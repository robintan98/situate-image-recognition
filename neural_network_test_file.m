%%%%%%%%%%%%%%%%%%%%%%%%%%Neural Network Assignment%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Handwriting Data%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc

%%Parameters

% neuron_matrix = [50 100 150 200 250 300 350 400];

% for h = 1:size(neuron_matrix,2)
    
%     num_hid_nrns = neuron_matrix(h);
    
epochs = 1000;
num_letters_train  = 1000;
num_letters_test = 500;
num_hid_nrns = 200;
learning_rate = 0.2;
momentum = 0.03; %0 if no momentum

correct_per_iteration_matrix = zeros(1,num_letters_test);


%%Load Handwriting Data

handwriting_data = fileread('handwriting.txt');
handwriting_data = (strsplit(handwriting_data,'\n'))';
for i = 1:num_letters_train+num_letters_test
handwriting_data_temp{i,:} = strsplit(handwriting_data{i,:},',');
end
handwriting_data = handwriting_data_temp;

handwriting_data_index = randperm(size(handwriting_data));
handwriting_data = handwriting_data(handwriting_data_index);
clear handwriting_data_temp;
clear handwriting_data_index;










%%%%%%%%%%%%%%%%FIRST TIME: RANDOMIZED WEIGHT MATRIX%%%%%%%%%%%%%%%%%%%%%%%
tic
handwriting_each_letter = handwriting_data{1};

%%Generate Matrix of Input Neurons/Letter Matrix

input_neurons = cell(1,16);
for i = 1:16
    input_neurons{1,i} = handwriting_each_letter{i+1};
end
letter = char(handwriting_each_letter{1});

for i = 1:16
    input_neurons_temp(1,i) = str2num(input_neurons{1,i});
end
input_neurons = input_neurons_temp;

%%Define Output Vectors - Letters
output_vector = zeros(1,26);
    if letter == 'A'
        output_vector(1,:) = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'B'
        output_vector(1,:) = [0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'C'
        output_vector(1,:) = [0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'D'
        output_vector(1,:) = [0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'E'
        output_vector(1,:) = [0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'F'
        output_vector(1,:) = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'G'
        output_vector(1,:) = [0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'H'
        output_vector(1,:) = [0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'I'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'J'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'K'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'L'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'M'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'N'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'O'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'P'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'Q'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'R'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0];
    end
    if letter == 'S'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0];
    end
    if letter == 'T'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0];
    end
    if letter == 'U'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0];
    end
    if letter == 'V'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0];
    end
    if letter == 'W'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0];
    end
    if letter == 'X'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0];
    end
    if letter == 'Y'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0];
    end
    if letter == 'Z'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
end

%%Generate Matrix of Weights
rng('shuffle')
weightmin = -0.5;
weightmax = 0.5;
num_hid_nrns = num_hid_nrns - 1;
weight_matrix_12 = weightmin + rand(num_hid_nrns+1,16)*(weightmax - weightmin);
weight_matrix_23 = weightmin + rand(26,num_hid_nrns+1)*(weightmax - weightmin);
clear weightmin weightmax;

%%Dot-Products to Produce Hidden Neurons
hidden_neurons = ones(1,num_hid_nrns+1);
hidden_neurons_before_act = ones(1,num_hid_nrns+1);
for i = 1:num_hid_nrns
    hidden_neurons_before_act(1,i) = dot(input_neurons(1,:),weight_matrix_12(i,:));
    hidden_neurons(1,i) = sigmf(hidden_neurons_before_act(1,i),[1 0]);
end
num_hid_nrns = num_hid_nrns + 1;

%%Dot-Products to Produce Output Neurons

output_neurons = zeros(1,26);
for i = 1:26
    output_neurons_before_act(1,i) = dot(hidden_neurons(1,:),weight_matrix_23(i,:));
    output_neurons(1,i) = sigmf(output_neurons_before_act(1,i),[1 0]);
end

%%Compute backpropagation error - Output Layer

for i = 1:26
    pd_cost_output(1,i) = (output_neurons(1,i)-output_vector(1,i));
    sigma_deriv_output(1,i) = sigmf(output_neurons_before_act(1,i),[1 0])*(1-sigmf(output_neurons_before_act(1,i),[1 0]));
