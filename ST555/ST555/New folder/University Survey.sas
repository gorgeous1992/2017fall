
data st555.UnivSurveyFull;
   infile "\\stat.ad.ncsu.edu\Redirect\jwduggin\Desktop\postscndryunivsrvy2013dirinfo.csv" dlm=',' dsd missover firstobs=2;
   input (UNITID INSTNM ADDR CITY STABBR ZIP FIPS OBEREG CHFNM CHFTITLE GENTELE FAXTELE EIN OPEID OPEFLAG WEBADDR ADMINURL FAIDURL APPLURL NPRICURL SECTOR ICLEVEL CONTROL HLOFFER UGOFFER GROFFER HDEGOFR1 DEGGRANT HBCU HOSPITAL MEDICAL TRIBAL LOCALE OPENPUBL ACT NEWID DEATHYR CLOSEDAT CYACTIVE POSTSEC PSEFLAG PSET4FLG RPTMTH IALIAS INSTCAT CCBASIC CCIPUG CCIPGRAD CCUGPROF CCENRPRF CCSIZSET CARNEGIE LANDGRNT INSTSIZE CBSA CBSATYPE CSA NECTA F1SYSTYP F1SYSNAM F1SYSCOD COUNTYCD COUNTYNM CNGDSTCD LONGITUD LATITUDE) (56*:$200.);
run;

data st555.UnivSurveyNC st555.UnivSurvey;
   set st555.univsurveyFull;
   if stabbr eq 'NC' then output st555.univsurveync;
      else output st555.univsurvey;
run;

proc append base = univSurvey
            data = univSurveyNC;
run;

data test01;
   set st555.univsurveync(firstobs = 20 obs = 29) 
       st555.univsurvey(firstobs = 290 obs = 299);
run;

data test02;
   set st555.univsurveync(obs = 10) 
       st555.univsurvey(obs = 10);
run;

options obs = 10;

data test03;
   set st555.univsurveync st555.univsurvey;
run;

proc freq data = test03;
   table stabbr;
run;
