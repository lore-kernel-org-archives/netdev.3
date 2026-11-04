Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760728;
	b=KZnzJXC1AP4SrOmdBvA5Q/V8OH4VFmyIj/Q4pmBym/8xOPlRsuXJGa/mqZNRWCaAaau1
	 4mTtUnvVZoZl6XRdP21STchLheN8gJAXN7MH0Dt2Yav9z5z5WMmxotf6dnp5RBdVV3/HQ
	 soIgIbjGwP63x13KszamGQ5J20zQg/Qe7v2RRHI2ptiUuIYpED/Ky6zAAy+itHunvuNsP
	 ZrA6kKE2Bec+IbBS/E0vD4Nx75KhYTYbRgDw0BSMVZpyarbB2xFfEXuV+XazmyLcTOlAq
	 IPnlFdWpB5Z9t+k+LkYUcykRprjGn3lowMkdJzFtxqS89hhyG2i0uy06kIfg9Y+E99Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=YOIB/NuvjxdYC3jB9HzBeV3ersJ2Dya87F36PEImkS0=;
	b=FYxr92jSN46aOStWHyemagtC3RoVCUqXc6rKG27KMua2ek6SCHZx+unYvxktaa3wJsHc
	 EgdXorULdnc2pmyYBqTaNEfV8fLZsjTBUAKm6NyXP8sDjZgdvQ1Hlpxkd4ZaSXCgMT0IC
	 t5/VNOUMa6qceLMial9o8JeUVfnZ7NJ87fSsH+9LdPeKaLOk0AHj7TF2GuoH0Ca1tKxG+
	 CWlDCsQHfa9glEdWvegoJidgLvQUQHMEJ/Vz8ze0kkZhOEdgfv8Ms3QS/2s6pqPYj7fAb
	 PT4+Vu3NUvsbVyfJ06+GFQU9kY9V5WAXxUSRE+Www/elIcySSfCuSZXJlUbneUlK9SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0RfJcSnv;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26135606A32C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 02:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26135606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0RfJcSnv
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-369f33df08eso360711eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 18:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793760727; x=1794365527; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YOIB/NuvjxdYC3jB9HzBeV3ersJ2Dya87F36PEImkS0=;
        b=0RfJcSnvf34FDeMQGoJPjj27hslWY4H/FeiLoTIMYMk2m0FB8q5hv2C4tj/i9HU4TY
         n3Qoe+oJQPnxqYV9gHlFmCwvRThQbuRMvkCC5jVfGF0oVidNyelMx+01Lcjapb+mwoIp
         EDBuihPiMAxOIMkKDskPQTepEzNt1+p9mRv8hUSnWDZgZd10/e4tgvzDRKkI5nNwg5zO
         7yOQBhM2JfrDiIFKeuRNWPKG9BzCVRkRWwAHFaa3szyAyFrMFZrmcWt1+GPlUxZHJ0kR
         bSznmTJvv7zXLsbPG75AoOMYt5Qv+4f5ZwY3qKdAaAWMHN3o5l3lAkV6uKHiCckECOYM
         eogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793760727; x=1794365527;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YOIB/NuvjxdYC3jB9HzBeV3ersJ2Dya87F36PEImkS0=;
        b=c5sPrCXbkmcI1ow2psQ4P31OnbactSb4dCESx85e4Zn+UgZwFvRHocCtlFBygL/tik
         NB0ARrlnS8G6Jx7t3vAOnFhrKJGPti6yWDYgTuozzVnEX02v7vZi/tj/fRxpfHYONBkw
         47D6s9Kf1mGPvkDUavwDPKlp/0Ye0x91RQq/qU8ddahKDXwrNn/zF98c/O0+4hQXfb+4
         fs/E56scSLSVA+UJbfZ5bLIy67vFBEZDXNkijoqJndZyj7zfXkExBG9ug8QmEp5njMuM
         F7INXCaYTvoSLWfcOjLEJDt2nTmFBUKnujw7cmhqryl1Yst7T/FoIRuwq9sSTvMP6tqX
         x54g==
