Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3B4BA1CE
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827083; cv=none; b=B1hJtKyZbHDOhVWjzTTDioiGncsYigJpJVBfLuT/MW0lw+/EqGes8Ds6dfNiuvYCiCJx0WBavtzUzJ5bD95eblr5aJeshGd7PLVEo9Zr9RxZ3MdYqIRECUP4hXZ4cJpnjSe1IbaIW3FOfDCT+6luiBF7rdGGbNfbRGmQarwleLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827083; c=relaxed/simple;
	bh=Wf+dcn+H7L54TUcUBVlu0iKz30m2BW37COuGS6AOYSI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lo+IWB2LoVM47UOUP1ELhTHHUdNxvMw09/RLGThOT8Zv+hazUcJnYMB3d+gXVGxmk0JSzlINkIyi9/JfaWCYzVBfHPni36F0I1R2yhcJM7QHF5vjdW6NdaqVqKt8tPqsharHDvZUkWJAGVvYpKV/ThmmAwAhd5xzs9WcssoP/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4fb73e868aaso3236799b6e.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827080; x=1792431880;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pufsqLDO+zktVwLnzpRklfjmp3rsFsMXB742BhkySMo=;
        b=qrrGAg+MtosKKjsckmGhjpJf0+0OrvJQtvWENdOA8KpjkE6oKxEukuHEvFHydwjObV
         3EHWTYwV/ko4QrYHtb7ow3OAGg7fGeV3Sxbai9l2QNRzUWIgMUqV64SQ7jCns6aZk2Cu
         ojKUuCbBz2g1mVEoOtmrSiSEhlOLIAXxvrGlxKRODnevztLQgsGeoWNkXT2Dctr0rCSE
         NWnHAT93uZBqirwXxl1ue+pfHlrZLvEDcF717HXZtfv3OhbY92vmHFFvEHSf/kCgrE4K
         CWXko6X4zmbtvV5yeOurqumNjgMRbT/H1Bp8qWAHnOXBKQ60J8cZ2X8cXfIOZsArGlX/
         67zQ==
X-Forwarded-Encrypted: i=1; AKwUvBxu6Ij9OUlrHauCTI0PU9CZfGDouVmD76rj2kXSjgdXHP+eaSqAwKru4zHyLEdJdrK5M+/qa2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXhE2mw6Hf+IQ+eCB/KwT0/wO37FLxJJHdEp5YiZpfxHUP9KWv
	KUz9YiZlpyK0tp3AiFoG/EfxBxYrys7ZonN5h1pCD/WMuKlnKrHAYtXFhdG8QPbuKIOhIbUBX4Y
	i7WODnobrB7El/f8kDC2yjXEhT1OcDgxPYmn7qB3nLg8WYrD0oZlWmn1Hchk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:23c4:b0:4fb:c2dd:c7ae with SMTP id
 5614622812f47-50c438a57dbmr11465605b6e.6.1791827080463; Mon, 12 Oct 2026
 10:44:40 -0700 (PDT)
Date: Mon, 12 Oct 2026 10:44:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6acd1c88.a150a118.27e199.0053.GAE@google.com>
Subject: [syzbot] [nfc?] KASAN: slab-out-of-bounds Read in pn533_recv_frame
From: syzbot <syzbot+93f169a8e7d66864f800@syzkaller.appspotmail.com>
To: david@ixit.cz, krzk@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3857c2fe5449 Merge tag 'pci-v7.3-fixes-4' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fd0c9c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=129d675874dbf896
dashboard link: https://syzkaller.appspot.com/bug?extid=93f169a8e7d66864f800
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37e6727f8862/disk-3857c2fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f8dc1f69ff6/vmlinux-3857c2fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73081d5a798a/bzImage-3857c2fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+93f169a8e7d66864f800@syzkaller.appspotmail.com

PN533 RX: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PN533 RX: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PN533 RX: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PN533 RX: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
BUG: KASAN: slab-out-of-bounds in hex_dump_to_buffer+0xbc4/0xc60 lib/hexdump.c:194
Read of size 1 at addr ffff88804551ba00 by task syz.0.691/10352

