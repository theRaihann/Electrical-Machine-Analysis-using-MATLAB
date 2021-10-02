function inductionconstVfclosed()
Vratedph=input("Applied phase voltage:");
P=input("Number of poles:");
Rs=input("Stator resistance:");
Rr=input("Rotor Resistance:");
Xs=input("Stator reactance:");
Xr=input("Rotor Reactance:");

Tmm=[];
Wrotormat=[];
Ls=Xs/(2*pi*50);
Lr=Xr/(2*pi*50);
Vfratio=Vratedph/200; %Constant V/f ratio = Rated Voltage/Maximum frequency that is applied (taken as 200 Hz)
%Find the value of Frequency at which the motot shall be started so that the given operating point (Tlstarting,Wref) lies in the stable zone
Tlstarting=input("Enter starting torque:");
Wref=input("Enter reference speed of rotor in rpm unit:");

if Tlstarting==0
 
     w_sync=Wref;
     f=w_sync*P/120;
     V=Vfratio*f;
     
else
     for f=1:0.001:200
 
         w_sync=120*f/P;
         s=(w_sync-Wref)/w_sync;
         sm=(Rr/((Rs^2+(2*pi*f*Ls+2*pi*f*Lr)^2)^0.5));
 
             if Wref<w_sync && s<sm %to make sure that the operating point lies in the stable zone
                   f=f;
                   V=Vfratio*f;
 
                   if Tlstarting>=(0.95*(3*(((V^2)*Rr/((w_sync-Wref)/w_sync))/((Rs+Rr/((w_sync-Wref)/w_sync))^2+(2*pi*f*Ls+2*pi*f*Lr)^2))/w_sync)) && Tlstarting<=(1.05*(3*(((V^2)*Rr/((w_sync-Wref)/w_sync))/((Rs+Rr/((w_sync-Wref)/w_sync))^2+(2*pi*f*Ls+2*pi*f*Lr)^2))/w_sync))
                          break; 
                   end
             end
      end
end
Tm=zeros(100001,1);
Wrot=zeros(100001,1);
m=1;
%Store the values of torque at different rotor speeds to plot the TorqueSpeed characteristics
 
for Wrotor=0:w_sync/100000:w_sync
    Tm(m)=(3*(((V^2)*Rr/((w_sync-Wrotor)/w_sync))/((Rs+Rr/((w_sync-Wrotor)/w_sync))^2+(2*pi*f*Ls+2*pi*f*Lr)^2))/w_sync);
    if Tm(m)<0
        Tm(m)=0;
    end
    Wrot(m)=Wrotor;
    m=m+1;
end
Tmax=(3*(V^2/(Rs+(Rs^2+(2*pi*f*Ls+2*pi*f*Lr)^2)^0.5))/(2*w_sync)); % Maximum Torque the given motor can deliver for the current values of V and f
% Vary the Load Torque From 0.1 to Tmax with a step of Tmax/10 and apply the closed loop P control to maintain the motor speed at Wref for any permissible values of load torque
for Tl=0.1:Tmax/10:Tmax
 
    Tmm=[Tmm Tm];
    Wrotormat=[Wrotormat Wrot];
        for a=100001:-1:1
 
            if (Tm(a)*0.95)<=Tl && Tl<=(Tm(a)*1.05)
                 W=Wrot(a); 
                 break;
            end
        end
 
        Werror=Wref-W; % Error in speed to be corrected
        n=1;
 
        f=f+(Werror*P/120); % The frequency and hence the Speed Corrected Proportionately (ie P controller used)
 
       w_sync=120*f/P;
 
       V=Vfratio*f;
 
 % Store the values of torque at different rotor speeds to plot the TorqueSpeed characteristics 
      for Wrotor=0:w_sync/100000:w_sync
 
          Tm(n)=(3*(((V^2)*Rr/((w_sync-Wrotor)/w_sync))/((Rs+Rr/((w_sync-Wrotor)/w_sync))^2+(2*pi*f*Ls+2*pi*f*Lr)^2))/w_sync); %Star connected
                if Tm(n)<0
                     Tm(n)=0;
                end
           Wrot(n)=Wrotor;
           n=n+1;
      end
end
 
[c,d]=size(Tmm);
[e,h]=size(Wrotormat);
figure;
% Plot the Torque-Speed Characteristics of the motor for various values of Load Torque
hold on;
for g=1:1:d
    plot(Wrotormat(:,g),Tmm(:,g));
end
hold off;
end