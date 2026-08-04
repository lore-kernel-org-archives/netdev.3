Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7475146DFFB
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858596; cv=none; b=HuqerNsNmbeEhLfxjGO1uJAhg3p72Jfu8bA5RpRhozSH7oS8g/Ihx4f1Jm07bzgUEzCfs+yxrB/TkKvXnv6IC2No3CIJ1ATEjytyFw1el6agoaEmb4NDbvKMVfv0YhqWaaMiEGgIHfRHYhHfa2VXlzMFJ6NRhBxp4kF2TmD7vBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858596; c=relaxed/simple;
	bh=uovPWBd0SGKEFnKsZBAJzZD9AlNo5Jtze3IGpRMzeak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hSDIPYwDMkOD8lS+TSGqpbJQcibCCzZ16YVnT/yVL5wPA5bQxvnMKcrbmWmsLguKccL/hCgTgfiZ9DJhmvMzplgaTNkGuAg/C5I3zfT/FxBC3TfMRfmVPMt5+LzRDOBQgVNOb4etOM+V3bq8OvxJaBsYopmuZvYzV7MeeKzAcCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-456ab1a7f2cso5492761fac.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785858593; x=1786463393;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxtXsUiOFnHkFmWf11MjFviaZRoJpPUirT53AJT0fL8=;
        b=kDz2aP4UF+5/xniACgI7ep0GAiK9DKQzK6a9BMaKf4sODTt/ssizW2wni7ph2m7w6A
         OSFDXfIPvldel9/2EGchqpPaswY2ORdheCOTJGYXfJ0pCnqYQw2I0qzqt6/AbQcH91tF
         WagSbpG8C1WgYZC4JzrwCrQGCstZUzvyX5zUpRpU5XDR32wphJ0E8blxZiTXTyPAHb5V
         r0NcQoHIdkqrF8RTpAtOkBBFZvQeQH+UoYQlvn5xFoPwmLpxYwsgMZgclKhuzPJ0YfL4
         Y8cvgjM5k6PQwU5FHsrxrZijrXfwVIMYDnNcBKPYdbNaHPDeMbzB7JHgrT2TkRZv/yhP
         XJ5w==
X-Forwarded-Encrypted: i=1; AHgh+Rpv/wXJqur4QBCbN0996lzLeNYmjkZ88SBE90LIo1IbjkwKVQaK5z7dgRRAOzOG+U6RPXSPMHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGLORpPTETw7IJ25luKVMgRHWyvlhmJRUSkZY4CW+SJ5+3xawf
	b5OQTpdjNgd6JhZDA0BtigOhzlRVq3/iAN1AwHwbd9KVjrC63EwPeDqPOqjuyZKcfl31b1tOEsu
	4i6aEmqmCPvSf5/iWRQNF5uUmy24WpoO/h9UJzgvSiLQJ+tdSfhup4Wflxyo=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4a08:b0:6a1:5b63:2ae2 with SMTP id
 006d021491bc7-6ae4334a975mr16005047eaf.29.1785858593264; Tue, 04 Aug 2026
 08:49:53 -0700 (PDT)
Date: Tue, 04 Aug 2026 08:49:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a720a21.40259c87.584f4.04bb.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in ipvlan_hard_header (5)
From: syzbot <syzbot+1f9fd0f4b601cf88d6e6@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e79499580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=1f9fd0f4b601cf88d6e6
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ed42f633fbc9/disk-11028ab6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/408a35414ed1/vmlinux-11028ab6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/526ce947af17/bzImage-11028ab6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f9fd0f4b601cf88d6e6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in dev_hard_header include/linux/netdevice.h:3500 [inline]
BUG: KASAN: slab-use-after-free in ipvlan_hard_header+0xa2/0x120 drivers/net/ipvlan/ipvlan_main.c:385
Read of size 8 at addr ffff888033c58010 by task syz.1.5338/25164

CPU: 0 UID: 0 PID: 25164 Comm: syz.1.5338 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 dev_hard_header include/linux/netdevice.h:3500 [inline]
 ipvlan_hard_header+0xa2/0x120 drivers/net/ipvlan/ipvlan_main.c:385
 dev_hard_header include/linux/netdevice.h:3503 [inline]
 tipc_l2_send_msg+0x319/0x400 net/tipc/bearer.c:515
 tipc_bearer_xmit_skb+0x2b3/0x400 net/tipc/bearer.c:576
 tipc_disc_timeout+0x5f6/0x750 net/tipc/discover.c:340
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
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
RIP: 0010:check_kcov_mode kernel/kcov.c:185 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:246 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x30/0x90 kernel/kcov.c:314
Code: 04 24 65 48 8b 15 b8 07 a6 11 65 8b 0d d9 07 a6 11 81 e1 00 01 ff 00 74 11 81 f9 00 01 00 00 75 5b 83 ba 24 17 00 00 00 74 52 <8b> 8a f8 16 00 00 83 f9 03 75 47 48 8b 8a 00 17 00 00 44 8b 8a fc
RSP: 0018:ffffc900064b75d8 EFLAGS: 00000246
RAX: ffffffff8219d998 RBX: ffffea0001693500 RCX: 0000000000000000
RDX: ffff88801de83e00 RSI: 0000000000000133 RDI: 0000000000000001
RBP: ffffc900064b78d0 R08: ffffea0001693507 R09: 1ffffd40002d26a0
R10: dffffc0000000000 R11: fffff940002d26a1 R12: 0000000000000000
R13: 800000005a4d4007 R14: ffff888026990668 R15: 0000000000000133
 __zap_vma_range+0x1608/0x4f10 mm/memory.c:-1
 unmap_vmas+0x390/0x550 mm/memory.c:2178
 exit_mmap+0x293/0x9f0 mm/mmap.c:1300
 __mmput+0x118/0x420 kernel/fork.c:1187
 exit_mm+0x221/0x2d0 kernel/exit.c:615
 do_exit+0x6cd/0x2360 kernel/exit.c:997
 do_group_exit+0x22d/0x2f0 kernel/exit.c:1152
 __do_sys_exit_group kernel/exit.c:1163 [inline]
 __se_sys_exit_group kernel/exit.c:1161 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1161
 x64_sys_call+0x221a/0x2240 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe52a99df99
