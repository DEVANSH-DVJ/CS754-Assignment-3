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
Q = size(angles, 2);

tomo = radon(orig, angles);
M = size(tomo, 1);

A  = RU(N, M, angles);
At = A';
y = reshape(tomo, [M*Q 1]);

lambda_max = find_lambdamax_l1_ls(At,y);
[x, status] = l1_ls(A, At, M*Q, N*N, y, 0.01);
figure; imshow(cast(idct2(reshape(x, [N N])), 'uint8'));

