% M-PSK System Simulation with BER Curves for SNR=[-4:2:20]dB
clear all; close all; clc;

%% Parameters
M = 16;                      % Set this manually to either 8 or 16 for 8-PSK or 16-PSK
k = log2(M);                 % Bits per symbol
Lb = 1e5;                    % Total number of bits
SNR_range = -4:2:20;         % SNR range in dB

% Preallocate BER array
BER_simulated = zeros(1, length(SNR_range));
BER_theoretical = zeros(1, length(SNR_range));

% Adjust Lb to be a multiple of k
if mod(Lb, k) ~= 0
    Lb_adjusted = floor(Lb / k) * k;
    Lb = Lb_adjusted;
end

Es = 1;                     % Symbol energy (normalized to 1)
Eb = Es / k;                % Energy per bit
Rs = 250e3;                 % Symbol rate (symbols per second)
Tsym = 1 / Rs;              % Symbol period (seconds)
Fc = 2.5e6;                 % Carrier frequency (Hz)
Fs = 10e6;                  % Sampling frequency (Hz)
Tsample = 1 / Fs;           % Sampling period (seconds)
Ns = Tsym / Tsample;        % Number of samples per symbol
Ns = round(Ns);             % Ensure Ns is an integer

%% Generate Binary Input Sequence
bits = randi([0, 1], Lb, 1);

%% Map Bits to Symbols (Gray Coding)
bit_groups = reshape(bits, k, []).';  
binary_symbols = bi2de(bit_groups, 'left-msb');  
gray_symbols = bitxor(binary_symbols, floor(binary_symbols / 2));

%% Generate Baseband Signal
pulse_shape = sqrt(2 / Ns) * ones(1, Ns);  
num_symbols = length(gray_symbols);
I_baseband_total = zeros(1, num_symbols * Ns);
Q_baseband_total = zeros(1, num_symbols * Ns);

for idx = 1:num_symbols
    idx_range = (idx-1)*Ns + 1 : idx*Ns;
    m = gray_symbols(idx);
    theta_m = 2 * pi * m / M;
    I_baseband_total(idx_range) = cos(theta_m) * pulse_shape;
    Q_baseband_total(idx_range) = sin(theta_m) * pulse_shape;
end

% Modulate Baseband Signal onto Carrier
t_total = (0:(num_symbols * Ns - 1)) * Tsample;  
carrier_cos_total = cos(2 * pi * Fc * t_total);
carrier_sin_total = sin(2 * pi * Fc * t_total);
s_t = I_baseband_total .* carrier_cos_total + Q_baseband_total .* carrier_sin_total;

% Loop over different SNR values to compute BER
for snr_idx = 1:length(SNR_range)
    SNR_dB = SNR_range(snr_idx);
    SNR = 10^(SNR_dB / 10);
    N0 = Eb / SNR;
    sigma2 = N0 / 2;
    
    % Add AWGN Noise
    noise = sqrt(sigma2) * randn(1, length(s_t));
    r_t = s_t + noise;

    % Demodulate Received Signal
    r_I = r_t .* carrier_cos_total;
    r_Q = r_t .* carrier_sin_total;

    received_symbols = zeros(num_symbols, 2);
    for idx = 1:num_symbols
        idx_range = (idx-1)*Ns + 1 : idx*Ns;
        I_r = sum(r_I(idx_range)) / Ns;
        Q_r = sum(r_Q(idx_range)) / Ns;
        received_symbols(idx, :) = [I_r, Q_r];
    end
    
    % Adjust Scaling of Received Symbols
    received_symbols = received_symbols / sqrt(mean(sum(received_symbols.^2, 2)));
    
    % Symbol Detection (Decision Device)
    theta = (0:M-1) * (2 * pi / M);
    constellation = [cos(theta).' sin(theta).'];
    detected_symbols = zeros(num_symbols, 1);
    for idx = 1:num_symbols
        r = received_symbols(idx, :);
        distances = sum((constellation - r).^2, 2);
        [~, min_idx] = min(distances);
        detected_symbols(idx) = min_idx - 1;
    end

    % Calculate Bit Error Rate (BER)
    binary_symbols_detected = gray2binary(detected_symbols, k);
    detected_bits_matrix = de2bi(binary_symbols_detected, k, 'left-msb');
    estimated_bits = reshape(detected_bits_matrix.', [], 1);
    estimated_bits = estimated_bits(1:Lb);
    num_errors = sum(bits ~= estimated_bits);
    BER_simulated(snr_idx) = num_errors / Lb;
    
    % Theoretical BER for M-PSK
    BER_theoretical(snr_idx) = (2/k) * qfunc(sqrt(2*SNR) * sin(pi/M));
end

%% Plot BER Curves
figure;
semilogy(SNR_range, BER_simulated, 'b-o', 'DisplayName', sprintf('Simulated %d-PSK', M));
hold on;
semilogy(SNR_range, BER_theoretical, 'r--', 'DisplayName', sprintf('Theoretical %d-PSK', M));
xlabel('SNR (dB)');
ylabel('BER');
title(sprintf('BER vs. SNR for %d-PSK with Gray Coding', M));
legend('show');
grid on;

%% Function for Gray to Binary Conversion
function binary_symbols = gray2binary(gray_symbols, k)
    gray_bits = de2bi(gray_symbols, k, 'left-msb');
    binary_bits = zeros(size(gray_bits));
    binary_bits(:,1) = gray_bits(:,1);
    for i = 2:k
        binary_bits(:,i) = xor(binary_bits(:,i-1), gray_bits(:,i));
    end
    binary_symbols = bi2de(binary_bits, 'left-msb');
end
