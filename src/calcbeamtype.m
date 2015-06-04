
function beamtype = calcbeamtype(ifcdataname,entityid)

templinecontent = findindexcontent(ifcdataname,entityid) ;
[funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ;

tempentityid = temparamcontainer{1,7} ;
templinecontent = findindexcontent(ifcdataname,tempentityid) ;
[funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ;

[element elementnum]=getparatype4element(temparamcontainer{1,3}) ;

for j = 1 : elementnum
    templinecontent = findindexcontent(ifcdataname,element{j}) ;
    [funname temparamcontainer entityid]=resolvlinecontent(templinecontent) ;
    
    if strcmp(temparamcontainer{1,3},'''SweptSolid''')  == 1
        beamtype = 'SweptSolid' 
        return ;
    end
end

beamtype = 'Brep' ;
