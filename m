Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A213E00AA
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421181; cv=none; b=dT/xiaDiKARGiMIHphupOXLMJt+WcuHWWZUeG9Hm/duX4DlMh+Z+jfrcvIVoefvm3o2RzSKzjjjHQfRosjhAqZ/nVXO2nkQ5HLnZ7wCZ7HyK/SUbgnhO8uHetEVo/TT25MLA6bp7cDdzC4BVsQ3XsjrQ0uWr8FZIwFDqG0Ns+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421181; c=relaxed/simple;
	bh=k4LOqtUosmr6ZyknwbppLFe4OcI5ltMy4YYox8qoGag=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J2NiEXw+M40hkL8w2ZiRpVKDJcnbNsCr8bNcerzMME4q8qUhpffRYXSPP3qzqOWycRdr5QsdF2+/uPCDqjGgXOkyTsY5veCg9fXzsP572vFHa9+2WuYCFwI6HikJsJY1vJOjjquuaGfx0qZqF5JeffV7eTC77vYjtwtf9c/ZLl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f4.google.com with SMTP id 46e09a7af769-7f4e9ec63a7so363297a34.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788421178; x=1789025978;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkbPX+/Gt8vrXhrXwYE9Oil0+rxtEjRaW6SUbOfN9XQ=;
        b=b6bUPBl3JPrriDEh8I/Cq/sMl+STtctNNpVlPdKTpUK1mPiFjnamTC0uDt47G8f5WP
         BMP8hMpTFDngdaz3WqVXrIDphl52WA+8qj6UoPQ2y+NakD4Gi9B43WnIlLfOoUpN746d
         Pz6Wn5b4Rjk/rguAa43TAnaBcAhuh+/pVFqKmot39TYRifbjOyjJlAXlFwHd/LkaFvEB
         zF+RKqxG1bvHgVmHMtLXfGEfwzaVmsMUN0jqmfQYKGQJGtbr+AJ1eKFyXNWJng9+ggsX
         rWJl9ISoRSx3jMMrYyyunAg7wdKLAr/yqwiAgpKj9rc2gXSNdNLJsdOAqMX4JDLaAb9W
         dQsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhB8A35oa2ysi0Bhvn6fjaspykokltAGu0VCxSaufe5DXLlc6Vfi7L3pRj1+Wf4ArwTNZT924=@vger.kernel.org
X-Gm-Message-State: AFuF++kUUxs+xUsZcaLcJjTZwIdsbhKVbjH8y82UwUhV1tBDZOifRRqG
	Stet+w5COJS2h1s3rp2swKGsEQnvXun58R2xwA3Qb/yOzaMkkGL8ZE/GALFJvOc0Wh2JLMgNdiT
	e8joxLJlhs7UxH6zqjCyrgrfE1ZrZVI64riJB949puEWm68uXIzlE5en5dvc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:619:b0:6ae:9815:7c8e with SMTP id
 006d021491bc7-6b48102eaa1mr7838702eaf.21.1788421178408; Thu, 03 Sep 2026
 00:39:38 -0700 (PDT)
