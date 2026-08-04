Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ADA47CA9E
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862910; cv=none; b=Ig9zL0Z/BxCyKZHw0maafoO/ZSzQSUt4Mpi6QuwRSjs/YqZw22X0D1PqqGHzOzjdngmaMXyxVkhC0TKO/hUhFjqpuuNCzCynSlm8MQO/7FwlZ8aeaWt2HdpM9wIQGzRdcSOWWYVMbnarbbo4mpVFIF/ssx51vdmFF6sF2RTVYRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862910; c=relaxed/simple;
	bh=AXJkorNTacYIuGn8PIp7IKVMWx+i20Mzs/6C15iQGFQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KIaHDixU2LIUiUl/M8KqgYtHLJCN2749wAvHW0bUV5iC2mnqaxoCjySCAIdBSlJWYP6tH1kDPC5TcmMQFgcy2CTi4VzCGZzCM1UuMuAIUOEWjm6f1YMwSkh+q97wTs+qGfUC6AUHt5PVg2IqEsvBkGGWVWdmdVdFg8uMFKo39MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6ab1946bb8eso82652eaf.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 10:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862893; x=1786467693;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IA8IVfUPjKlyNF0LpBtdvGn/1kyZDtNIWrtz8Lq9ops=;
        b=BbzisIOko/pdww2UdWst8mh5dwEL3e+GQAqDUnh33qOSi472+a9VOQ56TMjzcep8M4
         rE3w33IU6nL1zw7nZ251/1BZN7b/6fsG7R4jvRSQZUq8MU3oXpPm8wkpTq4Bzq4HnbbO
         MX2Ro0nY+lahuKGTlpY4rgC8FWbHMSTML/DKanfEzOjTMKgPJb3lY5ZAVbkJbg9ngIyh
         P1WpPiU97XaShkRTIQFafJPGuVDN4CUfwQ/MPXwWfYGOWU+g2y8+QZrRDd1telcuELBF
         zwSwIg4h5Uy6YIkeWqTqez6BRUM1QmQjvU99EhM8ObZB0U8t4Ob2a7vZPc9n0iRJwqzx
         9Q4g==
X-Forwarded-Encrypted: i=1; AHgh+Rrb2xVEktC0VvytjyJ9/BAABh275ja/rBAm4czid4E4WRMU2RY7vyVxJr4fY8xH9GhEzcCn184=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Lo/xXju2gfEjDvXLMF/qcc8zlAUuL6jmA/MAEWNXWzNq6whb
	V//B2offr+5JzrT18LcDCRyMEjCcqZeacXCFOT63FSlrpMwd+zr1AZDHnT0LEFpSmeN0GHHQd0Y
	MyFp2GGtlR6oamT4LK4wZMnIyzCbitNVEYTwkecbLw3Y7o48zEdrZohpW8yE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e844:0:b0:6aa:e854:d03b with SMTP id
 006d021491bc7-6ae96bb2dc0mr235720eaf.2.1785862893651; Tue, 04 Aug 2026
 10:01:33 -0700 (PDT)
Date: Tue, 04 Aug 2026 10:01:33 -0700
In-Reply-To: <6a6f9105.1aa927e4.17d4bf.001b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a721aed.9511d2ce.1fc5b9.0341.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in ipgre_xmit (2)
From: syzbot <syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kerneljasonxing@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=178fb649580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1617be32580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d113b9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4949138dcfef/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31cc6fbe5b8a/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/433919ca6520/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com

------------[ cut here ]------------
len > ((int)(~0U >> 1))
WARNING: ./include/linux/skbuff.h:2864 at pskb_may_pull_reason include/linux/skbuff.h:2864 [inline], CPU#1: syz-executor147/5638
WARNING: ./include/linux/skbuff.h:2864 at pskb_network_may_pull_reason include/linux/skbuff.h:3265 [inline], CPU#1: syz-executor147/5638
WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull_reason include/net/ip_tunnels.h:481 [inline], CPU#1: syz-executor147/5638
WARNING: ./include/linux/skbuff.h:2864 at pskb_inet_may_pull include/net/ip_tunnels.h:486 [inline], CPU#1: syz-executor147/5638
WARNING: ./include/linux/skbuff.h:2864 at ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658, CPU#1: syz-executor147/5638
Modules linked in:
CPU: 1 UID: 0 PID: 5638 Comm: syz-executor147 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2864 [inline]
RIP: 0010:pskb_network_may_pull_reason include/linux/skbuff.h:3265 [inline]
RIP: 0010:pskb_inet_may_pull_reason include/net/ip_tunnels.h:481 [inline]
RIP: 0010:pskb_inet_may_pull include/net/ip_tunnels.h:486 [inline]
RIP: 0010:ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658
Code: 48 3b 84 24 80 00 00 00 0f 85 3b 01 00 00 31 c0 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 3f 1a 78 01 cc e8 09 f5 6a f7 90 <0f> 0b 90 e9 08 f8 ff ff 44 89 ff 44 89 e6 e8 b5 f6 6a f7 45 39 e7
RSP: 0018:ffffc900039af5e0 EFLAGS: 00010293
RAX: ffffffff8a5c1d67 RBX: 0000000000000000 RCX: ffff888079535d00
RDX: 0000000000000000 RSI: 00000000ffffff40 RDI: 0000000000000000
RBP: ffffc900039af6b0 R08: ffff888079535d00 R09: 0000000000000002
R10: 0000000000004888 R11: ffffffff8a5c1410 R12: ffff88807ecbc000
R13: dffffc0000000000 R14: ffff88807b7f2780 R15: 00000000ffffff40
FS:  0000555590a0a400(0000) GS:ffff88812504b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055704428ded0 CR3: 00000000788f2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __netdev_start_xmit include/linux/netdevice.h:5400 [inline]
 netdev_start_xmit include/linux/netdevice.h:5409 [inline]
 __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:4942
 __xsk_generic_xmit net/xdp/xsk.c:1253 [inline]
 xsk_generic_xmit+0x2759/0x47b0 net/xdp/xsk.c:1309
 __xsk_sendmsg net/xdp/xsk.c:1363 [inline]
 xsk_sendmsg+0x482/0x810 net/xdp/xsk.c:1373
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
RIP: 0033:0x7fc137b1b409
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffc9ef46d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc137b1b409
RDX: 0000000000000040 RSI: 0000200000000700 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000080000000 R09: 0000000080000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000003
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
