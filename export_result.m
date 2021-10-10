function [] = export_result(case_name,data,data_size,model)
address= ['train_data/' case_name '/' num2str(data_size) '/' model  '/result/'];
writematrix(data.P, [address 'P.csv']);
writematrix(data.Q,[address 'Q.csv']);
writematrix(data.V,[address 'V.csv']);
writematrix(data.Va,[address 'Va.csv']);
writematrix(data.V_fitting,[address 'V_pred.csv']);
writematrix(data.Va_fitting,[address 'Va_pred.csv']);
writematrix(data.I,[address 'I.csv']);
writematrix(data.Ia,[address 'Ia.csv']); 
writematrix(data.I_fitting,[address 'I_pred.csv']);
writematrix(data.Ia_fitting,[address 'Ia_pred.csv']); 
end