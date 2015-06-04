function  dmatrix = sortifcdatamatrixbyid(smatrix)

N = length(smatrix);
dmatrix = smatrix ; 
trow = [] ;

for i = 1 : (N-1)
   for j = 1 : (N-i)
      t1 = dmatrix{j} ;
      t2 = dmatrix{j+1} ;
      
      gap1 = strfind(t1,'=') ;
      gap2 = strfind(t2,'=') ;
      
      id1 = str2num(t1(2:(gap1(1)-1)));
      id2 = str2num(t2(2:(gap2(1)-1)));
      
      if id1 > id2
         trow = dmatrix{j} ;
         dmatrix{j} = dmatrix{j+1} ;
         dmatrix{j+1} = trow ;
      end
   end
end