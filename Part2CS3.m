%%%Part2 CS3%%%

load("lightField.mat");

rays_x = rays(1,:);
rays_y= rays(3,:);
width = 0.03;
Npixels = 900;

[img,x,y] = rays2img(rays_x,rays_y,width,Npixels);
imshow(img);