Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DBC208D0
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786234175; cv=none; b=hhWDA+VL4gfILiULEwZuwdIQqrlj8J1vpJny8eLhgjgSQuKrPNm3DZbWruXfpsaAc9gva+M2ZZGiXBdC6LVIyheGeJj2gSgr+QK/05kOmkadJomOuaG+WWw25zRwaoqZlgQEbycT+zUBRe71dLX7KdUgib8R9vSmJeb5lUp1lHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786234175; c=relaxed/simple;
	bh=/QeTaHNPwcCPmeumVZo79wex1aEfJNEMDkSe176uCyw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=khpUsEibH++bTGtTeqckWSGYMfBtaGH126oXLoppZSuvvmrzW6TeFee1Rcm4BrfgER9iMbKlg9VGOoAr4HjYaXOk9gwhmzN7LHT0DkaSyTM1IKJ2qIbtdPCpATrC3HEm0LfNWeZtkoG8hhhxETx1j2Nuf68wsmHH7PECtoxXrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4ab7bb257bbso405995b6e.0
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 17:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786234173; x=1786838973;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vInf9AVLd8ueP6fJlwsQOnMJLRVgfMo2meap1oZ1iJw=;
        b=JNJCJu1TTi+5cprcBgy0GhL6guNN4DV/lzM05rQX8B0f/PsAJI/fV4THxxTI6ZAHxG
         pHQkjpUgwPqcHCjBBr7UJvDM7pUrSsfOxfZby4Nl87whz4Id4BG2uIAp7lxTfqLGqZ+5
         D0Vk2ZfsePI6tD/6S/hlLY4iQpoZZvpSCb25FCkLHRNHdA1ZT+zEc2Y4jwdnayMYXPmD
         IJQygmYwl0BLQgv8Dng3qMjurpN6E2LlaWz2+iaI+dMSd0bT08V06K2Tv1hpP3y1gOiW
         tkV6R2+V0HevnYQFRIfqmcuvd1FBb4ls35tq4I60uK5zNZDLsTCxQmWS6cmt4W1iPDYF
         uKLw==
X-Forwarded-Encrypted: i=1; AHgh+RpCsPCEACq8UzLyVkYY5hlJonA/2eMZKZLZ/VikAGv/mOmWkkjreKLsyyuXG0QW8qqLDN3NwvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmVYUubM7SD25YSV67FfUdHv4x3nC26ALC+rC2sia/l3vMFNmo
	TkWZUY7FxRKGHFtgGjJ0fqriqA49Pcd4nZJsgUo3CBA3nYelOi/5tdIb1RJQ03xBOx9J7pEcRls
	WPZh8H/IRU3/PGtpDrIQOxJiv6hAd/MnusFcnRnFCtoT3Rks7nIxjVucg1Ao=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1785:b0:496:11f1:f2b3 with SMTP id
 5614622812f47-4b1a107dfc1mr9184879b6e.20.1786234173169; Sat, 08 Aug 2026
 17:09:33 -0700 (PDT)
Date: Sat, 08 Aug 2026 17:09:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a77c53d.01d0871a.3a0d52.0077.GAE@google.com>
Subject: [syzbot] [nfc?] kernel panic: kernel: panic_on_warn set ... (3)
From: syzbot <syzbot+fe5ea83cdd7fc263f452@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, krzk@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9a2394a2348 Merge tag 'mm-hotfixes-stable-2026-08-06-18-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a1be49580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30772517ee66ef58
dashboard link: https://syzkaller.appspot.com/bug?extid=fe5ea83cdd7fc263f452
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ebec1b22682a/disk-f9a2394a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5c88db273365/vmlinux-f9a2394a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/43600cc1b90a/bzImage-f9a2394a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe5ea83cdd7fc263f452@syzkaller.appspotmail.com

Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 UID: 0 PID: 7451 Comm: kworker/u8:11 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: iou_exit io_ring_exit_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 vpanic+0x552/0x970 kernel/panic.c:651
 panic+0xd1/0xe0 kernel/panic.c:788
 check_panic_on_warn kernel/panic.c:525 [inline]
 check_panic_on_warn.cold+0x19/0x34 kernel/panic.c:520
 __warn.cold+0x191/0x318 kernel/panic.c:1104
 __report_bug+0x30f/0x440 lib/bug.c:254
 report_bug+0xb2/0x220 lib/bug.c:286
 handle_bug+0x16a/0x2a0 arch/x86/kernel/traps.c:436
 exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:490
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:593
RIP: 0010:io_ring_exit_work+0x479/0xd7a io_uring/io_uring.c:2365
Code: 8e e8 ab 8c 44 01 48 8b 05 24 97 4b 0d 4c 8b 7c 24 38 31 ff 49 29 c7 4c 89 fe e8 f2 f2 d4 00 4d 85 ff 79 12 e8 48 f8 d4 00 90 <0f> 0b 90 48 c7 44 24 20 70 17 00 00 e8 36 f8 d4 00 48 8b 74 24 20
RSP: 0018:ffffc900047b7aa0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888052290710 RCX: ffffffff81355b6e
RDX: ffff888052140000 RSI: ffffffff81355b78 RDI: ffff888052140000
RBP: ffffc900047b7c38 R08: 0000000000000007 R09: 0000000000000000
R10: fffffffffffffffc R11: 0000000000000000 R12: ffff888052290000
R13: dffffc0000000000 R14: 0000000052290700 R15: fffffffffffffffc
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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
