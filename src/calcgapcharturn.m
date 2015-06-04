% /***********************************************************************************
%  * 文 件 名   : calcgapcharturn.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年08月25日
%  * 文件描述   : 寻找分割符所在的索引
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/08/25	创建该文件
% ***********************************************************************************/
function gapcharturn=calcgapcharturn(A)
% 计算类似如下表达式的分隔符号，的真正位置
% #329= IFCPROPERTYSET('0hQyUek0bC2BakaR4Z0c$h',#52,'\X2\51764ED6\X0\',(),(,,(),,),$,(#319,#320,#323,#324,#326,#327,(111.,222.)),#55);
% 括号配对情况如下
%     50    51
%     56    57
%     53    60
%     95   105
%     64   106
%      1   111
% 凡是不再范围以内的分隔符号认为是分隔符
% A是传入的整行的数据
% gapcharturn的第一个数值是=，第二个数值是第一个（，最后一个数值是最后一个）

    j=1 ;
    k=[];
    m=[];
    while j<=length(A)
  
 %以下采用栈的方式获取（与）的配对性,m是存放配置的x*2的矩阵，凡是不在这个范围内的，索引均认为是分隔符
       if A(j) == '('
         k=[k j];
       elseif A(j) == ')'
         m=[m;k(length(k)) j] ;
         k(length(k))=[];
       end
        
       j=j+1; 
    end
    
    len = size(m) ;
    if len >= 1
       m(len(1),:)=[];
    end
    
    len = size(m) ;
    
    gapcharturn=[];
    
    n=strfind(A,',');%以此作为分隔符
    j=1;
    while j <= length(n)
        flag = 0 ;
        i = 1 ;
        
        if ~isempty(m)
           while (i <= len(1))%需要判断a是否为空
             if (n(j) >= m(i,1)) && (n(j) <= m(i,2))
              flag = 1 ;
              break ;
             end
             i = i + 1;
           end
        end
        
        if flag == 0
           gapcharturn = [gapcharturn n(j)];%取出所有分隔符的索引
        end
        j = j + 1 ;
    end
    
    n = strfind(A,'(');
    gapcharturn = [n(1) gapcharturn]; %获取第一个(的索引号
    
    n = strfind(A,'=');
    gapcharturn = [n(1) gapcharturn];%获取等号的索引号, 这两者的次序不能够反

    n = strfind(A,')');
    gapcharturn = [gapcharturn n(length(n))];%获取第一个(的索引号
    
    
    