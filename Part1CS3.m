%%Part1_CS3%%

clear;
close all;

% distance in meters before lens
d1 = 0.2;
% distance in meters after lens
d2 = 0.7;  

% lens focal length in meters
f = 0.150;
% lens radius in meters
r_lens = 0.020; 

theta_x_range = linspace(-pi/20, pi/20, 8); % range of angles for theta_x

% y-coordinate fixed at 0
y = 0;
% theta_y fixed at 0
theta_y = 0; 

% points
points = [0, 10];
points = points / 1000; % convert to meters

% propagation matrix before lens
M_d1 = [1 d1 0 0; 0 1 0 0; 0 0 1 d1; 0 0 0 1];

% Lens matrix
M_f = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];

% propagation matrix after lens
M_d2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];

% Initialize a counter for the ray index
ray_index = 0;

figure;
hold on;
xlabel('z (m)');
ylabel('x (m)');
title('Ray Tracing through a Finite-Sized Lens');
grid on;

% loop over each point and each angle
for i = points
    for theta_x = theta_x_range
        % Increment ray index
        ray_index = ray_index + 1;

        % initial ray vector
        ray_in = [i; theta_x; y; theta_y];
        
        % calc output ray after d1
        ray_mid = M_d1 * ray_in;

        % check to see if ray passes through lens
        if abs(ray_mid(1)) <= r_lens
            % if ray passes through lens and travels d2
            ray_out = M_d2 * M_f * ray_mid;
        else
            % ray misses the lens and doesnt propagate further
            ray_out = ray_mid;
        end

        if ray_index <= 8
            color = 'b';
        else
            color = 'r';
        end

        % plot ray trajectory before lens with color
        plot([0, d1], [ray_in(1), ray_mid(1)], color, 'LineWidth', 1.5);

        % plot ray trajectory after lens if it passes through with color 
        if abs(ray_mid(1)) <= r_lens
            plot([d1, d1 + d2], [ray_mid(1), ray_out(1)], color, 'LineWidth', 1.5);
        end
    end
end
