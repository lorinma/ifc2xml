% /***********************************************************************************
%  * �� �� ��   : calcgapcharturn.m
%  * �� �� ��   : whueht@gmail.com
%  * ��������   : 2013��08��25��
%  * �ļ�����   : Ѱ�ҷָ�����ڵ�����
%  * ��Ȩ˵��   : Copyright (c) 2013-2015
%  * ��    ��   : 
%  * �޸���־   : 2013/08/25	�������ļ�
% ***********************************************************************************/
function gapcharturn=calcgapcharturn(A)
% �����������±��ʽ�ķָ����ţ�������λ��
% #329= IFCPROPERTYSET('0hQyUek0bC2BakaR4Z0c$h',#52,'\X2\51764ED6\X0\',(),(,,(),,),$,(#319,#320,#323,#324,#326,#327,(111.,222.)),#55);
% ��������������
%     50    51
%     56    57
%     53    60
%     95   105
%     64   106
%      1   111
% ���ǲ��ٷ�Χ���ڵķָ�������Ϊ�Ƿָ���
% A�Ǵ�������е�����
% gapcharturn�ĵ�һ����ֵ��=���ڶ�����ֵ�ǵ�һ���������һ����ֵ�����һ����

    j=1 ;
    k=[];
    m=[];
    while j<=length(A)
  
 %���²���ջ�ķ�ʽ��ȡ���룩�������,m�Ǵ�����õ�x*2�ľ��󣬷��ǲ��������Χ�ڵģ���������Ϊ�Ƿָ���
       if A(j) == '('
         k=[k j];
       elseif A(j) == ')'
         m=[m;k(length(k)) j] ;
         k(length(k))=[];
       end
        
       j=j+1; 
    end
    
    len = size(m) ;
    if len >= 1
       m(len(1),:)=[];
    end
    
    len = size(m) ;
    
    gapcharturn=[];
    
    n=strfind(A,',');%�Դ���Ϊ�ָ���
    j=1;
    while j <= length(n)
        flag = 0 ;
        i = 1 ;
        
        if ~isempty(m)
           while (i <= len(1))%��Ҫ�ж�a�Ƿ�Ϊ��
             if (n(j) >= m(i,1)) && (n(j) <= m(i,2))
              flag = 1 ;
              break ;
             end
             i = i + 1;
           end
        end
        
        if flag == 0
           gapcharturn = [gapcharturn n(j)];%ȡ�����зָ���������
        end
        j = j + 1 ;
    end
    
    n = strfind(A,'(');
    gapcharturn = [n(1) gapcharturn]; %��ȡ��һ��(��������
    
    n = strfind(A,'=');
    gapcharturn = [n(1) gapcharturn];%��ȡ�Ⱥŵ�������, �����ߵĴ����ܹ���

    n = strfind(A,')');
    gapcharturn = [gapcharturn n(length(n))];%��ȡ��һ��(��������
    
    
    