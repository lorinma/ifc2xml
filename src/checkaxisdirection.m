% /***********************************************************************************
%  * 文 件 名   : getparatype4element.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年09月10日
%  * 文件描述   : 
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/09/10	创建该文件
% *************************************************************************************

function directiontype = checkaxisdirection(paracontainter)

   x = str2num(paracontainter{1});
   y = str2num(paracontainter{2});
   z = str2num(paracontainter{3});

   if x == 1
      directiontype = 'Relative X Axis' ;
   elseif x == -1
      directiontype = 'Relative -X Axis' ;
   elseif y == 1
      directiontype = 'Relative Y Axis' ;
   elseif y == -1
      directiontype = 'Relative -Y Axis';
   elseif z == 1
      directiontype = 'Relative Z Axis' ;
   elseif z == -1
      directiontype = 'Relative -Z Axis' ;
   else
      directiontype = 'ERROR' ;
   end