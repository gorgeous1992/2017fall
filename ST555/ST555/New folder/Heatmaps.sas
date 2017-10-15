*create MPG format;
proc format;
   value mpg (fuzz = 0) low - 18   = 'Inefficient'
                        18 <- 28   = 'Moderate'
                        28 <- 43 = 'Efficient'
                        43 <- high = '10/10 Stars!'
   ;
run;

*Grab frequency data;
proc freq data = st555.cars;
   format mpg_city mpg_highway mpg.;
   tables mpg_city*mpg_highway / norow nocol nopct;
   ods output crosstabfreqs = work01(where = (_type_ eq '11')
                                     drop = table _table_ missing);
run;

ods graphics / width=400px;
title;
*Make the basic HEATMAP;
proc sgplot data = work01;
   heatmap x = mpg_city y = mpg_highway;
   xaxis valueattrs = (size = 12pt) label = 'City Mileage' labelattrs = (size = 14pt) fitpolicy = rotate;
   yaxis valueattrs = (size = 12pt) label = 'Highway Mileage' labelattrs = (size = 14pt);
run;

*Add discrete axes;
proc sgplot data = work01;
   heatmap x = mpg_city y = mpg_highway / discretex discretey;
   xaxis valueattrs = (size = 12pt) label = 'City Mileage' 
         labelattrs = (size = 14pt) fitpolicy = rotate;
   yaxis valueattrs = (size = 12pt) label = 'Highway Mileage' 
         labelattrs = (size = 14pt);
run;

*Add outline;
proc sgplot data = work01;
   heatmap x = mpg_city y = mpg_highway / discretex discretey 
                                          outline;
   xaxis valueattrs = (size = 12pt) label = 'City Mileage' 
         labelattrs = (size = 14pt) fitpolicy = rotate;
   yaxis valueattrs = (size = 12pt) label = 'Highway Mileage' 
         labelattrs = (size = 14pt);
run;

*Add FREQ= option;
proc sgplot data = work01;
   heatmap x = mpg_city y = mpg_highway / discretex discretey
                                          outline
                                          freq = frequency;
   xaxis valueattrs = (size = 12pt) label = 'City Mileage' 
         labelattrs = (size = 14pt) fitpolicy = rotate;
   yaxis valueattrs = (size = 12pt) label = 'Highway Mileage' 
         labelattrs = (size = 14pt);
run;

*Add COLORMODEL;
proc sgplot data = work01;
   heatmap x = mpg_city y = mpg_highway / freq = frequency 
                                          discretex discretey 
                                          colormodel = twocolorramp 
                                          outline;
   xaxis valueattrs = (size = 12pt) label = 'City Mileage' 
         labelattrs = (size = 14pt) fitpolicy = rotate;
   yaxis valueattrs = (size = 12pt) label = 'Highway Mileage' 
         labelattrs = (size = 14pt);
run;

*Custom three color;
proc sgplot data = work01;
   heatmap x = mpg_city y = mpg_highway / freq = frequency 
                                          discretex discretey 
                                          colormodel = (green yellow blue) 
                                          outline;
   xaxis valueattrs = (size = 12pt) label = 'City Mileage' 
         labelattrs = (size = 14pt) fitpolicy = rotate;
   yaxis valueattrs = (size = 12pt) label = 'Highway Mileage' 
         labelattrs = (size = 14pt);
run;

*Custom four color;
proc sgplot data = work01;
   heatmap x = mpg_city y = mpg_highway / freq = frequency 
                                          discretex discretey 
                                          colormodel = (cxEDF8E9 cxBAE4B3 cx74C476 cx238B45) 
                                          outline;
   xaxis valueattrs = (size = 12pt) label = 'City Mileage' 
         labelattrs = (size = 14pt) fitpolicy = rotate;
   yaxis valueattrs = (size = 12pt) label = 'Highway Mileage' 
         labelattrs = (size = 14pt);
run;

*Adding in TEXT;
proc sgplot data = work01;
   heatmap x = mpg_city y = mpg_highway / freq = frequency 
                                          discretex discretey 
                                          colormodel = twocolorramp 
                                          outline;
   text x = mpg_city y = mpg_highway text = frequency;
   xaxis valueattrs = (size = 12pt) label = 'City Mileage' 
         labelattrs = (size = 14pt) fitpolicy = rotate;
   yaxis valueattrs = (size = 12pt) label = 'Highway Mileage' 
         labelattrs = (size = 14pt);
run;

*Fixing the legends;
proc sgplot data = work01 noautolegend;
   heatmap x = mpg_city y = mpg_highway / freq = frequency 
                                          discretex discretey 
                                          colormodel = twocolorramp 
                                          outline;
   text x = mpg_city y = mpg_highway text = frequency;
   gradlegend / position = top;
   xaxis valueattrs = (size = 12pt) label = 'City Mileage' labelattrs = (size = 14pt) fitpolicy = rotate;
   yaxis valueattrs = (size = 12pt) label = 'Highway Mileage' labelattrs = (size = 14pt);
run;

*Adjusting the size;
ods graphics / width=800px;
proc sgplot data = work01 noautolegend;
   heatmap x = mpg_city y = mpg_highway / freq = frequency 
                                          discretex discretey 
                                          colormodel = twocolorramp 
                                          outline;
   text x = mpg_city y = mpg_highway text = frequency / textattrs=(size=14pt) 
                                                        discreteoffset = -.15;
   gradlegend / position = top;
   xaxis valueattrs = (size = 12pt) label = 'City Mileage' 
         labelattrs = (size = 14pt) fitpolicy = rotate;
   yaxis valueattrs = (size = 12pt) label = 'Highway Mileage' 
         labelattrs = (size = 14pt);
run;

*Final graph;
ods graphics / width=600px;
proc sgplot data = work01 noautolegend;
   heatmap x = mpg_city y = mpg_highway / freq = frequency 
                                          discretex discretey 
                                          colormodel = twocolorramp 
                                          outline;
   text x = mpg_city y = mpg_highway text = frequency / textattrs=(size=16pt) 
                                                        discreteoffset = -.125;
   gradlegend / position = right;
   xaxis valueattrs = (size = 12pt) label = 'City Mileage' 
         labelattrs = (size = 14pt) fitpolicy = rotate;
   yaxis valueattrs = (size = 12pt) label = 'Highway Mileage' 
         labelattrs = (size = 14pt);
run;


data US;
   set mapsgfk.US;
   where StateCode NOT IN ("AK", "HI", "PR");
   by state segment;
   /* create ID variable for polygons */
   if first.segment then PolyID + 1;    
run;

/* enable anti-aliasing and labels */
ods graphics / antialiasmax = 2400 labelmax = 1500; 
title "Outline of 48 US States";
proc sgplot data = US;
   polygon x = x y = y ID = polyid / fill outline;
run;
title;

*Concatenate some city-level data;
data All; 
   set maps.uscity(where = (statecode NOT IN ("AK" "HI" "PR") AND pop > 5e5)
                   rename = (x = cityX y = cityY))
       work.US;
run;

*Overlay the city data;
title "US States with Some Large Cities";
proc sgplot data = All noautolegend noborder;
   polygon x = x y = y ID = PolyID / fill outline 
                                     transparency = 0.75
                                     group = StateCode;
   scatter x = cityX y = cityY / datalabel = city;
   xaxis display=none;
   yaxis display=none;
run;
title;

quit;
