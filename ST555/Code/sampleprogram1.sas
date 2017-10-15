*Set some system options using a global statement;
options formdlim = "~" nodate number pageno = 2;

*Assign a user-defined library;
libname st555 "D:\Documents\NCSU_materials\NCSU_2017Fall\ST555\ST555\New folder";

*Steps are composed of several statements;
data work.city_temps;
  input city $ Sun Mon Tue Wed Thr Fri Sat;
  cards;

atlanta   81 87 83 79 88 91 94
baltimore 73 75 70 78 73 75 79
charlotte 82 80 75 82 83 88 93
denver    72 71 67 68 72 71 58
ellington 51 42 47 52 55 56 59
frankfort 70 70 72 70 74 74 79
   ;

run;

filename temps "D:\Documents\NCSU_materials\NCSU_2017Fall\ST555\ST555\city_temps.txt";

data work.city_temps_1;
   infile temps firstobs = 2;
   input city $ sun mon tue wed thr fri sat;
   temp_avg = sum(of sun -- sat)/7;
run;

proc print data = city_temps;
run;

quit;





