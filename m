Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1C402BB7
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969809; cv=none; b=qV3/ABUllsLmUUJQ/X4mpcbAGScxVuGU7wX0nhvRoktjyQu0TIS9wmIgjNfVFqKl/CDy94RVFQ84aOSpcMKK6h9aMb3DXd3K/tXSDqKx2ZyyRjiRwaTIh+xOFMrkgDBhLChPfttzJSRDTRVl6uj8hyKjO5RslhN7ZSQhuKSq0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969809; c=relaxed/simple;
	bh=na3yIUd+O3pGlWpdKlxph375UnKcqAExGP1+FDilZEQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sBs6ovotJCpRRzMPvWY5yrgDiouig7SAcsXpCuF1O8ciX6R88utZ/Q4tHuoLopLLDlOTbMYke7dFf1b0q1UIoRbU5rxiYeT80/ppmWdekw9c1jf8+5PPbHB5z264BGgyQQK5dVxltIYxDJLFe28DsCGGwzIXzIMgJ/oTegQlIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6a17dafd042so1366089eaf.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 15:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785969807; x=1786574607;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F1P2VLQ2OGmrNLyOIICCNXArMMWwzzWcKgjBWnmKSUc=;
        b=svaybUy3ATH28wGJQrAnl6yC9eYZ4PkvcocDBrV8TjC+DNvILh+RR27dJFJWfZpbRM
         1v7DCFApRQn9gpejz3U40dxCs5dqnYd0F3/C9zJVHrmEXFVuQDyj4wzr0S+HKXAqYdgz
         ipMlEzZfe7zl6KgP7aPvDr69+NmoIPjv87pjT07uY8JgOYtaN5NaSGJuLcRnNoZCez3+
         38DaHBrmj4NlNYykVHYpFVHKFENPjqAi4Gbdki9IS4KmznZXRwJDYSe76Ki1534NXV21
         9m7YW3xGAys1BNj5MtwD+fgkn22WloubLaYbPJtc5LY3vQ9xPWW0JCJNN2iBQQwCcuD+
         U+JA==
X-Forwarded-Encrypted: i=1; AHgh+RrHesnuQeH4ZHmEzcibJYj6GLZpHbIl5SItZRtm7zmS+GL+kfH53saXUDS0dBN9WeYyIvirctU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOw9Z9gi3LE81/AtE8gm9yrwgLGxLisWWwrgS9TQMCPgOIHeX/
	ULqjwwgNX+cyHdCKz2MxWnID0bGj6x90qdT652T8OupS1o4WpDBzcTBBY61ylP7EFaqDR6c+08x
	Ro2sEDoAqGT1Rl0xBlGlSI/UPb+70pIQDMcg9n0rNJAS0ij7aTMWgMRXhyk0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:199a:b0:6aa:f172:3094 with SMTP id
 006d021491bc7-6ae96cb428bmr5074098eaf.10.1785969807042; Wed, 05 Aug 2026
 15:43:27 -0700 (PDT)
Date: Wed, 05 Aug 2026 15:43:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a73bc8f.5aeeccc9.207e63.0001.GAE@google.com>
Subject: [syzbot] [nfc?] WARNING in port100_send_cmd_async/usb_submit_urb (3)
From: syzbot <syzbot+89f5f8143d8e62af2b61@syzkaller.appspotmail.com>
To: david@ixit.cz, krzk@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b613b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=89f5f8143d8e62af2b61
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17379bb9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1073be32580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fb497cc0c8d/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/663ccee34982/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+89f5f8143d8e62af2b61@syzkaller.appspotmail.com

usb 5-1: Product: syz
usb 5-1: Manufacturer: syz
usb 5-1: SerialNumber: syz
------------[ cut here ]------------
URB ffff88803435b300 submitted while active
WARNING: drivers/usb/core/urb.c:379 at usb_submit_urb+0x1689/0x19b0 drivers/usb/core/urb.c:379, CPU#1: kworker/1:0/29
Modules linked in:
CPU: 1 UID: 0 PID: 29 Comm: kworker/1:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0x168c/0x19b0 drivers/usb/core/urb.c:379
Code: 00 48 8b 04 24 48 8b 90 b0 00 00 00 e9 70 ff ff ff bb ed ff ff ff e9 ac f1 ff ff e8 9e ed 89 fa 48 8d 3d a7 6d af 09 48 89 de <67> 48 0f b9 3a bb f0 ff ff ff e9 8e f1 ff ff c7 44 24 30 00 00 00
RSP: 0018:ffffc90000686e38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88803435b300 RCX: 1ffff1100686b7d1
RDX: ffff88801f6c2540 RSI: ffff88803435b300 RDI: ffffffff912fe4f0
RBP: ffff8880350c0c68 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880350c0c38
R13: ffff88802ef4fe00 R14: ffff88803823bcc0 R15: ffff8880350c0c60
FS:  0000000000000000(0000) GS:ffff8880d5ed8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33463fff CR3: 000000003f4ce000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 port100_send_frame_async drivers/nfc/port100.c:783 [inline]
 port100_send_cmd_async+0x7f7/0xc60 drivers/nfc/port100.c:879
 port100_send_cmd_sync drivers/nfc/port100.c:919 [inline]
 port100_set_command_type drivers/nfc/port100.c:990 [inline]
 port100_probe+0xb4c/0x1190 drivers/nfc/port100.c:1555
 usb_probe_interface+0x303/0x8f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_new_device.cold+0x685/0x115c drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x30a3/0x4a60 drivers/usb/core/hub.c:5953
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 48 8b             	add    %cl,-0x75(%rax)
   3:	04 24                	add    $0x24,%al
   5:	48 8b 90 b0 00 00 00 	mov    0xb0(%rax),%rdx
   c:	e9 70 ff ff ff       	jmp    0xffffff81
  11:	bb ed ff ff ff       	mov    $0xffffffed,%ebx
  16:	e9 ac f1 ff ff       	jmp    0xfffff1c7
  1b:	e8 9e ed 89 fa       	call   0xfa89edbe
  20:	48 8d 3d a7 6d af 09 	lea    0x9af6da7(%rip),%rdi        # 0x9af6dce
  27:	48 89 de             	mov    %rbx,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	bb f0 ff ff ff       	mov    $0xfffffff0,%ebx
  34:	e9 8e f1 ff ff       	jmp    0xfffff1c7
  39:	c7                   	.byte 0xc7
  3a:	44 24 30             	rex.R and $0x30,%al
  3d:	00 00                	add    %al,(%rax)


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
