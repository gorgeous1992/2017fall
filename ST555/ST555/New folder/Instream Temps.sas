/*
Author: Jonathan W. Duggins
Date Created: 2016-08-04
Purpose: Demonstrate reading instream data

Modification Date: N/A
Reason for Modification: N/A
*/

data work.city_temps;
   input city $ sun mon tue wed thr fri sat;
   cards;
   atlanta   81 87 83 79 88 91 94
   baltimore 73 75 70 78 73 75 79
   charlotte 82 80 75 82 83 88 93
   denver    72 71 67 68 72 71 58
   ellington 51 42 47 52 55 56 59
   frankfort 70 70 72 70 74 74 79
   ;
run;

quit;