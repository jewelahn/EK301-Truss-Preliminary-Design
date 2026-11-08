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
% Pre-allocated their size for now.
e = zeros(2*j, M);
F = zeros(M+x,1);

% Calculating the position matrix e. 
S = cat(1, S_x, S_y); % the last x columns of e_hat

for i = 1:M % columns
    for l = 1:2*j % rows
        if l <= j && C(l, i) == 1
            coords = find(C(:, i) == 1);
            point1 = [X(l), Y(l)];
            point2 = [X(coords(2)), Y(coords(2))];
            e(l, i) = 1;
        elseif l > j && C(l-j, i) == 1 
            e(l, i) = 1;
        end
    end
end

e_hat = cat(2, e, S);