/*
Author: Jonathan W. Duggins
Date Created: 2016-08-04
Purpose: Demonstrate usage of various statements in 
         PROC DATASETS

Modification Date: N/A
Reason for Modification: N/A
*/

data st555.wide;
   label subjid = 'Subject ID'
         x1 = 'Test 1'
         x2 = 'Test 2'
         x3 = 'Code 1'
         x4 = 'Code 2';
   x1 = 1;
   x2 = 3;
   x3 = 4;
   x4 = 8;
run;

data st555.wide_subj;
   label subjid = 'Subject ID'
         x1 = 'Test 1'
         x2 = 'Test 2'
         x3 = 'Code 1'
         x4 = 'Code 2';
   input subjid $ x1 - x4;
   cards;
   S-001 1 3 4 8
   S-002 2 6 7 9
   ;
run;

data st555.narrow;
   do x = 1,3,4,8;
      output;
   end;
run;

data st555.bloodwork;
   label param = 'Vital Sign Parameter';
   input subjid $ avisit $ param $ paramn aval;
   cards;
   S-001 Base Calcium 1 9.2
   S-001 Base WBC     2 4.5
   S-001 Base pH      3 7.39
   S-001 EOS Calcium  1 9.2
   S-001 EOS WBC      2 5.2
   S-001 EOS pH       3 7.40
   S-002 Base Calcium 1 10.0
   S-002 Base WBC     2 8.0
   S-002 Base pH      3 7.42
   S-002 EOS Calcium  1 9.8
   S-002 EOS WBC      2 8.2
   S-002 EOS pH       3 7.43
   ;
run;

quit;