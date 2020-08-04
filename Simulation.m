%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Nikita Vetter
%   Bachelorarbeit
%   Simulation des MZ-Interferometer
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Löschen des Speichers
clear all;
close all;
clc; 

%% Festlegen der Variablen
syms t R T A_0 k kreisfrequenz l_mp l_op l_d l_p n_Ende n_Anfang zeitdauer poly_zeit;

%% !!!!!!!!!!!! Hautpfunktionen !!!!!!!!!!!!!!!!!
z_mp(t) = l_d-2*l_p+2*l_mp+2*l_p*((n_Ende-n_Anfang)*poly_zeit*t+n_Anfang); ... Lineare Funktion für zeitabhängigen Brechungsindex
%z_mp(t) = k*(2*l_op+l_d);
E_op(t) = sqrt(R*T)*A_0*(exp(1i*(k*(2*l_op+l_d)+kreisfrequenz*t))+exp(-1i*(k*(2*l_op+l_d)+kreisfrequenz*t))); ... ohne Probe
E_mp(t) = sqrt(R*T)*A_0*(exp(1i*(k*z_mp(t)+kreisfrequenz*t))+exp(-1i*(k*z_mp(t)+kreisfrequenz*t)));
Intensitaet(t) = simplify((E_op(t)+E_mp(t))^2); 

%I_mw(a,b) = int(Intens,t,a,b); ... Mittelwert 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ========= Parameter Strahlengang =============

%% Strahlenweg ohne Probe (Von BS zu 
l_op = 0.1; ... Länge Strahlengang [m]

%% Strahlengang mit Probe 
l_mp = 0.1;  ... Länge Strahlengang [m]
l_p  = 0.01; ... Probenlänge [m]

%% Strahlengang Detektor 
l_d  = 0.05; ... Länge Strahlengang

%% Strahlteiler 
R = 0.5; ... Reflexionsanteil
T = 0.5; ... Translationsanteil 

%% ============== Lichtquelle ===================
wellenlaenge = (605*10^(-9));  ... Wellenlänge des Laser [nm]
c = 299792458;                 ... Lichtgeschwindigkeit [m/s]
A_0 = 1;                       ... Amplitude

%% ========= Physikalische Beziehungen ==========
k = 2*pi/wellenlaenge;              ... Perioditätszahl
kreisfrequenz = 2*pi*c/wellenlaenge;... reisfrequenz
frequenz = c/wellenlaenge;          ... Frequenz
periodendauer = 1/frequenz;         ... Periodendauer


%% ========== Polymerisationsparameter ==========
poly_zeit = 10;       ... Dauer für Polymerisationzeit
n_Anfang  = 1.2;      ... Startbrechungsindex (t=0)             
n_Ende    = 1.4;      ... Endbrechungsindex   (t=zeitdauer)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% XXXXXXXXX Plot der Welle ohne Probe XXXXXXXXXX
% Auskommentiert
% C= 0:(1*10^(-16)):(1*10^(-14))
% plot(C,eval(E_op(C)))
% C= 0:(1*10^(-16)):(1*10^(-14))
% plot(C,eval(E_mp(C)))
%C= (9500000000*10^(-14)):(1*10^(-17)):(9500000000.4*10^(-14))
%plot(C,eval(((E_mp(C)+E_op(C)))),C,eval(E_mp(C)),C,eval(E_op(C)))

Frage = input('Bitte wähle (1) für zeitliche Mittelwertbildung und (2) für brechungsindex bestimmte Mittelwertbildung','s');

if (Frage == '1')
%% ======== zeitliche Mittelwertbildung =========

syms a b; ... unbestimmte Integralgrenzen a(oben) b(unten)
Mittelwert_unbestimmt(a,b) = 1/(b-a)*simplify(eval(int(Intensitaet(t),t,a,b))); ... unbestimmtes Integral
Messfrequenz = 1000000;
Zeitwerte = 0:1/Messfrequenz:0.01;
Mittelwerte_bestimmt = double(Mittelwert_unbestimmt(Zeitwerte,Zeitwerte+1/Messfrequenz));
x = 1:1:100
plot(Mittelwerte_bestimmt)  

elseif(Frage == '2')
%% == Mittelwertbildung mittels Brechungsindex ==

end


