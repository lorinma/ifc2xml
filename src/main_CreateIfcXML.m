% /***********************************************************************************
%  * �� �� ��   : main_ifcdata2ifcxml.m
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
hwait=waitbar(0,'��ȴ�>>>>>>>>');%��ʼ��������
set(findobj(hwait,'type','patch'),'edgecolor','w','facecolor','b'); %���ƽ�������ɫ���ԣ����ɫ����ɫ

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
t_entity = entityinit(t_entity); %��������entity����ģ��
nozeroelem=calcnozero(t_entity) ;

%begin ����filename�ļ��Ĺ�������
max_line_no = 0; 
fid=fopen(ifcfilename,'r');
while ~feof(fid)     
    fgetl(fid);     
    max_line_no = max_line_no + 1; 
end
fclose(fid);
%end ����filename�ļ��Ĺ�������

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
    
    tline=fgetl(fid);%=���н��ж�ȡ��ֵ
    
    if strncmp(tline,schar,1)%�ҳ���#����������
        
         if debug_swtich == 1
            fprintf('%d:%s\n',i,tline);
         end
         
         gapcharturn = calcgapcharturn(tline) ;
         
         docNode = xmlread(xmlfilename);%��ȡXML�ļ�
         
         [docNode xmlflag]= insertelement2xml(tline,gapcharturn,i,docNode,nozeroelem,t_entity,debug_swtich,HEADER,xmlflag) ;
         
         %ȥ���ո�
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
    
    %��ʾ������
    if steps-i<=5
       waitbar(i/steps,hwait,'�������');
       pause(0.05);
    else
       PerStr=fix(i/step);
       str=['����������',num2str(PerStr),'%'];
       waitbar(i/steps,hwait,str);
       pause(0.05);
    end
    
    i=i+1;
    
end

fclose(fid);

t2=clock; %��������ʱ��

close(hwait);%�رս�����

running_time=etime(t2,t1)

