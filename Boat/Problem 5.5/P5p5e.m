clear all;
close all;
controller;
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
A = [[0, 1, 0, 0, 0];
     [-w_0^2, -2*lamda*w_0, 0, 0, 0];
     [0, 0, 0, 1, 0];
     [0, 0, 0, -1/T, -K/T];
     [0, 0, 0, 0, 0]];
 
B = [0, 0, 0, K/T, 0]';

C = [0, 1, 1, 0, 0];

E = [[0, 0];[K_w, 0];[0, 0];[0, 0];[0, 1]];

system = ss(A, E, C, []);

[Ad, Bd] = c2d(A, B, 0.1);

[a, Ed] = c2d(A, E, 0.1);

Cd = C;

Q = [[30, 0];[0, 10^-6]];
R = 0.001977259087647/0.1;

P_ = [[1, 0, 0, 0, 0];[0, 0.013, 0, 0, 0];[0, 0, pi^2, 0, 0];[0, 0, 0, 1, 0];[0, 0, 0, 0, 2.5*10^-3]];
P = P_;
x0  = [0;0;0;0;0];
data = struct('Ad', Ad, 'Bd', Bd, 'Cd', Cd, 'Ed', Ed, 'R', R, 'Q', Q, 'P_', P_, 'x0', x0)


