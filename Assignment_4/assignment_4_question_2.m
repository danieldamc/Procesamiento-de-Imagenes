function assignment_4_question_2()

    input_image = load('data/flower.mat').blurred_image;
      

    [M, N] = size(input_image); 
      

    FT_img = fft2(double(input_image)); 
    

    hFig = figure('Name', 'Image Processing with Adjustable Parameters');
    
    subplot(2, 1, 1);
    imshow(input_image, []);
    title('Input Image');
    

    subplot(2, 1, 2);
    hOutputImage = imshow(zeros(M, N), []);
    title('Output Image');
    

    hSliderN = uicontrol('Style', 'slider', ...
                         'Min', 0, 'Max', 10, 'Value', 2, ...
                         'Position', [20, 20, 300, 20], ...
                         'Callback', @updateOutputImage);
    hSliderD0 = uicontrol('Style', 'slider', ...
                          'Min', -10, 'Max', 100, 'Value', 10, ...
                          'Position', [20, 60, 300, 20], ...
                          'Callback', @updateOutputImage);
 
    uicontrol('Style', 'text', 'Position', [330, 20, 50, 20], ...
              'String', 'n');
    uicontrol('Style', 'text', 'Position', [330, 60, 50, 20], ...
              'String', 'D0');
    

    updateOutputImage();
    
    function updateOutputImage(~, ~)
        % Get slider values
        n = round(get(hSliderN, 'Value'));
        D0 = get(hSliderD0, 'Value');

        disp(['n = ', num2str(n), ', D0 = ', num2str(D0)]);
        
        u = 0:(M-1); 
        v = 0:(N-1); 
        idx = find(u > M/2); 
        u(idx) = u(idx) - M; 
        idy = find(v > N/2); 
        v(idy) = v(idy) - N; 
        [V, U] = meshgrid(v, u); 
        D = sqrt(U.^2 + V.^2); 
        H = 1 ./ (1 + (D0 ./ D).^(2*n)); 

        G = H .* FT_img; 
        output_image = real(ifft2(double(G)));
        
        % Update the output image
        set(hOutputImage, 'CData', output_image);
    end
end