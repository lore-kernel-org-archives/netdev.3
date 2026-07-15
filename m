Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8837472798
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130946; cv=none; b=oYVgVwZnynY7r1vefokd5TbwdJ73RhgrRC849amoOMIs+/DwmsUdtkg95zPBh/KDrCBuk7BDqOpNLB6QOTwWbaPShjE8aFp6NRBQncvS1mi1p+rWgRpeT1OpvrkmIc4G+SsuokCIdD2sGk+zJA74tlQVoK75N/okEq62WuL0X+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130946; c=relaxed/simple;
	bh=EZNfhrdlz4irc7pTkZR/Lz23yuxC53AlevaUph899R0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bv69VnXz5xsYukg80n+GPifYWAzuespD6y5jwC3UF8xEPj4P5vsaVAXKS/LdJBpbeiMe+Hj8WgLBT7qBYP7CX5/eQ/3YNN7D4q8jOBackag139jG27dzkyYyLLWfEoqBnFmA0zwj47C9rctA/QA+TEu/nk9MwJTJBl+EthX88Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-49d4cb3ca23so10247160b6e.3
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784130938; x=1784735738;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9WoPrGQoQSlhoAnzXbhzoBW+OBxq3RHjCFmqrAGLFM=;
        b=HTWecQmuBqGp3iFwFTnBWmA4BKpxFaV19cfEKB3XEj5kQJRMtKOoih/MXHgybcatc+
         wslwLEubfPGBncuD4OBLsTr1Dqn7BEj05RVFgeqeFv2r+8oKySjXmpKjKYENdjgGXfXj
         lA4XEFDxyT72qqNJP2NSyBKWiFGU9gmdi3H8Hmh7fyay0o8Z2a9rt4booR4ErA6dxxR+
         fqP5hqMJ/Gr8HCVj5jWBXFT6eQfzXtIVoQSpoho7rJw/qamUA6Oe23XZ6Ew/YXN0K3k3
         YcvoJNa83y5Rs+nKKdl8zF60m3+QRs8WqI6iPqEWFMJ+Fq4WEhzduJSrIZYrCT8L67/p
         idxA==
X-Forwarded-Encrypted: i=1; AHgh+RrkCRoDqn7/eWh2E7vUcMrUeM7IrjdDL762BvSVerGG0Bgz2FsBtjYELyeK+rmDa0pf50UogA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjWsqpQF1/PnLREktXi0N1hAOtxrNdi/CkfWRKvdVw3QgCePo
	m3WtJ8rBb818NSbNnCL3bYYCZn3d89Agvc6W4a4vcLB01B+6hwrSU5KxdwZgPsiEPhxyGENfa37
	hA8sMR/tR/STH8l0sq11g+N+DHfmcz5vdgMBeXTPLQc1wIyKyGBiinBeKLlg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1523:b0:4a4:2424:eb0e with SMTP id
 5614622812f47-4a47282d03amr5164990b6e.20.1784130936852; Wed, 15 Jul 2026
 08:55:36 -0700 (PDT)
Date: Wed, 15 Jul 2026 08:55:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a57ad78.9d83364e.246513.0004.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in llc_conn_ac_send_sabme_cmd_p_set_x
From: syzbot <syzbot+44efda9647c52be29d9c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a13c140cc289 Linux 7.2-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144c3b89580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d69870d5e052935f
dashboard link: https://syzkaller.appspot.com/bug?extid=44efda9647c52be29d9c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2052a80016f0/disk-a13c140c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d06ec9d98a4/vmlinux-a13c140c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8cfe7c92eaf6/bzImage-a13c140c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44efda9647c52be29d9c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in llc_conn_ac_send_sabme_cmd_p_set_x+0x442/0x470 net/llc/llc_c_ac.c:782
Read of size 1 at addr ffff8880370c8010 by task kworker/u8:0/11804

