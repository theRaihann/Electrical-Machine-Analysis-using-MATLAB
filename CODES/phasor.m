clc
close
clear

a = 100 + 200j;
a = a*0.3;
compass(a);
hold on;
b = -1-2j;
b = b/abs(b);
compass(b,'b');
c = 0.1 + 0.3j;
c = c/abs(c);
compass(c,'r');
legend('a','b','c');

%%
z=-2+3i; 
%z = z/abs(z);
quiver(0,0,real(z),imag(z),1);
hold on;
z2 = -5 - 3j;
%z2 = z2/abs(z2);
quiver(0,0,real(z2),imag(z2),1);

z3 = 0.03 + 0.06j;
%z3 = z3/abs(z3);
quiver(real(z2),imag(z2),real(z3),imag(z3),1,'r','Linewidth',2);

%%
a = 1+2j;
polarplot(a)

%%
clc
clear
close

Vs = 230;
Is = 52.14 - 39.15j ;
zs = 2.319 - 1.74j ; % Zs = Is * req
xs = 2.53 + 3.367j ; % xs = Is * xeq
Vp = 234.89 + 1.64j ;
quiver(0,0,real(Vp),imag(Vp),1,'g','MaxHeadSize',0.05,'Linewidth',2);
hold on;
quiver(0,0,real(Vs),imag(Vs),1,'r','MaxHeadSize',0.05,'Linewidth',2);
quiver(0,0,real(Is),imag(Is),1,'b','MaxHeadSize',0.1,'Linewidth',2);
quiver(real(Vs),imag(Vs),real(zs),imag(zs),1,'b','MaxHeadSize',1,'Linewidth',2);
quiver(real(zs+Vs),imag(zs+Vs),real(xs),imag(xs),1, 'r','MaxHeadSize',1,'Linewidth',2);

