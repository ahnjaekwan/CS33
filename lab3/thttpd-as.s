	.file	"thttpd.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.type	handle_hup, @function
handle_hup:
.LASANPC2:
.LFB2:
	.cfi_startproc
	movl	$1, got_hup(%rip)
	ret
	.cfi_endproc
.LFE2:
	.size	handle_hup, .-handle_hup
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.rodata
	.align 32
.LC1:
	.string	"  thttpd - %ld connections (%g/sec), %d max simultaneous, %lld bytes (%g/sec), %d httpd_conns allocated"
	.zero	56
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.type	thttpd_logstats, @function
thttpd_logstats:
.LASANPC33:
.LFB33:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	testq	%rdi, %rdi
	jle	.L3
	movq	stats_bytes(%rip), %r8
	pxor	%xmm2, %xmm2
	movq	stats_connections(%rip), %rdx
	pxor	%xmm1, %xmm1
	pxor	%xmm0, %xmm0
	movl	httpd_conn_count(%rip), %r9d
	cvtsi2ssq	%rdi, %xmm2
	movl	stats_simultaneous(%rip), %ecx
	movl	$.LC1, %esi
	movl	$6, %edi
	cvtsi2ssq	%r8, %xmm1
	movl	$2, %eax
	cvtsi2ssq	%rdx, %xmm0
	divss	%xmm2, %xmm1
	divss	%xmm2, %xmm0
	cvtss2sd	%xmm1, %xmm1
	cvtss2sd	%xmm0, %xmm0
	call	syslog
