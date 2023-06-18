function [input, size] = preprocess(folder, px)
    directory = dir(folder);
    size = length(directory);
    input = [];

    for i = 1 : size
        img = imread(append(directory(i).folder, "/", directory(i).name));
        img = img(:,:,1);

        img = imresize(img, [px, px]);

        img = imbinarize(img);

        img = img(:);

        input(:, i) = img;
    end
end
