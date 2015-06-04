% /***********************************************************************************
%  * 文 件 ?   : main_CreateGeometricalXML.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日?   : 2013年08月25日
%  * 文件描??  : 主函??
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    ?   : 
%  * ?改日志   : 2013/08/25	创建该文件
% ***********************************************************************************/
clear %清除?存记录
clc %清除?令行记录
format long g ;%不采用科学计??
t1=clock ;%计算运行?奔?
% hwait=waitbar(0,'请等待>>>>>>>>');%初?蓟忍?
% set(findobj(hwait,'type','patch'),'edgecolor','w','facecolor','b'); %控制进度条颜色?粜裕畛渖?抢渡?

DEBUG_ON=1;
DEBUG_OFF=0;
debug_swtich=DEBUG_OFF ;

path = '../../../Data/';
ifcfilename = 'Beam';
xmlfilename = ['Geometrical-' ifcfilename];
txtfilename = ['FACESandVERTICES-' ifcfilename ] ;
ifcfilename = [ifcfilename , '.ifc'] ; 
xmlfilename = [xmlfilename,'.xml'] ;
txtfilename = [txtfilename , '.txt'];
ifcfilename = [path ifcfilename] ;
xmlfilename = [path xmlfilename] ;
txtfilename = [path txtfilename] ;

schar = '#' ;

ifcbeamnumber = 0 ; %梁的个??

globalFaceNo = 0 ;
globalLineNo = 0 ;
globalPointNo = 0 ;

% t_entity=cell(100,1);
% t_entity = entityinit(t_entity); %定义?体entity??模型
% nozeroelem=calcnozero(t_entity) ;

%begin 计算filename文件的共计行??
% maxlineno = 0; 
% fid=fopen(ifcfilename,'r');
% while ~feof(fid)     %?欠穸寥〉轿募嵛?
%     fgetl(fid);     
%     maxlineno = maxlineno + 1; 
% end
% fclose(fid);
%end 计算filename文件的共计行??

% if debug_swtich == 1
%   fprintf('maxline=%d\n',max_line_no);
% end

 creategeometricalxml(xmlfilename) ;
 
 txtfid=fopen(txtfilename,'w+');

% steps=max_line_no;
% step=steps/100;

lineid = 1 ;
fid=fopen(ifcfilename,'r') ;

flaga = 0 ;
flagb = 0 ;

while ~feof(fid)
    
    tline=[];
    
    tline=fgetl(fid) ; %=逐行进行读取??
    
    if strncmp(tline,schar,1)%找出‘#’的所?行
         
         if debug_swtich == 1
            fprintf('%s\n',tline);
         end
         
         if feof(fid) == 1 %到了文件末尾
            flaga = 1 ; 
         end
         
         [funname paramcontainer entityid] = resolvlinecontent(tline) ;

         if strcmp(funname,'IFCBEAM') == 1 || strcmp(funname,'IFCCOLUMN') == 1 || strcmp(funname,'IFCWALLSTANDARDCASE') == 1 
             ifcbeamnumber = ifcbeamnumber + 1 ; 
             posa = ftell(fid) ;
             docNode = xmlread(xmlfilename);%读取XML文件
             if strcmp(funname,'IFCBEAM') == 1
%                  entityid
                  [docNode,globalFaceNo,globalLineNo,globalPointNo,txtfid] = ifcbeamhandle(ifcfilename,paramcontainer ,lineid,docNode, ifcbeamnumber,entityid,globalFaceNo,globalLineNo,globalPointNo,txtfid);
             elseif strcmp(funname,'IFCCOLUMN') == 1
%                  entityid
                  [docNode,globalFaceNo,globalLineNo,globalPointNo,txtfid] = ifccolumnhandle(ifcfilename,paramcontainer ,lineid,docNode, ifcbeamnumber,entityid,globalFaceNo,globalLineNo,globalPointNo,txtfid);
             else 
%                  entityid
                  [docNode,globalFaceNo,globalLineNo,globalPointNo,txtfid] = ifcwallhandle(ifcfilename,paramcontainer ,lineid,docNode, ifcbeamnumber,entityid,globalFaceNo,globalLineNo,globalPointNo,txtfid);
             end
             
             %去掉空格
             XML_string = xmlwrite(docNode); %XML as string
            XML_string = regexprep(XML_string,'\n[ \t\n]*\n','\n'); %removes extra tabs, spaces and extra lines
             %Write to file
            xfid = fopen(xmlfilename,'w');
            fprintf(xfid,'%s\n',XML_string);
            fclose(xfid); 
            
             posb = ftell(fid) ;
             
             if posa ~= posb 
                 flagb = 1 ; %表?居Ω没赝说絧osa的位置
             end
          
         end
         
%          gapcharturn = calcgapcharturn(tline) ;
%          
%          docNode = xmlread(xmlfilename);%读取XML文件
%          
%          docNode = insertelement2xml(tline,gapcharturn,i,docNode,nozeroelem,t_entity,debug_swtich) ;
%          

    end
    
%     %显?窘忍?
%     if steps-i<=5
%        waitbar(i/steps,hwait,'即将完成');
%        pause(0.05);
%     else
%        PerStr=fix(i/step);
%        str=['正?运行中',num2str(PerStr),'%'];
%        waitbar(i/steps,hwait,str);
%        pause(0.05);
%     end

    
    lineid = lineid + 1 ;
    
    if flagb == 1 && flaga ~= 1
         fseek(fid ,posa ,'bof') ;         
         flagb = 0 ;
    end

end

 fclose(fid);

t2=clock; %计算运行?奔?

% close(hwait);%关闭进度条
fclose(txtfid) ; 

running_time=etime(t2,t1)

