close all
%Imports data file, expecting headers to be in first row, so remove
%everything above headers and delete the timestamp from the header line
%manually.
struct_data=importdata('gpstimetest',' ',1);

Final_data = struct_data.data;

%Create cells with headers (Maybe not a good idea if we dont need headers)
Headered_table = [struct_data.textdata(1,:); num2cell(Final_data)];

%Find the max difference between uc and gps time
diff = Final_data(:,2)-Final_data(:,1);
max(diff)


runtime=Final_data(:,3)./1000000;
%Figure 1: Runtime vs temp1
figure(1)
plot(runtime, Final_data(:,4));

%Figure 2: Runtime vs HUM
figure(2)
plot(runtime, Final_data(:,5));

%Figure 3: Runtime vs Pressure
figure(3)
plot(runtime, Final_data(:,7));


%Figure 4: Phase difference over time
figure(4)
plot(runtime, diff);


data.phase = diff;
data.time=runtime;
data.rate=1;
tau = 1:28996;
allan(data,tau)
