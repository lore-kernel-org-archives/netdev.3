Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE7A311973
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696520; cv=none; b=e2GiwFhnUsC6zdhZftStjR48v4/CfRkKjezAslJPQ/4PlSBqVfDbEiXhbhqPKQynERMMfpj4NplVEuypZnNpMFRXb5pSG3s8tUxMP2oLe8ssM2aGJ2eYG4GKQ7Gc5WxJfyl68jWk3bVonDhVig8Vgdsopm9fH7IGJPZ730lFwyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696520; c=relaxed/simple;
	bh=sGq+odP6TlzhDeK4Kw02zvpGlY5+ERWu1BY5PE7Nu8o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YpJvYccwqGDT2J3aAIbWxKy5TeGSxs0d/nJXLc1L88Gd9llhUJ3H2oNKpo13BCiwJu8LctADNZHRneqSAr+NvXj56/B12pL2zUoZaKve1yZUpz/udsRrqjUOqLmL2I1xfgfb6VgKYcOVJgRKt+jAAaIVnnaOL4Me+7g/MzLmfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4a43d32fa9fso3689688b6e.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 11:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785696518; x=1786301318;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCIBAN2cYYYrLre0WuiWXMKYurAAnLOHcZZe9FXWc88=;
        b=BrOC+DpEPsgpD2/8P/mcbpWOKO+qA1QsL0/bXGCWNEmCeyMeEIz5cbkRLq9HJ7gxuB
         /cWmK4AqkP82aSIQGXjBw2IMRlcaD6GmPrdHdGg7WzKibhXn0+a+yTtkd3dLcdK/HuvD
         qu53AejqfZmZdtSNFQzgfSOEZxPTH7i5cwl7JQcPF/hiLNJbDB5RnlSbvof95rH8eGVc
         1lpHfgaDRp9hKkZ+OoXsn3qo0IK2j7Wh8crnH9KJLuB1Mp56EhMBeJd93m9ILrZs8iLP
         aEpbWxCSzQJATPPrmbtAGMBgrbXRTjn5Nd88hOwvWm2T0vL77XI/XHAjlBLovm2mpROo
         UaYA==
X-Forwarded-Encrypted: i=1; AHgh+RrbV37O+x42BlqTHCKnsMGmaIvFAA7ksgWWFJIRRlnDOFKEajySfJ8roepddYhsVN0ynNcN+84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2xQuWjCmCwiq1ctHhdHUGNZOaZKrD1H7qtp8jidUWvyk+FZJ5
	5rvEhUaJu6PXsvTWSwGiAkSSSi8sx8ZnzOXWd0kG2PUOhBB1+VVWgkQU7RGFG5Ub0VznTEIXE5e
	tCq4y494jf86B/MZLPIhs1iFe7Dr7K1ZqdUIWIQxEscIAnW4y9uEtK6drezs=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:d52:b0:497:deab:2bfe with SMTP id
 5614622812f47-4af5dfb3c0dmr12641156b6e.1.1785696517879; Sun, 02 Aug 2026
 11:48:37 -0700 (PDT)
Date: Sun, 02 Aug 2026 11:48:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6f9105.1aa927e4.17d4bf.001b.GAE@google.com>
Subject: [syzbot] [net?] WARNING in ipgre_xmit (2)
From: syzbot <syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc02acf6ac0c Merge tag 'platform-drivers-x86-v7.2-4' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1314d632580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c05be6c9b0d36cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-fc02acf6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a67a14a03b39/vmlinux-fc02acf6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/328affe48b77/bzImage-fc02acf6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com

------------[ cut here ]------------
len > ((int)(~0U >> 1))
WARNING: ./include/linux/skbuff.h:2864 at pskb_may_pull_reason include/linux/skbuff.h:2864 [inline], CPU#0: syz.0.0/5325
WARNING: ./include/linux/skbuff.h:2864 at pskb_network_may_pull_reason include/linux/skbuff.h:3265 [inline], CPU#0: syz.0.0/5325
WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull_reason include/net/ip_tunnels.h:481 [inline], CPU#0: syz.0.0/5325
WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull include/net/ip_tunnels.h:486 [inline], CPU#0: syz.0.0/5325
WARNING: ./include/linux/skbuff.h:2864 at ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658, CPU#0: syz.0.0/5325
Modules linked in:
CPU: 0 UID: 0 PID: 5325 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2864 [inline]
RIP: 0010:pskb_network_may_pull_reason include/linux/skbuff.h:3265 [inline]
RIP: 0010:pskb_inet_may_pull_reason include/net/ip_tunnels.h:481 [inline]
RIP: 0010:pskb_inet_may_pull include/net/ip_tunnels.h:486 [inline]
RIP: 0010:ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658
Code: 48 3b 84 24 80 00 00 00 0f 85 3b 01 00 00 31 c0 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 3f e9 77 01 cc e8 e9 05 69 f7 90 <0f> 0b 90 e9 08 f8 ff ff 44 89 ff 44 89 e6 e8 95 07 69 f7 45 39 e7
RSP: 0018:ffffc9000e4cf600 EFLAGS: 00010283
RAX: ffffffff8a5e0e67 RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc9000eef2000 RSI: 00000000000000bb RDI: 00000000000000bc
RBP: ffffc9000e4cf6d0 R08: ffff888035d20000 R09: 0000000000000002
R10: 0000000000004888 R11: ffffffff8a5e0510 R12: ffff88801244e000
R13: dffffc0000000000 R14: ffff888043f173c0 R15: 00000000ffffff40
FS:  00007f99c17006c0(0000) GS:ffff88808c543000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f99c0a12a18 CR3: 0000000042b19000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __netdev_start_xmit include/linux/netdevice.h:5400 [inline]
 netdev_start_xmit include/linux/netdevice.h:5409 [inline]
 __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:4942
 __xsk_generic_xmit net/xdp/xsk.c:1079 [inline]
 xsk_generic_xmit+0x277a/0x40a0 net/xdp/xsk.c:1120
 __xsk_sendmsg net/xdp/xsk.c:1174 [inline]
 xsk_sendmsg+0x482/0x810 net/xdp/xsk.c:1184
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f99c079de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f99c16fffe8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f99c0a25fa0 RCX: 00007f99c079de99
RDX: 0000000000000040 RSI: 0000200000000700 RDI: 0000000000000006
RBP: 00007f99c0833eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f99c0a26038 R14: 00007f99c0a25fa0 R15: 00007ffdd0e42b38
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
