function func_solver_start(stratsolver)
% Phase 是一个一维幅度
% e.g. 
%   stratsolver = invoke(mws, 'Solver');
%   func_solver_start(stratsolver);
invoke(stratsolver, 'Method','Hexahedral');
invoke(stratsolver, 'CalculationType','TD-S');
invoke(stratsolver, 'StimulationPort','Selected');
invoke(stratsolver, 'StimulationMode','All');
invoke(stratsolver, 'SteadyStateLimit','-40');
invoke(stratsolver, 'MeshAdaption','False');
invoke(stratsolver, 'AutoNormImpedance','False');
invoke(stratsolver, 'NormingImpedance','50');
invoke(stratsolver, 'CalculateModesOnly','False');
invoke(stratsolver, 'SParaSymmetry','False');
invoke(stratsolver, 'StoreTDResultsInCache','False');
invoke(stratsolver, 'FullDeembedding','False');
invoke(stratsolver, 'SuperimposePLWExcitation','False');
invoke(stratsolver, 'UseSensitivityAnalysis','False');
release(stratsolver);
end
% 原vbs
% With Solver 
%      .Method "Hexahedral"
%      .CalculationType "TD-S"
%      .StimulationPort "Selected"
%      .StimulationMode "All"
%      .SteadyStateLimit "-40"
%      .MeshAdaption "False"
%      .AutoNormImpedance "False"
%      .NormingImpedance "50"
%      .CalculateModesOnly "False"
%      .SParaSymmetry "False"
%      .StoreTDResultsInCache  "False"
%      .FullDeembedding "False"
%      .SuperimposePLWExcitation "False"
%      .UseSensitivityAnalysis "False"
% End With


 


