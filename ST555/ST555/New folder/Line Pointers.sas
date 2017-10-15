data fac01;
   infile "l:\Faculty_NoMiss.txt";
   input name & $50. ;
   input email : $50.;
   input office_number $ building & $50.;
   input phone : $12.;
run;

data fac02;
   infile "l:\Faculty_NoMiss.txt" ;
   input  name & $50. 
         #4 phone : $12.
         #3 office_number $ building & $50.
         #2 email : $50.;
run;

data fac03;
   infile "l:\Faculty_Miss01.txt" ;
   input  name & $50. 
         #4 phone : $12.
         #3 office_number $ building & $50.
         #2 email : $50.;
run;

data fac04;
   infile "l:\Faculty_Miss02.txt" missover;
   input  name & $50. 
         #4 phone : $12.
         #3 office_number $ building & $50.
         #2 email : $50.;
run;

data fac05;
   infile "l:\Faculty_NoMiss.txt";
   input    name & $50. 
         #3 office_number $ building & $50.
         #2 email : $50.
         #4 areacode $ 1-3 exchange $ 5-7 extension $ 9-12
         #2 email2 : $50.
         #4 phone : $50.;
run;

quit;