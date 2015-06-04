% /***********************************************************************************
%  * 文 件 名   : calclindandpointno.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年08月25日
%  * 文件描述   : 创建一个xml文件，存放于filename文件中
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/08/25	创建该文件
% ***********************************************************************************/
function  [face_line_containter,face_point_containter,lineno , point1no ,point2no ] = calclindandpointno(face_line_containter,face_point_containter,point1,point2,globalPointNo,globalLineNo)
point1no = 0 ;
point2no = 0 ;
pointcontainter = [point1 point2] ;
if isempty(face_line_containter) == 1
    face_line_containter = pointcontainter ;
    lineno = 1 ;
else
    flag = 0 ;
    [m,n] = size(face_line_containter) ;
    for j = 1:m
        tpoint1 = face_line_containter(j,1:3) ; 
        tpoint2 = face_line_containter(j,4:6) ;
        
        if ((ispointequal(tpoint1,point1) == 1) && (ispointequal(tpoint2,point2) == 1)) || ((ispointequal(tpoint1,point2) == 1) && (ispointequal(tpoint2,point1) == 1))
           flag = 1 ;
           lineno = j ;
           break ;
        end        
    end
    
    if flag == 0
       lineno = (m + 1) ;
       face_line_containter = [face_line_containter ; pointcontainter] ;
    end
end

if isempty(face_point_containter) == 1
    face_point_containter = point1 ;
    face_point_containter = [face_point_containter ; point2];
    point1no = 1 ;
    point2no = 2 ;
else
    flag1 = 0 ;
    flag2 = 0 ;
    [m,n] = size(face_point_containter) ;
    for j = 1 : m
       tpoint = face_point_containter(j,:);
       if ispointequal(tpoint , point1) == 1
          point1no = j ;
          flag1 = 1 ;
       break;
       end
    end
    if flag1 == 0
        face_point_containter = [face_point_containter ; point1];
        point1no = (m + 1) ;
    end
    
     [m,n] = size(face_point_containter) ;
     for j = 1 : m
       tpoint = face_point_containter(j,:);
       if ispointequal(tpoint , point2) == 1
          point2no = j ;
          flag2 = 1 ;
       break;
       end
    end
    if flag2 == 0
        face_point_containter = [face_point_containter ; point2];
        point2no = (m + 1) ;
    end   
    
end

point1no = globalPointNo + point1no ;
point2no = globalPointNo + point2no ;

lineno = globalLineNo + lineno ;