clc;
clear;

% Parameters
t = 0:1:26;  % Time vector (discrete steps) adjusted to 27 elements
analog_signal = [2 1.8 1.4 0.8 0.3 -0.2 -0.7 -1.1 -1.4 -1.5 -1.6 -1.5 -1.2 -0.8 ...
                 -0.3 0.2 0.6 0.9 1.1 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2]; % Sampled analog signal (27 elements)
initial_delta = 0.1; % Small initial step size for better accuracy

% Initialize variables
dm_signal = zeros(size(t));  % Delta modulated signal
reconstructed_signal = zeros(size(t));  % Reconstructed signal
transmitted_bits = zeros(size(t));  % Store transmitted bits

% Initial conditions
dm_signal(1) = analog_signal(1);  % Start delta modulated signal from the first value of analog_signal
reconstructed_signal(1) = dm_signal(1);  % Initialize reconstructed signal

% Delta Modulation Process to closely match analog_signal
for i = 2:length(t)
    % Calculate the difference between the current analog value and the previous dm_signal value
    diff = analog_signal(i) - dm_signal(i-1);
    
    % Adjust delta dynamically based on the difference to allow precise following
    delta = abs(diff) * 0.9;  % Scale delta to be close to diff without overshooting
    
    % Move the dm_signal in the direction of analog_signal
    if diff > 0
        dm_signal(i) = dm_signal(i-1) + delta;  % Move up by the adjusted delta
        transmitted_bits(i) = 1;  % Transmit bit '1'
    else
        dm_signal(i) = dm_signal(i-1) - delta;  % Move down by the adjusted delta
        transmitted_bits(i) = -1;  % Transmit bit '0' as -1 to show below the axis
    end
    
    % Update the reconstructed signal
    reconstructed_signal(i) = dm_signal(i);  
end

% Plotting
figure;

% Plot Sampling Function
subplot(3, 1, 1);
stem(t, ones(size(t)), 'filled', 'MarkerFaceColor', 'k');
title('Sampling Function');
ylabel('V_p(t)');
ylim([-0.5 1.5]);
xticks(0:26);
grid on;

% Plot Analog Signal and Reconstructed Signal in the same subplot
subplot(3, 1, 2);
plot(t, analog_signal, 'LineWidth', 1.5, 'Color', 'b'); % Original analog signal in blue
hold on;
stairs(t, reconstructed_signal, 'LineWidth', 1.5, 'Color', 'r'); % Reconstructed signal in red closely matching analog signal
hold off;
title('Analog Signal and Reconstructed Signal');
ylabel('Voltage');
xlabel('t (TIME)');
xticks(0:26);
legend('Analog Signal', 'Reconstructed Signal');
grid on;

% Plot Transmitted Bits with bits shown below the axis for '0'
subplot(3, 1, 3);
stem(t, transmitted_bits, 'filled', 'MarkerFaceColor', 'k');
title('Transmitted Bits');
ylabel('V_{out}(t)');
xlabel('t (TIME)');
ylim([-1.5 1.5]);
xticks(0:26);
grid on;
