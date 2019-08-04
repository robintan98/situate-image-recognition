addpath('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE')
global net layer;

models = {};

for type = {'person_my_left', 'handshake', 'person_my_right'}

    %% Load the images
    
    % --- you probably want to change these lines
    negative = image_files(['/home/rsoiffer/Desktop/crops/' type{1} '_negative']);
    positive = image_files(['/home/rsoiffer/Desktop/crops/' type{1} '_positive']);
    % ---
    
    files = [negative; positive];

    data = load_cnn_data(files);
    labels = [map(1:size(negative, 1), @(x) 'neg') map(1:size(positive, 1), @(x) 'pos')];

    %% Train an SVM model with 10-fold crossvalidation and score each image
    disp('Creating SVM model');
    svm_model = fitcsvm(data, labels, ...
        'KernelFunction','linear','Standardize',true,'ClassNames',{'neg','pos'});

    svm_model = svm_model.fitPosterior().compact();
    models{end+1} = svm_model;
end
models = models';