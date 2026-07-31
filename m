Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE93E121A
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518205; cv=none; b=Fh8tFvieCT8RQiutgudzvMRyBTTjc+Eq2V9LJxX35jsGc4dD7JoJtk95sFVWAMJUFCF8neYsSLEdtEE9Tir0sc2xXEXQvxmUJy4I6VE8MkIWNjj4+e4yEw6GFfoNfzlnrkMHyWH/8casBOijTgAOunasEYA8Qe4mMWMoFnfOPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518205; c=relaxed/simple;
	bh=HcoN/dVuE/4XPHJq74MO/5+SlJNel9J55+Ojn5RjR68=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=azxkogRp4Jf9UhPxC2OzKPX/X50naGYb011Oab4vat56AOvMUZxNjd86aTQr/j8gecgPipD3xoSkYZRJjWvuUhXxCIlIJBKMfNxDkCP0FbI/qbtihZgd3LcOAtZgZj+moJaEq0LD1mP6RtpXdsRNtHM7TpqPcMmQKRnpSCz6E+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4a7de733fa9so1402227b6e.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785518203; x=1786123003;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MtCLywQgZEAejrQViXAgHXw3FleG9I5MXHcT3eIY65U=;
        b=W9IqDEmstsZNNhMcUw4XY8jhMYWrF+OrZDkeu4gv0O7Jy/FBhFlyGTCo00MQ13MOhJ
         Jb6i9hbMzAZZJ2dHLEpOQXZzQ8uZHCsm2aSDZgUBt3T4h2AupC/5+7+9FSM0WeANqNUI
         8WoCTDehAddUj5KPUTm8eMmJUos1A0SN0OkaUZobavrfF5vxbMddfxBuq+mNo0n7066Z
         MUpZsC65furIuoLC5kaSW9MabJ47lBeys/e4L+p13ozLaxpu/2p2p2cmcRnlN2SQOCUD
         tfYCKi7pQ3tckMolpugNfUVI9kFUEB5tcLgmPHX9LbqvKNxcLo7ywJW3YkffZyAHQrnH
         7OwA==
X-Forwarded-Encrypted: i=1; AHgh+RpgpTGP7Phn+96Etrc3UJ+UPxhPg+8ATrE/Fd1qgHLr9efbeZPHgO5rEcOdt6diDlOlupBfMx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa/AIjERKLz/sBhmivEHCuHg0wlHuB6kzPECbQRT/CmGQZpqMG
	AVt/biLFh//7sE704Ug1g0qXi76R289QAiKAQMIPR7qiKDExav0FIPInzqqz6axefrYJriMtoy5
	XuDz+DQqMg6tDJuD/MhTx8kFPXMf3X1bq2NktPTgkMQVpeJejdVkIZbAJl2M=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:198d:b0:485:48da:133d with SMTP id
 5614622812f47-4af5e29c73bmr1452812b6e.10.1785518202879; Fri, 31 Jul 2026
 10:16:42 -0700 (PDT)
Date: Fri, 31 Jul 2026 10:16:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6cd87a.2d659fcc.1d46f5.019b.GAE@google.com>
Subject: [syzbot] [usb?] KASAN: slab-use-after-free Read in cxacru_poll_status
From: syzbot <syzbot+24eb38c789655fc43663@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, accessrunner-general@lists.sourceforge.net, 
	gregkh@linuxfoundation.org, linux-atm-general@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1243d9b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=24eb38c789655fc43663
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ca948e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dbf4cb7b4116/disk-11028ab6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/77761f1559a8/vmlinux-11028ab6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb1ed2bbff0e/bzImage-11028ab6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+24eb38c789655fc43663@syzkaller.appspotmail.com

ATM dev 0: poll status: error -71
ATM dev 0: polling disabled, set adsl_state to 'start' or 'poll' to resume
==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:625 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0x15ca/0x1bd0 kernel/locking/mutex.c:821
Read of size 8 at addr ffff88807d29c218 by task kworker/0:0/9

CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: events cxacru_poll_status
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 __mutex_lock_common kernel/locking/mutex.c:625 [inline]
 __mutex_lock+0x15ca/0x1bd0 kernel/locking/mutex.c:821
 cxacru_poll_status+0x55b/0xdc0 drivers/usb/atm/cxacru.c:920
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 9:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2e5/0x6c0 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 cxacru_bind+0xac/0x1440 drivers/usb/atm/cxacru.c:1133
 usbatm_usb_probe+0x378/0x1b50 drivers/usb/atm/usbatm.c:1058
 cxacru_usb_probe+0x101/0x200 drivers/usb/atm/cxacru.c:1370
 usb_probe_interface+0x303/0x8f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_new_device.cold+0x685/0x115c drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x30a3/0x4a60 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 10:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x22b/0x6c0 mm/slub.c:6692
 cxacru_unbind+0x1fc/0x3d0 drivers/usb/atm/cxacru.c:1266
 usbatm_usb_disconnect+0x449/0x7e0 drivers/usb/atm/usbatm.c:1255
 usb_unbind_interface+0x1dd/0x9e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:618 [inline]
 device_remove+0x12a/0x180 drivers/base/dd.c:610
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3961
 usb_disable_device+0x367/0x810 drivers/usb/core/message.c:1478
 usb_disconnect+0x2e2/0x9a0 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1c4f/0x4a60 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 insert_work+0x36/0x230 kernel/workqueue.c:2226
 __queue_work+0x9bc/0x12b0 kernel/workqueue.c:2401
 call_timer_fn+0x19a/0x610 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1794 [inline]
 __run_timers+0x570/0xb00 kernel/time/timer.c:2374
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
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

The buggy address belongs to the object at ffff88807d29c000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 536 bytes inside of
 freed 1024-byte region [ffff88807d29c000, ffff88807d29c400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7d298
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe23dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe23dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5629, tgid 5629 (syz-executor), ts 69989088439, free_ts 68776617028
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
 afs_alloc_call+0x51/0x640 fs/afs/rxrpc.c:171
 afs_charge_preallocation+0x14e/0x360 fs/afs/rxrpc.c:755
 afs_open_socket+0x31e/0x3f0 fs/afs/rxrpc.c:112
 afs_net_init+0x825/0xb00 fs/afs/main.c:116
 ops_init+0x1e2/0x5f0 net/core/net_namespace.c:137
 setup_net+0x118/0x3a0 net/core/net_namespace.c:446
 copy_net_ns+0x46f/0x7c0 net/core/net_namespace.c:579
 create_new_namespaces+0x3ea/0xac0 kernel/nsproxy.c:132
 unshare_nsproxy_namespaces+0xf2/0x220 kernel/nsproxy.c:234
page last free pid 5618 tgid 5618 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x79f/0x1090 mm/page_alloc.c:2950
 __folio_put+0x3b4/0x5f0 mm/swap.c:112
 folio_put include/linux/mm.h:2124 [inline]
 put_page include/linux/mm.h:2193 [inline]
 put_netmem include/net/netmem.h:394 [inline]
 skb_page_unref include/linux/skbuff_ref.h:43 [inline]
 __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
 skb_release_data+0x649/0x8e0 net/core/skbuff.c:1110
 skb_release_all net/core/skbuff.c:1191 [inline]
 __kfree_skb+0x4f/0x70 net/core/skbuff.c:1205
 tcp_wmem_free_skb include/net/tcp.h:334 [inline]
 tcp_rtx_queue_unlink_and_free include/net/tcp.h:2321 [inline]
 tcp_clean_rtx_queue net/ipv4/tcp_input.c:3698 [inline]
 tcp_ack+0x2079/0x7650 net/ipv4/tcp_input.c:4400
 tcp_rcv_established+0x84f/0x3990 net/ipv4/tcp_input.c:6678
 tcp_v4_do_rcv+0xbb6/0x1260 net/ipv4/tcp_ipv4.c:1854
 sk_backlog_rcv include/net/sock.h:1190 [inline]
 __release_sock+0x35a/0x440 net/core/sock.c:3261
 release_sock+0x1e5/0x280 net/core/sock.c:3860
 tcp_sendmsg+0x38/0x50 net/ipv4/tcp.c:1452
 inet_sendmsg+0xb9/0x140 net/ipv4/af_inet.c:865
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 sock_write_iter+0x4ea/0x5b0 net/socket.c:1241
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x1f8/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807d29c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807d29c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807d29c200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88807d29c280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807d29c300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
