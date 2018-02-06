K = 0.1556;
T = 70.5470;

clf;
close all;
figure;
plot(compass.time, [compass.signals.values])
legend('measured angle', 'model angle')
title('Compass');
xlabel('time [s]')
ylabel('angle [deg]')
grid on;
xlim([0, 1000])

max_a = max([compass.signals.values])
min_a = min(compass.signals.values(1000:2000))

a = (max_a - min_a)/2
