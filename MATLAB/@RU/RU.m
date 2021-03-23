function  res = RU(N, tomo_len, angles)

res.adjoint = 0;
res.N = N;
res.tomo_len1 = tomo_len;
res.tomo_len2 = size(angles, 2);
res.angles = angles;

% Register this variable as a RU class
res = class(res, 'RU');
