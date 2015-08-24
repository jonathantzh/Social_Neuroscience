close all
clear all
clc
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
for i = 1:50
    cla;
    brain_plot_four(rand(14),rand(14),rand(14),rand(14),0.5);
    pause(0.5);
    figure_1(i) = getframe;
end
% Uncomment this to save the movie as avi
% movie2avi(figure_1,'figure_1.avi','quality',100,'fps',5);