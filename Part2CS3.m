%%%Part2 CS3%%%

clear;
close all;

load("lightField.mat");

% distance for free-space propogation
d = -.36; 

M_d = [1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];

% Transform the ray data
rays_x = rays(1,:);
rays_y = rays(3,:);
rays_theta_x = rays(2,:); % Assuming this is the angle in the xz plane
rays_theta_y = rays(4,:); % Assuming this is the angle in the yz plane


% Apply the M_d matrix to each ray
for i = 1:length(rays_x)
    ray_in = [rays_x(i); rays_theta_x(i); rays_y(i); rays_theta_y(i)];
    ray_out = M_d * ray_in;
    rays_x(i) = ray_out(1);
    rays_y(i) = ray_out(3);
end

width = 0.03;
Npixels = 1000;

[img,x,y] = rays2img(rays_x,rays_y,width,Npixels);
imshow(img);

