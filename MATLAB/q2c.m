clc;
clear;
close all;

addpath("l1_ls_matlab");

% Reading
slice1 = cast(imread("data/slice_51.png"),'double');
slice2 = cast(imread("data/slice_52.png"),'double');
H = size(slice1, 1);
W = size(slice1, 2);
% figure; imshow(cast(slice1, 'uint8'));
% figure; imshow(cast(slice2, 'uint8'));

% Padding
orig1 = zeros(W,W,'double');
orig2 = zeros(W,W,'double');
orig1(18:17+H, :) = slice1;
orig2(18:17+H, :) = slice2;
N = W;
% figure; imshow(cast(orig1, 'uint8'));
% figure; imshow(cast(orig2, 'uint8'));
clear H W slice1 slice2;

% Angles of Projection
angles1 = 0:10:170; % Uniformly spaced angles
angles2 = 5:10:175; % Uniformly spaced angles
Q = size(angles1, 2);

% Creating Tomographic Projections
tomo1 = radon(orig1, angles1);
tomo2 = radon(orig2, angles2);
M = size(tomo1, 1);

% Creating objects of Forward matrix
A  = CCS2(N, M, angles1, angles2);
At = A';
y = [reshape(tomo1, [M*Q 1]); reshape(tomo2, [M*Q 1]);];

% Reconstruction using 2 slice Coupled CS
% lambda_max = find_lambdamax_l1_ls(At,y);
lambda = 1;
[x, status] = l1_ls(A, At, 2*M*Q, 2*N*N, y, lambda);
recon1 = idct2(reshape(x(1 : N*N), [N N]));
recon2 = idct2(reshape(x(1 : N*N) + x(N*N+1 : 2*N*N), [N N]));

% Result
figure; imshow(cast([orig1 recon1; orig2 recon2;], 'uint8'));
imwrite(cast([orig1 recon1; orig2 recon2;], 'uint8'), 'results/q2c_1.png');
