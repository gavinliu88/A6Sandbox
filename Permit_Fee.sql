/******************************************************************************
NAME: permit_fee (public)
PURPOSE: Calculates the permit fee

REVISIONS:

Ver        Date        Author           Description
---------  ----------  ---------------  ------------------------------------
???        ???         ???              ???
2.0        28/06/2013  Evan Sherwood    OSR0021979 - New sub type "Temporary Event Structure" (2030)
                                        and it's to be set up like the exisitng sub type "Tent" (2034)
                                        so some small code changes are required
2.1         Aug 30, 2103                INCIDENT INC0041251
                                        Water and Sewer fees were not being added correctly to
                                        B8 children of BP.  Had to do with the resetting of the v_foldertype
                                        variable.  when storing foldertype of parent, I now use v_parentfoldertype
3.0        14/04/2014  Evan Sherwood    OSR0023084 - New Building Bylaw Permit Fees Project
                                        - Moved sections of code into separate
                                          procedures and functions. This makes
                                          it possible to reuse existing code.
                                        - As a result of moving the code a couple
                                          minor changes were required to the code
                                          to make it work. I also re-structured
                                          the procedure to make it more effecient.
                                          As well, some formatting was done to
                                          make the code easier to read.
                                        - A few code changes were required as a
                                          result of changes to the business
                                          rules for permit fees.
3.1        26/08/2015  Ammar Al-Issa    OSR0024758 -  Change tent fee calculations
3.2        05/12/2016  Jeremy Wong      Added code for TPFP permit fee calculations

NOTES:
******************************************************************************/
Procedure Permit_Fee(parmFolderRSN number, parmUserID varchar2) as
    decl_con_value                      float(126) := 0;
    permit_fee                          float := 0;
    n_planreview_hours                  float;
    n_planreview_rate                   float;
    v_folder_in_date                    Folder.InDate%TYPE;
    v_charge_fee                        FolderProcessChecklist.Passed%TYPE;

    v_fee                               float;
    v_fee_rsn                           AccountBillFee.AccountBillFeeRSN%TYPE;
    v_amount_inserted                   AccountBillFee.FeeAmount%TYPE;
    v_fee_desc                          ValidAccountFee.FeeDesc%TYPE;
    v_bill_number                       AccountBill.BillNumber%TYPE;
begin
    --Version 3.0: Added In Date to select list
    select f.foldertype, f.subcode, f.workcode, f.folderrevision, f.InDate
    into v_foldertype, n_subcode, n_workcode, v_folderrevision, v_folder_in_date
    from amanda.folder f
    where folderrsn = parmFolderRSN;

    --Get declared construction value (added in Version 3.0)
    decl_con_value := toolkit.folderinfo_numeric(parmFolderRSN, 2045 /* Value of Construction - Declared */, 0);

    -----------------------------------------------------------------------------
    ----   If it is a revision folder and declared value of construction
    ----   is 0 then do not calculate any permit fee
    -----------------------------------------------------------------------------
    --Version 3.0: This condition was moved from being a separate statement below
    --to being part of this statement
    if v_folderrevision <> '00' and decl_con_value = 0 then
        /* Version 3.0: Even though permit fees aren't applicable, the value of
           construction should be re-calculated and the appropriate info fields
           should be updated in case there have been changes to the permit. */
        calc_and_update_construct_val(parmFolderRSN);

    /*--------------------------------------------------------
    -- if foldertype = 'BI'
       and subtype = 'Tent' (2034) or 'Temporary Event Structure' (2030)
       and work proposed = '*See Description' (999)
       then permit fee is # of Tents (infofield 2266)
       multiplied by a rate found in lookup table 2008
    ---------------------------------------------------------*/
    elsif v_foldertype = 'BI' and
        n_subcode in (2034, 2030) and
        n_workcode = 999
    then
        N_count := toolkit.FOLDERINFO_NUMERIC(parmFolderRSN, 2266, NULL);

-- 3.1        26/08/2015  Ammar Al-Issa    OSR0024758******************* Start
-- Will read the minimum Permit rate
--        n_rate := Amanda.pkc_surrey.get_rate_with_date( 2008,52,sysdate);  -- Commented in Version 3.1
          n_rate := Amanda.pkc_surrey.get_rate_with_date( 2002,0,sysdate);
