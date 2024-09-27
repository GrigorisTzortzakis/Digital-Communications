% M-PSK System Simulation with Phase Debugging
clear all; close all; clc;

%% Parameters
M_vals = [8, 16];            % Modulation orders for 8-PSK and 16-PSK
k_vals = log2(M_vals);       % Bits per symbol for each M-PSK
Lb = 1e5;                    % Total number of bits
Rs = 250e3;                  % Symbol rate (symbols per second)
Fc = 2.5e6;                  % Carrier frequency (Hz)
Fs = 10e6;                   % Sampling frequency (Hz)
Tsample = 1 / Fs;            % Sampling period (seconds)

% Prepare for power spectral densities
psd_8psk = [];
psd_16psk = [];
frequencies = [];

for M_idx = 1:2
    M = M_vals(M_idx);  % Get M (8 or 16)
    k = k_vals(M_idx);  % Get corresponding bits per symbol
    Tsym = 1 / Rs;      % Symbol period (seconds)
    Ns = Tsym / Tsample;  % Number of samples per symbol
    Ns = round(Ns);     % Ensure Ns is an integer

    % Adjust Lb to be a multiple of k
    if mod(Lb, k) ~= 0
        Lb_adjusted = floor(Lb / k) * k;
        Lb = Lb_adjusted;
    end
    
    Es = 1;                     % Symbol energy (normalized to 1)
    Eb = Es / k;                % Energy per bit

    % Display parameters for verification
    fprintf('Sampling Frequency Fs = %.2f MHz\n', Fs / 1e6);
    fprintf('Symbol Period Tsym = %.2f us\n', Tsym * 1e6);
    fprintf('Number of Samples per Symbol Ns = %d\n', Ns);

    %% Generate Binary Input Sequence
    bits = randi([0, 1], Lb, 1);

    %% Map Bits to Symbols (Gray Coding)
    bit_groups = reshape(bits, k, []).';  % Reshape bits into k-bit symbols
    binary_symbols = bi2de(bit_groups, 'left-msb');  % Convert to decimal symbols
    gray_symbols = bitxor(binary_symbols, floor(binary_symbols / 2));  % Gray code

    %% Generate Baseband Signal
    pulse_shape = sqrt(2 / Ns) * ones(1, Ns);  % Rectangular pulse with unit energy
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

    %% Modulate Baseband Signal onto Carrier (Corrected)
    t_total = (0:(num_symbols * Ns - 1)) * Tsample;  % Total time vector
    carrier_cos_total = cos(2 * pi * Fc * t_total);
    carrier_sin_total = sin(2 * pi * Fc * t_total);

    % Modulate onto carrier (corrected sign)
    s_t = I_baseband_total .* carrier_cos_total + Q_baseband_total .* carrier_sin_total;

    %% Power Spectral Density Calculation using pwelch
    [psd, f] = pwelch(s_t, [], [], [], Fs, 'twosided');  % Estimate the power spectrum
    psd_dB = 10*log10(psd);  % Convert to dB scale

    % Store PSD for plotting later, but ensure lengths match
    if isempty(frequencies)
        frequencies = f;  % Use the first frequency vector as reference
    else
        % Match lengths of PSDs by interpolation if needed
        if length(psd_dB) ~= length(frequencies)
            psd_dB = interp1(f, psd_dB, frequencies, 'linear', 'extrap');
        end
    end
    
    % Store PSD for respective modulation
    if M == 8
        psd_8psk = psd_dB;
    elseif M == 16
        psd_16psk = psd_dB;
    end
end

%% Plot both Power Spectra on the same graph
figure;
plot(frequencies / 1e6, psd_8psk, 'b-', 'LineWidth', 1.5); hold on;
plot(frequencies / 1e6, psd_16psk, 'r--', 'LineWidth', 1.5);
xlabel('Frequency (MHz)');
ylabel('Power/Frequency (dB/Hz)');
title('Power Spectral Density of 8-PSK and 16-PSK Signals');
legend('8-PSK', '16-PSK');
grid on;

%% Function for Gray to Binary Conversion (Kept Unchanged)
function binary_symbols = gray2binary(gray_symbols, k)
    gray_bits = de2bi(gray_symbols, k, 'left-msb');
    binary_bits = zeros(size(gray_bits));
    binary_bits(:,1) = gray_bits(:,1);
    for i = 2:k
        binary_bits(:,i) = xor(binary_bits(:,i-1), gray_bits(:,i));
    end
    binary_symbols = bi2de(binary_bits, 'left-msb');
end
