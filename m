Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584276;
	b=hbOGMwnOXcWWyuv7Rj1EGUNgYIbZd/TMKGehCeNbO6SDHbpVIlx1w/hApwO5mE9QLU9y
	 OzjFrXA5fzPD/IWDlAVZGlhWc2mNS6zEWbe0r8B3F83UvYH9MgXG8UpohZzqfE3rY81Iq
	 LWIxThBI5fxU8+Wx5WnqV0IeAESoBTvnMgrxQs28TD1XlCCc6YZcLNmc4UKdp/qyldoUC
	 ilMbKXRBkhA6+Lb7SWwSx2X6vbaduW5DjiL3iJ0CwOa8we9V4OiNeYcvbUbGOC8OZIj1n
	 jWc0/VdE78mx1VF7L5IsTs/GJOGS56kXuEOdj/J8FHxVPMLkRZjyOsJOq+a+sw89xYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584276;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=T9Y/TaQNUb3/griwMCePCu25yQGlbSAhSGmqu+WzWLQ=;
	b=3gUPOG6JJ3iw2lj6cRq7mNaShGKTVb4mQXUmqou9QDgQ2ntWNnxqe60/efk2sJeWRQkK
	 fnY6tbXuHHL/4YUm7f9UXCiXuRKR77CsWbwMSoIMl1He1PIRIPwNGRsGlHLlb85s8uto5
	 EHftlpKDfAOUn3AHG61EuxvebC2uPJyjOXRPTCASFvI3jcamhwMEtq4YHwERjd8yVHk8u
	 WuS6es3QdBllocjaCNHCeDap28O2Jv6dGzKAZGyrgmfa7lRr243u9SL3MuI8D2oMJIp2i
	 zrtiq0Eh9GcLjVd5IM7r4zkIrL/EaOO8OwmEvmJOAEgKEckaawwcTvrvS70L1nvmDkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218D606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E218D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-567e742f481so633049b6e.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584275; x=1795189075;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T9Y/TaQNUb3/griwMCePCu25yQGlbSAhSGmqu+WzWLQ=;
        b=1eDsokaWkxhVbtYgf0OK/J5hSVt4dwK+s6e50Wb8se/SHn1t0fk6zO8V9/ShO657pD
         2xZ22Q1Cl5Za9M4VofXZ4PmFZUR2QdLbaQh9r9sm6KYn8MD+g7KTly7ITU4wf/brjRh/
         Y2Bx8qs6iuUVDctVbbsk2da7WDYMmJIMVtzA8xvwoW1zikrrVEf0YUkdgqcJQqLsdNY4
         a3IDV/cGaShpSWqxy3LiYGWN3P6l6SZjZJoWIXVMz1NCxrcj+GeRBiVzSepYThKNIuuQ
         f9G1Vl+wrK2TI8W2Ngo2c2ob5ACaR4JKqxArwUp78Absuqy4fwE6WRshuzccJ5XNTO1L
         otVw==
X-Forwarded-Encrypted: i=1; AL+hErHcUyfw6N9zbl7PzirFXKsdKH3uz/1bLTX7qSGW673Y859JZTlvGK9WUB4G88iItSFiWU6B9OY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AjALTfmcaOK6scw+6Bz61AOpRX1u6LB27672Hq8xvTLtsZiV6
	loKiVOgXudcpqju/Eq8QrFMK9/U+CLeWYlx3BxeSUXpTEpWxbEJjrOjkTQ13E8iYMfBHbe2pHNe
	o7u7CFmMm5JegYxpD3+BSufBdIKhk53jUkaIA0alQ23vULDuO25QYqFlxChc=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a02:b0:4fb:8469:fc4f with SMTP id
 5614622812f47-56e64df31femr2010169b6e.29.1794584274942; Fri, 13 Nov 2026
 07:37:54 -0800 (PST)
Date: Fri, 13 Nov 2026 07:37:54 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af72ed2.fe96acdb.12252b.0006.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in mptcp_close (5)
From: syzbot <syzbot+fe510de4a165d4512813@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    145480b28ca8 net/mlx5: HWS, fix flow meter release on FTE ..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15776b55580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d44b06612b68f56
dashboard link: https://syzkaller.appspot.com/bug?extid=fe510de4a165d4512813
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f77cec177cc/disk-145480b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/846aaa5e713a/vmlinux-145480b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db5f4ddbee05/bzImage-145480b2.xz

