function target = getTarget(tamanho, size)
    target = zeros(size, tamanho);
    n = floor(tamanho / size);

    linha = 1;
    for i = 1 : tamanho
        target(linha, i) = 1;
        if mod(i, n) == 0
            linha = linha + 1;
        end
    end
end
