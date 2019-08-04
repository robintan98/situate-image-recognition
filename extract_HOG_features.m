%%%%%%%%%%%%%%%%%%%%Extract Hog Features%%%%%%%%%%%%%%%%%%%%

clear all
clc

%Rory:
%% Load the images - handshake

addpath('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\Rory Expository\RorySVM2');

if ~exist('labels', 'var')
    negative = load_images('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\HandshakeLabeled\handshake\');
    positive = load_images('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\HandshakeLabeled\handshake\');

    images = [negative; positive];
    hogs = to_hog_data(images, 80);
%     labels = [map(1:size(negative, 1), @(x) 'no handshake') map(1:size(positive, 1), @(x) 'handshake')];
%     
%     clear negative positive;
% endm(hogs,labels,'KernelFunction','linear','Standardize',true,'ClassNames',{'handshake','no handshake'});
end