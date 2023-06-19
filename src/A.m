clear all
close all
clc

folder = "../data/start/*/*/*.png";
[input, tamanho] = preprocess(folder, 28);
target = getTarget(tamanho, 14);

epochs = 10;

accuracyFinal = 0;
nSim = 10;

for sim = 1 : nSim
    net = feedforwardnet(10);
    net.trainParam.epochs = epochs;

    [net, tr] = train(net, input, target);

    out = net(input);
    plotconfusion(target, out);

    r = 0;
    for i = 1:size(out, 2)
        [~, b] = max(out(:, i));
        [~, d] = max(target(:, i));
        if b == d
            r = r + 1;
        end
    end
    accuracy = r / size(target, 2) * 100;
    fprintf('Precisão na iteração %d: %.3f\n', sim, accuracy)
    accuracyFinal = accuracyFinal + accuracy;
end

fprintf('\nMédia da precisão depois de %i iterações: %.3f\n', nSim, accuracyFinal/nSim);