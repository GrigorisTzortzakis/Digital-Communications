function main()

close all;

% posa proigoumena deigmata tha exoume
p = 10;
% ta bit kvadisti
N = 3; 
% dinamiki perioxi tou kvadisti
min_value = -3.5; 
max_value = 3.5; 
load('source.mat') 
%diavasa to arxeio pou exei dothei kai i t einai i metavliti pou exei ta
%deigmata
x = t; 
sinolikos_arithmos_deigmaton = length(x);
R = zeros(p,p);
r = zeros(p,1);

% yule walker
for i=1:p
    sum_r = 0;
    for n=p+1:sinolikos_arithmos_deigmaton
        sum_r = sum_r + x(n)*x(n-i);
    end
    r(i) = sum_r * 1/(sinolikos_arithmos_deigmaton-p); 
    for j=1:p
        sum_R = 0;
        for n=p+1:sinolikos_arithmos_deigmaton
            sum_R = sum_R + x(n-j)*x(n-i);
        end
        R(i,j) = sum_R * 1/(sinolikos_arithmos_deigmaton-p);
    end
end

a = R\r;
for i=1:p
    a(i) = my_quantizer(a(i), 8, -2, 2); 
end

% kodikopoiths
proigoumena_deigmata = zeros(p,1);
y = zeros(sinolikos_arithmos_deigmaton,1);
y_meto_simvolo_apano = zeros(sinolikos_arithmos_deigmaton,1);
y_meto_simvolo_apano_tonismeno = 0;
%ipologismos sfalmatos provepsis
for i=1:sinolikos_arithmos_deigmaton
    y(i) = x(i) - y_meto_simvolo_apano_tonismeno;
    y_meto_simvolo_apano(i) = my_quantizer(y(i),N,min_value,max_value);
    y_meto_simvolo_apano_tonismeno = y_meto_simvolo_apano(i) + y_meto_simvolo_apano_tonismeno;
    proigoumena_deigmata = [y_meto_simvolo_apano_tonismeno; proigoumena_deigmata(1:p-1)];
    y_meto_simvolo_apano_tonismeno = a'*proigoumena_deigmata;
end

% apokodikopoihths
proigoumena_deigmata = zeros(p,1);
y_meto_simvolo_apano_tonismeno = 0;
anakataskeuasmeno_sima = zeros(sinolikos_arithmos_deigmaton,1);
for i=1:sinolikos_arithmos_deigmaton
    anakataskeuasmeno_sima(i) = y_meto_simvolo_apano(i) + y_meto_simvolo_apano_tonismeno;
    proigoumena_deigmata = [anakataskeuasmeno_sima(i); proigoumena_deigmata(1:p-1)];
    y_meto_simvolo_apano_tonismeno = a'*proigoumena_deigmata;
end

% arxiko shma kai shma anakataskeuhs
figure;
subplot(2,1,1); 
plot(x);
title('arxiko shma');
xlabel('deigmata');
ylabel('platos');

subplot(2,1,2); 
plot(anakataskeuasmeno_sima);
title('anakaskeuasmeno shma');
xlabel('deigmata');
ylabel('platos');

end

