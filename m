Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCFF4B2CBC
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191733; cv=none; b=HaQfKhunTAA5cg2Xwvs8k3/rSpObcbLyof80xblurY3oDw6WqyCMp6R6/m2HQloaMIFLNrq2YbD7mvHjKmPQSuyETikcH3QDUcaKIj6KuTL4UEQA8EqkbSX1XgPn1huUXmwLlV5QTcc/rdvGmz3Pr7CpPWVR6bPPGvZ+fAFJTsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191733; c=relaxed/simple;
	bh=YMoYifXIUxSg/YmkMfK8wppSoBZnxZwRI6przP5GzAU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SZaZedNL2zKFZfV1wjB3qhkql9Hbbc81o3CGr3t843HTREhzmzdc0dLZOFkbIGHkwA5LnSexpdOjopf3DmVpfALov8iLMeNv4ZfVOu9kuP2I1mLI9hLOZsPiiibOlLsQ6VLeTcGEP43IX0+pQZzBMuZ3LGgBwC6qVR3aw4sfKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-7f66624aa21so216093a34.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191730; x=1788796530;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RM+zyyradddmkrsocPsvjlKDnQJPXI9mbS+TNAkusFw=;
        b=D8Qp64Xs4WKNMGiVxL4IfL9rcN8AToFmGxFvicbNTE2nzUci9IGKhHOOk33jb5abcu
         u1Bnm9Zo1imskDdUc870PNZPgsm3dXzeeZ5JGgOMTUkGiPbZDTf3dOynfSxqaRF/shly
         SSU0UsVPiZmIKGBtxxA23iwXY2QP4jFcILFZYdmGuLle03y6TIEUei/ox6qcDq4ShgMG
         JWx9yl+RBejK3z2A28tEuVwxfz1Z/f2YyLb/Tkf2aV+fAn8As+vSxHrs1qKxnQ35YdjL
         utTtcm9ekiSz6inVIkL/io2mhlHdHEgQ87gSSKATAcTzFbSzyutKxirpXSwwqEF/LON8
         GThg==
X-Forwarded-Encrypted: i=1; AHgh+Ron+97E8KwNOxZ1Kb4uI29Ikn+Mtw0L2jlS5u2RTZ2LtJM+rKKI+txNEOBxdqkWaaSq6ZVnfQw=@vger.kernel.org
X-Gm-Message-State: AFuF++mVhzhvff91h3F4LXkNEZjGXJoxkaWP7BdFVvC6/HA+ZxSXkbLS
	I7tllh4rl8FzAM6yMroB3WoTQIu5qC5o+t+y5VCSAgnjG9to2IPsyVBO9ECxMf1VgW0L4GXT3QK
	EX/o0rAe5c+wD3CPTA3ODHxNR9lRAttUSYD14snNtWK8+VpYObhKsNtz0+G4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:25a:b0:6ae:a950:9faa with SMTP id
 006d021491bc7-6b1c65cb077mr20034099eaf.10.1788191730280; Mon, 31 Aug 2026
 08:55:30 -0700 (PDT)
Date: Mon, 31 Aug 2026 08:55:30 -0700
In-Reply-To: <6a778cfc.9c11d2ce.289b96.00b9.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a95a3f2.99925153.16bd3d.0004.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in
 __hrtimer_run_queues (3)
