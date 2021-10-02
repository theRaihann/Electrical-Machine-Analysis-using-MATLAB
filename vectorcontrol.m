function vectorcontrol( )

%Motor detalis (Rated)
P = 12*10^3; %power
V = 230;     %line voltage
Va = 230/sqrt(3) ; %phase voltage
fe = 50;        %frequency
We = 2*pi*fe;   %angular velocity
Lambda = sqrt(2)*Va/We;
I= P/(sqrt(3)*V) ; %line current
Ipeakbase = sqrt(2)*I; %peak value of current
poles=4 ;   %number of poles
%Paramteres for 50-Hz motor
VI0 = V/sqrt(3) ;
X10 = 0.68;
X20 = 0.678;
Xm0 = 18.70;
R1 = 0.095;
R2 = 0.2;
%d-q parameters
Lm = Xm0/We;
LS = Lm + X10/We;
LR = Lm + X20/We;
Ra = R1;
RaR = R2 ;
n=1;
% Operating point
Wm = 2*n*pi/60;
Wme = (poles/2)*Wm;
Pmech = 9.7*10-3;
Tmech = Pmech/Wm;
Te=zeros(1001,1);
for n = 1:1:41
    lambda_D_R = (0.8 + (n-1)*0.4/40)*Lambda;
    iQ(n) = (2/3) * (2/poles) * (LR/Lm) * (Tmech/lambda_D_R) ;
    iD(n) = (lambda_D_R/Lm) ;
    iQm(n) = - (Lm/LR)*iQ(n);
    Ia(n) =sqrt((iD(n)^2 + iQ(n)^2)/2) ;
    We(n) = Wme - (RaR/LR)*(iQ(n)/iD(n)) ;
    fe(n) = We(n)*poles/120 ;
    Varms(n) = sqrt( ((Ra*iD(n)-We(n)*(LS-Lm^2/LR)*iQ(n)) ^2 +(Ra*iQ(n)+ We(n)*LS*iD(n))^2) /2) ;
end
plot (Varms,iQ)
%axis([100 160 8 48]);
hold on;
plot(Varms,iD)
end