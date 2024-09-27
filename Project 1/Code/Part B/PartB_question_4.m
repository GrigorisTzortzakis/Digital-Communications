function main()

    close all;
    load('source.mat'); 
    x = t; 
    sinolikos_arithmos_deigmaton = length(x);

    % times p pou zitoude
    p_sigekrimena = [5, 10]; % Only p = 5 and p = 10

    %times N pou zitoude
    N_values = 1:3; % N = 1, 2, 3

    % to idio me prin apla kano loop mono ta 2 p pou zitaei
    for p = p_sigekrimena
        for N = N_values
            min_value = -3.5; 
            max_value = 3.5; 

            % yule walker
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

            % kodikopoiths
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

           % ta plot pou zitaei na doume
            figure;
            plot(x, 'b', 'DisplayName', 'arxiko shma'); 
            hold on; 
            plot(anakataskeuasmeno_sima, 'r', 'DisplayName', 'anakateskeuasmeno shma'); 
            hold off; 
            title(['shmata gia ta p = ' num2str(p) ', N = ' num2str(N)]);
            xlabel('N');
            ylabel('A');
            legend show; 
        end
    end
end





