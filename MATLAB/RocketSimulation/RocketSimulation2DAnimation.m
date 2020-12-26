clc;

XX = PVA_X(:,1);
YY = PVA_Y(:,1);
aa = angularPositionLOG;
vv = vectorLOG;
ff = fLOG;

for mm=1:length(XX)   
    plot(XX(mm),YY(mm),'bo','MarkerFaceColor','blue'); hold on;
    quiver(XX(mm) ,YY(mm),cos(aa(mm)),sin(aa(mm)),6,"Linewidth",3,'color',[0 0 1]);
    quiver(XX(mm) ,YY(mm),ff(mm)*cos(aa(mm)-pi+vv(mm)),ff(mm)*sin(aa(mm)+pi+vv(mm))...
        ,1,"Linewidth",2,'color',[1 0 0]);
    hold off;
    axis([-50 50 -50 50])
    pause(0.01)
end

