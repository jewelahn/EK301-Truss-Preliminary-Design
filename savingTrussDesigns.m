%% Saving Truss Designs

%% Practice Problem truss
j = 8;
x = 3; %x=number of support forces.
M = 2*j - x; %M is the total number of member forces


C = [1 1 0 0 0 0 0 0 0 0 0 0 0;
     0 1 1 1 0 0 0 0 0 0 0 0 0;
     0 0 0 1 1 1 0 0 0 0 0 0 0;
     1 0 1 0 1 0 1 1 0 0 0 0 0;
     0 0 0 0 0 1 1 0 1 1 0 0 0;
     0 0 0 0 0 0 0 0 0 1 1 1 0;
     0 0 0 0 0 0 0 0 0 0 0 1 1];

%Support forces: S1 = Ax, S2 = Ay, S3 = Hy
%S_x are the hozitonal support forces, only 1st column(S1=Ax) is a horizontal force
S_x = zeros(j,x); 
S_x(1,1) = 1; %The only horizontal support force is from joint 1, 1st support force
%Vertical support forces. S2=Ay and S3=Hy are vertical forces
S_y = [0 1 0;
       0 0 0;
       0 0 0;
       0 0 0;
       0 0 0;
       0 0 0;
       0 0 0;
       0 0 1];

%X and Y vectors: distance of each joint from the Origin (joint A)
X = [0 0 4 4 8 8 12 12]; %X distance A
Y = [0 4 8 4 8 4 4 0]; %Y distance from A

%Pre-allocating L: the load matrix
L = zeros(2*j,1);

save("practiceTruss.mat","j", "x","M","C","S_x","S_y","X","Y","L");

%% Prelim Design 1: