function J=regression2D(ind,parameters,i,fig);
n_points=parameters.problem_variables.n_points;
[S0,S1]=meshgrid(linspace(-1,1,n_points));

b=(S0.^5)*2.*(1-S1.^2)+S1.*S0;
b2=b*0;
try
m=readmylisp_to_formal_MLC(ind,parameters);
eval(['b2=' m ';'])
J=sum((b2(:)-b(:)).^2)/length(b2(:));
catch err
    J=parameters.badvalue;
    fprintf(err.message);
end

if nargin==4
    plot3(S0(:),S1(:),b(:),'ok');hold on
    surf(S0,S1,b2,sqrt((b-b2).^2));hold  off
    set(gca,'fontsize',13,'xlim',[min(S0(:)),max(S1(:))],'ylim',[min(S1(:)) max(S1(:))])
    colorbar
    l=legend('$b_i$','${K(s_i)}$');
    set(l,'location','northwest','interpreter','latex')
    grid on
    xlabel('$S0$','fontsize',16,'interpreter','latex')
    ylabel('$S1$','fontsize',16,'interpreter','latex')
   
    set(gcf,'PaperPositionMode','auto')
    grid on
set(gcf,'Position',[100 500 600 500])
end


















































