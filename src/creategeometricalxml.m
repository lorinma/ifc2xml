% /***********************************************************************************
%  * �� �� ��   : createxml.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��08��25��
%  * �ļ�����   : ����һ��xml�ļ��������filename�ļ���
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/08/25	�������ļ�
% ***********************************************************************************/
function creategeometricalxml(filename)
% ����һ��xml�ļ�
% docNode = com.mathworks.xml.XMLUtils.createDocument('geometricalXML');
docNode = com.mathworks.xml.XMLUtils.createDocument('structure');
docNode.appendChild(docNode.createComment('end'));
xmlwrite(filename,docNode);
% type(filename);
