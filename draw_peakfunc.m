%---------------------------------%
%   批量修改nfs文件中dat得场值
%   使其电场的相位分布呈现peaks函数的分布
%
%   Author:CS.CHEN
%   Data: 2019.July.9th
%---------------------------------%
clc;clear;close all

testpath='E:\TRpainting\nfs_data\MakeMeshField-source (f=10)_pw';
original=testpath;

% original=uigetdir('*.*','选取所在得文件夹');
original_path=[original,'\'];
save_path=[original,'_peaks\'];    % 设置处理后保存得文件位置
mkdir(save_path);   % 创建一个文件夹，保存操作之后的文件

%   xml文件的copy
xml_files=dir([original_path,'*.xml']);
mx=size(xml_files,1);
for i=1:mx
    if ~isempty(strfind(xml_files(i).name,'E')) % 只copy电场的信息
        str_x = [original_path,'\',xml_files(i).name];
        copyfile(str_x,save_path)
    end
end



%   dat文件的分类操作
dat_files=dir([original_path,'*.dat']);
md=size(dat_files,1);
for i=1:md
    str_dat = [original_path,dat_files(i).name];
    data_edit(:,:) = dlmread(str_dat);
    
    [~,columns_with]=size(data_edit);
    
    %   虚部和实部的列数
    Im_col=linspace(5,columns_with,(columns_with-3)/2);
    Re_col=Im_col-1;
    
    %   只对电场信息做处理，磁场不处理，也不copy
    
    if ~isempty(strfind(dat_files(i).name,'E')) %   全部E归0
        data_edit(:,Im_col)=0;
        data_edit(:,Re_col)=0;
        save([save_path, dat_files(i).name],'data_edit','-ascii')
        
    end
     
    
    
    if ~isempty(strfind(dat_files(i).name,'Ex_z'))
        
        [rows_with,columns_with]=size(data_edit);
        %   虚部和实部的列数
        Im_col=linspace(5,columns_with,(columns_with-3)/2);
        Re_col=Im_col-1;
        
        unit_mat=ones(rows_with,length(Im_col(:)));
        
        
        %   获得归一化的peaks函数
        peak_mat=peaks(218);
        peak_max=max(max(peak_mat));peak_min=min(min(peak_mat));
        peak_nor=(peak_mat-peak_min)/(peak_max-peak_min);%  归一化
        peak_linear=peak_nor(:)*360;        %   转换为360度
        peak_linear=peak_linear.*unit_mat;
        
        data_edit(:,Im_col)=sind(peak_linear);
        data_edit(:,Re_col)=cosd(peak_linear);
        save([save_path, dat_files(i).name],'data_edit','-ascii')
        disp('11')
       
    end
    
    clear data_edit
end

disp('ok')



