%% Equivalent Circuit of Induction Motor
%This file will find out all the parameters of an induction motor from the 
%open circuit test and blocked rotor test
% Syed Abdul Rahman Kashif
% Department of Electrical Engineering
% University of Engineering and Technology
% Lahore, Pakistan

clc;
clear;
close all;


%% Input Data
R1=3.5;                            % Stator resistance
f=50;                              % Frequency
Poles=4;                           % No. of poles
% No load Test Data

%No load Currents
Ia_nl=2.5;                          % Line current of phase A at no load
Ib_nl=2.5;                          % Line current of phase B at no load
Ic_nl=2.5;                          % Line current of phase C at no load
I1=(Ia_nl+Ib_nl+Ic_nl)/3;           % Average per phase current

%No load Applied Voltage
Vab_nl=230;                         % Line voltage V_ab at no load
Vbc_nl=230;                         % Line voltage V_bc at no load
Vca_nl=230;                         % Line voltage V_ca at no load
VL_nl=(Vab_nl+Vbc_nl+Vca_nl)/3;     % Average line to line voltage

Pin_nl=106;                         % No Load input Power

%Blocked Rotor test Data

Ia_fl=2.6;                          % Line current of phase A at full load
Ib_fl=2.6;                          % Line current of phase B at full load
Ic_fl=2.6;                          % Line current of phase C at full load
I2=(Ia_fl+Ib_fl+Ic_fl)/3;           % Average per phase current

% Full load Applied Voltage
Vab_fl=64;                         % Line voltage V_ab at full load
Vbc_fl=64;                         % Line voltage V_bc at full load
Vca_fl=64;                         % Line voltage V_ca at full load
VL_fl=(Vab_fl+Vbc_fl+Vca_fl)/3;    % Average line to line voltage

Pin_fl=169;                         % Full Load input Power

%% Calculation using no-load test data
Vp=VL_nl/sqrt(3);                   % Calculate phase voltage for per phase circuit
Znl=Vp/I1;                          % No-load Impedance = X1+Xm
P_scl=3*I1*I1*R1;                   % Stator copper losses
P_rot=Pin_nl-P_scl;                 % Rotational Losses
PF_nl=Pin_nl/(sqrt(3)*VL_nl*I1);    % No load power factor 
angle_nl=acos(PF_nl)*180/pi;        % No load power factor angle in degrees
angle_nl_r=acos(PF_nl);             % No load power factor angle in radians
Vm=Vp-I1*R1;                        % Voltage across Magnitising branch 
Im=I1*sin(angle_nl_r);              % Current through Xm
Ic=I1*PF_nl;                        % Current through Rc
Rc=Vm/Ic;                           % Value of core resistance
Xm=Vm/Im;                           % Value of magnetising reactance
Zm=(j*Xm*Rc)/(j*Xm+Rc);             % Magnitising branch impedance
Rnl=Znl*PF_nl;                      % No load resistance from Znl and power factor
Xnl=Znl*sin(angle_nl_r);            % No load reactance from Znl and power factor
Znl_complex=Rnl+j*Xnl;              % No load impedance in complex form
X1_a=Xnl-imag(Zm);                  % Calculation of Xm using imaginary part of Znl
X1=Znl-Xm;                          % Calculation of X1 using approximation i.e. Znl=X1+Xm

disp(['No load calculations for trasformer equivalent circuit'])
disp(['------------------------------------------------------'])
disp(['Sator Resistance         = R1   = ' num2str(R1) ' ohm'])
disp(['Line to line voltage     = Vl   = ' num2str(VL_nl) ' V']);
disp(['No load Current          = I1   = ' num2str(I1) ' A']);
disp(['No load Input Power Pin  = Pin  = ' num2str(Pin_nl) ' W'])
disp(['Phase Voltage at no load = Vp   = ' num2str(Vp) ' V']);
disp(['No load Impedance Znl    = Znl  = ' num2str(Znl) ' ohms']);
disp(['No Load power factor     = PFnl = ' num2str(PF_nl)]);
disp(['Power factor angle       = phi  = ' num2str(angle_nl) ' degree']);
disp(['Magnitizing branch volt  = Vm   = ' num2str(Vm) ' V']);
disp(['Current through Xm       = Im   = ' num2str(Im) ' A']);
disp(['Current through Rc       = Ic   = ' num2str(Ic) ' A']);
disp(['Magnitizing Reactance    = Xm   = ' num2str(Xm) ' ohms']);
disp(['Core Resistance          = Rc   = ' num2str(Rc) ' ohms']);
disp(['Magnitizing Impedance    = Zm   = ' num2str(Zm) ' ohms']);
disp(['Approximate Reactance    = X1   = ' num2str(X1) ' ohms'])
disp(['Stator Copper Losses     = Pscl = ' num2str(P_scl) ' W']);
disp(['Rotational Losses        = Prot = ' num2str(P_rot) ' W']);

%% Calculation from blocked rotor test

