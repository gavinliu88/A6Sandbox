create or replace PACKAGE BODY        GIT_DEMO8 AS

  Function f1(rate Number)
  RETURN Number AS
    v_statuscode folder.statuscode%TYPE;
  BEGIN
  --Gavin add comments
  --Gavin add comments
    SELECT STATUSCODE INTO v_statuscode
    FROM FOLDER
    WHERE FOLDERRSN = 123;
    
    RETURN v_STATUSCODE;

  END f1;


  Function f2(rate Number)
  RETURN Number AS
  v_fee number;
  BEGIN
  --Gavin add comments
  --Gavin add comments
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
