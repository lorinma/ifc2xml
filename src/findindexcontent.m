% /***********************************************************************************
%  * �� �� ��   : findindexcontent.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��09��10��
%  * �ļ�����   : 
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/09/10	�������ļ�
% *************************************************************************************
function  buf = findindexcontent(filename,string)

  buf=[];
  string = [string '= '];%���Ķ�����#xxx= �ķ�ʽ��ͷ�� 
  nstr=length(string);
  
  fileopenflag = 0 ; %�ļ��򿪱�־λ
  
  fids=fopen('all') ; %��ȡ���д��ļ�ָ��
  for i=1:length(fids)
     if strcmp(fopen(fids(i)),filename)==1  %�ļ��ڱ��Ѿ���
          fileopenflag = 1 ; 
          break
     end
  end
 
  fid=fopen(filename,'r') ;
  
  while ~feof(fid)
     tline=[];
    
     tline=fgetl(fid);%=���н��ж�ȡ��ֵ
    
     if strncmp(tline,string,nstr) == 1%�ҳ������ַ�����������,strncmp����Ⱦͷ���1
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