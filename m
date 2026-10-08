Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF633480DD8
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450595; cv=none; b=Dq0iHaXIUGe8ZvvHXxyTwKP/JIEPDlJXJaO/Qwzkk4gMBo4Lr4POY1/Z2EGZjlXHgVg/ioL3pcJKwTzj4XWYdZKytuj90MRkMBFUj1SJJmWFPCOXRZUDn0s7lgStFiLVpvgMJcM/xPwu1cw0Duxkewjzt/Loi2bhfflgFpJL+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450595; c=relaxed/simple;
	bh=821f4AkKy0S46J+GjL03Mx+cauXrm+x+jzN34jFaAD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR/aipS4+VJA9Mc/IF6YqPnUe8zWmoUk7SLMJZ4TvHuI23oTQYNTyBrFhUZw2L3hVIpZlEP6BziQbEa0oWKNLPCa0F5/jryeIf911ROUNiEkAxcCTMtxr8gm5ICT8YFAumeldIFiCEY0i6ivdXN974FfOT5KNiV2bdh8dCmlL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm; spf=pass smtp.mailfrom=poczta.fm; dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b=FEtlTaFL; arc=none smtp.client-ip=217.74.67.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b="FEtlTaFL"
Received: from nr200 (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Thu,  8 Oct 2026 11:06:53 +0200 (CEST)
Date: Thu, 8 Oct 2026 11:06:51 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: syzbot <syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, kriish.sharma2006@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in device_move
Message-ID: <asddK6J6bt2YFJPb@nr200>
References: <673e3029.050a0220.363a1b.0024.GAE@google.com>
 <6a75e412.01d0871a.3a0d52.0049.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a75e412.01d0871a.3a0d52.0049.GAE@google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1791450415; bh=fdc2ywB5+TLgQIbK090FuizsHWJHtcNiBLPqY3jB6dE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=FEtlTaFLbnw4ML4bsFErJqlF9vYHyXbhHuF9q50R7TcISy5V5c2aLX1ktoOXiQzW+
	 lwEEq11RUPCtH8qSIspkeJ0Or3rnE0W3it7wSPYRKzSs76i1hcS1H8GM68A8KShVbv
	 NA9KvmhMM8DjYxSuF7itOLCcyjfpfUuF0fxj5Epk=

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-7.2.y

On sie 07, 2026 06:56, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    f9a2394a2348 Merge tag 'mm-hotfixes-stable-2026-08-06-18-4..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=101a02c6580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=86ba763b42fa66a
> dashboard link: https://syzkaller.appspot.com/bug?extid=1f4e278e8e1a9b01f95f
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170d0fb9580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
> CPU: 1 UID: 0 PID: 4943 Comm: kworker/u9:1 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> Workqueue: hci0 hci_rx_work
> RIP: 0010:klist_put lib/klist.c:212 [inline]
> RIP: 0010:klist_del lib/klist.c:230 [inline]
> RIP: 0010:klist_remove+0x156/0x340 lib/klist.c:249
> Code: 4d 89 f5 49 c1 ed 03 43 80 7c 3d 00 00 74 08 4c 89 f7 e8 8d 64 84 f6 4d 8b 26 49 83 e4 fe 49 8d 7c 24 58 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 74 05 e8 6e 64 84 f6 49 8b 44 24 58 48 89 44 24 08
> RSP: 0018:ffffc9000fc87700 EFLAGS: 00010202
> RAX: 000000000000000b RBX: ffff888035a90000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000058
> RBP: ffffc9000fc877e8 R08: ffffffff90199ae3 R09: 1ffffffff203335c
> R10: dffffc0000000000 R11: fffffbfff203335d R12: 0000000000000000
> R13: 1ffff1100e64e20c R14: ffff888073271060 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff888125306000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4691400c30 CR3: 00000000750f0000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  device_move+0x18e/0x720 drivers/base/core.c:4698
>  hci_conn_del_sysfs+0xb8/0x1a0 net/bluetooth/hci_sysfs.c:75
>  hci_conn_cleanup net/bluetooth/hci_conn.c:170 [inline]
>  hci_conn_del+0xc3d/0x1200 net/bluetooth/hci_conn.c:1308
>  hci_disconn_complete_evt+0x5ac/0x890 net/bluetooth/hci_event.c:3470
>  hci_event_func net/bluetooth/hci_event.c:7784 [inline]
>  hci_event_packet+0x6cd/0xf10 net/bluetooth/hci_event.c:7835
>  hci_rx_work+0x3ee/0x1020 net/bluetooth/hci_core.c:4039
>  process_one_work kernel/workqueue.c:3322 [inline]
>  process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
>  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
>  kthread+0x388/0x470 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:klist_put lib/klist.c:212 [inline]
> RIP: 0010:klist_del lib/klist.c:230 [inline]
> RIP: 0010:klist_remove+0x156/0x340 lib/klist.c:249
> Code: 4d 89 f5 49 c1 ed 03 43 80 7c 3d 00 00 74 08 4c 89 f7 e8 8d 64 84 f6 4d 8b 26 49 83 e4 fe 49 8d 7c 24 58 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 74 05 e8 6e 64 84 f6 49 8b 44 24 58 48 89 44 24 08
> RSP: 0018:ffffc9000fc87700 EFLAGS: 00010202
> RAX: 000000000000000b RBX: ffff888035a90000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000058
> RBP: ffffc9000fc877e8 R08: ffffffff90199ae3 R09: 1ffffffff203335c
> R10: dffffc0000000000 R11: fffffbfff203335d R12: 0000000000000000
> R13: 1ffff1100e64e20c R14: ffff888073271060 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff888125306000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4691400c30 CR3: 000000007e68e000 CR4: 00000000003526f0
> ----------------
> Code disassembly (best guess):
>    0:	4d 89 f5             	mov    %r14,%r13
>    3:	49 c1 ed 03          	shr    $0x3,%r13
>    7:	43 80 7c 3d 00 00    	cmpb   $0x0,0x0(%r13,%r15,1)
>    d:	74 08                	je     0x17
>    f:	4c 89 f7             	mov    %r14,%rdi
>   12:	e8 8d 64 84 f6       	call   0xf68464a4
>   17:	4d 8b 26             	mov    (%r14),%r12
>   1a:	49 83 e4 fe          	and    $0xfffffffffffffffe,%r12
>   1e:	49 8d 7c 24 58       	lea    0x58(%r12),%rdi
>   23:	48 89 f8             	mov    %rdi,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
>   2f:	74 05                	je     0x36
>   31:	e8 6e 64 84 f6       	call   0xf68464a4
>   36:	49 8b 44 24 58       	mov    0x58(%r12),%rax
>   3b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 

-- 
Slawomir Stepien
