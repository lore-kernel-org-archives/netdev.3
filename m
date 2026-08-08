Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B463B14B6
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219775; cv=none; b=FE8mGXZRdxmVZlg3ftEcwE8SKJ3mL5k4kTEilSOYo7bknYMWFair4E1nhAxTvgK970ilTbHUzFML2a4hElzBYAgrMfFOTNFIk/bs9Y94JOgR3TDLAxSNtQbBegTaa0HFvqIqrZPZeUfKKwDZ7hcevyhmH/T1mO9NIegOJE3eAKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219775; c=relaxed/simple;
	bh=PYt4xCVlFl59iS3uuZeYLedZTaS+/Qg/3JwzKWo/MjI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tWqUuBCCspC1f9XdY3uLmxMYFzpQ+j5kUf0oC0yXW9mSLWfO+pZypHRC7rQ1mFSdo0NrqTO7iAPc3Q3VqHKF+wHhyLdWKyjBS2YtLikqUqVjYPnigkcfWymvM9KV4M7Hx4vhGeOFjypEVEnr2EaP6v+W2fUoaQ32oxpPNZLPnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-49d4cb3ca23so872236b6e.3
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 13:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786219772; x=1786824572;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AD8SNSLTNhXw/PFXT2Es++CE18KkugQ1VzBw9PX6QnM=;
        b=mtRgWdRthLDC0byh/Ol+lpf0gByIqop2Z8J19Od1al1UMqvgpnx93hqKdr2e/Fll7d
         o/Jp6KPE0W2R6s8/6v/iICyVAdzwcUnaPlH4+UEcmMHEx2eAVzvFdvJCmzcDwBCQD2c7
         zLmZ7N3v3dh/VQydSShKArm1p6V9IF0Wrgo0r8ktPGW7bp6byuJcTult8uPlihCW7b+M
         XzjwG1yFzpwrt6jfkNA7l1fzYlXMj/1O358EsZPhbDE3xJImSizipOU3jX+4ylEf0k1Y
         NRnmzoDaNKrRIErZp9z/pPWW3Vqo+HOto9WhkDNclK04KwfICdBrdaXhqx+wee7pSAy2
         AE5g==
X-Forwarded-Encrypted: i=1; AHgh+RpCEbq1H7nBYD0lJTx9ZnGq3HiyhUjY9ukVrgaKyeVoojuerq7IG9n0s0fMG4RG9y+V70ipR0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YydOplcRJFn9KEnQoDUDtu4HFutoiL0sZIzb0tUbyuXdiiYbvRX
	qJ5FBuIfWe/aFNBXU1e4DE9vsB8yiy+kl8L6dv5tHqTzhKkk+gQwPswZzaKEUxXE1o0vvpYUlc3
	81+xdMQUtc+OZeIkfQtt0+AEltQj87d78207aAXGjo/WSC7mC9dqNYE+W9X0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c40a:b0:495:e1b6:2c5 with SMTP id
 5614622812f47-4afadd36ea4mr16701675b6e.1.1786219772206; Sat, 08 Aug 2026
 13:09:32 -0700 (PDT)
