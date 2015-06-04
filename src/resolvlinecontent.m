% /***********************************************************************************
%  * 文 件 名   : resolvlinecontent.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年09月10日
%  * 文件描述   : 按照行解析IFC文件内容
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/09/14	创建该文件
%
%funamename
%paramcontainer 包含此行的所有参数以及每个参数的属性
%
% *************************************************************************************


function [funname paramcontainer entityid]=resolvlinecontent(linecontent)

% gapcharturn的第一个数值是=，第二个数值是第一个（，最后一个数值是最后一个）
% #329=
% IFCPROPERTYSET('0hQyUek0bC2BakaR4Z0c$h',#52,'\X2\51764ED6\X0\',(),(,,(),,),$,(#319,#320,#323,#324,#326,#327,(111.,222.)),#55);
   gapcharturn = calcgapcharturn(linecontent) ;

   funname = linecontent((gapcharturn(1)+2):(gapcharturn(2)-1));%gapcharturn(1)+2 此处的是因为中间有一个空格

   entityid = linecontent(1:(gapcharturn(1)-1)) ;

   paramno = 1 ;%第几个元素
   paramindex = 2;%第一个是等号索引，第二个是第一个(的索引，所以此处是2
   while paramindex <= (length(gapcharturn)-1)
        paramcontainer{1,paramno} = linecontent((gapcharturn(paramindex)+1):(gapcharturn(paramindex+1)-1));%逐个的数值
        paramcontainer{2,paramno} = resolvparam(paramcontainer{1,paramno}) ;
        
        paramindex = paramindex + 1 ;
        paramno = paramno + 1 ;
   end
   
return