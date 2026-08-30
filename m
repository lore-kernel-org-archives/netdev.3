Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC4523D7FF
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788049831; cv=none; b=BvirDiOCajBVoEdRtEVHCJtKVK4y542Tg0G79YJAj2ruuIdg4dyWTAgEB5fbfgUS75jCwv7s90ubxOi35sI6M1DDEPmUY6rvu40aFr4jnXuKGI00FXxX/Xf2nlxHx2GdF8PiegzfHjPOmO9i70ORbqFh8uhheg5EHwrUCHU/lZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788049831; c=relaxed/simple;
	bh=HLVWaMVldZGCM1CNOfEHLO61y+UvHI0bHYIPOoaiHwg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K9S4SJDEyYR16iKgr0BiRQBp/ZSMWRuDXdJ3YVhEyQi8l+8kv4Fm/yh+i21UdDK8AFG6ymPxImWuZRQCYOnL4oGobD7F8Qb49rltr1Iirh39vr7Afv1C4YXwQFuGXD0O5ymsyNY7yszGd6u9iAdcs/W7mYUXsxU6zmSvqfvvuV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4b3b05aa29dso2222945b6e.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 17:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788049829; x=1788654629;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GkWDQBE726VxWf1LI026GoG6+i9KDMEuoSzzOrab5TA=;
        b=Z7TpH+2/F704leyu8ln2z4IKCf2u3w3/P8R0nyKUKYJTh+tS4nNoYFeiy4LKsIOhUd
         SNpboKISxC4x2CxdhMMF0wwyvnKVaHYRbcrNOGb2Jk92QMGY/xhM8Pd7jeVoKzHaRiEG
         wxQvW0U8v7LYuc6PQ0XDj1Y56ddatxvuEPvKGiFMC3xv9yuCKHnenc8Q5J9Atdd1MKhi
         uIiUd+e3pM8j4tvKu1tbD3w133Mkz4S0hNDTHHu6yWNtEVyzbumOHO4xqhPpMw3q5Dv7
         e4N3rvw9oVGuI/tYI4AHfh6339b8IEaXhaSYnERFUDekQB2j8eF/8DnG0obAxbH2Emft
         apxw==
X-Forwarded-Encrypted: i=1; AHgh+RoxsqdC520IjmUruitKqxB0oSNBXts6YcMdLrz1PYov1N9TH3hvwnuzIVMN/arasLjnoQamCPI=@vger.kernel.org
X-Gm-Message-State: AFuF++l/Mihvl8X49vPW8seRsBIYr/dQpWeWOkGE1blMXC7ZWmRHM3qu
	7vb+LdLZGFV1TYotCZgA8wo6W17SwvTy2ZErTYlWb4paZQxsGSO2Jbry9B0urQBx1YGty4K4/nK
	VNRv5gqTtFd25Q4ezPFc8ek3oqf4IeF1Z/AffxYX8/r7Wvgjw1xdFUJ3Jlq8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14c4:b0:4b3:18d2:5fa0 with SMTP id
 5614622812f47-4b37ca840ddmr22776221b6e.14.1788049829067; Sat, 29 Aug 2026
 17:30:29 -0700 (PDT)
