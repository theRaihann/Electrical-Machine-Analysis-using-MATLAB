%% Excercise-01 [Euler's Method]
clc
close
clear
format long

h =1/100;
x = (0:h:3);
efunc = @(x)(3*exp(-x/2)-2+x);
der = @(x,y)(x-y)/2 ;

y = zeros(1,length(x));
y(1)=1;

for i = 2:length(x)
    y(i) = y(i-1) + der(x(i-1),y(i-1))*h ;
end

ey = efunc(x);

% Plotting

plot(x,y,'r','linewidth',2);
hold on
grid on
plot(x,ey,'g','linewidth',2);
xlabel('x');
ylabel('y');
legend('Appoximate y(x)','Actual y(x)');


%% EXERCISE -02 [Euler's Method]
clc
clear
close
format long


h = 1/100;
t = (0:h:3);
R = 20000;
c = 10*10^-6 ;
E = 117;
Qex = @(x)c*E*(1-exp(-x/(R*c)));
derq = @(q)(E/R -q/(R*c));
Q = zeros(1,length(t));
Q(1)=0;

for i = 2:length(t)
    Q(i) = Q(i-1) + derq(Q(i-1))*h ;
end



% Plotting

plot(t,Q,'r','linewidth',2);
hold on
grid on
plot(t,Qex(t),'g','linewidth',2);
xlabel('x');
ylabel('y');
legend('Appoximate Q(t)','Actual Q(t)');



%% Excercise-03 [Improved Euler's Method]


clc
close
clear
format long

h =1/10;
x = (0:h:3);
efunc = @(x)(3*exp(-x/2)-2+x);
der = @(x,y)(x-y)/2 ;

y = zeros(1,length(x));
P = zeros(1,length(x));
y(1)=1;
P(1)= 1;
for i = 2:length(x)
    P(i) = y(i-1) + der(x(i-1),y(i-1))*h ;
    y(i) = y(i-1) + (der(x(i-1),y(i-1))+ der(x(i),P(i)))*h/2 ; 
end

ey = efunc(x);

% Plotting

plot(x,y,'r','linewidth',2);
hold on
grid on
plot(x,ey,'g','linewidth',2);
xlabel('x');
ylabel('y');
legend('Appoximate y(x)','Actual y(x)');

%% Excercise -04 

clc
clear
close
format long


h = 1/10;
t = (0:h:3);
R = 20000;
c = 10*10^-6 ;
E = 117;
Qex = @(x)c*E*(1-exp(-x/(R*c)));
derq = @(q)(E/R -q/(R*c));
Q = zeros(1,length(t));
P = zeros(1,length(t));
Q(1)=0;
P(1)=0;
for i = 2:length(t)
    P(i) = Q(i-1) + derq(Q(i-1))*h ;
    Q(i) = Q(i-1) + (derq(Q(i-1))+derq(P(i)))*h/2 ;
end



% Plotting

plot(t,Q,'r','linewidth',2);
hold on
grid on
plot(t,Qex(t),'g','linewidth',2);
xlabel('x');
ylabel('y');
legend('Appoximate Q(t)','Actual Q(t)');

%% Second order ODE

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

