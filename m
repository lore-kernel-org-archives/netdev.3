Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3C37FF54
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792293226; cv=none; b=ZOpZNY8iqmHWr6FoPzfbNloFarA9ysszRpmBF5Y/9qL2e03872T+WYBo9AOx2+LLr8+Syu+Yl5oW2trXbiAnM6fYXCKIT/rxapQ7E24Yj2+vXHpaCBMsxRrV10bVKb13bQf7+C3HsdQcUEpjSoDlxcM3kEe52O5pNySi5FodoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792293226; c=relaxed/simple;
	bh=A+vfuO7ROmtWXBPzpK7EUmQ9O/cmbMOIA/GzzeWpEtU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TcIwV6EZmvpdqtrvvNxE9M1RcCLdrqGGI1UsjUsu8XaV4nTrrHWbADfcZIuskfXFLKgydW7IjjeSuXCxL5cUdCPEag/1TXUZ4cBl0p54vtjSRBNyIrc3kcG4WXF68Wb+l19OH9N0wMYMmbcb9ZDoHxaAd+RJDnNWUz6Ieu64bOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4a45b3f0bdfso1773698b6e.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 20:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792293222; x=1792898022;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C55urHXM8JlROycY9AfN15KmNEJWdk4MSj4BGdwapNY=;
        b=juxNuUstszea1npgbG56PIg+3856MxGoe58poxTGRyjbcl9MZHUl6O6COWjAWytPln
         /MToICoJw9ZXubau98tD3EWzW7gXNkLWx/5KYrIcYW7gTMXXYUg754AGeAu8T0ZtAtDU
         riGmwbPzT/l4PtSQ07KHgReVrdgwxrkeJTyKKYPVkSCXKVQhJDHSHSOkE+wX237eTZNt
         jM6MvB6Sphcb3z45Yq3XwVH7M7hpHzPNQVDrDPpiuIVwgy34aEt3J21hvDQdTOUwarpH
         ErlrGdz906DsGtSHaS2X7xuLb/YwTA8FLHKpJct/JXq0oli/ISdYudMLEfPQWO1cIeZG
         9bPQ==
X-Forwarded-Encrypted: i=1; AKwUvByojlJvmr196T0fEiexZiNYXEo7mYqise++0xQ1nLmVTVTXan/8Nf8xtJ2RoOJhrE+XEeZ4xCQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLF7QjMl61FgXILrgZRYppM9SBxJx5do46YFTCYIq2xNFmoqOaw
	8GMoTG6py3mA5XCMyWJYpZ3lPxtq/6GHOOUe5APjz/EpcAY4FYdwzTIYtRXeHH7wKaRDyPOlFRT
	9ZgHH5Ta8q4WhvdFW/0Fqin3G+AZqunrPjixchXqKIEFEsdn1ae72aSZY2xQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2224:b0:4f4:fc4e:77e9 with SMTP id
 5614622812f47-53ccf4ebfa1mr4414588b6e.42.1792293222065; Sat, 17 Oct 2026
 20:13:42 -0700 (PDT)
Date: Sat, 17 Oct 2026 20:13:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad43966.a6d1a155.34a93f.006e.GAE@google.com>
Subject: [syzbot] [net?] INFO: trying to register non-static key in dst_destroy
From: syzbot <syzbot+de0b38c748fd9021e85f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7a19f0cc94ad Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=154e0f01580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26d6221a572842ac
dashboard link: https://syzkaller.appspot.com/bug?extid=de0b38c748fd9021e85f
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e49621580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/296cd4b77dbf/disk-7a19f0cc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e57669ed895f/vmlinux-7a19f0cc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c679c1ad76d4/Image-7a19f0cc.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de0b38c748fd9021e85f@syzkaller.appspotmail.com