CPU: 0 UID: 0 PID: 10352 Comm: syz.0.691 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 hex_dump_to_buffer+0xbc4/0xc60 lib/hexdump.c:194
 print_hex_dump+0x14a/0x1f0 lib/hexdump.c:277
 pn533_recv_frame+0x48e/0x6d0 drivers/nfc/pn533/pn533.c:2202
 __usb_hcd_giveback_urb+0x38e/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 dummy_timer+0xdaf/0x3820 drivers/usb/gadget/udc/dummy_hcd.c:2023
 __run_hrtimer kernel/time/hrtimer.c:2074 [inline]
 __hrtimer_run_queues+0x462/0x9c0 kernel/time/hrtimer.c:2131
 hrtimer_run_softirq+0x1ca/0x360 kernel/time/hrtimer.c:2148
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x16a/0x210 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:filter_irq_stacks+0x19/0x90 kernel/stacktrace.c:397
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 85 f6 74 61 53 31 c0 48 bb 00 00 00 00 00 fc ff df 48 83 ec 10 <48> 89 fa 48 c1 ea 03 80 3c 1a 00 75 4a 48 8b 17 48 81 fa 30 02 00
RSP: 0018:ffffc9000416f820 EFLAGS: 00000206
RAX: 0000000000000005 RBX: dffffc0000000000 RCX: 0000000000000001
RDX: ffffffff8274594b RSI: 000000000000000f RDI: ffffc9000416f8c0
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc9000416f898
R13: ffffffff84dfe5d7 R14: 0000000001422008 R15: ffffea0000d96540
 stack_depot_save_flags+0x27/0x9f0 lib/stackdepot.c:667
 kasan_save_stack+0x3f/0x50 mm/kasan/common.c:58
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6509 [inline]
 kfree+0x22b/0x6d0 mm/slub.c:6802
 selinux_release_secctx security/selinux/hooks.c:7111 [inline]
 selinux_release_secctx+0x87/0x110 security/selinux/hooks.c:7108
 security_release_secctx+0x7c/0x120 security/security.c:3992
 audit_log_subj_ctx+0x3a9/0x450 kernel/audit.c:2324
 audit_log_task_context+0x7f/0xb0 kernel/audit.c:2367
 audit_log_task+0x1b7/0x3a0 kernel/auditsc.c:2902
 audit_seccomp+0x7a/0x1f0 kernel/auditsc.c:2952
 seccomp_log kernel/seccomp.c:1048 [inline]
 __seccomp_filter+0x88c/0x1130 kernel/seccomp.c:1342
 __seccomp_permit_syscall+0x224/0x2e0 kernel/seccomp.c:1402
 syscall_trace_enter include/linux/entry-common.h:98 [inline]
 syscall_enter_from_user_mode_work include/linux/entry-common.h:147 [inline]
 do_syscall_64+0x591/0x790 arch/x86/entry/syscall_64.c:81
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f219af5ea0e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007f219bebaf38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 00007f219bebc6c0 RCX: 00007f219af5ea0e
RDX: 00007f219bebaf90 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000000c0
R13: 0000000000000000 R14: 00007f219b225fa0 R15: 00007ffc2e7b6028
 </TASK>

Allocated by task 10352:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:351 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:377
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_node_noprof+0x282/0x6e0 mm/slub.c:5068
 kmalloc_reserve+0x148/0x350 net/core/skbuff.c:615
 __alloc_skb+0x185/0x710 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 pn533_recv_response+0x100/0x200 drivers/nfc/pn533/usb.c:65
 __usb_hcd_giveback_urb+0x38e/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 dummy_timer+0xdaf/0x3820 drivers/usb/gadget/udc/dummy_hcd.c:2023
 __run_hrtimer kernel/time/hrtimer.c:2074 [inline]
 __hrtimer_run_queues+0x462/0x9c0 kernel/time/hrtimer.c:2131
 hrtimer_run_softirq+0x1ca/0x360 kernel/time/hrtimer.c:2148
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x16a/0x210 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

The buggy address belongs to the object at ffff88804551b740
 which belongs to the cache skbuff_small_head of size 704
The buggy address is located 0 bytes to the right of
 allocated 704-byte region [ffff88804551b740, ffff88804551ba00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x45518
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88814040b780 dead000000000100 dead000000000122
raw: 0000000000000000 0000000200130013 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88814040b780 dead000000000100 dead000000000122
head: 0000000000000000 0000000200130013 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 1108, tgid 1108 (kworker/u8:8), ts 286234767687
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7418
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 kmem_cache_alloc_node_noprof+0x4f2/0x6e0 mm/slub.c:5068
 kmalloc_reserve+0x148/0x350 net/core/skbuff.c:615
 __alloc_skb+0x185/0x710 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 inet6_ifmcaddr_notify+0xd6/0x1d0 net/ipv6/mcast.c:928
 __ipv6_dev_mc_inc+0x731/0xc80 net/ipv6/mcast.c:993
 addrconf_join_solict net/ipv6/addrconf.c:2262 [inline]
 addrconf_dad_begin net/ipv6/addrconf.c:4135 [inline]
 addrconf_dad_work+0x276/0x1360 net/ipv6/addrconf.c:4263
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
page last free pid 4956 tgid 4956 ts 286222916440 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x79f/0x10f0 mm/page_alloc.c:2962
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:361
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_node_noprof+0x282/0x6e0 mm/slub.c:5068
 __alloc_skb+0x140/0x710 net/core/skbuff.c:704
 alloc_skb include/linux/skbuff.h:1384 [inline]
 alloc_skb_with_frags+0xdd/0x760 net/core/skbuff.c:6803
 sock_alloc_send_pskb+0x801/0x980 net/core/sock.c:3022
 unix_dgram_sendmsg+0x3c7/0x1810 net/unix/af_unix.c:2144
 sock_sendmsg_nosec net/socket.c:800 [inline]
 __sock_sendmsg net/socket.c:815 [inline]
 __sys_sendto+0x48b/0x4e0 net/socket.c:2281
 __do_sys_sendto net/socket.c:2288 [inline]
 __se_sys_sendto net/socket.c:2284 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2284
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88804551b900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88804551b980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88804551ba00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88804551ba80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804551bb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	f3 0f 1e fa          	endbr64
  15:	85 f6                	test   %esi,%esi
  17:	74 61                	je     0x7a
  19:	53                   	push   %rbx
  1a:	31 c0                	xor    %eax,%eax
  1c:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
  23:	fc ff df
  26:	48 83 ec 10          	sub    $0x10,%rsp
* 2a:	48 89 fa             	mov    %rdi,%rdx <-- trapping instruction
  2d:	48 c1 ea 03          	shr    $0x3,%rdx
  31:	80 3c 1a 00          	cmpb   $0x0,(%rdx,%rbx,1)
  35:	75 4a                	jne    0x81
  37:	48 8b 17             	mov    (%rdi),%rdx
  3a:	48                   	rex.W
  3b:	81                   	.byte 0x81
  3c:	fa                   	cli
  3d:	30 02                	xor    %al,(%rdx)


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
