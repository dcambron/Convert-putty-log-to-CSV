string = input ("Enter the name of the csv file: ",'S');
b = input ("Enter the time unit interval: ");
array = csvread(string);
array = rot90(array);
time = array(33,:) * b / 3600;
for i = 1:30,
	capacity(i) = trapz(time,array(i+1,:)/2);
	polynomials(i,:) = polyfit(time,array(i+1,:),6);
  
end

save capacities.txt capacity;
save polynomials.txt polynomials;
%fileID = fopen('capacities.txt','w');
%fprintf(fileID,'%6.2f %12.8f\n',capacity);
%fclose(fileID);
%
%fileID = fopen('polynomials.txt','w');
%fprintf(fileID,'%6.2f %12.8f\n',polynomials);
%close(fileID);