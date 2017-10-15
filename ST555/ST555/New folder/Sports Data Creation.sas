data st555.sports1(where = (sport ne 'Football') drop = fname)
     st555.sports2(where = (sport not in ('Basketball', 'Baseball')) drop = lname);
   infile cards dlm = ',' dsd;
   input jersey (fname lname sport) (3*:$20.);
   cards;
   23,Michael,Jordan,Basketball
   99,Wayne,,Hockey
   7,John,Elway,A. Football
   7,Micky,Mantle,Baseball
   10,Edson,Nascimento,Football
   .,Steffen,Peters,Dressage
   .,Laurie,Hernandez,Gymnastics
   ;
run;

data oneTOone;
   set st555.sports1;
   set st555.sports2;
run;

proc sort data = st555.sports1 out = sports1;
   by jersey;
run;

proc sort data = st555.sports2 out = sports2;
   by jersey;
run;

data interleave;
   set sports1 sports2;
   by jersey;
run;

data match;
   merge sports1 sports2;
   by jersey;
run;

data concat;
   set sports1 sports2;
run;

data dropkeep01;
   merge sports1(drop = lname) sports2(drop = fname);
   by jersey;
run;

data dropkeep02 (drop = lname fname);
   merge sports1 sports2;
   by jersey;
run;

data rename01;
   merge sports1(rename = (sport = old_sport)) 
         sports2(rename = (sport = new_sport));
   by jersey;
run;

data all nomatch match(drop = old_sport 
                       rename = (new_sport = sport));
   merge sports1(rename = (sport = old_sport)) 
         sports2(rename = (sport = new_sport));
   by jersey;


   if old_sport eq new_sport then output match;
      else output nomatch;
run;

data all nomatch match(drop = old_sport 
                       rename = (new_sport = sport));
   merge sports1(rename = (sport = old_sport)) 
         sports2(rename = (sport = new_sport));
   by jersey;

   output all;
   if old_sport eq new_sport then output match;
      else output nomatch;
run;

data all nomatch match(rename = (new_sport = sport));
   merge sports1(rename = (sport = old_sport)) 
         sports2(rename = (sport = new_sport));
   by jersey;

   output all;
   if old_sport eq new_sport then output match;
      else output nomatch;

   drop old_sport;
run;

quit;