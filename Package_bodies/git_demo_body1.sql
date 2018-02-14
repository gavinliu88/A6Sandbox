create or replace PACKAGE BODY GIT_DEMO AS

  Function f1(rate Number,parmfolderrsn int)
  RETURN Number AS
  v_fee number;
  v_feeComment varchar2(2000);
  v_statuscode number;
  BEGIN

    select lookupfee into v_fee
    from validlookup
    where lookupcode=2007
    and lookup1 = 24
    and rownum = 1;

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
