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
  --V1.2 new logic
  RETURN number AS
  v_statuscode number;
  BEGIN
    -- Do something
    SELECT statuscode into v_statuscode
    from process
    where processrsn = 1;
    
    RETURN v_statuscode;
  END f2;
END GIT_DEMO3;
