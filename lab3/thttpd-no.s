	.file	"thttpd.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.type	handle_hup, @function
handle_hup:
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
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"  thttpd - %ld connections (%g/sec), %d max simultaneous, %lld bytes (%g/sec), %d httpd_conns allocated"
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.type	thttpd_logstats, @function
thttpd_logstats:
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
	.section	.rodata.str1.8
	.align 8
.LC3:
	.string	"throttle #%d '%.80s' rate %ld greatly exceeding limit %ld; %d sending"
	.align 8
.LC4:
	.string	"throttle #%d '%.80s' rate %ld exceeding limit %ld; %d sending"
	.align 8
.LC5:
	.string	"throttle #%d '%.80s' rate %ld lower than minimum %ld; %d sending"
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.p2align 4,,15
	.type	update_throttles, @function
update_throttles:
.LFB23:
	.cfi_startproc
	movl	numthrottles(%rip), %r8d
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movabsq	$6148914691236517206, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%ebx, %ebx
	testl	%r8d, %r8d
	jg	.L25
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L11:
	addl	$1, %ebx
	addq	$48, %rbp
	cmpl	%ebx, numthrottles(%rip)
	jle	.L13
.L25:
	movq	%rbp, %rcx
	addq	throttles(%rip), %rcx
	movq	32(%rcx), %rax
	movq	24(%rcx), %rdx
	movq	8(%rcx), %r9
	movq	$0, 32(%rcx)
	movq	%rax, %rsi
	shrq	$63, %rsi
	addq	%rsi, %rax
	sarq	%rax
	leaq	(%rax,%rdx,2), %rsi
	movq	%rsi, %rax
	sarq	$63, %rsi
	imulq	%r12
	subq	%rsi, %rdx
	cmpq	%r9, %rdx
	movq	%rdx, %r8
	movq	%rdx, 24(%rcx)
	jle	.L10
	movl	40(%rcx), %eax
	testl	%eax, %eax
	je	.L11
	leaq	(%r9,%r9), %rdx
	cmpq	%rdx, %r8
	jle	.L12
	subq	$8, %rsp
	.cfi_def_cfa_offset 40
	movq	(%rcx), %rcx
	movl	%ebx, %edx
	pushq	%rax
	.cfi_def_cfa_offset 48
	movl	$.LC3, %esi
	movl	$5, %edi
.L31:
	xorl	%eax, %eax
	call	syslog
	movq	%rbp, %rcx
	addq	throttles(%rip), %rcx
	popq	%rsi
	.cfi_def_cfa_offset 40
	popq	%rdi
	.cfi_def_cfa_offset 32
	movq	24(%rcx), %r8
.L10:
	movq	16(%rcx), %r9
	cmpq	%r8, %r9
	jle	.L11
	movl	40(%rcx), %eax
	testl	%eax, %eax
	je	.L11
	subq	$8, %rsp
	.cfi_def_cfa_offset 40
	movq	(%rcx), %rcx
	movl	%ebx, %edx
	pushq	%rax
	.cfi_def_cfa_offset 48
	movl	$.LC5, %esi
	xorl	%eax, %eax
	movl	$5, %edi
	addl	$1, %ebx
	addq	$48, %rbp
	call	syslog
	cmpl	%ebx, numthrottles(%rip)
	popq	%rax
	.cfi_def_cfa_offset 40
	popq	%rdx
	.cfi_def_cfa_offset 32
	jg	.L25
	.p2align 4,,10
	.p2align 3
.L13:
	movl	max_connects(%rip), %eax
	testl	%eax, %eax
	jle	.L6
	subl	$1, %eax
	movq	connects(%rip), %rdi
	movq	throttles(%rip), %r11
	leaq	9(%rax,%rax,8), %rbx
	salq	$4, %rbx
	addq	%rdi, %rbx
	jmp	.L15
	.p2align 4,,10
	.p2align 3
.L16:
	addq	$144, %rdi
	cmpq	%rbx, %rdi
	je	.L6
.L15:
	movl	(%rdi), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L16
	movl	56(%rdi), %eax
	movq	$-1, 64(%rdi)
	testl	%eax, %eax
	jle	.L16
	subl	$1, %eax
	leaq	16(%rdi), %rsi
	movq	$-1, %r8
	leaq	20(%rdi,%rax,4), %r10
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L34:
	movq	64(%rdi), %r8
.L19:
	movslq	(%rsi), %rax
	leaq	(%rax,%rax,2), %rcx
	salq	$4, %rcx
	addq	%r11, %rcx
	movq	8(%rcx), %rax
	movslq	40(%rcx), %r9
	cqto
	idivq	%r9
	cmpq	$-1, %r8
	je	.L32
	cmpq	%rax, %r8
	cmovle	%r8, %rax
.L32:
	addq	$4, %rsi
	movq	%rax, 64(%rdi)
	cmpq	%r10, %rsi
	jne	.L34
	addq	$144, %rdi
	cmpq	%rbx, %rdi
	jne	.L15
.L6:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L12:
	.cfi_restore_state
	subq	$8, %rsp
	.cfi_def_cfa_offset 40
	movq	(%rcx), %rcx
	movl	%ebx, %edx
	pushq	%rax
	.cfi_def_cfa_offset 48
	movl	$.LC4, %esi
	movl	$6, %edi
	jmp	.L31
	.cfi_endproc
.LFE23:
	.size	update_throttles, .-update_throttles
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.rodata.str1.8
	.align 8
.LC7:
	.string	"%s: no value required for %s option\n"
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.p2align 4,,15
	.type	no_value_required, @function
no_value_required:
.LFB12:
	.cfi_startproc
	testq	%rsi, %rsi
	jne	.L39
	rep; ret
.L39:
	movq	%rdi, %rcx
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rdi
	movq	argv0(%rip), %rdx
	movl	$.LC7, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE12:
	.size	no_value_required, .-no_value_required
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.rodata.str1.8
	.align 8
.LC9:
	.string	"%s: value required for %s option\n"
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.p2align 4,,15
	.type	value_required, @function
value_required:
.LFB11:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L44
	rep; ret
.L44:
	movq	%rdi, %rcx
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rdi
	movq	argv0(%rip), %rdx
	movl	$.LC9, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE11:
	.size	value_required, .-value_required
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.rodata.str1.8
	.align 8
.LC11:
	.string	"usage:  %s [-C configfile] [-p port] [-d dir] [-r|-nor] [-dd data_dir] [-s|-nos] [-v|-nov] [-g|-nog] [-u user] [-c cgipat] [-t throttles] [-h host] [-l logfile] [-i pidfile] [-T charset] [-P P3P] [-M maxage] [-V] [-D]\n"
	.section	.text.unlikely
.LCOLDB12:
.LHOTB12:
	.type	usage, @function
usage:
.LFB9:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rdi
	movl	$.LC11, %esi
	movq	argv0(%rip), %rdx
	xorl	%eax, %eax
	call	fprintf
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
.LFB28:
	.cfi_startproc
	cmpl	$3, (%rdi)
	movq	$0, 96(%rdi)
	je	.L49
	rep; ret
	.p2align 4,,10
	.p2align 3
.L49:
	movq	8(%rdi), %rax
	movl	$2, (%rdi)
	movq	%rdi, %rsi
	movl	$1, %edx
	movl	704(%rax), %eax
	movl	%eax, %edi
	jmp	fdwatch_add_fd
	.cfi_endproc
.LFE28:
	.size	wakeup_connection, .-wakeup_connection
	.section	.text.unlikely
.LCOLDE13:
	.text
.LHOTE13:
	.section	.rodata.str1.8
	.align 8
.LC14:
	.string	"up %ld seconds, stats for %ld seconds:"
	.section	.text.unlikely
.LCOLDB15:
	.text
.LHOTB15:
	.p2align 4,,15
	.type	logstats, @function
logstats:
.LFB32:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	testq	%rdi, %rdi
	je	.L54
.L51:
	movq	(%rdi), %rax
	movl	$1, %ecx
	movl	$.LC14, %esi
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
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L54:
	.cfi_restore_state
	movq	%rsp, %rdi
	xorl	%esi, %esi
	call	gettimeofday
	movq	%rsp, %rdi
	jmp	.L51
	.cfi_endproc
.LFE32:
	.size	logstats, .-logstats
	.section	.text.unlikely
.LCOLDE15:
	.text
.LHOTE15:
	.section	.text.unlikely
.LCOLDB16:
	.text
.LHOTB16:
	.p2align 4,,15
	.type	show_stats, @function
show_stats:
.LFB31:
	.cfi_startproc
	movq	%rsi, %rdi
	jmp	logstats
	.cfi_endproc
.LFE31:
	.size	show_stats, .-show_stats
	.section	.text.unlikely
.LCOLDE16:
	.text
.LHOTE16:
	.section	.text.unlikely
.LCOLDB17:
	.text
.LHOTB17:
	.p2align 4,,15
	.type	handle_usr2, @function
handle_usr2:
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
	movl	(%rax), %ebp
	movq	%rax, %rbx
	xorl	%edi, %edi
	call	logstats
	movl	%ebp, (%rbx)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE4:
	.size	handle_usr2, .-handle_usr2
	.section	.text.unlikely
.LCOLDE17:
	.text
.LHOTE17:
	.section	.text.unlikely
.LCOLDB18:
	.text
.LHOTB18:
	.p2align 4,,15
	.type	occasional, @function
occasional:
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
.LCOLDE18:
	.text
.LHOTE18:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC19:
	.string	"/tmp"
	.section	.text.unlikely
.LCOLDB20:
	.text
.LHOTB20:
	.p2align 4,,15
	.type	handle_alrm, @function
handle_alrm:
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
	movl	(%rax), %ebp
	movl	watchdog_flag(%rip), %eax
	testl	%eax, %eax
	je	.L63
	movl	$360, %edi
	movl	$0, watchdog_flag(%rip)
	call	alarm
	movl	%ebp, (%rbx)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L63:
	.cfi_restore_state
	movl	$.LC19, %edi
	call	chdir
	call	abort
	.cfi_endproc
.LFE5:
	.size	handle_alrm, .-handle_alrm
	.section	.text.unlikely
.LCOLDE20:
	.text
.LHOTE20:
	.section	.rodata.str1.1
.LC21:
	.string	"child wait - %m"
	.section	.text.unlikely
.LCOLDB22:
	.text
.LHOTB22:
	.p2align 4,,15
	.type	handle_chld, @function
handle_chld:
.LFB1:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	call	__errno_location
	movl	(%rax), %r12d
	movq	%rax, %rbx
	.p2align 4,,10
	.p2align 3
.L65:
	leaq	12(%rsp), %rsi
	movl	$1, %edx
	movl	$-1, %edi
	call	waitpid
	testl	%eax, %eax
	je	.L66
	js	.L81
	movq	hs(%rip), %rcx
	testq	%rcx, %rcx
	je	.L65
	movl	36(%rcx), %edx
	subl	$1, %edx
	cmovs	%ebp, %edx
	movl	%edx, 36(%rcx)
	jmp	.L65
	.p2align 4,,10
	.p2align 3
.L81:
	movl	(%rbx), %eax
	cmpl	$11, %eax
	je	.L65
	cmpl	$4, %eax
	je	.L65
	cmpl	$10, %eax
	je	.L66
	movl	$.LC21, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L66:
	movl	%r12d, (%rbx)
	addq	$16, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1:
	.size	handle_chld, .-handle_chld
	.section	.text.unlikely
.LCOLDE22:
	.text
