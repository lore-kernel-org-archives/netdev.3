Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149554652
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370223; cv=none; b=e4rVijFDSAuoxThwQUAFCJ7oOOEqlagieTaF4Hed0ZCye6FQimhEUKzyJeKWT1m3PwkLbCuavobDEGAByS2uRRn4B7HxegYgoHdovTedSTtEC6UvU/93L5gzOA1clxQUj4oYCnLgHoz3Bq3y2PE2rgvZNNjAl6/bJhp75v4Xoq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370223; c=relaxed/simple;
	bh=snJe4V7v9azVi3PukWSdG/n+yrAWrWA2wzpOynTa1nE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aewnwtv1YxnVD1/9oIY4mjZZ/Qpe6a1bx+LOrx9T/FK/+oDxP0u+HdAkXHQMkIEPx34/2Wdo7QY5HxvNEA1JoySvnkZGbLGx6XxnlZRgqnd8DGD3y5gGxM2xU+FY1wVYA6pQQqn6CkvrjdK2TTcolFjQeLA7qm+sYNYxEVp+Rjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-44aeefa1c36so643200fac.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 17:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785370220; x=1785975020;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kSNPU2uVFYT61FmWdc/DUsTjNi3Eqwki3en1z3v5W3c=;
        b=VM4Uge29mbYIxfQifAbwWvI5O79CR0NVpzwh6e6dXMx1YOb0JZLbXR/QaOSAXB8bFp
         4KMpYRW6DGgS1Pk5fANbb7ItztWQmxYleWxoOlieTdNFhXeKtGIqrbcacKBhlhyCMliz
         g4REp5ACOZ1wsXkmrFm668Qy5tyqdyCAkGCKRkJ8AuP19CKtbtGOV9evT9UHnrThCDdk
         WxRhNdy+LY3kNiliu2VA6dQt5Fc8PaDrTyAsFqp6ULShcW7Ychk0+zbArBcSXbDUHsyl
         Rv3BF9l/Xoj8p2X/VxKQu5r3hzckbDfmlRu87rKo8NJwikXhGZkABWxr57AOi6kIB/Uw
         MlnA==
X-Forwarded-Encrypted: i=1; AHgh+Rq34MZi/vkJ2EsO/ywAZAmn2j4UA+whrVMzMBaaNaHt46uLU1xojBITDV4fl6Ypo1HaIAKzAH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw4UGlZG70Py/mhDlWtGu5G4ydbAOlPhtb+DYSZbVNce80FpVG
	rVRSBHMMBszHPD+MnwYqOWX5NJ35ksZj875RkJsIeQE1WnU/uk1O615jS5PJq18w8iLekYTtk9B
	Kdy5qfvUWjd4/UJui/s8ukmPy30lLsnlFO8YP1gnCXf5ShQiM/w36P7CKQ4U=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:159a:b0:492:9e13:d5a7 with SMTP id
 5614622812f47-4ad876c9e1amr379559b6e.6.1785370220691; Wed, 29 Jul 2026
 17:10:20 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:10:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6a966c.86abc875.e5c3d.0054.GAE@google.com>
Subject: [syzbot] [net?] WARNING in udp_v6_send_skb
From: syzbot <syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    04026c998c24 net/rds: use krealloc_array() for iovector gr..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=163a6499580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9f592a4e0cc86da
dashboard link: https://syzkaller.appspot.com/bug?extid=ce13c07d96d04716eaa2
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4f82b6352d02/disk-04026c99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9b29e52c71b2/vmlinux-04026c99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b1e84e828d6/bzImage-04026c99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com

------------[ cut here ]------------
len >= 65536u
WARNING: ./include/linux/udp.h:49 at udp_set_len_short include/linux/udp.h:49 [inline], CPU#0: syz.4.4430/24120
WARNING: ./include/linux/udp.h:49 at udp_v6_send_skb+0xd3b/0x13a0 net/ipv6/udp.c:1375, CPU#0: syz.4.4430/24120
Modules linked in:
CPU: 0 UID: 0 PID: 24120 Comm: syz.4.4430 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:udp_set_len_short include/linux/udp.h:49 [inline]
RIP: 0010:udp_v6_send_skb+0xd3b/0x13a0 net/ipv6/udp.c:1375
Code: 42 0f b6 04 38 84 c0 0f 85 37 06 00 00 41 0f b7 1e e9 60 f3 ff ff e8 04 c3 43 f7 90 0f 0b 90 e9 02 f4 ff ff e8 f6 c2 43 f7 90 <0f> 0b 90 e9 e9 f4 ff ff e8 e8 c2 43 f7 90 0f 0b 90 e9 94 f5 ff ff
RSP: 0018:ffffc9000e0a74c8 EFLAGS: 00010287
RAX: ffffffff8a833e8a RBX: ffff8880355e4a00 RCX: 0000000000080000
RDX: ffffc900100ca000 RSI: 00000000000049e3 RDI: 00000000000049e4
RBP: 000000000000244c R08: ffff888049ed5d00 R09: 0000000000000003
R10: 000000000000000b R11: 0000000000000002 R12: dffffc0000000000
R13: ffff888027cb0c80 R14: 0000000000010000 R15: ffff8880355e4a02
FS:  00007f2d4a07b6c0(0000) GS:ffff888124f54000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000010000 CR3: 0000000029d28000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 udp_v6_push_pending_frames+0xa2/0x140 net/ipv6/udp.c:1451
 udpv6_sendmsg+0xfa0/0x2610 net/ipv6/udp.c:1740
 sock_sendmsg_nosec+0x90/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmmsg+0x273/0x4d0 net/socket.c:2827
 __do_sys_sendmmsg net/socket.c:2854 [inline]
 __se_sys_sendmmsg net/socket.c:2851 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2851
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d4919de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2d4a07b028 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f2d49425fa0 RCX: 00007f2d4919de99
RDX: 0000000000000001 RSI: 0000200000006780 RDI: 0000000000000019
RBP: 00007f2d49233eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2d49426038 R14: 00007f2d49425fa0 R15: 00007ffdc2399288
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
