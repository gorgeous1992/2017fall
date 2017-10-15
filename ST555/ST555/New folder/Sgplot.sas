proc sgplot data = st555.fish;
   histogram hg;
   where hg lt 2;
run;

proc sgplot data = st555.fish;
   histogram hg / dataskin = pressed;
   where hg lt 2;
run;

proc sgplot data = st555.fish;
   histogram hg / binstart = 0 binwidth = 0.2;
   where hg lt 2;
run;

proc sgplot data = st555.fish;
   histogram hg / nbins = 6;
   where hg lt 2;
run;


proc sgplot data = st555.fish;
   histogram hg / scale = count;
   where hg lt 2;
run;

proc sgplot data = st555.fish;
   density hg;
   where hg lt 2;
run;

proc sgplot data = st555.fish;
   density hg / type = kernel;
   where hg lt 2;
run;

proc sgplot data = st555.fish;
   histogram hg / dataskin = sheen;
   density hg;
   density hg / type = kernel;
   where hg lt 2;
run;

proc sgplot data = st555.fish;
   histogram hg / dataskin = sheen;
   density hg;
   density hg / type = kernel;
   keylegend / location = inside position = topleft
               across = 1 title = 'Density Type'
               titleattrs = (family = 'Arial Black'
                             color = blue);
   where hg lt 2;
run;

proc sgplot data = st555.fish;
   histogram hg / dataskin = sheen;
   density hg;
   density hg / type = kernel;
   keylegend / location = inside position = topleft
               across = 1 title = 'Density Type'
               titleattrs = (family = 'Arial Black' 
                             color = blue);
   xaxis minor minorcount = 2 offsetmin = 0
         valueattrs = (family = 'Georgia' 
                       color=cx5555FF size = 12pt);
   where hg lt 2;
run;

proc sgplot data = st555.fish;
   histogram hg / dataskin = sheen scale = proportion;
   density hg;
   density hg / type = kernel;
   keylegend / location = inside position = topleft
               across = 1 title = 'Density Type'
               titleattrs = (family = 'Arial Black' 
                             color = blue);
   xaxis minor minorcount = 2 offsetmin = 0
         valueattrs = (family = 'Georgia' 
                       color=cx5555FF size = 12pt);
   yaxis offsetmax = 0 values = (0 to .25 by 0.025)
         valuesformat = percent8.1
         display=(nolabel);
   where hg lt 2;
run;

proc sgplot data = st555.cars;
   vbar type;
run;

proc sgplot data = st555.cars;
   vbar type / dataskin = matte stat = percent;
run;

proc sgplot data = st555.cars;
   vbar type / response = msrp stat = median;
run;

proc sgplot data = st555.cars;
   vbar type / response = msrp stat = mean 
               limits = both alpha = 0.10
               limitattrs = (color = red);
run;

proc sgplot data = st555.cars;
   vbar type / response = msrp stat = freq
               datalabel datalabelpos = top;
run;

proc sgplot data = st555.cars;
   vbar type / fillattrs = (color = green);
run;

proc sgplot data = st555.cars;
   vbar type / fillattrs = (color = green) 
               filltype = gradient;
run;

proc sgplot data = st555.cars;
   vbar type / response = msrp stat = median
               baseline = 10000;
run;

proc sgplot data = st555.cars;
   vbar type / response = msrp stat = median
               baseline = 30000
               baselineattrs = (color = red);
run;

proc sgplot data = st555.cars;
   vbar type / baseline = 0 baselineattrs = (color = red);
run;

proc sgplot data = st555.cars noborder;
   vbar type / baseline = 0 baselineattrs = (color = red);
   xaxis display = (noline);
run;

proc sgplot data = st555.cars noborder;
   vbar type / group = origin grouporder = ascending
               categoryorder = RespAsc;
run;

proc sgplot data = st555.cars;
   scatter x = msrp y = mpg_city;
run;

proc sgplot data = st555.cars;
   scatter x = msrp y = mpg_city / group = origin
                                   markerattrs = (symbol = circlefilled 
                                                  size = 2.5 mm);
run;

proc sgplot data = st555.cars;
   where origin eq 'USA';
   scatter x = msrp y = mpg_city / group = origin
           markerattrs = (symbol = circlefilled size = 2.5mm
      color=cx66FF66) 
      filledoutlinedmarkers;
run;

proc sgplot data = st555.cars;
   where origin eq 'USA';
   scatter x = msrp y = mpg_city / group = origin
           markerattrs = (symbol = circlefilled size = 2.5 mm)
           filledoutlinedmarkers 
           markerfillattrs = (color = cx66FF66)
           markeroutlineattrs = (color = cxFF9933);
run;

proc sgplot data = st555.cars;
   scatter x = type y = mpg_city / markerattrs = (symbol = trianglefilled 
                                   color = cx3333FF);
run;

proc sgplot data = st555.cars;
   scatter x = type y = mpg_city / markerattrs = (symbol = trianglefilled 
                                   color = cx3333FF) jitter;
run;
  
proc sgplot data = st555.cars;
   where type = 'Hybrid'; 
   scatter x = mpg_highway y = mpg_city / markerattrs = (symbol = trianglefilled size=10pt)
                                          datalabel = model datalabelattrs = (family = 'Arial Black' size = 10pt);
   
run;

ods listing close;

proc means data = st555.cars lclm mean uclm;
   where type ne 'Hybrid';
   class type;
   var mpg_city mpg_highway;
   ods output summary = statz;
run;

ods listing;

proc sgplot data = statz;
   scatter x = mpg_city_mean y = mpg_highway_mean / 
            xerrorlower = mpg_city_lclm xerrorupper = mpg_city_uclm 
            yerrorlower = mpg_highway_lclm yerrorupper = mpg_highway_uclm 
            errorbarattrs = (color = cx3333FF)
            datalabel = type;
run;

quit;