.LHOTE22:
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	"out of memory copying a string"
	.align 8
.LC24:
	.string	"%s: out of memory copying a string\n"
	.section	.text.unlikely
.LCOLDB25:
	.text
.LHOTB25:
	.p2align 4,,15
	.type	e_strdup, @function
e_strdup:
.LFB13:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	strdup
	testq	%rax, %rax
	je	.L85
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L85:
	.cfi_restore_state
	movl	$.LC23, %esi
	movl	$2, %edi
	call	syslog
	movq	stderr(%rip), %rdi
	movq	argv0(%rip), %rdx
	movl	$.LC24, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE13:
	.size	e_strdup, .-e_strdup
	.section	.text.unlikely
.LCOLDE25:
	.text
.LHOTE25:
	.section	.rodata.str1.1
.LC26:
	.string	"r"
.LC27:
	.string	" \t\n\r"
.LC28:
	.string	"debug"
.LC29:
	.string	"port"
.LC30:
	.string	"dir"
.LC31:
	.string	"chroot"
.LC32:
	.string	"nochroot"
.LC33:
	.string	"data_dir"
.LC34:
	.string	"symlink"
.LC35:
	.string	"nosymlink"
.LC36:
	.string	"symlinks"
.LC37:
	.string	"nosymlinks"
.LC38:
	.string	"user"
.LC39:
	.string	"cgipat"
.LC40:
	.string	"cgilimit"
.LC41:
	.string	"urlpat"
.LC42:
	.string	"noemptyreferers"
.LC43:
	.string	"localpat"
.LC44:
	.string	"throttles"
.LC45:
	.string	"host"
.LC46:
	.string	"logfile"
.LC47:
	.string	"vhost"
.LC48:
	.string	"novhost"
.LC49:
	.string	"globalpasswd"
.LC50:
	.string	"noglobalpasswd"
.LC51:
	.string	"pidfile"
.LC52:
	.string	"charset"
.LC53:
	.string	"p3p"
.LC54:
	.string	"max_age"
	.section	.rodata.str1.8
	.align 8
.LC55:
	.string	"%s: unknown config option '%s'\n"
	.section	.text.unlikely
.LCOLDB56:
	.text
.LHOTB56:
	.p2align 4,,15
	.type	read_config, @function
read_config:
.LFB10:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	$.LC26, %esi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$120, %rsp
	.cfi_def_cfa_offset 160
	call	fopen
	testq	%rax, %rax
	movq	%rax, %r12
	je	.L141
.L87:
	movq	%r12, %rdx
	movl	$1000, %esi
	movq	%rsp, %rdi
	call	fgets
	testq	%rax, %rax
	je	.L142
	movl	$35, %esi
	movq	%rsp, %rdi
	call	strchr
	testq	%rax, %rax
	je	.L88
	movb	$0, (%rax)
.L88:
	movl	$.LC27, %esi
	movq	%rsp, %rdi
	call	strspn
	leaq	(%rsp,%rax), %rbp
	cmpb	$0, 0(%rbp)
	je	.L87
	.p2align 4,,10
	.p2align 3
.L132:
	movl	$.LC27, %esi
	movq	%rbp, %rdi
	call	strcspn
	leaq	0(%rbp,%rax), %rbx
	movzbl	(%rbx), %eax
	cmpb	$13, %al
	sete	%cl
	cmpb	$32, %al
	sete	%dl
	orb	%dl, %cl
	jne	.L134
	subl	$9, %eax
	cmpb	$1, %al
	ja	.L90
	.p2align 4,,10
	.p2align 3
.L134:
	addq	$1, %rbx
	movzbl	(%rbx), %esi
	movb	$0, -1(%rbx)
	cmpb	$13, %sil
	sete	%al
	cmpb	$32, %sil
	sete	%r8b
	orb	%r8b, %al
	jne	.L134
	subl	$9, %esi
	cmpb	$1, %sil
	jbe	.L134
.L90:
	movl	$61, %esi
	movq	%rbp, %rdi
	call	strchr
	testq	%rax, %rax
	je	.L125
	leaq	1(%rax), %r13
	movb	$0, (%rax)
.L93:
	movl	$.LC28, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L143
	movl	$.LC29, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L144
	movl	$.LC30, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L145
	movl	$.LC31, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L146
	movl	$.LC32, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L147
	movl	$.LC33, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L148
	movl	$.LC34, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L139
	movl	$.LC35, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L140
	movl	$.LC36, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L139
	movl	$.LC37, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L140
	movl	$.LC38, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L149
	movl	$.LC39, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L150
	movl	$.LC40, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L151
	movl	$.LC41, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L152
	movl	$.LC42, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L153
	movl	$.LC43, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L154
	movl	$.LC44, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L155
	movl	$.LC45, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L156
	movl	$.LC46, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L157
	movl	$.LC47, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L158
	movl	$.LC48, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L159
	movl	$.LC49, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L160
	movl	$.LC50, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L161
	movl	$.LC51, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L162
	movl	$.LC52, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L163
	movl	$.LC53, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L164
	movl	$.LC54, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	jne	.L121
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	atoi
	movl	%eax, max_age(%rip)
	.p2align 4,,10
	.p2align 3
.L95:
	movl	$.LC27, %esi
	movq	%rbx, %rdi
	call	strspn
	leaq	(%rbx,%rax), %rbp
	cmpb	$0, 0(%rbp)
	jne	.L132
	jmp	.L87
.L143:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$1, debug(%rip)
	jmp	.L95
.L144:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	atoi
	movw	%ax, port(%rip)
	jmp	.L95
.L125:
	xorl	%r13d, %r13d
	jmp	.L93
.L145:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, dir(%rip)
	jmp	.L95
.L146:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$1, do_chroot(%rip)
	movl	$1, no_symlink_check(%rip)
	jmp	.L95
.L147:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$0, do_chroot(%rip)
	movl	$0, no_symlink_check(%rip)
	jmp	.L95
.L139:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$0, no_symlink_check(%rip)
	jmp	.L95
.L148:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, data_dir(%rip)
	jmp	.L95
.L140:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$1, no_symlink_check(%rip)
	jmp	.L95
.L149:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, user(%rip)
	jmp	.L95
.L151:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	atoi
	movl	%eax, cgi_limit(%rip)
	jmp	.L95
.L150:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, cgi_pattern(%rip)
	jmp	.L95
.L142:
	movq	%r12, %rdi
	call	fclose
	addq	$120, %rsp
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
.L153:
	.cfi_restore_state
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$1, no_empty_referers(%rip)
	jmp	.L95
.L152:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, url_pattern(%rip)
	jmp	.L95
.L154:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, local_pattern(%rip)
	jmp	.L95
.L141:
	movq	%rbx, %rdi
	call	perror
	movl	$1, %edi
	call	exit
.L155:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, throttlefile(%rip)
	jmp	.L95
.L157:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, logfile(%rip)
	jmp	.L95
.L156:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, hostname(%rip)
	jmp	.L95
.L121:
	movq	stderr(%rip), %rdi
	movq	argv0(%rip), %rdx
	movq	%rbp, %rcx
	movl	$.LC55, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
.L164:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, p3p(%rip)
	jmp	.L95
.L163:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, charset(%rip)
	jmp	.L95
.L162:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, pidfile(%rip)
	jmp	.L95
.L161:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$0, do_global_passwd(%rip)
	jmp	.L95
.L160:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$1, do_global_passwd(%rip)
	jmp	.L95
.L159:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$0, do_vhost(%rip)
	jmp	.L95
.L158:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$1, do_vhost(%rip)
	jmp	.L95
	.cfi_endproc
.LFE10:
	.size	read_config, .-read_config
	.section	.text.unlikely
.LCOLDE56:
	.text
.LHOTE56:
	.section	.rodata.str1.1
.LC57:
	.string	"nobody"
.LC58:
	.string	"iso-8859-1"
.LC59:
	.string	""
.LC60:
	.string	"-V"
.LC61:
	.string	"thttpd/2.27.0 Oct 3, 2014"
.LC62:
	.string	"-C"
.LC63:
	.string	"-p"
.LC64:
	.string	"-d"
.LC65:
	.string	"-r"
.LC66:
	.string	"-nor"
.LC67:
	.string	"-dd"
.LC68:
	.string	"-s"
.LC69:
	.string	"-nos"
.LC70:
	.string	"-u"
.LC71:
	.string	"-c"
.LC72:
	.string	"-t"
.LC73:
	.string	"-h"
.LC74:
	.string	"-l"
.LC75:
	.string	"-v"
.LC76:
	.string	"-nov"
.LC77:
	.string	"-g"
.LC78:
	.string	"-nog"
.LC79:
	.string	"-i"
.LC80:
	.string	"-T"
.LC81:
	.string	"-P"
.LC82:
	.string	"-M"
.LC83:
	.string	"-D"
	.section	.text.unlikely
.LCOLDB84:
	.text
.LHOTB84:
	.p2align 4,,15
	.type	parse_args, @function
parse_args:
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
	movq	$.LC57, user(%rip)
	movq	$.LC58, charset(%rip)
	movq	$.LC59, p3p(%rip)
	movl	$-1, max_age(%rip)
	jle	.L196
	movq	8(%rsi), %rbx
	movq	%rsi, %r15
	cmpb	$45, (%rbx)
	jne	.L194
	movl	$1, %ebp
	movl	$.LC60, %r13d
	movl	$3, %r12d
	jmp	.L195
	.p2align 4,,10
	.p2align 3
.L211:
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jg	.L209
.L170:
	movl	$.LC65, %edi
	movq	%rbx, %rsi
	movq	%r12, %rcx
	repz; cmpsb
	jne	.L173
	movl	$1, do_chroot(%rip)
	movl	$1, no_symlink_check(%rip)
.L171:
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jle	.L166
.L212:
	movslq	%ebp, %rax
	movq	(%r15,%rax,8), %rbx
	cmpb	$45, (%rbx)
	jne	.L194
.L195:
	movq	%rbx, %rsi
	movq	%r13, %rdi
	movq	%r12, %rcx
	repz; cmpsb
	je	.L210
	movl	$.LC62, %edi
	movq	%rbx, %rsi
	movq	%r12, %rcx
	repz; cmpsb
	je	.L211
	movl	$.LC63, %edi
	movq	%rbx, %rsi
	movq	%r12, %rcx
	repz; cmpsb
	jne	.L172
	leal	1(%rbp), %edx
	cmpl	%edx, %r14d
	jle	.L170
	movslq	%edx, %rax
	movl	%edx, 12(%rsp)
	movq	(%r15,%rax,8), %rdi
	call	atoi
	movl	12(%rsp), %edx
	movw	%ax, port(%rip)
	movl	%edx, %ebp
	addl	$1, %ebp
	cmpl	%ebp, %r14d
	jg	.L212
.L166:
	cmpl	%r14d, %ebp
	jne	.L194
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
.L172:
	.cfi_restore_state
	movl	$.LC64, %edi
	movq	%rbx, %rsi
	movq	%r12, %rcx
	repz; cmpsb
	jne	.L170
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L170
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r15,%rdx,8), %rdx
	movq	%rdx, dir(%rip)
	jmp	.L171
	.p2align 4,,10
	.p2align 3
.L173:
	movl	$.LC66, %edi
	movl	$5, %ecx
	movq	%rbx, %rsi
	repz; cmpsb
	jne	.L174
	movl	$0, do_chroot(%rip)
	movl	$0, no_symlink_check(%rip)
	jmp	.L171
	.p2align 4,,10
	.p2align 3
