% /***********************************************************************************
%  * �� �� ��   : convertifcxml2ifcdata.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��09��18��
%  * �ļ�����   : ��ʼ������ģ��
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/09/18	�������ļ�
% ***********************************************************************************/

function  [hmatrix dmatrix ematrix] = convertifcxml2ifcdata(xmlfilename)

tentity=cell(100,1);
tentity = entityinit(tentity); %��������entity����ģ��
nozeroelem=calcnozero(tentity) ;
% tentity{i,1}������
% tentity{i,2}{1,j}{1,1}Ԫ��
% length(tentity{i,2}) Ԫ�ظ���

xDoc=xmlread(xmlfilename);%��ȡXML�ļ�
xRoot=xDoc.getDocumentElement();%��ȡ���ڵ㣬��Video

hmatrix = [] ;
dmatrix = [] ;
ematrix = [] ;
flag = 1;

headnode = xRoot.getElementsByTagName('ISO-10303-21') ;
if headnode.getLength() == 1
   headcontent = 'ISO-10303-21;';
   hmatrix = {headcontent} ;
end

headnode = xRoot.getElementsByTagName('Header') ;
if headnode.getLength() == 1
   headcontent = 'HEADER;';
   headcontent1 = 'FILE_DESCRIPTION((''ViewDefinition [CoordinationView]''),''2;1'');';
   if isempty(hmatrix) == 1
      hmatrix = headcontent ; 
   else
       hmatrix = [hmatrix ;{headcontent};{headcontent1}];
   end
end

headcontent = 'FILE_NAME(' ;

headnode = headnode.item(0) ;
headnode1 = headnode.getElementsByTagName('name') ;
if headnode1.getLength() == 1
    headcontent1 = char(headnode1.item(0).getTextContent());
    headcontent = [headcontent headcontent1];
    headcontent1 = ',' ;
    headcontent = [headcontent headcontent1];
end 
headnode1 = headnode.getElementsByTagName('time_stamp') ;
if headnode1.getLength() == 1
    headcontent1 = char(headnode1.item(0).getTextContent());
    headcontent = [headcontent headcontent1];
    headcontent1 = ',' ;
    headcontent = [headcontent headcontent1];
end 
headnode1 = headnode.getElementsByTagName('author') ;
if headnode1.getLength() == 1
    headcontent1 = char(headnode1.item(0).getTextContent());
    headcontent = [headcontent headcontent1];
    headcontent1 = ',' ;
    headcontent = [headcontent headcontent1];
end 
headnode1 = headnode.getElementsByTagName('organization') ;
if headnode1.getLength() == 1
    headcontent1 = char(headnode1.item(0).getTextContent());
    headcontent = [headcontent headcontent1];
    headcontent1 = ',' ;
    headcontent = [headcontent headcontent1];
end 
headnode1 = headnode.getElementsByTagName('preprocessor_version') ;
if headnode1.getLength() == 1
    headcontent1 = char(headnode1.item(0).getTextContent());
    headcontent = [headcontent headcontent1];
    headcontent1 = ',' ;
    headcontent = [headcontent headcontent1];
end 
headnode1 = headnode.getElementsByTagName('originating_system') ;
if headnode1.getLength() == 1
    headcontent1 = char(headnode1.item(0).getTextContent());
    headcontent = [headcontent headcontent1];
    headcontent1 = ',' ;
    headcontent = [headcontent headcontent1];
end 
headnode1 = headnode.getElementsByTagName('authorization') ;
if headnode1.getLength() == 1
    headcontent1 = char(headnode1.item(0).getTextContent());
    headcontent = [headcontent headcontent1];
end 

    headcontent1 = ');' ;
    headcontent = [headcontent headcontent1];
    hmatrix = [hmatrix ;{headcontent}];
    
    headcontent = 'FILE_SCHEMA((''IFC2X3''));' ;
    hmatrix = [hmatrix ;{headcontent}];
    headcontent = 'ENDSEC;' ;
    hmatrix = [hmatrix ;{headcontent}];
    headcontent = ' ' ;
    hmatrix = [hmatrix ;{headcontent}];
    headcontent = 'DATA;' ;
    hmatrix = [hmatrix ;{headcontent}];
    
