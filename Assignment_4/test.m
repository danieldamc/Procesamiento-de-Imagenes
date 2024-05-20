function interactive_motion_blur_estimation()
    % Read the blurred image
    blurredImage = load('data/flower.mat').blurred_image;

    initialNoise = 0.02;

    kernel = 5;
    de = 2;


    % Create figure
    hFig = figure('Name', 'Interactive Motion Blur Estimation', 'NumberTitle', 'off');
    
    % Create axis for the image
    hAx = axes('Parent', hFig, 'Position', [0.1 0.4 0.8 0.55]);
    
    % Display the initial blurred image
    PSF = fspecial('gaussian', [kernel, kernel], de);
    initialDeblurredImage = deconvwnr(blurredImage, PSF, initialNoise); 
    hImg = imshow(initialDeblurredImage, 'Parent', hAx);
    title(['Deblurred Image with kernel = ' num2str(kernel) ', desviacion = ' num2str(de) ', noise = ' num2str(initialNoise)]);
    
    % Create sliders and text labels
    createSlider('kernel', kernel, 3, 30, [100 70 300 20], @updateImage, [420 70 50 20]);
    createSlider('de', de, 0, 10, [100 40 300 20], @updateImage, [420 40 50 20]);
    createSlider('Noise', initialNoise, 0.001, 0.1, [100 10 300 20], @updateImage, [420 10 50 20]);

    % Nested function to create sliders
    function createSlider(name, initValue, minValue, maxValue, sliderPosition, callback, textPosition)
        uicontrol('Style', 'slider', 'Min', minValue, 'Max', maxValue, 'Value', initValue, ...
            'Position', sliderPosition, 'Callback', callback, 'Tag', name);
        uicontrol('Style', 'text', 'Position', textPosition, ...
            'String', num2str(initValue), 'Tag', [name '_text']);
    end

    % Nested function to update the image
    function updateImage(~, ~)
        kernel = get(findobj('Tag', 'kernel'), 'Value');
        de = get(findobj('Tag', 'de'), 'Value');
        noise = get(findobj('Tag', 'Noise'), 'Value');
        
        set(findobj('Tag', 'kernel'), 'String', num2str(kernel));
        set(findobj('Tag', 'de'), 'String', num2str(de));
        set(findobj('Tag', 'Noise_text'), 'String', num2str(noise));
        
        PSF = fspecial('gaussian', [kernel, kernel], de);
        deblurredImage = deconvwnr(blurredImage, PSF, noise);
        set(hImg, 'CData', deblurredImage);
        title(hAx, ['Deblurred Image with \theta = ' num2str(theta) ', len = ' num2str(len) ', noise = ' num2str(noise)]);
    end
end