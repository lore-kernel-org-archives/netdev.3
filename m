Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719102C11C4
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785975159; cv=none; b=WPOYpXPknfRT2oHqQIyT4wsnCc6MkMqUn3hlS4wpaDuFmHgaakqTJSsnFH9gtrHTi+zwNrs9x4VaUFqo8q3X+0zJCQ7yMEZBlsNeqfjtFt+qibTv1IfmdO2DM147NSzcTwLCiP4yZ6iTZv7IHd5rI274zg5L509rG+95lEVt2Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785975159; c=relaxed/simple;
	bh=oZVLuIcxRieMCqQ86u6beo7Iik2GGXzwb5yyKA+Im9U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CCtBGzwWq1lH54MaT0AqfxXkOOgLW7ijksI13RASHd1+r8cu7hp2aINUMFre0fNMQMNc2Mhm+tNYvJmti4Fc/qYZilC0Zo2qtO7VZW3XWH4HHACGeIbzjK+E6k0d3Y29asPmXCTDLqhypwVW62PnGEy2QiIOaOaIGHVt0ccUUIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7ee59eeb8c1so1002613a34.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 17:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785975156; x=1786579956;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H2gcXpVBtJ+YVASXQziPjGqs3OlOkoqkEmRd3mkgHHc=;
        b=ibOIlJemcusr0TioK2hb6QgzDQRYaMrhrvlwTyOSZd1atvFv5QcSn4LWQxO+JGxE6h
         8aZigh7nwiikb+6x4sAlsxj1OmmEbjLRby40kZ3e8+PWGAikHutoD6vIaA54n1ej4w2k
         xS8sBdeGdHEx6J4wbqxpMAEKXLgg9iq951OVu7bfIg5KWU07WCkG9KNe3hXhu19evQpy
         19D/MJiFAaUPSWwdfIP3Zh+pfSeuVmRquNkxw33AfeWCRZ9D4hksvY9c47jLjnH7B1Yq
         eZaEVJpm3XvN0cE7a0baTp0MrMc4w3EYazT77kgI6/TJymC5UYt3t1Q/7hjQWSTW033d
         kAZA==
X-Forwarded-Encrypted: i=1; AHgh+RohNllm30QLroYFetZ5GWVEs0hPawlVrmy56XGhVDIe1ZQ75VaSGGWraxQVZ+MPMx+Br5XZoAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBbR7z0PJCXg72b9Noz4ppV409bmFx4ZFYCIGwwVVc5OqvktWP
	k7Vtvwo5CAQ6uc4F+OHCyYyS0BVBufgiJjRVxeBnKyyNwC44p0GDtW12nkQAVe5XmIpoultLYY9
	7TcypBiAy4KjEeBtpC7NKkGmBQEBycJ1h0lPCAlE/ygjWnqkR36CClDi4ssA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b84:b0:6a0:f319:6903 with SMTP id
 006d021491bc7-6ae96bcee56mr5770051eaf.6.1785975156504; Wed, 05 Aug 2026
 17:12:36 -0700 (PDT)
Date: Wed, 05 Aug 2026 17:12:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a73d174.5aeeccc9.207e63.000c.GAE@google.com>
Subject: [syzbot] [afs?] [net?] kernel BUG in rxrpc_destroy_all_connections (2)
From: syzbot <syzbot+89001660f14fb7684c83@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1126cbb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7079b368dcec295
dashboard link: https://syzkaller.appspot.com/bug?extid=89001660f14fb7684c83
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9f5212fcea24/disk-c21bb419.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a166d81a082/vmlinux-c21bb419.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b36458f10930/bzImage-c21bb419.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+89001660f14fb7684c83@syzkaller.appspotmail.com

tipc: Left network mode
rxrpc: Assertion failed
------------[ cut here ]------------
kernel BUG at net/rxrpc/conn_object.c:488!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 1040 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: netns cleanup_net
RIP: 0010:rxrpc_destroy_all_connections.cold+0x12/0x14 net/rxrpc/conn_object.c:488
Code: ff 90 0f 0b e8 ca 82 98 00 48 c7 c7 80 12 3a 8d e8 9e 79 b0 ff 90 0f 0b e8 b6 82 98 00 48 c7 c7 80 12 3a 8d e8 8a 79 b0 ff 90 <0f> 0b e8 a2 82 98 00 49 63 d6 48 83 ce ff 48 c7 c7 20 7c de 90 e8
RSP: 0018:ffffc9000519f990 EFLAGS: 00010282
RAX: 0000000000000017 RBX: ffff888029c40000 RCX: 0000000000000000
RDX: 0000000000000017 RSI: ffffffff81e89fd9 RDI: fffff52000a33f23
RBP: ffff888029c40064 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 1ffff92000a33f34
R13: ffff888029c40078 R14: ffff888029c40088 R15: ffff888029c40088
FS:  0000000000000000(0000) GS:ffff888123dd9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6c701e4b45 CR3: 0000000057648000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 rxrpc_exit_net+0x7b/0xc0 net/rxrpc/net_ns.c:113
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x2ee/0xab0 net/core/net_namespace.c:252
 cleanup_net+0x499/0x920 net/core/net_namespace.c:702
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rxrpc_destroy_all_connections.cold+0x12/0x14 net/rxrpc/conn_object.c:488
Code: ff 90 0f 0b e8 ca 82 98 00 48 c7 c7 80 12 3a 8d e8 9e 79 b0 ff 90 0f 0b e8 b6 82 98 00 48 c7 c7 80 12 3a 8d e8 8a 79 b0 ff 90 <0f> 0b e8 a2 82 98 00 49 63 d6 48 83 ce ff 48 c7 c7 20 7c de 90 e8
RSP: 0018:ffffc9000519f990 EFLAGS: 00010282
RAX: 0000000000000017 RBX: ffff888029c40000 RCX: 0000000000000000
RDX: 0000000000000017 RSI: ffffffff81e89fd9 RDI: fffff52000a33f23
RBP: ffff888029c40064 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 1ffff92000a33f34
R13: ffff888029c40078 R14: ffff888029c40088 R15: ffff888029c40088
FS:  0000000000000000(0000) GS:ffff888123dd9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558cf9997138 CR3: 000000000e994000 CR4: 0000000000350ef0


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
