%----------------------------------------------
%   最终版了
%   paap 意思是 P 的 A，A 的 P。
%   验证pec中重建相位源时，幅度分布异同，并计算代价函数
%   验证pec中重建幅度源时，相位分布异同，并计算代价函数
%   Date:2020.Sep.22
%   Author:cschen
%----------------------------------------------



clear;close all;clc
feature('DefaultCharacterSet','UTF-8');
tic
disp('data loading')
%%  load 

oripath='C:\Users\CCS\Desktop\pec_rebuild\';

PecPhase.original = sfunc_dataprepro_A(fullfile(oripath,'F_original_z=0_e-field (f=10) [PhasePeaks].txt'));

PecPhase.num1 = sfunc_dataprepro_A(fullfile(oripath,'Phase\paper1.txt'));
PecPhase.num2 = sfunc_dataprepro_A(fullfile(oripath,'Phase\paper2.txt'));
PecPhase.num4 = sfunc_dataprepro_A(fullfile(oripath,'Phase\paper4.txt'));
PecPhase.num5 = sfunc_dataprepro_A(fullfile(oripath,'Phase\paper5.txt'));
PecPhase.num7 = sfunc_dataprepro_A(fullfile(oripath,'Phase\paper7.txt'));
% PecPhase.num8 = sfunc_dataprepro_A(fullfile(oripath,'paper7without180.txt'));对比表示without180是不对的%
PecPhase.num8= sfunc_dataprepro_A(fullfile(oripath,'Phase\paper8.txt'));


PecAmplitude.original = sfunc_dataprepro_P(fullfile(oripath,'\F_original_z=0_e-field (f=10) [AmplitudePeaks].txt'));

PecAmplitude.num1 = sfunc_dataprepro_P(fullfile(oripath,'Amplitude\paper1.txt'));
PecAmplitude.num2 = sfunc_dataprepro_P(fullfile(oripath,'Amplitude\paper2.txt'));
PecAmplitude.num4 = sfunc_dataprepro_P(fullfile(oripath,'Amplitude\paper4.txt'));
PecAmplitude.num5 = sfunc_dataprepro_P(fullfile(oripath,'Amplitude\paper5.txt'));
PecAmplitude.num7 = sfunc_dataprepro_P(fullfile(oripath,'Amplitude\paper7.txt'));
% PecAmplitude.num8 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\paper7without180.txt');
PecAmplitude.num8 = sfunc_dataprepro_P(fullfile(oripath,'Amplitude\paper8.txt'));


disp('finish data loading')
toc

%% reshape
% set(gca,'XTick',[1:1:3])
% set(gca,'xtickLabel',{'E and H','only\_E','only\_H'})
PecPhaseMat.original=reshape(PecPhase.original,199,199);
PecPhaseMat.num1=reshape(PecPhase.num1,199,199);
PecPhaseMat.num2=reshape(PecPhase.num2,199,199);
PecPhaseMat.num4=reshape(PecPhase.num4,199,199);
PecPhaseMat.num5=reshape(PecPhase.num5,199,199);
PecPhaseMat.num7=reshape(PecPhase.num7,199,199);
PecPhaseMat.num8=reshape(PecPhase.num8,199,199);

PecAmplitudeMat.original=reshape(PecAmplitude.original,199,199);
PecAmplitudeMat.num1=reshape(PecAmplitude.num1,199,199);
PecAmplitudeMat.num2=reshape(PecAmplitude.num2,199,199);
PecAmplitudeMat.num4=reshape(PecAmplitude.num4,199,199);
PecAmplitudeMat.num5=reshape(PecAmplitude.num5,199,199);
PecAmplitudeMat.num7=reshape(PecAmplitude.num7,199,199);
PecAmplitudeMat.num8=reshape(PecAmplitude.num8,199,199);

PecPhaseMat.original=reshape(PecPhase.original,199,199);
PecPhaseMat.num1=reshape(PecPhase.num1,199,199);
PecPhaseMat.num2=reshape(PecPhase.num2,199,199);
PecPhaseMat.num4=reshape(PecPhase.num4,199,199);
PecPhaseMat.num5=reshape(PecPhase.num5,199,199);
PecPhaseMat.num7=reshape(PecPhase.num7,199,199);
PecPhaseMat.num8=reshape(PecPhase.num8,199,199);

PecAmplitudeMat.original=reshape(PecAmplitude.original,199,199);
PecAmplitudeMat.num1=reshape(PecAmplitude.num1,199,199);
PecAmplitudeMat.num2=reshape(PecAmplitude.num2,199,199);
PecAmplitudeMat.num4=reshape(PecAmplitude.num4,199,199);
PecAmplitudeMat.num5=reshape(PecAmplitude.num5,199,199);
PecAmplitudeMat.num7=reshape(PecAmplitude.num7,199,199);
PecAmplitudeMat.num8=reshape(PecAmplitude.num8,199,199);

%% plot
figure;surf(PecPhaseMat.original);shading interp;axis([0 200 0 200 -1 1])
figure;surf(PecPhaseMat.num1);shading interp;axis([0 200 0 200 0 0.1])
figure;surf(PecPhaseMat.num2);shading interp;axis([0 200 0 200 0 0.1])
figure;surf(PecPhaseMat.num4);shading interp;axis([0 200 0 200 0 0.1])
figure;surf(PecPhaseMat.num5);shading interp;axis([0 200 0 200 0 0.1])
figure;surf(PecPhaseMat.num7);shading interp;axis([0 200 0 200 0 0.1])
figure;surf(PecPhaseMat.num8);shading interp;axis([0 200 0 200 0 0.1])


figure;surf(PecAmplitudeMat.original);shading interp;axis([0 200 0 200 -4 4])
figure;surf(PecAmplitudeMat.num1);shading interp;axis([0 200 0 200 -4 4])
figure;surf(PecAmplitudeMat.num2);shading interp;axis([0 200 0 200 -4 4])
figure;surf(PecAmplitudeMat.num4);shading interp;axis([0 200 0 200 -4 4])
figure;surf(PecAmplitudeMat.num5);shading interp;axis([0 200 0 200 -4 4])
figure;surf(PecAmplitudeMat.num7);shading interp;axis([0 200 0 200 -4 4])
figure;surf(PecAmplitudeMat.num8);shading interp;axis([0 200 0 200 -4 4])

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

