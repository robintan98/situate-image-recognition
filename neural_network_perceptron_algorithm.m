%%%%%%%%%%%%%%%%%%%%%%%%%%Neural Network Assignment%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%Handshake Orientation%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc

epochs = 10;
num_crops_train  = 600;
num_crops_test = 200;
num_hid_nrns = 200;
learning_rate = 0.3;
momentum = 0.3; %0 if no momentum



%%Data Collection

load('features.mat')
% clear images; clear positive; clear negative
addpath('C:\Users\Robin\Documents\Robin Tan\2016 ASE\HandshakeLabeled\handshake');
addpath('C:\Users\Robin\Documents\Robin Tan\2016 ASE\HandshakeLabeled\personmyleft');
addpath('C:\Users\Robin\Documents\Robin Tan\2016 ASE\HandshakeLabeled\personmyright');
%Order: Handshake, Left, Right

data = cnns(401:1200,:);

fnames = cell(800,1);
for i = 1:400
    fnames(i) = cellstr(['C:\Users\Robin\Documents\Robin Tan\2016 ASE\HandshakeLabeled\personmyleft\hs' num2str(i) 'person-my-left.jpg']);
end
for i = 1:400
    fnames(i+400) = cellstr(['C:\Users\Robin\Documents\Robin Tan\2016 ASE\HandshakeLabeled\personmyright\hs' num2str(i) 'person-my-right.jpg']);
end


random_images = randperm(length(fnames));
index_train = random_images(1:num_crops_train);
index_test  = random_images(num_crops_train+1:end);

fnames_train = fnames(index_train);
fnames_test  = fnames(index_test);

data_train = cnns(index_train,:);
data_test  = cnns(index_test,:);



%%%%%%%%%%%%%%%%FIRST TIME: RANDOMIZED WEIGHT MATRIX%%%%%%%%%%%%%%%%%%%%%%%

tic

%%Generate Matrix of Input Neurons/Crop Matrix

data_each_image = data_train(1,:);

input_neurons = zeros(1,size(data_each_image,2));
for i = 1:size(data_each_image,2) 
    input_neurons(i) = data_each_image(i);
end

%%Define Output Vectors - Orientation
output_vector = zeros(1,2);
if isempty(strfind(fnames_train{1},'left')) == 0;
    output_vector(1,:) = [1 0];
end
if isempty(strfind(fnames_train{1},'right')) == 0;
    output_vector(1,:) = [0 1];
end

%%Generate Matrix of Weights
rng('shuffle')
weightmin = -0.5;
weightmax = 0.5;
num_hid_nrns = num_hid_nrns - 1;
weight_matrix_12 = weightmin + rand(num_hid_nrns+1,size(data,2))*(weightmax - weightmin);
weight_matrix_23 = weightmin + rand(2,num_hid_nrns+1)*(weightmax - weightmin);

%%Dot-Products to Produce Hidden Neurons
hidden_neurons = ones(1,num_hid_nrns+1);
hidden_neurons_before_act = ones(1,num_hid_nrns+1);
for i = 1:num_hid_nrns
    hidden_neurons_before_act(1,i) = dot(input_neurons(1,:),weight_matrix_12(i,:));
    hidden_neurons(1,i) = sigmf(hidden_neurons_before_act(1,i),[1 0]);
end
num_hid_nrns = num_hid_nrns + 1;

%%Dot-Products to Produce Output Neurons

output_neurons = zeros(1,2);
for i = 1:2
    output_neurons_before_act(1,i) = dot(hidden_neurons(1,:),weight_matrix_23(i,:));
    output_neurons(1,i) = sigmf(output_neurons_before_act(1,i),[1 0]);
end

%%Compute backpropagation error - Output Layer

for i = 1:2
    pd_cost_output(1,i) = (output_neurons(1,i)-output_vector(1,i));
    sigma_deriv_output(1,i) = sigmf(output_neurons_before_act(1,i),[1 0])*(1-sigmf(output_neurons_before_act(1,i),[1 0]));
