% /***********************************************************************************
%  * �� �� ��   : getparatype4element.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��09��10��
%  * �ļ�����   : 
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/09/10	�������ļ�
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