X-Forwarded-Encrypted: i=1; AKwUvBw+Gc02HkGH3jNztQvsV/IxupfSDVmnHuvZzsqJqP7uKTvaLFFLmAishKpv2z72clPomF4knbI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SI55V6Hs/Zif0foodOwZ75qmxr5x3mZg7zBxoeyTMFynJV/6g
	2Z9H6uSU0gVN0RNp5DyILwf6hKtMLd1dmxYULqK+lZOT+oIjk9z8m8ze
X-Gm-Gg: AYBFou1J5EUvrJSqsHm6rSqNUbW/BDI/U8vop+FVfrg/HpnaPoWmFHTFTaBuNi/MaQ6
	6X+8q49pCFtS5EQ5NYp6itKgGIcSY6tEdvCXg2C8o9+nGmZ6gl+WqC+U0pHlQbn0aB899uu3jht
	ERArWrn1P4F3dXOm2Zs7nQ/i+4ZOnjxjfy0GSsNqVeCkl1hSGI1SxmkMMRb9Oh1b/lh0YXfCTN1
	CEYlAGNbESed/tg1UCfUOcWFRrJdJKOgYcuXIiZwAHQf/eS1KeYBgkIbMl2+Te/1BNwNDB3Xuh0
	jU8unWRBi69VID5KZ2K00kAI0g6GEUv1CdjXkMo8pLinxzq0XWHzg0N9GR5/FyWCt6YAFjZChN3
	Xjtts2y8Ip78o7rSK9jsBWXBxROyNbCZgvWf7+dePHIf4IG+r8UFhQeqJpv7ZEJYs5S3e4rfcWT
	m8PSYTHZ5YexN892C9xk+pA+AmEtByiUxW/NIwKpL4SLKUkW5kqm094JbU3kAhT0LlFdIV8Dhw8
	tfMbCPMtepl3HGhcmwwnd+xgbG2bDAkkQ837FiQBCo8ZqGkbum7TBZkOuyeFD5iCAyGTfYSWj/v
	LAv2kyYUcGmTGwYom5GzFnG4mESTxA9WK0C350X06uG+2N0=
X-Received: by 2002:a05:693c:895c:20b0:359:ef9:9be3 with SMTP id 5a478bee46e88-36a4236a466mr21802378eec.11.1793760726448;
        Tue, 03 Nov 2026 18:52:06 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3966daasm3275791eec.23.2026.11.03.18.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:52:05 -0800 (PST)
Date: Wed, 4 Nov 2026 11:52:02 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
	pabeni@redhat.com
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH mptcp-net v2] mptcp: fix use-after-free of the subflow
 context on the delegated list
Message-ID: <auqd0rAI95jDSMvu@v4bel>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

mptcp_subflow_delegate() links the subflow context into a per-CPU napi
list and takes a reference on the subflow socket. The context is a
separate allocation, reached through icsk_ulp_data, and the list holds
no reference to it.

inet_csk_destroy_sock() runs sk_prot->destroy() regardless of the
outstanding references. That path ends in tcp_cleanup_ulp(), which calls
subflow_ulp_release(). subflow_ulp_release() frees the context with
kfree_rcu() but does not remove it from the list. Once the grace period
elapses and the context is actually freed, the next mptcp_napi_poll()
dequeues that entry and mptcp_subflow_delegated_next() writes to the
freed context with list_del_init(). That is the use-after-free.

