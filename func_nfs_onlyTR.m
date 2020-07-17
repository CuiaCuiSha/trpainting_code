
function func_nfs_onlyTR(path_with)

%----------------------------------------------%
%   onlyTR,没有减空腔操作
%
%   用于处理cst导出的nfs文件
%   文件夹中为.dat 和 .xml格式文件
%   只处理dat文件
%   输入的变量Original_path，是字符串变量
%
%   e.g
%   Original_path='E:\GradProj\z_up_empty(f=15.1)_pw';
%   func_nfs_onlyTR(Original_path)
%   注意没有'\'哦
%
%   Date:2018.Dec.21
%   Author:cschen
%----------------------------------------------%

path_a=[path_with,'\'];
savepath_a=[path_with,'_tr\'];
mkdir(savepath_a)   % 创建一个文件夹，保存操作之后的文件

%   xml文件的copy

xml_files=dir([path_a,'*.xml']);
mx=size(xml_files,1);
for i=1:mx
    
    str_a = [path_a,'\',xml_files(i).name];
    copyfile(str_a,savepath_a)
    
end

%   dat 文件的TR操作

dat_files=dir([path_a,'*.dat']);
md=size(dat_files,1);
for i=1:md
    str_a = [path_a,dat_files(i).name]; %with
    with_data(:,:) = dlmread(str_a);
    
    %     str_b = [path_b,dat_files(i).name]; %空腔
    %     empty_data(:,:) = dlmread(str_b);
    
    [rows_with,columns_with]=size(with_data);
    %     [rows_empty,~]=size(empty_data);
    
    %   虚部和实部的列数
    Im_col=linspace(5,columns_with,(columns_with-3)/2);
    Re_col=Im_col-1;
    
    %   E 频域共轭  虚部取反
    if ~isempty(strfind(dat_files(i).name,'E'))
        
        %         temp_data(:,4:5)=flipud(temp_data(:,4:5));%实现反转
        with_data(:,Im_col)=-with_data(:,Im_col);
        save([savepath_a, dat_files(i).name],'with_data','-ascii')
        
    end
    %   H 共轭再取反 实部取反
    if ~isempty(strfind(dat_files(i).name,'H'))
        
        with_data(:,Re_col)=-with_data(:,Re_col);
        save([savepath_a, dat_files(i).name],'with_data','-ascii')
        
    end
    
    clear with_data
    clear empty_data
end
disp('Finish')

end




