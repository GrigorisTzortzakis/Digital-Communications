I = imread('parrot.png');

% megethos eikonas
[row, col] = size(I);

% metavlites pou kratane ta monadika zeugaria pou vrisko 
orizodia_zeugaria = containers.Map('KeyType', 'char', 'ValueType', 'double');
katheta_zeugaria = containers.Map('KeyType', 'char', 'ValueType', 'double');


sinolika_orizodia_zeugaria = 0;
sinolika_katheta_zeugaria = 0;

% euresi orizodion zeugarion
for i = 1:row
    for j = 1:(col - 1)
        orizodio_zeugari = [I(i, j), I(i, j + 1)];
        pair_str = num2str(orizodio_zeugari);
        if isKey(orizodia_zeugaria, pair_str)
            orizodia_zeugaria(pair_str) = orizodia_zeugaria(pair_str) + 1;
        else
            orizodia_zeugaria(pair_str) = 1;
        end
        sinolika_orizodia_zeugaria = sinolika_orizodia_zeugaria + 1;
    end
end

% euresi katheton zeugarion
for i = 1:(row - 1)
    for j = 1:col
        katheto_zeugari = [I(i, j), I(i + 1, j)];
        pair_str = num2str(katheto_zeugari);
        if isKey(katheta_zeugaria, pair_str)
            katheta_zeugaria(pair_str) = katheta_zeugaria(pair_str) + 1;
        else
            katheta_zeugaria(pair_str) = 1;
        end
        sinolika_katheta_zeugaria = sinolika_katheta_zeugaria + 1;
    end
end
