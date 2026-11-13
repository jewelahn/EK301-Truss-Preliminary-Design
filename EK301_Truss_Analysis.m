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
% 4. Find values of unknown forces: F_m = e^-1(L), 
% 5. Find the maximum theoretical load, Critical member, and uncertainty
% F_b =(C*L^-2.012) +- U_fit, 
% F_crit = -F_b, 
% F_c = R_c x W_fail, 
% F_b / F_m = 1 for critical member
% F_m = R_m x W (R_m = F_m / W),
% 6. Write to output file

%% Task 2: Loading the .mat file
filename = "prelimDesign1.mat"; %Change this filename to whichever truss we are analyzing right now
load(filename);

%% Task 3: Constructing the matrices
% Pre-allocated their size for now.
e = zeros(2*j, M);

% Calculating the position matrix e. 
S = cat(1, S_x, S_y); % the last x columns of e_hat
e = cat(2, e, S);

[joint, member] = find(C == 1);

for i = 1:M % columns (members)
    joints = find(member == i); % joints corresponding to member
    joint1 = joint(joints(2));
    joint2 = joint(joints(1));

    % coordinates of each joint
    point1 = [X(joint1), Y(joint1)];
    point2 = [X(joint2), Y(joint2)];

    % distance calculations
    x_dist = point1(1) - point2(1);
    y_dist = point1(2) - point2(2);
    r = norm(point1 - point2);

    % inputting entries of e
    e(joint2, i) = x_dist / r;
    e(joint1, i) = -x_dist / r;
    e(joint2 + j, i) = y_dist / r;
    e(joint1 + j, i) = -y_dist / r;
end

%% Task 4: Find values of unknown forces: F_m = e^-1(L)
F_m = e \ L; % A\B is equivalent to inv(A) * B, and is faster

% Maximum Theoretical Load F_b

% lengths: a 13x1 column vector that holds the length of each member
lengths = zeros(M, 1);

for i = 1:M
    coords = find(C(:,i) == 1);
    dx = X(coords(2)) - X(coords(1));
    dy = Y(coords(2)) - Y(coords(1));
    lengths(i) = sqrt(dx^2 + dy^2); % Same equation for findng r_1_2 in the e^ matrix
end

F_b = zeros(M,1);
U_fit = 1.52;

for i = 1:M
    F_b(i) = 3391.3*(lengths(i)^-2.012) + U_fit;
end

%% Task 5: Finding the critical member and Max Load W_max
R_m = F_m(1:M) / abs(sum(L)); % using the sum of load forces as a token value of W to find values of R_m

% Find maximum supported weight
W_ref = abs(sum(L));% Reference applied load
compression = find(F_m(1:M) < 0);%Members in compression
W_max_members = F_b(compression) ./ abs(R_m(compression)); % Maximum weight each compressive member can support

% W_max is the smallest maximum weight
[W_max, criticalIndex] = min(W_max_members);

% Critical member is the member that corresponds with the smallest W_max
criticalMember = compression(criticalIndex);

fprintf('Maximum supported weight: %.2f oz\n', W_max);
fprintf('Critical member: %d\n', criticalMember);

% Finding Uncertainty
W_max_mat = W_max .* ones(length(compression), 1);
U_wmax_members = abs(W_max_mat ./ W_max_members) * U_fit; %U_wmax = (W_max / F_max) * U_f
U_wmax = U_wmax_members(criticalIndex);

percent_Uncertain = (abs(U_wmax - W_max)/W_max)*100;

%% Task 6: Writing to output
[filepath, name, ext] = fileparts(filename);
output_file = name + '.txt';
fileID = fopen(output_file, 'w');

fprintf(fileID, "EK301, Section A3, Group 9:\nJewel Ahn, Amanda Wong, Chris Lee, \nDate: 11/13/2026.\n\n");
fprintf(fileID,"Analysis of: %s \n\n",name);
fprintf(fileID, "Load: %.3f oz\n", W_ref);

% Printing member forces
fprintf(fileID, "Member forces in oz:\n");
for i = 1:M
    if int32(F_m(i)) == 0
        fprintf(fileID, "m%d: %.3f \n", i, abs(F_m(i)));
    elseif F_m(i) < 0
        fprintf(fileID, "m%d: %.3f (C)\n", i, abs(F_m(i)));
    else
        fprintf(fileID, "m%d: %.3f (T)\n", i, abs(F_m(i)));
    end
end

% Printing reaction forces
fprintf(fileID, "\nReaction forces in oz:\n");
num_Sx = find(S_x == 1);
num_Sy = find(S_y == 1);
Sx = length(num_Sx);
Sy = length(num_Sy);

for i = M + 1: M + Sx
    fprintf(fileID, "Sx%d: %.3f \n", i - M, F_m(i));
end

for i = M + Sx + 1: M + Sx + Sy
    fprintf(fileID, "Sy%d: %.3f \n", i - M, F_m(i));
end

% Printing cost
cost = abs(sum(lengths)) + 10*j;
fprintf(fileID, "\nCost of truss: $%.2f \n", cost);

% Printing theoretical max load / cost ratio

fprintf(fileID, "Theoretical max load / cost ratio in oz / $: %.4f \n", W_max / cost);

fclose(fileID);