From: syzbot <syzbot+6d991f16f4bcc8eeea24@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f1b8fa82cab7 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15aee379580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=6d991f16f4bcc8eeea24
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15632d9e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dd1c15580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/932d85a2bda2/disk-f1b8fa82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b6b8fb76e8d/vmlinux-f1b8fa82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c246b61ee396/Image-f1b8fa82.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d991f16f4bcc8eeea24@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [syz-executor:4831]
Modules linked in:
irq event stamp: 38640849
hardirqs last  enabled at (38640848): [<ffff800080557cd8>] seqcount_lockdep_reader_access+0x7c/0xf8 include/linux/seqlock.h:75
hardirqs last disabled at (38640849): [<ffff80008690cd0c>] __el1_irq arch/arm64/kernel/entry-common.c:527 [inline]
hardirqs last disabled at (38640849): [<ffff80008690cd0c>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:543
softirqs last  enabled at (147672): [<ffff80008013891c>] local_bh_enable include/linux/bottom_half.h:33 [inline]
softirqs last  enabled at (147672): [<ffff80008013891c>] put_cpu_fpsimd_context arch/arm64/kernel/fpsimd.c:251 [inline]
softirqs last  enabled at (147672): [<ffff80008013891c>] do_sve_acc+0x32c/0x4b8 arch/arm64/kernel/fpsimd.c:1349
softirqs last disabled at (148217): [<ffff8000800204c0>] __do_softirq+0x14/0x20 kernel/softirq.c:656
CPU: 0 UID: 0 PID: 4831 Comm: syz-executor Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : trace_hrtimer_expire_exit include/trace/events/timer.h:321 [inline]
pc : __run_hrtimer kernel/time/hrtimer.c:2035 [inline]
pc : __hrtimer_run_queues+0x32c/0xbe0 kernel/time/hrtimer.c:2096
lr : arch_static_branch arch/arm64/include/asm/jump_label.h:36 [inline]
lr : trace_hrtimer_expire_exit include/trace/events/timer.h:321 [inline]
lr : __run_hrtimer kernel/time/hrtimer.c:2035 [inline]
lr : __hrtimer_run_queues+0x32c/0xbe0 kernel/time/hrtimer.c:2096
sp : ffff80008eb67de0
x29: ffff80008eb67e40 x28: 1fffe00034bb7c3a x27: ffff0001a5dbe1c0
x26: ffff0000c6453a90 x25: ffff0000d1a50d38 x24: dfff800000000000
x23: 0000000000000001 x22: ffff800084ec6bd4 x21: 1fffe00018c8a752
x20: ffff0000c64545a8 x19: ffff0000c6453a80 x18: 0000000000000000
x17: ffff80011d2d8000 x16: ffff80008eb60000 x15: 0000000000000000
x14: 00000000ffff8000 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000102 x9 : 0000000000000101
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000008 x3 : ffff80008046a634
x2 : 0000000000000001 x1 : ffff0000c6453a80 x0 : 0000000000000000
Call trace:
 arch_static_branch arch/arm64/include/asm/jump_label.h:36 [inline] (P)
 trace_hrtimer_expire_exit include/trace/events/timer.h:321 [inline] (P)
 __run_hrtimer kernel/time/hrtimer.c:2035 [inline] (P)
 __hrtimer_run_queues+0x32c/0xbe0 kernel/time/hrtimer.c:2096 (P)
 hrtimer_run_softirq+0x15c/0x21c kernel/time/hrtimer.c:2113
 handle_softirqs+0x2ec/0xd98 kernel/softirq.c:622
 __do_softirq+0x14/0x20 kernel/softirq.c:656
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:78
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:885
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:83
 invoke_softirq kernel/softirq.c:503 [inline]
 __irq_exit_rcu+0x1ac/0x428 kernel/softirq.c:735
 irq_exit_rcu+0x14/0x84 kernel/softirq.c:752
 __el1_irq arch/arm64/kernel/entry-common.c:531 [inline]
 el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:543
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:548
 el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:586
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:198 (P)
 __debug_check_no_obj_freed lib/debugobjects.c:1180 [inline]
 debug_check_no_obj_freed+0x2c8/0x3a4 lib/debugobjects.c:1201
 slab_free_hook mm/slub.c:2608 [inline]
 slab_free mm/slub.c:6377 [inline]
 kmem_cache_free+0x120/0x6b8 mm/slub.c:6504
 file_free+0x128/0x1dc fs/file_table.c:104
 __fput+0x538/0x74c fs/file_table.c:525
 fput_close_sync+0x10c/0x278 fs/file_table.c:617
 __do_sys_close fs/open.c:1511 [inline]
 __se_sys_close fs/open.c:1496 [inline]
 __arm64_sys_close+0x80/0x110 fs/open.c:1496
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 4802 Comm: kworker/1:3 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
Workqueue: rcu_gp process_srcu
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:179 [inline]
pc : _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:198
lr : __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inline]
lr : _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:198
sp : ffff80008eb77dc0
x29: ffff80008eb77dc0 x28: 1fffe00034bbc63a x27: ffff0001a5de31c0
x26: ffff0001a5de31d0 x25: ffff0000d2a4a538 x24: dfff800000000000
x23: 0000000000000001 x22: ffff800084ec6bd4 x21: ffff0001a5de2d80
x20: ffff0001a5de2d80 x19: 0000000000000000 x18: 00000000ffffffff
x17: ffff80008a7d6000 x16: 0000000000000002 x15: ffff80008a35fda0
x14: ffff80008a5d5e28 x13: 0000000000000001 x12: 0000000000000000
x11: ffff80008a5d5e28 x10: 0000000000000003 x9 : 0000000000000000
x8 : 00000000000000c0 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000008 x3 : ffff80008015611c
x2 : 0000000000000002 x1 : ffff0000d32c9d40 x0 : ffff80011d2fd000
Call trace:
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:198 (P)
 __run_hrtimer kernel/time/hrtimer.c:2028 [inline]
 __hrtimer_run_queues+0x22c/0xbe0 kernel/time/hrtimer.c:2096
 hrtimer_run_softirq+0x15c/0x21c kernel/time/hrtimer.c:2113
 handle_softirqs+0x2ec/0xd98 kernel/softirq.c:622
 __do_softirq+0x14/0x20 kernel/softirq.c:656
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:78
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:885
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:83
 invoke_softirq kernel/softirq.c:503 [inline]
 __irq_exit_rcu+0x1ac/0x428 kernel/softirq.c:735
 irq_exit_rcu+0x14/0x84 kernel/softirq.c:752
 __el1_irq arch/arm64/kernel/entry-common.c:531 [inline]
 el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:543
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:548
 el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:586
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 queue_delayed_work_on+0xf4/0x140 kernel/workqueue.c:2624 (P)
 queue_delayed_work include/linux/workqueue.h:714 [inline]
 srcu_reschedule+0x240/0x338 kernel/rcu/srcutree.c:1957
 process_srcu+0xd04/0x1eb8 kernel/rcu/srcutree.c:1991
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x788/0x10b8 kernel/workqueue.c:3405
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3486
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/1:3:4802]
Modules linked in:
irq event stamp: 44430735
hardirqs last  enabled at (44430734): [<ffff800086932074>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inline]
hardirqs last  enabled at (44430734): [<ffff800086932074>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:198
hardirqs last disabled at (44430735): [<ffff80008690cd0c>] __el1_irq arch/arm64/kernel/entry-common.c:527 [inline]
hardirqs last disabled at (44430735): [<ffff80008690cd0c>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:543
softirqs last  enabled at (6136): [<ffff80008030e6e4>] softirq_handle_end kernel/softirq.c:468 [inline]
softirqs last  enabled at (6136): [<ffff80008030e6e4>] handle_softirqs+0xc28/0xd98 kernel/softirq.c:650
softirqs last disabled at (7461): [<ffff8000800204c0>] __do_softirq+0x14/0x20 kernel/softirq.c:656


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
