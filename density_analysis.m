%DENSITY ANALYSIS
%ICB

density = 200:5:400;
r = 0.450;
repetitions = 50;

amp_mean_list = zeros(1,length(density));

count = 1;
for num_luc=density
    
    amp_list = zeros(1,repetitions);
    
    for rep=1:repetitions
        
        run('Bee_movie.m')
        amp = ((max(last_cycle) - min(last_cycle))/2)/(num_luc/2);
        amp_list(rep) = amp;
        fprintf('Density %d\nrepetition %d\nAmplitude: %0.1f\n---\n',num_luc,rep,amp)
    end
    
    mean_amp = mean(amp_list);
    amp_mean_list(count) = mean_amp;
    
    fprintf('###\nDensity %d\nMean Amplitude: %0.3f\n###\n',num_luc,mean_amp)
    count = count + 1;
end

[max_amp, idx] = max(amp_mean_list);
scatter(density,amp_mean_list)
yline(max_amp)
text(100,max(amp_mean_list)+10,sprintf('Number of Fireflies: %d',density(idx)))