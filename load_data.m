 clc;
 clear all;
 case_name ='case118';
 data_size = 800;
 model ='OLS';
 address=['train_data\' case_name '\' num2str(data_size) '\Scaled\']
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
 

%X1=[P,Q,I,Ia];
%Y1 =[V];
%Y2 =[Va];
data.Xv= Xv; 
data.Xva= Xva;
% Calling function to know bus types
[ref,pv,pq]=bus_type(case_name);
[delta,data] = ...
        current_inverse_regression(num_train, data, ref, pv, pq, num_load,model,data_size)
 export_result(case_name,data,data_size,model)   
    


 
 