%% Class Assesment Problem

clc
clear
close
format long

h = 0.01;
x = (0:h:1);
efunc = @(x) 3/5 * exp(2*x) + 2/5 * exp(-3*x);
der1 = @(m,x,y) -m+6*y ;
der2 = @(m,x,y) m ;

m = zeros(1,length(x));
y = zeros(1,length(x));
imy = zeros(1,length(x));
O = zeros(1,length(x));
P = zeros(1,length(x));

m(1) = 0;
O(1) = 0;
y(1) = 1;
P(1) = 1;
imy(1) = 1;


for i = 2:length(x)
    m(i) = m(i-1) + der1(m(i-1),x(i-1),y(i-1))*h ;
    y(i) = y(i-1) + der2(m(i-1),x(i-1),y(i-1))*h;
end

for i = 2:length(x)
    O(i) = m(i-1) + der1(m(i-1),x(i-1),imy(i-1))*h ;
    P(i) = imy(i-1) + der2(m(i-1),x(i-1),imy(i-1))*h;
    
    m(i) = m(i-1) + h/2 * (der1(m(i-1),x(i-1),imy(i-1)) + der1(O(i),x(i),P(i)));
    imy(i) = imy(i-1) + h/2 * (der2(m(i-1),x(i-1),imy(i-1)) + der2(O(i),x(i),P(i)));
end

ey = efunc(x) ;

% Plotting

plot(x,y,'g','linewidth',2);
hold on
grid on
plot(x,imy,'b','linewidth',2);
plot(x,ey,'r','linewidth',2);
xlabel('x');
ylabel('y');
legend('Euler Method','Improved Euler Method','Actual y(x)');

%% Report Excercise-01

clc
close
clear
format long

h = 0.01;
x = (0:h:2);
% efunc = @(x)exp(-(x-2).^2); % Actual Solution
der = @(x,y)-2*(x-2)*exp(-(x-2)^2) ;

y = zeros(1,length(x));
P = zeros(1,length(x));
y(1)=exp(-4);
P(1)=exp(-4);
for i = 2:length(x)
    P(i) = y(i-1) + der(x(i-1),y(i-1))*h ;
    y(i) = y(i-1) + (der(x(i-1),y(i-1))+ der(x(i),P(i)))*h/2 ; 
end

% ey = efunc(x);

% Plotting

plot(x,y,'r','linewidth',2);
hold on
grid on
% plot(x,ey,'g','linewidth',2);
xlabel('x');
ylabel('y');
% legend('Appoximate y(x)','Actual y(x)');

%% Report Exercise-02

clc
clear
close
format long

h = 0.01;
x = (0:h:4);

der1 = @(m,x,y) m + (cos(pi*x)-pi*sin(pi*x))*pi*exp(x) ;
der2 = @(m,x,y) m ;

m = zeros(1,length(x));
y = zeros(1,length(x));
imy = zeros(1,length(x));
O = zeros(1,length(x));
P = zeros(1,length(x));

m(1) = pi;
O(1) = pi;
y(1) = 0;
P(1) = 0;
imy(1) = 0;


for i = 2:length(x)
    m(i) = m(i-1) + der1(m(i-1),x(i-1),y(i-1))*h ;
    y(i) = y(i-1) + der2(m(i-1),x(i-1),y(i-1))*h;
end

for i = 2:length(x)
    O(i) = m(i-1) + der1(m(i-1),x(i-1),imy(i-1))*h ;
    P(i) = imy(i-1) + der2(m(i-1),x(i-1),imy(i-1))*h;
    
    m(i) = m(i-1) + h/2 * (der1(m(i-1),x(i-1),imy(i-1)) + der1(O(i),x(i),P(i)));
    imy(i) = imy(i-1) + h/2 * (der2(m(i-1),x(i-1),imy(i-1)) + der2(O(i),x(i),P(i)));
end



% Plotting

plot(x,y,'g','linewidth',2);
hold on
grid on
plot(x,imy,'b','linewidth',2);

xlabel('x');
ylabel('y');
legend('Euler Method','Improved Euler Method');



