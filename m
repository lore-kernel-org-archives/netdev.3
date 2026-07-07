Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3C30E0CC
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412428; cv=none; b=Zq37x80AnDaS+MBrKed94oFftCEPlPjKS/VOWi3XXJcdkNKZeNvSLf+G5HuB+ki6uRr95Wwk3MhEEHfh09surXFWH+3GWci/Isn1Gu90BalJ9n2I3dGGdpUHuE5OQQHZ+OOvlMYsehHwfNFWsvivk7ly5dBfnDmDROPrdm469P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412428; c=relaxed/simple;
	bh=Hjiyxg2eUNmBvt4aUNqjtkRdpxTKWi4LfPWtvi9ZFOo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hFDcJYIBZzqcYiuowUiKsEGRJTrmiiJm6qC3tl49Lrscg2n7MWyyP5Zf2l1sT0y78BVeizXcp2/Ljd+WeyOxXldfwoOfsfYWPgWahS8Zzib96LFHTA+OMLaJ7z46pyZauhTqYHKj6rm7j/OwaraIPHILV+/CmnpCwW7SLtfY5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-495e6bbed50so460123b6e.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 01:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783412426; x=1784017226;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OY3pUOoki3lJk4N4z7FkJAxOZfZdPekPl+bIFkFpNbA=;
        b=K8K1IA8AwLQvLY54+9xHeUTf93xbFzmp0Nvir0hRPmFjRclzrNKBSdtgA4HEoY3p80
         p4tcVSGTwEVKdyHz8Smj/JBX+iXMFUIvdq16U9cjmJCNii4YVbGn3kHUc9tNuPvvPDM7
         zTim0Hg8C6pvT41mo+YxNKeGiGbHLXLM854Dc2g3kbkJUpqdHbtcgJNx8KuapCO0WsRX
         UyIURMvMeaXr+fBaFABA002HhNUklyLqX17SuqQUumsyDVLafMPuyNg9oFyXzPwJioVV
         1t2j0S9mmQ24DT4yUKTERTi1No+JVkOTnJfL1P7Dh4NuAWDBXiSxDzx5dzqBySdZU0gj
         J8wA==
X-Forwarded-Encrypted: i=1; AFNElJ924lVP3s6GlKw0eIYplIi1OEqGYvTREgn4hWcOW+QTOZmVdB9ttY0o6G1tUr/AzmePG7pvQfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpekhlSNleoXyYWfVz+NI66KzPW3YdK64v6LDEesKhb82Q6mr
	KrvqVIByEWQboVeyD6RrDSz9vGPw8psm6O/M3BR7L1qZiXWMhHU0sgad0mZKTxpx64Kstuuau+O
	CQgvIBN0UqzTgpdb2F6er84rr4JJdbMCJGSVsFFHGmuyUzkP/ByJOpzIMUCk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:309b:b0:495:f8a5:8797 with SMTP id
 5614622812f47-4a073dc4eb4mr1753390b6e.0.1783412426131; Tue, 07 Jul 2026
 01:20:26 -0700 (PDT)
