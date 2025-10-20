function [snrdB,ptotdB,psigdB,pnoisedB] = calcSNRdef(vout,f,fB,w,N)
% SNR calculation in the time domain (P. Malcovati, S. Brigati)
% function [snrdB,ptotdB,psigdB,pnoisedB] = calcSNR(vout,f,fB,w,N)
% vout: Sigma-Delta bit-stream taken at the modulator output
% f:    Normalized signal frequency (fs -> 1)
% fB:	Base-band frequency bins
% w:	windowing vector
% N:    samples number
%
% snrdB:     SNR in dB
% ptotdB:    Bit-stream power spectral density (vector)
% psigdB:    Extracted signal power spectral density (vector)
% pnoisedB:  Noise power spectral density (vector)
%
fB=ceil(fB);
signal=(N/sum(w))*sinusx(vout(1:N).*w,f,N);	% Extracts sinusoidal signal
noise=vout(1:N)-signal;                     % Extracts noise components  
stot=((abs(fft((vout(1:N).*w)'))).^2);		% Bit-stream PSD
ssignal=(abs(fft((signal(1:N).*w)'))).^2;	% Signal PSD
snoise=(abs(fft((noise(1:N).*w)'))).^2;     % Noise PSD
pwsignal=sum(ssignal(4:fB));	            % Signal power
pwnoise=sum(snoise(4:fB));                  % Noise power
snr=pwsignal/pwnoise;
snrdB=dbp(snr);
norm=sum(stot)/sum(vout(1:N).^2)*N							% PSD normalization
if nargout > 1
	ptot=stot/norm;
	ptotdB=dbp(ptot);
end

if nargout > 2
	psig=ssignal/norm;
	psigdB=dbp(psig);
end

if nargout > 3
	pnoise=snoise/norm;
	pnoisedB=dbp(pnoise);
end
