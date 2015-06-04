% /***********************************************************************************
%  * 文 件 名   : calcnozero.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年08月25日
%  * 文件描述   : 计算矩阵元素不为空的个数
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/08/25	创建该文件
% ***********************************************************************************/
function nozero=calcnozero(t_entity)
% 计算矩阵t_entity中不为空的元素的个数，并使用nozero进行返回
index = 1  ;
nozero = 0 ;
while index <= length(t_entity)
    if ~isempty(t_entity{index}) %判断元素不为空值
       nozero = nozero + 1 ;
    end
    index = index + 1 ;    
end