; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze | FileCheck %s --check-prefixes=ALL,NOMOVBE,X64
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+movbe | FileCheck %s --check-prefixes=ALL,MOVBE,X64
; RUN: opt < %s -mtriple=i686-unknown-linux-gnu -cost-model -analyze | FileCheck %s --check-prefixes=ALL,NOMOVBE,X86
; RUN: opt < %s -mtriple=i686-unknown-linux-gnu -cost-model -analyze -mattr=+movbe | FileCheck %s --check-prefixes=ALL,MOVBE,X86

declare i16 @llvm.bswap.i16(i16)
declare i32 @llvm.bswap.i32(i32)
declare i64 @llvm.bswap.i64(i64)
declare i128 @llvm.bswap.i128(i128)

define void @var_bswap_store_i16(i16 %a, i16* %dst) {
; NOMOVBE-LABEL: 'var_bswap_store_i16'
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %bswap = call i16 @llvm.bswap.i16(i16 %a)
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i16 %bswap, i16* %dst, align 1
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; MOVBE-LABEL: 'var_bswap_store_i16'
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap = call i16 @llvm.bswap.i16(i16 %a)
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i16 %bswap, i16* %dst, align 1
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %bswap = call i16 @llvm.bswap.i16(i16 %a)
  store i16 %bswap, i16* %dst, align 1

  ret void
}
define void @var_bswap_store_i16_extrause(i16 %a, i16* %dst) {
; NOMOVBE-LABEL: 'var_bswap_store_i16_extrause'
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %bswap = call i16 @llvm.bswap.i16(i16 %a)
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i16 %bswap, i16* %dst, align 1
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap2 = shl i16 %bswap, 2
; NOMOVBE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; MOVBE-LABEL: 'var_bswap_store_i16_extrause'
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap = call i16 @llvm.bswap.i16(i16 %a)
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i16 %bswap, i16* %dst, align 1
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap2 = shl i16 %bswap, 2
; MOVBE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %bswap = call i16 @llvm.bswap.i16(i16 %a)
  store i16 %bswap, i16* %dst, align 1

  %bswap2 = shl i16 %bswap, 2 ; incur an extra use to the bswap

  ret void
}

define void @var_bswap_store_i32(i32 %a, i32* %dst) {
; ALL-LABEL: 'var_bswap_store_i32'
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap = call i32 @llvm.bswap.i32(i32 %a)
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i32 %bswap, i32* %dst, align 1
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %bswap = call i32 @llvm.bswap.i32(i32 %a)
  store i32 %bswap, i32* %dst, align 1

  ret void
}
define void @var_bswap_store_i32_extrause(i32 %a, i32* %dst) {
; ALL-LABEL: 'var_bswap_store_i32_extrause'
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap = call i32 @llvm.bswap.i32(i32 %a)
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i32 %bswap, i32* %dst, align 1
; ALL-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap2 = shl i32 %bswap, 2
; ALL-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %bswap = call i32 @llvm.bswap.i32(i32 %a)
  store i32 %bswap, i32* %dst, align 1

  %bswap2 = shl i32 %bswap, 2 ; incur an extra use to the bswap

  ret void
}

define void @var_bswap_store_i64(i64 %a, i64* %dst) {
; X64-LABEL: 'var_bswap_store_i64'
; X64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap = call i64 @llvm.bswap.i64(i64 %a)
; X64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i64 %bswap, i64* %dst, align 1
; X64-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; X86-LABEL: 'var_bswap_store_i64'
; X86-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bswap = call i64 @llvm.bswap.i64(i64 %a)
; X86-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store i64 %bswap, i64* %dst, align 1
; X86-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %bswap = call i64 @llvm.bswap.i64(i64 %a)
  store i64 %bswap, i64* %dst, align 1

  ret void
}
define void @var_bswap_store_i64_extrause(i64 %a, i64* %dst) {
; X64-LABEL: 'var_bswap_store_i64_extrause'
; X64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap = call i64 @llvm.bswap.i64(i64 %a)
; X64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store i64 %bswap, i64* %dst, align 1
; X64-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bswap2 = shl i64 %bswap, 2
; X64-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; X86-LABEL: 'var_bswap_store_i64_extrause'
; X86-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bswap = call i64 @llvm.bswap.i64(i64 %a)
; X86-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store i64 %bswap, i64* %dst, align 1
; X86-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %bswap2 = shl i64 %bswap, 2
; X86-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %bswap = call i64 @llvm.bswap.i64(i64 %a)
  store i64 %bswap, i64* %dst, align 1

  %bswap2 = shl i64 %bswap, 2 ; incur an extra use to the bswap

  ret void
}

define void @var_bswap_store_i128(i128 %a, i128* %dst) {
; X64-LABEL: 'var_bswap_store_i128'
; X64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bswap = call i128 @llvm.bswap.i128(i128 %a)
; X64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store i128 %bswap, i128* %dst, align 1
; X64-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; X86-LABEL: 'var_bswap_store_i128'
; X86-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %bswap = call i128 @llvm.bswap.i128(i128 %a)
; X86-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: store i128 %bswap, i128* %dst, align 1
; X86-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %bswap = call i128 @llvm.bswap.i128(i128 %a)
  store i128 %bswap, i128* %dst, align 1

  ret void
}
define void @var_bswap_store_i128_extrause(i128 %a, i128* %dst) {
; X64-LABEL: 'var_bswap_store_i128_extrause'
; X64-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bswap = call i128 @llvm.bswap.i128(i128 %a)
; X64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store i128 %bswap, i128* %dst, align 1
; X64-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %bswap2 = shl i128 %bswap, 2
; X64-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; X86-LABEL: 'var_bswap_store_i128_extrause'
; X86-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %bswap = call i128 @llvm.bswap.i128(i128 %a)
; X86-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: store i128 %bswap, i128* %dst, align 1
; X86-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bswap2 = shl i128 %bswap, 2
; X86-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %bswap = call i128 @llvm.bswap.i128(i128 %a)
  store i128 %bswap, i128* %dst, align 1

  %bswap2 = shl i128 %bswap, 2 ; incur an extra use to the bswap

  ret void
}