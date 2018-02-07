create or replace PACKAGE BODY        GIT_DEMO5 AS

  Function f1(rate Number)
  RETURN Number AS
    v_statuscode folder.statuscode%TYPE;
  BEGIN
   ---dev
    SELECT STATUSCODE INTO v_statuscode
    FROM FOLDER
    WHERE FOLDERRSN = 123;
    RETURN v_Statuscode;
  END f1;
END GIT_DEMO5;