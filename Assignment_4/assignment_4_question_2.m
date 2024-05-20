function assignment_4_question_2()
    flower_data = load('data/flower.mat').blurred_image;
   
    flower_data = double(flower_data);
    min_val = 0.04230597702414099;
    max_val = 0.9403096162968041;
    flower_data = (flower_data - min_val) / (max_val - min_val) * 255;

    F = fft2(flower_data);

    % Crear el kernel en el dominio de la frecuencia
    kernel_size = 20;
    sigma = 1;
    PSF = fspecial('gaussian', [kernel_size, kernel_size], sigma);
    PSF = psf2otf(PSF, size(F));
    
    % Calcular la inversa de la función de transferencia
    H = conj(PSF) ./ (abs(PSF).^2 + 0.0001); % Evitar división por cero
    
    % Aplicar la deconvolución en el dominio de la frecuencia
    deconv_F = F .* H;
    
    % Calcular la inversa de la transformada de Fourier 2D
    deconv_img = ifft2(deconv_F);
    
    % Convertir la imagen de vuelta a valores de píxeles en el rango [0, 255]
    deconv_img = uint8(real(deconv_img));

    imshow(deconv_img)
end