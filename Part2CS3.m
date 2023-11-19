%%%Part2 CS3%%%

clear;
close all;

load("lightField.mat");

% three sets of parameters for focal length (f), d1, and d2
params = struct(...
    'f', [0.78, 0.85, 0.9], ...
    'd1', [-0.35, -0.4, -0.45], ...
    'd2', [-0.1, -0.15, -0.2]);

% loop over each set of parameters
for p = 1:length(params.f)
    % set current parameters
    f = params.f(p);
    d1 = params.d1(p);
    d2 = params.d2(p);

    % lens matrix M_f and the free-space propagation matrices M_d1 and M_d2
    M_f = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];
    M_d1 = [1 d1 0 0; 0 1 0 0; 0 0 1 d1; 0 0 0 1];
    M_d2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];

    % Transform ray data
    rays_x = rays(1,:);
    rays_y = rays(3,:);
    rays_theta_x = rays(2,:);
    rays_theta_y = rays(4,:);

    % applu M_d1, M_f, & M_d2 matrices to each ray
    for i = 1:length(rays_x)
        ray_in = [rays_x(i); rays_theta_x(i); rays_y(i); rays_theta_y(i)];
        ray_out = M_d2 * M_f * M_d1 * ray_in;
        rays_x(i) = ray_out(1);
        rays_y(i) = ray_out(3);
    end

    % create image
    width = 0.03; 
    Npixels = 1000; 
    [img, x, y] = rays2img(rays_x, rays_y, width, Npixels);
    rot = imrotate(img, 180);
    flip = flipud(rot);

    % display image in a new figure
    figure;
    imshow(flip);
    title(sprintf('Image with f = %.2f, d1 = %.2f, d2 = %.2f', f, d1, d2));
end
