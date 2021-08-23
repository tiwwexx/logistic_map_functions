% I need to run a for loop using different a values and then save the gif
% at the end of each a for loop

%define my resolution
resolution_a = 0.0005;
start_x_spacing = 0.01;
%define the line that I'll plot over
x_line = 0:resolution_a:3.99;

%updating my values for each value of a
numel_a = numel(x_line); %getting how many a values I test

%initializing my first iterations values and pre-allocating x_new
x_old = 0.05:start_x_spacing:0.95;
x_old = x_old';
x_old = repmat(x_old,1,numel_a);
x_new = zeros(size(x_old,1),numel_a);


%plotting my first data
x_line_one = repmat(x_line,1,size(x_old,1));
plot(x_line_one,x_old(:),'.','MarkerSize',2)
set(gcf,'visible','off') %I dont want this figure popping up on my screen
pbaspect([16 9 1]) %setting standard video aspect ratio
set(gcf, 'Position', get(0, 'Screensize')); %setting figure to full screen for best resolution
title('Iteration 0','Color', [1 1 1],'FontSize',32)
xlabel('r Values','FontSize',24)
ylabel('Population','FontSize',24)
set(gca,'box','off')
set(gca, 'Color','k')
set(gca, 'XColor',[1 1 1]);
set(gca, 'YColor',[1 1 1]);
set(gcf, 'Color', 'k')

%making a gif
gif('logistic_map1.gif','DelayTime',0.3,'LoopCount',5)

%% now to create the gif

%running my loops to create the gif
tic
for n=1:400
    for a=1:numel_a % NOTE: this can be changed to parfor loop but it actually ran slower on my computer
        a_test = (a-1)*resolution_a;
        x_new(:,a) = (x_old(:,a)-x_old(:,a).^2)*a_test;
    end
    %plot these new values in scatter plot
    temp_x = x_new';
    %set(h,'Ydata',temp_x(:))
    %h
    plot(x_line_one,temp_x(:),'.','MarkerSize',2)
    title(['Iteration ', num2str(n)],'FontSize',32, 'Color', [1 1 1])
    xlabel('r Values','FontSize',24)
    ylabel('Population','FontSize',24)
    set(gca,'box','off')
    set(gca, 'Color','k')
    set(gca, 'XColor',[1 1 1]);
    set(gca, 'YColor',[1 1 1]);
    set(gcf, 'Color', 'k')
    gif
    x_old = x_new; 
end
toc

%% Now at the end I want the dot plot but also a density heatmap plot

% first I want a lot more points for my accurate colormap of the "steady state"
% To do this I'll just run the iteration a few more times but save every iteration

num_extra_its = 20; %define how many extra iterations I want to do
big_data_mat = zeros(size(x_new,1),size(x_new,2),num_extra_its); %pre-alloc size of mat
x_one_line_big = repmat(x_line_one,1,num_extra_its);

for n=1:num_extra_its
    big_data_mat(:,:,n) = x_old;
    for a=1:numel_a % NOTE: this can be changed to parfor loop but it actually ran slower on my computer
        a_test = (a-1)*resolution_a;
        x_new(:,a) = (x_old(:,a)-x_old(:,a).^2)*a_test;
    end
    %plot these new values in scatter plot
    temp_x = x_new';
    %set(h,'Ydata',temp_x(:))
    %h
    plot(x_line_one,temp_x(:),'.','MarkerSize',2)
    title(['Iteration ', num2str(n)])
    %gif
    x_old = x_new; 
end

% now I need to reshape big_data_mat into correct size
big_data_mat1 = reshape(big_data_mat,size(big_data_mat,1),size(big_data_mat,2)*size(big_data_mat,3));
big_data_mat1 = big_data_mat1';


%%
figure
n=hist3([x_one_line_big', big_data_mat1(:)],[889 500]);
n=n';
n1 = int16(n);
h=pcolor(n1);
c=colorbar;
c.Color = 'w';
caxis([0 225])
newmap = get(gcf,'Colormap');
newmap(1,:) = [0 0 0];
colormap(newmap);


set(h,'EdgeColor','none');
h.FaceColor = 'interp';
ax = gca;
ax.XTick = [];
ax.YTick = [];
set(gcf,'Color','k')
f=gcf;
%set(gcf,'visible','off') %I dont want this figure popping up on my screen
%set(f, 'Position', get(0, 'Screensize'));
%f.Units = 'inches';
%f.OuterPosition = [0.2 0.25 15.8 8.75];
%gif('logistic_map_heatmap.gif','DelayTime',0.3,'LoopCount',5)
%exportgraphics(f,'logistic_map_heatmap.pdf','ContentType','image','BackgroundColor','current')






