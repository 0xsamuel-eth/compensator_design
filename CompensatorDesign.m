%% Sam Masten, Jeffrey Whitenack, Dean Bui
%  MAE435
%  Compensator Design Project

%% Given Values

J = 1; %Nms^2/rad
b = 20; %kgs/m
R = 1; %ohms
K_m = 5; %Nm/A
L = 0.001; %H

%% Uncompensated Design

%G
numG = [5]; 
denG = conv([1 20 0],[0.001 1]);
G = tf(numG,denG);

rlocus(G)

%% Compensator Design

%Given Values
t_s = 0.03; %s
Mp = 0.05;
e_ss = 0;

%Calculate damping ratio
syms damp
assume(damp,'real')
damp = double(vpasolve(Mp == exp( (-pi*damp) / sqrt(1-(damp^2)) ),damp,[0,1]));

%Calculate natural frequency
w_n = 4.0 / (t_s*damp);

%Calculate sigma
sigma = damp*w_n;

%Calculate w_d
w_d = w_n * sqrt(1-(damp^2));

%% TF Without Disturbance
%% Initial Compensator Design

%G
numG = [5]; 
denG = conv([1 20 0],[0.001 1]);
G = tf(numG,denG);

%Gc
numGc = conv([7.948e8],[1 127.76]);
denGc = [1 18347.81];
Gc = tf(numGc,denGc);

%Closed Loop TF
G_cl = G * Gc;

%Plot step response
figure(1)
step(feedback(G_cl,1));

%% Second Compensator Design

%% K = 1000
%G
numG = [5]; 
denG = conv([1 20 0],[0.001 1]);
G = tf(numG,denG);

%Gc
numGc = conv([1000],[1 20]);
denGc = [1 732.4];
Gc = tf(numGc,denGc);

%Closed Loop TF
G_cl = G * Gc;

%Plot step response
figure(1)
step(feedback(G_cl,1));

%% K = 100,000
%G
numG = [5]; 
denG = conv([1 20 0],[0.001 1]);
G = tf(numG,denG);

%Gc
numGc = conv([100000],[1 20]);
denGc = [1 732.4];
Gc = tf(numGc,denGc);

%Closed Loop TF
G_cl = G * Gc;

%Plot step response
figure(1)
step(feedback(G_cl,1));

%% K = 15,000

%G
numG = [5]; 
denG = conv([1 20 0],[0.001 1]);
G = tf(numG,denG);

%Gc
numGc = conv([15000],[1 20]);
denGc = [1 732.4];
Gc = tf(numGc,denGc);

%Closed Loop TF
G_cl = G * Gc;

%Plot step response
figure(1)
step(feedback(G_cl,1));

%% K= 30,000

%G
numG = [5]; 
denG = conv([1 20 0],[0.001 1]);
G = tf(numG,denG);

%Gc
numGc = conv([30000],[1 20]);
denGc = [1 732.4];
Gc = tf(numGc,denGc);

%Closed Loop TF
G_cl = G * Gc;

%Plot step response
figure(1)
step(feedback(G_cl,1));

%% TF With Disturbance

%H1
numH1 = [1]; 
denH1 = [1 20 0];
H1 = tf(numH1,denH1);

%H2
numH2 = [5]; 
denH2 = conv([1 20 0],[0.001 1]);
H2 = tf(numH2,denH2);

%Gc
numGc = conv([30000],[1 20]);
denGc = [1 732];
Gc = tf(numGc,denGc);

%Closed Loop TF
G_cl = H1 / (1 + Gc*H2);

%Plot step response
figure(1)
step(feedback(G_cl,1));

