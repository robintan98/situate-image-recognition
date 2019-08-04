%%%%%%%%%%%%%%%%%%Principal Component Analysis Practice%%%%%%%%%%%%%%%%%%

clear all
clc

load('features1.mat')
clear images; clear positive; clear negative
addpath('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\HandshakeLabeled\personmyright');
addpath('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\HandshakeLabeled\personmyleft');
addpath('C:\Users\Robin Tan\Documents\Robin Tan\2016 ASE\HandshakeLabeled\HandshakeLabeled\handshake');
%%Order: Handshake, Left, Right

hogs = hogs(1:320,:);
cnns = cnns(1:320,:); %%% 1:320 for handshake, 321:640 for left, 642:960 for right

hogsco = pca(hogs);
cnnsco = pca(cnns);

%Most important column

hogsco1 = hogsco(:,1);
hogs = hogs * hogsco1;
cnnsco1 = cnnsco(:,1);
cnns = cnns * cnnsco1;