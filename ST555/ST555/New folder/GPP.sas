/*
Author: Jonathan W. Duggins
Date Created: 2016-08-04
Purpose: Demonstrate a program that follows GPP

Modification Date: N/A
Reason for Modification: N/A
*/

*Set some system options using a global statement;
options formdlim = "~" nodate number pageno = 2;

*Assign a user-defined library;
libname st555 "L:\";

/*Steps are composed of several statements*/
data work.EmployeeData;
   set st555.airemps;
   drop phone;
run;

proc print data = work.EmployeeData;
run;

proc means data = work.EmployeeData;
   class jobcode;
   var salary;
run;

quit;
