%{
case_name: string
Vm: 500x30
Va: 500x30
Ir: 500x30
Iim: 500x30
%}

function [data] = findI(case_name,data)
mpc = loadcase(case_name);
Vm =data.V;
Va =data.Va;
P =data.P;
Q =data.Q;

P=fillmissing( P ,'constant', 0);
Vm=fillmissing( Vm ,'constant', 0);
Va=fillmissing( Va ,'constant', 0);
Q=fillmissing( Q ,'constant', 0);

display('Total NaN values in Vm and Va ')
size(sum(isnan(Vm)))
display('Total NaN values in Va ')
size(sum(isnan(Va)))
display('Total NaN values in P ')
size(sum(isnan(P)))
display('Total NaN values in Q ')
size(sum(isnan(Q)))
start = mpc.branch(:,1);
last = mpc.branch(:,2);
num_bus = size(mpc.bus,1);
num_branch = size(mpc.branch,1);

num_train = size(Vm,1);
I = zeros(num_train, num_bus);
Ia = zeros(num_train, num_bus);

%%Filling NaN values with zero
for n=1:num_train
for j=1:num_bus
        if isnan(Va(n,j)) 
        Va(n,j)=0;   
        end
        if isnan(P(n,j))
           P(n,j) =0; 
        end
        if isnan(Q(n,j))
           Q(n,j) =0; 
        end
        if isnan(Vm(n,j))
            Vm(n,j)=0; 
        end

end
end
for n=1:num_train
for j=1:num_bus
        if isnan(Va(n,j)) 
           error('NaN value')
        end
        if isnan(P(n,j))
           error('NaN value')
        end
        if isnan(Q(n,j))
           error('NaN value') 
        end
        if isnan(Vm(n,j))
            error('NaN value')
        end

end
end
if isinf(Va)
    error('Infinity')
end

for n=1:num_train
for j=1:num_bus

   [Vr(n,j),Vim(n,j)] =pol2cart(Va(n,j),Vm(n,j));  % logic to convert into polar form
end
end

%for k= 1:num_bus
%Ir(i,k)  = real(I(k));
%Iim(i,k) = imag(I(k));
%end
V = [Vr + Vim*i];
S = [P  + Q*i];


for n=1:num_train
for j=1:num_bus
    if isnan(V(n,j))
      error('NaN value')
    end
    
I_calc(n,j)=conj(S(n,j)*pinv(V(n,j)));
%%{   
if isnan( I_calc(n,j) )
      error('NaN value')
end
%}
end
end
for n=1:num_train
for j=1:num_bus
   [Ia(n,j),I(n,j)] =cart2pol(real(I_calc(n,j)),imag(I_calc(n,j)));
end
end
data.P=P;
data.Q=Q;
data.Ia = Ia;
data.I = I;
data.V=Vm;
data.Va=Va;
end