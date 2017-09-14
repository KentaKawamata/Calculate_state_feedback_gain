% samp1.m
% 200[Hz]�̐����g�M���ɐ��K���z���闐���̃f�[�^��t���������̂�������M���Ƃ�,���̐M���̃p���[�X�y�N�g�����v�Z

%bbclear all
Fs = 1000;
t = 0: 1/Fs: 1;
nt = length(t);
y = sin(2*pi*200*t) + randn(1, nt);

f = Fs*(0: nt-1)/(nt-1);
Py = 20*log10(abs(fft(y)));

%������M���ƃp���[�X�y�N�g���̃v���b�g
subplot(211), plot(t, y), title('Time Domain'), xlabel('Time[s]')
subplot(212), plot(f, Py), title('Freq Domain'), xlabel('Freq[Hz]')