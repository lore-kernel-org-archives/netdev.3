Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E276282F12
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787358094; cv=none; b=g1osq3SK53NmevDXhw+nSsfuvLSn4RA5A9DGh22lFtNbGE6ZOqOlWxucEmQz61WpJC2/owxSPkjqaFJLGUr2ochCxgg270St5CDHOi/CdIjNlBZE9+s29ZIz+730GZGYFXF0dzYUMbz88E43N2v4ZHkMBQCI8Y69MgSb/QgJazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787358094; c=relaxed/simple;
	bh=gg3gHAad/Ttjtr8laxEs92qAYgbIicON71UAD7S6JLs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fciMpMeHvcyAT7r8dbsGjp5kKUPiCOmThzaznOAjf+Ma4Kr3cdQin1TJ+hKLbxER0qc4QIDjTTqqHcfSrT7HXV0K8OmLdkmLRBwqmSt2ZFRxw9Fw3Kt+7z5lYVzq0hZlNsSdeg1rp0/6LUdHNjJ3tfh2yAFIdFQI0caaWV455xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-495f936d5ecso522012b6e.0
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 17:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787358091; x=1787962891;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OYhu88NbwUWAVuj6G/mAqTvj4+DZplpMXLlAfOvLG5I=;
        b=kxTekFqE+izLbDsczQ3s04tYZZwse1RMKry2yqsatldWIEYPzQSEbwEXXeBzhPcmsg
         +khfuMMKg1a3wb5aE6+mzLz9mTB5yINE1pjV86WH+j8W0zOEJst6DHrciVBiUfUSQSO6
         2ZnyRcKnOBu3I2ozdlrwIghaLkyGwHobgVHSeJNlUY2xMT9w7YMMGnTAu9t+C0l0b++5
         PwAmvCDzZ+xgHJ8NeaTp/jzdLCZSspFV4DKnhcTuxSYtpw6vCzkSdNKJqvvjq0Gdsz7C
         QgaoS0jXCLmZ6b+G5CjOG8ifaaMBlwQdJV7i6nbtMeY1f+lHVaW+1ksUXS0JUEbOpf+2
         tbnA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5eDOTONzDaz9cgnA8QvYrB6PF0qMseMTY5EJot0lOjl4ekMbUTL6w7YIw3krbcgXxm5HJvy8=@vger.kernel.org
X-Gm-Message-State: AFuF++n0HJTtacfQDj5LnOJSzyZ1LwBWJEU7W3yjD0lpJvNkzL0ISRJj
	gENZY/mDIAeE3ABHW6bj+YmL93R8PgsFpTxtkdCICoQMifC3ZWitN6e7wuo51E3DKi004szxKdH
	G3jLi0RqQ1Lj8jhOv1oAjaCPrfFZE+UptY+lt/1CY7G5e//vjn4OrTIp/kVM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:179b:b0:495:d7ec:b6ae with SMTP id
 5614622812f47-4b309b6697fmr3142661b6e.16.1787358091399; Fri, 21 Aug 2026
 17:21:31 -0700 (PDT)
Date: Fri, 21 Aug 2026 17:21:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a88eb8b.ae6ddae5.3da009.0049.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in genl_rcv_msg (5)
From: syzbot <syzbot+2ad5f42cd6ca88f0107c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d3ae59288f1 Linux 7.2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b70679580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c9eb8e593cf8c5c
dashboard link: https://syzkaller.appspot.com/bug?extid=2ad5f42cd6ca88f0107c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13913949580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d6a679580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e3213198af93/disk-8d3ae592.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ccb0eb1c86ad/vmlinux-8d3ae592.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8c009fbdf753/bzImage-8d3ae592.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ad5f42cd6ca88f0107c@syzkaller.appspotmail.com

