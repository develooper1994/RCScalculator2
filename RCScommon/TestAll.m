Filename = 'v1newTET75Phi45.rka.out2';
%% RangeProfile
tic;
RangeProfile(Filename)
time = toc;
disp(['time to calculate RangeProfile = ', num2str(time)]) %0.56101ms
% jit  complied mex = 0.50726
% cuda-jit  complied mex = 0.65642 % gpu code loading overhead
%% RCS_vs_Freq
tic;
RCS_vs_Freq(Filename)
time = toc;
disp(['time to calculate RCS_vs_Freq = ', num2str(time)]) %0.54605ms
% jit complied mex = 0.4115
% cuda-jit  complied mex = 0.64669 % gpu code loading overhead
%% RCS_vs_Phi
tic;
RCS_vs_Phi(Filename)
time = toc;
disp(['time to calculate RCS_vs_Phi = ', num2str(time)]) %0.86357ms
% jit  complied mex = 0.62162
% cuda-jit  complied mex = 0.87499 % gpu code loading overhead
%% RCS_vs_Theta
tic;
RCS_vs_Theta(Filename)
time = toc;
disp(['time to calculate RCS_vs_Theta = ', num2str(time)]) %0.87058ms
% jit  complied mex = 
% cuda-jit  complied mex =  % gpu code loading overhead
