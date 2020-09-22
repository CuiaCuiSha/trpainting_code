%----------------------------------------------
%   最终版了
%   验证pec中重建源与初始源的异同，并计算代价函数
%   Date:2020.Sep.22
%   Author:cschen
%----------------------------------------------


clear;close all;clc
feature('DefaultCharacterSet','UTF-8');
tic
disp('data loading')
%%  load 

oripath='C:\Users\CCS\Desktop\pec_rebuild\';
PecPhase.original = sfunc_dataprepro_P(fullfile(oripath,'F_original_z=0_e-field (f=10) [PhasePeaks].txt'));
PecPhase.num1 = sfunc_dataprepro_P(fullfile(oripath,'Phase\paper1.txt'));
PecPhase.num2 = sfunc_dataprepro_P(fullfile(oripath,'Phase\paper2.txt'));
PecPhase.num4 = sfunc_dataprepro_P(fullfile(oripath,'Phase\paper4.txt'));
PecPhase.num5 = sfunc_dataprepro_P(fullfile(oripath,'Phase\paper5.txt'));
PecPhase.num7 = sfunc_dataprepro_P(fullfile(oripath,'Phase\paper7.txt'));
% PecPhase.num8 = sfunc_dataprepro_P(fullfile(oripath,'Phase\paper7without180.txt'));对比表示without180是不对的%
PecPhase.num8= sfunc_dataprepro_P(fullfile(oripath,'Phase\paper8.txt'));


PecAmplitude.original = sfunc_dataprepro_A(fullfile(oripath,'F_original_z=0_e-field (f=10) [AmplitudePeaks].txt'));
PecAmplitude.num1 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\paper1.txt'));
PecAmplitude.num2 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\paper2.txt'));
PecAmplitude.num4 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\paper4.txt'));
PecAmplitude.num5 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\paper5.txt'));
PecAmplitude.num7 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\paper7.txt'));
% PecAmplitude.num8 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\paper7without180.txt'));
PecAmplitude.num8 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\paper8.txt'));

disp('finish data loading')
toc

%% cal corrcoef Phase
tic
p{1}=corrcoef(PecPhase.original,PecPhase.num1);
p{2}=corrcoef(PecPhase.original,PecPhase.num2);

p{3}=corrcoef(PecPhase.original,PecPhase.num4);
p{4}=corrcoef(PecPhase.original,PecPhase.num5);

p{5}=corrcoef(PecPhase.original,PecPhase.num7);
p{6}=corrcoef(PecPhase.original,PecPhase.num8);


toc

corrcoefbetweenP=zeros(length(p),1);
for ii=1:length(p)
    corrcoefbetweenP(ii)= abs(p{ii}(2));
end
figure(1)
plot(corrcoefbetweenP,'r*');hold on;l1=plot(corrcoefbetweenP);axis([1 length(p) 0 1]);

%% cal corrcoef Amplitude
tic
a{1}=corrcoef(PecAmplitude.original,PecAmplitude.num1);
a{2}=corrcoef(PecAmplitude.original,PecAmplitude.num2);

a{3}=corrcoef(PecAmplitude.original,PecAmplitude.num4);
a{4}=corrcoef(PecAmplitude.original,PecAmplitude.num5);

a{5}=corrcoef(PecAmplitude.original,PecAmplitude.num7);
a{6}=corrcoef(PecAmplitude.original,PecAmplitude.num8);


toc

corrcoefbetweenA=zeros(length(a),1);
for ii=1:length(a)
    corrcoefbetweenA(ii)= abs(a{ii}(2));
end
hold on;
plot(corrcoefbetweenA,'b*');hold on;l2=plot(corrcoefbetweenA);axis([1 length(p) 0 1]);

title('相关曲线');
legend([l1,l2],'rebuild phase','rebuild amplitude')
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

