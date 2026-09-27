Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510D3A1D14
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790499690; cv=none; b=Zii8nb6efk8Q/o+43UmSdTy3qyzP2VP3JsOV6s8H+wo4iyblySdauCGEJP91Qzmd1KfPPnpAUCkVVVWnuZElU3OQUlAl9zdCY8/AHADs8b4JM68hSPZXre/DafbhpxoubmyVidRs/iOvBHNahcZacaf65STD8UXdLQ4lg1PdvcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790499690; c=relaxed/simple;
	bh=9JuhtbENpsjbZXxQ3saypGflidZ0aCxl9sYtCNnQAi0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C4ou6/PvqhSiGyDcc4qf3iQVbDauK8v6J9a5XzWVsa1JatVKs2L914TSE1zrKlukyeV1U6N2zIzhP8rCzZUWZF5TSJlhxij61xV5XM89GEavrd1BVr9iE8FsXSAda0AEENa9Oa0xYCg4DB+PJbGpEy4TMgMpsi1tj00aQglaANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4959c49e054so2405691b6e.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 02:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790499687; x=1791104487;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WQzw/YpLSMoSCiIwI7FbfAM4xPr8HwMrq7VMglE0Y1E=;
        b=0nUbItwMbE3ic0JmOwOsx9dt2wtUH3rEYBk2q0tl/WEpr83ZX0YX/Z5xZ09ORfQKjS
         fFw5xw15yfkhDCa5kbFJC5LgCuAZTWcr5bvXfPhHQ5SC9/L+2ld4MD4eRr1TaySB9ufj
         V9z2fRLB8AT+7N2tvfo1KdElFm4NR2A+GJx4s4pOXHHrd1URiQvxsORc+hCt8UAJUATz
         UpRJ41iSsUsAdMyy9u/qN//RepnQzJOt61VY4pE2M/V8m4pqs/Fe/7xvf4VpS/HG6ByJ
         MhwUdJLCWQzpUIGkdNnqaRk4ve4bp+T6EaRiyrhsTkMRsZJ4ki+M9QHOyXu6LQz+fS69
         LekA==
X-Forwarded-Encrypted: i=1; AKwUvBwFXQhbzFblI++Yz8CGHV7FuY2PX7MoaE34loM6MaRw3PYg8ja2SWE5+4BTKO9PeweVpPXlZ+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++km8cnQCrBGerv1um7QshCauOVdsZo797ncwkAlweXc+iPVUXqJ
	EWpofvpN3zrCWIJ/Ijl2BhtfqJtjywjyNxdnoZWxBO4IAkWVln5hlPtgu0t96ccLReU72Lb+yH7
	TejaqM88Xwzr4plMdF5fkx+rS+FIi+wWDa7bvE24jO1uHX17rIA2GrBP4u1M=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:15a0:b0:4d6:93e2:5bc8 with SMTP id
 5614622812f47-4d72d6603f8mr12738235b6e.68.1790499687338; Sun, 27 Sep 2026
 02:01:27 -0700 (PDT)
