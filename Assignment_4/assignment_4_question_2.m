function assignment_4_question_2()
    
    input_image = load('data/flower.mat').blurred_image;
    
    initial_psfRadius = 30; 
    estimated_nsr = 0.000001;
    
    hFig = figure('Name', 'Deconvolution with Adjustable PSF Radius');
    
    psf = fspecial('disk', initial_psfRadius);
    deconvolvedImage = deconvwnr(input_image, psf, estimated_nsr);
    hImage = imshow(deconvolvedImage);
    title('Deconvolved Image');
    
    hSlider = uicontrol('Style', 'slider', ...
        'Min', 1, 'Max', 100, 'Value', initial_psfRadius, ...
        'Units', 'normalized', 'Position', [0.2, 0.02, 0.6, 0.05], ...
        'Callback', @updateImage);
    

    hLabel = uicontrol('Style', 'text', ...
        'Position', [0.1 0.02 0.1 0.05], ...
        'String', 'PSF Radius:');

    updateImage();

    function updateImage(~, ~)

        psfRadius = round(get(hSlider, 'Value'));
        
        disp(['PSF Radius: ', num2str(psfRadius)]);

        psf = fspecial('disk', psfRadius);
        deconvolvedImage = deconvwnr(input_image, psf, estimated_nsr);

        set(hImage, 'CData', deconvolvedImage);
    end
end