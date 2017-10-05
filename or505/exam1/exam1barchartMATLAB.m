clc
clear all
grades = [90,65,82,76,84,90,78,94,66,92,82,92,94,67,76,84,71,85,80,90,53,72,91,97,75,103,...
    83,66,80,86,63,83];

N = length(grades);
barcapacity = zeros(1,6);

switch (grades)
        case 51:60
            barcapacity(1) = barcapacity(1) + 1
        case 61:70
            barcapacity(2) = barcapacity(2) + 1;
        case 71:80
            barcapacity(3) = barcapacity(3) + 1;
        case 81:90
            barcapacity(4) = barcapacity(4) + 1;
        case 91:100
            barcapacity(5) = barcapacity(5) + 1;
        case 101:110
            barcapacity(6) = barcapacity(6) + 1;
end
            
for i = 1 : N
    if grades(i) > 50 





width = 51 : 10 : 110;
barcapacity
length(width)
length(barcapacity)

bar(width, barcapacity)