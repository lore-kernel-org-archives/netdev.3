Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BA30C148
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786494158; cv=none; b=GonmI08Szdiw5PHIwWbIbgXdbFi4elkLNeKC9JGHD2QJrxAJ1Wv6bFXs00dS5ZBcqYluf+2LxcEo9j595WNMYoVzeiidTJjteY3rfczMUaOyIrUm7QckDS/vjE3z9VEvVUgWofWvzpq/n7SUScekOlImIZyVwcNWLycG3Iqcg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786494158; c=relaxed/simple;
	bh=208QMu+OsTyZ3BSoitdxeWdPz87VNPqm5tyxEbhVBCU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kpLhBGEauHTj04R8UPisISI4j0EKF7OydbHlrCiUwwmamvwLtRXFUZFT4KeNAV8O2RCFxdQJWpCqdSbLQ2chiYnpzgbxBC4ixMGisYA7miTumZFCjiscT0JQFDjsfegxFbbCmYxyB9l8mU3SbJc3oVSs8ad9Q2VILdxn+2JPx3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4a41e3d6fe9so281071b6e.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 17:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786494155; x=1787098955;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMAcU0Te/6B7srJdAbN55W1Loj4vijaSz1wl3sGVswY=;
        b=PlyLQPX6wndeDgXJ4kV/6KjI2mjZJLHek2erJEsIPjBMjrS7JgkqlzykfQPCor7JiU
         ZgpMCZKExUDFicJHqkmvmcIVtwigyQVLVZfr2izozYGcSh/DATsPRMT5E5OjHcDtuWiD
         70DodIR7Ug6aqUURt+XfPgXpayth9N/Nl/3Ck8OnTFke9K/ETtZQ3vwUgSxzHH8Aod6B
         bDktLZ+pSMVIX6zhdZ0vJtezE0pfADSaUp4UpbSI5YtWyMaalCyDp3HGLf/e+MAnA0Ag
         iYqNVflLkaveHulut4V5TdacvkyFXWTi19zrKIawrr9bW1Yw960UGO4t3GpBhDUVh4/d
         x5dQ==
X-Forwarded-Encrypted: i=1; AHgh+RoP6+iCbs1zPnD+H7risT4f0jV9f6coCyhAWxMnqVqCDiP91MzvFEjKQqIxCLgXLexy3hev/iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvz9oG2v0A/8toIGmB7QDRITo5FXwC1Lw31GoNaRisfwFakv6E
	QCGzOsmWxBxizhlz244rJ6Dsm/lyvIDgMIebR6yMflEK8hLpqWUrUlL1FH1QNbQbU8tQqq3/Qp9
	w2sxD7amwoAN2xXDyY3EiYm6HNAkcD4owexLnNmn6zbohF4oLL542cibJWeU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2389:b0:497:d1e7:5e90 with SMTP id
 5614622812f47-4b210bb5798mr1075518b6e.18.1786494155514; Tue, 11 Aug 2026
 17:22:35 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:22:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7bbccb.ac361c09.22ff0a.0048.GAE@google.com>
Subject: [syzbot] [io-uring?] [net?] WARNING: refcount bug in zcrx_unregister_user
From: syzbot <syzbot+a43f81e0646c5bbd2b88@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ea2bff00da89 Add linux-next specific files for 20260806
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e27e49580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2f9169913eb6d73
dashboard link: https://syzkaller.appspot.com/bug?extid=a43f81e0646c5bbd2b88
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d92132580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/473ce49245bc/disk-ea2bff00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d5bfcd186f5/vmlinux-ea2bff00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/281694927321/bzImage-ea2bff00.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a43f81e0646c5bbd2b88@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: lib/refcount.c:31 at refcount_warn_saturate+0x70/0x110 lib/refcount.c:31, CPU#0: syz.0.17/5808
Modules linked in:
CPU: 0 UID: 0 PID: 5808 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:refcount_warn_saturate+0x70/0x110 lib/refcount.c:31
Code: c6 c0 fe 36 8f e8 90 e5 ee fc 83 fb 01 7e 22 83 fb 02 74 39 83 fb 03 74 47 83 fb 04 75 68 e8 f7 df ee fc 48 8d 3d b0 16 8b 0b <67> 48 0f b9 3a eb 66 85 db 74 3e 83 fb 01 75 4c e8 db df ee fc 48
RSP: 0018:ffffc900032d78c8 EFLAGS: 00010293
RAX: ffffffff84d8a429 RBX: 0000000000000004 RCX: ffff888032abddc0
RDX: 0000000000000000 RSI: ffffffff8f36fec0 RDI: ffffffff9063bae0
RBP: ffffc900032d7a10 R08: ffff888032abddc0 R09: 0000000000000005
R10: 0000000000000004 R11: 0000000000000000 R12: ffff8880353d2700
R13: dffffc0000000000 R14: ffff8880353d2744 R15: 0000000000000001
FS:  00005555674e4500(0000) GS:ffff888124f12000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002020 CR3: 0000000079e90000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:461 [inline]
 refcount_dec include/linux/refcount.h:476 [inline]
 ref_tracker_free+0x706/0x830 lib/ref_tracker.c:303
 netdev_tracker_free include/linux/netdevice.h:4545 [inline]
 netdev_put include/linux/netdevice.h:4562 [inline]
 io_close_queue io_uring/zcrx.c:582 [inline]
 zcrx_unregister_user+0x2d8/0x430 io_uring/zcrx.c:681
 zcrx_unregister io_uring/zcrx.c:688 [inline]
 io_register_zcrx+0x875/0xc00 io_uring/zcrx.c:1021
 __io_uring_register io_uring/register.c:942 [inline]
 __do_sys_io_uring_register io_uring/register.c:1040 [inline]
 __se_sys_io_uring_register+0xc23/0x1ab0 io_uring/register.c:1017
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa6a959e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe56af7168 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 00007fa6a9825fa0 RCX: 00007fa6a959e0d9
RDX: 0000200000000100 RSI: 0000000000000020 RDI: 0000000000000003
RBP: 00007fa6a9635024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa6a9825fac R14: 00007fa6a9825fa0 R15: 00007fa6a9825fa0
 </TASK>
----------------
Code disassembly (best guess), 5 bytes skipped:
   0:	e8 90 e5 ee fc       	call   0xfceee595
   5:	83 fb 01             	cmp    $0x1,%ebx
   8:	7e 22                	jle    0x2c
   a:	83 fb 02             	cmp    $0x2,%ebx
   d:	74 39                	je     0x48
   f:	83 fb 03             	cmp    $0x3,%ebx
  12:	74 47                	je     0x5b
  14:	83 fb 04             	cmp    $0x4,%ebx
  17:	75 68                	jne    0x81
  19:	e8 f7 df ee fc       	call   0xfceee015
  1e:	48 8d 3d b0 16 8b 0b 	lea    0xb8b16b0(%rip),%rdi        # 0xb8b16d5
* 25:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2a:	eb 66                	jmp    0x92
  2c:	85 db                	test   %ebx,%ebx
  2e:	74 3e                	je     0x6e
  30:	83 fb 01             	cmp    $0x1,%ebx
  33:	75 4c                	jne    0x81
  35:	e8 db df ee fc       	call   0xfceee015
  3a:	48                   	rex.W


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