Date: Sun, 27 Sep 2026 02:01:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab8db67.dc2998a4.2261f5.0064.GAE@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in advance_sched (2)
From: syzbot <syzbot+e0fa723f5960605c7ddb@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aa98230e410f Merge tag 'vfs-7.3-rc5.fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a3e2c9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=718e346eb0b8f38
dashboard link: https://syzkaller.appspot.com/bug?extid=e0fa723f5960605c7ddb
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d8db131abdba/disk-aa98230e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58014231ef21/vmlinux-aa98230e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/97cab136e4af/bzImage-aa98230e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0fa723f5960605c7ddb@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P29
rcu: 	(detected by 1, t=10592 jiffies, g=56017, q=13328 ncpus=2)
task:ktimers/1       state:R  running task     stack:24168 pid:29    tgid:29    ppid:2      task_flags:0x4208040 flags:0x00080010
Call Trace:
 <IRQ>
 sched_show_task+0x4aa/0x5f0 kernel/sched/core.c:8250
 rcu_print_detail_task_stall_rnp kernel/rcu/tree_stall.h:292 [inline]
 print_other_cpu_stall+0xfbf/0x1350 kernel/rcu/tree_stall.h:683
 check_cpu_stall kernel/rcu/tree_stall.h:860 [inline]
 rcu_pending kernel/rcu/tree.c:3744 [inline]
 rcu_sched_clock_irq+0x9fe/0x10e0 kernel/rcu/tree.c:2749
 update_process_times+0x234/0x2d0 kernel/time/timer.c:2475
 tick_sched_handle kernel/time/tick-sched.c:296 [inline]
 tick_nohz_handler+0x38f/0x6b0 kernel/time/tick-sched.c:317
 __run_hrtimer kernel/time/hrtimer.c:2074 [inline]
 __hrtimer_run_queues+0x3a0/0xaf0 kernel/time/hrtimer.c:2131
 hrtimer_interrupt+0x4c2/0xa80 kernel/time/hrtimer.c:2250
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:lock_is_held_type+0x106/0x150 kernel/locking/lockdep.c:6021
Code: 1b 00 00 b8 ff ff ff ff 65 0f c1 05 c4 bd 4d 07 83 f8 01 75 25 9c 58 a9 00 02 00 00 75 39 41 f7 c4 00 02 00 00 74 01 fb 89 d8 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 4b d1 03 00 cc 90 0f 0b 90 48 c7
RSP: 0018:ffffc90000a3fab8 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000046
RDX: 0000000000000000 RSI: ffffffff8dae029b RDI: ffffffff8bcc4a80
RBP: 00000000ffffffff R08: 0000000000000100 R09: 0000000000000100
R10: dffffc0000000000 R11: fffffbfff1f64530 R12: 0000000000000246
R13: ffff88801d2c3e80 R14: ffff888060f6e400 R15: 0000000000000004
 lock_is_held include/linux/lockdep.h:249 [inline]
 advance_sched+0xea/0xc90 net/sched/sch_taprio.c:933
 __run_hrtimer kernel/time/hrtimer.c:2074 [inline]
 __hrtimer_run_queues+0x3eb/0xaf0 kernel/time/hrtimer.c:2131
 hrtimer_run_softirq+0x1e1/0x2e0 kernel/time/hrtimer.c:2148
 handle_softirqs+0x1da/0x6d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 run_ktimerd+0x6a/0x100 kernel/softirq.c:1174
 smpboot_thread_fn+0x565/0xa70 kernel/smpboot.c:160
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10596 jiffies! g56017 f0x0 RCU_GP_WAIT_FQS(5) ->state=I
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=32843
rcu: rcu_preempt kthread starved for 10597 jiffies! g56017 f0x0 RCU_GP_WAIT_FQS(5) ->state=I ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27784 pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x16d9/0x5700 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_timeout+0x152/0x2c0 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x30c/0x11f0 kernel/rcu/tree.c:2122
 rcu_gp_kthread+0x9e/0x2b0 kernel/rcu/tree.c:2330
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 29 Comm: ktimers/1 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:lock_is_held_type+0x106/0x150 kernel/locking/lockdep.c:6021
Code: 1b 00 00 b8 ff ff ff ff 65 0f c1 05 c4 bd 4d 07 83 f8 01 75 25 9c 58 a9 00 02 00 00 75 39 41 f7 c4 00 02 00 00 74 01 fb 89 d8 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 4b d1 03 00 cc 90 0f 0b 90 48 c7
RSP: 0018:ffffc90000a3fab8 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000046
RDX: 0000000000000000 RSI: ffffffff8dae029b RDI: ffffffff8bcc4a80
RBP: 00000000ffffffff R08: 0000000000000100 R09: 0000000000000100
R10: dffffc0000000000 R11: fffffbfff1f64530 R12: 0000000000000246
R13: ffff88801d2c3e80 R14: ffff888060f6e400 R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff888125cc4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3101f81e80 CR3: 000000000dfb0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_is_held include/linux/lockdep.h:249 [inline]
 advance_sched+0xea/0xc90 net/sched/sch_taprio.c:933
 __run_hrtimer kernel/time/hrtimer.c:2074 [inline]
 __hrtimer_run_queues+0x3eb/0xaf0 kernel/time/hrtimer.c:2131
 hrtimer_run_softirq+0x1e1/0x2e0 kernel/time/hrtimer.c:2148
 handle_softirqs+0x1da/0x6d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 run_ktimerd+0x6a/0x100 kernel/softirq.c:1174
 smpboot_thread_fn+0x565/0xa70 kernel/smpboot.c:160
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
