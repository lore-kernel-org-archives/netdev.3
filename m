Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE53377ABF
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481774; cv=none; b=K6GCiReyxhFWnYAYZQ1xJr4xMKXaglzD8ocGxWiu4inOEQRsVQP0+a16oLhygeDg2E59uHBkUKIhbCu8K8DD287D68CHH3c1E2fVaU7F0L1HAlr6GTg/wyq1QAyjSH14RFyJ39z0Rie0KqCMLWhgkokqyPmBt95minpM2B0zyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481774; c=relaxed/simple;
	bh=RHs3HORM3qAl8cRMM+EfnzR+WOLDDL+yaQZzKpTV+sI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HazvWWIPzYWmc6vRJoWK0sa0qIBm/wmmdkppXDUHKolnP6YNb+t2pofZ7mDb8X3nnSwLOmN584wNsoAzEIsiWj+zrG4hQXoBHcBKfukdEN48HmnLL+bFohvtm9FMaBAPe9ngM58de/H6ml0/cLubzPHrj/duB5SyHxvRN/FYV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4a5a66f375dso454752b6e.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481768; x=1786086568;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AqWYDbp5+iiLmNvHbFTjk0chA2oTgkuvBGPFunscKgU=;
        b=NvYp9vPcHKeQiVmZSMtHL5BR11YcpHI53ASHPVXIiqulM+zJvZ0+tFiKnWZBf/urXT
         DuiOzd7VP7SU4yvE+wMKkV8Vo3qdlaLebdkEfBg/MPYa4Gi0eGVPX2jPm5pgzVfTkcuc
         qTxT3u6mt2DARHAFkx/LI02luXfl+Om6oIcxKwN5TV408m77ZisrBDE6RHwdSoqFrjXL
         MGDldoAt1atYgAkjEr9xJfY7TkrCP/rMMrlbxjMaUXTiU1bl9BuZ5DfROk6VBHdIaP7t
         euupTmco5HWhDOyWfN7hmmYcQ5rKVylTbR75gmXWuD/UEJ0m9d2GI+Flp4R+3TRnDnbt
         0Frw==
X-Forwarded-Encrypted: i=1; AHgh+Rrhl1XlQ4VbWhVhec3e4hjG81WZKdF2WiC/Lweld3Af4OWauBs/Mii2dA3tde4QhpVA2D9Hs/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkYg+yxHZBvqq9TaKCgPU66DyMEMtl6C1lQUlTuPMy0U6g+U/7
	ic3O9fuIuAT/oHVA9tUqIfaJgiLx+PcCl0spcuLzGo0FWdRr7h3CFHl8IjCLYO86dvKT78GPLQP
	jRP6jJZVvRd1oyQyi3+wB+UdzhXddJ3j7ojkpU2Gm9EQS/UWLNQivf/MqJSo=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a21:b0:4a4:a693:9d87 with SMTP id
 5614622812f47-4ae4c4318a1mr652275b6e.5.1785481768459; Fri, 31 Jul 2026
 00:09:28 -0700 (PDT)
Date: Fri, 31 Jul 2026 00:09:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6c4a28.77639fcc.3d4fd0.0020.GAE@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in xfrm_do_migrate_state
From: syzbot <syzbot+d3bc2f2eb498a0175940@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4235cb24ec1e Merge tag 'vfs-7.2-rc5.fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1293a7b1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=d3bc2f2eb498a0175940
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a4c49e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1475bfde580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bfb2ad7db60c/disk-4235cb24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfd0a5b6c4bb/vmlinux-4235cb24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/44b46af35859/bzImage-4235cb24.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3bc2f2eb498a0175940@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
net/xfrm/xfrm_user.c:1630 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz.0.17/5833:
 #0: ffff888032dcc390 (&net->xfrm.xfrm_cfg_mutex){+.+.}-{4:4}, at: xfrm_netlink_rcv+0x62/0x90 net/xfrm/xfrm_user.c:3928

stack backtrace:
CPU: 1 UID: 0 PID: 5833 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 lockdep_rcu_suspicious.cold+0x4f/0xb1 kernel/locking/lockdep.c:6876
 xfrm_nlmsg_multicast net/xfrm/xfrm_user.c:1630 [inline]
 xfrm_send_migrate_state net/xfrm/xfrm_user.c:3340 [inline]
 xfrm_do_migrate_state+0x2463/0x2f10 net/xfrm/xfrm_user.c:3507
 xfrm_user_rcv_msg+0x483/0xd80 net/xfrm/xfrm_user.c:3907
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2556
 xfrm_netlink_rcv+0x71/0x90 net/xfrm/xfrm_user.c:3929
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0xa4d/0xbe0 net/socket.c:2684
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2738
 __sys_sendmsg+0x160/0x210 net/socket.c:2770
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9a1659de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe88741d08 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f9a16825fa0 RCX: 00007f9a1659de99
RDX: 0000000000000000 RSI: 0000200000000500 RDI: 0000000000000003
RBP: 00007f9a16633eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9a16825fac R14: 00007f9a16825fa0 R15: 00007f9a16825fa0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
