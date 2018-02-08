create or replace PACKAGE BODY        GIT_DEMO5 AS

  Function f1(rate Number)
  RETURN Number AS
    v_statuscode folder.statuscode%TYPE;
  BEGIN
   
   --feature from uat
    SELECT STATUSCODE INTO v_statuscode
    FROM FOLDER
    WHERE FOLDERRSN = 5555;
    
    RETURN v_Statuscode;
    
  END f1;
  
    Function f2(rate Number)
  RETURN Number AS
    v_statuscode folder.statuscode%TYPE;
  BEGIN
   ---dev
    --f2
    NULL;
  END f2;
END GIT_DEMO5;
