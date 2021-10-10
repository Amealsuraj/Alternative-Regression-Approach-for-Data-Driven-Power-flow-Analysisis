
 clc;
 clear all;
 case_name ='case14';
 data_size =500;
 num_bus =14;

 address=['train_data\' case_name '\' num2str(data_size) '\Scaled\']; 
 data.V = readtable([address 'V.csv']);
 data.Va = readtable([address 'Va.csv']);
 data.P = readtable([address 'P.csv']);
 data.Q = readtable([address 'Q.csv']);
 data.I = readtable([address 'I.csv']);
 data.Ia = readtable([address 'Ia.csv']);
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
%Xv= table2array(Xv); 
%Xva= table2array(Xva); 

data.P= P;
data.Q= Q; 
data.V= V; 
data.Va= Va;
data.I= I; 
data.Ia= Ia; 
 

X1=[P,Q,I,Ia];
%X1=[P,Q];
Y1 =[V];
Y2 =[Va];

model ='RSIMPLS';

switch model  
case 'MLR';
result1=mlr(X1,Y1,'intercept',1);
XV=result1.slope;
C1=result1.int;
Xv=[XV;C1];
result2=mlr(X1,Y2,'intercept',1);
XVA=result2.slope;
C2=result2.int;
Xva=[XVA;C2];
data.Xv=Xv';
data.Xva=Xva';
case 'RSIMPLS' %%RSIMPLS 
result1=rsimpls(X1,Y1,'k',35,'kmax',4*num_bus,'h',data_size,'classic',1)
%{
result1=rsimpls(X1,Y1,'kmax',4*num_bus,'alpha',0.75,'rmsecv',1,'rmsep',1);
 %}
XV=result1.slope;
C1=result1.int;
Xv=[XV;C1];
result2=rsimpls(X1,Y2,'k',35,'kmax',4*num_bus,'h',data_size,'classic',1)
%result2=rsimpls(X1,Y2,'rmsecv',1,'kmax',2*num_bus,'h',data_size,'classic',1)
%{
result2=rsimpls(X1,Y2,'kmax',4*num_bus,'alpha',0.75,'rmsecv',1,'rmsep',1,...
      'plots',1);
%}
XVA=result2.slope;
C2=result2.int;
Xva=[XVA;C2];
data.Xv=Xv';
data.Xva=Xva'


%%CSIMPLS
case 'CSIMPLS'
result1=csimpls(X1,Y1,'k',130,'plots',1)
XV=result1.slope;
C1=result1.int;
Xv=[XV;C1];
result2=csimpls(X1,Y1,'k',130,'plots',1)
XVA=result2.slope;
C2=result2.int;
Xva=[XVA;C2];
data.Xv=Xv';
data.Xva=Xva';
case 'MCD Regress'
%%MCD Regress
result1=mcdregres(X1,Y1,'h',1600,'ntrial',500,'plots',1,'classic',0);
XV=result1.slope;
C1=result1.int;
Xv=[XV;C1];
result2=mcdregres(X1,Y2,'h',1600,'ntrial',500,'plots',1,'classic',0);
XVA=result2.slope;
C2=result2.int;
Xva=[XVA;C2];
data.Xv=Xv';

data.Xva=Xva';
otherwise
        error('no such method')
        
end


address_params=['train_data\' case_name '\' num2str(data_size) '\' model +'\']
writematrix(data.Xv,[address_params 'Xv.csv']);
writematrix(data.Xva,[address_params 'Xva.csv']);

num_train = size(data.P,1);
num_load = size(data.P,2);
% Calling function to know bus types
[ref,pv,pq]=bus_type(case_name);

[delta,data] = ...
        current_inverse_regression(num_train, data, ref, pv, pq, num_load,model,data_size)
export_result(case_name,data,data_size,model)    