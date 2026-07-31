Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5749B19F115
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456686; cv=none; b=SaB6ffmsLozRhh1F1QQR3MOTVIbidGkeO2J7wOolZjbNU/1nDDwTw9M2cm8WLXQPSbAxI+ERuiK6kibODXfqcOnKdcbNej9Rv9fK0mOvaOBXtRmQOC9607BClpFL8Y9wdfhdzbA02f/Mzlo3DH9AvICniYnocT6G+b0oBRCKJW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456686; c=relaxed/simple;
	bh=zFzUR72sKWqMjuvUvwo8aevEk0W5/KjbkbE2rec3aic=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=inij/a//B7GvmnJxKvjFOq7xLCpl2qBaFJYftwMF/14jA1hZMUWFplWw7ZdiAEuFKDP0LHjNJwiYqWPDAc8LkUnNwoZfMEZ7ZOYNpASKOVc11hdslHuCgpad4/ftvkeIEmujwfAS8yzkOc39MLf29i5bzJIgTl+iFEAymGaCFNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-451d8064053so629612fac.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 17:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456683; x=1786061483;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cZsNJRFUHFRr++4/MMgx15PWU81FaIQf2NfiA3Osn1Q=;
        b=q1jD4g5jnQnIHseJ5hRuTqGWY3Xp8C8hjbWN5s3FgJ022kqRt4/v5qGUSCkolUVUrS
         iQ9Q8hHKStnq0iSzaDIy2dNcta4ZoJD3+9SRPvR59B5223LmzYS+SmgfT6tqSKO45iHT
         Ae3mC3v+Fb5P9t/BRG5eBCRGamyYiW+/ulYqzQ9CUAIEDkIihE7EePftFf6km7OX7CvS
         8lTSuoS+7yfFyIDZueTA/BN1RPq+zs9SPs789W0mMjpeR76ww4YtDL9A1gy4b77Galdn
         kWskL7nG8HHV7aexynvXVFNI+Nh0V7snzt8H4GQ9yJ8p4whQ994Yt56Ck6g3cxm4xbv8
         TNJA==
X-Forwarded-Encrypted: i=1; AHgh+RpsCEjyjWbX+u/9/cvdDPfOOLVuk2QD/erJxET8s2x9vRvug45C1i07bIge1yx0sytFvysQlUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvw007NCxPoYxNMxhzKog2Vew0bQL4sERF3DWZIILoRbb5V4Mx
	8bIzPfpibRHAMVAyxcFHTalzrewN9OCb9Izc1wfmIZDnv1dNuqRGp//1C85Q3QfMNDkdfof0lin
	0CdviRAvnSR8BCBXxhpNuC1+5pBKVQxnOHe5qvimYrESOeQC3ck8t7XLKA5M=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1989:b0:4a4:12c4:9c16 with SMTP id
 5614622812f47-4ad8771e9bcmr3755146b6e.7.1785456683213; Thu, 30 Jul 2026
 17:11:23 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:11:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6be82b.77639fcc.3d4fd0.0013.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in devlink_pernet_pre_exit (3)
From: syzbot <syzbot+b049b2633b72b6d3c926@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3dab139d4795 Merge tag 'rust-fixes-7.2-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ad388e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=b049b2633b72b6d3c926
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6accc9e5bb6e/disk-3dab139d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a19bcf991db/vmlinux-3dab139d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ddf9007207b9/bzImage-3dab139d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b049b2633b72b6d3c926@syzkaller.appspotmail.com

