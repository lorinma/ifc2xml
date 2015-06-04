% /***********************************************************************************
%  * �� �� ?   : main_CreateGeometricalXML.m
%  * �� �� ��   : whueht@gmail.com
%  * ������?   : 2013��08��25��
%  * �ļ���??  : ����??
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ?   : 
%  * ?����־   : 2013/08/25	�������ļ�
% ***********************************************************************************/
clear %���?���¼
clc %���?���м�¼
format long g ;%�����ÿ�ѧ��?��?
t1=clock ;%��������?��?
% hwait=waitbar(0,'��ȴ�>>>>>>>>');%��?��������?
% set(findobj(hwait,'type','patch'),'edgecolor','w','facecolor','b'); %���ƽ�������ɫ?��ԣ�����?����?

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

ifcbeamnumber = 0 ; %���ĸ�??

globalFaceNo = 0 ;
globalLineNo = 0 ;
globalPointNo = 0 ;

% t_entity=cell(100,1);
% t_entity = entityinit(t_entity); %����?��entity?��?ģ��
% nozeroelem=calcnozero(t_entity) ;

%begin ����filename�ļ��Ĺ�����??
% maxlineno = 0; 
% fid=fopen(ifcfilename,'r');
% while ~feof(fid)     %?Ƿ��ȡ���ļ����?
%     fgetl(fid);     
%     maxlineno = maxlineno + 1; 
% end
% fclose(fid);
%end ����filename�ļ��Ĺ�����??

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
    
    tline=fgetl(fid) ; %=���н��ж�ȡ?��?
    
    if strncmp(tline,schar,1)%�ҳ���#������?��
         
         if debug_swtich == 1
            fprintf('%s\n',tline);
         end
         
         if feof(fid) == 1 %�����ļ�ĩβ
            flaga = 1 ; 
         end
         
         [funname paramcontainer entityid] = resolvlinecontent(tline) ;

         if strcmp(funname,'IFCBEAM') == 1 || strcmp(funname,'IFCCOLUMN') == 1 || strcmp(funname,'IFCWALLSTANDARDCASE') == 1 
             ifcbeamnumber = ifcbeamnumber + 1 ; 
             posa = ftell(fid) ;
             docNode = xmlread(xmlfilename);%��ȡXML�ļ�
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
             
             %ȥ���ո�
             XML_string = xmlwrite(docNode); %XML as string
            XML_string = regexprep(XML_string,'\n[ \t\n]*\n','\n'); %removes extra tabs, spaces and extra lines
             %Write to file
            xfid = fopen(xmlfilename,'w');
            fprintf(xfid,'%s\n',XML_string);
            fclose(xfid); 
            
             posb = ftell(fid) ;
             
             if posa ~= posb 
                 flagb = 1 ; %��?�Ӧ�û��˵�posa��λ��
             end
          
         end
         
%          gapcharturn = calcgapcharturn(tline) ;
%          
%          docNode = xmlread(xmlfilename);%��ȡXML�ļ�
%          
%          docNode = insertelement2xml(tline,gapcharturn,i,docNode,nozeroelem,t_entity,debug_swtich) ;
%          

    end
    
%     %��?������?
%     if steps-i<=5
%        waitbar(i/steps,hwait,'�������');
%        pause(0.05);
%     else
%        PerStr=fix(i/step);
%        str=['��?������',num2str(PerStr),'%'];
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

t2=clock; %��������?��?

% close(hwait);%�رս�����
fclose(txtfid) ; 

running_time=etime(t2,t1)

