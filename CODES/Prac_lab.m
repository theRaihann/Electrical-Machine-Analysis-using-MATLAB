%%
clc
close
clear

V_S = 230;
amps = 0:6.52:65.2;
% I_S = 65.2;
% R_S = V_S/I_S;
% r_s = V_S./amps;
% r_percent = r_s*100/R_S;
Req = 0.0445;
Xeq = 0.0645;

I(1,:) = amps .* (0.8 - j*0.6);
I(2,:) = amps .* 1;
I(3,:) = amps .* (0.8 + j*0.6);

VPa = V_S + Req.*I + j.*Xeq.*I;
VR = (abs(VPa)-V_S)./V_S.*100;

plot(amps,VR(1,:),'b-');
hold on;
plot(amps,VR(2,:),'k-');
plot(amps,VR(3,:),'r-');
title('Voltage Regulation Versus Load');
xlabel('Load(A)');
ylabel('Voltage Regulation(%)');
%legend()
hold off



































%% Linear Interpolation
clc
clear
close
x = input('Enter the abcissa of the given points ');
y = input('Enter the ordinates of the points ');

xvar = input('Enter the point ');
lx = max(x(x<xvar));
hx = min(x(x>xvar));

ly = y(x==lx);
hy = y(x==hx);

yvar = ((xvar-hx)/(lx-hx))*ly - ((xvar-lx)/(lx-hx))*hy ;



%%
% Lagrange Polynomial
clear 
clc
close 
format long
x = [0:6];
y = [0 0.8415 0.9093 0.1411 -0.7568 -0.9589 -0.2794];
% x = input('Enter the abcissa of the points ');
% y = input('Enter the ordinates of the points ');
sum=0;
for i=1:length(x)
    p=1;
    for j=1:length(x)
        if j~=i
            c = poly(x(j))/(x(i)-x(j));
            p = conv(p,c);
        end
    end
    term = p*y(i);
    sum= sum + term;
end
disp(sum);

%plotting

x_plot = [0:0.1:10];

y_plot = polyval(sum,x_plot);

figure(1),clf
plot(x_plot/10,y_plot,'linew',2)
hold on;
%plot(x,y,'r*');
xlabel('x')
ylabel('y')
grid on


%%
% Newton Polynomial
clear 
clc
close 
format short
% x = [0:6];
% y = [0 0.8415 0.9093 0.1411 -0.7568 -0.9589 -0.2794];
x = input('Enter the abcissa of the points ');
y = input('Enter the ordinates of the points ');
n = length(x);
b_mat = zeros(n,n);
b_mat(:,1) = y;

for j=2:n
    for i=1:(n-j+1)
        b_mat(i,j) = (b_mat(i,j-1)-b_mat(i+1,j-1))/(x(i)-x(i+j-1));
    end
end

p = y(1);
var = 1;
for k=1:n-1
    var = conv(var,poly(x(k)));
    p = [zeros(1,1),p]+ b_mat(1,k+1)*var;
end

disp(p)

%plotting

x1 = 0:0.1:6;
y1 = polyval(p, x1);
plot(x, y, 'r*')
grid on
hold on
plot(x1, y1,'linew',2)
xlabel("X")
ylabel("Y")
hold off



    
 %%
 % Solving Linear equations
%  x = A\b;
%  x = pinv(A)*b;

% Gauss Jordan elimination with pivoting

clc
clear 
close 

A = input("Enter the coefficients of the variables along with the constant\n");
n = size(A,1);

for k=1:n-1
    max = abs(A(k,k));
    p = k;
    for m = (k+1):n
        if abs(A(m,k))>max
            max = abs(A(m,k));
            p  = m;
        end
    end
    if p~=k
        temp = A(k,:);
        A(k,:) = A(p,:);
        A(p,:) = temp;
%         for q = k : n+1
%             temp = A(k,q);
%             A(k,q) = A(p,q);
%             A(p,q) = temp;
%         end
    end
    for i = k+1 : n
        u = A(i,k) / A(k,k) ;
        for j = k : n+1
            A(i,j) = A(i,j) - u*A(k,j);
        end
    end
end
fprintf('The reduced equations are\n');
disp(A);

x = zeros(1,n);
x(n) = A(n,n+1) / A(n,n);

for i= (n-1):-1:1
    sum = 0;
    for j = (i+1):n
        sum = sum + A(i,j)* x(j);
    end
    x(i) = (A(i,n+1)-sum)/ A(i,i);
end
fprintf('The solution is \n')
disp(x);


%%
[a,r2] = linregr([0:6],[0 0.8415 0.9093 0.1411 -0.7568 -0.9589 -0.2794]);
function [a, r2] = linregr(x,y)
% linregr: linear regression curve fitting
% [a, r2] = linregr(x,y): Least squares fit of straight
% line to data by solving the normal equations
% input:
% x = independent variable
% y = dependent variable
% output:
% a = vector of slope, a(1), and intercept, a(2)
% r2 = coefficient of determination
n = length(x);
if length(y)~=n, error('x and y must be same length'); end
x = x(:); y = y(:); % convert to column vectors
sx = sum(x); sy = sum(y);
sx2 = sum(x.*x); sxy = sum(x.*y); sy2 = sum(y.*y);
a(1) = (n*sxy-sx*sy)/(n*sx2-sx^2);
a(2) = sy/n-a(1)*sx/n;
r2 = ((n*sxy-sx*sy)/sqrt(n*sx2-sx^2)/sqrt(n*sy2-sy^2))^2;
% create plot of data and best fit line
xp = linspace(min(x),max(x),2);
yp = a(1)*xp+a(2);
plot(x,y,'o',xp,yp)
grid on
end


%%
% Curve Fitting
function  c_vect = curve_fitter(order,x_data,y_data)
    
    if length(x_data)==length(y_data)
        n = length(x_data);
    else
        fprintf('The dimensions of the row vectors do not match; please give correct inputs \n');
    end
    
    N = order+1;
    A = zeros(N,N);
    
    for i = 1:N
        for j = 1:N
            A(i,j)= sum(x_data.^(i+j-2));
        end
    end
    
    B = zeros(N,1);
    
    for k=1:N
        B(k) = sum((x_data.^(k-1)).* y_data);
    end
    c_vect = A\B;
end
    

