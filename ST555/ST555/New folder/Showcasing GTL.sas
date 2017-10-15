/*
Author: Jonathan W. Duggins
Date Created: 2016-11-29
Purpose: Demonstrate PROC TEMPLATE

Modification Date: N/A
Reason for Modification: N/A
*/

*Don't need to output anything until the very end!;
ods _all_ close;

*Sort data for BY-processing;
proc sort data = st555.cars(keep = msrp mpg_city type origin) out = byOrigin;
   by origin;
run;

*Need counts of each ORIGIN in each bin;
*Use ODS OUTPUT to save the data;
proc sgplot data = byOrigin;
   by origin;
   histogram msrp / scale=count binstart=10000 binwidth=5000; 
   ods output sgplot = MSRPbins(drop = msrp
                                rename = (BIN_MSRP_SCALE_count_BINSTART__Y=count
                                          BIN_MSRP_SCALE_count_BINSTART__X=xBin)
                                where = (not missing(count)));
run;

*Sort again;
proc sort data=MSRPbins out=MSRPbinsBYbins;
  by xBin;
run;

*Create cumulative counts within each bin;
*Needed to figure out where each bar segment should start and stop;
data HighLowMSRP(drop = count);
   retain Low High;
   set MSRPbinsBYbins;
   by xbin;
   if first.xbin then Low = 0;
   High = Low + count;
   output;
   Low = High;
run;

*Repeat for second variable;
proc sgplot data = byOrigin;
   by origin;
   histogram mpg_city / scale=count binstart=10 binwidth=5; 
   ods output sgplot = MPGbins(drop = mpg_city
                                rename = (BIN_MPG_CITY_SCALE_count_BINS__Y=count
                                          BIN_MPG_CITY_SCALE_count_BINS__X=yBin)
                                where = (not missing(count)));
run;

proc sort data=MPGbins out=MPGbinsBYbins;
  by yBin;
run;

data HighLowMPG(drop = count);
   retain Low High;
   set MPGbinsBYbins;
   by ybin;
   if first.ybin then Low = 0;
   High = Low + count;
   output;
   Low = High;
run;

*Concatenate the original data (needed for scatter plot),
 x-variable data (needed for first "bar chart"),
 y-variable data (needed for second "bar chart").

 Scale down the MSRP values so the x-axes is readable;
data combined;
   set byOrigin
       HighLowMSRP
       HighLowMPG;
   msrp = msrp/1000;
   xbin = xbin/1000;
run;

*PROC TEMPLATE!;
proc template;
   *Name your custom template;
   define statgraph Scatter_Layout;
      *Begin listing the graphical elements;
      begingraph;
         *No automatic subtitles in PROC TEMPLATE - use TEXTATRRS= to change sizes;
         entrytitle "City Milage vs. Manufacturer's Suggested Retail Price" / textattrs = (size = 12pt);
         entrytitle 'Joint and Marginal Distributions' / textattrs = (size = 10pt);
         entrytitle 'Broken out by Country of Origin' / textattrs = (size = 8pt);

         /*--Outermost Lattice Container--*/
         layout lattice / rows=2 columns=2 rowweights=(0.3 0.7) columnweights=(0.7 0.3)
                          columndatarange=union rowdatarange=union
                          rowgutter=5 columngutter=5;

            /*--Common Row axes--*/
            rowaxes;
               *Row 1;
               rowaxis / offsetmin=0 offsetmax = 0 display=(label ticks tickvalues) 
                         label = 'Frequency' labelattrs = (size = 14pt) 
                         griddisplay=on gridattrs=(thickness = 2 color=cxa9a9a9)
                         tickvalueattrs = (size = 12pt)
                         linearopts = (viewmin = 0 viewmax = 80  
                                       tickvaluesequence = (start = 0 increment = 20 end = 80));
               *Row 2;
               rowaxis / label='City Mileage (MPG)' labelattrs = (size = 14pt)
                         griddisplay=on gridattrs=(thickness = 2 color=cxa9a9a9)
                         tickvalueattrs = (size = 12pt)
                         linearopts=(tickvaluesequence=(start=10 increment=10 end=60) 
                                     minorticks = true minortickcount = 1 
                                     minorgrid = true minorgridattrs = (thickness = 1 color = cxa9a9a9));
            endrowaxes;

            /*--Common Column axes--*/
            columnaxes;
               *Column 1;
               columnaxis / offsetmax = 0.05 
                            label='MSRP ($1000)' labelattrs = (size = 14pt) 
                            griddisplay=on gridattrs=(thickness = 2 color=cxa9a9a9) 
                            tickvalueattrs = (size = 12pt)
                            linearopts=(viewmin = 10 viewmax = 210 
                                        tickvaluesequence=(start=10 increment=20 end=210)
                                        minorticks = true minortickcount = 1 
                                        minorgrid = true minorgridattrs = (thickness = 1 color = cxa9a9a9));
               *Column 2;
               columnaxis /  offsetmin=0 display=(label ticks tickvalues) 
                             label = 'Frequency' labelattrs = (size = 14pt) 
                             griddisplay=on gridattrs=(thickness = 2 color=cxa9a9a9)
                             tickvalueattrs = (size = 12pt);
            endcolumnaxes;

            /*--Upper Left cell with Stacked X Bins counts by group--*/
            layout overlay;
               highlowplot x = xBin low = low high = high / group = origin type = bar intervalbarwidth = 8.5;
            endlayout;

            /*--Upper Right cell with Legend--*/
            *Name the legend to select which items go in it;
            layout overlay;
               discretelegend 'Origin' / title = 'Origin' titleattrs = (color = cxCC0000) 
                                         border = false titleborder = true;
            endlayout;

            /*--Lower Left cell with SX-Y Scatter Plot--*/
            *Use legend name to send this plots info to the legend;
            layout overlay;
               scatterplot x = msrp y = mpg_city / group = origin
                                                   markerattrs = (symbol=circlefilled size=5 transparency = .6) 
                                                   name='Origin';
            endlayout;

            /*--Lower Right cell with Stacked Y Bins counts by group--*/
            *Notice the bin information is on the y-axis now, providing a graph that appears to be rotated;
            layout overlay;
               highlowplot y = yBin low = low high = high / group = origin type = bar intervalbarwidth = 19;
            endlayout;
         endlayout; *ends the lattice;
      endgraph; *ends the graphical elements;
   end; *ends the DEFINE for this template;
run;

*Set path for file and image quality;
ods listing gpath = "S:\Documents\CURRENT COURSES\ST 555 Redesign\Graphics\" 
            image_dpi = 300 sge = on;
*Set name for the file and image format;
ods graphics / imagename = "SGRENDER Example" 
               outputfmt = pdf reset = index;

*SGRENDER to use my custom template;
proc sgrender data = combined template=Scatter_Layout;
run;

*Set OUTPUTFMT option and reset INDEX value to 1;
*9.4m3 you can use RESET with OUTPUTFMT and specify a value for the index:
   RESET = OUTPUTFMT
   RESET = INDEX(101)
;
ods graphics / outputfmt = png reset = index;

*SGRENDER to the default file type;
proc sgrender data = combined template=Scatter_Layout;
run;

quit;
