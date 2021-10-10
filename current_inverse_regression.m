function [delta,data] = ...
        current_inverse_regression(num_train, data, ref, pv, pq, num_load,model,data_size)
%{ this function test the accuracy of inverse regression
% note that the regression matrix is reordered
%   |V_pv   |    |         ||P_pq  |    |  |
%   |V_vva  |    |X11  X12 ||P_pv  |    |C1|
%   |Va_vva |    |         ||Q_pq  |    |  |
%   |       | =  |         ||I_pv  | +  |  |
%   |V_pq   |    |         ||I_vva |    |  |
%   |Va_pq  |    |X21  X22 ||Ia_pv |    |C2|
%   |Va_pv  |    |         ||Ia_vva|    |  |
%                           |      |
%                           |P_vva |
%                           |Q_pv  |
%                           |Q_vva |
%                           |I_pq  |
%                           |Ia_pq |
%
% Doubt - Va ref = 1??
V = data.V;
Va = data.Va;
P = data.P;
Q = data.Q;
I = data.I;
Ia = data.Ia;
Xv = data.Xv;
Xva = data.Xva;

%   Y = X * a
X11 = [Xv([pv; ref], [pq; pv; pq+num_load;pv+2*num_load;ref+2*num_load;pv+3*num_load; ref + 3*num_load]);...
    Xva(ref, [pq; pv; pq+num_load;pv+2*num_load;ref+2*num_load;pv+3*num_load; ref + 3*num_load])];

X12 = [Xv([pv; ref], [ref; pv+num_load; ref+num_load; pq+2*num_load; pq+3*num_load]);...
    Xva(ref, [ref; pv+num_load; ref+num_load; pq+2*num_load; pq+3*num_load])];
X21 = [Xv(pq, [pq; pv; pq+num_load;pv+2*num_load;ref+2*num_load;pv+3*num_load; ref + 3*num_load]);...
    Xva([pq;pv], [pq; pv; pq+num_load;pv+2*num_load;ref+2*num_load;pv+3*num_load; ref + 3*num_load])];
X22 = [Xv(pq, [ref; pv+num_load; ref+num_load; pq+2*num_load; pq+3*num_load]);...
    Xva([pq;pv], [ref; pv+num_load; ref+num_load; pq+2*num_load; pq+3*num_load])];
C1 = [Xv([pv; ref],4*num_load + 1);Xva(ref,4*num_load + 1)];
C2 = [Xv(pq,4*num_load + 1); Xva([pq;pv],4*num_load+1)];




%% calculate the results by data-driven linearized equations
for i = 1:num_train
    Y1 = [V(i, [pv; ref])'; Va(i, ref)'];
    a1 = [P(i, [pq; pv;])'; Q(i, pq)'; I(i, [pv; ref;])'; Ia(i, [pv; ref;])'];

    a2 = pinv(X12)*(Y1 - X11*a1 - C1); %x = A\b is computed differently than x = inv(A)*b and is recommended for solving systems of linear equations.
    
    num_pq = size(pq,1);
    num_pv = size(pv,1);
    num_ref = size(ref,1);

%   Q_pv = a2(1:num_pv);
%  Q_ref = a2(num_pv + 1:num_pv + 1);

    
    Y2 = X21 * a1 + X22 * a2 + C2;

    
    V_pred = zeros(num_load, 1);
    Va_pred = zeros(num_load, 1);
    I_pred = zeros(num_load,1);
    Ia_pred = zeros(num_load,1);
    %Q = data.Q(i, :);
    V_pred([pv; ref]) = V(i, [pv; ref]);
    V_pred(pq) = Y2(1:num_pq);
    Va_pred(ref) = Va(i, ref);
    Va_pred([pq; pv]) = Y2(1+num_pq: 2*num_pq + num_pv);
    %P(i, ref) = Y1(num_pq + num_pv + 1);
    %Q([pv; ref]) = [Q_pv; Q_ref]';
    I_pred([pv; ref]) = I(i, [pv; ref]);
    I_pred(pq) = a2(1+2*num_ref+num_pv : num_pq+2*num_ref+num_pv);
    Ia_pred([pv; ref]) = Ia(i, [pv; ref]);
    Ia_pred(pq) = a2(1+2*num_ref+num_pv+num_pq : 2*num_pq+2*num_ref+num_pv);
    
    
    data.V_fitting(i, :) = V_pred';
    data.Va_fitting(i, :) = Va_pred';
    data.I_fitting(i, :) = I_pred';
    data.Ia_fitting(i, :) = Ia_pred';
    %data.P_fitting(i, :) = P(i, :);
    %data.Q_fitting(i, :) = Q;
end
fprintf('\n')
fprintf('\n')

fprintf(['<strong> Error using  ' model ' on ' num2str(data_size) ' data size' '</strong>'])
% calculate the errors, note that the value of nan or inf is removed
    temp = abs((data.Va - data.Va_fitting));
    temp(find(isnan(temp)==1)) = [];
    temp(find(isinf(temp)==1)) = [];
    delta.va = mean(mean(temp));
    
    temp = abs((data.V - data.V_fitting));
    temp(find(isnan(temp)==1)) = [];
    temp(find(isinf(temp)==1)) = [];
    delta.v = mean(mean(temp));
   
    temp = abs((data.Ia - data.Ia_fitting));
    temp(find(isnan(temp)==1)) = [];
    temp(find(isinf(temp)==1)) = [];
    delta.Ia = mean(mean(temp));
    
    
    temp = abs((data.I - data.I_fitting));
    temp(find(isnan(temp)==1)) = [];
    temp(find(isinf(temp)==1)) = [];
    delta.I = mean(mean(temp));
   
 
end
    