Code: Unable to access opcode bytes at 0x7fe52a99df6f.
RSP: 002b:00007fe52ad4fd88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe52a99df99
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fe52ad4fdec R08: 0000000000000000 R09: 00000000000927c0
R10: 0000000000000001 R11: 0000000000000246 R12: 00000000000001f6
R13: 00000000000927c0 R14: 0000000000166acd R15: 00007fe52ad4fe40
 </TASK>

Allocated by task 16223:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kvmalloc_node_noprof+0x53f/0x860 mm/slub.c:6905
 alloc_netdev_mqs+0xa9/0x12b0 net/core/dev.c:12054
 rtnl_create_link+0x321/0xd70 net/core/rtnetlink.c:3721
 rtnl_newlink_create+0x25f/0xb00 net/core/rtnetlink.c:3903
 __rtnl_newlink net/core/rtnetlink.c:4044 [inline]
 rtnl_newlink+0x167f/0x1bd0 net/core/rtnetlink.c:4159
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7076
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
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

Freed by task 25158:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x1c5/0x640 mm/slub.c:6692
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 netdev_run_todo+0xf56/0x10d0 net/core/dev.c:11755
 rtnl_unlock net/core/rtnetlink.c:157 [inline]
 rtnl_net_unlock include/linux/rtnetlink.h:135 [inline]
 rtnl_dellink+0x68f/0x810 net/core/rtnetlink.c:3651
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7076
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888033c58000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 16 bytes inside of
 freed 4096-byte region [ffff888033c58000, ffff888033c59000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x33c58
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888033c59011
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b00a500 dead000000000100 dead000000000122
raw: 0000000000000000 0000200000040004 00000000f5000000 ffff888033c59011
head: 00fff00000000040 ffff88801b00a500 dead000000000100 dead000000000122
head: 0000000000000000 0000200000040004 00000000f5000000 ffff888033c59011
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5680, tgid 5680 (udevd), ts 133221374293, free_ts 133150703885
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x21fa/0x2270 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab+0x79/0x5e0 mm/slub.c:3380
 new_slab mm/slub.c:3426 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x2bf/0x6b0 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kvmalloc_node_noprof+0x66b/0x860 mm/slub.c:6905
 seq_buf_alloc fs/seq_file.c:39 [inline]
 seq_read_iter+0x1ea/0xca0 fs/seq_file.c:211
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x595/0xa80 fs/read_write.c:574
 ksys_read+0x150/0x270 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 6255 tgid 6255 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0xc1e/0xd10 mm/page_alloc.c:2950
 __slab_free+0x274/0x2c0 mm/slub.c:5741
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4584 [inline]
 slab_alloc_node mm/slub.c:4917 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0x311/0x720 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 __register_sysctl_table+0x6f/0x1370 fs/proc/proc_sysctl.c:1378
 __addrconf_sysctl_register+0x31c/0x4b0 net/ipv6/addrconf.c:7366
 addrconf_sysctl_register+0x168/0x1c0 net/ipv6/addrconf.c:7414
 ipv6_add_dev+0xd26/0x13a0 net/ipv6/addrconf.c:460
 addrconf_notify+0x771/0x1050 net/ipv6/addrconf.c:3685
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
 call_netdevice_notifiers net/core/dev.c:2302 [inline]
 register_netdevice+0x18a4/0x1eb0 net/core/dev.c:11484
 veth_newlink+0x49f/0xb70 drivers/net/veth.c:1863
 rtnl_newlink_create+0x310/0xb00 net/core/rtnetlink.c:3913
 __rtnl_newlink net/core/rtnetlink.c:4044 [inline]
 rtnl_newlink+0x167f/0x1bd0 net/core/rtnetlink.c:4159

Memory state around the buggy address:
 ffff888033c57f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888033c57f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888033c58000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888033c58080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888033c58100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	04 24                	add    $0x24,%al
   2:	65 48 8b 15 b8 07 a6 	mov    %gs:0x11a607b8(%rip),%rdx        # 0x11a607c2
   9:	11
   a:	65 8b 0d d9 07 a6 11 	mov    %gs:0x11a607d9(%rip),%ecx        # 0x11a607ea
  11:	81 e1 00 01 ff 00    	and    $0xff0100,%ecx
  17:	74 11                	je     0x2a
  19:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
  1f:	75 5b                	jne    0x7c
  21:	83 ba 24 17 00 00 00 	cmpl   $0x0,0x1724(%rdx)
  28:	74 52                	je     0x7c
* 2a:	8b 8a f8 16 00 00    	mov    0x16f8(%rdx),%ecx <-- trapping instruction
  30:	83 f9 03             	cmp    $0x3,%ecx
  33:	75 47                	jne    0x7c
  35:	48 8b 8a 00 17 00 00 	mov    0x1700(%rdx),%rcx
  3c:	44                   	rex.R
  3d:	8b                   	.byte 0x8b
  3e:	8a fc                	mov    %ah,%bh


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
