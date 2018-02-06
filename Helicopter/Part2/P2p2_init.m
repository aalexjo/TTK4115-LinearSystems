clear all;
init_heli_all();

% Pitch and elevation, PD controller
w_0 = pi;

k_pp = w_0^2/k_1
k_pd = (2*w_0)/k_1

% Travel, P controller
k_rp = -1.1