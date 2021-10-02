function c
s=input("Apparent Power:");
disp("Voltage Rating:")
v_rating_p = input("primary side:");
v_rating_s = input("Secondary side:");
a = v_rating_p/v_rating_s;
n=input("if you want to give input w.r.t primary side then press 1, otherwise press 0:");
if n
    disp("With respect to Primary side:")
    Rfe = input("Rfe:");%coreloss resistance
    XM = input("XM:"); %mutual flux reactance
    Req = input("Req:");%copperloss equivalent resistance
    Xeq = input("Xeq:");%leakage flux euivalent reactance
    Zload_R = input("Zload_resistive component:");
    Zload_X = input("Zload_inductive component:");
    
    %Power Factor
    Z1 = Req + Xeq*1i + Zload_R + Zload_X*1i ; %equivalent resistance of Zload branch only
    I_load = v_rating_p/Z1;
    V_load = I_load*(Zload_R+Zload_X*1i);
    PF = cos(angle(V_load)-angle(I_load));
    fprintf("Power Factor: %f\n",PF);
    
    %Power loss
    P_loss1 = (abs(I_load)*2)*Req; %power loss due to copper
    P_loss2 = (v_rating_p*2)/Rfe; % power loss due to core
    p_loss = P_loss1 + P_loss2;
    fprintf("Power loss of the transformer: %f\n",p_loss);
    
    %Efficiency
    p_loss_load = (abs(I_load)*2)*Zload_R;
    ita = (p_loss_load/(p_loss+p_loss_load))*100;
    fprintf("Efficiency: %f\n",ita);
    
    %Power Rating
    Is = s/v_rating_s;
    p_rating = ((Is*2)*Zload_R)/a*2;%with respect to secondary and rated measurement
    fprintf("Power Rating: %f\n",p_rating);
    
    %voltage regulation
    
    VR = ((v_rating_s-abs(V_load/a))/abs(V_load/a))*100;
    fprintf("Voltage Regulation: %f\n",VR);
    
else
    disp("With respect to Secondary side:")
    Rfe = input("Rfe:");%coreloss resistance
    XM = input("XM:"); %mutual flux reactance
    Req = input("Req:");%copperloss equivalent resistance
    Xeq = input("Xeq:");%leakage flux euivalent reactance
    Zload_R = input("Zload_resistive component:");
    Zload_X = input("Zload_inductive component:");
    
    %Power Factor
    Z1 = Req + Xeq*1i + Zload_R + Zload_X*1i ; %equivalent resistance of Zload branch only
    I_load = v_rating_p/(a*Z1);
    V_load = I_load*(Zload_R+Zload_X*1i);
    PF = cos(angle(V_load)-angle(I_load));
    fprintf("Power Factor: %f",PF);
    fprintf("vload=%f",V_load);
    
    %Power loss
    P_loss1 = (abs(I_load)*2)*Req; %power loss due to copper
    P_loss2 = ((v_rating_p/a)*2)/Rfe; % power loss due to core
    p_loss = P_loss1 + P_loss2;
    fprintf("Power loss of the transformer: %f",p_loss);
    
    %Efficiency
    p_loss_load = (abs(I_load)*2)*Zload_R;
    ita = (p_loss_load/(p_loss+p_loss_load))*100;
    fprintf("Efficiency: %f",ita);
    
    %Power Rating
    Is = s/v_rating_s;
    p_rating = ((Is*2)*Zload_R);
    fprintf("Power Rating: %f",p_rating);
    
    %voltage regulation
    VR = ((v_rating_s-abs(V_load))/abs(V_load))*100;
    fprintf("Voltage Regulation: %f",VR);
    
end
