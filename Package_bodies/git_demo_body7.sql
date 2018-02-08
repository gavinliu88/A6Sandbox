create or replace PACKAGE BODY        GIT_DEMO7 AS

  Function f1(rate Number)
  RETURN Number AS
    v_statuscode folder.statuscode%TYPE;
  BEGIN

    SELECT STATUSCODE INTO v_statuscode
    FROM FOLDER
    WHERE FOLDERRSN = 5555;
    
    v_statuscode := v_statuscode +2;
    
    RETURN v_STATUSCODE;

  END f1;

  Function f2(rate Number)
  RETURN Number AS
  v_fee number;
  BEGIN

    select lookupfee into v_fee
    from validlookup
    where lookupcode=2007
    and lookup1 = 24
    and rownum = 1;

    RETURN v_fee;
  END f2;

END GIT_DEMO7;
