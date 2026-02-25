%% Extract_CSI.m
% Extract CSI from a single Nexmon PCAP
% Copyright (C) 2025 Khandaker Foysal Haque
% GNU GPL v3

clc; clear; close all;

%% -------- Read argument from terminal --------
FILE = '../CSI-Samples/D_1_M1_P2_short.pcap';

if ~isfile(FILE)
    error('PCAP file not found: %s', FILE);
end

fprintf('Now reading %s\n', FILE);

%% -------- Configuration (same as yours) --------
CHIP = '4366c0';   % 4339, 4358, 43455c0, 4366c0
BW   = 80;         % MHz

if BW == 20
    non_zero = [5:32, 34:61];
else
    non_zero = [7:128, 132:251];
end

%% -------- Initialize pcap reader --------
p = readpcap();
p.open(FILE);
n = min(length(p.all()), 1000000);
p.from_start();

%% -------- Buffers --------
csi_buff = complex(zeros(n, BW * 3.2), 0);
seq_num  = [];
core_num = [];
write_idx = 0;

%% -------- Read frames --------
for k = 1:n
    f = p.next();
    if isempty(f)
        break;
    end

    if f.header.orig_len - (16 - 1) * 4 ~= BW * 3.2 * 4
        continue;
    end

    payload = f.payload;

    P14 = dec2hex(payload(14), 8);
    seq_num  = [seq_num; P14(5:end)];
    core_num = [core_num; P14(1:2)];

    H = payload(16:16 + BW * 3.2 - 1);

    switch CHIP
        case {'4339','43455c0'}
            Hout = typecast(H, 'int16');
        case '4358'
            Hout = unpack_float(int32(0), int32(BW * 3.2), H);
        case '4366c0'
            Hout = unpack_float(int32(1), int32(BW * 3.2), H);
        otherwise
            error('Invalid CHIP');
    end

    Hout = reshape(Hout, 2, []).';
    write_idx = write_idx + 1;
    csi_buff(write_idx,:) = ...
        double(Hout(:,1)) + 1j*double(Hout(:,2));
end

%% -------- Trim --------
csi_buff = csi_buff(1:write_idx,:);
csi = csi_buff(:, non_zero);

%% -------- Plot --------
% nfft should match the number of subcarriers in csi (after non_zero selection)
% nfft = size(csi, 2);
% normalize = true;
% plotcsi(csi, nfft, normalize);

%% -------- Save with same name --------
[folder, base, ~] = fileparts(FILE);
if isempty(folder), folder = '.'; end
mat_name = fullfile(folder, [base '.mat']);

save(mat_name, 'csi', 'seq_num', 'core_num', '-v7.3');

fprintf('Saved: %s\n', mat_name);
fprintf('Processing complete.\n');