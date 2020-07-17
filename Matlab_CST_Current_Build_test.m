%---------------------------------%
%   MATLAB调用CST实现指定的电流源分布
%   根据dat（切向场分布）实现指定的离散电流源分布
%   电流源分布包括位置，幅度，相位
%
%   Author:CS.CHEN
%   Data: 2020.May.1st
%---------------------------------%
clc;clear;close all;

Frq=[8,12];%工作频率，单位：GHz

%% CST文件初始化
cst = actxserver('CSTStudio.application');%首先载入CST应用控件
mws = invoke(cst, 'NewMWS');%新建一个MWS项目
app = invoke(mws, 'GetApplicationName');%获取当前应用名称
ver = invoke(mws, 'GetApplicationVersion');%获取当前应用版本号
invoke(mws, 'FileNew');%新建一个CST文件
path=pwd;%获取当前m文件夹路径
filename='\cstsimulation\current_build7.cst';%新建的CST文件名字
fullname=[path filename];
invoke(mws, 'SaveAs', fullname, 'True');%True表示保存到目前为止的结果
invoke(mws, 'DeleteResults');%删除之前的结果。注：在有结果的情况下修改模型会出现弹窗提示是否删除结果，这样运行的程序会停止，需等待手动点击弹窗使之消失
%%CST文件初始化结束

%%全局单位初始化
units = invoke(mws, 'Units');
invoke(units, 'Geometry', 'mm');
invoke(units, 'Frequency', 'GHz');
invoke(units, 'Time', 'ns');
invoke(units, 'TemperatureUnit', 'kelvin');
release(units);
%%全局单位初始化结束

%%工作频率设置
solver = invoke(mws, 'Solver');
invoke(solver, 'FrequencyRange', Frq(1), Frq(2));
release(solver);
%%工作频率设置结束

%%背景材料设置
background = invoke(mws, 'Background');
invoke(background, 'ResetBackground');
invoke(background, 'Type', 'Normal'); 
invoke(background, 'XminSpace', '70');
invoke(background, 'XmaxSpace', '70');
invoke(background, 'YminSpace', '70');
invoke(background, 'YmaxSpace', '70');
invoke(background, 'ZminSpace', '70');
invoke(background, 'ZmaxSpace', '370');
invoke(background, 'ApplyInAllDirections', 'False');
release(background);
%%背景材料设置结束

%%边界条件设置。
boundary = invoke(mws, 'Boundary');
invoke(boundary, 'Xmin', 'expanded open');%常用的值：”electric””magnetic””open””expanded open””periodic”"conducting wall"等
invoke(boundary, 'Xmax', 'expanded open');
invoke(boundary, 'Ymin', 'expanded open');
invoke(boundary, 'Ymax', 'expanded open');
invoke(boundary, 'Zmin', 'expanded open');
invoke(boundary, 'Zmax', 'expanded open');
invoke(boundary, 'Xsymmetry', 'none');%可以是”electric””magnetic””none”
invoke(boundary, 'Ysymmetry', 'none');
invoke(boundary, 'Zsymmetry', 'none');
invoke(boundary, 'ApplyInAllDirections', 'True');
release(boundary);
%%边界条件设置结束

%%使Bounding Box显示
plot = invoke(mws, 'Plot');
invoke(plot, 'DrawBox', 'True');
%%使Bounding Box显示结束

%% 读取数据并绘制电流源
%--------------------------------------------%
%   225*2=450mm,对应10GHz,15倍lambda
%   cst mesh 刚好划分了326格子，近似于一个波长划分20个格子
%   这个是Hy，所以刚好对应磁流源，又刚好是y向，所以电流源反而好设置
%--------------------------------------------%

distribution=importdata('E:\TRpainting\code\data_Hy_zmax.dat');

PortNum=1;      % Phase=zeros(length(distribution),1);
for n=1:length(distribution)
    if distribution(n,1)==distribution(n+1,1) 
        % 判断是否为一个x，只有在同一个x上生成电流源，换行的时候不生成
        P1 = distribution(n,1:3)*1e3;
        P2 = distribution(n+1,1:3)*1e3;
        current=complex(distribution(n,4),distribution(n,5));
        Amplitude = abs(current);       % 幅度设置可以在这里，也可以在激励中设置
        Phase(PortNum)=angle(current);  % 相位设置仅可以在激励中设置
        Phase=rad2deg(Phase);
        % cst 基于vbs根据数据生成电流源
        DiscretePort = invoke(mws, 'DiscretePort');
        func_build_DiscretePort(DiscretePort,PortNum,P1,P2,Amplitude)
        
        PortNum=PortNum+1;
    end
end

%% 设置激励相位

Solver = invoke(mws, 'Solver');
func_solver(Solver,Phase);
%% 设置场监视器
Monitor = invoke(mws, 'Monitor');
invoke(Monitor,'Reset');
invoke(Monitor,'Name','E-field(f=10)');
invoke(Monitor,'Domain','Frequency');
invoke(Monitor,'FieldType','Efield');
invoke(Monitor,'MonitorValue','10');
invoke(Monitor,'ExportFarfieldSource','False');
invoke(Monitor,'UseSubvolume','False');
invoke(Monitor,'Create');
release(Monitor);


%% 开始仿真
disp(1);
mesh = invoke(mws, 'Mesh');
invoke(mesh,'SetCreator', 'High Frequency');
release(mesh);
stratsolver = invoke(mws, 'Solver');
func_solver_start(stratsolver);
invoke(mws, 'Save');%保存
% % % % 仿真开始
% % solver = invoke(mws, 'Solver');
% % invoke(solver, 'Start');
% % %%仿真结束



