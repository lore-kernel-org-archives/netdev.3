Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F91C5D72
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785628836; cv=none; b=E2+F7JiM7xHIaxFMHArIAXqjEDsghagxkiigxNeEb8hOz8fHF7iqtxkCYJ+fukw2vDe+8EUc4hcyhqxgWyfHTP2eD6jg8tmdat+X2KmRFzI69pmweR50vRRTRcdXQHYvn4gx3tRtqlKMJQawjxAy5j8dyqdWLmZde1JnYrrntoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785628836; c=relaxed/simple;
	bh=mTIkNiFrB2tE8TGWw7i4l/43HnSjE3FgH47SLWzHggI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MNxyL+hzz68G6ZeyiPnkQjGrmhzsaR31eUZFeo5Mf+HhiCdxZi7ZO7pUKMrOdGmLcffodQsRuS+PisJrFp1QPqM1pd0lK/2v/E5Ajvhjx6jPZb5u4xCFvNiqC+JUIQodC0sXxAp505DVWI2TcfaufH5xvoaZR77ZXFelfjxkO28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-49f3a97f1caso1536374b6e.0
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 17:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785628833; x=1786233633;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcjUvSgLwh50//vBrNZydN3/5lJfhx/xxmZpzcHLEYM=;
        b=HsfRRI4+lUULU8tvuYelZeyz3JOojx1bnBFgo81aY5RseFEyfb6puCpVVHMorNja4n
         4DaL2FWTwgx7zKPkuvTDTS660g5GUGkJNiprvJS1B7IUEF4E887h8jU4UAjkChd3II0E
         eRLi8XcMwP0xMT+gQoyYtFZYPsRkXzIL03LT8E5MBW2qkN52Dhx+9KO3mGeJ9rpeZ1MP
         TeLAyCTRtf1DvZ9pSs4gDN+WvIJJesErCuhjSqw0O221JrBnXv/OPZ9JxEAu/6bcGP9a
         NRR1CsJI+iS4CLW47HUsGDtwkBkqlwD83zUPaZdTWrKYJzZK0vhPWoScXt77tQ3OJzdi
         O+Bw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8U0vTt7tTSXXKdVnOOOr4KhN3FOu3UCZWuJUrgf8wYHukjuxOUlVC6sGrCmpwKhllvMXGvMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRP6oKuOmxVy2QErkG1uzNkoxxLT8N6xjhjOEWkG/ZAFLq/QQ
	yhYIvs6ASGY29J7s7CtGcnidCh/VBvHPopm00bGhIxxQYE5VKDV57Qf8PgITSJ6md3wVlf8NvSs
	EtSMgMjgHqIS3UB99ka8nFxGuVoNbr3yMl5sk+zDH7HSLcqQX4d6YKfmHafI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:238b:b0:495:ce61:4e0c with SMTP id
 5614622812f47-4af5dfd106fmr9779571b6e.3.1785628833595; Sat, 01 Aug 2026
 17:00:33 -0700 (PDT)
