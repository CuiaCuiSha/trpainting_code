%----------------------------------------------%
%   TR painting中
%   为了验证点源到连续源，sinc分布和的过渡
%   有Amplitude和复数形式的
%   复数形式尚未完成
%
%
%
%   Date:2020.July.10
%   Author:cschen
%----------------------------------------------%


clear;clc;close all

x_real=-100:0.02:100;
y_real=sinc(x_real);

x_imag=-50:0.01:50;
y_imag=sinc(x_imag);

for ii=1:1:200
    % 实部
    y_real=y_real+sinc(x_real+ii*0.3);
    subplot(2,2,1)
    plot(x_real,y_real);
    axis([-50,50,-2,5]);
    % 虚部
    y_imag=y_imag+sinc(x_imag+1*ii);
    subplot(2,2,2)
    plot(x_imag,y_imag)
    axis([-50,50,-2,5]);
    % 辐角
    subplot(2,2,3)
    plot(x_imag,angle(y_real+1i*y_imag))
    axis([-50,50,-2,5]);
    
    % 模值
    subplot(2,2,4)
    plot(x_imag,abs(y_real+1i*y_imag))
    axis([-50,50,-2,5]);pause(0.02);
    
end







