% 2D Rocket Simulation with Thrust Vector Control
% @fkvd                               25.12.2020
clc;clear;

% Vertical and Horizontal PVA
x = [0 0];
v = [0 0];
a = [0 0];

% Unit: Radian
angularPosition = pi/2;    % 0: Right     pi/2:Up
angularVelocity = 0;
angularAcceleration = 0;

M = 1;
G = -9.81;
rocketLength = 1;    % 1 m
rocketRadius = 0.1;  % 10 cm

delta = 0.01;
t = 0:delta:10;
F = 12; % Constant Thrust

PVA_X = zeros(length(t),3);
PVA_Y = zeros(length(t),3);
angularPositionLOG = zeros(length(t),1);
vectorLOG = zeros(length(t),1);
fLOG = zeros(length(t),1);

vector = deg2rad(0);     % angle

for m=1:length(t)
    if m>5.5/delta && m<=6.5/delta
        vector = deg2rad(-40); 
    elseif m>6.5/delta && m<=7.5/delta
        vector = deg2rad(40);
    elseif m>7.5/delta
        vector = deg2rad(0);
        F = 0;
    end
    
    %Force along the x-axis (reference to rocket)
    lateralForce = F*sin(vector);
    
    angularAcceleration = (lateralForce*rocketLength/2) / ...
        (((M*rocketLength^2) / 12)+ (M*3*rocketRadius^2)/12);
        % Removed angularAcceleration + delta*
    
    angularVelocity = angularVelocity + angularAcceleration*delta;
    
    angularPosition = angularPosition + angularVelocity*delta + ...
        0.5*(angularAcceleration*delta^2);
    
    angularPosition = mod(angularPosition,2*pi);
    angularPositionLOG(m) = angularPosition;
    vectorLOG(m) = vector;
    fLOG(m) = F;
    
    % x-axis
    a(1) = (F*cos(angularPosition+vector)/M); % Removed a(1)+delta*
    v(1) = v(1) + a(1)*delta;
    x(1) = x(1) + v(1)*delta + (a(1)*delta^2)/2;
    
    % y-axis
    a(2) = ((F*sin(angularPosition+vector)/M) +G); % Removed a(2)+delta*
    v(2) = v(2) + a(2)*delta;
    x(2) = x(2) + v(2)*delta + (a(2)*delta^2)/2;
    
    % Data logging
    PVA_X(m,1) = x(1);  PVA_X(m,2) = v(1);  PVA_X(m,3) = a(1);
    PVA_Y(m,1) = x(2);  PVA_Y(m,2) = v(2);  PVA_Y(m,3) = a(2);   
end


subplot(1,2,1);
plot(t,PVA_X(:,1),'r','linewidth',1.5); hold on;
plot(t,PVA_X(:,2),'b','linewidth',1.5);
plot(t,PVA_X(:,3),'k','linewidth',1.5);
title('x-axis');
xlabel('time');
ylabel('value');
legend('Position ','Velocity','Acceleration','Location','NorthWest');
grid on;

subplot(1,2,2);
plot(t,PVA_Y(:,1),'r','linewidth',1.5); hold on;
plot(t,PVA_Y(:,2),'b','linewidth',1.5);
plot(t,PVA_Y(:,3),'k','linewidth',1.5);
title('y-axis');
xlabel('time');
ylabel('value');
legend('Position ','Velocity','Acceleration','Location','NorthWest');
grid on;
