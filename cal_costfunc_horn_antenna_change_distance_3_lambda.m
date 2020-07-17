%----------------------------------------------%
%   计算TR painting的代价函数
%   这里是比较远场特性，只关注了Dir方向性。
%   使用的是对于HornAntenna的数据
%   
%   此处称之为代价函数可能并不是很妥当，与之前文中定于的有些不太一致。
%   design面积越大，相当于天线的口径面越大，增益肯定就越高
%   
%
%   Date:2020.May.27
%   Author:cschen
%----------------------------------------------%
feature('DefaultCharacterSet','UTF-8');
clc;clear;close all;


%% 数据导入

origin=DataProcessing('E:\TRpainting\CostFuncData\hornantenna\origin.txt');
small_1=DataProcessing('E:\TRpainting\CostFuncData\hornantenna_3lambda\small_1.txt');
small_2=DataProcessing('E:\TRpainting\CostFuncData\hornantenna_3lambda\small_2.txt');
small_5=DataProcessing('E:\TRpainting\CostFuncData\hornantenna_3lambda\small_5.txt');
small_8=DataProcessing('E:\TRpainting\CostFuncData\hornantenna_3lambda\small_8.txt');
small_10=DataProcessing('E:\TRpainting\CostFuncData\hornantenna_3lambda\small_10.txt');
mult_1=DataProcessing('E:\TRpainting\CostFuncData\hornantenna_3lambda\mult_1.txt');
mult_2=DataProcessing('E:\TRpainting\CostFuncData\hornantenna_3lambda\mult_2.txt');
mult_3=DataProcessing('E:\TRpainting\CostFuncData\hornantenna_3lambda\mult_3.txt');
mult_4=DataProcessing('E:\TRpainting\CostFuncData\hornantenna_3lambda\mult_4.txt');
mult_5=DataProcessing('E:\TRpainting\CostFuncData\hornantenna_3lambda\mult_5.txt');

%% 绘图
if length(origin)==length(small_1)
%     plot(origin,'DisplayName','origin');hold on ;
%     plot(small_1,'DisplayName','small\_1');
%     plot(small_2,'DisplayName','small\_2');
%     plot(small_5,'DisplayName','small\_5');
%     plot(small_8,'DisplayName','small\_8');
% %     plot(small_10,'DisplayName','small\_10');
%     plot(mult_1,'DisplayName','mult\_1');
%     plot(mult_2,'DisplayName','mult\_2');
%     plot(mult_3,'DisplayName','mult\_3');
%     plot(mult_4,'DisplayName','mult\_4');
%     plot(mult_5,'DisplayName','mult\_5');
%     legend
else
    disp('Data format doesn''t match. Please check it.')
end

%% 计算误差曲线 随着design面的变化的变化
a(1)=cal_error(origin,small_1);
a(2)=cal_error(origin,small_2);
a(3)=cal_error(origin,small_5);
a(4)=cal_error(origin,small_8);
a(5)=cal_error(origin,small_10);
a(6)=cal_error(origin,mult_1);
a(7)=cal_error(origin,mult_2);
a(8)=cal_error(origin,mult_3);
a(9)=cal_error(origin,mult_4);
a(10)=cal_error(origin,mult_5);
figure(1)
plot(a,'r*');hold on;plot(a);
set(gca,'xtickLabel',{'small\_1','small\_2','small\_5','small\_8','small\_10',...
    'mult\_1','mult\_2','mult\_3','mult\_4','mult\_5'})
title('误差曲线 随着design面增大')

%% 计算协方差曲线 随着design面的变化的变化
b{1}=cov(origin,small_1);
b{2}=cov(origin,small_2);
b{3}=cov(origin,small_5);
b{4}=cov(origin,small_8);
b{5}=cov(origin,small_10);
b{6}=cov(origin,mult_1);
b{7}=cov(origin,mult_2);
b{8}=cov(origin,mult_3);
b{9}=cov(origin,mult_4);
b{10}=cov(origin,mult_5);

covbetween=zeros(length(b),1);
for ii=1:length(b)
   covbetween(ii)= b{ii}(2);
end

figure(2)
plot(covbetween,'r*');hold on;plot(covbetween);
title('协方差曲线 随着design面增大')
set(gca,'xtickLabel',{'small\_1','small\_2','small\_5','small\_8','small\_10',...
    'mult\_1','mult\_2','mult\_3','mult\_4','mult\_5'})

%% 计算相关系数曲线 随着design面的变化的变化
c{1}=corrcoef(origin,small_1);
c{2}=corrcoef(origin,small_2);
c{3}=corrcoef(origin,small_5);
c{4}=corrcoef(origin,small_8);
c{5}=corrcoef(origin,small_10);
c{6}=corrcoef(origin,mult_1);
c{7}=corrcoef(origin,mult_2);
c{8}=corrcoef(origin,mult_3);
c{9}=corrcoef(origin,mult_4);
c{10}=corrcoef(origin,mult_5);
corrcoef_between=zeros(length(c),1);
for ii=1:length(c)
   corrcoef_between(ii)= c{ii}(2);
end
figure(3)
plot(corrcoef_between,'r*');hold on;plot(corrcoef_between);
title('相关系数曲线 随着design面增大')
set(gca,'xtickLabel',{'small\_1','small\_2','small\_5','small\_8','small\_10',...
    'mult\_1','mult\_2','mult\_3','mult\_4','mult\_5'})


%%   子函数 归一化处理远场数据 (归一化对误差很重要，对协方差无所谓~)
function proc_data=DataProcessing(pathhh)
%   归一化方向图数据
%   path为txt的位置
%   e.g. a=NormaliDataAndPlot('E:\TRpainting\CostFuncData\small1.txt');


use_data=importdata(pathhh);
proc_data=use_data.data;
proc_data=sortrows(proc_data,1);  % 按theta排列，更容易观察。
proc_data=proc_data(:,3);         % 远场数据，所以只对比第三项，Dir(dBi)
proc_data = proc_data - max(proc_data); % dBi单位，归一化只做减法就行。
end

%%   子函数 计算远场代价函数误差
function aver_error=cal_error(origin,comparedata)

if length(origin)==length(comparedata)
    total_error=abs(origin-comparedata).^2;
    aver_error=sum(total_error);
else
    disp('Data format which sub function used doesn''t match. Please check it.')
end


end








