Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FD337C0F6
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784455359; cv=none; b=We0a/JDrNSXXVmtNb1m9LdbH8A4nVZsTVjWFoIxsSTzAFc/9TZN+474Px+yaNxxMDg2g2KZrMiz6yPvRc8nuOefu1SfGfa9E3FkltMiD7C5TBIz83nfSNCXL6mawckvyoqndTpNdtUlhW7rmmphK8fnaZj2WhBUbSG/C4nutcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784455359; c=relaxed/simple;
	bh=DgLVtKBYdCZ3ZSKKr+1TuSdaE16fFiCUusT4zT7eJ1Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C/OvGN7JzMnD7WHFiUHkVnhOfwmXa3orWEbOpZo3FLalMoxx36X06KzJijFFr12t8/Jd+xQZHBjdIRjPKVyauMdpjFaX0OkARJaLVn1yDIUIVrnyZyR5jju2ERAHwR1RJ9jtpnERlcMNL3QlCHIsutxbVwWAeTS7H9rmC1HUHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-49ce04870f8so15085492b6e.0
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 03:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784455351; x=1785060151;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZPWkpjpVol+Me5ls3242hGcDbY0V8vwyU9apwdRZsZI=;
        b=fJux28156a2DvdmIEiJzRnOQseArf2OI3fO7+yFRw3FDP+2OG4j8etKQ3Tasl9hgoo
         wVDeC/gRxnHC7t3mxbMTyaiGXsuxgo4lBcDnAOtbl5OVIqN3ISV8jCBNo/jQqUyhYXGf
         NRwOEbwWHL1MLVyY4J6MMBiXvJ27ZwPgkypEcriVM2lsWgx4/OxnH9A3Y/n/PQy+Nv5G
         k/ehBY40h96y4OqXX6cxHcKkrdyNm2FpW7VWOsYFQZarfmp8ucr+1G0cXnXlKFbAFOL+
         hwStNt99XbLgtnlfzVFzG2uI2XnqAVKvRwE0mweanx7H6blMwOI4v5bfRXYtT4ZsltpW
         H+yQ==
X-Forwarded-Encrypted: i=1; AHgh+RoF9hrNgjPG/4o95zm8NzGsXDXFb+Ajh6OZHh0wx6Sj32hHDotm2G2eOE20sc06k+cuo04pPtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQy7qeKsK7jqvjzzlIbzFdUTiI4JQnv1udWyGhfIoAMAy/VnMX
	kB1Rj0Mw425lzldaJViUjfJwfv8tbfF6hWA/4sU5XENCnxrtu7CZkqFz63mXHh95MjlN8WSZDhn
	03RJZ+XdlSnzWLR1gj8nUuKGSyHlz4Z8oAMhfEuSCm6whw8sAnx2WzZ7pT00=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:444b:b0:4a2:ca6b:4214 with SMTP id
 5614622812f47-4a4d0357287mr5531957b6e.29.1784455351253; Sun, 19 Jul 2026
 03:02:31 -0700 (PDT)
Date: Sun, 19 Jul 2026 03:02:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a5ca0b7.f1649fcc.2a4208.03f3.GAE@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in kernfs_remove_by_name_ns (2)
From: syzbot <syzbot+b50eba6bf6cd3f8ba7d0@syzkaller.appspotmail.com>
To: driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56d96fededd6 mpls: fix NULL deref in mpls_valid_fib_dump_r..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=136d4746580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c4196ba0e33631d
dashboard link: https://syzkaller.appspot.com/bug?extid=b50eba6bf6cd3f8ba7d0
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8a219d5f8172/disk-56d96fed.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc2c4acbf659/vmlinux-56d96fed.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2f3b2152262f/bzImage-56d96fed.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b50eba6bf6cd3f8ba7d0@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kworker/0:1/21181 is trying to acquire lock:
ffff88801c295180 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x4e/0x140 fs/kernfs/dir.c:1792

