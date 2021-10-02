% 'who' command to see all the existing variables ; 'whos' for more detail
% 'help elfun to see all the elementary functions'

%%

% The coefficients of the general equations are kept in a row vector after
% calculation
n = input('Number of nodes');
c0 = input('First Node value');
cn = input('Final Node Value');
P = input('Enter the general polynomial co-effs and constants in a row vector');
np = length(P);
A = zeros(n-2,n-2);
b = ones(n-2,1)*P(np);

b(1) = b(1) - P(1)*c0 ;
b(n-2)= b(n-2) - P(np-1)*cn;

A(1,1:(np-2))= P(2:(np-1));
A(n-2,(3:n-2))= P(1:(np-2));

for k = 2:(n-3)
    A(k,(k-1):(k+np-3)) = P(1:(np-1));
end

disp(A);
disp(b);

