function assignment_4_question_3()
    car_data = imread('data/car_blurred.png');
    
    % tunned hyperparameters
    len = 50;
    theta = 30;
    noise = 100;
    
    PSF = fspecial('motion', len, theta);
    
    snr = 1 / noise; 
    
    car_deconv = deconvwnr(car_data, PSF, snr);
    
    %save image
    imwrite(car_deconv, 'images/car_02.png');

    figure, imshow(car_deconv);
    title('Deblurred Image')
end