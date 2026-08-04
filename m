Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1313737EFE2
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804028; cv=none; b=qUagniC+vMylrTmApqvVVbClm5QyHTm5gQMBTTeEqxVyTPI1XcuiwOkveurh+pCDfEIKhERTmIoX/WcqquMvJGQ3KK2vxRvt7mKKmQcWyYWv454Om/yYZJgdTDZAWt/7lq1yXqPhM6IrDypr1QIGNIc/L1lWcTpIJr7uOwGLy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804028; c=relaxed/simple;
	bh=I6gWXDEwBVOZPIWwvrZHaxO/3M9QKCkpQ22/xhJC5V8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LpG4aA/x+Go9C5o0qWTqLur0ucT+/9o1wnhaV7FrkS8NFjtR4e5cUdPEjaQNmDkL21LPMiacoUJuEaIk84JLmvJG6yzH+ziCr0ZsJi3FUoArh5AQKYwClQwNQ1v+E1rl+yhsrgwVCLz7uW2QkEDAVw3zVEFPVN8HCusuZiKenUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7ec5495f105so3446308a34.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 17:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785804026; x=1786408826;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ubF6i7JD4IUrpmUaXuu4x/832Ry3dsg6m3Oj3ejdvQ=;
        b=dC6l2LfEJj5rEFGRcpkYM/b/ZvEVZSQwbItiHM0F5W4GLmZZ0FwwDrvWkT4TW1rqhs
         5CjUbqprlD3kSaVnE0jwzNWH8vwD0xUP2S9lCKBF49xQHCxAX0SjY7364SVlX7vCqVHK
         RxVEx8OBQXVw+dwhDmItPNhGu20pC+liA4FsvQleMuO50mmUWJHK8yIEMiK5KmBbvuvu
         deMqk+s9SSfdCFUcBAOGv32thUw/G16bCrMta5C3Tl/tKa0Dqcpcgz552zFMs4vG4t8O
         TTN6GwHy2HBhnEEUSFg2hzsosYozc9QARJQFXbTHPv8uqnA5EqHQRDkW/2jQaUKmPaoF
         Gs9A==
X-Forwarded-Encrypted: i=1; AHgh+Rpn4WmvH9EUe3NynVm9pUwmdDRxI8UOKJsiOfcDWCnhsZiRrV/rt4pN4LX+NN5ouMG+20kZFjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hHi7BB3N/haUsLvkZSczFu1yRDbyb+LQIcmmjg1/FOQzPtQM
	PB7ldukQp3LUlDPLhTWYIXwQPwvNegN/b9RTK6Tmu9ATOZFe5gHa5yEjpEa9CpqOVmKpmahxi+t
	TKHypQcyOZv5SLutRh87CLGjci6ddj60VHb+c0hFr7tVMLV4H0HE69B59RU8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5241:b0:4a4:866:c395 with SMTP id
 5614622812f47-4af5e335346mr19213504b6e.13.1785804025786; Mon, 03 Aug 2026
 17:40:25 -0700 (PDT)
Date: Mon, 03 Aug 2026 17:40:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7134f9.13623e66.bdc14.0005.GAE@google.com>
Subject: [syzbot] [usb?] KASAN: slab-use-after-free Read in
 lookup_object_or_alloc (4)
From: syzbot <syzbot+e4b1171e7c5ae2556f9e@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, accessrunner-general@lists.sourceforge.net, 
	gregkh@linuxfoundation.org, linux-atm-general@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159225b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=e4b1171e7c5ae2556f9e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dbf4cb7b4116/disk-11028ab6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/77761f1559a8/vmlinux-11028ab6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb1ed2bbff0e/bzImage-11028ab6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4b1171e7c5ae2556f9e@syzkaller.appspotmail.com

ATM dev 0: poll status: error -5
ATM dev 0: polling disabled, set adsl_state to 'start' or 'poll' to resume
==================================================================
BUG: KASAN: slab-use-after-free in timer_is_static_object+0x80/0x90 kernel/time/timer.c:691
Read of size 8 at addr ffff88805443f8f8 by task kworker/0:7/5803

CPU: 0 UID: 0 PID: 5803 Comm: kworker/0:7 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: events cxacru_poll_status
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 timer_is_static_object+0x80/0x90 kernel/time/timer.c:691
 lookup_object_or_alloc.part.0+0x386/0x4f0 lib/debugobjects.c:696
 lookup_object_or_alloc lib/debugobjects.c:682 [inline]
 debug_object_activate+0x2fd/0x4b0 lib/debugobjects.c:875
 debug_timer_activate kernel/time/timer.c:793 [inline]
 __mod_timer+0x845/0xca0 kernel/time/timer.c:1124
 add_timer_global+0x8e/0xd0 kernel/time/timer.c:1283
 __queue_delayed_work+0x331/0x450 kernel/workqueue.c:2585
 queue_delayed_work_on+0x180/0x1e0 kernel/workqueue.c:2620
 queue_delayed_work include/linux/workqueue.h:714 [inline]
 schedule_delayed_work include/linux/workqueue.h:856 [inline]
 cxacru_poll_status+0x622/0xdc0 drivers/usb/atm/cxacru.c:931
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5803:
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

Freed by task 5718:
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

The buggy address belongs to the object at ffff88805443f800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 248 bytes inside of
 freed 1024-byte region [ffff88805443f800, ffff88805443fc00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x54438
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
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1019, tgid 1019 (kworker/u8:7), ts 92204884189, free_ts 91158504294
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
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0x66d/0x820 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 ieee802_11_parse_elems_full+0x17c/0x3bc0 net/mac80211/parse.c:1073
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2551 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1540 [inline]
 ieee80211_ibss_rx_queued_mgmt+0xc96/0x1c70 net/mac80211/ibss.c:1571
 ieee80211_iface_process_skb net/mac80211/iface.c:1769 [inline]
 ieee80211_iface_work+0xa9a/0x1070 net/mac80211/iface.c:1823
 cfg80211_wiphy_work+0x2b7/0x550 net/wireless/core.c:538
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 5873 tgid 5870 stack trace:
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
 __kfree_skb net/core/skbuff.c:1205 [inline]
 kfree_skb_napi_cache net/core/skbuff.c:7281 [inline]
 skb_attempt_defer_free+0x38d/0x830 net/core/skbuff.c:7319
 tcp_eat_recv_skb net/ipv4/tcp.c:1621 [inline]
 tcp_recvmsg_locked+0x11ed/0x2a30 net/ipv4/tcp.c:2899
 tcp_recvmsg+0x141/0x630 net/ipv4/tcp.c:2944
 inet_recvmsg+0xd5/0x4c0 net/ipv4/af_inet.c:894
 sock_recvmsg_nosec net/socket.c:1126 [inline]
 sock_recvmsg+0x1b8/0x220 net/socket.c:1148
 __sys_recvfrom+0x1f2/0x2f0 net/socket.c:2302
 __do_sys_recvfrom net/socket.c:2317 [inline]
 __se_sys_recvfrom net/socket.c:2313 [inline]
 __x64_sys_recvfrom+0xe0/0x1c0 net/socket.c:2313
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805443f780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88805443f800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805443f880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff88805443f900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805443f980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
