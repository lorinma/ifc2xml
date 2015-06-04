% /***********************************************************************************
%  * 文 件 名   : main_ifcxml2ifcdata.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年08月25日
%  * 文件描述   : 主函数
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/08/25	创建该文件
% ***********************************************************************************/
clear
clc
t1=clock ;%计算运行时间

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

t2=clock; %计算运行时间

running_time=etime(t2,t1)