Date: Thu, 03 Sep 2026 00:39:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a99243a.2e567484.299ffc.0008.GAE@google.com>
Subject: [syzbot] [kernfs?] INFO: rcu detected stall in kernfs_fop_release (3)
From: syzbot <syzbot+087d9dac1f398074ca9f@syzkaller.appspotmail.com>
To: driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1b78070aaef6 Merge tag 'net-7.3-rc1' of git://git.kernel.o..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=107d7d79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=087d9dac1f398074ca9f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dc2379580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1286ac15580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18856a03a9a3/disk-1b78070a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc2bc68d7ef4/vmlinux-1b78070a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/05a5e00f8f91/bzImage-1b78070a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+087d9dac1f398074ca9f@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=c15c/1/0x4000000000000000 softirq=16029/16030 fqs=6
rcu: 	(detected by 1, t=10504 jiffies, g=15973, q=1121 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5842 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:should_restart_cycle net/sched/sch_taprio.c:-1 [inline]
RIP: 0010:advance_sched+0x2fe/0xc80 net/sched/sch_taprio.c:955
Code: 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 4c 89 ff e8 3e fc 4b f8 4d 8b 3f 4d 39 e7 0f 84 a7 00 00 00 <48> 8b 04 24 48 8d 98 28 01 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00
RSP: 0018:ffffc90000007cf8 EFLAGS: 00000006
RAX: 1ffff1100639ac28 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000001000001 RSI: 0000000000000000 RDI: 0000001db0a1a72b
RBP: 0000000000000000 R08: 0000000001000001 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000000f90 R12: ffff888031cd6910
R13: 0000000000000001 R14: 0000001db0a1a72b R15: ffff888076d4bd40
FS:  00007ff72c957880(0000) GS:ffff888124ce0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe39b15f44 CR3: 0000000075580000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:2067 [inline]
 __hrtimer_run_queues+0x3bc/0xa10 kernel/time/hrtimer.c:2124
 hrtimer_interrupt+0x4cd/0xaa0 kernel/time/hrtimer.c:2243
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:on_stack arch/x86/include/asm/stacktrace.h:58 [inline]
RIP: 0010:stack_access_ok arch/x86/kernel/unwind_orc.c:409 [inline]
RIP: 0010:deref_stack_reg arch/x86/kernel/unwind_orc.c:419 [inline]
RIP: 0010:unwind_next_frame+0xb86/0x2550 arch/x86/kernel/unwind_orc.c:614
Code: fc ff df 41 80 3c 04 00 74 09 e8 a5 7f bf 00 4c 8b 04 24 49 8d 50 f8 4d 8b 6e 10 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 10 <0f> b6 04 01 84 c0 0f 85 3b 14 00 00 41 83 3e 00 0f 95 c0 49 39 d7
RSP: 0018:ffffc90003cff8a0 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 1ffff9200079ff2a RCX: 1ffff9200079ff29
RDX: ffffc90003cffcb0 RSI: 0000000000000002 RDI: ffffc90003cff958
RBP: 1ffffffff22401c0 R08: ffffc90003cffcb8 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8ed5c6e0 R12: 1ffff9200079ff2b
R13: ffffc90003d00000 R14: ffffc90003cff948 R15: ffffc90003cf8000
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kmem_cache_free+0x182/0x650 mm/slub.c:6626
 seq_release+0x63/0x70 fs/seq_file.c:357
 kernfs_fop_release+0x2f8/0x440 fs/kernfs/file.c:777
 __fput+0x418/0xa50 fs/file_table.c:512
 fput_close_sync+0x11f/0x240 fs/file_table.c:617
 __do_sys_close fs/open.c:1560 [inline]
 __se_sys_close fs/open.c:1545 [inline]
 __x64_sys_close+0x7e/0x110 fs/open.c:1545
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff72ca51a67
Code: 44 00 00 48 83 ec 10 48 63 ff 45 31 c9 45 31 c0 6a 01 31 c9 e8 ca 19 f9 ff 48 83 c4 18 c3 0f 1f 44 00 00 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 61 b3 0d 00 f7 d8 64 89 02 b8
RSP: 002b:00007ffe39b145d8 EFLAGS: 00000297 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000557f662c60d0 RCX: 00007ff72ca51a67
RDX: 00007ff72cb2bea0 RSI: 0000557f662dc3e0 RDI: 0000000000000008
RBP: 00007ff72cb2bff0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000000
R13: 3d45505954564544 R14: 3d5845444e494649 R15: 3d454d414e564544
 </TASK>
rcu: rcu_preempt kthread starved for 10474 jiffies! g15973 f0x0 RCU_GP_WAIT_FQS(5) ->state=R ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27496 pid:17    tgid:17    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17d4/0x5820 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_timeout+0x152/0x2c0 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x30c/0x11f0 kernel/rcu/tree.c:2122
 rcu_gp_kthread+0x9e/0x2b0 kernel/rcu/tree.c:2330
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 4986 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:csd_lock_wait kernel/smp.c:363 [inline]
RIP: 0010:csd_lock kernel/smp.c:396 [inline]
RIP: 0010:smp_call_function_many_cond+0x628/0x1500 kernel/smp.c:944
Code: 00 44 8b 3b 44 89 fe 83 e6 01 31 ff e8 51 51 0c 00 41 83 e7 01 75 07 e8 46 4c 0c 00 eb 3f f3 90 48 b8 00 00 00 00 00 fc ff df <41> 0f b6 04 04 84 c0 75 0f f7 03 01 00 00 00 74 1d e8 22 4c 0c 00
RSP: 0018:ffffc90002e0f420 EFLAGS: 00000293
RAX: dffffc0000000000 RBX: ffff8880b8643708 RCX: ffff88807e928000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002e0f570 R08: ffff88807e92959f R09: 1ffff1100fd252b3
R10: dffffc0000000000 R11: 0000000000000000 R12: 1ffff110170c86e1
R13: 0000000000000000 R14: ffff8880b8643700 R15: 0000000000000001
FS:  00007ff72c957880(0000) GS:ffff888124de0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe39b19040 CR3: 000000007eae6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:46 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
 flush_tlb_mm_range+0x8ff/0x1090 arch/x86/mm/tlb.c:1435
 dup_mmap+0x1758/0x1dc0 mm/mmap.c:1884
 dup_mm kernel/fork.c:1543 [inline]
 copy_mm+0x11a/0x480 kernel/fork.c:1595
 copy_process+0x1e75/0x43e0 kernel/fork.c:2307
 kernel_clone+0x2d7/0x940 kernel/fork.c:2766
 __do_sys_clone kernel/fork.c:2908 [inline]
 __se_sys_clone kernel/fork.c:2892 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2892
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff72ca2d636
Code: 89 df e8 6d e8 f6 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 52 89 c5 85 c0 75 31 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffe39b18a50 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffe39b18a58 RCX: 00007ff72ca2d636
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000557f662a4910 R08: 0000000000000000 R09: 0000557f662ac8e0
R10: 00007ff72c957b50 R11: 0000000000000246 R12: 00007ffe39b18e10
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
