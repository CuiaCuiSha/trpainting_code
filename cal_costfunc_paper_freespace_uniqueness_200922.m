%----------------------------------------------
%   最终版了
%   验证freespace情况下，仅仅使用Et重建源的情况
%   Date:2020.Sep.23
%   Author:cschen
%----------------------------------------------

clear;close all;clc
feature('DefaultCharacterSet','UTF-8');

%%  load 
tic;disp('data loading')
oripath='E:\TRpainting\CostFuncData\唯一性定理freespace\';

Phase.original = sfunc_dataprepro_P(fullfile(oripath,'F_original_z=0_e-field (f=10) [PhasePeaks].txt'));
Phase.num1 = sfunc_dataprepro_P(fullfile(oripath,'e-field (f=10) [up_P_onlyEt].txt'));
Phase.num2 = sfunc_dataprepro_P(fullfile(oripath,'e-field (f=10) [down_P_onlyEt].txt'));
Phase.num3 = sfunc_dataprepro_P(fullfile(oripath,'e-field (f=10) [down_P_onlyEt[1.0,180]+up_P_onlyEt[1.0,0.0],[10]].txt'));

Amplitude.original = sfunc_dataprepro_A(fullfile(oripath,'F_original_z=0_e-field (f=10) [AmplitudePeaks].txt'));
Amplitude.num1 = sfunc_dataprepro_A(fullfile(oripath,'e-field (f=10) [up_A_onlyEt[1.0,0.0],[10]].txt'));
Amplitude.num2 = sfunc_dataprepro_A(fullfile(oripath,'e-field (f=10) [down_A_onlyEt[1.0,0.0],[10]].txt'));
Amplitude.num3 = sfunc_dataprepro_A(fullfile(oripath,'e-field (f=10) [down_A_onlyEt[1.0,180]+up_A_onlyEt[1.0,0.0],[10]].txt'));

% 重建相位源的幅度分布
PhaseA.original = sfunc_dataprepro_A(fullfile(oripath,'F_original_z=0_e-field (f=10) [PhasePeaks].txt'));
PhaseA.num1 = sfunc_dataprepro_A(fullfile(oripath,'e-field (f=10) [up_P_onlyEt].txt'));
PhaseA.num2 = sfunc_dataprepro_A(fullfile(oripath,'e-field (f=10) [down_P_onlyEt].txt'));
PhaseA.num3 = sfunc_dataprepro_A(fullfile(oripath,'e-field (f=10) [down_P_onlyEt[1.0,180]+up_P_onlyEt[1.0,0.0],[10]].txt'));

% 重建幅度源的相位分布
AmplitudeP.original = sfunc_dataprepro_P(fullfile(oripath,'F_original_z=0_e-field (f=10) [AmplitudePeaks].txt'));
AmplitudeP.num1 = sfunc_dataprepro_P(fullfile(oripath,'e-field (f=10) [up_A_onlyEt[1.0,0.0],[10]].txt'));
AmplitudeP.num2 = sfunc_dataprepro_P(fullfile(oripath,'e-field (f=10) [down_A_onlyEt[1.0,0.0],[10]].txt'));
AmplitudeP.num3 = sfunc_dataprepro_P(fullfile(oripath,'e-field (f=10) [down_A_onlyEt[1.0,180]+up_A_onlyEt[1.0,0.0],[10]].txt'));
disp('finish data loading');toc

%% cal corrcoef Phase
p{1}=corrcoef(Phase.original,Phase.num1);
p{2}=corrcoef(Phase.original,Phase.num2);
p{3}=corrcoef(Phase.original,Phase.num3);

corrcoefbetweenP=zeros(length(p),1);
for ii=1:length(p)
    corrcoefbetweenP(ii)= abs(p{ii}(2));
end
figure(1)
plot(corrcoefbetweenP,'r*');hold on;l1=plot(corrcoefbetweenP);axis([1 length(p) 0 1]);

%% cal corrcoef Amplitude
a{1}=corrcoef(Amplitude.original,Amplitude.num1);
a{2}=corrcoef(Amplitude.original,Amplitude.num2);
a{3}=corrcoef(Amplitude.original,Amplitude.num3);

corrcoefbetweenA=zeros(length(a),1);
for ii=1:length(a)
    corrcoefbetweenA(ii)= abs(a{ii}(2));
end

hold on;
plot(corrcoefbetweenA,'b*');hold on;l2=plot(corrcoefbetweenA);axis([1 length(p) 0 1]);
title('相关曲线');
legend([l1,l2],'rebuild phase','rebuild amplitude')


%% reshape PAAP

PecPhaseMat.original=reshape(PhaseA.original,199,199);
PecPhaseMat.num1=reshape(PhaseA.num1,199,199);
PecPhaseMat.num2=reshape(PhaseA.num2,199,199);
PecPhaseMat.num3=reshape(PhaseA.num3,199,199);

PecAmplitudeMat.original=reshape(AmplitudeP.original,199,199);
PecAmplitudeMat.num1=reshape(AmplitudeP.num1,199,199);
PecAmplitudeMat.num2=reshape(AmplitudeP.num2,199,199);
PecAmplitudeMat.num3=reshape(AmplitudeP.num3,199,199);

%% plot PAAP
figure;surf(PecPhaseMat.original);shading interp;axis([0 200 0 200 -1 1])
figure;surf(PecPhaseMat.num1);shading interp;axis([0 200 0 200 0 0.1])
figure;surf(PecPhaseMat.num2);shading interp;axis([0 200 0 200 0 0.1])
figure;surf(PecPhaseMat.num3);shading interp;axis([0 200 0 200 0 0.1])

figure;surf(PecAmplitudeMat.original);shading interp;axis([0 200 0 200 -4 4])
figure;surf(PecAmplitudeMat.num1);shading interp;axis([0 200 0 200 -4 4])
figure;surf(PecAmplitudeMat.num2);shading interp;axis([0 200 0 200 -4 4])
figure;surf(PecAmplitudeMat.num3);shading interp;axis([0 200 0 200 -4 4])


%% sub function sfunc_dataprepro
%   子函数 归一化处理电场数据 返回值为 Ex 的 Amplitude or Phase

function proc_data=sfunc_dataprepro_A(pathhh)
%   选择面前
%   path为txt的位置
%   e.g. a=NormaliDataAndPlot('.\CostFuncData\small1.txt');

use_data=importdata(pathhh);
proc_data=use_data.data;
proc_data=proc_data(proc_data(:,1)<150 & -150<proc_data(:,1),:);% 筛选X
proc_data=proc_data(proc_data(:,2)<150 & -150<proc_data(:,2),:);% 筛选y
proc_data=abs(proc_data(:,4)+1i*proc_data(:,5)); % 返回值为Ex幅度

end

function proc_data=sfunc_dataprepro_P(pathhh)
%   选择面前
%   path为txt的位置
%   e.g. a=NormaliDataAndPlot('.\CostFuncData\small1.txt');

use_data=importdata(pathhh);
proc_data=use_data.data;
proc_data=proc_data(proc_data(:,1)<150 & -150<proc_data(:,1),:);% 筛选X
proc_data=proc_data(proc_data(:,2)<150 & -150<proc_data(:,2),:);% 筛选y
proc_data=angle(proc_data(:,4)+1i*proc_data(:,5)); % 返回值为Ex相位
proc_data=unwrap(proc_data);% 利用unwrap 防止相位跳变

end

