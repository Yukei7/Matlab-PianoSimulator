function pitch = pitchtable()
% PITCH 获取音高频率表

f0 = 440/(2^(9/12)); % Middle C

pitch = ones(12, 4);
ScaleTable1 = 2.^(1/12 .* [-36: 1: -25]);
ScaleTable2 = 2.^(1/12 .* [-24: 1: -13]);
ScaleTable3 = 2.^(1/12 .* [-12: 1: -1]);
ScaleTable4 = 2.^(1/12 .* [0: 1: 11]);
ScaleTable5 = 2.^(1/12 .* [12: 1: 23]);
ScaleTable6 = 2.^(1/12 .* [24: 1: 35]);
ScaleTable7 = 2.^(1/12 .* [36: 1: 47]);
pitch(:, 1) = f0.*ScaleTable1;
pitch(:, 2) = f0.*ScaleTable2;
pitch(:, 3) = f0.*ScaleTable3;
pitch(:, 4) = f0.*ScaleTable4;
pitch(:, 5) = f0.*ScaleTable5;
pitch(:, 6) = f0.*ScaleTable6;
pitch(:, 7) = f0.*ScaleTable7;

end