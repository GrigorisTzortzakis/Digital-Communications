% apo to erotima 4
x = kodikopoihsh; 

% i sinartisi pou mas dinete sto zip
y = binary_symmetric_channel(x);

% ipologismos p sostis metavasis
sostabit = sum(x == y);
sinolikabit = length(x);
p = sostabit / sinolikabit;


disp(['p: ', num2str(p, '%.2f')]);

% diadiki edropia kai xoritikothta kanaliou
H_p = -p * log2(p) - (1 - p) * log2(1 - p);


xorithkothta_kanaliou = 1 - H_p;


disp(['Xorithkothta kanaliou: ', num2str(xorithkothta_kanaliou)]);

% ipologismos katanomis pithanotiton tis eisodou
arithmos_0 = sum(kodikopoihsh == 0);
arithmos_1 = sum(kodikopoihsh == 1);
olatabit = length(kodikopoihsh);


pithanotita_0 = arithmos_0 / olatabit;
pithanotita_1 = arithmos_1 / olatabit;

% edropia eisodou
H_X = - (pithanotita_0 * log2(pithanotita_0) + pithanotita_1 * log2(pithanotita_1));



% ipologismos amoivaias pliroforias
amoivaia_pliroforia = H_X - H_p;


disp(['Amoivaia Pliroforia: ', num2str(amoivaia_pliroforia)]);
