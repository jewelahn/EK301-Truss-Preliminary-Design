%% Saving Truss Designs

%% Practice Problem truss (in ounces and inches)
j = 8; % j = mumbers of joints
x = 3; %x=number of support forces.
M = 2*j - x; %M is the total number of member forces


C = [1 1 0 0 0 0 0 0 0 0  0  0  0; % 1
     0 1 1 1 0 0 0 0 0 0  0  0  0; % 2
     0 0 0 1 1 1 0 0 0 0  0  0  0; % 3
     1 0 1 0 1 0 1 1 0 0  0  0  0; % 4
     0 0 0 0 0 1 1 0 1 1  0  0  0; % 5
     0 0 0 0 0 0 0 1 1 0  1  0  1; % 6
     0 0 0 0 0 0 0 0 0 1  1  1  0; % 7
     0 0 0 0 0 0 0 0 0 0  0  1  1]; % 8
   % 1 2 3 4 5 6 7 8 9 10 11 12 13

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
       0 0 1;
       0 0 0];

%X and Y vectors: distance of each joint from the Origin (joint A) (in inches)
X = [0 0 157.48 157.48 314.961 314.961 472.441 472.441]; % X distance A
Y = [0 157.48 314.961 157.48 314.961 157.48 157.48 0]; % Y distance from A

%L: the load matrix
L = zeros(2*j,1); %Pre-allocating zeroes
%The only constant force/applied force is the 89.924 oz load at D (vertical)
L(j+4) = 89.924;

save("practiceTruss.mat","j", "x","M","C","S_x","S_y","X","Y","L");

%% Practice Problem truss (In Newtons and Meters)
j = 8; % j = mumbers of joints
x = 4; %x=number of support forces.
M = 2*j - x; %M is the total number of member forces


C = [1 1 0 0 0 0 0 0 0 0  0  0  0; % 1
     0 1 1 1 0 0 0 0 0 0  0  0  0; % 2
     0 0 0 1 1 1 0 0 0 0  0  0  0; % 3
     1 0 1 0 1 0 1 1 0 0  0  0  0; % 4
     0 0 0 0 0 1 1 0 1 1  0  0  0; % 5
     0 0 0 0 0 0 0 1 1 0  1  0  1; % 6
     0 0 0 0 0 0 0 0 0 1  1  1  0; % 7
     0 0 0 0 0 0 0 0 0 0  0  1  1]; % 8
   % 1 2 3 4 5 6 7 8 9 10 11 12 13
   
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
       0 0 1;
       0 0 0];

%X and Y vectors: distance of each joint from the Origin (joint A) (in meters)
X = [0 0 4 4 8 8 12 12]; % X distance A
Y = [0 4 8 4 8 4 4 0]; % Y distance from A

%L: the load matrix
L = zeros(2*j,1); %Pre-allocating zeroes
%The only constant force/applied force is the 25 N load at D (vertical)
L(j+4) = 25;

save("practiceTrussNewtons.mat","j", "x","M","C","S_x","S_y","X","Y","L");

%% Prelim Design 1: The Hexagon
j = 8;% j = mumbers of joints
x = 3; %x=number of support forces.
M = 2*j -x; %M is the total number of member forces

C = [1 1 0 0 0 0 0 0 0 0  0  0  1; % 1
     1 0 1 1 0 0 0 0 0 0  0  0  0; %j2
     0 0 0 1 1 1 0 0 0 0  0  0  0; %j3
     0 0 0 0 0 1 1 0 0 0  0  0  0; %j4
     0 0 0 0 0 0 0 1 1 0  0  0  0; %j5
     0 0 0 0 0 0 0 0 1 1  1  0  0; %j6
     0 0 0 0 0 0 0 0 0 0  1  1  1; %j7
     0 1 1 0 1 0 1 1 1 1  0  1  0];%j8
  %M 1 2 3 4 5 6 7 8 9 10 11 12 13

%Support forces: S1 = J1x, S2 = J1y, S3 = J6y
%S_x are the hozitonal support forces, S1 is the only horizontal force
S_x = zeros(j,x); 
S_x(1,1) = 1; 
%Vertical support forces. S2=J1y and S3=J6y are vertical forces
S_y = zeros(j,x);
S_y(1,2) = 1;
S_y(7,3) = 1;

%X and Y vectors: distance of each joint from the Origin (joint1) (in inches)
X = [3 0 3  6  9 12 9 6]; % X distance J1
Y = [0 6 12 12 12  6 0 6]; % Y distance from J1

%L: the load matrix
L = zeros(2*j,1); %Pre-allocating zeroes
%Loads forces: 80 oz at J3 (vertical), 50 oz at J5 (vertical)
L(j+3) = 80;
L(j+5) = 50;

save("prelimDesign1.mat","j", "x","M","C","S_x","S_y","X","Y","L");

%% Prelim Design 1: The Hexagon
j = 8; % j = mumbers of joints
x = 3; %x=number of support forces.
M = 2*j -x; %M is the total number of member forces

C = [1 1 0 0 0 0 0 0 0 0  0  0  0; % 1
     0 1 1 1 1 0 0 0 0 0  0  0  0; % 2
     0 0 0 1 0 0 1 0 1 0  0  0  0; % 3
     0 0 0 0 0 0 1 1 0 0  1  1  0; % 4
     0 0 0 0 0 0 0 0 0 0  0  1  1; % 5
     0 0 0 0 0 0 0 0 0 1  1  0  1; % 6
     0 0 0 0 1 1 0 1 1 1  0  0  0; % 7
     1 0 1 0 0 1 0 0 0 0  0  1  1];% 8
   % 1 2 3 4 5 6 7 8 9 10 11 12 13

%Support forces: S1 = J1x, S2 = J1y, S3 = J5x, S4 = J5y
%S_x are the hozitonal support forces, S1 and S3 (1st and 3rd columns)
S_x = zeros(j,x); 
S_x(1,1) = 1; 
S_x(5,3) = 1;
%Vertical support forces. S2=J1y and S4=J5y are vertical forces
S_y = zeros(j,x);
S_y(1,2) = 1;
S_y(5,4) = 1;

%X and Y vectors: distance of each joint from the Origin (joint1) (in inches)
X = [0 2 6 10 12 10 6 2]; % X distance J1
Y = [0 6 6 6  0  0  0 0]; % Y distance from J1

%L: the load matrix
L = zeros(2*j,1); %Pre-allocating zeroes
%Loads forces: 90 oz at J7 (vertical), 40 oz at J4 (vertical)
L(j+7) = 90;
L(j+4) = 40;

save("prelimDesign2.mat","j", "x","M","C","S_x","S_y","X","Y","L");
