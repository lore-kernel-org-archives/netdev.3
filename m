Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877104;
	b=ynWoWamONC9JzvQV3yQ63ap7+1goCvOlmSuKEqzQXYwc9t0bCKIa+Du7MPgtwvjBLR1n
	 J934+5nTIxX4VRCYS39VlUZn6j1cfj6j7lC49XHa0sgW8N5cSv19mNVhhGMplCS/4v5X8
	 CYIM5W5KFdpsvYlglH6Zhylp6j7pLqJg+kR3zDXKPJwPBuznv/ALfPKhRWnYn7INBMEuo
	 PmR1i7mZeIK+jsQ+9q1mp9Nf0ZDgWHJOYGo2P6nIT05NO+GB5lv1X7sOLWfHwhk11y5dY
	 zo5XW0evfOFxC6s676s6PhFEiFUe/Sa6W26z40p2OQK+9Qac18QQ/4tx8vYAEZUK/MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877104;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=3jVc4SI3dwrhCHlixWzw1rVfq5AqGHNQ1RV/3qjkXoU=;
	b=WvX+cnjlabruJHM7rVv92Tp8jK6s3WvBhBi5KRmFSYd41ONF7pLDI7PjxPwQcxxLIzWC
	 PeesdeukawR8q6yxvo1uZh31Tme32BppR/sS7JBENFqVEiOquyFNS+SB02jmeezd2yK1M
	 MnJTVlgXdlF03jzGHeQ12gxQ1Y69uiNUUFIucI26VnxR2vla7K0qMAszf2gG4EXowm6Ha
	 CXREOb98JOVIaUGat2SYIQmxRJkc+doEA4sB3yEz/x5jziGq6f97woXLNH2Hehr1LsUwd
	 07cIFuKlt+xh4M1Ubab5OrH5wCXMNxSkFYWMSzYBEtvF3G/cI6vl9hTKWAghWJxstmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C3606EE90
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D1C3606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4a41f46d629so2617338b6e.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 03:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877103; x=1794481903;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3jVc4SI3dwrhCHlixWzw1rVfq5AqGHNQ1RV/3qjkXoU=;
        b=zCVc0TMmDkDumsJsXLrSdhSu6QvACBN6hlUzZPes8/N1EOdEHkAmU2eA6HVXDUb9J+
         RQkcuCGsKKr1aaLh4QeTloQALARDC05bHnSBh9bhFQTN/Xnt0ja1oEyvyaP9IxPiQeD3
         /6rI0Dzww4FuEIdqFCMksyrrMhkysExQnPiVdtIvQq2xN81Bo0yr4mcsKuVSZ2ZDVdp1
         LH/WmYqocrY8TGHccTRyTF/52+jz24yj+aQqY+WMPjUSIc1NTjjpvClkhWX5a0hQSTmx
         WR2s6Xa7r6psU5EaBRju+EKyqv6H3M9hFJJGYrq14f9HwUviE7wNRqbQSgsOTAePro6A
         9h1A==
X-Forwarded-Encrypted: i=1; AKwUvByJCBZQUrViwexBZMC99zHLMrPfDCjCMQPaC/bC3O51cBsIQ7+sg7+GJU9PPPevbO4mcd3ehto=@vger.kernel.org
X-Gm-Message-State: APuU4Z85Qp4IqQMMwciJgOUi+0cXAr1QnRjwTw85Ir2s/ugQw5gfvHuv
	8MyMWfoA3+Sig57agO4l5tuHJmOdmRP/+vNWsF3dPaeQQm0Z775AUu6WUFk9YveqLO9P8irAUQE
	Y3rgYGAIG72LgLdj9VYKtMfOFETuig0msU2NXvmzP174Fr3D6eNYiVXn4/1k=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c40a:b0:4b9:e65b:8c33 with SMTP id
 5614622812f47-5640ddb8b16mr12457733b6e.33.1793877103079; Thu, 05 Nov 2026
 03:11:43 -0800 (PST)
Date: Thu, 05 Nov 2026 03:11:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aec646f.aca85a03.3b899.0000.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in sk_stream_wait_memory
From: syzbot <syzbot+a761911cb2560f3ca2f7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    03897066069f tipc: raise the minimum bearer MTU to fit tun..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12215969580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d30e1495ee3ac817
dashboard link: https://syzkaller.appspot.com/bug?extid=a761911cb2560f3ca2f7
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4416adab3ebe/disk-03897066.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2165a756da2b/vmlinux-03897066.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d949ba699d8b/bzImage-03897066.xz

