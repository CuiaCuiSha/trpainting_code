%----------------------------------------------
%   TR painting中
%   验证Amplitude Peaks的相关系数
%   对应cst文件
%       20200702_1_original_rebuild amplitude
%       20200630_1_original
%
%   Date:2020.July.17
%   Author:cschen
%----------------------------------------------


clear;close all;clc
feature('DefaultCharacterSet','UTF-8');
tic
disp('data loading')
%%  load Amplitude
F_original_amplitude.z0 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F_original_z=0_e-field (f=10) [AmplitudePeaks].txt');
F_original_amplitude.z1 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F_original_z=1_e-field (f=10) [AmplitudePeaks].txt');
% F_original_amplitude.z2 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F_original_z=2_e-field (f=10) [AmplitudePeaks].txt');
F_original_amplitude.z_1 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F_original_z=-1_e-field (f=10) [AmplitudePeaks].txt');

F_2.z0 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F2-0_e-field (f=10) [A_up_rebuild].txt');
F_2.z1 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F2-1_e-field (f=10) [A_up_rebuild].txt');
% F_2.z2 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F2-2_e-field (f=10) [A_up_rebuild].txt');
F_2.z_1 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F2--1_e-field (f=10) [A_up_rebuild].txt');


F_4.z0 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F4-0_e-field (f=10) [A_down_rebuild].txt');
F_4.z1 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F4-1_e-field (f=10) [A_down_rebuild].txt');
% F_4.z2 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F4-2_e-field (f=10) [A_down_rebuild].txt');
F_4.z_1 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F4--1_e-field (f=10) [A_down_rebuild].txt');


F_6.z0 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F6-0_e-field (f=10) [Simulation_1].txt');
F_6.z1 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F6-1_e-field (f=10) [Simulation_1].txt');
F_6.z_1 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F6--1_e-field (f=10) [Simulation_1].txt');


F_6with180.z0 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F6-0_e-field (f=10) [Simulation_with 180degree].txt');
F_6with180.z1 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F6-1_e-field (f=10) [Simulation_with 180degree].txt');
F_6with180.z_1 = sfunc_dataprepro_abs('.\CostFuncData\20200717_field\F6--1_e-field (f=10) [Simulation_with 180degree].txt');
%%  load Phase
F_original_phase.z0 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F_original_z=0_e-field (f=10) [PhasePeaks].txt');
F_original_phase.z1 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F_original_z=1_e-field (f=10) [PhasePeaks].txt');
F_original_phase.z_1 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F_original_z=-1_e-field (f=10) [PhasePeaks].txt');
F_original_phase.z0unw = unwrap(F_original_phase.z0);F_original_phase.z1unw = unwrap(F_original_phase.z1);F_original_phase.z_1unw = unwrap(F_original_phase.z_1);


F_1.z0 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F1-0_e-field (f=10) [P_up_rebuild].txt');    
F_1.z1 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F1-1_e-field (f=10) [P_up_rebuild].txt');
F_1.z_1 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F1--1_e-field (f=10) [P_up_rebuild].txt');
F_1.z0unw = unwrap(F_1.z0);F_1.z1unw = unwrap(F_1.z1);F_1.z_1unw = unwrap(F_1.z_1);

F_3.z0 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F3-0_e-field (f=10) [P_down_rebuild].txt');
F_3.z1 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F3-1_e-field (f=10) [P_down_rebuild].txt');
F_3.z_1 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F3--1_e-field (f=10) [P_down_rebuild].txt');
F_3.z0unw = unwrap(F_3.z0);F_3.z1unw = unwrap(F_3.z1);F_3.z_1unw = unwrap(F_3.z_1);

F_5.z0 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F5-0_e-field (f=10) [Simulation_1].txt');
F_5.z1 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F5-1_e-field (f=10) [Simulation_1].txt');
F_5.z_1 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F5--1_e-field (f=10) [Simulation_1].txt');
F_5.z0unw = unwrap(F_5.z0);F_5.z1unw = unwrap(F_5.z1);F_5.z_1unw = unwrap(F_5.z_1);

