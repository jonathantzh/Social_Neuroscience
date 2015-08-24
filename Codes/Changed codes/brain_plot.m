function brain_plot(connectivity, thres)
%% Plotting cortex
load tess_bs_tcortex
Vertices=Vertices.*950;
light('Parent',gca','Position',[-0.9 0.03 0.5]);

Vertices=Vertices*1.1;
hold on

trisurf(Faces,Vertices(:,2)-mean(Vertices(:,2)),...
    (-Vertices(:,1)-mean(Vertices(:,1)))+5,...
    Vertices(:,3)-mean(Vertices(:,3)),...
    'facecolor',[0.8 0.8 0.8],'facealpha',0.1,'LineStyle','none');

trisurf(Faces,(Vertices(:,2)-mean(Vertices(:,2))+200),...
    (-Vertices(:,1)-mean(Vertices(:,1)))+5,...
    Vertices(:,3)-mean(Vertices(:,3)),...
    'facecolor',[0.8 0.8 0.8],'facealpha',0.1,'LineStyle','none');


%% Plotting nodes
load emotive_brains.mat
for i = 1:14
    plot3(brain_1(i,1),brain_1(i,2),brain_1(i,2),'Marker','o',...
        'MarkerSize',30,'MarkerFaceColor','r','MarkerEdgeColor','r');
    plot3(brain_2(i,1),brain_2(i,2),brain_2(i,2),'Marker','o',...
        'MarkerSize',30,'MarkerFaceColor','b','MarkerEdgeColor','b');
    
end
set(gca,'Visible','off');
set(gcf,'Color',[1 1 1]);
view(0,90)


%% Thresholding connectivity matrix
adj = connectivity;
adj(adj>thres) = 1;
adj(adj<thres) = 0;
[nbrain_1, nbrain_2] = find(adj);
cord_brain_1 = brain_1(nbrain_1,:);  
cord_brain_2 = brain_2(nbrain_2,:);

value123=sum(adj(:)==1);
result13=value123/(14^2);    
%set(mTextBoxresult,'String',result13);
text(max(xlim)*0.5, min(ylim)*1.1, ['Inter-Brain Density: ' num2str(result13)],'FontSize',30);
%annotation('textbox',[0.02 0.03 1 0.05],'String',['Inter-Brain Density:' num2str(result13)]);


for i = 1:size(cord_brain_1,1)
    
    bline(i) = line([cord_brain_1(i,1);cord_brain_2(i,1)],...
        [cord_brain_1(i,2);cord_brain_2(i,2)],...
        [cord_brain_1(i,3);cord_brain_2(i,3)],'LineWidth',2,'Color','k');
end

hold off
end



