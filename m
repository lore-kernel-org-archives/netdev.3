Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F93B27CE
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887353; cv=none; b=LzfdeLO6otqbBn4SnRKCIgz8KauJTonNLR3PfrOObvtDqgERhzYv7j1qRSbUrL9kpr16G9J4DZmw9BUZbr7RddEv3gbLkuBfoENr59XgGvxTCz05GrlObV/fmFhDNAKiL77usj8GqtySWZSM6zzlITxYEGv/rT3EhhvWqD/Blqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887353; c=relaxed/simple;
	bh=51kAgZR5SNBt2Fbi9EDBjUxr/TMHN+zbP67rSF62djk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e+mM5gIeRx1A2+edXH48TV6emRs6sfYcyF/4M4AggU6bDlVisuDtvw6fsLR4B462kBppc4dPto9MCYVlgDSd6Zfi8sVx24uIDGLpCoukxC4hrYB0MksgtvCDufl8SSrKJwo94B5L3v33kylTvU6uLF0wKqpSAhFnT6c/f5v248M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4ab4f652f9bso112903b6e.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 03:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784887350; x=1785492150;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Azn/3IlpuHexJrCgDq1Ifv1DPRfYixXp1wh4CkIlWE=;
        b=JHYKiGWc3vHzqm3sefbfqMo9Hkoo9Z7Y3bopDmC18KjhHI3Dz26+a+GWipyC9mFCs8
         PJK3ulT5o4yaTyw12Z1oqUMqprs7DeD8bvwllaqM8aX/wfq0UK5ICn+o13J1xMAt13gO
         93Mmr4nKYrtCSq3zykVcrJ3UAf+frINgzI5fYz+czPj6qaKMjVc//7I3lE/SanQl0Drz
         wKkF7MGQLBpKr7jaCdK+UsKbVHE44aJ8EkMpYxQ96vEvTTz5Yd/cpPGk3dWcCkrMQHz2
         H32GaoES5eAogxIBPOXyyXaBoWlKawlj/fcGxIewswHGZFNLEkDPGolPqNOH0Ed+LALf
         e6Cw==
X-Forwarded-Encrypted: i=1; AHgh+RpbaAJvhz58tzhTtwmM+Zy9CuSwmdU10xvEvzXr2VLz9lUhgFkmqbIjL+G4UCZN+UMaG6wWOz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHuP7JDrrHeqnEKN6uu/cUwqD1W7g5qts5xaV/Hw0QnkT7UFz
	ciuHf0mo4RbrmqJMOycsGz+30VS9K5DyT7rGZ6TjUL1paMgQp4R/h2C5nDtVSievx+t2SfT+OTX
	daiajw9TFW5JzByGmWj+fAH8bQkhWJjYnbX8NCTDk7+IgoKnNY5EimMnuZUI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1693:b0:492:5684:7ab3 with SMTP id
 5614622812f47-4ab3544d448mr3520909b6e.21.1784887350478; Fri, 24 Jul 2026
 03:02:30 -0700 (PDT)
Date: Fri, 24 Jul 2026 03:02:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a633836.dde6c935.cf6c8.0014.GAE@google.com>
Subject: [syzbot] [mm?] possible deadlock in hugetlb_vma_lock_free (2)
From: syzbot <syzbot+fa1191e3d726401b23b5@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org, 
	osalvador@suse.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    298bb2b89033 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=142cbcb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c4196ba0e33631d
dashboard link: https://syzkaller.appspot.com/bug?extid=fa1191e3d726401b23b5
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8628d381680d/disk-298bb2b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f050ac40f048/vmlinux-298bb2b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b07d34fb709a/bzImage-298bb2b8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa1191e3d726401b23b5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.1342/12219 is trying to acquire lock:
ffff88805e3b2a70 (&vma_lock->rw_sema){++++}-{4:4}, at: hugetlb_vma_lock_free+0xb7/0x1a0 mm/hugetlb.c:415

