% MATLAB code for binary ASK modulation and demodulation
clear all; close all; clc;

bp = 0.1; % Bit period
bit = [0 1 0 0 1 1 0 1 ]; % Binary information to transmit
disp('Binary information at transmitter:');
disp(bit);
% Representation of transmitting binary information as digital signal
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

% Binary ASK Modulation
A1 = 5; % Amplitude of carrier signal for bit 1
A2 = 0; % Amplitude of carrier signal for bit 0
f = bit_rate * 10; % Carrier frequency

t2 = bp / 99 : bp / 99 : bp;
x = []; % Modulated signal initialization

for i = 1:length(bit)
    if bit(i) == 1
        y = A1 * cos(2 * pi * f * t2); % Carrier for bit 1
    else
        y = A2 * cos(2 * pi * f * t2); % Carrier for bit 0
    end
    x = [x y];
end

t3 = bp / 99 : bp / 99 : bp * length(bit);
subplot(3, 1, 2);
plot(t3, x, 'LineWidth', 2.5); grid on;
xlabel('Time (sec)');
ylabel('Amplitude (volt)');
title('ASK Modulated Signal');

% Binary ASK Demodulation
demodulated_bit = []; % Demodulated binary sequence
for i = 1:length(bit)
    % Extract each bit duration segment from the modulated signal
    segment = x((i-1)*length(t2)+1:i*length(t2));
    
    % Calculate the mean amplitude of the segment
    mean_amplitude = mean(abs(segment));
    
    % Decision threshold: if mean amplitude is closer to A1, it's bit 1; else bit 0
    if mean_amplitude > A1 / 2
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