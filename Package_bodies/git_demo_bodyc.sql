create or replace PACKAGE BODY        GIT_DEMO AS

  Function f1(rate Number,parmfolderrsn int)
  RETURN Number AS
  v_fee number;
  v_feeComment varchar2(2000);
  v_statuscode number;
  BEGIN

  v_fee := pkc_surrey.get_rate_with_date(2008, 56, sysdate);
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
  
PROCEDURE f2(argFolderRSN IN folder.folderrsn%TYPE)
IS
    n_old_folderrsn     folder.folderrsn%TYPE;
    n_count             PLS_INTEGER;
BEGIN
    pkc_surrey.revise_permit (argFolderRSN, n_old_folderrsn);


END f2;  

END GIT_DEMO;
