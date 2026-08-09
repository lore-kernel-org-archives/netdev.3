Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FE3403E7;
	Sun,  9 Aug 2026 01:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786240707; cv=none; b=EwuJC+XaObpkTBjf7awsgEWW+KBjXS6UYg9O1eVwGg207cuLZ1b2boEFjeEqP/nx6JL5gefszZxjKybEz7aipxsP+MNyhevvy7nT8mEu1vXIiGVk4lak2XuZHy/dIrvWdNoI6k3dDhy54/M7Ix60VlnKJmgeuycVQJFK3A4wi3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786240707; c=relaxed/simple;
	bh=PYSjsMnXjL6Tb1ount6lfZvEm+MdIekhS+zanzi1zrE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OfHlIbMMhgxOvqQHymVj7YosTeCgdYgzkKwvNd6R8pC4nZpxoxLIeh6POn2pZgOfgLWs0yygxQ1QZOXW91MAxDbW/poURgoDDfTYjDT7Mn4wX1MNrnqArWpVXZjUsRb7HRb+dYI1qz55tmzMyO04NXJ7uaNtULQJlQ4RMp6uEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iGT/4ts8; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iGT/4ts8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786240696; bh=uEmMr/SZK/TIaWoHbQ3q9ghn3gK6KxbhUQcK+NWFVAE=;
	h=Date:To:Cc:From:Subject;
	b=iGT/4ts812Spmd3DNJsWxhM0skdJT5uUu3yhFnaf3kon9yyUGzTPGdFdadQ0VUrCn
	 loMH1UAR2aV6mInuv6VJPsci8N5TYIXTP0YLPgXWjNL8NvM6wukBhziVJfBmJ/VrNp
	 W1vVynpWEGDRj+NY7C4ZoYWtsP6QtsJ1GzBtqtU4=
Received: from [IPV6:2409:8a00:7893:9e40:542c:be54:7415:4303] ([2409:8a00:7893:9e40:542c:be54:7415:4303])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id E8E362D0; Sun, 09 Aug 2026 09:58:14 +0800
X-QQ-mid: xmsmtpt1786240694t69dn9xkh
Message-ID: <tencent_CD62BCA17CDEAE677233BDA9A0D9455E5708@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRVM9oEWjk6jDgCfDsjqAiWO5pbWclUjWSDbc4CInAg4Lh/0zPRh
	 7vxuedA6d1VL3h943Bqa8E53F1OQSs/5hDaA9R9x118odEttk3t9tsoUE/UKfc1dK6MIggaMUtR8
	 ipCkvoeMu0r7Je2QrAthYOzwynyUfAISU1d7hur1qeUuh6t9mBcAOCXomUh5KAOrMy73Uhd6+dOj
	 UxfQ0qGsd+tsSLJYpqgw/mmRMgvpEdziaqFCIGeS4Rx7sQKZSrY5JZqeS/V/Aeg0+0cO9QQ2nY8v
	 Nn8PSGstiw8oU/02SByOiCzhv02hnTHwDYq089YPTxFYWG4RDVTeqPcF4AScMHnhFBU1kX75I32B
	 wbBIHK+ZgLCn0rjLdfEEjWxXkwqPtx6ccFbnomcTRmrlCccmAM/5YqI4wVPd1+xmY9FdtyQQT1ZJ
	 g4ojUEok2/cccb9sotQhFQFDNpGFM7bDM1uwBvAKvPaYbGDv4rLMJs+VYqgp0ML+8g9BP3HBmd+k
	 asVbBH4Tz5ibrHFEAJhZ2/UX12X/sxLsJ4r1DLsJZJmcCOlfKLoa80195CYd7tRhfXyqnFc3B9mG
	 psvid2fsTqTH3rVf1/pFgiAIR/a543imrY53koa65jtscww1ECXw9fIAp1WQltAhIyPTWYdLvSYJ
	 omOkXPBHPMMpwMVnPsyNdZdvRTAzvLaUTtV/Yx9RGhDljG3IwIhtaGEDJdsFYKH/40c/TCsGw/Wo
	 5IFIv8wZsgJWe6VUcrfc4T/o4kSXNDRlKSuBbrwaudIYIrCjiqcSRyNfJoDZBQ7nN179lJFQKXRg
	 GxgMw6N2aDJffVaENVEjexdcigejRJGp556bX/tVzUJGFlOVCpmeeSJieJAwvHZ1oO7ok0Wf5RAY
	 U1f5rtjksbbAz/iNEZoysSZ9+FEP6wbDWFo8Zj4lfI0j8ZpBpUWnJuurHkrQuRXkBFbZx3K4y92l
	 IdqbfQ5eTxDdcbPM12pRPbRI/N5o1XlH2Ja4fJ8Zpri6xP+VJICjh3ugziYkmQYNSWwvcBMdjk8X
	 FzNPvydzQie+bA5MqDFpGar4QF/+Xex3Iy/EKIKxtG4pCTbOQr52y07sdM5zuPu+/1g3c3Hzhgub
	 1j+N5woVwO3RSXZZs=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-OQ-MSGID: <8170ae9d-8649-4a17-b427-569aa2c4c806@qq.com>
