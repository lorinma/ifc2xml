% /***********************************************************************************
%  * 文 件 名   : isdecdigital.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年08月25日
%  * 文件描述   : 判断字符A的类型
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/08/25	创建该文件
%  * 修正bug
%    类似 #31= IFCDIMENSIONALEXPONENTS(0,0,0,0,0,0,0); 的表达式原先无法解析
% ***********************************************************************************/
function param_type=resolvparam(S)
%
%本函数用于解析函数的形参
%
% 1 $ 表示空   #39= IFCAXIS2PLACEMENT3D(#3,$,$);，此处有两个空
% 2 '' 表示字符串 #1= IFCORGANIZATION($,'Autodesk Revit 2013',$,$,$)， 此处的Autodesk Revit 2013表示字符串
% 3 #xx 表示链接   #39= IFCAXIS2PLACEMENT3D(#3,$,$); 此处的#3表示链接
% 4 () 括号表示一个实体  #25= IFCDIRECTION((0.,-1.));(0.,-1.)表示一个实体,% 有（#x,#y），（#x）,(xx.,yyy),(xx.)这样几种情况
% 5  .ENUM. 表示枚举类型 #30= IFCSIUNIT(*,.PLANEANGLEUNIT.,$,.RADIAN.); 此处的.PLANEANGLEUNIT.,.RADIAN.均表示枚举类型
% 6 XXX.XXX  表示普通数据  #101= IFCCURVESTYLEFONTPATTERN(76.2,838.2); 此处的76.2 与838.2表示数字
% 7 FUC() 表示函数 #229=
% IFCPROPERTYSINGLEVALUE('\X2\4FA754115BF96B63\X0\',$,IFCINTEGER(0),$);IFCINTEGER表示函数,函数的形参仅有一个
% 8 *



  param_type = 0 ;

  if length(S) == 1  && (S(1) == '$')
      param_type = 1 ;
  elseif (S(1) == '''') && (S(length(S)) == '''')
      param_type = 2 ;
  elseif (S(1) == '#') && (length(S) >= 2) 
      param_type = 3 ;
  elseif (S(1) == '(') && (S(length(S)) == ')')
      param_type = 4 ;
  elseif (S(1) == '.') && (S(length(S)) == '.')
      param_type = 5 ;
%   elseif (isdecdigital(S(1)) == 1) && (length(strfind(S,'.')) >= 1)
  elseif (isdecdigital(S(1)) == 1) || (S(1) == '-' &&  isdecdigital(S(2)) == 1) %修复类似#31= IFCDIMENSIONALEXPONENTS(0,0,0,0,0,0,0);这样的表达式 ,修复-xx.xx这样的数判定不准确问题
      param_type = 6 ;
  elseif ((isdecdigital(S(1)) == 2) || (isdecdigital(S(1)) == 3))  && (length(strfind(S,'(')) >= 1) && (length(strfind(S,')')) >= 1)
      param_type = 7 ;
  elseif length(S) == 1  && (S(1) == '*')
      param_type = 8 ;
  end
      