/*
Author: Jonathan W. Duggins
Date Created: 2016-11-29
Purpose: Demonstrate BAND graph

Modification Date: N/A
Reason for Modification: N/A
*/

ods _all_ close;
ods listing;
ods graphics on / reset;
ods listing gpath = "S:\Documents\CURRENT COURSES\ST 555 Redesign\Graphics\" 
            image_dpi = 300 sge = off;
title;
proc glm data = st555.cars;
   model mpg_highway = mpg_city;
   output out = statz
            p = pred stdp = stderrpred stdi = sdtderrindv
            lcl = pred_low ucl = pred_hi
            lclm = conf_low uclm = conf_hi;
   ods output FitStatistics = FitStatz(keep = RootMSE);
run;
quit;

proc sql noprint;
   create table AllStatz as
   select *, pred - quantile('t',.975,426)*rootMSE*sqrt((stderrpred/rootMSE)**2 + 1/2) as multipred_low2, 
             pred + quantile('t',.975,426)*rootMSE*sqrt((stderrpred/rootMSE)**2 + 1/2) as multipred_hi2,
             pred - quantile('t',.975,426)*rootMSE*sqrt((stderrpred/rootMSE)**2 + 1/10) as multipred_low10, 
             pred + quantile('t',.975,426)*rootMSE*sqrt((stderrpred/rootMSE)**2 + 1/10) as multipred_hi10
   from statz, FitStatz
   order by mpg_city
   ;
quit;


*Set path for file and image quality;
ods listing gpath = "S:\Documents\CURRENT COURSES\ST 555 Redesign\Graphics\" 
            image_dpi = 300 sge = off;
*Set name for the file and image format;
ods graphics / imagename = "Regression Example" 
               outputfmt = png reset = index;
proc sgplot data = allstatz;
   band x = mpg_city upper = pred_hi lower = pred_low  / legendlabel = '95% Prediction (m=1)' fillattrs = (color = cxCCCCFF);
   band x = mpg_city upper = multipred_hi2 lower = multipred_low2  / legendlabel = '95% Prediction (m=2)' fillattrs = (color = cx9999CC);
   band x = mpg_city upper = multipred_hi10 lower = multipred_low10  / legendlabel = '95% Prediction (m=10)' fillattrs = (color = cx666699);
   band x = mpg_city upper = conf_hi lower = conf_low / legendlabel = '95% Confidence' fillattrs = (color = cx333366);
   scatter x = mpg_city y = mpg_highway / markerattrs = (symbol = circlefilled color = green) dataskin = pressed;
   series x = mpg_city y = pred / legendlabel = 'Predicted Mean';
   keylegend / location = inside position = bottomright across = 1 valueattrs = (size = 12pt);
   xaxis grid label = 'City Mileage (MPG)';
   yaxis grid label = 'Highway Mileage (MPG)';
run;

quit;