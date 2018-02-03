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
  RETURN float AS
  BEGIN
    -- TODO: Initial checkin
    RETURN NULL;
  END f2;
END GIT_DEMO3;
