clear;
close all;

load("lightField.mat");

% lens system parameters
d1 = -0.35;
d2 = -0.1;
f = 0.9;

M_d1 = [1 d1 0 0; 0 1 0 0; 0 0 1 d1; 0 0 0 1];
M_f = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];
M_d2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];

% subset of rays for visualization
num_rays_to_plot = 1000; 
subset_indices = round(linspace(1, size(rays, 2), num_rays_to_plot));

figure;
hold on;
xlabel('z (m)');
ylabel('x (m)');
title('Ray Tracing in the Light Field');
grid on;


for i = subset_indices
  
    ray_in = rays(:, i);

    % apply transformations
    ray_mid = M_d1 * ray_in;
    ray_out = M_d2 * M_f * ray_mid;

    % plot the ray path before & after lens
    plot([0, d1], [ray_in(1), ray_mid(1)], 'b'); % before lens
    plot([d1, d1 + d2], [ray_mid(1), ray_out(1)], 'r'); % after lens
end

hold off;