but task is already holding lock:
ffff88807ed9d950 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
ffff88807ed9d950 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: hugetlbfs_file_mmap+0x2de/0x630 fs/hugetlbfs/inode.c:139

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #9 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}:
       down_write+0x96/0x200 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1024 [inline]
       hugetlbfs_file_mmap+0x2de/0x630 fs/hugetlbfs/inode.c:139
       vfs_mmap include/linux/fs.h:2066 [inline]
       mmap_file mm/internal.h:167 [inline]
       __mmap_new_file_vma mm/vma.c:2496 [inline]
       __mmap_new_vma mm/vma.c:2562 [inline]
       __mmap_region mm/vma.c:2774 [inline]
       mmap_region+0x19e6/0x2310 mm/vma.c:2860
       do_mmap+0xc3b/0x10c0 mm/mmap.c:560
       vm_mmap_pgoff+0x272/0x4e0 mm/util.c:581
       ksys_mmap_pgoff+0x57d/0x760 mm/mmap.c:606
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #8 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault+0xcb/0x130 mm/memory.c:7292
       _copy_from_iter+0x100/0x1660 lib/iov_iter.c:271
       copy_from_iter include/linux/uio.h:228 [inline]
       copy_from_iter_full include/linux/uio.h:245 [inline]
       skb_do_copy_data_nocache include/net/sock.h:2327 [inline]
       skb_copy_to_page_nocache include/net/sock.h:2353 [inline]
       tcp_sendmsg_locked+0x2620/0x55c0 net/ipv4/tcp.c:1310
       tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1451
       sock_sendmsg_nosec+0x10e/0x180 net/socket.c:776
       __sock_sendmsg net/socket.c:790 [inline]
       sock_write_iter+0x2de/0x3e0 net/socket.c:1241
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x612/0xba0 fs/read_write.c:687
       ksys_write+0x150/0x270 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #7 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x41/0x100 net/core/sock.c:3825
       lock_sock include/net/sock.h:1713 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:913
       nbd_mark_nsock_dead+0x2cb/0x550 drivers/block/nbd.c:318
       recv_work+0x1cee/0x1e10 drivers/block/nbd.c:1021
       process_one_work kernel/workqueue.c:3322 [inline]
       process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #6 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x373/0x1150 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0x499/0x1990 block/blk-mq.c:2117
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xd36/0x1580 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0x16c/0x300 block/blk-mq.c:2532
       process_one_work kernel/workqueue.c:3322 [inline]
       process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #5 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       nbd_queue_rq+0xc1/0x1150 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0x499/0x1990 block/blk-mq.c:2117
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xd36/0x1580 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0x16c/0x300 block/blk-mq.c:2532
       process_one_work kernel/workqueue.c:3322 [inline]
       process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #4 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xc9/0x2f0 kernel/rcu/srcutree.c:1481
       elevator_switch+0x1e8/0x7b0 block/elevator.c:576
       elevator_change+0x2fa/0x480 block/elevator.c:681
       elevator_set_default+0x375/0x440 block/elevator.c:754
       blk_register_queue+0x3f3/0x4e0 block/blk-sysfs.c:992
       __add_disk+0x6cb/0xe30 block/genhd.c:524
       add_disk_fwnode+0x100/0x3a0 block/genhd.c:593
       add_disk include/linux/blkdev.h:800 [inline]
       nbd_dev_add+0x733/0xb60 drivers/block/nbd.c:2021
       nbd_init+0x15f/0x1e0 drivers/block/nbd.c:2729
       do_one_initcall+0x250/0x870 init/main.c:1347
       do_initcall_level+0x10a/0x1a0 init/main.c:1409
       do_initcalls+0x59/0xa0 init/main.c:1425
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1658
       kernel_init+0x1d/0x1d0 init/main.c:1548
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       elevator_change+0x1af/0x480 block/elevator.c:679
       elevator_set_none+0xb5/0x140 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5101 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5146 [inline]
       blk_mq_update_nr_hw_queues+0x5ef/0x19f0 block/blk-mq.c:5211
       nbd_start_device+0x189/0xb30 drivers/block/nbd.c:1526
       nbd_genl_connect+0x1597/0x1c10 drivers/block/nbd.c:2276
       genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
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

