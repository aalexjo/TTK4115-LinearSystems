clear all;
close all;
load('wave.mat')
[Sx, f] = pwelch(deg2rad(psi_w(2,:)), 4096, [], [], 10);

Sx = Sx./(2*pi);
omega = f .* (2*pi);
index = find(Sx == max(Sx));
w_0 = omega(index);

figure;
plot(omega, Sx)
title('PSD');
xlabel('w [rad]');
hold on;
legend('Sx')

sigma = sqrt(max(Sx));
omega_p = 0:0.01:6.28;
    
for lamda = 0.04:0.02:0.12
    P = zeros(1, 6.28/0.01);
    i = 1;
    for w = 0:0.01:6.28
        P(i) = (w^2 * (2*lamda*w_0*sigma)^2)/((w_0^2 - w^2)^2 + (2*lamda*w_0*w)^2);
        i = i+1;
    end
    omega_p = 0:0.01:6.28;
    plot(omega_p, P)
    xlim([0, pi/2])
end

hold off;

%Use LSQcurve
fun = @(l, omega)(( omega.^2*(2*l*w_0*sigma).^2)./((w_0^2 - omega.^2).^2 + (2*l*w_0.*omega).^2));

lamda_0 = [0.08];
lamda = lsqcurvefit(fun, lamda_0, omega, Sx);
P = zeros(1, 6.28/0.01);
i = 1;

for w = 0:0.01:6.28
    P(i) = (w^2 * (2*lamda*w_0*sigma)^2)/((w_0^2 - w^2)^2 + (2*lamda*w_0*w)^2);
    i = i+1;
end

plot(omega, Sx)
title('PSD');
xlabel('w [rad]');
hold on;
omega_p = 0:0.01:6.28;
plot(omega_p, P)
xlim([0, pi/2])
legend('Sx', 'lsq curvefit')


%Set controller values:
K = 0.1556;
T = 70.5470;

Td = T;
Tf = 8.4;
Kpd = 0.8390;