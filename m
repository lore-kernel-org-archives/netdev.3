Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719E33B961
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289250; cv=none; b=BDU0mJ+A5nrwmf7ZDZKkCP1WNFm4bi+X2sJWsrPO8CPe4q91xsFOufV+G3qxXEJGuVC+nMpDBSWbu3Bwisnw62/enOgbhPmVDqaBTG2j0/jVQWU7p1ZFhVyRwkkEbC5IiN92Eqjes3hvOtKgG7+YrcyVCQ0zsml87xAlMysartI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289250; c=relaxed/simple;
	bh=ouG0aROo23jJT+b2EJuNYxdAFVWVj46OHqNHv8ixEIo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gVbYeZtfJ9DXPt1lGk2QTGXIkrgUC1GRPLwyN4f5eQ+5HafeGTYrGHe1YElwBy2DSS1ruLdk7S7sRC36qZgo+N9uaRsFVnW+2wnvuuVx/jtafPz8ZY25lr56DQ6OL2+cmqAa7hVkiJr4HKqc4TAqFEqdKWuif42d7Lhdmngt4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c307941971so1950656b6e.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 19:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289246; x=1792894046;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+ubYti4JhivmOi5yI812OU6maljYefXbpcBPFcPR84=;
        b=ee4L6sRon4putINYz8bOeaQyZ8XN3W8RgwqR7Zntthn6yo8wcm4wjmPkc5rgSey2c1
         Qo47IT+K2gwcaAZ7dvmK/QIZv7XZUDBoxQbh4hPIxAIYvcapGPycNIDB02ocwBbCH3ri
         DfowQtnZQSS3duVYORvBtmlmyC0nmKgahxKieamzHzoJTFcYTPRH5JPsiN71YxsutS9g
         6580WR9X9xNMJCT4lWnl1laISjdhP+kaQQkaGnKXMcn+YzE3dA8Lx8WsySDyM+dC/Qba
         taO7vbOllowRNyItzFKPAEUnKtWMd+mHjBYP4uzZG5/jmjlcys7+tEC9q4MQRMDgMSgJ
         g3mQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwtNm8vu65mXujonyZuwNC15KGtVneXkLLZILnTYzaKYUeEX9xKZA7iuj5j9kKZ8dMQNqf9m0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkQH04KHbKo9xUlWWlbuaTe6khbstdW92hewfKaodIfyWQPPlb
	MY0cu4FQZvgThMuXdq2mUV0Vwvy2rsU8t6riu5N5by6PuQiuIe3gpYob+0gw3SK4GTT4lwCFpQM
	TAcDH5XFISG3Me8TSuVcQZI7e3/zM+6x69U4hEhtZtLxRBvKTHwLw9wrjI3w=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3384:b0:4fc:5e91:5377 with SMTP id
 5614622812f47-53cd7d48d45mr3830438b6e.59.1792289246089; Sat, 17 Oct 2026
 19:07:26 -0700 (PDT)
