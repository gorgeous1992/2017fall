*Set some system options using a global statement;
options formdlim = "~" nodate number pageno = 2;

*Assignment 1;
*Assign a user-defined library;
libname HW1 "D:\Documents\NCSU_materials\NCSU_2017Fall\ST555\ST555\hw1_lib";

*Assignment 2;
filename Bank "D:\Documents\NCSU_materials\NCSU_2017Fall\ST555\ST555\New folder\bankdata.txt";
filename Bank_t "D:\Documents\NCSU_materials\NCSU_2017Fall\ST555\ST555\New folder\bankdata_t.txt";

*Assignment 3;
data HW1.Bank1;
    infile Bank;
	input FNAME $ LNAME $ ACCTNUM $ BALANCE $ RATE;
	
run;

data HW1.Bank2;
  infile Bank;
  input NAME & $ ACCTNUM $ BALANCE $ RATE;

run;

