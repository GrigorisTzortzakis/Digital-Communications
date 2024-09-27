% ipologismos edropias
entropia_pigis = sum(pithanotites .* log2(1 ./ pithanotites));
disp('edropia pigis:');
disp(entropia_pigis);

% dimiourgia dedrou huffman
huffmanDict = huffmandict(simvola_pigis, pithanotites);

% kodikopoihsh huffman
kodikopoihsh = huffmanenco(I(:), huffmanDict);


disp('dedrohuffman:');
disp(huffmanDict);

% meso mhkos kodika
mhkos_huffman = sum(pithanotites .* arrayfun(@(x) length(huffmanDict{x, 2}), 1:size(huffmanDict, 1)));
disp('Meso mhkos huffman:');
disp(mhkos_huffman);

% apodotikothta
apodotikothta = entropia_pigis / mhkos_huffman;
disp('apodotikothta:');
disp(apodotikothta);

