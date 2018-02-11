create or replace PACKAGE BODY        GIT_DEMO9 AS

  Function f1(rate Number)
  RETURN Number AS
  v_fee number;
  BEGIN

    select lookupfee into v_fee
    from validlookup
    where lookupcode=2007
    and lookup1 = 24
    and rownum = 1;

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
END GIT_DEMO9;
