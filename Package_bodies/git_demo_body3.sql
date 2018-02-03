create or replace PACKAGE BODY        GIT_DEMO3 AS
--V1.1 add comment
  Function f1(rate float)
  RETURN float AS
  BEGIN
    -- add very long logic section
    -- long
    -- long
    -- logic section
    
    RETURN 6;
  END f1;

  Function f2(rate float)
  --V1.1 new logic
  --V1.2 new features
  RETURN number AS
  BEGIN
    -- Do something
    SELECT processrsn into v_statuscode
    from folderprocess
    where folderrsn = 11;
    
    RETURN v_statuscode;
  END f2;
END GIT_DEMO3;
