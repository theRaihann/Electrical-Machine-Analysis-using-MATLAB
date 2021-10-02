function primary_secondary_impedances
s=input("Apparent Power:");
disp("Voltage Rating:")
v_rating=[input("High Side:") input("Low Side:")];
p_impedance=[input("Rc:") input("Xl:"); input("Rfe:") input("XM:")];
sec_load=input("Load impedance:");
sec_line=input("secondary line impedance:");

%Equivalent Circuit1
disp("EQ CIRCUIT-1: referred to primary");
a=v_rating(1)/v_rating(2);
Zeq_prim1 = p_impedance(1,1)+p_impedance(1,2) + a*a*sec_line + a*a*sec_load;
Zeq=(p_impedance(2,1)^(-1)+p_impedance(2,2)^(-1)+Zeq_prim1^(-1))^(-1);
Zequivalent = p_impedance(1,1)+p_impedance(1,2) + a*a*sec_line;
disp("Zequivalent referred to primary:");
disp(Zequivalent);
Ip = v_rating(1)/Zeq;
disp("Ip:");
disp(Ip);
I_hs=v_rating(1)/Zeq_prim1;
disp("I_hs:");
disp(I_hs);
I_fe = v_rating(1)/p_impedance(2,1);
disp("I_fe:");
disp(I_fe);
IM = v_rating(1)/p_impedance(2,2);
disp("IM:");
disp(IM);

%Equivalent Circuit2
disp("EQ CIRCUIT-2: referred to secondary");
A=a*a;
Zequivalent=p_impedance(1,1)/A+p_impedance(1,2)/A + sec_line;
disp("Zequivalent referred to secondary:");
disp(Zequivalent);
ip_a= a*Ip;
disp("ip_a:");
disp(ip_a);
i_fe=(a*v_rating(1))/p_impedance(2,1);
disp("i_fe:");
disp(i_fe);
iM = (a*v_rating(1))/p_impedance(2,2);
disp("iM:");
disp(iM);
Is = a*I_hs;
disp("Is:");
disp(Is);

%power factor
pf = cos(-angle(Is));
disp("pf:");
disp(pf);

%power rating
power_rating = s*pf;
disp("power_rating:");
disp(power_rating);

%power loss
power_loss = (abs(I_fe)^2)*p_impedance(2,1)+(abs(I_hs)^2)*(p_impedance(1,1)+A*real(sec_line));
disp("power_loss:");
disp(power_loss);

%efficiency
efficiency = power_rating/(power_rating + power_loss);
disp("efficiency:");
disp(efficiency);

%voltage regulation
v_regulation = (v_rating(2)-Is*sec_load)/v_rating(2);
disp("voltage regulation:");
disp(v_regulation);











