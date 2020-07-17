%----------------------------------------------%
%   计算TR painting的 代价函数
%   这里是比较远场特性，只关注了Dir方向性。
%
%   Date:2020.May.27
%   Author:cschen
%----------------------------------------------%

clc;clear;close all;
%% 数据导入

origin=DataProcessing('E:\TRpainting\CostFuncData\origin.txt');
small_1=DataProcessing('E:\TRpainting\CostFuncData\small1.txt');
small_2=DataProcessing('E:\TRpainting\CostFuncData\small2.txt');
small_5=DataProcessing('E:\TRpainting\CostFuncData\small5.txt');
small_8=DataProcessing('E:\TRpainting\CostFuncData\small8.txt');
small_10=DataProcessing('E:\TRpainting\CostFuncData\small10.txt');
mult_1=DataProcessing('E:\TRpainting\CostFuncData\mult1.txt');
mult_2=DataProcessing('E:\TRpainting\CostFuncData\mult2.txt');
mult_3=DataProcessing('E:\TRpainting\CostFuncData\mult3.txt');
mult_4=DataProcessing('E:\TRpainting\CostFuncData\mult4.txt');
mult_5=DataProcessing('E:\TRpainting\CostFuncData\mult5.txt');

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

plot(a)


%%   子函数 归一化处理远场数据
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








