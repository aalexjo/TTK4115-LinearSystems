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

