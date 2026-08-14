Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1563AB29E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705592; cv=none; b=mCQQinzncdtSTvAjotfi25FcbTjGzFvXMMdSfZjUn+a/WMTK9yAQCI8MKXWReDlup87Th5AA4ij6vGkhmSse8bLvxhrzuDTy0TjvQBW1aQD6cXwAFwY+UeINdmQpVN7c2PGxyrdXiVsyT0stp3jjR0/pgyR5m/3TFrivYJiU2G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705592; c=relaxed/simple;
	bh=sTEaSzZGZ7wzz3nSZfYyiBfSaTay8Nqwy+y6SfFbCOo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EcOCBjsUENRTeFCSxrwz82DJvXNS3MWcPzvNZ4HqAN1RkvBFoZ9wxJv1UYBy9QdtLL8MFS6gf5jWkdPBLTQab2OwUWbIdDX+ndrELt96Jdrpvf6ay6Q+BsdxlFpg0T0eoEutWpYbi0eiP2wau9IrrRwLaGoXC8rLxUTLcplnqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6acbcb92d31so694586eaf.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 04:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705585; x=1787310385;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mD+AN/ziivY+94sIbJ3DI1SGLR/569rJOQ1PlTZUJdw=;
        b=ceRE+R8P5cVUWGBOXFSCGReuaBafg5aGiXlcOr2mmA8xchL77mB8IrFtr8p82oJW09
         j6NBI3dh53aK+9HfXVTKX7MGho5Zg7CARLlMVi6TIKfb0U320XwXelG+xRYbrXEpSpFo
         MI16Xo6QU1l7Q1IKbLoiHE+kNOJv5bI5Xn/i6QoWLMFqC+pYG9ei5QTgk63Regd+3bMW
         CY43QKSVlPXl3f1hLdwwbtzNfZYGN5v7S7CBOhMWRQgoJOK6h0sbrNONv/4Kld2RoFlQ
         lfjgH1UUCF3TIQWztYDwo7/JKaEUZotY0mE1LEX72WuWq3iRQ8s7u4Ap+dhYoJ9yw5cl
         jITg==
X-Forwarded-Encrypted: i=1; AHgh+RoaX9AhgXP9iZPBffBSzaVRMjHNNePa92txfH1jv+6ifOvChTFOQEr9tMb7nMSVK2BtrseSulM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA95eFDIMGKgBHEEo/q3aSjAfZbP+rW9oVTqOaMtbtUwMnCjLK
	tbUAMaMnu8xncmLMZBb/VSWi8sRFSfbcsFNpPNQuu0oBDo5Oi6QB4CAkGteqMY3m09ho2JU/N6o
	Xqnld363o7Jhi62/Scn5l0T4cUoTib06ndTFySilQPSIOvWTf87n6CYCSgKY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b09:b0:6ae:8b66:8726 with SMTP id
 006d021491bc7-6b0d62583e1mr4149900eaf.18.1786705584977; Fri, 14 Aug 2026
 04:06:24 -0700 (PDT)
Date: Fri, 14 Aug 2026 04:06:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7ef6b0.10853dc7.22f513.0004.GAE@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in new_device_store
From: syzbot <syzbot+989ff6506f5c6d1ff56b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f1baf1fc892 Merge tag 'trace-v7.2-rc7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170d8a25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=989ff6506f5c6d1ff56b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148d8a25580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+989ff6506f5c6d1ff56b@syzkaller.appspotmail.com

 </TASK>
kobject: kobject_add_internal failed for netdevsim1 (error: -12 parent: devices)
------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x111/0x130 lib/refcount.c:25, CPU#2: syz-executor324/6031
Modules linked in:
CPU: 2 UID: 0 PID: 6031 Comm: syz-executor324 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:refcount_warn_saturate+0x111/0x130 lib/refcount.c:25
Code: 06 e8 b3 92 ec fc 48 8d 3d bc c2 0e 0c 67 48 0f b9 3a e8 a2 92 ec fc 5b 5d c3 cc cc cc cc e8 96 92 ec fc 48 8d 3d af c2 0e 0c <67> 48 0f b9 3a e8 85 92 ec fc 5b 5d c3 cc cc cc cc 48 89 df e8 36
RSP: 0018:ffffc90003587b80 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffff9ba33900 RCX: ffffffff851de03b
RDX: ffff88802a11a540 RSI: ffffffff851de0ea RDI: ffffffff912ca3a0
RBP: 0000000000000002 R08: 0000000000000005 R09: 0000000000000004
R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000005
R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000001
FS:  000055558c1ff400(0000) GS:ffff8880d5fe9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558dbbbdfda8 CR3: 000000003f842000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:289 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 new_device_store+0x682/0x700 drivers/net/netdevsim/bus.c:197
 bus_attr_store+0x74/0xb0 drivers/base/bus.c:172
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_pwrite64 fs/read_write.c:794 [inline]
 __do_sys_pwrite64 fs/read_write.c:802 [inline]
 __se_sys_pwrite64 fs/read_write.c:799 [inline]
 __x64_sys_pwrite64+0x1eb/0x250 fs/read_write.c:799
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff5691f4237
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007fffaed29530 EFLAGS: 00000202 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 000055558c1ff400 RCX: 00007ff5691f4237
RDX: 0000000000000005 RSI: 00007ff56922d0cd RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
R13: 00007fffaed29580 R14: 0000000000000007 R15: 00007ff56922d4c2
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	e8 b3 92 ec fc       	call   0xfcec92b8
   5:	48 8d 3d bc c2 0e 0c 	lea    0xc0ec2bc(%rip),%rdi        # 0xc0ec2c8
   c:	67 48 0f b9 3a       	ud1    (%edx),%rdi
  11:	e8 a2 92 ec fc       	call   0xfcec92b8
  16:	5b                   	pop    %rbx
  17:	5d                   	pop    %rbp
  18:	c3                   	ret
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	e8 96 92 ec fc       	call   0xfcec92b8
  22:	48 8d 3d af c2 0e 0c 	lea    0xc0ec2af(%rip),%rdi        # 0xc0ec2d8
* 29:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2e:	e8 85 92 ec fc       	call   0xfcec92b8
  33:	5b                   	pop    %rbx
  34:	5d                   	pop    %rbp
  35:	c3                   	ret
  36:	cc                   	int3
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	48 89 df             	mov    %rbx,%rdi
  3d:	e8                   	.byte 0xe8
  3e:	36                   	ss


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
