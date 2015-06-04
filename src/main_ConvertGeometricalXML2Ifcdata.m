
clc
clear

path = '../data/';
xmlfilename = 'Project1'; 
% sdatafilename = ['IFCBAK-' xmlfilename '.ifc'] ;
sdatafilename = [xmlfilename '.ifc'] ;
ddatafilename = ['XMLBAK-' xmlfilename '.ifc'] ; %将要生成的ifc文件
xmlfilename = ['Geometrical-' xmlfilename '.xml'] ;
xmlfilename = [path xmlfilename] ;
sdatafilename = [path sdatafilename];
ddatafilename = [path ddatafilename];

rpositionx = 0;
rpositiony = 0;
rpositionz = 0;
rposition = [rpositionx rpositiony rpositionz];
rdirectionx = [1 0 0];
rdirectiony = [0 1 0];
rdirectionz = [0 0 1];
rdirection = [rdirectionx;rdirectiony;rdirectionz];
   
sdatacontainer = [] ;

fid=fopen(sdatafilename,'r');
while ~feof(fid)     
    tcontent = fgetl(fid) ;
    if isempty(sdatacontainer) == 1
        sdatacontainer = {tcontent} ;
    else
        sdatacontainer = [sdatacontainer ; {tcontent}] ;
    end
end
fclose(fid);

[sdatacontainerm,sdatacontainern] = size(sdatacontainer);

targetlineno =  find(strcmp(sdatacontainer,'ENDSEC;') == 1) ;
targetlineno = targetlineno(2) ;%文件插入点的行数

targetentityid = 0 ;
for j = 1:targetlineno
   targetline = sdatacontainer(j,1) ;
   targetline=targetline{1,1} ;
   if strcmp(targetline(1),'#') == 1
       p=strfind(targetline,'=') ;
       if isempty(p) == 1
          continue ; 
       end
       p=p(1) ;
       tempcontent=targetline(2:(p-1));
       tempcontent=str2num(tempcontent) ;
       if tempcontent >= targetentityid
           targetentityid = tempcontent ;
       end
   end
end

mycontent{1,1}='000000000000';

xDoc=xmlread(xmlfilename);%读取XML文件
removeIndentNodes(xDoc.getChildNodes);
xRoot=xDoc.getDocumentElement();%获取根节点，即structure

objectnode = xRoot.getElementsByTagName('object') ;
objectnum = objectnode.getLength() ;

objectpointcontentcontainter = [] ;
objectfacetcontainter = [] ;
globalcoordinatesystemvaluecontent = [] ;
globalcoordinatesystemaxis2placement3dcontent = [] ;
relativecoordinatesystemvaluecontent = [] ;

for j = 0 : objectnum-1
    objectentitynode = objectnode.item(j) ;
    entityid = char(objectentitynode.getAttribute('entityid')) ;
    typevalue = char(objectentitynode.getAttribute('type')) ;