Vfl=VL_fl/sqrt(3);                  % Full load phase voltage
R2=(Pin_fl-3*I2*I2*R1)/(3*I2*I2);   % Calculating R2 from copper losses
Zfl=Vfl/I2;                         % Full load equivalent impedence
PFfl=Pin_fl/(sqrt(3)*VL_fl*I2);     % Full load power factor
angle_fl=acos(PFfl)*180/pi;         % Full load Power factor Angle
Rfl=Zfl*PFfl;                       % Full load equivalent resistance
Xfl=Zfl*sin(acos(PFfl));            % Full load equivalent raectance
Zfl_c=Rfl+Xfl*j;                    % Full load impedence in complex form
X2=sqrt(Zfl*Zfl-(R1+R2)^2)-X1;      % Calculation of X2
 
disp([' ']);
disp(['Full load calculations for trasformer equivalent circuit'])
disp(['--------------------------------------------------------'])
disp(['Full laod Line Voltage   = VLfl = ' num2str(VL_fl) ' V']);
disp(['Full load Phase Voltage  = Vfl  = ' num2str(Vfl) ' ohms'])
disp(['Full laod Current        = I2   = ' num2str(I2) ' A']);
disp(['Full laod Impedance      = Zfl  = ' num2str(Zfl) ' ohms']);
disp(['Full load Power          = Pfl  = ' num2str(Pin_fl) ' W'])
disp(['Full load Power factor   = PFfl = ' num2str(PFfl) ' '])
disp(['Power factor angle       = phi  = ' num2str(angle_fl) ' degree']);
disp(['Full load Imedance       = Zfl  = ' num2str(Zfl_c) ' ohm']);
disp(['Rotor resistance         = R2   = ' num2str(R2) ' ohms']);
disp(['Approximate X2           = X2   = ' num2str(X2) ' ohms'])

%% Calculation of thevenin equivalent circuit parameters

Vth=(Xm/(X1+Xm))*Vp;        % calculating thevenin equivalent voltage
Rth=(Xm/(X1+Xm))^2*R1;      % calculation of thevenin resistance
Xth=X1;                     % calculation of thevenin reactance
Ns=120*f/Poles;             % calculation of synchronous frequency
ws=Ns*2*pi/60;              % converting 'rpm' into 'rad/sec'

Tstart=(3*Vth^2*R2)/(ws*((Rth+R2)^2+(Xth+X2)^2));     % Caculating starting torque of motor
Smax=R2/sqrt(Rth^2+(Xth+X2)^2);                       % Slip for maximum torque
Tmax=(3*Vth^2)/(2*ws*(Rth+sqrt(Rth^2+(Xth+X2)^2)));   % Calulating maximum torque 

disp([' ']);
disp(['Thevenin Calculation from Induction motor equivalent cicuit'])
disp(['-----------------------------------------------------------'])
disp(['Thevenin Voltage         = Vth  = ' num2str(Vth) ' V'])
disp(['Thevenin Resistance      = Rth  = ' num2str(Rth) ' ohms'])
disp(['Thevenin Reactance       = Xth  = ' num2str(Xth) ' ohms'])

disp([' ']);
disp(['Calculation of starting and pull-out torque '])
disp(['-------------------------------------------'])
disp(['Rated frequency          = f    = ' num2str(f) ' Hz'])
disp(['No. of poles             = P    = ' num2str(Poles) ' '])
disp(['Synchronous speed        = Ns   = ' num2str(Ns) ' rpm'])
disp(['Synchronous speed        = Ws   = ' num2str(ws) ' rad/sec'])
disp(['Starting Torque, Tstart  = Ts   = ' num2str(Tstart) ' N.m'])
disp(['Slip for Tmax            = Sm   = ' num2str(Smax) ' '])
disp(['Maximum Torque, Tmax     = Tm   = ' num2str(Tmax) ' N.m'])

%% Plotting torque speed characteristics
s=1:-0.001:0;
s(1001)=0.001;
Nm=(1-s)*Ns;
for ii=1:1000
Tind(ii)=(3*Vth^2*R2/s(ii))/(ws*((Rth+R2/s(ii))^2+(Xth+X2)^2));
end
Tind(1001)=Tind(1000);
plot(Nm,Tind);
axis([0,Ns,0,Tmax+1]);
xlabel('Rotor Speed (rpm)');
ylabel('Torque induced N.m');
title('Torque speed curve of induction motor');
Nmax=(1-Smax)*Ns;
x=[Nmax, Nmax];
y=[0,Tmax];
hold on;
line(x,y,'Color','r','LineStyle',':','LineWidth',1)
text(Nmax,Tmax+0.35,'Pull out Torque');
plot(Nmax,Tmax,'Marker','o')
text(Nmax+10,0.35,'Smax')
plot(Nmax,0,'Marker','o')
text(15,Tstart-0.25,'Starting Torque');
plot(0,Tstart,'Marker','o')
