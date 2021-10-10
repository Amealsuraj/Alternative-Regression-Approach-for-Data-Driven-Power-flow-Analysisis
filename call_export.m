data_size=600;
case_name='case33bw';
address=['gen_data\' case_name '\' case_name '_training_data' num2str(data_size)]
mpc=load(address);
data =mpc.data;
export(case_name,data,data_size);
%for test data
%test_export('case118',data);