INFO: task syz-executor328:5631 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor328 state:D stack:24144 pid:5631  tgid:5631  ppid:5627   task_flags:0x400140 flags:0x00080000
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
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7f5/0x990 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 __sys_sendto+0x41e/0x5d0 net/socket.c:2252
 __do_sys_sendto net/socket.c:2259 [inline]
 __se_sys_sendto net/socket.c:2255 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2255
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3a6b484867
RSP: 002b:00007ffc18787540 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00005555865654c0 RCX: 00007f3a6b484867
RDX: 0000000000000024 RSI: 00007f3a6b4f4b50 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffc18787594 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 00007f3a6b4f4b50
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/0:0/9:
9 locks held by ksoftirqd/0/15:
4 locks held by pr/legacy/17:
6 locks held by ktimers/1/29:
1 lock held by khungtaskd/38:
 #0: ffffffff8e1c3040 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8e1c3040 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8e1c3040 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
1 lock held by kcompactd0/41:
1 lock held by kcompactd1/42:
4 locks held by kworker/u8:5/67:
3 locks held by kworker/u8:7/154:
 #0: ffff888032738138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff888032738138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc900039bfc40 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc900039bfc40 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffffffff8f5ac938 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8f5ac938 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x123/0x16e0 net/ipv6/addrconf.c:4229
6 locks held by kworker/u8:8/1014:
6 locks held by kworker/u8:9/1034:
 #0: ffff88813ff5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88813ff5c138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc90004aa7c40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc90004aa7c40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffff888040d208d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6884 [inline]
 #2: ffff888040d208d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_work+0xb4/0x420 net/wireless/core.c:524
 #3: ffffffff8e059260 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #4: ffffffff8e1c3040 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #5: ffff888040d20228 (&rdev->bss_lock){+...}-{3:3}, at: spin_lock_bh include/linux/spinlock_rt.h:90 [inline]
 #5: ffff888040d20228 (&rdev->bss_lock){+...}-{3:3}, at: cfg80211_inform_single_bss_data+0xc22/0x1bf0 net/wireless/scan.c:2377
7 locks held by kworker/u8:11/1506:
6 locks held by kworker/u8:14/3336:
4 locks held by kworker/u8:15/3359:
 #0: ffff88801aea0938 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88801aea0938 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc9000ea07c40 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc9000ea07c40 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffffffff8f59dda0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf5/0x810 net/core/net_namespace.c:673
 #3: ffffffff8f5ac938 (rtnl_mutex){+.+.}-{4:4}, at: ieee80211_unregister_hw+0x55/0x2c0 net/mac80211/main.c:1711
2 locks held by klogd/4941:
 #0: ffffffff8e1c3040 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #1: ffff8880b86241a8 (tasklet_sync_callback.cb_lock){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #1: ffff8880b86241a8 (tasklet_sync_callback.cb_lock){+...}-{3:3}, at: tasklet_lock_callback kernel/softirq.c:877 [inline]
 #1: ffff8880b86241a8 (tasklet_sync_callback.cb_lock){+...}-{3:3}, at: tasklet_action_common+0xc5/0x600 kernel/softirq.c:927
2 locks held by getty/5341:
 #0: ffff8880366ae0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003cc62e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x460/0x1360 drivers/tty/n_tty.c:2211
1 lock held by syz-executor328/5628:
 #0: ffffffff8f5ac938 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8f5ac938 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x2fb/0x1c50 net/ipv4/devinet.c:1120
4 locks held by syz-executor328/5629:
 #0: ffffffff8f61dca0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8f61dab8 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8f61dab8 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8f61dab8 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
 #2: ffffffff8f5ac938 (rtnl_mutex){+.+.}-{4:4}, at: wiphy_register+0x1faf/0x2ff0 net/wireless/core.c:1154
 #3: ffff88803c9108d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6884 [inline]
 #3: ffff88803c9108d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: reg_process_self_managed_hints+0x8d/0x160 net/wireless/reg.c:3195
2 locks held by syz-executor328/5631:
 #0: ffffffff8f61dca0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
 #1: ffffffff8f61dab8 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8f61dab8 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8f61dab8 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10b/0x7a0 net/netlink/genetlink.c:1208
