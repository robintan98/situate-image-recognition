%%%%%%%%%%%%%%Random Generated Training and Testing Sets%%%%%%%%%%%%%%%%
clear all
clc

num_of_images = 400;
% train_over_total = 0.8;
num_of_images_train = num_of_images * 0.8;
num_of_images_test = num_of_images * 0.2;

permutation = randperm(400);

for i = 1:num_of_images_train
    train_array(i) = permutation(i);
end

for i = 1:num_of_images_test
    test_array(i) = permutation(i+num_of_images_train);
end

% clearvars -except train_array test_array