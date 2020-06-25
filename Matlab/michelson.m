%{
    Nikita Vetter - Michelson Interferometer (Modell)
%}

close all;
clear all;
clc; 
%% Deklarationen
syms t;          ...Zeit
syms A_1 A_2...  ...Amplitude (=1)
     z_1 z_2...  ...geometrische Weglänge
     w...        ...Kreisfrequenz
     k...        ...Perioditätszahl
     wellenlaenge...
     c...        ...Lichtgeschwindigkeit
     TV...       ...Tranmissionsvermögen
     s...        ...Probenlaenge
     n;          ...Brechungsindex
%% Definitionen
    c = 299792458; 
    wellenlaenge = 450*10^(-9); 
    k = 2*pi/wellenlaenge;
    R = 0.5; 
    TV = 0.5;
    w = c*k;
    z_1 = 1; 
    z_2 = 1.34;
    A_1 = 1; 
    A_2 = 1; 
    T = wellenlaenge/c;     
    s = 0.02;
    phi(n) = s*(n-1)*2*pi/wellenlaenge;
%% Wellen
    E_1(t,n) = R*TV*exp(1i*((k*(z_1))+w*t+phi(n)))+R*TV*exp(-1i*(k*(z_1)+w*t+phi(n)));
    E_2(t,n) = R*TV*exp(1i*((k*(z_2))+w*t))+R*TV*exp(-1i*(k*(z_2)+w*t)); 
%% Interferenz
    E_ges(t,n) = E_1(t,n)+E_2(t,n);
%% Intensität 
    I(t,n) = E_ges(t,n)^2;     ... zeitliche Intensität 
    I_mw(n) = int(I(t,n),0,T); ... mittlere  Intensität
%% Plot 
    x = [1.4:0.000001:1.40005];
    plot(x,I_mw(x));
    xlabel('Brechungsindex n');
    ylabel('relative Intensität');
    title('Intensität der interferierenden Wellen bei Änderung des Brechungsindexes');
%% Zusatz Plotten der EM-Welle 
%t = [0:T*0.005:T*1];
%plot(t,E_1(t),t,E_2(t),t,E_ges(t));
%legend('E_1','E_2','E_ges','Location','NorthEastOutside')
%plot(t,I(t));
%int(I,t,T);




