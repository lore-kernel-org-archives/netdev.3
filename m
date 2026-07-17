Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EFE1EB1AA
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 05:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784266778; cv=none; b=j4MU2REDusTstqOM3Yh8o7NKkRVYHXILmshKzthsRc7yVGt4ZbTbU7hb/NhKx62hkNYy6BMVWzn7zV3dvIUBPOhwtXNhHBPIwZJPiyNs7H9hWzqyKzI3gFKa3xtBneiBPBEtzrT4UV1VLr6TTlciZAd4rjNFOrbbeQmdR2F+q/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784266778; c=relaxed/simple;
	bh=CPbJlRnv9XEOIhEZJepVB26b6wp1+SSU3t/YpuwqlBE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XW/gUPpWq/LZdzBhwSbQRuYhDLZBMDkDUesxkKdVrVZmZaFWUuuLWdJaqzM5auuhdOfqC+gke0UjKrtqH+URN2L//YDHGlvKHKw+0xfRgT2EJaJSI1Vs+WaWxtnYmU9EFrWSsXbkpXRCYoo5BekLYr93wvoZK/PcfJ4NjzxQLmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-44aeefa1a30so13859859fac.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 22:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784266775; x=1784871575;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mITD29bGm/rVF3HYjCMVqW3egDLi1jveGkSrm8TdQC8=;
        b=DfpTX+T0YW0ht/QjzSEPMpwhyupJftBffaPpO0zeapOCPYeNq1vZdKB3QAXsV6Uf1h
         FTPyfHUdX5PYtuKdNqlN3bR4eicqZ2Z+88dqqAHYZs8WiIxXuXS+ZhFhJMp7K4vJw+Rf
         LJzJKx9fx2uSxpZG7IkO8l8hxACGl5As7TFSVzOpiVu4vD+4CE3+j7v7fi4rJNHN+nGL
         jnmG2gxG6jtIJx4uK0WYUScyNRAHxHGVEyRdysL/o7znR2V+7DLMMG9fqN3or7i6Cez1
         nUIuoQ38RNLYcW5EBPekjHXmemYlRkeT343KMxyE40kEtse3Q7mYws3jhsR/Pl3PPfQI
         WGcw==
X-Forwarded-Encrypted: i=1; AHgh+RpFrttOcQxpdI00q/HXP4hcwibu6AHkYxHYwWfmG0Sp0Jst2FWmN6RsBe4yYLCyDeDFUNSTOQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvRqAUzVdUMoF/pJQT3qmNEDpM6UMZL4iH9y+u2N4fiMZZFOM
	R5JIUBeb4gGM7joYin16fSpEyDhOrAEaAJb/mqyLtgnTYGkHgc5awqGdWBGM1n0cvP8v+ys7wuk
	nDHJMef8IrjcgqVrYNnFEb0lAlSSgQ9OBnID0WZiia9nDgCLabnXidDUsWFI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b23:b0:495:dbb:7320 with SMTP id
 5614622812f47-4a4d03f4be7mr458588b6e.41.1784266775054; Thu, 16 Jul 2026
 22:39:35 -0700 (PDT)
Date: Thu, 16 Jul 2026 22:39:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a59c017.5622734e.c905.003d.GAE@google.com>
Subject: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbatm_usb_disconnect
From: syzbot <syzbot+e62a973f8322b3bbe3ac@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, duncan.sands@free.fr, gregkh@linuxfoundation.org, 
	linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    58717b2a1365 Merge tag 'sound-7.2-rc4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115dfb89580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ef5c5c0f192153
dashboard link: https://syzkaller.appspot.com/bug?extid=e62a973f8322b3bbe3ac
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b104b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155dfb89580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-58717b2a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f102e0277861/vmlinux-58717b2a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d532ca1493c0/bzImage-58717b2a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e62a973f8322b3bbe3ac@syzkaller.appspotmail.com

usb 5-1: [ueagle-atm] loading firmware ueagle-atm/eagleI.fw
usb 5-1: USB disconnect, device number 2
==================================================================
BUG: KASAN: slab-out-of-bounds in __mutex_lock_common kernel/locking/mutex.c:625 [inline]
BUG: KASAN: slab-out-of-bounds in __mutex_lock+0x15ca/0x1bd0 kernel/locking/mutex.c:821
Read of size 8 at addr ffff888033d7a460 by task kworker/1:1/56