AI-generated root cause summary:
When attaching a socket to an NBD device in nbd_add_socket(),
nbd_reclassify_socket() attempts to assign the socket a distinct lockdep class
(sk_lock-AF_INET-NBD) to decouple it from general networking socket locks. If
the socket lock happens to be held or busy during addition,
sock_allow_reclassification() returns false, causing nbd_reclassify_socket() to
silently skip reclassification and leave the socket with the default
sk_lock-AF_INET class. Consequently, when NBD acquires lock_sock under
nsock->tx_lock (e.g. during recv_work or request dispatch under fs_reclaim),
lockdep records the chain fs_reclaim -> &nsock->tx_lock -> sk_lock-AF_INET. When
an unrelated userspace AF_INET socket (here, an MPTCP socket during
mptcp_close()) subsequently performs a GFP_KERNEL allocation while holding
lock_sock, lockdep triggers a false-positive circular locking dependency warning
between fs_reclaim and sk_lock-AF_INET.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=fe510de4a165d4512813

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe510de4a165d4512813@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.3453/19253 is trying to acquire lock:
ffffffff90294f80 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:316 [inline]
ffffffff90294f80 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4673 [inline]
ffffffff90294f80 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:5011 [inline]
ffffffff90294f80 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_node_noprof+0x5f/0x600 mm/slub.c:5105

but task is already holding lock:
ffff88803354a720 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1717 [inline]
ffff88803354a720 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x1d/0x1a0 net/mptcp/protocol.c:3537

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x41/0x100 net/core/sock.c:3906
       lock_sock include/net/sock.h:1717 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:913
       nbd_mark_nsock_dead+0x2cb/0x550 drivers/block/nbd.c:319
       recv_work+0x1d14/0x1e30 drivers/block/nbd.c:1030
       process_one_work kernel/workqueue.c:3495 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x373/0xff0 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0x499/0x1990 block/blk-mq.c:2141
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xd36/0x1580 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0x167/0x2f0 block/blk-mq.c:2556
       process_one_work kernel/workqueue.c:3495 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #4 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       nbd_queue_rq+0xc1/0xff0 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0x499/0x1990 block/blk-mq.c:2141
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xd36/0x1580 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0x167/0x2f0 block/blk-mq.c:2556
       process_one_work kernel/workqueue.c:3495 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (set->srcu){.+.+}-{0:0}:
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

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       elevator_change+0x1af/0x480 block/elevator.c:679
       elevator_set_none+0xb5/0x140 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5160 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5205 [inline]
       blk_mq_update_nr_hw_queues+0x60b/0x1b70 block/blk-mq.c:5273
       nbd_start_device+0x189/0xb30 drivers/block/nbd.c:1530
       nbd_genl_connect+0x167d/0x1cd0 drivers/block/nbd.c:2310
       genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2585
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1336 [inline]
       netlink_unicast+0x8ef/0xa80 net/netlink/af_netlink.c:1362
       netlink_sendmsg+0x7f0/0xb20 net/netlink/af_netlink.c:1921
       sock_sendmsg_nosec+0x14e/0x190 net/socket.c:800
       __sock_sendmsg net/socket.c:818 [inline]
       ____sys_sendmsg+0x49f/0x790 net/socket.c:2713
       ___sys_sendmsg+0x2f7/0x3d0 net/socket.c:2770
       __sys_sendmsg net/socket.c:2802 [inline]
       __do_sys_sendmsg net/socket.c:2807 [inline]
       __se_sys_sendmsg net/socket.c:2805 [inline]
       __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2805
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       blk_alloc_queue+0x544/0x690 block/blk-core.c:505
       blk_mq_alloc_queue block/blk-mq.c:4460 [inline]
       __blk_mq_alloc_disk+0x194/0x390 block/blk-mq.c:4507
       nbd_dev_add+0x494/0xb60 drivers/block/nbd.c:1996
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2743
       do_one_initcall+0x250/0x870 init/main.c:1419
       do_initcall_level+0x10a/0x1a0 init/main.c:1481
       do_initcalls+0x59/0xa0 init/main.c:1497
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1732
       kernel_init+0x22/0x1d0 init/main.c:1622
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       __fs_reclaim_acquire mm/page_alloc.c:4365 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4379
       might_alloc include/linux/sched/mm.h:316 [inline]
       slab_pre_alloc_hook mm/slub.c:4673 [inline]
       slab_alloc_node mm/slub.c:5011 [inline]
       kmem_cache_alloc_node_noprof+0x5f/0x600 mm/slub.c:5105
       __alloc_skb+0x1db/0x7a0 net/core/skbuff.c:705
       alloc_skb include/linux/skbuff.h:1390 [inline]
       nlmsg_new include/net/netlink.h:1055 [inline]
       mptcp_event+0x13b/0x990 net/mptcp/pm_netlink.c:582
       __mptcp_close+0x871/0xd10 net/mptcp/protocol.c:3521
       mptcp_close+0x28/0x1a0 net/mptcp/protocol.c:3539
       inet_release+0x143/0x190 net/ipv4/af_inet.c:443
       __sock_release+0xa0/0x1f0 net/socket.c:735
       sock_close+0x1c/0x30 net/socket.c:1529
       __fput+0x408/0xa40 fs/file_table.c:512
       fput_close_sync+0x11f/0x240 fs/file_table.c:618
       filp_close_sync+0x6e/0xa0 fs/open.c:1573
       __range_close fs/file.c:919 [inline]
       __do_sys_close_range fs/file.c:1003 [inline]
       __se_sys_close_range+0xa77/0xef0 fs/file.c:954
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &nsock->tx_lock --> sk_lock-AF_INET

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET);
                               lock(&nsock->tx_lock);
                               lock(sk_lock-AF_INET);
  lock(fs_reclaim);

 *** DEADLOCK ***

