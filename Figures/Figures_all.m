%% Common code to produce figures for the OOI Biogeochemical Sensor Data Best Practices & User Guide

addpath('data_files_for_figures')
addpath(genpath('C:\Users\palevsky\Documents\GitHub\boundedline-pkg'))

%% General plotting stuff from Kristen

blue = [0     0.44706     0.74118];
red = [0.85098     0.32549    0.098039];
yellow = [0.92941     0.69412     0.12549];
purple = [0.49412     0.18431     0.55686];
green = [0.46667     0.67451     0.18824];
cyan = [0.30196      0.7451     0.93333];
maroon = [0.63529    0.078431     0.18431];
grey = [0.5 0.5 0.5];
lightcyan = [0.67843 0.92157 1];
brightpurple = [0.74902           0     0.74902];
forestgreen = [0     0.49804           0];
teal = [0     0.74902     0.74902];
navy = [0.078431     0.16863     0.54902];

%% Set common plotting info
F = 10;
set(0,'defaultAxesFontSize',F)
x0=2;
y0=2;
fullwidth=15;