Date: Sat, 29 Aug 2026 17:30:29 -0700
In-Reply-To: <695e9bb5.050a0220.1c677c.0372.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9379a5.1d9ded08.62e62.0114.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in kernfs_fop_write_iter (3)
From: syzbot <syzbot+10b515098afdcfc455c7@syzkaller.appspotmail.com>
To: dakr@kernel.org, davem@davemloft.net, driver-core@lists.linux.dev, 
	edumazet@google.com, gregkh@linuxfoundation.org, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    1b78070aaef6 Merge tag 'net-7.3-rc1' of git://git.kernel.o..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=132ec379580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=10b515098afdcfc455c7
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1208fd49580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b92c15580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18856a03a9a3/disk-1b78070a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc2bc68d7ef4/vmlinux-1b78070a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/05a5e00f8f91/bzImage-1b78070a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10b515098afdcfc455c7@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (1 ticks this GP) idle=51bc/1/0x4000000000000000 softirq=17926/17938 fqs=6
rcu: 	(detected by 0, t=10502 jiffies, g=16769, q=4471 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 4984 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:check_preemption_disabled+0x1a/0xd0 lib/smp_processor_id.c:53
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41 57 41 56 53 65 8b 05 4b ee b0 07 65 48 8b 0d 1b ee b0 07 85 c9 74 0c 5b <41> 5e 41 5f 5d c3 cc cc cc cc cc 9c 59 f7 c1 00 02 00 00 74 ea 65
RSP: 0018:ffffc90000a18d68 EFLAGS: 00000002
RAX: 0000000000000001 RBX: 00000000ffffffff RCX: 0000000001000001
RDX: 0000000001000001 RSI: ffffffff8e48da65 RDI: ffffffff8c6d8b80
RBP: 00000000ffffffff R08: 0000000001000001 R09: 0000000000000000
R10: ffff88802b880308 R11: ffffed1005710063 R12: 0000000000000046
R13: ffff88807ed40000 R14: ffff8880b8728298 R15: ffff8880b8728390
FS:  00007f352db77880(0000) GS:ffff888124de0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055556bd98a38 CR3: 000000007efac000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 lockdep_recursion_inc kernel/locking/lockdep.c:465 [inline]
 lock_is_held_type+0x5a/0x150 kernel/locking/lockdep.c:5981
 lock_is_held include/linux/lockdep.h:249 [inline]
 __run_hrtimer kernel/time/hrtimer.c:2033 [inline]
 __hrtimer_run_queues+0x20b/0xa10 kernel/time/hrtimer.c:2124
 hrtimer_interrupt+0x4cd/0xaa0 kernel/time/hrtimer.c:2243
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:add_uevent_var+0x25f/0x460 lib/kobject_uevent.c:692
Code: 01 00 00 e8 63 ee ed f5 4c 8b 64 24 38 42 0f b6 04 3b 84 c0 48 8b 54 24 10 0f 85 aa 01 00 00 49 83 c4 18 4c 63 32 41 8d 46 01 <89> 02 bf 40 00 00 00 44 89 f6 e8 32 f3 ed f5 49 83 fe 3f 0f 87 aa
RSP: 0018:ffffc9000253f880 EFLAGS: 00000286
RAX: 0000000000000009 RBX: 1ffff1100feb9043 RCX: ffff88807ed40000
RDX: ffff88807f5c8218 RSI: 000000000000007b RDI: 0000000000000801
RBP: ffffc9000253f9b0 R08: ffffc9000253f757 R09: 0000000000000000
R10: ffffc9000253f740 R11: fffff520004a7eeb R12: ffff88807f5c8018
R13: 1ffff920004a7f20 R14: 0000000000000008 R15: dffffc0000000000
 dev_uevent+0x4ab/0x870 drivers/base/core.c:2774
 kobject_uevent_env+0x475/0x9e0 lib/kobject_uevent.c:576
 kobject_synth_uevent+0x45e/0x950 lib/kobject_uevent.c:207
 uevent_store+0x26/0x70 drivers/base/core.c:2847
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f352d4a7407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007fff3d25d8b0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f352db77880 RCX: 00007f352d4a7407
RDX: 0000000000000007 RSI: 000055716b1e2a00 RDI: 000000000000000c
RBP: 000055716b1e2a00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000007
R13: 000055716b1ea8a0 R14: 00007f352d5efea0 R15: 00007fff3d25dbf0
 </TASK>
rcu: rcu_preempt kthread starved for 10472 jiffies! g16769 f0x0 RCU_GP_WAIT_FQS(5) ->state=R ->cpu=0
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
CPU: 0 UID: 0 PID: 5760 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:csd_lock_wait kernel/smp.c:363 [inline]
RIP: 0010:csd_lock kernel/smp.c:396 [inline]
RIP: 0010:smp_call_function_many_cond+0x61e/0x1500 kernel/smp.c:944
Code: b6 04 04 84 c0 0f 85 d5 03 00 00 44 8b 3b 44 89 fe 83 e6 01 31 ff e8 51 51 0c 00 41 83 e7 01 75 07 e8 46 4c 0c 00 eb 3f f3 90 <48> b8 00 00 00 00 00 fc ff df 41 0f b6 04 04 84 c0 75 0f f7 03 01
RSP: 0018:ffffc9000355f420 EFLAGS: 00000293
RAX: ffffffff81bb677e RBX: ffff8880b87414c8 RCX: ffff888020330000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000355f570 R08: ffff88802033159f R09: 1ffff110040662b3
R10: dffffc0000000000 R11: 0000000000000000 R12: 1ffff110170e8299
R13: 0000000000000001 R14: ffff8880b87414c0 R15: 0000000000000001
FS:  000055556bd7d500(0000) GS:ffff888124ce0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe76eb556c8 CR3: 000000007b140000 CR4: 00000000003526f0
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
RIP: 0033:0x7fe76ddc6bd2
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffc068b1d70 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffc068b1d70 RCX: 00007fe76ddc6bd2
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffc068b1efc R08: 0000000000000000 R09: 0000000000000000
R10: 000055556bd7d7d0 R11: 0000000000000246 R12: 0000000000000001
R13: 000055556bd90a00 R14: 000000000001ae67 R15: 00007ffc068b1f50
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
