clear;
close all;

load("lightField.mat");

% focal length for lens
f = 0.78;

% lens matrix M_f
M_f = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];

% d1 is first free-space propagation matrix (before the lens)
d1 = -0.35;

% first free-space propagation matrix
M_d1 = [1 d1 0 0; 0 1 0 0; 0 0 1 d1; 0 0 0 1];

% d2 is second free-space propagation matrix (after the lens)
d2 = -0.1; 

% second free-space propagation matrix
M_d2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];

% transform the ray data
rays_x = rays(1,:);
rays_y = rays(3,:);
rays_theta_x = rays(2,:); 
rays_theta_y = rays(4,:);

% angle offsets (in radians)
angle_offset_x = .01; 
angle_offset_y = .01;

% modify ray angles
rays_theta_x = rays_theta_x + angle_offset_x;
rays_theta_y = rays_theta_y + angle_offset_y;

% apply M_d1, M_f, and M_d2 matrices to each ray
for i = 1:length(rays_x)
    ray_in = [rays_x(i); rays_theta_x(i); rays_y(i); rays_theta_y(i)];
    
    % applying M_d1, then M_f, then M_d2
    ray_out = M_d2 * M_f * M_d1 * ray_in; 
    rays_x(i) = ray_out(1);
    rays_y(i) = ray_out(3);
end

width = 0.03; % sensor width
Npixels = 1000; % number of pixels

% use rays2img to create the image from the transformed rays
[img, x, y] = rays2img(rays_x, rays_y, width, Npixels);
rot = imrotate(img,180);
flip = flip(rot,2);
imshow(flip);
