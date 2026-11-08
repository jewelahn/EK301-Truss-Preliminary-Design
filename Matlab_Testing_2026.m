C = [1 0 0 0;
     0 1 1 0;
     1 0 1 1;
     0 1 0 1];

B = [1 2 3 4;
     5 6 7 8;
     9 10 11 12];

[row, col] = find(C == 1);
C_loc = cat(2, row, col);

coords = find(C(:, 1))