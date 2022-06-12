
radius = 0.025:0.025:1.4;
amp_mean_list = amp_analysis(150,radius,50);



%--------------------------------------------------------------------------
% PLOT DATA
%--------------------------------------------------------------------------
[max_amp, idx] = max(amp_mean_list);
scatter(radius,amp_mean_list, '.r')
axis([0 1.5 0 max_amp + 1])
yline(max_amp)
text(0.05,max(amp_mean_list) + 0.5,sprintf('Radius: %0.3f',radius(idx)))


function amp_mean_list = amp_analysis(num_fireflies, radius, repetitions)

amp_mean_list = zeros(1,length(radius));

%--------------------------------------------------------------------------
% ANALYSIS LOOP
% This loops through a range of radiuses and repeats the hive simulation
% repetitions. times to obtain data
%--------------------------------------------------------------------------
count = 1;
f = waitbar(0,'Starting',Name = 'Amplitude Analysis');
for r=radius
    waitbar((count - 1)/length(radius),f, sprintf('RADIUS: %0.3f', r))
    amp_list = zeros(1,repetitions);
    
    for rep = 1:repetitions
        
        run('Bee_movie.m') % Run Hive
        amp = (max(last_cycle) - min(last_cycle))/2; % Caluclate Amplitude of last cycle
        amp_list(rep) = amp;
    end
    
    mean_amp = mean(amp_list); % Gets mean amplitude of the 50 repetitions
    amp_mean_list(count) = mean_amp;
    
    count = count + 1;
end
delete(f)
end