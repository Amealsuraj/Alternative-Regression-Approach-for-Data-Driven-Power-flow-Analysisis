 clc;
 clear all;
 case_name ='case118';
 data_size = 800;
 model ='OLS';
 address=['train_data\' case_name '\' num2str(data_size) '\']
 %If you want to load scaled data
  data.V = readtable([address 'V.csv']);
 data.Va = readtable([address 'Va.csv']);
 data.P = readtable([address 'P.csv']);
 data.Q = readtable([address 'Q.csv']);
 data.I = readtable([address 'I.csv']);
 data.Ia = readtable([address 'Ia.csv']);
 
 address_params=['train_data\' case_name '\' num2str(data_size) '\' model +'\']
 Xv = readtable([address_params 'Xv.csv']);
 Xva = readtable( [address_params 'Xva.csv']);
 num_train = size(data.P,1);
 num_load = size(data.P,2);

P = data.P;
Q = data.Q;
V = data.V;
Va = data.Va;
I = data.I;
Ia = data.Ia;

P= table2array(P); 
Q= table2array(Q); 
I= table2array(I); 
Ia= table2array(Ia); 
V= table2array(V); 
Va= table2array(Va); 
Xv= table2array(Xv); 
Xva= table2array(Xva); 

data.P= P;
data.Q= Q; 
data.V= V; 
data.Va= Va;
data.I= I; 
data.Ia= Ia; 
boxplot(V);
xlabel('Bus Number','FontSize', 36)
%set(gca,'XTick',[1:118])
%set(gca,'XTick',[1:118], 'ActivePositionProperty','position','FontSize',10)

%xlabel('Bus Number','FontSize', 32)