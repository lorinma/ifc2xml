% /***********************************************************************************
%  * 文 件 名   : insertelement2xml.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年08月25日
%  * 文件描述   : 为xml文件添加节点
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/08/25	创建该文件
% ***********************************************************************************/
function [docNode matrixflag]=insertelement2xml(tline,gapcharturn,i,docNode,nozeroelem,t_entity,debug_swtich, matrix , matrixflag) 
   xRoot = docNode.getDocumentElement();%获取根节点，
   
   if matrixflag == 1
       content = matrix{1} ;
       content = content(1:(length(content)-1));      
       fNode = docNode.createElement(content);
       fNode.setAttribute('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
       fNode.setAttribute('xmlns:xlink','http://www.w3.org/1999/xlink');
       fNode.setAttribute('xmlns','urn:iso.org:standard:10303:part(28):version(2):xmlschema:common');
       fNode.setAttribute('xsi:schemaLocation','urn:iso.org:standard:10303:part(28):version(2):xmlschema:common http://www.iai-tech.org/ifcXML/IFC2x3/FINAL/ex.xsd');
       fNode.setAttribute('version','2');
       xRoot.appendChild(fNode);
       
       content = ['temp=' matrix{4}];
       [funname paramcontainer entityid]=resolvlinecontent(content);
       
       hNode = docNode.createElement('Header');
       xRoot.appendChild(hNode);
       
       entity_node = docNode.createElement('name');
       entity_node_context = docNode.createTextNode(paramcontainer{1,1});
       entity_node.appendChild(entity_node_context);
       hNode.appendChild(entity_node);
       
       entity_node = docNode.createElement('time_stamp');
       entity_node_context = docNode.createTextNode(paramcontainer{1,2});
       entity_node.appendChild(entity_node_context);
       hNode.appendChild(entity_node);
       
       entity_node = docNode.createElement('author');
       entity_node_context = docNode.createTextNode(paramcontainer{1,3});
       entity_node.appendChild(entity_node_context);
       hNode.appendChild(entity_node);
       
       entity_node = docNode.createElement('organization');
       entity_node_context = docNode.createTextNode(paramcontainer{1,4});
       entity_node.appendChild(entity_node_context);
       hNode.appendChild(entity_node);
       
       entity_node = docNode.createElement('preprocessor_version');
       entity_node_context = docNode.createTextNode(paramcontainer{1,5});
       entity_node.appendChild(entity_node_context);
       hNode.appendChild(entity_node);
       
       entity_node = docNode.createElement('originating_system');
       entity_node_context = docNode.createTextNode(paramcontainer{1,6});
       entity_node.appendChild(entity_node_context);
       hNode.appendChild(entity_node);
       
       entity_node = docNode.createElement('authorization');
       entity_node_context = docNode.createTextNode(paramcontainer{1,7});
       entity_node.appendChild(entity_node_context);
       hNode.appendChild(entity_node);
       
       matrixflag = 0 ;
   end
   

   entity_name = tline(gapcharturn(1) + 2 : gapcharturn(2) - 1);
   id_name = tline(2 : gapcharturn(1) - 1);
   
   if debug_swtich == 1
      fprintf('%s ',id_name) ;
      fprintf('%d:%s ',i,entity_name);
   end
   
   j=1 ;
   flag=0;
   
   while j<=nozeroelem
       if strcmp(lower(entity_name),lower(t_entity{j}{1})) == 1
           flag = 1 ;
           break ;
       end
       j=j+1;
   end
   
    if flag == 0
        if debug_swtich == 0
          fprintf('%s-%s is no found,need add data model.\n',entity_name,id_name) ;
        end
        return ;
    end

   entity_node = docNode.createElement(t_entity{j}{1});
   entity_node.setAttribute('id',id_name);
   xRoot.appendChild(entity_node);
                    
   element_no = 1 ;%第几个元素
   value_index = 2;%第一个是等号索引，第二个是第一个(的索引，所以此处是2
  
   while value_index <= (length(gapcharturn)-1)
        value_name = tline((gapcharturn(value_index)+1):(gapcharturn(value_index+1)-1));%逐个的数值
            
        value_type = resolvparam(value_name) ;
        
        if debug_swtich == 1
           fprintf('%s',value_name);%1xxxxx2xxxxxxx3xxxxxxx4
           fprintf('-type:%d  ',value_type);
        end

      switch value_type
          
          case 1  % $符号，表示空，不作任何操作
              ;
          case 2 % ‘xx' 字符串类型
             entity_para = docNode.createElement(t_entity{j,2}{element_no}{1});
             tvalue_name = value_name(2:(length(value_name)-1));%去掉‘’
             entity_para_context = docNode.createTextNode(value_name);%此处若使用tvalue_name则无法在ifcxml区分数字与字符串
             entity_para.appendChild(entity_para_context);
             entity_node.appendChild(entity_para);
          case 3  %#xxx 形式 ，需要取出后面的数字
             value_name_id = value_name(2:length(value_name)) ;
             entity_para = docNode.createElement(t_entity{j,2}{element_no}{1});
             entity_para_child = docNode.createElement(t_entity{j,2}{element_no}{2});
             entity_para_child.setAttribute('ref',value_name_id);
             entity_para.appendChild(entity_para_child);
             entity_node.appendChild(entity_para);
          case 4 %有（#x,#y），（#x）,(xx.,yyy.),(xx.)这样几种情况
              value_name=value_name(2:(length(value_name)-1));%去掉两个括弧号
              num1=length(strfind(value_name,'#'));
              num2=length(strfind(value_name,'.'));
              num3=length(strfind(value_name,','));
              num4=length(strfind(value_name,''''));
              
              if num1 == 1 && num3 == 0 % （#x）
                 entity_para = docNode.createElement(t_entity{j,2}{element_no}{1});
                 entity_para_child = docNode.createElement(t_entity{j,2}{element_no}{2});
                 entity_para_child.setAttribute('ref',value_name(2:length(value_name)));
                 temppostcontent = '1';
                 entity_para_child.setAttribute('pos',temppostcontent);%对于（#xx）增加一个pos属性，用于跟#xx进行区分，by whueht@gmail.com,20130923
                 entity_para.appendChild(entity_para_child);
                 entity_node.appendChild(entity_para);
              elseif num1 > 1 && num3 >= 1 % （#x,#y）
                 numx=strfind(value_name,',');
                 numx=[0 numx length(value_name)+1];
                 
                 entity_para = docNode.createElement(t_entity{j,2}{element_no}{1});
                 for x=1:length(numx)-1
                    context=value_name(numx(x)+1:numx(x+1)-1);
                    context=context(2:length(context));

                    entity_child = docNode.createElement(t_entity{j,2}{element_no}{2}{1});
                    entity_child.setAttribute('ref',context);
                    entity_child.setAttribute('pos',num2str(x));
                    entity_para.appendChild(entity_child);                    
                 end
                 entity_node.appendChild(entity_para);
            
              %elseif num2 == 1 && num3 == 0 % (xx.) 或者（XX）
              elseif num3 == 0
                  entity_para = docNode.createElement(t_entity{j,2}{element_no}{1});
                  temppostcontent = '1';
                  entity_para.setAttribute('pos',temppostcontent);%对于（#xx.）增加一个pos属性，用于跟#xx进行区分，by whueht@gmail.com,20130923
                  entity_para_context = docNode.createTextNode(value_name);
                  entity_para.appendChild(entity_para_context);
                  entity_node.appendChild(entity_para);
              %elseif num2 > 1 && num3 >= 1 % (xx.,yyy.) 或者（xxx,yyy）
              elseif num3 >= 1
                  numx=strfind(value_name,',');
                  numx=[0 numx length(value_name)+1];
                 
                  entity_para = docNode.createElement(t_entity{j,2}{element_no}{1});
                  for x=1:length(numx)-1
                    context=value_name(numx(x)+1:numx(x+1)-1);                 
                    entity_child = docNode.createElement(t_entity{j,2}{element_no}{2}{1});
                    entity_child_context = docNode.createTextNode(context);
                    entity_child.setAttribute('pos',num2str(x));
                    
                    entity_child.appendChild(entity_child_context);  
                    entity_para.appendChild(entity_child);                    
                  end
                  entity_node.appendChild(entity_para);   
                  
              elseif num4 == 2 && num3 == 0 % ('xxxxxxxxx')%对于（#xx.）增加一个pos属性，用于跟#xx进行区分，by whueht@gmail.com,20130923
                  entity_para = docNode.createElement(t_entity{j,2}{element_no}{1});
                  temppostcontent = '1';
                  entity_para.setAttribute('pos',temppostcontent);%对于（#xx.）增加一个pos属性，用于跟#xx进行区分，by whueht@gmail.com,20130923
                  entity_para_context = docNode.createTextNode(value_name);
                  entity_para.appendChild(entity_para_context);
                  entity_node.appendChild(entity_para);
              elseif num4 > 2 && num3 >= 1 % (xx.,yyy.)
                  numx=strfind(value_name,',');
                  numx=[0 numx length(value_name)+1];
                 
                  entity_para = docNode.createElement(t_entity{j,2}{element_no}{1});
                  for x=1:length(numx)-1
                    context=value_name(numx(x)+1:numx(x+1)-1);                 
                    entity_child = docNode.createElement(t_entity{j,2}{element_no}{2}{1});
                    entity_child_context = docNode.createTextNode(context);
                    entity_child.setAttribute('pos',num2str(x));
                    
                    entity_child.appendChild(entity_child_context);  
                    entity_para.appendChild(entity_child);                    
                  end
                  entity_node.appendChild(entity_para); 
                  
              end
              
          case 5 %.xx.格式
              entity_para = docNode.createElement(t_entity{j,2}{element_no}{1});
%             value_name_context = value_name(2:(length(value_name)-1));%还是应该带上..by whueht@gmail.com,20130923
              value_name_context = value_name;
              entity_para_context = docNode.createTextNode(value_name_context);
              entity_para.appendChild(entity_para_context);
              entity_node.appendChild(entity_para);
              
          case 6 %xxx.yyy 普通数字格式
              entity_para = docNode.createElement(t_entity{j,2}{element_no}{1});
              entity_para_context = docNode.createTextNode(value_name);
              entity_para.appendChild(entity_para_context);
              entity_node.appendChild(entity_para);
              
          case 7 %xxx(yyy)函数格式，首先找出函数名字与形参
              ckgap = strfind(value_name,'(') ;
              func_name=value_name(1:(ckgap(1)-1));
              para_name=value_name((ckgap(1)+1):(length(value_name)-1));%减去1是为了去掉')'
              
              func_name=lower(func_name);
              tfunc_name = func_name ;
              func_name=[func_name '-wrapper'];

              entity_para = docNode.createElement(t_entity{j,2}{element_no}{1});
              entity_para.setAttribute('function',tfunc_name);%对于（#xx.）增加一个pos属性，用于跟#xx进行区分，by whueht@gmail.com,20130923
              entity_child = docNode.createElement(func_name);
              entity_child_context = docNode.createTextNode(para_name);
              entity_child.appendChild(entity_child_context);
              
              entity_para.appendChild(entity_child);
              entity_node.appendChild(entity_para);
              
          case 8  %*符号，表示空，不作任何操作 
%      *还是应该显示在ifcXML中by whueht@gmail.com,20130923
              entity_para = docNode.createElement(t_entity{j,2}{element_no}{1});
              entity_para_context = docNode.createTextNode(value_name);
              entity_para.appendChild(entity_para_context);
              entity_node.appendChild(entity_para);
          otherwise
              ;    
      end
  
      value_index = value_index + 1 ;
      element_no = element_no + 1 ;
   end
   
   if debug_swtich == 1
      fprintf('\n');
   end

   
