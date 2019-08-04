%%%%%%%%%%%%%%%%%%% K-Means Algorithm %%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%Handwriting_input.m

clear all
clc

%%Read in Data

readfl = dlmread('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\optdigits.txt');
spl = readfl;

%%Initialize Variables for Input

n = 100; %Number of numbers wanted
store = zeros(n, 64);
real_val = ones(n, 1);

%%%%%%%%%%%%%%%%%%Bryan_kmeans2

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

%% Create Initial Scatter

rd_x = normrnd(5, 1, 20, 10);
rd_y = normrnd(10, 3, 20, 10);
rd_z = normrnd(15, 3, 20, 10);

%Process Number data into vectors
store = zeros(length(re_store)/8, 8);
 for i = 1:length(re_store)/8
    for j = 1:8
        for p = 1:7
            store(i, j) =  store(i, j) + re_store(8*(i-1)+1 + p, j);
        end
    end
    store(i, j) = store(i, j)/8;
 end
rd_f = store;

%% Declare Parameters

[num_row, dim] = size(rd_f); %Number of elements and dimensions
k = 12; %Number of clusters
centroid_initial = zeros(k, 1);
threshhold = zeros(k, dim);
for i = 1:k
    for j = 1:dim
        threshhold(i, j) = 0.0001; 
    end
end 
%% Initialize Centroids

rd = randi([1, num_row]);
for i = 1:k
    done = 0;
    while done == 0
        done = 1;
        for j = 1:k
            if centroid_initial(j, 1) == rd
                 rd = randi([1, num_row]);
                 done = 0;
            end
        end
    end 
    centroid_initial(i, 1) = rd;
end

centroid = zeros(k, dim);
for i = 1:k
    centroid(i, :) = rd_f(centroid_initial(i, 1), :);
end
%% Repeat until no change

for ii = 1:15

    cluster_mean = zeros(k, dim);
    cluster_sum = zeros(k, dim);
    cluster_vals = zeros(k, num_row);
    group = zeros(1, k);

    %%Compare Distances and Categorize
    for i = 1:num_row
        min = 10000000000;
        for j = 1:k
            d = pdist2(rd_f(i, :), centroid(j, :));
            if d < min
                min = d;
                cat = j; %Store new cluster
            end
        end
        group(1, cat) = group(1, cat) + 1; %Counts number in group
        for j = 1:dim  %CHECK IF DIM IS CORRECT INSTEAD OF 2
            cluster_sum(cat, j) = cluster_sum(cat, j) + rd_f(i, j); %Stores value into cluster
        end
        cluster_vals(cat, group(1, cat)) = i; %stores instances that go into each cluster
    end 
    
    %%Calculate new Centroids with Mean of Categories
    
    for i = 1:k 
        cluster_mean(i, :) = cluster_sum(i, :)./group(1, i);
    end
    
    test = 1;
    for i = 1:k
        for j = 1:dim
            if abs(centroid(i, j) - cluster_mean(i, j)) < threshhold(i,j)
                centroid(i, j) - cluster_mean(i, j);
            else
                test = 0;
                break;
            end
        end
    end 
    
    if test == 1
        break;
    end
    
    centroid = cluster_mean;
    cluster_sum;
    centroid;
    group;
    %%Repeat until no change in Centroids
end

%%Plot New Centroids

hand = zeros(k, 100);

for i = 1:k
    for j = 1:group(1,i)
        hand(i, j) = real_val(cluster_vals(i, j));
    end
end
