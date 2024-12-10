% MATLAB code for binary FSK modulation and demodulation
clear all; close all; clc;

bp = 0.1; % Bit period
bit = [0 1 0 0 1 1 0 1 ]; % Binary information to transmit
disp('Binary information at transmitter:');
disp(bit);

% Representation of transmitting binary information as a digital signal
bit_rate = 1 / bp;
n = 100; % Number of samples per bit
digit = []; % Digital signal initialization

for i = 1:length(bit)
    if bit(i) == 1
        se = ones(1, n); % Set high for bit 1
    else
        se = zeros(1, n); % Set low for bit 0
    end
    digit = [digit se];
end

t1 = bp / 100 : bp / 100 : 100 * length(bit) * (bp / 100);
subplot(3, 1, 1);
plot(t1, digit, 'LineWidth', 2.5); grid on;
axis([0 bp * length(bit) -0.5 1.5]);
ylabel('Amplitude');
xlabel('Time (sec)');
title('Transmitting information as digital signal');

% Binary FSK Modulation
f1 = bit_rate * 10; % Frequency for binary 1
f2 = bit_rate * 5;  % Frequency for binary 0
t2 = bp / 99 : bp / 99 : bp;
x = []; % Modulated signal initialization

for i = 1:length(bit)
    if bit(i) == 1
        y = cos(2 * pi * f1 * t2); % Carrier for bit 1
    else
        y = cos(2 * pi * f2 * t2); % Carrier for bit 0
    end
    x = [x y];
end

t3 = bp / 99 : bp / 99 : bp * length(bit);
subplot(3, 1, 2);
plot(t3, x, 'LineWidth', 2.5); grid on;
xlabel('Time (sec)');
ylabel('Amplitude');
title('FSK Modulated Signal');

% Binary FSK Demodulation
demodulated_bit = []; % Demodulated binary sequence
for i = 1:length(bit)
    % Extract each bit duration segment from the modulated signal
    segment = x((i-1)*length(t2)+1:i*length(t2));
    
    % Correlation with each carrier frequency
    corr_f1 = sum(segment .* cos(2 * pi * f1 * t2)); % Correlation with f1
    corr_f2 = sum(segment .* cos(2 * pi * f2 * t2)); % Correlation with f2
    
    % Decision: if correlation with f1 is higher, it's bit 1; else bit 0
    if corr_f1 > corr_f2
        demodulated_bit = [demodulated_bit 1];
    else
        demodulated_bit = [demodulated_bit 0];
    end
end

% Plotting demodulated signal
disp('Demodulated binary information at receiver:');
disp(demodulated_bit);

% Digital representation of demodulated data
demodulated_signal = [];
for i = 1:length(demodulated_bit)
    if demodulated_bit(i) == 1
        se = ones(1, n); % High for bit 1
    else
        se = zeros(1, n); % Low for bit 0
    end
    demodulated_signal = [demodulated_signal se];
end

subplot(3, 1, 3);
plot(t1, demodulated_signal, 'LineWidth', 2.5); grid on;
axis([0 bp * length(bit) -0.5 1.5]);
ylabel('Amplitude');
xlabel('Time (sec)');
title('Demodulated Signal');
