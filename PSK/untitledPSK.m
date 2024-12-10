clc; clear; close all;

% Parameters
bp = 0.1; % Bit period
bit = [0 1 0 0 1 1 0 1]; % Binary information to transmit
disp('Binary information at transmitter:');
disp(bit);

% Representation of transmitting binary information as digital signal
bit_rate = 1 / bp;
n = 100; % Number of samples per bit
digit = []; % Digital signal initialization

for i = 1:length(bit)
    if bit(i) == 1
        se = ones(1, n); % High for bit 1
    else
        se = zeros(1, n); % Low for bit 0
    end
    digit = [digit se];
end

t1 = linspace(0, bp * length(bit), length(digit)); % Time vector for digital signal
figure('Position', [100, 100, 1000, 600]);

% Plot digital signal
subplot(3, 1, 1);
plot(t1, digit, 'g', 'LineWidth', 2.5); grid on;
axis([0 bp * length(bit) -0.5 1.5]);
ylabel('Amplitude');
xlabel('Time (sec)');
title('Transmitting Information as Digital Signal');

% Binary PSK Modulation
f = bit_rate * 10; % Carrier frequency
t2 = linspace(0, bp, n); % Time vector for one bit period
x = []; % Modulated signal initialization

for i = 1:length(bit)
    if bit(i) == 1
        y = cos(2 * pi * f * t2); % Carrier for bit 1
    else
        y = cos(2 * pi * f * t2 + pi); % Carrier for bit 0 (180° phase shift)
    end
    x = [x y];
end

t3 = linspace(0, bp * length(bit), length(x)); % Time vector for modulated signal
subplot(3, 1, 2);
plot(t3, x, 'b', 'LineWidth', 2.5); grid on;
xlabel('Time (sec)');
ylabel('Amplitude');
title('PSK Modulated Signal');

% Binary PSK Demodulation
demodulated_bit = []; % Demodulated binary sequence
for i = 1:length(bit)
    % Extract each bit duration segment from the modulated signal
    segment = x((i-1)*n + 1:i*n);
    
    % Correlation with the reference carrier (0° phase)
    corr = sum(segment .* cos(2 * pi * f * t2));
    
    % Decision: if correlation is positive, it's bit 1; else bit 0
    if corr > 0
        demodulated_bit = [demodulated_bit 1];
    else
        demodulated_bit = [demodulated_bit 0];
    end
end

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
plot(t1, demodulated_signal, 'r', 'LineWidth', 2.5); grid on;
axis([0 bp * length(bit) -0.5 1.5]);
ylabel('Amplitude');
xlabel('Time (sec)');
title('Demodulated Signal');

% Enhanced zoom for PSK visualization
figure('Position', [100, 100, 800, 400]);
zoom_range = 1:n*3; % Focus on the first 3 bits
plot(t3(zoom_range), x(zoom_range), 'b', 'LineWidth', 2.5); grid on;
xlabel('Time (sec)');
ylabel('Amplitude');
title('Zoomed-In View of PSK Modulated Signal');
