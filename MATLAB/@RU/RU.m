function  res = RU(N, M, angles)

res.adjoint = 0;
res.N = N;
res.M = M; % Number of tomographic displacements
res.Q = size(angles, 2);
res.angles = angles;

% Register this variable as a RU class
res = class(res, 'RU');
