%P4P2 integral
clear all;
clf
init_heli_all()

%Controller
A_reg = [0 1 0 0 0;0 0 0 0 0; 0 0 0 0 0;1 0 0 0 0; 0 0 1 0 0];
B_reg = [0 0 ;0 k_1; k_2 0; 0 0; 0 0];
C_reg = [[1 0 0 0 0];[0 0 1 0 0]];
F = [1 0; 0 1];

Q_reg = diag([10000,10,10000, 100, 10000])
R_reg = diag([75,100])

K = lqr(A_reg, B_reg, Q_reg, R_reg);

sys_pol = eig(A_reg-B_reg*K);

A = [[0 1 0];[0 0 0];[0 0 0]];
B = [[0 0]; [0 k_1]; [k_2 0]];
C = [[1 0 0];[0 0 1]];

K_new = [K(1, 1:3); K(2, 1:3)];

P = inv(C*inv(B*K_new-A)*B);


%Estimator
A_hat = [0 1 0 0 0 0; zeros(1, 6); 0 0 0 1 0 0;zeros(1, 6); 0 0 0 0 0 1; k_3 0 0 0 0 0]
B_hat = [0 0 ;0 k_1; 0 0; k_2 0; 0 0; 0 0]
C_hat = [[1 0 0 0 0 0];[0 0 1 0 0 0]; [0 0 0 0 1 0]]

r = 42;
theta = pi/3;

i = 1;

for p = (pi-theta:(2*theta)/5:pi+theta)
    poles(i)=r*exp(p*1j);
    i = i + 1;
end
poles = cplxpair(poles)

figure(1);
plot(real(poles),imag(poles), 'o');
hold on;
plot(real(sys_pol),imag(sys_pol), '+');
grid on;
axis equal;
hold off;
ylim([-80, 80])

L = place(A_hat', C_hat', poles)'

O = obsv(A_hat, C_hat) %Calculate Observability Matrix
rank(O) %Check rank for Observability Matrix

