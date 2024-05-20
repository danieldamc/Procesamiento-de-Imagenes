kitchen_data = load('data/kitchen_noise.mat');

% imshow(data.kitchen_noise);

%save image 
imwrite(kitchen_data.kitchen_noise, 'output/kitchen_noise.png')

% save every rgb channel of the image
r = kitchen_data.kitchen_noise(:,:,1);
g = kitchen_data.kitchen_noise(:,:,2);
b = kitchen_data.kitchen_noise(:,:,3);

imwrite(r, 'output/kitchen_noise_r_channel.png');
imwrite(g, 'output/kitchen_noise_g_channel.png');
imwrite(b, 'output/kitchen_noise_b_channel.png');


