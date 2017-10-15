/*
Author: Jonathan W. Duggins
Date Created: 2016-08-04
Purpose: Customized CARS report.

Modification Date: 2016-09-16
Reason for Modification: Add sort
*/

*Basic PRINT report;
proc print data = st555.cars;
run;

*Control select system options;
options formdlim = '~' pagesize = 50 nodate nonumber linesize = 120;

*Sort data by type, then within 
 type by MSRP (decreasing);
proc sort data = st555.cars
          out = cars_sorted;
   by type descending msrp;
run;

*Produce improved report;
proc print data = cars_sorted label;
   format msrp invoice dollar12. weight comma5.;
   label mpg_highway = 'Higheway Mileage'
         mpg_city    = "City Mileage"
         msrp        = "Manufacturer's Suggested Retail Price"
         invoice     = "Actual Sale Price"
         ;
   id make model;
   by type;
      pageby type;
   sum msrp;
run;

quit;
