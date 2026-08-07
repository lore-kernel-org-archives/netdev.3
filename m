Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCAF2D2495
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111001; cv=none; b=de1MZ0/m6n8q4t91Y8i1LE83BQodBNwttN3QrYrp1CyHySogapEGkZNwh57Rxp+tmWdmU2rpoEeD8pMY2QyQfwzWfh5tcUpObxNRRIDLRSP3VcSYhmlxTHToQyj/1kCMV0TiFJwJAQIULJT9F2pu/VwQVysadWYVLG6pMS4pZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111001; c=relaxed/simple;
	bh=kXZkz+nFrrkZHAffGQSrPVYZ78T8zo5nRCbLOlbeNkI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VQL0adPN67ZpymSVVZ7+Qg6Q4EW5KLqPijGCEX8/JRpiO6ZvA03eBTEmULjiml2MtRCL/ikwJJlr4qNACgFSAXJWWMVpx/Nx9gXcG5ZePEZWxcnqZhOuNJn020Qzud4u1q+nvox2OzaitvON8wWiF1lFINSbWFV9z+S/H61vH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9e54e9cf5so4003463a34.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110994; x=1786715794;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R/npyqMpy3L42TglGs2VMomY8aCT1/3vU5yA/bSF4N0=;
        b=bgrM1kJc4bdEaeWQwThCHLAyuORDKCe7OXzyRrKaTonydIw2NPgu5Qep+TGzcdvil6
         z2GN619rlfnf7L8oOaPkrVUPZRNKLYGErXAdYQ+ORZ6nlwXePVpd9k705LAyxEDnhYUv
         s0i19Ep1oRCyCoa0xsGujj6jU2NHbnTlkgpuoGR9+IfL9bVz/QQvuy9JieApLBwI1wxJ
         AsSuixtzoEPwXxeVUdFqmdxhmRc5t6Js6BlTFWTyXFHcYTkDDQ4zvwon3YD5ZPhOV9IF
         AU1nRFQI4GEKo5mQ9MGcP8r1m6P8Otg1GRXoflcjTmIaLukmAWklOSqCeaRjj3gKsMmT
         xN5Q==
X-Forwarded-Encrypted: i=1; AHgh+RqOPQ1hy4OuF6WbNLq0gp11FtkFb+kwYoNcJQrgXZaOxupmgSEaj/3ah5bJWH/qNG7MZjOB35Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGEvp9Gu1aIpDe3cJhmP8honOFLKrmUps78kQra8C3dVc+aa9S
	0uIyrw74mpFCgngn7F54yf1xhTY6LPzioihOxodxv4Q8J5SHdQrrOTJlFbBgJ8gDEXtWoPJz0vQ
	gG/ehXYuvc+CAsLfofec54CDmsl0z5W17g8KoQTudV7IYNjUJqs62D1WHfM8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2916:b0:69d:9dfb:7928 with SMTP id
 006d021491bc7-6ae96c1002fmr12466994eaf.3.1786110994196; Fri, 07 Aug 2026
 06:56:34 -0700 (PDT)
Date: Fri, 07 Aug 2026 06:56:34 -0700
In-Reply-To: <673e3029.050a0220.363a1b.0024.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a75e412.01d0871a.3a0d52.0049.GAE@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in device_move
From: syzbot <syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, kriish.sharma2006@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f9a2394a2348 Merge tag 'mm-hotfixes-stable-2026-08-06-18-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101a02c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86ba763b42fa66a
dashboard link: https://syzkaller.appspot.com/bug?extid=1f4e278e8e1a9b01f95f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170d0fb9580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 1 UID: 0 PID: 4943 Comm: kworker/u9:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: hci0 hci_rx_work
RIP: 0010:klist_put lib/klist.c:212 [inline]
RIP: 0010:klist_del lib/klist.c:230 [inline]
RIP: 0010:klist_remove+0x156/0x340 lib/klist.c:249
Code: 4d 89 f5 49 c1 ed 03 43 80 7c 3d 00 00 74 08 4c 89 f7 e8 8d 64 84 f6 4d 8b 26 49 83 e4 fe 49 8d 7c 24 58 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 74 05 e8 6e 64 84 f6 49 8b 44 24 58 48 89 44 24 08
RSP: 0018:ffffc9000fc87700 EFLAGS: 00010202
RAX: 000000000000000b RBX: ffff888035a90000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000058
RBP: ffffc9000fc877e8 R08: ffffffff90199ae3 R09: 1ffffffff203335c
R10: dffffc0000000000 R11: fffffbfff203335d R12: 0000000000000000
R13: 1ffff1100e64e20c R14: ffff888073271060 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125306000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4691400c30 CR3: 00000000750f0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 device_move+0x18e/0x720 drivers/base/core.c:4698
 hci_conn_del_sysfs+0xb8/0x1a0 net/bluetooth/hci_sysfs.c:75
 hci_conn_cleanup net/bluetooth/hci_conn.c:170 [inline]
 hci_conn_del+0xc3d/0x1200 net/bluetooth/hci_conn.c:1308
 hci_disconn_complete_evt+0x5ac/0x890 net/bluetooth/hci_event.c:3470
 hci_event_func net/bluetooth/hci_event.c:7784 [inline]
 hci_event_packet+0x6cd/0xf10 net/bluetooth/hci_event.c:7835
 hci_rx_work+0x3ee/0x1020 net/bluetooth/hci_core.c:4039
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:klist_put lib/klist.c:212 [inline]
RIP: 0010:klist_del lib/klist.c:230 [inline]
RIP: 0010:klist_remove+0x156/0x340 lib/klist.c:249
Code: 4d 89 f5 49 c1 ed 03 43 80 7c 3d 00 00 74 08 4c 89 f7 e8 8d 64 84 f6 4d 8b 26 49 83 e4 fe 49 8d 7c 24 58 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 74 05 e8 6e 64 84 f6 49 8b 44 24 58 48 89 44 24 08
RSP: 0018:ffffc9000fc87700 EFLAGS: 00010202
RAX: 000000000000000b RBX: ffff888035a90000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000058
RBP: ffffc9000fc877e8 R08: ffffffff90199ae3 R09: 1ffffffff203335c
R10: dffffc0000000000 R11: fffffbfff203335d R12: 0000000000000000
R13: 1ffff1100e64e20c R14: ffff888073271060 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125306000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4691400c30 CR3: 000000007e68e000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	4d 89 f5             	mov    %r14,%r13
   3:	49 c1 ed 03          	shr    $0x3,%r13
   7:	43 80 7c 3d 00 00    	cmpb   $0x0,0x0(%r13,%r15,1)
   d:	74 08                	je     0x17
   f:	4c 89 f7             	mov    %r14,%rdi
  12:	e8 8d 64 84 f6       	call   0xf68464a4
  17:	4d 8b 26             	mov    (%r14),%r12
  1a:	49 83 e4 fe          	and    $0xfffffffffffffffe,%r12
  1e:	49 8d 7c 24 58       	lea    0x58(%r12),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 05                	je     0x36
  31:	e8 6e 64 84 f6       	call   0xf68464a4
  36:	49 8b 44 24 58       	mov    0x58(%r12),%rax
  3b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
