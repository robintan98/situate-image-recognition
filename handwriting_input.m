clear all;
%%Read in Data
readfl = dlmread('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\optdigits.txt');
spl = readfl;
%{
readfl = fileread('C:\Users\LiFamily\Desktop\2016 ASE\optdigits.txt');
temp = strsplit(readfl,'\n');
temp2 = zeros(1, length(temp));
for i = 1:length(temp)
    temp2(1, i) = cell2mat(temp(i));
end
for i = 1:length(temp)
    temp2(i) = strsplit(temp(i), ',');
end
spl = cell2mat(spl);
mat = zeros(1, length(spl));

for i = 1:length(temp)
    mat(1, i) = str2num(temp2(1, i)); 
end

%}
%%Initialize Variables for Input
n = 100; %Number of numbers wanted
store = zeros(n, 64);
real_val = ones(n, 1);

%% Split storage into pixel values and then correct value
for i = 1:n %NOTE: Could have done this by simply taking 65th column of spl
    store(i, 1:64) = spl(i, 1:64);
    real_val(i, 1) = spl(i, 65);
end

%% Change to square matrix
[num_rows, num_cols] = size(store);
re_store = reshape(store(1, :), 8, 8);

for i = 2:num_rows   
    re_store = [re_store; reshape(store(i, :), 8, 8)]; %Concotanates onto re_store
end 

%%Displays images onto screen
for i = 1:10
    figure;
    temp = imresize( re_store((8*(i-1) + 1):(8*(i-1) + 9), 1:8)', [100 100], 'nearest');
    imshow(temp,[]);
end