INFO: task kworker/u8:12:1593 blocked for more than 145 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:12   state:D stack:21792 pid:1593  tgid:1593  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x16dc/0x5500 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7607
 rt_mutex_slowlock_block+0x55c/0x680 kernel/locking/rtmutex.c:1670
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1747 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1787 [inline]
 rt_mutex_slowlock+0x2d4/0x780 kernel/locking/rtmutex.c:1827
 __rt_mutex_lock kernel/locking/rtmutex.c:1842 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 device_lock include/linux/device.h:1102 [inline]
 devl_dev_lock net/devlink/devl_internal.h:124 [inline]
 devlink_pernet_pre_exit+0x129/0x420 net/devlink/core.c:557
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x17d/0x8d0 net/core/net_namespace.c:234
 cleanup_net+0x575/0x810 net/core/net_namespace.c:702
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz-executor:11639 blocked for more than 145 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:23024 pid:11639 tgid:11639 ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x16dc/0x5500 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7607
 rt_mutex_slowlock_block+0x55c/0x680 kernel/locking/rtmutex.c:1670
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1747 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1787 [inline]
 rt_mutex_slowlock+0x2d4/0x780 kernel/locking/rtmutex.c:1827
 __rt_mutex_lock kernel/locking/rtmutex.c:1842 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 new_device_store+0x13c/0x710 drivers/net/netdevsim/bus.c:184
 kernfs_fop_write_iter+0x3a5/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5895bde6ce
RSP: 002b:00007ffecdfc4cc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055557d47b500 RCX: 00007f5895bde6ce
RDX: 0000000000000003 RSI: 00007ffecdfc4d50 RDI: 0000000000000005
RBP: 00007f5895cb4756 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ffecdfc4d50 R14: 00007f58969d4620 R15: 0000000000000003
 </TASK>
INFO: task syz-executor:11793 blocked for more than 145 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22712 pid:11793 tgid:11793 ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x16dc/0x5500 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7607
 rt_mutex_slowlock_block+0x55c/0x680 kernel/locking/rtmutex.c:1670
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1747 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1787 [inline]
 rt_mutex_slowlock+0x2d4/0x780 kernel/locking/rtmutex.c:1827
 __rt_mutex_lock kernel/locking/rtmutex.c:1842 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 del_device_store+0xd6/0x370 drivers/net/netdevsim/bus.c:234
 kernfs_fop_write_iter+0x3a5/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff7262be6ce
RSP: 002b:00007fffd5254988 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000555558320500 RCX: 00007ff7262be6ce
RDX: 0000000000000001 RSI: 00007fffd5254a10 RDI: 0000000000000005
RBP: 00007ff726394732 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffd5254a10 R14: 00007ff7270b4620 R15: 0000000000000003
 </TASK>

Showing all locks held in the system:
5 locks held by ktimers/0/16:
1 lock held by khungtaskd/38:
 #0: ffffffff8e1c3000 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8e1c3000 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8e1c3000 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by kcompactd0/41:
5 locks held by kworker/u8:11/1306:
 #0: ffff888040d0f138 ((wq_completion)krds_cp_wq#5/0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff888040d0f138 ((wq_completion)krds_cp_wq#5/0){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc9000621fc40 ((work_completion)(&(&cp->cp_conn_w)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc9000621fc40 ((work_completion)(&(&cp->cp_conn_w)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffff88805f7ae3e0 (&tc->t_conn_path_lock){+.+.}-{4:4}, at: rds_tcp_conn_path_connect+0x1cc/0x920 net/rds/tcp_connect.c:118
 #3: ffffffff8e3075d0 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:187 [inline]
 #3: ffffffff8e3075d0 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_read_lock+0x27/0x60 include/linux/srcu.h:294
 #4: ffff88801e6fd958 (&n->list_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #4: ffff88801e6fd958 (&n->list_lock){+.+.}-{3:3}, at: __slab_free+0xf1/0x2a0 mm/slub.c:5687
4 locks held by kworker/u8:12/1593:
 #0: ffff88801aea0938 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88801aea0938 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc900069afc40 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc900069afc40 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffffffff8f5a2e80 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf5/0x810 net/core/net_namespace.c:673
 #3: ffff888022293160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1102 [inline]
 #3: ffff888022293160 (&dev->mutex){....}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:124 [inline]
 #3: ffff888022293160 (&dev->mutex){....}-{4:4}, at: devlink_pernet_pre_exit+0x129/0x420 net/devlink/core.c:557
