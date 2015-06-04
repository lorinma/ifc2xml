% /***********************************************************************************
%  * 文 件 名   : findindexcontent.m
%  * 负 责 人   : whueht@gmail.com
%  * 创建日期   : 2013年09月10日
%  * 文件描述   : 
%  * 版权说明   : Copyright (c) 2013-2015
%  * 其    他   : 
%  * 修改日志   : 2013/09/10	创建该文件
% *************************************************************************************
function  buf = findindexcontent(filename,string)

  buf=[];
  string = [string '= '];%正文都是以#xxx= 的方式打头的 
  nstr=length(string);
  
  fileopenflag = 0 ; %文件打开标志位
  
  fids=fopen('all') ; %获取所有打开文件指针
  for i=1:length(fids)
     if strcmp(fopen(fids(i)),filename)==1  %文件在别处已经打开
          fileopenflag = 1 ; 
          break
     end
  end
 
  fid=fopen(filename,'r') ;
  
  while ~feof(fid)
     tline=[];
    
     tline=fgetl(fid);%=逐行进行读取数值
    
     if strncmp(tline,string,nstr) == 1%找出特殊字符串的所在行,strncmp是相等就返回1
        buf=tline ;
        
        if fileopenflag == 0
           fclose(fid);
        end
        
        return ;
     end
  end
 
  if fileopenflag == 0
     fclose(fid);
  end