K = 0.1556;
T = 70.5470;

clf;
close all;
figure;
plot(compass_ref_ror.time, [compass_ref_ror.signals.values])
legend('measured angle', 'reference', 'u', 'actual rudder angle')
title('Compass');
xlabel('time [s]')
ylabel('angle [deg]')
grid on;
xlim([0, 300])

max_a = max([compass.signals.values])
min_a = min(compass.signals.values(1000:2000))

a = (max_a - min_a)/2