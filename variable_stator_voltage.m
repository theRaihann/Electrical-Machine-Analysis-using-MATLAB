function variable_stator_voltage
r1 = input("stator resistance:");                 % Stator resistance
x1 = input("Stator reactance:");                  % Stator reactance
r2 = input("Rotor resistance:");                  % Rotor resistance
x2 = input("Rotor reactance:");                   % Rotor reactance
xm = input("Magnetization branch reactance:");    % Magnetization branch reactance
v_phase1 = input("Testing line voltage1:") / sqrt(3);    % Phase voltage
v_phase2 = input("Testing line voltage2:") / sqrt(3);
v_phase3 = input("Testing line voltage3:") / sqrt(3);
v_phase4 = input("Testing line voltage4:") / sqrt(3);
v_phase5 = input("Testing line voltage5:") / sqrt(3);


f=input("frequency:");
Poles=input("Poles:");

n_sync = 120*f/Poles;              % Synchronous speed (r/min)
w_sync = n_sync*2*pi/60;             % Synchronous speed (rad/s)

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
     nm = (1 - s) * n_sync;       % Mechanical speed rpm
     wm = (1-s) * w_sync;         % Mechanical speed rps
     
% v_phase1
    
    v_th = v_phase1 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );

    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm,t_ind1,'Color','b','LineWidth',2.0);
    axis([0 1850 0 1800]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
    
 % v_phase2
    v_th = v_phase2 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );

    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm,t_ind1,'Color','g','LineWidth',2.0);
    axis([0 1850 0 1800]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
 % v_phase3
    v_th = v_phase3 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );

    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm,t_ind1,'Color','r','LineWidth',2.0);
    axis([0 1850 0 1800]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
    
  % v_phase4
    v_th = v_phase4 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );

    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm,t_ind1,'Color','k','LineWidth',2.0);
    axis([0 1850 0 1800]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
    
  % v_phase5
    v_th = v_phase5 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );

    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
            (w_sync * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm,t_ind1,'Color','c','LineWidth',2.0);
    axis([0 1850 0 1800]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
    
    legend('Vphase1','Vphase2','Vphase3','Vphase4','Vphase5');
