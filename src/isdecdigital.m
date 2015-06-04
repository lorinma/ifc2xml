% /***********************************************************************************
%  * �� �� ��   : isdecdigital.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��08��25��
%  * �ļ�����   : �ж��ַ�A������
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/08/25	�������ļ�
% ***********************************************************************************/
function value=isdecdigital(A)
% �ж��ַ�A�Ƿ�Ϊ��ֵ0-9���Ƿ�Ϊa-z, �Ƿ�ΪA-Z
% ����1����ʾ0-9
% ����2����ʾa-z
% ����3����ʾA-Z
% if (A == '0') || (A == '1') || (A == '2') || (A == '3') || (A == '4') || (A == '5') || (A == '6') || (A == '7') || (A == '8') || (A == '9')   
if (abs(A) >= 48) && (abs(A) <= 57) %'0'-48,'9'-57
   value =  1 ;
elseif (abs(A) >= 97) && (abs(A) <= 122) %'a'-97,'z'-132
   value =  2
elseif (abs(A) >= 65) && (abs(A) <= 90) %'A'-65,'Z'-90
   value =  3 ;
else
   value =  0 ;    
end