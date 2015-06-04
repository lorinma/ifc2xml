% /***********************************************************************************
%  * �� �� ��   : getpointanddirectvalue.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��09��10��
%  * �ļ�����   : 
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/09/10	�������ļ�
% *************************************************************************************
function [funcname type value]=getpointanddirectvalue(filename,string)

   linecontent = findindexcontent(filename,string) ;
   [funcname paramcontainer entityid]=resolvlinecontent(linecontent) ;
   
   n = size(paramcontainer) ;
   if n(2) ~= 1 || paramcontainer{2,1} ~= 4
      ERROR='wrong............................................';
      return ;
   end
   
   if strcmp(funcname ,'IFCCARTESIANPOINT') == 1 
       type = 'IFCCARTESIANPOINT' ;
   elseif strcmp(funcname,'IFCDIRECTION') == 1
       type = 'IFCDIRECTION' ;
   else
      type = 'ERROR'
      return ;
   end
   
   tbuf = paramcontainer{1,1} ;
   gapturna = strfind(tbuf,'(');
   gapturnb = strfind(tbuf,',') ;
   gapturnc = strfind(tbuf,')');
   gapturn = [gapturna gapturnb gapturnc] ;
       
   for i=1:(length(gapturn)-1)
     value{i} = tbuf((gapturn(i)+1):(gapturn(i+1)-1));
   end
       
   

   