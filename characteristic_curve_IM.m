function characteristic_curve_IM
r1 = input("stator resistance:");                 % Stator resistance
x1 = input("Stator reactance:");                  % Stator reactance
r2 = input("Rotor resistance:");                  % Rotor resistance
x2 = input("Rotor reactance:");                   % Rotor reactance
xm = input("Magnetization branch reactance:");    % Magnetization branch reactance
v_phase = input("Applied line voltage:") / sqrt(3);    % Phase voltage
f=input("frequency:");
Poles=input("Poles:");
disp("Losses:");
disp("If you dont have losses data, enter 0");
p_fw = input("friction and windage losses, p_fw:");
p_core =input("Core losses:");
p_misc = input("P_misc(other losses):");

n_sync = 120*f/Poles;              % Synchronous speed (r/min)
w_sync = n_sync*2*pi/60;             % Synchronous speed (rad/s)

% Calculate the Thevenin voltage and impedance from Equations
% 7-41a and 7-43.
v_th = v_phase * ( xm / sqrt(r1^2 + (x1 + xm)^2) );
z_th = ((1i*xm) * (r1 + 1i*x1)) / (r1 + 1i*(x1 + xm));
r_th = real(z_th);
x_th = imag(z_th);

Tstart=(3*v_th^2*r2)/(w_sync*((r_th+r2)^2+(x_th+x2)^2));     % Caculating starting torque of motor
Smax=r2/sqrt(r_th^2+(x_th+x2)^2);                            % Slip for maximum torque
Tmax=(3*v_th^2)/(2*w_sync*(r_th+sqrt(r_th^2+(x_th+x2)^2)));  % Calulating maximum torque 
nm_max=(1-Smax)*n_sync;                                      % rotor speed for maximum torque

    disp([' ']);
    disp(['Thevenin Calculation from Induction motor equivalent cicuit'])
    disp(['-----------------------------------------------------------'])
    disp(['Thevenin Voltage         = Vth  = ' num2str(v_th) ' V'])
    disp(['Thevenin Resistance      = Rth  = ' num2str(r_th) ' ohms'])
    disp(['Thevenin Reactance       = Xth  = ' num2str(x_th) ' ohms'])

    disp([' ']);
    disp(['Calculation of starting and pull-out torque '])
    disp(['-------------------------------------------'])
    disp(['Rated frequency          = f    = ' num2str(f) ' Hz'])
    disp(['No. of poles             = P    = ' num2str(Poles) ' '])
    disp(['Synchronous speed        = Ns   = ' num2str(n_sync) ' rpm'])
    disp(['Synchronous speed        = Ws   = ' num2str(w_sync) ' rad/sec'])
    disp(['Starting Torque, Tstart  = Ts   = ' num2str(Tstart) ' N.m'])
    disp(['Slip for Tmax            = Sm   = ' num2str(Smax) ' '])
    disp(['Maximum Torque, Tmax     = Tm   = ' num2str(Tmax) ' N.m'])
    disp(['Rotor speed for maximum torque, nm_max     = nm_max   = ' num2str(nm_max) ' rpm'])

% Now calculate the torque-speed characteristic for many
% slips between 0 and 1.  Note that the first slip value 
% is set to 0.001 instead of exactly 0 to avoid divide-
% by-zero problems.
s = (0:.1:50) / 50;           % Slip
s(1) = 0.001;
nm = (1 - s) * n_sync;       % Mechanical speed rpm
wm = (1-s) * w_sync;         % Mechanical speed rps

% Calculate torque for original rotor resistance
for ii = 1:length(s)
    %torque speed characteristics
   t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
   
   %Power converted     
   p_conv(ii) = t_ind1(ii) * wm(ii);
   
   %Power output
   p_out(ii) = p_conv(ii) - p_fw - p_core - p_misc;
   
   %Power input
   zf = 1 / ( 1/(1i*xm) + 1/(r2/s(ii)+1i*x2) );
   ia = v_phase / ( r1 + 1i*x1 + zf ); 
   p_in(ii) = 3 * v_phase * abs(ia) * cos(atan(imag(ia)/real(ia)));
   
   % Efficiency
   eff(ii) = p_out(ii) / p_in(ii) * 100; 

end

% Plot the torque-speed curve
figure(1)
plot(nm,t_ind1,'Color','k','LineWidth',2.0);
xlabel('\itn_{m}','Fontweight','Bold');
ylabel('\tau_{ind}','Fontweight','Bold');
title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
grid on;
% Output power Vs speed graph
figure(2)
plot(nm,p_conv/1000,'b-','LineWidth',2.0);
xlabel('\bf\itn_{m} \rm\bf(r/min)');
ylabel('\bf\itP\rm\bf_{CONV} (kW)');
title ('\bf Power Converted versus Speed');
grid on;

%plot output power versus speed
figure(3)
plot(nm,p_out/1000,'b-','LineWidth',2.0);
xlabel('\bf\itn_{m} \rm\bf(r/min)');
ylabel('\bf\itP\rm\bf_{out} (kW)');
title ('\bf Output Power versus Speed');
grid on;

%plot the efficiency
figure(4)
plot(nm,eff,'b-','LineWidth',2.0);
xlabel('\bf\itn_{m} \rm\bf(r/min)');
ylabel('\bf\eta (%)');
title ('\bf Efficiency versus Speed');
grid on;

end


 

