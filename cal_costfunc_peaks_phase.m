%----------------------------------------------%
%   计算TR painting的 代价函数
%   这里是比较远场特性，只关注了Dir方向性。
%
%   Date:2020.May.27
%   Author:cschen
%----------------------------------------------%

clc;clear;close all;
format long
%% 数据导入
origin=DataProcessing('E:\TRpainting\CostFuncData\phase\origin.txt');
E_H=DataProcessing('E:\TRpainting\CostFuncData\phase\EH.txt');
only_E=DataProcessing('E:\TRpainting\CostFuncData\phase\onlyE.txt');
only_H=DataProcessing('E:\TRpainting\CostFuncData\phase\onlyH.txt');

% 防止跳变
orgin=unwrap(origin);
only_E=unwrap(only_E);
only_H=unwrap(only_H);
E_H=unwrap(E_H);
%
%  only_E=reshape(only_E,99,99);
% pcolor(only_E);colorbar


figure
%% 绘图
if length(origin)==length(only_E)
    plot(orgin,'DisplayName','origin');hold on ;
    plot(only_E,'DisplayName','only\_E');hold on;
    plot(only_H,'DisplayName','only\_H');
    plot(E_H,'DisplayName','EH');
    
    legend
else
    disp('Data format doesn''t match. Please check it.')
end

%% 计算误差曲线 随着design面的变化的变化
% a(1)=cal_error(origin,E_H);
% a(2)=cal_error(origin,only_H);
% a(3)=cal_error(origin,only_E);
% figure(2)
% plot(a)

%% 计算协方差曲线 随着design面的变化的变化
b{1}=cov(origin,E_H);
b{2}=cov(origin,only_E);
b{3}=cov(origin,only_H);
covbetween=zeros(length(b),1);
for ii=1:length(b)
    covbetween(ii)= abs(b{ii}(2));
end
figure(2)
plot(covbetween,'r*');hold on;plot(covbetween);
title('协方差');
set(gca,'XTick',[1:1:3])
set(gca,'xtickLabel',{'E and H','only\_E','only\_H'})



%% 计算相关系数曲线 随着design面的变化的变化
b{1}=corrcoef(origin,E_H);
b{2}=corrcoef(origin,only_E);
b{3}=corrcoef(origin,only_H);
covbetween=zeros(length(b),1);
for ii=1:length(b)
    covbetween(ii)= abs(b{ii}(2));
end
figure(3)
plot(covbetween,'r*');hold on;plot(covbetween);axis([1 3 0.5 1]);
title('相关曲线');
set(gca,'XTick',[1:1:3])
set(gca,'xtickLabel',{'E and H','only\_E','only\_H'})
%%   子函数 归一化处理电场数据
%   返回值为固定格式的Ex相位
function proc_data=DataProcessing(pathhh)
%   选择面前
%   path为txt的位置
%   e.g. a=NormaliDataAndPlot('E:\TRpainting\CostFuncData\small1.txt');

use_data=importdata(pathhh);
proc_data=use_data.data;
proc_data=proc_data(proc_data(:,1)<150 & -150<proc_data(:,1),:);% 筛选X
proc_data=proc_data(proc_data(:,2)<150 & -150<proc_data(:,2),:);% 筛选y
% proc_data=rad2deg(angle(proc_data(:,4)+1i*proc_data(:,5)));
proc_data=angle(proc_data(:,4)+1i*proc_data(:,5));
end