%     typevalue
    if strcmp(typevalue, 'ifccolumn') == 1
        continue ;
    end
    if strcmp(typevalue, 'ifcwall') == 1
        continue ;
    end
    
    objectentitychildnode = objectentitynode.getFirstChild ;
    while ~isempty(objectentitychildnode)
        objectchildnodename = objectentitychildnode.getNodeName();      
        if strcmp(objectchildnodename,'globalcoordinatesystem') == 1  %***************************************** globalcoordinatesystem ****************************************
            
            objectentityvaluenode = objectentitychildnode.getFirstChild ;%取value的值
            objectentityaxis2placement3dnode = objectentityvaluenode.getNextSibling ; %取axis2placement3d的值
            objectentityaxis2placement3dentityid = char(objectentityaxis2placement3dnode.getAttribute('refid')) ;
            
            flag = 1 ;
            
            objectentityvaluenode = objectentityvaluenode.getFirstChild ;
            while ~isempty(objectentityvaluenode)
                tempcontent  = char(objectentityvaluenode.getTextContent());
                tempcontent(find(isspace(tempcontent))) = [] ; %删除空格
                objectentityvaluenode = objectentityvaluenode.getNextSibling ;
                globalcoordinatesystemvaluecontent{(j+1),flag} = tempcontent ;
                flag = flag + 1 ;
            end
            
            objectentityaxis2placement3dnode = objectentityaxis2placement3dnode.getFirstChild ;
            while ~isempty(objectentityaxis2placement3dnode)
                tempcontent  = char(objectentityaxis2placement3dnode.getTextContent());
                tempcontent(find(isspace(tempcontent))) = [] ; %删除空格
                objectentityaxis2placement3dnode = objectentityaxis2placement3dnode.getNextSibling ;
                globalcoordinatesystemvaluecontent{(j+1),flag} = tempcontent ;
                flag = flag + 1 ;
            end
           
          tmpxdirection = str2num(globalcoordinatesystemvaluecontent{(j+1),1})  ;
          tmpydirection = str2num(globalcoordinatesystemvaluecontent{(j+1),2})  ;
          tmpzdirection = str2num(globalcoordinatesystemvaluecontent{(j+1),3}) ;  
          tmpposition = str2num(globalcoordinatesystemvaluecontent{(j+1),4}) ;
          
          tmpdirection = [tmpxdirection;tmpydirection;tmpzdirection] ;
          
          temptransmatrix = calctransmatrix( rdirection,rposition,tmpdirection,tmpposition ) ;
          transmatrix = temptransmatrix ;
           %#7= IFCDIRECTION((1.,0.,0.));
           targetentityid = targetentityid + 1 ;
           tempcontent = globalcoordinatesystemvaluecontent{(j+1),5};
           tempcontent = ['#' num2str(targetentityid) '= ' 'IFCDIRECTION' '((' tempcontent '))' ';'] ;
           mycontent = [mycontent ; tempcontent] ;  
           tempglobalcsvalue = ['#' num2str(targetentityid) ','] ;
           
           %#7= IFCDIRECTION((1.,0.,0.));
           targetentityid = targetentityid + 1 ;
           tempcontent = globalcoordinatesystemvaluecontent{(j+1),6};
           tempcontent = ['#' num2str(targetentityid) '= ' 'IFCDIRECTION' '((' tempcontent '))' ';'] ;
           mycontent = [mycontent ; tempcontent] ;  
           tempglobalcsvalue = [tempglobalcsvalue '#' num2str(targetentityid)] ;
           
           %#252= IFCCARTESIANPOINT((-56.748608656703,-248.710049520697));
           targetentityid = targetentityid + 1 ;
           tempcontent = globalcoordinatesystemvaluecontent{(j+1),7};
           tempcontent = ['#' num2str(targetentityid) '= ' 'IFCCARTESIANPOINT' '((' tempcontent '))' ';'] ;
           mycontent = [mycontent ; tempcontent] ; 
           tempglobalcsvalue = ['#' num2str(targetentityid) ',' tempglobalcsvalue] ;
           %#325= IFCAXIS2PLACEMENT3D(#323,$,$);
           tempcontent = [num2str(objectentityaxis2placement3dentityid) '= ' 'IFCAXIS2PLACEMENT3D' '(' tempglobalcsvalue ')' ';'] ;
           
           tempcontent1 = num2str(objectentityaxis2placement3dentityid);
           
           for k =1:sdatacontainerm
               tempcontent2 = sdatacontainer{k} ;
               charindex = strfind(tempcontent2,'=') ;
               if isempty(charindex) == 1
                  continue ; 
               end
               charindex =charindex(1);
               if strcmp(tempcontent2(1:(charindex-1)),tempcontent1) == 1