4 locks held by kworker/u8:14/3349:
2 locks held by kworker/u8:16/3437:
1 lock held by udevd/4965:
4 locks held by kworker/0:3/5331:
2 locks held by crond/5338:
 #0: ffffffff8e3075d0 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:187 [inline]
 #0: ffffffff8e3075d0 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_read_lock+0x27/0x60 include/linux/srcu.h:294
 #1: ffff88801e6fd958 (&n->list_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #1: ffff88801e6fd958 (&n->list_lock){+.+.}-{3:3}, at: __slab_free+0xf1/0x2a0 mm/slub.c:5687
2 locks held by getty/5353:
 #0: ffff88803623d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003cbe2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x460/0x1360 drivers/tty/n_tty.c:2211
3 locks held by kworker/0:8/5839:
3 locks held by kworker/0:9/5954:
 #0: ffff88813ff1b938 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88813ff1b938 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc900058e7c40 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc900058e7c40 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffffffff8f5b1a38 (rtnl_mutex){+.+.}-{4:4}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
2 locks held by syz-executor/7602:
3 locks held by kworker/u8:19/8786:
 #0: ffff888032570938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff888032570938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc9000617fc40 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc9000617fc40 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffffffff8f5b1a38 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8f5b1a38 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4769
3 locks held by kworker/u8:20/8787:
 #0: ffff88813ff5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88813ff5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc90003c97c40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc90003c97c40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffff8880423108d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6884 [inline]
 #2: ffff8880423108d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_work+0xb4/0x420 net/wireless/core.c:524
4 locks held by syz-executor/11639:
 #0: ffff88803585e500 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2733 [inline]
 #0: ffff88803585e500 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x231/0xbb0 fs/read_write.c:683
 #1: ffff88805fda1478 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1d9/0x540 fs/kernfs/file.c:336
 #2: ffff8880291435a8 (kn->active#53){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff8880291435a8 (kn->active#53){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x22c/0x540 fs/kernfs/file.c:337
 #3: ffffffff8ee26cd8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: new_device_store+0x13c/0x710 drivers/net/netdevsim/bus.c:184
7 locks held by syz-executor/11691:
 #0: ffff88803585e500 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2733 [inline]
 #0: ffff88803585e500 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x231/0xbb0 fs/read_write.c:683
 #1: ffff888079668c78 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1d9/0x540 fs/kernfs/file.c:336
 #2: ffff8880291434b8 (kn->active#52){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff8880291434b8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x22c/0x540 fs/kernfs/file.c:337
 #3: ffffffff8ee26cd8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd6/0x370 drivers/net/netdevsim/bus.c:234
 #4: ffff888022293160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1102 [inline]
 #4: ffff888022293160 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff888022293160 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb9/0x880 drivers/base/dd.c:1369
 #5: ffff8880374e6310 (&devlink->lock_key#16){+.+.}-{4:4}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1799
 #6: ffffffff8f5b1a38 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #6: ffffffff8f5b1a38 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_dev_lock+0x257/0x2f0 net/core/dev.c:2163
4 locks held by syz-executor/11793:
 #0: ffff88803585e500 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2733 [inline]
 #0: ffff88803585e500 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x231/0xbb0 fs/read_write.c:683
 #1: ffff88805dbf9878 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1d9/0x540 fs/kernfs/file.c:336
 #2: ffff8880291434b8 (kn->active#52){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff8880291434b8 (kn->active#52){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x22c/0x540 fs/kernfs/file.c:337
 #3: ffffffff8ee26cd8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd6/0x370 drivers/net/netdevsim/bus.c:234
5 locks held by dhcpcd-run-hook/12132:
6 locks held by syz.5.1472/12143:
1 lock held by syz-executor/12152:
4 locks held by syz-executor/12154:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 38 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:122
 nmi_trigger_cpumask_backtrace+0x17a/0x380 lib/nmi_backtrace.c:65
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
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