F_5with180.z0 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F5-0_e-field (f=10) [Simulation_with_180].txt');
F_5with180.z1 = sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F5-1_e-field (f=10) [Simulation_with_180].txt');
F_5with180.z_1= sfunc_dataprepro_angle('.\CostFuncData\20200717_field\F5--1_e-field (f=10) [Simulation_with_180].txt');
F_5with180.z0unw = unwrap(F_5with180.z0);F_5with180.z1unw = unwrap(F_5with180.z1);F_5with180.z_1unw = unwrap(F_5with180.z_1);

disp('finish data loading')
toc

%% cal corrcoef
tic
b{1}=corrcoef( F_original_amplitude.z0,F_2.z0);
b{2}=corrcoef( F_original_amplitude.z1,F_2.z1);
b{3}=corrcoef( F_original_amplitude.z_1,F_2.z_1);

b{4}=corrcoef( F_original_amplitude.z0,F_4.z0);
b{5}=corrcoef( F_original_amplitude.z1,F_4.z1);
b{6}=corrcoef( F_original_amplitude.z_1,F_4.z_1);

b{7}=corrcoef( F_original_amplitude.z0,F_6.z0);
b{8}=corrcoef( F_original_amplitude.z1,F_6.z1);
b{9}=corrcoef( F_original_amplitude.z_1,F_6.z_1);

b{10}=corrcoef( F_original_amplitude.z0,F_6with180.z0);
b{11}=corrcoef( F_original_amplitude.z1,F_6with180.z1);
b{12}=corrcoef( F_original_amplitude.z_1,F_6with180.z_1);




b{13}=corrcoef( F_original_phase.z0unw,F_1.z0unw);
b{14}=corrcoef( F_original_phase.z1unw,F_1.z1unw);
b{15}=corrcoef( F_original_phase.z_1unw,F_1.z_1unw);

b{16}=corrcoef( F_original_phase.z0unw,F_5.z0unw);
b{17}=corrcoef( F_original_phase.z1unw,F_5.z1unw);
b{18}=corrcoef( F_original_phase.z_1unw,F_5.z_1unw);

b{19}=corrcoef( F_original_phase.z0unw,F_5.z0unw);
b{20}=corrcoef( F_original_phase.z1unw,F_5.z1unw);
b{21}=corrcoef( F_original_phase.z_1unw,F_5.z_1unw);

b{22}=corrcoef( F_original_phase.z0unw,F_5with180.z0unw);
b{23}=corrcoef( F_original_phase.z1unw,F_5with180.z1unw);
b{24}=corrcoef( F_original_phase.z_1unw,F_5with180.z_1unw);

toc

corrcoefbetween=zeros(length(b),1);
for ii=1:length(b)
    corrcoefbetween(ii)= abs(b{ii}(2));
end
figure(1)
plot(corrcoefbetween,'r*');hold on;plot(corrcoefbetween);axis([1 length(b) 0 1]);
% title('相关曲线');
% set(gca,'XTick',[1:1:3])
% set(gca,'xtickLabel',{'E and H','only\_E','only\_H'})


%% sub function sfunc_dataprepro
%   子函数 归一化处理电场数据 返回值为 Ex 的 Amplitude or Phase

function proc_data=sfunc_dataprepro_abs(pathhh)
%   选择面前
%   path为txt的位置
%   e.g. a=NormaliDataAndPlot('.\CostFuncData\small1.txt');

use_data=importdata(pathhh);
proc_data=use_data.data;
proc_data=proc_data(proc_data(:,1)<150 & -150<proc_data(:,1),:);% 筛选X
proc_data=proc_data(proc_data(:,2)<150 & -150<proc_data(:,2),:);% 筛选y
proc_data=abs(proc_data(:,4)+1i*proc_data(:,5)); % 返回值为Ex幅度

end

function proc_data=sfunc_dataprepro_angle(pathhh)
%   选择面前
%   path为txt的位置
%   e.g. a=NormaliDataAndPlot('.\CostFuncData\small1.txt');

use_data=importdata(pathhh);
proc_data=use_data.data;
proc_data=proc_data(proc_data(:,1)<150 & -150<proc_data(:,1),:);% 筛选X
proc_data=proc_data(proc_data(:,2)<150 & -150<proc_data(:,2),:);% 筛选y
proc_data=angle(proc_data(:,4)+1i*proc_data(:,5)); % 返回值为Ex幅度

end