.L209:
	movslq	%eax, %rdx
	movl	%eax, 12(%rsp)
	movq	(%r15,%rdx,8), %rdi
	call	read_config
	movl	12(%rsp), %eax
	movl	%eax, %ebp
	jmp	.L171
	.p2align 4,,10
	.p2align 3
.L174:
	movl	$.LC67, %edi
	movl	$4, %ecx
	movq	%rbx, %rsi
	repz; cmpsb
	jne	.L175
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L175
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r15,%rdx,8), %rdx
	movq	%rdx, data_dir(%rip)
	jmp	.L171
	.p2align 4,,10
	.p2align 3
.L175:
	movl	$.LC68, %edi
	movq	%rbx, %rsi
	movq	%r12, %rcx
	repz; cmpsb
	jne	.L176
	movl	$0, no_symlink_check(%rip)
	jmp	.L171
	.p2align 4,,10
	.p2align 3
.L176:
	movl	$.LC69, %edi
	movl	$5, %ecx
	movq	%rbx, %rsi
	repz; cmpsb
	je	.L213
	movl	$.LC70, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L178
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jg	.L214
	movl	$.LC72, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L182
.L184:
	movl	$.LC74, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L183
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jg	.L215
.L183:
	movl	$.LC75, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L185
	movl	$1, do_vhost(%rip)
	jmp	.L171
.L213:
	movl	$1, no_symlink_check(%rip)
	jmp	.L171
.L178:
	movl	$.LC71, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L180
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L181
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r15,%rdx,8), %rdx
	movq	%rdx, cgi_pattern(%rip)
	jmp	.L171
.L180:
	movl	$.LC72, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L182
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L183
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r15,%rdx,8), %rdx
	movq	%rdx, throttlefile(%rip)
	jmp	.L171
.L182:
	movl	$.LC73, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L184
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L183
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r15,%rdx,8), %rdx
	movq	%rdx, hostname(%rip)
	jmp	.L171
.L214:
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r15,%rdx,8), %rdx
	movq	%rdx, user(%rip)
	jmp	.L171
.L181:
	movl	$.LC73, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L183
	jmp	.L184
.L185:
	movl	$.LC76, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L216
	movl	$.LC77, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L187
	movl	$1, do_global_passwd(%rip)
	jmp	.L171
.L215:
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r15,%rdx,8), %rdx
	movq	%rdx, logfile(%rip)
	jmp	.L171
.L216:
	movl	$0, do_vhost(%rip)
	jmp	.L171
.L196:
	movl	$1, %ebp
	jmp	.L166
.L187:
	movl	$.LC78, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L188
	movl	$0, do_global_passwd(%rip)
	jmp	.L171
.L210:
	movl	$.LC61, %edi
	call	puts
	xorl	%edi, %edi
	call	exit
.L188:
	movl	$.LC79, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L189
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L190
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r15,%rdx,8), %rdx
	movq	%rdx, pidfile(%rip)
	jmp	.L171
.L189:
	movl	$.LC80, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L191
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L192
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r15,%rdx,8), %rdx
	movq	%rdx, charset(%rip)
	jmp	.L171
.L191:
	movl	$.LC81, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L193
	leal	1(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L192
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r15,%rdx,8), %rdx
	movq	%rdx, p3p(%rip)
	jmp	.L171
.L190:
	movl	$.LC81, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L193
.L192:
	movl	$.LC83, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L194
	movl	$1, debug(%rip)
	jmp	.L171
.L193:
	movl	$.LC82, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L192
	leal	1(%rbp), %edx
	cmpl	%edx, %r14d
	jle	.L192
	movslq	%edx, %rax
	movl	%edx, 12(%rsp)
	movq	(%r15,%rax,8), %rdi
	call	atoi
	movl	12(%rsp), %edx
	movl	%eax, max_age(%rip)
	movl	%edx, %ebp
	jmp	.L171
.L194:
	call	usage
	.cfi_endproc
.LFE8:
	.size	parse_args, .-parse_args
	.section	.text.unlikely
.LCOLDE84:
	.text
.LHOTE84:
	.section	.rodata.str1.1
.LC85:
	.string	"%.80s - %m"
.LC86:
	.string	" %4900[^ \t] %ld-%ld"
.LC87:
	.string	" %4900[^ \t] %ld"
	.section	.rodata.str1.8
	.align 8
.LC88:
	.string	"unparsable line in %.80s - %.80s"
	.align 8
.LC89:
	.string	"%s: unparsable line in %.80s - %.80s\n"
	.section	.rodata.str1.1
.LC90:
	.string	"|/"
	.section	.rodata.str1.8
	.align 8
.LC91:
	.string	"out of memory allocating a throttletab"
	.align 8
.LC92:
	.string	"%s: out of memory allocating a throttletab\n"
	.section	.text.unlikely
.LCOLDB93:
	.text
.LHOTB93:
	.p2align 4,,15
	.type	read_throttlefile, @function
read_throttlefile:
.LFB15:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	$.LC26, %esi
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$10048, %rsp
	.cfi_def_cfa_offset 10096
	call	fopen
	testq	%rax, %rax
	movq	%rax, %rbp
	je	.L260
	leaq	16(%rsp), %rdi
	leaq	32(%rsp), %rbx
	leaq	5041(%rsp), %r13
	xorl	%esi, %esi
	call	gettimeofday
	.p2align 4,,10
	.p2align 3
.L240:
	movq	%rbp, %rdx
	movl	$5000, %esi
	movq	%rbx, %rdi
	call	fgets
	testq	%rax, %rax
	je	.L261
	movl	$35, %esi
	movq	%rbx, %rdi
	call	strchr
	testq	%rax, %rax
	je	.L220
	movb	$0, (%rax)
.L220:
	movq	%rbx, %r9
.L221:
	movl	(%r9), %edx
	addq	$4, %r9
	leal	-16843009(%rdx), %eax
	notl	%edx
	andl	%edx, %eax
	andl	$-2139062144, %eax
	je	.L221
	movl	%eax, %edx
	shrl	$16, %edx
	testl	$32896, %eax
	cmove	%edx, %eax
	leaq	2(%r9), %rdx
	cmove	%rdx, %r9
	addb	%al, %al
	sbbq	$3, %r9
	subq	%rbx, %r9
	cmpl	$0, %r9d
	jg	.L258
	jmp	.L262
	.p2align 4,,10
	.p2align 3
.L249:
	testl	%r9d, %r9d
	movb	$0, 32(%rsp,%rdx)
	je	.L240
.L258:
	subl	$1, %r9d
	movslq	%r9d, %rdx
	movzbl	32(%rsp,%rdx), %eax
	cmpb	$13, %al
	sete	%sil
	cmpb	$32, %al
	sete	%cl
	orb	%cl, %sil
	jne	.L249
	subl	$9, %eax
	cmpb	$1, %al
	jbe	.L249
.L229:
	leaq	8(%rsp), %rcx
	leaq	5040(%rsp), %rdx
	xorl	%eax, %eax
	movq	%rsp, %r8
	movl	$.LC86, %esi
	movq	%rbx, %rdi
	call	__isoc99_sscanf
	cmpl	$3, %eax
	je	.L225
	leaq	5040(%rsp), %rdx
	xorl	%eax, %eax
	movq	%rsp, %rcx
	movl	$.LC87, %esi
	movq	%rbx, %rdi
	call	__isoc99_sscanf
	cmpl	$2, %eax
	jne	.L230
	movq	$0, 8(%rsp)
	.p2align 4,,10
	.p2align 3
.L225:
	cmpb	$47, 5040(%rsp)
	jne	.L233
	jmp	.L263
	.p2align 4,,10
	.p2align 3
.L234:
	leaq	2(%rax), %rsi
	leaq	1(%rax), %rdi
	call	strcpy
.L233:
	leaq	5040(%rsp), %rdi
	movl	$.LC90, %esi
	call	strstr
	testq	%rax, %rax
	jne	.L234
	movslq	numthrottles(%rip), %rdx
	movl	maxthrottles(%rip), %eax
	cmpl	%eax, %edx
	jl	.L235
	testl	%eax, %eax
	jne	.L236
	movl	$4800, %edi
	movl	$100, maxthrottles(%rip)
	call	malloc
	movq	%rax, throttles(%rip)
.L237:
	testq	%rax, %rax
	je	.L238
	movslq	numthrottles(%rip), %rdx
.L239:
	leaq	(%rdx,%rdx,2), %r14
	leaq	5040(%rsp), %rdi
	movq	%r14, %rdx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %r14
	call	e_strdup
	movq	%rax, (%r14)
	movslq	numthrottles(%rip), %rax
	movq	(%rsp), %rcx
	movq	%rax, %rdx
	leaq	(%rax,%rax,2), %rax
	addl	$1, %edx
	salq	$4, %rax
	addq	throttles(%rip), %rax
	movl	%edx, numthrottles(%rip)
	movq	%rcx, 8(%rax)
	movq	8(%rsp), %rcx
	movq	$0, 24(%rax)
	movq	$0, 32(%rax)
	movl	$0, 40(%rax)
	movq	%rcx, 16(%rax)
	jmp	.L240
.L262:
	je	.L240
	jmp	.L229
.L230:
	movq	%rbx, %rcx
	movq	%r12, %rdx
	xorl	%eax, %eax
	movl	$.LC88, %esi
	movl	$2, %edi
	call	syslog
	movq	argv0(%rip), %rdx
	movq	stderr(%rip), %rdi
	movq	%rbx, %r8
	movq	%r12, %rcx
	movl	$.LC89, %esi
	xorl	%eax, %eax
	call	fprintf
	jmp	.L240
.L236:
	addl	%eax, %eax
	movq	throttles(%rip), %rdi
	movl	%eax, maxthrottles(%rip)
	cltq
	leaq	(%rax,%rax,2), %rsi
	salq	$4, %rsi
	call	realloc
	movq	%rax, throttles(%rip)
	jmp	.L237
.L235:
	movq	throttles(%rip), %rax
	jmp	.L239
.L261:
	movq	%rbp, %rdi
	call	fclose
	addq	$10048, %rsp
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
.L263:
	.cfi_restore_state
	leaq	5040(%rsp), %rdi
	movq	%r13, %rsi
	call	strcpy
	jmp	.L233
.L260:
	movq	%r12, %rdx
	movl	$.LC85, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movq	%r12, %rdi
	call	perror
	movl	$1, %edi
	call	exit
.L238:
	movl	$.LC91, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movq	stderr(%rip), %rdi
	movq	argv0(%rip), %rdx
	movl	$.LC92, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE15:
	.size	read_throttlefile, .-read_throttlefile
	.section	.text.unlikely
.LCOLDE93:
	.text
.LHOTE93:
	.section	.rodata.str1.1
.LC94:
	.string	"-"
.LC95:
	.string	"re-opening logfile"
.LC96:
	.string	"a"
.LC97:
	.string	"re-opening %.80s - %m"
	.section	.text.unlikely
.LCOLDB98:
	.text
.LHOTB98:
	.p2align 4,,15
	.type	re_open_logfile, @function
re_open_logfile:
.LFB6:
	.cfi_startproc
	movl	no_log(%rip), %eax
	testl	%eax, %eax
	jne	.L276
	cmpq	$0, hs(%rip)
	je	.L276
	movq	logfile(%rip), %rsi
	testq	%rsi, %rsi
	je	.L276
	movl	$.LC94, %edi
	movl	$2, %ecx
	repz; cmpsb
	jne	.L277
