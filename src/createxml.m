% /***********************************************************************************
%  * �� �� ��   : createxml.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��08��25��
%  * �ļ�����   : ����һ��xml�ļ��������filename�ļ���
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/08/25	�������ļ�
% ***********************************************************************************/
function createxml(filename)
% ����һ��xml�ļ�
docNode = com.mathworks.xml.XMLUtils.createDocument('ifcXML');

docNode.appendChild(docNode.createComment('end'));
xmlwrite(filename,docNode);
% type(filename);


