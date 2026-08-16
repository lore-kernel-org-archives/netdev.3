Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42535674A
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786887937; cv=none; b=f8T/dWCUdfZvBR1CKe4GuI6QI7qhRfdvaVuEcNmzUC/dbiPprABd4gH7LtQlBfdfDsSqiGT02lA0s/2YcSwz8Nx5dmDjnuxqotm7GHoEq/XB3lHJxI/XaZJfNfmFGC/Fwl+0etSBwd+JT8pMvKl5pJmu4/fLeRweoN/ThFjCjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786887937; c=relaxed/simple;
	bh=Du/vOM0bE9iJZfH//3Dxe+lDliwwSlmnC3zcoSENi+w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B4b9Xv1xNRLmxFhMkNzxcO3y7adJxwDml9PxdVvtLNEG5YV89sMX0fXZqZhsJ7fmVGjnv9StSsu/PLbqfWn6ZnLumgz7r/FXDObc1cxs3sUmZjwfw0MFr4cGE/gKJCnMtrG0PcqSNv16Z8aYgzofX9AfeHSh+ELpDRWoSsQ4h3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-44aeefa1c36so1086839fac.3
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 06:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786887934; x=1787492734;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3HiKop/xw7nR5E6/mneXFNUAVrRueAu4qxjmpz4NUdg=;
        b=d+c13Kvq9WfQifgAGMGs1k52Qn7bFVUulq97l2LwO45A8SJmFyk4zYO2dKdEKfxoi8
         +8hRfDlDwPQNWh1P/WtCMpHD/JJb70QZ/9P0rytHiT/NBIQOz/BrJBTxIU1UvYpGVg9A
         e3am7cDGDGnTrW9bycuiMSiw/AUt+ZIFbOP7MSFkCdRGqgQyYB0K4clbbxHLbihLmzAw
         r0KUdMzK6/uBT21MXbiXwn1GTgkteIkbp3L5+RcKU5HG8eC5wfqfCC7JcGtFQfv10nYh
         65Rvj8ROPVs+B6OmNJ+Xk8bKVJlmgVPjZSMJMMJtYENUVm9C8fTQLkslro9r5MvtNfI2
         ih6A==
X-Forwarded-Encrypted: i=1; AHgh+Rp96A0HP0YaNg3OlaWlM0HzDX2suaaDeM73/ao6QeVZVOmgMt1tqhUH4WYryKNeqi5mIy2H1FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVEdDbc0H2yNQotwX8OVo4ZdCJf55+PP+T8AOwf+Cm+YsoUJz5
	nWs+LiE+exM9Kl+CG/88o0vNYoIyPqroDPxDoGAsK6TSkZpmDhtHgwtVJfVph1PHI4zZhDfX/Aa
	UaqJ0asevKxqWXTz3bLDs5qttXdIP66an/FiEXkZ3eK+Ad7oE81iby57SFSQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:690b:b0:4ae:f5be:fe29 with SMTP id
 5614622812f47-4b241917e16mr19106105b6e.5.1786887933926; Sun, 16 Aug 2026
 06:45:33 -0700 (PDT)
Date: Sun, 16 Aug 2026 06:45:33 -0700
In-Reply-To: <6a57ad78.9d83364e.246513.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a81befd.dbb3a75c.20434b.0030.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in llc_conn_ac_send_sabme_cmd_p_set_x
From: syzbot <syzbot+44efda9647c52be29d9c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jeffinphilip14@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3eb40771c00a Merge tag 'soc-fixes-7.2-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e296c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d67342c314f228d
dashboard link: https://syzkaller.appspot.com/bug?extid=44efda9647c52be29d9c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109f1949580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44efda9647c52be29d9c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in llc_conn_ac_send_sabme_cmd_p_set_x+0x442/0x470 net/llc/llc_c_ac.c:782
Read of size 1 at addr ffff888058d87010 by task syz-executor377/6034

CPU: 3 UID: 0 PID: 6034 Comm: syz-executor377 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 llc_conn_ac_send_sabme_cmd_p_set_x+0x442/0x470 net/llc/llc_c_ac.c:782
 llc_exec_conn_trans_actions net/llc/llc_conn.c:437 [inline]
 llc_conn_service net/llc/llc_conn.c:362 [inline]
 llc_conn_state_process+0x3ec/0x1480 net/llc/llc_conn.c:66
 llc_process_tmr_ev net/llc/llc_c_ac.c:1442 [inline]
 llc_conn_tmr_common_cb+0x2d4/0x880 net/llc/llc_c_ac.c:1325
 call_timer_fn+0x19a/0x610 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x757/0xb00 kernel/time/timer.c:2374
 __run_timer_base kernel/time/timer.c:2386 [inline]
 __run_timer_base kernel/time/timer.c:2378 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2395
 run_timer_softirq+0x1a/0x50 kernel/time/timer.c:2405
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:preempt_count_sub+0x0/0x160 kernel/sched/core.c:6004
Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 c7 c7 e0 bd 8a 94 e9 10 95 71 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 c7 c0 00 96 93 9b 53 89 fb 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc900016bfda8 EFLAGS: 00000246
RAX: 0000000000000001 RBX: ffff88803d884380 RCX: ffffffff81e65993
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 1ffff920002d7fba R08: 0000000000000000 R09: ffffed1007b10870
R10: ffff88803d884383 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 __raw_spin_unlock include/linux/spinlock_api_smp.h:169 [inline]
 _raw_spin_unlock+0x28/0x50 kernel/locking/spinlock.c:190
 spin_unlock include/linux/spinlock.h:390 [inline]
 setfl fs/fcntl.c:85 [inline]
 do_fcntl+0x5da/0x1670 fs/fcntl.c:477
 __do_sys_fcntl fs/fcntl.c:602 [inline]
 __se_sys_fcntl fs/fcntl.c:587 [inline]
 __x64_sys_fcntl+0x163/0x200 fs/fcntl.c:587
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff89b73ab00
Code: 00 00 0f 1f 84 00 00 00 00 00 48 83 ec 18 64 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 83 fe 09 74 27 b8 48 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 40 48 8b 54 24 08 64 48 2b 14 25 28 00 00 00
RSP: 002b:00007ff8986ff130 EFLAGS: 00000293 ORIG_RAX: 0000000000000048
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007ff89b73ab00
RDX: 0000000000000802 RSI: 0000000000000004 RDI: 0000000000000006
RBP: 000000000000005c R08: 0000000000000004 R09: 0000000000000017
R10: 00007ff8986ff1b4 R11: 0000000000000293 R12: 0000000000000007
R13: 0000000000000022 R14: 0000000088888889 R15: 000000000000002e
 </TASK>

