*Sort data for merge;
proc sort data=st555.exam_fr out=st555.exam_fr_s;
   by idnum;
run;

proc sort data=st555.exam_sp out=st555.exam_sp_s;
   by idnum;
run;

proc sort data=st555.exam_cs out=st555.exam_cs_s;
   by idnum;
run;

*merge by IDNUM;
data PassScores1;
   merge st555.exam_fr_s
        st555.exam_cs_s 
        st555.exam_sp_s
   ;
   by idnum;
run;

**********************************************************************************************;

*Only keep observations with information from all input data sets;
data PassScores2;
   merge st555.exam_fr_s (in= in_fr)
        st555.exam_cs_s (in= in_cs)
        st555.exam_sp_s (in= in_sp)
   ;
   by idnum;
   if in_fr eq 1 and in_cs eq 1 and in_sp eq 1;
run;

**********************************************************************************************;

*Only keep flight attendants who pass all exams;
data PassScores3a;
   merge st555.exam_fr_s
        st555.exam_cs_s
        st555.exam_sp_s
   ;
   by idnum;
   if fr_score gt 6 and cs_score gt 6 and sp_score gt 6;
run;

*Same approach but using single WHERE statement;
data PassScores3b;
   merge st555.exam_fr_s
        st555.exam_cs_s
        st555.exam_sp_s
   ;
   by idnum;
   where fr_score gt 6 and cs_score gt 6 and sp_score gt 6;
   /*This approach does not work because WHERE compares your constraints to the INCOMING
     PDVs of all three data sets. Compare this to the subsetting IF that comapres your
     constraints to the PDV of PassScores3 data set*/
run;

*Correct use of WHERE data set options, but different resulting data set;
data PassScores3c;
   merge st555.exam_fr_s(where = (fr_score gt 6))
        st555.exam_cs_s(where = (cs_score gt 6))
        st555.exam_sp_s(where = (sp_score gt 6));
   ;
   by idnum;
run;

*Using data set WHERE options and subsetting IF with the data set IN options;
data PassScores3d;
   merge st555.exam_fr_s(in = in_fr where = (fr_score gt 6))
        st555.exam_cs_s(in = in_cs where = (cs_score gt 6))
        st555.exam_sp_s(in = in_sp where = (sp_score gt 6));
   ;
   by idnum;
   if in_fr eq 1 and in_cs eq 1 and in_sp eq 1;
run;

**********************************************************************************************;

*Add scores to the sort, in descending order;
proc sort data=st555.exam_fr out=st555.exam_fr_s;
   by idnum descending fr_score;
run;

proc sort data=st555.exam_sp out=st555.exam_sp_s;
   by idnum descending sp_score;
run;

proc sort data=st555.exam_cs out=st555.exam_cs_s;
  by idnum descending cs_score;
run;

*Use NODUPKEY option to get rid of duplicates at the IDNUM level;
proc sort data=st555.exam_fr_s
          out=st555.exam_fr_nodup
          nodupkey;      
   by idnum;
run;

proc sort data=st555.exam_sp_s
          out=st555.exam_sp_nodup
          nodupkey;
   by idnum;
run;

proc sort data=st555.exam_cs_s
          out=st555.exam_cs_nodup
          nodupkey;
   by idnum;
run;

*Merge the resulting data, only keeping certified flight attendants;

*Option 1: Subsetting IF;
data PassScores4a;
   merge st555.exam_fr_nodup
        st555.exam_cs_nodup
        st555.exam_sp_nodup
   ;
   by idnum;
   if fr_score gt 6 and cs_score gt 6 and sp_score gt 6;
   /*This approach reads ALL the data from the NODUP data sets,
     combines it by IDNUM in the PDV, then checks if the flight
     attendant is certified.*/
run;

*Option 2: WHERE and IN options;
data PassScores4b;
   merge st555.exam_fr_nodup(in = in_fr where = (fr_score gt 6))
        st555.exam_cs_nodup(in = in_cs where = (cs_score gt 6))
        st555.exam_sp_nodup(in = in_sp where = (sp_score gt 6));
   ;
   by idnum;
   if in_fr eq 1 and in_cs eq 1 and in_sp eq 1;
   /*This approach only reads scores from NODUP data sets if they are
     passing scores. The PDV will be built for all records remaining,
     but will only be written to the PassScores data set if the 
     flight attendant is certified. This approach is more computationally
     efficient for large input data sets.*/
run;

quit;