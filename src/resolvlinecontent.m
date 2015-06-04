% /***********************************************************************************
%  * �� �� ��   : resolvlinecontent.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��09��10��
%  * �ļ�����   : �����н���IFC�ļ�����
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/09/14	�������ļ�
%
%funamename
%paramcontainer �������е����в����Լ�ÿ������������
%
% *************************************************************************************


function [funname paramcontainer entityid]=resolvlinecontent(linecontent)

% gapcharturn�ĵ�һ����ֵ��=���ڶ�����ֵ�ǵ�һ���������һ����ֵ�����һ����
% #329=
% IFCPROPERTYSET('0hQyUek0bC2BakaR4Z0c$h',#52,'\X2\51764ED6\X0\',(),(,,(),,),$,(#319,#320,#323,#324,#326,#327,(111.,222.)),#55);
   gapcharturn = calcgapcharturn(linecontent) ;

   funname = linecontent((gapcharturn(1)+2):(gapcharturn(2)-1));%gapcharturn(1)+2 �˴�������Ϊ�м���һ���ո�

   entityid = linecontent(1:(gapcharturn(1)-1)) ;

   paramno = 1 ;%�ڼ���Ԫ��
   paramindex = 2;%��һ���ǵȺ��������ڶ����ǵ�һ��(�����������Դ˴���2
   while paramindex <= (length(gapcharturn)-1)
        paramcontainer{1,paramno} = linecontent((gapcharturn(paramindex)+1):(gapcharturn(paramindex+1)-1));%�������ֵ
        paramcontainer{2,paramno} = resolvparam(paramcontainer{1,paramno}) ;
        
        paramindex = paramindex + 1 ;
        paramno = paramno + 1 ;
   end
   
return