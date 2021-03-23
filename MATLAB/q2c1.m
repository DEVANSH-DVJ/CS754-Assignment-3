clc;
clear;
close all;

addpath("l1_ls_matlab");

% Reading
slice1 = cast(imread("data/slice_51.png"),'double');
slice2 = cast(imread("data/slice_52.png"),'double');
H = size(slice1, 1);
W = size(slice1, 2);
% figure; imshow(cast(slice, 'uint8'));

% Padding
orig1 = zeros(W,W,'double');
orig2 = zeros(W,W,'double');
orig1(18:17+H, :) = slice1;
orig2(18:17+H, :) = slice2;
N = W;
% figure; imshow(cast(orig, 'uint8'));
clear H W slice1 slice2;

angles1 = 0:10:170;
angles2 = 5:10:175;
Q = size(angles1, 2);

tomo1 = radon(orig1, angles1);
tomo2 = radon(orig2, angles2);
M = size(tomo1, 1);

A  = CCS2(N, M, angles1, angles2);
At = A';
y = [reshape(tomo1, [M*Q 1]); reshape(tomo2, [M*Q 1]);];

lambda_max = find_lambdamax_l1_ls(At,y);
[x, status] = l1_ls(A, At, 2*M*Q, 2*N*N, y, 10);
figure; imshow(cast(idct2(reshape(x(1:N*N), [N N])), 'uint8'));
figure; imshow(cast(idct2(reshape(x(1:N*N) + x(N*N+1:2*N*N), [N N])), 'uint8'));

