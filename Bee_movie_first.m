


r = 0.45;
num_luc = 150;
steps = 5000;
cycle = 50;
plotting = 0;

% hive = [0.5 0.5;0.25 0.25; 0.75 0.75; 0.75 0.25; 0.25 0.75];
hive = rand(num_luc,2);
neighbours = rangesearch(hive, hive, r);


for idx=1:length(neighbours)
    neighbours{idx}(1) = [];
end

fase = randi(cycle - 1,1,num_luc);
on_off = fase == 0;


off_color = [198 216 211]./255;
on_color = [155 249 39]./255;
bg_color = [51 24 50]./255;

X = hive(:,1);
Y = hive(:,2);

if plotting
    F = figure('Position',[146,521,1108,441]);
    subplot(1,2,1)
    plt = scatter(X,Y,'.');
    set(gca,'color',bg_color)
    set(gca,'xtick',[])
    set(gca,'ytick',[])
    axis square
    axis([0 1,0 1])

    subplot(1,2,2)
    h = animatedline;
    axis([0,steps,0,num_luc])
end

last_cycle = zeros(1,cycle);

for step = 1:steps
    on_lucs = find(fase == 0);
    off_lucs = find(fase == 25);
    on_off(off_lucs) = 0;
    on_off(on_lucs) = 1;
    for ind = on_lucs
        nei = neighbours{ind};
        num_nei = length(nei);
        
        if on_off(ind) && (sum(on_off(nei)) >= num_nei/2)
            fase(ind) = rem(fase(ind) + 1,50);
        end
    end
    
    if plotting
        colors = [];
        sizes = repelem(50,num_luc);
        sizes(on_off) = 200;
        
        for idx = 1:num_luc
            if on_off(idx)
                colors = [colors;on_color];
            else
                colors = [colors;off_color];
            end
        end
        
        
        plt.CData = colors;
        plt.SizeData = sizes;
        drawnow
        addpoints(h,step,sum(on_off))
    end
    
    if step > steps - cycle
        last_cycle(rem(step,cycle) + 1) = sum(on_off);
    end
    
    fase = rem(fase + 1,50);
end

