% /***********************************************************************************
%  * �� �� ��   : isdecdigital.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��08��25��
%  * �ļ�����   : �ж��ַ�A������
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/08/25	�������ļ�
%  * ����bug
%    ���� #31= IFCDIMENSIONALEXPONENTS(0,0,0,0,0,0,0); �ı��ʽԭ���޷�����
% ***********************************************************************************/
function param_type=resolvparam(S)
%
%���������ڽ����������β�
%
% 1 $ ��ʾ��   #39= IFCAXIS2PLACEMENT3D(#3,$,$);���˴���������
% 2 '' ��ʾ�ַ��� #1= IFCORGANIZATION($,'Autodesk Revit 2013',$,$,$)�� �˴���Autodesk Revit 2013��ʾ�ַ���
% 3 #xx ��ʾ����   #39= IFCAXIS2PLACEMENT3D(#3,$,$); �˴���#3��ʾ����
% 4 () ���ű�ʾһ��ʵ��  #25= IFCDIRECTION((0.,-1.));(0.,-1.)��ʾһ��ʵ��,% �У�#x,#y������#x��,(xx.,yyy),(xx.)�����������
% 5  .ENUM. ��ʾö������ #30= IFCSIUNIT(*,.PLANEANGLEUNIT.,$,.RADIAN.); �˴���.PLANEANGLEUNIT.,.RADIAN.����ʾö������
% 6 XXX.XXX  ��ʾ��ͨ����  #101= IFCCURVESTYLEFONTPATTERN(76.2,838.2); �˴���76.2 ��838.2��ʾ����
% 7 FUC() ��ʾ���� #229=
% IFCPROPERTYSINGLEVALUE('\X2\4FA754115BF96B63\X0\',$,IFCINTEGER(0),$);IFCINTEGER��ʾ����,�������βν���һ��
% 8 *



  param_type = 0 ;

  if length(S) == 1  && (S(1) == '$')
      param_type = 1 ;
  elseif (S(1) == '''') && (S(length(S)) == '''')
      param_type = 2 ;
  elseif (S(1) == '#') && (length(S) >= 2) 
      param_type = 3 ;
  elseif (S(1) == '(') && (S(length(S)) == ')')
      param_type = 4 ;
  elseif (S(1) == '.') && (S(length(S)) == '.')
      param_type = 5 ;
%   elseif (isdecdigital(S(1)) == 1) && (length(strfind(S,'.')) >= 1)
  elseif (isdecdigital(S(1)) == 1) || (S(1) == '-' &&  isdecdigital(S(2)) == 1) %�޸�����#31= IFCDIMENSIONALEXPONENTS(0,0,0,0,0,0,0);�����ı��ʽ ,�޸�-xx.xx���������ж���׼ȷ����
      param_type = 6 ;
  elseif ((isdecdigital(S(1)) == 2) || (isdecdigital(S(1)) == 3))  && (length(strfind(S,'(')) >= 1) && (length(strfind(S,')')) >= 1)
      param_type = 7 ;
  elseif length(S) == 1  && (S(1) == '*')
      param_type = 8 ;
  end
      