%                   sdatacontainer{k} = tempcontent ;
                  break ;
               end
           end
        elseif strcmp(objectchildnodename,'relativecoordinatesystem') == 1 %***************************************** relativecoordinatesystem ****************************************
           objectentityaxis2placement3dnode = objectentitychildnode.getFirstChild ; %取axis2placement3d的值
           objectentityaxis2placement3dentityid = char(objectentityaxis2placement3dnode.getAttribute('refid')) ;
           flag = 1 ;
           objectentityaxis2placement3dnode = objectentityaxis2placement3dnode.getFirstChild ;
           while ~isempty(objectentityaxis2placement3dnode)
                tempcontent  = char(objectentityaxis2placement3dnode.getTextContent());
                tempcontent(find(isspace(tempcontent))) = [] ; %删除空格
                objectentityaxis2placement3dnode = objectentityaxis2placement3dnode.getNextSibling ;
                relativecoordinatesystemvaluecontent{(j+1),flag} = tempcontent ;
                flag = flag + 1 ;
           end
           
          tmpxdirection = str2num(relativecoordinatesystemvaluecontent{(j+1),2}) ;
          tmpzdirection = str2num(relativecoordinatesystemvaluecontent{(j+1),1}) ;  
          tmpydirection = cross(tmpzdirection,tmpxdirection) ;
          tmpposition = str2num(relativecoordinatesystemvaluecontent{(j+1),3}) ;
          
          tmpdirection = [tmpxdirection;tmpydirection;tmpzdirection] ;
          
          temptransmatrix = calctransmatrix( rdirection,rposition,tmpdirection,tmpposition ) ;
          transmatrix = temptransmatrix*transmatrix ;
           
           %#7= IFCDIRECTION((1.,0.,0.));
           targetentityid = targetentityid + 1 ;
           tempcontent = relativecoordinatesystemvaluecontent{(j+1),1};
           tempcontent = ['#' num2str(targetentityid) '= ' 'IFCDIRECTION' '((' tempcontent '))' ';'] ;
           mycontent = [mycontent ; tempcontent] ; 
           tempglobalcsvalue = ['#' num2str(targetentityid) ','] ;
           
           %#7= IFCDIRECTION((1.,0.,0.));
           targetentityid = targetentityid + 1 ;
           tempcontent = relativecoordinatesystemvaluecontent{(j+1),2};
           tempcontent = ['#' num2str(targetentityid) '= ' 'IFCDIRECTION' '((' tempcontent '))' ';'] ;
           mycontent = [mycontent ; tempcontent] ;  
           tempglobalcsvalue = [tempglobalcsvalue '#' num2str(targetentityid)] ;
           
           %#252= IFCCARTESIANPOINT((-56.748608656703,-248.710049520697));
           targetentityid = targetentityid + 1 ;
           tempcontent = relativecoordinatesystemvaluecontent{(j+1),3};
           tempcontent = ['#' num2str(targetentityid) '= ' 'IFCCARTESIANPOINT' '((' tempcontent '))' ';'] ;
           mycontent = [mycontent ; tempcontent] ;  
           tempglobalcsvalue = ['#' num2str(targetentityid) ',' tempglobalcsvalue] ;
           %#325= IFCAXIS2PLACEMENT3D(#323,$,$);
           tempcontent = [num2str(objectentityaxis2placement3dentityid) '= ' 'IFCAXIS2PLACEMENT3D' '(' tempglobalcsvalue ')' ';'] ;
           
           tempcontent1 = num2str(objectentityaxis2placement3dentityid) ;
           
           for k =1:sdatacontainerm
               tempcontent2 = sdatacontainer{k} ;
               charindex = strfind(tempcontent2,'=') ;
               if isempty(charindex) == 1
                  continue ; 
               end
               charindex =charindex(1);
               if strcmp(tempcontent2(1:(charindex-1)),tempcontent1) == 1
%                   sdatacontainer{k} = tempcontent ;
                  break ;
               end
           end
                    
        else  %***************************************** productdefinitionshape ****************************************
           objectentitynode = objectentitynode.getElementsByTagName('productdefinitionshape') ;
           objectentitynode = objectentitynode.item(0) ;

%获取点的集合**************************************************************************************************
           objectentitypointnode = objectentitynode.getElementsByTagName('point') ;
           objectrntitypointnum = objectentitypointnode.getLength() ; 
           objectpointindexcontainter = 0 ;%存放point点的索引号集合
           minnumberindex = 0 ;
           for k = 0: (objectrntitypointnum-1)
             objectentitypointnodetmp  = objectentitypointnode.item(k);
             objectentitypointnodeindex = char(objectentitypointnodetmp.getAttribute('pointNO')) ;
             objectentitypointnodeindex(find(isspace(objectentitypointnodeindex))) = [] ;
             objectentitypointnodeindex = str2num(objectentitypointnodeindex) ;
             
             if k == 0
                 minnumberindex = objectentitypointnodeindex
             else
                 if minnumberindex >=  objectentitypointnodeindex
                     minnumberindex = objectentitypointnodeindex ;
                 end
             end
             
             objectentitypointnodecontent = char(objectentitypointnodetmp.getTextContent()) ;
             objectentitypointnodecontent(find(isspace(objectentitypointnodecontent))) = [] ;       
            tempindex = find(objectpointindexcontainter == objectentitypointnodeindex) ;
            if isempty(tempindex) == 1
              objectpointindexcontainter = [objectpointindexcontainter objectentitypointnodeindex];
              objectpointcontentcontainter{(j+1),(length(objectpointindexcontainter)-1)} = objectentitypointnodecontent ; % 存放点的内容值
            end        
           end
