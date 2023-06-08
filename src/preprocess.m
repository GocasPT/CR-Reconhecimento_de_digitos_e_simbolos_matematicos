function [input, size] = preprocess(folder, px)
    directory = dir(folder);
    size = length(directory);
    input = [];

    for i = 1 : size
        % Lê a imagem
        img = imread(append(directory(i).folder, "/", directory(i).name));
        img = img(:,:,1);

        % Redimensiona a imagem para px por px
        % TODO: devemos mudar as resolução das imagens para pc mais fracos,
        % mas devemos diminuir para o minimo ou mantemos no 32px?
        img = imresize(img, [px, px]);

        % Converte a imagem para uma matriz binária
        img = imbinarize(img);

        % Transforma a matriz em uma coluna
        img = img(:);

        % Adiciona a coluna aos dados
        input(:, i) = img;
    end
end
