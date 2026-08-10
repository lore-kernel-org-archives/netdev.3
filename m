Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4913DC4CD
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368153; cv=none; b=W4QyD2ULd/41WOcTfmeNvoDRyHaN/ivxXpjYrN476JM/LVdWFz4/b8AO5b33Oi7OcXB6BDP9P7UVwTaFogus3VeltUd+5p8YHLTWUD3l5CadNT3V4aGMoJmvy2MBfZM1XId2cFAi3Ik+ILLgQfMjG/ldWWV/Cu5W/z/MpXBH8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368153; c=relaxed/simple;
	bh=0j0LkihhU2HfDwCxV3ZnnCFJ9C3P29IZwcnP1B+/jc4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hCr4LbhJQOWvPd0MuzcfOwrmkwj1Jis8oMF0pF/8S3XRa4KMTzlBJJ5lDB+8L6ooCilomyF1EfrqAxpKJyIGupaX/0OhL0nMeTH5gJ2IJfJHpTnBXE5FNE20bTFb7oQmT/7iQwuBpmugxskObIHPRNU+RDME+xDnWMxWOtuCR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-448bb8bd2efso2855813fac.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786368150; x=1786972950;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zGFY1rwDSMn7vEJbSqDTZ+lj7ayPZ3xuZ6mjzSCn2KM=;
        b=gA8g9o4s9Qhxh7HOfKUKoH8ZhaWZfAqjZdeeN4YD8zBvMPptPBXzLRSCYVD7FYBt8M
         EuicmakhqA3ftpJAD6YGn6EhrlzWrmnK2dblk/kDGoTeUBdIzNWRpFXIdFY1BIDKY4bg
         bUzwe+Y5C4cS/DYUWenNY/EaFKrjTvFoPcfHfMG2SoDH7wsHfzJ3qliBYIK2w5UB+c/K
         2uLp7tAXlpsDDKgtJMTQn5iEHU0sQMfSMkBNXKGj6a4iewcMCIzYFkUCQSdnucYEEnxc
         hS4XptJSmAt7uUKFZBvSLbzEaKThJC6gQokVdaFwYfAqyrBjlh1QO8LJ2zv0SUpYAMYr
         +8uw==
X-Forwarded-Encrypted: i=1; AHgh+RpOFfETEaWv/O3+WtRkWqyKCXoTVn74A0t6IsaRIgQPwTY+1lTOh7i5ZWq+cG8GjjdU7tFwBKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6PTbdRPbWRVlxYGrC3+j1EU2yobRx9Hgm/o6OqFDEyHmwgqJM
	ukQU8/OCC1baevnfMC+bpnFfngTGWW7zSVyGQbpPkpJCdzhesXVreHO31eMrYwnOGBBiJPMVxqB
	r8zWX1oGau2gDiRcS6t4u/qcs0WcE2YWJ++4R02b+oqKQGWwvcpd/9i4PAaM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee14:0:b0:6ac:b80e:76b0 with SMTP id
 006d021491bc7-6b041eb0f8bmr10576185eaf.3.1786368150395; Mon, 10 Aug 2026
 06:22:30 -0700 (PDT)
Date: Mon, 10 Aug 2026 06:22:30 -0700
In-Reply-To: <6a7919fe.9c11d2ce.289b96.00df.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a79d096.9c11d2ce.289b96.00ed.GAE@google.com>
Subject: Re: [syzbot] [afs?] [net?] KASAN: slab-use-after-free Read in rxrpc_destroy_all_peers
From: syzbot <syzbot+c876adfab6362679008c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    db2ddb871435 Linux 7.2-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152cd079580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=c876adfab6362679008c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e35132580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c876adfab6362679008c@syzkaller.appspotmail.com

rxrpc: Leaked peer 4dfc {1} 127.0.0.1:8051
rxrpc: Leaked peer 5009 {1} 127.0.0.1:8167
rxrpc: Leaked peer 5726 {1} 127.0.0.1:8581
rxrpc: Leaked peer 5523 {0} 127.0.0.1:8374
==================================================================
BUG: KASAN: slab-use-after-free in rxrpc_destroy_all_peers+0x1ce/0x1d0 net/rxrpc/peer_object.c:461
Read of size 8 at addr ffff888054f70c20 by task kworker/u8:3/48

CPU: 0 UID: 0 PID: 48 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full) 
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

Allocated by task 6240:
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
 afs_merge_fs_addr4+0x1cd/0x4c0 fs/afs/addr_list.c:300
 afs_parse_text_addrs+0x655/0xa10 fs/afs/addr_list.c:220
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

Freed by task 16:
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
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_call_function_single arch/x86/kernel/smp.c:267 [inline]
 sysvec_call_function_single+0xa3/0xc0 arch/x86/kernel/smp.c:267
 asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:681

The buggy address belongs to the object at ffff888054f70c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 32 bytes inside of
 freed 512-byte region [ffff888054f70c00, ffff888054f70e00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x54f70
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
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6240, tgid 6240 (syz-executor166), ts 101070694469, free_ts 79760049897
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
 rxrpc_alloc_peer+0xa7/0x400 net/rxrpc/peer_object.c:229
 rxrpc_create_peer net/rxrpc/peer_object.c:293 [inline]
 rxrpc_lookup_peer+0x168/0x680 net/rxrpc/peer_object.c:354
 rxrpc_kernel_lookup_peer+0xa8/0xe0 net/rxrpc/af_rxrpc.c:285
 afs_merge_fs_addr4+0x1cd/0x4c0 fs/afs/addr_list.c:300
 afs_parse_text_addrs+0x655/0xa10 fs/afs/addr_list.c:220
 afs_alloc_cell fs/afs/cell.c:181 [inline]
 afs_lookup_cell+0xbb6/0x1940 fs/afs/cell.c:273
 afs_proc_cells_write+0x2a3/0x3a0 fs/afs/proc.c:125
 proc_simple_write+0x10e/0x1a0 fs/proc/generic.c:843
 pde_write fs/proc/inode.c:330 [inline]
 proc_reg_write+0x240/0x330 fs/proc/inode.c:342
page last free pid 5674 tgid 5674 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 free_pages_prepare+0x586/0xd80 mm/page_alloc.c:1451
 __free_contig_range_common+0x14f/0x250 mm/page_alloc.c:6897
 __free_contig_range mm/page_alloc.c:6942 [inline]
 free_pages_bulk+0x12a/0x200 mm/page_alloc.c:5257
 vm_area_free_pages+0xad/0x2b0 mm/vmalloc.c:3461
 vfree mm/vmalloc.c:3510 [inline]
 vfree+0x107/0x750 mm/vmalloc.c:3484
 kcov_put kernel/kcov.c:447 [inline]
 kcov_put kernel/kcov.c:443 [inline]
 kcov_close+0x34/0x60 kernel/kcov.c:554
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x951/0x2ae0 kernel/exit.c:1009
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1152
 get_signal+0x1ec7/0x21e0 kernel/signal.c:3046
 arch_do_signal_or_restart+0x91/0x7e0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x139/0x6f0 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x666/0x870 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888054f70b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888054f70b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888054f70c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888054f70c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888054f70d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
