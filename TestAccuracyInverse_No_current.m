function [delta,data] = ...
        TestAccuracyInverse_No_current(num_train, data, ref, pv, pq, num_load)
% this function test the accuracy of inverse regression
% note that the regression matrix is reordered
%   |Va_pq |    |         ||P_pq  |    |  |
%   |Va_pv |    |X11  X12 ||P_pv  |    |C1|
%   |P_ref |    |         ||1     |    |  |
%   |V_pq  | =  |         ||Q_pq  | +  |  |
%   |      |    |         ||      |    |  |
%   |V_pv  |    |X21  X22 ||Q_pv  |    |C2|
%   |V_ref |    |         ||Q_ref |    |  |

% Doubt - Va ref = 1??

%   Y = X * a
P = data.P;
V = data.V;
Va = data.Va;
Xv = data.Xv;
Xva = data.Xva;
X11 = [Xva([pq; pv; ref], [pq; pv; ref; pq + num_load]);...
    Xv(pq, [pq; pv; ref; pq + num_load])];
X12 = [Xva([pq; pv; ref], [pv; ref] + num_load);...
    Xv(pq, [pv; ref] + num_load)];
X21 = Xv([pv; ref], [pq; pv; ref; pq + num_load]);
X22 = Xv([pv; ref], [pv; ref] + num_load);
C1 = [Xva([pq; pv; ref],4*num_load + 1);Xv(pq,4*num_load + 1)];
C2 = Xv([pv; ref],4*num_load + 1);

%
%P(:, ref) = data.Va(:, ref);
%Va = data.Va;
%Va(:, ref) = data.P(:, ref);

%% calculate the results by data-driven linearized equations
for i = 1:num_train
    Y2 = data.V(i, [pv; ref])';
    a1 = [P(i, [pq; pv; ref])'; data.Q(i, pq)'];
    a2 = pinv(X22)*(Y2 - X21 * a1 - C2);
    
    num_pq = size(pq,1);
    num_pv = size(pv,1);
    %Q_pv = a2(1:num_pv);
    %Q_ref = a2(num_pv + 1:num_pv + 1);
    
    Y1 = X11 * a1 + X12 * a2 + C1;

    
    V_pred= zeros(num_load, 1);
    Va_pred = zeros(num_load, 1);
    %Q = data.Q(i, :);
    V_pred([pv; ref]) = data.V(i, [pv; ref]);
    V_pred(pq) = Y1(num_load + 1: num_load + num_pq);
    Va_pred(ref) = data.Va(i, ref);
    Va_pred([pq; pv]) = Y1(1: num_pq + num_pv) ;
    %P(i, ref) = Y1(num_pq + num_pv + 1);
    %Q([pv; ref]) = [Q_pv; Q_ref]';
    
    data.V_fitting(i, :) = V_pred';
    data.Va_fitting(i, :) = Va_pred';
    %data.P_fitting(i, :) = P(i, :);
    %data.Q_fitting(i, :) = Q;
end

%% calculate the errors, note that the value of nan or inf is removed
    temp = abs((data.Va - data.Va_fitting));
    temp(find(isnan(temp)==1)) = [];
    temp(find(isinf(temp)==1)) = [];
    delta.va.fitting = mean(mean(temp));
    
    temp = abs((data.V(:,pq) - data.V_fitting(:,pq)));
    temp(find(isnan(temp)==1)) = [];
    temp(find(isinf(temp)==1)) = [];
    delta.v.fitting = mean(mean(temp));
    

    
 

end
    