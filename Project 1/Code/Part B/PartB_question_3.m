function main()

    close all;
    load('source.mat') 
    x = t; 
    sinolikos_arithmos_deigmaton = length(x);

    % meso tetragoniko sfalma
    MSE = zeros(6, 3); 

    % kano to loop adi gia mia mia fora opos to 2 
    for p = 5:10
        for N = 1:3
            min_value = -3.5; 
            max_value = 3.5; 

            R = zeros(p,p);
            r = zeros(p,1);

            
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

            % kodikopoihths
            proigoumena_deigmata = zeros(p,1);
            y = zeros(sinolikos_arithmos_deigmaton,1);
            y_meto_simvolo_apano = zeros(sinolikos_arithmos_deigmaton,1);
            y_meto_simvolo_apano_tonismeno = 0;
            for i=1:sinolikos_arithmos_deigmaton
                y(i) = x(i) - y_meto_simvolo_apano_tonismeno;
                y_meto_simvolo_apano(i) = my_quantizer(y(i),N,min_value,max_value);
                y_meto_simvolo_apano_tonismeno = y_meto_simvolo_apano(i) + y_meto_simvolo_apano_tonismeno;
                proigoumena_deigmata = [y_meto_simvolo_apano_tonismeno; proigoumena_deigmata(1:p-1)];
                y_meto_simvolo_apano_tonismeno = a'*proigoumena_deigmata;
            end

            % apokodikopoiths
            proigoumena_deigmata = zeros(p,1);
            y_meto_simvolo_apano_tonismeno = 0;
            anakataskeuasmeno_sima = zeros(sinolikos_arithmos_deigmaton,1);
            for i=1:sinolikos_arithmos_deigmaton
                anakataskeuasmeno_sima(i) = y_meto_simvolo_apano(i) + y_meto_simvolo_apano_tonismeno;
                proigoumena_deigmata = [anakataskeuasmeno_sima(i); proigoumena_deigmata(1:p-1)];
                y_meto_simvolo_apano_tonismeno = a'*proigoumena_deigmata;
            end

            % ipologismos mse gia kathe iteration tou loop
            MSE(p-4, N) = mean((x - anakataskeuasmeno_sima).^2);
        end
    end
    disp('mse gia kathe sindiasmo:');
    disp(MSE);
    % apla vazo ta mse pou vrika xeirokinita 
times_kvadisti = [1 2 3];
mse_giap5 = [5.2714, 0.6409, 0.1611];
mse_giap6 = [5.3353, 0.6633, 0.1586];
mse_giap7 = [4.2377, 0.5591, 0.1004];
mse_giap8 = [3.9709, 0.4855, 0.0898];
mse_giap9 = [4.0595, 0.4841, 0.0892];
mse_giap10 = [3.6841, 0.4766, 0.0863];


hold on;
plot1 = plot(times_kvadisti, mse_giap5);
plot2 = plot(times_kvadisti, mse_giap6);
plot3 = plot(times_kvadisti, mse_giap7);
plot4 = plot(times_kvadisti, mse_giap8);
plot5 = plot(times_kvadisti, mse_giap9);
plot6 = plot(times_kvadisti, mse_giap10);

set(plot1, 'Marker', 'square');
set(plot2, 'Marker', 'square');
set(plot3, 'Marker', 'square');
set(plot4, 'Marker', 'square');
set(plot5, 'Marker', 'square');
set(plot6, 'Marker', 'square');

hold off;
xlabel('N');
ylabel('meso tetragoniko sfalma');
legend('meso tetragoniko sfalma gia p=5', 'meso tetragoniko sfalma gia p=6', 'meso tetragoniko sfalma gia p=7', 'meso tetragoniko sfalma gia  p=8', 'meso tetragoniko sfalma gia p=9', 'meso tetragoniko sfalma gia p=10');

end
