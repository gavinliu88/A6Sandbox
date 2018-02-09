create or replace PACKAGE BODY        GIT_DEMO9 AS

  Function f1(rate Number)
  RETURN Number AS
  v_fee number;
  BEGIN

    select lookupfee into v_fee
    from validlookup
    where lookupcode=2008
    and lookup1 = 57
    and rownum = 1;

    RETURN v_fee;
  END f1;

  Function f2(p_folderrsn Number)
  RETURN Number AS
    v_statuscode number;
  BEGIN
    SELECT STATUSCODE INTO v_statuscode
    FROM FOLDER
    WHERE FOLDERRSN = 123;  
      v_rate := 14;
      
    RETURN v_rate;
  END f2;   

END GIT_DEMO9;
