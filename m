Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867028;
	b=J3EuhA9aYArrmIcXcc7RuowzKMOcjBak9QbU23kSRuKuXB4ZM6xfaa++NIGISI2Pxac3
	 H+owIIaN+NKQxGnHfbSvIR3qzOeWJSwMLuYbiijaPwKCpZGdy3/p14l8uJOmobQNNWWh6
	 Srxsr2U1ErvLI9gNM0TLJLrB4LRGPrOAmTqYX+Rdp6LuEzrD9IjLjz4FaCEl0hZ6+/lEU
	 e+XatIZBR2xcQLlGdhujMoC6HuIMbxPaeHicVJ7q/h89rstM03GgIgewdFrILZuPlFE8n
	 ki0uYu/+WiN6eTjNQzHivWHd9JPlIAKEPGGJKiECabFtwUTcGJDdRVtVgI0WDBeodHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867028;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=NI1GgIgXNQObAgyI4VamVXZkG9i7zMwG2QWU7SC7WiU=;
	b=XxDwbkWLGUzrfAisIzEUhYJpTdAvieRt7MQ1pErb4PpkO2xv7UETLsJM03wWQszCvxDf
	 PyGmS5Uhxdrdgfrifr0JEQ9vwN1KZIRlMQkWs56CVewWI/euKOXqqDXXnIqwQLe5JKA1j
	 BKLGmPDKljzuj6eflP6xi/P7mZ74wVaY6rULxvnB+MH5zhJ4ETGbwykfnjFBA0pTNIT/I
	 gLaS45DBiHdpLIZU/lqadybR8SO/VYrwSRi+6iSfGfgdgZiuxesyHN8YFtAhdBiL2v/hj
	 yhMD/lMUM+q7i8tE51f4pdbooy6c8eN93z01vB4orSOlM1hUkiWiHlgRansxKeWcOMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF95606A32E
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 08:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEF95606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a45b3f0bdfso2537798b6e.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 00:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793867026; x=1794471826;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NI1GgIgXNQObAgyI4VamVXZkG9i7zMwG2QWU7SC7WiU=;
        b=gQ4r5yhBb3o4cqvoABGFa5mqkzXYtPSMU3YjQjabg8A47Bi5aJWozsLSh9CiVLsyOE
         uvIjJmGsIAceceV2GHlrai5QDGDEn519I6UoKY3nMNP3XNFc57xJUR8zozUxLhRA+kQS
         fd6nfg9KRfXHJ8rPOadmKn0BeanrmDZcV3MYIQoezuYkD32yHd40hXZYwkRLSeIV65Ep
         i2NnFMKG1FeoZ28LaTOQ0aFsUqw3+Zy8V0eVO/Hbe/cY9WUz1B/vP+cnD0U+CIkCpNXX
         8RmCwvy5y1HmuxsqiVSgPlajoAXlwfkeRZKnyJnkT6H6G6a9/VtrXfvtcxgZLmPE1LcO
         O7ow==
X-Forwarded-Encrypted: i=1; AKwUvBy7c8Xlv179kgCzEAMYbAZqfRnMzaqbGNLVMtnRYpUH+ajHFm4llt+4KxDzDyO7PU76LYNS3f8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ju0RTyT97t9g4B28FfyJcMer1ibZjfpdRtBMAxPsFYi57BNYb
	aNugUH+zhfVVJe6ySAB0jjrUEh3ED9PRA+5osVNh5nVAd1JbAF8pZEatSYXu6iyIrBxcyUzHKgJ
	qfSpOrhWPTuUITyvlE26YWHHQbscOM1eo36oXuFvNIpM0HwGwpv6AWNyzDKc=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:e8d4:20b0:564:48f3:df91 with SMTP id
 5614622812f47-56448f3e1fbmr6077549b6e.12.1793867026656; Thu, 05 Nov 2026
 00:23:46 -0800 (PST)
Date: Thu, 05 Nov 2026 00:23:46 -0800
In-Reply-To: <6acd1c88.a150a118.27e199.0053.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aec3d12.f31022ea.233d2f.0004.GAE@google.com>
Subject: Re: [syzbot] [nfc?] KASAN: slab-out-of-bounds Read in pn533_recv_frame
From: syzbot <syzbot+93f169a8e7d66864f800@syzkaller.appspotmail.com>
To: chandradhar.2003@gmail.com, david@ixit.cz, krzk@kernel.org, 
	linux-kernel@vger.kernel.org, michael.thalmeier@hale.at, 
	netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, sameo@linux.intel.com, 
	shreeramrahul94@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8b7179210b22 Add linux-next specific files for 20261104
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1472fca1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5dad87d6a9d5ee90
dashboard link: https://syzkaller.appspot.com/bug?extid=93f169a8e7d66864f800
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1641aca1580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c09edd580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24dabb992a55/disk-8b717921.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/efb6c59219d5/vmlinux-8b717921.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ced4d906c236/bzImage-8b717921.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+93f169a8e7d66864f800@syzkaller.appspotmail.com