-- 3.1        26/08/2015  Ammar Al-Issa    OSR0024758******************* End

        permit_fee := n_count * n_rate;

    /*--------------------------------------------------------
    -- if foldertype = 'BF'
       calculate sign permit fee
    ---------------------------------------------------------*/
    elsif v_foldertype = 'TPFP' then    /*version 3.2 code start*/
        v_fee := round(pkc_surrey.get_rate_with_date(2008, 55, d_indate), 2);

        IF v_fee > 0 THEN
            pkc_surrey.insert_fee(parmFolderRSN, 2075, v_fee, v_fee_rsn, v_amount_inserted);
          --  pkc_surrey.insert_fee(parmFolderRSN, parmFeeCode, v_fee, v_fee_rsn, v_amount_inserted);

            --If the fee was inserted, add fee parameters and bill it
            IF v_amount_inserted is not null THEN
                SELECT vaf.FeeDesc || ' Fee'
                INTO v_fee_desc
                FROM ValidAccountFee vaf
                WHERE vaf.FeeCode = 2075;

                pkc_surrey.insert_fee_parameter(v_fee_rsn, 0, v_fee, v_fee_desc);
                v_bill_number := pkc_surrey.bill_fee(v_fee_rsn);

                IF v_amount_inserted != v_fee THEN
                    pkc_surrey.insert_fee_parameter(v_fee_rsn, null, (v_fee - v_amount_inserted) * -1, 'LESS: Amount previously billed');
                END IF;
            END IF;
        END IF;

        pkc_surrey.insert_fee(parmFolderRSN, 2075, v_fee, v_fee_rsn, v_amount_inserted);

    elsif v_foldertype = 'BF' then
        Sign_Processing_fee(parmFolderRSN , parmuserid );
        Sign_Permit_fee(parmFolderRSN , parmuserid );

    else
        --Version 3.0: Moved code into separate procedures and functions

        --Calculate the value of construction and update the appropriate folder info fields
        calc_and_update_construct_val(parmFolderRSN);

        --Calculate the permit fee
        permit_fee := calculate_permit_fee(parmFolderRSN);
    end if;

    --Version 3.0: Commented out code because it's no longer applicable
    /*
    -------------------------------------------------------------------------------
    ---  if Work Proposed is Tenant Improvement or
    --- a BI folder, when Sub = 'Tent' (2034) or 'Temporary Event Structure' (2030) and Work Proposed = '*See Description':
    --- insert two new infofields
    --- 2267 Plan Review Code Compliance
    --- 2268 # of hours for Plan Review
    ------------------------------------------------------------------------------
    if ((n_workcode = 28) or
        (n_subcode in (2034, 2030) and n_workcode = 999 and v_foldertype = 'BI')) then
        n_planreview_hours := toolkit.folderinfo_numeric(parmFolderRSN, 2268, null);
        if nvl(n_planreview_hours,0) > 0 then
            n_planreview_rate := Amanda.pkc_surrey.get_rate_with_date( 2008,53,sysdate);
            permit_fee := permit_fee + (n_planreview_hours * n_planreview_rate);
        end if;
    end if;
    */

    if permit_fee > 0 then --insert permit fee
        --Version 3.0: Moved code into a separate procedure
        insert_permit_fee(parmFolderRSN, permit_fee);
    end if;

    /***** Start of Version 3.0 changes *****/

    /* If this is a revision folder check the value of the "Charge Plan Review Fee?"
       checklist item (2025) on the "Fee Calculation - Commercial" process (2014)
       to determine if the plan review fee is to be charged */

    BEGIN
        SELECT upper(fpc.Passed)
        INTO v_charge_fee
        FROM FolderProcess fp
        INNER JOIN FolderProcessChecklist fpc on fp.ProcessRSN = fpc.ProcessRSN
        AND fp.FolderRSN = parmFolderRSN
        AND fp.ProcessCode = 2014
        AND fpc.ChecklistCode = 2025;
    EXCEPTION
        WHEN NO_DATA_FOUND OR TOO_MANY_ROWS THEN
            v_charge_fee := null;
    END;

    IF v_FolderRevision != '00' AND v_charge_fee = 'Y' THEN
        insert_plan_review_fee(parmFolderRSN);
    END IF;

    /***** End of Version 2.0 changes *****/

end permit_fee;