AI-generated root cause summary:
In drivers/block/nbd.c, nbd_add_socket() reclassifies user-supplied socket locks
to sk_lock-AF_INET-NBD using nbd_reclassify_socket(). Because the socket was
obtained via sockfd_lookup(), userspace retains access to the socket file
descriptor and can issue sendto()/sendmsg() calls on it. During userspace
transmission, tcp_sendmsg() holds lock_sock(sk) (sk_lock-AF_INET-NBD) while
copying user data, creating a dependency on &mm->mmap_lock via page faults.
Concurrently, memory allocations while holding &mm->mmap_lock can trigger direct
reclaim (fs_reclaim) to write back dirty pages through the NBD block device
(nbd_queue_rq), which acquires &nsock->tx_lock and subsequently lock_sock(sk)
(sk_lock-AF_INET-NBD), creating an ABBA circular locking dependency between
&mm->mmap_lock and sk_lock-AF_INET-NBD.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=a761911cb2560f3ca2f7

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a761911cb2560f3ca2f7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.4.7408/2091 is trying to acquire lock:
ffff888036f0a800 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0xaf/0x130 mm/memory.c:7530

but task is already holding lock:
ffff8880760ed1e0 (sk_lock-AF_INET-NBD){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1717 [inline]
ffff8880760ed1e0 (sk_lock-AF_INET-NBD){+.+.}-{0:0}, at: sk_stream_wait_memory+0x8de/0xff0 net/core/stream.c:148

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (sk_lock-AF_INET-NBD){+.+.}-{0:0}:
       lock_sock_nested+0x41/0x100 net/core/sock.c:3908
       lock_sock include/net/sock.h:1717 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:911
       nbd_mark_nsock_dead+0x2cb/0x550 drivers/block/nbd.c:319
       recv_work+0x1d14/0x1e30 drivers/block/nbd.c:1030
       process_one_work kernel/workqueue.c:3495 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #6 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x373/0xff0 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0x499/0x1990 block/blk-mq.c:2131
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xd36/0x1580 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0x167/0x2f0 block/blk-mq.c:2546
       process_one_work kernel/workqueue.c:3495 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #5 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       nbd_queue_rq+0xc1/0xff0 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0x499/0x1990 block/blk-mq.c:2131
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xd36/0x1580 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0x167/0x2f0 block/blk-mq.c:2546
       process_one_work kernel/workqueue.c:3495 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #4 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:225 [inline]
       __synchronize_srcu+0xca/0x2f0 kernel/rcu/srcutree.c:1662
       elevator_switch+0x1e8/0x7b0 block/elevator.c:576
       elevator_change+0x2fa/0x480 block/elevator.c:681
       elevator_set_default+0x375/0x440 block/elevator.c:754
       blk_register_queue+0x404/0x4f0 block/blk-sysfs.c:992
       __add_disk+0x6b8/0xdb0 block/genhd.c:531
       add_disk_fwnode+0x100/0x3a0 block/genhd.c:600
       add_disk include/linux/blkdev.h:801 [inline]
       nbd_dev_add+0x733/0xb60 drivers/block/nbd.c:2026
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2743
       do_one_initcall+0x250/0x870 init/main.c:1419
       do_initcall_level+0x10a/0x1a0 init/main.c:1481
       do_initcalls+0x59/0xa0 init/main.c:1497
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1732
       kernel_init+0x22/0x1d0 init/main.c:1622
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       elevator_change+0x1af/0x480 block/elevator.c:679
       elevator_set_none+0xb5/0x140 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5114 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5159 [inline]
       blk_mq_update_nr_hw_queues+0x5ef/0x19e0 block/blk-mq.c:5224
       nbd_start_device+0x189/0xb30 drivers/block/nbd.c:1530
       nbd_genl_connect+0x167d/0x1cd0 drivers/block/nbd.c:2310
       genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2584
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
       netlink_unicast+0x8ef/0xa80 net/netlink/af_netlink.c:1361
       netlink_sendmsg+0x7f0/0xb20 net/netlink/af_netlink.c:1920
       sock_sendmsg_nosec+0x14e/0x190 net/socket.c:800
       __sock_sendmsg net/socket.c:818 [inline]
       ____sys_sendmsg+0x54e/0x850 net/socket.c:2715
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2769
       __sys_sendmsg net/socket.c:2801 [inline]
       __do_sys_sendmsg net/socket.c:2806 [inline]
       __se_sys_sendmsg net/socket.c:2804 [inline]
       __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2804
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->q_usage_counter(io)#50){++++}-{0:0}:
       blk_alloc_queue+0x544/0x690 block/blk-core.c:505
       blk_mq_alloc_queue block/blk-mq.c:4439 [inline]
       __blk_mq_alloc_disk+0x194/0x390 block/blk-mq.c:4486
       nbd_dev_add+0x494/0xb60 drivers/block/nbd.c:1996
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2743
       do_one_initcall+0x250/0x870 init/main.c:1419
       do_initcall_level+0x10a/0x1a0 init/main.c:1481
       do_initcalls+0x59/0xa0 init/main.c:1497
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1732
       kernel_init+0x22/0x1d0 init/main.c:1622
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4360 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4374
       might_alloc include/linux/sched/mm.h:316 [inline]
       slab_pre_alloc_hook mm/slub.c:4673 [inline]
       slab_alloc_node mm/slub.c:5011 [inline]
       kmem_cache_alloc_noprof+0x5f/0x600 mm/slub.c:5047
       mt_alloc_one lib/maple_tree.c:139 [inline]
       mas_alloc_nodes+0x291/0x350 lib/maple_tree.c:1049
       mas_preallocate+0x42a/0x840 lib/maple_tree.c:5016
       vma_iter_prealloc mm/vma.h:698 [inline]
       vma_link+0x123/0x460 mm/vma.c:1922
       insert_vm_struct+0x3db/0x5b0 mm/vma.c:3608
       create_init_stack_vma+0x607/0xa40 mm/vma_exec.c:155
       bprm_mm_init fs/exec.c:279 [inline]
       alloc_bprm+0x507/0x640 fs/exec.c:1570
       class_bprm_constructor fs/exec.c:1580 [inline]
       kernel_execve+0x85/0x9a0 fs/exec.c:1976
       try_to_run_init_process+0x13/0x60 init/main.c:1548
       kernel_init+0xb2/0x1d0 init/main.c:1678
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&mm->mmap_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       __might_fault+0xcb/0x130 mm/memory.c:7530
       _copy_from_iter+0x100/0x1680 lib/iov_iter.c:271
       copy_from_iter include/linux/uio.h:236 [inline]
       copy_from_iter_full include/linux/uio.h:253 [inline]
       skb_do_copy_data_nocache include/net/sock.h:2333 [inline]
       skb_copy_to_page_nocache include/net/sock.h:2359 [inline]
       tcp_sendmsg_locked+0x214a/0x53c0 net/ipv4/tcp.c:1321
       tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1462
       sock_sendmsg_nosec+0x10f/0x190 net/socket.c:801
       __sock_sendmsg net/socket.c:818 [inline]
       __sys_sendto+0x408/0x5a0 net/socket.c:2283
       __do_sys_sendto net/socket.c:2290 [inline]
       __se_sys_sendto net/socket.c:2286 [inline]
       __x64_sys_sendto+0xde/0x100 net/socket.c:2286
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> &nsock->tx_lock --> sk_lock-AF_INET-NBD

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET-NBD);
                               lock(&nsock->tx_lock);
                               lock(sk_lock-AF_INET-NBD);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

