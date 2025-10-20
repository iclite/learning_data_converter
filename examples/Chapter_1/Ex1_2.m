%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Example 1.2                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
%-------------------------------------------------------------------------%
%                                                                         %
%                              Input values                               %
%                                                                         %
%-------------------------------------------------------------------------%

sampl_freq=100e6;            % clock frequency
input_freq=20e6;             % signal frequency
SNR=80;
ampl=1;                      % signal amplitude (full scale)
perc=20;                     % percentuage of noise due to jitter

%-------------------------------------------------------------------------%
%                                                                         %
%                          Outputs                                        %
%                                                                         %
%-------------------------------------------------------------------------%

noise_power=ampl^2/(2*10^(SNR/10))                    % total noise power 
jitter_power=noise_power*perc/100                     % jitter noise power
time_jitter=(jitter_power/(2*pi*input_freq)^2)^0.5    
norm_freq=[0:0.025:1.0];         
vn_square=(100-perc)/100*noise_power+jitter_power*(norm_freq*sampl_freq/...
    input_freq).^2;
SNR=10*log10(ampl^2/2) -10*(log10(vn_square));        % Eq. (1.8) page 14

%---------------------------Graphics--------------------------------------%
%                                                                         %
%    figure(1) --> Fig 1.13 page 15                                       %
%                                                                         %
%-------------------------------------------------------------------------%
figure(1);
plot(norm_freq,SNR)
grid
XLABEL('Normalized input frequency, f/f_C_K')
YLABEL('snr [dB]')
title('SNR degradation caused by the jitter noise')


