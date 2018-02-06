clf;
close all;
figure;
plot(scope_compass.time, [scope_compass.signals.values])
legend('measured angle', 'estimated angle', 'reference')%, 'rudder angle', 'rudder bias')
title('Compass');
xlabel('time [s]')
ylabel('angle [deg]')
grid on;
xlim([0, 300])

figure;
plot(scope_rudder.time, [scope_rudder.signals.values])
legend('rudder angle', 'rudder bias')%, 'rudder angle', 'rudder bias')
title('Rudder');
xlabel('time [s]')
ylabel('angle [deg]')
grid on;
xlim([0, 300])

max_a = max([compass.signals.values])
min_a = min(compass.signals.values(1000:2000))

a = (max_a - min_a)/2