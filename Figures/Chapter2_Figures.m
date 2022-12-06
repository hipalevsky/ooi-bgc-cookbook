%% Kristen Fogaren 8/23/22
% Code will produce figures in Chapter 2 of OOI BGC Sensor Best Practices
% CSV files are in shared google drive. 
% https://drive.google.com/drive/folders/1ZQyt2YfRBE1IAxZcQewDwRvfDUufSuoX?usp=sharing
addpath('C:\Users\palevsky\Desktop\DATA_FILES_FOR_FIGURES\oxygen')

%% General plotting stuff 

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

%% Figure 2-2 
glider = readtable('Figure_2-2_Glider.csv','TextType','string');
% variables of depth, oxygen_umol_kg, oxygen_gain_corr_umol_kg
winklers = readtable('Figure_2-2_Winklers.csv','TextType','string');
% variables of depth, oxygen_umol_kg

f = figure(1); clf

set(gcf,'color','w')
height=9;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth/1.75,height])
L = 2;

plot(glider.oxygen_umol_kg,glider.depth,'Linewidth',L,'Color',blue)
hold on
plot(glider.oxygen_gain_corr_umol_kg,glider.depth,'Linewidth',L,'Color',red)
plot(winklers.oxygen_umol_kg,winklers.depth,'ok','MarkerSize',5,'MarkerFaceColor','k')
axis ij
x = gca;
x.XAxisLocation = 'top';
grid off
ylim([0 1050])
xlabel('Oxygen (\mumol kg^-^1)')
ylabel('Depth (m)')
legend('Uncorrected','Corrected','Discrete (Winkler)','Location','SE')

%% Figure 2-3
deepiso = readtable('Figure_2-3.csv','TextType','string');
ymin = 240; ymax = 285;
% variables date and o2

% Izi's file doesn't break up by deployment so I found deployments
% Used diff(deepiso.date), quick and easy, not efficient 
deployment1 = 1:194;
deployment2 = 195:378;
deployment3 = 379:596;
deployment4 = 597:782;
deployment5 = 783:1011;
deployment6 = 1012:1168;

f = figure(2); clf

set(gcf,'color','w')
height=6;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth,height])
L = 1;
tbuf = 15; ybuf = 4;

plot(deepiso.date(deployment1),deepiso.o2(deployment1),'Color',blue,'linewidth',L)
hold on
plot(deepiso.date(deployment2),deepiso.o2(deployment2),'Color',blue,'linewidth',L)
plot(deepiso.date(deployment3),deepiso.o2(deployment3),'Color',blue,'linewidth',L)
plot(deepiso.date(deployment4),deepiso.o2(deployment4),'Color',blue,'linewidth',L)
plot(deepiso.date(deployment5),deepiso.o2(deployment5),'Color',blue,'linewidth',L)
plot(deepiso.date(deployment6),deepiso.o2(deployment6),'Color',blue,'linewidth',L)

plot([deepiso.date(deployment1(1)) deepiso.date(deployment1(1))], [ymin ymax],'k-','linewidth',1);
text(deepiso.date(deployment1(1))+tbuf, ymin+ybuf,'1')
plot([deepiso.date(deployment2(1)) deepiso.date(deployment2(1))], [ymin ymax],'k-','linewidth',1);
text(deepiso.date(deployment2(1))+tbuf, ymin+ybuf,'2')
plot([deepiso.date(deployment3(1)) deepiso.date(deployment3(1))], [ymin ymax],'k-','linewidth',1);
text(deepiso.date(deployment3(1))+tbuf, ymin+ybuf,'3')
plot([deepiso.date(deployment4(1)) deepiso.date(deployment4(1))], [ymin ymax],'k-','linewidth',1);
text(deepiso.date(deployment4(1))+tbuf, ymin+ybuf,'4')
plot([deepiso.date(deployment5(1)) deepiso.date(deployment5(1))], [ymin ymax],'k-','linewidth',1);
text(deepiso.date(deployment5(1))+tbuf, ymin+ybuf,'5')
plot([deepiso.date(deployment6(1)) deepiso.date(deployment6(1))], [ymin ymax],'k-','linewidth',1);
text(deepiso.date(deployment6(1))+tbuf, ymin+ybuf,'6')

