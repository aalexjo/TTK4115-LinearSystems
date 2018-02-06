clear all;
init_heli_all()

A = [0 1 0 0 0;0 0 0 0 0; 0 0 0 0 0;1 0 0 0 0; 0 0 1 0 0]
B = [0 0 ;0 k_1; k_2 0; 0 0; 0 0]
C = [[1 0 0 0 0];[0 0 1 0 0]]
F = [1 0; 0 1]

Q = diag([10000,10,10000, 100, 10000])
R = diag([75,100])

K = lqr(A, B, Q, R)

sys_pol = eig(A-B*K)

A = [[0 1 0];[0 0 0];[0 0 0]];
B = [[0 0]; [0 k_1]; [k_2 0]];
C = [[1 0 0];[0 0 1]];

K_new = [K(1, 1:3); K(2, 1:3)]

P = inv(C*inv(B*K_new-A)*B)