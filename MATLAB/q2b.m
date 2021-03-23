clc;
clear;
close all;

addpath("l1_ls_matlab");

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

A  = RU(N, size(tomo,1), angles);
At = A';
y = reshape(tomo, [size(tomo,1)*size(tomo,2) 1]);

lambda_max = find_lambdamax_l1_ls(At,y);
[x, status] = l1_ls(A, At, size(tomo,1)*size(tomo,2), N*N, y, 0.01);
figure; imshow(cast(idct2(reshape(x, [N N])), 'uint8'));