x = gca;
xlim([min(deepiso.date)-30 max(deepiso.date)+30])
ylabel('Oxygen (\mumol kg^-^1)')
ylim([ymin ymax])
grid off


%% Figure 2-4
DO1 = readtable('Figure_2-4_DO1.csv','TextType','string');
% variables datenum_wUV oxygen_wUV_umol_kg

DO2 = readtable('Figure_2-4_DO2.csv','TextType','string');
% variables datenum_noUV oxygen_noUV_umol_kg

figure(3); clf

set(gcf,'color','w')
height=6;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth,height])

plot(DO2.datenum_noUV,DO2.oxygen_noUV_umol_kg,'Linewidth',1,'color',blue) 
hold on
plot(DO1.datenum_wUV,DO1.oxygen_wUV_umol_kg,'Linewidth',1.75,'color',red)
datetick
axis tight
ylabel('Oxygen (\mumol kg^-^1)')
xlim([datetime(2017,11,01) datetime(2018,02,01)])
f = gca;
legend('No UV','With UV','Location','NW')
%title({'Oregon Shelf Surface Mooring' 'Near-surface instrument frame'})

%% Figure 2-5
deploy8 = readtable('Figure_2-5_Deploy8File.csv','TextType','string');
% variables datetime, oxygen_uncorrected_umol_kg, oxygen_corrected_umol_kg
deploy9 = readtable('Figure_2-5_Deploy9File.csv','TextType','string');
% variables datetime, oxygen_uncorrected_umol_kg, oxygen_corrected_umol_kg
winklers = readtable('Figure_2-5_Winkler.csv','TextType','string');
% variables CTDBottleClosureTime_UTC DiscreteOyxgen_umolkg

figure(4); clf
L1 = 0.5;
L2 = 1.5;

set(gcf,'color','w')
height=14;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth,height])

subplot(2,1,1)
plot(deploy8.datetime,deploy8.oxygen_uncorrected_umol_kg,'Color',blue,'Linewidth',L1)
hold on
plot(deploy9.datetime,deploy9.oxygen_uncorrected_umol_kg,'Color',teal,'Linewidth',L1)
plot(deploy8.datetime,deploy8.oxygen_corrected_umol_kg,'Color',red,'Linewidth',L1)
plot(deploy9.datetime,deploy9.oxygen_corrected_umol_kg,'Color',red,'Linewidth',L1)
plot(winklers.CTDBottleClosureTime_UTC,winklers.DiscreteOxygen_umolkg,...
    'ok','MarkerSize',5,'MarkerFaceColor','k')
ylabel('Oxygen (\mumol kg^-^1)')
xlim([datetime(2019,4,10) datetime(2020,7,20)])

subplot(2,1,2)
plot(deploy8.datetime,deploy8.oxygen_uncorrected_umol_kg,'Color',blue,'Linewidth',L2)
hold on
plot(deploy9.datetime,deploy9.oxygen_uncorrected_umol_kg,'Color',teal,'Linewidth',L2)
plot(deploy8.datetime,deploy8.oxygen_corrected_umol_kg,'Color',red,'Linewidth',L2)
plot(winklers.CTDBottleClosureTime_UTC,winklers.DiscreteOxygen_umolkg,...
    'ok','MarkerSize',8,'MarkerFaceColor','k')
plot(deploy9.datetime,deploy9.oxygen_corrected_umol_kg,'Color',red,'Linewidth',L2)
plot(winklers.CTDBottleClosureTime_UTC,winklers.DiscreteOxygen_umolkg,...
    'ok','MarkerSize',6,'MarkerFaceColor','k')
ylabel('Oxygen (\mumol kg^-^1)')
legend('Deployment 8','Deployment 9','Corrected','Discrete (Winkler)','Location','southoutside',...
    'Orientation','horizontal')
xlim([datetime(2019,10,20) datetime(2019,10,24)])
ylim([220 270])

%also ask about figure exporting