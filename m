Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C540B6D4
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798251; cv=none; b=st5hEcTtizNeYcHpgA3dRwFc2PxwqXaSaCQSFasjCyzAcWBtaC+HUyBfhntihP1lfFh198bwPVJoFcx5u8OX7e9V7DrSrDce+xz80ms+dvuRt0VBTLND/+J0KIuBHA8ArdqXxf3+FdzVkrVRu0Ee6xRDCGWacOIY9XbxwDnaF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798251; c=relaxed/simple;
	bh=0DOYA9j5LCHaMZwNHcC1j1dbo1T7ngDwNIKrikuaF/s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o7ITay4ak86wvvYhpjnlGR+u7i1a04KGsPtbawQC1Yq9Lbo/Wi7/FMu11/XpmIAf3eM0GGph7cKci7h5Nvk8y67eShS3FTR2asaJB81xryXWL15di09snmZAW2izucCctH79GUUDe9F8BsiGsYf5GimNyD26iA5jsK5Cvd5N+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4db3db8687fso346089b6e.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798249; x=1791403049;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuCztHNpAgV3X7BfgjOC6VVtGxHWH4J6xHbwAt48ZXA=;
        b=Hp/Vj9nGbU6F4s1E4Fjym9tkWbIO9iZWSb43VdiwMpwOmQ9FHxdcHOS6VxFZQJsckr
         3iVGHSMXJhCxFUErAzQoWplAsOzJ6T/nkhNQzemaZ8k9Qc2YoNqtqWHRACFqTgU+B/Rg
         B0jS3l5mugfJ0NGL5MNymOmAoh7oLPjY2y/KqKjOe6bn9d6q31EXHf/1M4vPPsQbkU/M
         Somkh3pvr1xDlfT65ciTjWCx4d/qW8in16/pbuQvDHe1qDdyHMA/479T9AYrLAKFouL1
         qgb3SUiki/64i1FJKSDObCcQ49CracxxOvIRuhO28eLpDCl3FYp/4z3l6dljZftk+uGf
         5DtA==
X-Forwarded-Encrypted: i=1; AKwUvBzNxmMvkKn5TMVhzJrf7HGt8P1cTdcVu9afTFsfdHX5UyBmz5NKXjYXZ6pfQk7mhfQ0XRrQgVk=@vger.kernel.org
X-Gm-Message-State: AFuF++mwOYD5TTBvXziEyu80JZ/jIGkoMUS6tGYmWXHtt+aouOb2i6dK
	JJcwNIHFlTMCoppoaF3wGmte0JDzJ6iQL1QaiL3ZXJJAl49Hj2VV7NCcYdIOY8/yI0aHQSG46iN
	W+f3ILs0Q4V4CZC03jF9D1ibtAQVP4VpmlpUuCuw0SXFp6otKWqOjyUkQV7Y=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c194:b0:4ea:18f:649f with SMTP id
 5614622812f47-4f1b12ed99bmr2904918b6e.3.1790798249184; Wed, 30 Sep 2026
 12:57:29 -0700 (PDT)
Date: Wed, 30 Sep 2026 12:57:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abd69a9.80e1c6cc.22483f.0005.GAE@google.com>
Subject: [syzbot] [net?] WARNING in neigh_mark_dead
From: syzbot <syzbot+5a8857f0b4a0a7b12c62@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    014d795c7383 idpf: fix kernel-doc parameter descriptions
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15033315580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f9be4b0ece4f44b
dashboard link: https://syzkaller.appspot.com/bug?extid=5a8857f0b4a0a7b12c62
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ffe50eefb704/disk-014d795c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bbb13d8fe817/vmlinux-014d795c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df8fdfbd7a2b/bzImage-014d795c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a8857f0b4a0a7b12c62@syzkaller.appspotmail.com

netlink: 'syz.0.857': attribute type 4 has an invalid length.
------------[ cut here ]------------
debug_locks && !(lock_is_held(&(&n->tbl->lock)->dep_map) != 0)
WARNING: net/core/neighbour.c:154 at neigh_mark_dead+0x2fb/0x340 net/core/neighbour.c:154, CPU#0: syz.0.857/9765
Modules linked in:
CPU: 0 UID: 0 PID: 9765 Comm: syz.0.857 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:neigh_mark_dead+0x2fb/0x340 net/core/neighbour.c:154
Code: e8 03 42 80 3c 28 00 74 08 48 89 df e8 ee 9a 80 f8 4c 89 33 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 86 95 10 f8 90 <0f> 0b 90 e9 8f fd ff ff 48 c7 c1 80 9a 7a 90 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90003726600 EFLAGS: 00010287
RAX: ffffffff89b7467a RBX: ffff888022e86000 RCX: 0000000000080000
RDX: ffffc900047fa000 RSI: 0000000000003e08 RDI: 0000000000003e09
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520006e4cb8 R12: ffff888022e8613c
R13: dffffc0000000000 R14: ffff888022e86020 R15: ffff888022e86000
FS:  00007f9c30f046c0(0000) GS:ffff888124cc6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000076c56000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 neigh_flush_one+0x27c/0x5a0 net/core/neighbour.c:388
 neigh_flush_dev net/core/neighbour.c:432 [inline]
 __neigh_ifdown+0x1fb/0xc70 net/core/neighbour.c:465
 neigh_ifdown+0x1f/0x30 net/core/neighbour.c:487
 rt6_disable_ip+0x751/0x7e0 net/ipv6/route.c:5058
 addrconf_ifdown+0x155/0x1ad0 net/ipv6/addrconf.c:3892
 addrconf_notify+0x1bc/0x1050 net/ipv6/addrconf.c:-1
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_mtu net/core/dev.c:2350 [inline]
 netif_set_mtu_ext+0x5ac/0x830 net/core/dev.c:9963
 do_setlink+0xa81/0x47a0 net/core/rtnetlink.c:3247
 rtnl_setlink+0x578/0x820 net/core/rtnetlink.c:3623
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7159
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2572
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 sock_write_iter+0x2de/0x3e0 net/socket.c:1266
 do_iter_readv_writev+0x612/0x8c0 fs/read_write.c:-1
 vfs_writev+0x343/0x990 fs/read_write.c:1058
 do_writev+0x154/0x2e0 fs/read_write.c:1104
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9c2ff9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9c30f04028 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f9c30225fa0 RCX: 00007f9c2ff9e159
RDX: 0000000000000001 RSI: 00002000000003c0 RDI: 0000000000000004
RBP: 00007f9c3003506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9c30226038 R14: 00007f9c30225fa0 R15: 00007ffed3c74808
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
