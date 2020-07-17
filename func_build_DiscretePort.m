function func_build_DiscretePort(DiscretePort,PortNum,P1,P2,Amplitude)
% 子函数用来创建电流源
% PortNum端口号
% P1,P2坐标都是一个三维数组，分别代表xyz坐标
% Amplitude 电流源幅度

invoke(DiscretePort, 'Reset');
invoke(DiscretePort, 'PortNumber',PortNum);%PortNum
invoke(DiscretePort, 'Type','Current');
invoke(DiscretePort, 'Label','');
invoke(DiscretePort, 'Folder','');
invoke(DiscretePort, 'Impedance','50.0');
invoke(DiscretePort, 'VoltagePortImpedance','0.0');
invoke(DiscretePort, 'Voltage','1.0');
invoke(DiscretePort, 'Current',Amplitude); % 幅度
invoke(DiscretePort, 'SetP1','False',P1(1),P1(2),P1(3));% P1坐标
invoke(DiscretePort, 'SetP2','False',P2(1),P2(2),P2(3));% P2坐标
invoke(DiscretePort, 'InvertDirection','False');
invoke(DiscretePort, 'LocalCoordinates','False');
invoke(DiscretePort, 'Monitor','True');
invoke(DiscretePort, 'Radius','0.0');
invoke(DiscretePort, 'Wire','');
invoke(DiscretePort, 'Position','end1');
invoke(DiscretePort, 'Create');
release(DiscretePort);
end
%------------vbs
% % With DiscretePort 
% %      .Reset 
% %      .PortNumber "1" 
% %      .Type "Current" 
% %      .Label "" 
% %      .Folder "" 
% %      .Impedance "50.0" 
% %      .VoltagePortImpedance "0.0" 
% %      .Voltage "1.0" 
% %      .Current "1.0" 
% %      .SetP1 "False", "0.0", "2", "0.0" 
% %      .SetP2 "False", "0.0", "24", "0.0" 
% %      .InvertDirection "False" 
% %      .LocalCoordinates "False" 
% %      .Monitor "True" 
% %      .Radius "0.0" 
% %      .Wire "" 
% %      .Position "end1" 
% %      .Create 
% % End With %  release(DiscretePort);