but task is already holding lock:
ffff88801c2952a0 (&root->kernfs_supers_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x3f/0x140 fs/kernfs/dir.c:1791

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #10 (&root->kernfs_supers_rwsem){++++}-{4:4}:
       down_read+0x4a/0x330 kernel/locking/rwsem.c:1574
       kernfs_remove_by_name_ns+0x3f/0x140 fs/kernfs/dir.c:1791
       kernfs_remove_by_name include/linux/kernfs.h:644 [inline]
       create_files fs/sysfs/group.c:66 [inline]
       internal_create_group+0x58e/0x1180 fs/sysfs/group.c:189
       internal_create_groups fs/sysfs/group.c:229 [inline]
       sysfs_update_groups+0x60/0x130 fs/sysfs/group.c:273
       pmu_dev_alloc+0x29b/0x300 kernel/events/core.c:12772
       perf_event_sysfs_init+0x76/0x100 kernel/events/core.c:15368
       do_one_initcall+0x250/0x870 init/main.c:1347
       do_initcall_level+0x10a/0x1a0 init/main.c:1409
       do_initcalls+0x59/0xa0 init/main.c:1425
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1658
       kernel_init+0x1d/0x1d0 init/main.c:1548
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #9 (pmus_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       perf_event_init_cpu+0x1d1/0x7a0 kernel/events/core.c:15270
       cpuhp_invoke_callback+0x434/0x810 kernel/cpu.c:194
       cpuhp_thread_fun+0x362/0x780 kernel/cpu.c:1109
       smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #8 (cpuhp_state-up){+.+.}-{0:0}:
       cpuhp_lock_acquire kernel/cpu.c:103 [inline]
       cpuhp_thread_fun+0x127/0x780 kernel/cpu.c:1086
       smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

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

-> #2 (&q->q_usage_counter(io)#54){++++}-{0:0}:
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
       kmem_cache_alloc_lru_noprof+0x65/0x5f0 mm/slub.c:4978
       alloc_inode+0xb8/0x1b0 fs/inode.c:340
       iget_locked+0x131/0x6a0 fs/inode.c:1477
       kernfs_get_inode+0x4f/0x770 fs/kernfs/inode.c:252
       kernfs_fill_super fs/kernfs/mount.c:308 [inline]
       kernfs_get_tree+0x5cd/0x980 fs/kernfs/mount.c:392
       vfs_get_tree+0x92/0x2a0 fs/super.c:1694
       fc_mount fs/namespace.c:1198 [inline]
       do_new_mount_fc fs/namespace.c:3765 [inline]
       do_new_mount+0x319/0xdc0 fs/namespace.c:3841
       do_mount fs/namespace.c:4174 [inline]
       __do_sys_mount fs/namespace.c:4390 [inline]
       __se_sys_mount+0x31d/0x420 fs/namespace.c:4367
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&root->kernfs_rwsem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1520/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
       down_write+0x96/0x200 kernel/locking/rwsem.c:1631
       kernfs_remove_by_name_ns+0x4e/0x140 fs/kernfs/dir.c:1792
       _cfg80211_unregister_wdev+0x133/0x5a0 net/wireless/core.c:1420
       ieee80211_if_remove+0x289/0x340 net/mac80211/iface.c:2432
       ieee80211_del_iface+0x19/0x30 net/mac80211/cfg.c:254
       rdev_del_virtual_intf net/wireless/rdev-ops.h:62 [inline]
       cfg80211_remove_virtual_intf+0x221/0x3f0 net/wireless/util.c:3006
       cfg80211_destroy_ifaces+0x23f/0x300 net/wireless/core.c:436
       cfg80211_destroy_iface_wk+0x21/0x30 net/wireless/core.c:464
       process_one_work kernel/workqueue.c:3322 [inline]
       process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  &root->kernfs_rwsem --> pmus_lock --> &root->kernfs_supers_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&root->kernfs_supers_rwsem);
                               lock(pmus_lock);
                               lock(&root->kernfs_supers_rwsem);
  lock(&root->kernfs_rwsem);

 *** DEADLOCK ***

5 locks held by kworker/0:1/21181:
 #0: ffff88801b02b140 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88801b02b140 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc900041dfc40 ((work_completion)(&rdev->destroy_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc900041dfc40 ((work_completion)(&rdev->destroy_work)){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffffffff9002c040 (rtnl_mutex){+.+.}-{4:4}, at: cfg80211_destroy_iface_wk+0x19/0x30 net/wireless/core.c:463
 #3: ffff888088e907a0 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6884 [inline]
 #3: ffff888088e907a0 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_destroy_ifaces+0x233/0x300 net/wireless/core.c:434
 #4: ffff88801c2952a0 (&root->kernfs_supers_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x3f/0x140 fs/kernfs/dir.c:1791

stack backtrace:
CPU: 0 UID: 0 PID: 21181 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Workqueue: events cfg80211_destroy_iface_wk
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
 kernfs_remove_by_name_ns+0x4e/0x140 fs/kernfs/dir.c:1792
 _cfg80211_unregister_wdev+0x133/0x5a0 net/wireless/core.c:1420
 ieee80211_if_remove+0x289/0x340 net/mac80211/iface.c:2432
 ieee80211_del_iface+0x19/0x30 net/mac80211/cfg.c:254
 rdev_del_virtual_intf net/wireless/rdev-ops.h:62 [inline]
 cfg80211_remove_virtual_intf+0x221/0x3f0 net/wireless/util.c:3006
 cfg80211_destroy_ifaces+0x23f/0x300 net/wireless/core.c:436
 cfg80211_destroy_iface_wk+0x21/0x30 net/wireless/core.c:464
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
