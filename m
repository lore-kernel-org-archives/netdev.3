Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C7282F1E
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790923657; cv=none; b=ZkkH72VwDjrw8Qv+vL4QZad0tukM4RAp8/f+D+NNLk5JLSaa6IPARoTvVpj6FDswz4r9Eb/N7gb14I0+avDFqS3AHFfRSqB0kaaPgOioa7hVf1V4dGuKfIwyLviGCqQhhPFzbqis65kkMXrYEoUCK9Oww41lQNOw/vaNQn+8qdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790923657; c=relaxed/simple;
	bh=gbfPRwZftkck2LO2e16pi2S+G80B/cZ7HKZAN3eCUrg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JdspMS7yssoocLo7gsJ3xCycSovXtYUwWqedWGEMsxx+Q1NZFTmm1WJ9sL09Psc6To+/CRfgmnWJu2xT0VhD8i+OWE/IwkrRDCcA3IdnjemULZrR/eECSf3XObaCmE0aLUqK1KI7tqE1H4ltouDxfqxbkcDfchVCA+ano/GXM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4f4612a1a5cso1540834b6e.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 23:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790923655; x=1791528455;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WSPC3bP+3CDYpVCWkBISelr44X/6ERe8JuUHvSqeuIc=;
        b=IDtYLWVQ6TWn7LXb7s3M66yiusX5eBGZRlUuDxur1LjGYo3njbJTdmkzPsGsDjRUj8
         hRw6iQHaT3Kt9Pe59U6MMueE0iJB1UQ3xseMS5BjmIV/WbYQ8pY0uWPUbREn3xrzdOYn
         H9usY2rVm032w+QbP4KrEd1sI9GoFu/NFPqNJgqvQsMLuixfFx69PAttcyl3Gn78l33J
         LribAUdDPf9EKrmLJmvowugKExYIT58k2u6nqEK7aNRYnndYVRKw9le2mdW1lLyworNF
         O5rXd8XdOAbPUy9kNkrvWRFGHVsap059Za64fhcWhcd1ig5Ev+n5nI+WmJL/qVnU6zi5
         54eQ==
X-Forwarded-Encrypted: i=1; AKwUvByLOLwY5Wrr1u+zHJ4GSWwo8MwaUQs3roYQ5tO9l+V77jl7tO9lpI8Tgi9nPGPeP2LzLEb7rGY=@vger.kernel.org
X-Gm-Message-State: AFuF++k3FerjCPBMAqMiTgKrjgvK2yekAOpvUbUswAodDOwocfqN8XQ3
	dae0JuwQ2tzuf/71UHSrPZgxoFnzajRKwBSPkIW/IDyB0RaY3APTwPzkl0VEHxtdX8qWfsg0VTy
	EQwBI09yaGZ1H/5EBr4qCPNH7xbpeIiQji51BlY5WbBHpKvuCxwbcHnwZ49Q=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3a11:b0:4dd:f8bb:e1bd with SMTP id
 5614622812f47-4f307f07699mr4528250b6e.13.1790923654962; Thu, 01 Oct 2026
 23:47:34 -0700 (PDT)
Date: Thu, 01 Oct 2026 23:47:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abf5386.f32479dd.202a09.0008.GAE@google.com>
Subject: [syzbot] [net?] [nfc?] WARNING in nci_rsp_packet
From: syzbot <syzbot+ebbbf06f152da8ea4716@syzkaller.appspotmail.com>
To: davem@davemloft.net, david@ixit.cz, edumazet@google.com, horms@kernel.org, 
	krzk@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d266640c6c76 Merge tag 'driver-core-7.3-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116eb315580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a820d8842c77560
dashboard link: https://syzkaller.appspot.com/bug?extid=ebbbf06f152da8ea4716
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d266640c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a2c43e9e32e/vmlinux-d266640c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/74034a2af7be/bzImage-d266640c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebbbf06f152da8ea4716@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue nci_cmd_work on wq nfc2_nci_cmd_wq
WARNING: kernel/workqueue.c:2352 at __queue_work+0xdb7/0x1370 kernel/workqueue.c:2351, CPU#3: kworker/u32:0/12
Modules linked in:
CPU: 3 UID: 0 PID: 12 Comm: kworker/u32:0 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: nfc2_nci_rx_wq nci_rx_work
RIP: 0010:__queue_work+0xdbb/0x1370 kernel/workqueue.c:2351
Code: 00 00 00 fc ff df 49 8d 94 24 70 01 00 00 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 84 05 00 00 48 8d 3d 29 43 78 0f 48 8b 75 18 <67> 48 0f b9 3a 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03
RSP: 0000:ffffc900001e7a40 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff888026cc1000 RCX: 1ffff1100f10e022
RDX: ffff8880298be170 RSI: ffffffff8ba2d9c0 RDI: ffffffff91486f90
RBP: ffff8880788700f8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000200000 R11: 000000000000761b R12: ffff8880298be000
R13: 1ffff9200003cf52 R14: 0000000000000020 R15: 0000000000000084
FS:  0000000000000000(0000) GS:ffff888096c55000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000c3aef55 CR3: 0000000078b7d000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 queue_work_on+0x180/0x1e0 kernel/workqueue.c:2501
 queue_work include/linux/workqueue.h:700 [inline]
 nci_rsp_packet+0x297/0x3420 net/nfc/nci/rsp.c:463
 nci_rx_work+0x29c/0x430 net/nfc/nci/core.c:1579
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 fc                	add    %bh,%ah
   4:	ff                   	lcall  (bad)
   5:	df 49 8d             	fisttps -0x73(%rcx)
   8:	94                   	xchg   %eax,%esp
   9:	24 70                	and    $0x70,%al
   b:	01 00                	add    %eax,(%rax)
   d:	00 48 89             	add    %cl,-0x77(%rax)
  10:	f9                   	stc
  11:	48 c1 e9 03          	shr    $0x3,%rcx
  15:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
  19:	0f 85 84 05 00 00    	jne    0x5a3
  1f:	48 8d 3d 29 43 78 0f 	lea    0xf784329(%rip),%rdi        # 0xf78434f
  26:	48 8b 75 18          	mov    0x18(%rbp),%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  36:	fc ff df
  39:	48 89 ea             	mov    %rbp,%rdx
  3c:	48 c1 ea 03          	shr    $0x3,%rdx


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
