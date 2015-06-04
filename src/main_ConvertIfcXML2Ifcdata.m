% /***********************************************************************************
%  * �� �� ��   : main_ifcxml2ifcdata.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��08��25��
%  * �ļ�����   : ������
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/08/25	�������ļ�
% ***********************************************************************************/
clear
clc
t1=clock ;%��������ʱ��

path = '../data/';
ifcfilename = 'Project1'; 
xmlfilename = ['IFC-' ifcfilename];
ifcfilename = ['IFCBAK-' ifcfilename  '.ifc'] ; 
xmlfilename = [xmlfilename,'.xml'] ;
ifcfilename = [path ifcfilename] ;
xmlfilename = [path xmlfilename] ;

[hmatrix dmatrix ematrix] = convertifcxml2ifcdata(xmlfilename) ;

datamatrix = sortifcdatamatrixbyid(dmatrix) ;

matrix = [hmatrix;datamatrix;ematrix];

fid=fopen(ifcfilename,'wt+');

for i = 1: length(matrix)
   tcontent = matrix{i};
   fprintf(fid,'%s\n',tcontent);
end

fclose(fid) ;

t2=clock; %��������ʱ��

running_time=etime(t2,t1)