Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDFD39F162
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721624; cv=none; b=FLUV44gvtbIW/q997LPGWnDLcg5CBVaWN5cfX5bnAe1hFBVxSmEHEe0uaiMLOgvv2tL7URJQJ4qTCW+Vl9ekV8V+GpIFcfxaEAiYkLY+6qs8WFlzOASTgSTNi5mifhoDh8ZFOePXT5s3UE9cd9WZ0R83wbu5879iSpb4sf63zjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721624; c=relaxed/simple;
	bh=aH+UW4tiet+jqWWtba253aMJtniIXAJZMf1jc5j+snA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N43cFIf5RH5F0+iUgBGTkjTEzmCLLSjsyf2AlWAHxmPli1SwMiTDv7gUtbpkaL9MvxWQWU0aBOzZTGUaA2m/HrEWNdZonNZeAaN2Qsz/iyuxtDf2DpQOV9er3lDtXIMfWf3i6YGph085iUNZ8FMsHJZmZR5OwpSSiE+ZkUOTAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4a485034d01so1454663b6e.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786721621; x=1787326421;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNNIeDuIr12EGfrqamsjcTCncp/55vur9umFXrMPoJ8=;
        b=n8+yWNf7tPJb33fhBUUxslVQCIVdvQJyNa338GXpfEtEglIdfFSDPzf0s9QKyaKhMS
         gAJPbWYfUYnJ1dCxUxNTXgJcyfrlCBw4y/zCvL8KE5A70Ii2KcIYM3cvrxep7FRksCvq
         d0A4e5M4NFKVAp3wyphZC7G1PFjDbuIeUZ+KlZfa4rWFMvuJW2Xq+Ua699QZTfF9Ynm1
         ZfE2ono5QVvBwhmsG+43Y1B24twyDaYpC8hubhxE20TJEQTfESA/X2QP5ay5Ki+FytZl
         fFPc5kSj7oM2pUUgWCwc6KlQL+v/AGPQSxAxctsd+qYpb7kv8cXLWRb0MuM1zyDWwXzC
         8JbQ==
X-Forwarded-Encrypted: i=1; AHgh+Ron/Nv7qEi7h51ADIS7ALuNpfcs+I/YO7QP2VrCCW9ud/G7Crc2va/VCoextcydPtjWp2xZn3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhHkDvdN6apd7cPrgd9t6Ei8i2SFuL136a3benjX6JuZLd5MP2
	8qklzaUPdpSVnDArwumI7xpvyS0KEDp7YBHmollX90wm6DKNDOLdLnXcom9hNVuQCSbHqy6dEIo
	966chPDqWbfDL+wTlIFrrPqg2mTuM6eo8pqxZI1eymZkFawKHOr3dPt4dW2k=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee10:0:b0:6ae:774d:45ab with SMTP id
 006d021491bc7-6b0d688e363mr5581738eaf.27.1786721621146; Fri, 14 Aug 2026
 08:33:41 -0700 (PDT)
Date: Fri, 14 Aug 2026 08:33:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7f3555.dbb3a75c.20434b.0005.GAE@google.com>
Subject: [syzbot] [net?] WARNING in rtmsg_ifinfo_build_skb
From: syzbot <syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    02dc699f83d0 Merge tag 'kbuild-fixes-7.2-1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17320db9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=f2f6312ad1b5a0bfe316
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d0e5b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f9cc9e580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-02dc699f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/faf03a1fb300/vmlinux-02dc699f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a48e50ceca1d/bzImage-02dc699f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com

------------[ cut here ]------------
err == -EMSGSIZE
WARNING: net/core/rtnetlink.c:4538 at rtmsg_ifinfo_build_skb+0x1c1/0x260 net/core/rtnetlink.c:4538, CPU#1: syz.0.17/5924
Modules linked in:
CPU: 1 UID: 0 PID: 5924 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:rtmsg_ifinfo_build_skb+0x1c1/0x260 net/core/rtnetlink.c:4538
Code: ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 80 00 00 00 45 8b 76 08 e9 3c ff ff ff e8 40 d7 73 f8 90 <0f> 0b 90 ba 02 00 00 00 48 89 ee 31 ff bb a6 ff ff ff e8 d8 8f f0
RSP: 0018:ffffc90004266df0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffa6 RCX: ffffffff89968a40
RDX: ffff888034e5a540 RSI: ffffffff89968aa0 RDI: ffff888034e5a540
RBP: ffff88803d24db80 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffa6 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880578ce108
FS:  000055558858a500(0000) GS:ffff8880d5ed8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001140 CR3: 0000000036c7c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 rtmsg_ifinfo_event net/core/rtnetlink.c:4566 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4556 [inline]
 rtnetlink_event+0x137/0x1f0 net/core/rtnetlink.c:7136
 notifier_call_chain+0x99/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2250
 call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
 call_netdevice_notifiers net/core/dev.c:2302 [inline]
 netdev_features_change net/core/dev.c:1590 [inline]
 netdev_update_features net/core/dev.c:11108 [inline]
 netdev_update_features net/core/dev.c:11105 [inline]
 netif_disable_lro+0x3e9/0x660 net/core/dev.c:1831
 inetdev_init+0x371/0x570 net/ipv4/devinet.c:284
 inetdev_event+0x7fa/0x17f0 net/ipv4/devinet.c:1590
 notifier_call_chain+0x99/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2250
 call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
 call_netdevice_notifiers net/core/dev.c:2302 [inline]
 register_netdevice+0x1998/0x25a0 net/core/dev.c:11484
 macsec_newlink+0x4fb/0x1c50 drivers/net/macsec.c:4221
 rtnl_newlink_create net/core/rtnetlink.c:3913 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4044 [inline]
 rtnl_newlink+0x1499/0x2380 net/core/rtnetlink.c:4159
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:7076
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0xa4d/0xbe0 net/socket.c:2684
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2738
 __sys_sendmsg+0x160/0x210 net/socket.c:2770
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbf0c99e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe9eca118 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fbf0cc25fa0 RCX: 00007fbf0c99e019
RDX: 0000000000000000 RSI: 0000200000000280 RDI: 0000000000000005
RBP: 00007fbf0ca3500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbf0cc25fac R14: 00007fbf0cc25fa0 R15: 00007fbf0cc25fa0
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
