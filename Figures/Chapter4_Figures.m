%% Hilary Palevsky 11/17/2022
% Code will produce figures in Chapter 4 of OOI BGC Sensor Best Practices
% CSV files are in shared google drive. 
% https://drive.google.com/drive/u/0/folders/1kL_F7oWQ6wk_rl0UStI4ljkFYcYj0zuE
addpath('C:\Users\palevsky\Desktop\DATA_FILES_FOR_FIGURES\carbonate')
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

%% Figure 4-2 - Example of solenoid valve failure

pco2a = readtable('Figure_4-2_data.csv','TextType','string');
ymin = 100; ymax = 500;
d = [datetime(2015,10,13), datetime(2016,5,13), datetime(2016,9,28)];
M = 4;

figure(1); clf

set(gcf,'color','w')
height=6;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth,height])

plot(pco2a.time, pco2a.surface_partial_pressure_of_carbon_dioxide_in_sea_water,'.-','Color',blue,'markersize',M); hold on;
plot(pco2a.time, pco2a.surface_partial_pressure_of_carbon_dioxide_in_air,'.-','Color',red,'markersize',M); hold on;
plot([d(1) d(1)], [ymin ymax],'k-','linewidth',1);
plot([d(2) d(2)], [ymin ymax],'k-','linewidth',1);
plot([d(3) d(3)], [ymin ymax],'k-','linewidth',1);
text(d(1)+5, ymax-25,'2')
text(d(2)+5, ymax-25,'3')
text(d(3)+5, ymax-25,'4')

ylabel('pCO_2 (\muatm)')
legend('Seawater','Air','location','southwest')
%title({'Coastal Endurance: Washington Shelf Surface Mooring' 'Surface Buoy: Pro-Oceanus CO2 Pro-Atmosphere'})

%% Figure 4-3 - Example of rezeroing error

pco2a_0err = readtable('Figure_4-3_data.csv','TextType','string');
outliers = readtable('Figure_4-3_data_outliers.csv','TextType','string');

figure(2); clf

set(gcf,'color','w')
height=6;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth,height])

plot(pco2a_0err.time, pco2a_0err.surface_partial_pressure_of_carbon_dioxide_in_sea_water,'.-','Color',blue,'markersize',7); hold on;
plot(outliers.time, outliers.surface_partial_pressure_of_carbon_dioxide_in_sea_water,'.','Color',red,'markersize',14); hold on;

xlim([min(pco2a_0err.time)-0.5 max(pco2a_0err.time)+0.5])
ylabel('Seawater pCO_2(\muatm)')
%title({'Coastal Endurance: Oregon Shelf Surface Mooring' 'Surface Buoy: Pro-Oceanus CO2 Pro-Atmosphere'})
legend('Seawater pCO_2','Rezeroing error','location','southeast')

%% Figure 4-4 - Example of annotations

mfnco2 = readtable('Figure_4-4_data.csv','TextType','string');
ymin = 100; ymax = 1000;
annind = find(mfnco2.annotation_flags > 1);

figure(3); clf

set(gcf,'color','w')
height=6;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth,height])

plot(mfnco2.time, mfnco2.partial_pressure_of_carbon_dioxide_in_sea_water,'.','Color',blue); hold on;
plot(mfnco2.time(annind), mfnco2.partial_pressure_of_carbon_dioxide_in_sea_water(annind),'.','Color',red); hold on;
for i = [1,3,5:11,13:16]
    ind = find(mfnco2.deployment == i);
    plot([mfnco2.time(ind(1)) mfnco2.time(ind(1))], [ymin ymax],'k-','linewidth',1);
    text(mfnco2.time(ind(1))+10, ymin+50,num2str(i))
end

ylim([ymin ymax])
xlim([min(mfnco2.time)-30 max(mfnco2.time)+30])
ylabel('Seawater pCO_2(\muatm)')
%title({'Coastal Pioneer: Central Surface Mooring' 'Seafloor Multi-Function Node: SAMI-CO2'})
legend('Data','Annotation','location','northwest')

%% Figure 4-7 - SAMI pH QC

samiph = readtable('Figure_4-7_data.csv','TextType','string');
ymin = 7.6; ymax = 8.55;
idsus = find(samiph.qc_flags == 3);
idbad = find(samiph.qc_flags == 4);

figure(4); clf

set(gcf,'color','w')
height=6;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth,height])

