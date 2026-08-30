Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424E21CC5C
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788112893; cv=none; b=DnrSGT8SjhiCL2bxE9g0iZUsd4yPvw+KcC8Xo0rc7Ew8fLRzGi0dbJgyFodgS3qugYWTAhRrYuFQ6bIMWdanIebr1ludMurEBZGQjsCkI+rVqTKOhkQ93vYM6cDm3J4h3s8rH2bOX/YD+/n9h3TD8vfEFBgxVQfneTxHfGSThsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788112893; c=relaxed/simple;
	bh=RqzC4FzEYqQS6LIAD3jjFLoYwoOXW92oWS0ktLLaSRw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h0yuUn0YBWa6eSR1N4/x2oeyQFwIHE+jwryg1BqIK/y4uEx0hBaovxUpv6fea3HQyOafsZRGMvC0Cv4wUCC8MPtIoOKx9GMeHXboH2/Q5y8d/j2xngpJLwzmVcUA1A6lxcrBBnoNHsDloDDPfMCvxisblhLTio6oufEs497Uotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-44cdbcd53b8so219689fac.0
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 11:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788112890; x=1788717690;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMO+I9B0WYs3owJQkxaxop23TuH+FUDXmgzunS3hq1A=;
        b=FwqhHNWLX0UHl+g4cHVdxWsmLlQV4WfvBEhEfginUVtB+OrmcwZLXa7H/+xEye13pE
         U6IwmCoB0EU0Wnk6g7CLOarGSYOwcl03PgvPkmuYiiFVNFle9FRlwh/nGRwacht8u1+p
         3fwym83NqiUwTjTxzXrqydA/TL9SN29IOz7ZzkVlSe4x+lfBIyAjwpVccdEo3gKUm1Pc
         9aRGdsb5TQMWXeSxPwPEZ3zkuWXPRGjA7dNknh/3yU7A56i3U2+gW9mbqYIPEaos5kbY
         cySIWneH3OeVPn3AFHO+jQREvAHh+V7CsKlW71Jmy71dPPGBlr7j1gUxIH1uR1+evWKX
         VT2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrvnHj8EXAmY1iI1Za2y8G+IPlGUp8XrOBWnce5akCmWkduo35dt77+e5Ao3Wdm9h69BJ5HDhE=@vger.kernel.org
X-Gm-Message-State: AFuF++mnCTd20atnUrbyUGw1PJTmtPQZ9aAPhuCNp+/90dIOoeksaZFB
	/KJcOgOW0WHogUCcmmDJOMNl9S6gVcnvQSF665C7RVEF6gz55iRkDRE6MmnTu6Q6vGQCv+BhcVy
	OTC9t3ND2g+fOInPetQ2BfpY2V4+Jzj0rsqaWWR8NxsBzjWksnNnnLZLGDPA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c296:b0:4b5:5bfb:f25f with SMTP id
 5614622812f47-4b55bfbfca9mr9183513b6e.20.1788112890637; Sun, 30 Aug 2026
 11:01:30 -0700 (PDT)
Date: Sun, 30 Aug 2026 11:01:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a946ffa.1d9ded08.62e62.0123.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in sock_sendmsg_nosec
From: syzbot <syzbot+73df3f89e1e13089e466@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2188569e7e1b sctp: fix a TOCTOU race in SCTP_CMD_TIMER_START
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11571d79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=73df3f89e1e13089e466
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12042c15580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10057d49580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1f2ec0e5d4f/disk-2188569e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c32fe4a8974b/vmlinux-2188569e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67c9c4d5cc44/bzImage-2188569e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+73df3f89e1e13089e466@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/socket.c:803!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5628 Comm: syz-executor176 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:sock_sendmsg_nosec+0x145/0x180 net/socket.c:803
Code: 06 67 48 0f b9 3a eb 95 e8 e8 3a 22 f8 48 89 df 4c 89 f6 4c 89 e2 4d 89 fb 2e e8 32 a5 5c 16 e9 51 ff ff ff e8 cc 3a 22 f8 90 <0f> 0b e8 c4 3a 22 f8 48 83 c3 18 48 89 d8 48 c1 e8 03 42 80 3c 28
RSP: 0018:ffffc90003aefb48 EFLAGS: 00010293
RAX: ffffffff89a578d4 RBX: ffff8880764c67c0 RCX: ffff88807fb23e80
RDX: 0000000000000000 RSI: 00000000fffffdef RDI: 00000000fffffdef
RBP: 00000000fffffdef R08: ffffc90003aef747 R09: 1ffff9200075dee8
R10: dffffc0000000000 R11: fffff5200075dee9 R12: 0000000000000001
R13: dffffc0000000000 R14: ffffc90003aefbc0 R15: ffffffff8aac4310
FS:  000055559101b400(0000) GS:ffff888124ce0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000210 CR3: 0000000073dca000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __sock_sendmsg net/socket.c:815 [inline]
 sock_write_iter+0x2de/0x3e0 net/socket.c:1266
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f173130ecb9
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd67e44248 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000200000000000 RCX: 00007f173130ecb9
RDX: 0000000000000001 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd67e44388
R13: 0000000000000002 R14: 00002000000000c0 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sock_sendmsg_nosec+0x145/0x180 net/socket.c:803
Code: 06 67 48 0f b9 3a eb 95 e8 e8 3a 22 f8 48 89 df 4c 89 f6 4c 89 e2 4d 89 fb 2e e8 32 a5 5c 16 e9 51 ff ff ff e8 cc 3a 22 f8 90 <0f> 0b e8 c4 3a 22 f8 48 83 c3 18 48 89 d8 48 c1 e8 03 42 80 3c 28
RSP: 0018:ffffc90003aefb48 EFLAGS: 00010293
RAX: ffffffff89a578d4 RBX: ffff8880764c67c0 RCX: ffff88807fb23e80
RDX: 0000000000000000 RSI: 00000000fffffdef RDI: 00000000fffffdef
RBP: 00000000fffffdef R08: ffffc90003aef747 R09: 1ffff9200075dee8
R10: dffffc0000000000 R11: fffff5200075dee9 R12: 0000000000000001
R13: dffffc0000000000 R14: ffffc90003aefbc0 R15: ffffffff8aac4310
FS:  000055559101b400(0000) GS:ffff888124de0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006a9ee0 CR3: 0000000073dca000 CR4: 00000000003526f0


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
