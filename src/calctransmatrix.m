% /***********************************************************************************
%  * 文 件 名   : calctransmatrix.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年09月19日
%  * 文件描述   :  计算坐标平移的矩阵，
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/09/19	创建该文件 , 
%  * 修改记录   
%    在本地坐标系的任意一点的坐标通过乘以transmatrix，就可以得到该坐标点在global坐标系中的坐标点
% *************************************************************************************
function [ transmatrix ] = calctransmatrix( relativedirection,relativeposition,targetdirection,targetposition )
% 本函数是求以原始坐标系relativedirection作为相对坐标系，通过平移与旋转，得到目标坐标系targetdirection
% relativedirection与targetdirection为3×3的矩阵
% relativeposition与targetposition为为1×3的矩阵

% 判断矩阵维数合法性
n = size(relativedirection);
m = size(targetdirection) ;
j = size(relativeposition);
k = size(targetposition);

if n(1) ~= 3 || n(2) ~= 3 || m(1) ~= 3 || m(2) ~= 3 ||  j(1) ~= 1 || j(2) ~= 3 || k(1) ~= 1 || k(2) ~= 3
   fprintf('error,the relativedirection format is wrong!.\n');
    return; 
end

tempmatrix=[1;1;1];
relativedirection = [relativedirection tempmatrix];
targetdirection = [targetdirection tempmatrix];

% relativedirection =
%        x y z 1

% T = [ 
%       x1 y1 z1 0;
%       x2 y2 z2 0;
%       x3 y3 z3 0;
%       0  0  0  1
%      ];

% targetdirection =
%       x' y' z' 1

r=relativedirection ;
t=targetdirection ;

syms x1 x2 x3 y1 y2 y3 z1 z2 z3 ;

[x1,x2,x3,y1,y2,y3,z1,z2,z3] = solve('r(1,1)*x1+r(1,2)*x2+r(1,3)*x3=t(1,1)', ...
                                     'r(1,1)*y1+r(1,2)*y2+r(1,3)*y3=t(1,2)', ...
                                     'r(1,1)*z1+r(1,2)*z2+r(1,3)*z3=t(1,3)', ...
                                     'r(2,1)*x1+r(2,2)*x2+r(2,3)*x3=t(2,1)', ...
                                     'r(2,1)*y1+r(2,2)*y2+r(2,3)*y3=t(2,2)', ...
                                     'r(2,1)*z1+r(2,2)*z2+r(2,3)*z3=t(2,3)', ...
                                     'r(3,1)*x1+r(3,2)*x2+r(3,3)*x3=t(3,1)', ...
                                     'r(3,1)*y1+r(3,2)*y2+r(3,3)*y3=t(3,2)', ...
                                     'r(3,1)*z1+r(3,2)*z2+r(3,3)*z3=t(3,3)', ...
                                     'x1,x2,x3,y1,y2,y3,z1,z2,z3');
x1=eval(x1);
x2=eval(x2);
x3=eval(x3);
y1=eval(y1);
y2=eval(y2);
y3=eval(y3);
z1=eval(z1);
z2=eval(z2);
z3=eval(z3);
transmatrix = [x1 y1 z1;x2 y2 z2;x3 y3 z3] ;

tempmatrix = [0 0 0];
transmatrix = [transmatrix ; tempmatrix];
tempmatrix = [0;0;0;1];
transmatrix = [transmatrix tempmatrix]; %由此得到旋转矩阵

movematrix = [1 0 0 ; 0 1 0 ;0 0 1];
tempmatrix = targetposition - relativeposition ;
movematrix = [movematrix ; tempmatrix];
tempmatrix = [0;0;0;1];
movematrix = [movematrix  tempmatrix];%由此得到旋转矩阵

transmatrix = transmatrix*movematrix;
% transmatrix = movematrix*transmatrix;

end

