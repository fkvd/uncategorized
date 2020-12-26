% 1D Simple Rocket Simulation
% @fkvd
% 24.12.2020

% Inital Conditions for PVA
x0 = 0; 
v0 = 0;    
a0 = 0;     
M  = 1;
G = -9.81;

delta = 0.1;
t = 0:delta:20;
F = linspace(12,6,length(t));

PVA = zeros(length(t),3);

% Calculating PVA
for m=1:length(t)
    a0 = delta*((F(m)/M) +G);   % a0 + removed
    v0 = v0 + a0*delta;
    x0 = x0 + v0*delta + (a0*delta^2)/2;
    PVA(m,1) = x0;
    PVA(m,2) = v0;
    PVA(m,3) = a0;
end

% Plotting PVA
plot(t,PVA(:,1),'r','linewidth',1.5); hold on;
plot(t,PVA(:,2),'b','linewidth',1.5);
plot(t,PVA(:,3),'k','linewidth',1.5);
title('Rocket Simulation');
xlabel('time');
ylabel('value');
legend('Altitude','Velocity','Acceleration','Location','NorthWest');
grid on;

