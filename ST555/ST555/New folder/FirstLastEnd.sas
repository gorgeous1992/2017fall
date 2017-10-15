
data st555.firstlast;
   input (A B C) (3*:$2.);
   cards;
   A1 B1 C1
   A1 B1 C2
   A1 B2 C3
   A1 B3 C4
   A2 B2 C4
   A2 B3 C4
   A2 B3 C4
   A3 B1 C4
   ;
run;

proc sort data = st555.firstlast;
          out = firstlast;
   by a b c;
run;

data firstlast_chk;
   set firstlast end = LastObs;
   by a b c;
run;

quit;