function [sys,x0,str,ts] = DiscKal(t,x,u,flag,data) %DiscKal(t,x,u,flag,data) if method 2 is used
% Shell for the discrete kalman filter assignment in
% TTK4115 Linear Systems.
%
% Author: Jørgen Spjøtvold
% 19/10-2003 
%

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(data);%mdlInitializeSizes(data); if method 2 is used
    
  %%%%%%%%%%%%%
  % Outputs   %
  %%%%%%%%%%%%%
  
  case 3,
    sys=mdlOutputs(t,x,u, data); % mdlOutputs(t,x,u,data) if mathod 2 is used
  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  
  case 2,
    sys=mdlUpdate(t,x,u,data); %mdlUpdate(t,x,u, data); if method 2 is used
  
  case {1,4,}
    sys=[];

  case 9,
      sys=mdlTerminate(t,x,u);
  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end

function [sys,x0,str,ts]=mdlInitializeSizes(data) %mdlInitializeSizes(data); if method 2 is used
% This is called only at the start of the simulation. 

sizes = simsizes; % do not modify

sizes.NumContStates  = 0; % Number of continuous states in the system, do not modify
sizes.NumDiscStates  = 35; % Number of discrete states in the system, modify. 
sizes.NumOutputs     = 2; % Number of outputs, the hint states 2
sizes.NumInputs      = 2; % Number of inputs, the hint states 2
sizes.DirFeedthrough = 0; % 1 if the input is needed directly in the
% update part
sizes.NumSampleTimes = 1; % Do not modify  

sys = simsizes(sizes); % Do not modify  

x0(1:5)  = data.x0;%[0;0;0;0;0]; % Initial values for the discrete states, modify
x0(6:10) = data.x0;
x0(11:35) = data.P_(:)';
str = []; % Do not modify

ts  = [-1 0]; % Sample time. [-1 0] means that sampling is
% inherited from the driving block and that it changes during
% minor steps.


function x=mdlUpdate(t,x,u,data),%mdlUpdate(t,x,u, data); if method 2 is used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update the filter covariance matrix and state etsimates here.
% example: sys=x+u(1), means that the state vector after
% the update equals the previous state vector + input nr one.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% u(1) is compass angle
% u(2) is rudder input
% x(1:5): a priori state estimate
% x(6:10): a posteriori state estimate
% x(11:35): a priori P-

P_ = reshape(x(11:35), 5, 5); % P_ is now 5x5 matrix

%Compute Kalman gain
L = P_ * (data.Cd)' * (data.Cd*P_*(data.Cd)' + data.R)^-1;

%Update estimate with measurement
x(6:10) = x(1:5) + L*(u(1) - data.Cd*(x(1:5)));
%update P
P = (eye(5) - L*data.Cd)*P_ *(eye(5) - L*data.Cd)' + L*data.R*L';

%Priori
x(1:5) = data.Ad * x(6:10) + data.Bd*u(2);
P_ = data.Ad*P*(data.Ad)' + data.Ed*data.Q*(data.Ed)';
x(11:35) = P_(:);

function sys=mdlOutputs(t,x,u, data)% mdlOutputs(t,x,u,data) if mathod 2 is used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the outputs here
% example: sys=x(1)+u(2), means that the output is the first state+
% the second input. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sys(1): compass angle
% sys(2): bias to the rudder angle

sys(1) = x(8);
sys(2) = x(10);

function sys=mdlTerminate(t,x,u) 
sys = [];


