Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A634C49BD86
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766678; cv=none; b=UFTsdG4CA8db/NevvyFNl7YVJSERmLeQYfjnIbF4YeFrt0pGOADQGGysSsz/qMMHsSUkWDoI+DvBshUrkIVcJbCIBTLmKoCOHLM4UsEVKOKjXqxzS/fnwJMm91ILSHL5p/VSrtj0qHcdj/t8QfBYdY5bnbe6bfHf3LPihpml0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766678; c=relaxed/simple;
	bh=vysW34Y5MuVI7mh8rvcO+tz1BNsiP2Tm2MaYv/6cUS0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O2/CE4uUYlt9tW4YrkLfnThuicGKklvDhFwfxt6j5cPJJFBeXCj4GaXp7C8T9Et1adTHGSZVdzDhrzaBcVaOWN4RUP+yLBSRMdlLz5kpyGNabPtaLdbxMKhDDcnxj9H2Uyi5XdJ3e5XV61ABKwLnJrATXC8Ur6xxaYSCJhw9RsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-6b1bebb3ae8so497388eaf.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 14:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766675; x=1790371475;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u1u3CHkcCfNdtkHpr2f6Q8I6xzAzYCLm9kLKPD5T5jo=;
        b=ecYqMJHZannJTrqjcMpuKZ6K+7J/7SdaCQWaL2UNnLDG/s/2PCfjup4kd74LNA1CpT
         BWh+VcbqcQANDeikR2kBFmlArbFwC96oc12DAbyPbnKBcihFyKzPvJCrpMzSpVfbewhB
         pdZyT4QLbRE3eFjlO2ZworxKk9EMc2H/MJR3dP8B42dSe+394i2OfxZJzLEvco9xa2s4
         IIUDNKYj9wYxEKWigdpBc4khK6vIeASTLcHK4hplv+bLILMyWVZ16yM9fdS37OVftGVB
         7dy09xsdFGJUy6IfVaM8pgyXUe/2oSqw/E4lqANdsSfT/pJnA0a7aVJwKIlMgzJ+YDC+
         kpQg==
X-Forwarded-Encrypted: i=1; AKwUvByUJ2/d1NQKLIbep6aL/fAYkdGy9pi8j3ple0gXqN5PkYZGGH/oS909E1UID/6SDgkcM19EtrY=@vger.kernel.org
X-Gm-Message-State: AFuF++nCJ7IDdp52LJEDKMVtTneaav0zDtAZ9cm8T/XAsJZujB+oeXKF
	B6eFYDbP3Csf3voeTi45LJpY4mITZmQylPYr9Jv+vZKiN54NOm7JYdjAUJnjVB3QnOiz02gsiL4
	edyE5OZB+bvzOyeOHpqJ0VqZbYSCw6LB2155RogYGwHjHPedQuvIXmWqNqFE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a284:20b0:6cd:3fdb:fa6a with SMTP id
 006d021491bc7-6cd3fdbfe8dmr588537eaf.85.1789766675670; Fri, 18 Sep 2026
 14:24:35 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:24:35 -0700
