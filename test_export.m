function [] = test_export(case_name,data)
data.Va = data.Va*pi/180;
data = findI(case_name, data);
writematrix(data.P,'test_data/P.csv');
writematrix(data.Q,'test_data/Q.csv');
writematrix(data.V,'test_data/V.csv');
writematrix(data.Va,'test_data/Va.csv');
writematrix(data.I,'test_data/I.csv');
writematrix(data.Ia,'test_data/Ia.csv'); 