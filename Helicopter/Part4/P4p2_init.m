%P4P2 integral
clear all;
clf
init_heli_all()

%Controller
A_reg = [[0 1 0];[0 0 0];[0 0 0]];
B_reg = [[0 0]; [0 k_1]; [k_2 0]];
C_reg = [[1 0 0];[0 0 1]]

%Q_reg = [[100 0 0]; [0 10 0]; [0 0 100]]
%R_reg = [[1 0];[0 1]]
Q_reg = diag([10000,10,100000])
R_reg = diag([100,100])


K = lqr(A_reg, B_reg, Q_reg, R_reg)

P = inv(C_reg*inv(B_reg*K-A_reg)*B_reg)

sys_pol = eig(A_reg-B_reg*K);


%Estimator
A_hat = [0 1 0 0 0 0; zeros(1, 6); 0 0 0 1 0 0;zeros(1, 6); 0 0 0 0 0 1; k_3 0 0 0 0 0];
B_hat = [0 0 ;0 k_1; 0 0; k_2 0; 0 0; 0 0];
C_hat = [[1 0 0 0 0 0];[0 0 1 0 0 0]; [0 0 0 0 1 0]];

r = 5;
theta = pi/3;

i = 1;

for p = (pi-theta:(2*theta)/5:pi+theta)
    poles(i)=r*exp(p*1j);
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
ylim([-30, 30])

L = place(A_hat', C_hat', poles)'

O = obsv(A_hat, C_hat); %Calculate Observability Matrix
rank(O) %Check rank for Observability Matrix

