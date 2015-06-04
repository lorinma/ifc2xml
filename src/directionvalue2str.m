function [content] = directionvalue2str(directionvalue)

    tmpcontentx = num2str(directionvalue(1));
    if isempty(strfind(tmpcontentx,'.')) == 1
        tmpcontentx = [tmpcontentx '.'];
    end
    
    tmpcontenty = num2str(directionvalue(2));
    if isempty(strfind(tmpcontenty,'.')) == 1
       tmpcontenty = [tmpcontenty '.'];
    end
    
    tmpcontentz = num2str(directionvalue(3));
    if isempty(strfind(tmpcontentz,'.')) == 1
        tmpcontentz = [tmpcontentz '.'];
    end
    
    content = [tmpcontentx ',' tmpcontenty ',' tmpcontentz] ;