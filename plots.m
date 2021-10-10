%%For Voltage%%
 clc;
 clear all;
 close all;
 case_name ='case118';
 data_size = 800;
 
 model ='OLS';
 address= ['train_data/' case_name '/' num2str(data_size) '/' model  '/result/'];
 %If you want to load scaled data
 data.V = readtable([address 'V.csv']);
 data.Va = readtable([address 'Va.csv']);
 data.V_pred = readtable([address 'V_pred.csv']);
 data.Va_pred = readtable([address 'Va_pred.csv']);
 data.P = readtable([address 'P.csv']);
 data.Q = readtable([address 'Q.csv']);
 data.I = readtable([address 'I.csv']);
 data.Ia = readtable([address 'Ia.csv']);
 data.I_pred = readtable([address 'I_pred.csv']);
 data.Ia_pred = readtable([address 'Ia_pred.csv']);
 
P = data.P;
Q = data.Q;
V = data.V;
Va = data.Va;
V_pred = data.V_pred;
Va_pred = data.Va_pred;

I = data.I;
Ia = data.Ia;
I_pred = data.I_pred;
Ia_pred = data.Ia_pred;

P= table2array(P); 
Q= table2array(Q); 
I= table2array(I); 
Ia= table2array(Ia); 
I_pred= table2array(I_pred); 
Ia_pred= table2array(Ia_pred); 
V= table2array(V); 
Va= table2array(Va); 
V_pred= table2array(V_pred); 
Va_pred= table2array(Va_pred);

 


i=1:118;  
figure(1);
plot(i,V(1,:),'r-o','MarkerSize',5)
hold on
plot(i,V_pred(1,:),'b-s')
xlabel('Bus Number','FontSize', 32) 
ylabel('Voltage Magnitude(pu)','FontSize', 32) 
%legend('V_{actual}','V_{predicted}')
title('Actual V/s Predicted ','FontSize', 32)
%legend('OLS','color','b')
%%For Angle%%

i=1:118;  
figure(2);
plot(i,Va(1,:),'r-o')
hold on
plot(i,Va_pred(1,:),'b-s')
xlabel('Bus Number','FontSize', 32) 
ylabel('Voltage angle(rad)','FontSize', 32) 
%legend('Va_{actual}','Va_{predicted}')
title('Actual V/s Predicted  ','FontSize', 32)
%legend('OLS','color','b')

 model ='RSIMPLS';
 address= ['train_data/' case_name '/' num2str(data_size) '/' model  '/result/'];
 %If you want to load scaled data
 data.V = readtable([address 'V.csv']);
 data.Va = readtable([address 'Va.csv']);
 data.V_pred = readtable([address 'V_pred.csv']);
 data.Va_pred = readtable([address 'Va_pred.csv']);
 data.P = readtable([address 'P.csv']);
 data.Q = readtable([address 'Q.csv']);
 data.I = readtable([address 'I.csv']);
 data.Ia = readtable([address 'Ia.csv']);
 data.I_pred = readtable([address 'I_pred.csv']);
 data.Ia_pred = readtable([address 'Ia_pred.csv']);
 
P = data.P;
Q = data.Q;
V = data.V;
Va = data.Va;
V_pred = data.V_pred;
Va_pred = data.Va_pred;

I = data.I;
Ia = data.Ia;
I_pred = data.I_pred;
Ia_pred = data.Ia_pred;

P= table2array(P); 
Q= table2array(Q); 
I= table2array(I); 
Ia= table2array(Ia); 
I_pred= table2array(I_pred); 
Ia_pred= table2array(Ia_pred); 
V= table2array(V); 
Va= table2array(Va); 
V_pred= table2array(V_pred); 
Va_pred= table2array(Va_pred);

 


i=1:118;  
figure(1);
%plot(i,V(1,:),'g')
%hold on
plot(i,V_pred(1,:),'g-d')
%xlabel('Bus Number') 
%ylabel('Voltage Magnitude(pu)') 
%legend('V_{actual}','V_{predicted}')
%title('Difference b/w Actual and Predicted values using OLS model')
%legend('RSIMPLS','color','g')
%%For Angle%%

i=1:118;  
figure(2);
%plot(i,Va(2,:),'g')
%hold on
plot(i,Va_pred(1,:),' g-d')
%xlabel('Bus Number') 
%ylabel('Voltage angle(rad)') 
%legend('Va_{actual}','Va_{predicted}')
%title('Difference b/w Actual and Predicted values using RSIMPLS model')
%legend('RSIMPLS','color','g')
%%Using mean value
%{
V_act=data.V;
V_pred =data.V_fitting;
V_am=mean(V_act);
V_pm=mean(V_pred);
i=1:118;  
plot(i,V_am,'r')
hold on
plot(i,V_pm,'b')
xlabel('Bus Number') 
ylabel('Voltage Magnitude(pu)') 
legend('V_{actual}','V_{predicted}')
title('Difference b/w Actual and Predicted values using OLS model')
%}

 model ='ANN';
 address= ['train_data/' case_name '/' num2str(data_size) '/' model  '/result/'];
 %If you want to load scaled data
 data.V = readtable([address 'V.csv']);
 data.Va = readtable([address 'Va.csv']);
 data.V_pred = readtable([address 'V_pred.csv']);
 data.Va_pred = readtable([address 'Va_pred.csv']);

 

V = data.V;
Va = data.Va;
V_pred = data.V_pred;
Va_pred = data.Va_pred;



 
V= table2array(V); 
Va= table2array(Va); 
V_pred= table2array(V_pred); 
Va_pred= table2array(Va_pred);

 


i=1:118;  
figure(1);
%plot(i,V(1,:),'g')
%hold on
plot(i,V_pred(1,:),'m-*')
%xlabel('Bus Number') 
%ylabel('Voltage Magnitude(pu)') 
%legend('V_{actual}','V_{predicted}')
%title('Difference b/w Actual and Predicted values using OLS model')
%legend('RSIMPLS','color','g')
%%For Angle%%
legend({'V_{actual}', 'OLS','RSIMPLS','ANN'},'FontSize', 32)
i=1:118;  
figure(2);
%plot(i,Va(2,:),'g')
%hold on
plot(i,Va_pred(1,:),'m-*')
legend({'Va_{actual}', 'OLS','RSIMPLS','ANN'},'FontSize', 32)
 