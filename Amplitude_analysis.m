% AMPLITUDE ANALYSIS:
% FIREFLIES
% Author: ICB
% Date: 21/10/21

%--------------------------------------------------------------------------
% SETTING VARIABLES
%--------------------------------------------------------------------------
num_fireflies =150;
radius = 0.025:0.025:1.4;
repetitions = 50;

amp_mean_list = zeros(1,length(radius));

%--------------------------------------------------------------------------
% ANALYSIS LOOP
% This loops through a range of radiuses and repeats the hive simulation
% 50 times to obtain data
%--------------------------------------------------------------------------
count = 1;
for r=radius
    
    amp_list = zeros(1,repetitions);
    
    for rep = 1:repetitions
        
        run('Bee_movie.m') % Run Hive
        amp = (max(last_cycle) - min(last_cycle))/2; % Caluclate Amplitude of last cycle
        amp_list(rep) = amp;
        fprintf('radius %0.3f\nrepetition %d\nAmplitude: %0.1f\n---\n',r,rep,amp) % Prints information
    end
    
    mean_amp = mean(amp_list); % Gets mean amplitude of the 50 repetitions
    amp_mean_list(count) = mean_amp;
    
    fprintf('###\nradius %0.3f\nMean Amplitude: %0.3f\n###\n',r,mean_amp) % prints information
    count = count + 1;
end
 
%--------------------------------------------------------------------------
% PLOT DATA
%--------------------------------------------------------------------------
[max_amp, idx] = max(amp_mean_list);
scatter(radius,amp_mean_list, '.r')
axis([0 1.5 0 max_amp + 5])
yline(max_amp, '--')
text(0.05,max(amp_mean_list) + 2,sprintf('Radius: %0.3f',radius(idx)))