end     
gammaL_output = pd_cost_output.*sigma_deriv_output;
gammaL_output_act = (hidden_neurons')*gammaL_output;
gammaL_output_act = gammaL_output_act';
   
%%Compute backpropagation error - Hidden layer

for i = 1:num_hid_nrns
    sigma_deriv_hidden(1,i) = sigmf(hidden_neurons_before_act(1,i),[1 0])*(1-sigmf(hidden_neurons_before_act(1,i),[1 0]));
end
gammaL_hidden = (gammaL_output*weight_matrix_23).*sigma_deriv_hidden;
gammaL_hidden_act = (input_neurons')*gammaL_hidden;
gammaL_hidden_act = gammaL_hidden_act';

%%Gradient Descent: Weights - learning rate*gammaL

if momentum ~= 0
velocity_new_hidden = - learning_rate*gammaL_hidden_act;
velocity_new_output = - learning_rate*gammaL_output_act;


weight_matrix_12_new = weight_matrix_12 + velocity_new_hidden;
weight_matrix_23_new = weight_matrix_23 + velocity_new_output;

end

if momentum == 0

weight_matrix_12_new = weight_matrix_12 - learning_rate*gammaL_hidden_act;
weight_matrix_23_new = weight_matrix_23 - learning_rate*gammaL_output_act;

end


weight_matrix_12 = weight_matrix_12_new;
weight_matrix_23 = weight_matrix_23_new;

toc;
display('Epoch 1 done');














%%%%%%%%%%%%%%%%%%%%%%%SECOND TIME: TRAINED WEIGHT MATRIX%%%%%%%%%%%%%%%%%%

%%Define Loop for each Data Row

for n = 2:epochs
    
tic

for m = 2:num_letters_train
    
handwriting_each_letter = handwriting_data{m};

%%Generate Matrix of Input Neurons/Letter Matrix

input_neurons = cell(1,16);
for i = 1:16
    input_neurons{1,i} = handwriting_each_letter{i+1};
end
letter = char(handwriting_each_letter{1});

for i = 1:16
    input_neurons_temp(1,i) = str2num(input_neurons{1,i});
end
input_neurons = input_neurons_temp;

%%Define Output Vectors - Letters
output_vector = zeros(1,26);
    if letter == 'A'
        output_vector(1,:) = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'B'
        output_vector(1,:) = [0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'C'
        output_vector(1,:) = [0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'D'
        output_vector(1,:) = [0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'E'
        output_vector(1,:) = [0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'F'
        output_vector(1,:) = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'G'
        output_vector(1,:) = [0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'H'
        output_vector(1,:) = [0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'I'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'J'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'K'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'L'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'M'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'N'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'O'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'P'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'Q'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0];
    end
    if letter == 'R'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0];
    end
    if letter == 'S'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0];
    end
    if letter == 'T'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0];
    end
    if letter == 'U'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0];
    end
    if letter == 'V'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0];
    end
    if letter == 'W'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0];
    end
    if letter == 'X'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0];
    end
    if letter == 'Y'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0];
    end
    if letter == 'Z'
        output_vector(1,:) = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
end


num_hid_nrns = num_hid_nrns - 1;

%%Dot-Products to Produce Hidden Neurons
hidden_neurons = ones(1,num_hid_nrns+1);
hidden_neurons_before_act = ones(1,num_hid_nrns+1);
for i = 1:num_hid_nrns
    hidden_neurons_before_act(1,i) = dot(input_neurons(1,:),weight_matrix_12(i,:));
    hidden_neurons(1,i) = sigmf(hidden_neurons_before_act(1,i),[1 0]);
end
num_hid_nrns = num_hid_nrns + 1;

%%Dot-Products to Produce Output Neurons

output_neurons = zeros(1,26);
for i = 1:26
    output_neurons_before_act(1,i) = dot(hidden_neurons(1,:),weight_matrix_23(i,:));
    output_neurons(1,i) = sigmf(output_neurons_before_act(1,i),[1 0]);
end

%%Compute backpropagation error - Output Layer

for i = 1:26
    pd_cost_output(1,i) = (output_neurons(1,i)-output_vector(1,i));
    sigma_deriv_output(1,i) = sigmf(output_neurons_before_act(1,i),[1 0])*(1-sigmf(output_neurons_before_act(1,i),[1 0]));