In-Reply-To: <6aa3307a.6e6c5f9e.28f11f.003a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aadac13.b398a7c9.1f86be.003c.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: locking bug in finish_task_switch (3)
From: syzbot <syzbot+b5ddc2aecb8d1b29c871@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	luto@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b5f8c9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ddc2aecb8d1b29c871
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ab4525580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d4e915580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/daf497619736/disk-50d05c7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/748fbd82f647/vmlinux-50d05c7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e61c59099d07/bzImage-50d05c7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5ddc2aecb8d1b29c871@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: kernel/locking/lockdep.c:238 at hlock_class kernel/locking/lockdep.c:238 [inline], CPU#0: syz.1.28/6067
WARNING: kernel/locking/lockdep.c:238 at check_wait_context kernel/locking/lockdep.c:4923 [inline], CPU#0: syz.1.28/6067
WARNING: kernel/locking/lockdep.c:238 at __lock_acquire+0x5f0/0x2de0 kernel/locking/lockdep.c:5238, CPU#0: syz.1.28/6067
Modules linked in:
CPU: 0 UID: 0 PID: 6067 Comm: syz.1.28 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:hlock_class kernel/locking/lockdep.c:238 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4923 [inline]
RIP: 0010:__lock_acquire+0x5f7/0x2de0 kernel/locking/lockdep.c:5238
Code: 83 3d bc f2 fa 18 00 75 27 90 e8 94 e8 37 03 85 c0 74 1c 83 3d ed 29 d7 0e 00 75 13 48 8d 3d e0 32 da 0e 48 c7 c6 29 f3 59 8e <67> 48 0f b9 3a 90 31 c9 0f b6 81 c4 00 00 00 84 c0 0f 84 76 ff ff
RSP: 0000:ffffc90003a6e538 EFLAGS: 00010046
RAX: 0000000000000001 RBX: ffff88802f13e9b8 RCX: ffff88802f13ddc0
RDX: 0000000040000000 RSI: ffffffff8e59f329 RDI: ffffffff907d6580
RBP: ffff88802f13e9c0 R08: ffffffff907a5c83 R09: 1ffffffff20f4b90
R10: dffffc0000000000 R11: fffffbfff20f4b91 R12: 0000000000000004
R13: 0000000000000000 R14: ffff88802f13ddc0 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888124cd2000(0063) knlGS:00000000f67c3b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f71c8c10 CR3: 00000000711ba000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 finish_lock_switch kernel/sched/core.c:5254 [inline]
 finish_task_switch+0x16e/0xc60 kernel/sched/core.c:5375
 context_switch kernel/sched/core.c:5529 [inline]
 __schedule+0x17e3/0x58f0 kernel/sched/core.c:7276
 __schedule_loop kernel/sched/core.c:7353 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7368
 __lock_sock+0x162/0x2c0 net/core/sock.c:3238
 __lock_sock_fast+0x94/0xe0 net/core/sock.c:3900
 lock_sock_fast include/net/sock.h:1746 [inline]
 tcp_get_info+0x26d/0x2b70 net/ipv4/tcp.c:4250
 inet_sk_diag_fill+0xdb6/0x18c0 net/ipv4/inet_diag.c:330
 sk_diag_fill+0x2e6/0xd50 net/ipv4/tcp_diag.c:284
 tcp_diag_dump+0x1ba6/0x2020 net/ipv4/tcp_diag.c:538
 __inet_diag_dump net/ipv4/inet_diag.c:823 [inline]
 inet_diag_dump_compat+0x274/0x490 net/ipv4/inet_diag.c:927
 netlink_dump+0x711/0xee0 net/netlink/af_netlink.c:2331
 __netlink_dump_start+0x589/0x7b0 net/netlink/af_netlink.c:2446
 netlink_dump_start include/linux/netlink.h:341 [inline]
 inet_diag_rcv_msg_compat+0x214/0x420 net/ipv4/inet_diag.c:962
 sock_diag_rcv_msg+0x4b0/0x5f0 net/core/sock_diag.c:-1
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2713
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
 __sys_sendmsg+0x177/0x240 net/socket.c:2799
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x27a/0x6a0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf700f0ec
Code: 90 85 d2 74 0a 89 ce 81 e6 ff 0f 00 00 89 32 85 c0 74 05 c1 e9 0c 89 08 31 c0 5e 5d c3 90 0f 1f 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 58 b8
RSP: 002b:00000000f67c350c EFLAGS: 00000206 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 0000000080000240
RDX: 0000000004004010 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	83 3d bc f2 fa 18 00 	cmpl   $0x0,0x18faf2bc(%rip)        # 0x18faf2c3
   7:	75 27                	jne    0x30
   9:	90                   	nop
   a:	e8 94 e8 37 03       	call   0x337e8a3
   f:	85 c0                	test   %eax,%eax
  11:	74 1c                	je     0x2f
  13:	83 3d ed 29 d7 0e 00 	cmpl   $0x0,0xed729ed(%rip)        # 0xed72a07
  1a:	75 13                	jne    0x2f
  1c:	48 8d 3d e0 32 da 0e 	lea    0xeda32e0(%rip),%rdi        # 0xeda3303
  23:	48 c7 c6 29 f3 59 8e 	mov    $0xffffffff8e59f329,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	90                   	nop
  30:	31 c9                	xor    %ecx,%ecx
  32:	0f b6 81 c4 00 00 00 	movzbl 0xc4(%rcx),%eax
  39:	84 c0                	test   %al,%al
  3b:	0f                   	.byte 0xf
  3c:	84 76 ff             	test   %dh,-0x1(%rsi)
  3f:	ff                   	.byte 0xff


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