Date: Sun, 9 Aug 2026 09:58:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [BUG] KASAN: slab-use-after-free in enqueue_timer (re-armed timer on
 freed skbuff) [mgag200] [syzkaller]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

While fuzzing the kernel with syzkaller (KASAN), I triggered a
slab-use-after-free in the core timer wheel. A periodic (self-rearming) IPv6
addrconf `rs_timer` was fired in softirq after its host skbuff had already been
freed, and its `mod_timer()` wrote into the freed slab slot.

Reproducer summary :

    BUG: KASAN: slab-use-after-free in enqueue_timer+0x59/0x280 kernel/time/timer.c:616
    BUG: KASAN: slab-use-after-free in hlist_add_head include/linux/list.h:1075 [inline]
    Write of size 8 at addr ffff8880164ac28c8 by task syz.0.4/818
    Call trace:
      __run_timers -> expire_timers -> call_timer_fn
        addrconf_rs_timer  net/ipv6/addrconf.c:4061
        addrconf_mod_rs_timer  net/ipv6/addrconf.c:332
        __mod_timer -> enqueue_timer  kernel/time/timer.c:612
          hlist_add_head  list.h:1075   <-- UAF Write (8B)

The corrupted 704-byte object belongs to `skbuff_small_head` (offset 584,
i.e. the embedded timer_list region). It was allocated by an skb that mgag200's
uevent broadcast created during driver registration/probe, and released via
`consume_skb -> skb_free_head -> kfree`. The timer base still holds an active,
rearming RK/RS timer pointing into that freed object; when the softirq fires
it re-queues it, writing 8 bytes and corrupting the freed slab.

Root cause:  a device / driver with an active, self-rearming IPv6 `addrconf` RS
timer is torn down (device removed/unloaded - e.g. mgag200 remove path) without
first cancelling the timer with `del_timer_sync()`. Once the host object is
freed, the pending timer re-arms itself on freed memory (classic mode-B family:
“timer not removed on driver shutdown → cascade UAF”).

The crash stack trace shows below:

BUG: KASAN: slab-use-after-free in hlist_add_head include/linux/list.h:1075 [inline]
BUG: KASAN: slab-use-after-free in enqueue_timer+0x59/0x280 kernel/time/timer.c:616
Write of size 8 at addr ffff8880164288c8 by task syz.0.4/818

CPU: 0 UID: 0 PID: 818 Comm: syz.0.4 Tainted: G        W  O        7.1.0 #2 PREEMPT(lazy) 
Tainted: [W]=WARN, [O]=OOT_MODULE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0xa2/0xd0 lib/dump_stack.c:120
 print_address_description+0x77/0x200 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 hlist_add_head include/linux/list.h:1075 [inline]
 enqueue_timer+0x59/0x280 kernel/time/timer.c:616
 __mod_timer+0x625/0x840 kernel/time/timer.c:-1
 addrconf_mod_rs_timer+0x36/0xd0 net/ipv6/addrconf.c:332
 addrconf_rs_timer+0x280/0x320 net/ipv6/addrconf.c:4061
 call_timer_fn+0xfb/0x2c0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x4ad/0x6d0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0x32/0x70 kernel/time/timer.c:2405
 handle_softirqs+0x1a2/0x560 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xa7/0x180 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0x6e/0x80 arch/x86/kernel/apic/apic.c:1061
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:__orc_find arch/x86/kernel/unwind_orc.c:103 [inline]
RIP: 0010:orc_module_find arch/x86/kernel/unwind_orc.c:121 [inline]
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:248 [inline]
RIP: 0010:unwind_next_frame+0x474/0x14a0 arch/x86/kernel/unwind_orc.c:510
Code: c1 f8 02 49 c1 ed 3f 49 01 c5 49 83 e5 fe 4b 8d 1c 6f 48 89 df e8 7c 8a 50 00 4b 63 04 6f 48 01 d8 4c 39 e0 76 bf 4b 8d 2c 6f <48> 83 c5 fc 49 39 ef 76 c3 48 8b 04 24 48 2b 44 24 30 48 c1 f8 02
RSP: 0018:ffff88800b91e5a0 EFLAGS: 00000202
RAX: ffffffffc002e234 RBX: ffffffffc0283d2c RCX: ffffffff81349f04
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffffffffc0283d2c
RBP: ffffffffc0283d2c R08: 00000000000200ec R09: ffffffffffffffff
R10: dffffc0000000000 R11: ffffffff814fd3d0 R12: ffffffffc000f3d3
R13: 00000000000016ac R14: ffffffffc026ffac R15: ffffffffc0280fd4
 arch_stack_walk+0x131/0x160 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x45/0x70 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5296 [inline]
 __kmalloc_noprof+0x237/0x6e0 mm/slub.c:5308
 <alloc::raw_vec::RawVecInner>::finish_grow+0x7d/0xb0 [kt_runtime]
 <alloc::raw_vec::RawVec<u8>>::grow_one+0x3f/0x70 [kt_runtime]
 __kerneltracker_log_integer_cmp_with_graph+0x174/0x590 [kt_runtime]
 mgag200_g200_init_registers drivers/gpu/drm/mgag200/mgag200_g200.c:48 [inline] [mgag200]
 mgag200_g200_device_create+0x55df/0x5a40 drivers/gpu/drm/mgag200/mgag200_g200.c:392 [mgag200]
 </TASK>

