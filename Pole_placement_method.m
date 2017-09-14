m     = 0.030;               %�U�q�̏d��[kg]
M     = 0.675;               %��Ԃ̏d��[kg]
l     = 0.15;                 %�U�q�̒���[m]
d     = 0.09;                %�d�S�����]���܂ł̒���[m]
Ig    = (m*l^2)/3;          %�d�S�����Ƃ��銵�����[�����g[Nm]
Id    = Ig + m*d*d;            %��]���𒆐S�Ƃ��銵�����[�����g[Nm]
wheel = 0.051/2;              %�ԗւ̔��a[m]
G     = 6.67;               %������
Omax  = 261.05814;               %���[�^�̍ő�p���x[rad/s]  (3750/60)*2PI = 523.5988
Tmax  = 0.015;             %���[�^�̍ő�g���N[Nm] 0.2713 0.015
g     = 9.81;               %�d��[m/s^2]

x0 = [0 0 12 2];

f0 = (Tmax*G)/wheel;
f1 = -(Tmax*G^3)/(Omax*wheel^2);
p = Ig*(M+m)+M*m*l^2;         %denominator for the A and B matrices

A = [0      1              0           0;
     0 (Ig+m*l^2)*f1/p  -(m^2*g*l^2)/p   0;
     0      0              0           1;
     0 -(m*l)*f1/p       m*g*l*(M+m)/p  0];
 
 B = [     0;
     (Ig+m*l^2)*f0/p;
          0;
       -m*l*f0/p];
    
C = [0 0 1 0];
 
D = 0;
 
[b, a] = ss2tf(A, B, C, D);
T = tf(b, a);

display(T);

%rlocus(T);
%nyquist(T);

p = [-3.99 -2.95 -3.81 -4.76];
K = place(A, B, p);
disp(K);

A = A - B*K;
state = ss(A, B, C, D);                                             %��ԋ�ԕ\���̌`��
%display(state);                                                     %�R�}���h�E�C���h�E�Ɏ��\��
%step(state); %�X�e�b�v���͂̉����O���t�\��
[b, a] = ss2tf(A, B, C, D);
T = tf(b, a);
nyquist(T);
%margin(T);
%initial(state, x0); 