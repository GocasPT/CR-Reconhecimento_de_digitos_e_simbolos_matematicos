function target = getTarget(tamanho)
    target = zeros(14, tamanho);
    n = floor(tamanho / 14);

    linha = 1;
    for i = 1 : tamanho
        target(linha, i) = 1;
        if mod(i, n) == 0
            linha = linha + 1;
        end
    end
end
