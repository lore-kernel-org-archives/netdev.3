Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6CE20125F
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786820733; cv=none; b=emOjMG9CEKS2KMo9L3LXIrXyk7ASPCp/hqoat5s0pVDAME1GL4iIdMrEdet7qBffPLTxRXVLCPp4wMnBDlwrGKTIY4/5vy5jE9GbZ/mn/DRuk9unaERUcb/gPGQHt3B3CN8vGm+/vpMi7FeeEyCVq08LoOO4VFAvzZRQYvL3Yb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786820733; c=relaxed/simple;
	bh=gJ2jBi5LmX8p0QrjRaAHcjx2K27921vmwzBNC++Ow6U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NCjb0uFLzCIbAyZaWyJzSmwRzGHAWpNWGyz2fngac0nl4bDjQqpltPhQtOBwX5vNs8mZb97Hb8b0HHVE8fR5IPfSa6gJDG7D4oV5EOacgSGUC0AU4ltHrQLq8j1ChC6pWfb2Do0MZPUlZ7XGqVwAHqahK+taOH3ASLKtYTCqdDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6ae7c37604aso2026423eaf.0
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 12:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786820731; x=1787425531;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmgSW4j5GiF7fDESSM7LsP2d8izilj9+9VU7QkjM3ro=;
        b=HU1fE8cwCGgJkvoW4TnVdL9nxxFRHbOzn1HqTCcvRSMtnAMkZk9kb6iElCBtCGYZRf
         zX07dv3Qu80IDmJ6aKR8/A/qa5vNXZYjZNCZzjIhTDURe0At6g/8vVU0fGToaJ+HJoBn
         kcUX87o7f2QTEyt4SrUifoF1rDsyPbfVGY5h5bkOdwOYNyUx4UOZ6QlR0rx/wmXlI4LY
         7ui7Zt1ClaRAU0mWOhQWZuOGr3rvIJuDf/jI37exNZ3MfYjR1QlenXRuGhiE3672tkZn
         ZKKdW8uP0npJKZ/uzkFyW0KR3W9O7rXIWFKrX/Fu42ECaNch3TvgDyJSfNP3ISPsBJDl
         O79A==
X-Forwarded-Encrypted: i=1; AHgh+RrdRecdcljl9c/mWv48HOfoTFbAI28ks59upCE3VXof9QhMbtUIPX73qW7qBZEGX8d7IA3PoQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8WdgfscddI41VpJNWMvN2KbzRhLidPD0/KpIVw6IRVSBcZ2k
	hMXXaLxLZb/eIPum+mja/HfBby0MYPX+MVv15Dy7vD5E7OoSm/6Nkzq5CCcOUGPhRQUnKsk8qra
	/WfKwbIC5Ouca6eTe2MH21hhlbbHy0H2GSc+XsOlYDJpWNYaFCcSm0NN6lLM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3091:b0:6b0:4e2b:17d0 with SMTP id
 006d021491bc7-6b0d68fd314mr12862707eaf.30.1786820730894; Sat, 15 Aug 2026
 12:05:30 -0700 (PDT)
Date: Sat, 15 Aug 2026 12:05:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a80b87a.dbb3a75c.20434b.001d.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in qlist_free_all (4)
From: syzbot <syzbot+b7a5f122d6dd573df0d1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    df685633c3db Merge tag 'rcu-fixes.v7.1-20260519a' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10897536580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a
dashboard link: https://syzkaller.appspot.com/bug?extid=b7a5f122d6dd573df0d1
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90074e46cb62/disk-df685633.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/691247547753/vmlinux-df685633.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e1c705a2acac/bzImage-df685633.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7a5f122d6dd573df0d1@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 101 PID: 5289 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:__phys_addr+0x99/0x100 arch/x86/mm/physaddr.c:28
Code: 84 d2 75 28 0f b6 0d 57 a9 1e 0f 80 f9 3f 0f 87 a7 ed 67 ff 48 89 e8 48 d3 e8 48 85 c0 75 0a 48 89 e8 5b 5d c3 cc cc cc cc 90 <0f> 0b 48 c7 c7 e1 ed d7 90 e8 39 8f bb 00 eb ca 48 c7 c0 10 f0 5b
RSP: 0018:ffffc9000366f538 EFLAGS: 00010287
RAX: 840077090033186c RBX: 83ffff890033186c RCX: 000000080020001a
RDX: dffffc0000000000 RSI: 000000000020001a RDI: 83ffff888033186c
RBP: 840077088033186c R08: ffff88802d950001 R09: 000000080020001a
R10: 0000000000000001 R11: 0000000000000000 R12: 83ffff888033186c
R13: 0000000000000000 R14: ffffc9000366f580 R15: ffff8880b85439b0
FS:  00007f66bbcd2780(0000) GS:ffff888124474000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555588f66a38 CR3: 000000007ac58000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 virt_to_slab mm/slab.h:168 [inline]
 qlink_to_cache mm/kasan/quarantine.c:131 [inline]
 qlist_free_all+0x5f/0xf0 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4569 [inline]
 slab_alloc_node mm/slub.c:4898 [inline]
 kmem_cache_alloc_node_noprof+0x25a/0x6f0 mm/slub.c:4950
 __alloc_skb+0x140/0x710 net/core/skbuff.c:702
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xdd/0x760 net/core/skbuff.c:6734
 sock_alloc_send_pskb+0x801/0x980 net/core/sock.c:2998
 unix_dgram_sendmsg+0x3c7/0x1810 net/unix/af_unix.c:2141
 unix_seqpacket_sendmsg+0x12a/0x1d0 net/unix/af_unix.c:2542
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 sock_write_iter+0x524/0x5a0 net/socket.c:1254
 do_iter_readv_writev+0x6ee/0x920 fs/read_write.c:829
 vfs_writev+0x360/0xe10 fs/read_write.c:1059
 do_writev+0x28a/0x340 fs/read_write.c:1105
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66bbd5c407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffd60c66880 EFLAGS: 00000202 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f66bbcd2780 RCX: 00007f66bbd5c407
RDX: 0000000000000005 RSI: 00007ffd60c668e0 RDI: 000000000000000a
RBP: 000056120f92f400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000056120f92f400
R13: 000000000000012c R14: 00000000ffffffff R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0x99/0x100 arch/x86/mm/physaddr.c:28
Code: 84 d2 75 28 0f b6 0d 57 a9 1e 0f 80 f9 3f 0f 87 a7 ed 67 ff 48 89 e8 48 d3 e8 48 85 c0 75 0a 48 89 e8 5b 5d c3 cc cc cc cc 90 <0f> 0b 48 c7 c7 e1 ed d7 90 e8 39 8f bb 00 eb ca 48 c7 c0 10 f0 5b
RSP: 0018:ffffc9000366f538 EFLAGS: 00010287
RAX: 840077090033186c RBX: 83ffff890033186c RCX: 000000080020001a
RDX: dffffc0000000000 RSI: 000000000020001a RDI: 83ffff888033186c
RBP: 840077088033186c R08: ffff88802d950001 R09: 000000080020001a
R10: 0000000000000001 R11: 0000000000000000 R12: 83ffff888033186c
R13: 0000000000000000 R14: ffffc9000366f580 R15: ffff8880b85439b0
FS:  00007f66bbcd2780(0000) GS:ffff888124374000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdd954c9e80 CR3: 000000007ac58000 CR4: 00000000003526f0


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
