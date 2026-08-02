; ModuleID = '/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/hasitha_hls_component/mine/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: inaccessiblemem_or_argmemonly noinline willreturn
define void @apatb_mine_ir(i32* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="20" "maxi" %header, i32* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="8" "maxi" %target, i32 %nonce_start, i32 %nonce_count, i32* noalias nocapture nonnull "maxi" %found_nonce, i32* noalias nocapture nonnull "maxi" %found) local_unnamed_addr #0 {
entry:
  %0 = bitcast i32* %header to [20 x i32]*
  %header_copy = alloca [20 x i32], align 512
  %1 = bitcast i32* %target to [8 x i32]*
  %target_copy = alloca [8 x i32], align 512
  %2 = bitcast i32* %found_nonce to [1 x i32]*
  %found_nonce_copy = alloca [1 x i32], align 512
  %3 = getelementptr inbounds [1 x i32], [1 x i32]* %found_nonce_copy, i64 0, i64 0
  %4 = bitcast i32* %found to [1 x i32]*
  %found_copy = alloca [1 x i32], align 512
  %5 = getelementptr inbounds [1 x i32], [1 x i32]* %found_copy, i64 0, i64 0
  call fastcc void @copy_in([20 x i32]* nonnull %0, [20 x i32]* nonnull align 512 %header_copy, [8 x i32]* nonnull %1, [8 x i32]* nonnull align 512 %target_copy, [1 x i32]* nonnull %2, [1 x i32]* nonnull align 512 %found_nonce_copy, [1 x i32]* nonnull %4, [1 x i32]* nonnull align 512 %found_copy)
  call void @apatb_mine_hw([20 x i32]* %header_copy, [8 x i32]* %target_copy, i32 %nonce_start, i32 %nonce_count, i32* %3, i32* %5)
  call void @copy_back([20 x i32]* %0, [20 x i32]* %header_copy, [8 x i32]* %1, [8 x i32]* %target_copy, [1 x i32]* %2, [1 x i32]* %found_nonce_copy, [1 x i32]* %4, [1 x i32]* %found_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([20 x i32]* noalias readonly, [20 x i32]* noalias align 512, [8 x i32]* noalias readonly, [8 x i32]* noalias align 512, [1 x i32]* noalias readonly, [1 x i32]* noalias align 512, [1 x i32]* noalias readonly, [1 x i32]* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0a20i32([20 x i32]* align 512 %1, [20 x i32]* %0)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* align 512 %3, [8 x i32]* %2)
  call fastcc void @onebyonecpy_hls.p0a1i32([1 x i32]* align 512 %5, [1 x i32]* %4)
  call fastcc void @onebyonecpy_hls.p0a1i32([1 x i32]* align 512 %7, [1 x i32]* %6)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a20i32([20 x i32]* noalias align 512 %dst, [20 x i32]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [20 x i32]* %dst, null
  %1 = icmp eq [20 x i32]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a20i32([20 x i32]* nonnull %dst, [20 x i32]* nonnull %src, i64 20)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a20i32([20 x i32]* %dst, [20 x i32]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [20 x i32]* %src, null
  %1 = icmp eq [20 x i32]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [20 x i32], [20 x i32]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [20 x i32], [20 x i32]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i32, i32* %src.addr, align 4
  store i32 %3, i32* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* noalias align 512 %dst, [8 x i32]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [8 x i32]* %dst, null
  %1 = icmp eq [8 x i32]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a8i32([8 x i32]* nonnull %dst, [8 x i32]* nonnull %src, i64 8)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a8i32([8 x i32]* %dst, [8 x i32]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [8 x i32]* %src, null
  %1 = icmp eq [8 x i32]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [8 x i32], [8 x i32]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [8 x i32], [8 x i32]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i32, i32* %src.addr, align 4
  store i32 %3, i32* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a1i32([1 x i32]* noalias align 512 %dst, [1 x i32]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [1 x i32]* %dst, null
  %1 = icmp eq [1 x i32]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a1i32([1 x i32]* nonnull %dst, [1 x i32]* nonnull %src, i64 1)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a1i32([1 x i32]* %dst, [1 x i32]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [1 x i32]* %src, null
  %1 = icmp eq [1 x i32]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [1 x i32], [1 x i32]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [1 x i32], [1 x i32]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i32, i32* %src.addr, align 4
  store i32 %3, i32* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([20 x i32]* noalias, [20 x i32]* noalias readonly align 512, [8 x i32]* noalias, [8 x i32]* noalias readonly align 512, [1 x i32]* noalias, [1 x i32]* noalias readonly align 512, [1 x i32]* noalias, [1 x i32]* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a20i32([20 x i32]* %0, [20 x i32]* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0a8i32([8 x i32]* %2, [8 x i32]* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0a1i32([1 x i32]* %4, [1 x i32]* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0a1i32([1 x i32]* %6, [1 x i32]* align 512 %7)
  ret void
}

declare void @apatb_mine_hw([20 x i32]*, [8 x i32]*, i32, i32, i32*, i32*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([20 x i32]* noalias, [20 x i32]* noalias readonly align 512, [8 x i32]* noalias, [8 x i32]* noalias readonly align 512, [1 x i32]* noalias, [1 x i32]* noalias readonly align 512, [1 x i32]* noalias, [1 x i32]* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a1i32([1 x i32]* %4, [1 x i32]* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0a1i32([1 x i32]* %6, [1 x i32]* align 512 %7)
  ret void
}

declare void @mine_hw_stub(i32* noalias nocapture nonnull readonly, i32* noalias nocapture nonnull readonly, i32, i32, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull)

define void @mine_hw_stub_wrapper([20 x i32]*, [8 x i32]*, i32, i32, i32*, i32*) #5 {
entry:
  %6 = bitcast i32* %4 to [1 x i32]*
  %7 = bitcast i32* %5 to [1 x i32]*
  call void @copy_out([20 x i32]* null, [20 x i32]* %0, [8 x i32]* null, [8 x i32]* %1, [1 x i32]* null, [1 x i32]* %6, [1 x i32]* null, [1 x i32]* %7)
  %8 = bitcast [20 x i32]* %0 to i32*
  %9 = bitcast [8 x i32]* %1 to i32*
  %10 = bitcast [1 x i32]* %6 to i32*
  %11 = bitcast [1 x i32]* %7 to i32*
  call void @mine_hw_stub(i32* %8, i32* %9, i32 %2, i32 %3, i32* %10, i32* %11)
  call void @copy_in([20 x i32]* null, [20 x i32]* %0, [8 x i32]* null, [8 x i32]* %1, [1 x i32]* null, [1 x i32]* %6, [1 x i32]* null, [1 x i32]* %7)
  ret void
}

attributes #0 = { inaccessiblemem_or_argmemonly noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1}
!llvm.module.flags = !{!2, !3, !4}
!blackbox_cfg = !{!5}

!0 = !{!"AMD/Xilinx clang version 16.0.6"}
!1 = !{!"clang version 7.0.0 "}
!2 = !{i32 2, !"Dwarf Version", i32 4}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{}
