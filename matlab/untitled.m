%% Example data plotting script
% # CREATED BY: SP
% # DATE: 8/30/14
%
% # DESCRIPTION: This program shows how to correctly plot data using proper
% code formatting
%
%
% Always clear the workspace
clear all; close all;
%% Generate Sample Data
t = 0:0.02:2;
amplitude = 0.12;

% example data - damped sinewave with noise
y = exp(-t).*cos(2*pi*t) + amplitude * randn(1,length(t));

% curve fitting
coeffs = polyfit(t, y, 4);

% Get fitted values
fittedX = linspace(min(t), max(t), 200);
fittedY = polyval(coeffs, fittedX);

%% Plotting
% Bad plot
figure(1)
plot(t,y);

% Better plot
figure(2)
plot(t,y,'ko-', 'LineWidth',1, 'LineSmoothing','on');
% xlim([0 2]); ylim([0 7])
 
set(gca,'FontSize',12);
xlabel('time,t');
ylabel('Position, \theta_{1}');
title('Better Plot');
legend('data')
grid on

% Best plot
figure(3)
plot(t,y,'ko');

% Plot the fitted line
hold on;
plot(fittedX, fittedY, 'k--', 'LineWidth',2, 'LineSmoothing','on');
% xlim([0 2]); ylim([0 7])
set(gca,'FontSize',16);
xlabel('time,t');
ylabel('Position, y');
h = legend('data','4th order curve fit');
set(h,'color','w')
grid on
hold off