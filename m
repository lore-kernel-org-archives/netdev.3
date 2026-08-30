Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C193B0599
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788094230; cv=none; b=b8vraH1OQs30oGHNQ57M+l7+Ur983u9yg5WGK5wFl83bQolFJ546WXcFZsD32UVVXoyAuWnb3o7uBkhYVNbIpfztLoZeW5PGO1NmNpYHWWTAbjwchzFmv51tyk2Wqw07DQ+uqBfAPQKkHgAmbrHtnLWUsRFrijTZQjVjOjctBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788094230; c=relaxed/simple;
	bh=C6E7Y94FP+suWFyULPZWMPFn3OYYCjHsZw7LbY90qHY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KLEW5ixZVLwsWz5CeW8kiV3TVMxppUhjiG9SqIOX/GD3IFqSkXy/HeoKYXvyW8RKvWN7qLq1F6BTiGrC/epjwiCC6muI+WAfgdtarcheOcFaXa1rMDkalCcaHWsW19X/I5T0E0VJ6m95VQiUdO+eWbeDugGk6V3kuhlebTpHZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-4489b7aa0e7so690944fac.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 05:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788094228; x=1788699028;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/XI9Sq1kNaZAPWZ2QuqGzoa86CKZO8KeH/ZtsnkY1c4=;
        b=hb+k7hOhgDgIuEM8FFUcDYCA3LmlsV3b2+0Cq3+qFX2xbPyGMQFs/zkzOxJwlUUrqk
         ANuTysqY76oxlsyhjVmlCYYm52eceBxPVo0F9X6EaN8rmqcW7T/xtW9e5GWdbe+D4T2B
         iuoHMj1nSSr6Wy1V9siznxwnNYGalIndMXLSRQjxdepOySRazm4dTyEegi6AR71IKgZf
         sftnQHq+WTxZLTmsO1Ktlw3XFiOpi/7tO79ICg5pU88bC/BWOh0FcD2RDQLe2CoI11a4
         YpBE3hIUcat8tQIZHCivA10c3Umm6NvxlFCwt1FFeiOCIpYTp9fT3BE2wBfyyBlJF4nN
         fAzg==
X-Forwarded-Encrypted: i=1; AHgh+RrdodaIpH1V/czBlCBSjQwKwbW6T1id0NLjOmq9iJZ1fMxAQMRxTlEzioz9mGlu34KbNeU6g3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lj8gx1pSEMrh54KPvjxl6Zx3F0STsfSM7pa67cCEDXVf7l1UjT
	mSxSDrmPEldl0xDudgSpELQR9SYuRGKqDvMOYK7nGGSFFwN5ZsS/p4sWmEs8ZkVYsmIpFwbKUnG
	4vZP1SB4XBKTOYoF0gviQ3IFzuOWrcUrYLnGCIKi4PH7KQWetKgi/MH5ovAk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2229:b0:496:2b3:ae71 with SMTP id
 5614622812f47-4b39839d589mr22177376b6e.18.1788094228273; Sun, 30 Aug 2026
 05:50:28 -0700 (PDT)
Date: Sun, 30 Aug 2026 05:50:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a942714.4d659fcc.734b4.003a.GAE@google.com>
Subject: [syzbot] [usb?] [nfc?] [net?] memory leak in nci_send_cmd
From: syzbot <syzbot+b197a0fb4e741cc5030e@syzkaller.appspotmail.com>
To: davem@davemloft.net, david@ixit.cz, edumazet@google.com, horms@kernel.org, 
	krzk@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	oe-linux-nfc@lists.linux.dev, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    73ae59e97596 Merge tag 'erofs-for-7.3-rc1-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e70d49580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=563582168294b9d9
dashboard link: https://syzkaller.appspot.com/bug?extid=b197a0fb4e741cc5030e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11df1625580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148b6979580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0e5c9cbfb31a/disk-73ae59e9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/481171cf3bc4/vmlinux-73ae59e9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9df84fec3c49/bzImage-73ae59e9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b197a0fb4e741cc5030e@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810a94e600 (size 240):
  comm "syz.6.23", pid 5954, jiffies 4294942380
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 40 38 2b 81 88 ff ff 00 00 00 00 00 00 00 00  .@8+............
  backtrace (crc 98a4d7):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4696 [inline]
    slab_alloc_node mm/slub.c:4996 [inline]
    kmem_cache_alloc_node_noprof+0x39f/0x440 mm/slub.c:5068
    __alloc_skb+0xdc/0x4e0 net/core/skbuff.c:704
    alloc_skb include/linux/skbuff.h:1384 [inline]
    nci_skb_alloc include/net/nfc/nci_core.h:330 [inline]
    nci_send_cmd+0x46/0x110 net/nfc/nci/core.c:1397
    nci_reset_req net/nfc/nci/core.c:167 [inline]
    __nci_request net/nfc/nci/core.c:108 [inline]
    nci_open_device net/nfc/nci/core.c:503 [inline]
    nci_dev_up+0x1b6/0x690 net/nfc/nci/core.c:643
    nfc_dev_up+0xca/0x160 net/nfc/core.c:118
    nfc_genl_dev_up+0x3d/0x70 net/nfc/netlink.c:775
    genl_family_rcv_msg_doit+0x12e/0x1a0 net/netlink/genetlink.c:1114
    genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
    genl_rcv_msg+0x302/0x440 net/netlink/genetlink.c:1209
    netlink_rcv_skb+0x89/0x1c0 net/netlink/af_netlink.c:2556
    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
    netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
    netlink_unicast+0x38f/0x4e0 net/netlink/af_netlink.c:1345
    netlink_sendmsg+0x335/0x690 net/netlink/af_netlink.c:1900
    sock_sendmsg_nosec net/socket.c:800 [inline]
    __sock_sendmsg net/socket.c:815 [inline]
    ____sys_sendmsg+0x54a/0x580 net/socket.c:2713
    ___sys_sendmsg+0x101/0x140 net/socket.c:2767
    __sys_sendmsg+0xcd/0x140 net/socket.c:2799
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84