CPU: 0 UID: 0 PID: 11804 Comm: kworker/u8:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/10/2026
Workqueue: events_unbound toggle_allocation_gate
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
RIP: 0010:finish_task_switch.isra.0+0x2cd/0x10c0 kernel/sched/core.c:5361
Code: ab 0a 00 00 41 c7 87 20 0e 00 00 00 00 00 00 e9 47 04 00 00 49 8d 7f 48 e8 30 b4 e6 09 e8 1b a9 3c 00 fb 48 8d bb f8 16 00 00 <48> b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84
RSP: 0018:ffffc90005097578 EFLAGS: 00000202
RAX: 0000000000056db3 RBX: ffff8880741c8000 RCX: 0000000000000040
RDX: 0000000000000000 RSI: ffffffff8e1a3c59 RDI: ffff8880741c96f8
RBP: ffffc900050975d0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8e891480
R13: 0000000000000001 R14: ffffffff91227064 R15: ffff8880b843b4c0
 context_switch kernel/sched/core.c:5513 [inline]
 __schedule+0x1264/0x6730 kernel/sched/core.c:7234
 preempt_schedule_irq+0x50/0x90 kernel/sched/core.c:7556
 irqentry_exit_to_kernel_mode_preempt include/linux/irq-entry-common.h:468 [inline]
 irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:539 [inline]
 irqentry_exit+0x205/0xa00 kernel/entry/common.c:167
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:679
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:210
Code: 56 e1 5e 00 48 89 df 5b e9 9d 5c 64 00 be 03 00 00 00 5b e9 32 5a 13 03 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 65 8b 05 85 a3 59 12 48 8b 34 24 65 48 8b 15 61 a3 59
RSP: 0018:ffffc90005097850 EFLAGS: 00000206
RAX: 0000000000000000 RBX: ffffc900050979b0 RCX: ffffffff8bb86f00
RDX: 0000000000008000 RSI: 0000000000000000 RDI: ffff8880741c8000
RBP: ffffc900050979d4 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000008000 R11: 0000000000000000 R12: ffffc900050979fc
R13: 0000000000008000 R14: 0000000000008000 R15: 0000000000000ffa
 insn_get_modrm+0xee/0x790 arch/x86/lib/insn.c:396
 insn_get_sib arch/x86/lib/insn.c:466 [inline]
 insn_get_displacement+0x2f9/0x960 arch/x86/lib/insn.c:507
 insn_get_immediate+0x84/0x1e00 arch/x86/lib/insn.c:673
 insn_get_length arch/x86/lib/insn.c:745 [inline]
 insn_decode+0x21d/0x320 arch/x86/lib/insn.c:784
 __smp_text_poke_batch_add+0x174/0x790 arch/x86/kernel/alternative.c:3103
 arch_jump_label_transform_queue+0xaf/0x120 arch/x86/kernel/jump_label.c:138
 __jump_label_update+0xd7/0x380 kernel/jump_label.c:513
 jump_label_update+0x37a/0x550 kernel/jump_label.c:910
 static_key_disable_cpuslocked+0x162/0x1c0 kernel/jump_label.c:240
 static_key_disable+0x1a/0x20 kernel/jump_label.c:248
 toggle_allocation_gate mm/kfence/core.c:918 [inline]
 toggle_allocation_gate+0x149/0x2d0 mm/kfence/core.c:903
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 12543:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2e5/0x6c0 mm/slub.c:5515
 _kmalloc_noprof include/linux/slab.h:969 [inline]
 _kzalloc_noprof include/linux/slab.h:1290 [inline]
 llc_sap_alloc net/llc/llc_core.c:29 [inline]
 llc_sap_open+0x120/0x3b0 net/llc/llc_core.c:96
 llc_ui_autobind.isra.0+0x2ae/0x580 net/llc/af_llc.c:301
 llc_ui_connect+0x582/0xdb0 net/llc/af_llc.c:498
 __sys_connect_file+0x141/0x1a0 net/socket.c:2135
 __sys_connect+0x141/0x170 net/socket.c:2154
 __do_sys_connect net/socket.c:2160 [inline]
 __se_sys_connect net/socket.c:2157 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2157
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 0:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2705 [inline]
 __rcu_free_sheaf_prepare+0x5d/0x2f0 mm/slub.c:2956
 rcu_free_sheaf+0x1a/0xe0 mm/slub.c:6004
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x5a2/0x10d0 kernel/rcu/tree.c:2897
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_call_function_single arch/x86/kernel/smp.c:267 [inline]
 sysvec_call_function_single+0xa3/0xc0 arch/x86/kernel/smp.c:267
 asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:681

