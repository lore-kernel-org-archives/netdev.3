Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C337AA79
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922196; cv=none; b=UGRZe6g33s610pWC797zRJjGhe+AuUPSqAWRc+kueAUap+Kb6VHZNkoBxlkten1UR+MP9pTN4cKBl67Xr9czaBPUo4jku/bvL/5KyaZz2/ypI1FpOpR0mwoB1el2u31b3drxHcrbOpHXrlU2tqF734Kd6p5X+gvazIy+JLzRdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922196; c=relaxed/simple;
	bh=w9N7rUN5MyX0SWHUVLR7eOIV31mFCPUdmgCSaGSrv1A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IrsXp74mUfyK+1yM3oir3oCwOZrMlBoib6O2LekMjM9VpDkh9S/rkOCLMEXb844KFe5J/x2nmBH+/FCVivPjuuy73BurGV21k4X4BeNvELjP2DcKL5npGfsssMEIcWVcoQDF3E3uDFKKivmFK6JrLT8hah+Dt4uNVAs23hnAs2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-69de11bef3dso6121212eaf.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 05:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922194; x=1781526994;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIREoixd2bdV8Z7DckKM4nIm0jrKXnD6MTejIoiF5rM=;
        b=mWKDrGX1VGo9TxuyJpFcGhqGesXbZ/UMTE/5596a2yduOjQHkVsLYsl3knmyY5rZ7N
         yGuCjcrC1HvbtT3dNNWB0LHX1Ea/t4NGJgDIGsxk648utzobnDRLsMDHAXxQshZVkT5w
         dHFoB9WN9eVqGelyxfAMFvsfjpsMF32odPbfg5JwJ1RFEHYnIh40dCqwEtw9uU/JXl3D
         ILigbS5TGGjcI4x88MC+LGT5XwvVXFf7aAmeVkZItbWeD2WYieASDgV+5jrTfifFPFe4
         u7sP0zY7vpAVNPRXzEEG6GB7fozk/aoujDWxTrK5ADI/TyAFWu+7+AsOWTuMezbieuCp
         W1sw==
X-Forwarded-Encrypted: i=1; AFNElJ/ubft1X83WxnEbqgAkCdZNe6PPNlBn5ZwKZ1PjGRG8UZML97a98B+WsVz2HMYPbOqE+P34C1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlxsGEYaxib7D8jxwMLQpqn1dFe2VmDBO0EeQGIsbOW9BLfVH
	JvPIymHESgACpkjtes7JYmKxVGUVKUZfFBVeWfCr8phsW0ivO0S6D74x3rvB4XlpVsI8hxxBGeu
	I3eWVfzXRu5oOA7Zsq0L3MkHo0OhC/naHnHa+6ZwNlUxYbg9Ke4yae2pVaqE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6fc8:b0:699:a28b:18ed with SMTP id
 006d021491bc7-69e68c6459cmr6137714eaf.48.1780922193959; Mon, 08 Jun 2026
 05:36:33 -0700 (PDT)
Date: Mon, 08 Jun 2026 05:36:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a26b751.c25708ab.1b19ef.0013.GAE@google.com>
Subject: [syzbot] [net?] BUG: corrupted list in dev_deactivate_many (2)
From: syzbot <syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    511e746700ee usb: host: xhci-rcar: Split R-Car Gen2 and Ge..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14231e7a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30c90421ef9661c9
dashboard link: https://syzkaller.appspot.com/bug?extid=381d82bbf0253710b35d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1533db7e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6557c06dfbf9/disk-511e7467.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2753a4bffe07/vmlinux-511e7467.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6954fb52fe02/bzImage-511e7467.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com

list_del corruption, ffff888114a18c00->next is NULL
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:52!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 91 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Workqueue: events_unbound linkwatch_event
RIP: 0010:__list_del_entry_valid_or_report.cold+0x22/0x2a lib/list_debug.c:52
Code: e8 9d d8 fa ff 90 0f 0b 48 89 de 48 c7 c7 80 85 b0 87 e8 8b d8 fa ff 90 0f 0b 48 89 de 48 c7 c7 20 85 b0 87 e8 79 d8 fa ff 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000517870 EFLAGS: 00010086
RAX: 0000000000000033 RBX: ffff888114a18c00 RCX: 0000000000000000
RDX: 0000000000000033 RSI: ffffffff819207d9 RDI: fffff520000a2eff
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000202 R11: fffffffffffeb4a0 R12: 0000000000000000
R13: ffffc900005178c0 R14: ffff888135550678 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8882687a5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007febffbd4e9c CR3: 0000000120bc2000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:132 [inline]
 __list_del_entry include/linux/list.h:246 [inline]
 list_move_tail include/linux/list.h:341 [inline]
 ref_tracker_free+0x1a7/0x6c0 lib/ref_tracker.c:329
 netdev_tracker_free include/linux/netdevice.h:4491 [inline]
 netdev_put include/linux/netdevice.h:4508 [inline]
 netdev_put include/linux/netdevice.h:4504 [inline]
 netdev_watchdog_down net/sched/sch_generic.c:600 [inline]
 dev_deactivate_many+0x28c/0xfe0 net/sched/sch_generic.c:1363
 dev_deactivate+0x109/0x1d0 net/sched/sch_generic.c:1397
 linkwatch_do_dev net/core/link_watch.c:184 [inline]
 linkwatch_do_dev+0xd3/0x120 net/core/link_watch.c:166
 __linkwatch_run_queue+0x3a5/0x810 net/core/link_watch.c:240
 linkwatch_event+0x8f/0xc0 net/core/link_watch.c:314
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
 process_scheduled_works kernel/workqueue.c:3397 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report.cold+0x22/0x2a lib/list_debug.c:52
Code: e8 9d d8 fa ff 90 0f 0b 48 89 de 48 c7 c7 80 85 b0 87 e8 8b d8 fa ff 90 0f 0b 48 89 de 48 c7 c7 20 85 b0 87 e8 79 d8 fa ff 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000517870 EFLAGS: 00010086
RAX: 0000000000000033 RBX: ffff888114a18c00 RCX: 0000000000000000
RDX: 0000000000000033 RSI: ffffffff819207d9 RDI: fffff520000a2eff
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000202 R11: fffffffffffeb4a0 R12: 0000000000000000
R13: ffffc900005178c0 R14: ffff888135550678 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8882687a5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007febffbd4e9c CR3: 0000000120bc2000 CR4: 00000000003506f0


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
