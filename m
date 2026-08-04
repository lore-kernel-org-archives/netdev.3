Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB943A7F3;
	Tue,  4 Aug 2026 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877209; cv=none; b=jqVOi8H+h6jHsTLlfqgJV+iOpkwj+NnSGtq3WKwS5Ab3Nw5QlyQfKb050pFHbMg8McdLcQawYDtZnQ9wclxRSybX0KycX5+d+H/Bov71bP8KggdrTx4YBp6kuPu6w7JG1E4Pxd29Vv5XKj/IHVM9MzsdZgHa9PTFY55aOaklJhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877209; c=relaxed/simple;
	bh=1DjlGMxzCYwJpQfkxictaP2MlWvY7NAtfDrE0KWhpSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=du0c+FWGe8+U89pjnwGRyDBRbwlqxasgHYbPSYaj2JqRkgDue2gqJZvKqRjKD0p/5e0OuZ0Z3TRUITYh68EDnO1DaDNJ9h212XK87lADydkdN77CbZe8lgPFj5dQqb6cOMmpz9EdxWT9kPnTlEH5lwOqiOVrJBthddt4h2ZQYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCt9KCiw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCt9KCiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615B11F00A3A;
	Tue,  4 Aug 2026 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785877207;
	bh=rC8FDbIMWTB39WKOKXiFLlVQC87F9uT7a0Abtcke7nI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gCt9KCiwaiOfPJNSnfCSxC3tOuiP3oOj2zTekaQB1CHSHYi5ddlDU9cUgLgYSMj03
	 20xO7MFkQDa/HD6YzaWfFHq61APux+WjfNwt9OHBQUMrGlE9gB9ES/3pfUbKEFw/CC
	 CXGRMkE8HLFgpVOq43MSbhlayCHRhaxi3XamoKfrEe+5ARdPU0tt2p40nxZTZA59Zr
	 dgMGZGxXc90Z5tdBgIRIjcS1/WLALR7Iv/gD6GTpnK371NFzRzqglq0Ne39m+sWfw1
	 rxcYMKT7AypDji8IibTKeueATb2cRCnbM2MBd7hqKbxy/9az8p92pTfnPXDEcM14hn
	 7nQHCh191Rvwg==
Date: Tue, 4 Aug 2026 14:00:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: syzbot <syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in netdev_queue_get_dma_dev
Message-ID: <20260804140006.0210f6ca@kernel.org>
In-Reply-To: <6a71f80c.40259c87.584f4.04b9.GAE@google.com>
References: <6a71f80c.40259c87.584f4.04b9.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Pavel, could you TAL?

On Tue, 04 Aug 2026 07:32:44 -0700 syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    075b74841bd0 Linux 7.2-rc6
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=176a7db9580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
> dashboard link: https://syzkaller.appspot.com/bug?extid=a78926bdac2adb52dc0e
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16225db9580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bade32580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1dc04730d019/disk-075b7484.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d76da42271f4/vmlinux-075b7484.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/07b1cdbcbe45/bzImage-075b7484.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> RTNL: assertion failed at ./include/net/netdev_lock.h (72)
> WARNING: ./include/net/netdev_lock.h:72 at netdev_assert_locked_ops_compat include/net/netdev_lock.h:72 [inline], CPU#1: syz-executor223/5620
> WARNING: ./include/net/netdev_lock.h:72 at netdev_queue_get_dma_dev+0x52e/0x660 net/core/netdev_queues.c:43, CPU#1: syz-executor223/5620
> Modules linked in:
> CPU: 1 UID: 0 PID: 5620 Comm: syz-executor223 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
> RIP: 0010:netdev_assert_locked_ops_compat include/net/netdev_lock.h:72 [inline]
> RIP: 0010:netdev_queue_get_dma_dev+0x53a/0x660 net/core/netdev_queues.c:43
> Code: 89 c5 89 c6 e8 27 f7 68 f8 45 85 ed 0f 85 be fb ff ff e8 a9 fc 68 f8 48 8d 3d 12 0e 90 07 ba 48 00 00 00 48 c7 c6 a0 88 18 8d <67> 48 0f b9 3a e9 9c fb ff ff e8 87 fc 68 f8 48 8d bd 00 08 00 00
> RSP: 0018:ffffc90003b47a80 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888029874000 RCX: ffffffff89a16569
> RDX: 0000000000000048 RSI: ffffffff8d1888a0 RDI: ffffffff91317390
> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: ffff88807b3f2568 R15: ffffc90003b47be0
> FS:  00005555885ac400(0000) GS:ffff888123ed8000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000001000 CR3: 000000006f8b6000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  zcrx_register_netdev io_uring/zcrx.c:831 [inline]
>  io_register_zcrx+0xe94/0x1d30 io_uring/zcrx.c:983
>  __io_uring_register io_uring/register.c:942 [inline]
>  __do_sys_io_uring_register+0x1193/0x1bc0 io_uring/register.c:1040
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fd0b54bbcb9
> Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe25f0a7f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
> RAX: ffffffffffffffda RBX: 00007ffe25f0a928 RCX: 00007fd0b54bbcb9
> RDX: 0000200000000400 RSI: 0000000000000020 RDI: 0000000000000003
> RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffe25f0a928
> R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffe25f0a918
> R13: 0000000000000002 R14: 00007fd0b554cca0 R15: 0000000000000002
>  </TASK>
> ----------------
> Code disassembly (best guess):
>    0:	89 c5                	mov    %eax,%ebp
>    2:	89 c6                	mov    %eax,%esi
>    4:	e8 27 f7 68 f8       	call   0xf868f730
>    9:	45 85 ed             	test   %r13d,%r13d
>    c:	0f 85 be fb ff ff    	jne    0xfffffbd0
>   12:	e8 a9 fc 68 f8       	call   0xf868fcc0
>   17:	48 8d 3d 12 0e 90 07 	lea    0x7900e12(%rip),%rdi        # 0x7900e30
>   1e:	ba 48 00 00 00       	mov    $0x48,%edx
>   23:	48 c7 c6 a0 88 18 8d 	mov    $0xffffffff8d1888a0,%rsi
> * 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
>   2f:	e9 9c fb ff ff       	jmp    0xfffffbd0
>   34:	e8 87 fc 68 f8       	call   0xf868fcc0
>   39:	48 8d bd 00 08 00 00 	lea    0x800(%rbp),%rdi
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

