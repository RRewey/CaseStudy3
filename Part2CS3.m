clear;
close all;

load("lightField.mat");

% focal length for lens
f = 0.2;

% lens matrix M_f
M_f = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];

% d2 is second free-space propagation matrix (after the lens)
d2 = 0.4; 

% second free-space propagation matrix
M_d2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];

% transform the ray data
rays_x = rays(1,:);
rays_y = rays(3,:);
rays_theta_x = rays(2,:); 
rays_theta_y = rays(4,:);


% Perform k-means clustering on rays_x
num_clusters = 3;
[idx, C] = kmeans(rays_x', num_clusters);

% Create separate matrices for each cluster

obj1 = rays(:,idx == 1);
obj2 = rays(:,idx == 2);
obj3 = rays(:,idx == 3);


%propagating 
obj1 =  M_d2 * M_f * obj1;
obj2 =  M_d2 * M_f * obj2;
obj3 =  M_d2 * M_f * obj3;


width = 0.005; % sensor width
Npixels = 175; % number of pixels

% Create images for each cluster using rays2img
img1 = rays2img(-1*obj1(1,:), obj1(3,:), width, Npixels);
img2 = rays2img(-1*obj2(1,:), obj2(3,:), width, Npixels);
img3 = rays2img(-1*obj3(1,:), obj3(3,:), width, Npixels);

tiledlayout(1,3);

nexttile;
imshow(img1);
title('Avocado in Therapy');

nexttile;
imshow(img2);
title('WashU Logo');

nexttile;
imshow(img3);
title('Brookings Hall');