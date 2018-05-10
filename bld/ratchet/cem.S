	.text
	.file	"cem.a.bc"
	.globl	_ratchet_print_log
	.align	2
	.type	_ratchet_print_log,@function
_ratchet_print_log:                     ; @_ratchet_print_log
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#16, r1
	;DEBUG_VALUE: print_log:log <- undef
	mov.w	r15, r12
	mov.w	r15, -6(r4)             ; 2-byte Folded Spill
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-6(r4), r12             ; 2-byte Folded Reload
	mov.w	r12, -2(r4)
	call	#request_energy_guard_debug_mode
	mov.w	-2(r4), r12
	mov.w	130(r12), r15
	mov.w	128(r12), r12
	mov.w	r1, r13
	mov.w	r12, 4(r13)
	mov.w	r15, 2(r13)
	mov.w	#.L.str, 0(r13)
	call	#printf
	mov.w	r15, -10(r4)            ; 2-byte Folded Spill
	call	#resume_application
	mov.w	-2(r4), r12
	mov.w	130(r12), r12
	cmp.w	#353, r12
	jeq	.LBB0_2
	jmp	.LBB0_1
.LBB0_1:                                ; %if.then
	mov.w	#0, r15
	call	#exit
.LBB0_2:                                ; %if.end
	mov.w	16(r1), r4
	mov.w	18(r1), r14
	call	#checkpoint
	add.w	#20, r1
	mov.w	r14, r0
.Lfunc_end0:
	.size	_ratchet_print_log, .Lfunc_end0-_ratchet_print_log

	.globl	_ratchet_acquire_sample
	.align	2
	.type	_ratchet_acquire_sample,@function
_ratchet_acquire_sample:                ; @_ratchet_acquire_sample
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#8, r1
	;DEBUG_VALUE: acquire_sample:prev_sample <- undef
	mov.w	r15, r12
	mov.w	r15, -6(r4)             ; 2-byte Folded Spill
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-6(r4), r12             ; 2-byte Folded Reload
	mov.w	r12, -2(r4)
	add.w	#1, r12
	and.w	#3, r12
	mov.w	r12, -4(r4)
	mov.w	r12, r15
	mov.w	8(r1), r4
	mov.w	10(r1), r14
	call	#checkpoint
	add.w	#12, r1
	mov.w	r14, r0
.Lfunc_end1:
	.size	_ratchet_acquire_sample, .Lfunc_end1-_ratchet_acquire_sample

	.globl	_ratchet_init_dict
	.align	2
	.type	_ratchet_init_dict,@function
_ratchet_init_dict:                     ; @_ratchet_init_dict
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#18, r1
	;DEBUG_VALUE: init_dict:dict <- undef
	mov.w	r15, r12
	mov.w	r15, -8(r4)             ; 2-byte Folded Spill
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-8(r4), r12             ; 2-byte Folded Reload
	mov.w	r12, -2(r4)
	mov.w	#0, 3072(r12)
	mov.w	#0, -4(r4)
	jmp	.LBB2_1
.LBB2_1:                                ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-4(r4), r12
	cmp.w	#256, r12
	jhs	.LBB2_4
	jmp	.LBB2_2
