% M-PSK System Simulation without Gray Coding
clear all; close all; clc;

%% Parameters
M = 16;                      % Modulation order (8-PSK or 16-PSK)
k = log2(M);                % Bits per symbol
Lb = 1e5;                   % Total number of bits

% Adjust Lb to be a multiple of k
if mod(Lb, k) ~= 0
    Lb_adjusted = floor(Lb / k) * k;
    Lb = Lb_adjusted;
end

Es = 1;                     % Symbol energy (normalized to 1)
Eb = Es / k;                % Energy per bit
Rs = 250e3;                 % Symbol rate (symbols per second)
Tsym = 1 / Rs;              % Symbol period (4 µs)
Fc = 2.5e6;                 % Carrier frequency (Hz)
Fs = 10e6;                  % Sampling frequency (Hz)
Tsample = 1 / Fs;           % Sampling period (seconds)
Ns = Tsym / Tsample;        % Number of samples per symbol
Ns = round(Ns);             % Ensure Ns is an integer

% Display parameters for verification
fprintf('Sampling Frequency Fs = %.2f MHz\n', Fs / 1e6);
fprintf('Symbol Period Tsym = %.2f us\n', Tsym * 1e6);
fprintf('Number of Samples per Symbol Ns = %d\n', Ns);

%% Generate Binary Input Sequence
bits = randi([0, 1], Lb, 1);

%% Map Bits to Symbols (WITHOUT Gray Coding)
bit_groups = reshape(bits, k, []).';  % Reshape bits into k-bit symbols
binary_symbols = bi2de(bit_groups, 'left-msb');  % Convert to decimal symbols (no Gray coding)

%% Generate Baseband Signal
pulse_shape = sqrt(2 / Ns) * ones(1, Ns);  % Rectangular pulse with unit energy
num_symbols = length(binary_symbols);
I_baseband_total = zeros(1, num_symbols * Ns);
Q_baseband_total = zeros(1, num_symbols * Ns);

for idx = 1:num_symbols
    idx_range = (idx-1)*Ns + 1 : idx*Ns;
    m = binary_symbols(idx);    % No Gray coding applied
    theta_m = 2 * pi * m / M;
    I_baseband_total(idx_range) = cos(theta_m) * pulse_shape;
    Q_baseband_total(idx_range) = sin(theta_m) * pulse_shape;
end

%% Modulate Baseband Signal onto Carrier (Corrected)
t_total = (0:(num_symbols * Ns - 1)) * Tsample;  % Total time vector
carrier_cos_total = cos(2 * pi * Fc * t_total);
carrier_sin_total = sin(2 * pi * Fc * t_total);

% Modulate onto carrier (corrected sign)
s_t = I_baseband_total .* carrier_cos_total + Q_baseband_total .* carrier_sin_total;

%% Add AWGN Noise
SNR_dB = 30;
SNR = 10^(SNR_dB / 10);
N0 = Eb / SNR;
sigma2 = N0 / 2;
noise = sqrt(sigma2) * randn(1, length(s_t));  % Generate noise
r_t = s_t + noise;  % Add noise to the transmitted signal

%% Demodulate Received Signal (Corrected Scaling)
r_I = r_t .* carrier_cos_total;
r_Q = r_t .* carrier_sin_total;

received_symbols = zeros(num_symbols, 2);

for idx = 1:num_symbols
    idx_range = (idx-1)*Ns + 1 : idx*Ns;
    I_r = sum(r_I(idx_range)) / Ns;  % Normalize by Ns to average the values
    Q_r = sum(r_Q(idx_range)) / Ns;  % Normalize by Ns to average the values
    received_symbols(idx, :) = [I_r, Q_r];  % Store the received I/Q symbols
end

%% Adjust Scaling of Received Symbols (Match Ideal Constellation)
received_symbols = received_symbols / sqrt(mean(sum(received_symbols.^2, 2)));  % Normalize symbol energy

%% Symbol Detection (Decision Device)
theta = (0:M-1) * (2 * pi / M);
constellation = [cos(theta).' sin(theta).'];  % Ideal constellation

detected_symbols = zeros(num_symbols, 1);
for idx = 1:num_symbols
    r = received_symbols(idx, :);
    distances = sum((constellation - r).^2, 2);
    [~, min_idx] = min(distances);
    detected_symbols(idx) = min_idx - 1;
end

%% Phase Debugging: Check Phase Offset
received_phase = atan2(received_symbols(:, 2), received_symbols(:, 1));  % Phase of received symbols
ideal_phase = theta(binary_symbols + 1)';  % Ideal phase (non-Gray coded symbols)
phase_offset = received_phase - ideal_phase;

% Adjust phase_offset to be within [-pi, pi]
phase_offset = mod(phase_offset + pi, 2*pi) - pi;

% Debug output for phase comparison
fprintf('Phase comparison (first 5 symbols):\n');
for i = 1:5
    fprintf('Symbol %d: Ideal Phase = %f, Received Phase = %f, Phase Offset = %f\n', ...
        i, ideal_phase(i), received_phase(i), phase_offset(i));
end

%% Calculate Bit Error Rate (BER) -- Kept Untouched
binary_symbols_detected = detected_symbols;  % No Gray-to-binary conversion needed
detected_bits_matrix = de2bi(binary_symbols_detected, k, 'left-msb');
estimated_bits = reshape(detected_bits_matrix.', [], 1);
estimated_bits = estimated_bits(1:Lb);
num_errors = sum(bits ~= estimated_bits);
BER = num_errors / Lb;
fprintf('BER at SNR = %d dB: %e\n', SNR_dB, BER);

%% Plot Constellation Diagram (Corrected)
figure;
plot(received_symbols(:,1), received_symbols(:,2), 'r.');
hold on;
plot(constellation(:,1), constellation(:,2), 'bo', 'MarkerFaceColor', 'b');
xlabel('In-phase');
ylabel('Quadrature');
title(sprintf('Constellation Diagram (M=%d-PSK, No Gray Coding)', M));
legend('Received Symbols', 'Ideal Constellation');
grid on;
