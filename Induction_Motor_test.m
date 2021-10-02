function Induction_Motor_test
%ckt values
f=input("Frequency:");
Poles=input("Number of Poles:");
design=input("Design(A/B/C/D):");
pattern=input("Supply Connection Wye(Y) or Delta(D):");

%DC test input
disp("DC test input:")
Vdc=input("Vdc:");
Idc=input("Idc:");

%Blocked Rotor test Data
disp("Blocked rotor test data:")

Ia_fl=input("Line current of phase A at full load:");   % Line current of phase A at full load
Ib_fl=input("Line current of phase B at full load:");   % Line current of phase B at full load
Ic_fl=input("Line current of phase C at full load:");   % Line current of phase C at full load
I2=(Ia_fl+Ib_fl+Ic_fl)/3;           % Average per phase current

% Full load Applied Voltage

VL_fl=input("Applied Voltage at Full load:");

Pin_fl=input("Full load input power:");                         % Full Load input Power

% No load Test Data
disp("No-load test data:")

%No load Currents
Ia_nl=input("Line current of phase A at no load:");    % Line current of phase A at no load
Ib_nl=input("Line current of phase B at no load:");   % Line current of phase B at no load
Ic_nl=input("Line current of phase C at no load:");   % Line current of phase C at no load
I1=(Ia_nl+Ib_nl+Ic_nl)/3;           % Average per phase current

%No load Applied Voltage
VL_nl=input("Applied Voltage at no load:");     

Pin_nl=input("Input power at no load:");                         % No Load input Power

%starting of Calculations