%           objectpointcontentcontainter((j+1),1) = {num2str(length(objectpointindexcontainter)-1)} ;%点的集合
%            objectpointcontentcontainter{(j+1),1} = [];%第一列清空

            pointentitybaseid  = targetentityid  ;
            for k = 1 : (length(objectpointindexcontainter)-1)
               targetentityid = targetentityid + 1 ;
               tempcontent = str2num(objectpointcontentcontainter{(j+1),k}); 
               tempcontent = [tempcontent 1] ;
               tempcontent = tempcontent/transmatrix  ; %key point
               tempcontent = tempcontent(1:3);
               tempcontent = round(tempcontent*10000000)/10000000 ; %计算精度
               
               tempcontentx = num2str(tempcontent(1)) ;
               tempcontenty = num2str(tempcontent(2)) ;
               tempcontentz = num2str(tempcontent(3)) ;
               if isempty(strfind(tempcontentx,'.')) == 1
                   tempcontentx = [tempcontentx '.'];
               end
               if isempty(strfind(tempcontenty,'.')) == 1
                   tempcontenty = [tempcontenty '.'];
               end
               if isempty(strfind(tempcontentz,'.')) == 1
                   tempcontentz = [tempcontentz '.'];
               end
               
               tempcontent = [tempcontentx ',' tempcontenty ',' tempcontentz];
               tempcontent = ['#' num2str(targetentityid) '= ' 'IFCCARTESIANPOINT' '((' tempcontent '))' ';'] ;
               mycontent = [mycontent ; tempcontent] ;                
            end
