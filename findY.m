function [Y] = findY(start,last,r,x,num_bus)

num_branch = size(start,1);
wt = zeros([num_bus num_bus]);
adj = zeros([num_bus num_bus+1]);
for idx = 1:num_bus
adj(idx,1) = 1;
end

for idx = 1:num_branch 
    left = start(idx);
    right = last(idx);
    wt(left,right) = 1/(r(idx) + x(idx)*i);
    wt(right,left) = 1/(r(idx) + x(idx)*i);
    
    col = adj(left,1);
    adj(left,col+1) = right;
    adj(left,1) = adj(left,1)+1;

    col = adj(right,1);
    adj(right,col+1) = left;
    adj(right,1) = adj(right,1)+1;
    % adj(left) = [adj(left), right];
    % adj(right) = [adj(right), left];

end

Y = zeros([num_bus num_bus]);
for row = 1:num_bus
    for col = 1:num_bus
        if row==col
            temp = 0;
            for idx = 2:adj(row,1)
                temp = temp + wt(row, adj(row,idx));
            end
            Y(row,col) = temp;
        else
            Y(row,col) = -1 * wt(row,col);
        end
    end
end
end