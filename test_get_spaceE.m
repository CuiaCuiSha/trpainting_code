% Matlab_CST_Current_Build_test 中获取电流源分布情况的
% 将电流源分布对应在坐标中。10GHz
% 包括相位和幅度

distribution=importdata('E:\TRpainting\code\data_Hy_zmax.dat');
%--------------------------------------------%
%   225*2=450mm,对应10GHz,15倍lambda
%   cst mesh 刚好划分了326格子，近似于一个波长划分20个格子
%   这个是Hy，所以刚好对应磁流源，又刚好是y向，所以电流源反而好设置
%--------------------------------------------%

% 初始化
PortNum=1;
% Phase=zeros(length(distribution),1);
for n=1:length(distribution)
    if distribution(n,1)==distribution(n+1,1) 
        % 判断是否为一个x，只有在同一个x上生成电流源，换行的时候不生成
        P1 = distribution(n,1:3);
        P2 = distribution(n+1,1:3);
        current=complex(distribution(n,4),distribution(n,5));
        Amplitude = abs(current);
        Phase(PortNum)=angle(current);
        % 幅度设置可以在这里，也可以在最后的激励中设置
        %     DiscretePort = invoke(mws, 'DiscretePort');
        %     func_build_DiscretePort(DiscretePort,PortNum,P1,P2,Amplitude )
        PortNum=PortNum+1;
    end
end