.L3:
	movq	$0, stats_connections(%rip)
	movq	$0, stats_bytes(%rip)
	movl	$0, stats_simultaneous(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE33:
	.size	thttpd_logstats, .-thttpd_logstats
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.rodata
	.align 32
.LC3:
	.string	"throttle #%d '%.80s' rate %ld greatly exceeding limit %ld; %d sending"
	.zero	58
	.align 32
.LC4:
	.string	"throttle #%d '%.80s' rate %ld exceeding limit %ld; %d sending"
	.zero	34
	.align 32
.LC5:
	.string	"throttle #%d '%.80s' rate %ld lower than minimum %ld; %d sending"
	.zero	63
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.p2align 4,,15
	.type	update_throttles, @function
update_throttles:
.LASANPC23:
.LFB23:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movabsq	$6148914691236517206, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	xorl	%ebp, %ebp
	xorl	%ebx, %ebx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movl	numthrottles(%rip), %r11d
	testl	%r11d, %r11d
	jg	.L71
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L22:
	addl	$1, %ebx
	addq	$48, %rbp
	cmpl	%ebx, numthrottles(%rip)
	jle	.L26
.L71:
	movq	%rbp, %rcx
	addq	throttles(%rip), %rcx
	leaq	24(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L89
	movq	24(%rcx), %rax
	leaq	32(%rcx), %rdi
	leaq	(%rax,%rax), %rsi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L90
	movq	32(%rcx), %rax
	leaq	8(%rcx), %rdi
	movq	$0, 32(%rcx)
	movq	%rax, %rdx
	shrq	$63, %rdx
	addq	%rdx, %rax
	sarq	%rax
	addq	%rax, %rsi
	movq	%rsi, %rax
	sarq	$63, %rsi
	imulq	%r12
	movq	%rdi, %rax
	shrq	$3, %rax
	subq	%rsi, %rdx
	cmpb	$0, 2147450880(%rax)
	movq	%rdx, %r8
	movq	%rdx, 24(%rcx)
	jne	.L91
	movq	8(%rcx), %r9
	cmpq	%r9, %rdx
	jle	.L13
	leaq	40(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L14
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L92
.L14:
	movl	40(%rcx), %eax
	testl	%eax, %eax
	je	.L13
	leaq	(%r9,%r9), %rdx
	cmpq	%rdx, %r8
	movq	%rcx, %rdx
	jle	.L15
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L93
	subq	$8, %rsp
	.cfi_def_cfa_offset 56
	movq	(%rcx), %rcx
	movl	$5, %edi
	pushq	%rax
	.cfi_def_cfa_offset 64
	movl	%ebx, %edx
	xorl	%eax, %eax
	movl	$.LC3, %esi
	call	syslog
	movq	%rbp, %rcx
	addq	throttles(%rip), %rcx
	popq	%r9
	.cfi_def_cfa_offset 56
	popq	%r10
	.cfi_def_cfa_offset 48
	leaq	24(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L94
.L19:
	movq	24(%rcx), %r8
.L13:
	leaq	16(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L95
	movq	16(%rcx), %r9
	cmpq	%r8, %r9
	jle	.L22
	leaq	40(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L23
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L96
.L23:
	movl	40(%rcx), %eax
	testl	%eax, %eax
	je	.L22
	movq	%rcx, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L97
	subq	$8, %rsp
	.cfi_def_cfa_offset 56
	movq	(%rcx), %rcx
	movl	%ebx, %edx
	pushq	%rax
	.cfi_def_cfa_offset 64
	movl	$.LC5, %esi
	xorl	%eax, %eax
	movl	$5, %edi
	addl	$1, %ebx
	addq	$48, %rbp
	call	syslog
	cmpl	%ebx, numthrottles(%rip)
	popq	%rax
	.cfi_def_cfa_offset 56
	popq	%rdx
	.cfi_def_cfa_offset 48
	jg	.L71
	.p2align 4,,10
	.p2align 3
.L26:
	movl	max_connects(%rip), %eax
	testl	%eax, %eax
	jle	.L6
	subl	$1, %eax
	movq	connects(%rip), %r9
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	64(%r9), %rdi
	leaq	208(%r9,%rax), %rbx
	jmp	.L29
	.p2align 4,,10
	.p2align 3
.L32:
	addq	$144, %rdi
	addq	$144, %r9
	cmpq	%rbx, %rdi
	je	.L6
.L29:
	movq	%r9, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L27
	movq	%r9, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L98
.L27:
	movl	(%r9), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L32
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L99
	leaq	-8(%rdi), %rax
	movq	$-1, (%rdi)
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L31
	movq	%rax, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L100
.L31:
	movl	-8(%rdi), %eax
	testl	%eax, %eax
	jle	.L32
	subl	$1, %eax
	movq	%rdi, %r8
	movq	throttles(%rip), %r11
	leaq	-48(%rdi), %rsi
	leaq	20(%r9,%rax,4), %r10
	movq	$-1, %rbp
	shrq	$3, %r8
	jmp	.L41
	.p2align 4,,10
	.p2align 3
.L36:
	cmpq	%rax, %rbp
	cmovle	%rbp, %rax
	cmpb	$0, 2147450880(%r8)
	jne	.L101
.L39:
	addq	$4, %rsi
	movq	%rax, (%rdi)
	cmpq	%r10, %rsi
	je	.L32
	cmpb	$0, 2147450880(%r8)
	jne	.L102
	movq	(%rdi), %rbp
.L41:
	movq	%rsi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L33
	movq	%rsi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L103
.L33:
	movslq	(%rsi), %rax
	leaq	(%rax,%rax,2), %rcx
	salq	$4, %rcx
	addq	%r11, %rcx
	leaq	8(%rcx), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L104
	leaq	40(%rcx), %rdx
	movq	8(%rcx), %rax
	movq	%rdx, %r12
	shrq	$3, %r12
	movzbl	2147450880(%r12), %r12d
	testb	%r12b, %r12b
	je	.L35
	movq	%rdx, %r13
	andl	$7, %r13d
	addl	$3, %r13d
	cmpb	%r12b, %r13b
	jge	.L105
.L35:
	movslq	40(%rcx), %rcx
	cqto
	idivq	%rcx
	cmpq	$-1, %rbp
	jne	.L36
	cmpb	$0, 2147450880(%r8)
	je	.L39
	call	__asan_report_store8
	.p2align 4,,10
	.p2align 3
.L15:
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L106
	subq	$8, %rsp
	.cfi_def_cfa_offset 56
	movq	(%rcx), %rcx
	movl	$.LC4, %esi
	pushq	%rax
	.cfi_def_cfa_offset 64
	movl	$6, %edi
	xorl	%eax, %eax
	movl	%ebx, %edx
	call	syslog
	movq	%rbp, %rcx
	addq	throttles(%rip), %rcx
	popq	%rsi
	.cfi_def_cfa_offset 56
	popq	%r8
	.cfi_def_cfa_offset 48
	leaq	24(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	je	.L19
	call	__asan_report_load8
	.p2align 4,,10
	.p2align 3
.L6:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L102:
	.cfi_restore_state
	call	__asan_report_load8
.L101:
	call	__asan_report_store8
.L105:
	movq	%rdx, %rdi
	call	__asan_report_load4
.L104:
	movq	%rax, %rdi
	call	__asan_report_load8
.L103:
	movq	%rsi, %rdi
	call	__asan_report_load4
.L100:
	movq	%rax, %rdi
	call	__asan_report_load4
.L99:
	call	__asan_report_store8
.L98:
	movq	%r9, %rdi
	call	__asan_report_load4
.L106:
	movq	%rcx, %rdi
	call	__asan_report_load8
.L97:
	movq	%rcx, %rdi
	call	__asan_report_load8
.L96:
	call	__asan_report_load4
.L95:
	call	__asan_report_load8
.L94:
	call	__asan_report_load8
.L93:
	movq	%rcx, %rdi
	call	__asan_report_load8
.L92:
	call	__asan_report_load4
.L91:
	call	__asan_report_load8
.L90:
	call	__asan_report_load8
.L89:
	call	__asan_report_load8
	.cfi_endproc
.LFE23:
	.size	update_throttles, .-update_throttles
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.rodata
	.align 32
.LC7:
	.string	"%s: no value required for %s option\n"
	.zero	59
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.p2align 4,,15
	.type	no_value_required, @function
no_value_required:
.LASANPC12:
.LFB12:
	.cfi_startproc
	testq	%rsi, %rsi
	jne	.L112
	rep; ret
.L112:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$stderr, %eax
	movq	%rdi, %rcx
	shrq	$3, %rax
	movq	argv0(%rip), %rdx
	cmpb	$0, 2147450880(%rax)
	jne	.L113
	movq	stderr(%rip), %rdi
	movl	$.LC7, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L113:
	movl	$stderr, %edi
	call	__asan_report_load8
	.cfi_endproc
.LFE12:
	.size	no_value_required, .-no_value_required
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.rodata
	.align 32
.LC9:
	.string	"%s: value required for %s option\n"
	.zero	62
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.p2align 4,,15
	.type	value_required, @function
value_required:
.LASANPC11:
.LFB11:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L119
	rep; ret
.L119:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$stderr, %eax
	movq	%rdi, %rcx
	shrq	$3, %rax
	movq	argv0(%rip), %rdx
	cmpb	$0, 2147450880(%rax)
	jne	.L120
	movq	stderr(%rip), %rdi
	movl	$.LC9, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L120:
	movl	$stderr, %edi
	call	__asan_report_load8
	.cfi_endproc
.LFE11:
	.size	value_required, .-value_required
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.rodata
	.align 32
.LC11:
	.string	"usage:  %s [-C configfile] [-p port] [-d dir] [-r|-nor] [-dd data_dir] [-s|-nos] [-v|-nov] [-g|-nog] [-u user] [-c cgipat] [-t throttles] [-h host] [-l logfile] [-i pidfile] [-T charset] [-P P3P] [-M maxage] [-V] [-D]\n"
	.zero	37
	.section	.text.unlikely
.LCOLDB12:
.LHOTB12:
	.type	usage, @function
usage:
.LASANPC9:
.LFB9:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	je	.L122
	movl	$stderr, %edi
	call	__asan_report_load8
.L122:
	movq	stderr(%rip), %rdi
	movl	$.LC11, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE9:
	.size	usage, .-usage
.LCOLDE12:
.LHOTE12:
.LCOLDB13:
	.text
.LHOTB13:
	.p2align 4,,15
	.type	wakeup_connection, @function
wakeup_connection:
.LASANPC28:
.LFB28:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsp, %rax
	movq	%rdi, (%rsp)
	movq	%rsp, %rdi
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L151
	movq	(%rsp), %rsi
	leaq	96(%rsi), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L152
	movq	%rsi, %rax
	movq	$0, 96(%rsi)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L127
	movq	%rsi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L153
.L127:
	cmpl	$3, (%rsi)
	je	.L154
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L154:
	.cfi_restore_state
	movq	%rsi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L129
	movq	%rsi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L155
.L129:
	leaq	8(%rsi), %rdi
	movl	$2, (%rsi)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L156
	movq	8(%rsi), %rax
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L131
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L157
.L131:
	movl	704(%rax), %edi
	movl	$1, %edx
	call	fdwatch_add_fd
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L153:
	.cfi_restore_state
	movq	%rsi, %rdi
	call	__asan_report_load4
.L152:
	call	__asan_report_store8
.L151:
	call	__asan_report_load8
.L157:
	call	__asan_report_load4
.L156:
	call	__asan_report_load8
.L155:
	movq	%rsi, %rdi
	call	__asan_report_store4
	.cfi_endproc
.LFE28:
	.size	wakeup_connection, .-wakeup_connection
	.section	.text.unlikely
.LCOLDE13:
	.text
.LHOTE13:
	.globl	__asan_stack_malloc_1
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC14:
	.string	"1 32 16 2 tv "
	.section	.rodata
	.align 32
.LC15:
	.string	"up %ld seconds, stats for %ld seconds:"
	.zero	57
	.section	.text.unlikely
.LCOLDB16:
	.text
.LHOTB16:
	.p2align 4,,15
	.type	logstats, @function
logstats:
.LASANPC32:
.LFB32:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$104, %rsp
	.cfi_def_cfa_offset 144
	movl	__asan_option_detect_stack_use_after_return(%rip), %eax
	movq	%rsp, %rbp
	movq	%rsp, %r13
	testl	%eax, %eax
	jne	.L166
.L158:
	movq	%rbp, %r12
	movq	$1102416563, 0(%rbp)
	movq	$.LC14, 8(%rbp)
	shrq	$3, %r12
	testq	%rbx, %rbx
	movq	$.LASANPC32, 16(%rbp)
	movl	$-235802127, 2147450880(%r12)
	movl	$-185335808, 2147450884(%r12)
	movl	$-202116109, 2147450888(%r12)
	je	.L167
.L162:
	movq	%rbx, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L168
	movq	(%rbx), %rax
	movl	$1, %ecx
	movl	$.LC15, %esi
	movl	$6, %edi
	movq	%rax, %rdx
	movq	%rax, %rbx
	subq	start_time(%rip), %rdx
	subq	stats_time(%rip), %rbx
	movq	%rax, stats_time(%rip)
	cmove	%rcx, %rbx
	xorl	%eax, %eax
	movq	%rbx, %rcx
	call	syslog
	movq	%rbx, %rdi
	call	thttpd_logstats
	movq	%rbx, %rdi
	call	httpd_logstats
	movq	%rbx, %rdi
	call	mmc_logstats
	movq	%rbx, %rdi
	call	fdwatch_logstats
	movq	%rbx, %rdi
	call	tmr_logstats
	cmpq	%rbp, %r13
	jne	.L169
	movq	$0, 2147450880(%r12)
	movl	$0, 2147450888(%r12)
.L160:
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L167:
	.cfi_restore_state
	leaq	32(%rbp), %rbx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	call	gettimeofday
	jmp	.L162
.L169:
	movabsq	$-723401728380766731, %rax
	movq	$1172321806, 0(%rbp)
	movl	$-168430091, 2147450888(%r12)
	movq	%rax, 2147450880(%r12)
	jmp	.L160
.L166:
	movq	%rsp, %rsi
	movl	$96, %edi
	call	__asan_stack_malloc_1
	movq	%rax, %rbp
	jmp	.L158
.L168:
	movq	%rbx, %rdi
	call	__asan_report_load8
	.cfi_endproc
.LFE32:
	.size	logstats, .-logstats
	.section	.text.unlikely
.LCOLDE16:
	.text
.LHOTE16:
	.section	.text.unlikely
.LCOLDB17:
	.text
.LHOTB17:
	.p2align 4,,15
	.type	show_stats, @function
show_stats:
.LASANPC31:
.LFB31:
	.cfi_startproc
	movq	%rsi, %rdi
	jmp	logstats
	.cfi_endproc
.LFE31:
	.size	show_stats, .-show_stats
	.section	.text.unlikely
.LCOLDE17:
	.text
.LHOTE17:
	.section	.text.unlikely
.LCOLDB18:
	.text
.LHOTB18:
	.p2align 4,,15
	.type	handle_usr2, @function
handle_usr2:
.LASANPC4:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	__errno_location
	movq	%rax, %rbx
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L172
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L187
.L172:
	xorl	%edi, %edi
	movl	(%rbx), %ebp
	call	logstats
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L173
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L188
.L173:
	movl	%ebp, (%rbx)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L188:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	__asan_report_store4
.L187:
	movq	%rbx, %rdi
	call	__asan_report_load4
	.cfi_endproc
.LFE4:
	.size	handle_usr2, .-handle_usr2
	.section	.text.unlikely
.LCOLDE18:
	.text
.LHOTE18:
	.section	.text.unlikely
.LCOLDB19:
	.text
.LHOTB19:
	.p2align 4,,15
	.type	occasional, @function
occasional:
.LASANPC30:
.LFB30:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rsi, %rdi
	call	mmc_cleanup
	call	tmr_cleanup
	movl	$1, watchdog_flag(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE30:
	.size	occasional, .-occasional
	.section	.text.unlikely
.LCOLDE19:
	.text
.LHOTE19:
	.section	.rodata
	.align 32
.LC20:
	.string	"/tmp"
	.zero	59
	.section	.text.unlikely
.LCOLDB21:
	.text
.LHOTB21:
	.p2align 4,,15
	.type	handle_alrm, @function
handle_alrm:
.LASANPC5:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	__errno_location
	movq	%rax, %rbx
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L192
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L208
.L192:
	movl	watchdog_flag(%rip), %eax
	movl	(%rbx), %ebp
	testl	%eax, %eax
	je	.L209
	movl	$360, %edi
	movl	$0, watchdog_flag(%rip)
	call	alarm
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L194
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L210
.L194:
	movl	%ebp, (%rbx)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L210:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	__asan_report_store4
.L208:
	movq	%rbx, %rdi
	call	__asan_report_load4
.L209:
	movl	$.LC20, %edi
	call	chdir
	call	__asan_handle_no_return
	call	abort
	.cfi_endproc
.LFE5:
	.size	handle_alrm, .-handle_alrm
	.section	.text.unlikely
.LCOLDE21:
	.text
.LHOTE21:
	.section	.rodata.str1.1
.LC22:
	.string	"1 32 4 6 status "
	.section	.rodata
	.align 32
.LC23:
	.string	"child wait - %m"
	.zero	48
	.section	.text.unlikely
.LCOLDB24:
	.text
.LHOTB24:
	.p2align 4,,15
	.type	handle_chld, @function
handle_chld:
.LASANPC1:
.LFB1:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	movl	__asan_option_detect_stack_use_after_return(%rip), %eax
	leaq	16(%rsp), %rbp
	testl	%eax, %eax
	jne	.L267
.L211:
	movq	%rbp, %r13
	movq	$1102416563, 0(%rbp)
	movq	$.LC22, 8(%rbp)
	shrq	$3, %r13
	movq	$.LASANPC1, 16(%rbp)
	leaq	96(%rbp), %r12
	movl	$-235802127, 2147450880(%r13)
	movl	$-185273340, 2147450884(%r13)
	movl	$-202116109, 2147450888(%r13)
	call	__errno_location
	movq	%rax, %rbx
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L215
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L268
.L215:
	movq	%rbx, %rax
	movl	(%rbx), %r15d
	movq	%rbx, %r14
	andl	$7, %eax
	subq	$64, %r12
	shrq	$3, %r14
	addl	$3, %eax
	movb	%al, 15(%rsp)
	.p2align 4,,10
	.p2align 3
.L216:
	movl	$1, %edx
	movq	%r12, %rsi
	movl	$-1, %edi
	call	waitpid
	testl	%eax, %eax
	je	.L221
	js	.L269
	movq	hs(%rip), %rax
	testq	%rax, %rax
	je	.L216
	leaq	36(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L222
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L270
.L222:
	movl	36(%rax), %edx
	subl	$1, %edx
	js	.L223
	movl	%edx, 36(%rax)
	jmp	.L216
	.p2align 4,,10
	.p2align 3
.L269:
	movzbl	2147450880(%r14), %eax
	testb	%al, %al
	je	.L219
	cmpb	%al, 15(%rsp)
	jge	.L271
.L219:
	movl	(%rbx), %eax
	cmpl	$11, %eax
	je	.L216
	cmpl	$4, %eax
	je	.L216
	cmpl	$10, %eax
	je	.L221
	movl	$.LC23, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L221:
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L226
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L272
.L226:
	leaq	16(%rsp), %rax
	movl	%r15d, (%rbx)
	cmpq	%rbp, %rax
	jne	.L273
	movq	$0, 2147450880(%r13)
	movl	$0, 2147450888(%r13)
.L213:
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L223:
	.cfi_restore_state
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L224
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L274
.L224:
	movl	$0, 36(%rax)
	jmp	.L216
.L274:
	call	__asan_report_store4
	.p2align 4,,10
	.p2align 3
.L273:
	movabsq	$-723401728380766731, %rax
	movq	$1172321806, 0(%rbp)
	movl	$-168430091, 2147450888(%r13)
	movq	%rax, 2147450880(%r13)
	jmp	.L213
.L267:
	movq	%rbp, %rsi
	movl	$96, %edi
	call	__asan_stack_malloc_1
	movq	%rax, %rbp
	jmp	.L211
.L272:
	movq	%rbx, %rdi
	call	__asan_report_store4
.L268:
	movq	%rbx, %rdi
	call	__asan_report_load4
.L271:
	movq	%rbx, %rdi
	call	__asan_report_load4
.L270:
	call	__asan_report_load4
	.cfi_endproc
.LFE1:
	.size	handle_chld, .-handle_chld
	.section	.text.unlikely
.LCOLDE24:
	.text
.LHOTE24:
	.section	.rodata
	.align 32
.LC25:
	.string	"out of memory copying a string"
	.zero	33
	.align 32
.LC26:
	.string	"%s: out of memory copying a string\n"
	.zero	60
	.section	.text.unlikely
.LCOLDB27:
	.text
.LHOTB27:
	.p2align 4,,15
	.type	e_strdup, @function
e_strdup:
.LASANPC13:
.LFB13:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	strdup
	testq	%rax, %rax
	je	.L279
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L279:
	.cfi_restore_state
	movl	$.LC25, %esi
	movl	$2, %edi
	call	syslog
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L280
	movq	stderr(%rip), %rdi
	movl	$.LC26, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L280:
	movl	$stderr, %edi
	call	__asan_report_load8
	.cfi_endproc
.LFE13:
	.size	e_strdup, .-e_strdup
	.section	.text.unlikely
.LCOLDE27:
	.text
.LHOTE27:
	.globl	__asan_stack_malloc_2
	.section	.rodata.str1.1
.LC28:
	.string	"1 32 100 4 line "
	.section	.rodata
	.align 32
.LC29:
	.string	"r"
	.zero	62
	.align 32
.LC30:
	.string	" \t\n\r"
	.zero	59
	.align 32
.LC31:
	.string	"debug"
	.zero	58
	.align 32
.LC32:
	.string	"port"
	.zero	59
	.align 32
.LC33:
	.string	"dir"
	.zero	60
	.align 32
.LC34:
	.string	"chroot"
	.zero	57
	.align 32
.LC35:
	.string	"nochroot"
	.zero	55
	.align 32
.LC36:
	.string	"data_dir"
	.zero	55
	.align 32
.LC37:
	.string	"symlink"
	.zero	56
	.align 32
.LC38:
	.string	"nosymlink"
	.zero	54
	.align 32
.LC39:
	.string	"symlinks"
	.zero	55
	.align 32
.LC40:
	.string	"nosymlinks"
	.zero	53
	.align 32
.LC41:
	.string	"user"
	.zero	59
	.align 32
.LC42:
	.string	"cgipat"
	.zero	57
	.align 32
.LC43:
	.string	"cgilimit"
	.zero	55
	.align 32
.LC44:
	.string	"urlpat"
	.zero	57
	.align 32
.LC45:
	.string	"noemptyreferers"
	.zero	48
	.align 32
.LC46:
	.string	"localpat"
	.zero	55
	.align 32
.LC47:
	.string	"throttles"
	.zero	54
	.align 32
.LC48:
	.string	"host"
	.zero	59
	.align 32
.LC49:
	.string	"logfile"
	.zero	56
	.align 32
.LC50:
	.string	"vhost"
	.zero	58
	.align 32
.LC51:
	.string	"novhost"
	.zero	56
	.align 32
.LC52:
	.string	"globalpasswd"
	.zero	51
	.align 32
.LC53:
	.string	"noglobalpasswd"
	.zero	49
	.align 32
.LC54:
	.string	"pidfile"
	.zero	56
	.align 32
.LC55:
	.string	"charset"
	.zero	56
	.align 32
.LC56:
	.string	"p3p"
	.zero	60
	.align 32
.LC57:
	.string	"max_age"
	.zero	56
	.align 32
.LC58:
	.string	"%s: unknown config option '%s'\n"
	.zero	32
	.section	.text.unlikely
.LCOLDB59:
	.text
.LHOTB59:
	.p2align 4,,15
	.type	read_config, @function
read_config:
.LASANPC10:
.LFB10:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$216, %rsp
	.cfi_def_cfa_offset 272
	movl	__asan_option_detect_stack_use_after_return(%rip), %eax
	leaq	16(%rsp), %r12
	testl	%eax, %eax
	jne	.L387
.L281:
	movq	%r12, %r13
	movq	$1102416563, (%r12)
	movq	$.LC28, 8(%r12)
	shrq	$3, %r13
	movq	$.LASANPC10, 16(%r12)
	movl	$.LC29, %esi
	movl	$-235802127, 2147450880(%r13)
	movl	$-185273340, 2147450896(%r13)
	movq	%rbx, %rdi
	movl	$-202116109, 2147450900(%r13)
	call	fopen
	testq	%rax, %rax
	movq	%rax, 8(%rsp)
	je	.L383
	leaq	32(%r12), %r14
.L285:
	movq	8(%rsp), %rdx
	movl	$1000, %esi
	movq	%r14, %rdi
	call	fgets
	testq	%rax, %rax
	je	.L388
	movl	$35, %esi
	movq	%r14, %rdi
	call	strchr
	testq	%rax, %rax
	je	.L286
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L287
	movq	%rax, %rcx
	andl	$7, %ecx
	cmpb	%cl, %dl
	jle	.L389
.L287:
	movb	$0, (%rax)
.L286:
	movl	$.LC30, %esi
	movq	%r14, %rdi
	call	strspn
	leaq	(%r14,%rax), %rbx
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L288
	movq	%rbx, %rdx
	andl	$7, %edx
	cmpb	%dl, %al
	jle	.L390
	.p2align 4,,10
	.p2align 3
.L288:
	cmpb	$0, (%rbx)
	je	.L285
	movq	%rbx, %rdi
	movl	$.LC30, %esi
	call	strcspn
	leaq	(%rbx,%rax), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L290
	movq	%rdi, %rdx
	andl	$7, %edx
	cmpb	%dl, %al
	jle	.L391
.L290:
	movzbl	(%rdi), %eax
	cmpb	$13, %al
	sete	%cl
	cmpb	$32, %al
	sete	%dl
	orb	%dl, %cl
	jne	.L367
	subl	$9, %eax
	cmpb	$1, %al
	ja	.L331
	.p2align 4,,10
	.p2align 3
.L367:
	movq	%rdi, %rax
	leaq	1(%rdi), %r15
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L293
	movq	%rdi, %rcx
	andl	$7, %ecx
	cmpb	%cl, %al
	jle	.L392
.L293:
	movq	%r15, %rax
	movb	$0, -1(%r15)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L294
	movq	%r15, %rcx
	andl	$7, %ecx
	cmpb	%cl, %al
	jle	.L393
.L294:
	movzbl	(%r15), %ecx
	movq	%r15, %rdi
	cmpb	$13, %cl
	sete	%sil
	cmpb	$32, %cl
	sete	%al
	orb	%al, %sil
	jne	.L367
	subl	$9, %ecx
	cmpb	$1, %cl
	jbe	.L367
.L291:
	movl	$61, %esi
	movq	%rbx, %rdi
	call	strchr
	testq	%rax, %rax
	je	.L332
	movq	%rax, %rcx
	leaq	1(%rax), %rbp
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%cl, %cl
	je	.L297
	movq	%rax, %rsi
	andl	$7, %esi
	cmpb	%sil, %cl
	jle	.L394
.L297:
	movb	$0, (%rax)
.L296:
	movl	$.LC31, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L395
	movl	$.LC32, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L396
	movl	$.LC33, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L397
	movl	$.LC34, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L398
	movl	$.LC35, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L399
	movl	$.LC36, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L400
	movl	$.LC37, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L385
	movl	$.LC38, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L386
	movl	$.LC39, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L385
	movl	$.LC40, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L386
	movl	$.LC41, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L401
	movl	$.LC42, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L402
	movl	$.LC43, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L403
	movl	$.LC44, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L404
	movl	$.LC45, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L405
	movl	$.LC46, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L406
	movl	$.LC47, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L407
	movl	$.LC48, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L408
	movl	$.LC49, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L409
	movl	$.LC50, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L410
	movl	$.LC51, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L411
	movl	$.LC52, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L412
	movl	$.LC53, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L413
	movl	$.LC54, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L414
	movl	$.LC55, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L415
	movl	$.LC56, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L416
	movl	$.LC57, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	jne	.L325
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	atoi
	movl	%eax, max_age(%rip)
	.p2align 4,,10
	.p2align 3
.L299:
	movl	$.LC30, %esi
	movq	%r15, %rdi
	call	strspn
	leaq	(%r15,%rax), %rbx
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L288
	movq	%rbx, %rdx
	andl	$7, %edx
	cmpb	%dl, %al
	jg	.L288
	movq	%rbx, %rdi
	call	__asan_report_load1
	.p2align 4,,10
	.p2align 3
.L395:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$1, debug(%rip)
	jmp	.L299
.L396:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	atoi
	movw	%ax, port(%rip)
	jmp	.L299
.L332:
	xorl	%ebp, %ebp
	jmp	.L296
.L397:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, dir(%rip)
	jmp	.L299
.L398:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$1, do_chroot(%rip)
	movl	$1, no_symlink_check(%rip)
	jmp	.L299
.L331:
	movq	%rdi, %r15
	jmp	.L291
.L399:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$0, do_chroot(%rip)
	movl	$0, no_symlink_check(%rip)
	jmp	.L299
.L385:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$0, no_symlink_check(%rip)
	jmp	.L299
.L400:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, data_dir(%rip)
	jmp	.L299
.L386:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$1, no_symlink_check(%rip)
	jmp	.L299
.L401:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, user(%rip)
	jmp	.L299
.L403:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	atoi
	movl	%eax, cgi_limit(%rip)
	jmp	.L299
.L402:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, cgi_pattern(%rip)
	jmp	.L299
.L405:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$1, no_empty_referers(%rip)
	jmp	.L299
.L404:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, url_pattern(%rip)
	jmp	.L299
.L406:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, local_pattern(%rip)
	jmp	.L299
.L388:
	movq	8(%rsp), %rdi
	call	fclose
	leaq	16(%rsp), %rax
	cmpq	%r12, %rax
	jne	.L417
	movl	$0, 2147450880(%r13)
	movq	$0, 2147450896(%r13)
.L283:
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L390:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	__asan_report_load1
.L409:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, logfile(%rip)
	jmp	.L299
.L408:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, hostname(%rip)
	jmp	.L299
.L391:
	call	__asan_report_load1
.L417:
	movabsq	$-723401728380766731, %rax
	movq	$1172321806, (%r12)
	movq	%rax, 2147450880(%r13)
	movq	%rax, 2147450888(%r13)
	movq	%rax, 2147450896(%r13)
	jmp	.L283
.L407:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, throttlefile(%rip)
	jmp	.L299
.L383:
	movq	%rbx, %rdi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L387:
	movq	%r12, %rsi
	movl	$192, %edi
	call	__asan_stack_malloc_2
	movq	%rax, %r12
	jmp	.L281
.L389:
	movq	%rax, %rdi
	call	__asan_report_store1
.L392:
	call	__asan_report_store1
.L393:
	movq	%r15, %rdi
	call	__asan_report_load1
.L394:
	movq	%rax, %rdi
	call	__asan_report_store1
.L325:
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L418
	movq	stderr(%rip), %rdi
	movq	%rbx, %rcx
	movl	$.LC58, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L416:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, p3p(%rip)
	jmp	.L299
.L418:
	movl	$stderr, %edi
	call	__asan_report_load8
.L415:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, charset(%rip)
	jmp	.L299
.L414:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, pidfile(%rip)
	jmp	.L299
.L413:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$0, do_global_passwd(%rip)
	jmp	.L299
.L412:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$1, do_global_passwd(%rip)
	jmp	.L299
.L411:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$0, do_vhost(%rip)
	jmp	.L299
.L410:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$1, do_vhost(%rip)
	jmp	.L299
	.cfi_endproc
.LFE10:
	.size	read_config, .-read_config
	.section	.text.unlikely
.LCOLDE59:
	.text
.LHOTE59:
	.section	.rodata
	.align 32
.LC60:
	.string	"nobody"
	.zero	57
	.align 32
.LC61:
	.string	"iso-8859-1"
	.zero	53
	.align 32
.LC62:
	.string	""
	.zero	63
	.align 32
.LC63:
	.string	"-V"
	.zero	61
	.align 32
.LC64:
	.string	"thttpd/2.27.0 Oct 3, 2014"
	.zero	38
	.align 32
.LC65:
	.string	"-C"
	.zero	61
	.align 32
.LC66:
	.string	"-p"
	.zero	61
	.align 32
.LC67:
	.string	"-d"
	.zero	61
	.align 32
.LC68:
	.string	"-r"
	.zero	61
	.align 32
.LC69:
	.string	"-nor"
	.zero	59
	.align 32
.LC70:
	.string	"-dd"
	.zero	60
	.align 32
.LC71:
	.string	"-s"
	.zero	61
	.align 32
.LC72:
	.string	"-nos"
	.zero	59
	.align 32
.LC73:
	.string	"-u"
	.zero	61
	.align 32
.LC74:
	.string	"-c"
	.zero	61
	.align 32
.LC75:
	.string	"-t"
	.zero	61
	.align 32
.LC76:
	.string	"-h"
	.zero	61
	.align 32
.LC77:
	.string	"-l"
	.zero	61
	.align 32
.LC78:
	.string	"-v"
	.zero	61
	.align 32
.LC79:
	.string	"-nov"
	.zero	59
	.align 32
.LC80:
	.string	"-g"
	.zero	61
	.align 32
.LC81:
	.string	"-nog"
	.zero	59
	.align 32
.LC82:
	.string	"-i"
	.zero	61
	.align 32
.LC83:
	.string	"-T"
	.zero	61
	.align 32
.LC84:
	.string	"-P"
	.zero	61
	.align 32
.LC85:
	.string	"-M"
	.zero	61
	.align 32
.LC86:
	.string	"-D"
	.zero	61
	.section	.text.unlikely
.LCOLDB87:
	.text
.LHOTB87:
	.p2align 4,,15
	.type	parse_args, @function
parse_args:
.LASANPC8:
.LFB8:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	$80, %eax
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%edi, %r14d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	cmpl	$1, %edi
	movl	$0, debug(%rip)
	movw	%ax, port(%rip)
	movq	$0, dir(%rip)
	movq	$0, data_dir(%rip)
	movl	$0, do_chroot(%rip)
	movl	$0, no_log(%rip)
	movl	$0, no_symlink_check(%rip)
	movl	$0, do_vhost(%rip)
	movl	$0, do_global_passwd(%rip)
	movq	$0, cgi_pattern(%rip)
	movl	$0, cgi_limit(%rip)
	movq	$0, url_pattern(%rip)
	movl	$0, no_empty_referers(%rip)
	movq	$0, local_pattern(%rip)
	movq	$0, throttlefile(%rip)
	movq	$0, hostname(%rip)
	movq	$0, logfile(%rip)
	movq	$0, pidfile(%rip)
	movq	$.LC60, user(%rip)
	movq	$.LC61, charset(%rip)
	movq	$.LC62, p3p(%rip)
	movl	$-1, max_age(%rip)
	jle	.L467
	leaq	8(%rsi), %rdi
	movq	%rsi, %r15
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L492
	movq	8(%rsi), %rbx
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L422
	movq	%rbx, %rdx
	andl	$7, %edx
	cmpb	%dl, %al
	jle	.L493
.L422:
	cmpb	$45, (%rbx)
	jne	.L463
	movl	$1, %ebp
	movl	$.LC63, %r13d
	movl	$3, %r12d
	jmp	.L466
	.p2align 4,,10
	.p2align 3
.L498:
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jg	.L494
.L426:
	movl	$.LC68, %edi
	movq	%rbx, %rsi
	movq	%r12, %rcx
	repz; cmpsb
	jne	.L432
	movl	$1, do_chroot(%rip)
	movl	$1, no_symlink_check(%rip)
.L428:
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jle	.L420
.L500:
	movslq	%ebp, %rax
	leaq	(%r15,%rax,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L495
	movq	(%rdi), %rbx
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L465
	movq	%rbx, %rdx
	andl	$7, %edx
	cmpb	%dl, %al
	jle	.L496
.L465:
	cmpb	$45, (%rbx)
	jne	.L463
.L466:
	movq	%rbx, %rsi
	movq	%r13, %rdi
	movq	%r12, %rcx
	repz; cmpsb
	je	.L497
	movl	$.LC65, %edi
	movq	%rbx, %rsi
	movq	%r12, %rcx
	repz; cmpsb
	je	.L498
	movl	$.LC66, %edi
	movq	%rbx, %rsi
	movq	%r12, %rcx
	repz; cmpsb
	jne	.L429
	leal	1(%rbp), %edx
	cmpl	%edx, %r14d
	jle	.L426
	movslq	%edx, %rax
	leaq	(%r15,%rax,8), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L499
	movq	(%rdi), %rdi
	movl	%edx, 12(%rsp)
	call	atoi
	movl	12(%rsp), %edx
	movw	%ax, port(%rip)
	movl	%edx, %ebp
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jg	.L500
.L420:
	cmpl	%r14d, %ebp
	jne	.L463
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L429:
	.cfi_restore_state
	movl	$.LC67, %edi
	movq	%rbx, %rsi
	movq	%r12, %rcx
	repz; cmpsb
	jne	.L426
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L426
	movslq	%eax, %rdx
	leaq	(%r15,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L501
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, dir(%rip)
	jmp	.L428
	.p2align 4,,10
	.p2align 3
.L432:
	movl	$.LC69, %edi
	movl	$5, %ecx
	movq	%rbx, %rsi
	repz; cmpsb
	jne	.L433
	movl	$0, do_chroot(%rip)
	movl	$0, no_symlink_check(%rip)
	jmp	.L428
	.p2align 4,,10
	.p2align 3
.L494:
	movslq	%eax, %rdx
	leaq	(%r15,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L502
	movq	(%rdi), %rdi
	movl	%eax, 12(%rsp)
	call	read_config
	movl	12(%rsp), %eax
	movl	%eax, %ebp
	jmp	.L428
	.p2align 4,,10
	.p2align 3
.L433:
	movl	$.LC70, %edi
	movl	$4, %ecx
	movq	%rbx, %rsi
	repz; cmpsb
	jne	.L434
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L434
	movslq	%eax, %rdx
	leaq	(%r15,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L503
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, data_dir(%rip)
	jmp	.L428
	.p2align 4,,10
	.p2align 3
.L434:
	movl	$.LC71, %edi
	movq	%rbx, %rsi
	movq	%r12, %rcx
	repz; cmpsb
	jne	.L436
	movl	$0, no_symlink_check(%rip)
	jmp	.L428
	.p2align 4,,10
	.p2align 3
.L436:
	movl	$.LC72, %edi
	movl	$5, %ecx
	movq	%rbx, %rsi
	repz; cmpsb
	je	.L504
	movl	$.LC73, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L438
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jg	.L505
	movl	$.LC75, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L444
.L447:
	movl	$.LC77, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L445
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L445
	movslq	%eax, %rdx
	leaq	(%r15,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L506
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, logfile(%rip)
	jmp	.L428
.L504:
	movl	$1, no_symlink_check(%rip)
	jmp	.L428
.L438:
	movl	$.LC74, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L441
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L442
	movslq	%eax, %rdx
	leaq	(%r15,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L507
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, cgi_pattern(%rip)
	jmp	.L428
.L441:
	movl	$.LC75, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L444
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L445
	movslq	%eax, %rdx
	leaq	(%r15,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L508
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, throttlefile(%rip)
	jmp	.L428
.L444:
	movl	$.LC76, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L447
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L445
	movslq	%eax, %rdx
	leaq	(%r15,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L509
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, hostname(%rip)
	jmp	.L428
.L505:
	movslq	%eax, %rdx
	leaq	(%r15,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L510
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, user(%rip)
	jmp	.L428
.L442:
	movl	$.LC76, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L447
.L445:
	movl	$.LC78, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L450
	movl	$1, do_vhost(%rip)
	jmp	.L428
.L450:
	movl	$.LC79, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L511
	movl	$.LC80, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L452
	movl	$1, do_global_passwd(%rip)
	jmp	.L428
.L511:
	movl	$0, do_vhost(%rip)
	jmp	.L428
.L467:
	movl	$1, %ebp
	jmp	.L420
.L452:
	movl	$.LC81, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L453
	movl	$0, do_global_passwd(%rip)
	jmp	.L428
.L497:
	movl	$.LC64, %edi
	call	puts
	call	__asan_handle_no_return
	xorl	%edi, %edi
	call	exit
.L453:
	movl	$.LC82, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L454
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L455
	movslq	%eax, %rdx
	leaq	(%r15,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L512
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, pidfile(%rip)
	jmp	.L428
.L454:
	movl	$.LC83, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L457
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L458
	movslq	%eax, %rdx
	leaq	(%r15,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L513
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, charset(%rip)
	jmp	.L428
.L457:
	movl	$.LC84, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L460
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L458
	movslq	%eax, %rdx
	leaq	(%r15,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L514
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, p3p(%rip)
	jmp	.L428
.L455:
	movl	$.LC84, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L460
.L458:
	movl	$.LC86, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L463
	movl	$1, debug(%rip)
	jmp	.L428
.L460:
	movl	$.LC85, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L458
	leal	1(%rbp), %edx
	cmpl	%edx, %r14d
	jle	.L458
	movslq	%edx, %rax
	leaq	(%r15,%rax,8), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L515
	movq	(%rdi), %rdi
	movl	%edx, 12(%rsp)
	call	atoi
	movl	12(%rsp), %edx
	movl	%eax, max_age(%rip)
	movl	%edx, %ebp
	jmp	.L428
.L513:
	call	__asan_report_load8
.L514:
	call	__asan_report_load8
.L507:
	call	__asan_report_load8
.L495:
	call	__asan_report_load8
.L503:
	call	__asan_report_load8
.L502:
	call	__asan_report_load8
.L501:
	call	__asan_report_load8
.L463:
	call	__asan_handle_no_return
	call	usage
.L496:
	movq	%rbx, %rdi
	call	__asan_report_load1
.L499:
	call	__asan_report_load8
.L506:
	call	__asan_report_load8
.L508:
	call	__asan_report_load8
.L493:
	movq	%rbx, %rdi
	call	__asan_report_load1
.L492:
	call	__asan_report_load8
.L509:
	call	__asan_report_load8
.L510:
	call	__asan_report_load8
.L512:
	call	__asan_report_load8
.L515:
	call	__asan_report_load8
	.cfi_endproc
.LFE8:
	.size	parse_args, .-parse_args
	.section	.text.unlikely
.LCOLDE87:
	.text
.LHOTE87:
	.globl	__asan_stack_malloc_8
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC88:
	.string	"5 32 8 9 max_limit 96 8 9 min_limit 160 16 2 tv 224 5000 3 buf 5280 5000 7 pattern "
	.globl	__asan_stack_free_8
	.section	.rodata
	.align 32
.LC89:
	.string	"%.80s - %m"
	.zero	53
	.align 32
.LC90:
	.string	" %4900[^ \t] %ld-%ld"
	.zero	44
	.align 32
.LC91:
	.string	" %4900[^ \t] %ld"
	.zero	48
	.align 32
.LC92:
	.string	"unparsable line in %.80s - %.80s"
	.zero	63
	.align 32
.LC93:
	.string	"%s: unparsable line in %.80s - %.80s\n"
	.zero	58
	.align 32
.LC94:
	.string	"|/"
	.zero	61
	.align 32
.LC95:
	.string	"out of memory allocating a throttletab"
	.zero	57
	.align 32
.LC96:
	.string	"%s: out of memory allocating a throttletab\n"
	.zero	52
	.section	.text.unlikely
.LCOLDB97:
	.text
.LHOTB97:
	.p2align 4,,15
	.type	read_throttlefile, @function
read_throttlefile:
.LASANPC15:
.LFB15:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$10392, %rsp
	.cfi_def_cfa_offset 10448
	movl	__asan_option_detect_stack_use_after_return(%rip), %edx
	leaq	48(%rsp), %rax
	movq	%rdi, 16(%rsp)
	testl	%edx, %edx
	movq	%rax, 24(%rsp)
	jne	.L616
.L516:
	movq	24(%rsp), %rax
	movl	$.LC29, %esi
	movq	$1102416563, (%rax)
	movq	$.LC88, 8(%rax)
	leaq	10336(%rax), %r15
	movq	$.LASANPC15, 16(%rax)
	movq	16(%rsp), %rdi
	shrq	$3, %rax
	movq	%rax, 32(%rsp)
	movl	$-235802127, 2147450880(%rax)
	movl	$-185273344, 2147450884(%rax)
	movl	$-218959118, 2147450888(%rax)
	movl	$-185273344, 2147450892(%rax)
	movl	$-218959118, 2147450896(%rax)
	movl	$-185335808, 2147450900(%rax)
	movl	$-218959118, 2147450904(%rax)
	movl	$-185273344, 2147451532(%rax)
	movl	$-218959118, 2147451536(%rax)
	movl	$-185273344, 2147452164(%rax)
	movl	$-202116109, 2147452168(%rax)
	call	fopen
	testq	%rax, %rax
	movq	%rax, %r12
	je	.L617
	movq	24(%rsp), %rbx
	xorl	%esi, %esi
	leaq	160(%rbx), %rdi
	call	gettimeofday
	movq	%rbx, %rax
	leaq	224(%rbx), %rbx
	leaq	96(%rax), %rdi
	leaq	32(%rax), %r13
	leaq	5280(%rax), %rbp
	addq	$5281, %rax
	movq	%rdi, (%rsp)
	movq	%rax, 40(%rsp)
	.p2align 4,,10
	.p2align 3
.L521:
	movq	%rbx, %rax
	movq	%rbx, %r14
	andl	$7, %eax
	shrq	$3, %r14
	movq	%rax, 8(%rsp)
	.p2align 4,,10
	.p2align 3
.L556:
	movq	%r12, %rdx
	movl	$5000, %esi
	movq	%rbx, %rdi
	call	fgets
	testq	%rax, %rax
	je	.L618
	movl	$35, %esi
	movq	%rbx, %rdi
	call	strchr
	testq	%rax, %rax
	je	.L522
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L523
	movq	%rax, %rcx
	andl	$7, %ecx
	cmpb	%cl, %dl
	jle	.L619
.L523:
	movb	$0, (%rax)
.L522:
	movq	%rbx, %rax
.L524:
	movl	(%rax), %ecx
	addq	$4, %rax
	leal	-16843009(%rcx), %edx
	notl	%ecx
	andl	%ecx, %edx
	andl	$-2139062144, %edx
	je	.L524
	movl	%edx, %ecx
	shrl	$16, %ecx
	testl	$32896, %edx
	cmove	%ecx, %edx
	leaq	2(%rax), %rcx
	cmove	%rcx, %rax
	addb	%dl, %dl
	movzbl	2147450880(%r14), %edx
	sbbq	$3, %rax
	subq	%rbx, %rax
	testb	%dl, %dl
	je	.L526
	cmpb	8(%rsp), %dl
	jle	.L620
.L526:
	leaq	(%rbx,%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L527
	movq	%rdi, %rcx
	andl	$7, %ecx
	cmpb	%cl, %dl
	jle	.L621
.L527:
	cmpl	$0, %eax
	jle	.L528
	subl	$1, %eax
	movslq	%eax, %rsi
	leaq	(%rbx,%rsi), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L529
	movq	%rdi, %rcx
	andl	$7, %ecx
	cmpb	%cl, %dl
	jle	.L622
.L529:
	movzbl	-10112(%r15,%rsi), %edx
	cmpb	$13, %dl
	sete	%dil
	cmpb	$32, %dl
	sete	%cl
	orb	%cl, %dil
	jne	.L530
	subl	$9, %edx
	cmpb	$1, %dl
	ja	.L537
.L530:
	leaq	(%rbx,%rsi), %rcx
	.p2align 4,,10
	.p2align 3
.L593:
	movq	%rcx, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L533
	movq	%rcx, %rdi
	andl	$7, %edi
	cmpb	%dil, %dl
	jle	.L623
.L533:
	testl	%eax, %eax
	movb	$0, -10112(%r15,%rsi)
	je	.L556
	subq	$1, %rcx
	subl	$1, %eax
	movq	%rcx, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L535
	movq	%rcx, %rsi
	andl	$7, %esi
	cmpb	%sil, %dl
	jle	.L624
.L535:
	movslq	%eax, %rsi
	movzbl	-10112(%r15,%rsi), %edx
	cmpb	$13, %dl
	sete	%r8b
	cmpb	$32, %dl
	sete	%dil
	orb	%dil, %r8b
	jne	.L593
	subl	$9, %edx
	cmpb	$1, %dl
	jbe	.L593
.L537:
	movq	(%rsp), %rcx
	xorl	%eax, %eax
	movq	%r13, %r8
	movq	%rbp, %rdx
	movl	$.LC90, %esi
	movq	%rbx, %rdi
	call	__isoc99_sscanf
	cmpl	$3, %eax
	je	.L531
	xorl	%eax, %eax
	movq	%r13, %rcx
	movq	%rbp, %rdx
	movl	$.LC91, %esi
	movq	%rbx, %rdi
	call	__isoc99_sscanf
	cmpl	$2, %eax
	jne	.L538
	movq	$0, -10240(%r15)
	.p2align 4,,10
	.p2align 3
.L531:
	cmpb	$47, -5056(%r15)
	jne	.L542
	jmp	.L625
	.p2align 4,,10
	.p2align 3
.L543:
	leaq	2(%rax), %rsi
	leaq	1(%rax), %rdi
	call	strcpy
.L542:
	movl	$.LC94, %esi
	movq	%rbp, %rdi
	call	strstr
	testq	%rax, %rax
	jne	.L543
	movslq	numthrottles(%rip), %rdx
	movl	maxthrottles(%rip), %eax
	cmpl	%eax, %edx
	jl	.L544
	testl	%eax, %eax
	jne	.L545
	movl	$4800, %edi
	movl	$100, maxthrottles(%rip)
	call	malloc
	movq	%rax, throttles(%rip)
.L546:
	testq	%rax, %rax
	je	.L547
	movslq	numthrottles(%rip), %rdx
.L548:
	leaq	(%rdx,%rdx,2), %r14
	movq	%rbp, %rdi
	movq	%r14, %rdx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %r14
	call	e_strdup
	movq	%r14, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L626
	movq	%rax, (%r14)
	movslq	numthrottles(%rip), %rax
	movq	-10304(%r15), %rcx
	movq	%rax, %rdx
	leaq	(%rax,%rax,2), %rax
	salq	$4, %rax
	addq	throttles(%rip), %rax
	leaq	8(%rax), %rdi
	movq	%rdi, %rsi
	shrq	$3, %rsi
	cmpb	$0, 2147450880(%rsi)
	jne	.L627
	leaq	16(%rax), %rdi
	movq	%rcx, 8(%rax)
	movq	-10240(%r15), %rcx
	movq	%rdi, %rsi
	shrq	$3, %rsi
	cmpb	$0, 2147450880(%rsi)
	jne	.L628
	leaq	24(%rax), %rdi
	movq	%rcx, 16(%rax)
	movq	%rdi, %rcx
	shrq	$3, %rcx
	cmpb	$0, 2147450880(%rcx)
	jne	.L629
	leaq	32(%rax), %rdi
	movq	$0, 24(%rax)
	movq	%rdi, %rcx
	shrq	$3, %rcx
	cmpb	$0, 2147450880(%rcx)
	jne	.L630
	leaq	40(%rax), %rdi
	movq	$0, 32(%rax)
	movq	%rdi, %rcx
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%cl, %cl
	je	.L555
	movq	%rdi, %rsi
	andl	$7, %esi
	addl	$3, %esi
	cmpb	%cl, %sil
	jge	.L631
.L555:
	movl	$0, 40(%rax)
	leal	1(%rdx), %eax
	movl	%eax, numthrottles(%rip)
	jmp	.L521
.L528:
	je	.L556
	jmp	.L537
.L545:
	addl	%eax, %eax
	movq	throttles(%rip), %rdi
	movl	%eax, maxthrottles(%rip)
	cltq
	leaq	(%rax,%rax,2), %rsi
	salq	$4, %rsi
	call	realloc
	movq	%rax, throttles(%rip)
	jmp	.L546
.L538:
	movq	16(%rsp), %rdx
	xorl	%eax, %eax
	movq	%rbx, %rcx
	movl	$.LC92, %esi
	movl	$2, %edi
	call	syslog
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L632
	movq	16(%rsp), %rcx
	movq	stderr(%rip), %rdi
	movq	%rbx, %r8
	movl	$.LC93, %esi
	xorl	%eax, %eax
	call	fprintf
	jmp	.L521
.L544:
	movq	throttles(%rip), %rax
	jmp	.L548
.L618:
	movq	%r12, %rdi
	call	fclose
	leaq	48(%rsp), %rax
	cmpq	24(%rsp), %rax
	jne	.L633
	movq	32(%rsp), %rax
	movq	$0, 2147450880(%rax)
	movq	$0, 2147450888(%rax)
	movq	$0, 2147450896(%rax)
	movl	$0, 2147450904(%rax)
	movq	$0, 2147451532(%rax)
	movq	$0, 2147452164(%rax)
.L518:
	addq	$10392, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L625:
	.cfi_restore_state
	movq	40(%rsp), %rsi
	movq	%rbp, %rdi
	call	strcpy
	jmp	.L542
.L616:
	movq	%rax, %rsi
	movl	$10336, %edi
	call	__asan_stack_malloc_8
	movq	%rax, 24(%rsp)
	jmp	.L516
.L633:
	movq	24(%rsp), %rax
	leaq	48(%rsp), %rdx
	movl	$10336, %esi
	movq	%rax, %rdi
	movq	$1172321806, (%rax)
	call	__asan_stack_free_8
	jmp	.L518
.L632:
	movl	$stderr, %edi
	call	__asan_report_load8
.L631:
	call	__asan_report_store4
.L630:
	call	__asan_report_store8
.L629:
	call	__asan_report_store8
.L628:
	call	__asan_report_store8
.L627:
	call	__asan_report_store8
.L626:
	movq	%r14, %rdi
	call	__asan_report_store8
.L547:
	xorl	%eax, %eax
	movl	$.LC95, %esi
	movl	$2, %edi
	call	syslog
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L634
	movq	stderr(%rip), %rdi
	movl	$.LC96, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L624:
	movq	%rcx, %rdi
	call	__asan_report_load1
.L634:
	movl	$stderr, %edi
	call	__asan_report_load8
.L623:
	movq	%rcx, %rdi
	call	__asan_report_store1
.L622:
	call	__asan_report_load1
.L621:
	call	__asan_report_load1
.L620:
	movq	%rbx, %rdi
	call	__asan_report_load1
.L619:
	movq	%rax, %rdi
	call	__asan_report_store1
.L617:
	movq	16(%rsp), %rbx
	movl	$.LC89, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	movq	%rbx, %rdx
	call	syslog
	movq	%rbx, %rdi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE15:
	.size	read_throttlefile, .-read_throttlefile
	.section	.text.unlikely
.LCOLDE97:
	.text
.LHOTE97:
	.section	.rodata
	.align 32
.LC98:
	.string	"-"
	.zero	62
	.align 32
.LC99:
	.string	"re-opening logfile"
	.zero	45
	.align 32
.LC100:
	.string	"a"
	.zero	62
	.align 32
.LC101:
	.string	"re-opening %.80s - %m"
	.zero	42
	.section	.text.unlikely
.LCOLDB102:
	.text
.LHOTB102:
	.p2align 4,,15
	.type	re_open_logfile, @function
re_open_logfile:
.LASANPC6:
.LFB6:
	.cfi_startproc
	movl	no_log(%rip), %eax
	testl	%eax, %eax
	jne	.L647
	cmpq	$0, hs(%rip)
	je	.L647
	movq	logfile(%rip), %rsi
	testq	%rsi, %rsi
	je	.L647
	movl	$.LC98, %edi
	movl	$2, %ecx
	repz; cmpsb
	jne	.L648
.L647:
	rep; ret
	.p2align 4,,10
	.p2align 3
.L648:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	xorl	%eax, %eax
	movl	$.LC99, %esi
	movl	$5, %edi
	call	syslog
	movq	logfile(%rip), %rdi
	movl	$.LC100, %esi
	call	fopen
	movq	logfile(%rip), %rdi
	movl	$384, %esi
	movq	%rax, %rbx
	call	chmod
	testl	%eax, %eax
	jne	.L639
	testq	%rbx, %rbx
	je	.L639
	movq	%rbx, %rdi
	call	fileno
	movl	$2, %esi
	movl	%eax, %edi
	movl	$1, %edx
	xorl	%eax, %eax
	call	fcntl
	movq	%rbx, %rsi
	movq	hs(%rip), %rdi
	popq	%rbx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	jmp	httpd_set_logfp
	.p2align 4,,10
	.p2align 3
.L639:
	.cfi_restore_state
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	movq	logfile(%rip), %rdx
	movl	$.LC101, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	jmp	syslog
	.cfi_endproc
.LFE6:
	.size	re_open_logfile, .-re_open_logfile
	.section	.text.unlikely
.LCOLDE102:
	.text
.LHOTE102:
	.section	.rodata
	.align 32
.LC103:
	.string	"too many connections!"
	.zero	42
	.align 32
.LC104:
	.string	"the connects free list is messed up"
	.zero	60
	.align 32
.LC105:
	.string	"out of memory allocating an httpd_conn"
	.zero	57
	.section	.text.unlikely
.LCOLDB106:
	.text
.LHOTB106:
	.p2align 4,,15
	.type	handle_newconnect, @function
handle_newconnect:
.LASANPC17:
.LFB17:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbp
	movl	%esi, %r12d
	shrq	$3, %r13
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movl	num_connects(%rip), %eax
.L674:
	cmpl	%eax, max_connects(%rip)
	jle	.L723
	movslq	first_free_connect(%rip), %rax
	cmpl	$-1, %eax
	je	.L654
	leaq	(%rax,%rax,8), %rbx
	salq	$4, %rbx
	addq	connects(%rip), %rbx
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L653
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L724
.L653:
	movl	(%rbx), %eax
	testl	%eax, %eax
	jne	.L654
	leaq	8(%rbx), %r14
	movq	%r14, %r15
	shrq	$3, %r15
	cmpb	$0, 2147450880(%r15)
	jne	.L725
	movq	8(%rbx), %rdx
	testq	%rdx, %rdx
	je	.L726
.L656:
	movq	hs(%rip), %rdi
	movl	%r12d, %esi
	call	httpd_get_conn
	testl	%eax, %eax
	je	.L661
	cmpl	$2, %eax
	je	.L676
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L662
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L727
.L662:
	leaq	4(%rbx), %rdi
	movl	$1, (%rbx)
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L663
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L728
.L663:
	addl	$1, num_connects(%rip)
	cmpb	$0, 2147450880(%r13)
	movl	4(%rbx), %eax
	movl	$-1, 4(%rbx)
	movl	%eax, first_free_connect(%rip)
	jne	.L729
	leaq	88(%rbx), %rdi
	movq	0(%rbp), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L730
	leaq	96(%rbx), %rdi
	movq	%rax, 88(%rbx)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L731
	leaq	104(%rbx), %rdi
	movq	$0, 96(%rbx)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L732
	leaq	136(%rbx), %rdi
	movq	$0, 104(%rbx)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L733
	leaq	56(%rbx), %rdi
	movq	$0, 136(%rbx)
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L669
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L734
.L669:
	movq	%r14, %rax
	movl	$0, 56(%rbx)
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L735
	movq	8(%rbx), %rax
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L671
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L736
.L671:
	movl	704(%rax), %edi
	call	httpd_set_ndelay
	movq	%r14, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L737
	movq	8(%rbx), %rax
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L673
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L738
.L673:
	movl	704(%rax), %edi
	xorl	%edx, %edx
	movq	%rbx, %rsi
	call	fdwatch_add_fd
	addq	$1, stats_connections(%rip)
	movl	num_connects(%rip), %eax
	cmpl	stats_simultaneous(%rip), %eax
	jle	.L674
	movl	%eax, stats_simultaneous(%rip)
	jmp	.L674
	.p2align 4,,10
	.p2align 3
.L676:
	movl	$1, %eax
.L651:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L661:
	.cfi_restore_state
	movq	%rbp, %rdi
	movl	%eax, 12(%rsp)
	call	tmr_run
	movl	12(%rsp), %eax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L726:
	.cfi_restore_state
	movl	$720, %edi
	call	malloc
	cmpb	$0, 2147450880(%r15)
	jne	.L739
	testq	%rax, %rax
	movq	%rax, 8(%rbx)
	je	.L740
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L659
	movq	%rax, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L741
.L659:
	movl	$0, (%rax)
	addl	$1, httpd_conn_count(%rip)
	movq	%rax, %rdx
	jmp	.L656
.L741:
	movq	%rax, %rdi
	call	__asan_report_store4
	.p2align 4,,10
	.p2align 3
.L723:
	xorl	%eax, %eax
	movl	$.LC103, %esi
	movl	$4, %edi
	call	syslog
	movq	%rbp, %rdi
	call	tmr_run
	xorl	%eax, %eax
	jmp	.L651
.L654:
	movl	$2, %edi
	movl	$.LC104, %esi
	xorl	%eax, %eax
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L740:
	movl	$2, %edi
	movl	$.LC105, %esi
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L739:
	movq	%r14, %rdi
	call	__asan_report_store8
.L731:
	call	__asan_report_store8
.L732:
	call	__asan_report_store8
.L729:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L730:
	call	__asan_report_store8
.L725:
	movq	%r14, %rdi
	call	__asan_report_load8
.L724:
	movq	%rbx, %rdi
	call	__asan_report_load4
.L733:
	call	__asan_report_store8
.L734:
	call	__asan_report_store4
.L735:
	movq	%r14, %rdi
	call	__asan_report_load8
.L736:
	call	__asan_report_load4
.L737:
	movq	%r14, %rdi
	call	__asan_report_load8
.L738:
	call	__asan_report_load4
.L727:
	movq	%rbx, %rdi
	call	__asan_report_store4
.L728:
	call	__asan_report_load4
	.cfi_endproc
.LFE17:
	.size	handle_newconnect, .-handle_newconnect
	.section	.text.unlikely
.LCOLDE106:
	.text
.LHOTE106:
	.section	.rodata
	.align 32
.LC107:
	.string	"throttle sending count was negative - shouldn't happen!"
	.zero	40
	.section	.text.unlikely
.LCOLDB108:
	.text
.LHOTB108:
	.p2align 4,,15
	.type	check_throttles, @function
check_throttles:
.LASANPC21:
.LFB21:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	56(%rdi), %rax
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rax, %rdx
	movq	%rdi, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%rax, 32(%rsp)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L743
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L826
.L743:
	leaq	72(%rbx), %r15
	movl	$0, 56(%rbx)
	movq	%r15, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L827
	leaq	64(%rbx), %rax
	movq	$-1, 72(%rbx)
	movq	%rax, 16(%rsp)
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L828
	leaq	8(%rbx), %rax
	xorl	%r13d, %r13d
	xorl	%r14d, %r14d
	movq	$-1, 64(%rbx)
	movq	%rax, 40(%rsp)
	movl	numthrottles(%rip), %eax
	testl	%eax, %eax
	jle	.L771
	movq	32(%rsp), %rax
	movq	40(%rsp), %r12
	movq	%r15, 24(%rsp)
	movq	%rax, %rbp
	andl	$7, %eax
	shrq	$3, %r12
	addl	$3, %eax
	shrq	$3, %rbp
	movb	%al, 15(%rsp)
	jmp	.L806
	.p2align 4,,10
	.p2align 3
.L842:
	addl	$1, %ecx
	movslq	%ecx, %r9
.L757:
	movzbl	2147450880(%rbp), %edx
	testb	%dl, %dl
	je	.L761
	cmpb	%dl, 15(%rsp)
	jge	.L829
.L761:
	movslq	56(%rbx), %rdx
	leal	1(%rdx), %r10d
	movl	%r10d, 56(%rbx)
	leaq	16(%rbx,%rdx,4), %r10
	movq	%r10, %r11
	shrq	$3, %r11
	movzbl	2147450880(%r11), %r11d
	testb	%r11b, %r11b
	je	.L762
	movq	%r10, %r15
	andl	$7, %r15d
	addl	$3, %r15d
	cmpb	%r11b, %r15b
	jge	.L830
.L762:
	movl	%r14d, 16(%rbx,%rdx,4)
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L763
	movq	%rdi, %r10
	andl	$7, %r10d
	addl	$3, %r10d
	cmpb	%dl, %r10b
	jge	.L831
.L763:
	cqto
	movl	%ecx, 40(%rsi)
	idivq	%r9
	movq	16(%rsp), %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L832
	movq	64(%rbx), %rdx
	cmpq	$-1, %rdx
	je	.L824
	cmpq	%rdx, %rax
	cmovg	%rdx, %rax
.L824:
	movq	%rax, 64(%rbx)
	movq	24(%rsp), %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L833
	movq	72(%rbx), %rax
	cmpq	$-1, %rax
	je	.L825
	cmpq	%rax, %r8
	cmovl	%rax, %r8
.L825:
	movq	%r8, 72(%rbx)
.L751:
	addl	$1, %r14d
	cmpl	%r14d, numthrottles(%rip)
	jle	.L771
	movzbl	2147450880(%rbp), %eax
	testb	%al, %al
	je	.L772
	cmpb	%al, 15(%rsp)
	jge	.L834
.L772:
	addq	$48, %r13
	cmpl	$9, 56(%rbx)
	jg	.L771
.L806:
	cmpb	$0, 2147450880(%r12)
	jne	.L835
	movq	8(%rbx), %rax
	leaq	240(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L836
	movq	%r13, %rdi
	addq	throttles(%rip), %rdi
	movq	240(%rax), %rsi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L837
	movq	(%rdi), %rdi
	call	match
	testl	%eax, %eax
	je	.L751
	movq	%r13, %rsi
	addq	throttles(%rip), %rsi
	leaq	24(%rsi), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L838
	leaq	8(%rsi), %rdi
	movq	24(%rsi), %rdx
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L839
	movq	8(%rsi), %rax
	leaq	(%rax,%rax), %rcx
	cmpq	%rcx, %rdx
	jg	.L775
	leaq	16(%rsi), %rdi
	movq	%rdi, %rcx
	shrq	$3, %rcx
	cmpb	$0, 2147450880(%rcx)
	jne	.L840
	movq	16(%rsi), %r8
	cmpq	%r8, %rdx
	jl	.L775
	leaq	40(%rsi), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L755
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L841
.L755:
	movl	40(%rsi), %ecx
	testl	%ecx, %ecx
	jns	.L842
	xorl	%eax, %eax
	movl	$.LC107, %esi
	movl	$3, %edi
	call	syslog
	movq	%r13, %rsi
	addq	throttles(%rip), %rsi
	leaq	40(%rsi), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L758
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L843
.L758:
	leaq	8(%rsi), %rax
	movl	$0, 40(%rsi)
	movq	%rax, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L844
	leaq	16(%rsi), %rcx
	movq	8(%rsi), %rax
	movq	%rcx, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L845
	movq	16(%rsi), %r8
	movl	$1, %r9d
	movl	$1, %ecx
	jmp	.L757
	.p2align 4,,10
	.p2align 3
.L771:
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	$1, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L775:
	.cfi_restore_state
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L843:
	.cfi_restore_state
	call	__asan_report_store4
.L833:
	movq	24(%rsp), %r15
	movq	%r15, %rdi
	call	__asan_report_load8
.L832:
	movq	16(%rsp), %rdi
	call	__asan_report_load8
.L834:
	movq	32(%rsp), %rdi
	call	__asan_report_load4
.L840:
	call	__asan_report_load8
.L839:
	call	__asan_report_load8
.L838:
	call	__asan_report_load8
.L831:
	call	__asan_report_store4
.L830:
	movq	%r10, %rdi
	call	__asan_report_store4
.L829:
	movq	32(%rsp), %rdi
	call	__asan_report_load4
.L841:
	call	__asan_report_load4
.L837:
	call	__asan_report_load8
.L836:
	call	__asan_report_load8
.L835:
	movq	40(%rsp), %rdi
	call	__asan_report_load8
.L828:
	movq	16(%rsp), %rdi
	call	__asan_report_store8
.L827:
	movq	%r15, %rdi
	call	__asan_report_store8
.L826:
	movq	32(%rsp), %rdi
	call	__asan_report_store4
.L845:
	movq	%rcx, %rdi
	call	__asan_report_load8
.L844:
	movq	%rax, %rdi
	call	__asan_report_load8
	.cfi_endproc
.LFE21:
	.size	check_throttles, .-check_throttles
	.section	.text.unlikely
.LCOLDE108:
	.text
.LHOTE108:
	.section	.text.unlikely
.LCOLDB109:
	.text
.LHOTB109:
	.p2align 4,,15
	.type	shut_down, @function
shut_down:
.LASANPC16:
.LFB16:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	movl	__asan_option_detect_stack_use_after_return(%rip), %ecx
	leaq	16(%rsp), %rbp
	testl	%ecx, %ecx
	jne	.L900
.L846:
	leaq	32(%rbp), %rbx
	movq	%rbp, %rax
	movq	$1102416563, 0(%rbp)
	shrq	$3, %rax
	movq	$.LC14, 8(%rbp)
	movq	$.LASANPC16, 16(%rbp)
	xorl	%esi, %esi
	movq	%rax, 8(%rsp)
	movq	%rbx, %rdi
	movl	$-235802127, 2147450880(%rax)
	movl	$-185335808, 2147450884(%rax)
	xorl	%r15d, %r15d
	movl	$-202116109, 2147450888(%rax)
	call	gettimeofday
	movq	%rbx, %rdi
	xorl	%ebx, %ebx
	call	logstats
	movl	max_connects(%rip), %edx
	leaq	32(%rbp), %rax
	movq	%rax, (%rsp)
	testl	%edx, %edx
	jg	.L887
	jmp	.L860
	.p2align 4,,10
	.p2align 3
.L854:
	leaq	8(%rdx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L901
	movq	8(%rdx), %rdi
	testq	%rdi, %rdi
	je	.L857
	call	httpd_destroy_conn
	movq	%r15, %r13
	addq	connects(%rip), %r13
	leaq	8(%r13), %r14
	movq	%r14, %r12
	shrq	$3, %r12
	cmpb	$0, 2147450880(%r12)
	jne	.L902
	movq	8(%r13), %rdi
	call	free
	subl	$1, httpd_conn_count(%rip)
	cmpb	$0, 2147450880(%r12)
	jne	.L903
	movq	$0, 8(%r13)
.L857:
	addl	$1, %ebx
	addq	$144, %r15
	cmpl	%ebx, max_connects(%rip)
	jle	.L860
.L887:
	movq	%r15, %rdx
	addq	connects(%rip), %rdx
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L853
	movq	%rdx, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%al, %cl
	jge	.L904
.L853:
	movl	(%rdx), %eax
	testl	%eax, %eax
	je	.L854
	leaq	8(%rdx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L905
	movq	8(%rdx), %rdi
	movq	(%rsp), %rsi
	call	httpd_close_conn
	movq	%r15, %rdx
	addq	connects(%rip), %rdx
	jmp	.L854
	.p2align 4,,10
	.p2align 3
.L860:
	movq	hs(%rip), %rbx
	testq	%rbx, %rbx
	je	.L852
	leaq	72(%rbx), %rdi
	movq	$0, hs(%rip)
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L861
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L906
.L861:
	movl	72(%rbx), %edi
	cmpl	$-1, %edi
	je	.L862
	call	fdwatch_del_fd
.L862:
	leaq	76(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L863
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L907
.L863:
	movl	76(%rbx), %edi
	cmpl	$-1, %edi
	je	.L864
	call	fdwatch_del_fd
.L864:
	movq	%rbx, %rdi
	call	httpd_terminate
.L852:
	call	mmc_destroy
	call	tmr_destroy
	movq	connects(%rip), %rdi
	call	free
	movq	throttles(%rip), %rdi
	testq	%rdi, %rdi
	je	.L849
	call	free
.L849:
	leaq	16(%rsp), %rax
	cmpq	%rbp, %rax
	jne	.L908
	movq	8(%rsp), %rax
	movq	$0, 2147450880(%rax)
	movl	$0, 2147450888(%rax)
.L848:
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L907:
	.cfi_restore_state
	call	__asan_report_load4
.L906:
	call	__asan_report_load4
.L905:
	call	__asan_report_load8
.L903:
	movq	%r14, %rdi
	call	__asan_report_store8
.L902:
	movq	%r14, %rdi
	call	__asan_report_load8
.L901:
	call	__asan_report_load8
.L904:
	movq	%rdx, %rdi
	call	__asan_report_load4
.L900:
	movq	%rbp, %rsi
	movl	$96, %edi
	call	__asan_stack_malloc_1
	movq	%rax, %rbp
	jmp	.L846
.L908:
	movq	$1172321806, 0(%rbp)
	movq	8(%rsp), %rax
	movabsq	$-723401728380766731, %rsi
	movq	%rsi, 2147450880(%rax)
	movl	$-168430091, 2147450888(%rax)
	jmp	.L848
	.cfi_endproc
.LFE16:
	.size	shut_down, .-shut_down
	.section	.text.unlikely
.LCOLDE109:
	.text
.LHOTE109:
	.section	.rodata
	.align 32
.LC110:
	.string	"exiting"
	.zero	56
	.section	.text.unlikely
.LCOLDB111:
	.text
.LHOTB111:
	.p2align 4,,15
	.type	handle_usr1, @function
handle_usr1:
.LASANPC3:
.LFB3:
	.cfi_startproc
	movl	num_connects(%rip), %edx
	testl	%edx, %edx
	je	.L912
	movl	$1, got_usr1(%rip)
	ret
.L912:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	shut_down
	movl	$5, %edi
	movl	$.LC110, %esi
	xorl	%eax, %eax
	call	syslog
	call	closelog
	call	__asan_handle_no_return
	xorl	%edi, %edi
	call	exit
	.cfi_endproc
.LFE3:
	.size	handle_usr1, .-handle_usr1
	.section	.text.unlikely
.LCOLDE111:
	.text
.LHOTE111:
	.section	.rodata
	.align 32
.LC112:
	.string	"exiting due to signal %d"
	.zero	39
	.section	.text.unlikely
.LCOLDB113:
	.text
.LHOTB113:
	.p2align 4,,15
	.type	handle_term, @function
handle_term:
.LASANPC0:
.LFB0:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	%edi, %ebx
	call	shut_down
	movl	$5, %edi
	movl	%ebx, %edx
	movl	$.LC112, %esi
	xorl	%eax, %eax
	call	syslog
	call	closelog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE0:
	.size	handle_term, .-handle_term
	.section	.text.unlikely
.LCOLDE113:
	.text
.LHOTE113:
	.section	.text.unlikely
.LCOLDB114:
	.text
.LHOTB114:
	.p2align 4,,15
	.type	clear_throttles.isra.0, @function
clear_throttles.isra.0:
.LASANPC34:
.LFB34:
	.cfi_startproc
	leaq	56(%rdi), %rax
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L916
	movq	%rax, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L942
.L916:
	movl	56(%rdi), %eax
	testl	%eax, %eax
	jle	.L915
	subl	$1, %eax
	movq	throttles(%rip), %r9
	leaq	16(%rdi), %rdx
	leaq	20(%rdi,%rax,4), %r8
	.p2align 4,,10
	.p2align 3
.L920:
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L918
	movq	%rdx, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%al, %cl
	jge	.L943
.L918:
	movslq	(%rdx), %rax
	leaq	(%rax,%rax,2), %rax
	salq	$4, %rax
	addq	%r9, %rax
	leaq	40(%rax), %rdi
	movq	%rdi, %rcx
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%cl, %cl
	je	.L919
	movq	%rdi, %rsi
	andl	$7, %esi
	addl	$3, %esi
	cmpb	%cl, %sil
	jge	.L944
.L919:
	addq	$4, %rdx
	subl	$1, 40(%rax)
	cmpq	%r8, %rdx
	jne	.L920
.L915:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L942:
	.cfi_restore_state
	movq	%rax, %rdi
	call	__asan_report_load4
.L944:
	call	__asan_report_load4
.L943:
	movq	%rdx, %rdi
	call	__asan_report_load4
	.cfi_endproc
.LFE34:
	.size	clear_throttles.isra.0, .-clear_throttles.isra.0
	.section	.text.unlikely
.LCOLDE114:
	.text
.LHOTE114:
	.section	.text.unlikely
.LCOLDB115:
	.text
.LHOTB115:
	.p2align 4,,15
	.type	really_clear_connection, @function
really_clear_connection:
.LASANPC26:
.LFB26:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	8(%rdi), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%rbp, %rax
	shrq	$3, %rax
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	cmpb	$0, 2147450880(%rax)
	jne	.L985
	movq	8(%rdi), %rax
	leaq	200(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L986
	movq	200(%rax), %rdx
	addq	%rdx, stats_bytes(%rip)
	movq	%rbx, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L948
	movq	%rbx, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L987
.L948:
	cmpl	$3, (%rbx)
	je	.L949
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L950
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L988
.L950:
	movl	704(%rax), %edi
	movq	%rsi, 8(%rsp)
	call	fdwatch_del_fd
	movq	%rbp, %rax
	movq	8(%rsp), %rsi
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L989
	movq	8(%rbx), %rax
.L949:
	leaq	104(%rbx), %r12
	movq	%rax, %rdi
	call	httpd_close_conn
	movq	%r12, %rbp
	movq	%rbx, %rdi
	shrq	$3, %rbp
	call	clear_throttles.isra.0
	cmpb	$0, 2147450880(%rbp)
	jne	.L990
	movq	104(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L953
	call	tmr_cancel
	cmpb	$0, 2147450880(%rbp)
	jne	.L991
	movq	$0, 104(%rbx)
.L953:
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L955
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L992
.L955:
	leaq	4(%rbx), %rdi
	movl	$0, (%rbx)
	movl	first_free_connect(%rip), %edx
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L956
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%al, %cl
	jge	.L993
.L956:
	movl	%edx, 4(%rbx)
	subq	connects(%rip), %rbx
	movabsq	$-8198552921648689607, %rax
	subl	$1, num_connects(%rip)
	sarq	$4, %rbx
	imulq	%rax, %rbx
	movl	%ebx, first_free_connect(%rip)
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L987:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	__asan_report_load4
.L993:
	call	__asan_report_store4
.L992:
	movq	%rbx, %rdi
	call	__asan_report_store4
.L988:
	call	__asan_report_load4
.L989:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L985:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L990:
	movq	%r12, %rdi
	call	__asan_report_load8
.L991:
	movq	%r12, %rdi
	call	__asan_report_store8
.L986:
	call	__asan_report_load8
	.cfi_endproc
.LFE26:
	.size	really_clear_connection, .-really_clear_connection
	.section	.text.unlikely
.LCOLDE115:
	.text
.LHOTE115:
	.section	.rodata
	.align 32
.LC116:
	.string	"replacing non-null linger_timer!"
	.zero	63
	.align 32
.LC117:
	.string	"tmr_create(linger_clear_connection) failed"
	.zero	53
	.section	.text.unlikely
.LCOLDB118:
	.text
.LHOTB118:
	.p2align 4,,15
	.type	clear_connection, @function
clear_connection:
.LASANPC25:
.LFB25:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	96(%rdi), %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	movq	%r13, %rbp
	shrq	$3, %rbp
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	cmpb	$0, 2147450880(%rbp)
	jne	.L1072
	movq	96(%rdi), %rdi
	movq	%rsi, %r12
	testq	%rdi, %rdi
	je	.L996
	call	tmr_cancel
	cmpb	$0, 2147450880(%rbp)
	jne	.L1073
	movq	$0, 96(%rbx)
.L996:
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L998
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1074
.L998:
	cmpl	$4, (%rbx)
	je	.L999
	leaq	8(%rbx), %rbp
	movq	%rbp, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1075
	movq	8(%rbx), %rax
	leaq	556(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1001
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L1076
.L1001:
	movl	556(%rax), %edx
	testl	%edx, %edx
	je	.L1003
	movq	%rbx, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1008
	movq	%rbx, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L1077
.L1008:
	cmpl	$3, (%rbx)
	je	.L1009
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1010
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L1078
.L1010:
	movl	704(%rax), %edi
	call	fdwatch_del_fd
	movq	%rbp, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1079
	movq	8(%rbx), %rax
.L1009:
	movq	%rbx, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1012
	movq	%rbx, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L1080
.L1012:
	leaq	704(%rax), %rdi
	movl	$4, (%rbx)
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1013
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L1081
.L1013:
	movl	704(%rax), %edi
	movl	$1, %esi
	call	shutdown
	movq	%rbp, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1082
	movq	8(%rbx), %rax
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1015
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L1083
.L1015:
	movl	704(%rax), %edi
	leaq	104(%rbx), %rbp
	xorl	%edx, %edx
	movq	%rbx, %rsi
	call	fdwatch_add_fd
	movq	%rbp, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1084
	cmpq	$0, 104(%rbx)
	je	.L1017
	movl	$.LC116, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L1017:
	xorl	%r8d, %r8d
	movq	%rbx, %rdx
	movl	$500, %ecx
	movl	$linger_clear_connection, %esi
	movq	%r12, %rdi
	call	tmr_create
	movq	%rbp, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1085
	testq	%rax, %rax
	movq	%rax, 104(%rbx)
	je	.L1086
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L999:
	.cfi_restore_state
	leaq	104(%rbx), %r13
	movq	%r13, %rbp
	shrq	$3, %rbp
	cmpb	$0, 2147450880(%rbp)
	jne	.L1087
	movq	104(%rbx), %rdi
	call	tmr_cancel
	cmpb	$0, 2147450880(%rbp)
	jne	.L1088
	leaq	8(%rbx), %rdi
	movq	$0, 104(%rbx)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1089
	movq	8(%rbx), %rax
	leaq	556(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1007
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L1090
.L1007:
	movl	$0, 556(%rax)
.L1003:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%r12, %rsi
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	really_clear_connection
.L1074:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	__asan_report_load4
.L1080:
	movq	%rbx, %rdi
	call	__asan_report_store4
.L1083:
	call	__asan_report_load4
.L1081:
	call	__asan_report_load4
.L1077:
	movq	%rbx, %rdi
	call	__asan_report_load4
.L1076:
	call	__asan_report_load4
.L1078:
	call	__asan_report_load4
.L1086:
	movl	$2, %edi
	movl	$.LC117, %esi
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1090:
	call	__asan_report_store4
.L1072:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1079:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L1087:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1084:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L1089:
	call	__asan_report_load8
.L1088:
	movq	%r13, %rdi
	call	__asan_report_store8
.L1082:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L1075:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L1085:
	movq	%rbp, %rdi
	call	__asan_report_store8
.L1073:
	movq	%r13, %rdi
	call	__asan_report_store8
	.cfi_endproc
.LFE25:
	.size	clear_connection, .-clear_connection
	.section	.text.unlikely
.LCOLDE118:
	.text
.LHOTE118:
	.section	.text.unlikely
.LCOLDB119:
	.text
.LHOTB119:
	.p2align 4,,15
	.type	finish_connection, @function
finish_connection:
.LASANPC24:
.LFB24:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	leaq	8(%rdi), %rdi
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1094
	movq	8(%rbx), %rdi
	movq	%rsi, %rbp
	call	httpd_write_response
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	clear_connection
.L1094:
	.cfi_restore_state
	call	__asan_report_load8
	.cfi_endproc
.LFE24:
	.size	finish_connection, .-finish_connection
	.section	.text.unlikely
.LCOLDE119:
	.text
.LHOTE119:
	.section	.text.unlikely
.LCOLDB120:
	.text
.LHOTB120:
	.p2align 4,,15
	.type	handle_read, @function
handle_read:
.LASANPC18:
.LFB18:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	leaq	8(%rdi), %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rax
	shrq	$3, %rax
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	cmpb	$0, 2147450880(%rax)
	jne	.L1215
	movq	8(%rbp), %rbx
	leaq	160(%rbx), %r13
	movq	%r13, %r15
	shrq	$3, %r15
	cmpb	$0, 2147450880(%r15)
	jne	.L1216
	leaq	152(%rbx), %r14
	movq	160(%rbx), %rax
	movq	%r14, %rcx
	shrq	$3, %rcx
	cmpb	$0, 2147450880(%rcx)
	jne	.L1217
	movq	152(%rbx), %rdx
	movq	%rsi, %r12
	leaq	144(%rbx), %r8
	cmpq	%rdx, %rax
	jb	.L1099
	cmpq	$5000, %rdx
	jbe	.L1100
	movl	$httpd_err400form, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1218
	movl	$httpd_err400title, %eax
	movq	httpd_err400form(%rip), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1219
.L1121:
	movq	httpd_err400title(%rip), %rdx
	movl	$.LC62, %r9d
	movl	$400, %esi
	movq	%r9, %rcx
	movq	%rbx, %rdi
	call	httpd_send_err
.L1214:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rsi
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	finish_connection
	.p2align 4,,10
	.p2align 3
.L1100:
	.cfi_restore_state
	leaq	144(%rbx), %r8
	addq	$1000, %rdx
	movq	%r14, %rsi
	movq	%rcx, 8(%rsp)
	movq	%r8, %rdi
	movq	%r8, (%rsp)
	call	httpd_realloc_str
	movq	8(%rsp), %rcx
	movq	(%rsp), %r8
	cmpb	$0, 2147450880(%rcx)
	jne	.L1220
	cmpb	$0, 2147450880(%r15)
	movq	152(%rbx), %rdx
	jne	.L1221
	movq	160(%rbx), %rax
.L1099:
	movq	%r8, %rcx
	subq	%rax, %rdx
	shrq	$3, %rcx
	cmpb	$0, 2147450880(%rcx)
	jne	.L1222
	addq	144(%rbx), %rax
	leaq	704(%rbx), %r14
	movq	%rax, %rsi
	movq	%r14, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1106
	movq	%r14, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%al, %cl
	jge	.L1223
.L1106:
	movl	704(%rbx), %edi
	call	read
	testl	%eax, %eax
	je	.L1224
	js	.L1225
	movq	%r13, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1226
	cltq
	addq	%rax, 160(%rbx)
	movq	%r12, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1227
	leaq	88(%rbp), %rdi
	movq	(%r12), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1228
	movq	%rax, 88(%rbp)
	movq	%rbx, %rdi
	call	httpd_got_request
	testl	%eax, %eax
	je	.L1095
	cmpl	$2, %eax
	jne	.L1212
	movl	$httpd_err400form, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1229
	movl	$httpd_err400title, %eax
	movq	httpd_err400form(%rip), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	je	.L1121
	movl	$httpd_err400title, %edi
	call	__asan_report_load8
	.p2align 4,,10
	.p2align 3
.L1225:
	call	__errno_location
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1111
	movq	%rax, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L1230
.L1111:
	movl	(%rax), %eax
	cmpl	$11, %eax
	jne	.L1231
.L1095:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1224:
	.cfi_restore_state
	movl	$httpd_err400form, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1232
	movl	$httpd_err400title, %eax
	movq	httpd_err400form(%rip), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	je	.L1121
	movl	$httpd_err400title, %edi
	call	__asan_report_load8
	.p2align 4,,10
	.p2align 3
.L1231:
	cmpl	$4, %eax
	je	.L1095
	movl	$httpd_err400form, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1233
	movl	$httpd_err400title, %eax
	movq	httpd_err400form(%rip), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	je	.L1121
	movl	$httpd_err400title, %edi
	call	__asan_report_load8
	.p2align 4,,10
	.p2align 3
.L1212:
	movq	%rbx, %rdi
	call	httpd_parse_request
	testl	%eax, %eax
	js	.L1214
	movq	%rbp, %rdi
	call	check_throttles
	testl	%eax, %eax
	je	.L1234
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	httpd_start_request
	testl	%eax, %eax
	js	.L1214
	leaq	528(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1128
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1235
.L1128:
	movl	528(%rbx), %eax
	testl	%eax, %eax
	je	.L1129
	leaq	536(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1236
	leaq	136(%rbp), %rdi
	movq	536(%rbx), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1237
	leaq	544(%rbx), %rdi
	movq	%rax, 136(%rbp)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1238
	leaq	128(%rbp), %rdi
	movq	544(%rbx), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	addq	$1, %rax
	cmpb	$0, 2147450880(%rdx)
	jne	.L1239
.L1138:
	movq	%rax, 128(%rbp)
.L1134:
	leaq	712(%rbx), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1240
	cmpq	$0, 712(%rbx)
	je	.L1241
	leaq	136(%rbp), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1242
	movq	%rdi, %rdx
	movq	136(%rbp), %rax
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1243
	cmpq	128(%rbp), %rax
	jge	.L1214
	movq	%rbp, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1152
	movq	%rbp, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1244
.L1152:
	movq	%r12, %rax
	movl	$2, 0(%rbp)
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1245
	leaq	80(%rbp), %rdi
	movq	(%r12), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1246
	leaq	112(%rbp), %rdi
	movq	%rax, 80(%rbp)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1247
	movq	%r14, %rax
	movq	$0, 112(%rbp)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1156
	movq	%r14, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1248
.L1156:
	movl	704(%rbx), %edi
	call	fdwatch_del_fd
	movq	%r14, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1157
	movq	%r14, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1249
.L1157:
	movl	704(%rbx), %edi
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rsi
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	movl	$1, %edx
	jmp	fdwatch_add_fd
	.p2align 4,,10
	.p2align 3
.L1234:
	.cfi_restore_state
	leaq	208(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1250
	movl	$httpd_err503form, %eax
	movq	208(%rbx), %r9
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1251
	movl	$httpd_err503title, %eax
	movq	httpd_err503form(%rip), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1252
	movq	httpd_err503title(%rip), %rdx
	movl	$.LC62, %ecx
	movl	$503, %esi
	movq	%rbx, %rdi
	call	httpd_send_err
	jmp	.L1214
.L1223:
	movq	%r14, %rdi
	call	__asan_report_load4
.L1230:
	movq	%rax, %rdi
	call	__asan_report_load4
	.p2align 4,,10
	.p2align 3
.L1129:
	leaq	192(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1253
	movq	192(%rbx), %rax
	leaq	128(%rbp), %rdi
	testq	%rax, %rax
	js	.L1254
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	je	.L1138
	call	__asan_report_store8
	.p2align 4,,10
	.p2align 3
.L1241:
	leaq	56(%rbp), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1141
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1255
.L1141:
	movl	56(%rbp), %eax
	testl	%eax, %eax
	jle	.L1256
	leaq	200(%rbx), %rdi
	movq	throttles(%rip), %r8
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1257
	subl	$1, %eax
	movq	200(%rbx), %rsi
	leaq	16(%rbp), %rdi
	leaq	20(%rbp,%rax,4), %r9
	.p2align 4,,10
	.p2align 3
.L1148:
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1146
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1258
.L1146:
	movslq	(%rdi), %rax
	leaq	(%rax,%rax,2), %rax
	salq	$4, %rax
	addq	%r8, %rax
	leaq	32(%rax), %rdx
	movq	%rdx, %rcx
	shrq	$3, %rcx
	cmpb	$0, 2147450880(%rcx)
	jne	.L1259
	addq	$4, %rdi
	addq	%rsi, 32(%rax)
	cmpq	%r9, %rdi
	jne	.L1148
.L1144:
	leaq	136(%rbp), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1260
	movq	%rsi, 136(%rbp)
	jmp	.L1214
.L1254:
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1261
	movq	$0, 128(%rbp)
	jmp	.L1134
.L1256:
	leaq	200(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1262
	movq	200(%rbx), %rsi
	jmp	.L1144
.L1229:
	movl	$httpd_err400form, %edi
	call	__asan_report_load8
.L1259:
	movq	%rdx, %rdi
	call	__asan_report_load8
.L1257:
	call	__asan_report_load8
.L1258:
	call	__asan_report_load4
.L1261:
	call	__asan_report_store8
.L1242:
	movq	%rax, %rdi
	call	__asan_report_load8
.L1255:
	call	__asan_report_load4
.L1262:
	call	__asan_report_load8
.L1252:
	movl	$httpd_err503title, %edi
	call	__asan_report_load8
.L1251:
	movl	$httpd_err503form, %edi
	call	__asan_report_load8
.L1250:
	call	__asan_report_load8
.L1232:
	movl	$httpd_err400form, %edi
	call	__asan_report_load8
.L1216:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1215:
	call	__asan_report_load8
.L1226:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1227:
	movq	%r12, %rdi
	call	__asan_report_load8
.L1220:
	movq	%r14, %rdi
	call	__asan_report_load8
.L1221:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1218:
	movl	$httpd_err400form, %edi
	call	__asan_report_load8
.L1219:
	movl	$httpd_err400title, %edi
	call	__asan_report_load8
.L1222:
	movq	%r8, %rdi
	call	__asan_report_load8
.L1217:
	movq	%r14, %rdi
	call	__asan_report_load8
.L1228:
	call	__asan_report_store8
.L1233:
	movl	$httpd_err400form, %edi
	call	__asan_report_load8
.L1236:
	call	__asan_report_load8
.L1235:
	call	__asan_report_load4
.L1244:
	movq	%rbp, %rdi
	call	__asan_report_store4
.L1246:
	call	__asan_report_store8
.L1245:
	movq	%r12, %rdi
	call	__asan_report_load8
.L1247:
	call	__asan_report_store8
.L1249:
	movq	%r14, %rdi
	call	__asan_report_load4
.L1240:
	movq	%rax, %rdi
	call	__asan_report_load8
.L1239:
	call	__asan_report_store8
.L1238:
	call	__asan_report_load8
.L1237:
	call	__asan_report_store8
.L1243:
	call	__asan_report_load8
.L1248:
	movq	%r14, %rdi
	call	__asan_report_load4
.L1253:
	call	__asan_report_load8
.L1260:
	call	__asan_report_store8
	.cfi_endproc
.LFE18:
	.size	handle_read, .-handle_read
	.section	.text.unlikely
.LCOLDE120:
	.text
.LHOTE120:
	.section	.rodata
	.align 32
.LC121:
	.string	"%.80s connection timed out reading"
	.zero	61
	.align 32
.LC122:
	.string	"%.80s connection timed out sending"
	.zero	61
	.section	.text.unlikely
.LCOLDB123:
	.text
.LHOTB123:
	.p2align 4,,15
	.type	idle, @function
idle:
.LASANPC27:
.LFB27:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	xorl	%r12d, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	xorl	%ebp, %ebp
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movl	max_connects(%rip), %eax
	testl	%eax, %eax
	jle	.L1263
	movl	$httpd_err408form, %r13d
	movq	%rsi, %r14
	movq	%rsi, %r15
	shrq	$3, %r13
	shrq	$3, %r14
	movq	%r13, 8(%rsp)
	jmp	.L1286
	.p2align 4,,10
	.p2align 3
.L1296:
	jl	.L1266
	cmpl	$3, %eax
	jg	.L1266
	cmpb	$0, 2147450880(%r14)
	jne	.L1292
	leaq	88(%rbx), %rdi
	movq	(%r15), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1293
	subq	88(%rbx), %rax
	cmpq	$299, %rax
	jg	.L1294
.L1266:
	addl	$1, %r12d
	addq	$144, %rbp
	cmpl	%r12d, max_connects(%rip)
	jle	.L1263
.L1286:
	movq	%rbp, %rbx
	addq	connects(%rip), %rbx
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1265
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1295
.L1265:
	movl	(%rbx), %eax
	cmpl	$1, %eax
	jne	.L1296
	cmpb	$0, 2147450880(%r14)
	jne	.L1297
	leaq	88(%rbx), %rdi
	movq	(%r15), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1298
	subq	88(%rbx), %rax
	cmpq	$59, %rax
	jle	.L1266
	leaq	8(%rbx), %rcx
	movq	%rcx, %r13
	shrq	$3, %r13
	cmpb	$0, 2147450880(%r13)
	jne	.L1299
	movq	8(%rbx), %rax
	movq	%rcx, (%rsp)
	leaq	16(%rax), %rdi
	call	httpd_ntoa
	movl	$.LC121, %esi
	movq	%rax, %rdx
	movl	$6, %edi
	xorl	%eax, %eax
	call	syslog
	movq	8(%rsp), %rax
	movq	(%rsp), %rcx
	cmpb	$0, 2147450880(%rax)
	jne	.L1300
	movl	$httpd_err408title, %eax
	movq	httpd_err408form(%rip), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1301
	cmpb	$0, 2147450880(%r13)
	movq	httpd_err408title(%rip), %rdx
	jne	.L1302
	movq	8(%rbx), %rdi
	movl	$.LC62, %r9d
	movl	$408, %esi
	movq	%r9, %rcx
	call	httpd_send_err
	movq	%r15, %rsi
	movq	%rbx, %rdi
	call	finish_connection
	jmp	.L1266
	.p2align 4,,10
	.p2align 3
.L1263:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1294:
	.cfi_restore_state
	leaq	8(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1303
	movq	8(%rbx), %rax
	leaq	16(%rax), %rdi
	call	httpd_ntoa
	movl	$.LC122, %esi
	movq	%rax, %rdx
	movl	$6, %edi
	xorl	%eax, %eax
	call	syslog
	movq	%r15, %rsi
	movq	%rbx, %rdi
	call	clear_connection
	jmp	.L1266
.L1295:
	movq	%rbx, %rdi
	call	__asan_report_load4
.L1303:
	call	__asan_report_load8
.L1302:
	movq	%rcx, %rdi
	call	__asan_report_load8
.L1301:
	movl	$httpd_err408title, %edi
	call	__asan_report_load8
.L1300:
	movl	$httpd_err408form, %edi
	call	__asan_report_load8
.L1299:
	movq	%rcx, %rdi
	call	__asan_report_load8
.L1298:
	call	__asan_report_load8
.L1297:
	movq	%r15, %rdi
	call	__asan_report_load8
.L1293:
	call	__asan_report_load8
.L1292:
	movq	%r15, %rdi
	call	__asan_report_load8
	.cfi_endproc
.LFE27:
	.size	idle, .-idle
	.section	.text.unlikely
.LCOLDE123:
	.text
.LHOTE123:
	.section	.rodata.str1.1
.LC124:
	.string	"1 32 32 2 iv "
	.section	.rodata
	.align 32
.LC125:
	.string	"replacing non-null wakeup_timer!"
	.zero	63
	.align 32
.LC126:
	.string	"tmr_create(wakeup_connection) failed"
	.zero	59
	.align 32
.LC127:
	.string	"write - %m sending %.80s"
	.zero	39
	.section	.text.unlikely
.LCOLDB128:
	.text
.LHOTB128:
	.p2align 4,,15
	.type	handle_send, @function
handle_send:
.LASANPC19:
.LFB19:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$152, %rsp
	.cfi_def_cfa_offset 208
	movl	__asan_option_detect_stack_use_after_return(%rip), %eax
	leaq	48(%rsp), %r15
	testl	%eax, %eax
	jne	.L1478
.L1304:
	leaq	8(%rbx), %rax
	movq	%r15, %rbp
	movq	$1102416563, (%r15)
	shrq	$3, %rbp
	movq	$.LC124, 8(%r15)
	movq	$.LASANPC19, 16(%r15)
	movl	$-235802127, 2147450880(%rbp)
	movl	$-202116109, 2147450888(%rbp)
	leaq	96(%r15), %rsi
	movq	%rax, (%rsp)
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1479
	leaq	64(%rbx), %rax
	movq	8(%rbx), %r12
	movq	%rax, 32(%rsp)
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1480
	movq	64(%rbx), %rdx
	movl	$1000000000, %eax
	cmpq	$-1, %rdx
	je	.L1310
	leaq	3(%rdx), %rax
	testq	%rdx, %rdx
	cmovns	%rdx, %rax
	sarq	$2, %rax
.L1310:
	leaq	472(%r12), %r14
	movq	%r14, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1481
	movq	472(%r12), %rdx
	testq	%rdx, %rdx
	jne	.L1312
	leaq	128(%rbx), %rdi
	movq	%rdi, %rdx
	movq	%rdi, 8(%rsp)
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1482
	leaq	136(%rbx), %rdi
	movq	128(%rbx), %rdx
	movq	%rdi, %rsi
	movq	%rdi, 16(%rsp)
	shrq	$3, %rsi
	cmpb	$0, 2147450880(%rsi)
	jne	.L1483
	movq	136(%rbx), %rsi
	leaq	712(%r12), %rdi
	subq	%rsi, %rdx
	cmpq	%rdx, %rax
	cmovbe	%rax, %rdx
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1484
	leaq	704(%r12), %rax
	addq	712(%r12), %rsi
	movq	%rax, %rcx
	movq	%rax, 24(%rsp)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edi
	testb	%dil, %dil
	je	.L1316
	movq	%rcx, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dil, %al
	jge	.L1485
.L1316:
	movl	704(%r12), %edi
	call	write
	testl	%eax, %eax
	js	.L1486
.L1323:
	je	.L1334
	movq	%r13, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1487
	leaq	88(%rbx), %rdi
	movq	0(%r13), %rdx
	movq	%rdi, %rsi
	shrq	$3, %rsi
	cmpb	$0, 2147450880(%rsi)
	jne	.L1488
	movq	%rdx, 88(%rbx)
	movq	%r14, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1489
	movq	472(%r12), %r8
	testq	%r8, %r8
	je	.L1476
	movslq	%eax, %rdx
	cmpq	%rdx, %r8
	ja	.L1490
	subl	%r8d, %eax
	movq	$0, 472(%r12)
.L1476:
	movslq	%eax, %r9
.L1345:
	movq	16(%rsp), %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1491
	movq	(%rsp), %rax
	movq	%r9, %rdx
	addq	136(%rbx), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	movq	%rdx, 136(%rbx)
	jne	.L1492
	movq	8(%rbx), %rcx
	leaq	200(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1493
	movq	%r9, %rax
	addq	200(%rcx), %rax
	leaq	56(%rbx), %rdi
	movq	%rax, 200(%rcx)
	movq	%rdi, %rcx
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%cl, %cl
	je	.L1357
	movq	%rdi, %rsi
	andl	$7, %esi
	addl	$3, %esi
	cmpb	%cl, %sil
	jge	.L1494
.L1357:
	movl	56(%rbx), %ecx
	testl	%ecx, %ecx
	jle	.L1365
	subl	$1, %ecx
	movq	throttles(%rip), %r14
	leaq	16(%rbx), %r8
	leaq	20(%rbx,%rcx,4), %r11
	.p2align 4,,10
	.p2align 3
.L1364:
	movq	%r8, %rcx
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%cl, %cl
	je	.L1362
	movq	%r8, %rsi
	andl	$7, %esi
	addl	$3, %esi
	cmpb	%cl, %sil
	jge	.L1495
.L1362:
	movslq	(%r8), %rcx
	leaq	(%rcx,%rcx,2), %rcx
	salq	$4, %rcx
	addq	%r14, %rcx
	leaq	32(%rcx), %rdi
	movq	%rdi, %rsi
	shrq	$3, %rsi
	cmpb	$0, 2147450880(%rsi)
	jne	.L1496
	addq	$4, %r8
	addq	%r9, 32(%rcx)
	cmpq	%r11, %r8
	jne	.L1364
.L1365:
	movq	8(%rsp), %rcx
	shrq	$3, %rcx
	cmpb	$0, 2147450880(%rcx)
	jne	.L1497
	cmpq	128(%rbx), %rdx
	jge	.L1498
	leaq	112(%rbx), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1499
	movq	112(%rbx), %rdx
	cmpq	$100, %rdx
	jg	.L1500
.L1367:
	movq	32(%rsp), %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1501
	movq	64(%rbx), %rcx
	cmpq	$-1, %rcx
	je	.L1307
	movq	%r13, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1502
	leaq	80(%rbx), %rdi
	movq	0(%r13), %r14
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1503
	subq	80(%rbx), %r14
	movl	$1, %edx
	cmove	%rdx, %r14
	cqto
	idivq	%r14
	cmpq	%rax, %rcx
	jge	.L1307
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1374
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jl	.L1374
	movq	%rbx, %rdi
	call	__asan_report_store4
	.p2align 4,,10
	.p2align 3
.L1312:
	leaq	368(%r12), %rdi
	movq	%rdi, %r8
	shrq	$3, %r8
	cmpb	$0, 2147450880(%r8)
	jne	.L1504
	movq	368(%r12), %rdi
	movq	%rdx, -56(%rsi)
	movq	%rdi, -64(%rsi)
	leaq	712(%r12), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1505
	leaq	136(%rbx), %rdi
	movq	712(%r12), %rdx
	movq	%rdi, 16(%rsp)
	shrq	$3, %rdi
	cmpb	$0, 2147450880(%rdi)
	jne	.L1506
	movq	136(%rbx), %rdi
	addq	%rdi, %rdx
	movq	%rdx, -48(%rsi)
	leaq	128(%rbx), %rdx
	movq	%rdx, 8(%rsp)
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1507
	movq	128(%rbx), %rdx
	subq	%rdi, %rdx
	cmpq	%rdx, %rax
	cmova	%rdx, %rax
	movq	%rax, -40(%rsi)
	leaq	704(%r12), %rax
	movq	%rax, %rdx
	movq	%rax, 24(%rsp)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1322
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1508
.L1322:
	movl	704(%r12), %edi
	subq	$64, %rsi
	movl	$2, %edx
	call	writev
	testl	%eax, %eax
	jns	.L1323
.L1486:
	call	__errno_location
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1324
	movq	%rax, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L1509
.L1324:
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L1307
	cmpl	$11, %eax
	je	.L1334
	cmpl	$22, %eax
	setne	%cl
	cmpl	$32, %eax
	setne	%dl
	testb	%dl, %cl
	je	.L1338
	cmpl	$104, %eax
	je	.L1338
	leaq	208(%r12), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1510
	movq	208(%r12), %rdx
	movl	$.LC127, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L1338:
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	clear_connection
	jmp	.L1307
	.p2align 4,,10
	.p2align 3
.L1334:
	leaq	112(%rbx), %r14
	movq	%r14, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1511
	movq	%rbx, %rax
	addq	$100, 112(%rbx)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1329
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1512
.L1329:
	movq	24(%rsp), %rdx
	movl	$3, (%rbx)
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1330
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1513
.L1330:
	movl	704(%r12), %edi
	leaq	96(%rbx), %r12
	call	fdwatch_del_fd
	movq	%r12, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1514
	cmpq	$0, 96(%rbx)
	je	.L1333
	movl	$.LC125, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L1333:
	movq	%r14, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1515
	movq	112(%rbx), %rcx
	xorl	%r8d, %r8d
	movq	%rbx, %rdx
	movl	$wakeup_connection, %esi
	movq	%r13, %rdi
	call	tmr_create
	movq	%r12, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1516
.L1337:
	testq	%rax, %rax
	movq	%rax, 96(%rbx)
	je	.L1517
.L1307:
	leaq	48(%rsp), %rax
	cmpq	%r15, %rax
	jne	.L1518
	movl	$0, 2147450880(%rbp)
	movl	$0, 2147450888(%rbp)
.L1306:
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1500:
	.cfi_restore_state
	subq	$100, %rdx
	movq	%rdx, 112(%rbx)
	jmp	.L1367
	.p2align 4,,10
	.p2align 3
.L1490:
	leaq	368(%r12), %rdi
	subl	%eax, %r8d
	movslq	%r8d, %r8
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1519
	movq	368(%r12), %rdi
	testq	%r8, %r8
	leaq	(%rdi,%rdx), %rax
	je	.L1350
	movq	%rax, %rdx
	leaq	-1(%r8), %r11
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	leaq	(%rax,%r11), %rcx
	movq	%rcx, %rsi
	shrq	$3, %rsi
	movzbl	2147450880(%rsi), %r9d
	testb	%dl, %dl
	movq	%rax, %rsi
	setne	%r10b
	andl	$7, %esi
	cmpb	%sil, %dl
	setle	%dl
	testb	%dl, %r10b
	jne	.L1387
	testb	%r9b, %r9b
	movq	%rcx, %rdx
	setne	%sil
	andl	$7, %edx
	cmpb	%dl, %r9b
	setle	%dl
	testb	%dl, %sil
	jne	.L1387
	testq	%r8, %r8
	je	.L1350
	movq	%rdi, %rdx
	addq	%rdi, %r11
	shrq	$3, %rdx
	movq	%r11, %rsi
	movzbl	2147450880(%rdx), %edx
	shrq	$3, %rsi
	movzbl	2147450880(%rsi), %r9d
	movq	%rdi, %rsi
	testb	%dl, %dl
	setne	%cl
	andl	$7, %esi
	cmpb	%sil, %dl
	setle	%dl
	testb	%dl, %cl
	jne	.L1388
	testb	%r9b, %r9b
	setne	%dl
	andl	$7, %r11d
	cmpb	%r11b, %r9b
	setle	%sil
	testb	%sil, %dl
	je	.L1350
.L1388:
	movq	%r8, %rsi
	call	__asan_report_store_n
	.p2align 4,,10
	.p2align 3
.L1374:
	movq	24(%rsp), %rdx
	movl	$3, (%rbx)
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1375
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jl	.L1375
	movq	24(%rsp), %rdi
	call	__asan_report_load4
	.p2align 4,,10
	.p2align 3
.L1375:
	movl	704(%r12), %edi
	call	fdwatch_del_fd
	movq	(%rsp), %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1520
	movq	8(%rbx), %rax
	leaq	200(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1521
	movq	32(%rsp), %rdx
	movq	200(%rax), %rax
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1522
	cqto
	leaq	96(%rbx), %r12
	idivq	64(%rbx)
	subl	%r14d, %eax
	movslq	%eax, %r14
	movq	%r12, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1523
	cmpq	$0, 96(%rbx)
	je	.L1380
	movl	$.LC125, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L1380:
	testl	%r14d, %r14d
	movl	$500, %ecx
	jle	.L1381
	imulq	$1000, %r14, %rcx
.L1381:
	xorl	%r8d, %r8d
	movq	%rbx, %rdx
	movl	$wakeup_connection, %esi
	movq	%r13, %rdi
	call	tmr_create
	movq	%r12, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	je	.L1337
	movq	%r12, %rdi
	call	__asan_report_store8
	.p2align 4,,10
	.p2align 3
.L1498:
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	finish_connection
	jmp	.L1307
.L1350:
	movq	%r8, %rdx
	movq	%rax, %rsi
	movq	%r8, 40(%rsp)
	call	memmove
	movq	%r14, %rax
	movq	40(%rsp), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1524
	movq	%r8, 472(%r12)
	xorl	%r9d, %r9d
	jmp	.L1345
.L1518:
	movabsq	$-723401728380766731, %rax
	movq	$1172321806, (%r15)
	movl	$-168430091, 2147450888(%rbp)
	movq	%rax, 2147450880(%rbp)
	jmp	.L1306
.L1478:
	movq	%r15, %rsi
	movl	$96, %edi
	call	__asan_stack_malloc_1
	movq	%rax, %r15
	jmp	.L1304
.L1509:
	movq	%rax, %rdi
	call	__asan_report_load4
.L1512:
	movq	%rbx, %rdi
	call	__asan_report_store4
.L1513:
	movq	24(%rsp), %rdi
	call	__asan_report_load4
.L1510:
	call	__asan_report_load8
.L1519:
	call	__asan_report_load8
.L1506:
	movq	16(%rsp), %rdi
	call	__asan_report_load8
.L1505:
	call	__asan_report_load8
.L1504:
	call	__asan_report_load8
.L1487:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1488:
	call	__asan_report_store8
.L1489:
	movq	%r14, %rdi
	call	__asan_report_load8
.L1515:
	movq	%r14, %rdi
	call	__asan_report_load8
.L1387:
	movq	%r8, %rsi
	movq	%rax, %rdi
	call	__asan_report_load_n
.L1524:
	movq	%r14, %rdi
	call	__asan_report_store8
.L1523:
	movq	%r12, %rdi
	call	__asan_report_load8
.L1522:
	movq	32(%rsp), %rdi
	call	__asan_report_load8
.L1521:
	call	__asan_report_load8
.L1520:
	movq	(%rsp), %rdi
	call	__asan_report_load8
.L1514:
	movq	%r12, %rdi
	call	__asan_report_load8
.L1493:
	call	__asan_report_load8
.L1494:
	call	__asan_report_load4
.L1495:
	movq	%r8, %rdi
	call	__asan_report_load4
.L1496:
	call	__asan_report_load8
.L1491:
	movq	16(%rsp), %rdi
	call	__asan_report_load8
.L1492:
	movq	(%rsp), %rdi
	call	__asan_report_load8
.L1517:
	movl	$2, %edi
	movl	$.LC126, %esi
	xorl	%eax, %eax
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1516:
	movq	%r12, %rdi
	call	__asan_report_store8
.L1483:
	call	__asan_report_load8
.L1482:
	call	__asan_report_load8
.L1481:
	movq	%r14, %rdi
	call	__asan_report_load8
.L1507:
	movq	8(%rsp), %rdi
	call	__asan_report_load8
.L1479:
	movq	(%rsp), %rdi
	call	__asan_report_load8
.L1484:
	call	__asan_report_load8
.L1480:
	movq	32(%rsp), %rdi
	call	__asan_report_load8
.L1499:
	call	__asan_report_load8
.L1501:
	movq	32(%rsp), %rdi
	call	__asan_report_load8
.L1502:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1503:
	call	__asan_report_load8
.L1511:
	movq	%r14, %rdi
	call	__asan_report_load8
.L1485:
	movq	%rcx, %rdi
	call	__asan_report_load4
.L1508:
	movq	24(%rsp), %rdi
	call	__asan_report_load4
.L1497:
	movq	8(%rsp), %rdi
	call	__asan_report_load8
	.cfi_endproc
.LFE19:
	.size	handle_send, .-handle_send
	.section	.text.unlikely
.LCOLDE128:
	.text
.LHOTE128:
	.section	.text.unlikely
.LCOLDB129:
	.text
.LHOTB129:
	.p2align 4,,15
	.type	linger_clear_connection, @function
linger_clear_connection:
.LASANPC29:
.LFB29:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsp, %rax
	movq	%rdi, (%rsp)
	movq	%rsp, %rdi
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1529
	movq	(%rsp), %rdi
	leaq	104(%rdi), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1530
	movq	$0, 104(%rdi)
	call	really_clear_connection
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L1529:
	.cfi_restore_state
	call	__asan_report_load8
.L1530:
	movq	%rax, %rdi
	call	__asan_report_store8
	.cfi_endproc
.LFE29:
	.size	linger_clear_connection, .-linger_clear_connection
	.section	.text.unlikely
.LCOLDE129:
	.text
.LHOTE129:
	.globl	__asan_stack_malloc_7
	.section	.rodata.str1.1
.LC130:
	.string	"1 32 4096 3 buf "
	.globl	__asan_stack_free_7
	.section	.text.unlikely
.LCOLDB131:
	.text
.LHOTB131:
	.p2align 4,,15
	.type	handle_linger, @function
handle_linger:
.LASANPC20:
.LFB20:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rdi, %r14
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rsi, %r13
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$4160, %rsp
	.cfi_def_cfa_offset 4208
	movl	__asan_option_detect_stack_use_after_return(%rip), %eax
	movq	%rsp, %rbx
	movq	%rsp, %r12
	testl	%eax, %eax
	jne	.L1556
.L1531:
	leaq	8(%r14), %rdi
	movq	%rbx, %rbp
	movq	$1102416563, (%rbx)
	shrq	$3, %rbp
	movq	$.LC130, 8(%rbx)
	movq	$.LASANPC20, 16(%rbx)
	movq	%rdi, %rdx
	movl	$-235802127, 2147450880(%rbp)
	movl	$-202116109, 2147451396(%rbp)
	shrq	$3, %rdx
	leaq	4160(%rbx), %rax
	cmpb	$0, 2147450880(%rdx)
	jne	.L1557
	movq	8(%r14), %rdx
	leaq	704(%rdx), %rdi
	movq	%rdi, %rcx
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%cl, %cl
	je	.L1536
	movq	%rdi, %rsi
	andl	$7, %esi
	addl	$3, %esi
	cmpb	%cl, %sil
	jge	.L1558
.L1536:
	movl	704(%rdx), %edi
	leaq	-4128(%rax), %rsi
	movl	$4096, %edx
	call	read
	testl	%eax, %eax
	js	.L1559
	je	.L1541
.L1534:
	cmpq	%rbx, %r12
	jne	.L1560
	movl	$0, 2147450880(%rbp)
	movl	$0, 2147451396(%rbp)
.L1533:
	addq	$4160, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1559:
	.cfi_restore_state
	call	__errno_location
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1538
	movq	%rax, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L1561
.L1538:
	movl	(%rax), %eax
	cmpl	$11, %eax
	je	.L1534
	cmpl	$4, %eax
	je	.L1534
.L1541:
	movq	%r13, %rsi
	movq	%r14, %rdi
	call	really_clear_connection
	jmp	.L1534
.L1558:
	call	__asan_report_load4
.L1561:
	movq	%rax, %rdi
	call	__asan_report_load4
.L1556:
	movq	%rsp, %rsi
	movl	$4160, %edi
	call	__asan_stack_malloc_7
	movq	%rax, %rbx
	jmp	.L1531
.L1560:
	movq	$1172321806, (%rbx)
	movq	%r12, %rdx
	movl	$4160, %esi
	movq	%rbx, %rdi
	call	__asan_stack_free_7
	jmp	.L1533
.L1557:
	call	__asan_report_load8
	.cfi_endproc
.LFE20:
	.size	handle_linger, .-handle_linger
	.section	.text.unlikely
.LCOLDE131:
	.text
.LHOTE131:
	.section	.rodata.str1.8
	.align 8
.LC132:
	.string	"3 32 8 2 ai 96 10 7 portstr 160 48 5 hints "
	.section	.rodata
	.align 32
.LC133:
	.string	"%d"
	.zero	61
	.align 32
.LC134:
	.string	"getaddrinfo %.80s - %.80s"
	.zero	38
	.align 32
.LC135:
	.string	"%s: getaddrinfo %s - %s\n"
	.zero	39
	.align 32
.LC136:
	.string	"%.80s - sockaddr too small (%lu < %lu)"
	.zero	57
	.section	.text.unlikely
.LCOLDB137:
	.text
.LHOTB137:
	.p2align 4,,15
	.type	lookup_hostname.constprop.1, @function
lookup_hostname.constprop.1:
.LASANPC35:
.LFB35:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdx, %r11
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rcx, %r14
	subq	$296, %rsp
	.cfi_def_cfa_offset 352
	movl	__asan_option_detect_stack_use_after_return(%rip), %eax
	movq	%rsi, 8(%rsp)
	leaq	32(%rsp), %rbp
	testl	%eax, %eax
	jne	.L1686
.L1562:
	leaq	160(%rbp), %rbx
	movq	%rbp, %r15
	movq	$1102416563, 0(%rbp)
	shrq	$3, %r15
	movq	$.LC132, 8(%rbp)
	movq	$.LASANPC35, 16(%rbp)
	movq	%rbx, %rax
	movl	$-235802127, 2147450880(%r15)
	movl	$-185273344, 2147450884(%r15)
	shrq	$3, %rax
	movl	$-218959118, 2147450888(%r15)
	movl	$-185335296, 2147450892(%r15)
	movl	$-218959118, 2147450896(%r15)
	movl	$-185335808, 2147450904(%r15)
	movq	%rbx, %rdi
	movl	$-202116109, 2147450908(%r15)
	movzbl	2147450880(%rax), %ecx
	leaq	207(%rbp), %rax
	leaq	256(%rbp), %r12
	movq	%rax, %rdx
	shrq	$3, %rdx
	testb	%cl, %cl
	movzbl	2147450880(%rdx), %edx
	setne	%sil
	andl	$7, %edi
	cmpb	%dil, %cl
	setle	%cl
	testb	%cl, %sil
	jne	.L1603
	testb	%dl, %dl
	setne	%cl
	andl	$7, %eax
	cmpb	%al, %dl
	setle	%al
	testb	%al, %cl
	jne	.L1603
	xorl	%eax, %eax
	movq	%rbx, %rdi
	movl	$6, %ecx
	rep; stosq
	movzwl	port(%rip), %ecx
	leaq	96(%rbp), %r8
	movl	$.LC133, %edx
	movl	$10, %esi
	movl	$1, -96(%r12)
	movl	$1, -88(%r12)
	movq	%r8, %rdi
	movq	%r11, 24(%rsp)
	movq	%r8, 16(%rsp)
	call	snprintf
	movq	16(%rsp), %r8
	movq	hostname(%rip), %rdi
	leaq	32(%rbp), %rcx
	movq	%rbx, %rdx
	movq	%r8, %rsi
	call	getaddrinfo
	testl	%eax, %eax
	movl	%eax, %ebx
	movq	24(%rsp), %r11
	jne	.L1687
	movq	-224(%r12), %rax
	testq	%rax, %rax
	je	.L1570
	xorl	%ebx, %ebx
	xorl	%r9d, %r9d
	jmp	.L1576
	.p2align 4,,10
	.p2align 3
.L1691:
	cmpl	$10, %edx
	jne	.L1572
	testq	%r9, %r9
	cmove	%rax, %r9
.L1572:
	leaq	40(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1688
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L1689
.L1576:
	leaq	4(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1571
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L1690
.L1571:
	movl	4(%rax), %edx
	cmpl	$2, %edx
	jne	.L1691
	testq	%rbx, %rbx
	cmove	%rax, %rbx
	jmp	.L1572
	.p2align 4,,10
	.p2align 3
.L1689:
	testq	%r9, %r9
	je	.L1692
	leaq	16(%r9), %rdx
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1580
	movq	%rdx, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%al, %cl
	jge	.L1693
.L1580:
	movl	16(%r9), %r8d
	cmpq	$128, %r8
	ja	.L1685
	movq	%r11, %rax
	movq	%r11, %r8
	shrq	$3, %rax
	movzbl	2147450880(%rax), %esi
	leaq	127(%r11), %rax
	movq	%rax, %rcx
	shrq	$3, %rcx
	testb	%sil, %sil
	movzbl	2147450880(%rcx), %ecx
	setne	%dil
	andl	$7, %r8d
	cmpb	%r8b, %sil
	setle	%sil
	testb	%sil, %dil
	jne	.L1604
	testb	%cl, %cl
	setne	%sil
	andl	$7, %eax
	cmpb	%al, %cl
	setle	%al
	testb	%al, %sil
	jne	.L1604
	leaq	8(%r11), %rdi
	movq	%r11, %rcx
	xorl	%eax, %eax
	movq	$0, (%r11)
	movq	$0, 120(%r11)
	andq	$-8, %rdi
	subq	%rdi, %rcx
	subl	$-128, %ecx
	shrl	$3, %ecx
	rep; stosq
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1584
	movq	%rdx, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%al, %cl
	jge	.L1694
.L1584:
	leaq	24(%r9), %rdi
	movl	16(%r9), %edx
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1695
	testq	%rdx, %rdx
	movq	24(%r9), %rdi
	je	.L1588
	movq	%rdi, %rax
	movq	%rdi, %r8
	shrq	$3, %rax
	movzbl	2147450880(%rax), %esi
	leaq	-1(%rdx), %rax
	leaq	(%rdi,%rax), %r9
	movq	%r9, %rcx
	shrq	$3, %rcx
	testb	%sil, %sil
	setne	%r10b
	andl	$7, %r8d
	movzbl	2147450880(%rcx), %ecx
	cmpb	%r8b, %sil
	setle	%sil
	testb	%sil, %r10b
	jne	.L1605
	testb	%cl, %cl
	setne	%sil
	andl	$7, %r9d
	cmpb	%r9b, %cl
	setle	%cl
	testb	%cl, %sil
	jne	.L1605
	addq	%r11, %rax
	movq	%rax, %rcx
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%cl, %cl
	je	.L1588
	andl	$7, %eax
	cmpb	%al, %cl
	jg	.L1588
	movq	%rdx, %rsi
	movq	%r11, %rdi
	call	__asan_report_store_n
	.p2align 4,,10
	.p2align 3
.L1588:
	movq	%rdi, %rsi
	movq	%r11, %rdi
	call	memmove
	movq	%r14, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1589
	movq	%r14, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1696
.L1589:
	movl	$1, (%r14)
.L1579:
	testq	%rbx, %rbx
	je	.L1697
	leaq	16(%rbx), %rdx
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1593
	movq	%rdx, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%al, %cl
	jge	.L1698
.L1593:
	movl	16(%rbx), %r8d
	cmpq	$128, %r8
	ja	.L1685
	movq	%r13, %rax
	movq	%r13, %r8
	shrq	$3, %rax
	movzbl	2147450880(%rax), %esi
	leaq	127(%r13), %rax
	movq	%rax, %rcx
	shrq	$3, %rcx
	testb	%sil, %sil
	movzbl	2147450880(%rcx), %ecx
	setne	%dil
	andl	$7, %r8d
	cmpb	%r8b, %sil
	setle	%sil
	testb	%sil, %dil
	jne	.L1606
	testb	%cl, %cl
	setne	%sil
	andl	$7, %eax
	cmpb	%al, %cl
	setle	%al
	testb	%al, %sil
	jne	.L1606
	leaq	8(%r13), %rdi
	movq	%r13, %rcx
	xorl	%eax, %eax
	movq	$0, 0(%r13)
	movq	$0, 120(%r13)
	andq	$-8, %rdi
	subq	%rdi, %rcx
	subl	$-128, %ecx
	shrl	$3, %ecx
	rep; stosq
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1597
	movq	%rdx, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%al, %cl
	jge	.L1699
.L1597:
	leaq	24(%rbx), %rdi
	movl	16(%rbx), %edx
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1700
	testq	%rdx, %rdx
	movq	24(%rbx), %rdi
	je	.L1601
	movq	%rdi, %rax
	movq	%rdi, %r11
	shrq	$3, %rax
	movzbl	2147450880(%rax), %r8d
	leaq	-1(%rdx), %rax
	leaq	(%rdi,%rax), %rcx
	movq	%rcx, %rsi
	shrq	$3, %rsi
	testb	%r8b, %r8b
	setne	%r9b
	andl	$7, %r11d
	movzbl	2147450880(%rsi), %esi
	cmpb	%r11b, %r8b
	setle	%r8b
	testb	%r8b, %r9b
	jne	.L1607
	testb	%sil, %sil
	setne	%r8b
	andl	$7, %ecx
	cmpb	%cl, %sil
	setle	%cl
	testb	%cl, %r8b
	jne	.L1607
	addq	%r13, %rax
	movq	%rax, %rcx
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%cl, %cl
	je	.L1601
	andl	$7, %eax
	cmpb	%al, %cl
	jg	.L1601
	movq	%rdx, %rsi
	movq	%r13, %rdi
	call	__asan_report_store_n
	.p2align 4,,10
	.p2align 3
.L1601:
	movq	%rdi, %rsi
	movq	%r13, %rdi
	call	memmove
	movq	8(%rsp), %rdx
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1602
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1701
.L1602:
	movq	8(%rsp), %rax
	movl	$1, (%rax)
.L1592:
	movq	-224(%r12), %rdi
	call	freeaddrinfo
	leaq	32(%rsp), %rax
	cmpq	%rbp, %rax
	jne	.L1702
	movq	$0, 2147450880(%r15)
	movq	$0, 2147450888(%r15)
	movl	$0, 2147450896(%r15)
	movq	$0, 2147450904(%r15)
.L1564:
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L1692:
	.cfi_restore_state
	movq	%rbx, %rax
.L1570:
	movq	%r14, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1578
	movq	%r14, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L1703
.L1578:
	movl	$0, (%r14)
	movq	%rax, %rbx
	jmp	.L1579
.L1697:
	movq	8(%rsp), %rdx
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1591
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L1704
.L1591:
	movq	8(%rsp), %rax
	movl	$0, (%rax)
	jmp	.L1592
.L1703:
	movq	%r14, %rdi
	call	__asan_report_store4
.L1702:
	movabsq	$-723401728380766731, %rax
	movq	$1172321806, 0(%rbp)
	movq	%rax, 2147450880(%r15)
	movq	%rax, 2147450888(%r15)
	movq	%rax, 2147450896(%r15)
	movq	%rax, 2147450904(%r15)
	jmp	.L1564
.L1690:
	call	__asan_report_load4
.L1605:
	movq	%rdx, %rsi
	call	__asan_report_load_n
.L1695:
	call	__asan_report_load8
.L1607:
	movq	%rdx, %rsi
	call	__asan_report_load_n
.L1700:
	call	__asan_report_load8
.L1685:
	movq	hostname(%rip), %rdx
	movl	$2, %edi
	movl	$128, %ecx
	movl	$.LC136, %esi
	xorl	%eax, %eax
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1687:
	movl	%eax, %edi
	call	gai_strerror
	movq	hostname(%rip), %rdx
	movq	%rax, %rcx
	movl	$.LC134, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	call	syslog
	movl	%ebx, %edi
	call	gai_strerror
	movl	$stderr, %esi
	movq	%rax, %r8
	movq	hostname(%rip), %rcx
	shrq	$3, %rsi
	movq	argv0(%rip), %rdx
	cmpb	$0, 2147450880(%rsi)
	jne	.L1705
	movq	stderr(%rip), %rdi
	movl	$.LC135, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1603:
	movl	$48, %esi
	movq	%rbx, %rdi
	call	__asan_report_store_n
.L1688:
	call	__asan_report_load8
.L1604:
	movl	$128, %esi
	movq	%r11, %rdi
	call	__asan_report_store_n
.L1686:
	movq	%rbp, %rsi
	movl	$256, %edi
	movq	%rdx, 16(%rsp)
	call	__asan_stack_malloc_2
	movq	16(%rsp), %r11
	movq	%rax, %rbp
	jmp	.L1562
.L1705:
	movl	$stderr, %edi
	call	__asan_report_load8
.L1696:
	movq	%r14, %rdi
	call	__asan_report_store4
.L1694:
	movq	%rdx, %rdi
	call	__asan_report_load4
.L1606:
	movl	$128, %esi
	movq	%r13, %rdi
	call	__asan_report_store_n
.L1701:
	movq	8(%rsp), %rdi
	call	__asan_report_store4
.L1699:
	movq	%rdx, %rdi
	call	__asan_report_load4
.L1698:
	movq	%rdx, %rdi
	call	__asan_report_load4
.L1693:
	movq	%rdx, %rdi
	call	__asan_report_load4
.L1704:
	movq	8(%rsp), %rdi
	call	__asan_report_store4
	.cfi_endproc
.LFE35:
	.size	lookup_hostname.constprop.1, .-lookup_hostname.constprop.1
	.section	.text.unlikely
.LCOLDE137:
	.text
.LHOTE137:
	.section	.rodata.str1.8
	.align 8
.LC138:
	.string	"6 32 4 5 gotv4 96 4 5 gotv6 160 16 2 tv 224 128 3 sa4 384 128 3 sa6 544 4097 3 cwd "
	.section	.rodata
	.align 32
.LC139:
	.string	"can't find any valid address"
	.zero	35
	.align 32
.LC140:
	.string	"%s: can't find any valid address\n"
	.zero	62
	.align 32
.LC141:
	.string	"unknown user - '%.80s'"
	.zero	41
	.align 32
.LC142:
	.string	"%s: unknown user - '%s'\n"
	.zero	39
	.align 32
.LC143:
	.string	"/dev/null"
	.zero	54
	.align 32
.LC144:
	.string	"logfile is not an absolute path, you may not be able to re-open it"
	.zero	61
	.align 32
.LC145:
	.string	"%s: logfile is not an absolute path, you may not be able to re-open it\n"
	.zero	56
	.align 32
.LC146:
	.string	"fchown logfile - %m"
	.zero	44
	.align 32
.LC147:
	.string	"fchown logfile"
	.zero	49
	.align 32
.LC148:
	.string	"chdir - %m"
	.zero	53
	.align 32
.LC149:
	.string	"chdir"
	.zero	58
	.align 32
.LC150:
	.string	"/"
	.zero	62
	.align 32
.LC151:
	.string	"daemon - %m"
	.zero	52
	.align 32
.LC152:
	.string	"w"
	.zero	62
	.align 32
.LC153:
	.string	"%d\n"
	.zero	60
	.align 32
.LC154:
	.string	"fdwatch initialization failure"
	.zero	33
	.align 32
.LC155:
	.string	"chroot - %m"
	.zero	52
	.align 32
.LC156:
	.string	"logfile is not within the chroot tree, you will not be able to re-open it"
	.zero	54
	.align 32
.LC157:
	.string	"%s: logfile is not within the chroot tree, you will not be able to re-open it\n"
	.zero	49
	.align 32
.LC158:
	.string	"chroot chdir - %m"
	.zero	46
	.align 32
.LC159:
	.string	"chroot chdir"
	.zero	51
	.align 32
.LC160:
	.string	"data_dir chdir - %m"
	.zero	44
	.align 32
.LC161:
	.string	"data_dir chdir"
	.zero	49
	.align 32
.LC162:
	.string	"tmr_create(occasional) failed"
	.zero	34
	.align 32
.LC163:
	.string	"tmr_create(idle) failed"
	.zero	40
	.align 32
.LC164:
	.string	"tmr_create(update_throttles) failed"
	.zero	60
	.align 32
.LC165:
	.string	"tmr_create(show_stats) failed"
	.zero	34
	.align 32
.LC166:
	.string	"setgroups - %m"
	.zero	49
	.align 32
.LC167:
	.string	"setgid - %m"
	.zero	52
	.align 32
.LC168:
	.string	"initgroups - %m"
	.zero	48
	.align 32
.LC169:
	.string	"setuid - %m"
	.zero	52
	.align 32
.LC170:
	.string	"started as root without requesting chroot(), warning only"
	.zero	38
	.align 32
.LC171:
	.string	"out of memory allocating a connecttab"
	.zero	58
	.align 32
.LC172:
	.string	"fdwatch - %m"
	.zero	51
	.section	.text.unlikely
.LCOLDB173:
	.section	.text.startup,"ax",@progbits
.LHOTB173:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LASANPC7:
.LFB7:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%edi, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$4728, %rsp
	.cfi_def_cfa_offset 4784
	movl	__asan_option_detect_stack_use_after_return(%rip), %esi
	leaq	16(%rsp), %rbx
	testl	%esi, %esi
	jne	.L2025
.L1706:
	movq	%rbx, %rdx
	movq	%r13, %rax
	movq	$1102416563, (%rbx)
	shrq	$3, %rdx
	shrq	$3, %rax
	movq	$.LC138, 8(%rbx)
	movq	$.LASANPC7, 16(%rbx)
	movl	$-235802127, 2147450880(%rdx)
	leaq	4704(%rbx), %rbp
	movl	$-185273340, 2147450884(%rdx)
	movl	$-218959118, 2147450888(%rdx)
	movl	$-185273340, 2147450892(%rdx)
	movl	$-218959118, 2147450896(%rdx)
	movl	$-185335808, 2147450900(%rdx)
	movl	$-218959118, 2147450904(%rdx)
	movl	$-218959118, 2147450924(%rdx)
	movl	$-218959118, 2147450944(%rdx)
	movl	$-185273343, 2147451460(%rdx)
	movl	$-202116109, 2147451464(%rdx)
	cmpb	$0, 2147450880(%rax)
	jne	.L2026
	movq	0(%r13), %r12
	movl	$47, %esi
	movq	%r12, %rdi
	movq	%r12, argv0(%rip)
	call	strrchr
	leaq	1(%rax), %rdx
	testq	%rax, %rax
	movl	$9, %esi
	cmovne	%rdx, %r12
	movl	$24, %edx
	movq	%r12, %rdi
	call	openlog
	movq	%r13, %rsi
	movl	%r14d, %edi
	leaq	384(%rbx), %r13
	call	parse_args
	call	tzset
	leaq	96(%rbx), %rcx
	leaq	32(%rbx), %rsi
	addq	$224, %rbx
	movq	%r13, %rdx
	movq	%rbx, %rdi
	call	lookup_hostname.constprop.1
	movl	-4672(%rbp), %ecx
	testl	%ecx, %ecx
	jne	.L1712
	cmpl	$0, -4608(%rbp)
	je	.L2027
.L1712:
	movq	throttlefile(%rip), %rdi
	movl	$0, numthrottles(%rip)
	movl	$0, maxthrottles(%rip)
	movq	$0, throttles(%rip)
	testq	%rdi, %rdi
	je	.L1714
	call	read_throttlefile
.L1714:
	call	getuid
	testl	%eax, %eax
	movl	$32767, (%rsp)
	movl	$32767, 4(%rsp)
	je	.L2028
.L1715:
	movq	logfile(%rip), %r12
	testq	%r12, %r12
	je	.L1824
	movl	$.LC143, %edi
	movl	$10, %ecx
	movq	%r12, %rsi
	repz; cmpsb
	je	.L2029
	movl	$.LC98, %esi
	movq	%r12, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L1722
	movl	$stdout, %eax
	movq	stdout(%rip), %r15
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L2030
.L1720:
	movq	dir(%rip), %rdi
	testq	%rdi, %rdi
	je	.L1729
	call	chdir
	testl	%eax, %eax
	js	.L2031
.L1729:
	leaq	-4160(%rbp), %r12
	movl	$4096, %esi
	movq	%r12, %rdi
	call	getcwd
	movq	%r12, %rax
.L1730:
	movl	(%rax), %ecx
	addq	$4, %rax
	leal	-16843009(%rcx), %edx
	notl	%ecx
	andl	%ecx, %edx
	andl	$-2139062144, %edx
	je	.L1730
	movl	%edx, %ecx
	shrl	$16, %ecx
	testl	$32896, %edx
	cmove	%ecx, %edx
	leaq	2(%rax), %rcx
	cmove	%rcx, %rax
	addb	%dl, %dl
	movq	%r12, %rdx
	sbbq	$3, %rax
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	subq	%r12, %rax
	testb	%dl, %dl
	je	.L1732
	movq	%r12, %rcx
	andl	$7, %ecx
	cmpb	%cl, %dl
	jle	.L2032
.L1732:
	leaq	(%r12,%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1733
	movq	%rdi, %rcx
	andl	$7, %ecx
	cmpb	%cl, %dl
	jle	.L2033
.L1733:
	leaq	-1(%rax), %rdx
	leaq	(%r12,%rdx), %rdi
	movq	%rdi, %rcx
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%cl, %cl
	je	.L1734
	movq	%rdi, %rsi
	andl	$7, %esi
	cmpb	%sil, %cl
	jle	.L2034
.L1734:
	cmpb	$47, -4160(%rdx,%rbp)
	je	.L1735
	movl	$.LC150, %ecx
	addq	%r12, %rax
	movq	%rcx, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edi
	movl	$.LC150+1, %edx
	movq	%rdx, %rsi
	shrq	$3, %rsi
	movzbl	2147450880(%rsi), %esi
	testb	%dil, %dil
	setne	%r8b
	andl	$7, %ecx
	cmpb	%cl, %dil
	setle	%cl
	testb	%cl, %r8b
	jne	.L1828
	testb	%sil, %sil
	setne	%cl
	andl	$7, %edx
	cmpb	%dl, %sil
	setle	%dl
	testb	%dl, %cl
	jne	.L1828
	movq	%rax, %rdx
	movq	%rax, %r8
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %esi
	leaq	1(%rax), %rdx
	movq	%rdx, %rcx
	shrq	$3, %rcx
	testb	%sil, %sil
	movzbl	2147450880(%rcx), %ecx
	setne	%dil
	andl	$7, %r8d
	cmpb	%r8b, %sil
	setle	%sil
	testb	%sil, %dil
	jne	.L1829
	testb	%cl, %cl
	setne	%sil
	andl	$7, %edx
	cmpb	%dl, %cl
	setle	%dl
	testb	%dl, %sil
	jne	.L1829
	movw	$47, (%rax)
.L1735:
	movl	debug(%rip), %edx
	testl	%edx, %edx
	jne	.L1740
	movl	$stdin, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L2035
	movq	stdin(%rip), %rdi
	call	fclose
	movl	$stdout, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L2036
	movq	stdout(%rip), %rdi
	cmpq	%rdi, %r15
	je	.L1743
	call	fclose
.L1743:
	movl	$stderr, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L2037
	movq	stderr(%rip), %rdi
	call	fclose
	movl	$1, %esi
	movl	$1, %edi
	call	daemon
	testl	%eax, %eax
	movl	$.LC151, %esi
	js	.L2021
.L1745:
	movq	pidfile(%rip), %rdi
	testq	%rdi, %rdi
	je	.L1746
	movl	$.LC152, %esi
	call	fopen
	testq	%rax, %rax
	movq	%rax, %r14
	je	.L2038
	call	getpid
	movq	%r14, %rdi
	movl	%eax, %edx
	movl	$.LC153, %esi
	xorl	%eax, %eax
	call	fprintf
	movq	%r14, %rdi
	call	fclose
.L1746:
	call	fdwatch_get_nfiles
	testl	%eax, %eax
	movl	%eax, max_connects(%rip)
	js	.L2039
	subl	$10, %eax
	cmpl	$0, do_chroot(%rip)
	movl	%eax, max_connects(%rip)
	jne	.L2040
.L1749:
	movq	data_dir(%rip), %rdi
	testq	%rdi, %rdi
	je	.L1760
	call	chdir
	testl	%eax, %eax
	js	.L2041
.L1760:
	movl	$handle_term, %esi
	movl	$15, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$handle_term, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$handle_chld, %esi
	movl	$17, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$1, %esi
	movl	$13, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$handle_hup, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$handle_usr1, %esi
	movl	$10, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$handle_usr2, %esi
	movl	$12, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$handle_alrm, %esi
	movl	$14, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$360, %edi
	movl	$0, got_hup(%rip)
	movl	$0, got_usr1(%rip)
	movl	$0, watchdog_flag(%rip)
	call	alarm
	call	tmr_init
	xorl	%esi, %esi
	cmpl	$0, -4608(%rbp)
	movl	no_empty_referers(%rip), %eax
	movq	%r13, %rdx
	movzwl	port(%rip), %ecx
	movl	cgi_limit(%rip), %r9d
	movq	cgi_pattern(%rip), %r8
	movq	hostname(%rip), %rdi
	cmove	%rsi, %rdx
	cmpl	$0, -4672(%rbp)
	pushq	%rax
	.cfi_def_cfa_offset 4792
	movl	do_global_passwd(%rip), %eax
	pushq	local_pattern(%rip)
	.cfi_def_cfa_offset 4800
	pushq	url_pattern(%rip)
	.cfi_def_cfa_offset 4808
	pushq	%rax
	.cfi_def_cfa_offset 4816
	movl	do_vhost(%rip), %eax
	cmovne	%rbx, %rsi
	pushq	%rax
	.cfi_def_cfa_offset 4824
	movl	no_symlink_check(%rip), %eax
	pushq	%rax
	.cfi_def_cfa_offset 4832
	movl	no_log(%rip), %eax
	pushq	%r15
	.cfi_def_cfa_offset 4840
	pushq	%rax
	.cfi_def_cfa_offset 4848
	movl	max_age(%rip), %eax
	pushq	%r12
	.cfi_def_cfa_offset 4856
	pushq	%rax
	.cfi_def_cfa_offset 4864
	pushq	p3p(%rip)
	.cfi_def_cfa_offset 4872
	pushq	charset(%rip)
	.cfi_def_cfa_offset 4880
	call	httpd_initialize
	addq	$96, %rsp
	.cfi_def_cfa_offset 4784
	testq	%rax, %rax
	movq	%rax, hs(%rip)
	je	.L2022
	movq	JunkClientData(%rip), %rdx
	movl	$occasional, %esi
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$120000, %ecx
	call	tmr_create
	testq	%rax, %rax
	movl	$.LC162, %esi
	je	.L2023
	movq	JunkClientData(%rip), %rdx
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$5000, %ecx
	movl	$idle, %esi
	call	tmr_create
	testq	%rax, %rax
	je	.L2042
	cmpl	$0, numthrottles(%rip)
	jle	.L1766
	movq	JunkClientData(%rip), %rdx
	movl	$update_throttles, %esi
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$2000, %ecx
	call	tmr_create
	testq	%rax, %rax
	movl	$.LC164, %esi
	je	.L2023
.L1766:
	movq	JunkClientData(%rip), %rdx
	movl	$show_stats, %esi
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$3600000, %ecx
	call	tmr_create
	testq	%rax, %rax
	movl	$.LC165, %esi
	je	.L2023
	xorl	%edi, %edi
	call	time
	movq	$0, stats_connections(%rip)
	movq	%rax, stats_time(%rip)
	movq	%rax, start_time(%rip)
	movq	$0, stats_bytes(%rip)
	movl	$0, stats_simultaneous(%rip)
	call	getuid
	testl	%eax, %eax
	je	.L2043
.L1769:
	movslq	max_connects(%rip), %r12
	movq	%r12, %rbx
	imulq	$144, %r12, %r12
	movq	%r12, %rdi
	call	malloc
	testq	%rax, %rax
	movq	%rax, connects(%rip)
	je	.L1775
	xorl	%ecx, %ecx
	testl	%ebx, %ebx
	movq	%rax, %rdx
	jle	.L1784
	.p2align 4,,10
	.p2align 3
.L1956:
	movq	%rdx, %rsi
	shrq	$3, %rsi
	movzbl	2147450880(%rsi), %esi
	testb	%sil, %sil
	je	.L1780
	movq	%rdx, %rdi
	andl	$7, %edi
	addl	$3, %edi
	cmpb	%sil, %dil
	jge	.L2044
.L1780:
	leaq	4(%rdx), %rdi
	addl	$1, %ecx
	movl	$0, (%rdx)
	movq	%rdi, %r8
	shrq	$3, %r8
	movzbl	2147450880(%r8), %r8d
	testb	%r8b, %r8b
	je	.L1781
	movq	%rdi, %r9
	andl	$7, %r9d
	addl	$3, %r9d
	cmpb	%r8b, %r9b
	jge	.L2045
.L1781:
	leaq	8(%rdx), %rdi
	movl	%ecx, 4(%rdx)
	movq	%rdi, %r8
	shrq	$3, %r8
	cmpb	$0, 2147450880(%r8)
	jne	.L2046
	movq	$0, 8(%rdx)
	addq	$144, %rdx
	cmpl	%ebx, %ecx
	jne	.L1956
.L1784:
	leaq	-144(%rax,%r12), %rax
	leaq	4(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1777
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L2047
.L1777:
	movl	$-1, 4(%rax)
	movq	hs(%rip), %rax
	movl	$0, first_free_connect(%rip)
	movl	$0, num_connects(%rip)
	movl	$0, httpd_conn_count(%rip)
	testq	%rax, %rax
	je	.L1785
	leaq	72(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1786
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L2048
.L1786:
	movl	72(%rax), %edi
	cmpl	$-1, %edi
	je	.L1787
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	fdwatch_add_fd
	movq	hs(%rip), %rax
.L1787:
	leaq	76(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1788
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L2049
.L1788:
	movl	76(%rax), %edi
	cmpl	$-1, %edi
	je	.L1785
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	fdwatch_add_fd
.L1785:
	subq	$4544, %rbp
	movq	%rbp, %rdi
	call	tmr_prepare_timeval
	.p2align 4,,10
	.p2align 3
.L1789:
	movl	terminate(%rip), %eax
	testl	%eax, %eax
	je	.L1822
	cmpl	$0, num_connects(%rip)
	jle	.L2050
.L1822:
	movl	got_hup(%rip), %eax
	testl	%eax, %eax
	jne	.L2051
.L1790:
	movq	%rbp, %rdi
	call	tmr_mstimeout
	movq	%rax, %rdi
	call	fdwatch
	testl	%eax, %eax
	movl	%eax, %ebx
	js	.L2052
	movq	%rbp, %rdi
	call	tmr_prepare_timeval
	testl	%ebx, %ebx
	je	.L2053
	movq	hs(%rip), %rax
	testq	%rax, %rax
	je	.L1808
	leaq	76(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1799
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L2054
.L1799:
	movl	76(%rax), %edi
	cmpl	$-1, %edi
	je	.L1800
	call	fdwatch_check_fd
	testl	%eax, %eax
	jne	.L1801
.L1805:
	movq	hs(%rip), %rax
	testq	%rax, %rax
	je	.L1808
.L1800:
	leaq	72(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1806
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L2055
.L1806:
	movl	72(%rax), %edi
	cmpl	$-1, %edi
	je	.L1808
	call	fdwatch_check_fd
	testl	%eax, %eax
	jne	.L2056
	.p2align 4,,10
	.p2align 3
.L1808:
	call	fdwatch_get_next_client_data
	cmpq	$-1, %rax
	movq	%rax, %rbx
	je	.L2057
	testq	%rbx, %rbx
	je	.L1808
	leaq	8(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L2058
	movq	8(%rbx), %rax
	leaq	704(%rax), %rdi
	movq	%rdi, %rcx
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%cl, %cl
	je	.L1810
	movq	%rdi, %rsi
	andl	$7, %esi
	addl	$3, %esi
	cmpb	%cl, %sil
	jge	.L2059
.L1810:
	movl	704(%rax), %edi
	call	fdwatch_check_fd
	testl	%eax, %eax
	je	.L2060
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1813
	movq	%rbx, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%al, %dl
	jge	.L2061
.L1813:
	movl	(%rbx), %eax
	cmpl	$2, %eax
	je	.L1814
	cmpl	$4, %eax
	je	.L1815
	cmpl	$1, %eax
	jne	.L1808
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	handle_read
	jmp	.L1808
.L2029:
	movl	$1, no_log(%rip)
	xorl	%r15d, %r15d
	jmp	.L1720
.L2052:
	call	__errno_location
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1792
	movq	%rax, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L2062
.L1792:
	movl	(%rax), %eax
	cmpl	$11, %eax
	je	.L1789
	cmpl	$4, %eax
	je	.L1789
	movl	$.LC172, %esi
	movl	$3, %edi
.L2024:
	xorl	%eax, %eax
	call	syslog
.L2022:
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1740:
	call	setsid
	jmp	.L1745
.L2028:
	movq	user(%rip), %rdi
	call	getpwnam
	testq	%rax, %rax
	je	.L2063
	leaq	16(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1718
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L2064
.L1718:
	leaq	20(%rax), %rdi
	movl	16(%rax), %esi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movl	%esi, 4(%rsp)
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1719
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L2065
.L1719:
	movl	20(%rax), %eax
	movl	%eax, (%rsp)
	jmp	.L1715
.L2027:
	xorl	%eax, %eax
	movl	$.LC139, %esi
	movl	$3, %edi
	call	syslog
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L2066
	movq	stderr(%rip), %rdi
	movl	$.LC140, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L2043:
	xorl	%esi, %esi
	xorl	%edi, %edi
	call	setgroups
	testl	%eax, %eax
	movl	$.LC166, %esi
	js	.L2021
	movl	(%rsp), %edi
	call	setgid
	testl	%eax, %eax
	movl	$.LC167, %esi
	js	.L2021
	movl	(%rsp), %esi
	movq	user(%rip), %rdi
	call	initgroups
	testl	%eax, %eax
	js	.L2067
.L1772:
	movl	4(%rsp), %edi
	call	setuid
	testl	%eax, %eax
	movl	$.LC169, %esi
	js	.L2021
	cmpl	$0, do_chroot(%rip)
	jne	.L1769
	movl	$.LC170, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	jmp	.L1769
.L2042:
	movl	$.LC163, %esi
.L2023:
	movl	$2, %edi
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L2060:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	clear_connection
	jmp	.L1808
.L1815:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	handle_linger
	jmp	.L1808
.L1814:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	handle_send
	jmp	.L1808
.L2057:
	movq	%rbp, %rdi
	call	tmr_run
	movl	got_usr1(%rip), %eax
	testl	%eax, %eax
	je	.L1789
	cmpl	$0, terminate(%rip)
	jne	.L1789
	movq	hs(%rip), %rax
	movl	$1, terminate(%rip)
	testq	%rax, %rax
	je	.L1789
	leaq	72(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1818
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jl	.L1818
	call	__asan_report_load4
.L1818:
	movl	72(%rax), %edi
	cmpl	$-1, %edi
	je	.L1819
	call	fdwatch_del_fd
	movq	hs(%rip), %rax
.L1819:
	leaq	76(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1820
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jl	.L1820
	call	__asan_report_load4
.L1820:
	movl	76(%rax), %edi
	cmpl	$-1, %edi
	je	.L1821
	call	fdwatch_del_fd
.L1821:
	movq	hs(%rip), %rdi
	call	httpd_unlisten
	jmp	.L1789
.L2051:
	call	re_open_logfile
	movl	$0, got_hup(%rip)
	jmp	.L1790
.L2039:
	movl	$.LC154, %esi
.L2021:
	movl	$2, %edi
	jmp	.L2024
.L2053:
	movq	%rbp, %rdi
	call	tmr_run
	jmp	.L1789
.L2040:
	movq	%r12, %rdi
	call	chroot
	testl	%eax, %eax
	js	.L2068
	movq	logfile(%rip), %r14
	testq	%r14, %r14
	je	.L1751
	movl	$.LC98, %esi
	movq	%r14, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L1751
	xorl	%eax, %eax
	orq	$-1, %rcx
	movq	%r12, %rdi
	repnz; scasb
	movq	%rcx, %rax
	notq	%rax
	leaq	-1(%rax), %rcx
	movq	%r12, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1752
	movq	%r12, %rdx
	andl	$7, %edx
	cmpb	%dl, %al
	jg	.L1752
	movq	%r12, %rdi
	call	__asan_report_load1
.L1752:
	leaq	(%r12,%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1753
	movq	%rdi, %rdx
	andl	$7, %edx
	cmpb	%dl, %al
	jg	.L1753
	call	__asan_report_load1
.L1753:
	movq	%rcx, %rdx
	movq	%r12, %rsi
	movq	%r14, %rdi
	movq	%rcx, 8(%rsp)
	call	strncmp
	testl	%eax, %eax
	movq	8(%rsp), %rcx
	je	.L2069
	xorl	%eax, %eax
	movl	$.LC156, %esi
	movl	$4, %edi
	call	syslog
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L2070
	movq	stderr(%rip), %rdi
	movl	$.LC157, %esi
	xorl	%eax, %eax
	call	fprintf
.L1751:
	movl	$.LC150, %edx
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %esi
	movl	$.LC150+1, %eax
	movq	%rax, %rcx
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%sil, %sil
	setne	%dil
	andl	$7, %edx
	cmpb	%dl, %sil
	setle	%dl
	testb	%dl, %dil
	jne	.L1830
	testb	%cl, %cl
	setne	%dl
	andl	$7, %eax
	cmpb	%al, %cl
	setle	%al
	testb	%al, %dl
	jne	.L1830
	movq	%r12, %rax
	movq	%r12, %rdi
	shrq	$3, %rax
	movzbl	2147450880(%rax), %ecx
	leaq	1(%r12), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	testb	%cl, %cl
	movzbl	2147450880(%rdx), %edx
	setne	%sil
	andl	$7, %edi
	cmpb	%dil, %cl
	setle	%cl
	testb	%cl, %sil
	jne	.L1831
	testb	%dl, %dl
	setne	%cl
	andl	$7, %eax
	cmpb	%al, %dl
	setle	%al
	testb	%al, %cl
	jne	.L1831
	movw	$47, -4160(%rbp)
	movq	%r12, %rdi
	call	chdir
	testl	%eax, %eax
	jns	.L1749
	movl	$.LC158, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	call	syslog
	movl	$.LC159, %edi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1824:
	xorl	%r15d, %r15d
	jmp	.L1720
.L1722:
	movl	$.LC100, %esi
	movq	%r12, %rdi
	call	fopen
	movq	logfile(%rip), %rdi
	movl	$384, %esi
	movq	%rax, %r15
	call	chmod
	testl	%eax, %eax
	jne	.L1827
	testq	%r15, %r15
	je	.L1827
	movq	logfile(%rip), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1726
	movq	%rdi, %rdx
	andl	$7, %edx
	cmpb	%dl, %al
	jg	.L1726
	call	__asan_report_load1
.L1726:
	cmpb	$47, (%rdi)
	je	.L1727
	xorl	%eax, %eax
	movl	$.LC144, %esi
	movl	$4, %edi
	call	syslog
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L2071
	movq	stderr(%rip), %rdi
	movl	$.LC145, %esi
	xorl	%eax, %eax
	call	fprintf
.L1727:
	movq	%r15, %rdi
	call	fileno
	movl	$1, %edx
	movl	%eax, %edi
	movl	$2, %esi
	xorl	%eax, %eax
	call	fcntl
	call	getuid
	testl	%eax, %eax
	jne	.L1720
	movq	%r15, %rdi
	call	fileno
	movl	(%rsp), %edx
	movl	4(%rsp), %esi
	movl	%eax, %edi
	call	fchown
	testl	%eax, %eax
	jns	.L1720
	movl	$.LC146, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	movl	$.LC147, %edi
	call	perror
	jmp	.L1720
.L2031:
	movl	$.LC148, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	call	syslog
	movl	$.LC149, %edi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L2038:
	movq	pidfile(%rip), %rdx
	movl	$2, %edi
	movl	$.LC89, %esi
	xorl	%eax, %eax
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L2041:
	movl	$.LC160, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	call	syslog
	movl	$.LC161, %edi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L2069:
	leaq	-1(%r14,%rcx), %rsi
	movq	%r14, %rdi
	call	strcpy
	jmp	.L1751
.L1801:
	movq	hs(%rip), %rax
	leaq	76(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1803
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L2072
.L1803:
	movl	76(%rax), %esi
	movq	%rbp, %rdi
	call	handle_newconnect
	testl	%eax, %eax
	jne	.L1789
	jmp	.L1805
.L2056:
	movq	hs(%rip), %rax
	leaq	72(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1807
	movq	%rdi, %rcx
	andl	$7, %ecx
	addl	$3, %ecx
	cmpb	%dl, %cl
	jge	.L2073
.L1807:
	movl	72(%rax), %esi
	movq	%rbp, %rdi
	call	handle_newconnect
	testl	%eax, %eax
	jne	.L1789
	jmp	.L1808
.L1827:
	movq	logfile(%rip), %rdx
	movl	$.LC89, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	call	syslog
	movq	logfile(%rip), %rdi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L2050:
	call	shut_down
	movl	$5, %edi
	movl	$.LC110, %esi
	xorl	%eax, %eax
	call	syslog
	call	closelog
	call	__asan_handle_no_return
	xorl	%edi, %edi
	call	exit
.L2068:
	movl	$.LC155, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	call	syslog
	movl	$.LC34, %edi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L2063:
	movq	user(%rip), %rdx
	movl	$.LC141, %esi
	movl	$2, %edi
	call	syslog
	movl	$stderr, %eax
	movq	user(%rip), %rcx
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L2074
	movq	stderr(%rip), %rdi
	movl	$.LC142, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1775:
	movl	$.LC171, %esi
	jmp	.L2021
.L2067:
	movl	$.LC168, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	jmp	.L1772
.L2025:
	movq	%rbx, %rsi
	movl	$4704, %edi
	call	__asan_stack_malloc_7
	movq	%rax, %rbx
	jmp	.L1706
.L2055:
	call	__asan_report_load4
.L2071:
	movl	$stderr, %edi
	call	__asan_report_load8
.L2062:
	movq	%rax, %rdi
	call	__asan_report_load4
.L2070:
	movl	$stderr, %edi
	call	__asan_report_load8
.L2036:
	movl	$stdout, %edi
	call	__asan_report_load8
.L2037:
	movl	$stderr, %edi
	call	__asan_report_load8
.L2030:
	movl	$stdout, %edi
	call	__asan_report_load8
.L2026:
	movq	%r13, %rdi
	call	__asan_report_load8
.L2065:
	call	__asan_report_load4
.L2066:
	movl	$stderr, %edi
	call	__asan_report_load8
.L2032:
	movq	%r12, %rdi
	call	__asan_report_load1
.L2033:
	call	__asan_report_load1
.L2034:
	call	__asan_report_load1
.L1828:
	movl	$2, %esi
	movl	$.LC150, %edi
	call	__asan_report_load_n
.L1829:
	movl	$2, %esi
	movq	%rax, %rdi
	call	__asan_report_store_n
.L2035:
	movl	$stdin, %edi
	call	__asan_report_load8
.L2054:
	call	__asan_report_load4
.L2073:
	call	__asan_report_load4
.L1831:
	movl	$2, %esi
	movq	%r12, %rdi
	call	__asan_report_store_n
.L1830:
	movl	$2, %esi
	movl	$.LC150, %edi
	call	__asan_report_load_n
.L2072:
	call	__asan_report_load4
.L2058:
	call	__asan_report_load8
.L2061:
	movq	%rbx, %rdi
	call	__asan_report_load4
.L2059:
	call	__asan_report_load4
.L2049:
	call	__asan_report_load4
.L2048:
	call	__asan_report_load4
.L2047:
	call	__asan_report_store4
.L2046:
	call	__asan_report_store8
.L2045:
	call	__asan_report_store4
.L2044:
	movq	%rdx, %rdi
	call	__asan_report_store4
.L2064:
	call	__asan_report_load4
.L2074:
	movl	$stderr, %edi
	call	__asan_report_load8
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE173:
	.section	.text.startup
.LHOTE173:
	.bss
	.align 32
	.type	watchdog_flag, @object
	.size	watchdog_flag, 4
watchdog_flag:
	.zero	64
	.align 32
	.type	got_usr1, @object
	.size	got_usr1, 4
got_usr1:
	.zero	64
	.align 32
	.type	got_hup, @object
	.size	got_hup, 4
got_hup:
	.zero	64
	.comm	stats_simultaneous,4,4
	.comm	stats_bytes,8,8
	.comm	stats_connections,8,8
	.comm	stats_time,8,8
	.comm	start_time,8,8
	.globl	terminate
	.align 32
	.type	terminate, @object
	.size	terminate, 4
terminate:
	.zero	64
	.align 32
	.type	hs, @object
	.size	hs, 8
hs:
	.zero	64
	.align 32
	.type	httpd_conn_count, @object
	.size	httpd_conn_count, 4
httpd_conn_count:
	.zero	64
	.align 32
	.type	first_free_connect, @object
	.size	first_free_connect, 4
first_free_connect:
	.zero	64
	.align 32
	.type	max_connects, @object
	.size	max_connects, 4
max_connects:
	.zero	64
	.align 32
	.type	num_connects, @object
	.size	num_connects, 4
num_connects:
	.zero	64
	.align 32
	.type	connects, @object
	.size	connects, 8
connects:
	.zero	64
	.align 32
	.type	maxthrottles, @object
	.size	maxthrottles, 4
maxthrottles:
	.zero	64
	.align 32
	.type	numthrottles, @object
	.size	numthrottles, 4
numthrottles:
	.zero	64
	.align 32
	.type	throttles, @object
	.size	throttles, 8
throttles:
	.zero	64
	.align 32
	.type	max_age, @object
	.size	max_age, 4
max_age:
	.zero	64
	.align 32
	.type	p3p, @object
	.size	p3p, 8
p3p:
	.zero	64
	.align 32
	.type	charset, @object
	.size	charset, 8
charset:
	.zero	64
	.align 32
	.type	user, @object
	.size	user, 8
user:
	.zero	64
	.align 32
	.type	pidfile, @object
	.size	pidfile, 8
pidfile:
	.zero	64
	.align 32
	.type	hostname, @object
	.size	hostname, 8
hostname:
	.zero	64
	.align 32
	.type	throttlefile, @object
	.size	throttlefile, 8
throttlefile:
	.zero	64
	.align 32
	.type	logfile, @object
	.size	logfile, 8
logfile:
	.zero	64
	.align 32
	.type	local_pattern, @object
	.size	local_pattern, 8
local_pattern:
	.zero	64
	.align 32
	.type	no_empty_referers, @object
	.size	no_empty_referers, 4
no_empty_referers:
	.zero	64
	.align 32
	.type	url_pattern, @object
	.size	url_pattern, 8
url_pattern:
	.zero	64
	.align 32
	.type	cgi_limit, @object
	.size	cgi_limit, 4
cgi_limit:
	.zero	64
	.align 32
	.type	cgi_pattern, @object
	.size	cgi_pattern, 8
cgi_pattern:
	.zero	64
	.align 32
	.type	do_global_passwd, @object
	.size	do_global_passwd, 4
do_global_passwd:
	.zero	64
	.align 32
	.type	do_vhost, @object
	.size	do_vhost, 4
do_vhost:
	.zero	64
	.align 32
	.type	no_symlink_check, @object
	.size	no_symlink_check, 4
no_symlink_check:
	.zero	64
	.align 32
	.type	no_log, @object
	.size	no_log, 4
no_log:
	.zero	64
	.align 32
	.type	do_chroot, @object
	.size	do_chroot, 4
do_chroot:
	.zero	64
	.align 32
	.type	data_dir, @object
	.size	data_dir, 8
data_dir:
	.zero	64
	.align 32
	.type	dir, @object
	.size	dir, 8
dir:
	.zero	64
	.align 32
	.type	port, @object
	.size	port, 2
port:
	.zero	64
	.align 32
	.type	debug, @object
	.size	debug, 4
debug:
	.zero	64
	.align 32
	.type	argv0, @object
	.size	argv0, 8
argv0:
	.zero	64
	.section	.rodata.str1.1
.LC174:
	.string	"watchdog_flag"
.LC175:
	.string	"thttpd.c"
.LC176:
	.string	"got_usr1"
.LC177:
	.string	"got_hup"
.LC178:
	.string	"terminate"
.LC179:
	.string	"hs"
.LC180:
	.string	"httpd_conn_count"
.LC181:
	.string	"first_free_connect"
.LC182:
	.string	"max_connects"
.LC183:
	.string	"num_connects"
.LC184:
	.string	"connects"
.LC185:
	.string	"maxthrottles"
.LC186:
	.string	"numthrottles"
.LC187:
	.string	"hostname"
.LC188:
	.string	"throttlefile"
.LC189:
	.string	"local_pattern"
.LC190:
	.string	"no_empty_referers"
.LC191:
	.string	"url_pattern"
.LC192:
	.string	"cgi_limit"
.LC193:
	.string	"cgi_pattern"
.LC194:
	.string	"do_global_passwd"
.LC195:
	.string	"do_vhost"
.LC196:
	.string	"no_symlink_check"
.LC197:
	.string	"no_log"
.LC198:
	.string	"do_chroot"
.LC199:
	.string	"argv0"
.LC200:
	.string	"*.LC122"
.LC201:
	.string	"*.LC148"
.LC202:
	.string	"*.LC52"
.LC203:
	.string	"*.LC99"
.LC204:
	.string	"*.LC168"
.LC205:
	.string	"*.LC94"
.LC206:
	.string	"*.LC95"
.LC207:
	.string	"*.LC3"
.LC208:
	.string	"*.LC160"
.LC209:
	.string	"*.LC163"
.LC210:
	.string	"*.LC83"
.LC211:
	.string	"*.LC48"
.LC212:
	.string	"*.LC74"
.LC213:
	.string	"*.LC91"
.LC214:
	.string	"*.LC76"
.LC215:
	.string	"*.LC98"
.LC216:
	.string	"*.LC68"
.LC217:
	.string	"*.LC155"
.LC218:
	.string	"*.LC161"
.LC219:
	.string	"*.LC49"
.LC220:
	.string	"*.LC34"
.LC221:
	.string	"*.LC45"
.LC222:
	.string	"*.LC167"
.LC223:
	.string	"*.LC69"
.LC224:
	.string	"*.LC58"
.LC225:
	.string	"*.LC134"
.LC226:
	.string	"*.LC42"
.LC227:
	.string	"*.LC11"
.LC228:
	.string	"*.LC5"
.LC229:
	.string	"*.LC139"
.LC230:
	.string	"*.LC136"
.LC231:
	.string	"*.LC90"
.LC232:
	.string	"*.LC92"
.LC233:
	.string	"*.LC147"
.LC234:
	.string	"*.LC44"
.LC235:
	.string	"*.LC53"
.LC236:
	.string	"*.LC63"
.LC237:
	.string	"*.LC70"
.LC238:
	.string	"*.LC54"
.LC239:
	.string	"*.LC150"
.LC240:
	.string	"*.LC75"
.LC241:
	.string	"*.LC43"
.LC242:
	.string	"*.LC1"
.LC243:
	.string	"*.LC100"
.LC244:
	.string	"*.LC169"
.LC245:
	.string	"*.LC153"
.LC246:
	.string	"*.LC23"
.LC247:
	.string	"*.LC60"
.LC248:
	.string	"*.LC61"
.LC249:
	.string	"*.LC133"
.LC250:
	.string	"*.LC159"
.LC251:
	.string	"*.LC56"
.LC252:
	.string	"*.LC126"
.LC253:
	.string	"*.LC32"
.LC254:
	.string	"*.LC38"
.LC255:
	.string	"*.LC158"
.LC256:
	.string	"*.LC141"
.LC257:
	.string	"*.LC142"
.LC258:
	.string	"*.LC172"
.LC259:
	.string	"*.LC33"
.LC260:
	.string	"*.LC64"
.LC261:
	.string	"*.LC86"
.LC262:
	.string	"*.LC105"
.LC263:
	.string	"*.LC80"
.LC264:
	.string	"*.LC77"
.LC265:
	.string	"*.LC78"
.LC266:
	.string	"*.LC145"
.LC267:
	.string	"*.LC29"
.LC268:
	.string	"*.LC152"
.LC269:
	.string	"*.LC151"
.LC270:
	.string	"*.LC93"
.LC271:
	.string	"*.LC154"
.LC272:
	.string	"*.LC7"
.LC273:
	.string	"*.LC156"
.LC274:
	.string	"*.LC30"
.LC275:
	.string	"*.LC81"
.LC276:
	.string	"*.LC35"
.LC277:
	.string	"*.LC55"
.LC278:
	.string	"*.LC79"
.LC279:
	.string	"*.LC39"
.LC280:
	.string	"*.LC101"
.LC281:
	.string	"*.LC46"
.LC282:
	.string	"*.LC62"
.LC283:
	.string	"*.LC149"
.LC284:
	.string	"*.LC157"
.LC285:
	.string	"*.LC135"
.LC286:
	.string	"*.LC127"
.LC287:
	.string	"*.LC170"
.LC288:
	.string	"*.LC121"
.LC289:
	.string	"*.LC89"
.LC290:
	.string	"*.LC15"
.LC291:
	.string	"*.LC165"
.LC292:
	.string	"*.LC84"
.LC293:
	.string	"*.LC96"
.LC294:
	.string	"*.LC67"
.LC295:
	.string	"*.LC82"
.LC296:
	.string	"*.LC71"
.LC297:
	.string	"*.LC166"
.LC298:
	.string	"*.LC107"
.LC299:
	.string	"*.LC171"
.LC300:
	.string	"*.LC4"
.LC301:
	.string	"*.LC116"
.LC302:
	.string	"*.LC9"
.LC303:
	.string	"*.LC117"
.LC304:
	.string	"*.LC164"
.LC305:
	.string	"*.LC125"
.LC306:
	.string	"*.LC110"
.LC307:
	.string	"*.LC36"
.LC308:
	.string	"*.LC72"
.LC309:
	.string	"*.LC20"
.LC310:
	.string	"*.LC146"
.LC311:
	.string	"*.LC143"
.LC312:
	.string	"*.LC103"
.LC313:
	.string	"*.LC47"
.LC314:
	.string	"*.LC162"
.LC315:
	.string	"*.LC57"
.LC316:
	.string	"*.LC40"
.LC317:
	.string	"*.LC104"
.LC318:
	.string	"*.LC112"
.LC319:
	.string	"*.LC65"
.LC320:
	.string	"*.LC85"
.LC321:
	.string	"*.LC51"
.LC322:
	.string	"*.LC66"
.LC323:
	.string	"*.LC73"
.LC324:
	.string	"*.LC50"
.LC325:
	.string	"*.LC41"
.LC326:
	.string	"*.LC25"
.LC327:
	.string	"*.LC26"
.LC328:
	.string	"*.LC140"
.LC329:
	.string	"*.LC37"
.LC330:
	.string	"*.LC144"
.LC331:
	.string	"*.LC31"
	.data
	.align 64
	.type	.LASAN0, @object
	.size	.LASAN0, 8064
.LASAN0:
	.quad	watchdog_flag
	.quad	4
	.quad	64
	.quad	.LC174
	.quad	.LC175
	.quad	0
	.quad	got_usr1
	.quad	4
	.quad	64
	.quad	.LC176
	.quad	.LC175
	.quad	0
	.quad	got_hup
	.quad	4
	.quad	64
	.quad	.LC177
	.quad	.LC175
	.quad	0
	.quad	terminate
	.quad	4
	.quad	64
	.quad	.LC178
	.quad	.LC175
	.quad	0
	.quad	hs
	.quad	8
	.quad	64
	.quad	.LC179
	.quad	.LC175
	.quad	0
	.quad	httpd_conn_count
	.quad	4
	.quad	64
	.quad	.LC180
	.quad	.LC175
	.quad	0
	.quad	first_free_connect
	.quad	4
	.quad	64
	.quad	.LC181
	.quad	.LC175
	.quad	0
	.quad	max_connects
	.quad	4
	.quad	64
	.quad	.LC182
	.quad	.LC175
	.quad	0
	.quad	num_connects
	.quad	4
	.quad	64
	.quad	.LC183
	.quad	.LC175
	.quad	0
	.quad	connects
	.quad	8
	.quad	64
	.quad	.LC184
	.quad	.LC175
	.quad	0
	.quad	maxthrottles
	.quad	4
	.quad	64
	.quad	.LC185
	.quad	.LC175
	.quad	0
	.quad	numthrottles
	.quad	4
	.quad	64
	.quad	.LC186
	.quad	.LC175
	.quad	0
	.quad	throttles
	.quad	8
	.quad	64
	.quad	.LC47
	.quad	.LC175
	.quad	0
	.quad	max_age
	.quad	4
	.quad	64
	.quad	.LC57
	.quad	.LC175
	.quad	0
	.quad	p3p
	.quad	8
	.quad	64
	.quad	.LC56
	.quad	.LC175
	.quad	0
	.quad	charset
	.quad	8
	.quad	64
	.quad	.LC55
	.quad	.LC175
	.quad	0
	.quad	user
	.quad	8
	.quad	64
	.quad	.LC41
	.quad	.LC175
	.quad	0
	.quad	pidfile
	.quad	8
	.quad	64
	.quad	.LC54
	.quad	.LC175
	.quad	0
	.quad	hostname
	.quad	8
	.quad	64
	.quad	.LC187
	.quad	.LC175
	.quad	0
	.quad	throttlefile
	.quad	8
	.quad	64
	.quad	.LC188
	.quad	.LC175
	.quad	0
	.quad	logfile
	.quad	8
	.quad	64
	.quad	.LC49
	.quad	.LC175
	.quad	0
	.quad	local_pattern
	.quad	8
	.quad	64
	.quad	.LC189
	.quad	.LC175
	.quad	0
	.quad	no_empty_referers
	.quad	4
	.quad	64
	.quad	.LC190
	.quad	.LC175
	.quad	0
	.quad	url_pattern
	.quad	8
	.quad	64
	.quad	.LC191
	.quad	.LC175
	.quad	0
	.quad	cgi_limit
	.quad	4
	.quad	64
	.quad	.LC192
	.quad	.LC175
	.quad	0
	.quad	cgi_pattern
	.quad	8
	.quad	64
	.quad	.LC193
	.quad	.LC175
	.quad	0
	.quad	do_global_passwd
	.quad	4
	.quad	64
	.quad	.LC194
	.quad	.LC175
	.quad	0
	.quad	do_vhost
	.quad	4
	.quad	64
	.quad	.LC195
	.quad	.LC175
	.quad	0
	.quad	no_symlink_check
	.quad	4
	.quad	64
	.quad	.LC196
	.quad	.LC175
	.quad	0
	.quad	no_log
	.quad	4
	.quad	64
	.quad	.LC197
	.quad	.LC175
	.quad	0
	.quad	do_chroot
	.quad	4
	.quad	64
	.quad	.LC198
	.quad	.LC175
	.quad	0
	.quad	data_dir
	.quad	8
	.quad	64
	.quad	.LC36
	.quad	.LC175
	.quad	0
	.quad	dir
	.quad	8
	.quad	64
	.quad	.LC33
	.quad	.LC175
	.quad	0
	.quad	port
	.quad	2
	.quad	64
	.quad	.LC32
	.quad	.LC175
	.quad	0
	.quad	debug
	.quad	4
	.quad	64
	.quad	.LC31
	.quad	.LC175
	.quad	0
	.quad	argv0
	.quad	8
	.quad	64
	.quad	.LC199
	.quad	.LC175
	.quad	0
	.quad	.LC122
	.quad	35
	.quad	96
	.quad	.LC200
	.quad	.LC175
	.quad	0
	.quad	.LC148
	.quad	11
	.quad	64
	.quad	.LC201
	.quad	.LC175
	.quad	0
	.quad	.LC52
	.quad	13
	.quad	64
	.quad	.LC202
	.quad	.LC175
	.quad	0
	.quad	.LC99
	.quad	19
	.quad	64
	.quad	.LC203
	.quad	.LC175
	.quad	0
	.quad	.LC168
	.quad	16
	.quad	64
	.quad	.LC204
	.quad	.LC175
	.quad	0
	.quad	.LC94
	.quad	3
	.quad	64
	.quad	.LC205
	.quad	.LC175
	.quad	0
	.quad	.LC95
	.quad	39
	.quad	96
	.quad	.LC206
	.quad	.LC175
	.quad	0
	.quad	.LC3
	.quad	70
	.quad	128
	.quad	.LC207
	.quad	.LC175
	.quad	0
	.quad	.LC160
	.quad	20
	.quad	64
	.quad	.LC208
	.quad	.LC175
	.quad	0
	.quad	.LC163
	.quad	24
	.quad	64
	.quad	.LC209
	.quad	.LC175
	.quad	0
	.quad	.LC83
	.quad	3
	.quad	64
	.quad	.LC210
	.quad	.LC175
	.quad	0
	.quad	.LC48
	.quad	5
	.quad	64
	.quad	.LC211
	.quad	.LC175
	.quad	0
	.quad	.LC74
	.quad	3
	.quad	64
	.quad	.LC212
	.quad	.LC175
	.quad	0
	.quad	.LC91
	.quad	16
	.quad	64
	.quad	.LC213
	.quad	.LC175
	.quad	0
	.quad	.LC76
	.quad	3
	.quad	64
	.quad	.LC214
	.quad	.LC175
	.quad	0
	.quad	.LC98
	.quad	2
	.quad	64
	.quad	.LC215
	.quad	.LC175
	.quad	0
	.quad	.LC68
	.quad	3
	.quad	64
	.quad	.LC216
	.quad	.LC175
	.quad	0
	.quad	.LC155
	.quad	12
	.quad	64
	.quad	.LC217
	.quad	.LC175
	.quad	0
	.quad	.LC161
	.quad	15
	.quad	64
	.quad	.LC218
	.quad	.LC175
	.quad	0
	.quad	.LC49
	.quad	8
	.quad	64
	.quad	.LC219
	.quad	.LC175
	.quad	0
	.quad	.LC34
	.quad	7
	.quad	64
	.quad	.LC220
	.quad	.LC175
	.quad	0
	.quad	.LC45
	.quad	16
	.quad	64
	.quad	.LC221
	.quad	.LC175
	.quad	0
	.quad	.LC167
	.quad	12
	.quad	64
	.quad	.LC222
	.quad	.LC175
	.quad	0
	.quad	.LC69
	.quad	5
	.quad	64
	.quad	.LC223
	.quad	.LC175
	.quad	0
	.quad	.LC58
	.quad	32
	.quad	64
	.quad	.LC224
	.quad	.LC175
	.quad	0
	.quad	.LC134
	.quad	26
	.quad	64
	.quad	.LC225
	.quad	.LC175
	.quad	0
	.quad	.LC42
	.quad	7
	.quad	64
	.quad	.LC226
	.quad	.LC175
	.quad	0
	.quad	.LC11
	.quad	219
	.quad	256
	.quad	.LC227
	.quad	.LC175
	.quad	0
	.quad	.LC5
	.quad	65
	.quad	128
	.quad	.LC228
	.quad	.LC175
	.quad	0
	.quad	.LC139
	.quad	29
	.quad	64
	.quad	.LC229
	.quad	.LC175
	.quad	0
	.quad	.LC136
	.quad	39
	.quad	96
	.quad	.LC230
	.quad	.LC175
	.quad	0
	.quad	.LC90
	.quad	20
	.quad	64
	.quad	.LC231
	.quad	.LC175
	.quad	0
	.quad	.LC92
	.quad	33
	.quad	96
	.quad	.LC232
	.quad	.LC175
	.quad	0
	.quad	.LC147
	.quad	15
	.quad	64
	.quad	.LC233
	.quad	.LC175
	.quad	0
	.quad	.LC44
	.quad	7
	.quad	64
	.quad	.LC234
	.quad	.LC175
	.quad	0
	.quad	.LC53
	.quad	15
	.quad	64
	.quad	.LC235
	.quad	.LC175
	.quad	0
	.quad	.LC63
	.quad	3
	.quad	64
	.quad	.LC236
	.quad	.LC175
	.quad	0
	.quad	.LC70
	.quad	4
	.quad	64
	.quad	.LC237
	.quad	.LC175
	.quad	0
	.quad	.LC54
	.quad	8
	.quad	64
	.quad	.LC238
	.quad	.LC175
	.quad	0
	.quad	.LC150
	.quad	2
	.quad	64
	.quad	.LC239
	.quad	.LC175
	.quad	0
	.quad	.LC75
	.quad	3
	.quad	64
	.quad	.LC240
	.quad	.LC175
	.quad	0
	.quad	.LC43
	.quad	9
	.quad	64
	.quad	.LC241
	.quad	.LC175
	.quad	0
	.quad	.LC1
	.quad	104
	.quad	160
	.quad	.LC242
	.quad	.LC175
	.quad	0
	.quad	.LC100
	.quad	2
	.quad	64
	.quad	.LC243
	.quad	.LC175
	.quad	0
	.quad	.LC169
	.quad	12
	.quad	64
	.quad	.LC244
	.quad	.LC175
	.quad	0
	.quad	.LC153
	.quad	4
	.quad	64
	.quad	.LC245
	.quad	.LC175
	.quad	0
	.quad	.LC23
	.quad	16
	.quad	64
	.quad	.LC246
	.quad	.LC175
	.quad	0
	.quad	.LC60
	.quad	7
	.quad	64
	.quad	.LC247
	.quad	.LC175
	.quad	0
	.quad	.LC61
	.quad	11
	.quad	64
	.quad	.LC248
	.quad	.LC175
	.quad	0
	.quad	.LC133
	.quad	3
	.quad	64
	.quad	.LC249
	.quad	.LC175
	.quad	0
	.quad	.LC159
	.quad	13
	.quad	64
	.quad	.LC250
	.quad	.LC175
	.quad	0
	.quad	.LC56
	.quad	4
	.quad	64
	.quad	.LC251
	.quad	.LC175
	.quad	0
	.quad	.LC126
	.quad	37
	.quad	96
	.quad	.LC252
	.quad	.LC175
	.quad	0
	.quad	.LC32
	.quad	5
	.quad	64
	.quad	.LC253
	.quad	.LC175
	.quad	0
	.quad	.LC38
	.quad	10
	.quad	64
	.quad	.LC254
	.quad	.LC175
	.quad	0
	.quad	.LC158
	.quad	18
	.quad	64
	.quad	.LC255
	.quad	.LC175
	.quad	0
	.quad	.LC141
	.quad	23
	.quad	64
	.quad	.LC256
	.quad	.LC175
	.quad	0
	.quad	.LC142
	.quad	25
	.quad	64
	.quad	.LC257
	.quad	.LC175
	.quad	0
	.quad	.LC172
	.quad	13
	.quad	64
	.quad	.LC258
	.quad	.LC175
	.quad	0
	.quad	.LC33
	.quad	4
	.quad	64
	.quad	.LC259
	.quad	.LC175
	.quad	0
	.quad	.LC64
	.quad	26
	.quad	64
	.quad	.LC260
	.quad	.LC175
	.quad	0
	.quad	.LC86
	.quad	3
	.quad	64
	.quad	.LC261
	.quad	.LC175
	.quad	0
	.quad	.LC105
	.quad	39
	.quad	96
	.quad	.LC262
	.quad	.LC175
	.quad	0
	.quad	.LC80
	.quad	3
	.quad	64
	.quad	.LC263
	.quad	.LC175
	.quad	0
	.quad	.LC77
	.quad	3
	.quad	64
	.quad	.LC264
	.quad	.LC175
	.quad	0
	.quad	.LC78
	.quad	3
	.quad	64
	.quad	.LC265
	.quad	.LC175
	.quad	0
	.quad	.LC145
	.quad	72
	.quad	128
	.quad	.LC266
	.quad	.LC175
	.quad	0
	.quad	.LC29
	.quad	2
	.quad	64
	.quad	.LC267
	.quad	.LC175
	.quad	0
	.quad	.LC152
	.quad	2
	.quad	64
	.quad	.LC268
	.quad	.LC175
	.quad	0
	.quad	.LC151
	.quad	12
	.quad	64
	.quad	.LC269
	.quad	.LC175
	.quad	0
	.quad	.LC93
	.quad	38
	.quad	96
	.quad	.LC270
	.quad	.LC175
	.quad	0
	.quad	.LC154
	.quad	31
	.quad	64
	.quad	.LC271
	.quad	.LC175
	.quad	0
	.quad	.LC7
	.quad	37
	.quad	96
	.quad	.LC272
	.quad	.LC175
	.quad	0
	.quad	.LC156
	.quad	74
	.quad	128
	.quad	.LC273
	.quad	.LC175
	.quad	0
	.quad	.LC30
	.quad	5
	.quad	64
	.quad	.LC274
	.quad	.LC175
	.quad	0
	.quad	.LC81
	.quad	5
	.quad	64
	.quad	.LC275
	.quad	.LC175
	.quad	0
	.quad	.LC35
	.quad	9
	.quad	64
	.quad	.LC276
	.quad	.LC175
	.quad	0
	.quad	.LC55
	.quad	8
	.quad	64
	.quad	.LC277
	.quad	.LC175
	.quad	0
	.quad	.LC79
	.quad	5
	.quad	64
	.quad	.LC278
	.quad	.LC175
	.quad	0
	.quad	.LC39
	.quad	9
	.quad	64
	.quad	.LC279
	.quad	.LC175
	.quad	0
	.quad	.LC101
	.quad	22
	.quad	64
	.quad	.LC280
	.quad	.LC175
	.quad	0
	.quad	.LC46
	.quad	9
	.quad	64
	.quad	.LC281
	.quad	.LC175
	.quad	0
	.quad	.LC62
	.quad	1
	.quad	64
	.quad	.LC282
	.quad	.LC175
	.quad	0
	.quad	.LC149
	.quad	6
	.quad	64
	.quad	.LC283
	.quad	.LC175
	.quad	0
	.quad	.LC157
	.quad	79
	.quad	128
	.quad	.LC284
	.quad	.LC175
	.quad	0
	.quad	.LC135
	.quad	25
	.quad	64
	.quad	.LC285
	.quad	.LC175
	.quad	0
	.quad	.LC127
	.quad	25
	.quad	64
	.quad	.LC286
	.quad	.LC175
	.quad	0
	.quad	.LC170
	.quad	58
	.quad	96
	.quad	.LC287
	.quad	.LC175
	.quad	0
	.quad	.LC121
	.quad	35
	.quad	96
	.quad	.LC288
	.quad	.LC175
	.quad	0
	.quad	.LC89
	.quad	11
	.quad	64
	.quad	.LC289
	.quad	.LC175
	.quad	0
	.quad	.LC15
	.quad	39
	.quad	96
	.quad	.LC290
	.quad	.LC175
	.quad	0
	.quad	.LC165
	.quad	30
	.quad	64
	.quad	.LC291
	.quad	.LC175
	.quad	0
	.quad	.LC84
	.quad	3
	.quad	64
	.quad	.LC292
	.quad	.LC175
	.quad	0
	.quad	.LC96
	.quad	44
	.quad	96
	.quad	.LC293
	.quad	.LC175
	.quad	0
	.quad	.LC67
	.quad	3
	.quad	64
	.quad	.LC294
	.quad	.LC175
	.quad	0
	.quad	.LC82
	.quad	3
	.quad	64
	.quad	.LC295
	.quad	.LC175
	.quad	0
	.quad	.LC71
	.quad	3
	.quad	64
	.quad	.LC296
	.quad	.LC175
	.quad	0
	.quad	.LC166
	.quad	15
	.quad	64
	.quad	.LC297
	.quad	.LC175
	.quad	0
	.quad	.LC107
	.quad	56
	.quad	96
	.quad	.LC298
	.quad	.LC175
	.quad	0
	.quad	.LC171
	.quad	38
	.quad	96
	.quad	.LC299
	.quad	.LC175
	.quad	0
	.quad	.LC4
	.quad	62
	.quad	96
	.quad	.LC300
	.quad	.LC175
	.quad	0
	.quad	.LC116
	.quad	33
	.quad	96
	.quad	.LC301
	.quad	.LC175
	.quad	0
	.quad	.LC9
	.quad	34
	.quad	96
	.quad	.LC302
	.quad	.LC175
	.quad	0
	.quad	.LC117
	.quad	43
	.quad	96
	.quad	.LC303
	.quad	.LC175
	.quad	0
	.quad	.LC164
	.quad	36
	.quad	96
	.quad	.LC304
	.quad	.LC175
	.quad	0
	.quad	.LC125
	.quad	33
	.quad	96
	.quad	.LC305
	.quad	.LC175
	.quad	0
	.quad	.LC110
	.quad	8
	.quad	64
	.quad	.LC306
	.quad	.LC175
	.quad	0
	.quad	.LC36
	.quad	9
	.quad	64
	.quad	.LC307
	.quad	.LC175
	.quad	0
	.quad	.LC72
	.quad	5
	.quad	64
	.quad	.LC308
	.quad	.LC175
	.quad	0
	.quad	.LC20
	.quad	5
	.quad	64
	.quad	.LC309
	.quad	.LC175
	.quad	0
	.quad	.LC146
	.quad	20
	.quad	64
	.quad	.LC310
	.quad	.LC175
	.quad	0
	.quad	.LC143
	.quad	10
	.quad	64
	.quad	.LC311
	.quad	.LC175
	.quad	0
	.quad	.LC103
	.quad	22
	.quad	64
	.quad	.LC312
	.quad	.LC175
	.quad	0
	.quad	.LC47
	.quad	10
	.quad	64
	.quad	.LC313
	.quad	.LC175
	.quad	0
	.quad	.LC162
	.quad	30
	.quad	64
	.quad	.LC314
	.quad	.LC175
	.quad	0
	.quad	.LC57
	.quad	8
	.quad	64
	.quad	.LC315
	.quad	.LC175
	.quad	0
	.quad	.LC40
	.quad	11
	.quad	64
	.quad	.LC316
	.quad	.LC175
	.quad	0
	.quad	.LC104
	.quad	36
	.quad	96
	.quad	.LC317
	.quad	.LC175
	.quad	0
	.quad	.LC112
	.quad	25
	.quad	64
	.quad	.LC318
	.quad	.LC175
	.quad	0
	.quad	.LC65
	.quad	3
	.quad	64
	.quad	.LC319
	.quad	.LC175
	.quad	0
	.quad	.LC85
	.quad	3
	.quad	64
	.quad	.LC320
	.quad	.LC175
	.quad	0
	.quad	.LC51
	.quad	8
	.quad	64
	.quad	.LC321
	.quad	.LC175
	.quad	0
	.quad	.LC66
	.quad	3
	.quad	64
	.quad	.LC322
	.quad	.LC175
	.quad	0
	.quad	.LC73
	.quad	3
	.quad	64
	.quad	.LC323
	.quad	.LC175
	.quad	0
	.quad	.LC50
	.quad	6
	.quad	64
	.quad	.LC324
	.quad	.LC175
	.quad	0
	.quad	.LC41
	.quad	5
	.quad	64
	.quad	.LC325
	.quad	.LC175
	.quad	0
	.quad	.LC25
	.quad	31
	.quad	64
	.quad	.LC326
	.quad	.LC175
	.quad	0
	.quad	.LC26
	.quad	36
	.quad	96
	.quad	.LC327
	.quad	.LC175
	.quad	0
	.quad	.LC140
	.quad	34
	.quad	96
	.quad	.LC328
	.quad	.LC175
	.quad	0
	.quad	.LC37
	.quad	8
	.quad	64
	.quad	.LC329
	.quad	.LC175
	.quad	0
	.quad	.LC144
	.quad	67
	.quad	128
	.quad	.LC330
	.quad	.LC175
	.quad	0
	.quad	.LC31
	.quad	6
	.quad	64
	.quad	.LC331
	.quad	.LC175
	.quad	0
	.section	.text.unlikely
.LCOLDB332:
	.section	.text.exit,"ax",@progbits
.LHOTB332:
	.p2align 4,,15
	.type	_GLOBAL__sub_D_00099_0_terminate, @function
_GLOBAL__sub_D_00099_0_terminate:
.LFB36:
	.cfi_startproc
	movl	$168, %esi
	movl	$.LASAN0, %edi
	jmp	__asan_unregister_globals
	.cfi_endproc
.LFE36:
	.size	_GLOBAL__sub_D_00099_0_terminate, .-_GLOBAL__sub_D_00099_0_terminate
	.section	.text.unlikely
.LCOLDE332:
	.section	.text.exit
.LHOTE332:
	.section	.dtors.65436,"aw",@progbits
	.align 8
	.quad	_GLOBAL__sub_D_00099_0_terminate
	.section	.text.unlikely
.LCOLDB333:
	.section	.text.startup
.LHOTB333:
	.p2align 4,,15
	.type	_GLOBAL__sub_I_00099_1_terminate, @function
_GLOBAL__sub_I_00099_1_terminate:
.LFB37:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	__asan_init_v3
	movl	$168, %esi
	movl	$.LASAN0, %edi
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	__asan_register_globals
	.cfi_endproc
.LFE37:
	.size	_GLOBAL__sub_I_00099_1_terminate, .-_GLOBAL__sub_I_00099_1_terminate
	.section	.text.unlikely
.LCOLDE333:
	.section	.text.startup
.LHOTE333:
	.section	.ctors.65436,"aw",@progbits
	.align 8
	.quad	_GLOBAL__sub_I_00099_1_terminate
	.ident	"GCC: (GNU) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