4 locks held by syz-executor328/5637:
3 locks held by kworker/0:3/5642:
 #0: ffff88813ff1e538 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88813ff1e538 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc9000458fc40 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc9000458fc40 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffffffff8f5ac938 (rtnl_mutex){+.+.}-{4:4}, at: reg_check_chans_work+0xac/0x1110 net/wireless/reg.c:2469

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 38 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 1034 Comm: kworker/u8:9 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:246 [inline]
RIP: 0010:__sanitizer_cov_trace_switch+0x92/0x110 kernel/kcov.c:351
Code: 39 c8 0f 84 86 00 00 00 4e 8b 5c ce 10 65 8b 2d f4 90 d8 10 81 e5 00 00 ff 00 41 8b 98 f4 0b 00 00 44 21 d3 41 89 de 41 09 ee <74> 12 85 ed 75 cc 85 db 74 c8 41 83 b8 0c 17 00 00 00 74 be 41 8b
RSP: 0018:ffffc90004aa64e0 EFLAGS: 00000246
RAX: 0000000000000020 RBX: 0000000000000000 RCX: 0000000000000005
RDX: ffffffff81c9fb3a RSI: ffffffff8e2264f0 RDI: 000000000000000a
RBP: 0000000000000000 R08: ffff8880275c3e00 R09: 0000000000000014
R10: 0000000000000100 R11: 0000000000000014 R12: 00000054f161582e
R13: 000000000000000a R14: 0000000000000000 R15: ffff88803210f664
FS:  0000000000000000(0000) GS:ffff888125d3a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d1b2826660 CR3: 000000000dfb0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rb_read_data_buffer+0x14a/0x5b0 kernel/trace/ring_buffer.c:1861
 check_buffer+0x288/0x7f0 kernel/trace/ring_buffer.c:4690
 __rb_reserve_next+0x537/0xdc0 kernel/trace/ring_buffer.c:4791
 rb_reserve_next_event kernel/trace/ring_buffer.c:4928 [inline]
 ring_buffer_lock_reserve+0xbd5/0x1040 kernel/trace/ring_buffer.c:4987
 __trace_buffer_lock_reserve kernel/trace/trace.h:1676 [inline]
 trace_event_buffer_lock_reserve+0x1d2/0x700 kernel/trace/trace.c:1924
 trace_event_buffer_reserve+0x1ef/0x2d0 kernel/trace/trace_events.c:688
 do_trace_event_raw_event_lock_acquire include/trace/events/lock.h:23 [inline]
 trace_event_raw_event_lock_acquire+0x12b/0x2e0 include/trace/events/lock.h:23
 __do_trace_lock_acquire include/trace/events/lock.h:23 [inline]
 trace_lock_acquire include/trace/events/lock.h:23 [inline]
 lock_acquire+0x2ff/0x350 kernel/locking/lockdep.c:5831
 rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 rcu_read_lock include/linux/rcupdate.h:840 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1183 [inline]
 unwind_next_frame+0xac/0x2550 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_noprof+0x41a/0x780 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 cfg80211_inform_single_bss_data+0x986/0x1bf0 net/wireless/scan.c:2354
 cfg80211_inform_bss_data+0x25b/0x3d50 net/wireless/scan.c:3241
 cfg80211_inform_bss_frame_data+0x3c7/0x840 net/wireless/scan.c:3333
 ieee80211_bss_info_update+0x791/0xa50 net/mac80211/scan.c:230
 ieee80211_rx_bss_info net/mac80211/ibss.c:1063 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1544 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1ce3/0x2c40 net/mac80211/ibss.c:1571
 ieee80211_iface_process_skb net/mac80211/iface.c:1769 [inline]
 ieee80211_iface_work+0x78a/0x1010 net/mac80211/iface.c:1823
 cfg80211_wiphy_work+0x29e/0x420 net/wireless/core.c:538
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

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
