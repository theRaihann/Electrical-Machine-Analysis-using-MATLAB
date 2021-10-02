function variable_rotor_resistance
r1 = input("stator resistance:");                 % Stator resistance
x1 = input("Stator reactance:");                  % Stator reactance
x2 = input("Rotor reactance:");                   % Rotor reactance
xm = input("Magnetization branch reactance:");    % Magnetization branch reactance
v_phase = input("Applied line voltage:") / sqrt(3);    % Phase voltage
f=input("frequency:");
Poles=input("Poles:");

n_sync = 120*f/Poles;              % Synchronous speed (r/min)
w_sync = n_sync*2*pi/60;             % Synchronous speed (rad/s)

% Calculate the Thevenin voltage and impedance from Equations
% 7-41a and 7-43.
v_th = v_phase * ( xm / sqrt(r1^2 + (x1 + xm)^2) );
z_th = ((1i*xm) * (r1 + 1i*x1)) / (r1 + 1i*(x1 + xm));
r_th = real(z_th);
x_th = imag(z_th);
r2_max = sqrt(r_th^2+(x_th+x2)^2); %when S_max=1
r2=0:(r2_max/4):r2_max;
disp(r2);
    
    % Now calculate the torque-speed characteristic for many
    % slips between 0 and 1.  Note that the first slip value 
    % is set to 0.001 instead of exactly 0 to avoid divide-
    % by-zero problems.
     s = (0:.1:50) / 50;           % Slip
     s(1) = 0.001;
     nm = (1 - s) * n_sync;       % Mechanical speed rpm
     wm = (1-s) * w_sync;         % Mechanical speed rps
     

%when r2=r2(2)
    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2(2) / s(ii)) / ...
            (w_sync * ((r_th + r2(2)/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm,t_ind1,'Color','b','LineWidth',2.0);
    %axis([0 1850 0 800]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
    
%when r2=r2(3)
    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2(3) / s(ii)) / ...
            (w_sync * ((r_th + r2(3)/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm,t_ind1,'Color','g','LineWidth',2.0);
    %axis([0 1850 0 800]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
    
 %when r2=r2(4)
    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2(4) / s(ii)) / ...
            (w_sync * ((r_th + r2(4)/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm,t_ind1,'Color','r','LineWidth',2.0);
    %axis([0 1850 0 800]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
    
 %when r2=r2(5)
    for ii = 1:length(s)
        t_ind1(ii) = (3 * v_th^2 * r2(5) / s(ii)) / ...
            (w_sync * ((r_th + r2(5)/s(ii))^2 + (x_th + x2)^2) );
    end

    plot(nm,t_ind1,'Color','k','LineWidth',2.0);
    %axis([0 1850 0 800]);
    xlabel('\itn_{m}','Fontweight','Bold');
    ylabel('\tau_{ind}','Fontweight','Bold');
    title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
    grid on;
    hold on;
    
    legend('r2=.1744ohm','r2=.3489ohm','r2=.5233ohm','r2=.6977ohm');
    
