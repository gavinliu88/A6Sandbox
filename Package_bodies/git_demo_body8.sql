create or replace PACKAGE BODY        GIT_DEMO8 AS

  Function f1(rate Number)
  RETURN Number AS
  BEGIN
    --New comments
    --someone else code
    
    RETURN NULL;
  END f1;


  Function f2(rate Number)
  RETURN Number AS
  v_fee number;
  BEGIN
    --github line1
    --github line2
    select lookupfee into v_fee
    from validlookup
    where lookupcode=2007
    and lookup1 = 24
    and rownum = 1;


    RETURN v_fee;
  END f2;
  
  Function f3(folderrsn Number)
  RETURN Number AS
  v_rate number;
  BEGIN

    v_rate := 6;
    RETURN v_rate;
  END f3;  
END GIT_DEMO8;
