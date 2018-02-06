%clear all;
init_heli_all()

%Controller
A_reg = [0 1 0 0 0;0 0 0 0 0; 0 0 0 0 0;1 0 0 0 0; 0 0 1 0 0];
B_reg = [0 0 ;0 k_1; k_2 0; 0 0; 0 0];
C_reg = [[1 0 0 0 0];[0 0 1 0 0]];
F = [1 0; 0 1];

Q_reg = diag([150,50,150, 10, 10])
R_reg = diag([2,20])

K = lqr(A_reg, B_reg, Q_reg, R_reg);

sys_pol = eig(A_reg-B_reg*K);

A = [[0 1 0];[0 0 0];[0 0 0]];
B = [[0 0]; [0 k_1]; [k_2 0]];
C = [[1 0 0];[0 0 1]];

K_new = [K(1, 1:3); K(2, 1:3)];

P = inv(C*inv(B*K_new-A)*B);

%Estimator

A_hat = [0 1 0 0 0 0; zeros(1, 6); 0 0 0 1 0 0;zeros(1, 6); 0 0 0 0 0 1; k_3 0 0 0 0 0];

C_bad_hat = [[1 0 0 0 0 0];[0 0 1 0 0 0];];

O = obsv(A_hat, C_bad_hat); %Calculate Observability Matrix for pitch and elevation
rank(O) %System is observable if this equals 6

C_hat = [[0 0 1 0 0 0]; [0 0 0 0 1 0]];

O = obsv(A_hat, C_hat); %Calculate Observability Matrix for elevation and lamda
rank(O) %System is observable if this equals 6

%B hat
B_hat = [0 0 ;0 k_1; 0 0; k_2 0; 0 0; 0 0]

r = 24.928;
%theta = pi/12;

i = 1;

for p = 1:6%(pi-theta:(2*theta)/5:pi+theta)
    poles(i)=-(r+i/10)%*exp(0*1j);
    i = i + 1;
end
poles = cplxpair(poles)

figure(8);
plot(real(poles),imag(poles), 'o');
hold on;
plot(real(sys_pol),imag(sys_pol), '+');
grid on;
axis equal;
hold off;

L = place(A_hat', C_hat', poles)'
