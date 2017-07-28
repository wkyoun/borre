function nw5(m,n)
%NW5    Plots a posteriori standard deviation of each levelling
%       point in a regular m by n network.
%       The normals are generated by means of the Kronecker product.
%       The basic problem (k = 3) is the so-called free network
%       with singular N-matrix. If a boundary is kept fixed
%       we delete the corresponding columns and rows,
%       and dimensions are deminished accordingly.

%Kai Borre June 3, 1998
%Copyright (c) by Kai Borre
%$Revision: 1.0 $  $Date: 2000/12/16 $

if m < 2 | n < 2
   display('Dimensions too small');
   break
end

kr = figure;
figure(kr)
k = menu('Boundary conditions', ...
	      'fixing W and E boundary', ...
	      'all boundaries fixed', ...
	      'all boundaries free');
D = diag(-ones(n-1,1));
D = [D zeros(n-1,1)];
H = diag(ones(n-1,1),1);
H = H(1:n-1,:);
A = D+H;
NA = A'*A;
D = diag(-ones(m-1,1));
D = [D zeros(m-1,1)];
H = diag(ones(m-1,1),1);
H = H(1:m-1,:);
B = D+H;
NB = B'*B;
if k == 1
   NA = NA(2:n-1,2:n-1); 
   n = n-2;
end     % fixing W & E boundaries
if k == 2 
   NA = NA(2:n-1,2:n-1);
   n = n-2;
   NB = NB(2:m-1,2:m-1);
   m = m-2; 
end     % fixing all boundaries
Id = eye(m,m);
NoA = kron(Id,NA);
Id = eye(n,n);
NoB = kron(NB,Id);
N = NoA+NoB;
if k == 3
   Sigmax = pinv(N);
else
   Sigmax = inv(N);
end
for i = 1:m
  for j = 1:n
    sigma(i,j) = sqrt(Sigmax((i-1)*(n)+j,(i-1)*(n)+j));
  end
end

subplot(211)
axis('square')
cp = contour(sigma); clabel(cp)
title('Standard deviations in 2-D levelling network')
subplot(212)
axis('auto')
mesh(sigma)
view(45,60), pause
%same plot of sigma, but from another viewpoint
ks = figure;
figure(ks)
mesh(sigma)
view(120,30)
print -deps nw5 
%%%%%%%%%%%%%% end nw5.m  %%%%%%%%%%%%%%