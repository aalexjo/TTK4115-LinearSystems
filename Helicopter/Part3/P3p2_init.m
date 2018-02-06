clear all;
init_heli_all()

A = [[0 1 0];[0 0 0];[0 0 0]];
B = [[0 0]; [0 k_1]; [k_2 0]];
C = [[1 0 0];[0 0 1]]


Q = diag([10000,10,100000])
R = diag([100,100])

K = lqr(A, B, Q, R)

P = inv(C*inv(B*K-A)*B)
