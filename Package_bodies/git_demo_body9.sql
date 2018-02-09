create or replace PACKAGE BODY        GIT_DEMO9 AS

  Function f1(rate Number)
  RETURN Number AS
  v_fee number;
  BEGIN

  v_fee := pkc_surrey.get_rate_with_date(2007, 24, sysdate);
  v_feeComment := 'Minor Plumbing Field Design/Construction Revisions';
    
    RETURN v_fee;
  END f1;
END GIT_DEMO9;
