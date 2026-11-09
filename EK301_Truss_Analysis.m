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
% 4. Find values of unknown forces: F_m = e^-1(L)
% 5. Find maximum theoretical load and Critical member
% F_b =(C*L^-2.012) +- U_fit, 
% F_crit = -F_b, F_c = R_c x W_fail, F_b / F_m = 1 for critical member 
% 6. Find uncertainty:
% F_m = R_m x W (R_m = F_m / W),

%% Task 2: Loading the .mat file
filename = "practiceTruss.mat";
load(filename);

%% Task 3: Constructing the matrices
% Pre-allocated their size for now.
e = zeros(2*j, M);

% Calculating the position matrix e. 
S = cat(1, S_x, S_y); % the last x columns of e_hat

for i = 1:M % columns
    for l = 1:2*j % rows
        %Horizontal unit vectors (in rows 1 to j)
        if l <= j && C(l, i) == 1
            coords = find(C(:, i) == 1);
            point1 = [X(l), Y(l)];
            point2 = [X(coords(2)), Y(coords(2))];
            dx = point2(1,1)-point1(1,1);
            dy = point2(1,2)-point1(1,2);
            r_1_2 = sqrt(dx^2 + dy^2);
            if r_1_2 ~= 0
                e(l,i) = dx/r_1_2; %only add this value if the position vector isn't 0
                e(coords(2), i) = -dx/r_1_2; %Opposite unit vector components at the 2nd joint 
            end %Otherwise, it would be 0, and we prefilled e with 0. 
            
            %Now e^hat magntiude is not 1 for trusses where length!=width
            %and is negative when position vector dif_x is negative. 
        %Vertical unit vectors (in rows j+1 to 2j)
        elseif l > j && C(l-j, i) == 1 
            coords = find(C(:, i) == 1);
            point1 = [X(l-j), Y(l-j)];
            point2 = [X(coords(2)), Y(coords(2))];
            dx = point2(1,1)-point1(1,1);
            dy = point2(1,2)-point1(1,2);
            r_1_2 = sqrt(dx^2 + dy^2);
            if r_1_2 ~= 0
                e(l,i) = dy/r_1_2;
                e(j+coords(2), i) = -dy/r_1_2;
            end
        end
    end
end

e_hat = cat(2, e, S);

%% Task 4: Find values of unknown forces: F_m = e^-1(L)
F_m = e_hat \ L; % A\B is equivalent to inv(A) * B, and is faster

%% Task 5: Maximum Theoretical Load F_b

%lengths: a 13x1 column vector that holds the length of each member
lengths = zeros(M,1);

for i = 1:M
    coords = find(C(:,i) == 1);
    dx = X(coords(2)) - X(coords(1));
    dy = Y(coords(2)) - Y(coords(1));
    lengths(i) = sqrt(dx^2 + dy^2); %Same equation for finidng r_1_2 in the e^ matrix
end

F_b = zeros(M,1);
U_fit = 1.52;

for i = 1:M
    F_b(i) = 3391.3*(lengths(i)^-2.012) + U_fit;
end

%% Finding the critical member and Max Load W_max
R_m = F_m(1:M) / abs(sum(L)); %using the sum of load forces as a token value of W to find values of R_m

%Find maximum supported weight
W_ref = sum(abs(L));% Reference applied load

% Find members in compression
compression = find(F_m(1:M) < 0);

% Maximum weight each compressive member can support
W_max_members = F_b(compression) ./ abs(R_m(compression));

% Find the smallest maximum weight
[W_max, criticalIndex] = min(W_max_members);

% Identify the critical member
criticalMember = compression(criticalIndex);

fprintf('Maximum supported weight: %.2f N\n', W_max);
fprintf('Critical member: %d\n', criticalMember);

