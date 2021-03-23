function res = mtimes(A,x)

if A.adjoint == 0 % A*x
    res = reshape(radon(idct2(reshape(x, [A.N A.N])), A.angles), [A.tomo_len1*A.tomo_len2 1]);
else % At*x
    res = reshape(dct2(iradon(reshape(x, [A.tomo_len1 A.tomo_len2]), A.angles, A.N)), [A.N*A.N 1]);
end
