/*
Author: Jonathan W. Duggins
Date Created: 2016-08-04
Purpose: Read in lake water chemistry data.

Modification Date: N/A
Reason for Modification: N/A
*/

/*
Initially we're asked to read in the data and
use the viewtable window to try to confirm the
data was read in correctly
*/
data H2Ochem;
   infile "l:\water_chemistry.txt";
   input hg n elv sa z lt st da rf fr dam lat1 - lat3 long1 - long3;
run;

/*
Next we're asked to use PROC MEANS to begin some
basic self-validation. What stands out to you?
*/
proc means data = H2Ochem n mean min max;
   var lt dam;
run;

/*
To further look into our data we added the CLASS option.
The MAXDEC= option is used simply to clean up the output some
*/
proc means data = H2Ochem n mean min max maxdec = 1;
   class lt;
   var dam;
run;

/*
To see the delimiters easier, we've switched to a CSV
which uses commas as delimiters. Below we can see how
DSD and DLM= should be used.
*/
data H2Ochem;
   infile "l:\water_chemistry.csv" dsd dlm = ',';
   input hg n elv sa z lt st da rf fr dam 
         lat1 - lat3 long1 - long3;
run;

/*
Finally, add the MISSOVER option to fix the handling
of missing values at the end of a line when using list
input (SLI or MLI).
*/

data H2Ochem;
   infile "l:\water_chemistry.csv" dsd dlm = ',' missover;
   input hg n elv sa z lt st da rf fr dam 
         lat1 - lat3 long1 - long3;
run;



quit;
