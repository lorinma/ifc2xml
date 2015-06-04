% /***********************************************************************************
%  * 文 件 名   : ifcbeamhandle.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年09月14日
%  * 文件描述   : 
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/10/11	创建该文件 , 
%  * 修改记录   
%    1 2013/10/13 完善此文件
% *************************************************************************************
function [docNode,globalFaceNo,globalLineNo,globalPointNo,txtfid]=ifccolumnhandle(filename,paramcontainer,lineid,docNode ,ifcbeamnumber,entityid,globalFaceNo,globalLineNo,globalPointNo,txtfid)

% IFCCOLUMN parameters struct
% 1 GlobalId	 : 	IfcGloballyUniqueId;
% 2 OwnerHistory	 : 	IfcOwnerHistory;
% 3 Name	 : 	OPTIONAL IfcLabel;
% 4 Description	 : 	OPTIONAL IfcText;
% 5 ObjectType	 : 	OPTIONAL IfcLabel;
% 6 ObjectPlacement	 : 	OPTIONAL IfcObjectPlacement;
% 7 Representation	 : 	OPTIONAL IfcProductRepresentation;
% 8 Tag	 : 	OPTIONAL IfcIdentifier;

%计算分隔符索引，gapcharturn的第一个数值是=，第二个数值是第一个（，最后一个数值是最后一个）
% = （1 ，2， 3， 4， 5， 6， 7， 8）
% gapcharturn=calcgapcharturn(linecontent) ;
   
	lenth = size(paramcontainer);

	if lenth(2) ~= 8
		fprintf('%s %dth fatmat is wrong,in ifcbeam',filename ,lineid);
		return ;
	end
   
	xRoot = docNode.getDocumentElement();%获取根节点，
	objectname = 'object' ;   
	objectEntityID=entityid;

	ifcbeamentitynode = docNode.createElement(objectname) ;
	xRoot.appendChild(ifcbeamentitynode) ;
	ifcbeamentitynode.setAttribute('type','ifccolumn') ;
	ifcbeamentitynode.setAttribute('objectNO',num2str(ifcbeamnumber)) ;
	ifcbeamentitynode.setAttribute('entityid',num2str(entityid)) ;

	ifcbeamGCSnode = docNode.createElement('globalcoordinatesystem');
	ifcbeamRCSnode = docNode.createElement('relativecoordinatesystem');
	ifcbeamPDSnode = docNode.createElement('productdefinitionshape');

	ifcbeamentitynode.appendChild(ifcbeamGCSnode);
	ifcbeamentitynode.appendChild(ifcbeamRCSnode);
	ifcbeamentitynode.appendChild(ifcbeamPDSnode);

	ifcbeamGCSvaluenode = docNode.createElement('Value'); %全局坐标系 ，数值部分
	ifcbeamGCSvaluenode.setAttribute('type','r'); %表明此处为只读变量
	ifcbeamGCSnode.appendChild(ifcbeamGCSvaluenode);
	ifcbeamGCSvalueXdnode = docNode.createElement('x-axis');
	ifcbeamGCSvalueYdnode = docNode.createElement('y-axis');
	ifcbeamGCSvalueZdnode = docNode.createElement('z-axis');
	ifcbeamGCSvalueOPnode = docNode.createElement('OriginPoint');
	ifcbeamGCSvaluenode.appendChild(ifcbeamGCSvalueXdnode);
	ifcbeamGCSvaluenode.appendChild(ifcbeamGCSvalueYdnode);
	ifcbeamGCSvaluenode.appendChild(ifcbeamGCSvalueZdnode);
	ifcbeamGCSvaluenode.appendChild(ifcbeamGCSvalueOPnode);

	ifcbeamGCSaxis2placement3dnode = docNode.createElement('Axis2placement3d'); %全局坐标系 ，参考坐标系
	ifcbeamGCSaxis2placement3dnode.setAttribute('type','rw'); %表明此处为只读变量
	ifcbeamGCSnode.appendChild(ifcbeamGCSaxis2placement3dnode);
	ifcbeamGCSaxis2placement3dZDnode = docNode.createElement('Zdirection');
	ifcbeamGCSaxis2placement3dXDnode = docNode.createElement('Xdirection');
	ifcbeamGCSaxis2placement3dOPnode = docNode.createElement('OriginPoint');
	ifcbeamGCSaxis2placement3dnode.appendChild(ifcbeamGCSaxis2placement3dZDnode);
	ifcbeamGCSaxis2placement3dnode.appendChild(ifcbeamGCSaxis2placement3dXDnode);
	ifcbeamGCSaxis2placement3dnode.appendChild(ifcbeamGCSaxis2placement3dOPnode);

	ifcbeamRCSaxis2placement3dnode = docNode.createElement('Axis2placement3d');  %相对坐标系 ，参考坐标系
	ifcbeamRCSaxis2placement3dnode.setAttribute('type','rw'); %表明此处为只读变量
	ifcbeamRCSnode.appendChild(ifcbeamRCSaxis2placement3dnode);
	ifcbeamRCSaxis2placement3dZDnode = docNode.createElement('Zdirection');
	ifcbeamRCSaxis2placement3dXDnode = docNode.createElement('Xdirection');
	ifcbeamRCSaxis2placement3dOPnode = docNode.createElement('OriginPoint');
	ifcbeamRCSaxis2placement3dnode.appendChild(ifcbeamRCSaxis2placement3dZDnode);
	ifcbeamRCSaxis2placement3dnode.appendChild(ifcbeamRCSaxis2placement3dXDnode);
	ifcbeamRCSaxis2placement3dnode.appendChild(ifcbeamRCSaxis2placement3dOPnode);

	ifcobjectplacement = paramcontainer{1,6};
	ifcproductrepresentation = paramcontainer{1,7};
 
% IFCLOCALPLACEMENT IFC STRUCT
% PlacementRelTo	 : 	OPTIONAL IfcObjectPlacement; 相对坐标系
% RelativePlacement	 : 	IfcAxis2Placement; 实际的坐标点（相对，相对坐标系而言），包含相对中心坐标点与Z,X方向，Y方向由Z，X方向共同决定，
% END_ENTITY;

% IFCAXIS2PLACEMENT3D IFC STRUCT
% ENTITY IfcAxis2Placement3D;
% Location	 : 	IfcCartesianPoint;
% Axis	 : 	OPTIONAL IfcDirection;         Z方向 ，by whueht@gmail.com
% RefDirection	 : 	OPTIONAL IfcDirection; X方向   by whueht@gmail.com
% END_ENTITY;

% IFCCARTESIANPOINT IFC STRUCT	
% ENTITY IfcCartesianPoint;
% Coordinates	 : 	LIST [1:3] OF IfcLengthMeasure; 空间中的一个坐标点， by whueht@gmail.com
% END_ENTITY;

% IFCDIRECTION IFC STRUCT
% ENTITY IfcDirection;
% DirectionRatios	 : 	LIST [2:3] OF REAL; 此处可能是两个方向的即XY,也可能是XYZ方向，主要取决于（）中元素的个数 ， by whueht@gmail.com
% END_ENTITY;

   
	ifclocalmentcontainer = [] ;
	ifcaxis2placement3dcontainer = [] ;
	ifccartestanpointcontainer = [] ;
	ifcdirectionZcontainer = [] ;
	ifcdirectionXcontainer = [] ;

	templocalvar = ifcobjectplacement ;
	tempaxisvar = [] ;

	index = 1 ;
 
	while 1
		if isempty(templocalvar) == 0 && strcmp(templocalvar , '$') == 0 
			templinecontent = findindexcontent(filename,templocalvar) ; %取出IfcObjectPlacement当前行内容        
			[funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ;    

			if strcmp(funname , 'IFCLOCALPLACEMENT') == 1  && length(temparamcontainer) == 2
				templocalvar = temparamcontainer{1,1} ;
				tempaxisvar = temparamcontainer{1,2} ;

				ifclocalmentcontainer{index} = templocalvar ;
				ifcaxis2placement3dcontainer{index} = tempaxisvar ;

				if strcmp(tempaxisvar,'$') == 0  %不是$
					templinecontent = findindexcontent(filename,tempaxisvar) ; %取出IfcObjectPlacement当前行内容        
					[funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ;

					if strcmp(funname , 'IFCAXIS2PLACEMENT3D') == 1  && length(temparamcontainer) == 3
						ifccartestanpointcontainer{index} = temparamcontainer{1,1} ;
						ifcdirectionZcontainer{index} = temparamcontainer{1,2} ;
						ifcdirectionXcontainer{index} = temparamcontainer{1,3} ;
					end

				else
					ifccartestanpointcontainer{index} = '$' ;
					ifcdirectionZcontainer{index} = '$' ;
					ifcdirectionXcontainer{index} = '$';
				end

			else
				fprintf('%s %d fatmat is wrong,in ifcbeam',filename ,entityid);
				break ;
			end 

		else
			break ;			
		end       

		index = index + 1 ;   
	end
   
   
% ifclocalmentcontainer
% ifcaxis2placement3dcontainer
% ifccartestanpointcontainer
% ifcdirectionZcontainer
% ifcdirectionXcontainer


% ifclocalmentcontainer =         '#59'    '#38'    '#274'    '$'
% ifcaxis2placement3dcontainer =  '#68'    '#58'    '#37'     '#273'
% ifccartestanpointcontainer =    '#66'    '#3'     '#3'      '#3'
% ifcdirectionZcontainer =         '$'     '$'      '$'       '$'
% ifcdirectionXcontainer =         '$'     '$'      '$'       '$'

	rpositionx = 0;
	rpositiony = 0;
	rpositionz = 0;
	rposition = [rpositionx rpositiony rpositionz];
	rdirectionx = [1 0 0];
	rdirectiony = [0 1 0];
	rdirectionz = [0 0 1];
	rdirection = [rdirectionx;rdirectiony;rdirectionz];

	for i = length(ifclocalmentcontainer) : -1 : 1
		tdirection = [];
		tposition = [] ;
       
		if strcmp(ifccartestanpointcontainer{i} , '$') == 0
			[funcname type value]=getpointanddirectvalue(filename,ifccartestanpointcontainer{i}) ;

			if strcmp(type,'IFCCARTESIANPOINT') == 0
				sprintf('error....\n'); 
				return ;
			end
            
			tpositionx = str2num(value{1}) ;
			tpositiony = str2num(value{2}) ;
			tpositionz = str2num(value{3}) ;
		else
			tpositionx = 0 ;
			tpositiony = 0 ;
			tpositionz = 0 ;
		end
        
		if strcmp(ifcdirectionZcontainer{i} , '$') == 0
			[funcname type value]=getpointanddirectvalue(filename,ifcdirectionZcontainer{i}) ;
			tmpx = str2num(value{1}) ;
			tmpy = str2num(value{2}) ;
			if length(value) == 3
				tmpz = str2num(value{3}) ;
			else
				tmpz = 0 ;
			end
			tdirectionz = [tmpx tmpy tmpz] ;
		else
			tdirectionz = [0 0 1];
		end
        
		if strcmp(ifcdirectionXcontainer{i} , '$') == 0
			[funcname type value]=getpointanddirectvalue(filename,ifcdirectionXcontainer{i}) ;
			tmpx = str2num(value{1}) ;
			tmpy = str2num(value{2}) ;
			if length(value) == 3
				tmpz = str2num(value{3}) ;
			else
				tmpz = 0 ;
			end
			tdirectionx = [tmpx tmpy tmpz] ;
		else
			tdirectionx = [1 0 0];
		end
        
		tdirectiony = cross(tdirectionz,tdirectionx) ;
		tdirection = [tdirectionx;tdirectiony;tdirectionz] ;
		tposition = [tpositionx tpositiony tpositionz] ;
        
		if i == 1
			trelativeposition = tposition ;
			trelativedirectionz = tdirectionz ;
			trelativedirectionx = tdirectionx ;
		elseif i == length(ifclocalmentcontainer)
			tglobalposition = tposition ;
			tglobaldirectionz = tdirectionz ;
			tglobaldirectionx = tdirectionx ;
		end
        
		if i == length(ifclocalmentcontainer)
			transmatrix = calctransmatrix( rdirection,rposition,tdirection,tposition ) ;
		else
			temp = calctransmatrix( rdirection,rposition,tdirection,tposition ) ;
			transmatrix = temp*transmatrix;  %此处相乘的顺序不能够反
			if i ~= 1
				gcstransmatrix = transmatrix ;
			end 
		end      
%         rdirection = tdirection ;
%         rposition = tposition
%         ;%这两行不能加上，因为相对坐标系在当前坐标系中，都是相对全局坐标系而言，对前面坐标系的继承体现在transmatrix = transmatrix * temp 中
	end
	
   
	ifcbeamxmlcontent = directionvalue2str(gcstransmatrix(1,1:3)) ;
	ifcbeamGCSvalueXContentdnode = docNode.createTextNode(ifcbeamxmlcontent);
	ifcbeamGCSvalueXdnode.appendChild(ifcbeamGCSvalueXContentdnode);
	ifcbeamxmlcontent = directionvalue2str(gcstransmatrix(2,1:3)) ;
	ifcbeamGCSvalueYContentdnode = docNode.createTextNode(ifcbeamxmlcontent);
	ifcbeamGCSvalueYdnode.appendChild(ifcbeamGCSvalueYContentdnode);
	ifcbeamxmlcontent = directionvalue2str(gcstransmatrix(3,1:3)) ;
	ifcbeamGCSvalueZContentdnode = docNode.createTextNode(ifcbeamxmlcontent);
	ifcbeamGCSvalueZdnode.appendChild(ifcbeamGCSvalueZContentdnode);
	ifcbeamxmlcontent = directionvalue2str(gcstransmatrix(4,1:3)) ;
	ifcbeamGCSvalueOPContentdnode = docNode.createTextNode(ifcbeamxmlcontent);
	ifcbeamGCSvalueOPnode.appendChild(ifcbeamGCSvalueOPContentdnode);
% ifclocalmentcontainer =         '#59'    '#38'    '#274'    '$'
% ifcaxis2placement3dcontainer =  '#68'    '#58'    '#37'     '#273'
% ifccartestanpointcontainer =    '#66'    '#3'     '#3'      '#3'
% ifcdirectionZcontainer =         '$'     '$'      '$'       '$'
% ifcdirectionXcontainer =         '$'     '$'      '$'       '$'
   
	ifcbeamGCSaxis2placement3dOPnode.setAttribute('refid',ifccartestanpointcontainer{length(ifccartestanpointcontainer)});
	ifcbeamRCSaxis2placement3dOPnode.setAttribute('refid',ifccartestanpointcontainer{1});

	ifcbeamGCSaxis2placement3dnode.setAttribute('refid',ifcaxis2placement3dcontainer{length(ifcaxis2placement3dcontainer)}); %显示全局坐标系id
	ifcbeamRCSaxis2placement3dnode.setAttribute('refid',ifcaxis2placement3dcontainer{1}); %显示相对坐标系id

	ifcbeamxmlcontent = directionvalue2str(tglobaldirectionz) ;
	ifcbeamGCSaxis2placement3dZDcontentnode = docNode.createTextNode(ifcbeamxmlcontent);
	ifcbeamGCSaxis2placement3dZDnode.appendChild(ifcbeamGCSaxis2placement3dZDcontentnode);
	if strcmp(ifcdirectionZcontainer{length(ifcdirectionZcontainer)} , '$') == 1
		ifcbeamGCSaxis2placement3dZDnode.setAttribute('refid','$');
	else
		ifcbeamGCSaxis2placement3dZDnode.setAttribute('refid',ifcdirectionZcontainer{length(ifcdirectionZcontainer)}); 
	end
    
	ifcbeamxmlcontent = directionvalue2str(tglobaldirectionx) ;
	ifcbeamGCSaxis2placement3dXDcontentnode = docNode.createTextNode(ifcbeamxmlcontent);
	ifcbeamGCSaxis2placement3dXDnode.appendChild(ifcbeamGCSaxis2placement3dXDcontentnode);
	if strcmp(ifcdirectionXcontainer{length(ifcdirectionZcontainer)} , '$') == 1
		ifcbeamGCSaxis2placement3dXDnode.setAttribute('refid','$'); 
	else
		ifcbeamGCSaxis2placement3dXDnode.setAttribute('refid',ifcdirectionZcontainer{length(ifcdirectionXcontainer)}); 
	end
    
	ifcbeamxmlcontent = directionvalue2str(tglobalposition) ;
	ifcbeamGCSaxis2placement3dOPcontentnode = docNode.createTextNode(ifcbeamxmlcontent);
	ifcbeamGCSaxis2placement3dOPnode.appendChild(ifcbeamGCSaxis2placement3dOPcontentnode);

	ifcbeamxmlcontent = directionvalue2str(trelativedirectionz) ;
	ifcbeamRCSaxis2placement3dZDcontentnode = docNode.createTextNode(ifcbeamxmlcontent);
	ifcbeamRCSaxis2placement3dZDnode.appendChild(ifcbeamRCSaxis2placement3dZDcontentnode);
	if strcmp(ifcdirectionZcontainer{1} , '$') == 1
		ifcbeamRCSaxis2placement3dZDnode.setAttribute('refid','$'); 
	else
		ifcbeamRCSaxis2placement3dZDnode.setAttribute('refid',ifcdirectionZcontainer{1}); 
	end
        
	ifcbeamxmlcontent = directionvalue2str(trelativedirectionx) ;
	ifcbeamRCSaxis2placement3dXDcontentnode = docNode.createTextNode(ifcbeamxmlcontent);
	ifcbeamRCSaxis2placement3dXDnode.appendChild(ifcbeamRCSaxis2placement3dXDcontentnode);
	if strcmp(ifcdirectionXcontainer{1} , '$') == 1
		ifcbeamRCSaxis2placement3dXDnode.setAttribute('refid','$'); %显示相对坐标系id
	else
		ifcbeamRCSaxis2placement3dXDnode.setAttribute('refid',ifcdirectionXcontainer{1}); %显示相对坐标系id
	end
    
	ifcbeamxmlcontent = directionvalue2str(trelativeposition) ;
	ifcbeamRCSaxis2placement3dOPcontentnode = docNode.createTextNode(ifcbeamxmlcontent);
	ifcbeamRCSaxis2placement3dOPnode.appendChild(ifcbeamRCSaxis2placement3dOPcontentnode);
    

%  return ;
%     
%    rpositionx
%    rpositiony
%    rpositionz
%    rdirectionx
%    rdirectiony
%    rdirectionz

% IFCPRODUCTDEFINITIONSHAPE IFC STRUCT
% ENTITY IfcProductDefinitionShape;
% Name	 : 	OPTIONAL IfcLabel;
% Description	 : 	OPTIONAL IfcText;
% Representations	 : 	LIST [1:?] OF IfcRepresentation;
% END_ENTITY;

% IFCSHAPEREPRESENTATION IFC STRUCT
% ENTITY IfcShapeRepresentation;
% ENTITY IfcRepresentation;
% ContextOfItems	 : 	IfcRepresentationContext;
% RepresentationIdentifier	 : 	OPTIONAL IfcLabel;
% RepresentationType	 : 	OPTIONAL IfcLabel;
% Items	 : 	SET [1:?] OF IfcRepresentationItem;
% END_ENTITY;

% IFCPOLYLINE IFC STRUCT
% ENTITY IfcPolyline;
% Points	 : 	LIST [2:?] OF IfcCartesianPoint;
% END_ENTITY;

	templinecontent = findindexcontent(filename,ifcproductrepresentation) ; %取出IfcObjectPlacement当前行内容   
	[funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ;
	[ifcproductdefinitionshape ifcproductdefinitionshapenum]=getparatype4element(temparamcontainer{1,3}) ;

	facefront = [] ;
	facebehind = [];
	axisfront = [];
	axisbehind = [];
	beamdirection = [] ;

	for i = 1:ifcproductdefinitionshapenum
		templinecontent = findindexcontent(filename,ifcproductdefinitionshape{i}) ;
		[funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ; 

		if strcmp(temparamcontainer{1,2},'''Body''') == 1
			if strcmp(temparamcontainer{1,3},'''MappedRepresentation''') == 1 % temparamcontainer  == > IFCSHAPEREPRESENTATION
				[ifcextrudedareasolid ifcextrudedareasolidnum] = getparatype4element(temparamcontainer{1,4}) ;% ifcextrudedareasolid ==??  > IFCMAPPEDITEM
				for j = 1:ifcextrudedareasolidnum
					templinecontent = findindexcontent(filename,ifcextrudedareasolid{j}) ;%templinecontent == > IFCMAPPEDITEM
					[funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ;
					if strcmp(funname , 'IFCMAPPEDITEM') == 1 
						templinecontent = findindexcontent(filename,temparamcontainer{1,1}) ;
						[funname t0_temparamcontainer entityid]=resolvlinecontent(templinecontent) ; 
						templinecontent = findindexcontent(filename,t0_temparamcontainer{1,2}) ;
						[funname t1_temparamcontainer entityid]=resolvlinecontent(templinecontent) ; 

						if strcmp(funname,'IFCSHAPEREPRESENTATION') == 1
							if strcmp(t1_temparamcontainer{1,3},'''SweptSolid''') == 1
								templinecontent = t1_temparamcontainer{1,4} ;
								templinecontent = findindexcontent(filename,templinecontent(2:(length(templinecontent)-1))) ;
								[funname t2_temparamcontainer entityid]=resolvlinecontent(templinecontent) ;  
								[m,n] = size(t2_temparamcontainer) ;
								if n == 1
									return ; 
								end
                  
								zlength = str2num(t2_temparamcontainer{1,4});  %p4

								[funcname type value] = getpointanddirectvalue(filename,t2_temparamcontainer{1,3}) ;%p3
								zposition = str2num(value{3}) ;
								if zposition == -1
									zlength = -zlength ;
								end
								ifcproductiondefinitionshapdirectionz = value ;

								templinecontent = findindexcontent(filename,t2_temparamcontainer{1,1}) ;
								[funname tempparamcontainer1 entityid]=resolvlinecontent(templinecontent) ;

								xlength = str2num(tempparamcontainer1{1,4}) ;
								ylength = str2num(tempparamcontainer1{1,5}) ;

								templinecontent = findindexcontent(filename,tempparamcontainer1{1,3}) ;
								[funname tempparamcontainer1 entityid]=resolvlinecontent(templinecontent) ;              
								[funcname type value] = getpointanddirectvalue(filename,tempparamcontainer1{1,1}) ;
								xposition = str2num(value{1}) ;
								yposition = str2num(value{2}) ;        
								txposition = xposition ;
								typosition = yposition ;             
								[funcname type value]=getpointanddirectvalue(filename,tempparamcontainer1{1,2}) ; 
								xdirection = str2num(value{1}) ;
								ydirection = str2num(value{2}) ;
								ifcproductiondefinitionshapdirectionx = value ;
								if ydirection == 1 || ydirection == -1
									position1 = [xposition+ylength/2 yposition+xlength/2 0];
									position2 = [xposition+ylength/2 yposition-xlength/2 0];
									position3 = [xposition-ylength/2 yposition-xlength/2 0];
									position4 = [xposition-ylength/2 yposition+xlength/2 0];
									face1 = [position1;position2;position3;position4] ;
									axis1 = [xposition yposition 0];      
              
									position5 = [xposition+ylength/2 yposition+xlength/2 zlength];
									position6 = [xposition+ylength/2 yposition-xlength/2 zlength];
									position7 = [xposition-ylength/2 yposition-xlength/2 zlength];
									position8 = [xposition-ylength/2 yposition+xlength/2 zlength];
									face2 = [position5;position6;position7;position8] ;
									axis2 = [xposition yposition zlength];
                 
								elseif xdirection == 1 || xdirection == -1   
									position1 = [xposition+xlength/2 yposition+ylength/2 0];
									position2 = [xposition+xlength/2 yposition-ylength/2 0];
									position3 = [xposition-xlength/2 yposition-ylength/2 0];
									position4 = [xposition-xlength/2 yposition+ylength/2 0];
									face1 = [position1;position2;position3;position4] ;
									axis1 = [xposition yposition 0];      

									position5 = [xposition+xlength/2 yposition+ylength/2 zlength];
									position6 = [xposition+xlength/2 yposition-ylength/2 zlength];
									position7 = [xposition-xlength/2 yposition-ylength/2 zlength];
									position8 = [xposition-xlength/2 yposition+ylength/2 zlength];
									face2 = [position5;position6;position7;position8] ;
									axis2 = [xposition yposition zlength];
								end
                 
								templinecontent = findindexcontent(filename,t2_temparamcontainer{1,2}) ;%P2
								[funname tempparamcontainer1 entityid]=resolvlinecontent(templinecontent) ;

								[funcname type value]=getpointanddirectvalue(filename,tempparamcontainer1{1,1}) ;
								tmpx = str2num(value{1}) ;
								tmpy = str2num(value{2}) ;
								tmpz = str2num(value{3}) ;
								temptargetposiotion=[tmpx tmpy tmpz];
               
								if strcmp(tempparamcontainer1{1,2} , '$') ~= 1
									[funcname type value]=getpointanddirectvalue(filename,tempparamcontainer1{1,2}) ;
									tmpx = str2num(value{1}) ;
									tmpy = str2num(value{2}) ;
									if length(value) == 3
										tmpz = str2num(value{3}) ;
									else
										tmpz = 0 ;
									end
									temptargetdirectionz = [tmpx tmpy tmpz] ;
								else
									temptargetdirectionz = [0 0 1] ;
								end
               
								if strcmp(tempparamcontainer1{1,3} , '$') ~= 1
									[funcname type value]=getpointanddirectvalue(filename,tempparamcontainer1{1,3}) ;
									tmpx = str2num(value{1}) ;
									tmpy = str2num(value{2}) ;
									if length(value) == 3
										tmpz = str2num(value{3}) ;
									else
										tmpz = 0 ;
									end
									temptargetdirectionx = [tmpx tmpy tmpz] ;
								else
									temptargetdirectionx = [1 0 0] ;
								end
               
								temptargetdirectiony = cross(temptargetdirectionz,temptargetdirectionx);

								temptargetdirect = [temptargetdirectionx;temptargetdirectiony;temptargetdirectionz] ;

								temprelaticedirection = [1 0 0 ; 0 1 0 ; 0 0 1];
								temprelativeposition = [ 0 0 0] ;
								temptransmatrix = calctransmatrix( temprelaticedirection,temprelativeposition,temptargetdirect,temptargetposiotion ) ;

								temptransmatrix = temptransmatrix*transmatrix;  
								addcol = [1;1;1;1];
								tface1 = [face1 addcol];
								tface2 = [face2 addcol];
               
								tface1 = tface1*temptransmatrix ;
								face1 = tface1(:,1:3);
								tface2 = tface2*temptransmatrix ;
								face2 = tface2(:,1:3);

								ifccolumnP1 = face1(1,:) ;
								ifccolumnP2 = face1(2,:) ;
								ifccolumnP3 = face1(3,:) ;
								ifccolumnP4 = face1(4,:) ;

								ifccolumnP5 = face2(1,:) ;
								ifccolumnP6 = face2(2,:) ;
								ifccolumnP7 = face2(3,:) ;
								ifccolumnP8 = face2(4,:) ;
                                
                                ifccolumnP1=round((ifccolumnP1)*100)/100;
                                ifccolumnP2=round((ifccolumnP2)*100)/100;
                                ifccolumnP3=round((ifccolumnP3)*100)/100;
                                ifccolumnP4=round((ifccolumnP4)*100)/100;
                                ifccolumnP5=round((ifccolumnP5)*100)/100;
                                ifccolumnP6=round((ifccolumnP6)*100)/100;
                                ifccolumnP7=round((ifccolumnP7)*100)/100;
                                ifccolumnP8=round((ifccolumnP8)*100)/100;

								ifcbeamFace1 = [ifccolumnP1;ifccolumnP2;ifccolumnP3;ifccolumnP4] ;         
								ifcbeamFace2 = [ifccolumnP5;ifccolumnP6;ifccolumnP7;ifccolumnP8] ;            
								ifcbeamFace3 = [ifccolumnP1;ifccolumnP2;ifccolumnP6;ifccolumnP5] ;             
								ifcbeamFace4 = [ifccolumnP4;ifccolumnP3;ifccolumnP7;ifccolumnP8] ;                              
								ifcbeamFace5 = [ifccolumnP1;ifccolumnP4;ifccolumnP8;ifccolumnP5] ;          
								ifcbeamFace6 = [ifccolumnP2;ifccolumnP3;ifccolumnP7;ifccolumnP6] ;

								face_point_containter = [] ; %用于确定点的id号
								face_line_containter = [] ;    %用于确定线的id号
								%用户自定义形状
								ifcbeamUDMnode = docNode.createElement('closeshellentity');
								ifcbeamUDMnode.setAttribute('type','r'); %表明此处为只读变量
								ifcbeamUDMnode.setAttribute('cseNO',num2str(j)); %表明此处为只读变量
								ifcbeamPDSnode.appendChild(ifcbeamUDMnode);

								faceindex = 'face' ;
								lineindex = 'line' ;
								for udmfaceindex = 1:6
									%              faceindex = ['face' num2str(udmfaceindex)] ; 
									ifcbeamUDMfacenode = docNode.createElement(faceindex) ;
									globalFaceNo = globalFaceNo + 1 ;
									ifcbeamUDMfacenode.setAttribute('faceNO',num2str(globalFaceNo)) ;
									ifcbeamUDMnode.appendChild(ifcbeamUDMfacenode) ;

									str=(['ifcbeamFace = ifcbeamFace',num2str(udmfaceindex) ';']);
									eval(str);
									ifcbeamPoint1 = ifcbeamFace(1,:);
									ifcbeamPoint2 = ifcbeamFace(2,:);
									ifcbeamPoint3 = ifcbeamFace(3,:);
									ifcbeamPoint4 = ifcbeamFace(4,:);
                                    
                                    txttempcontent = ['Face #' num2str(globalFaceNo)];
                                    fwrite(txtfid,txttempcontent);  
                                    fprintf(txtfid,'\n');
                                  
                                    txttempcontent=[ifcbeamPoint1;ifcbeamPoint2;ifcbeamPoint3;ifcbeamPoint4];
                                 txttempcontentx = txttempcontent(:,1);
                                 txttempcontenty = txttempcontent(:,2);
                                 txttempcontentz = txttempcontent(:,3);
                                 txttempcontentx=txttempcontentx';
                                 txttempcontenty=txttempcontenty';
                                 txttempcontentz=txttempcontentz';
                                 txttempcontent=[objectEntityID ' COLUMN'];
%                                  txttempcontent='Normal vector direction';
%                                  fprintf(txtfid,'%s\n',txttempcontent);
%                                  txttempcontent='0 0 0';
                                 fprintf(txtfid,'%s\n',txttempcontent);
                                 txttempcontent='X coordinates';
                                 fprintf(txtfid,'%s\n',txttempcontent);
                                 fprintf(txtfid,'%s\n',num2str(txttempcontentx));
                                 txttempcontent='Y coordinates' ;
                                 fprintf(txtfid,'%s\n',txttempcontent);
                                 fprintf(txtfid,'%s\n',num2str(txttempcontenty));
                                 txttempcontent='Z coordinates';
                                 fprintf(txtfid,'%s\n',txttempcontent);
                                 fprintf(txtfid,'%s\n',num2str(txttempcontentz));
                                 fprintf(txtfid,'\n');
                                    

									ifcbeamline1 = [ifcbeamPoint1;ifcbeamPoint2] ;
									ifcbeamline2 = [ifcbeamPoint2;ifcbeamPoint3] ;
									ifcbeamline3 = [ifcbeamPoint3;ifcbeamPoint4] ;
									ifcbeamline4 = [ifcbeamPoint4;ifcbeamPoint1] ;
             
             
									for udmlineindex = 1:4
									%                lineindex = ['line' num2str(udmlineindex)] ;
									ifcbeamUDMfacelinenode = docNode.createElement(lineindex) ;
									ifcbeamUDMfacenode.appendChild(ifcbeamUDMfacelinenode); 

									str=(['ifcbeamline = ifcbeamline',num2str(udmlineindex) ';']);
									eval(str);

									ifcbeamlinepoint1 = ifcbeamline(1,:) ;
									ifcbeamlinepoint2 = ifcbeamline(2,:) ;

									lineno = 0 ;
									point1no = 0 ;
									point2no = 0 ;

									[face_line_containter,face_point_containter,lineno,point1no ,point2no] = ...
                                    calclindandpointno(face_line_containter,face_point_containter,ifcbeamlinepoint1,ifcbeamlinepoint2,globalPointNo,globalLineNo);
                 
									ifcbeamUDMfacelinenode.setAttribute('lineNO',num2str(lineno)) ;

									ifcbeamUDMfacelinepoint1node = docNode.createElement('point') ;
									ifcbeamUDMfacelinepoint1node.setAttribute('pointNO',num2str(point1no)) ;
									ifcbeamUDMfacelinenode.appendChild(ifcbeamUDMfacelinepoint1node); 
									ifcbeamxmlcontent = directionvalue2str(ifcbeamlinepoint1) ;
									ifcbeamUDMfacelinepoint1contentnode = docNode.createTextNode(ifcbeamxmlcontent);
									ifcbeamUDMfacelinepoint1node.appendChild(ifcbeamUDMfacelinepoint1contentnode);

									ifcbeamUDMfacelinepoint2node = docNode.createElement('point') ;
									ifcbeamUDMfacelinepoint2node.setAttribute('pointNO',num2str(point2no)) ;
									ifcbeamUDMfacelinenode.appendChild(ifcbeamUDMfacelinepoint2node); 
									ifcbeamxmlcontent = directionvalue2str(ifcbeamlinepoint2) ;
									ifcbeamUDMfacelinepoint2contentnode = docNode.createTextNode(ifcbeamxmlcontent);
									ifcbeamUDMfacelinepoint2node.appendChild(ifcbeamUDMfacelinepoint2contentnode);
								end

							end
               
						elseif   strcmp(t1_temparamcontainer{1,3},'''Brep''') == 1
                    
							[ifcfacetedbrep ifcfacetedbrepnum]=getparatype4element(t1_temparamcontainer{1,4}) ;

							face_point_containter = [] ; %用于确定点的id号
							face_line_containter = [] ;    %用于确定线的id号
							for j = 1 : ifcfacetedbrepnum %表明封闭的实体个数 ，j是封闭实体的个数

							ifcbeamxmlcontent = 'closeshellentity' ;
							ifcbeamshellnode = docNode.createElement(ifcbeamxmlcontent);
							ifcbeamshellnode.setAttribute('cseNO',num2str(j)); %表明此处为只读变量
							ifcbeamPDSnode.appendChild(ifcbeamshellnode);

							templinecontent = findindexcontent(filename,ifcfacetedbrep{j}) ;
							[funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ;
							templinecontent = findindexcontent(filename,temparamcontainer{1,1}) ;
							[funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ;

							[ifcclosedshell ifcclosedshellnum]=getparatype4element(temparamcontainer{1,1}) ;
                
							totalPoint = [] ;
							for k = 1 : ifcclosedshellnum %每个封闭实体一共有多少个面 , k是面的个数
								%                     face_point_containter = [] ; %用于确定点的id号
								%                     face_line_containter = [] ;    %用于确定线的id号
								%                     ifcbeamxmlcontent = ['face' num2str(k)] ;
								ifcbeamxmlcontent = 'face' ;
								ifcbeamshellfacenode = docNode.createElement(ifcbeamxmlcontent);
								globalFaceNo = globalFaceNo + 1 ;
								ifcbeamshellfacenode.setAttribute('faceNO',num2str(globalFaceNo)); %表明此处为只读变量
								ifcbeamshellnode.appendChild(ifcbeamshellfacenode);
                                
                                txttempcontent = ['Face #' num2str(globalFaceNo)];
                                fwrite(txtfid,txttempcontent);  
                                fprintf(txtfid,'\n');

								templinecontent = findindexcontent(filename,ifcclosedshell{k}) ;
								[funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ;
								[ifcface ifcfacenum]=getparatype4element(temparamcontainer{1,1}) ;

								templinecontent = findindexcontent(filename,ifcface{1}) ;
								[funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ;

								templinecontent = findindexcontent(filename,temparamcontainer{1,1}) ;
								[funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ;

								[ifcpolyloop ifcpolyloopnum]=getparatype4element(temparamcontainer{1,1}) ;
								%                    ifcpolyloopnum
								facepoint = [];
								%                    eval(['object',num2str(j),'facepoint',num2str(k) '= []', ';']);

								for m = 1 :ifcpolyloopnum %每一个面有多少个点
									[funcname type value]=getpointanddirectvalue(filename,ifcpolyloop{m}) ;
									tmpx = str2num(value{1}) ;
									tmpy = str2num(value{2}) ;
									tmpz = str2num(value{3}) ;
									P = [tmpx tmpy tmpz 1] ;
									tP = P*transmatrix;
									P = tP(1:3);
									P=round(P*100)/100;			                   
									if m == 1;
										facepoint = P;
									%                           eval(['object',num2str(j),'facepoint',num2str(k) '= P', ';']);
									else
                          
										[mfacepoint nfacepoint] = size(facepoint);

										ifcbeamlinepoint1 = facepoint(mfacepoint,:) ;
										ifcbeamlinepoint2 = P ;

										[face_line_containter,face_point_containter,lineno,point1no ,point2no] = ...
											calclindandpointno(face_line_containter,face_point_containter,ifcbeamlinepoint1,ifcbeamlinepoint2,globalPointNo,globalLineNo);

										%                            ifcbeamxmlcontent = ['line' num2str(m-1)] ;
										ifcbeamxmlcontent = 'line' ;
										ifcbeamshellfacelinenode = docNode.createElement(ifcbeamxmlcontent);
										ifcbeamshellfacelinenode.setAttribute('lineNO',num2str(lineno)) ;
										ifcbeamshellfacenode.appendChild(ifcbeamshellfacelinenode);

										%                            ifcbeamxmlcontent = ['point1'] ;
										ifcbeamxmlcontent = 'point' ;
										ifcbeamshellfacelinepointnode = docNode.createElement(ifcbeamxmlcontent);
										ifcbeamshellfacelinepointnode.setAttribute('pointNO',num2str(point1no)) ;
										ifcbeamxmlcontent = directionvalue2str(facepoint(mfacepoint,:));
										ifcbeamshellfacelinepointcontentnode = docNode.createTextNode(ifcbeamxmlcontent);
										ifcbeamshellfacelinepointnode.appendChild(ifcbeamshellfacelinepointcontentnode);
										ifcbeamshellfacelinenode.appendChild(ifcbeamshellfacelinepointnode);
                             
										%                            ifcbeamxmlcontent = ['point2'] ;
										ifcbeamxmlcontent = 'point' ;
										ifcbeamshellfacelinepointnode = docNode.createElement(ifcbeamxmlcontent);
										ifcbeamshellfacelinepointnode.setAttribute('pointNO',num2str(point2no)) ;
										ifcbeamxmlcontent = directionvalue2str(P);
										ifcbeamshellfacelinepointcontentnode = docNode.createTextNode(ifcbeamxmlcontent);
										ifcbeamshellfacelinepointnode.appendChild(ifcbeamshellfacelinepointcontentnode);
										ifcbeamshellfacelinenode.appendChild(ifcbeamshellfacelinepointnode);
                          
										if m == ifcpolyloopnum
											ifcbeamlinepoint1 = P ;
											ifcbeamlinepoint2 = facepoint(1,:) ;

											[face_line_containter,face_point_containter,lineno,point1no ,point2no] = ...
											calclindandpointno(face_line_containter,face_point_containter,ifcbeamlinepoint1,ifcbeamlinepoint2,globalPointNo,globalLineNo);
											%                             ifcbeamxmlcontent = ['line' num2str(m)] ;
											ifcbeamxmlcontent = 'line';
											ifcbeamshellfacelinenode = docNode.createElement(ifcbeamxmlcontent);
											ifcbeamshellfacelinenode.setAttribute('lineNO',num2str(lineno)) ;
											ifcbeamshellfacenode.appendChild(ifcbeamshellfacelinenode);
                          
											%                             ifcbeamxmlcontent = ['point1'] ;
											ifcbeamxmlcontent = 'point' ;
											ifcbeamshellfacelinepointnode = docNode.createElement(ifcbeamxmlcontent);
											ifcbeamshellfacelinepointnode.setAttribute('pointNO',num2str(point1no)) ;
											ifcbeamxmlcontent = directionvalue2str(P);
											ifcbeamshellfacelinepointcontentnode = docNode.createTextNode(ifcbeamxmlcontent);
											ifcbeamshellfacelinepointnode.appendChild(ifcbeamshellfacelinepointcontentnode);
											ifcbeamshellfacelinenode.appendChild(ifcbeamshellfacelinepointnode);

											%                             ifcbeamxmlcontent = ['point2'] ;
											ifcbeamxmlcontent = 'point' ;
											ifcbeamshellfacelinepointnode = docNode.createElement(ifcbeamxmlcontent);
											ifcbeamshellfacelinepointnode.setAttribute('pointNO',num2str(point2no)) ;
											ifcbeamxmlcontent = directionvalue2str(facepoint(1,:));
											ifcbeamshellfacelinepointcontentnode = docNode.createTextNode(ifcbeamxmlcontent);
											ifcbeamshellfacelinepointnode.appendChild(ifcbeamshellfacelinepointcontentnode);
											ifcbeamshellfacelinenode.appendChild(ifcbeamshellfacelinepointnode);
											end

											facepoint = [facepoint;P];
										%                           eval(['object',num2str(j),'facepoint',num2str(k) '= [object',num2str(j),'facepoint',num2str(k) ';P]', ';']);
										end
                      
									end
                   
%                     facepoint
                     txttempcontent=facepoint;
                     txttempcontentx = txttempcontent(:,1);
                     txttempcontenty = txttempcontent(:,2);
                     txttempcontentz = txttempcontent(:,3);
                     txttempcontentx=txttempcontentx';
                     txttempcontenty=txttempcontenty';
                     txttempcontentz=txttempcontentz';
                     txttempcontent='Normal vector direction';
                     fprintf(txtfid,'%s\n',txttempcontent);
                     txttempcontent='0 0 0';
                     fprintf(txtfid,'%s\n',txttempcontent);
                     txttempcontent='X coordinates';
                     fprintf(txtfid,'%s\n',txttempcontent);
                     fprintf(txtfid,'%s\n',num2str(txttempcontentx));
                     txttempcontent='Y coordinates' ;
                     fprintf(txtfid,'%s\n',txttempcontent);
                     fprintf(txtfid,'%s\n',num2str(txttempcontenty));
                     txttempcontent='Z coordinates';
                     fprintf(txtfid,'%s\n',txttempcontent);
                     fprintf(txtfid,'%s\n',num2str(txttempcontentz));
                     fprintf(txtfid,'\n');
								end
							end
						end
					end
				end
			end
          
				[m_face_line_containter,n_face_line_containter] =size(face_line_containter) ;
				globalLineNo = globalLineNo + m_face_line_containter ;
				globalPointNo = globalPointNo + length(face_point_containter) ;
          
			end
        
		elseif strcmp(temparamcontainer{1,2},'''Axis''') == 1
         ;
		end
	
	end
  
	return;
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
