
function [] = export(case_name,data,data_size)
data.Va = data.Va*pi/180;
data = findI(case_name, data);
address= ['train_data/' case_name '/' num2str(data_size) '/' ];
writematrix(data.P, [address 'P.csv']);
writematrix(data.Q,[address 'Q.csv']);
writematrix(data.V,[address 'V.csv']);
writematrix(data.Va,[address 'Va.csv']);
writematrix(data.Va,[address 'Va.csv']);
writematrix(data.I,[address 'I.csv']);
writematrix(data.I,[address 'I.csv']);
writematrix(data.Ia,[address 'Ia.csv']);    
end