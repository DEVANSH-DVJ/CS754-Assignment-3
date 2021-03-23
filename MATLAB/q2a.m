clc;
clear;
close all;

% Reading
slice = cast(imread("data/slice_50.png"),'double');
H = size(slice, 1);
W = size(slice, 2);
% figure; imshow(cast(slice, 'uint8'));

% Padding
orig = zeros(W,W,'double');
orig(18:17+H, :) = slice;
N = W;
% figure; imshow(cast(orig, 'uint8'));
clear H W slice;

angles = 0:10:170;

tomo = radon(orig, angles);

recon = iradon(tomo, angles, N);
figure; imshow(cast(recon, 'uint8'));