locks held by syz.0.3453/19253: 2, last CPU#1:
 #0: ffff8880529b4740 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1026 [inline]
 #0: ffff8880529b4740 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: __sock_release+0x7a/0x1f0 net/socket.c:734
 #1: ffff88803354a720 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1717 [inline]
 #1: ffff88803354a720 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x1d/0x1a0 net/mptcp/protocol.c:3537

stack backtrace:
CPU: 1 UID: 0 PID: 19253 Comm: syz.0.3453 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
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
 __fs_reclaim_acquire mm/page_alloc.c:4365 [inline]
 fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4379
 might_alloc include/linux/sched/mm.h:316 [inline]
 slab_pre_alloc_hook mm/slub.c:4673 [inline]
 slab_alloc_node mm/slub.c:5011 [inline]
 kmem_cache_alloc_node_noprof+0x5f/0x600 mm/slub.c:5105
 __alloc_skb+0x1db/0x7a0 net/core/skbuff.c:705
 alloc_skb include/linux/skbuff.h:1390 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 mptcp_event+0x13b/0x990 net/mptcp/pm_netlink.c:582
 __mptcp_close+0x871/0xd10 net/mptcp/protocol.c:3521
 mptcp_close+0x28/0x1a0 net/mptcp/protocol.c:3539
 inet_release+0x143/0x190 net/ipv4/af_inet.c:443
 __sock_release+0xa0/0x1f0 net/socket.c:735
 sock_close+0x1c/0x30 net/socket.c:1529
 __fput+0x408/0xa40 fs/file_table.c:512
 fput_close_sync+0x11f/0x240 fs/file_table.c:618
 filp_close_sync+0x6e/0xa0 fs/open.c:1573
 __range_close fs/file.c:919 [inline]
 __do_sys_close_range fs/file.c:1003 [inline]
 __se_sys_close_range+0xa77/0xef0 fs/file.c:954
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3143da94d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff94a73f18 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: ffffffffffffffda RBX: 00007fff94a74000 RCX: 00007f3143da94d9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 000000000005c95b R08: 0000000000000001 R09: 0000000000000000
R10: 0000001b31620000 R11: 0000000000000246 R12: 00007fff94a74040
R13: 00007f314402609c R14: 000000000005c9a5 R15: 00007f3144026090
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
