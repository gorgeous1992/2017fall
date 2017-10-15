%let name=we_didnt_start_the_fire;
filename odsout '.';

/*
Original graph & data from here:
http://www.rachelleedesign.com/data-visualizations/
http://static1.squarespace.com/static/524ad9c3e4b031f96a6c0f03/t/54db8b86e4b0e0b2dc28f346/1423674246509/Dataviz_Process_Book.pdf

And double-checked a few spellings in:
http://www.school-for-champions.com/history/start_fire_facts.htm#.V7MDnPkrKM8

Entered data & text by hand into xls spreadsheet.
*/

PROC IMPORT OUT=my_data
 DATAFILE="we_didnt_start_the_fire.xls"
 DBMS=XLS REPLACE;
 GETNAMES=YES;
 MIXED=NO;
RUN;

data my_data; set my_data;
data_order=_n_;
run;
proc sort data=my_data out=my_data;
by year data_order;
run;
data my_data; set my_data;
by year;
if first.year then ring=1;
else ring+1;
run;

%let color0=black;
%let color1=cxe41a1c;
%let color2=cx377eb8;
%let color3=cx4daf4a;
%let color4=cx984ea3;
%let color5=cxff7f00;
%let color6=cxffff33;
%let color7=cxa65628;

/*
%let color1=cxee1e7b;
%let color2=cxee1d23;
%let color3=cxef6437;
%let color4=cxf2b318;
%let color5=cxffe60c;
%let color6=cx9ecb3a;
%let color7=cx49bfa8;
*/

%let x_cen=50;
%let y_cen=50;

%let maxsize=48;

/* insert blank/black area between last obsn and middle of pie */
proc sort data=my_data out=my_data;
by year ring;
run;
data my_data; set my_data;
by year;
output;
if last.year then do;
 ring=ring+1;
 category=0;
 name='Blank';
 description='Blank';
 output;
 end;
run;

proc sort data=my_data out=my_data;
by ring year;
run;

data anno_rings; set my_data;
length function $8 color $12 function $8 style $35 text $100 html $500;
xsys='3'; ysys='3'; hsys='3'; when='a';
x=&x_cen; y=&y_cen;  /* center of pie */
size=&maxsize-(ring*3.0); /* the 3.0 is the width of each band */
rotate=-1*(360/(1989-1949)); /* the amount of angle of each year */
angle=90-(year-1949)*(360/(1989-1949+1)); /* the start position of each year */
if category=1 then color="&color1";
if category=2 then color="&color2";
if category=3 then color="&color3";
if category=4 then color="&color4";
if category=5 then color="&color5";
if category=6 then color="&color6";
if category=7 then color="&color7";
if category=0 then color="&color0";
function='pie'; 
style='psolid'; output;
if category=0 then do;
 html='title='||quote(" ");
 color="&color0"; 
 end;
else do;
 html=
  'title='||quote(
   trim(left(name))||'0d'x||
   trim(left(description)))||
  ' href='||quote('https://www.google.com/search?&q='||trim(left(name))||'+'||trim(left(year)));
 color='gray33'; 
 end;
style='pempty'; output;
run;

data whole_record;
length function $8 color $12 function $8 style $35 text $100 html $500;
xsys='3'; ysys='3'; hsys='3'; when='a';
x=&x_cen; y=&y_cen;  
size=&maxsize-2.5; 
rotate=360;
angle=0;
function="pie";
style="psolid";
color="black";
run;

/*
the outline of some of the colored slices were 'showing through',
so I'm covering the inner black vinyl with yet-another layer of
black vinyl, to cover those faint traces of outline.
*/
data cover_up;
length function $8 color $12 function $8 style $35 text $100 html $500;
xsys='3'; ysys='3'; hsys='3'; when='a';
x=&x_cen; y=&y_cen;  
size=24; 
rotate=360;
angle=0;
function="pie";
style="psolid";
color="black";
run;

data record_label;
length function $8 color $12 function $8 style $35 text $100 html $500;
xsys='3'; ysys='3'; hsys='3'; when='a';
x=&x_cen; y=&y_cen;  
size=15; 
rotate=360;
angle=0;
function="pie";
style="psolid";
color="cxe6c041";
html=
 'title='||quote('Click to see the official music video')||
 ' href='||quote('https://www.youtube.com/watch?v=eFTLKWw542g');