%获取点的集合**********************************************************************************************************

          objectentitycsnode = objectentitynode.getElementsByTagName('closeshellentity') ;
          objectrntitycsnum = objectentitycsnode.getLength() ;
          tempcloseshellcontainer = 0 ;
          for k = 0 :(objectrntitycsnum-1)
              tempobjectentitycsnode  = objectentitycsnode.item(k) ;
              objectentityfacenode = tempobjectentitycsnode.getElementsByTagName('face') ;
              objectrntityfacenum = objectentityfacenode.getLength() ;
              tempfacecontainer = 0 ;
              for i = 0 : (objectrntityfacenum-1) %遍历每一个面
                  tempobjectentityfacenode = objectentityfacenode.item(i);
                  tempobjectentityfacechildnode = tempobjectentityfacenode.getFirstChild ; %获取线的实体
                  temppointidcontainer = 0 ;
                  while ~isempty(tempobjectentityfacechildnode)
                      tempobjectentityfacechildlinenode = tempobjectentityfacechildnode.getFirstChild ;%获取线的第一个点的实体
                      pointid = char(tempobjectentityfacechildlinenode.getAttribute('pointNO')) ;
                      pointid = str2num(pointid) ;
                      temppointidcontainer = [temppointidcontainer pointid] ;
                      tempobjectentityfacechildnode= tempobjectentityfacechildnode.getNextSibling ;
                  end
                  temppointidcontainer(1) = [] ;
                  
                  tempcontent = [] ;
                  pointcontent = [] ;
                  for x = 1 :length(temppointidcontainer)
                      tempcontent = '#' ;
                      tempcontent = [tempcontent num2str(temppointidcontainer(x)+pointentitybaseid-minnumberindex+1)] ;
                      if x~= length(temppointidcontainer)
                          tempcontent = [tempcontent ','] ;
                      end
                      if isempty(pointcontent) == 1
                          pointcontent = tempcontent ;
                      else
                          pointcontent = [pointcontent tempcontent] ;
                      end
                  end
                  
                  %#872= IFCPOLYLOOP((#862,#854,#858,#860));
                  targetentityid = targetentityid + 1 ;
                  tempcontent = pointcontent;
                  tempcontent = ['#' num2str(targetentityid) '= ' 'IFCPOLYLOOP' '((' tempcontent '))' ';'] ;
                  mycontent = [mycontent ; tempcontent] ;     
                  ifcpolyloopid = targetentityid ;
                  
                  %#874= IFCFACEOUTERBOUND(#872,.T.);
                  targetentityid = targetentityid + 1 ;
                  tempcontent = ['#' num2str(ifcpolyloopid)];
                  tempcontent = ['#' num2str(targetentityid) '= ' 'IFCFACEOUTERBOUND' '(' tempcontent ',' '.T.' ')' ';'] ;
                  mycontent = [mycontent ; tempcontent] ;   
                  ifcfaceouterboundid = targetentityid ;
                  
                  %#875= IFCFACE((#874));
                  targetentityid = targetentityid + 1 ;
                  tempcontent = ['#' num2str(ifcfaceouterboundid)];
                  tempcontent = ['#' num2str(targetentityid) '= ' 'IFCFACE' '((' tempcontent '))' ';'] ;
                  mycontent = [mycontent ; tempcontent] ;   
                  ifcfaceid = targetentityid ;    
                  tempfacecontainer = [tempfacecontainer ifcfaceid] ;
              end
              
              tempfacecontainer(1) = [] ;
              
              %#949= IFCCLOSEDSHELL((#875,#880,#885,#890,#895,#900,#905,#910));
              tempcontent = [] ;
              tempfacecontent = [] ;
              for i = 1:length(tempfacecontainer)
                  tempfacecontent = ['#' num2str(tempfacecontainer(i))] ;
                  if i~=length(tempfacecontainer)
                      tempfacecontent = [tempfacecontent ','] ;
                  end
                  if isempty(tempcontent) == 1
                      tempcontent = tempfacecontent ;
                  else
                      tempcontent = [tempcontent tempfacecontent] ;
                  end
              end         
              targetentityid = targetentityid + 1 ;
              tempcontent = ['#' num2str(targetentityid) '= ' 'IFCCLOSEDSHELL' '((' tempcontent '))' ';'] ;
              mycontent = [mycontent ; tempcontent] ;   
              ifcclosedshellid = targetentityid ;    
              
              %#951= IFCFACETEDBREP(#949);
              targetentityid = targetentityid + 1 ;
              tempcontent = ['#' num2str(ifcclosedshellid)];
              tempcontent = ['#' num2str(targetentityid) '= ' 'IFCFACETEDBREP' '(' tempcontent  ')' ';'] ;
              mycontent = [mycontent ; tempcontent] ;   
              ifcfacetedbrepid = targetentityid ;    
              tempcloseshellcontainer = [tempcloseshellcontainer ifcfacetedbrepid] ;
          end
              tempcloseshellcontainer(1) = [] ;
              
              tempshellcontent = [] ;
              tempcontent = [] ;
              for k = 1 : length(tempcloseshellcontainer)
                  tempshellcontent = ['#' num2str(tempcloseshellcontainer(k))] ;
                  if k~=length(tempcloseshellcontainer)
                      tempshellcontent = [tempshellcontent ','];
                  end
                  if isempty(tempcontent) == 1
                      tempcontent = tempshellcontent ;
                  else
                      tempcontent = [tempcontent tempshellcontent] ;
                  end
              end
              
             templinecontent = findindexcontent(sdatafilename,entityid) ; %取出IfcObjectPlacement当前行内容    
             [funname temparamcontainer tentityid]=resolvlinecontent(templinecontent) ;    
             ifcproductrepresentation = temparamcontainer{1,7};
             templinecontent = findindexcontent(sdatafilename,ifcproductrepresentation) ; %取出IfcObjectPlacement当前行内容    
             [funname temparamcontainer tentityid]=resolvlinecontent(templinecontent) ;    
             [ifcproductdefinitionshape ifcproductdefinitionshapenum]=getparatype4element(temparamcontainer{1,3}) ;
             for k = 1 : ifcproductdefinitionshapenum                
                 templinecontent = findindexcontent(sdatafilename,ifcproductdefinitionshape{k}) ; %取出IfcObjectPlacement当前行内容    
                 [funname temparamcontainer tentityid]=resolvlinecontent(templinecontent) ; 
                 if strcmp(temparamcontainer{1,2} ,'''Body''') == 1                   
                     tempcontent = [tentityid '= ' 'IFCSHAPEREPRESENTATION' '(' temparamcontainer{1,1} ',' temparamcontainer{1,2} ','  '''Brep''' ',' '(' tempcontent ')' ')' ';'] ;
                     break;
                 end
             end
             
             for k =1:sdatacontainerm
               tempcontent2 = sdatacontainer{k} ;
               charindex = strfind(tempcontent2,'=') ;
               if isempty(charindex) == 1
                  continue ; 
               end
               charindex =charindex(1);
               if strcmp(tempcontent2(1:(charindex-1)),tentityid) == 1
                  sdatacontainer{k} = tempcontent ;
                  break ;
               end
             end
             
        end
        
        objectentitychildnode = objectentitychildnode.getNextSibling ;      
    end
      
end

mycontent = mycontent(2:length(mycontent)) ;

ddatacontainer = [sdatacontainer(1:(targetlineno-1)) ; mycontent ; sdatacontainer(targetlineno:length(sdatacontainer))];

fid=fopen(ddatafilename,'wt+');

for i = 1: length(ddatacontainer)
   tcontent = ddatacontainer{i};
   fprintf(fid,'%s\n',tcontent);
end

fclose(fid) ;
