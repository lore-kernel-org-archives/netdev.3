Received: from mail-oi2-f5.google.com (mail-oi2-f5.google.com [74.125.231.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C47355295C
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089377; cv=none; b=TqEaphCQen0j9cLvCa3PaGelztxCSYptyOYy7Bfusb+LAVtIq1XP6ZwM8PwQZ6P+AOVmk514D0BX1Si8/qUWXDDBL+VZ9V1Zrm3OPNOYZYLuDVlShnkRA60xc45gEvjVDk3ggUFIP9eCxt1+rR8eDDXpHfU7JQ4s1Hnc226q8mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089377; c=relaxed/simple;
	bh=YQ7ys8Y0eaSHGJp2vboFfSiYHINwTd2XD0CWPFDYwK0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=owjSu/ijfbgYEF2UXuG7WdRDzpIR582NMS7+icA89oo7aNzahzgJukszxO0Ow/cD1dQ8XKWDpSezDIIRvLG18hb9lNmaoxmgxcII4KRX7f/N1hLEJn1Vm5VDBAfe28txUkThAwJZQHJfLq+z6YqF5ZYVIEtfm5jjWr5rBf/z5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f5.google.com with SMTP id 46e09a7af769-801706d7e6dso17818a34.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089374; x=1790694174;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ArxMwdNqa1Pa4d+hxX0OUt5zftaLEfb4a/34J0DlhTY=;
        b=GH4ZkCla70AgfeA4OGT8QakvcrAQj6sCv3AoZ6KYUBjcpmZjDyf/pKtaMPKTcitwTk
         NWQVcqiFPgHzXg6KWEOhWAqJqml9zFlQfoCemLOviPEWWONjhir75/JQMI8mAZWBAmfs
         HtuYnTwBNlPUw/7G9EhpV4pWaWMs84DJMMOvTpi/J4nDp/8y+H2v19oD6FUtX7awO7q7
         oSsFJrOIZc8zZCweIok6ZUgsaUTieJgQVWMU/U4x2wxh6Wk7/O/axOMMhWioXIYZdV8G
         VYxgn4G1XemfrofWiQZZ4CfQwd17/SjNlRawHLBCrzhmjkNO3p6hmX5JvFekTFe5Nwiy
         WCbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzY5aUHzszalBlz4lhRBsSdc6YXWPEA0Nv6YluZkJ2d+sPmDiR+TzMcJ4dItbgJc6G1tvNqJMU=@vger.kernel.org
X-Gm-Message-State: AFuF++lHQu4r5409oYIbxmdHdjfJ3eyI6iDZXXrtY2a4zO/+auNY9jd0
	nRpojMVuJTh5kbr4VkJ3xLNrVR6GxqGaEEER5xlWe0GbX9xcLA9wnXU+9JUEc3ghSGCIVoh4J0i
	Re9rZrUPdFSyf6AV4VjTzVSvuiDSDC6RtaCdq9MBYdALZWq5WFU/OfhExsTw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:814:b0:6cd:3ffc:ad08 with SMTP id
 006d021491bc7-6d191112420mr2308553eaf.88.1790089374284; Tue, 22 Sep 2026
 08:02:54 -0700 (PDT)
Date: Tue, 22 Sep 2026 08:02:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab2989e.a6af0033.177e91.0021.GAE@google.com>
Subject: [syzbot] [net?] [afs?] kernel BUG in rxrpc_purge_client_connections
From: syzbot <syzbot+e2f5927fc701355ef101@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f0100363d8c3 Merge tag 'xfs-fixes-7.3-rc5' of gitolite.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f20c5e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=e2f5927fc701355ef101
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f20c5e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ae34c9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f0100363.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/57240753f5ee/vmlinux-f0100363.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2930b9a97546/bzImage-f0100363.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2f5927fc701355ef101@syzkaller.appspotmail.com

rxrpc: AF_RXRPC: Leaked client conn ffff888055bb9000 {1}
------------[ cut here ]------------
kernel BUG at net/rxrpc/conn_client.c:64!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5919 Comm: krxrpcio/4660 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:rxrpc_destroy_client_conn_ids net/rxrpc/conn_client.c:64 [inline]
RIP: 0010:rxrpc_purge_client_connections+0xc0/0x1a0 net/rxrpc/conn_client.c:145
Code: 2b 31 db 48 8d 6c 24 28 e8 ed 4b 15 f7 48 89 ee 4c 89 ef 89 5c 24 28 e8 1e 7f d0 00 48 89 c3 48 85 c0 75 73 e8 d1 4b 15 f7 90 <0f> 0b e8 c9 4b 15 f7 31 f6 4c 89 ef e8 4f 5f d5 00 31 ff 89 c3 89
RSP: 0018:ffffc900038e7a80 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888024d3cb00 RSI: ffffffff8af6d6bf RDI: ffff888024d3cb00
RBP: ffffc900038e7aa8 R08: 0000000000000007 R09: 000000007fffffff
R10: 000000002bb346e4 R11: 0000000000000001 R12: ffff888055bb9038
R13: ffff888054eb7270 R14: ffff888054eb7038 R15: ffff888038d94180
FS:  0000000000000000(0000) GS:ffff8880d5b53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 000000003566e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 rxrpc_destroy_local+0x262/0x300 net/rxrpc/local_object.c:451
 rxrpc_io_thread+0x2e1a/0x3820 net/rxrpc/io_thread.c:579
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rxrpc_destroy_client_conn_ids net/rxrpc/conn_client.c:64 [inline]
RIP: 0010:rxrpc_purge_client_connections+0xc0/0x1a0 net/rxrpc/conn_client.c:145
Code: 2b 31 db 48 8d 6c 24 28 e8 ed 4b 15 f7 48 89 ee 4c 89 ef 89 5c 24 28 e8 1e 7f d0 00 48 89 c3 48 85 c0 75 73 e8 d1 4b 15 f7 90 <0f> 0b e8 c9 4b 15 f7 31 f6 4c 89 ef e8 4f 5f d5 00 31 ff 89 c3 89
RSP: 0018:ffffc900038e7a80 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888024d3cb00 RSI: ffffffff8af6d6bf RDI: ffff888024d3cb00
RBP: ffffc900038e7aa8 R08: 0000000000000007 R09: 000000007fffffff
R10: 000000002bb346e4 R11: 0000000000000001 R12: ffff888055bb9038
R13: ffff888054eb7270 R14: ffff888054eb7038 R15: ffff888038d94180
FS:  0000000000000000(0000) GS:ffff8880d5c53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33024008 CR3: 000000000eb96000 CR4: 0000000000352ef0


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
