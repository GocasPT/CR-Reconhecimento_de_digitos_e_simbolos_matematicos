clear all
close all
clc

folder = "../data/draw/*/*/*.png";
folderNum = "../data/draw/num/*/*.png";
folderOp = "../data/draw/op/*/*.png";
[input, tamanho] = preprocess(folder, 28);
[inputNum, tamanhoNum] = preprocess(folderNum, 28);
[inputOp, tamanhoOp] = preprocess(folderOp, 28);
target = getTarget(tamanho);
targetNum = getTarget(tamanhoNum);
targetOp = getTarget(tamanhoOp);

accuracyFinal = 0;
accuracyNumFinal = 0;
accuracyOpFinal = 0;
nSim = 10;

for sim = 1 : nSim
    load('../model/BNetwork.mat', 'net');
    load('../model/BNetworkNum.mat', 'netNum');
    load('../model/BNetworkOP.mat', 'netOp');

    out = net(input);
    outNum = netNum(inputNum);
    outOp = netOp(inputOp);

    % rede num + op
    r = 0;
    for i = 1:size(out, 2)
        [~, b] = max(out(:, i));
        [~, d] = max(target(:, i));
        if b == d
            r = r + 1;
        end
    end
    accuracy = r / size(target, 2) * 100;
    fprintf('Precisão [da rede num + op] na iteração %d: %.3f\n', sim, accuracy)
    accuracyFinal = accuracyFinal + accuracy;

    % rede num
    r = 0;
    for i = 1:size(outNum, 2)
        [~, b] = max(outNum(:, i));
        [~, d] = max(targetNum(:, i));
        if b == d
            r = r + 1;
        end
    end
    accuracy = r / size(targetNum, 2) * 100;
    fprintf('Precisão [da rede num] na iteração %d: %.3f\n', sim, accuracy)
    accuracyNumFinal = accuracyNumFinal + accuracy;

    % rede op
    r = 0;
    for i = 1:size(outOp, 2)
        [~, b] = max(outOp(:, i));
        [~, d] = max(targetOp(:, i));
        if b == d
            r = r + 1;
        end
    end
    accuracy = r / size(targetOp, 2) * 100;
    fprintf('Precisão [da rede op] na iteração %d: %.3f\n', sim, accuracy)
    accuracyOpFinal = accuracyOpFinal + accuracy;
end

fprintf('\nMédia da precisão [da rede num + op] depois de %i iterações: %.3f', nSim, accuracyFinal/nSim);
fprintf('\nMédia da precisão [da rede num] depois de %i iterações: %.3f', nSim, accuracyNumFinal/nSim);
fprintf('\nMédia da precisão [da rede op] depois de %i iterações: %.3f\n', nSim, accuracyOpFinal/nSim);