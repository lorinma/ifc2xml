% /***********************************************************************************
%  * 文 件 名   : convertifcxml2ifcdata.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年09月18日
%  * 文件描述   : 初始化数据模型
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/09/18	创建该文件
% ***********************************************************************************/

function  [hmatrix dmatrix ematrix] = convertifcxml2ifcdata(xmlfilename)

tentity=cell(100,1);
tentity = entityinit(tentity); %定义整体entity数据模型
nozeroelem=calcnozero(tentity) ;
% tentity{i,1}函数名
% tentity{i,2}{1,j}{1,1}元素
% length(tentity{i,2}) 元素个数

xDoc=xmlread(xmlfilename);%读取XML文件
xRoot=xDoc.getDocumentElement();%获取根节点，即Video

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
        upperfunname = upper(funname); %转化为大写，对应小写的是lower
        content = [content tempcont upperfunname];
        tempcont = '(' ;
        content = [content tempcont];
        
        for elemi = 1 : elemmaxno
            elemchildcontainer = elementity.getElementsByTagName(tentity{i,2}{1,elemi}{1,1}{1,1}) ;%tentity{i,2}{1,elemi}{1,1}元素成员，tentity{i,2}{1,elemi}{1,1}元素成员的类别
            elemchildnumber = elemchildcontainer.getLength() ;
    
            if elemchildnumber == 0
               tempcont = '$' ;
            elseif elemchildnumber == 1
               elemchildcontainer = elemchildcontainer.item(0);
               elemchildattrcontainer = elemchildcontainer.getElementsByTagName(tentity{i,2}{1,elemi}{1,2}{1,1}) ;
               elemchildattrnumber = elemchildattrcontainer.getLength() ;
 
               if elemchildattrnumber == 0 %元素成员没有属性
                   tempcont = char(elemchildcontainer.getTextContent());
                   tempcont(find(isspace(tempcont)))=[] ;%删除所有空格；
                   
                   FUNCTIONentity=char(elemchildcontainer.getAttribute('function')) ;              
                   POSentity=char(elemchildcontainer.getAttribute('pos')) ;%应对（'XXXXXXX'）这样的格式
                   if isempty(FUNCTIONentity) == 0
%                       FUNCTIONentity = FUNCTIONentity(1:(length(FUNCTIONentity)-length('-wrapper'))) ;%要去掉'-wrapper'这部分内容
                      FUNCTIONentity = upper(FUNCTIONentity);
                      tempcont = [FUNCTIONentity '(' tempcont ')'];
                   elseif isempty(POSentity) == 0
                      tempcont = [FUNCTIONentity '(' tempcont ')'];
                   end
                            
               elseif elemchildattrnumber == 1 %元素成员有属性
                   elemchildattrcontainerentity = elemchildattrcontainer.item(0) ;
                   if isempty(char(elemchildattrcontainerentity.getTextContent())) == 1 %判断属性内容是否为空 ,若为空则肯定为#xx
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
                   
               elseif elemchildattrnumber > 1 %元素成员有多个属性 ，需要区分 （xx，xx，xx）与（#xx,##xx,##xx）
                   tempcont = '(' ;
                   tempcont1 = [] ;
                   for elemattri = 1:elemchildattrnumber
                       elemchildattrcontainerentity = [];
                       elemchildattrcontainerentity = elemchildattrcontainer.item(elemattri-1) ;
                       if isempty(char(elemchildattrcontainerentity.getTextContent())) == 1 %判断属性内容是否为空 ,若为空则肯定为#xx
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

% 获取节点
Slides= xRoot.getElementsByTagName('Slide');% 获取Slide节点集合
Num_Slides=Slides.getLength();%查看Slide节点的个数，返回2
Slide1=Slides.item(0);%从Slide节点集合获取第一个Slide节点，注意集合的索引已从0开始的
% 对于Title的这样的单一节点，同样使用getElementsByTagName方法获取：Title= xRoot.getElementsByTagName('Title').item(0);

% 获取属性值，设置属性值，添加属性值
Slide1Time=char(Slide1.getAttribute('Time'));%获取Slide1的Time属性,注意getTextContent()返回的是java.lang.String类型，使用char函数将它转化为MATLAB中的字符串类型
Slide1.setAttribute('Time','0:05');%修改Slide1的Time属性
Slide1.setAttribute('Date','2011/11/14');%为Slide1添加Date属性,并设置为'2011/11/14'

% 获取文本内容，设置文本内容
Slide1Content=char(Slide1.getTextContent());%获取Slide1的文本内容
Slide1.setTextContent('Good morning!');%设置Slide1的文本内容

% 新建节点，插入节点
newSlide=xDoc.createElement('Slide');%新建newSlide节点
newSlide.setAttribute('Time','2:00');%设置Time属性
newSlide.setAttribute('Headline','Thank you!');%设置Headline属性
newSlide.setTextContent('That''s all!');%设置文本内容
xRoot.appendChild(newSlide);%将newSlide插入xRoot的末尾

xmlwrite('regular_output.xml',xDoc);%保存结果到example_output.xml
