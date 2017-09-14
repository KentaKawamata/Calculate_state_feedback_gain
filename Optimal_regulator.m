m     = 0.030;               %振子の重さ[kg]
M     = 0.695;               %台車の重さ[kg]
l     = 0.15;                 %振子の長さ[m]
d     = 0.09;                %重心から回転軸までの長さ[m]
Ig    = (m*l^2)/3;          %重心を軸とする慣性モーメント[Nm]
Id    = Ig + m*d*d;            %回転軸を中心とする慣性モーメント[Nm]
wheel = 0.025;              %車輪の半径[m]
G     = 80/12;               %減速比
Omax  = 231;               %モータの最大角速度[rad/s]  (3750/60)*2PI = 523.5988
Tmax  = 0.015;             %モータの最大トルク[Nm] 0.2713 0.015
g     = 9.81;               %重力

x0 = [0 0 2 0];             %初期条件

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

Q = [100 0 0 0 ; 0 5 0 0 ; 0 0 500 0 ; 0 0 0 2];            %最適レギュレータの重みQ 収束の速さに関係
R = 10;                                                            %最適レギュレータの重みR 制御入力の大きさに関係

%P = care(A, B, Q, R);                                               %リカッチ方程式の時間解
%K =  R\B'*P;                                                        %(1/R)*Bの転置*P  フィードバックゲインの導出     
%disp(K);
[K, S, e] = lqr(A, B, Q, R);
disp('feedback gain =');
disp(K);

A = A - B*K;
state = ss(A, B, C, D);                                           %状態空間表現の形に
%display(state);                                                     %コマンドウインドウに式表示
%step(state);                                                     %ステップ入力の応答グラフ表示
initial(state, x0); 

