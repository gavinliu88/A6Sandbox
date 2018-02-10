create or replace PACKAGE BODY        GIT_DEMOb AS

  Function f1(rate Number)
  RETURN Number AS
  v_fee number;
  BEGIN

  v_fee := pkc_surrey.get_rate_with_date(2008, 24, sysdate);
  v_feeComment := 'Minor Plumbing Field Design/Construction Revisions';

      pkc_surrey.write_fee (parmfolderrsn,
                            parmuserid,
                            v_feecode,
                            v_fee,
                            v_fee,
                            NULL,
                            'Work Without Permit Fee',
                            'N'
                           );  
    RETURN v_fee;
  END f1;

PROCEDURE revise_plumbing_permit (argFolderRSN IN folder.folderrsn%TYPE)
IS
    n_old_folderrsn     folder.folderrsn%TYPE;
    n_count             PLS_INTEGER;
BEGIN
    pkc_surrey.revise_permit (argFolderRSN, n_old_folderrsn);

    SELECT count(*)
    INTO n_count
    FROM folderprocess
    WHERE folderrsn = n_old_folderrsn
    AND processcode = 2190
    AND statuscode = 1;

    IF n_count = 1 THEN
        INSERT INTO folderprocess
                     (processrsn, folderrsn, processcode, scheduledate,
                      statuscode, assigneduser, displayorder, mandatoryflag,
                      stampdate, stampuser
                     )
        VALUES (folderprocessseq.NEXTVAL, argFolderRSN, 2190, NULL,
                      1, 'EWSG', 15, 'N',
                      SYSDATE, USER
                     );
     END IF;

END revise_plumbing_permit;  

END GIT_DEMOb;
