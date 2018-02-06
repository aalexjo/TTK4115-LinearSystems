clear all;
close all;
load('wave.mat')
[Sx, f] = pwelch(deg2rad(psi_w(2,:)), 4096, [], [], 10);

Sx = Sx./(2*pi);
omega = f .* (2*pi);
index = find(Sx == max(Sx));
w_0 = omega(index);

lamda = 0.0857; %From part 3
T = 70.54702; %From part 1
K = 0.15566; %From part 1

sigma = 0.0385254418201371; %From part 3
K_w = 2*lamda*w_0*sigma; %From part 3

%No disturbances
A = [[0, 1];[0, -1/T]]
C = [1, 0];
O = obsv(A, C)
rank(O) %Should become 2

%Only current disturbance
A = [[0, 1, 0];[0, -1/T, -K/T];[0, 0, 0]];
C = [1, 0, 0];
O = obsv(A, C)
rank(O) %Should become 3

%Only wave disturbance
A = [[0, 1, 0, 0];[-w_0^2, -2*lamda*w_0, 0, 0];[0, 0, 0, 1];[0, 0, 0, -1/T]];
C = [0, 1, 1, 0];
O = obsv(A, C)
rank(O) %Should become 4

%Full system
A = [[0, 1, 0, 0, 0];
     [-w_0^2, -2*lamda*w_0, 0, 0, 0];
     [0, 0, 0, 1, 0];
     [0, 0, 0, -1/T, -K/T];
     [0, 0, 0, 0, 0]];
 
B = [0, 0, 0, K/T, 0]';

C = [0, 1, 1, 0, 0];

E = [[0, 0];[K_w, 0];[0, 0];[0, 0];[0, 1]];

O = obsv(A, C)
rank(O) %Should become 5