Date: Sat, 08 Aug 2026 13:09:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a778cfc.9c11d2ce.289b96.00b9.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in __hrtimer_run_queues (3)
From: syzbot <syzbot+6d991f16f4bcc8eeea24@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    594d90519502 af_unix: Unlink scc_entry in unix_del_edge().
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13d4c132580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e8a402093abe6b2
dashboard link: https://syzkaller.appspot.com/bug?extid=6d991f16f4bcc8eeea24
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d4c132580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/672b53d154af/disk-594d9051.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f5c69520cde/vmlinux-594d9051.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5f0629640136/bzImage-594d9051.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d991f16f4bcc8eeea24@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5762
rcu: 	(detected by 0, t=10502 jiffies, g=15917, q=4592 ncpus=2)
task:syz-executor    state:R  running task     stack:22408 pid:5762  tgid:5762  ppid:1      task_flags:0x400140 flags:0x00080012
Call Trace:
 <IRQ>
 sched_show_task+0x4aa/0x5f0 kernel/sched/core.c:8184
 rcu_print_detail_task_stall_rnp kernel/rcu/tree_stall.h:292 [inline]
 print_other_cpu_stall+0xf7d/0x1310 kernel/rcu/tree_stall.h:680
 check_cpu_stall kernel/rcu/tree_stall.h:855 [inline]
 rcu_pending kernel/rcu/tree.c:3708 [inline]
 rcu_sched_clock_irq+0x93d/0x1050 kernel/rcu/tree.c:2744
 update_process_times+0x23b/0x2f0 kernel/time/timer.c:2475
 tick_sched_handle kernel/time/tick-sched.c:296 [inline]
 tick_nohz_handler+0x38f/0x6b0 kernel/time/tick-sched.c:317
 __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
 __hrtimer_run_queues+0x371/0xa10 kernel/time/hrtimer.c:2096
 hrtimer_interrupt+0x448/0x910 kernel/time/hrtimer.c:2215
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:179 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x47/0x80 kernel/locking/spinlock.c:198
Code: f7 e8 2d 7d d0 f5 f7 c3 00 02 00 00 74 05 e8 00 5e fc f5 9c 58 a9 00 02 00 00 75 27 f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> c4 90 c1 f5 65 8b 05 bd a0 99 07 85 c0 74 18 5b 41 5e c3 cc cc
RSP: 0018:ffffc90000007e08 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000246 RCX: 0000000000000102
RDX: 0000000000000000 RSI: ffffffff8e227e64 RDI: 0000000000000001
RBP: ffff88807b4d0938 R08: ffffffff90573637 R09: 1ffffffff20ae6c6
R10: dffffc0000000000 R11: fffffbfff20ae6c7 R12: ffff8880b86281c0
R13: ffffffff89cd5bf0 R14: ffff8880b86281c0 R15: 1ffff110170c50c2
 __run_hrtimer kernel/time/hrtimer.c:2028 [inline]
 __hrtimer_run_queues+0x2bf/0xa10 kernel/time/hrtimer.c:2096
 hrtimer_run_softirq+0x17a/0x240 kernel/time/hrtimer.c:2113
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:finish_task_switch+0x417/0xc60 kernel/sched/core.c:5361
Code: 04 00 00 41 c7 84 24 20 0e 00 00 00 00 00 00 0f 1f 44 00 00 49 83 c4 48 4c 89 e7 e8 53 4c 3d 0a e8 de aa 39 00 fb 4c 8b 65 c8 <49> 8d bc 24 f8 16 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: 0018:ffffc900031ef320 EFLAGS: 00000206
RAX: 0000000000018aa5 RBX: ffff8880b863bf20 RCX: 0000000080000001
RDX: 0000000000000000 RSI: ffffffff8e227e64 RDI: ffffffff8c4bba80
RBP: ffffc900031ef370 R08: ffffffff90573637 R09: 1ffffffff20ae6c6
R10: dffffc0000000000 R11: fffffbfff20ae6c7 R12: ffff888029f49f00
R13: ffff8880b863bee8 R14: dffffc0000000000 R15: 1ffff110170c77e4
 context_switch kernel/sched/core.c:5513 [inline]
 __schedule+0x17e1/0x56c0 kernel/sched/core.c:7234
 preempt_schedule_irq+0x4d/0xa0 kernel/sched/core.c:7556
 irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:539 [inline]
 irqentry_exit+0x14f/0x8f0 kernel/entry/common.c:167
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:lock_acquire+0x221/0x350 kernel/locking/lockdep.c:5872
Code: ff ff ff e8 51 6d 2d 0a f7 44 24 08 00 02 00 00 0f 84 3a ff ff ff 65 48 8b 05 db c7 c9 11 48 3b 44 24 58 75 33 fb 48 83 c4 60 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 80 6f 30 0a cc 48 8d 3d c8 0c b8
RSP: 0018:ffffc900031ef6a0 EFLAGS: 00000286
RAX: fa5918e404740300 RBX: 0000000000000000 RCX: 0000000000000046
RDX: 000000005a44979c RSI: ffffffff8e4acd09 RDI: ffffffff8c4bba80
RBP: ffffffff8177827f R08: ffffffff8177827f R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8eb59c60 R12: 0000000000000002
R13: ffffffff8eb59c60 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 rcu_read_lock include/linux/rcupdate.h:840 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1183 [inline]
 unwind_next_frame+0xac/0x2550 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3159 [inline]
 call_rcu+0xee/0x8b0 kernel/rcu/tree.c:3279
 __destroy_inode+0x2a1/0x630 fs/inode.c:362
 destroy_inode fs/inode.c:385 [inline]
 evict+0x8d4/0xb50 fs/inode.c:849
 dentry_kill+0x1b9/0x880 fs/dcache.c:826
 finish_dput+0x1a/0x260 fs/dcache.c:1001
 __fput+0x675/0xa50 fs/file_table.c:520
 fput_close_sync+0x11f/0x240 fs/file_table.c:617
 __do_sys_close fs/open.c:1511 [inline]
 __se_sys_close fs/open.c:1496 [inline]
 __x64_sys_close+0x7e/0x110 fs/open.c:1496
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6c4799d247
Code: 44 00 00 48 83 ec 10 48 63 ff 45 31 c9 45 31 c0 6a 01 31 c9 e8 3a c0 fb ff 48 83 c4 18 c3 0f 1f 44 00 00 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffdab7221d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f6c4799d247
RDX: 0000000000000000 RSI: 0000000000008933 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000fffffff9
R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffdab722260
R13: 00007ffdab722350 R14: 00007f6c48754620 R15: 00007ffdab722350
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10546 jiffies! g15917 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=3578
rcu: rcu_preempt kthread starved for 10577 jiffies! g15917 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27752 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 schedule_timeout+0x152/0x2c0 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x30c/0x11f0 kernel/rcu/tree.c:2123
 rcu_gp_kthread+0x9e/0x2b0 kernel/rcu/tree.c:2325
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 5762 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:179 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x47/0x80 kernel/locking/spinlock.c:198
Code: f7 e8 2d 7d d0 f5 f7 c3 00 02 00 00 74 05 e8 00 5e fc f5 9c 58 a9 00 02 00 00 75 27 f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> c4 90 c1 f5 65 8b 05 bd a0 99 07 85 c0 74 18 5b 41 5e c3 cc cc
RSP: 0018:ffffc90000007e08 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000246 RCX: 0000000000000102
RDX: 0000000000000000 RSI: ffffffff8e227e64 RDI: 0000000000000001
RBP: ffff88807b4d0938 R08: ffffffff90573637 R09: 1ffffffff20ae6c6
R10: dffffc0000000000 R11: fffffbfff20ae6c7 R12: ffff8880b86281c0
R13: ffffffff89cd5bf0 R14: ffff8880b86281c0 R15: 1ffff110170c50c2
FS:  000055555c50f500(0000) GS:ffff888124f58000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cf03528bd0 CR3: 000000007fb92000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:2028 [inline]
 __hrtimer_run_queues+0x2bf/0xa10 kernel/time/hrtimer.c:2096
 hrtimer_run_softirq+0x17a/0x240 kernel/time/hrtimer.c:2113
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:finish_task_switch+0x417/0xc60 kernel/sched/core.c:5361
Code: 04 00 00 41 c7 84 24 20 0e 00 00 00 00 00 00 0f 1f 44 00 00 49 83 c4 48 4c 89 e7 e8 53 4c 3d 0a e8 de aa 39 00 fb 4c 8b 65 c8 <49> 8d bc 24 f8 16 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: 0018:ffffc900031ef320 EFLAGS: 00000206
RAX: 0000000000018aa5 RBX: ffff8880b863bf20 RCX: 0000000080000001
RDX: 0000000000000000 RSI: ffffffff8e227e64 RDI: ffffffff8c4bba80
RBP: ffffc900031ef370 R08: ffffffff90573637 R09: 1ffffffff20ae6c6
R10: dffffc0000000000 R11: fffffbfff20ae6c7 R12: ffff888029f49f00
R13: ffff8880b863bee8 R14: dffffc0000000000 R15: 1ffff110170c77e4
 context_switch kernel/sched/core.c:5513 [inline]
 __schedule+0x17e1/0x56c0 kernel/sched/core.c:7234
 preempt_schedule_irq+0x4d/0xa0 kernel/sched/core.c:7556
 irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:539 [inline]
 irqentry_exit+0x14f/0x8f0 kernel/entry/common.c:167
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:lock_acquire+0x221/0x350 kernel/locking/lockdep.c:5872
Code: ff ff ff e8 51 6d 2d 0a f7 44 24 08 00 02 00 00 0f 84 3a ff ff ff 65 48 8b 05 db c7 c9 11 48 3b 44 24 58 75 33 fb 48 83 c4 60 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 80 6f 30 0a cc 48 8d 3d c8 0c b8
RSP: 0018:ffffc900031ef6a0 EFLAGS: 00000286
RAX: fa5918e404740300 RBX: 0000000000000000 RCX: 0000000000000046
RDX: 000000005a44979c RSI: ffffffff8e4acd09 RDI: ffffffff8c4bba80
RBP: ffffffff8177827f R08: ffffffff8177827f R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8eb59c60 R12: 0000000000000002
R13: ffffffff8eb59c60 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 rcu_read_lock include/linux/rcupdate.h:840 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1183 [inline]
 unwind_next_frame+0xac/0x2550 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3159 [inline]
 call_rcu+0xee/0x8b0 kernel/rcu/tree.c:3279
 __destroy_inode+0x2a1/0x630 fs/inode.c:362
 destroy_inode fs/inode.c:385 [inline]
 evict+0x8d4/0xb50 fs/inode.c:849
 dentry_kill+0x1b9/0x880 fs/dcache.c:826
 finish_dput+0x1a/0x260 fs/dcache.c:1001
 __fput+0x675/0xa50 fs/file_table.c:520
 fput_close_sync+0x11f/0x240 fs/file_table.c:617
 __do_sys_close fs/open.c:1511 [inline]
 __se_sys_close fs/open.c:1496 [inline]
 __x64_sys_close+0x7e/0x110 fs/open.c:1496
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6c4799d247
Code: 44 00 00 48 83 ec 10 48 63 ff 45 31 c9 45 31 c0 6a 01 31 c9 e8 3a c0 fb ff 48 83 c4 18 c3 0f 1f 44 00 00 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffdab7221d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f6c4799d247
RDX: 0000000000000000 RSI: 0000000000008933 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000fffffff9
R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffdab722260
R13: 00007ffdab722350 R14: 00007f6c48754620 R15: 00007ffdab722350
 </TASK>
sched: DL replenish lagged too much


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
