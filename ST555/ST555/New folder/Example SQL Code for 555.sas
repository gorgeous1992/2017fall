/*
Alternative to some of the code from HW #6

Some general SQL notes:
 - Lists of variables and data sets are comma delimited now!
 - The order in which the clauses are required for syntax
   is not the order in which they are executed. (For example
   in the first SELECT clause below we use the syntax a.* to
   select all variables from ST555.fish which has been given
   the label A. If you tried to move the FROM clause before 
   the SELECT clause you would get a syntax error!
*/
proc sql noprint;
   *CREATE is the keyword needed to put our SQL query 
    into something other than our listing window!
    TABLE is the keyword that tells SAS to put our 
    SQL query into a SAS data table
    AS is the keyword for instructing SAS *how* to 
    create the data table;
   create table easy as
   /*SELECT is the keyword that tells SAS what variables
      to bring into the data table we are creating
     A.* tells SAS to take all variables from the data set
     brought in with the label A - those labels are applied
     in the FROM statement below*/
   select a.*, mean_hg, median_hg, mean_z, median_z, 
          mean_rf, median_rf, mean_fr, median_fr
   /*FROM is a keyword that tells SAS where the source data 
     can be found.
     Since the summary statistics don't exist yet they can't 
     be found in any data set. However, we can nest a SELECT
     clause here to bring those summary statistics into 
     existence!*/
   from st555.fish as a, (select lt, dam, mean(hg) as mean_hg,
                                 median(hg) as median_hg,
                                 mean(z) as mean_z,
                                 median(z) as median_z,
                                 mean(fr) as mean_fr,
                                 median(fr) as median_fr,
                                 mean(rf) as mean_rf,
                                 median(rf) as median_rf
                           from st555.fish
                           /*GROUP BY to ensure our statistics are correct!*/
                           group by lt, dam
                           ) as b
   /*WHERE to select only certain records from our Cartesian product*/
   where a.lt eq b.lt and a.dam eq b.dam
   /*ORDER BY to sort the outgoing data set*/
   order by name
   ;
quit;

quit;