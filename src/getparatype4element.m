% /***********************************************************************************
%  * �� �� ��   : getparatype4element.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��09��10��
%  * �ļ�����   : 
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/09/10	�������ļ�
% *************************************************************************************
function [element i]=getparatype4element(string)

   gapturna = strfind(string,'(');
   gapturnb = strfind(string,',') ;
   gapturnc = strfind(string,')');
   gapturn = [gapturna gapturnb gapturnc] ;
       
   for i=1:(length(gapturn)-1)
     element{i} = string((gapturn(i)+1):(gapturn(i+1)-1));
   end