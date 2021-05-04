; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze | FileCheck %s --check-prefixes=ALL,NOMOVBE,X64
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+movbe | FileCheck %s --check-prefixes=ALL,MOVBE,X64
; RUN: opt < %s -mtriple=i686-unknown-linux-gnu -cost-model -analyze | FileCheck %s --check-prefixes=ALL,NOMOVBE,X86
; RUN: opt < %s -mtriple=i686-unknown-linux-gnu -cost-model -analyze -mattr=+movbe | FileCheck %s --check-prefixes=ALL,MOVBE,X86

declare i16 @llvm.bswap.i16(i16)
declare i32 @llvm.bswap.i32(i32)
declare i64 @llvm.bswap.i64(i64)
declare i128 @llvm.bswap.i128(i128)

define i16 @var_load_bswap_i16(i16* %src) {
; NOMOVBE-LABEL: 'var_load_bswap_i16'
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = load i16, i16* %src, align 1
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %bswap = call i16 @llvm.bswap.i16(i16 %a)
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i16 %bswap
;
; MOVBE-LABEL: 'var_load_bswap_i16'
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = load i16, i16* %src, align 1
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap = call i16 @llvm.bswap.i16(i16 %a)
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i16 %bswap
;
  %a = load i16, i16* %src, align 1
  %bswap = call i16 @llvm.bswap.i16(i16 %a)

  ret i16 %bswap
}
define i16 @var_load_bswap_i16_extrause(i16* %src, i16* %clobberdst) {
; NOMOVBE-LABEL: 'var_load_bswap_i16_extrause'
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = load i16, i16* %src, align 1
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %bswap = call i16 @llvm.bswap.i16(i16 %a)
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a2 = shl i16 %a, 2
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i16 %a2, i16* %clobberdst, align 1
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i16 %bswap
;
; MOVBE-LABEL: 'var_load_bswap_i16_extrause'
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = load i16, i16* %src, align 1
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap = call i16 @llvm.bswap.i16(i16 %a)
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a2 = shl i16 %a, 2
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i16 %a2, i16* %clobberdst, align 1
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i16 %bswap
;
  %a = load i16, i16* %src, align 1
  %bswap = call i16 @llvm.bswap.i16(i16 %a)

  %a2 = shl i16 %a, 2 ; incur an extra use to the load
  store i16 %a2, i16* %clobberdst, align 1

  ret i16 %bswap
}

define i32 @var_load_bswap_i32(i32* %src) {
; ALL-LABEL: 'var_load_bswap_i32'
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = load i32, i32* %src, align 1
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap = call i32 @llvm.bswap.i32(i32 %a)
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 %bswap
;
  %a = load i32, i32* %src, align 1
  %bswap = call i32 @llvm.bswap.i32(i32 %a)

  ret i32 %bswap
}
define i32 @var_load_bswap_i32_extrause(i32* %src, i32* %clobberdst) {
; ALL-LABEL: 'var_load_bswap_i32_extrause'
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = load i32, i32* %src, align 1
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap = call i32 @llvm.bswap.i32(i32 %a)
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a2 = shl i32 %a, 2
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i32 %a2, i32* %clobberdst, align 1
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 %bswap
;
  %a = load i32, i32* %src, align 1
  %bswap = call i32 @llvm.bswap.i32(i32 %a)

  %a2 = shl i32 %a, 2 ; incur an extra use to the load
  store i32 %a2, i32* %clobberdst, align 1

  ret i32 %bswap
}

define i64 @var_load_bswap_i64(i64* %src) {
; X64-LABEL: 'var_load_bswap_i64'
; X64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = load i64, i64* %src, align 1
; X64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap = call i64 @llvm.bswap.i64(i64 %a)
; X64-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i64 %bswap
;
; X86-LABEL: 'var_load_bswap_i64'
; X86-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %a = load i64, i64* %src, align 1
; X86-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bswap = call i64 @llvm.bswap.i64(i64 %a)
; X86-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i64 %bswap
;
  %a = load i64, i64* %src, align 1
  %bswap = call i64 @llvm.bswap.i64(i64 %a)

  ret i64 %bswap
}
define i64 @var_load_bswap_i64_extrause(i64* %src, i64* %clobberdst) {
; X64-LABEL: 'var_load_bswap_i64_extrause'
; X64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = load i64, i64* %src, align 1
; X64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap = call i64 @llvm.bswap.i64(i64 %a)
; X64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a2 = shl i64 %a, 2
; X64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i64 %a2, i64* %clobberdst, align 1
; X64-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i64 %bswap
;
; X86-LABEL: 'var_load_bswap_i64_extrause'
; X86-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %a = load i64, i64* %src, align 1
; X86-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bswap = call i64 @llvm.bswap.i64(i64 %a)
; X86-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %a2 = shl i64 %a, 2
; X86-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store i64 %a2, i64* %clobberdst, align 1
; X86-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i64 %bswap
;
  %a = load i64, i64* %src, align 1
  %bswap = call i64 @llvm.bswap.i64(i64 %a)

  %a2 = shl i64 %a, 2 ; incur an extra use to the load
  store i64 %a2, i64* %clobberdst, align 1

  ret i64 %bswap
}

define i128 @var_load_bswap_i128(i128* %src) {
; X64-LABEL: 'var_load_bswap_i128'
; X64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %a = load i128, i128* %src, align 1
; X64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bswap = call i128 @llvm.bswap.i128(i128 %a)
; X64-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i128 %bswap
;
; X86-LABEL: 'var_load_bswap_i128'
; X86-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %a = load i128, i128* %src, align 1
; X86-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %bswap = call i128 @llvm.bswap.i128(i128 %a)
; X86-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i128 %bswap
;
  %a = load i128, i128* %src, align 1
  %bswap = call i128 @llvm.bswap.i128(i128 %a)

  ret i128 %bswap
}
define i128 @var_load_bswap_i128_extrause(i128* %src, i128* %clobberdst) {
; X64-LABEL: 'var_load_bswap_i128_extrause'
; X64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %a = load i128, i128* %src, align 1
; X64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bswap = call i128 @llvm.bswap.i128(i128 %a)
; X64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %a2 = shl i128 %a, 2
; X64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store i128 %a2, i128* %clobberdst, align 1
; X64-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i128 %bswap
;
; X86-LABEL: 'var_load_bswap_i128_extrause'
; X86-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %a = load i128, i128* %src, align 1
; X86-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %bswap = call i128 @llvm.bswap.i128(i128 %a)
; X86-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %a2 = shl i128 %a, 2
; X86-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: store i128 %a2, i128* %clobberdst, align 1
; X86-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i128 %bswap
;
  %a = load i128, i128* %src, align 1
  %bswap = call i128 @llvm.bswap.i128(i128 %a)

  %a2 = shl i128 %a, 2 ; incur an extra use to the load
  store i128 %a2, i128* %clobberdst, align 1

  ret i128 %bswap
}