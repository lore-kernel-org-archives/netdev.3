Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D052378D8C
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790508188; cv=none; b=r9lR0Ayvf83Jiup+u1rb03vk6lZRuOq6N4glzjz0JyfpWqibgtEXWk7QT0UKYY6SR5Eq3buyCkb9/F6xXFck1tkdTNReowrh45r2LQF7UpFNUBobQsXMMm1Ec64SPOhiQ8Ps1q7uX5sErjF9HmrPMMp5+/m7fattnex7cwblIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790508188; c=relaxed/simple;
	bh=kbyKVp5Zvp47iaRL8DmcBVN3hbrse/nRZjYGIVn7x7I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oi6oa/kzGg0rj0xSYSZq7qnp9FEXjDpSsQBRb0sdtBc1v3TEEvbj7kZa/4ULLHyOHtnOPN2eI3JzdjP3NuX30KxaWIVx9dpWgQTCxgUZ0bh7ybUjEObotgy2RilwSvAYjE6sH8fCN2YkyBF/dqrFQomgJPmvwL7oC1oCOb4HFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4dc57e2a3f2so3314226b6e.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 04:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790508185; x=1791112985;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NAmk3GpEoBd0TS7zXqhccr2MGvUT0tGsCjyzRRE3oSI=;
        b=g6AUAx8+eJwS0LEdeVzk++z/7eUOCsOieWX/NixAcCJjNgIxQHOY/8vyXKKCXXA9cE
         y4Cjr+8jbJMiiGlf5vmf09kP7uYaJh2q9zjrT2RK9XCMXjw2vmJBaaWrYPCIlA/vCxrG
         k2VdrdeyjBo/EFuw6WCiVtiQLgPh+uNGEQazN6IWrAr0o28KJI+V7GaBzmBMj3J+iwvR
         pz0qiBaQdrRlRiOyJtgJ6U+Op95nCH25gsEB3dkJXvVV9JE+5V9572v1VzDE7zlRyAC1
         YQZrTnTPLlOJuaG8CxGV6na57N1Rq3MBNy1oC+0UFO+Dy1ypL88BrRhgtKbWnOB+4zO+
         Lvsg==
X-Forwarded-Encrypted: i=1; AKwUvBz+19QpqBoqDTm3gkNGmslRg5Ix8f3/5GLzSvI2LJSTxs97AljG0L0uEkaahtfbgUnTc/VcowE=@vger.kernel.org
X-Gm-Message-State: AFuF++nJG947RQnNsUnOR42bp8O3QUIDym/4lPGdhsm7ofmBxZ6X9BXC
	O+Gy9Ef6DpnwdRqv4dLozwyhI6506/hxpNsKBdEHLZMepW8auXumCuNFC5yrCs8lI4VDyY9/66v
	leqJOFesyofIHF5VlSObFY19C9DFjqIcVn4LIVevl2RRe1ViaZwEibxfo2Es=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:30aa:b0:4c6:eddf:ca6f with SMTP id
 5614622812f47-4d728922debmr13681154b6e.12.1790508185524; Sun, 27 Sep 2026
 04:23:05 -0700 (PDT)
Date: Sun, 27 Sep 2026 04:23:05 -0700
In-Reply-To: <arj4xgLi_4YZl929@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab8fc99.dc2998a4.2261f5.0065.GAE@google.com>
Subject: Re: [syzbot] [net?] [afs?] kernel BUG in rxrpc_destroy_all_connections
 (2)
From: syzbot <syzbot+89001660f14fb7684c83@syzkaller.appspotmail.com>
To: azpijr@gmail.com, davem@davemloft.net, dhowells@redhat.com, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in rxrpc_destroy_all_connections

rxrpc: AF_RXRPC: proc conn 560 cid f29e6b44 state 7 ref 1 act 0 flags 2 cache_empty 1 calls 0000000000000000 0000000000000000 0000000000000000 0000000000000000 bundle ffff88802ce96b00
rxrpc: Assertion failed
------------[ cut here ]------------
kernel BUG at net/rxrpc/conn_object.c:504!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 5781 Comm: kworker/u32:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:rxrpc_destroy_all_connections.cold+0x12/0x34f net/rxrpc/conn_object.c:504
Code: ff 90 0f 0b e8 6e a7 99 00 48 c7 c7 20 73 5d 8d e8 72 be af ff 90 0f 0b e8 5a a7 99 00 48 c7 c7 20 73 5d 8d e8 5e be af ff 90 <0f> 0b e8 46 a7 99 00 48 c7 c7 a0 77 5d 8d e8 4a be af ff 4c 89 e7
RSP: 0018:ffffc90003be7928 EFLAGS: 00010286
RAX: 0000000000000017 RBX: ffff888036dd4000 RCX: 0000000000000000
RDX: 0000000000000017 RSI: ffffffff81ea2579 RDI: fffff5200077cf16
RBP: ffff888036dd4064 R08: 0000000000000007 R09: 0000000000000000
R10: 8000000000000000 R11: 0000000000000001 R12: ffff888036dd4098
R13: ffff888036dd3e70 R14: ffff888036dd4078 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880d5c52000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f67bacc6e9c CR3: 000000002647e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 rxrpc_exit_net+0x7b/0xc0 net/rxrpc/net_ns.c:113
 ops_exit_list net/core/net_namespace.c:200 [inline]
 ops_undo_list+0x2ee/0xab0 net/core/net_namespace.c:253
 cleanup_net+0x499/0x920 net/core/net_namespace.c:706
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rxrpc_destroy_all_connections.cold+0x12/0x34f net/rxrpc/conn_object.c:504
Code: ff 90 0f 0b e8 6e a7 99 00 48 c7 c7 20 73 5d 8d e8 72 be af ff 90 0f 0b e8 5a a7 99 00 48 c7 c7 20 73 5d 8d e8 5e be af ff 90 <0f> 0b e8 46 a7 99 00 48 c7 c7 a0 77 5d 8d e8 4a be af ff 4c 89 e7
RSP: 0018:ffffc90003be7928 EFLAGS: 00010286
RAX: 0000000000000017 RBX: ffff888036dd4000 RCX: 0000000000000000
RDX: 0000000000000017 RSI: ffffffff81ea2579 RDI: fffff5200077cf16
RBP: ffff888036dd4064 R08: 0000000000000007 R09: 0000000000000000
R10: 8000000000000000 R11: 0000000000000001 R12: ffff888036dd4098
R13: ffff888036dd3e70 R14: ffff888036dd4078 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880d5c52000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f67bacc6e9c CR3: 000000002647e000 CR4: 0000000000352ef0


Tested on:

commit:         a7bfaba4 ipv6: fix prefix route expiry in modify_prefi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17888605580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=89001660f14fb7684c83
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12908605580000

