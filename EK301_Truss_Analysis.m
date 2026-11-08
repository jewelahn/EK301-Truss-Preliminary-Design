%% Truss Analysis Code, EK301
% Group Members: Chris, Jewel, Amanda

%% Code Split Tasks

% Tasks
% 1. Make matrices for calculations: connection matrix, x- and y- support
% forces, joint location vectors, applied external load vector - jewel
% 2. Set input variables: number of joints, members, support forces,
% coordinates of joints, load forces - jewel
% 3. Calculate the unit vector: (# of x- and y-components)x(# of members +
% # of unknown support forces), calculate using the connection matrix (jewel will get started ig)
% 4. Find values of unknown forces: F = e^-1(L)
% 5. Find maximum theoretical load and uncertainty: F_b =
% (C*L^-2.012)+-U_fit, F_m = R_m x W (R_m = F_m / W), F_crit = -F_b, F_c =
% R_c x W_fail, F_b / F_m = 1 for critical member 

%% Loading the .mat file
filename = "practiceTruss.mat";
load(filename);

%% 2.4.2 Constructing the matrices
%Pre-alloacted their size for now.
e = zeros(2*j, M+x);
F = zeros(M+x,1);

%Section 2.4.2: Calculating the position matrix e. 