Date: Sat, 01 Aug 2026 17:00:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6e88a1.13bfb6d0.1ecdd5.0260.GAE@google.com>
Subject: [syzbot] [mm?] [kernfs?] INFO: rcu detected stall in netlink_sendmsg (6)
From: syzbot <syzbot+508388c85f7a82cbd79e@syzkaller.appspotmail.com>
To: driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9c88929cc18c Merge branch 'vxlan-fixes-for-skb-header-pull..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12e316b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=508388c85f7a82cbd79e
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113de499580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c10aea580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c839a5778222/disk-9c88929c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7d9c12119e13/vmlinux-9c88929c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0189c8f6aad/bzImage-9c88929c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+508388c85f7a82cbd79e@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 1, t=10502 jiffies, g=15149, q=760 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10502 (4294966187-4294955685), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10502 jiffies! g15149 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27496 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5666 Comm: syz-executor142 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:__lock_is_held kernel/locking/lockdep.c:5601 [inline]
RIP: 0010:lock_is_held_type+0x89/0x150 kernel/locking/lockdep.c:5940
Code: 9c 07 41 83 bd 98 0b 00 00 00 7e 48 4c 89 eb 48 81 c3 a0 0b 00 00 45 31 ff 49 83 ff 31 73 24 48 89 df 4c 89 f6 e8 f7 01 00 00 <85> c0 75 2a 49 ff c7 49 63 85 98 0b 00 00 48 83 c3 28 49 39 c7 7c
RSP: 0018:ffffc90000007d68 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff88807e8aaaf0 RCX: 0000000000010001
RDX: ffff88807e8a9f00 RSI: ffff8880b86281d8 RDI: ffff88807e8aaaf0
RBP: 00000000ffffffff R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000000fac R12: 0000000000000046
R13: ffff88807e8a9f00 R14: ffff8880b86281d8 R15: 0000000000000002
FS:  0000555577b834c0(0000) GS:ffff888124f50000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7bc378eef0 CR3: 0000000070652000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 lock_is_held include/linux/lockdep.h:249 [inline]
 enqueue_hrtimer+0x79/0x2c0 kernel/time/hrtimer.c:1107
 __run_hrtimer kernel/time/hrtimer.c:2048 [inline]
 __hrtimer_run_queues+0x4ce/0xa10 kernel/time/hrtimer.c:2096
 hrtimer_interrupt+0x448/0x910 kernel/time/hrtimer.c:2215
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__orc_find arch/x86/kernel/unwind_orc.c:101 [inline]
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:238 [inline]
RIP: 0010:unwind_next_frame+0x4d0/0x2550 arch/x86/kernel/unwind_orc.c:510
Code: fc ff df 4c 8b 7c 24 10 49 8d 6e 38 0f 84 8a 16 00 00 e9 ee 01 00 00 49 89 d5 49 89 d7 4c 89 e0 4c 29 f8 48 89 c1 48 c1 f9 02 <48> c1 e8 3f 48 01 c8 48 83 e0 fe 49 8d 1c 47 48 89 d8 48 c1 e8 03
RSP: 0018:ffffc90003ace660 EFLAGS: 00000202
RAX: 0000000000000008 RBX: ffffffff9073eec0 RCX: 0000000000000002
RDX: ffffffff9073eeb4 RSI: ffffffff90f35a48 RDI: ffffffff8c4bdb20
RBP: ffffffff81b1f9a8 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8eb59c60 R12: ffffffff9073eebc
R13: ffffffff9073eeb4 R14: ffffc90003ace708 R15: ffffffff9073eeb4
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4612 [inline]
 slab_alloc_node mm/slub.c:4945 [inline]
 kmem_cache_alloc_noprof+0x2a0/0x5f0 mm/slub.c:4959
 __kernfs_new_node+0xe6/0x980 fs/kernfs/dir.c:665
 kernfs_new_node fs/kernfs/dir.c:751 [inline]
 kernfs_create_dir_ns+0xfe/0x230 fs/kernfs/dir.c:1120
 sysfs_create_dir_ns+0x12f/0x2a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x622/0xcd0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x163/0x240 lib/kobject.c:426
 device_add+0x3fa/0xb80 drivers/base/core.c:3695
 netdev_register_kobject+0x178/0x310 net/core/net-sysfs.c:2337
 register_netdevice+0x1433/0x1eb0 net/core/dev.c:11446
 cfg80211_register_netdevice+0x138/0x2d0 net/wireless/core.c:1690
 ieee80211_if_add+0x108d/0x1600 net/mac80211/iface.c:2397
 ieee80211_register_hw+0x3e79/0x4a50 net/mac80211/main.c:1644
 mac80211_hwsim_new_radio+0x3238/0x5680 drivers/net/wireless/virtual/mac80211_hwsim_main.c:6113
 hwsim_new_radio_nl+0xd8b/0xf90 drivers/net/wireless/virtual/mac80211_hwsim_main.c:6904
 genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 __sys_sendto+0x408/0x5a0 net/socket.c:2252
 __do_sys_sendto net/socket.c:2259 [inline]
 __se_sys_sendto net/socket.c:2255 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2255
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7bc370bc2e
Code: 08 0f 85 25 ed ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007fffcb9d7168 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000555577b834c0 RCX: 00007f7bc370bc2e
RDX: 0000000000000024 RSI: 00007f7bc3791990 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007fffcb9d71e4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f7bc3791990 R15: 0000000000000000
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