end     
gammaL_output = pd_cost_output.*sigma_deriv_output;
gammaL_output_act = (hidden_neurons')*gammaL_output;
gammaL_output_act = gammaL_output_act';
   
%%Compute backpropagation error - Hidden layer

for i = 1:num_hid_nrns
    sigma_deriv_hidden(1,i) = sigmf(hidden_neurons_before_act(1,i),[1 0])*(1-sigmf(hidden_neurons_before_act(1,i),[1 0]));
end
gammaL_hidden = (gammaL_output*weight_matrix_23).*sigma_deriv_hidden;
gammaL_hidden_act = (input_neurons')*gammaL_hidden;
gammaL_hidden_act = gammaL_hidden_act';

%%Gradient Descent: Weights - learning rate*gammaL

if momentum ~= 0
velocity_new_hidden = momentum*velocity_new_hidden - learning_rate*gammaL_hidden_act;
velocity_new_output = momentum*velocity_new_output - learning_rate*gammaL_output_act;


weight_matrix_12_new = weight_matrix_12 + velocity_new_hidden;
weight_matrix_23_new = weight_matrix_23 + velocity_new_output;

end


if momentum == 0

weight_matrix_12_new = weight_matrix_12 - learning_rate*gammaL_hidden_act;
weight_matrix_23_new = weight_matrix_23 - learning_rate*gammaL_output_act;

end


weight_matrix_12 = weight_matrix_12_new;
weight_matrix_23 = weight_matrix_23_new;








end

toc;
display(['Epoch ' num2str(n) ' done']);

end









%%%%%%%%%%%%%%%%%%%%%TESTING PHASE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

total_number_of_errors_matrix = zeros(1, num_letters_test);



maximum_letter = zeros(1,num_letters_test);
actual_letter = zeros(1,num_letters_test);
for m = num_letters_train + 1: num_letters_train + num_letters_test


handwriting_each_letter = handwriting_data{m};

%%Generate Matrix of Input Neurons/Letter Matrix


input_neurons = cell(1,16);
for i = 1:16
    input_neurons{1,i} = handwriting_each_letter{i+1};
end
letter = char(handwriting_each_letter{1});

for i = 1:16
    input_neurons_temp(1,i) = str2num(input_neurons{1,i});
end
input_neurons = input_neurons_temp;


num_hid_nrns = num_hid_nrns - 1;


%%Dot-Products to Produce Hidden Neurons
hidden_neurons = ones(1,num_hid_nrns+1);
hidden_neurons_before_act = ones(1,num_hid_nrns+1);
for i = 1:num_hid_nrns
    hidden_neurons_before_act(1,i) = dot(input_neurons(1,:),weight_matrix_12(i,:));
    hidden_neurons(1,i) = sigmf(hidden_neurons_before_act(1,i),[1 0]);
end
num_hid_nrns = num_hid_nrns + 1;

%%Dot-Products to Produce Output Neurons

output_neurons = zeros(1,26);
for i = 1:26
    output_neurons_before_act(1,i) = dot(hidden_neurons(1,:),weight_matrix_23(i,:));
    output_neurons(1,i) = sigmf(output_neurons_before_act(1,i),[1 0]);
end
%     display([num2str(output_neurons(1,1))]);%GFDSJGIJGSIFGGJFDSGFDSIGJIGJIFDSA
%%Compute Total number of errors

[temp,maximum_letter(m-num_letters_train)] = max(output_neurons);



%%Define Actual Letter

    if letter == 'A'
        actual_letter(m-num_letters_train) = 1;
    end
    if letter == 'B'
        actual_letter(m-num_letters_train) = 2;
    end
    if letter == 'C'
        actual_letter(m-num_letters_train) = 3;
    end
    if letter == 'D'
        actual_letter(m-num_letters_train) = 4;
    end
    if letter == 'E'
        actual_letter(m-num_letters_train) = 5;
    end
    if letter == 'F'
        actual_letter(m-num_letters_train) = 6;
    end
    if letter == 'G'
        actual_letter(m-num_letters_train) = 7;
    end
    if letter == 'H'
        actual_letter(m-num_letters_train) = 8;
    end
    if letter == 'I'
        actual_letter(m-num_letters_train) = 9;
    end
    if letter == 'J'
        actual_letter(m-num_letters_train) = 10;
    end
    if letter == 'K'
        actual_letter(m-num_letters_train) = 11;
    end
    if letter == 'L'
        actual_letter(m-num_letters_train) = 12;
    end
    if letter == 'M'
        actual_letter(m-num_letters_train) = 13;
    end
    if letter == 'N'
        actual_letter(m-num_letters_train) = 14;
    end
    if letter == 'O'
        actual_letter(m-num_letters_train) = 15;
    end
    if letter == 'P'
        actual_letter(m-num_letters_train) = 16;
    end
    if letter == 'Q'
        actual_letter(m-num_letters_train) = 17;
    end
    if letter == 'R'
        actual_letter(m-num_letters_train) = 18;
    end
    if letter == 'S'
        actual_letter(m-num_letters_train) = 19;
    end
    if letter == 'T'
        actual_letter(m-num_letters_train) = 20;
    end
    if letter == 'U'
        actual_letter(m-num_letters_train) = 21;
    end
    if letter == 'V'
        actual_letter(m-num_letters_train) = 22;
    end
    if letter == 'W'
        actual_letter(m-num_letters_train) = 23;
    end
    if letter == 'X'
        actual_letter(m-num_letters_train) = 24;
    end
    if letter == 'Y'
        actual_letter(m-num_letters_train) = 25;
    end
    if letter == 'Z'
        actual_letter(m-num_letters_train) = 26;
    end



% correct_per_iteration_matrix(m-num_letters_train) = total_correct;

end

%%%%%%%%%%%%%%%%%%%%%%TOTAL ERRORS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

correct_matrix = zeros(1,num_letters_test);
for i = 1:num_letters_test
    if actual_letter(i) == maximum_letter(i)
        if actual_letter(i) ~= 0
        correct_matrix(i) = 1;
        end
    end
end

total_correct = sum(correct_matrix);

predicted_correct_over_total_correct = total_correct/num_letters_test*100;


% x = linspace


% display(['For Number of Hidden Neurons of ' num2str(num_hid_nrns)]);
display(['Percent of Correct Predictions: ' num2str(predicted_correct_over_total_correct) '%']);
        
% end





%%%%%%%%%%%%%%%%%%%%%%%%Plot CDF%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear i temp

display('done');