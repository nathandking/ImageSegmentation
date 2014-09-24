%% Code to determine time and space step sizes that satisfy MBO condition 
clear all
close all

T = 3/256;

for i = 5:9
    N = 2^i;
    
    R0 = 0.25;
    dx = 1/N;
    lower = R0*dx
    T_lower = T/(2^(i-5))
    (2^(i-5))
end
upper = R0^2