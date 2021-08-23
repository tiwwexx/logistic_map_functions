bvals=[];
b=0:0.001:4;
for a=0:0.001:4
   xold=rand;
   sold=0;
   for i=1:10000
      xnew=a*xold*(1-xold);
      lyap=log(a)+log(abs(1-2*xold));
      snew=sold+lyap;
      xold=xnew;
      sold=snew;
   end
   bvals(1, length(bvals)+1) = snew/10000;
end
%%
plot(b,bvals,'LineWidth',2)
hold on
plot(b,zeros(1,numel(b)),'LineWidth',2)
hold off
f = gcf;
ax = gca;
set(f,'Color','k')
set(ax,'Color','k')
set(gca,'box','off')
set(gca, 'XColor',[1 1 1]);
set(gca, 'YColor',[1 1 1]);
xlabel('r Values','FontSize',24)
ylabel('Lyapunov Exponent','FontSize',24)

%%
gif('Lyapunov_exp.gif')

%%
r=1;
x=0:0.01:1;
y = r*x.*(1-x);
plot(x,y)
hold on
plot(x,x)
hold off