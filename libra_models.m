function []=libra_models(model)
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
result1=rsimpls(X1,Y1,'k',2*num_bus,'kmax',2*num_bus, 'h',data_size,'classic',1)
XV=result1.slope;
C1=result1.int;
Xv=[XV;C1];
result2=rsimpls(X1,Y2,'k',2*num_bus,'kmax',2*num_bus,'h',data_size,'classic',1)
XVA=result2.slope;
C2=result2.int;
Xva=[XVA;C2];
data.Xv=Xv';
data.Xva=Xva'


%%CSIMPLS
case 'CSIMPLS'
result1=csimpls(X1,Y1,'k',200,'plots',1)
XV=result1.slope;
C1=result1.int;
Xv=[XV;C1];
result2=csimpls(X1,Y1,'k',200,'plots',1)
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
end