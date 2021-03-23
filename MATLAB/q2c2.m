clc;
clear;
close all;

addpath("l1_ls_matlab");

% Reading
slice1 = cast(imread("data/slice_53.png"),'double');
slice2 = cast(imread("data/slice_54.png"),'double');
slice3 = cast(imread("data/slice_55.png"),'double');
H = size(slice1, 1);
W = size(slice1, 2);
% figure; imshow(cast(slice1, 'uint8'));
% figure; imshow(cast(slice2, 'uint8'));
% figure; imshow(cast(slice3, 'uint8'));

% Padding
orig1 = zeros(W,W,'double');
orig2 = zeros(W,W,'double');
orig3 = zeros(W,W,'double');
orig1(18:17+H, :) = slice1;
orig2(18:17+H, :) = slice2;
orig3(18:17+H, :) = slice3;
N = W;
% figure; imshow(cast(orig1, 'uint8'));
% figure; imshow(cast(orig2, 'uint8'));
% figure; imshow(cast(orig3, 'uint8'));
clear H W slice1 slice2 slice3;

angles1 = 0:10:170;
angles2 = 3:10:173;
angles3 = 6:10:176;
Q = size(angles1, 2);

tomo1 = radon(orig1, angles1);
tomo2 = radon(orig2, angles2);
tomo3 = radon(orig3, angles3);
M = size(tomo1, 1);

A  = CCS3(N, M, angles1, angles2, angles3);
At = A';
y = [reshape(tomo1, [M*Q 1]); reshape(tomo2, [M*Q 1]);  reshape(tomo3, [M*Q 1]);];

lambda_max = find_lambdamax_l1_ls(At,y);
[x, status] = l1_ls(A, At, 3*M*Q, 3*N*N, y, 100);
figure; imshow(cast(idct2(reshape(x(1:N*N), [N N])), 'uint8'));
figure; imshow(cast(idct2(reshape(x(1:N*N) + x(N*N+1:2*N*N), [N N])), 'uint8'));
figure; imshow(cast(idct2(reshape(x(1:N*N) + x(2*N*N+1:3*N*N), [N N])), 'uint8'));

