I = imread('parrot.png'); 

%  vrisko ta monadika simvola pigis
simvola_pigis = unique(I(:));

%  ipologismos pithanotiton
pithanotites = histcounts(I, numel(simvola_pigis)) / numel(I);


disp('Simvola Pigis:');
disp(simvola_pigis);

disp('Pithanotites:');
disp(pithanotites);