Date: Sat, 17 Oct 2026 19:07:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad429de.7f4e89eb.3d59aa.00a8.GAE@google.com>
Subject: [syzbot] [tipc?] kernel BUG in pskb_expand_head (6)
From: syzbot <syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com>
To: jmaloy@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f2f7eeef8b0 Merge tag 'soc-fixes-7.3-3' of git://git.kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=141aa69c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4b098695335c89f
dashboard link: https://syzkaller.appspot.com/bug?extid=0017742620a9d06f06ef
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1250efd1580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:2308!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5940 Comm: syz-executor216 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
RIP: 0010:pskb_expand_head+0x135a/0x13a0 net/core/skbuff.c:2308
Code: e9 10 f3 ff ff e8 76 06 1b f8 4c 89 e7 48 c7 c6 80 0c 23 8d e8 97 19 7b f7 90 0f 0b e8 5f 06 1b f8 90 0f 0b e8 57 06 1b f8 90 <0f> 0b 89 d1 80 e1 07 80 c1 03 38 c1 0f 8c d8 fa ff ff 48 8b 3c 24
RSP: 0018:ffffc90000007520 EFLAGS: 00010246
RAX: ffffffff89ad0a29 RBX: dffffc0000000000 RCX: ffff88802a490000
RDX: 8000000000000100 RSI: 0000000000000100 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000100 R09: 1ffff1100e875c3a
R10: dffffc0000000000 R11: ffffed100e875c3b R12: 0000000000000820
R13: 0000000000000000 R14: 0000000000000002 R15: ffff8880743ae0f0
FS:  000055557b02f400(0000) GS:ffff888123abf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff61507fa8 CR3: 000000007506a000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __pskb_pull_tail+0x111/0x1870 net/core/skbuff.c:2890
 skb_cow_data+0x2ed/0xc50 net/core/skbuff.c:5398
 tipc_aead_decrypt net/tipc/crypto.c:892 [inline]
 tipc_crypto_rcv+0x346/0x23d0 net/tipc/crypto.c:1843
 tipc_rcv+0x4b7/0x1040 net/tipc/node.c:2119
 tipc_l2_rcv_msg+0x2d9/0x470 net/tipc/bearer.c:669
 deliver_ptype_list_skb net/core/dev.c:2533 [inline]
 __netif_receive_skb_core+0x2988/0x30c0 net/core/dev.c:6254
 __netif_receive_skb_one_core net/core/dev.c:6295 [inline]
 __netif_receive_skb net/core/dev.c:6410 [inline]
 process_backlog+0x727/0x18b0 net/core/dev.c:6761
 __napi_poll+0xaa/0x330 net/core/dev.c:7830
 napi_poll net/core/dev.c:7893 [inline]
 net_rx_action+0x61d/0xf50 net/core/dev.c:8050
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 do_softirq+0x77/0xd0 kernel/softirq.c:546
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x140 kernel/softirq.c:473
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:923 [inline]
 __dev_queue_xmit+0x1efb/0x3920 net/core/dev.c:4993
 dev_queue_xmit include/linux/netdevice.h:3464 [inline]
 tipc_l2_send_msg+0x331/0x400 net/tipc/bearer.c:517
 tipc_bearer_xmit_skb+0x2b3/0x400 net/tipc/bearer.c:576
 tipc_enable_bearer net/tipc/bearer.c:366 [inline]
 __tipc_nl_bearer_enable+0x10ec/0x1480 net/tipc/bearer.c:1048
 tipc_nl_bearer_enable+0x22/0x40 net/tipc/bearer.c:1057
 genl_family_rcv_msg_doit+0x233/0x340 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x614/0x7a0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2579
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
 netlink_unicast+0x8ef/0xa80 net/netlink/af_netlink.c:1364
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1923
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 __sys_sendto+0x408/0x5a0 net/socket.c:2281
 __do_sys_sendto net/socket.c:2288 [inline]
 __se_sys_sendto net/socket.c:2284 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2284
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f091b73dcf7
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007fff615088d0 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000055557b02f400 RCX: 00007f091b73dcf7
RDX: 0000000000000028 RSI: 00007fff61509950 RDI: 0000000000000005
RBP: 0000000000000005 R08: 00007fff61508924 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000005
R13: 00007f091b77b018 R14: 00007f091b7a2cc0 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pskb_expand_head+0x135a/0x13a0 net/core/skbuff.c:2308
Code: e9 10 f3 ff ff e8 76 06 1b f8 4c 89 e7 48 c7 c6 80 0c 23 8d e8 97 19 7b f7 90 0f 0b e8 5f 06 1b f8 90 0f 0b e8 57 06 1b f8 90 <0f> 0b 89 d1 80 e1 07 80 c1 03 38 c1 0f 8c d8 fa ff ff 48 8b 3c 24
RSP: 0018:ffffc90000007520 EFLAGS: 00010246
RAX: ffffffff89ad0a29 RBX: dffffc0000000000 RCX: ffff88802a490000
RDX: 8000000000000100 RSI: 0000000000000100 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000100 R09: 1ffff1100e875c3a
R10: dffffc0000000000 R11: ffffed100e875c3b R12: 0000000000000820
R13: 0000000000000000 R14: 0000000000000002 R15: ffff8880743ae0f0
FS:  000055557b02f400(0000) GS:ffff888123abf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff61507fa8 CR3: 000000007506a000 CR4: 00000000003526f0


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
