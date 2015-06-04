% /***********************************************************************************
%  * 文 件 名   : getparatype4element.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年09月10日
%  * 文件描述   : 
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/09/10	创建该文件
% *************************************************************************************
function [element i]=getparatype4element(string)

   gapturna = strfind(string,'(');
   gapturnb = strfind(string,',') ;
   gapturnc = strfind(string,')');
   gapturn = [gapturna gapturnb gapturnc] ;
       
   for i=1:(length(gapturn)-1)
     element{i} = string((gapturn(i)+1):(gapturn(i+1)-1));
   end