/*
Author: Jonathan W. Duggins
Date Created: 2016-08-04
Purpose: Demonstrate equivalence of DO UNTIL
         and DO WHILE loops

Modification Date: N/A
Reason for Modification: N/A
*/

data st555.investing1;
   do until (invest ge 50000);
      total_months + 1;
      invest + 1000;
      invest + invest * 0.01;   
      years = floor(total_months/12);
      months = mod(total_months,12);
      output;
   end;
   format invest dollar20.2;
run;

data st555.investing2;
   do while (invest lt 50000);
      total_months + 1;
      invest + 1000;
      invest + invest * 0.01;   
      years = floor(total_months/12);
      months = mod(total_months,12);
      output;
   end;
   format invest dollar20.2;
run;

proc compare base = st555.investing1
             compare = st555.investing2
             out = diff outbase outcomp outnoequal
             method = absolute criterion = 0.000001;
run;

quit;