The decoded KASAN trace is:

 ==================================================================
 BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report (lib/list_debug.c:49)
 Read of size 8 at addr ffff88800cc13cc8 by task poc/88

 CPU: 3 UID: 65534 PID: 88 Comm: poc Not tainted 7.2.0-rc7 #1 PREEMPT(lazy)
 Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 Call Trace:
  <IRQ>
  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
  ? __pfx__raw_spin_lock_irqsave (include/asm-generic/qrwlock.h:122 (discriminator 4))
  ? __list_del_entry_valid_or_report (lib/list_debug.c:49)
  kasan_report (mm/kasan/report.c:595)
  ? __list_del_entry_valid_or_report (lib/list_debug.c:49)
  __list_del_entry_valid_or_report (lib/list_debug.c:49)
  mptcp_napi_poll (include/linux/list.h:132 include/linux/list.h:246 include/linux/list.h:318 net/mptcp/protocol.h:787 net/mptcp/protocol.c:4620)
  ? call_timer_fn (kernel/time/timer.c:1748)
  __napi_poll (net/core/dev.c:7735)
  ? __pfx_delayed_work_timer_fn (include/linux/list.h:404 (discriminator 2))
  net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
  ? __pfx_net_rx_action (include/net/gro.h:525)
  ? _raw_spin_lock_irq (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:143 kernel/locking/spinlock.c:174)
  ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:183)
  ? try_to_wake_up (include/linux/spinlock.h:571 kernel/sched/core.c:4292)
  handle_softirqs (kernel/softirq.c:622)
  ? __pfx_handle_softirqs (include/linux/wait_bit.h:77)
  ? __hrtimer_rearm_deferred (kernel/time/hrtimer.c:707 kernel/time/hrtimer.c:2141 kernel/time/hrtimer.c:2161)
  do_softirq (kernel/softirq.c:523 (discriminator 20) kernel/softirq.c:510 (discriminator 20))
  </IRQ>
  <TASK>
  __local_bh_enable_ip (kernel/softirq.c:450)
  inet_stream_connect (net/ipv4/af_inet.c:756)
  __sys_connect (net/socket.c:2154)
  ? __pfx___sys_connect (net/socket.c:2136)
  ? __sys_setsockopt (include/linux/file.h:63 include/linux/file.h:83 net/socket.c:2385)
  __x64_sys_connect (net/socket.c:2160 net/socket.c:2157 net/socket.c:2157)
  ? fpregs_assert_state_consistent (include/linux/instrumented.h:82 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/thread_info.h:133 arch/x86/kernel/fpu/core.c:912)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
 RIP: 0033:0x4216eb
 Code: 48 89 e5 48 83 ec 10 89 55 f8 48 89 75 f0 89 7d fc e8 b9 ec 02 00 8b 55 f8 48 8b 75 f0 41 89 c0 8b 7d fc b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2d 44 89 c7 89 45 fc e8 12 ed 02 00 8b 45 fc
