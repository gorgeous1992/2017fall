

data case1_even;
   infile "l:\AirportCodes_Even.txt";
   input airport_codes $ num_emp @@;
run;

data case1_uneven;
   infile "l:\AirportCodes_Uneven.txt";
   input airport_codes $ num_emp @@;
run;

data case1_miss;
   infile "l:\AirportCodes_Miss.txt" dsd dlm=',';
   input airport_codes $ num_emp @@;
run;

data case2_even;
   infile "l:\AirEmps_Even.txt";
   input airport_code $ @;
   input emp_id $ @;
   output;
   input emp_id $ @;
   output;
   input emp_id $ @;
   output;
   input emp_id $ @;
   output;
   input emp_id $ @;
   output;
run;

data case2_even_short(drop = i);
   infile "l:\AirEmps_Even.txt";
   input airport_code $ @;
   do i = 1 to 5;
      input emp_id $ @;
      output;
   end;
run;

data case2_uneven_naive(drop = i);
   infile "l:\AirEmps_Uneven.txt";
   input airport_code $ @;
   do i = 1 to 4;
      input emp_id $ @;
      output;
   end;
run;

data case2_uneven;
   infile "l:\AirEmps_Uneven.txt" missover;
   input airport_code $ emp_id $ @;
   do while (emp_id not eq '');
      output;
      input emp_id $ @;
   end;
run;

quit;