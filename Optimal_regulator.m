m     = 0.030;               %�U�q�̏d��[kg]
M     = 0.695;               %��Ԃ̏d��[kg]
l     = 0.15;                 %�U�q�̒���[m]
d     = 0.09;                %�d�S�����]���܂ł̒���[m]
Ig    = (m*l^2)/3;          %�d�S�����Ƃ��銵�����[�����g[Nm]
Id    = Ig + m*d*d;            %��]���𒆐S�Ƃ��銵�����[�����g[Nm]
wheel = 0.025;              %�ԗւ̔��a[m]
G     = 80/12;               %������
Omax  = 231;               %���[�^�̍ő�p���x[rad/s]  (3750/60)*2PI = 523.5988
Tmax  = 0.015;             %���[�^�̍ő�g���N[Nm] 0.2713 0.015
g     = 9.81;               %�d��

x0 = [0 0 2 0];             %��������

f0 = (Tmax*G)/wheel;
f1 = -(Tmax*G^3)/(Omax*wheel^2);
p = Ig*(M+m)+M*m*d^2;         %denominator for the A and B matrices

A = [0      1              0           0;
     0 (Ig+m*d^2)*f1/p  -(m^2*g*d^2)/p   0;
     0      0              0           1;
     0 -(m*d)*f1/p       m*g*d*(M+m)/p  0];

 B = [     0;
     (Ig+m*d^2)*f0/p;
          0;
        -m*d*f0/p];

C = [1 0 0 0;
     0 0 1 0];

D = [0;
     0];

Q = [100 0 0 0 ; 0 5 0 0 ; 0 0 500 0 ; 0 0 0 2];            %�œK���M�����[�^�̏d��Q �����̑����Ɋ֌W
R = 10;                                                            %�œK���M�����[�^�̏d��R ������͂̑傫���Ɋ֌W

%P = care(A, B, Q, R);                                               %���J�b�`�������̎��ԉ�
%K =  R\B'*P;                                                        %(1/R)*B�̓]�u*P  �t�B�[�h�o�b�N�Q�C���̓��o     
%disp(K);
[K, S, e] = lqr(A, B, Q, R);
disp('feedback gain =');
disp(K);

A = A - B*K;
state = ss(A, B, C, D);                                           %��ԋ�ԕ\���̌`��
%display(state);                                                     %�R�}���h�E�C���h�E�Ɏ��\��
%step(state);                                                     %�X�e�b�v���͂̉����O���t�\��
initial(state, x0); 

