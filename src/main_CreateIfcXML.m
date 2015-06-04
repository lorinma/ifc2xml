% /***********************************************************************************
%  * 文 件 名   : main_ifcdata2ifcxml.m
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
hwait=waitbar(0,'请等待>>>>>>>>');%初始化进度条
set(findobj(hwait,'type','patch'),'edgecolor','w','facecolor','b'); %控制进度条颜色属性，填充色是蓝色

DEBUG_ON=1;
DEBUG_OFF=0;
debug_swtich=DEBUG_OFF ;

path = '../data/';
ifcfilename = 'Project1'; 
xmlfilename = ['IFC-' ifcfilename];
ifcfilename = [ifcfilename , '.ifc'] ; 
xmlfilename = [xmlfilename,'.xml'] ;
ifcfilename = [path ifcfilename] ;
xmlfilename = [path xmlfilename] ;

schar = '#' ;
HEADER=[];   
xmlflag = 1 ;

t_entity=cell(100,1);
t_entity = entityinit(t_entity); %定义整体entity数据模型
nozeroelem=calcnozero(t_entity) ;

%begin 计算filename文件的共计行数
max_line_no = 0; 
fid=fopen(ifcfilename,'r');
while ~feof(fid)     
    fgetl(fid);     
    max_line_no = max_line_no + 1; 
end
fclose(fid);
%end 计算filename文件的共计行数

if debug_swtich == 1
  fprintf('maxline=%d\n',max_line_no);
end

steps=max_line_no;
step=steps/100;

createxml(xmlfilename) ;

fid=fopen(ifcfilename,'r') ;
i=1 ;

while i <= max_line_no
    
    tline=[];
    
    tline=fgetl(fid);%=逐行进行读取数值
    
    if strncmp(tline,schar,1)%找出‘#’的所在行
        
         if debug_swtich == 1
            fprintf('%d:%s\n',i,tline);
         end
         
         gapcharturn = calcgapcharturn(tline) ;
         
         docNode = xmlread(xmlfilename);%读取XML文件
         
         [docNode xmlflag]= insertelement2xml(tline,gapcharturn,i,docNode,nozeroelem,t_entity,debug_swtich,HEADER,xmlflag) ;
         
         %去掉空格
         XML_string = xmlwrite(docNode); %XML as string
         XML_string = regexprep(XML_string,'\n[ \t\n]*\n','\n'); %removes extra tabs, spaces and extra lines
         %Write to file
         xfid = fopen(xmlfilename,'w');
         fprintf(xfid,'%s\n',XML_string);
         fclose(xfid); 
    else
        tempcontent = {tline};
        
        if isempty(HEADER) == 1
            HEADER = tempcontent ;
        else
            HEADER = [HEADER;tempcontent];
        end
        
    end
    
    %显示进度条
    if steps-i<=5
       waitbar(i/steps,hwait,'即将完成');
       pause(0.05);
    else
       PerStr=fix(i/step);
       str=['正在运行中',num2str(PerStr),'%'];
       waitbar(i/steps,hwait,str);
       pause(0.05);
    end
    
    i=i+1;
    
end

fclose(fid);

t2=clock; %计算运行时间

close(hwait);%关闭进度条

running_time=etime(t2,t1)