All code
========
   0:	48 89 e5             	mov    %rsp,%rbp
   3:	48 83 ec 10          	sub    $0x10,%rsp
   7:	89 55 f8             	mov    %edx,-0x8(%rbp)
   a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   e:	89 7d fc             	mov    %edi,-0x4(%rbp)
  11:	e8 b9 ec 02 00       	call   0x2eccf
  16:	8b 55 f8             	mov    -0x8(%rbp),%edx
  19:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
  1d:	41 89 c0             	mov    %eax,%r8d
  20:	8b 7d fc             	mov    -0x4(%rbp),%edi
  23:	b8 2a 00 00 00       	mov    $0x2a,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 2d                	ja     0x5f
  32:	44 89 c7             	mov    %r8d,%edi
  35:	89 45 fc             	mov    %eax,-0x4(%rbp)
  38:	e8 12 ed 02 00       	call   0x2ed4f
  3d:	8b 45 fc             	mov    -0x4(%rbp),%eax

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 2d                	ja     0x35
   8:	44 89 c7             	mov    %r8d,%edi
   b:	89 45 fc             	mov    %eax,-0x4(%rbp)
   e:	e8 12 ed 02 00       	call   0x2ed25
  13:	8b 45 fc             	mov    -0x4(%rbp),%eax
 RSP: 002b:00007fbe0147b1d0 EFLAGS: 00000293 ORIG_RAX: 000000000000002a
 RAX: ffffffffffffffda RBX: 000000000000000a RCX: 00000000004216eb
 RDX: 0000000000000010 RSI: 00007fbe0147b200 RDI: 000000000000000a
 RBP: 00007fbe0147b1e0 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007fbe0147b1f8 R11: 0000000000000293 R12: 00007fbe0147b1f8
 R13: 00007fbe0157b678 R14: 00007fbe0147b1f4 R15: 00007fffd4bc16c0
  </TASK>

 Allocated by task 90:
  kasan_save_stack (mm/kasan/common.c:57)
  kasan_save_track (mm/kasan/common.c:78)
  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
  __kmalloc_cache_noprof (include/linux/kasan.h:263 mm/slub.c:5489)
  subflow_create_ctx (include/linux/slab.h:988 include/linux/slab.h:1309 net/mptcp/subflow.c:1845)
  subflow_ulp_init (net/mptcp/subflow.c:1977)
  tcp_set_ulp (net/ipv4/tcp_ulp.c:146 net/ipv4/tcp_ulp.c:167)
  mptcp_subflow_create_socket (net/mptcp/subflow.c:1806)
  __mptcp_nmpc_sk.part.0 (net/mptcp/protocol.c:111 net/mptcp/protocol.c:143)
  mptcp_connect (net/mptcp/protocol.c:139 net/mptcp/protocol.c:4009)
  __inet_stream_connect (net/ipv4/af_inet.c:684)
  inet_stream_connect (net/ipv4/af_inet.c:755)
  __sys_connect (net/socket.c:2154)
  __x64_sys_connect (net/socket.c:2160 net/socket.c:2157 net/socket.c:2157)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

 Freed by task 22:
  kasan_save_stack (mm/kasan/common.c:57)
  kasan_save_track (mm/kasan/common.c:78)
  kasan_save_free_info (mm/kasan/generic.c:584)
  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
  kvfree_rcu_cb (include/linux/kasan.h:235 mm/slub.c:2677 mm/slub.c:6377 mm/slub.c:6662)
  rcu_core (kernel/rcu/tree.c:2645 kernel/rcu/tree.c:2897)
  handle_softirqs (kernel/softirq.c:622)
  run_ksoftirqd (kernel/softirq.c:1076 kernel/softirq.c:1068)
  smpboot_thread_fn (kernel/smpboot.c:160)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:158)
  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

 Last potentially related work creation:
  kasan_save_stack (mm/kasan/common.c:57)
  kasan_record_aux_stack (mm/kasan/generic.c:556)
  __call_rcu_common.constprop.0 (kernel/rcu/tree.c:3159)
  tcp_cleanup_ulp (net/ipv4/tcp_ulp.c:124)
  tcp_v4_destroy_sock (net/ipv4/tcp_ipv4.c:2437)
  inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1282)
  __tcp_close (net/ipv4/tcp.c:3299)
  __mptcp_close_ssk (net/mptcp/protocol.c:2648)
  mptcp_destroy_common (net/mptcp/protocol.c:3442 (discriminator 1))
  mptcp_destroy (net/mptcp/protocol.c:3651)
  __mptcp_destroy_sock (net/mptcp/protocol.c:3284)
  __mptcp_close (net/mptcp/protocol.c:3386)
  mptcp_close (net/mptcp/protocol.c:3401)
  inet_release (net/ipv4/af_inet.c:442)
  __sock_release (net/socket.c:710)
  sock_close (net/socket.c:1501 (discriminator 1))
  __fput (fs/file_table.c:512)
  fput_close_sync (fs/file_table.c:617)
  __x64_sys_close (fs/open.c:1511 fs/open.c:1496 fs/open.c:1496)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

 Second to last potentially related work creation:
  kasan_save_stack (mm/kasan/common.c:57)
  kasan_record_aux_stack (mm/kasan/generic.c:556)
  kvfree_call_rcu (mm/slab_common.c:1288)
  tcp_cleanup_ulp (net/ipv4/tcp_ulp.c:124)
  tcp_v4_destroy_sock (net/ipv4/tcp_ipv4.c:2437)
  inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1282)
  __tcp_close (net/ipv4/tcp.c:3299)
  __mptcp_close_ssk (net/mptcp/protocol.c:2648)
  mptcp_destroy_common (net/mptcp/protocol.c:3442 (discriminator 1))
  mptcp_destroy (net/mptcp/protocol.c:3651)
  __mptcp_destroy_sock (net/mptcp/protocol.c:3284)
  __mptcp_close (net/mptcp/protocol.c:3386)
  mptcp_close (net/mptcp/protocol.c:3401)
  inet_release (net/ipv4/af_inet.c:442)
  __sock_release (net/socket.c:710)
  sock_close (net/socket.c:1501 (discriminator 1))
  __fput (fs/file_table.c:512)
  fput_close_sync (fs/file_table.c:617)
  __x64_sys_close (fs/open.c:1511 fs/open.c:1496 fs/open.c:1496)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

 The buggy address belongs to the object at ffff88800cc13c00
  which belongs to the cache kmalloc-512 of size 512
 The buggy address is located 200 bytes inside of
  freed 512-byte region [ffff88800cc13c00, ffff88800cc13e00)

 The buggy address belongs to the physical page:
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xcc10
 head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 flags: 0x100000000000040(head|node=0|zone=1)
 page_type: f5(slab)
 raw: 0100000000000040 ffff888007042c80 dead000000000100 dead000000000122
 raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
 head: 0100000000000040 ffff888007042c80 dead000000000100 dead000000000122
 head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
 head: 0100000000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
 head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff88800cc13b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88800cc13c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >ffff88800cc13c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff88800cc13d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88800cc13d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ==================================================================