PN533 RX: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PN533 RX: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PN533 RX: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
PN533 RX: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
BUG: KASAN: slab-out-of-bounds in hex_dump_to_buffer+0x36c/0xd70 lib/hexdump.c:194
Read of size 1 at addr ffff888027737a00 by task swapper/1/0

CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 hex_dump_to_buffer+0x36c/0xd70 lib/hexdump.c:194
 print_hex_dump+0x16b/0x2b0 lib/hexdump.c:277
 pn533_recv_frame+0x5f6/0x6d0 drivers/nfc/pn533/pn533.c:2202
 __usb_hcd_giveback_urb+0x378/0x540 drivers/usb/core/hcd.c:1658
 dummy_timer+0xa9a/0x4ce0 drivers/usb/gadget/udc/dummy_hcd.c:2051
 __run_hrtimer kernel/time/hrtimer.c:2079 [inline]
 __hrtimer_run_queues+0x3bc/0xa10 kernel/time/hrtimer.c:2136
 hrtimer_run_softirq+0x1e3/0x2e0 kernel/time/hrtimer.c:2153
 handle_softirqs+0x265/0x8d0 kernel/softirq.c:669
 __do_softirq kernel/softirq.c:703 [inline]
 invoke_softirq kernel/softirq.c:542 [inline]
 __irq_exit_rcu+0xc6/0x220 kernel/softirq.c:786
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:809
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1073 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1073
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:finish_task_switch+0x413/0xc60 kernel/sched/core.c:5434
Code: 04 00 00 41 c7 84 24 20 0e 00 00 00 00 00 00 0f 1f 44 00 00 49 83 c4 48 4c 89 e7 e8 c7 56 89 0a e8 22 92 3a 00 fb 4c 8b 65 c8 <49> 8d bc 24 18 17 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: 0018:ffffc900001c7be0 EFLAGS: 00000206
RAX: 000000000008812b RBX: ffff8880b833d3a0 RCX: 8000000000000001
RDX: 0000000000000000 RSI: ffffffff8e9ef560 RDI: ffffffff8cb01080
RBP: ffffc900001c7c30 R08: ffffffff91e104bf R09: 1ffffffff23c2097
R10: dffffc0000000000 R11: fffffbfff23c2098 R12: ffff88801fa99f40
R13: ffff88801fa99f40 R14: dffffc0000000000 R15: 1ffff11017067a74
 context_switch kernel/sched/core.c:5586 [inline]
 __schedule+0x17e5/0x5830 kernel/sched/core.c:7382
 schedule_idle+0x51/0x90 kernel/sched/core.c:7500
 do_idle+0x4ad/0x540 kernel/sched/idle.c:384
 cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:458
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x157
 </TASK>

Allocated by task 0:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3f/0x90 mm/kasan/common.c:79
 unpoison_slab_object mm/kasan/common.c:354 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:380
 kasan_slab_alloc include/linux/kasan.h:257 [inline]
 slab_post_alloc_hook mm/slub.c:4716 [inline]
 slab_alloc_node mm/slub.c:5029 [inline]
 kmem_cache_alloc_node_noprof+0x34f/0x600 mm/slub.c:5101
 kmalloc_reserve net/core/skbuff.c:616 [inline]
 __alloc_skb+0x27a/0x7a0 net/core/skbuff.c:716
 alloc_skb include/linux/skbuff.h:1390 [inline]
 pn533_recv_response+0xc4/0x230 drivers/nfc/pn533/usb.c:65
 __usb_hcd_giveback_urb+0x378/0x540 drivers/usb/core/hcd.c:1658
 dummy_timer+0xa9a/0x4ce0 drivers/usb/gadget/udc/dummy_hcd.c:2051
 __run_hrtimer kernel/time/hrtimer.c:2079 [inline]
 __hrtimer_run_queues+0x3bc/0xa10 kernel/time/hrtimer.c:2136
 hrtimer_run_softirq+0x1e3/0x2e0 kernel/time/hrtimer.c:2153
 handle_softirqs+0x265/0x8d0 kernel/softirq.c:669
 __do_softirq kernel/softirq.c:703 [inline]
 invoke_softirq kernel/softirq.c:542 [inline]
 __irq_exit_rcu+0xc6/0x220 kernel/softirq.c:786
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:809
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1073 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1073
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

