/*
Author: Jonathan W. Duggins
Date Created: 2016-08-04
Purpose: Solution to ICE related to heart function data in the List Input with Missing Data Module

Modification Date: N/A
Reason for Modification: N/A
*/

/*
Approach 1: Fewest statements
- No FILENAME statement
- Use DLM to set up delimiters as underscores and forward slashes
- Use DSD to handle the twelfth record that doesn't have SBP or DBP
- Use MISSOVER to handle the ninth record that doesn't have a visit date
- Use FIRSTOBS to skip over the variable names in the raw file
- Use informat for ID to set length automatically
- Use informat for DATE to read in as numeric
- Use FORMAT statement to apply format to DATE
- Use LABEL statement to apply labels;
*/

data heart_ICE; *ICE stands for In-Class Activity;
   infile "L:\heart function.txt" dlm = '_/' dsd missover firstobs = 2;
   input id : $4. sbp dbp hr date : mmddyy10.;
   format date ddmmyy10.;
   label id   = 'Patient ID'
         sbp  = 'Systolic Blood Pressure'
         dbp  = 'Diastolic Blood Pressure'
         hr   = 'Heart Rate'
         date = 'Visit Date'
         ;
run;

/* Approach 2: Get that bonus!
- Use a FILENAME statement to get Bonus #2
- Use PROC DATASETS to get both parts of Bonus #1
- Use LENGTH statement to get Super Extra Bonus
*/

filename heart 'L:\heart function.txt';

data heart2_ICE;
   infile heart dlm = '_/' dsd missover firstobs = 2;
   length id $ 4;
   input id sbp dbp hr date : mmddyy10.;
run;

proc datasets library = work nolist;
   modify heart2_ice;
      format date date9.;
      label id   = 'Patient ID'
            sbp  = 'Systolic Blood Pressure'
            dbp  = 'Diastolic Blood Pressure'
            hr   = 'Heart Rate'
            date = 'Visit Date'
         ;
   run;
quit;

quit;