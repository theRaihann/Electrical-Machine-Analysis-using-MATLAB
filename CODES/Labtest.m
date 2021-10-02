clc
clear 
close

t_given = [1:2:13];
H_given = [22 51 127 202 227 248 252];

c = 254;

H = log((c./H_given)-1);

M = zeros(2,2);
N = zeros(2,1);

for i= 1:2
    for j= 1:2
        M(i,j) = sum(t_given.^(i+j-2));
    end
end

for k=1:2
    N(k,1)= sum((t_given.^(k-1)).* H);
end

C = M\N;

A = exp(C(1));
B = -C(2);

fprintf('The value of A is \n');
disp(A);
fprintf('The value of B is \n');
disp(B);

coeff = flip(C);

% Plotting

t_plot = [1:13];
y_plot = polyval(coeff,t_plot);
y_plot = c./(exp(y_plot)+1); % c = 254cm

figure(1),clf
plot(t_plot,y_plot,'g','linew',2)
xlabel('t')
ylabel('H')
title("Curve Fitting")
hold on
plot(t_given,H_given,'ro','linew',1)
legend("Fitted Cuve","Given Data Points")

% finding height at 56th day

t = 56/7;
H = polyval(coeff,t);
H = c/(exp(H)+1);
fprintf('height at 56th day');
disp(H);




