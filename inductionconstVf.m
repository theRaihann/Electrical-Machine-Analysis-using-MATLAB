function inductionconstVf()
v_phase1=input('Suppy Voltage (line to line): ');
f1=input('Enter the generally used frequency:');
f2=input('Enter the second frequency: ');
f3=input('Enter the third frequency: ');
f4=input('Enter the fourth frequency: ');
f5=input('Enter the fifth frequency: ');
Poles=input('Enter the number of poles: ');
r1=input('Stator Resistance: ');
r2=input('Rotor Resistance: ');
x1=input('Stator Leakage Reactance: ');
x2=input('Rotor Leakage Reactance: ');
Ls=x1/(2*pi*f1);
Lr=x2/(2*pi*f1);
Vlnf1=v_phase1/(3^0.5);
Vlnf2=Vlnf1*f2/f1;
Vlnf3=Vlnf1*f3/f1;
Vlnf4=Vlnf1*f4/f1;
Vlnf5=Vlnf1*f5/f1;
Wsync1=4*3.1416*f1/Poles;
Wsync2=4*3.1416*f2/Poles;
Wsync3=4*3.1416*f3/Poles;
Wsync4=4*3.1416*f4/Poles;
Wsync5=4*3.1416*f5/Poles;
Tmf2=zeros(round(Wsync2)*500+10,1);
Tmf3=zeros(round(Wsync3)*500+10,1);
Tmf4=zeros(round(Wsync4)*500+10,1);
Tmf5=zeros(round(Wsync5)*500+10,1);
Tmf1=zeros(round(Wsync1)*500+1,1);
m=1; 
for Wrotor1=0:0.002:Wsync1
    Tmf1(m)=(3*(((Vlnf1^2)*r2/((Wsync1-Wrotor1)/Wsync1))/((r1+r2/((Wsync1-Wrotor1)/Wsync1))^2+(2*pi*f1*Ls+2*pi*f1*Lr)^2))/Wsync1); %star connected
    m=m+1;
end
m=1;
for Wrotor2=0:0.002:Wsync2
    Tmf2(m)=(3*(((Vlnf2^2)*r2/((Wsync2-Wrotor2)/Wsync2))/((r1+r2/((Wsync2-Wrotor2)/Wsync2))^2+(2*pi*f2*Ls+2*pi*f2*Lr)^2))/Wsync2);
    m=m+1;
end
m=1;
for Wrotor3=0:0.002:Wsync3
   Tmf3(m)=(3*(((Vlnf3^2)*r2/((Wsync3-Wrotor3)/Wsync3))/((r1+r2/((Wsync3-Wrotor3)/Wsync3))^2+(2*pi*f3*Ls+2*pi*f3*Lr)^2))/Wsync3);
   m=m+1; 
end
m=1;
for Wrotor4=0:0.002:Wsync4
    Tmf4(m)=(3*(((Vlnf4^2)*r2/((Wsync4-Wrotor4)/Wsync4))/((r1+r2/((Wsync4-Wrotor4)/Wsync4))^2+(2*pi*f4*Ls+2*pi*f4*Lr)^2))/Wsync4);
    m=m+1; 
end
m=1;
for Wrotor5=0:0.002:Wsync5
    Tmf5(m)=(3*(((Vlnf5^2)*r2/((Wsync5-Wrotor5)/Wsync5))/((r1+r2/((Wsync5-Wrotor5)/Wsync5))^2+(2*pi*f5*Ls+2*pi*f5*Lr)^2))/Wsync5);
    m=m+1; 
end
plot(Tmf1);
hold on;
plot(Tmf2);
plot(Tmf3);
plot(Tmf4);
plot(Tmf5);
hold off;
ylabel('Torque(N-m)');
xlabel('Rotor Speed(Rad/s) * 100');
end

%%

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
            
            plot(app.UIAxes_3,nm1,t_ind1,'Color','r','LineWidth',2.0);
%             axis([0 2200 0 900]);
%             xlabel('\itn_{m}','Fontweight','Bold');
%             ylabel('\tau_{ind}','Fontweight','Bold');
%             title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
%             grid on;
            hold(app.UIAxes_3,"on");
            
            % v_phase2
            v_th = v_phase2 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );
            
            for ii = 1:length(s)
                t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
                    (w_sync2 * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
            end
            
            plot(app.UIAxes_3,nm2,t_ind1,'Color','g','LineWidth',2.0);
%             axis([0 2200 0 900]);
%             xlabel('\itn_{m}','Fontweight','Bold');
%             ylabel('\tau_{ind}','Fontweight','Bold');
%             title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
%             grid on;
%             hold on;
            % v_phase3
            v_th = v_phase3 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );
            
            for ii = 1:length(s)
                t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
                    (w_sync3 * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
            end
            
            plot(app.UIAxes_3,nm3,t_ind1,'Color','b','LineWidth',2.0);
%             axis([0 2200 0 900]);
%             xlabel('\itn_{m}','Fontweight','Bold');
%             ylabel('\tau_{ind}','Fontweight','Bold');
%             title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
%             grid on;
%             hold on;
            
            % v_phase4
            v_th = v_phase4 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );
            
            for ii = 1:length(s)
                t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
                    (w_sync4 * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
            end
            
            plot(app.UIAxes_3,nm4,t_ind1,'Color','k','LineWidth',2.0);
%             axis([0 2200 0 900]);
%             xlabel('\itn_{m}','Fontweight','Bold');
%             ylabel('\tau_{ind}','Fontweight','Bold');
%             title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
%             grid on;
%             hold on;
            
            % v_phase5
            v_th = v_phase5 * ( xm / sqrt(r1^2 + (x1 + xm)^2) );
            
            for ii = 1:length(s)
                t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
                    (w_sync5 * ((r_th + r2/s(ii))^2 + (x_th + x2)^2) );
            end
            
            plot(app.UIAxes_3,nm5,t_ind1,'Color','c','LineWidth',2.0);
%             axis([0 2200 0 900]);
%             xlabel('\itn_{m}','Fontweight','Bold');
%             ylabel('\tau_{ind}','Fontweight','Bold');
%             title ('Induction Motor Torque-Speed Characteristic','Fontweight','Bold');
%             grid on;
%             hold on;
              hold(app.UIAxes_3,'off');