Allocated by task 814:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x4b/0x60 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_node_noprof+0x1db/0x5e0 mm/slub.c:4951
 kmalloc_reserve net/core/skbuff.c:613 [inline]
 __alloc_skb+0x230/0x4a0 net/core/skbuff.c:713
 alloc_skb include/linux/skbuff.h:1385 [inline]
 alloc_uevent_skb+0x5c/0x120 lib/kobject_uevent.c:289
 uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
 kobject_uevent_net_broadcast+0x23f/0x420 lib/kobject_uevent.c:410
 kobject_uevent_env+0x447/0x450 lib/kobject_uevent.c:611
 driver_register+0x1e2/0x220 drivers/base/driver.c:257
 drm_pci_register_driver_if_modeset+0x125/0xf20 drivers/gpu/drm/mgag200/mgag200_bmc.c:24 [mgag200]
 do_init_module+0x125/0x3f0 kernel/module/main.c:3106
 init_module_from_file kernel/module/main.c:3777 [inline]
 idempotent_init_module kernel/module/main.c:3789 [inline]
 __do_sys_finit_module kernel/module/main.c:3815 [inline]
 __se_sys_finit_module+0x2c7/0x410 kernel/module/main.c:3799
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14b/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 135:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x3a/0x60 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kfree+0x1c1/0x550 mm/slub.c:6566
 skb_kfree_head net/core/skbuff.c:1075 [inline]
 skb_free_head net/core/skbuff.c:1087 [inline]
 skb_release_data+0x5a6/0x690 net/core/skbuff.c:1114
 skb_release_all net/core/skbuff.c:1189 [inline]
 __kfree_skb net/core/skbuff.c:1203 [inline]
 consume_skb+0x106/0x180 net/core/skbuff.c:1436
 netlink_recvmsg+0x3a9/0x570 net/netlink/af_netlink.c:1977
 sock_recvmsg_nosec net/socket.c:1138 [inline]
 sock_recvmsg+0x138/0x140 net/socket.c:1160
 ____sys_recvmsg+0xf5/0x280 net/socket.c:2919
 ___sys_recvmsg+0x117/0x300 net/socket.c:2961
 __sys_recvmsg net/socket.c:2994 [inline]
 __do_sys_recvmsg net/socket.c:3000 [inline]
 __se_sys_recvmsg net/socket.c:2997 [inline]
 __x64_sys_recvmsg+0xd5/0x170 net/socket.c:2997
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14b/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888016428680
 which belongs to the cache skbuff_small_head of size 704
The buggy address is located 584 bytes inside of
 freed 704-byte region [ffff888016428680, ffff888016428940)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16428
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x100000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0100000000000040 ffff888008b8adc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000800130013 00000000f5000000 0000000000000000
head: 0100000000000040 ffff888008b8adc0 dead000000000122 0000000000000000
head: 0000000000000000 0000000800130013 00000000f5000000 0000000000000000
head: 0100000000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffff8880164291c0 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888016428780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888016428800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888016428880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888016428900: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888016428980: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb

Regards,
Yang Zi

