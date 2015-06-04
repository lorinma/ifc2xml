function matrix = calcrotatematrix( pointA,pointB,theta )

a = pointA(1) ; 
b = pointA(2) ; 
c = pointA(3) ; 

lineD = pointB-pointA ;
lineD = lineD/norm(lineD);

u = lineD(1) ;
v = lineD(2) ;
w = lineD(3) ;

uu = u*u ;
uv = u*v ;
uw = u*w ;
vv = v*v ;
vw = v*w ;
ww = w*w ;
au = a*u ;
av = a*v ;
aw = a*w ;
bu = b*u ;
bv = b*v ;
bw = b*w ;
cu = c*u ;
cv = c*v ;
cw = c*w ;

costheta = cos(theta/180*pi) ;
sintheta = sin(theta/180*pi) ;

matrix(1,1) = uu + (vv + ww) * costheta;
matrix(1,2) = uv * (1 - costheta) + w * sintheta;
matrix(1,3) = uw * (1 - costheta) - v * sintheta;
matrix(1,4) = 0;

matrix(2,1) = uv * (1 - costheta) - w * sintheta;
matrix(2,2) = vv + (uu + ww) * costheta;
matrix(2,3) = vw * (1 - costheta) + u * sintheta;
matrix(2,4) = 0;

matrix(3,1) = uw * (1 - costheta) + v * sintheta;
matrix(3,2) = vw * (1 - costheta) - u * sintheta;
matrix(3,3) = ww + (uu + vv) * costheta;
matrix(3,4) = 0;

matrix(4,1) = (a * (vv + ww) - u * (bv + cw)) * (1 - costheta) + (bw - cv) * sintheta;
matrix(4,2) = (b * (uu + ww) - v * (au + cw)) * (1 - costheta) + (cu - aw) * sintheta;
matrix(4,3) = (c * (uu + vv) - w * (au + bv)) * (1 - costheta) + (av - bu) * sintheta;
matrix(4,4) = 1;


end

