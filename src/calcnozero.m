% /***********************************************************************************
%  * �� �� ��   : calcnozero.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��08��25��
%  * �ļ�����   : �������Ԫ�ز�Ϊ�յĸ���
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/08/25	�������ļ�
% ***********************************************************************************/
function nozero=calcnozero(t_entity)
% �������t_entity�в�Ϊ�յ�Ԫ�صĸ�������ʹ��nozero���з���
index = 1  ;
nozero = 0 ;
while index <= length(t_entity)
    if ~isempty(t_entity{index}) %�ж�Ԫ�ز�Ϊ��ֵ
       nozero = nozero + 1 ;
    end
    index = index + 1 ;    
end