create or replace PACKAGE BODY        GIT_DEMO3 AS
--V1.1 add comment
  Function f1(rate Number)
  RETURN Number AS
  v_fee number;
  BEGIN
    -- add very long logic section
    -- long
    -- long
    -- logic section
    select lookupfee
    from vlookup
    where lookupcode=2007
    and lookup1 = 24;
    
    
    RETURN v_fee;
  END f1;

  Function f2(rate float)
  --V1.1 new logic
  --V1.2 new features
  --V1.3 new logic
  RETURN number AS
  v_statuscode number;
  v_statusdesc varchar2(100);
  
  BEGIN
    -- Do something
    SELECT processrsn into v_statuscode
    from folderprocess
    where folderrsn = 11;
  
      SELECT statuscode,statusdesc into v_statuscode,v_statusdesc
    from process p
    inner join validprocess vp
    on p.processcode = vp.processcode
    where processrsn = 1;
    
    select statusdesc 
    from validprocess
    where processcode =1000;
    
    RETURN v_statuscode;
  END f2;
END GIT_DEMO3;