CPU: 1 UID: 0 PID: 56 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 __mutex_lock_common kernel/locking/mutex.c:625 [inline]
 __mutex_lock+0x15ca/0x1bd0 kernel/locking/mutex.c:821
 usbatm_usb_disconnect+0x70/0x7e0 drivers/usb/atm/usbatm.c:1221
 uea_disconnect+0x279/0x2b0 drivers/usb/atm/ueagle-atm.c:2605
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
 </TASK>

Allocated by task 5834:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5362 [inline]
 __kmalloc_node_track_caller_noprof+0x331/0x830 mm/slub.c:5497
 kmemdup_noprof+0x29/0x60 mm/util.c:138
 kmemdup_noprof include/linux/fortify-string.h:715 [inline]
 xt_register_table+0x129/0x9a0 net/netfilter/x_tables.c:1580
 ip6t_register_table+0x137/0x2c0 net/ipv6/netfilter/ip6_tables.c:1755
 ip6table_mangle_table_init+0x40/0x60 net/ipv6/netfilter/ip6table_mangle.c:85
 xt_find_table_lock+0x2db/0x520 net/netfilter/x_tables.c:1353
 xt_request_find_table_lock+0x28/0xf0 net/netfilter/x_tables.c:1378
 get_info+0x1a7/0x770 net/ipv6/netfilter/ip6_tables.c:977
 do_ip6t_get_ctl+0x231/0xc30 net/ipv6/netfilter/ip6_tables.c:1669
 nf_getsockopt+0x7c/0xe0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x207/0x2a0 net/ipv6/ipv6_sockglue.c:1464
 tcp_getsockopt+0xa1/0x110 net/ipv4/tcp.c:4864
 do_sock_getsockopt+0x50a/0x6e0 net/socket.c:2474
 __sys_getsockopt+0x148/0x260 net/socket.c:2505
 __do_sys_getsockopt net/socket.c:2512 [inline]
 __se_sys_getsockopt net/socket.c:2509 [inline]
 __x64_sys_getsockopt+0xbd/0x160 net/socket.c:2509
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 13:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2705 [inline]
 slab_free mm/slub.c:6405 [inline]
 kfree+0x22b/0x6c0 mm/slub.c:6720
 __ip6t_unregister_table net/ipv6/netfilter/ip6_tables.c:1729 [inline]
 ip6t_unregister_table_exit+0x1b7/0x230 net/ipv6/netfilter/ip6_tables.c:1773
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x2ee/0xab0 net/core/net_namespace.c:252
 cleanup_net+0x499/0x920 net/core/net_namespace.c:702
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888033d7a400
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes to the right of
 allocated 96-byte region [ffff888033d7a400, ffff888033d7a460)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888033d7a780 pfn:0x33d7a
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801bc42280 ffffea0000b94790 ffffea0000d07d10
raw: ffff888033d7a780 000000080020001f 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1169, tgid 1169 (kworker/u33:9), ts 17888008252, free_ts 0
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
 __kmalloc_cache_node_noprof+0x542/0x6c0 mm/slub.c:5530
 _kmalloc_node_noprof include/linux/slab.h:1174 [inline]
 __get_vm_area_node+0x101/0x330 mm/vmalloc.c:3215
 __vmalloc_node_range_noprof+0x228/0x1630 mm/vmalloc.c:4042
 __vmalloc_node_noprof+0xad/0xf0 mm/vmalloc.c:4143
 alloc_thread_stack_node kernel/fork.c:359 [inline]
 dup_task_struct kernel/fork.c:929 [inline]
 copy_process+0x7fb/0x8030 kernel/fork.c:2115
 kernel_clone+0x176/0x9d0 kernel/fork.c:2748
 user_mode_thread+0xcc/0x110 kernel/fork.c:2824
 call_usermodehelper_exec_work kernel/umh.c:171 [inline]
 call_usermodehelper_exec_work+0xcb/0x180 kernel/umh.c:157
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888033d7a300: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
 ffff888033d7a380: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>ffff888033d7a400: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                                       ^
 ffff888033d7a480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888033d7a500: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
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