for i = 1:nozeroelem
    content = [] ;
    funname = tentity{i,1}{1,1} ;
    elemmaxno = length(tentity{i,2}) ;
    
    elemcontainer = xRoot.getElementsByTagName(funname) ;
    elemnumber = elemcontainer.getLength() ;
    
    if elemnumber == 0
       sprintf('%s is not in your %s',funname,xmlfilename);
       continue ; 
    end
    
    for j = 0 : (elemnumber-1)
        elementity = elemcontainer.item(j) ;
        IDentity=char(elementity.getAttribute('id')) ;
        
        if isempty(IDentity)
           continue ; 
        end

        content = '#' ;
        content = [content IDentity];
        tempcont = '= ';
        upperfunname = upper(funname); %ת��Ϊ��д����ӦСд����lower
        content = [content tempcont upperfunname];
        tempcont = '(' ;
        content = [content tempcont];
        
        for elemi = 1 : elemmaxno
            elemchildcontainer = elementity.getElementsByTagName(tentity{i,2}{1,elemi}{1,1}{1,1}) ;%tentity{i,2}{1,elemi}{1,1}Ԫ�س�Ա��tentity{i,2}{1,elemi}{1,1}Ԫ�س�Ա�����
            elemchildnumber = elemchildcontainer.getLength() ;
    
            if elemchildnumber == 0
               tempcont = '$' ;
            elseif elemchildnumber == 1
               elemchildcontainer = elemchildcontainer.item(0);
               elemchildattrcontainer = elemchildcontainer.getElementsByTagName(tentity{i,2}{1,elemi}{1,2}{1,1}) ;
               elemchildattrnumber = elemchildattrcontainer.getLength() ;
 
               if elemchildattrnumber == 0 %Ԫ�س�Աû������
                   tempcont = char(elemchildcontainer.getTextContent());
                   tempcont(find(isspace(tempcont)))=[] ;%ɾ�����пո�
                   
                   FUNCTIONentity=char(elemchildcontainer.getAttribute('function')) ;              
                   POSentity=char(elemchildcontainer.getAttribute('pos')) ;%Ӧ�ԣ�'XXXXXXX'�������ĸ�ʽ
                   if isempty(FUNCTIONentity) == 0
%                       FUNCTIONentity = FUNCTIONentity(1:(length(FUNCTIONentity)-length('-wrapper'))) ;%Ҫȥ��'-wrapper'�ⲿ������
                      FUNCTIONentity = upper(FUNCTIONentity);
                      tempcont = [FUNCTIONentity '(' tempcont ')'];
                   elseif isempty(POSentity) == 0
                      tempcont = [FUNCTIONentity '(' tempcont ')'];
                   end
                            
               elseif elemchildattrnumber == 1 %Ԫ�س�Ա������
                   elemchildattrcontainerentity = elemchildattrcontainer.item(0) ;
                   if isempty(char(elemchildattrcontainerentity.getTextContent())) == 1 %�ж����������Ƿ�Ϊ�� ,��Ϊ����϶�Ϊ#xx
                       REFentity=char(elemchildattrcontainerentity.getAttribute('ref')) ;
                       tempcont = '#' ;
                       tempcont = [tempcont REFentity];
                       
                       POSentity=char(elemchildattrcontainerentity.getAttribute('pos')) ;
                       if isempty(POSentity) == 0 && strcmp(POSentity,'1') == 1
                           tempcont = ['(' tempcont ')'] ;
                       end
                   else 
                       tempcont = char(elemchildattrcontainerentity.getTextContent());
                       POSentity=char(elemchildattrcontainerentity.getAttribute('pos')) ;
                       if isempty(POSentity) == 0 && strcmp(POSentity,'1') == 1
                           tempcont = ['(' tempcont ')'] ;
                       end
                   end
                   
               elseif elemchildattrnumber > 1 %Ԫ�س�Ա�ж������ ����Ҫ���� ��xx��xx��xx���루#xx,##xx,##xx��
                   tempcont = '(' ;
                   tempcont1 = [] ;
                   for elemattri = 1:elemchildattrnumber
                       elemchildattrcontainerentity = [];
                       elemchildattrcontainerentity = elemchildattrcontainer.item(elemattri-1) ;
                       if isempty(char(elemchildattrcontainerentity.getTextContent())) == 1 %�ж����������Ƿ�Ϊ�� ,��Ϊ����϶�Ϊ#xx
                          REFentity=char(elemchildattrcontainerentity.getAttribute('ref')) ;
                          tempcont2 = '#' ;
                          tempcont2 = [tempcont2 REFentity];
                          
                          if elemattri == 1
                             tempcont1 = tempcont2 ;
                          else
                             tempcont1 = [tempcont1 tempcont2];
                          end
                          
                          if elemattri ~= elemchildattrnumber
                             tempcont2 = ',' ;
                             tempcont1 = [tempcont1 tempcont2];
                          end
                       else 
                          tempcont2 = char(elemchildattrcontainerentity.getTextContent());
                          if elemattri == 1
                             tempcont1 = tempcont2 ;
                          else
                             tempcont1 = [tempcont1 tempcont2];
                          end
                           
                          if elemattri ~= elemchildattrnumber
                             tempcont2 = ',' ;
                             tempcont1 = [tempcont1 tempcont2];
                          end
                       end
                       
                   end
                   tempcont2 = ')' ;
                   tempcont = [tempcont tempcont1 tempcont2] ;