locks held by syz.4.7408/2091: 1, last CPU#0:
 #0: ffff8880760ed1e0 (sk_lock-AF_INET-NBD){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1717 [inline]
 #0: ffff8880760ed1e0 (sk_lock-AF_INET-NBD){+.+.}-{0:0}, at: sk_stream_wait_memory+0x8de/0xff0 net/core/stream.c:148

stack backtrace:
CPU: 0 UID: 0 PID: 2091 Comm: syz.4.7408 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/15/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
 check_prev_add kernel/locking/lockdep.c:3209 [inline]
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 __might_fault+0xcb/0x130 mm/memory.c:7530
 _copy_from_iter+0x100/0x1680 lib/iov_iter.c:271
 copy_from_iter include/linux/uio.h:236 [inline]
 copy_from_iter_full include/linux/uio.h:253 [inline]
 skb_do_copy_data_nocache include/net/sock.h:2333 [inline]
 skb_copy_to_page_nocache include/net/sock.h:2359 [inline]
 tcp_sendmsg_locked+0x214a/0x53c0 net/ipv4/tcp.c:1321
 tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1462
 sock_sendmsg_nosec+0x10f/0x190 net/socket.c:801
 __sock_sendmsg net/socket.c:818 [inline]
 __sys_sendto+0x408/0x5a0 net/socket.c:2283
 __do_sys_sendto net/socket.c:2290 [inline]
 __se_sys_sendto net/socket.c:2286 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2286
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f21b9fb19
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f22997028 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f2f21e25fa0 RCX: 00007f2f21b9fb19
RDX: ffffffffffffff94 RSI: 0000200000000100 RDI: 0000000000000004
RBP: 00007f2f21c37b70 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000000b R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2f21e26038 R14: 00007f2f21e25fa0 R15: 00007fffcbec2ed8
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
