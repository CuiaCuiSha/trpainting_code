function func_solver(Solver,Phase)
% Phase 是一个一维幅度
% e.g. 
%   Solver = invoke(mws, 'Solver');
%   func_solver(Solver,Phase);


invoke(Solver, 'ResetExcitationModes');
invoke(Solver, 'SParameterPortExcitation','False');  
invoke(Solver, 'SimultaneousExcitation','True');
invoke(Solver, 'SetSimultaneousExcitAutoLabel','False');
invoke(Solver, 'SetSimultaneousExcitationLabel','drivesignal');
invoke(Solver, 'SetSimultaneousExcitationOffset','Phaseshift');  % 时序还是相位
invoke(Solver, 'PhaseRefFrequency','10'); % 中心频率
invoke(Solver, 'ExcitationSelectionShowAdditionalSettings','False');

for PortNum=1:length(Phase)% 相位设置
    invoke(Solver, 'ExcitationPortMode',PortNum,'1','1.0',Phase(PortNum),'default','True');
end
release(Solver);
end
% With Solver 
%      .ResetExcitationModes 
%      .SParameterPortExcitation "False" 
%      .SimultaneousExcitation "True" 
%      .SetSimultaneousExcitAutoLabel "False" 
%      .SetSimultaneousExcitationLabel "simsignal" 
%      .SetSimultaneousExcitationOffset "Phaseshift" 
%      .PhaseRefFrequency "10" 
%      .ExcitationSelectionShowAdditionalSettings "False" 
%      .ExcitationPortMode "1", "1", "1.0", "0.0", "default", "True" 
%                        portnum，不知道，幅度，相位，激励信号，是否激励 
%      .ExcitationPortMode "2", "1", "1.0", "0.0", "default", "True" 
% End With 



