# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=znver3 -iterations=1500 -timeline -timeline-max-iterations=6 < %s | FileCheck %s

# The ILP is limited by the false dependency on %dx. So, the mov cannot execute
# in parallel with the add.

add %cx, %dx
mov %ax, %dx
xor %bx, %dx

# CHECK:      Iterations:        1500
# CHECK-NEXT: Instructions:      4500
# CHECK-NEXT: Total Cycles:      4503
# CHECK-NEXT: Total uOps:        4500

# CHECK:      Dispatch Width:    6
# CHECK-NEXT: uOps Per Cycle:    1.00
# CHECK-NEXT: IPC:               1.00
# CHECK-NEXT: Block RThroughput: 1.5

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.25                        addw	%cx, %dx
# CHECK-NEXT:  1      1     1.00                        movw	%ax, %dx
# CHECK-NEXT:  1      1     0.25                        xorw	%bx, %dx

# CHECK:      Resources:
# CHECK-NEXT: [0]   - Zn3AGU0
# CHECK-NEXT: [1]   - Zn3AGU1
# CHECK-NEXT: [2]   - Zn3AGU2
# CHECK-NEXT: [3]   - Zn3ALU0
# CHECK-NEXT: [4]   - Zn3ALU1
# CHECK-NEXT: [5]   - Zn3ALU2
# CHECK-NEXT: [6]   - Zn3ALU3
# CHECK-NEXT: [7]   - Zn3BRU1
# CHECK-NEXT: [8]   - Zn3FPP0
# CHECK-NEXT: [9]   - Zn3FPP1
# CHECK-NEXT: [10]  - Zn3FPP2
# CHECK-NEXT: [11]  - Zn3FPP3
# CHECK-NEXT: [12.0] - Zn3FPP45
# CHECK-NEXT: [12.1] - Zn3FPP45
# CHECK-NEXT: [13]  - Zn3FPSt
# CHECK-NEXT: [14.0] - Zn3LSU
# CHECK-NEXT: [14.1] - Zn3LSU
# CHECK-NEXT: [14.2] - Zn3LSU
# CHECK-NEXT: [15.0] - Zn3Load
# CHECK-NEXT: [15.1] - Zn3Load
# CHECK-NEXT: [15.2] - Zn3Load
# CHECK-NEXT: [16.0] - Zn3Store
# CHECK-NEXT: [16.1] - Zn3Store

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12.0] [12.1] [13]   [14.0] [14.1] [14.2] [15.0] [15.1] [15.2] [16.0] [16.1]
# CHECK-NEXT:  -      -      -     1.50   1.50   1.50   1.50    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12.0] [12.1] [13]   [14.0] [14.1] [14.2] [15.0] [15.1] [15.2] [16.0] [16.1] Instructions:
# CHECK-NEXT:  -      -      -     0.25   0.25   0.25   0.25    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     addw	%cx, %dx
# CHECK-NEXT:  -      -      -     1.00   1.00   1.00   1.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     movw	%ax, %dx
# CHECK-NEXT:  -      -      -     0.25   0.25   0.25   0.25    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     xorw	%bx, %dx

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789
# CHECK-NEXT: Index     0123456789          0

# CHECK:      [0,0]     DeER .    .    .    .   addw	%cx, %dx
# CHECK-NEXT: [0,1]     D=eER.    .    .    .   movw	%ax, %dx
# CHECK-NEXT: [0,2]     D==eER    .    .    .   xorw	%bx, %dx
# CHECK-NEXT: [1,0]     D===eER   .    .    .   addw	%cx, %dx
# CHECK-NEXT: [1,1]     D====eER  .    .    .   movw	%ax, %dx
# CHECK-NEXT: [1,2]     D=====eER .    .    .   xorw	%bx, %dx
# CHECK-NEXT: [2,0]     .D=====eER.    .    .   addw	%cx, %dx
# CHECK-NEXT: [2,1]     .D======eER    .    .   movw	%ax, %dx
# CHECK-NEXT: [2,2]     .D=======eER   .    .   xorw	%bx, %dx
# CHECK-NEXT: [3,0]     .D========eER  .    .   addw	%cx, %dx
# CHECK-NEXT: [3,1]     .D=========eER .    .   movw	%ax, %dx
# CHECK-NEXT: [3,2]     .D==========eER.    .   xorw	%bx, %dx
# CHECK-NEXT: [4,0]     . D==========eER    .   addw	%cx, %dx
# CHECK-NEXT: [4,1]     . D===========eER   .   movw	%ax, %dx
# CHECK-NEXT: [4,2]     . D============eER  .   xorw	%bx, %dx
# CHECK-NEXT: [5,0]     . D=============eER .   addw	%cx, %dx
# CHECK-NEXT: [5,1]     . D==============eER.   movw	%ax, %dx
# CHECK-NEXT: [5,2]     . D===============eER   xorw	%bx, %dx

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     6     7.5    0.2    0.0       addw	%cx, %dx
# CHECK-NEXT: 1.     6     8.5    0.0    0.0       movw	%ax, %dx
# CHECK-NEXT: 2.     6     9.5    0.0    0.0       xorw	%bx, %dx
# CHECK-NEXT:        6     8.5    0.1    0.0       <total>