plot(samiph.time, samiph.seawater_ph,'.','Color',blue); hold on;
plot(samiph.time(idsus), samiph.seawater_ph(idsus),'.','Color',yellow); hold on;
plot(samiph.time(idbad), samiph.seawater_ph(idbad),'.','Color',red); hold on;
for i = 1:7
    ind = find(samiph.deployment == i);
    plot([samiph.time(ind(1)) samiph.time(ind(1))], [ymin ymax],'k-','linewidth',1);
    text(samiph.time(ind(1))+10, ymin+0.05,num2str(i))
end

ylim([ymin ymax])
xlim([min(samiph.time)-30 max(samiph.time)+30])
ylabel('Seawater pH')
%title({'Global Irminger Sea: Flanking Subsurface Mooring A' 'Mooring Riser: Seawater pH'})
legend('Observations','Suspect','Bad','location','northeast')

%% Figure 4-6 Comparison with external data

pco2comp = readtable('Figure_4-6_data.csv','TextType','string');
tbuffer = 10;
M = 8;

figure(5); clf

set(gcf,'color','w')
height=12;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth,height])

subplot(211)
plot(pco2comp.time, pco2comp.surface_partial_pressure_of_carbon_dioxide_in_sea_water,'.','Color',blue,'markersize',M); hold on;
plot(pco2comp.time, pco2comp.pmel_nh10_pco2_seawater,'.','Color',red,'markersize',M); hold on;

xlim([min(pco2comp.time)-tbuffer max(pco2comp.time)+tbuffer])
ylabel('Seawater pCO_2(\muatm)')
legend('OOI','PMEL','location','northeast')
%title('Comparison of pCO_2 measured by OOI and PMEL buoys on the Oregon Shelf')

subplot(212)
plot([min(pco2comp.time)-tbuffer max(pco2comp.time)+tbuffer], [0 0],'k-','linewidth',1); hold on;
plot(pco2comp.time, pco2comp.ooi_pmel_pco2_difference,'.','Color',grey,'markersize',M); hold on;

xlim([min(pco2comp.time)-tbuffer max(pco2comp.time)+tbuffer])
ylabel('pCO_2 difference (\muatm)')

%% Worked Example figure

pco2w_sensor = readtable('Figure_4-5_data.csv','TextType','string');
bottle_data = readtable('Figure_4-5_bottle_data.csv','TextType','string');
M = 3; L = 1;

%Calculate correction
T1 = nanmean(datetime(bottle_data.CTDBottleClosureTime_UTC_(1:2)));
T2 = nanmean(datetime(bottle_data.CTDBottleClosureTime_UTC_(3:4)));
ind_T1 = find(pco2w_sensor.time < T1+0.25);
ind_T2 = find(pco2w_sensor.time > T2-0.5);
sensor_T1 = nanmean(pco2w_sensor.partial_pressure_of_carbon_dioxide_in_sea_water(ind_T1));
sensor_T2 = nanmean(pco2w_sensor.partial_pressure_of_carbon_dioxide_in_sea_water(ind_T2));
bottle_T1 = nanmean(bottle_data.CalculatedPCO2_uatm_(1:2));
bottle_T2 = nanmean(bottle_data.CalculatedPCO2_uatm_(3:4));
slope = [(bottle_T2-sensor_T2) - (bottle_T1-sensor_T1)]./ datenum((T2-T1));

correction = (bottle_T1-sensor_T1) + datenum((pco2w_sensor.time - T1))*slope;

figure(6); clf

set(gcf,'color','w')
height=6;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth,height])

boundedline(datenum(pco2w_sensor.time), pco2w_sensor.partial_pressure_of_carbon_dioxide_in_sea_water,pco2w_sensor.pCO2_weekly_std,'-','Color',navy); hold on
h1 = plot(datenum(pco2w_sensor.time), pco2w_sensor.partial_pressure_of_carbon_dioxide_in_sea_water,'-','Color',blue,'linewidth',L); hold on
h2 = plot(datenum(pco2w_sensor.time), pco2w_sensor.partial_pressure_of_carbon_dioxide_in_sea_water + correction,'-','Color',red,'linewidth',L); hold on
h3 = plot(datenum(bottle_data.CTDBottleClosureTime_UTC_),bottle_data.CalculatedPCO2_uatm_,...
    'ok','MarkerSize',5,'MarkerFaceColor','k')
ylabel('Seawater pCO_2 (\muatm)')
xlim([datenum(2015,5,1) datenum(2015,10,30)])
box on
datetick('x',2,'keeplimits')
legend([h1 h2 h3], 'SAMI-CO2 L1 data','Corrected','Discrete samples','Location','southeast')
%title({'Coastal Pioneer: Central Surface Mooring' 'Seafloor Multi-function Node: SAMI-CO2'})
