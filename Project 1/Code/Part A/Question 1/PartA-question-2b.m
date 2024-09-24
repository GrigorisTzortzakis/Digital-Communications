% ipologimos edropias gia orizodia zeugaria
disp('orizodia zeugaria kai pithanotites:');
edropia_oriz = 0;
orizodies_pithanotites = [];
horizontal_keys = keys(orizodia_zeugaria);
for k = 1:length(horizontal_keys)
    key = horizontal_keys{k};
    arithos_emfaniseon = orizodia_zeugaria(key);
    pithanotita = arithos_emfaniseon / sinolika_orizodia_zeugaria;
    orizodies_pithanotites(end+1) = pithanotita;
    edropia_oriz = edropia_oriz - pithanotita * log2(pithanotita);
    disp([key, ' pithanotita: ', num2str(pithanotita)]);
end
disp(['edropia oriz: ', num2str(edropia_oriz)]);

% ipologismos edropias gia katheta zeugaria
disp('katheta zeugaria kai pithanotites:');
edropia_kath = 0;
kathetes_pithanotites = [];
vertical_keys = keys(katheta_zeugaria);
for k = 1:length(vertical_keys)
    key = vertical_keys{k};
    arithos_emfaniseon = katheta_zeugaria(key);
    pithanotita = arithos_emfaniseon / sinolika_katheta_zeugaria;
    kathetes_pithanotites(end+1) = pithanotita;
    edropia_kath = edropia_kath - pithanotita * log2(pithanotita);
    disp([key, ' pithanotita: ', num2str(pithanotita)]);
end
disp(['edropia kath: ', num2str(edropia_kath)]);

% dedro huffman gia orizodia
[orizodio_dedro, ~] = huffmandict(horizontal_keys, orizodies_pithanotites);


disp('dedro oriz:');
disp(orizodio_dedro);

% dedro huffman gia katheta
[katheto_dedro, ~] = huffmandict(vertical_keys, kathetes_pithanotites);


disp('dedro kath:');
disp(katheto_dedro);

% meso mhkos kodika gia orizodia
meso_mhkos_oriz = 0;
for k = 1:length(horizontal_keys)
    key = horizontal_keys{k};
    kodikas = orizodio_dedro{find(strcmp(key, orizodio_dedro(:,1))), 2};
    mhkos_kodika = length(kodikas);
    meso_mhkos_oriz = meso_mhkos_oriz + orizodies_pithanotites(k) * mhkos_kodika;
end


disp(['meso mhkos oriz: ', num2str(meso_mhkos_oriz), ' bits']);

% meso mhkos kodika gia katheta
meso_mhkos_kath = 0;
for k = 1:length(vertical_keys)
    key = vertical_keys{k};
    kodikas = katheto_dedro{find(strcmp(key, katheto_dedro(:,1))), 2};
    mhkos_kodika = length(kodikas);
    meso_mhkos_kath = meso_mhkos_kath + kathetes_pithanotites(k) * mhkos_kodika;
end


disp(['meso mhkos kath: ', num2str(meso_mhkos_kath), ' bits']);

% apodotikothta gia orizodia
apodotikothta_oriz = edropia_oriz / meso_mhkos_oriz;
disp(['apodotikothta oriz: ', num2str(apodotikothta_oriz * 100), '%']);

% apodotikothta gia katheta
apodotikothta_kath = edropia_kath / meso_mhkos_kath;
disp(['apodotikothta kath: ', num2str(apodotikothta_kath * 100), '%']);

