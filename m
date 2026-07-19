Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7FB346E55
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784485052; cv=none; b=Df0KpoBBS89j7k7a1pPOB40AnOY1M5ysyH+d8ea11JhlZz1krh/xwSPi+FnAd1QPtt02JTze7Std2+y0MZ/HpMLTLbMl4qDIU41aDCLgyddSQf5DKAhiwNXgijkUiQRZ3c8hYBPomQY0uit40nmShGggNUaimTW1f43bOWMWa7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784485052; c=relaxed/simple;
	bh=crs/b9s5b0UVw901NN5FTW7P3cfzgx1JTMV1MUXbrdc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dcfQXmX8J9xLjM9dMTwAs75vebohLwCWGGWTM641nDrnUCuCfxGcatSKG9l/O+Fnkb4HvXExq4HsKQ+Rqk+U6v6vcavHY8wTXqXMVT8FXFkLnUg91m8rmE1ZU2JAA8N9AVFuofBxMoZagHbRFaUqTbtOR0Sk1hLQXTP3PwNCwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4a41e3d6fe9so12697523b6e.2
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 11:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784485049; x=1785089849;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3IhFjGpG+Wpj3TAEbVXnnE0L77BBCG2fqqrXSAb+BVE=;
        b=AZp+WnRrTaHMADMlhUR9EtZmn5ZOu6btRu+4vHFMuRr4H5AR7OI/hoyRZuJ93kfwdR
         P61gppVQ6HUtWLL+emQxm2xFYDGOyOq9Lo5zta8RAmhUFjulabxlqbo4jpaNOBcnkyzQ
         MweQG1mQDsmcGLy5Kn2I6TKtEc5+v96t2ESm1y2GpHlSyKkIEAo8zcL2atXbBT/9uojD
         W7yDXw0DcKuzOsLJU2uHzTo2lISjbjkMTL29FO0FynBU4fh2+/Bi/Iir1pvClhNvFJeh
         5djcO87YmyGtBjzutMhohb5y/S2J9LZc3ntBphp4NoQFKQHuHuMqD3PIit+v3BsegkRG
         Lg0A==
X-Forwarded-Encrypted: i=1; AHgh+RrdwekK+TSLBPmkMm89G9zDfPkEqm94/76ixAY3XKuqtQFOfle9KKeKmdUhJz4238NXnHZj8A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlQOvfL297M3HR7L8uL/563O+fh4X69/F4G/1RMIi0u+kIuMbY
	pqRejtPX5d3KOJPSb8qk8oNQJgi1riEMHOsFWcx1GyHVIYcIWsRYkKcuAgjVMB9+AmGLfRF0+DG
	s6vU40ndBnbmSyWERE1npvH1/PlCZv14n6dW1SzMxidYsoa918MIdzVdsmSM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:19a4:b0:4a3:3108:866a with SMTP id
 5614622812f47-4a4d01e7283mr7419073b6e.17.1784485048961; Sun, 19 Jul 2026
 11:17:28 -0700 (PDT)
Date: Sun, 19 Jul 2026 11:17:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a5d14b8.42649fcc.6186.0078.GAE@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in kernfs_iop_permission (2)
From: syzbot <syzbot+90c39e7098489ce1def1@syzkaller.appspotmail.com>
To: driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f1f75536668 net: openvswitch: reject oversized nested act..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=108e8789580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c4196ba0e33631d
dashboard link: https://syzkaller.appspot.com/bug?extid=90c39e7098489ce1def1
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/38c0534858bd/disk-3f1f7553.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3140a6e2252d/vmlinux-3f1f7553.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f8a7156a6da0/bzImage-3f1f7553.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90c39e7098489ce1def1@syzkaller.appspotmail.com

netlink: 'syz.3.10493': attribute type 1 has an invalid length.
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.3.10493/14209 is trying to acquire lock:
ffff88801c294210 (&root->kernfs_iattr_rwsem){++++}-{4:4}, at: kernfs_iop_permission+0x7f/0x430 fs/kernfs/inode.c:288

but task is already holding lock:
ffffffff8e9e75f0 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2535 [inline]
ffffffff8e9e75f0 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_procs_write_start+0x539/0x900 kernel/cgroup/cgroup.c:3100

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (cpu_hotplug_lock){++++}-{0:0}:
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       cpus_read_lock+0x42/0x160 kernel/cpu.c:490
       static_key_slow_inc+0x12/0x30 kernel/jump_label.c:190
       nbd_reconnect_socket drivers/block/nbd.c:1379 [inline]
       nbd_genl_reconfigure+0x1301/0x1e80 drivers/block/nbd.c:2468
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
       __add_disk+0x6cb/0xe30 block/genhd.c:528
       add_disk_fwnode+0xfb/0x4b0 block/genhd.c:597
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

