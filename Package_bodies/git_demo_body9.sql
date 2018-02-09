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

  Function f2(p_folderrsn Number)
  RETURN Number AS
    v_statuscode number;
  BEGIN

      v_rate := 6;
    RETURN v_rate;
  END f2;   

END GIT_DEMO9;