The buggy address belongs to the object at ffff8880370c8000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 16 bytes inside of
 freed 2048-byte region [ffff8880370c8000, ffff8880370c8800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880370cd000 pfn:0x370c8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88813fe22000 ffffea0000c73e10 ffffea0000a2e810
raw: ffff8880370cd000 0000000800080007 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88813fe22000 ffffea0000c73e10 ffffea0000a2e810
head: ffff8880370cd000 0000000800080007 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5615, tgid 5615 (syz-executor), ts 66637688496, free_ts 48968356257
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3294 [inline]
 allocate_slab mm/slub.c:3408 [inline]
 new_slab+0xa2/0x650 mm/slub.c:3454
 refill_objects+0xe3/0x410 mm/slub.c:7338
 refill_sheaf mm/slub.c:2832 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4703
 alloc_from_pcs mm/slub.c:4801 [inline]
 slab_alloc_node mm/slub.c:4933 [inline]
 __do_kmalloc_node mm/slub.c:5361 [inline]
 __kmalloc_node_track_caller_noprof+0x679/0x830 mm/slub.c:5497
 kmalloc_reserve+0xe8/0x350 net/core/skbuff.c:637
 pskb_expand_head+0x249/0x10e0 net/core/skbuff.c:2306
 netlink_trim+0x22d/0x2f0 net/netlink/af_netlink.c:1300
 netlink_broadcast_filtered+0x6d/0xf20 net/netlink/af_netlink.c:1518
 nlmsg_multicast_filtered include/net/netlink.h:1165 [inline]
 nlmsg_multicast include/net/netlink.h:1184 [inline]
 nlmsg_notify+0xb1/0x290 net/netlink/af_netlink.c:2599
 rtnl_notify net/core/rtnetlink.c:963 [inline]
 rtmsg_ifinfo_send net/core/rtnetlink.c:4553 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4569 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4556 [inline]
 rtmsg_ifinfo+0x177/0x1b0 net/core/rtnetlink.c:4575
 __dev_notify_flags+0x24c/0x2e0 net/core/dev.c:9789
 rtnl_configure_link+0x1b5/0x280 net/core/rtnetlink.c:3679
 rtnl_newlink_create net/core/rtnetlink.c:3923 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4044 [inline]
 rtnl_newlink+0x153b/0x2380 net/core/rtnetlink.c:4159
page last free pid 5271 tgid 5271 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x79f/0x1090 mm/page_alloc.c:2950
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4612 [inline]
 slab_alloc_node mm/slub.c:4945 [inline]
 kmem_cache_alloc_node_noprof+0x27d/0x6b0 mm/slub.c:5017
 __alloc_skb+0x140/0x710 net/core/skbuff.c:704
 alloc_skb include/linux/skbuff.h:1384 [inline]
 alloc_skb_with_frags+0xdd/0x760 net/core/skbuff.c:6769
 sock_alloc_send_pskb+0x801/0x980 net/core/sock.c:3010
 unix_dgram_sendmsg+0x3c7/0x1810 net/unix/af_unix.c:2136
 unix_seqpacket_sendmsg+0x12a/0x1d0 net/unix/af_unix.c:2537
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 sock_write_iter+0x53a/0x5b0 net/socket.c:1241
 do_iter_readv_writev+0x6f7/0x930 fs/read_write.c:828
 vfs_writev+0x360/0xdd0 fs/read_write.c:1058
 do_writev+0x28a/0x340 fs/read_write.c:1104
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880370c7f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880370c7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880370c8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff8880370c8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880370c8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	41 c7 87 20 0e 00 00 	movl   $0x0,0xe20(%r15)
   9:	00 00 00 00
   d:	e9 47 04 00 00       	jmp    0x459
  12:	49 8d 7f 48          	lea    0x48(%r15),%rdi
  16:	e8 30 b4 e6 09       	call   0x9e6b44b
  1b:	e8 1b a9 3c 00       	call   0x3ca93b
  20:	fb                   	sti
  21:	48 8d bb f8 16 00 00 	lea    0x16f8(%rbx),%rdi
* 28:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax <-- trapping instruction
  2f:	fc ff df
  32:	48 89 fa             	mov    %rdi,%rdx
  35:	48 c1 ea 03          	shr    $0x3,%rdx
  39:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
  3d:	84                   	.byte 0x84


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
