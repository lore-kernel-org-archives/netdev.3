Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2B351C0C
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037144; cv=none; b=FjbzE1Pv1EoWIxpxT2eDssg8ykQxA/yqgEwwp84myL2UCX9TbhfaKzvOS2bXtHZ+/Lvj22YHCbAVbG8pLntOZ6KSel8PnTsxYwKcL2TEzuJhfrPuQ8z4AhW01vMfA4d2kCwUCYBlq1xIa42gTlkr6TMlqjEGDzaWk0v3z8l3JFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037144; c=relaxed/simple;
	bh=PGA37Aw1uYtTeEO5MjT+1glEXpmvF6LSRdWoyPJdf18=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rvGE8UOnmkC7k7iH8bVVXcjFnOeZkM48m2z8d8Yxg2KfMCIOjrq0OBr95qzc127wUUjqL3B/oEcJMCsB/s7hqqFDGo+bOdBrtkguUedDj4KlBiP6+RREqaBCA5ZKV/PoNfuT/1D/sozG+TNiNg6cxh+VQt1sW4ObI2Jv3BRPX88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6c2c5c1f843so705733eaf.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790037142; x=1790641942;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRdut7bVBSm2SpCHoYzNXZW5bUxoFVvpj0afbTE+wWU=;
        b=pqw1gbsXwwY9DtXk6Nk46bEGdbiBaFegL6YO5reg/x7ATEfVck49AQBeR3H8PWYFkw
         cAcySRYt9WpIk8zJ3S6AZO0fRltxurMBhDBIAHLMQg7ILTBe1JPbWEEIKUpVP3kBzdrS
         yIKZmxOB6ePOBmnUI1awm/tRemoghF5MVIztHxJWF9oULJHkKbdnzDRGtNg7g+OuJNAz
         72a/bBPFlJyhaRzAjsPeFUMIF2fdJi1hiwRiBYJqVwjYUBm+VJT2DE4pOBZBie95l8Bf
         H8qhgzXvBLm7Xi2b7WYxRvqkr97QK8bI8zA9yM99bRAVROKi0fpg8josj/rZRrQ+vkk7
         n5gw==
X-Forwarded-Encrypted: i=1; AKwUvBwffNfc11rBS4596HKKiErzliJHGdIr7D8zadyCiY0Hng8kxrkc/F0vRRFkvHVo9XZqUr3v+l4=@vger.kernel.org
X-Gm-Message-State: AFuF++m+mmZFoE65nJ2zh8i9EbmhPnR46gNXBLpT6rkPKrTXe2JeA8E+
	ovCQAcvwOO/OAFJdh3TCE9zUzjQc2GP6EYLkO+iEY5BllZKL4STCvOGyPm4otfhMP6CdSRz7CsE
	X0hvfMXblYeJZzpoHwYYA7A2pTTDooymuWC+opd/sYGBxQahoZpJMZoFR8hY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a4:b0:6ba:5f65:6e5c with SMTP id
 006d021491bc7-6d15b86e2fdmr1299293eaf.42.1790037141831; Mon, 21 Sep 2026
 17:32:21 -0700 (PDT)
Date: Mon, 21 Sep 2026 17:32:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab1cc95.3179f8cd.1e36b2.0025.GAE@google.com>
Subject: [syzbot] [net?] [nfc?] WARNING in nci_unregister_device (2)
From: syzbot <syzbot+c2d417f06523d8133c6a@syzkaller.appspotmail.com>
To: davem@davemloft.net, david@ixit.cz, edumazet@google.com, horms@kernel.org, 
	krzk@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4982d3552a3b Merge tag 'sound-7.3-rc4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126007f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84649d3ff8d550cb
dashboard link: https://syzkaller.appspot.com/bug?extid=c2d417f06523d8133c6a
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4982d355.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2afaea1fac3/vmlinux-4982d355.xz
kernel image: https://storage.googleapis.com/syzbot-assets/06e82fadea82/bzImage-4982d355.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2d417f06523d8133c6a@syzkaller.appspotmail.com

------------[ cut here ]------------
pwq_busy(pwq)
WARNING: kernel/workqueue.c:6173 at destroy_workqueue+0x329/0xa30 kernel/workqueue.c:6173, CPU#1: syz.2.490/7238
Modules linked in:
CPU: 1 UID: 0 PID: 7238 Comm: syz.2.490 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:destroy_workqueue+0x329/0xa30 kernel/workqueue.c:6173
Code: 8d 5c 24 68 48 89 d8 48 c1 e8 03 42 80 3c 28 00 0f 85 80 06 00 00 49 8b 44 24 68 48 39 c3 0f 84 84 00 00 00 e8 a8 67 3a 00 90 <0f> 0b 90 48 c7 c6 e0 33 ee 8b 49 8d 96 70 01 00 00 48 c7 c7 80 23
RSP: 0018:ffffc90024d17d18 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffff8880202d5024 RCX: 0000000000000001
RDX: ffff88802efb0000 RSI: ffffffff81d1b808 RDI: ffff88802efb0000
RBP: 0000000000000002 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880202d5000
R13: dffffc0000000000 R14: ffff88802d717000 R15: 0000000000000001
FS:  000055557a4f1500(0000) GS:ffff8880d5c59000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb058227dac CR3: 00000000259c2000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 nci_unregister_device+0x87/0x330 net/nfc/nci/core.c:1332
 virtual_ncidev_close+0x4b/0xa0 drivers/nfc/virtual_ncidev.c:168
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1d8/0x700 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x661/0x790 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb057f9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca775e428 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fb058227da0 RCX: 00007fb057f9e159
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fb058227da0 R08: 0000000000000006 R09: 0000000000000000
R10: 00000000003ff438 R11: 0000000000000246 R12: 0000000000011884
R13: 00007fb05822609c R14: 00000000000115bd R15: 00007fb058226090
 </TASK>


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