.LBB2_2:                                ; %for.body
                                        ;   in Loop: Header=BB2_1 Depth=1
	;DEBUG_VALUE: node <- [FP+-6]
	mov.w	-4(r4), r15
	mov.w	-2(r4), r12
	mov.w	#6, r14
	mov.w	r12, -12(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-12(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, -6(r4)
	mov.w	-4(r4), r14
	mov.w	r14, 0(r12)
	mov.w	-6(r4), r12
	mov.w	#0, 2(r12)
	mov.w	-6(r4), r12
	mov.w	#0, 4(r12)
	mov.w	-2(r4), r12
	mov.w	3072(r12), r14
	add.w	#1, r14
	mov.w	r12, -14(r4)            ; 2-byte Folded Spill
	mov.w	r14, -16(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-14(r4), r12            ; 2-byte Folded Reload
	mov.w	-16(r4), r14            ; 2-byte Folded Reload
	mov.w	r14, 3072(r12)
	jmp	.LBB2_3
.LBB2_3:                                ; %for.inc
                                        ;   in Loop: Header=BB2_1 Depth=1
	mov.w	-4(r4), r12
	add.w	#1, r12
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-18(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -4(r4)
	jmp	.LBB2_1
.LBB2_4:                                ; %for.end
	mov.w	18(r1), r4
	mov.w	20(r1), r14
	call	#checkpoint
	add.w	#22, r1
	mov.w	r14, r0
.Lfunc_end2:
	.size	_ratchet_init_dict, .Lfunc_end2-_ratchet_init_dict

	.globl	_ratchet_find_child
	.align	2
	.type	_ratchet_find_child,@function
_ratchet_find_child:                    ; @_ratchet_find_child
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	push.w	r10
	sub.w	#30, r1
	;DEBUG_VALUE: find_child:letter <- undef
	;DEBUG_VALUE: find_child:parent <- undef
	;DEBUG_VALUE: find_child:dict <- undef
	mov.w	r13, r12
	mov.w	r14, r11
	mov.w	r15, r10
	mov.w	r13, -20(r4)            ; 2-byte Folded Spill
	mov.w	r14, -22(r4)            ; 2-byte Folded Spill
	mov.w	r15, -24(r4)            ; 2-byte Folded Spill
	mov.w	r12, -26(r4)            ; 2-byte Folded Spill
	mov.w	r11, -28(r4)            ; 2-byte Folded Spill
	mov.w	r10, -30(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-24(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -8(r4)
	mov.w	-22(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, -10(r4)
	mov.w	-20(r4), r14            ; 2-byte Folded Reload
	mov.w	r14, -12(r4)
	mov.w	-10(r4), r15
	mov.w	#6, r14
	call	#__mulhi3hw_noint
	mov.w	-20(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, -14(r4)
	mov.w	4(r12), r12
	cmp.w	#0, r12
	jne	.LBB3_2
	jmp	.LBB3_1
.LBB3_1:                                ; %if.then
	mov.w	#0, -6(r4)
	jmp	.LBB3_9
.LBB3_2:                                ; %if.end
	;DEBUG_VALUE: find_child:sibling <- [FP+-12]
	mov.w	-14(r4), r12
	mov.w	4(r12), r12
	mov.w	r12, -16(r4)
	jmp	.LBB3_3
.LBB3_3:                                ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-16(r4), r12
	cmp.w	#0, r12
	jeq	.LBB3_8
	jmp	.LBB3_4
.LBB3_4:                                ; %while.body
                                        ;   in Loop: Header=BB3_3 Depth=1
	;DEBUG_VALUE: sibling_node <- [FP+-14]
	mov.w	-16(r4), r15
	mov.w	-12(r4), r12
	mov.w	#6, r14
	mov.w	r12, -32(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-32(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, -18(r4)
	mov.w	0(r12), r12
	mov.w	-8(r4), r14
	cmp.w	r14, r12
	jne	.LBB3_6
	jmp	.LBB3_5
.LBB3_5:                                ; %if.then.7
	mov.w	-16(r4), r12
	mov.w	r12, -6(r4)
	jmp	.LBB3_9
.LBB3_6:                                ; %if.else
                                        ;   in Loop: Header=BB3_3 Depth=1
	mov.w	-18(r4), r12
	mov.w	2(r12), r12
	mov.w	r12, -34(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-34(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -16(r4)
	jmp	.LBB3_7
.LBB3_7:                                ; %if.end.9
                                        ;   in Loop: Header=BB3_3 Depth=1
	jmp	.LBB3_3
.LBB3_8:                                ; %while.end
	mov.w	#0, -6(r4)
	jmp	.LBB3_9
.LBB3_9:                                ; %return
	mov.w	-6(r4), r15
	mov.w	30(r1), r10
	mov.w	32(r1), r11
	mov.w	34(r1), r4
	mov.w	36(r1), r14
	call	#checkpoint
	add.w	#38, r1
	mov.w	r14, r0
.Lfunc_end3:
	.size	_ratchet_find_child, .Lfunc_end3-_ratchet_find_child

	.globl	_ratchet_add_node
	.align	2
	.type	_ratchet_add_node,@function
_ratchet_add_node:                      ; @_ratchet_add_node
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	push.w	r10
	sub.w	#66, r1
	;DEBUG_VALUE: add_node:letter <- undef
	;DEBUG_VALUE: add_node:parent <- undef
	;DEBUG_VALUE: add_node:dict <- undef
	mov.w	r13, r12
	mov.w	r14, r11
	mov.w	r15, r10
	mov.w	r13, -22(r4)            ; 2-byte Folded Spill
	mov.w	r14, -24(r4)            ; 2-byte Folded Spill
	mov.w	r15, -26(r4)            ; 2-byte Folded Spill
	mov.w	r12, -28(r4)            ; 2-byte Folded Spill
	mov.w	r11, -30(r4)            ; 2-byte Folded Spill
	mov.w	r10, -32(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-26(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -6(r4)
	mov.w	-24(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, -8(r4)
	mov.w	-22(r4), r14            ; 2-byte Folded Reload
	mov.w	r14, -10(r4)
	mov.w	3072(r14), r15
	cmp.w	#512, r15
	jne	.LBB4_4
	jmp	.LBB4_1
.LBB4_1:                                ; %if.then
	jmp	.LBB4_2
.LBB4_2:                                ; %do.body
	call	#request_non_interactive_debug_mode
	mov.w	r1, r12
	mov.w	#.L.str.1, 0(r12)
	call	#printf
	mov.w	r15, -34(r4)            ; 2-byte Folded Spill
	call	#resume_application
	jmp	.LBB4_3
.LBB4_3:                                ; %do.end
	jmp	.LBB4_4
.LBB4_4:                                ; %if.end
	;DEBUG_VALUE: add_node:node <- [FP+-8]
	mov.w	-10(r4), r12
	mov.w	3072(r12), r15
	mov.w	#6, r13
	mov.w	r13, r14
	mov.w	r12, -36(r4)            ; 2-byte Folded Spill
	mov.w	r13, -38(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-36(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, -12(r4)
	mov.w	-6(r4), r13
	mov.w	r12, -40(r4)            ; 2-byte Folded Spill
	mov.w	r13, -42(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-40(r4), r12            ; 2-byte Folded Reload
	mov.w	-42(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 0(r12)
	mov.w	-12(r4), r13
	mov.w	#0, 2(r13)
	mov.w	-12(r4), r13
	mov.w	#0, 4(r13)
	;DEBUG_VALUE: add_node:node_index <- [FP+-10]
	mov.w	-10(r4), r13
	mov.w	3072(r13), r14
	mov.w	r14, r15
	add.w	#1, r15
	mov.w	r13, -44(r4)            ; 2-byte Folded Spill
	mov.w	r14, -46(r4)            ; 2-byte Folded Spill
	mov.w	r15, -48(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-44(r4), r12            ; 2-byte Folded Reload
	mov.w	-48(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 3072(r12)
	mov.w	-46(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, -14(r4)
	;DEBUG_VALUE: add_node:child <- [FP+-12]
	mov.w	-8(r4), r15
	mov.w	-10(r4), r14
	mov.w	-38(r4), r11            ; 2-byte Folded Reload
	mov.w	r14, -50(r4)            ; 2-byte Folded Spill
	mov.w	r11, r14
	call	#__mulhi3hw_noint
	mov.w	-50(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	4(r12), r12
	mov.w	r12, -16(r4)
	cmp.w	#0, r12
	jeq	.LBB4_9
	jmp	.LBB4_5
.LBB4_5:                                ; %if.then.8
	;DEBUG_VALUE: sibling <- [FP+-14]
	mov.w	-16(r4), r12
	mov.w	r12, -18(r4)
	;DEBUG_VALUE: sibling_node <- [FP+-16]
	mov.w	-10(r4), r13
	mov.w	#6, r14
	mov.w	r12, r15
	mov.w	r13, -52(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-52(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, -20(r4)
	jmp	.LBB4_6
.LBB4_6:                                ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-20(r4), r12
	mov.w	2(r12), r12
	cmp.w	#0, r12
	jeq	.LBB4_8
	jmp	.LBB4_7
.LBB4_7:                                ; %while.body
                                        ;   in Loop: Header=BB4_6 Depth=1
	mov.w	-20(r4), r12
	mov.w	2(r12), r12
	mov.w	r12, -54(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-54(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -18(r4)
	mov.w	-10(r4), r13
	mov.w	#6, r14
	mov.w	r12, r15
	mov.w	r13, -56(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-56(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, -20(r4)
	jmp	.LBB4_6
.LBB4_8:                                ; %while.end
	mov.w	-14(r4), r12
	mov.w	-18(r4), r15
	mov.w	-10(r4), r13
	mov.w	#6, r14
	mov.w	r12, -58(r4)            ; 2-byte Folded Spill
	mov.w	r13, -60(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-60(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, -62(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-62(r4), r12            ; 2-byte Folded Reload
	mov.w	-58(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 2(r12)
	jmp	.LBB4_10
.LBB4_9:                                ; %if.else
	mov.w	-14(r4), r12
	mov.w	-8(r4), r15
	mov.w	-10(r4), r13
	mov.w	#6, r14
	mov.w	r12, -64(r4)            ; 2-byte Folded Spill
	mov.w	r13, -66(r4)            ; 2-byte Folded Spill
	call	#__mulhi3hw_noint
	mov.w	-66(r4), r12            ; 2-byte Folded Reload
	add.w	r15, r12
	mov.w	r12, -68(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-68(r4), r12            ; 2-byte Folded Reload
	mov.w	-64(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 4(r12)
	jmp	.LBB4_10
.LBB4_10:                               ; %if.end.23
	mov.w	66(r1), r10
	mov.w	68(r1), r11
	mov.w	70(r1), r4
	mov.w	72(r1), r14
	call	#checkpoint
	add.w	#74, r1
	mov.w	r14, r0
.Lfunc_end4:
	.size	_ratchet_add_node, .Lfunc_end4-_ratchet_add_node

	.globl	_ratchet_append_compressed
	.align	2
	.type	_ratchet_append_compressed,@function
_ratchet_append_compressed:             ; @_ratchet_append_compressed
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#18, r1
	;DEBUG_VALUE: append_compressed:parent <- undef
	;DEBUG_VALUE: append_compressed:log <- undef
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r14, -8(r4)             ; 2-byte Folded Spill
	mov.w	r15, -10(r4)            ; 2-byte Folded Spill
	mov.w	r12, -12(r4)            ; 2-byte Folded Spill
	mov.w	r13, -14(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-10(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -4(r4)
	mov.w	-8(r4), r13             ; 2-byte Folded Reload
	mov.w	r13, -6(r4)
	mov.w	-4(r4), r14
	mov.w	128(r13), r15
	mov.w	r15, r11
	add.w	#1, r11
	mov.w	r14, -16(r4)            ; 2-byte Folded Spill
	mov.w	r15, -18(r4)            ; 2-byte Folded Spill
	mov.w	r11, -20(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-8(r4), r12             ; 2-byte Folded Reload
	mov.w	-20(r4), r13            ; 2-byte Folded Reload
	mov.w	r13, 128(r12)
	mov.w	-6(r4), r13
	mov.w	-18(r4), r14            ; 2-byte Folded Reload
	rla.w	r14
	add.w	r14, r13
	mov.w	-16(r4), r14            ; 2-byte Folded Reload
	mov.w	r14, 0(r13)
	mov.w	18(r1), r11
	mov.w	20(r1), r4
	mov.w	22(r1), r14
	call	#checkpoint
	add.w	#24, r1
	mov.w	r14, r0
.Lfunc_end5:
	.size	_ratchet_append_compressed, .Lfunc_end5-_ratchet_append_compressed

	.globl	init
	.align	2
	.type	init,@function
init:                                   ; @init
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#4, r1
	call	#init_hw
	;APP
	nop { eint { nop
	;NO_APP
	jmp	.LBB6_1
.LBB6_1:                                ; %do.body
	call	#request_non_interactive_debug_mode
	mov.w	r1, r12
	mov.w	#.L.str.2, 0(r12)
	call	#printf
	mov.w	r15, -2(r4)             ; 2-byte Folded Spill
	call	#resume_application
	jmp	.LBB6_2
.LBB6_2:                                ; %do.end
	add.w	#4, r1
	pop.w	r4
	ret
.Lfunc_end6:
	.size	init, .Lfunc_end6-init

	.globl	main
	.align	2
	.type	main,@function
main:                                   ; @main
; BB#0:                                 ; %entry
	mov.b	&chkpt_ever_taken, r12
	cmp.b	#0, r12
	jeq	.LBB_FIRST
	jmp	.LBB_NOTFIRST
.LBB_NOTFIRST:
	mov.w	#9216, R1
	jmp	.LBB_FIRST
.LBB_FIRST:
	push.w	r4
	mov.w	r1, r4
	sub.w	#38, r1
	mov.w	#0, -2(r4)
	call	#init
	call	#restore_regs
	jmp	.LBB7_1
.LBB7_1:                                ; %while.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB7_2 Depth 2
                                        ;       Child Loop BB7_4 Depth 3
                                        ;         Child Loop BB7_9 Depth 4
                                        ;           Child Loop BB7_13 Depth 5
                                        ;           Child Loop BB7_15 Depth 5
	;DEBUG_VALUE: cnt <- [FP+-4]
	mov.w	#0, -4(r4)
	jmp	.LBB7_2
.LBB7_2:                                ; %for.cond
                                        ;   Parent Loop BB7_1 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB7_4 Depth 3
                                        ;         Child Loop BB7_9 Depth 4
                                        ;           Child Loop BB7_13 Depth 5
                                        ;           Child Loop BB7_15 Depth 5
	mov.w	-4(r4), r12
	cmp.w	#0, r12
	jne	.LBB7_23
	jmp	.LBB7_3
.LBB7_3:                                ; %for.body
                                        ;   in Loop: Header=BB7_2 Depth=2
	mov.w	#main.dict, r15
	call	#_ratchet_init_dict
	;DEBUG_VALUE: letter <- [FP+-6]
	mov.w	#0, -6(r4)
	;DEBUG_VALUE: letter_idx <- [FP+-8]
	mov.w	#0, -8(r4)
	;DEBUG_VALUE: parent <- [FP+-10]
	;DEBUG_VALUE: child <- [FP+-12]
	;DEBUG_VALUE: sample <- [FP+-14]
	;DEBUG_VALUE: prev_sample <- [FP+-16]
	mov.w	#0, -16(r4)
	mov.w	#1, &main.log+130
	mov.w	#0, &main.log+128
	jmp	.LBB7_4
.LBB7_4:                                ; %while.body.2
                                        ;   Parent Loop BB7_1 Depth=1
                                        ;     Parent Loop BB7_2 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB7_9 Depth 4
                                        ;           Child Loop BB7_13 Depth 5
                                        ;           Child Loop BB7_15 Depth 5
	mov.w	-6(r4), r12
	mov.w	r12, -12(r4)
	mov.w	-8(r4), r12
	cmp.w	#0, r12
	jne	.LBB7_6
	jmp	.LBB7_5
.LBB7_5:                                ; %if.then
                                        ;   in Loop: Header=BB7_4 Depth=3
	mov.w	-16(r4), r15
	call	#_ratchet_acquire_sample
	mov.w	r15, -14(r4)
	mov.w	r15, -16(r4)
	jmp	.LBB7_6
.LBB7_6:                                ; %if.end
                                        ;   in Loop: Header=BB7_4 Depth=3
	mov.w	-8(r4), r12
	add.w	#1, r12
	mov.w	r12, -22(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-22(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -8(r4)
	cmp.w	#2, r12
	jne	.LBB7_8
	jmp	.LBB7_7
.LBB7_7:                                ; %if.then.5
                                        ;   in Loop: Header=BB7_4 Depth=3
	call	#checkpoint
	mov.w	#0, -8(r4)
	jmp	.LBB7_8
.LBB7_8:                                ; %if.end.6
                                        ;   in Loop: Header=BB7_4 Depth=3
	jmp	.LBB7_9
.LBB7_9:                                ; %do.body
                                        ;   Parent Loop BB7_1 Depth=1
                                        ;     Parent Loop BB7_2 Depth=2
                                        ;       Parent Loop BB7_4 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB7_13 Depth 5
                                        ;           Child Loop BB7_15 Depth 5
	;DEBUG_VALUE: letter_idx_tmp <- [FP+-18]
	mov.w	-8(r4), r12
	cmp.w	#0, r12
	jne	.LBB7_11
	jmp	.LBB7_10
.LBB7_10:                               ; %cond.true
                                        ;   in Loop: Header=BB7_9 Depth=4
	mov.w	#2, r12
	mov.w	r12, -24(r4)            ; 2-byte Folded Spill
	jmp	.LBB7_12
.LBB7_11:                               ; %cond.false
                                        ;   in Loop: Header=BB7_9 Depth=4
	mov.w	-8(r4), r12
	add.w	#-1, r12
	mov.w	r12, -24(r4)            ; 2-byte Folded Spill
	jmp	.LBB7_12
.LBB7_12:                               ; %cond.end
                                        ;   in Loop: Header=BB7_9 Depth=4
	;DEBUG_VALUE: letter_shift <- [FP+-20]
	mov.w	-24(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -18(r4)
	rla.w	r12
	rla.w	r12
	rla.w	r12
	mov.w	r12, -20(r4)
	mov.w	-14(r4), r12
	mov.b	-20(r4), r13
	mov.w	#255, r14
	cmp.b	#0, r13
	mov.b	r13, r15
	mov.w	r12, -26(r4)            ; 2-byte Folded Spill
	mov.b	r13, -27(r4)            ; 1-byte Folded Spill
	mov.w	r14, -30(r4)            ; 2-byte Folded Spill
	mov.b	r15, -31(r4)            ; 1-byte Folded Spill
	jeq	.LBB7_14
.LBB7_13:                               ; %cond.end
                                        ;   Parent Loop BB7_1 Depth=1
                                        ;     Parent Loop BB7_2 Depth=2
                                        ;       Parent Loop BB7_4 Depth=3
                                        ;         Parent Loop BB7_9 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	mov.b	-31(r4), r12            ; 1-byte Folded Reload
	mov.w	-30(r4), r13            ; 2-byte Folded Reload
	rla.w	r13
	sub.b	#1, r12
	mov.w	r13, -30(r4)            ; 2-byte Folded Spill
	mov.b	r12, -31(r4)            ; 1-byte Folded Spill
	jne	.LBB7_13
.LBB7_14:                               ; %cond.end
                                        ;   in Loop: Header=BB7_9 Depth=4
	mov.w	-30(r4), r12            ; 2-byte Folded Reload
	mov.w	-26(r4), r13            ; 2-byte Folded Reload
	and.w	r12, r13
	mov.b	-27(r4), r14            ; 1-byte Folded Reload
	cmp.b	#0, r14
	mov.b	r14, -32(r4)            ; 1-byte Folded Spill
	mov.w	r13, -34(r4)            ; 2-byte Folded Spill
	jeq	.LBB7_16
.LBB7_15:                               ; %cond.end
                                        ;   Parent Loop BB7_1 Depth=1
                                        ;     Parent Loop BB7_2 Depth=2
                                        ;       Parent Loop BB7_4 Depth=3
                                        ;         Parent Loop BB7_9 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	mov.b	-32(r4), r12            ; 1-byte Folded Reload
	mov.w	-34(r4), r13            ; 2-byte Folded Reload
	clrc
	rrc.w	r13
	sub.b	#1, r12
	mov.w	r13, -34(r4)            ; 2-byte Folded Spill
	mov.b	r12, -32(r4)            ; 1-byte Folded Spill
	jne	.LBB7_15
.LBB7_16:                               ; %cond.end
                                        ;   in Loop: Header=BB7_9 Depth=4
	mov.w	-34(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -6(r4)
	mov.w	&main.log+130, r12
	add.w	#1, r12
	mov.w	r12, -36(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-36(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, &main.log+130
	mov.w	-12(r4), r12
	mov.w	r12, -10(r4)
	mov.w	-6(r4), r15
	mov.w	#main.dict, r13
	mov.w	r12, r14
	call	#_ratchet_find_child
	mov.w	r15, -12(r4)
	jmp	.LBB7_17
.LBB7_17:                               ; %do.cond
                                        ;   in Loop: Header=BB7_9 Depth=4
	mov.w	-12(r4), r12
	cmp.w	#0, r12
	jne	.LBB7_9
	jmp	.LBB7_18
.LBB7_18:                               ; %do.end
                                        ;   in Loop: Header=BB7_4 Depth=3
	mov.w	-10(r4), r15
	mov.w	#main.log, r14
	call	#_ratchet_append_compressed
	mov.w	-6(r4), r15
	mov.w	-10(r4), r14
	mov.w	#main.dict, r13
	call	#_ratchet_add_node
	mov.w	&main.log+128, r13
	cmp.w	#64, r13
	jne	.LBB7_20
	jmp	.LBB7_19
.LBB7_19:                               ; %if.then.12
                                        ;   in Loop: Header=BB7_2 Depth=2
	call	#checkpoint
	mov.w	#0, &main.log+128
	mov.w	#0, &main.log+130
	jmp	.LBB7_21
.LBB7_20:                               ; %if.end.13
                                        ;   in Loop: Header=BB7_4 Depth=3
	jmp	.LBB7_4
.LBB7_21:                               ; %while.end
                                        ;   in Loop: Header=BB7_2 Depth=2
	jmp	.LBB7_22
.LBB7_22:                               ; %for.inc
                                        ;   in Loop: Header=BB7_2 Depth=2
	mov.w	-4(r4), r12
	add.w	#1, r12
	mov.w	r12, -38(r4)            ; 2-byte Folded Spill
	call	#checkpoint
	mov.w	-38(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -4(r4)
	jmp	.LBB7_2
.LBB7_23:                               ; %for.end
                                        ;   in Loop: Header=BB7_1 Depth=1
	jmp	.LBB7_1
.Lfunc_end7:
	.size	main, .Lfunc_end7-main

	.align	2
	.type	init_hw,@function
init_hw:                                ; @init_hw
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	call	#msp_watchdog_disable
	mov.w	&PM5CTL0, r12
	and.w	#-2, r12
	mov.w	r12, &PM5CTL0
	call	#msp_clock_setup
	pop.w	r4
	ret
.Lfunc_end8:
	.size	init_hw, .Lfunc_end8-init_hw

	.globl	msp_watchdog_enable
	.align	2
	.type	msp_watchdog_enable,@function
msp_watchdog_enable:                    ; @msp_watchdog_enable
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	;DEBUG_VALUE: msp_watchdog_enable:bits <- R15
	;DEBUG_VALUE: msp_watchdog_enable:bits <- R15
	mov.b	r15, r12
	bis.w	#23048, r15
	mov.w	r15, &WDTCTL
	mov.b	r12, &watchdog_bits
	pop.w	r4
	ret
.Lfunc_end9:
	.size	msp_watchdog_enable, .Lfunc_end9-msp_watchdog_enable

	.globl	msp_watchdog_disable
	.align	2
	.type	msp_watchdog_disable,@function
msp_watchdog_disable:                   ; @msp_watchdog_disable
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.w	#23168, &WDTCTL
	pop.w	r4
	ret
.Lfunc_end10:
	.size	msp_watchdog_disable, .Lfunc_end10-msp_watchdog_disable

	.globl	msp_watchdog_kick
	.align	2
	.type	msp_watchdog_kick,@function
msp_watchdog_kick:                      ; @msp_watchdog_kick
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	&watchdog_bits, r12
	bis.w	#23048, r12
	mov.w	r12, &WDTCTL
	pop.w	r4
	ret
.Lfunc_end11:
	.size	msp_watchdog_kick, .Lfunc_end11-msp_watchdog_kick

	.globl	memcpy
	.align	2
	.type	memcpy,@function
memcpy:                                 ; @memcpy
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#8, r1
	;DEBUG_VALUE: memcpy:dest <- R15
	;DEBUG_VALUE: memcpy:src <- R14
	;DEBUG_VALUE: memcpy:n <- R13
	;DEBUG_VALUE: memcpy:n <- R13
	;DEBUG_VALUE: memcpy:src <- R14
	;DEBUG_VALUE: memcpy:dest <- R15
	;DEBUG_VALUE: memcpy:i <- 0
	mov.w	r13, r12
	;DEBUG_VALUE: memcpy:src <- R14
	;DEBUG_VALUE: memcpy:dest <- R15
	cmp.w	#0, r13
	mov.w	r15, -2(r4)             ; 2-byte Folded Spill
	;DEBUG_VALUE: memcpy:dest <- [FP+-2]
	mov.w	r12, -4(r4)             ; 2-byte Folded Spill
	mov.w	r14, -6(r4)             ; 2-byte Folded Spill
	;DEBUG_VALUE: memcpy:src <- [FP+-6]
	jeq	.LBB12_4
	jmp	.LBB12_1
.LBB12_1:                               ; %while.body.preheader
	mov.w	#0, r12
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	jmp	.LBB12_2
.LBB12_2:                               ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-8(r4), r12             ; 2-byte Folded Reload
	mov.w	-6(r4), r13             ; 2-byte Folded Reload
	add.w	r12, r13
	mov.b	0(r13), r14
	mov.w	-2(r4), r13             ; 2-byte Folded Reload
	add.w	r12, r13
	mov.b	r14, 0(r13)
	add.w	#1, r12
	;DEBUG_VALUE: memcpy:i <- R12
	mov.w	-4(r4), r13             ; 2-byte Folded Reload
	cmp.w	r13, r12
	mov.w	r12, -8(r4)             ; 2-byte Folded Spill
	jne	.LBB12_2
	jmp	.LBB12_3
.LBB12_3:                               ; %while.end.loopexit
	jmp	.LBB12_4
.LBB12_4:                               ; %while.end
	mov.w	-2(r4), r15             ; 2-byte Folded Reload
	add.w	#8, r1
	pop.w	r4
	ret
.Lfunc_end12:
	.size	memcpy, .Lfunc_end12-memcpy

	.globl	msp_clock_setup
	.align	2
	.type	msp_clock_setup,@function
msp_clock_setup:                        ; @msp_clock_setup
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	mov.b	#-91, &CSCTL0_H
	mov.w	#70, &CSCTL1
	mov.w	#307, &CSCTL2
	mov.w	#0, &CSCTL3
	pop.w	r4
	ret
.Lfunc_end13:
	.size	msp_clock_setup, .Lfunc_end13-msp_clock_setup

	.globl	mult16
	.align	2
	.type	mult16,@function
mult16:                                 ; @mult16
; BB#0:                                 ; %entry
	;APP
	MOV R15, &0x04C0
MOV R14, &0x04C8
MOV &0x04CA, R14
MOV &0x04CC, R15
RET

	;NO_APP
.Lfunc_end14:
	.size	mult16, .Lfunc_end14-mult16

	.globl	sqrt16
	.align	2
	.type	sqrt16,@function
sqrt16:                                 ; @sqrt16
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#30, r1
	;DEBUG_VALUE: sqrt16:x <- undef
	mov.w	r15, r12
	mov.w	r14, r13
	mov.w	r15, -6(r4)
	mov.w	r14, -8(r4)
	mov.w	#-1, -10(r4)
	mov.w	#0, -12(r4)
	mov.w	-10(r4), r14
	clrc
	rrc.w	r14
	mov.w	r14, -14(r4)
	mov.w	#0, -18(r4)
	mov.w	#0, -20(r4)
	mov.w	r13, -22(r4)            ; 2-byte Folded Spill
	mov.w	r12, -24(r4)            ; 2-byte Folded Spill
	jmp	.LBB15_1
.LBB15_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-20(r4), r12
	mov.w	-18(r4), r13
	mov.w	-8(r4), r14
	mov.w	-6(r4), r15
	mov.b	#0, r11
	xor.w	r15, r13
	xor.w	r14, r12
	bis.w	r13, r12
	cmp.w	#0, r12
	mov.b	r11, -25(r4)            ; 1-byte Folded Spill
	jeq	.LBB15_3
	jmp	.LBB15_2
.LBB15_2:                               ; %land.rhs
                                        ;   in Loop: Header=BB15_1 Depth=1
	mov.w	-10(r4), r12
	mov.w	-12(r4), r13
	sub.w	r13, r12
	cmp.w	#2, r12
	mov.w	r2, r12
	and.w	#1, r12
	mov.b	r12, r14
	mov.b	r14, -25(r4)            ; 1-byte Folded Spill
	jmp	.LBB15_3
.LBB15_3:                               ; %land.end
                                        ;   in Loop: Header=BB15_1 Depth=1
	mov.b	-25(r4), r12            ; 1-byte Folded Reload
	mov.b	r12, r13
	bit.w	#1, r13
	jeq	.LBB15_10
	jmp	.LBB15_4
.LBB15_4:                               ; %while.body
                                        ;   in Loop: Header=BB15_1 Depth=1
	mov.w	-10(r4), r12
	mov.w	-12(r4), r13
	mov.w	#0, r14
	add.w	r13, r12
	addc.w	#0, r14
	clrc
	rrc.w	r12
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	rla.w	r14
	bis.w	r14, r12
	mov.w	r12, -14(r4)
	mov.w	r12, r15
	mov.w	r12, r14
	call	#mult16
	mov.w	r15, -18(r4)
	mov.w	r14, -20(r4)
	mov.w	-8(r4), r12
	mov.w	-6(r4), r13
	cmp.w	r13, r15
	mov.w	r2, r11
	and.w	#1, r11
	cmp.w	r12, r14
	mov.w	r2, r12
	and.w	#1, r12
	cmp.w	r13, r15
	mov.w	r11, -28(r4)            ; 2-byte Folded Spill
	mov.w	r12, -30(r4)            ; 2-byte Folded Spill
	jeq	.LBB15_6
; BB#5:                                 ; %while.body
                                        ;   in Loop: Header=BB15_1 Depth=1
	mov.w	-28(r4), r12            ; 2-byte Folded Reload
	mov.w	r12, -30(r4)            ; 2-byte Folded Spill
.LBB15_6:                               ; %while.body
                                        ;   in Loop: Header=BB15_1 Depth=1
	mov.w	-30(r4), r12            ; 2-byte Folded Reload
	bit.w	#1, r12
	jne	.LBB15_8
	jmp	.LBB15_7
.LBB15_7:                               ; %if.then
                                        ;   in Loop: Header=BB15_1 Depth=1
	mov.w	-14(r4), r12
	mov.w	r12, -12(r4)
	jmp	.LBB15_9
.LBB15_8:                               ; %if.else
                                        ;   in Loop: Header=BB15_1 Depth=1
	mov.w	-14(r4), r12
	mov.w	r12, -10(r4)
	jmp	.LBB15_9
.LBB15_9:                               ; %if.end
                                        ;   in Loop: Header=BB15_1 Depth=1
	jmp	.LBB15_1
.LBB15_10:                              ; %while.end
	mov.w	-14(r4), r15
	add.w	#30, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end15:
	.size	sqrt16, .Lfunc_end15-sqrt16

	.globl	udivmodhi4
	.align	2
	.type	udivmodhi4,@function
udivmodhi4:                             ; @udivmodhi4
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	push.w	r10
	sub.w	#20, r1
	;DEBUG_VALUE: udivmodhi4:num <- undef
	;DEBUG_VALUE: udivmodhi4:den <- undef
	;DEBUG_VALUE: udivmodhi4:modwanted <- undef
	mov.w	r13, r12
	mov.w	r14, r11
	mov.w	r15, r10
	mov.w	r15, -8(r4)
	mov.w	r14, -10(r4)
	mov.w	r13, -12(r4)
	mov.w	#1, -14(r4)
	mov.w	#0, -16(r4)
	mov.w	r12, -18(r4)            ; 2-byte Folded Spill
	mov.w	r11, -20(r4)            ; 2-byte Folded Spill
	mov.w	r10, -22(r4)            ; 2-byte Folded Spill
	jmp	.LBB16_1
.LBB16_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-10(r4), r12
	mov.w	-8(r4), r13
	mov.b	#0, r14
	cmp.w	r13, r12
	mov.b	r14, -23(r4)            ; 1-byte Folded Spill
	jhs	.LBB16_4
	jmp	.LBB16_2
.LBB16_2:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB16_1 Depth=1
	mov.w	-14(r4), r12
	mov.b	#0, r13
	cmp.w	#0, r12
	mov.b	r13, -23(r4)            ; 1-byte Folded Spill
	jeq	.LBB16_4
	jmp	.LBB16_3
.LBB16_3:                               ; %land.rhs
                                        ;   in Loop: Header=BB16_1 Depth=1
	mov.b	-9(r4), r12
	bit.b	#-128, r12
	mov.w	r2, r13
	rra.w	r13
	and.w	#1, r13
	mov.b	r13, r12
	mov.b	r12, -23(r4)            ; 1-byte Folded Spill
	jmp	.LBB16_4
.LBB16_4:                               ; %land.end
                                        ;   in Loop: Header=BB16_1 Depth=1
	mov.b	-23(r4), r12            ; 1-byte Folded Reload
	mov.b	r12, r13
	bit.w	#1, r13
	jeq	.LBB16_6
	jmp	.LBB16_5
.LBB16_5:                               ; %while.body
                                        ;   in Loop: Header=BB16_1 Depth=1
	mov.w	-10(r4), r12
	rla.w	r12
	mov.w	r12, -10(r4)
	mov.w	-14(r4), r12
	rla.w	r12
	mov.w	r12, -14(r4)
	jmp	.LBB16_1
.LBB16_6:                               ; %while.end
	jmp	.LBB16_7
.LBB16_7:                               ; %while.cond.3
                                        ; =>This Inner Loop Header: Depth=1
	mov.w	-14(r4), r12
	cmp.w	#0, r12
	jeq	.LBB16_11
	jmp	.LBB16_8
.LBB16_8:                               ; %while.body.5
                                        ;   in Loop: Header=BB16_7 Depth=1
	mov.w	-8(r4), r12
	mov.w	-10(r4), r13
	cmp.w	r13, r12
	jlo	.LBB16_10
	jmp	.LBB16_9
.LBB16_9:                               ; %if.then
                                        ;   in Loop: Header=BB16_7 Depth=1
	mov.w	-10(r4), r12
	mov.w	-8(r4), r13
	sub.w	r12, r13
	mov.w	r13, -8(r4)
	mov.w	-14(r4), r12
	mov.w	-16(r4), r13
	bis.w	r12, r13
	mov.w	r13, -16(r4)
	jmp	.LBB16_10
.LBB16_10:                              ; %if.end
                                        ;   in Loop: Header=BB16_7 Depth=1
	mov.w	-14(r4), r12
	clrc
	rrc.w	r12
	mov.w	r12, -14(r4)
	mov.w	-10(r4), r12
	clrc
	rrc.w	r12
	mov.w	r12, -10(r4)
	jmp	.LBB16_7
.LBB16_11:                              ; %while.end.8
	mov.w	-12(r4), r12
	cmp.w	#0, r12
	jeq	.LBB16_13
	jmp	.LBB16_12
.LBB16_12:                              ; %if.then.10
	mov.w	-8(r4), r12
	mov.w	r12, -6(r4)
	jmp	.LBB16_14
.LBB16_13:                              ; %if.end.11
	mov.w	-16(r4), r12
	mov.w	r12, -6(r4)
	jmp	.LBB16_14
.LBB16_14:                              ; %return
	mov.w	-6(r4), r15
	add.w	#20, r1
	pop.w	r10
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end16:
	.size	udivmodhi4, .Lfunc_end16-udivmodhi4

	.globl	__divhi3
	.align	2
	.type	__divhi3,@function
__divhi3:                               ; @__divhi3
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#12, r1
	;DEBUG_VALUE: __divhi3:a <- undef
	;DEBUG_VALUE: __divhi3:b <- undef
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -2(r4)
	mov.w	r14, -4(r4)
	mov.w	#0, -6(r4)
	mov.w	-2(r4), r14
	cmp.w	#0, r14
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	jge	.LBB17_2
	jmp	.LBB17_1
.LBB17_1:                               ; %if.then
	mov.w	-2(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -2(r4)
	mov.w	-6(r4), r12
	cmp.w	#0, r12
	mov.w	r2, r12
	rra.w	r12
	and.w	#1, r12
	mov.w	r12, -6(r4)
	jmp	.LBB17_2
.LBB17_2:                               ; %if.end
	mov.w	-4(r4), r12
	cmp.w	#0, r12
	jge	.LBB17_4
	jmp	.LBB17_3
.LBB17_3:                               ; %if.then.2
	mov.w	-4(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -4(r4)
	mov.w	-6(r4), r12
	cmp.w	#0, r12
	mov.w	r2, r12
	rra.w	r12
	and.w	#1, r12
	mov.w	r12, -6(r4)
	jmp	.LBB17_4
.LBB17_4:                               ; %if.end.7
	mov.w	-2(r4), r15
	mov.w	-4(r4), r14
	mov.w	#0, r13
	call	#udivmodhi4
	mov.w	r15, -8(r4)
	mov.w	-6(r4), r13
	cmp.w	#0, r13
	jeq	.LBB17_6
	jmp	.LBB17_5
.LBB17_5:                               ; %if.then.9
	mov.w	-8(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -8(r4)
	jmp	.LBB17_6
.LBB17_6:                               ; %if.end.11
	mov.w	-8(r4), r15
	add.w	#12, r1
	pop.w	r4
	ret
.Lfunc_end17:
	.size	__divhi3, .Lfunc_end17-__divhi3

	.globl	__modhi3
	.align	2
	.type	__modhi3,@function
__modhi3:                               ; @__modhi3
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#12, r1
	;DEBUG_VALUE: __modhi3:a <- undef
	;DEBUG_VALUE: __modhi3:b <- undef
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -2(r4)
	mov.w	r14, -4(r4)
	mov.w	#0, -6(r4)
	mov.w	-2(r4), r14
	cmp.w	#0, r14
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	mov.w	r13, -12(r4)            ; 2-byte Folded Spill
	jge	.LBB18_2
	jmp	.LBB18_1
.LBB18_1:                               ; %if.then
	mov.w	-2(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -2(r4)
	mov.w	#1, -6(r4)
	jmp	.LBB18_2
.LBB18_2:                               ; %if.end
	mov.w	-4(r4), r12
	cmp.w	#0, r12
	jge	.LBB18_4
	jmp	.LBB18_3
.LBB18_3:                               ; %if.then.2
	mov.w	-4(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -4(r4)
	jmp	.LBB18_4
.LBB18_4:                               ; %if.end.4
	mov.w	-2(r4), r15
	mov.w	-4(r4), r14
	mov.w	#1, r13
	call	#udivmodhi4
	mov.w	r15, -8(r4)
	mov.w	-6(r4), r13
	cmp.w	#0, r13
	jeq	.LBB18_6
	jmp	.LBB18_5
.LBB18_5:                               ; %if.then.5
	mov.w	-8(r4), r12
	mov.w	#0, r13
	sub.w	r12, r13
	mov.w	r13, -8(r4)
	jmp	.LBB18_6
.LBB18_6:                               ; %if.end.7
	mov.w	-8(r4), r15
	add.w	#12, r1
	pop.w	r4
	ret
.Lfunc_end18:
	.size	__modhi3, .Lfunc_end18-__modhi3

	.globl	__udivhi3
	.align	2
	.type	__udivhi3,@function
__udivhi3:                              ; @__udivhi3
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#8, r1
	;DEBUG_VALUE: __udivhi3:a <- undef
	;DEBUG_VALUE: __udivhi3:b <- undef
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -4(r4)
	mov.w	r14, -6(r4)
	mov.w	-4(r4), r15
	mov.w	#0, r11
	mov.w	r13, -8(r4)             ; 2-byte Folded Spill
	mov.w	r11, r13
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	call	#udivmodhi4
	add.w	#8, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end19:
	.size	__udivhi3, .Lfunc_end19-__udivhi3

	.globl	__umodhi3
	.align	2
	.type	__umodhi3,@function
__umodhi3:                              ; @__umodhi3
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	push.w	r11
	sub.w	#8, r1
	;DEBUG_VALUE: __umodhi3:a <- undef
	;DEBUG_VALUE: __umodhi3:b <- undef
	mov.w	r14, r12
	mov.w	r15, r13
	mov.w	r15, -4(r4)
	mov.w	r14, -6(r4)
	mov.w	-4(r4), r15
	mov.w	#1, r11
	mov.w	r13, -8(r4)             ; 2-byte Folded Spill
	mov.w	r11, r13
	mov.w	r12, -10(r4)            ; 2-byte Folded Spill
	call	#udivmodhi4
	add.w	#8, r1
	pop.w	r11
	pop.w	r4
	ret
.Lfunc_end20:
	.size	__umodhi3, .Lfunc_end20-__umodhi3

	.globl	checkpoint
	.align	2
	.type	checkpoint,@function
checkpoint:                             ; @checkpoint
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#6, r1
	;APP
	PUSH R12
	;NO_APP
	;APP
	MOV cur_reg, R12
	;NO_APP
	;APP
	MOV 10(R1), 0(R12)
	;NO_APP
	;APP
	MOV R1, 2(R12)
	;NO_APP
	;APP
	MOV R2, 4(R12)
	;NO_APP
	;APP
	ADD #12, 2(R12)
	;NO_APP
	;APP
	MOV 8(R1), 6(R12)
	;NO_APP
	;APP
	MOV R5, 8(R12)
	;NO_APP
	;APP
	MOV R6, 10(R12)
	;NO_APP
	;APP
	MOV R7, 12(R12)
	;NO_APP
	;APP
	MOV R8, 14(R12)
	;NO_APP
	;APP
	MOV R9, 16(R12)
	;NO_APP
	;APP
	MOV R10, 18(R12)
	;NO_APP
	;APP
	MOV R11, 20(R12)
	;NO_APP
	;APP
	MOV 0(R1), 22(R12)
	;NO_APP
	;APP
	MOV R13, 24(R12)
	;NO_APP
	;APP
	MOV R14, 26(R12)
	;NO_APP
	;APP
	MOV R15, 28(R12)
	;NO_APP
	;APP
	MOV R12, -2(r4)
	;NO_APP
	mov.w	&cur_reg, r12
	mov.w	#regs_0, r13
	mov.w	#regs_1, r14
	cmp.w	r13, r12
	mov.w	r13, -4(r4)             ; 2-byte Folded Spill
	mov.w	r14, -6(r4)             ; 2-byte Folded Spill
	jeq	.LBB21_2
; BB#1:                                 ; %entry
	mov.w	-4(r4), r12             ; 2-byte Folded Reload
	mov.w	r12, -6(r4)             ; 2-byte Folded Spill
.LBB21_2:                               ; %entry
	mov.w	-6(r4), r12             ; 2-byte Folded Reload
	mov.w	r12, &cur_reg
	mov.b	#0, &isStuck
	mov.w	&debug_cntr, r12
	add.w	#1, r12
	mov.w	r12, &debug_cntr
	;APP
	MOV -2(r4), R12
	;NO_APP
	;APP
	MOV 2(R12), R1
	;NO_APP
	;APP
	MOV 4(R12), R2
	;NO_APP
	;APP
	MOV 24(R12), R13
	;NO_APP
	;APP
	MOV 26(R12), R14
	;NO_APP
	;APP
	MOV 28(R12), R15
	;NO_APP
	;APP
	MOV -4(R1), R4
	;NO_APP
	;APP
	MOV -12(R1), R12
	;NO_APP
	;APP
	MOV -2(R1), R0
	;NO_APP
	add.w	#6, r1
	pop.w	r4
	ret
.Lfunc_end21:
	.size	checkpoint, .Lfunc_end21-checkpoint

	.globl	restore_regs
	.align	2
	.type	restore_regs,@function
restore_regs:                           ; @restore_regs
; BB#0:                                 ; %entry
	push.w	r4
	mov.w	r1, r4
	sub.w	#2, r1
	mov.b	&chkpt_ever_taken, r12
	cmp.b	#0, r12
	jne	.LBB22_2
	jmp	.LBB22_1
.LBB22_1:                               ; %if.then
	mov.b	#1, &chkpt_ever_taken
	jmp	.LBB22_9
.LBB22_2:                               ; %if.else
	mov.w	&cur_reg, r12
	mov.w	#regs_0, r13
	cmp.w	r13, r12
	jne	.LBB22_4
	jmp	.LBB22_3
.LBB22_3:                               ; %if.then.1
	mov.w	#regs_1, -2(r4)
	jmp	.LBB22_5
.LBB22_4:                               ; %if.else.2
	mov.w	#regs_0, -2(r4)
	jmp	.LBB22_5
.LBB22_5:                               ; %if.end
	jmp	.LBB22_6
.LBB22_6:                               ; %if.end.3
	mov.b	&isStuck, r12
	cmp.b	#1, r12
	jne	.LBB22_8
	jmp	.LBB22_7
.LBB22_7:                               ; %if.then.6
	mov.b	&PAOUT_L, r12
	bis.w	#16, r12
	mov.b	r12, r13
	mov.b	r13, &PAOUT_L
	mov.b	&PAOUT_L, r12
	and.w	#239, r12
	mov.b	r12, r13
	mov.b	r13, &PAOUT_L
	jmp	.LBB22_8
.LBB22_8:                               ; %if.end.11
	mov.b	#1, &isStuck
	;APP
	MOV -2(r4), R12
	;NO_APP
	;APP
	MOV 28(R12), R15
	;NO_APP
	;APP
	MOV 26(R12), R14
	;NO_APP
	;APP
	MOV 24(R12), R13
	;NO_APP
	;APP
	MOV 20(R12), R11
	;NO_APP
	;APP
	MOV 18(R12), R10
	;NO_APP
	;APP
	MOV 16(R12), R9
	;NO_APP
	;APP
	MOV 14(R12), R8
	;NO_APP
	;APP
	MOV 12(R12), R7
	;NO_APP
	;APP
	MOV 10(R12), R6
	;NO_APP
	;APP
	MOV 8(R12), R5
	;NO_APP
	;APP
	MOV 6(R12), R4
	;NO_APP
	;APP
	MOV 4(R12), R2
	;NO_APP
	;APP
	MOV 2(R12), R1
	;NO_APP
	;APP
	MOV 0(R12), &0x4400
	;NO_APP
	;APP
	MOV 22(R12), R12
	;NO_APP
	;APP
	MOV &0x4400, R0
	;NO_APP
	jmp	.LBB22_9
.LBB22_9:                               ; %return
	add.w	#2, r1
	pop.w	r4
	ret
.Lfunc_end22:
	.size	restore_regs, .Lfunc_end22-restore_regs

	.type	.L.str,@object          ; @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"rate: samples/block: %u/%u\r\n"
	.size	.L.str, 29

	.type	.L.str.1,@object        ; @.str.1
.L.str.1:
	.asciz	"add node: table full\r\n"
	.size	.L.str.1, 23

	.type	.L.str.2,@object        ; @.str.2
.L.str.2:
	.asciz	"reboot\r\n"
	.size	.L.str.2, 9

	.type	main.dict,@object       ; @main.dict
	.section	.nv_vars,"aw",@progbits
	.align	1
main.dict:
	.zero	3074
	.size	main.dict, 3074

	.type	main.log,@object        ; @main.log
	.align	1
main.log:
	.zero	132
	.size	main.log, 132

	.type	watchdog_bits,@object   ; @watchdog_bits
	.local	watchdog_bits
	.comm	watchdog_bits,1,1
	.type	isStuck,@object         ; @isStuck
	.globl	isStuck
isStuck:
	.byte	0                       ; 0x0
	.size	isStuck, 1

	.type	regs_0,@object          ; @regs_0
	.globl	regs_0
	.align	1
regs_0:
	.zero	32
	.size	regs_0, 32

	.type	cur_reg,@object         ; @cur_reg
	.globl	cur_reg
	.align	1
cur_reg:
	.short	regs_0
	.size	cur_reg, 2

	.type	chkpt_ever_taken,@object ; @chkpt_ever_taken
	.globl	chkpt_ever_taken
chkpt_ever_taken:
	.byte	0                       ; 0x0
	.size	chkpt_ever_taken, 1

	.type	debug_cntr,@object      ; @debug_cntr
	.globl	debug_cntr
	.align	1
debug_cntr:
	.short	0                       ; 0x0
	.size	debug_cntr, 2

	.type	regs_1,@object          ; @regs_1
	.globl	regs_1
	.align	1
regs_1:
	.zero	32
	.size	regs_1, 32


	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 18b9daa6fb72668933b1384d577f19e5d6bf8d85) (http://llvm.org/git/llvm.git be2b2c32d38ab91bfe59b53d0dea8c8404802013)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 18b9daa6fb72668933b1384d577f19e5d6bf8d85) (http://llvm.org/git/llvm.git be2b2c32d38ab91bfe59b53d0dea8c8404802013)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 18b9daa6fb72668933b1384d577f19e5d6bf8d85) (http://llvm.org/git/llvm.git be2b2c32d38ab91bfe59b53d0dea8c8404802013)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 18b9daa6fb72668933b1384d577f19e5d6bf8d85) (http://llvm.org/git/llvm.git be2b2c32d38ab91bfe59b53d0dea8c8404802013)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 18b9daa6fb72668933b1384d577f19e5d6bf8d85) (http://llvm.org/git/llvm.git be2b2c32d38ab91bfe59b53d0dea8c8404802013)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 18b9daa6fb72668933b1384d577f19e5d6bf8d85) (http://llvm.org/git/llvm.git be2b2c32d38ab91bfe59b53d0dea8c8404802013)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 18b9daa6fb72668933b1384d577f19e5d6bf8d85) (http://llvm.org/git/llvm.git be2b2c32d38ab91bfe59b53d0dea8c8404802013)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 18b9daa6fb72668933b1384d577f19e5d6bf8d85) (http://llvm.org/git/llvm.git be2b2c32d38ab91bfe59b53d0dea8c8404802013)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 18b9daa6fb72668933b1384d577f19e5d6bf8d85) (http://llvm.org/git/llvm.git be2b2c32d38ab91bfe59b53d0dea8c8404802013)"
	.ident	"clang version 3.8.0 (http://llvm.org/git/clang.git 18b9daa6fb72668933b1384d577f19e5d6bf8d85) (http://llvm.org/git/llvm.git be2b2c32d38ab91bfe59b53d0dea8c8404802013)"
	.section	".note.GNU-stack","",@progbits
