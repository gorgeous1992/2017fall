ods listing close;
ods rtf file = 'L:\Basic Cars Report.rtf';

proc report data = st555.cars out = cars_report;
   column make model type msrp mpg_city mpg_highway;
run;

ods rtf close;

ods rtf file = 'L:\Cars Mileage vs Cost Report (Default).rtf';

proc report data = st555.cars out = cars_report;
   column mpg_city mpg_highway msrp;
run;

ods rtf close;

ods rtf file = 'L:\Ordered Mileage vs Cost.rtf';

proc report data = st555.cars out = cars_report;
   title;
   column type mpg_city mpg_highway msrp;
   define type / order 'Type of Vehicle';
   define mpg_city / display style(column) = [just = center width = .75in] 'City Mileage';
   define mpg_highway / display style(column) = [just = center width = .75in] 'Highway Mileage';
   define msrp / display style(column) = [just = center width = 1.5in] format = dollar7. "Manufacturer's Suggested Retail Price";
run;

ods rtf close;

ods rtf file = 'L:\Ordered Mileage vs Cost (Two-Column).rtf' columns = 2;

proc report data = st555.cars out = cars_report;
   title;
   column type mpg_city mpg_highway msrp;
   define type / order 'Type of Vehicle';
   define mpg_city / display style(column) = [just = center width = .75in] 'City Mileage';
   define mpg_highway / display style(column) = [just = center width = .75in] 'Highway Mileage';
   define msrp / display style(column) = [just = center width = 1.5in] format = dollar7. "Manufacturer's Suggested Retail Price";
run;

ods rtf close;

proc sort data = st555.cars
          out = cars;
   by type;
run;

proc sort data = st555.cars(keep = type) 
          out = car_types 
          nodupkey;
   by type;
run;

data car_sortn;
   set car_types;
   mainord = _n_;
run;

data cars2;
   merge cars car_sortn;
   by type;
run;

ods rtf file = 'L:\Ordered Mileage vs Cost (Readable).rtf' columns = 2;

proc report data = cars2 out = cars_report;
   title;
   column mainord type mpg_city mpg_highway msrp;
   define mainord / order noprint;
   define type / display 'Type of Vehicle';
   define mpg_city / display style(column) = [just = center width = .75in] 'City Mileage';
   define mpg_highway / display style(column) = [just = center width = .75in] 'Highway Mileage';
   define msrp / display style(column) = [just = center width = 1.5in] format = dollar7. "Manufacturer's Suggested Retail Price";
run;

ods rtf close;

ods rtf file = 'L:\Report with Line Breaks.rtf';

proc report data = cars2 out = cars_report;
   column mainord type mpg_city mpg_highway msrp;
   define mainord / order noprint;
   define type / display;
   define mpg_city / display;
   define mpg_highway / display;
   define msrp / display;

   compute after mainord;
      line '';
   endcomp;
run;

ods rtf close;

ods rtf file = 'L:\Report With Text.rtf';

proc report data = cars2 out = cars_report;
   column mainord type mpg_city mpg_highway msrp;

   define mainord / order noprint;
   define type / display;
   define mpg_city / display;
   define mpg_highway / display;
   define msrp / display;

   compute before mainord / style=[just = center fontsize = 14pt color = cx0000FF];
      line 'Begin type ' mainord 1.;
   endcomp;
run;

ods rtf close;

ods rtf file = 'L:\Report Using BY-groups.rtf';

proc report data = cars2 out = cars_report;
   by mainord;
   column mainord type mpg_city mpg_highway msrp;

   define mainord / order noprint;
   define type / display;
   define mpg_city / display;
   define mpg_highway / display;
   define msrp / display;

   compute before mainord / style=[just = center fontsize = 14pt color = cx0000FF];
      line 'Begin type ' mainord 1.;
   endcomp;
run;

ods rtf close;

ods rtf file = 'L:\Report Using RTF Commands.rtf';
ods escapechar = "~";
options nobyline;

proc report data = cars2 out = cars_report;
   by mainord;
   column mainord type mpg_city mpg_highway msrp;

   define mainord / order noprint;
   define type / display;
   define mpg_city / display;
   define mpg_highway / display;
   define msrp / display;

   compute before mainord / style=[just = center fontsize = 14pt color = cx0000FF];
      line "~R'\b\i ' Begin type ~R'\b0\i0 '" mainord 1.;
   endcomp;
run;

ods rtf close;
      



quit;