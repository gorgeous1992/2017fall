data st555.wide;
   input var1 var2 $ var3 var4 $;
   label var1 = 'Analysis Value (AVAL)'
         var2 = 'Lab Test Code (LBTESTCD)'
         var3 = 'Analysis Value (AVAL)'
         var4 = 'Lab Test Code (LBTESTCD)'
   ;
   cards;
   10.0 HGB 11.0 LYM
   ;
run;

data st555.wide_subj;
   input subjid $ var1 var2 $ var3 var4 $;
   label subjid = 'Subject ID'
         var1 = 'Analysis Value (AVAL)'
         var2 = 'Lab Test Code (LBTESTCD)'
         var3 = 'Analysis Value (AVAL)'
         var4 = 'Lab Test Code (LBTESTCD)'
   ;
   cards;
   S-001 10.0 HGB 11.0 LYM
   S-002 12.0 HGB 13.0 LYM
   ;
run;

proc transpose data = st555.wide 
               out = wide_trans;
   var var1 - var4;
run;

proc transpose data = st555.wide 
               out = wide_trans(drop = _label_)
               name = Old_Vars
               prefix = AVAL;
   var var1 - var4;
run;

proc transpose data = st555.wide_subj 
               out = wide_trans;
   by subjid;
   var var1 - var4;
run;

data wide_array_t(keep = subjid 
		        aval lb:);
   set st555.wide_subj;
   by subjid;

   label lbtestn = 'Lab Test Number'
         lbtestcd = 'Lab Test Code'
         aval = 'Analysis Value';
   
   lbtestn = 1;
   lbtestcd = var2;
   aval =  var1;
   output;
   lbtestn = 2;
   lbtestcd = var4;
   aval = var3;
   output;
run;


data wide_array_t(keep = subjid 
		        lb: aval);
   set st555.wide_subj;
   by subjid;

   array values[*] var1 var3;
   array codes[*] var2 var4;
   label lbtestn = 'Lab Test Number'
         lbtestcd = 'Lab Test Code'
         aval = 'Analysis Value';
   
   do lbtestn = 1 to dim(values);
      lbtestcd = codes[lbtestn];
      aval = values[lbtestn];
      output;
   end;
run;


quit;