-> #2 (&q->q_usage_counter(io)#52){++++}-{0:0}:
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
       kmem_cache_alloc_noprof+0x64/0x5f0 mm/slub.c:4959
       __kernfs_iattrs+0xdd/0x380 fs/kernfs/inode.c:36
       kernfs_iattrs fs/kernfs/inode.c:60 [inline]
       __kernfs_setattr fs/kernfs/inode.c:73 [inline]
       kernfs_iop_setattr+0xe6/0x3f0 fs/kernfs/inode.c:127
       notify_change+0xbba/0xea0 fs/attr.c:556
       do_truncate+0x1c2/0x250 fs/open.c:68
       handle_truncate fs/namei.c:4305 [inline]
       do_open fs/namei.c:4704 [inline]
       path_openat+0x2fed/0x3830 fs/namei.c:4863
       do_file_open+0x23e/0x4a0 fs/namei.c:4892
       do_sys_openat2+0x115/0x200 fs/open.c:1368
       do_sys_open fs/open.c:1374 [inline]
       __do_sys_openat fs/open.c:1390 [inline]
       __se_sys_openat fs/open.c:1385 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1385
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&root->kernfs_iattr_rwsem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1520/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
       down_read+0x4a/0x330 kernel/locking/rwsem.c:1574
       kernfs_iop_permission+0x7f/0x430 fs/kernfs/inode.c:288
       do_inode_permission fs/namei.c:583 [inline]
       inode_permission+0x3de/0x5f0 fs/namei.c:653
       cgroup_may_write kernel/cgroup/cgroup.c:5325 [inline]
       cgroup_procs_write_permission kernel/cgroup/cgroup.c:5345 [inline]
       cgroup_attach_permissions+0x28e/0x9f0 kernel/cgroup/cgroup.c:5368
       __cgroup_procs_write+0x24b/0x320 kernel/cgroup/cgroup.c:5411
       cgroup_threads_write+0x24/0x50 kernel/cgroup/cgroup.c:5441
       cgroup_file_write+0x331/0x8f0 kernel/cgroup/cgroup.c:4316
       kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x612/0xba0 fs/read_write.c:687
       ksys_write+0x150/0x270 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &root->kernfs_iattr_rwsem --> &nsock->tx_lock --> cpu_hotplug_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(cpu_hotplug_lock);
                               lock(&nsock->tx_lock);
                               lock(cpu_hotplug_lock);
  rlock(&root->kernfs_iattr_rwsem);

 *** DEADLOCK ***

4 locks held by syz.3.10493/14209:
 #0: ffff8880355be450 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2733 [inline]
 #0: ffff8880355be450 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x22b/0xba0 fs/read_write.c:683
 #1: ffff888029df8c80 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1d8/0x540 fs/kernfs/file.c:336
 #2: ffffffff8eb99560 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_lock include/linux/cgroup.h:456 [inline]
 #2: ffffffff8eb99560 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0x13c/0x230 kernel/cgroup/cgroup.c:1717
 #3: ffffffff8e9e75f0 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2535 [inline]
 #3: ffffffff8e9e75f0 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_procs_write_start+0x539/0x900 kernel/cgroup/cgroup.c:3100

stack backtrace:
CPU: 0 UID: 0 PID: 14209 Comm: syz.3.10493 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/25/2026
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
 down_read+0x4a/0x330 kernel/locking/rwsem.c:1574
 kernfs_iop_permission+0x7f/0x430 fs/kernfs/inode.c:288
 do_inode_permission fs/namei.c:583 [inline]
 inode_permission+0x3de/0x5f0 fs/namei.c:653
 cgroup_may_write kernel/cgroup/cgroup.c:5325 [inline]
 cgroup_procs_write_permission kernel/cgroup/cgroup.c:5345 [inline]
 cgroup_attach_permissions+0x28e/0x9f0 kernel/cgroup/cgroup.c:5368
 __cgroup_procs_write+0x24b/0x320 kernel/cgroup/cgroup.c:5411
 cgroup_threads_write+0x24/0x50 kernel/cgroup/cgroup.c:5441
 cgroup_file_write+0x331/0x8f0 kernel/cgroup/cgroup.c:4316
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3c8819de59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3c890ee028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3c88425fa0 RCX: 00007f3c8819de59
RDX: 0000000000000012 RSI: 0000200000000c40 RDI: 000000000000000b
RBP: 00007f3c88233e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3c88426038 R14: 00007f3c88425fa0 R15: 00007fffbdb3ac08
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