run;

data label_text;
length function $8 color $12 function $8 style $35 text $100 html $500;
xsys='3'; ysys='3'; hsys='3'; when='a';
size=2.5; 
rotate=.;
angle=.;
function="label";
style="albany amt/bold"; color=''; 
x=&x_cen; 
y=&y_cen+8+1.0; text="We Didn't Start"; output;
y=&y_cen+4.5+1.0;  text="The Fire"; output;
y=&y_cen-5;  text="Billy Joel"; output;
run;

data record_hole;
length function $8 color $12 function $8 style $35 text $100 html $500;
xsys='3'; ysys='3'; hsys='3'; when='a';
x=&x_cen; y=&y_cen;  
size=1.2; 
rotate=360;
angle=0;
function="pie";
style="psolid"; color="white"; output;
style="pempty"; color="gray44"; output;
run;

data anno_years;
length function $8 color $12 function $8 style $35 text $100 html $500;
xsys='3'; ysys='3'; hsys='3'; when='a';
do year=1949 to 1989;
 x=&x_cen; y=&y_cen;
 size=&maxsize; 
 rotate=-1*(360/(1989-1949)); 
 angle=90-(year-1949)*(360/(1989-1949+1))-(360/(1989-1949+1))/2; 
 function='pie'; style='pempty'; color='white';
 output;
 function='piexy'; size=.99; output;
 function='cntl2txt'; output;
 function='label'; style=''; color=''; rotate=0; angle=0; position='5'; size=.; x=.; y=.;
 text=trim(left(year));
 output;

 end;
run;

data anno_legend;
length function $8 color $12 function $8 style $35 text $100 html $500;
xsys='3'; ysys='3'; hsys='3'; when='a';
html='';
/* first, the text in the legend */
function='LABEL'; color='white'; style='albany amt/bold'; position='6'; size=1.5;
x=32;
y=33;  text='Foreign Affairs'; output;
y=y-2.4; text='US Affairs'; output;
y=y-2.4; text='Pop Culture'; output;
y=y-2.4; text='The Arts'; output;
y=y-2.4; text='Famous Deaths'; output;
y=y-2.4; text='Sports'; output;
y=y-2.4; text='Health & Disease'; output;
/* 'marker' character 'U' is a box - these are my color chips in legend */
style='marker'; text='U'; position='5'; size=2.0;
x=32-2; 
y=33-.3; color="&color1"; output;
y=y-2.4;   color="&color2"; output; /* red */
y=y-2.4;   color="&color3"; output;
y=y-2.4;   color="&color4"; output; /* green */
y=y-2.4;   color="&color5"; output;
y=y-2.4;   color="&color6"; output; /* blue */
y=y-2.4;   color="&color7"; output; /* blue */
/* And, draw an outline around them ... */
style='markere'; color="gray55";
x=32-2; 
y=33-.3; output;
y=y-2.4; output;
y=y-2.4; output;
y=y-2.4; output;
y=y-2.4; output;
y=y-2.4; output;
y=y-2.4; output;
run;

data anno_all; set anno_years whole_record anno_rings 
 cover_up 
 record_label label_text record_hole anno_legend;
run;

goptions device=png noborder;
goptions xpixels=850 ypixels=850;

ODS LISTING CLOSE;
ODS HTML path=odsout body="&name..htm" 
 (title="We Didn't Start the Fire - Visualization")
 style=sasweb;

goptions gunit=pct ftitle="albany amt/bold" ftext="albany amt";
goptions htitle=16pt htext=9pt;

proc gslide anno=anno_all des='' name="&name";
run;

proc sort data=my_data (where=(name^='Blank')) out=my_data;
by data_order;
run;

data my_data; set my_data;
length link $300 href $300;
href=' href='||quote('https://www.google.com/search?&q='||trim(left(name))||'+'||trim(left(year)));
link = '<a ' || trim(href) || ' target="body">' || htmlencode(trim(name)) || '</a>';
run;

title1 c=black "We Didn't Start the Fire - Billy Joel";
proc print data=my_data noobs label
 style(header)={background=white bordercolor=white font_size=12pt color=gray33}
 ; 
label year='00'x;
label link='00'x;
label description='00'x;
var year link description;
run;

quit;
ODS HTML CLOSE;
ODS LISTING;

quit;