%% Kristen Fogaren 8/23/22
% Figures for Chapter 2 of OOI BGC Sensor Best Practices & User Guide
Figures_all

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
