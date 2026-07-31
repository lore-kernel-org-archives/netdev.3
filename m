Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928671A5B9D
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456686; cv=none; b=H/kdJGgz2q6x+CjYqDqxRfL4aWy0BazRS4dleSK3WSlynjXV6E5HZLlAXDQZjdGpKjKPDMArP2wd5pMlQVu+PU4mY9PUHXRZaWOuc8Ni6bzFu2Icb+WH5Jvm/ufXOan0upxpVM9OORJaIHZuXBi3BezJclfsd5331nhlQi+d8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456686; c=relaxed/simple;
	bh=++6amJUbDymrZs4cQrQe3QLiUGskoOI+YCdMxWdYbSk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RwYy0/TXwjGDk8rcUI8bNXqDD1/9YhFN9CDLiZY5hkwzEckeA80RLWLL/CoEqjqDOXsgi1DVSnzG382iljexvcbUCSgGYg/+eE1nnOKBvWWrsKbTG4QZitzn1g5I5UeAA/hRVHv95KtDY2Hi1eH6ZZ3XGt3qmcaOCn1ITGphIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7ebe970a21fso261775a34.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 17:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456683; x=1786061483;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AqIz0D7MUl40h9xPiXFUSbEuKb9qF+ab9rrFpgsrEMw=;
        b=r5YFwQ+wQp6hUCZADx8fduKxMu9u0CZd1D7b/22a3aMqejeU8zexrefhenkFO+/cGX
         cCaHIbomNuinA5FnBl/nZZQ49+/d4VDVYgy5rLi0JiwQBb58HCHcUuP5y95SYAjoBzL7
         4UTYXJL7Ak2Ellb+oxNVb0F5vP/F6vmuezpyHsueirR+hS0F5AxQzL9KY+2U5PVVh6Qg
         v3R94BiWSNMEac+DNnahLQSHMMrK0xSoEKUjSI/q+Zt8cWiOIlTr8IjFm0HL5yljHojV
         XGYRG59liUcYLDi1AMmfaTrtGk2CE9SwfzrimjjBnR7sDRIZaDavccAquTez3deOPu/j
         Vs4Q==
X-Forwarded-Encrypted: i=1; AHgh+RoZ7QVz9OCqI25OeozmuOLvRgw9hZOhy6ryvkLUnXJT65w6gs6bORUduX2/TTzCEDd2iMdSuX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJD2smEelYl4esvECsVPIV6tAbFY8Bh2ufjF8T8YD5KQM6qb2V
	x8INodRlePN64m1T7h/cN8kkQgHGfn/JET3VUjCF8SSCRaAwEgudU0F0Jx1sAjPSuFUUibeRKui
	lIM0XQJy2OHDnkhLzPq/zvIWUchg+qRKfsr24DLWjCnTShcN21lZFnsOq82k=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f12:b0:496:b7c:9445 with SMTP id
 5614622812f47-4ad95116fbbmr2960306b6e.12.1785456683487; Thu, 30 Jul 2026
 17:11:23 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:11:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6be82b.77639fcc.3d4fd0.0014.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in __netdev_update_features (3)
From: syzbot <syzbot+c6c86a1c56b5131f2d97@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b515dc54795e net: ip6_tunnel: use tunnel parameters for fi..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=149e51b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a830513e9494bd
dashboard link: https://syzkaller.appspot.com/bug?extid=c6c86a1c56b5131f2d97
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e24d9778837a/disk-b515dc54.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae4d23043bab/vmlinux-b515dc54.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07018b9230e4/bzImage-b515dc54.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6c86a1c56b5131f2d97@syzkaller.appspotmail.com

openvswitch: netlink: Tunnel attr 68 out of range max 16
============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.4.11245/17670 is trying to acquire lock:
ffff88802c0f4e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2852 [inline]
ffff88802c0f4e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff88802c0f4e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: netdev_sync_lower_features net/core/dev.c:10885 [inline]
ffff88802c0f4e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: __netdev_update_features+0xd27/0x1ef0 net/core/dev.c:11055

but task is already holding lock:
ffff88802c0f4e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2852 [inline]
ffff88802c0f4e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff88802c0f4e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3627 [inline]
ffff88802c0f4e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: dev_ethtool+0x47e/0x29c0 net/ethtool/ioctl.c:3669
and the lock comparison function returns 0:

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev_instance_lock_key#23);
  lock(&dev_instance_lock_key#23);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.4.11245/17670:
 #0: ffffffff9002d000 (rtnl_mutex){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3626 [inline]
 #0: ffffffff9002d000 (rtnl_mutex){+.+.}-{4:4}, at: dev_ethtool+0x3a0/0x29c0 net/ethtool/ioctl.c:3669
 #1: ffff88802c0f4e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2852 [inline]
 #1: ffff88802c0f4e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 #1: ffff88802c0f4e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3627 [inline]
 #1: ffff88802c0f4e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: dev_ethtool+0x47e/0x29c0 net/ethtool/ioctl.c:3669

stack backtrace:
CPU: 0 UID: 0 PID: 17670 Comm: syz.4.11245 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x24df/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
 netdev_lock include/linux/netdevice.h:2852 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 netdev_sync_lower_features net/core/dev.c:10885 [inline]
 __netdev_update_features+0xd27/0x1ef0 net/core/dev.c:11055
 netdev_update_features+0x6f/0x100 net/core/dev.c:11112
 macvlan_device_event+0x559/0x880 drivers/net/macvlan.c:1856
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2291 [inline]
 call_netdevice_notifiers net/core/dev.c:2305 [inline]
 netdev_features_change+0x8d/0xd0 net/core/dev.c:1590
 dev_ethtool_locked net/ethtool/ioctl.c:3576 [inline]
 __dev_ethtool net/ethtool/ioctl.c:3634 [inline]
 dev_ethtool+0x1f09/0x29c0 net/ethtool/ioctl.c:3669
 dev_ioctl+0x392/0x1150 net/core/dev_ioctl.c:751
 sock_do_ioctl+0x23e/0x320 net/socket.c:1314
 sock_ioctl+0x57a/0x7e0 net/socket.c:1421
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd7cdd9de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd7ceb8e028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd7ce026090 RCX: 00007fd7cdd9de99
RDX: 0000200000000080 RSI: 0000000000008946 RDI: 0000000000000009
RBP: 00007fd7cde33eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd7ce026128 R14: 00007fd7ce026090 R15: 00007fffb9a03768
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