The freeing path cannot dequeue the entry itself: the list is per-CPU
and only the CPU that queued the subflow may touch it, as
tcp_release_cb_override() already notes.

Delay the free instead. Add MPTCP_DELEGATE_DEAD.
mptcp_subflow_free_ctx() sets it and frees the context only if the
subflow is not scheduled, while mptcp_napi_poll() frees it if the dead
bit is set when it clears the scheduled bit. Either
mptcp_subflow_free_ctx() gets there first, sees the scheduled bit and
leaves the free to mptcp_napi_poll(), or mptcp_napi_poll() gets there
first, does not see the dead bit and mptcp_subflow_free_ctx() does the
free.

Also skip mptcp_subflow_process_delegated() once the dead bit is set.
subflow_ulp_release() has already dropped the msk reference by then, so
the pending actions must not run.

Finally, move delegated_status out of struct_group(reset).
mptcp_subflow_ctx_reset() clears that group on disconnect, and clearing
the scheduled bit while the entry is still queued would let
mptcp_subflow_free_ctx() free a context the napi list still points to.
delegated_node is already outside the group.

Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Rebase the patch. (Matthieu Baerts)
- Add the decoded KASAN trace without timestamps. (Matthieu Baerts)
- Clear stale action bits in mptcp_subflow_ctx_reset() to prevent old
  actions from running after a disconnect.