Allocated by task 6032:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2e5/0x6c0 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 llc_sap_alloc net/llc/llc_core.c:29 [inline]
 llc_sap_open+0x120/0x3b0 net/llc/llc_core.c:96
 llc_ui_bind+0xb67/0xe40 net/llc/af_llc.c:386
 __sys_bind_socket net/socket.c:1920 [inline]
 __sys_bind_socket net/socket.c:1912 [inline]
 __sys_bind+0x1a9/0x260 net/socket.c:1951
 __do_sys_bind net/socket.c:1956 [inline]
 __se_sys_bind net/socket.c:1954 [inline]
 __x64_sys_bind+0x72/0xb0 net/socket.c:1954
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 33:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 __rcu_free_sheaf_prepare+0x5d/0x2f0 mm/slub.c:2928
 rcu_free_sheaf+0x1a/0xe0 mm/slub.c:5978
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x5a2/0x10d0 kernel/rcu/tree.c:2897
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1076 [inline]
 run_ksoftirqd+0x38/0x60 kernel/softirq.c:1068
 smpboot_thread_fn+0x3d3/0xaa0 kernel/smpboot.c:160
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888058d87000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 16 bytes inside of
 freed 2048-byte region [ffff888058d87000, ffff888058d87800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x58d80
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801c042f00 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801c042f00 dead000000000100 dead000000000122
head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6028, tgid 6024 (syz-executor377), ts 76930678762, free_ts 76926318518
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab mm/slub.c:3380 [inline]
 new_slab+0xa2/0x640 mm/slub.c:3426
 refill_objects+0xe3/0x410 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __kmalloc_cache_noprof+0x479/0x6c0 mm/slub.c:5485
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 llc_sap_alloc net/llc/llc_core.c:29 [inline]
 llc_sap_open+0x120/0x3b0 net/llc/llc_core.c:96
 llc_ui_bind+0xb67/0xe40 net/llc/af_llc.c:386
 __sys_bind_socket net/socket.c:1920 [inline]
 __sys_bind_socket net/socket.c:1912 [inline]
 __sys_bind+0x1a9/0x260 net/socket.c:1951
 __do_sys_bind net/socket.c:1956 [inline]
 __se_sys_bind net/socket.c:1954 [inline]
 __x64_sys_bind+0x72/0xb0 net/socket.c:1954
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 6028 tgid 6024 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x79f/0x1090 mm/page_alloc.c:2950
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4584 [inline]
 slab_alloc_node mm/slub.c:4917 [inline]
 __kmalloc_cache_noprof+0x265/0x6c0 mm/slub.c:5485
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 ref_tracker_alloc+0x190/0x590 lib/ref_tracker.c:270
 __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
 netdev_tracker_alloc include/linux/netdevice.h:4508 [inline]
 llc_ui_bind+0x77b/0xe40 net/llc/af_llc.c:412
 __sys_bind_socket net/socket.c:1920 [inline]
 __sys_bind_socket net/socket.c:1912 [inline]
 __sys_bind+0x1a9/0x260 net/socket.c:1951
 __do_sys_bind net/socket.c:1956 [inline]
 __se_sys_bind net/socket.c:1954 [inline]
 __x64_sys_bind+0x72/0xb0 net/socket.c:1954
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888058d86f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888058d86f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888058d87000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888058d87080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888058d87100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	f3 0f 1e fa          	endbr64
   e:	48 c7 c7 e0 bd 8a 94 	mov    $0xffffffff948abde0,%rdi
  15:	e9 10 95 71 00       	jmp    0x71952a
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	90                   	nop
  26:	90                   	nop
  27:	90                   	nop
  28:	90                   	nop
  29:	90                   	nop
* 2a:	f3 0f 1e fa          	endbr64 <-- trapping instruction
  2e:	48 c7 c0 00 96 93 9b 	mov    $0xffffffff9b939600,%rax
  35:	53                   	push   %rbx
  36:	89 fb                	mov    %edi,%ebx
  38:	48                   	rex.W
  39:	ba 00 00 00 00       	mov    $0x0,%edx
  3e:	00 fc                	add    %bh,%ah


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