if pattern=="Y"
    %DC Test Calculation
    
    R1=Vdc/(2*Idc);  % Stator resistance
    disp(['Stator resistance         = R1   = ' num2str(R1) ' ohms']);
    
    %blocked-rotor test calculation
    
    Vfl=VL_fl/sqrt(3);                  % Full load phase voltage
    Zfl=Vfl/I2;                         % Full load equivalent impedence
    PFfl=Pin_fl/(sqrt(3)*VL_fl*I2);     % Full load power factor
    angle_fl=acos(PFfl)*180/pi;         % Full load Power factor Angle
    Rfl=Zfl*PFfl;                       % Full load equivalent resistance
    R2=Rfl-R1;                          % Rotor resistance
    Xfl_15=Zfl*sin(acos(PFfl));         % Full load equivalent raectance at 50Hz
    Xfl_60=(60/15)*Xfl_15;              %Full load equivalent reactance at 60Hz
    Zfl_c=Rfl+Xfl_60*1i;                 % Full load impedence in complex form
    if design=="A"
        X1=.5*Xfl_60;
        X2=.5*Xfl_60;
    elseif design=="B"
        X1=.4*Xfl_60;
        X2=.6*Xfl_60;
    elseif design=="C"
        X1=.3*Xfl_60;
        X2=.7*Xfl_60;
    else
        X1=.5*Xfl_60;
        X2=.5*Xfl_60; 
    end
    
    disp([' ']);
    disp(['Full load calculations for trasformer equivalent circuit'])
    disp(['--------------------------------------------------------'])
    disp(['Full laod Line Voltage   = VLfl = ' num2str(VL_fl) ' V']);
    disp(['Full load Phase Voltage  = Vfl  = ' num2str(Vfl) ' ohms'])
    disp(['Full laod Current        = I2   = ' num2str(I2) ' A']);
    disp(['Full laod Impedance      = Zfl  = ' num2str(Zfl) ' ohms']);
    disp(['Full load Power factor   = PFfl = ' num2str(PFfl) ' ']);
    disp(['Power factor angle       = phi  = ' num2str(angle_fl) ' degree']);
    disp(['Rotor resistance         = R2   = ' num2str(R2) ' ohms']);
    disp(['Approximate X1           = X1   = ' num2str(X1) ' ohms']);
    disp(['Approximate X2           = X2   = ' num2str(X2) ' ohms']);
    
    % Calculation using no-load test data
    Vp=VL_nl/sqrt(3);                   % Calculate phase voltage for per phase circuit
    Znl=Vp/I1;                          % No-load Impedance 
    P_scl=3*I1*I1*R1;                   % Stator copper losses
    P_rot=Pin_nl-P_scl;                 % Rotational Losses
    PF_nl=Pin_nl/(sqrt(3)*VL_nl*I1);    % No load power factor 
    angle_nl=acos(PF_nl)*180/pi;        % No load power factor angle in degrees
    angle_nl_r=acos(PF_nl);             % No load power factor angle in radians
    Im=I1*sin(angle_nl_r);              % Current through Xm 
    Ic=I1*PF_nl;                        % Current through Rc 
    Xm=Znl-X1;                          % value of magnetizing reactance
    Vm=Xm*Im;                           % Magnetizing branch voltage
    Rc=Vm/Ic;                           % Value of core resistance 
    Zm=(1i*Xm*Rc)/(1i*Xm+Rc);           % Magnitising branch impedance
    Rnl=Znl*PF_nl;                      % No load resistance from Znl and power factor
    Xnl=Znl*sin(angle_nl_r);            % No load reactance from Znl and power factor
    Znl_complex=Rnl+1i*Xnl;             % No load impedance in complex form
    
    disp(['No load calculations for trasformer equivalent circuit'])
    disp(['------------------------------------------------------'])
    disp(['Line to line voltage     = Vl   = ' num2str(VL_nl) ' V']);
    disp(['Phase Voltage at no load = Vp   = ' num2str(Vp) ' V']);
    disp(['No load Current          = I1   = ' num2str(I1) ' A']);
    disp(['No load Input Power Pin  = Pin  = ' num2str(Pin_nl) ' W']);
    disp(['No load Impedance Znl    = Znl  = ' num2str(Znl) ' ohms']);
    disp(['No Load power factor     = PFnl = ' num2str(PF_nl)]);
    disp(['Power factor angle       = phi  = ' num2str(angle_nl) ' degree']);
    %disp(['Magnitizing branch volt  = Vm   = ' num2str(Vm) ' V']);
    disp(['Current through Xm       = Im   = ' num2str(Im) ' A']);
    disp(['Current through Rc       = Ic   = ' num2str(Ic) ' A']);
    disp(['Magnitizing Reactance    = Xm   = ' num2str(Xm) ' ohms']);
    disp(['Core Resistance          = Rc   = ' num2str(Rc) ' ohms']);
    %disp(['Magnitizing Impedance    = Zm   = ' num2str(Zm) ' ohms']);
    disp(['Stator Copper Losses     = Pscl = ' num2str(P_scl) ' W']);
    disp(['Rotational Losses        = Prot = ' num2str(P_rot) ' W']);
    
    % Calculation of thevenin equivalent circuit parameters

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
    
    % Plotting torque speed characteristics
    s=1:-0.001:0;
    s(1001)=0.001;
    Nm=(1-s)*Ns;
    for ii=1:1000
    T_ind(ii)=(3*Vth^2*R2/s(ii))/(ws*((Rth+R2/s(ii))^2+(Xth+X2)^2));
    end
    T_ind(1001)=T_ind(1000);
    plot(Nm,T_ind);
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

