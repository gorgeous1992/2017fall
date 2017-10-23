[x,t] = meshgrid((0:24)/24,(0:.5:575)/575*17*pi-2*pi); 
p = (pi/2)*exp(-t/(8*pi));
u = 1-(1-mod(3.6*t,2*pi)/pi).^4/2;
y = 2*(x.^2-x).^2.*sin(p); 
r = u.*(x.*sin(p)+y.*cos(p)); 
figure('color','w');
view(-22,66);
axis image off ;
surface(r.*cos(t),r.*sin(t),u.*(x.*cos(p)-y.*sin(p)),'EdgeC','n','FaceC','r') ;
light('pos',[-.25 -.25 1], 'style','local', 'col',[1 0.84 0.6]);
lighting gouraud