%                    content = [content tempcont];
                   
               else
                   ERROR='Error.......\n'
                   return ;
               end
               
            else
                ERROR='Error.......\n'
                return ;
            end
            
            content = [content tempcont];
            
            if  elemi ~= elemmaxno
                tempcont = ',';
                content = [content tempcont];
            end

        end
        
        tempcont = ');' ;
        
        content = [content tempcont] ;
        
        if flag == 1
            dmatrix = {content} ;
            flag  = 0;
        else
            dmatrix = [dmatrix ; {content}];
        end
    end
    
end

econtent = 'ENDSEC;' ;
ematrix = {econtent} ;

econtent = '  ' ;
ematrix =[ematrix ;{econtent}] ;

econtent = 'END-ISO-10303-21;' ;
ematrix = [ematrix ;{econtent}] ;
return ;

% ��ȡ�ڵ�
Slides= xRoot.getElementsByTagName('Slide');% ��ȡSlide�ڵ㼯��
Num_Slides=Slides.getLength();%�鿴Slide�ڵ�ĸ���������2
Slide1=Slides.item(0);%��Slide�ڵ㼯�ϻ�ȡ��һ��Slide�ڵ㣬ע�⼯�ϵ������Ѵ�0��ʼ��
% ����Title�������ĵ�һ�ڵ㣬ͬ��ʹ��getElementsByTagName������ȡ��Title= xRoot.getElementsByTagName('Title').item(0);

% ��ȡ����ֵ����������ֵ���������ֵ
Slide1Time=char(Slide1.getAttribute('Time'));%��ȡSlide1��Time����,ע��getTextContent()���ص���java.lang.String���ͣ�ʹ��char��������ת��ΪMATLAB�е��ַ�������
Slide1.setAttribute('Time','0:05');%�޸�Slide1��Time����
Slide1.setAttribute('Date','2011/11/14');%ΪSlide1���Date����,������Ϊ'2011/11/14'

% ��ȡ�ı����ݣ������ı�����
Slide1Content=char(Slide1.getTextContent());%��ȡSlide1���ı�����
Slide1.setTextContent('Good morning!');%����Slide1���ı�����

% �½��ڵ㣬����ڵ�
newSlide=xDoc.createElement('Slide');%�½�newSlide�ڵ�
newSlide.setAttribute('Time','2:00');%����Time����
newSlide.setAttribute('Headline','Thank you!');%����Headline����
newSlide.setTextContent('That''s all!');%�����ı�����
xRoot.appendChild(newSlide);%��newSlide����xRoot��ĩβ

xmlwrite('regular_output.xml',xDoc);%��������example_output.xml
