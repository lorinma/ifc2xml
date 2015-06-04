% /***********************************************************************************
%  * ÎÄ ¼þ Ã?   : main_CreateGeometricalXML.m
%  * ¸º Ôð ÈË   : whueht@gmail.com
%  * ´´½¨ÈÕÆ?   : 2013Äê08ÔÂ25ÈÕ
%  * ÎÄ¼þÃè?ö   : Ö÷º¯?ý
%  * °æÈ¨ËµÃ÷   : Copyright (c) 2013-2015
%  * Æä    Ë?   : 
%  * Ð?¸ÄÈÕÖ¾   : 2013/08/25	´´½¨¸ÃÎÄ¼þ
% ***********************************************************************************/
clear %Çå³ýÄ?´æ¼ÇÂ¼
clc %Çå³ýÃ?ÁîÐÐ¼ÇÂ¼
format long g ;%²»²ÉÓÃ¿ÆÑ§¼Æ?ý·¨
t1=clock ;%¼ÆËãÔËÐÐ?±¼ä
% hwait=waitbar(0,'ÇëµÈ´ý>>>>>>>>');%³õ?¼»¯½ø¶ÈÌõ
% set(findobj(hwait,'type','patch'),'edgecolor','w','facecolor','b'); %¿ØÖÆ½ø¶ÈÌõÑÕÉ«?ôÐÔ£¬Ìî³äÉ«?ÇÀ¶É«

DEBUG_ON=1;
DEBUG_OFF=0;
debug_swtich=DEBUG_OFF ;

path = '../../../Data/';
ifcfilename = 'Beam+Column';
xmlfilename = ['Geometrical-' ifcfilename];
txtfilename = ['FACESandVERTICES-' ifcfilename ] ;
ifcfilename = [ifcfilename , '.ifc'] ; 
xmlfilename = [xmlfilename,'.xml'] ;
txtfilename = [txtfilename , '.txt'];
ifcfilename = [path ifcfilename] ;
xmlfilename = [path xmlfilename] ;
txtfilename = [path txtfilename] ;

schar = '#' ;

ifcbeamnumber = 0 ; %ÁºµÄ¸ö?ý

globalFaceNo = 0 ;
globalLineNo = 0 ;
globalPointNo = 0 ;

% t_entity=cell(100,1);
% t_entity = entityinit(t_entity); %¶¨ÒåÕ?Ìåentity?ý¾?Ä£ÐÍ
% nozeroelem=calcnozero(t_entity) ;

%begin ¼ÆËãfilenameÎÄ¼þµÄ¹²¼ÆÐÐ?ý
% maxlineno = 0; 
% fid=fopen(ifcfilename,'r');
% while ~feof(fid)     %?Ç·ñ¶ÁÈ¡µ½ÎÄ¼þ½áÎ²
%     fgetl(fid);     
%     maxlineno = maxlineno + 1; 
% end
% fclose(fid);
%end ¼ÆËãfilenameÎÄ¼þµÄ¹²¼ÆÐÐ?ý

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
    
    tline=fgetl(fid) ; %=ÖðÐÐ½øÐÐ¶ÁÈ¡?ýÖµ
    
    if strncmp(tline,schar,1)%ÕÒ³ö¡®#¡¯µÄËùÔ?ÐÐ
         
         if debug_swtich == 1
            fprintf('%s\n',tline);
         end
         
         if feof(fid) == 1 %µ½ÁËÎÄ¼þÄ©Î²
            flaga = 1 ; 
         end
         
         [funname paramcontainer entityid] = resolvlinecontent(tline) ;

         if strcmp(funname,'IFCBEAM') == 1 || strcmp(funname,'IFCCOLUMN') == 1 || strcmp(funname,'IFCWALLSTANDARDCASE') == 1 
             ifcbeamnumber = ifcbeamnumber + 1 ; 
             posa = ftell(fid) ;
             docNode = xmlread(xmlfilename);%¶ÁÈ¡XMLÎÄ¼þ
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
             
             %È¥µô¿Õ¸ñ
             XML_string = xmlwrite(docNode); %XML as string
            XML_string = regexprep(XML_string,'\n[ \t\n]*\n','\n'); %removes extra tabs, spaces and extra lines
             %Write to file
            xfid = fopen(xmlfilename,'w');
            fprintf(xfid,'%s\n',XML_string);
            fclose(xfid); 
            
             posb = ftell(fid) ;
             
             if posa ~= posb 
                 flagb = 1 ; %±í?¾Ó¦¸Ã»ØÍËµ½posaµÄÎ»ÖÃ
             end
          
         end
         
%          gapcharturn = calcgapcharturn(tline) ;
%          
%          docNode = xmlread(xmlfilename);%¶ÁÈ¡XMLÎÄ¼þ
%          
%          docNode = insertelement2xml(tline,gapcharturn,i,docNode,nozeroelem,t_entity,debug_swtich) ;
%          

    end
    
%     %ÏÔ?¾½ø¶ÈÌõ
%     if steps-i<=5
%        waitbar(i/steps,hwait,'¼´½«Íê³É');
%        pause(0.05);
%     else
%        PerStr=fix(i/step);
%        str=['ÕýÔ?ÔËÐÐÖÐ',num2str(PerStr),'%'];
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

t2=clock; %¼ÆËãÔËÐÐ?±¼ä

% close(hwait);%¹Ø±Õ½ø¶ÈÌõ
fclose(txtfid) ; 

running_time=etime(t2,t1)

