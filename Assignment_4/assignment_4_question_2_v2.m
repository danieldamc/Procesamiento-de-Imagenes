function assignment_4_question_2_v2()
    
    input_image = load('data/flower.mat').blurred_image;
    
    initial_psfRadius = 10; 
    estimated_nsr = 0.000001;
    
    psf = fspecial('disk', initial_psfRadius);
    deconvolvedImage = deconvwnr(input_image, psf, estimated_nsr);

    imwrite(deconvolvedImage, 'images/flower_03.png');    
end