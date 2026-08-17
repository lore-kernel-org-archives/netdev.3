Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1276190462
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954711; cv=none; b=FhMKazhxAx5lOT+sRl76eRs9fgy5Nuor0bvP1mchsNm63cJcMDcs68DqywP9WlGhhmceVLJNsNYo1OPudU6877aHTYKae0Y8jRleQPGLY8CfZwjTdhGuxF+ElmR+10sNCnTd8faWYqittYghQYuHQ8Bg20Xq+CIYRb8BoofnppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954711; c=relaxed/simple;
	bh=2WRU1LAzDFQyr736YMDPBWPgkK848UlvDaSUKvjTYTE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qNOBIG5AVBuCAKfKrIjqaJgbrcH0k7hD+3bxDoMSEQGwS8uZWJwMu1/5qq7SpBzVX/iLvL7riKA4kFFYDqElFRFGHfnd+9GAq/y4pTLz+CNs4DCtKBY5HfT+DdxObcMGG/dq7JnwDJX2GsoR5A1XZh5uM1NPZa8bGDxw3rhw774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6b0e26855f9so3103127eaf.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954709; x=1787559509;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0FaO1QCRnZnkA6shIYBBdncSnDkqPEYWvnlXGGxQbHA=;
        b=h33aKmAtghGOMxk3oNSsqO4X0A1ntmlSdHSOhBXZIMhwW8F5167k/LpI07AqZLQuru
         gcldQdm0j74741S5REoDpsd7HYKy2wU/5tDj7RRXVAgIojyYMZjBakWZMUeNWig/WaE8
         u4WFGHmWCjUM2KydZurf+MUlAqQabOolo40ZHAAh4dAq45+3LK4cPh9QLFCTb5Is8TEX
         pfXqx/yrbsdvW4vcAY0HqXmEKV+EKd9DGoqenvfQyHKDJJ46vEvGi9EJwsV0HDnAdLuC
         sqWQT8z6KgYlvkKQ8cCOhC6NAijt4vYa+3aSR1YTX3MBihH3ct1IfwInk/LzIbAoDjAS
         kb7A==
X-Forwarded-Encrypted: i=1; AHgh+RpQINyUUR4qGV/qiqTtgft9p4yDW91ecy3nx4IhlAVkxHNUVzrDSjAHjzLQV18DTbTKLZZ0fEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylGXAIsaj2FIdU8eaxM5PaRDXjKKHUta4ZoAaqE3Jj2pnvkK70
	txLgfO9RGYTkAQuW35B7SMNITSKPyQA2839CumHdHCaYdfPmquV4jQwSfbJlFfgrO1cTIUmJIEi
	jpp6FnUxwtbt0/bxzn+NhGbytQ0+66ic8/UoNLSIMfvBFjKZmD3F2QEN3fgs=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:220c:b0:6ac:b5ae:65cb with SMTP id
 006d021491bc7-6b0d618d1fdmr20728409eaf.14.1786954708884; Mon, 17 Aug 2026
 01:18:28 -0700 (PDT)
Date: Mon, 17 Aug 2026 01:18:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a82c3d4.f7a79266.2f965f.0024.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in nla_put_napi_id
From: syzbot <syzbot+483a6efbc4882c1201ee@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    21d6ac051080 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=169646c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=483a6efbc4882c1201ee
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/88380e2ddcb9/disk-21d6ac05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5dba5c2896b7/vmlinux-21d6ac05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52ac739e37e0/Image-21d6ac05.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+483a6efbc4882c1201ee@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in nla_put_napi_id+0x140/0x144 net/core/netdev-genl.c:386
Read of size 4 at addr ffff0000c1da598c by task syz.3.236/6054

