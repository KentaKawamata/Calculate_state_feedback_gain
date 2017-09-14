m     = 0.030;               %振子の重さ[kg]
M     = 0.675;               %台車の重さ[kg]
l     = 0.15;                 %振子の長さ[m]
d     = 0.09;                %重心から回転軸までの長さ[m]
Ig    = (m*l^2)/3;          %重心を軸とする慣性モーメント[Nm]
Id    = Ig + m*d*d;            %回転軸を中心とする慣性モーメント[Nm]
wheel = 0.051/2;              %車輪の半径[m]
G     = 6.67;               %減速比
Omax  = 261.05814;               %モータの最大角速度[rad/s]  (3750/60)*2PI = 523.5988
Tmax  = 0.015;             %モータの最大トルク[Nm] 0.2713 0.015
g     = 9.81;               %重力[m/s^2]

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
state = ss(A, B, C, D);                                             %状態空間表現の形に
%display(state);                                                     %コマンドウインドウに式表示
%step(state); %ステップ入力の応答グラフ表示
[b, a] = ss2tf(A, B, C, D);
T = tf(b, a);
nyquist(T);
%margin(T);
%initial(state, x0); 