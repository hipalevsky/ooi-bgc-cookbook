%% Hilary Palevsky
% Figures for Chapter 3 of OOI BGC Sensor Best Practices & User Guide
Figures_all

%% Figure 3-2 - Calibration profile

calprof = readtable('Fig 3.2.csv','TextType','string');

figure(1); clf

set(gcf,'color','w')
height=9;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth,height])
L = 2;

subplot(121)
plot(calprof.salinity_corrected_nitrate,calprof.depth,'Linewidth',L,'Color',blue); hold on
plot(calprof.discrete_nitrate,calprof.ctd_depth,'ok','MarkerSize',5,'MarkerFaceColor','k')
axis ij
x = gca;
x.XAxisLocation = 'top';
grid off
ylim([0 210])
xlim([0 35])
xlabel('Nitrate (\muM)')
ylabel('Depth (m)')
%legend('Surface piercing profiler','Discrete','Location','SW')

subplot(122)
plot(calprof.salinity_corrected_nitrate,calprof.seawater_temperature,'Linewidth',L,'Color',blue); hold on
plot(calprof.discrete_nitrate(2:end),calprof.ctd_temperature_1(2:end),'ok','MarkerSize',5,'MarkerFaceColor','k')
x = gca;
grid off
ylim([7 11])
xlim([0 35])
x.XAxisLocation = 'top';
xlabel('Nitrate (\muM)')
ylabel('Temperature (^oC)')
legend('Profiler SUNA L2 data','Discrete','Location','N')


%% Figure 3-3 Nitrate cal regression

matchup = readtable('Fig 3.4.csv','TextType','string');
L = 1.5;

figure(2); clf

set(gcf,'color','w')
height=6;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth/1.75,height])
L = 2;

h3 = plot([10:33],[10:33]*1.3231-8.8413,'-','color',blue,'linewidth',L); hold on;
h4 = plot([10:34],[10:34]*0.9917+0.3015,'-','color',teal,'linewidth',L);
h1 = plot(matchup.ProfilerCorrectedNitrate_DepthMatch, matchup.discrete_nitrate,'ok','MarkerSize',8,'MarkerFaceColor',blue); hold on;
h2 = plot(matchup.ProfilerCorrectedNitrate_TemperatureMatch, matchup.discrete_nitrate,'sk','MarkerSize',8,'MarkerFaceColor',teal);

text(1.5, 32.5,'y = 1.32x - 8.84; R^2 = 0.982','color',blue)
text(1.5, 29,'y = 0.99x + 0.30; R^2 = 0.986','color',teal)

axis([0 35 0 35])
legend([h1 h2],'Depth','Temperature','location','SE')
xlabel('Profiler nitrate (\muM)')
ylabel('Discrete nitrate (\muM)')

%% Figure 3-4 Profile comparisons

profiles = readtable('Fig 3.5.csv','TextType','string');

D = diff(profiles.depth_m_);
ind = find(D > 100);

figure(3); clf
set(gcf,'color','w')
height=8;
set(gcf,'units','centimeters','position',[x0,y0,fullwidth/1.25,height])
L = 1;
C = flipud(cmocean('haline',length(ind)));
ymin = 7; ymax = 15;

boundedline([0 0], [ymin ymax], [2 2],'k-','orientation','horiz'); hold on

plot(profiles.corrNitrateUmolL_1(1:ind(1)), profiles.seawater_temperature_C(1:ind(1)), '-','color',C(1,:),'linewidth',L); hold on;
for i = 2:length(ind)
    plot(profiles.corrNitrateUmolL_1(ind(i-1)+1:ind(i)), profiles.seawater_temperature_C(ind(i-1)+1:ind(i)), '-','color',C(i,:),'linewidth',L); hold on;
end
box on
colormap(C); B = colorbar('location','eastoutside')
B.Ticks = linspace(0, 1, 4);
B.TickLabels = [datestr(profiles.DateUTC(ind(linspace(1, length(ind), 4))-1),6)]
xlim([-5 35]); ylim([ymin ymax])
xlabel('Nitrate (\muM)')
ylabel('Temperature (^oC)')