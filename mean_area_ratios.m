%%%%%%%%%%%%%%%Calculate Mean of Area Ratios for Each Category%%%%%%%%%%%%%



clear all
clc

addpath('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE');
addpath('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled');
load('train_test_arrays.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%Area Ratio%%%%%%%%%%%%%%%%%%%%%%%%%%%

left_dimensions = zeros(320,2);
right_dimensions = zeros(320,2);
handshake_dimensions = zeros(320,2);

train_array = sort(train_array);

for i = {'personmyleft', 'personmyright', 'handshake'};
    files_area = [];
    path2 = ['C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled' i{1} '\'];
end

    
    
    total_image_dimensions = zeros(320,2);
    
    
for j = 1:320
    
k = train_array(j);
handshake = imread(sprintf('handshake%s.jpg',num2str(k)));
hstext = fileread(['handshake' num2str(k) '.labl']);

textsplit = strsplit(hstext, '|');
total_image_dimensions(j,:) = [str2num(textsplit{1}) str2num(textsplit{2})];


if strcmp(textsplit(16), 'person-my-left') == 1
left_dimensions(j,:) = [str2num(textsplit{6}) str2num(textsplit{7})];
end

if strcmp(textsplit(16), 'person-my-right') == 1
right_dimensions(j,:) = [str2num(textsplit{6}) str2num(textsplit{7})];
end

if strcmp(textsplit(16), 'handshake') == 1
handshake_dimensions(j,:) = [str2num(textsplit{6}) str2num(textsplit{7})];
end

%%second box%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(textsplit(17), 'person-my-left') == 1
left_dimensions(j,:) = [str2num(textsplit{10}) str2num(textsplit{11})];
end

if strcmp(textsplit(17), 'person-my-right') == 1
right_dimensions(j,:) = [str2num(textsplit{10}) str2num(textsplit{11})];
end

if strcmp(textsplit(17), 'handshake') == 1
handshake_dimensions(j,:) = [str2num(textsplit{10}) str2num(textsplit{11})];
end

%%thirdbox%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(textsplit(18), 'person-my-left') == 1
left_dimensions(j,:) = [str2num(textsplit{14}) str2num(textsplit{15})];
end

if strcmp(textsplit(18), 'person-my-right') == 1
right_dimensions(j,:) = [str2num(textsplit{14}) str2num(textsplit{15})];
end

if strcmp(textsplit(18), 'handshake') == 1
handshake_dimensions(j,:) = [str2num(textsplit{14}) str2num(textsplit{15})];
end

end

area_ratios_left = zeros(320,1);
area_ratios_right = zeros(320,1);
area_ratios_handshake = zeros(320,1);

for j = 1:320
    area_ratios_left(j) = (left_dimensions(j,1)*left_dimensions(j,2)/(total_image_dimensions(j,1)*total_image_dimensions(j,2)));
end

for j = 1:320
    area_ratios_right(j) = (right_dimensions(j,1)*right_dimensions(j,2)/(total_image_dimensions(j,1)*total_image_dimensions(j,2)));
end

for j = 1:320
    area_ratios_handshake(j) = (handshake_dimensions(j,1)*handshake_dimensions(j,2)/(total_image_dimensions(j,1)*total_image_dimensions(j,2)));
end


pml_arearatio_mean = mean(area_ratios_left)
h_area_ratio_mean = mean(area_ratios_handshake)
pmr_arearatio_mean = mean(area_ratios_right)

% area_ratios_left = log2(area_ratios_left);
% area_ratios_right = log2(area_ratios_right);
% area_ratios_handshake = log2(area_ratios_handshake);

% subplot(3,1,1)
% 
%     hist(area_ratios_left, 100);
%     [area_ratios_left_fitdist] = fitdist(area_ratios_left,'Normal');
%     x_linspace = linspace(-10,3,320);
%     area_ratios_left_pdf = pdf(area_ratios_left_fitdist,x_linspace);
%     plot(x_linspace,area_ratios_left_pdf);
%     title('personmyleft');
%     
% subplot(3,1,2)
% 
%     hist(area_ratios_right, 100);
%     [area_ratios_right_fitdist] = fitdist(area_ratios_right,'Normal');
%     x_linspace = linspace(-10,3,320);
%     area_ratios_right_pdf = pdf(area_ratios_right_fitdist,x_linspace);
%     plot(x_linspace,area_ratios_right_pdf);
%     title('personmyright');
%     
% subplot(3,1,3)
% 
%     hist(area_ratios_handshake, 100);
%     [area_ratios_handshake_fitdist] = fitdist(area_ratios_handshake,'Normal');
%     x_linspace = linspace(-10,3,320);
%     area_ratios_handshake_pdf = pdf(area_ratios_handshake_fitdist,x_linspace);
%     plot(x_linspace,area_ratios_handshake_pdf);
%     title('handshake');
    
%     aspect_ratios_lognormal = lognpdf(aspect_ratios,mean(aspect_ratios),std(aspect_ratios));
    %hist(cell2mat(sizes), 100);
%     aspect_ratios_lognormal = (aspect_ratios-mean(aspect_ratios))/std(aspect_ratios);
%     aspect_ratios = fitdist(aspect_ratios,'Normal');
%     hist(aspect_ratios, 100);
%     [aspect_ratios_fitdist] = fitdist(aspect_ratios,'Normal');
%     x_linspace = linspace(-5,5,320);
%     aspect_ratios_pdf = pdf(aspect_ratios_fitdist,x_linspace);
%     plot(x_linspace,aspect_ratios_pdf);
%     plot(x_linspace,aspect_ratios_fitdist);
%     aspect_ratios = fitdist(aspect_ratios);
%     hist(aspect_ratios,100);
%     title(i{1});
