clc;
clear all;
%% define parameters
generate_data = 1;%1,data generation is needed; 0,data is already generated
upper_bound = 1.2;%upper bound of generated load
lower_bound = 0.8;%lower bound of generated load
regression = 1; %0-least squares 1-pls regression 2-bayesian linear regression 
for_or_inv = 1;% 0-forward regression;1-inverse regression 

G_range = 0.1; %range of power generation variations
Q_range = 0.25; %range of Q variations
Q_per = 0.2; %Q percentage on P
V_range = 0.01; %range of voltage magnitude variations of PV buses
L_range = 0.05; %range of load in different nodes
L_corr = 0.9; %covariance
Va_range = 7;%degree
Va_num = [];
dc_ac = 1; %0-dc;1-ac;
random_load = 1; %1,random 0,not random with bounder 2,not random with covariance

data_size =600;% training data size
%data_size_test = 0 % testing data size
case_name = 'case33bw';
address = ['gen_data/' case_name '/'];% address to read and save the data filess

%%  training data generation
data_name = [ address case_name  '_training_data' num2str(data_size)];
if (generate_data)
    mpc = ext2int(loadcase(case_name));
    [ref, pv, pq] = bustypes(mpc.bus, mpc.gen);
    DataGeneration(case_name, Q_per, data_name, dc_ac, G_range, ...
        upper_bound, lower_bound, Q_range, V_range, data_size, L_range, ...
        random_load, Va_range, ref, L_corr);      
end
load([data_name,'.mat']);
%{
%% generate testing data
upper_bound = 1.13;
lower_bound = 0.87;
data_name = [address case_name  '_testing_data' num2str(data_size_test)];
if (generate_test_data)
    DataGeneration(case_name, Q_per, data_name, dc_ac, G_range,...
        upper_bound, lower_bound, Q_range, V_range, data_size_test, L_range, ...
        random_load, Va_range, ref, L_corr); 
end
%load([data_name,'.mat']);
%}

