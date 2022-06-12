% SWARM ROBOTICS:
% FIREFLIES
% Author: ICB
% Date: 20/10/21
% Version 2.1

%--------------------------------------------------------------------------
% DEFINE CONSTANTS
%--------------------------------------------------------------------------
r = 1; % Radius of sight
num_fireflies = 150; % Number of fireflies
steps = 5000; % Timesteps
cycle = 50; % Length of each cycle
plotting = 1; % True if plotting
%--------------------------------------------------------------------------
% GET FIREFLY COORDINATES
%--------------------------------------------------------------------------
Hive = rand(num_fireflies,2); % Random n by 2 matrix where n is the number of fireflies
D = squareform(pdist(Hive)); % Get a matrix of distances
Neighbours = (D < r); % Logical matrix that tells you if two fireflies are neighbours
Neighbours  = logical(Neighbours - diag(diag(Neighbours))); % Delete the diagonal in the Neighbours matrix
%--------------------------------------------------------------------------
% START PLOT
%--------------------------------------------------------------------------
off_color = [198 216 211]./255;
on_color = [155 249 39]./255;
bg_color = [51 24 50]./255;

if plotting
    F = figure('Position',[136,415,1245,523]); % Initialize Figure

    subplot(1,2,1)
    hold on
    hive_visualization = scatter(Hive(:,1),Hive(:,2), '.'); % Create scatter plot
    set(gca, 'xtick',[],'ytick', [], 'color',bg_color) % Set properties (Deletes axis ticks and changes background color)
    hold off
    
    subplot(1,2,2)
    anim_line = animatedline; % Start animated line of number of fireflies on
    axis([0,steps,0,num_fireflies])
    
end
%--------------------------------------------------------------------------
% ON/OFF LOOP
%--------------------------------------------------------------------------
fase = randi(cycle - 1 ,1 ,num_fireflies);
last_cycle = zeros(1,cycle);

for step = 1:steps
    
    turning_on = find(fase == 0); % Get indexes of fireflies that turn on
    on_off = fase < cycle/2; % Logical -> Vector of on fireflies
    
    for ind_turns_on = turning_on
        
        nei = Neighbours(ind_turns_on,:); % Logical -> vector of neighbours
        nei_state = on_off(nei); % Logical -> State of neighbours
        
        if sum(nei_state) >= length(nei_state)/2 % If more than half neighbours are on
            
            fase(ind_turns_on) = fase(ind_turns_on) + 1; % Skip one on step (Add 1 to fase)
            
        end
    end
%-------------------------------------------------------------------------
% UPDATE PLOT
%-------------------------------------------------------------------------
    if plotting
        colors = zeros(num_fireflies,3); % Matrix n by 3 where n is the number of fireflies
        sizes = repelem(50,num_fireflies); % Vector of 50s
        sizes(on_off) = 200; % Change only on fireflies to 200

        for idx = 1:num_fireflies %Iter
            
            colors(idx,:) = off_color; % Fill Color Matrix with off_color
            
        end
        
        for idx = find(on_off) % Iterate over on fireflies
            
            colors(idx,:) = on_color; % Change only on fireflies to on_color
            
        end
        
        hive_visualization.CData = colors; % Update Color Data
        hive_visualization.SizeData = sizes; % Update Size Data
        drawnow
        
        addpoints(anim_line,step,sum(on_off)) % Update 
    end
%--------------------------------------------------------------------------
% DATA COLECTION
% It records the last cycle in a vector of cycle length for further
% analysis
%--------------------------------------------------------------------------
    if step > steps - cycle
        last_cycle(rem(step,cycle) + 1) = sum(fase < cycle/2); % Get on fireflies for last cycle
    end
    
    fase = rem(fase + 1, cycle); % Add one to the fase of all fireflies
end

if plotting
    pause(2)
    close all
end