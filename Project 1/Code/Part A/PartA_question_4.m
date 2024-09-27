% sigrisi ton eikonon
apokodikopoihsh = huffmandeco(kodikopoihsh, huffmanDict);
apokodikopoihsh = reshape(apokodikopoihsh, size(I));
elenxos = isequal(I, apokodikopoihsh);
disp('Einai sosti i kodikopoihsh?');
disp(elenxos);

% vrisko ta bit tis kanonikis eikonas kai meta tis kodikopoihmenhs
bits_diadikhs_anaparastashs = numel(I) * 8; 
bits_huffman = length(kodikopoihsh);


disp('arithmos bit original eikonas:');
disp(bits_diadikhs_anaparastashs);
disp('arithmos bit kodikopoihmenhs eikonas:');
disp(bits_huffman);

% logos sibieshs
j = bits_huffman / bits_diadikhs_anaparastashs;
disp('j:');
disp(j);