CPU: 0 UID: 0 PID: 6054 Comm: syz.3.236 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xb0/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0x8c/0xc4 mm/kasan/report.c:595
 __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
 nla_put_napi_id+0x140/0x144 net/core/netdev-genl.c:386
 netdev_nl_queue_fill_one+0x3ac/0x610 net/core/netdev-genl.c:494
 netdev_nl_queue_dump_one+0xd0/0x2f8 net/core/netdev-genl.c:603
 netdev_nl_queue_get_dumpit+0x1e0/0x4a4 net/core/netdev-genl.c:641
 genl_dumpit+0x108/0x1bc net/netlink/genetlink.c:1026
 netlink_dump+0x55c/0xb6c net/netlink/af_netlink.c:2331
 __netlink_dump_start+0x4c4/0x6f8 net/netlink/af_netlink.c:2446
 genl_family_rcv_msg_dumpit+0x1a8/0x28c net/netlink/genetlink.c:1075
 genl_family_rcv_msg net/netlink/genetlink.c:1191 [inline]
 genl_rcv_msg+0x404/0x620 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x238/0x414 net/netlink/af_netlink.c:2556
 genl_rcv+0x38/0x50 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x600/0x7f8 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x648/0x948 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg+0xc8/0x17c net/socket.c:790
 ____sys_sendmsg+0x3d0/0x6c8 net/socket.c:2684
 ___sys_sendmsg+0x198/0x224 net/socket.c:2738
 __sys_sendmsg+0x158/0x204 net/socket.c:2770
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __arm64_sys_sendmsg+0x88/0x9c net/socket.c:2773
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590

Allocated by task 12:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:78
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:570
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2e8/0x5ec mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 nsim_queue_alloc+0x58/0x120 drivers/net/netdevsim/netdev.c:715
 nsim_queue_init drivers/net/netdevsim/netdev.c:1012 [inline]
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1059 [inline]
 nsim_create+0x7e0/0xcf4 drivers/net/netdevsim/netdev.c:1152
 __nsim_dev_port_add+0x59c/0x95c drivers/net/netdevsim/dev.c:1509
 nsim_dev_port_add_all+0x50/0x114 drivers/net/netdevsim/dev.c:1570
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1622 [inline]
 nsim_dev_reload_up+0x3cc/0x5b4 drivers/net/netdevsim/dev.c:1058
 devlink_reload+0x3b0/0x64c net/devlink/dev.c:475
 devlink_pernet_pre_exit+0x1ac/0x30c net/devlink/core.c:560
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x158/0x81c net/core/net_namespace.c:234
 cleanup_net+0x474/0x6c4 net/core/net_namespace.c:702
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x788/0x10b8 kernel/workqueue.c:3405
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3486
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838

Freed by task 5937:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:78
 kasan_save_free_info+0x54/0x6c mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x74/0xa4 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x188/0x690 mm/slub.c:6692
 nsim_queue_free+0x11c/0x1a0 drivers/net/netdevsim/netdev.c:735
 nsim_queue_mem_free+0xfc/0x130 drivers/net/netdevsim/netdev.c:796
 netdev_rx_queue_reconfig+0x2dc/0x48c net/core/netdev_rx_queue.c:-1
 netdev_rx_queue_restart+0xa4/0xec net/core/netdev_rx_queue.c:183
 nsim_qreset_write+0x30c/0x48c drivers/net/netdevsim/netdev.c:887
 full_proxy_write+0x11c/0x160 fs/debugfs/file.c:388
 vfs_write+0x2a4/0xa0c fs/read_write.c:685
 ksys_write+0x12c/0x228 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x84/0x98 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590

The buggy address belongs to the object at ffff0000c1da5800
 which belongs to the cache kmalloc-cg-1k of size 1024
The buggy address is located 396 bytes inside of
 freed 1024-byte region [ffff0000c1da5800, ffff0000c1da5c00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff0000c1da7000 pfn:0x101da0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff0000c1da0411
flags: 0x5ffc00000000240(workingset|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000240 ffff0000c000b280 fffffdffc3c5e410 fffffdffc35ae210
raw: ffff0000c1da7000 000008000010000f 00000000f5000000 ffff0000c1da0411
head: 05ffc00000000240 ffff0000c000b280 fffffdffc3c5e410 fffffdffc35ae210
head: ffff0000c1da7000 000008000010000f 00000000f5000000 ffff0000c1da0411
head: 05ffc00000000003 fffffdffc3076801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000c1da5880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000c1da5900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000c1da5980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff0000c1da5a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000c1da5a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
