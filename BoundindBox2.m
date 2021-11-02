function BB=BoundindBox2(H,w,h,theta0,phi0,n)
R = H/pi

rect = Myrectangle(w/R,h/R,n)
proj = projrectosph(rect) ;
RotatedProj = RotatePhi(proj,90+phi0);
RotatedProj = RotateTheta(RotatedProj,-theta0)
RotatedProj

BB = cartospher(RotatedProj)
plot(BB(1,:).*R,BB(2,:).*R)
xlim([-pi*R,pi*R])
ylim([-1/2*pi*R,1/2*pi*R])
end

function rec = Myrectangle(w,h,n)
    Y = [linspace(-w/2,w/2-w/(n-1),n-1) ones(1,n-1)*w/2 linspace(w/2,-w/2+w/(n-1),n-1) ones(1,n-1)*-(w/2)];
    X = [ones(1,n-1)*h/2 linspace(h/2,-h/2+h/(n-1),n-1) ones(1,n-1)*-(h/2) linspace(-h/2,h/2-h/(n-1),n-1)];
    rec = [X ; Y];
    
end

function proj = projrectosph(rect)
    X = rect(1,:)/2;
    Y = rect(2,:)/2;
    x = 2.*X./(1+X.^2+Y.^2);
    y = 2.*Y./(1+X.^2+Y.^2);
    z = (-1+x.^2+y.^2)./(1+X.^2+Y.^2);
    proj = [x ; y ; z]
end

function sphr = cartospher(cart)
    x = cart(1,:);
    y = cart(2,:);
    z = cart(3,:);
    phi = atan(sqrt(x.^2+y.^2)./z);
    
    here = phi/pi
    phi = (-pi/2 - atan(sqrt(x.^2+y.^2)./z)).*(phi<0)+(pi/2 - atan(sqrt(x.^2+y.^2)./z)).*(phi>0);
    theta = atan(y./x)+pi*(x<0);
    theta = theta - ((theta/pi)>1)*2*pi;
    sphr = [theta ; phi];
end

function rot = RotatePhi(points, angle)
rot = [];
for i = 1:size(points,2)
   rot = [rot (points(:,i)'*roty(angle))'];
end
end

function rot = RotateTheta(points, angle)
rot = [];
for i = 1:size(points,2)
   rot = [rot (points(:,i)'*rotz(angle))'];
end
end