-> #2 (&q->q_usage_counter(io)#51){++++}-{0:0}:
       blk_alloc_queue+0x544/0x690 block/blk-core.c:504
       blk_mq_alloc_queue block/blk-mq.c:4420 [inline]
       __blk_mq_alloc_disk+0x194/0x390 block/blk-mq.c:4467
       nbd_dev_add+0x494/0xb60 drivers/block/nbd.c:1991
       nbd_init+0x15f/0x1e0 drivers/block/nbd.c:2729
       do_one_initcall+0x250/0x870 init/main.c:1347
       do_initcall_level+0x10a/0x1a0 init/main.c:1409
       do_initcalls+0x59/0xa0 init/main.c:1425
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1658
       kernel_init+0x1d/0x1d0 init/main.c:1548
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4329 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4343
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4565 [inline]
       slab_alloc_node mm/slub.c:4925 [inline]
       __kmalloc_cache_noprof+0x61/0x660 mm/slub.c:5511
       _kmalloc_noprof include/linux/slab.h:969 [inline]
       allocate_file_region_entries+0x1ef/0x5a0 mm/hugetlb.c:688
       region_chg mm/hugetlb.c:808 [inline]
       __vma_reservation_common+0x7c2/0x9c0 mm/hugetlb.c:2446
       vma_needs_reservation mm/hugetlb.c:2513 [inline]
       alloc_hugetlb_folio+0x2de/0x1630 mm/hugetlb.c:2884
       hugetlb_no_page+0xfdd/0x1fc0 mm/hugetlb.c:5761
       hugetlb_fault+0x570/0x12c0 mm/hugetlb.c:5993
       handle_mm_fault+0x1f42/0x3080 mm/memory.c:6684
       faultin_page mm/gup.c:1126 [inline]
       __get_user_pages+0x1678/0x2720 mm/gup.c:1428
       populate_vma_page_range+0x2be/0x3c0 mm/gup.c:1860
       __mm_populate+0x25f/0x390 mm/gup.c:1963
       mm_populate include/linux/mm.h:4171 [inline]
       vm_mmap_pgoff+0x353/0x4e0 mm/util.c:586
       ksys_mmap_pgoff+0x57d/0x760 mm/mmap.c:606
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&vma_lock->rw_sema){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1520/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
       down_write+0x96/0x200 kernel/locking/rwsem.c:1631
       hugetlb_vma_lock_free+0xb7/0x1a0 mm/hugetlb.c:415
       hugetlb_reserve_pages+0xce6/0x1140 mm/hugetlb.c:6714
       hugetlbfs_file_mmap+0x475/0x630 fs/hugetlbfs/inode.c:153
       vfs_mmap include/linux/fs.h:2066 [inline]
       mmap_file mm/internal.h:167 [inline]
       __mmap_new_file_vma mm/vma.c:2496 [inline]
       __mmap_new_vma mm/vma.c:2562 [inline]
       __mmap_region mm/vma.c:2774 [inline]
       mmap_region+0x19e6/0x2310 mm/vma.c:2860
       do_mmap+0xc3b/0x10c0 mm/mmap.c:560
       vm_mmap_pgoff+0x272/0x4e0 mm/util.c:581
       ksys_mmap_pgoff+0x57d/0x760 mm/mmap.c:606
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &vma_lock->rw_sema --> &mm->mmap_lock --> &sb->s_type->i_mutex_key#24

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#24);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#24);
  lock(&vma_lock->rw_sema);

 *** DEADLOCK ***

2 locks held by syz.0.1342/12219:
 #0: ffff88807c66a9f8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:554 [inline]
 #0: ffff88807c66a9f8 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x1dd/0x4e0 mm/util.c:579
 #1: ffff88807ed9d950 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
 #1: ffff88807ed9d950 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: hugetlbfs_file_mmap+0x2de/0x630 fs/hugetlbfs/inode.c:139

stack backtrace:
CPU: 1 UID: 0 PID: 12219 Comm: syz.0.1342 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x1520/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 down_write+0x96/0x200 kernel/locking/rwsem.c:1631
 hugetlb_vma_lock_free+0xb7/0x1a0 mm/hugetlb.c:415
 hugetlb_reserve_pages+0xce6/0x1140 mm/hugetlb.c:6714
 hugetlbfs_file_mmap+0x475/0x630 fs/hugetlbfs/inode.c:153
 vfs_mmap include/linux/fs.h:2066 [inline]
 mmap_file mm/internal.h:167 [inline]
 __mmap_new_file_vma mm/vma.c:2496 [inline]
 __mmap_new_vma mm/vma.c:2562 [inline]
 __mmap_region mm/vma.c:2774 [inline]
 mmap_region+0x19e6/0x2310 mm/vma.c:2860
 do_mmap+0xc3b/0x10c0 mm/mmap.c:560
 vm_mmap_pgoff+0x272/0x4e0 mm/util.c:581
 ksys_mmap_pgoff+0x57d/0x760 mm/mmap.c:606
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f075639de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f07572fb028 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f0756626090 RCX: 00007f075639de99
RDX: 0000000002000002 RSI: 0000000000c00000 RDI: 0000200000000000
RBP: 00007f0756433eaf R08: ffffffffffffffff R09: 00000000aba00000
R10: 0000000000042073 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0756626128 R14: 00007f0756626090 R15: 00007fff5a82f7c8
 </TASK>


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
