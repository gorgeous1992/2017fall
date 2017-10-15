
data logic01;
   x = 1;
   if x eq 0 or x eq 2 then type = 'Even';
      else type = 'Unknown';
run;

data logic02;
   x = 1;
   if x eq 0 or 2 then type = 'Even';
      else type = 'Unknown';
run;

quit;