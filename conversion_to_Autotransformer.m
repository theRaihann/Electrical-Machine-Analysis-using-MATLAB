function conversion_to_Autotransformer
disp("Conversion to Autotransformer");
s=input("Apparent Power:");
disp("Voltage Rating of the Two winding transformer:");
V_P=input("Rated voltage of Primary side:");
V_S=input("Rated Voltage of Secondary side:");
pf=input("Power of the two winding transformer:");
n=input("Efficiency in percentage:");
n=n/100;
volt_regulation=input("Voltage regulation:");
if V_P>V_S
    disp("Step-Down:")
    disp("Configuration 1:");%when V_P is in common 
    
    k1=V_P/(V_P+V_S);
    fprintf("Transformation Ratio:%.2f\n",k1);
    
    e_copper=k1*100;
    fprintf("Economy in Copper:%.2f\n",e_copper);
    
    S_auto=((V_S+V_P)/V_S)*s;%apparent power of autotransformer
    fprintf("Apparent Power Rating:%.2f\n",S_auto);
    
    Rating_advantage=S_auto/s;
    fprintf("Rating Advantage of the Autotransformer:%.2f\n",Rating_advantage);
    
    V1=V_P+V_S;
    fprintf("Primary voltage of autotransformer:%.2f",V1);
    
    V2=V1*k1;
    fprintf("Secondary voltage of autotransformer:%.2f\n",V2);
    
    Is=(s/V_P)/(1-k1);%secondary current
    fprintf("Load Current:%.2f\n",Is);
    
    Ip=k1*Is;%primary current
    fprintf("supplied Current:%.2f\n",Ip);
    
    Ibc=Is-Ip;
    fprintf("Ibc=%.2f\n",Ibc);
    
    trans_power=(1-k1)*S_auto;
    fprintf("Power transformed:%.2f\n",trans_power);
    
    conduct_power=k1*S_auto;
    fprintf("Power Conducted:%.2f\n",conduct_power);
    
    power_loss=((1/n)-1)*s*pf;
    fprintf("Power loss:%.2f\n",power_loss);
    
    efficiency=(S_auto/(S_auto+power_loss))*100;
    fprintf("Efficiency:%.f\n",efficiency);
    
    regulation=(1-k1)*volt_regulation;
    fprintf("Voltage regulation:%.2f\n",regulation);
    
    %configuration 2
    
    disp("Configuration 2:"); %when V_S is in common 
    
    k2=V_S/(V_P+V_S);
    fprintf("Transformation Ratio:%.2f\n",k2);
    
    e_copper=k2*100;
    fprintf("Economy in Copper:%.2f\n",e_copper);
    
    S_auto=((V_S+V_P)/V_P)*s;%apparent power of autotransformer
    fprintf("Apparent Power Rating:%,2f\n",S_auto);
    
    Rating_advantage=S_auto/s;
    fprintf("Rating Advantage of the Autotransformer:%.2f\n",Rating_advantage);
    
    V1=V_P+V_S;
    fprintf("Primary voltage of autotransformer:%.2f",V1);
    
    V2=V1*k2;
    fprintf("Secondary voltage of autotransformer:%.2f\n",V2);
    
    Is2=(s/V_S)/(1-k2);%secondary current
    fprintf("Load Current:%.2f\n",Is2);
    
    Ip2=k2*Is2;%primary current
    fprintf("supplied Current:%.2f\n",Ip2);
    
    Ibc2=Is2-Ip2;
    fprintf("Ibc=%.2f\n",Ibc2);
    
    trans_power=(1-k2)*S_auto;
    fprintf("Power transformed:%.2f\n",trans_power);
    
    conduct_power=k2*S_auto;
    fprintf("Power Conducted:%.2f\n",conduct_power);
    
     power_loss=((1/n)-1)*s*pf;
    fprintf("Power loss:%.2f\n",power_loss);
    
    efficiency=(S_auto/(S_auto+power_loss))*100;
    fprintf("Efficiency:%.f\n",efficiency);
    
    regulation=(1-k2)*volt_regulation;
    fprintf("Voltage regulation:%.2f\n",regulation);
else
    disp("Step-Up:")
    disp("Configuration 1:");%when V_P is in common 
    
    k1=(V_P+V_S)/V_P;
    fprintf("Transformation Ratio:%.2f\n",k1);
    
    %e_copper=k1*100;
    %fprintf("Economy in Copper:%f\n",e_copper);
    
    S_auto=((V_S+V_P)/V_S)*s;%apparent power of autotransformer
    fprintf("Apparent Power Rating:%.2f\n",S_auto);
    
    Rating_advantage=S_auto/s;
    fprintf("Rating Advantage of the Autotransformer:%.2f\n",Rating_advantage);
    
    V1=V_P;
    fprintf("Primary voltage of autotransformer:%.2f\n",V1);
    
    V2=V_P+V_S;
    fprintf("Secondary voltage of autotransformer:%.2f\n",V2);
    
    Is=(s/V_P)/(k1-1);%secondary current
    fprintf("Load Current:%.2f\n",Is);
    
    Ip=k1*Is;%primary current
    fprintf("supplied Current:%.2f\n",Ip);
    
    Ibc=Ip-Is;
    fprintf("Ibc=%.2f\n",Ibc);
    
    trans_power=V_S*Is;
    fprintf("Power transformed:%.2f\n",trans_power);
    
    conduct_power=S_auto-trans_power;
    fprintf("Power Conducted:%.2f\n",conduct_power);
    
     power_loss=((1/n)-1)*s*pf;
    fprintf("Power loss:%.2f\n",power_loss);
    
    efficiency=(S_auto/(S_auto+power_loss))*100;
    fprintf("Efficiency:%.f\n",efficiency);
    
    regulation=(1-(1/k1))*volt_regulation;
    fprintf("Voltage regulation:%.2f\n",regulation);
    
    %configuration 2
    
    disp("Configuration 2:");%when V_S is in common 
    
    k2=(V_P+V_S)/V_S;
    fprintf("Transformation Ratio:%.2f\n",k2);
    
    %e_copper=k2*100;
    %fprintf("Economy in Copper:%f\n",e_copper);
    
    S_auto=((V_S+V_P)/V_P)*s;%apparent power of autotransformer
    fprintf("Apparent Power Rating:%.2f\n",S_auto);
    
    Rating_advantage=S_auto/s;
    fprintf("Rating Advantage of the Autotransformer:%.2f\n",Rating_advantage);
    
    V1=V_S;
    fprintf("Primary voltage of autotransformer:%.2f\n",V1);
    
    V2=V_P+V_S;
    fprintf("Secondary voltage of autotransformer:%.2f\n",V2);
    
    Is=(s/V_S)/(k2-1);%secondary current
    fprintf("Load Current:%.2f\n",Is);
    
    Ip=k2*Is;%primary current
    fprintf("supplied Current:%.2f\n",Ip);
    
    Ibc=Ip-Is;
    fprintf("Ibc=%.2f\n",Ibc);
    
    trans_power=V_P*Is;
    fprintf("Power transformed:%.2f\n",trans_power);
    
    conduct_power=S_auto-trans_power;
    fprintf("Power Conducted:%.2f\n",conduct_power);
    
     power_loss=((1/n)-1)*s*pf;
    fprintf("Power loss:%.2f\n",power_loss);
    
    efficiency=(S_auto/(S_auto+power_loss))*100;
    fprintf("Efficiency:%.2f\n",efficiency);
    
    regulation=(1-(1/k2))*volt_regulation;
    fprintf("Voltage regulation:%.2f\n",regulation);
    
    
end
    
    
    
    
    