else
    %for Delta Connection
    %DC Test Calculation
    R1=(3/2)*(Vdc/Idc); %for delta connection
    disp(['Stator resistance         = R1   = ' num2str(R1) ' ohms']);
    
    %blocked-rotor test calculation
    
    Vfl=VL_fl;                          % Full load phase voltage
    I2=I2/sqrt(3);                      % Phase Current
    Zfl=Vfl/I2;                         % Full load equivalent impedence
    PFfl=Pin_fl/(3*VL_fl*I2);           % Full load power factor
    angle_fl=acos(PFfl)*180/pi;         % Full load Power factor Angle
    Rfl=Zfl*PFfl;                       % Full load equivalent resistance
    R2=Rfl-R1;                          % Rotor resistance
    Xfl_15=Zfl*sin(acos(PFfl));         % Full load equivalent raectance at 50Hz
    Xfl_60=(60/15)*Xfl_15;              %Full load equivalent reactance at 60Hz
    Zfl_c=Rfl+Xfl_60*1i;                 % Full load impedence in complex form
    if design=="A"||"D"
        X1=.5*Xfl_60;
        X2=.5*Xfl_60;
    elseif design=="B"
        X1=.4*Xfl_60;
        X2=.6*Xfl_60;
    else
        X1=.3*Xfl_60;
        X2=.7*Xfl_60;
    end
    
    disp([' ']);
    disp(['Full load calculations for trasformer equivalent circuit'])
    disp(['--------------------------------------------------------'])
    disp(['Full laod Line Voltage   = VLfl = ' num2str(VL_fl) ' V']);
    disp(['Full load Phase Voltage  = Vfl  = ' num2str(Vfl) ' ohms'])
    disp(['Full laod Current        = I2   = ' num2str(I2) ' A']);
    disp(['Full laod Impedance      = Zfl  = ' num2str(Zfl) ' ohms']);
    disp(['Full load Power factor   = PFfl = ' num2str(PFfl) ' ']);
    disp(['Power factor angle       = phi  = ' num2str(angle_fl) ' degree']);
    disp(['Rotor resistance         = R2   = ' num2str(R2) ' ohms']);
    disp(['Approximate X1           = X1   = ' num2str(X1) ' ohms']);
    disp(['Approximate X2           = X2   = ' num2str(X2) ' ohms']);
    
    % Calculation using no-load test data
    Vp=VL_nl;                           % Calculate phase voltage for per phase circuit
    I1=I1/sqrt(3);                      % Phase Current
    Znl=Vp/I1;                          % No-load Impedance 
    P_scl=3*I1*I1*R1;                   % Stator copper losses
    P_rot=Pin_nl-P_scl;                 % Rotational Losses
    PF_nl=Pin_nl/(3*VL_nl*I1);    % No load power factor 
    angle_nl=acos(PF_nl)*180/pi;        % No load power factor angle in degrees
    angle_nl_r=acos(PF_nl);             % No load power factor angle in radians
    Im=I1*sin(angle_nl_r);              % Current through Xm 
    Ic=I1*PF_nl;                        % Current through Rc 
    Xm=Znl-X1;                          % value of magnetizing reactance
    Vm=Xm*Im;                           % Magnetizing branch voltage
    Rc=Vm/Ic;                           % Value of core resistance 
    Zm=(1i*Xm*Rc)/(1i*Xm+Rc);           % Magnitising branch impedance
    Rnl=Znl*PF_nl;                      % No load resistance from Znl and power factor
    Xnl=Znl*sin(angle_nl_r);            % No load reactance from Znl and power factor
    %Znl_complex=Rnl+1i*Xnl;             % No load impedance in complex form
    
    disp(['No load calculations for trasformer equivalent circuit'])
    disp(['------------------------------------------------------'])
    disp(['Line to line voltage     = Vl   = ' num2str(VL_nl) ' V']);
    disp(['Phase Voltage at no load = Vp   = ' num2str(Vp) ' V']);
    disp(['No load Current          = I1   = ' num2str(I1) ' A']);
    disp(['No load Input Power Pin  = Pin  = ' num2str(Pin_nl) ' W']);
    disp(['No load Impedance Znl    = Znl  = ' num2str(Znl) ' ohms']);
    disp(['No Load power factor     = PFnl = ' num2str(PF_nl)]);
    disp(['Power factor angle       = phi  = ' num2str(angle_nl) ' degree']);
    %disp(['Magnitizing branch volt  = Vm   = ' num2str(Vm) ' V']);
    disp(['Current through Xm       = Im   = ' num2str(Im) ' A']);
    disp(['Current through Rc       = Ic   = ' num2str(Ic) ' A']);
    disp(['Magnitizing Reactance    = Xm   = ' num2str(Xm) ' ohms']);
    disp(['Core Resistance          = Rc   = ' num2str(Rc) ' ohms']);
    %disp(['Magnitizing Impedance    = Zm   = ' num2str(Zm) ' ohms']);
    disp(['Stator Copper Losses     = Pscl = ' num2str(P_scl) ' W']);
    disp(['Rotational Losses        = Prot = ' num2str(P_rot) ' W']);
    
    % Calculation of thevenin equivalent circuit parameters

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
    
    % Plotting torque speed characteristics
    s=1:-0.001:0;
    s(1001)=0.001;
    Nm=(1-s)*Ns;
    for ii=1:1000
    T_ind(ii)=(3*Vth^2*R2/s(ii))/(ws*((Rth+R2/s(ii))^2+(Xth+X2)^2));
    end
    T_ind(1001)=T_ind(1000);
    plot(Nm,T_ind);
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
end