nvme nvme0: request 0x1a genctr mismatch (got 0xc expected 0x2)
nvme nvme0: invalid id 49178 completed on queue 0
nvme nvme0: request 0x1b genctr mismatch (got 0xc expected 0x2)
nvme nvme0: invalid id 49179 completed on queue 0
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 4383 Comm: kworker/0:3 Tainted: G   M                syzkaller #0 PREEMPT 
Tainted: [M]=MACHINE_CHECK
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
Workqueue: rcu_gp process_srcu
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 assign_lock_key+0xcc/0xdc kernel/locking/lockdep.c:1028
 register_lock_class+0xf8/0x31c kernel/locking/lockdep.c:1343
 __lock_acquire+0x140/0x2b08 kernel/locking/lockdep.c:5162
 lock_acquire+0x13c/0x320 kernel/locking/lockdep.c:5942
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:181
 ref_tracker_free+0x114/0x6b4 lib/ref_tracker.c:310
 netdev_tracker_free include/linux/netdevice.h:4551 [inline]
 netdev_put include/linux/netdevice.h:4568 [inline]
 dst_destroy+0xf4/0x2c0 net/core/dst.c:115
 dst_destroy_rcu+0x20/0x30 net/core/dst.c:133
 rcu_do_batch kernel/rcu/tree.c:2650 [inline]
 rcu_core+0x790/0xfbc kernel/rcu/tree.c:2919
 rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2936
 handle_softirqs+0x324/0xcbc kernel/softirq.c:645
 __do_softirq+0x14/0x20 kernel/softirq.c:679
 ____do_softirq+0x10/0x1c arch/arm64/kernel/irq.c:78
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:901
 do_softirq_own_stack+0x1c/0x28 arch/arm64/kernel/irq.c:83
 invoke_softirq kernel/softirq.c:526 [inline]
 __irq_exit_rcu+0x10c/0x318 kernel/softirq.c:758
 irq_exit_rcu+0x14/0x84 kernel/softirq.c:775
 __el1_irq arch/arm64/kernel/entry-common.c:569 [inline]
 el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:581
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:586
 el1h_64_irq+0x78/0x7c arch/arm64/kernel/entry.S:602
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P)
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline] (P)
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:219 [inline] (P)
 _raw_spin_unlock_irq+0x34/0x80 kernel/locking/spinlock.c:229 (P)
 try_check_zero+0xf8/0x4f0 kernel/rcu/srcutree.c:1132
 srcu_advance_state kernel/rcu/srcutree.c:1845 [inline]
 process_srcu+0x2f8/0x13b8 kernel/rcu/srcutree.c:1954
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3479
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3560
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
list_add corruption. prev is NULL.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:26!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 4383 Comm: kworker/0:3 Tainted: G   M                syzkaller #0 PREEMPT 
Tainted: [M]=MACHINE_CHECK
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
Workqueue: rcu_gp process_srcu
pstate: 634000c5 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __list_add_valid_or_report+0xcc/0x148 lib/list_debug.c:25
lr : __list_add_valid_or_report+0xcc/0x148 lib/list_debug.c:25
sp : ffff80008f7e7b40
x29: ffff80008f7e7b40 x28: 1fffe000191988ed x27: ffff0000c8cc4768
x26: ffff0000c8cc4760 x25: dfff800000000000 x24: ffff700011efcf74
x23: 1fffe0001ac2ca28 x22: 0000000000000000 x21: ffff0000d6165140
x20: 0000000000000000 x19: ffff0000c8cc4700 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 00000000000006b6 x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000000 x10: 0000000000000103 x9 : 10c42bc48b746e00
x8 : 10c42bc48b746e00 x7 : 0000000000000001 x6 : ffff800080483084
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008048db84
x2 : 0000000000000102 x1 : ffff0000c6ecd880 x0 : 0000000000000022
Call trace:
 __list_add_valid_or_report+0xcc/0x148 lib/list_debug.c:25 (P)
 __list_add_valid include/linux/list.h:104 [inline]
 __list_add include/linux/list.h:169 [inline]
 list_add_tail include/linux/list.h:206 [inline]
 list_move_tail include/linux/list.h:357 [inline]
 ref_tracker_free+0x248/0x6b4 lib/ref_tracker.c:329
 dst_des


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