end     
gammaL_output = pd_cost_output.*sigma_deriv_output;
gammaL_output_act = ((hidden_neurons')*gammaL_output)';

%%Compute backpropagation error - Hidden layer

for i = 1:num_hid_nrns
    sigma_deriv_hidden(1,i) = sigmf(hidden_neurons_before_act(1,i),[1 0])*(1-sigmf(hidden_neurons_before_act(1,i),[1 0]));
end
gammaL_hidden = (gammaL_output*weight_matrix_23).*sigma_deriv_hidden;
gammaL_hidden_act = ((input_neurons')*gammaL_hidden)';

%%Gradient Descent: Weights - learning rate*gammaL

if momentum ~= 0
velocity_new_hidden = - learning_rate*gammaL_hidden_act;
velocity_new_output = - learning_rate*gammaL_output_act;
weight_matrix_12 = weight_matrix_12 + velocity_new_hidden;
weight_matrix_23 = weight_matrix_23 + velocity_new_output;
end

if momentum == 0
weight_matrix_12 = weight_matrix_12 - learning_rate*gammaL_hidden_act;
weight_matrix_23 = weight_matrix_23 - learning_rate*gammaL_output_act;
end

toc;
display('Epoch 1 done');




%%%%%%%%%%%%%%%%%%%%%%%SECOND TIME: TRAINED WEIGHT MATRIX%%%%%%%%%%%%%%%%%%

%%Define Loop for each Data Row

for n = 2:epochs
    
tic

for m = 2:num_crops_train
    
%%Generate Matrix of Input Neurons/Letter Matrix

data_each_image = data_train(m,:);

input_neurons = zeros(1,size(data_each_image,2));
for i = 1:size(data_each_image,2) 
    input_neurons(i) = data_each_image(i);
end

%%Define Output Vectors - Orientation
output_vector = zeros(1,2);
if isempty(strfind(fnames_train{m},'left')) == 0;
    output_vector(1,:) = [1 0];
end
if isempty(strfind(fnames_train{m},'right')) == 0;
    output_vector(1,:) = [0 1];
end

%%Dot-Products to Produce Hidden Neurons
num_hid_nrns = num_hid_nrns - 1;
hidden_neurons = ones(1,num_hid_nrns+1);
hidden_neurons_before_act = ones(1,num_hid_nrns+1);
for i = 1:num_hid_nrns
    hidden_neurons_before_act(1,i) = dot(input_neurons(1,:),weight_matrix_12(i,:));
    hidden_neurons(1,i) = sigmf(hidden_neurons_before_act(1,i),[1 0]);
end
num_hid_nrns = num_hid_nrns + 1;

%%Dot-Products to Produce Output Neurons

output_neurons = zeros(1,2);
for i = 1:2
    output_neurons_before_act(1,i) = dot(hidden_neurons(1,:),weight_matrix_23(i,:));
    output_neurons(1,i) = sigmf(output_neurons_before_act(1,i),[1 0]);
end

%%Compute backpropagation error - Output Layer

for i = 1:2
    pd_cost_output(1,i) = (output_neurons(1,i)-output_vector(1,i));
    sigma_deriv_output(1,i) = sigmf(output_neurons_before_act(1,i),[1 0])*(1-sigmf(output_neurons_before_act(1,i),[1 0]));
end     
gammaL_output = pd_cost_output.*sigma_deriv_output;
gammaL_output_act = ((hidden_neurons')*gammaL_output)';
  
%%Compute backpropagation error - Hidden layer

for i = 1:num_hid_nrns
    sigma_deriv_hidden(1,i) = sigmf(hidden_neurons_before_act(1,i),[1 0])*(1-sigmf(hidden_neurons_before_act(1,i),[1 0]));
end
gammaL_hidden = (gammaL_output*weight_matrix_23).*sigma_deriv_hidden;
gammaL_hidden_act = ((input_neurons')*gammaL_hidden)';

%%Gradient Descent: Weights - learning rate*gammaL

if momentum ~= 0
velocity_new_hidden = momentum*velocity_new_hidden - learning_rate*gammaL_hidden_act;
velocity_new_output = momentum*velocity_new_output - learning_rate*gammaL_output_act;
weight_matrix_12 = weight_matrix_12 + velocity_new_hidden;
weight_matrix_23 = weight_matrix_23 + velocity_new_output;
end

if momentum == 0
weight_matrix_12 = weight_matrix_12 - learning_rate*gammaL_hidden_act;
weight_matrix_23 = weight_matrix_23 - learning_rate*gammaL_output_act;
end

end

toc;
display(['Epoch ' num2str(n) ' done']);

end



%%%%%%%%%%%%%%%%%%%%%TESTING PHASE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

total_number_of_errors_matrix = zeros(1, num_crops_test);
maximum_orientation = zeros(1,num_crops_test);
actual_orientation = zeros(1,num_crops_test);

for m = num_crops_train + 1: num_crops_train + num_crops_test

%%Generate Matrix of Input Neurons/Letter Matrix

data_each_image = data_test(m-num_crops_train,:);

input_neurons = zeros(1,size(data_each_image,2));
for i = 1:size(data_each_image,2) 
    input_neurons(i) = data_each_image(i);
end

num_hid_nrns = num_hid_nrns - 1;

%%Dot-Products to Produce Hidden Neurons
hidden_neurons = ones(1,num_hid_nrns+1);
hidden_neurons_before_act = ones(1,num_hid_nrns+1);
for i = 1:num_hid_nrns
    hidden_neurons_before_act(1,i) = dot(input_neurons(1,:),weight_matrix_12(i,:));
    hidden_neurons(1,i) = sigmf(hidden_neurons_before_act(1,i),[1 0]);
end
% hidden_neurons
num_hid_nrns = num_hid_nrns + 1;

%%Dot-Products to Produce Output Neurons

output_neurons = zeros(1,2);
for i = 1:2
    output_neurons_before_act(1,i) = dot(hidden_neurons(1,:),weight_matrix_23(i,:));
    output_neurons(1,i) = sigmf(output_neurons_before_act(1,i),[1 0]);
end

% output_neurons
[temp,maximum_orientation(m-num_crops_train)] = max(output_neurons);

end



%%%%%%%%%%%%%%%%%%%%%%TOTAL ERRORS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Define Actual Letter
for i = 1:num_crops_test
    if isempty(strfind(fnames_test{i},'left')) == 0;
        actual_orientation(i) = 1;
    end
    if isempty(strfind(fnames_test{i},'right')) == 0;
        actual_orientation(i) = 2;
    end
end

correct_matrix = zeros(1,num_crops_test);
for i = 1:num_crops_test
    if actual_orientation(i) == maximum_orientation(i)
        correct_matrix(i) = 1;
    end
end

total_correct = sum(correct_matrix);
predicted_correct_over_total_correct = total_correct/num_crops_test*100;

display(['For Number of Hidden Neurons of ' num2str(num_hid_nrns)]);
display(['Percent of Correct Predictions: ' num2str(predicted_correct_over_total_correct) '%']);



confusion_matrix = zeros(2,2);
LL = zeros(1,num_crops_test);
LR = zeros(1,num_crops_test);
RL = zeros(1,num_crops_test);
RR = zeros(1,num_crops_test);
for i = 1:num_crops_test
    if isempty(strfind(fnames_test{i},'left')) == 0;
        if actual_orientation(i) == maximum_orientation(i)
            LL(i) = 1;
        end
        if actual_orientation(i) ~= maximum_orientation(i)
            LR(i) = 1;
        end
    end
    if isempty(strfind(fnames_test{i},'right')) == 0;
        if actual_orientation(i) == maximum_orientation(i)
            RR(i) = 1;
        end
        if actual_orientation(i) ~= maximum_orientation(i)
            RL(i) = 1;
        end
    end
end

confusion_matrix(1,1) = sum(LL);
confusion_matrix(1,2) = sum(LR);
confusion_matrix(2,1) = sum(RL);
confusion_matrix(2,2) = sum(RR);


%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:num_crops_test
    if isempty(strfind(fnames_test{i},'left')) == 0;
        if actual_orientation(i) ~= maximum_orientation(i)
            fnames_test{i}
        end
    end
    if isempty(strfind(fnames_test{i},'right')) == 0;
        if actual_orientation(i) ~= maximum_orientation(i)
            fnames_test{i}
        end
    end
end




display('done');
