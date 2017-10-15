/*
Author: Jonathan W. Duggins
Date Created: 2016-08-04
Purpose: Demonstrate usage of arrays

Modification Date: N/A
Reason for Modification: N/A
*/

*Horrible approach!;
data temp_conv;
   set st555.city_temps;
   sun = (5/9) * (sun - 32);
   mon = (5/9) * (mon - 32);
   tue = (5/9) * (tue - 32);
   wed = (5/9) * (wed - 32);
   thr = (5/9) * (thr - 32);
   fri = (5/9) * (fri - 32);
   sat = (5/9) * (sat - 32);
run;

*Non-GPP approach to conversion;
data temp_conv(drop = i);
   set st555.city_temps;
   array cels_temp[7] sun -- sat;
   do i = 1 to 7;
      cels_temp[i] = (5/9)*(cels_temp[i] - 32);
   end;
run;

/*
Here we've made a few changes:
   - Use GPP by including two arrays
   - Use MISSING() routine to set missing values
   - Use ROUND() function to round the stored values
*/
data temp_conv2(drop = i);
   set st555.cities_spss;
   city = propcase(city);
   array far_temp[*] _numeric_;
   array cels_temp[7] csun cmon ctue cwed cthr cfri csat;
      do i = 1 to dim(far_temp);
        if far_temp[i] = 9999 then call missing(far_temp[i]);
        cels_temp[i] = round((5/9) * (far_temp[i] - 32),.1);
      end;
run;

quit;