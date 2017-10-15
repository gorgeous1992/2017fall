
/* Approximate ship dates for major releases of SAS software.
   Ignore the day: 01JUN just means "some day in June" 
   Author: Rick Wicklin
   Source: http://blogs.sas.com/content/iml/2013/08/02/how-old-is-your-version-of-sas-release-dates-for-sas-software.html
   Last Accessed: 2016-07-25:11:02:00*/

data releases;
   format date date9.;
   input category $8. release $6. date date9. statRelease $5.;
   cards;
Ancient 8.0   01Nov1999 
Ancient 8.1   01Jul2000 
Ancient 8.2   01Mar2001 
Ancient 9.0   01Oct2002 
Ancient 9.1   01Dec2003 
Ancient 9.1.3 01Aug2004 
Old     9.2   01Mar2008 9.2
Old     9.2m2 01Apr2010 9.22
Old     9.3   12Jul2011 9.3
Recent  9.3m2 29Aug2012 12.1
Recent  9.4   10Jul2013 12.3
Recent  9.4m1 15Dec2013 13.1
Recent  9.4m2 05Aug2014 13.2
Recent  9.4m3 14Jul2015 14.1
   ;
run;
 
*Set path for file and image quality;
ods listing gpath = "S:\Documents\CURRENT COURSES\ST 555 Redesign\Graphics\" 
            image_dpi = 100 sge = off;
*Set name for the file and image format;
ods graphics / imagename = "SAS Version History" 
               outputfmt = png reset = index;


title "Major Releases of SAS Software and Analytical Products";
title2 ' ';
title3 'Data Label is SAS STAT Release Number';
proc sgplot data = releases noautolegend;
   styleattrs datacolors = (red yellow green);
   block x = date block = category / transparency = 0.8;
   scatter x = date y = release / datalabel = statRelease 
                                  datalabelpos = right
                                  markerattrs = (symbol = circleFilled
                                                 size = 14);
   xaxis grid type = time offsetmin=0 label = 'Release Year';
   yaxis type = discrete offsetmax=0.1 label = 'Release Number';
run;
title;

quit;
