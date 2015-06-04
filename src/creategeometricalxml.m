% /***********************************************************************************
%  * 文 件 名   : createxml.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年08月25日
%  * 文件描述   : 创建一个xml文件，存放于filename文件中
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/08/25	创建该文件
% ***********************************************************************************/
function creategeometricalxml(filename)
% 创建一个xml文件
% docNode = com.mathworks.xml.XMLUtils.createDocument('geometricalXML');
docNode = com.mathworks.xml.XMLUtils.createDocument('structure');
docNode.appendChild(docNode.createComment('end'));
xmlwrite(filename,docNode);
% type(filename);