v1: https://lore.kernel.org/all/aoWBrkNwebJe-koh@v4bel/
---
 net/mptcp/protocol.c | 13 ++++++++++---
 net/mptcp/protocol.h | 18 ++++++++++++++++--
 net/mptcp/subflow.c  |  4 ++--
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e9..60bb16305e656 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2705,7 +2705,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 */
 	if (!inet_csk(ssk)->icsk_ulp_ops) {
 		WARN_ON_ONCE(!sock_flag(ssk, SOCK_DEAD));
-		kfree_rcu(subflow, rcu);
+		mptcp_subflow_free_ctx(subflow);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
 		__tcp_close(ssk, 0);
@@ -4791,10 +4791,13 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 	delegated = container_of(napi, struct mptcp_delegated_action, napi);
 	while ((subflow = mptcp_subflow_delegated_next(delegated)) != NULL) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		long status;
 
 		bh_lock_sock_nested(ssk);
 		if (!sock_owned_by_user(ssk)) {
-			mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated_status, 0));
+			status = xchg(&subflow->delegated_status, 0);
+			if (!(status & BIT(MPTCP_DELEGATE_DEAD)))
+				mptcp_subflow_process_delegated(ssk, status);
 		} else {
 			/* tcp_release_cb_override already processed
 			 * the action or will do at next release_sock().
@@ -4802,11 +4805,15 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 			 * CPU that scheduled it.
 			 */
 			smp_wmb();
-			clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_status);
+			status = set_mask_bits(&subflow->delegated_status,
+					       BIT(MPTCP_DELEGATE_SCHEDULED), 0);
 		}
 		bh_unlock_sock(ssk);
 		sock_put(ssk);
 
+		if (status & BIT(MPTCP_DELEGATE_DEAD))
+			kfree_rcu(subflow, rcu);
+
 		if (++work_done == budget)
 			return budget;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 011e73d04ee60..6140c82347b42 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -553,8 +553,10 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 #define MPTCP_DELEGATE_SEND		1
 #define MPTCP_DELEGATE_ACK		2
 #define MPTCP_DELEGATE_SNDBUF		3
+#define MPTCP_DELEGATE_DEAD		4
 
-#define MPTCP_DELEGATE_ACTIONS_MASK	(~BIT(MPTCP_DELEGATE_SCHEDULED))
+#define MPTCP_DELEGATE_ACTIONS_MASK	(~(BIT(MPTCP_DELEGATE_SCHEDULED) | \
+					   BIT(MPTCP_DELEGATE_DEAD)))
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
@@ -628,11 +630,11 @@ struct mptcp_subflow_context {
 
 	u32	subflow_id;
 
-	long	delegated_status;
 	unsigned long	fail_tout;
 
 	);
 
+	long	delegated_status;
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
 
 	u32	setsockopt_seq;
@@ -671,6 +673,8 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 	memset(&subflow->reset, 0, sizeof(subflow->reset));
 	subflow->request_mptcp = 1;
 	WRITE_ONCE(subflow->local_id, -1);
+	set_mask_bits(&subflow->delegated_status,
+		      MPTCP_DELEGATE_ACTIONS_MASK, 0);
 }
 
 /* Convert reset reasons in MPTCP to enum sk_rst_reason type */
@@ -808,6 +812,16 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
 	return ret;
 }
 
+static inline void mptcp_subflow_free_ctx(struct mptcp_subflow_context *subflow)
+{
+	long old = set_mask_bits(&subflow->delegated_status, 0,
+				 BIT(MPTCP_DELEGATE_DEAD));
+
+	/* a scheduled subflow is owned by mptcp_napi_poll(), which will free it */
+	if (!(old & BIT(MPTCP_DELEGATE_SCHEDULED)))
+		kfree_rcu(subflow, rcu);
+}
+
 void __mptcp_inherit_memcg(struct sock *sk, struct sock *ssk, gfp_t gfp);
 void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 78e886b202585..32afd9e8865d9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -828,7 +828,7 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
 			sock_put(ctx->conn);
 	}
 
-	kfree_rcu(ctx, rcu);
+	mptcp_subflow_free_ctx(ctx);
 }
 
 void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
@@ -2087,7 +2087,7 @@ static void subflow_ulp_release(struct sock *ssk)
 
 	mptcp_subflow_ops_undo_override(ssk);
 	if (release)
-		kfree_rcu(ctx, rcu);
+		mptcp_subflow_free_ctx(ctx);
 }
 
 static void subflow_ulp_clone(const struct request_sock *req,
-- 
2.43.0