The buggy address belongs to the object at ffff888027737740
 which belongs to the cache skbuff_small_head of size 704
The buggy address is located 0 bytes to the right of
 allocated 704-byte region [ffff888027737740, ffff888027737a00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27734
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888140a9bdc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000200130013 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff888140a9bdc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000200130013 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5650, tgid 5650 (syz-executor223), ts 84263979260
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1874
 prep_new_page+0x22/0xb0 mm/page_alloc.c:1882
 get_page_from_freelist+0x22a1/0x22e0 mm/page_alloc.c:3964
 __alloc_frozen_pages_noprof+0x211/0x450 mm/page_alloc.c:5506
 alloc_slab_page mm/slub.c:3382 [inline]
 allocate_slab+0x7d/0x5e0 mm/slub.c:3497
 new_slab mm/slub.c:3548 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7522
 refill_sheaf mm/slub.c:2915 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4807
 alloc_from_pcs mm/slub.c:4883 [inline]
 slab_alloc_node mm/slub.c:5017 [inline]
 kmem_cache_alloc_node_noprof+0x432/0x600 mm/slub.c:5101
 kmalloc_reserve net/core/skbuff.c:616 [inline]
 __alloc_skb+0x27a/0x7a0 net/core/skbuff.c:716
 napi_alloc_skb+0x86/0xaf0 net/core/skbuff.c:856
 page_to_skb+0x240/0x1780 drivers/net/virtio_net.c:880
 receive_mergeable drivers/net/virtio_net.c:2426 [inline]
 receive_buf+0x720/0x1b60 drivers/net/virtio_net.c:2596
 virtnet_receive_packets drivers/net/virtio_net.c:2921 [inline]
 virtnet_receive drivers/net/virtio_net.c:2945 [inline]
 virtnet_poll+0x22bf/0x3100 drivers/net/virtio_net.c:3040
 __napi_poll+0xaa/0x330 net/core/dev.c:7985
 napi_poll net/core/dev.c:8048 [inline]
 net_rx_action+0x61d/0xf50 net/core/dev.c:8205
 handle_softirqs+0x265/0x8d0 kernel/softirq.c:669
page last free pid 5317 tgid 5317 ts 54559667751 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1416 [inline]
 __free_frozen_pages+0xd1a/0xe10 mm/page_alloc.c:2972
 __slab_free+0x269/0x2c0 mm/slub.c:5922
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:364
 kasan_slab_alloc include/linux/kasan.h:257 [inline]
 slab_post_alloc_hook mm/slub.c:4716 [inline]
 slab_alloc_node mm/slub.c:5029 [inline]
 kmem_cache_alloc_noprof+0x2b4/0x600 mm/slub.c:5043
 vm_area_alloc+0x24/0x140 mm/vma_init.c:36
 __mmap_new_vma mm/vma.c:2765 [inline]
 __mmap_region mm/vma.c:3119 [inline]
 mmap_region+0x18e8/0x2820 mm/vma.c:3201
 do_mmap+0xe0a/0x1300 mm/mmap.c:573
 vm_mmap_pgoff+0x27a/0x520 mm/util.c:581
 ksys_mmap_pgoff+0x4dc/0x760 mm/mmap.c:619
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x16a/0x530 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888027737900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888027737980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888027737a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888027737a80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027737b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	41 c7 84 24 20 0e 00 	movl   $0x0,0xe20(%r12)
   9:	00 00 00 00 00
   e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  13:	49 83 c4 48          	add    $0x48,%r12
  17:	4c 89 e7             	mov    %r12,%rdi
  1a:	e8 c7 56 89 0a       	call   0xa8956e6
  1f:	e8 22 92 3a 00       	call   0x3a9246
  24:	fb                   	sti
  25:	4c 8b 65 c8          	mov    -0x38(%rbp),%r12
* 29:	49 8d bc 24 18 17 00 	lea    0x1718(%r12),%rdi <-- trapping instruction
  30:	00
  31:	48 89 f8             	mov    %rdi,%rax
  34:	48 c1 e8 03          	shr    $0x3,%rax
  38:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
  3d:	84 c0                	test   %al,%al


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