Date: Tue, 07 Jul 2026 01:20:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4cb6ca.57639fcc.86d58.000b.GAE@google.com>
Subject: [syzbot] [net?] memory leak in vlan_vid_add
From: syzbot <syzbot+456957213f32970c0762@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    71dfdfb0209b Merge tag 'vfs-7.2-rc2.fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13bbf1b1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b80376788da8bcda
dashboard link: https://syzkaller.appspot.com/bug?extid=456957213f32970c0762
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10166ffe580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16218b1c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d3c154e8d39b/disk-71dfdfb0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f35a0982146/vmlinux-71dfdfb0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc56d29c15a3/bzImage-71dfdfb0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+456957213f32970c0762@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881147f3c00 (size 256):
  comm "syz-executor", pid 5805, jiffies 4294943736
  hex dump (first 32 bytes):
    00 40 02 0b 81 88 ff ff 00 00 00 00 00 00 00 00  .@..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a66a6b91):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4625 [inline]
    slab_alloc_node mm/slub.c:4945 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5511
    _kmalloc_noprof include/linux/slab.h:969 [inline]
    _kzalloc_noprof include/linux/slab.h:1290 [inline]
    vlan_info_alloc net/8021q/vlan_core.c:153 [inline]
    vlan_vid_add+0x1ff/0x2b0 net/8021q/vlan_core.c:329
    vlan_vid0_add net/8021q/vlan.c:349 [inline]
    vlan_device_event.cold+0x27/0x65 net/8021q/vlan.c:388
    notifier_call_chain+0x59/0x160 kernel/notifier.c:85
    call_netdevice_notifiers_info+0x7d/0xb0 net/core/dev.c:2250
    call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
    call_netdevice_notifiers net/core/dev.c:2302 [inline]
    __dev_notify_flags+0xb1/0x1b0 net/core/dev.c:9793
    netif_change_flags+0x71/0x90 net/core/dev.c:9822
    do_setlink.isra.0+0x50e/0x1ce0 net/core/rtnetlink.c:3215
    rtnl_changelink net/core/rtnetlink.c:3849 [inline]
    __rtnl_newlink net/core/rtnetlink.c:4022 [inline]
    rtnl_newlink+0xb23/0x1310 net/core/rtnetlink.c:4159
    rtnetlink_rcv_msg+0x52b/0x600 net/core/rtnetlink.c:7076
    netlink_rcv_skb+0x89/0x1c0 net/netlink/af_netlink.c:2556
    netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
    netlink_unicast+0x38f/0x4e0 net/netlink/af_netlink.c:1345
    netlink_sendmsg+0x335/0x690 net/netlink/af_netlink.c:1900
    sock_sendmsg_nosec net/socket.c:775 [inline]
    __sock_sendmsg net/socket.c:790 [inline]
    __sys_sendto+0x2ca/0x2e0 net/socket.c:2252
    __do_sys_sendto net/socket.c:2259 [inline]
    __se_sys_sendto net/socket.c:2255 [inline]
    __x64_sys_sendto+0x28/0x30 net/socket.c:2255
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94

BUG: memory leak
unreferenced object 0xffff8881127a3660 (size 32):
  comm "syz-executor", pid 5805, jiffies 4294943736
  hex dump (first 32 bytes):
    a0 3c 7f 14 81 88 ff ff a0 3c 7f 14 81 88 ff ff  .<.......<......
    81 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a6a88710):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4625 [inline]
    slab_alloc_node mm/slub.c:4945 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5511
    _kmalloc_noprof include/linux/slab.h:969 [inline]
    _kzalloc_noprof include/linux/slab.h:1290 [inline]
    vlan_vid_info_alloc net/8021q/vlan_core.c:196 [inline]
    __vlan_vid_add net/8021q/vlan_core.c:302 [inline]
    vlan_vid_add+0x14f/0x2b0 net/8021q/vlan_core.c:336
    vlan_vid0_add net/8021q/vlan.c:349 [inline]
    vlan_device_event.cold+0x27/0x65 net/8021q/vlan.c:388
    notifier_call_chain+0x59/0x160 kernel/notifier.c:85
    call_netdevice_notifiers_info+0x7d/0xb0 net/core/dev.c:2250
    call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
    call_netdevice_notifiers net/core/dev.c:2302 [inline]
    __dev_notify_flags+0xb1/0x1b0 net/core/dev.c:9793
    netif_change_flags+0x71/0x90 net/core/dev.c:9822
    do_setlink.isra.0+0x50e/0x1ce0 net/core/rtnetlink.c:3215
    rtnl_changelink net/core/rtnetlink.c:3849 [inline]
    __rtnl_newlink net/core/rtnetlink.c:4022 [inline]
    rtnl_newlink+0xb23/0x1310 net/core/rtnetlink.c:4159
    rtnetlink_rcv_msg+0x52b/0x600 net/core/rtnetlink.c:7076
    netlink_rcv_skb+0x89/0x1c0 net/netlink/af_netlink.c:2556
    netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
    netlink_unicast+0x38f/0x4e0 net/netlink/af_netlink.c:1345
    netlink_sendmsg+0x335/0x690 net/netlink/af_netlink.c:1900
    sock_sendmsg_nosec net/socket.c:775 [inline]
    __sock_sendmsg net/socket.c:790 [inline]
    __sys_sendto+0x2ca/0x2e0 net/socket.c:2252
    __do_sys_sendto net/socket.c:2259 [inline]
    __se_sys_sendto net/socket.c:2255 [inline]
    __x64_sys_sendto+0x28/0x30 net/socket.c:2255
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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
