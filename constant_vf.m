function constant_vf
r1 = input("stator resistance:");                 % Stator resistance
x1 = input("Stator reactance:");                  % Stator reactance
r2 = input("Rotor resistance:");                  % Rotor resistance
x2 = input("Rotor reactance:");                   % Rotor reactance
xm = input("Magnetization branch reactance:");    % Magnetization branch reactance
v_phase1 = input("Applied line voltage:") / sqrt(3);    % Phase voltage

f1=input("Enter generally used frequency:");
f2=input("Enter second frequency:");
f3=input("Enter third frequency:");
f4=input("Enter fourth frequency:");
f5=input("Enter fifth frequency:");
Poles=input("Poles:");

v_phase2=v_phase1*f2/f1;
v_phase3=v_phase1*f3/f1;
v_phase4=v_phase1*f4/f1;
v_phase5=v_phase1*f5/f1;

n_sync1 = 120*f1/Poles;              % Synchronous speed (r/min)
n_sync2 = 120*f2/Poles;
n_sync3 = 120*f3/Poles;
n_sync4 = 120*f4/Poles;
n_sync5 = 120*f5/Poles;

w_sync1 = n_sync1*2*pi/60;             % Synchronous speed (rad/s)
w_sync2 = n_sync2*2*pi/60;
w_sync3 = n_sync3*2*pi/60;
w_sync4 = n_sync4*2*pi/60;
w_sync5 = n_sync5*2*pi/60;

% Calculate the Thevenin voltage and impedance from Equations
% 7-41a and 7-43.

z_th = ((1i*xm) * (r1 + 1i*x1)) / (r1 + 1i*(x1 + xm));
r_th = real(z_th);
x_th = imag(z_th);
 
    % Now calculate the torque-speed characteristic for many
    % slips between 0 and 1.  Note that the first slip value 
    % is set to 0.001 instead of exactly 0 to avoid divide-
    % by-zero problems.
     s = (0:.1:50) / 50;           % Slip
     s(1) = 0.001;
     nm1 = (1 - s) * n_sync1;       % Mechanical speed rpm
     nm2 = (1 - s) * n_sync2;
     nm3 = (1 - s) * n_sync3;
     nm4 = (1 - s) * n_sync4;
     nm5 = (1 - s) * n_sync5;
     
     wm1 = (1-s) * w_sync1;         % Mechanical speed rps
     wm2 = (1-s) * w_sync2;
     wm3 = (1-s) * w_sync3;
     wm4 = (1-s) * w_sync4;
     wm5 = (1-s) * w_sync5;
     
% v_phase1
    
    v_th = v_phase1 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );

    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync1 * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm1,t_ind1,'Color','b','LineWidth',2.0);
    axis([0 2200 0 900]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
    
 % v_phase2
    v_th = v_phase2 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );

    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync2 * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm2,t_ind1,'Color','g','LineWidth',2.0);
    axis([0 2200 0 900]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
 % v_phase3
    v_th = v_phase3 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );

    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync3 * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm3,t_ind1,'Color','r','LineWidth',2.0);
    axis([0 2200 0 900]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
    
  % v_phase4
    v_th = v_phase4 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );

    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync4 * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm4,t_ind1,'Color','k','LineWidth',2.0);
    axis([0 2200 0 900]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
    
  % v_phase5
    v_th = v_phase5 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );

    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync5 * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm5,t_ind1,'Color','c','LineWidth',2.0);
    axis([0 2200 0 900]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
    
    legend('fgeneral','f2','f3','f4','f5');