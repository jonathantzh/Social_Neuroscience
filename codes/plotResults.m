addpath('plotFunc')
addpath('Results')
%% Load Results for Box Plot
load ('Baseline');
comp(:,1) =  IBD;

load ('1v1Virtual');
comp(:,2) =  IBD;

load ('1vs1Physical');
comp(:,3) =  IBD;

label = {'Baseline', '1v1Virtual', '1vs1Physical'};
bh = boxplot(comp, label,'notch', 'on','colors','kbr');

% For Making the plot look good
for i=1:size(bh,1) % <- # graphics handles/x
     set(bh(i,1),'linewidth',3);
     %disp(sprintf('working on component: %3d = %s',i,get(bh(i,1),'tag')));
     %pause(.5);
end
set(bh(:,2),'linewidth',3);
set(bh(:,3),'linewidth',3)

ylabel('Inter Brain Desity');
set(gca,'fontsize',25);

p12 = ranksum(comp(:,1),comp(:,2));
p23 = ranksum(comp(:,2),comp(:,3));

title(['p_{12} = ' num2str(p12), ' p_{23}= ' num2str(p12)]);

% Export Figure as PDF or PNG
fp = fillPage(gcf, 'margins', [0 0 0 0], 'papersize', [10,8]);
print(gcf, '-dpdf', '-r300','BoxPlot.pdf');


