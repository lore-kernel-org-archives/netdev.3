Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11296207A32
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786321409; cv=none; b=TdYjO+ki2ZbtfJpS2COGMZedeC89p0228QyO1JTucG3SJh1qCqimRQbB/CsuS79IEr/1BuRBxdlTFZlvIipjibfFUjQ8IQT9DFB0brEh3Va2LBaak1oCpv5Zsz0rzH2Bo5Tn3XvMk01rMMgnH4yD7W3dKTb5oVwBvUPauXWU9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786321409; c=relaxed/simple;
	bh=qm8LABPELvkllpS0TBT6PNFecL6IvXCnPy0cjAkw2sY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fHQowNj+6H4f86FztH2CnrdONl2+bJD6mJ61e9mivbF5l8ITz2EM2L4Xlxou3CUxw9ZuvzWv79W1efexZZNrSfZjLY0CBgCyHHGH3ckEkGI9qhi5jyFRt0wFgx4u3+6s0dnVVGFMaQc3iA9p2aVBvxYsXrTYLX3wDhFaSau9oGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-49f3a97f1caso852182b6e.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 17:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786321407; x=1786926207;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=biw8+KEd9p5P7Ve2i/RpSLqWuOxWajehnU628jqJQ3A=;
        b=HMCjje2qLL/uDN1BCOSe+/9Lgf+/NzJYoVQjsuHMvPpHiiAXNOMJ6IM5befNpOpo37
         hjlY3o064HIUqJo/4++F+lDm05Es+2zwvCKxbZ6r0wK2z4eStN+1KDPv5CEUONSwdJig
         h4KbVHVcBDpMFhAN+jJBCJI3wol575+6nMGyUhwM2Kkw2GHeDqbI3M2QgbdXVp7AygbN
         XlMx5bn9lGqpJ3IG6I7UKga7La9VnU7zh1JaBbrDZHCRKYzRea0eKd1Yr4Tm8TRnsi1J
         Az86HaiyaQxxUcO4m35JeYQVEx3TlNkvwDw1Ms+0NoDY7gGvwX9gWOAA6YfViI9GUphw
         DTTw==
X-Forwarded-Encrypted: i=1; AHgh+RrbhJoXp7FBGajq9kMGiBnz9VcYqQOkH4QPaAJIcyiAFduD96a6ouS+uZ11PlvrmydF7dLa/ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxofE1591H4nE5i/w0CnMCVDrYH/cl1PRYNXX6RUXNYwPHstTBy
	rO35AuQSbwF/JT35ywCKWVyptH/+Co3qDzAvL592+MUl9HfAyNufv9yoNRoinEG9z7A8r7yA/Yq
	bDtgneYyNWhkrCQAqDPoDILVs+IGlnG7HwTQSA5uaCNH2y4v3Oaeo9v+WQMI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1688:b0:495:e0a9:8c0 with SMTP id
 5614622812f47-4b1ab96cd2fmr8055787b6e.11.1786321406991; Sun, 09 Aug 2026
 17:23:26 -0700 (PDT)
Date: Sun, 09 Aug 2026 17:23:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7919fe.9c11d2ce.289b96.00df.GAE@google.com>
Subject: [syzbot] [net?] [afs?] KASAN: slab-use-after-free Read in rxrpc_destroy_all_peers
From: syzbot <syzbot+c876adfab6362679008c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06cf61899d64 Merge tag 'x86-urgent-2026-08-08' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16765fb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=c876adfab6362679008c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/260ea970a68e/disk-06cf6189.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0005e8a7195f/vmlinux-06cf6189.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f061ed2152ca/bzImage-06cf6189.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c876adfab6362679008c@syzkaller.appspotmail.com

rxrpc: Leaked peer e1 {1} [0000:0000:0000:0000:0000:0000:0000:0001]:7003
==================================================================
BUG: KASAN: slab-use-after-free in rxrpc_destroy_all_peers+0x1ce/0x1d0 net/rxrpc/peer_object.c:461
Read of size 8 at addr ffff88803528cc20 by task kworker/u8:6/1029

CPU: 0 UID: 0 PID: 1029 Comm: kworker/u8:6 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 rxrpc_destroy_all_peers+0x1ce/0x1d0 net/rxrpc/peer_object.c:461
 rxrpc_exit_net+0x83/0xc0 net/rxrpc/net_ns.c:114
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x2ee/0xab0 net/core/net_namespace.c:252
 cleanup_net+0x499/0x920 net/core/net_namespace.c:702
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5852:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2e5/0x6c0 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 rxrpc_alloc_peer+0xa7/0x400 net/rxrpc/peer_object.c:229
 rxrpc_create_peer net/rxrpc/peer_object.c:293 [inline]
 rxrpc_lookup_peer+0x168/0x680 net/rxrpc/peer_object.c:354
 rxrpc_kernel_lookup_peer+0xa8/0xe0 net/rxrpc/af_rxrpc.c:285
 afs_merge_fs_addr6+0x186/0x460 fs/afs/addr_list.c:344
 afs_parse_text_addrs+0x3f2/0xa10 fs/afs/addr_list.c:222
 afs_alloc_cell fs/afs/cell.c:181 [inline]
 afs_lookup_cell+0xbb6/0x1940 fs/afs/cell.c:273
 afs_proc_cells_write+0x2a3/0x3a0 fs/afs/proc.c:125
 proc_simple_write+0x10e/0x1a0 fs/proc/generic.c:843
 pde_write fs/proc/inode.c:330 [inline]
 proc_reg_write+0x240/0x330 fs/proc/inode.c:342
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
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

The buggy address belongs to the object at ffff88803528cc00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 32 bytes inside of
 freed 512-byte region [ffff88803528cc00, ffff88803528ce00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3528c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe21c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe21c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 16783483369, free_ts 0
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
 __kmalloc_node_track_caller_noprof+0x679/0x830 mm/slub.c:5471
 __do_krealloc mm/slub.c:6837 [inline]
 krealloc_node_align_noprof+0x1f9/0x3e0 mm/slub.c:6858
 add_sysfs_param+0xdb/0x970 kernel/params.c:648
 kernel_add_sysfs_param kernel/params.c:797 [inline]
 param_sysfs_builtin kernel/params.c:836 [inline]
 param_sysfs_builtin_init+0x310/0x3f0 kernel/params.c:972
 do_one_initcall+0x11d/0x700 init/main.c:1347
 do_initcall_level init/main.c:1409 [inline]
 do_initcalls init/main.c:1425 [inline]
 do_basic_setup init/main.c:1445 [inline]
 kernel_init_freeable+0x6ea/0x7b0 init/main.c:1658
 kernel_init+0x1f/0x1e0 init/main.c:1548
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803528cb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803528cb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88803528cc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88803528cc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803528cd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