.L276:
	rep; ret
	.p2align 4,,10
	.p2align 3
.L277:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	xorl	%eax, %eax
	movl	$.LC95, %esi
	movl	$5, %edi
	call	syslog
	movq	logfile(%rip), %rdi
	movl	$.LC96, %esi
	call	fopen
	movq	logfile(%rip), %rdi
	movl	$384, %esi
	movq	%rax, %rbx
	call	chmod
	testl	%eax, %eax
	jne	.L268
	testq	%rbx, %rbx
	je	.L268
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
.L268:
	.cfi_restore_state
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	movq	logfile(%rip), %rdx
	movl	$.LC97, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	jmp	syslog
	.cfi_endproc
.LFE6:
	.size	re_open_logfile, .-re_open_logfile
	.section	.text.unlikely
.LCOLDE98:
	.text
.LHOTE98:
	.section	.rodata.str1.1
.LC99:
	.string	"too many connections!"
	.section	.rodata.str1.8
	.align 8
.LC100:
	.string	"the connects free list is messed up"
	.align 8
.LC101:
	.string	"out of memory allocating an httpd_conn"
	.section	.text.unlikely
.LCOLDB102:
	.text
.LHOTB102:
	.p2align 4,,15
	.type	handle_newconnect, @function
handle_newconnect:
.LFB17:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movl	%esi, %ebp
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	movl	num_connects(%rip), %eax
.L287:
	cmpl	%eax, max_connects(%rip)
	jle	.L297
	movslq	first_free_connect(%rip), %rax
	cmpl	$-1, %eax
	je	.L281
	leaq	(%rax,%rax,8), %rbx
	salq	$4, %rbx
	addq	connects(%rip), %rbx
	movl	(%rbx), %eax
	testl	%eax, %eax
	jne	.L281
	movq	8(%rbx), %rdx
	testq	%rdx, %rdx
	je	.L298
.L283:
	movq	hs(%rip), %rdi
	movl	%ebp, %esi
	call	httpd_get_conn
	testl	%eax, %eax
	je	.L286
	cmpl	$2, %eax
	jne	.L299
	movl	$1, %eax
.L280:
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
	.p2align 4,,10
	.p2align 3
.L299:
	.cfi_restore_state
	movl	4(%rbx), %eax
	movl	$1, (%rbx)
	movl	$-1, 4(%rbx)
	addl	$1, num_connects(%rip)
	movl	%eax, first_free_connect(%rip)
	movq	(%r12), %rax
	movq	$0, 96(%rbx)
	movq	$0, 104(%rbx)
	movq	%rax, 88(%rbx)
	movq	8(%rbx), %rax
	movq	$0, 136(%rbx)
	movl	$0, 56(%rbx)
	movl	704(%rax), %edi
	call	httpd_set_ndelay
	movq	8(%rbx), %rax
	xorl	%edx, %edx
	movq	%rbx, %rsi
	movl	704(%rax), %edi
	call	fdwatch_add_fd
	addq	$1, stats_connections(%rip)
	movl	num_connects(%rip), %eax
	cmpl	stats_simultaneous(%rip), %eax
	jle	.L287
	movl	%eax, stats_simultaneous(%rip)
	jmp	.L287
	.p2align 4,,10
	.p2align 3
.L286:
	movq	%r12, %rdi
	movl	%eax, 12(%rsp)
	call	tmr_run
	movl	12(%rsp), %eax
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
	.p2align 4,,10
	.p2align 3
.L298:
	.cfi_restore_state
	movl	$720, %edi
	call	malloc
	testq	%rax, %rax
	movq	%rax, 8(%rbx)
	je	.L300
	movl	$0, (%rax)
	addl	$1, httpd_conn_count(%rip)
	movq	%rax, %rdx
	jmp	.L283
	.p2align 4,,10
	.p2align 3
.L297:
	xorl	%eax, %eax
	movl	$.LC99, %esi
	movl	$4, %edi
	call	syslog
	movq	%r12, %rdi
	call	tmr_run
	xorl	%eax, %eax
	jmp	.L280
.L281:
	movl	$2, %edi
	movl	$.LC100, %esi
	xorl	%eax, %eax
	call	syslog
	movl	$1, %edi
	call	exit
.L300:
	movl	$2, %edi
	movl	$.LC101, %esi
	call	syslog
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE17:
	.size	handle_newconnect, .-handle_newconnect
	.section	.text.unlikely
.LCOLDE102:
	.text
.LHOTE102:
	.section	.rodata.str1.8
	.align 8
.LC103:
	.string	"throttle sending count was negative - shouldn't happen!"
	.section	.text.unlikely
.LCOLDB104:
	.text
.LHOTB104:
	.p2align 4,,15
	.type	check_throttles, @function
check_throttles:
.LFB21:
	.cfi_startproc
	movl	numthrottles(%rip), %eax
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	xorl	%r12d, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movl	$0, 56(%rdi)
	movq	$-1, 72(%rdi)
	testl	%eax, %eax
	movq	$-1, 64(%rdi)
	jg	.L316
	jmp	.L310
	.p2align 4,,10
	.p2align 3
.L322:
	addl	$1, %ecx
	movslq	%ecx, %r8
.L306:
	movslq	56(%rbx), %rdi
	leal	1(%rdi), %r9d
	movl	%r9d, 56(%rbx)
	movl	%r12d, 16(%rbx,%rdi,4)
	movl	%ecx, 40(%rdx)
	cqto
	idivq	%r8
	movq	64(%rbx), %rdx
	cmpq	$-1, %rdx
	je	.L320
	cmpq	%rdx, %rax
	cmovg	%rdx, %rax
.L320:
	movq	%rax, 64(%rbx)
	movq	72(%rbx), %rax
	cmpq	$-1, %rax
	je	.L321
	cmpq	%rax, %rsi
	cmovl	%rax, %rsi
.L321:
	movq	%rsi, 72(%rbx)
.L304:
	addl	$1, %r12d
	cmpl	%r12d, numthrottles(%rip)
	jle	.L310
	addq	$48, %rbp
	cmpl	$9, 56(%rbx)
	jg	.L310
.L316:
	movq	8(%rbx), %rax
	movq	240(%rax), %rsi
	movq	throttles(%rip), %rax
	movq	(%rax,%rbp), %rdi
	call	match
	testl	%eax, %eax
	je	.L304
	movq	%rbp, %rdx
	addq	throttles(%rip), %rdx
	movq	8(%rdx), %rax
	movq	24(%rdx), %rcx
	leaq	(%rax,%rax), %rsi
	cmpq	%rsi, %rcx
	jg	.L313
	movq	16(%rdx), %rsi
	cmpq	%rsi, %rcx
	jl	.L313
	movl	40(%rdx), %ecx
	testl	%ecx, %ecx
	jns	.L322
	movl	$.LC103, %esi
	xorl	%eax, %eax
	movl	$3, %edi
	call	syslog
	movq	%rbp, %rdx
	addq	throttles(%rip), %rdx
	movl	$1, %r8d
	movl	$1, %ecx
	movl	$0, 40(%rdx)
	movq	8(%rdx), %rax
	movq	16(%rdx), %rsi
	jmp	.L306
	.p2align 4,,10
	.p2align 3
.L310:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	$1, %eax
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L313:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE21:
	.size	check_throttles, .-check_throttles
	.section	.text.unlikely
.LCOLDE104:
	.text
.LHOTE104:
	.section	.text.unlikely
.LCOLDB105:
	.text
.LHOTB105:
	.p2align 4,,15
	.type	shut_down, @function
shut_down:
.LFB16:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%esi, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%ebp, %ebp
	xorl	%ebx, %ebx
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	movq	%rsp, %rdi
	call	gettimeofday
	movq	%rsp, %rdi
	call	logstats
	movl	max_connects(%rip), %ecx
	testl	%ecx, %ecx
	jg	.L342
	jmp	.L329
	.p2align 4,,10
	.p2align 3
.L327:
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L328
	call	httpd_destroy_conn
	movq	%rbx, %r12
	addq	connects(%rip), %r12
	movq	8(%r12), %rdi
	call	free
	subl	$1, httpd_conn_count(%rip)
	movq	$0, 8(%r12)
.L328:
	addl	$1, %ebp
	addq	$144, %rbx
	cmpl	%ebp, max_connects(%rip)
	jle	.L329
.L342:
	movq	%rbx, %rax
	addq	connects(%rip), %rax
	movl	(%rax), %edx
	testl	%edx, %edx
	je	.L327
	movq	8(%rax), %rdi
	movq	%rsp, %rsi
	call	httpd_close_conn
	movq	%rbx, %rax
	addq	connects(%rip), %rax
	jmp	.L327
	.p2align 4,,10
	.p2align 3
.L329:
	movq	hs(%rip), %rbx
	testq	%rbx, %rbx
	je	.L326
	movl	72(%rbx), %edi
	movq	$0, hs(%rip)
	cmpl	$-1, %edi
	je	.L330
	call	fdwatch_del_fd
.L330:
	movl	76(%rbx), %edi
	cmpl	$-1, %edi
	je	.L331
	call	fdwatch_del_fd
.L331:
	movq	%rbx, %rdi
	call	httpd_terminate
.L326:
	call	mmc_destroy
	call	tmr_destroy
	movq	connects(%rip), %rdi
	call	free
	movq	throttles(%rip), %rdi
	testq	%rdi, %rdi
	je	.L323
	call	free
.L323:
	addq	$16, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE16:
	.size	shut_down, .-shut_down
	.section	.text.unlikely
.LCOLDE105:
	.text
.LHOTE105:
	.section	.rodata.str1.1
.LC106:
	.string	"exiting"
	.section	.text.unlikely
.LCOLDB107:
	.text
.LHOTB107:
	.p2align 4,,15
	.type	handle_usr1, @function
handle_usr1:
.LFB3:
	.cfi_startproc
	movl	num_connects(%rip), %edx
	testl	%edx, %edx
	je	.L352
	movl	$1, got_usr1(%rip)
	ret
.L352:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	shut_down
	movl	$5, %edi
	movl	$.LC106, %esi
	xorl	%eax, %eax
	call	syslog
	call	closelog
	xorl	%edi, %edi
	call	exit
	.cfi_endproc
.LFE3:
	.size	handle_usr1, .-handle_usr1
	.section	.text.unlikely
.LCOLDE107:
	.text
.LHOTE107:
	.section	.rodata.str1.1
.LC108:
	.string	"exiting due to signal %d"
	.section	.text.unlikely
.LCOLDB109:
	.text
.LHOTB109:
	.p2align 4,,15
	.type	handle_term, @function
handle_term:
.LFB0:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	%edi, %ebx
	call	shut_down
	movl	$5, %edi
	movl	%ebx, %edx
	movl	$.LC108, %esi
	xorl	%eax, %eax
	call	syslog
	call	closelog
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE0:
	.size	handle_term, .-handle_term
	.section	.text.unlikely
.LCOLDE109:
	.text
.LHOTE109:
	.section	.text.unlikely
.LCOLDB110:
	.text
.LHOTB110:
	.p2align 4,,15
	.type	clear_throttles.isra.0, @function
clear_throttles.isra.0:
.LFB34:
	.cfi_startproc
	movl	56(%rdi), %eax
	testl	%eax, %eax
	jle	.L355
	subl	$1, %eax
	movq	throttles(%rip), %rcx
	leaq	16(%rdi), %rdx
	leaq	20(%rdi,%rax,4), %rsi
	.p2align 4,,10
	.p2align 3