BUG: memory leak
unreferenced object 0xffff888109c4bc80 (size 704):
  comm "syz.6.23", pid 5954, jiffies 4294942380
  hex dump (first 32 bytes):
    20 00 01 01 00 00 00 00 00 00 00 00 00 00 00 00   ...............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 40ddf9):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4696 [inline]
    slab_alloc_node mm/slub.c:4996 [inline]
    kmem_cache_alloc_node_noprof+0x39f/0x440 mm/slub.c:5068
    kmalloc_reserve+0xd2/0x1b0 net/core/skbuff.c:615
    __alloc_skb+0x15d/0x4e0 net/core/skbuff.c:715
    alloc_skb include/linux/skbuff.h:1384 [inline]
    nci_skb_alloc include/net/nfc/nci_core.h:330 [inline]
    nci_send_cmd+0x46/0x110 net/nfc/nci/core.c:1397
    nci_reset_req net/nfc/nci/core.c:167 [inline]
    __nci_request net/nfc/nci/core.c:108 [inline]
    nci_open_device net/nfc/nci/core.c:503 [inline]
    nci_dev_up+0x1b6/0x690 net/nfc/nci/core.c:643
    nfc_dev_up+0xca/0x160 net/nfc/core.c:118
    nfc_genl_dev_up+0x3d/0x70 net/nfc/netlink.c:775
    genl_family_rcv_msg_doit+0x12e/0x1a0 net/netlink/genetlink.c:1114
    genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
    genl_rcv_msg+0x302/0x440 net/netlink/genetlink.c:1209
    netlink_rcv_skb+0x89/0x1c0 net/netlink/af_netlink.c:2556
    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
    netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
    netlink_unicast+0x38f/0x4e0 net/netlink/af_netlink.c:1345
    netlink_sendmsg+0x335/0x690 net/netlink/af_netlink.c:1900
    sock_sendmsg_nosec net/socket.c:800 [inline]
    __sock_sendmsg net/socket.c:815 [inline]
    ____sys_sendmsg+0x54a/0x580 net/socket.c:2713
    ___sys_sendmsg+0x101/0x140 net/socket.c:2767
    __sys_sendmsg+0xcd/0x140 net/socket.c:2799

BUG: memory leak
unreferenced object 0xffff88810aa0d700 (size 240):
  comm "syz.0.26", pid 5976, jiffies 4294942681
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 a0 5b 28 81 88 ff ff 00 00 00 00 00 00 00 00  ..[(............
  backtrace (crc cdb4723c):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4696 [inline]
    slab_alloc_node mm/slub.c:4996 [inline]
    kmem_cache_alloc_node_noprof+0x39f/0x440 mm/slub.c:5068
    __alloc_skb+0xdc/0x4e0 net/core/skbuff.c:704
    alloc_skb include/linux/skbuff.h:1384 [inline]
    nci_skb_alloc include/net/nfc/nci_core.h:330 [inline]
    nci_send_cmd+0x46/0x110 net/nfc/nci/core.c:1397
    nci_reset_req net/nfc/nci/core.c:167 [inline]
    __nci_request net/nfc/nci/core.c:108 [inline]
    nci_open_device net/nfc/nci/core.c:503 [inline]
    nci_dev_up+0x1b6/0x690 net/nfc/nci/core.c:643
    nfc_dev_up+0xca/0x160 net/nfc/core.c:118
    nfc_genl_dev_up+0x3d/0x70 net/nfc/netlink.c:775
    genl_family_rcv_msg_doit+0x12e/0x1a0 net/netlink/genetlink.c:1114
    genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
    genl_rcv_msg+0x302/0x440 net/netlink/genetlink.c:1209
    netlink_rcv_skb+0x89/0x1c0 net/netlink/af_netlink.c:2556
    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
    netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
    netlink_unicast+0x38f/0x4e0 net/netlink/af_netlink.c:1345
    netlink_sendmsg+0x335/0x690 net/netlink/af_netlink.c:1900
    sock_sendmsg_nosec net/socket.c:800 [inline]
    __sock_sendmsg net/socket.c:815 [inline]
    ____sys_sendmsg+0x54a/0x580 net/socket.c:2713
    ___sys_sendmsg+0x101/0x140 net/socket.c:2767
    __sys_sendmsg+0xcd/0x140 net/socket.c:2799
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84

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
