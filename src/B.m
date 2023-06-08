clear all
close all
clc

folder = "../data/NN datasets/train1/*/*.png";
[input, tamanho] = preprocess(folder, 28);
target = getTarget(tamanho);

epochs = 10;
layer = 10;
actionFunc = ["logsig" "hardlim" "purelin" "softmax" "tansig" "tribas"];
trainFunc = ["trainlm" "trainbfg" "trainscg" "trainoss" "traingdx" "traingd"];
divisionFunc = ["dividerand" "divideblock" "divideint" "divideind"];

accuracyTotalFinal = 0;
accuracyTestFinal = 0;
nSim = 10;

numNetwork = 1;

for sim = 1 : nSim
    if (numNetwork == 1)
        net = feedforwardnet(layer);
        net.layers{1}.transferFcn = act_func;
        net.trainFcn = trn_func;
        net.divideFcn = dvd_func;
        net.trainParam.epochs = epochs;

        [net, tr] = train(net, input, target);
    
        out = net(input);
    
        r = 0;
        for i = 1:size(out, 2)
            [~, b] = max(out(:, i));
            [~, d] = max(target(:, i));
            if b == d
                r = r + 1;
            end
        end
        accuracy = r / size(target, 2) * 100;
        fprintf('Precisão total de %i: %.3f\n', sim, accuracy)
        accuracyFinal = accuracyFinal + accuracy;
    else 
        if (numNetwork == 2)
            netNum = feedforwardnet(layer);
            netOp = feedforwardnet(layer);
            
        end
    end
end

fprintf('\nMédia global final dos depois de %i testes: %.3f\n', nSim, accuracyFinal/nSim);
fprintf('\nMédia global final dos depois de %i testes: %.3f\n', nSim, accuracyFinal/nSim);

plotconfusion(target, out);