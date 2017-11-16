clc
clear all

n = 0:1:20;

f_1 = @(n) n.^2 ; 
f_2 = @(n) n.^3 ; 
f_3 = @(n) 2.^n ;
f_4 = @(n) 100*n.^2 ;
f_5 = @(n) 0.001*2.^n ;

figure
subplot(3,2,1)
plot(n, f_1(n), 'r');

subplot(3,2,2)
plot(n, f_2(  n), 'b');

subplot(3,2,3)
plot(n, f_3(n), 'g');

subplot(3,2,4)
plot(n, f_4(n), '-*');

subplot(3,2,5)
plot(n, f_5(n), 'o-');

%% Plot comparison for problem (a)
k = 0 : 1 : 200;

figure
plot(k, f_1(k), 'r');
hold on
plot(k, f_2(k), 'b');
hold on
plot(k, f_4(k), '-*');
legend('f_1(n) = n^2', 'f_2(n) = n^3', 'f_4(n) = 100*n^2', '')
hold off
xlabel('n')
ylabel('f(n)')

%% Plot comparison for part (b)
m = 0:1:25;

figure
plot(m, f_2(m), 'r');
% hold on
% plot(m, f_3(m), 'g');
hold on
plot(m, f_5(m), '-o');
%legend('f_2(n) = n^3', 'f_3(n) = 2^n', 'f_5(n) = 0.001*2^n', '')
legend('f_2(n) = n^3', 'f_5(n) = 0.001*2^n', '')
hold off
xlabel('n')
ylabel('f(n)')




