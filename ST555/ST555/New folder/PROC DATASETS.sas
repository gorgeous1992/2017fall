/*
Author: Jonathan W. Duggins
Date Created: 2016-08-04
Purpose: Demonstrate usage of various statements in 
         PROC DATASETS

Modification Date: N/A
Reason for Modification: N/A
*/

proc datasets library = st555 nolist;
   contents data = Air_employees_data;
   run;
   modify air_employees_data;
   label city = "City in which employee is based"
         Country = "Country in which employee is based"
         Division = "Division in which employee works"
         EmpID = "Identification Code"
         FirstName = "First Name"
         LastName = "Last Name"
         HireDate = "Date of hire"
         JobCode = "Internal code for job title"
         Phone = "Phone Number (extension only)"
         Salary = "current salary"
         ;
   run;
   contents data = air_employees_data;
   run;
   modify air_employees_data;
   attrib _all_ label  = " ";
   run;
quit;

quit;
