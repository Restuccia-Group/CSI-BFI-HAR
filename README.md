# CSI-BFI-HAR Dataset

This repository documents the structure and usage of the CSI-BFI-HAR dataset.

Dataset publication target:
- https://ieee-dataport.org/documents/csi-bfi-har-wi-fi-datasets-human-activity-recognition

## Dataset Structure

The dataset is organized into two subsets:
- `Dataset-1`: single-subject HAR (`HAR-1` to `HAR-6`)
- `Dataset-2`: simultaneous multi-subject HAR (`HAR-7` to `HAR-12`)

Each `HAR-*` folder contains two subfolders:
- `CSI/`: channel state information traces
- `BFI/`: beamforming feedback information traces

```text
CSI-BFI-HAR-Dataset/
├── Dataset-1/
│   ├── HAR-1/
│   │   ├── BFI/
│   │   └── CSI/
│   ├── HAR-2/
│   │   ├── BFI/
│   │   └── CSI/
│   ├── HAR-3/
│   │   ├── BFI/
│   │   └── CSI/
│   ├── HAR-4/
│   │   ├── BFI/
│   │   └── CSI/
│   ├── HAR-5/
│   │   ├── BFI/
│   │   └── CSI/
│   └── HAR-6/
│       ├── BFI/
│       └── CSI/
└── Dataset-2/
    ├── HAR-7/
    │   ├── BFI/
    │   └── CSI/
    ├── HAR-8/
    │   ├── BFI/
    │   └── CSI/
    ├── HAR-9/
    │   ├── BFI/
    │   └── CSI/
    ├── HAR-10/
    │   ├── BFI/
    │   └── CSI/
    ├── HAR-11/
    │   ├── BFI/
    │   └── CSI/
    └── HAR-12/
        ├── BFI/
        └── CSI/
```

## HAR Folder Mapping

| HAR Set | Environment | Device(s) | LoS/NLoS | Concurrent Subjects | Subject IDs |
|---|---|---|---|---|---|
| HAR-1 | Kitchen (Orientation 1-3) | M1, M2 | LoS | 1 | P1-P6 |
| HAR-2 | Kitchen (Orientation 1-3) | M3 | NLoS | 1 | P1-P6 |
| HAR-3 | Classroom | M1, M2 | LoS | 1 | P1-P6 |
| HAR-4 | Classroom | M3 | NLoS | 1 | P1-P6 |
| HAR-5 | Living room | M1, M2 | LoS | 1 | P1-P6 |
| HAR-6 | Living room | M3 | NLoS | 1 | P1-P6 |
| HAR-7 | Kitchen (Orientation 1-3) | M1, M2 | LoS | 3 | P1-P3 |
| HAR-8 | Kitchen (Orientation 1-3) | M3 | NLoS | 3 | P1-P3 |
| HAR-9 | Classroom (Orientation 1-3) | M1, M2 | LoS | 3 | P1-P3 |
| HAR-10 | Classroom (Orientation 1-3) | M3 | NLoS | 3 | P1-P3 |
| HAR-11 | Living room (Orientation 1-3) | M1, M2 | LoS | 3 | P1-P3 |
| HAR-12 | Living room (Orientation 1-3) | M3 | NLoS | 3 | P1-P3 |

## Trace Naming Convention

Each trace filename follows:

```text
X_D_YY_ZZ
```

Where:
- `X`: activity code (`A` to `T`)
- `D`: day index (`1` to `6`)
- `YY`: sensing device ID
- `ZZ`: subject ID

Device IDs:
- CSI devices: `M1`, `M2`, `M3`
- BFI devices: `S1`, `S2`, `S3`

Subject IDs:
- `P1` to `P6` for `Dataset-1`
- `P1` to `P3` for `Dataset-2`

Activity code map:
- `A`: jogging
- `B`: clapping
- `C`: push forward
- `D`: boxing
- `E`: writing
- `F`: brushing teeth
- `G`: rotating
- `H`: standing
- `I`: eating
- `J`: reading a book
- `K`: waving
- `L`: walking
- `M`: browsing phone
- `N`: drinking
- `O`: hands-up-down
- `P`: phone call
- `Q`: side bends
- `R`: check wrist (watch)
- `S`: washing hands
- `T`: browsing laptop

Examples:
- `A_3_M1_P2` -> jogging, day 3, CSI device M1, subject P2
- `N_6_S2_P1` -> drinking, day 6, BFI device S2, subject P1
