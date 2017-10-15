/*
Author: Jonathan W. Duggins
Date Created: 2016-08-04
Purpose: Demonstrate usage of PROC TRANSPOSE
         and how to use arrays to carry out
         transpositions not easily done in 
         PROC TRANSPOSE

Modification Date: N/A
Reason for Modification: N/A
*/

*Basic transposition of wide data;
proc transpose data = st555.wide 
               out = wide_trans;
   var x1 - x4;
run;

/*
Add options:
   - OUT names the resulting data set
   - NAME provides a variable name for the column 
     containing original variable names
   - PREFIX proves a common prefix for the naming 
     of all new variables
*/
proc transpose data = st555.wide 
               out = wide_trans(drop = _label_)
               name = Old_Vars
               prefix = AVAL;
   var x1 - x4;
run;

*WIDE_SUBJ has data that needs to be transposed 
 within each subject - BY statement handles that;
proc transpose data = st555.wide_subj 
               out = wide_trans;
   by subjid;
   var x1 - x4;
run;

*More complicated data set that needs BY and ID;
proc transpose data = st555.bloodwork
               out = blood_t(drop = _name_);
   by subjid avisit;
   id param;
   var aval;
run;


************************************************;

*Using arrays to carry out a block transposition;
data wide_array_t(keep = subjid aval: visitn);
   set st555.wide_subj;
   by subjid;

   array orig[*] x1 x3 x2 x4;
   array aval[2];
   label aval1 = 'Test Result'
         aval2 = 'Test Code'
         visitn = 'Visit Number';
   
   do i = 1 to dim(orig);
      if mod(i,2) eq 1 then call missing(of aval1 - aval2);
      aval[2 - mod(i,2)] = orig[i];
      if mod(i,2) eq 0 then do;
               visitn = i/2;
               output;
            end;
   end;
run;

quit;