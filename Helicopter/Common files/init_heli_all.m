% FOR HELICOPTER NR 3-10
% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert høsten 2006 av Jostein Bakkeheim
% Oppdatert høsten 2008 av Arnfinn Aas Eielsen
% Oppdatert høsten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring


%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = 1;
Joystick_gain_y = -1;


%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]
V_ss = 7%1/0.149;

k_f = 1/V_ss * (l_h*(g*m_p*2) - m_c * g *l_c)/l_h
l_1 = l_p * k_f;
l_2 = m_c * g * l_c - l_h*(m_p*g*2);
l_3 = k_f*l_h;
l_4 = -l_3;
j_p = 2*m_p*l_p^2;
j_l = m_c * l_c^2 + 2 * m_p * (l_h^2 + l_p^2);
j_e = m_c * l_c^2 + 2 * m_p * l_h^2;
k_1 = l_1/j_p;
k_2 = l_3/j_e;
k_3 = -(l_2 * l_4)/(l_3 * j_l);



