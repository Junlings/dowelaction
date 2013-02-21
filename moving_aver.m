function [ y ] = moving_aver( x,b)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a = 1;
y = filter(b,a,x);

% for plot the difference

%{
figure;
hold on;
plot(1:length(x),x,'-ro');
plot(1:length(y),y,'-.b');
hleg1 = legend('Original Data','Filtered Data');
set(hleg1,'Location','NorthWest')
title('Filter results')
%}

end

