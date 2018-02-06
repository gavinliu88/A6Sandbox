create or replace PACKAGE BODY                      GIT_DEMO4 AS

  Function f1(rate Number)
  RETURN Number AS
  BEGIN
    -- TODO: Initial checkin
    RETURN NULL;
  END f1;

  Function f2(rate Number)
  RETURN Number AS
  v_fee number;
  BEGIN
    -- add very long logic section
    -- long
    -- long
    -- logic section
    select lookupfee into v_fee
    from validlookup
    where lookupcode=2007
    and lookup1 = 24
    and rownum = 1;

    -- add 2 lines
    --
    RETURN v_fee;
  END f2;
END GIT_DEMO4;