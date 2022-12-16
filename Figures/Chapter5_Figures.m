%% Hilary Palevsky
% Code will produce figures in Chapter 5 of OOI BGC Sensor Best Practices
% CSV files are in BioOptics folder of this repo
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

%% Figure 5.3 Seawater backscatter correction

bs = readtable('BO_F4_1_10_MAR_2021_Particulate_Backscatter_calculated.csv','TextType','string');
M = 4; L = 2;
X = 200;

ind = [1400:4500];

figure(1); clf

set(gcf,'color','w')
height=9;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth/1.3,height])

subplot(121)
plot(bs.backscatter(ind), bs.depth(ind), '.','Color',blue,'markersize',M); hold on;
h1 = plot(movmedian(bs.backscatter(ind),X), movmedian(bs.depth(ind),X), '-','Color',navy,'linewidth',L); hold on;
plot(bs.particulate(ind), bs.depth(ind), '.','Color',red,'markersize',M); hold on;
h2 = plot(movmedian(bs.particulate(ind),X), movmedian(bs.depth(ind),X), '-','Color',maroon,'linewidth',L); hold on;

axis ij
xlim([0 0.002])
legend([h1 h2], 'Total','Particulate','location','N')
title('Backscatter')
ylabel('Depth (m)')

subplot(122)
plot(bs.seawater_scattering_coefficient(ind), bs.depth(ind), '.','Color','k','markersize',M); hold on;
plot(movmedian(bs.seawater_scattering_coefficient(ind),X), movmedian(bs.depth(ind),X), '-','Color','k','linewidth',L); hold on;
axis ij
title('Seawater Scattering')

%% Chapter 5 Worked Example

chl = readtable('chl_raw_to_corrected.csv','TextType','string');
bottle = readtable('sensor_bottle_match.csv','TextType','string');
bottle_all = readtable('BO_F6_8_26_JUN_2018_cast_CTD002_Discrete_and_CTD_data.csv','TextType','string');
S = 0.29864436;

indbot = find(bottle_all.DiscreteChlorophyll_ug_L_ > 0);
L = 1.5;
xmin = -0.05; xmax = 2;

figure(2); clf

set(gcf,'color','w')
height=9;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth/1.7,height])

plot(chl.chlora, chl.depth, '-', 'color',blue,'linewidth',L); hold on;
plot(bottle_all.DiscreteChlorophyll_ug_L_(indbot), bottle_all.CTDDepth_m_(indbot), 'ko','MarkerSize',6,'MarkerFaceColor','w');
plot(bottle.DiscreteChlorophyll_ug_L_, bottle.CTDDepth_m_, 'ko','MarkerSize',6,'MarkerFaceColor','k');
axis ij
ylabel('Depth (m)')
xlabel('Chlorophyll (\mug/L)')
legend('Uncorrected sensor data','Discrete, above chl max','Discrete, below chl max','location','SE')
xlim([xmin xmax])

figure(3); clf

set(gcf,'color','w')
height=9;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth/1.7,height])

plot(chl.chlora, chl.depth, '-', 'color',blue,'linewidth',L); hold on;
plot(chl.chlora_dark, chl.depth, '-', 'color',grey,'linewidth',L-0.5); hold on;

axis ij
ylabel('Depth (m)')
xlabel('Chlorophyll (\mug/L)')
legend('Uncorrected sensor data','Dark corrected sensor data','location','SE')
xlim([xmin xmax])


figure(4); clf

set(gcf,'color','w')
height=9;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth/1.7,height])

plot(chl.chlora, chl.depth, '-', 'color',blue,'linewidth',L); hold on;
plot(chl.chlora_corr, chl.depth, '-', 'color',green,'linewidth',L+1); hold on;
plot(bottle_all.DiscreteChlorophyll_ug_L_(indbot), bottle_all.CTDDepth_m_(indbot), 'ko','MarkerSize',6,'MarkerFaceColor','w');
plot(bottle.DiscreteChlorophyll_ug_L_, bottle.CTDDepth_m_, 'ko','MarkerSize',6,'MarkerFaceColor','k');
axis ij
ylabel('Depth (m)')
xlabel('Chlorophyll (\mug/L)')
legend('Uncorrected sensor data','Corrected sensor data','Discrete, above chl max','Discrete, below chl max','location','SE')
xlim([xmin xmax])

figure(5); clf

set(gcf,'color','w')
height=5.5;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth/1.6,height])
xmin = -0.02; xmax = 0.51; ymin = -0.1; ymax = 1.8;

P = polyfit(bottle.DiscreteChlorophyll_ug_L_, bottle.sensor_match, 1);

plot(bottle.DiscreteChlorophyll_ug_L_, bottle.sensor_match, 'ko','MarkerSize',5,'MarkerFaceColor','k'); hold on;
plot([0:0.1:0.5], [0:0.1:0.5]*1/S, '-','linewidth',L,'color',green)
plot([0:0.1:0.5], [0:0.1:0.5], '--','linewidth',L/2,'color','k')
axis([xmin xmax ymin ymax])
legend('Discrete, below chl max','Linear regression','1:1 line','location','NW')
xlabel('Discrete sample chlorophyll (\mug/L)')
ylabel('Sensor chlorophyll (\mug/L)')

