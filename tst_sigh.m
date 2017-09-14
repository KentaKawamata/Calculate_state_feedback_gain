% samp1.m
% 200[Hz]の正弦波信号に正規分布する乱数のデータを付加したものを時刻歴信号とし,この信号のパワースペクトルを計算

%bbclear all
Fs = 1000;
t = 0: 1/Fs: 1;
nt = length(t);
y = sin(2*pi*200*t) + randn(1, nt);

f = Fs*(0: nt-1)/(nt-1);
Py = 20*log10(abs(fft(y)));

%時刻歴信号とパワースペクトルのプロット
subplot(211), plot(t, y), title('Time Domain'), xlabel('Time[s]')
subplot(212), plot(f, Py), title('Freq Domain'), xlabel('Freq[Hz]')