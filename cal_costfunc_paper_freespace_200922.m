%----------------------------------------------
%   最终版了
%   验证free space 重建源与初始源的异同，并计算代价函数
%   Date:2020.Sep.22
%   Author:cschen
%----------------------------------------------


clear;close all;clc
feature('DefaultCharacterSet','UTF-8');
tic
disp('data loading')
%%  load 

oripath='C:\Users\CCS\Desktop\rebuild_2dplane\';
Phase.original = sfunc_dataprepro_P(fullfile(oripath,'F_original_z=0_e-field (f=10) [PhasePeaks].txt'));
Phase.num1 = sfunc_dataprepro_P(fullfile(oripath,'Phase\zhengli\paper1.txt'));
Phase.num2 = sfunc_dataprepro_P(fullfile(oripath,'Phase\zhengli\paper2.txt'));
Phase.num4 = sfunc_dataprepro_P(fullfile(oripath,'Phase\zhengli\paper4.txt'));
Phase.num5 = sfunc_dataprepro_P(fullfile(oripath,'Phase\zhengli\paper5.txt'));
Phase.num7 = sfunc_dataprepro_P(fullfile(oripath,'Phase\zhengli\paper7.txt'));
Phase.num8 = sfunc_dataprepro_P(fullfile(oripath,'Phase\zhengli\paper8.txt'));


Amplitude.original = sfunc_dataprepro_A(fullfile(oripath,'F_original_z=0_e-field (f=10) [AmplitudePeaks].txt'));
Amplitude.num1 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\zhengli\paper1.txt'));
Amplitude.num2 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\zhengli\paper2.txt'));
Amplitude.num4 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\zhengli\paper4.txt'));
Amplitude.num5 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\zhengli\paper5.txt'));
Amplitude.num7 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\zhengli\paper7.txt'));
Amplitude.num8 = sfunc_dataprepro_A(fullfile(oripath,'Amplitude\zhengli\paper8.txt'));




disp('finish data loading')
toc

%% cal corrcoef Phase
tic
p{1}=corrcoef(Phase.original,Phase.num1);
p{2}=corrcoef(Phase.original,Phase.num2);

p{3}=corrcoef(Phase.original,Phase.num4);
p{4}=corrcoef(Phase.original,Phase.num5);

p{5}=corrcoef(Phase.original,Phase.num7);
p{6}=corrcoef(Phase.original,Phase.num8);


toc

corrcoefbetweenP=zeros(length(p),1);
for ii=1:length(p)
    corrcoefbetweenP(ii)= abs(p{ii}(2));
end
figure(1)
plot(corrcoefbetweenP,'r*');hold on;l1=plot(corrcoefbetweenP);axis([1 length(p) 0 1]);

%% cal corrcoef Amplitude
tic
a{1}=corrcoef(Amplitude.original,Amplitude.num1);
a{2}=corrcoef(Amplitude.original,Amplitude.num2);

a{3}=corrcoef(Amplitude.original,Amplitude.num4);
a{4}=corrcoef(Amplitude.original,Amplitude.num5);

a{5}=corrcoef(Amplitude.original,Amplitude.num7);
a{6}=corrcoef(Amplitude.original,Amplitude.num8);


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
PhaseMat.original=reshape(Phase.original,199,199);
PhaseMat.num1=reshape(Phase.num1,199,199);
PhaseMat.num2=reshape(Phase.num2,199,199);
PhaseMat.num4=reshape(Phase.num4,199,199);
PhaseMat.num5=reshape(Phase.num5,199,199);
PhaseMat.num7=reshape(Phase.num7,199,199);
PhaseMat.num8=reshape(Phase.num8,199,199);

AmplitudeMat.original=reshape(Amplitude.original,199,199);
AmplitudeMat.num1=reshape(Amplitude.num1,199,199);
AmplitudeMat.num2=reshape(Amplitude.num2,199,199);
AmplitudeMat.num4=reshape(Amplitude.num4,199,199);
AmplitudeMat.num5=reshape(Amplitude.num5,199,199);
AmplitudeMat.num7=reshape(Amplitude.num7,199,199);
AmplitudeMat.num8=reshape(Amplitude.num8,199,199);



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

