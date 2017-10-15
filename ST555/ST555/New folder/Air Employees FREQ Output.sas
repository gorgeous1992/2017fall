/*
Author: Jonathan W. Duggins
Date Created: 2016-08-04
Purpose: Produce frequency reports for Airline Employees

Modification Date: N/A
Reason for Modification: N/A
*/

proc freq data = st555.air_employees_data;
   tables country;
   table country*jobcode division*jobcode / norow nocol;
   ods output OneWayFreqs = Freqz01
              Table2.CrossTabFreqs = Freqz02
              Table3.CrossTabFreqs = Freqz03;
run;

proc freq data = st555.air_employees_data;
   tables country*division*jobcode;
   ods output CrossTabFreqs = Freqz04;
run;


ods rtf file = "L:\Frequencies.rtf";

title 'One-Way Frequencies of Country';
footnote 'Analysis 1 of 4';
proc print data = freqz01;
run;

title 'Two-Way Frequencies of Country by Job Code';
title2 'Row and Column Statistics Suppressed';
footnote 'Analysis 2 of 4';
proc print data = freqz02;
run;

title 'One-Way Frequencies of Division by Job Code';
title2 'Row and Column Statistics Suppressed';
footnote 'Analysis 3 of 4';
proc print data = freqz03;
run;

ods pdf file = "L:\Overall.pdf";

title 'Three-Way Frequencies of Country by Division by Job Code';
footnote 'Analysis 4 of 4';
footnote2 'Remaining analyses located in Frequencies.rtf';
proc print data = freqz04;
run;

ods _all_ close;

title;
footnote;
quit;