.L357:
	movslq	(%rdx), %rax
	addq	$4, %rdx
	leaq	(%rax,%rax,2), %rax
	salq	$4, %rax
	subl	$1, 40(%rcx,%rax)
	cmpq	%rsi, %rdx
	jne	.L357
.L355:
	rep; ret
	.cfi_endproc
.LFE34:
	.size	clear_throttles.isra.0, .-clear_throttles.isra.0
	.section	.text.unlikely
.LCOLDE110:
	.text
.LHOTE110:
	.section	.text.unlikely
.LCOLDB111:
	.text
.LHOTB111:
	.p2align 4,,15
	.type	really_clear_connection, @function
really_clear_connection:
.LFB26:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rdi
	movq	200(%rdi), %rax
	addq	%rax, stats_bytes(%rip)
	cmpl	$3, (%rbx)
	je	.L361
	movl	704(%rdi), %edi
	movq	%rsi, 8(%rsp)
	call	fdwatch_del_fd
	movq	8(%rbx), %rdi
	movq	8(%rsp), %rsi
.L361:
	call	httpd_close_conn
	movq	%rbx, %rdi
	call	clear_throttles.isra.0
	movq	104(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L362
	call	tmr_cancel
	movq	$0, 104(%rbx)
.L362:
	movl	first_free_connect(%rip), %eax
	movl	$0, (%rbx)
	subl	$1, num_connects(%rip)
	movl	%eax, 4(%rbx)
	subq	connects(%rip), %rbx
	movabsq	$-8198552921648689607, %rax
	sarq	$4, %rbx
	imulq	%rax, %rbx
	movl	%ebx, first_free_connect(%rip)
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE26:
	.size	really_clear_connection, .-really_clear_connection
	.section	.text.unlikely
.LCOLDE111:
	.text
.LHOTE111:
	.section	.rodata.str1.8
	.align 8
.LC112:
	.string	"replacing non-null linger_timer!"
	.align 8
.LC113:
	.string	"tmr_create(linger_clear_connection) failed"
	.section	.text.unlikely
.LCOLDB114:
	.text
.LHOTB114:
	.p2align 4,,15
	.type	clear_connection, @function
clear_connection:
.LFB25:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	96(%rdi), %rdi
	testq	%rdi, %rdi
	je	.L368
	call	tmr_cancel
	movq	$0, 96(%rbx)
.L368:
	cmpl	$4, (%rbx)
	je	.L369
	movq	8(%rbx), %rax
	movl	556(%rax), %edx
	testl	%edx, %edx
	je	.L371
	cmpl	$3, (%rbx)
	je	.L372
	movl	704(%rax), %edi
	call	fdwatch_del_fd
	movq	8(%rbx), %rax
.L372:
	movl	704(%rax), %edi
	movl	$1, %esi
	movl	$4, (%rbx)
	call	shutdown
	movq	8(%rbx), %rax
	xorl	%edx, %edx
	movq	%rbx, %rsi
	movl	704(%rax), %edi
	call	fdwatch_add_fd
	cmpq	$0, 104(%rbx)
	je	.L373
	movl	$.LC112, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L373:
	xorl	%r8d, %r8d
	movl	$500, %ecx
	movq	%rbx, %rdx
	movl	$linger_clear_connection, %esi
	movq	%rbp, %rdi
	call	tmr_create
	testq	%rax, %rax
	movq	%rax, 104(%rbx)
	je	.L379
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L369:
	.cfi_restore_state
	movq	104(%rbx), %rdi
	call	tmr_cancel
	movq	8(%rbx), %rax
	movq	$0, 104(%rbx)
	movl	$0, 556(%rax)
.L371:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	really_clear_connection
.L379:
	.cfi_restore_state
	movl	$2, %edi
	movl	$.LC113, %esi
	call	syslog
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE25:
	.size	clear_connection, .-clear_connection
	.section	.text.unlikely
.LCOLDE114:
	.text
.LHOTE114:
	.section	.text.unlikely
.LCOLDB115:
	.text
.LHOTB115:
	.p2align 4,,15
	.type	finish_connection, @function
finish_connection:
.LFB24:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rdi
	call	httpd_write_response
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	clear_connection
	.cfi_endproc
.LFE24:
	.size	finish_connection, .-finish_connection
	.section	.text.unlikely
.LCOLDE115:
	.text
.LHOTE115:
	.section	.text.unlikely
.LCOLDB116:
	.text
.LHOTB116:
	.p2align 4,,15
	.type	handle_read, @function
handle_read:
.LFB18:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	8(%rdi), %rbx
	movq	%rdi, %rbp
	movq	160(%rbx), %rsi
	movq	152(%rbx), %rdx
	cmpq	%rdx, %rsi
	jb	.L383
	cmpq	$5000, %rdx
	jbe	.L410
.L409:
	movq	httpd_err400form(%rip), %r8
	movq	httpd_err400title(%rip), %rdx
	movl	$.LC59, %r9d
	movq	%r9, %rcx
	movl	$400, %esi
	movq	%rbx, %rdi
	call	httpd_send_err
.L408:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%r12, %rsi
	movq	%rbp, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	finish_connection
	.p2align 4,,10
	.p2align 3
.L410:
	.cfi_restore_state
	leaq	152(%rbx), %rsi
	leaq	144(%rbx), %rdi
	addq	$1000, %rdx
	call	httpd_realloc_str
	movq	152(%rbx), %rdx
	movq	160(%rbx), %rsi
.L383:
	subq	%rsi, %rdx
	addq	144(%rbx), %rsi
	movl	704(%rbx), %edi
	call	read
	testl	%eax, %eax
	je	.L409
	js	.L411
	cltq
	addq	%rax, 160(%rbx)
	movq	(%r12), %rax
	movq	%rbx, %rdi
	movq	%rax, 88(%rbp)
	call	httpd_got_request
	testl	%eax, %eax
	je	.L382
	cmpl	$2, %eax
	je	.L409
	movq	%rbx, %rdi
	call	httpd_parse_request
	testl	%eax, %eax
	js	.L408
	movq	%rbp, %rdi
	call	check_throttles
	testl	%eax, %eax
	je	.L412
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	httpd_start_request
	testl	%eax, %eax
	js	.L408
	movl	528(%rbx), %eax
	testl	%eax, %eax
	je	.L393
	movq	536(%rbx), %rax
	movq	%rax, 136(%rbp)
	movq	544(%rbx), %rax
	addq	$1, %rax
	movq	%rax, 128(%rbp)
.L394:
	cmpq	$0, 712(%rbx)
	je	.L413
	movq	128(%rbp), %rax
	cmpq	%rax, 136(%rbp)
	jge	.L408
	movq	(%r12), %rax
	movl	704(%rbx), %edi
	movl	$2, 0(%rbp)
	movq	$0, 112(%rbp)
	movq	%rax, 80(%rbp)
	call	fdwatch_del_fd
	movl	704(%rbx), %edi
	movq	%rbp, %rsi
	movl	$1, %edx
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fdwatch_add_fd
	.p2align 4,,10
	.p2align 3
.L411:
	.cfi_restore_state
	call	__errno_location
	movl	(%rax), %eax
	cmpl	$11, %eax
	je	.L382
	cmpl	$4, %eax
	jne	.L409
.L382:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L412:
	.cfi_restore_state
	movq	208(%rbx), %r9
	movq	httpd_err503form(%rip), %r8
	movl	$.LC59, %ecx
	movq	httpd_err503title(%rip), %rdx
	movl	$503, %esi
	movq	%rbx, %rdi
	call	httpd_send_err
	jmp	.L408
	.p2align 4,,10
	.p2align 3
.L393:
	movq	192(%rbx), %rax
	movl	$0, %edx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	movq	%rax, 128(%rbp)
	jmp	.L394
.L413:
	movl	56(%rbp), %eax
	testl	%eax, %eax
	jle	.L414
	subl	$1, %eax
	movq	throttles(%rip), %rcx
	movq	200(%rbx), %rsi
	leaq	16(%rbp), %rdx
	leaq	20(%rbp,%rax,4), %rdi
	.p2align 4,,10
	.p2align 3
.L399:
	movslq	(%rdx), %rax
	addq	$4, %rdx
	leaq	(%rax,%rax,2), %rax
	salq	$4, %rax
	addq	%rsi, 32(%rcx,%rax)
	cmpq	%rdi, %rdx
	jne	.L399
.L398:
	movq	%rsi, 136(%rbp)
	jmp	.L408
.L414:
	movq	200(%rbx), %rsi
	jmp	.L398
	.cfi_endproc
.LFE18:
	.size	handle_read, .-handle_read
	.section	.text.unlikely
.LCOLDE116:
	.text
.LHOTE116:
	.section	.rodata.str1.8
	.align 8
.LC117:
	.string	"%.80s connection timed out reading"
	.align 8
.LC118:
	.string	"%.80s connection timed out sending"
	.section	.text.unlikely
.LCOLDB119:
	.text
.LHOTB119:
	.p2align 4,,15
	.type	idle, @function
idle:
.LFB27:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	xorl	%r12d, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	xorl	%ebp, %ebp
	movq	%rsi, %r13
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movl	max_connects(%rip), %eax
	testl	%eax, %eax
	jg	.L422
	jmp	.L415
	.p2align 4,,10
	.p2align 3
.L427:
	jl	.L417
	cmpl	$3, %eax
	jg	.L417
	movq	0(%r13), %rax
	subq	88(%rbx), %rax
	cmpq	$299, %rax
	jg	.L426
.L417:
	addl	$1, %r12d
	addq	$144, %rbp
	cmpl	%r12d, max_connects(%rip)
	jle	.L415
.L422:
	movq	%rbp, %rbx
	addq	connects(%rip), %rbx
	movl	(%rbx), %eax
	cmpl	$1, %eax
	jne	.L427
	movq	0(%r13), %rax
	subq	88(%rbx), %rax
	cmpq	$59, %rax
	jle	.L417
	movq	8(%rbx), %rax
	leaq	16(%rax), %rdi
	call	httpd_ntoa
	movl	$.LC117, %esi
	movq	%rax, %rdx
	movl	$6, %edi
	xorl	%eax, %eax
	call	syslog
	movq	8(%rbx), %rdi
	movq	httpd_err408form(%rip), %r8
	movl	$.LC59, %r9d
	movq	httpd_err408title(%rip), %rdx
	movq	%r9, %rcx
	movl	$408, %esi
	call	httpd_send_err
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	finish_connection
	jmp	.L417
	.p2align 4,,10
	.p2align 3
.L415:
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
.L426:
	.cfi_restore_state
	movq	8(%rbx), %rax
	leaq	16(%rax), %rdi
	call	httpd_ntoa
	movl	$.LC118, %esi
	movq	%rax, %rdx
	movl	$6, %edi
	xorl	%eax, %eax
	call	syslog
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	clear_connection
	jmp	.L417
	.cfi_endproc
.LFE27:
	.size	idle, .-idle
	.section	.text.unlikely
.LCOLDE119:
	.text
.LHOTE119:
	.section	.rodata.str1.8
	.align 8
.LC120:
	.string	"replacing non-null wakeup_timer!"
	.align 8
.LC121:
	.string	"tmr_create(wakeup_connection) failed"
	.section	.rodata.str1.1
.LC122:
	.string	"write - %m sending %.80s"
	.section	.text.unlikely
.LCOLDB123:
	.text
.LHOTB123:
	.p2align 4,,15
	.type	handle_send, @function
handle_send:
.LFB19:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	$1000000000, %edx
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbp
	movq	%rdi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
	movq	64(%rdi), %rcx
	movq	8(%rdi), %r12
	cmpq	$-1, %rcx
	je	.L429
	leaq	3(%rcx), %rax
	testq	%rcx, %rcx
	movq	%rcx, %rdx
	cmovs	%rax, %rdx
	sarq	$2, %rdx
.L429:
	movq	472(%r12), %rax
	testq	%rax, %rax
	jne	.L430
	movq	136(%rbx), %rsi
	movq	128(%rbx), %rax
	movl	704(%r12), %edi
	subq	%rsi, %rax
	cmpq	%rax, %rdx
	cmova	%rax, %rdx
	addq	712(%r12), %rsi
	call	write
	testl	%eax, %eax
	js	.L485
.L432:
	je	.L435
	movq	0(%rbp), %rdx
	movq	%rdx, 88(%rbx)
	movq	472(%r12), %rdx
	testq	%rdx, %rdx
	je	.L483
	movslq	%eax, %rcx
	cmpq	%rcx, %rdx
	ja	.L486
	subl	%edx, %eax
	movq	$0, 472(%r12)
.L483:
	movslq	%eax, %rsi
.L442:
	movq	8(%rbx), %rcx
	movq	%rsi, %rdx
	movq	%rsi, %rax
	addq	136(%rbx), %rdx
	addq	200(%rcx), %rax
	movq	%rdx, 136(%rbx)
	movq	%rax, 200(%rcx)
	movl	56(%rbx), %ecx
	testl	%ecx, %ecx
	jle	.L448
	subl	$1, %ecx
	movq	throttles(%rip), %rdi
	leaq	16(%rbx), %r8
	leaq	20(%rbx,%rcx,4), %r9
	.p2align 4,,10
	.p2align 3
.L447:
	movslq	(%r8), %rcx
	addq	$4, %r8
	leaq	(%rcx,%rcx,2), %rcx
	salq	$4, %rcx
	addq	%rsi, 32(%rdi,%rcx)
	cmpq	%r9, %r8
	jne	.L447
.L448:
	cmpq	128(%rbx), %rdx
	jge	.L487
	movq	112(%rbx), %rdx
	cmpq	$100, %rdx
	jg	.L488
.L449:
	movq	64(%rbx), %rcx
	cmpq	$-1, %rcx
	je	.L428
	movq	0(%rbp), %r13
	subq	80(%rbx), %r13
	movl	$1, %edx
	cmove	%rdx, %r13
	cqto
	idivq	%r13
	cmpq	%rax, %rcx
	jge	.L428
	movl	704(%r12), %edi
	movl	$3, (%rbx)
	call	fdwatch_del_fd
	movq	8(%rbx), %rax
	movq	200(%rax), %rax
	cqto
	idivq	64(%rbx)
	movl	%eax, %r12d
	subl	%r13d, %r12d
	cmpq	$0, 96(%rbx)
	je	.L452
	movl	$.LC120, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L452:
	testl	%r12d, %r12d
	movl	$500, %ecx
	jle	.L482
	movslq	%r12d, %r12
	imulq	$1000, %r12, %rcx
	jmp	.L482
	.p2align 4,,10
	.p2align 3
.L430:
	movq	%rax, 8(%rsp)
	movq	128(%rbx), %rdi
	movq	%rsp, %rsi
	movq	136(%rbx), %rax
	movq	368(%r12), %rcx
	subq	%rax, %rdi
	movq	%rcx, (%rsp)
	movq	%rax, %rcx
	addq	712(%r12), %rcx
	cmpq	%rdi, %rdx
	cmova	%rdi, %rdx
	movl	704(%r12), %edi
	movq	%rdx, 24(%rsp)
	movl	$2, %edx
	movq	%rcx, 16(%rsp)
	call	writev
	testl	%eax, %eax
	jns	.L432
.L485:
	call	__errno_location
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L428
	cmpl	$11, %eax
	je	.L435
	cmpl	$22, %eax
	setne	%cl
	cmpl	$32, %eax
	setne	%dl
	testb	%dl, %cl
	je	.L439
	cmpl	$104, %eax
	je	.L439
	movq	208(%r12), %rdx
	movl	$.LC122, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L439:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	clear_connection
	addq	$40, %rsp
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
.L435:
	.cfi_restore_state
	addq	$100, 112(%rbx)
	movl	704(%r12), %edi
	movl	$3, (%rbx)
	call	fdwatch_del_fd
	cmpq	$0, 96(%rbx)
	je	.L438
	movl	$.LC120, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L438:
	movq	112(%rbx), %rcx
.L482:
	xorl	%r8d, %r8d
	movq	%rbx, %rdx
	movl	$wakeup_connection, %esi
	movq	%rbp, %rdi
	call	tmr_create
	testq	%rax, %rax
	movq	%rax, 96(%rbx)
	je	.L489
.L428:
	addq	$40, %rsp
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
.L488:
	.cfi_restore_state
	subq	$100, %rdx
	movq	%rdx, 112(%rbx)
	jmp	.L449
	.p2align 4,,10
	.p2align 3
.L486:
	movq	368(%r12), %rdi
	subl	%eax, %edx
	movslq	%edx, %r13
	movq	%r13, %rdx
	leaq	(%rdi,%rcx), %rsi
	call	memmove
	movq	%r13, 472(%r12)
	xorl	%esi, %esi
	jmp	.L442
	.p2align 4,,10
	.p2align 3
.L487:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	finish_connection
	addq	$40, %rsp
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
.L489:
	.cfi_restore_state
	movl	$2, %edi
	movl	$.LC121, %esi
	xorl	%eax, %eax
	call	syslog
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE19:
	.size	handle_send, .-handle_send
	.section	.text.unlikely
.LCOLDE123:
	.text
.LHOTE123:
	.section	.text.unlikely
.LCOLDB124:
	.text
.LHOTB124:
	.p2align 4,,15
	.type	linger_clear_connection, @function
linger_clear_connection:
.LFB29:
	.cfi_startproc
	movq	$0, 104(%rdi)
	jmp	really_clear_connection
	.cfi_endproc
.LFE29:
	.size	linger_clear_connection, .-linger_clear_connection
	.section	.text.unlikely
.LCOLDE124:
	.text
.LHOTE124:
	.section	.text.unlikely
.LCOLDB125:
	.text
.LHOTB125:
	.p2align 4,,15
	.type	handle_linger, @function
handle_linger:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	movl	$4096, %edx
	subq	$4104, %rsp
	.cfi_def_cfa_offset 4128
	movq	8(%rdi), %rax
	movq	%rsp, %rsi
	movl	704(%rax), %edi
	call	read
	testl	%eax, %eax
	js	.L498
	je	.L494
.L491:
	addq	$4104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L498:
	.cfi_restore_state
	call	__errno_location
	movl	(%rax), %eax
	cmpl	$11, %eax
	je	.L491
	cmpl	$4, %eax
	je	.L491
.L494:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	really_clear_connection
	addq	$4104, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE20:
	.size	handle_linger, .-handle_linger
	.section	.text.unlikely
.LCOLDE125:
	.text
.LHOTE125:
	.section	.rodata.str1.1
.LC126:
	.string	"%d"
.LC127:
	.string	"getaddrinfo %.80s - %.80s"
.LC128:
	.string	"%s: getaddrinfo %s - %s\n"
	.section	.rodata.str1.8
	.align 8
.LC129:
	.string	"%.80s - sockaddr too small (%lu < %lu)"
	.section	.text.unlikely
.LCOLDB130:
	.text
.LHOTB130:
	.p2align 4,,15
	.type	lookup_hostname.constprop.1, @function
lookup_hostname.constprop.1:
.LFB35:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	xorl	%eax, %eax
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %r13
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rcx, %r12
	movl	$6, %ecx
	movq	%rsi, %rbp
	movq	%rdx, %r14
	movl	$10, %esi
	subq	$80, %rsp
	.cfi_def_cfa_offset 128
	movl	$.LC126, %edx
	leaq	32(%rsp), %rbx
	movq	%rbx, %rdi
	rep; stosq
	movzwl	port(%rip), %ecx
	leaq	16(%rsp), %rdi
	movl	$1, 32(%rsp)
	movl	$1, 40(%rsp)
	call	snprintf
	movq	hostname(%rip), %rdi
	leaq	8(%rsp), %rcx
	leaq	16(%rsp), %rsi
	movq	%rbx, %rdx
	call	getaddrinfo
	testl	%eax, %eax
	movl	%eax, %ebx
	jne	.L518
	movq	8(%rsp), %rax
	testq	%rax, %rax
	je	.L501
	xorl	%ebx, %ebx
	xorl	%r9d, %r9d
	jmp	.L505
	.p2align 4,,10
	.p2align 3
.L520:
	cmpl	$10, %r8d
	jne	.L502
	testq	%r9, %r9
	cmove	%rax, %r9
.L502:
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L519
.L505:
	movl	4(%rax), %r8d
	cmpl	$2, %r8d
	jne	.L520
	testq	%rbx, %rbx
	cmove	%rax, %rbx
	movq	40(%rax), %rax
	testq	%rax, %rax
	jne	.L505
.L519:
	testq	%r9, %r9
	je	.L521
	movl	16(%r9), %r8d
	cmpq	$128, %r8
	ja	.L517
	leaq	8(%r14), %rdi
	movq	%r14, %rcx
	movq	$0, (%r14)
	movq	$0, 120(%r14)
	andq	$-8, %rdi
	subq	%rdi, %rcx
	subl	$-128, %ecx
	shrl	$3, %ecx
	rep; stosq
	movq	%r14, %rdi
	movl	16(%r9), %edx
	movq	24(%r9), %rsi
	call	memmove
	movl	$1, (%r12)
.L507:
	testq	%rbx, %rbx
	je	.L522
	movl	16(%rbx), %r8d
	cmpq	$128, %r8
	ja	.L517
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
	movq	%r13, %rdi
	movl	16(%rbx), %edx
	movq	24(%rbx), %rsi
	call	memmove
	movl	$1, 0(%rbp)
.L510:
	movq	8(%rsp), %rdi
	call	freeaddrinfo
	addq	$80, %rsp
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
.L521:
	.cfi_restore_state
	movq	%rbx, %rax
.L501:
	movl	$0, (%r12)
	movq	%rax, %rbx
	jmp	.L507
.L522:
	movl	$0, 0(%rbp)
	jmp	.L510
.L517:
	movq	hostname(%rip), %rdx
	movl	$2, %edi
	movl	$128, %ecx
	movl	$.LC129, %esi
	xorl	%eax, %eax
	call	syslog
	movl	$1, %edi
	call	exit
.L518:
	movl	%eax, %edi
	call	gai_strerror
	movq	hostname(%rip), %rdx
	movq	%rax, %rcx
	movl	$.LC127, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movl	%ebx, %edi
	call	gai_strerror
	movq	stderr(%rip), %rdi
	movq	hostname(%rip), %rcx
	movq	%rax, %r8
	movq	argv0(%rip), %rdx
	movl	$.LC128, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE35:
	.size	lookup_hostname.constprop.1, .-lookup_hostname.constprop.1
	.section	.text.unlikely
.LCOLDE130:
	.text
.LHOTE130:
	.section	.rodata.str1.1
.LC131:
	.string	"can't find any valid address"
	.section	.rodata.str1.8
	.align 8
.LC132:
	.string	"%s: can't find any valid address\n"
	.section	.rodata.str1.1
.LC133:
	.string	"unknown user - '%.80s'"
.LC134:
	.string	"%s: unknown user - '%s'\n"
.LC135:
	.string	"/dev/null"
	.section	.rodata.str1.8
	.align 8
.LC136:
	.string	"logfile is not an absolute path, you may not be able to re-open it"
	.align 8
.LC137:
	.string	"%s: logfile is not an absolute path, you may not be able to re-open it\n"
	.section	.rodata.str1.1
.LC138:
	.string	"fchown logfile - %m"
.LC139:
	.string	"fchown logfile"
.LC140:
	.string	"chdir - %m"
.LC141:
	.string	"chdir"
.LC142:
	.string	"daemon - %m"
.LC143:
	.string	"w"
.LC144:
	.string	"%d\n"
	.section	.rodata.str1.8
	.align 8
.LC145:
	.string	"fdwatch initialization failure"
	.section	.rodata.str1.1
.LC146:
	.string	"chroot - %m"
	.section	.rodata.str1.8
	.align 8
.LC147:
	.string	"logfile is not within the chroot tree, you will not be able to re-open it"
	.align 8
.LC148:
	.string	"%s: logfile is not within the chroot tree, you will not be able to re-open it\n"
	.section	.rodata.str1.1
.LC149:
	.string	"chroot chdir - %m"
.LC150:
	.string	"chroot chdir"
.LC151:
	.string	"data_dir chdir - %m"
.LC152:
	.string	"data_dir chdir"
.LC153:
	.string	"tmr_create(occasional) failed"
.LC154:
	.string	"tmr_create(idle) failed"
	.section	.rodata.str1.8
	.align 8
.LC155:
	.string	"tmr_create(update_throttles) failed"
	.section	.rodata.str1.1
.LC156:
	.string	"tmr_create(show_stats) failed"
.LC157:
	.string	"setgroups - %m"
.LC158:
	.string	"setgid - %m"
.LC159:
	.string	"initgroups - %m"
.LC160:
	.string	"setuid - %m"
	.section	.rodata.str1.8
	.align 8
.LC161:
	.string	"started as root without requesting chroot(), warning only"
	.align 8
.LC162:
	.string	"out of memory allocating a connecttab"
	.section	.rodata.str1.1
.LC163:
	.string	"fdwatch - %m"
	.section	.text.unlikely
.LCOLDB164:
	.section	.text.startup,"ax",@progbits
.LHOTB164:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB7:
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
	movl	%edi, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbp
	subq	$4424, %rsp
	.cfi_def_cfa_offset 4480
	movq	(%rsi), %rbx
	movl	$47, %esi
	movq	%rbx, %rdi
	movq	%rbx, argv0(%rip)
	call	strrchr
	leaq	1(%rax), %rdx
	testq	%rax, %rax
	movl	$9, %esi
	cmovne	%rdx, %rbx
	movl	$24, %edx
	movq	%rbx, %rdi
	call	openlog
	movq	%rbp, %rsi
	movl	%r12d, %edi
	leaq	176(%rsp), %rbp
	leaq	48(%rsp), %r12
	call	parse_args
	call	tzset
	leaq	28(%rsp), %rcx
	leaq	24(%rsp), %rsi
	movq	%rbp, %rdx
	movq	%r12, %rdi
	call	lookup_hostname.constprop.1
	movl	24(%rsp), %ecx
	testl	%ecx, %ecx
	jne	.L525
	cmpl	$0, 28(%rsp)
	je	.L660
.L525:
	movq	throttlefile(%rip), %rdi
	movl	$0, numthrottles(%rip)
	movl	$0, maxthrottles(%rip)
	movq	$0, throttles(%rip)
	testq	%rdi, %rdi
	je	.L526
	call	read_throttlefile
.L526:
	call	getuid
	testl	%eax, %eax
	movl	$32767, %r15d
	movl	$32767, 4(%rsp)
	je	.L661
.L527:
	movq	logfile(%rip), %rbx
	testq	%rbx, %rbx
	je	.L597
	movl	$.LC135, %edi
	movl	$10, %ecx
	movq	%rbx, %rsi
	repz; cmpsb
	je	.L662
	movl	$.LC94, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L531
	movq	stdout(%rip), %r14
.L529:
	movq	dir(%rip), %rdi
	testq	%rdi, %rdi
	je	.L535
	call	chdir
	testl	%eax, %eax
	js	.L663
.L535:
	leaq	304(%rsp), %rbx
	movl	$4096, %esi
	movq	%rbx, %rdi
	call	getcwd
	movq	%rbx, %rdx
.L536:
	movl	(%rdx), %ecx
	addq	$4, %rdx
	leal	-16843009(%rcx), %eax
	notl	%ecx
	andl	%ecx, %eax
	andl	$-2139062144, %eax
	je	.L536
	movl	%eax, %ecx
	shrl	$16, %ecx
	testl	$32896, %eax
	cmove	%ecx, %eax
	leaq	2(%rdx), %rcx
	cmove	%rcx, %rdx
	addb	%al, %al
	sbbq	$3, %rdx
	subq	%rbx, %rdx
	cmpb	$47, 303(%rsp,%rdx)
	je	.L538
	movw	$47, (%rbx,%rdx)
.L538:
	movl	debug(%rip), %edx
	testl	%edx, %edx
	jne	.L539
	movq	stdin(%rip), %rdi
	call	fclose
	movq	stdout(%rip), %rdi
	cmpq	%rdi, %r14
	je	.L540
	call	fclose
.L540:
	movq	stderr(%rip), %rdi
	call	fclose
	movl	$1, %esi
	movl	$1, %edi
	call	daemon
	testl	%eax, %eax
	movl	$.LC142, %esi
	js	.L658
.L541:
	movq	pidfile(%rip), %rdi
	testq	%rdi, %rdi
	je	.L542
	movl	$.LC143, %esi
	call	fopen
	testq	%rax, %rax
	movq	%rax, %r13
	je	.L664
	call	getpid
	movq	%r13, %rdi
	movl	%eax, %edx
	movl	$.LC144, %esi
	xorl	%eax, %eax
	call	fprintf
	movq	%r13, %rdi
	call	fclose
.L542:
	call	fdwatch_get_nfiles
	testl	%eax, %eax
	movl	%eax, max_connects(%rip)
	js	.L665
	subl	$10, %eax
	cmpl	$0, do_chroot(%rip)
	movl	%eax, max_connects(%rip)
	jne	.L666
.L545:
	movq	data_dir(%rip), %rdi
	testq	%rdi, %rdi
	je	.L549
	call	chdir
	testl	%eax, %eax
	js	.L667
.L549:
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
	cmpl	$0, 28(%rsp)
	movl	no_empty_referers(%rip), %eax
	movq	%rbp, %rdx
	movzwl	port(%rip), %ecx
	movl	cgi_limit(%rip), %r9d
	movq	cgi_pattern(%rip), %r8
	movq	hostname(%rip), %rdi
	cmove	%rsi, %rdx
	cmpl	$0, 24(%rsp)
	pushq	%rax
	.cfi_def_cfa_offset 4488
	movl	do_global_passwd(%rip), %eax
	pushq	local_pattern(%rip)
	.cfi_def_cfa_offset 4496
	pushq	url_pattern(%rip)
	.cfi_def_cfa_offset 4504
	pushq	%rax
	.cfi_def_cfa_offset 4512
	movl	do_vhost(%rip), %eax
	cmovne	%r12, %rsi
	pushq	%rax
	.cfi_def_cfa_offset 4520
	movl	no_symlink_check(%rip), %eax
	pushq	%rax
	.cfi_def_cfa_offset 4528
	movl	no_log(%rip), %eax
	pushq	%r14
	.cfi_def_cfa_offset 4536
	pushq	%rax
	.cfi_def_cfa_offset 4544
	movl	max_age(%rip), %eax
	pushq	%rbx
	.cfi_def_cfa_offset 4552
	pushq	%rax
	.cfi_def_cfa_offset 4560
	pushq	p3p(%rip)
	.cfi_def_cfa_offset 4568
	pushq	charset(%rip)
	.cfi_def_cfa_offset 4576
	call	httpd_initialize
	addq	$96, %rsp
	.cfi_def_cfa_offset 4480
	testq	%rax, %rax
	movq	%rax, hs(%rip)
	je	.L659
	movq	JunkClientData(%rip), %rdx
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$120000, %ecx
	movl	$occasional, %esi
	call	tmr_create
	testq	%rax, %rax
	je	.L668
	movq	JunkClientData(%rip), %rdx
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$5000, %ecx
	movl	$idle, %esi
	call	tmr_create
	testq	%rax, %rax
	je	.L669
	cmpl	$0, numthrottles(%rip)
	jle	.L555
	movq	JunkClientData(%rip), %rdx
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$2000, %ecx
	movl	$update_throttles, %esi
	call	tmr_create
	testq	%rax, %rax
	je	.L670
.L555:
	movq	JunkClientData(%rip), %rdx
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$3600000, %ecx
	movl	$show_stats, %esi
	call	tmr_create
	testq	%rax, %rax
	je	.L671
	xorl	%edi, %edi
	call	time
	movq	$0, stats_connections(%rip)
	movq	%rax, stats_time(%rip)
	movq	%rax, start_time(%rip)
	movq	$0, stats_bytes(%rip)
	movl	$0, stats_simultaneous(%rip)
	call	getuid
	testl	%eax, %eax
	jne	.L558
	xorl	%esi, %esi
	xorl	%edi, %edi
	call	setgroups
	testl	%eax, %eax
	movl	$.LC157, %esi
	js	.L658
	movl	%r15d, %edi
	call	setgid
	testl	%eax, %eax
	movl	$.LC158, %esi
	js	.L658
	movq	user(%rip), %rdi
	movl	%r15d, %esi
	call	initgroups
	testl	%eax, %eax
	js	.L672
.L561:
	movl	4(%rsp), %edi
	call	setuid
	testl	%eax, %eax
	movl	$.LC160, %esi
	js	.L658
	cmpl	$0, do_chroot(%rip)
	je	.L673
.L558:
	movslq	max_connects(%rip), %rbp
	movq	%rbp, %rbx
	imulq	$144, %rbp, %rbp
	movq	%rbp, %rdi
	call	malloc
	testq	%rax, %rax
	movq	%rax, connects(%rip)
	je	.L564
	xorl	%ecx, %ecx
	testl	%ebx, %ebx
	movq	%rax, %rdx
	jle	.L569
	.p2align 4,,10
	.p2align 3
.L637:
	addl	$1, %ecx
	movl	$0, (%rdx)
	movq	$0, 8(%rdx)
	movl	%ecx, 4(%rdx)
	addq	$144, %rdx
	cmpl	%ebx, %ecx
	jne	.L637
.L569:
	movl	$-1, -140(%rax,%rbp)
	movq	hs(%rip), %rax
	movl	$0, first_free_connect(%rip)
	movl	$0, num_connects(%rip)
	movl	$0, httpd_conn_count(%rip)
	testq	%rax, %rax
	je	.L570
	movl	72(%rax), %edi
	cmpl	$-1, %edi
	je	.L571
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	fdwatch_add_fd
	movq	hs(%rip), %rax
.L571:
	movl	76(%rax), %edi
	cmpl	$-1, %edi
	je	.L570
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	fdwatch_add_fd
.L570:
	leaq	32(%rsp), %rdi
	call	tmr_prepare_timeval
	.p2align 4,,10
	.p2align 3
.L572:
	movl	terminate(%rip), %eax
	testl	%eax, %eax
	je	.L595
	cmpl	$0, num_connects(%rip)
	jle	.L674
.L595:
	movl	got_hup(%rip), %eax
	testl	%eax, %eax
	jne	.L675
.L573:
	leaq	32(%rsp), %rdi
	call	tmr_mstimeout
	movq	%rax, %rdi
	call	fdwatch
	testl	%eax, %eax
	movl	%eax, %ebx
	js	.L676
	leaq	32(%rsp), %rdi
	call	tmr_prepare_timeval
	testl	%ebx, %ebx
	je	.L677
	movq	hs(%rip), %rax
	testq	%rax, %rax
	je	.L586
	movl	76(%rax), %edi
	cmpl	$-1, %edi
	je	.L581
	call	fdwatch_check_fd
	testl	%eax, %eax
	jne	.L582
.L585:
	movq	hs(%rip), %rax
	testq	%rax, %rax
	je	.L586
.L581:
	movl	72(%rax), %edi
	cmpl	$-1, %edi
	je	.L586
	call	fdwatch_check_fd
	testl	%eax, %eax
	jne	.L678
	.p2align 4,,10
	.p2align 3
.L586:
	call	fdwatch_get_next_client_data
	cmpq	$-1, %rax
	movq	%rax, %rbx
	je	.L679
	testq	%rbx, %rbx
	je	.L586
	movq	8(%rbx), %rax
	movl	704(%rax), %edi
	call	fdwatch_check_fd
	testl	%eax, %eax
	je	.L680
	movl	(%rbx), %eax
	cmpl	$2, %eax
	je	.L589
	cmpl	$4, %eax
	je	.L590
	cmpl	$1, %eax
	jne	.L586
	leaq	32(%rsp), %rsi
	movq	%rbx, %rdi
	call	handle_read
	jmp	.L586
.L662:
	movl	$1, no_log(%rip)
	xorl	%r14d, %r14d
	jmp	.L529
.L539:
	call	setsid
	jmp	.L541
.L665:
	movl	$.LC145, %esi
.L658:
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
.L659:
	movl	$1, %edi
	call	exit
.L661:
	movq	user(%rip), %rdi
	call	getpwnam
	testq	%rax, %rax
	je	.L681
	movl	16(%rax), %ecx
	movl	20(%rax), %r15d
	movl	%ecx, 4(%rsp)
	jmp	.L527
.L660:
	movl	$.LC131, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
	movq	stderr(%rip), %rdi
	movq	argv0(%rip), %rdx
	movl	$.LC132, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
.L680:
	leaq	32(%rsp), %rsi
	movq	%rbx, %rdi
	call	clear_connection
	jmp	.L586
.L676:
	call	__errno_location
	movl	(%rax), %eax
	cmpl	$11, %eax
	je	.L572
	cmpl	$4, %eax
	je	.L572
	movl	$3, %edi
	movl	$.LC163, %esi
	xorl	%eax, %eax
	call	syslog
	movl	$1, %edi
	call	exit
.L590:
	leaq	32(%rsp), %rsi
	movq	%rbx, %rdi
	call	handle_linger
	jmp	.L586
.L589:
	leaq	32(%rsp), %rsi
	movq	%rbx, %rdi
	call	handle_send
	jmp	.L586
.L679:
	leaq	32(%rsp), %rdi
	call	tmr_run
	movl	got_usr1(%rip), %eax
	testl	%eax, %eax
	je	.L572
	cmpl	$0, terminate(%rip)
	jne	.L572
	movq	hs(%rip), %rax
	movl	$1, terminate(%rip)
	testq	%rax, %rax
	je	.L572
	movl	72(%rax), %edi
	cmpl	$-1, %edi
	je	.L593
	call	fdwatch_del_fd
	movq	hs(%rip), %rax
.L593:
	movl	76(%rax), %edi
	cmpl	$-1, %edi
	je	.L594
	call	fdwatch_del_fd
.L594:
	movq	hs(%rip), %rdi
	call	httpd_unlisten
	jmp	.L572
.L675:
	call	re_open_logfile
	movl	$0, got_hup(%rip)
	jmp	.L573
.L677:
	leaq	32(%rsp), %rdi
	call	tmr_run
	jmp	.L572
.L666:
	movq	%rbx, %rdi
	call	chroot
	testl	%eax, %eax
	js	.L682
	movq	logfile(%rip), %r13
	testq	%r13, %r13
	je	.L547
	movl	$.LC94, %esi
	movq	%r13, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L547
	xorl	%eax, %eax
	orq	$-1, %rcx
	movq	%rbx, %rdi
	repnz; scasb
	movq	%rbx, %rsi
	movq	%r13, %rdi
	notq	%rcx
	leaq	-1(%rcx), %rdx
	movq	%rcx, 8(%rsp)
	call	strncmp
	testl	%eax, %eax
	movq	8(%rsp), %rcx
	jne	.L548
	leaq	-2(%r13,%rcx), %rsi
	movq	%r13, %rdi
	call	strcpy
.L547:
	movq	%rbx, %rdi
	movw	$47, 304(%rsp)
	call	chdir
	testl	%eax, %eax
	jns	.L545
	movl	$.LC149, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movl	$.LC150, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L597:
	xorl	%r14d, %r14d
	jmp	.L529
.L531:
	movl	$.LC96, %esi
	movq	%rbx, %rdi
	call	fopen
	movq	logfile(%rip), %rdi
	movl	$384, %esi
	movq	%rax, %r14
	call	chmod
	testl	%eax, %eax
	jne	.L600
	testq	%r14, %r14
	je	.L600
	movq	logfile(%rip), %rax
	cmpb	$47, (%rax)
	je	.L534
	movl	$.LC136, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	movq	argv0(%rip), %rdx
	movq	stderr(%rip), %rdi
	movl	$.LC137, %esi
	xorl	%eax, %eax
	call	fprintf
.L534:
	movq	%r14, %rdi
	call	fileno
	movl	$1, %edx
	movl	%eax, %edi
	movl	$2, %esi
	xorl	%eax, %eax
	call	fcntl
	call	getuid
	testl	%eax, %eax
	jne	.L529
	movq	%r14, %rdi
	call	fileno
	movl	4(%rsp), %esi
	movl	%r15d, %edx
	movl	%eax, %edi
	call	fchown
	testl	%eax, %eax
	jns	.L529
	movl	$.LC138, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	movl	$.LC139, %edi
	call	perror
	jmp	.L529
.L663:
	movl	$.LC140, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movl	$.LC141, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L664:
	movq	pidfile(%rip), %rdx
	movl	$2, %edi
	movl	$.LC85, %esi
	xorl	%eax, %eax
	call	syslog
	movl	$1, %edi
	call	exit
.L668:
	movl	$2, %edi
	movl	$.LC153, %esi
	call	syslog
	movl	$1, %edi
	call	exit
.L667:
	movl	$.LC151, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movl	$.LC152, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L548:
	xorl	%eax, %eax
	movl	$.LC147, %esi
	movl	$4, %edi
	call	syslog
	movq	argv0(%rip), %rdx
	movq	stderr(%rip), %rdi
	movl	$.LC148, %esi
	xorl	%eax, %eax
	call	fprintf
	jmp	.L547
.L673:
	movl	$.LC161, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	jmp	.L558
.L670:
	movl	$2, %edi
	movl	$.LC155, %esi
	call	syslog
	movl	$1, %edi
	call	exit
.L582:
	movq	hs(%rip), %rax
	leaq	32(%rsp), %rdi
	movl	76(%rax), %esi
	call	handle_newconnect
	testl	%eax, %eax
	jne	.L572
	jmp	.L585
.L678:
	movq	hs(%rip), %rax
	leaq	32(%rsp), %rdi
	movl	72(%rax), %esi
	call	handle_newconnect
	testl	%eax, %eax
	jne	.L572
	jmp	.L586
.L671:
	movl	$2, %edi
	movl	$.LC156, %esi
	call	syslog
	movl	$1, %edi
	call	exit
.L600:
	movq	logfile(%rip), %rdx
	movl	$.LC85, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movq	logfile(%rip), %rdi
	call	perror
	movl	$1, %edi
	call	exit
.L674:
	call	shut_down
	movl	$5, %edi
	movl	$.LC106, %esi
	xorl	%eax, %eax
	call	syslog
	call	closelog
	xorl	%edi, %edi
	call	exit
.L669:
	movl	$2, %edi
	movl	$.LC154, %esi
	call	syslog
	movl	$1, %edi
	call	exit
.L682:
	movl	$.LC146, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movl	$.LC31, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L681:
	movq	user(%rip), %rdx
	movl	$.LC133, %esi
	movl	$2, %edi
	call	syslog
	movq	stderr(%rip), %rdi
	movq	user(%rip), %rcx
	movl	$.LC134, %esi
	movq	argv0(%rip), %rdx
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
.L564:
	movl	$.LC162, %esi
	jmp	.L658
.L672:
	movl	$.LC159, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	jmp	.L561
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE164:
	.section	.text.startup
.LHOTE164:
	.local	watchdog_flag
	.comm	watchdog_flag,4,4
	.local	got_usr1
	.comm	got_usr1,4,4
	.local	got_hup
	.comm	got_hup,4,4
	.comm	stats_simultaneous,4,4
	.comm	stats_bytes,8,8
	.comm	stats_connections,8,8
	.comm	stats_time,8,8
	.comm	start_time,8,8
	.globl	terminate
	.bss
	.align 4
	.type	terminate, @object
	.size	terminate, 4
terminate:
	.zero	4
	.local	hs
	.comm	hs,8,8
	.local	httpd_conn_count
	.comm	httpd_conn_count,4,4
	.local	first_free_connect
	.comm	first_free_connect,4,4
	.local	max_connects
	.comm	max_connects,4,4
	.local	num_connects
	.comm	num_connects,4,4
	.local	connects
	.comm	connects,8,8
	.local	maxthrottles
	.comm	maxthrottles,4,4
	.local	numthrottles
	.comm	numthrottles,4,4
	.local	throttles
	.comm	throttles,8,8
	.local	max_age
	.comm	max_age,4,4
	.local	p3p
	.comm	p3p,8,8
	.local	charset
	.comm	charset,8,8
	.local	user
	.comm	user,8,8
	.local	pidfile
	.comm	pidfile,8,8
	.local	hostname
	.comm	hostname,8,8
	.local	throttlefile
	.comm	throttlefile,8,8
	.local	logfile
	.comm	logfile,8,8
	.local	local_pattern
	.comm	local_pattern,8,8
	.local	no_empty_referers
	.comm	no_empty_referers,4,4
	.local	url_pattern
	.comm	url_pattern,8,8
	.local	cgi_limit
	.comm	cgi_limit,4,4
	.local	cgi_pattern
	.comm	cgi_pattern,8,8
	.local	do_global_passwd
	.comm	do_global_passwd,4,4
	.local	do_vhost
	.comm	do_vhost,4,4
	.local	no_symlink_check
	.comm	no_symlink_check,4,4
	.local	no_log
	.comm	no_log,4,4
	.local	do_chroot
	.comm	do_chroot,4,4
	.local	data_dir
	.comm	data_dir,8,8
	.local	dir
	.comm	dir,8,8
	.local	port
	.comm	port,2,2
	.local	debug
	.comm	debug,4,4
	.local	argv0
	.comm	argv0,8,8
	.ident	"GCC: (GNU) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
