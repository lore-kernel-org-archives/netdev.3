Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887CD27B340
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767174; cv=none; b=nZOlWb2079yPWGTGURhRZXe128xcnYi1RpZZTp0GpxS63W4H7YsgXwuG1T9ugZvRda/cHfA8clTE/gUhvZJ7ux1u7ywTgFcITAE8OasxXnbT9+FnNqBFy8ks2D/u4AlTsHi1XDDZyrI2+wnfCIteievABipKFa+Nuobe63zKIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767174; c=relaxed/simple;
	bh=NvKeBWEPTljeH0OraIY2kdDqlCpntQjPiAMlQ1DcMrQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ARA35FnKIdhcsq2yKsIppjM8OvPgUE+TUGcU1F3mNrGAP2d6Giz1cd3jlwfz7AcOZ2yhngwWcbbqxrBuHILZCGnonUCGbNdk4hMGxW4QB8KMzeuuEOX8CcdRqPPNikMzQXBPqf3BDW2b355I+LCQ95uD1irWsjAqOJa+6dOX//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-451ff8b9acbso44604fac.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 17:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784767171; x=1785371971;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZbNS/13+64JV2lMjMJl+r/9dBrsjiPt4ulSptJVrL8=;
        b=cTR+biwAvylOFy3Useo2hv6JOkXwSncb22qd8b1JK9N1gToXUZuPANYk22kd4S25pb
         9uaX7KGpf8Mc0xa+/2cy3BKhi4zaFBPLXPVCVlHDXvR/Wkmg+3f6TPyw4JALpglCkFVV
         fs6EwgDjN3xJZtQfeqkQAyT6RVbW0b1bJ3BbJrcteaiDGwbaWb7QImaAnLiRqB5a5e//
         F+iyDwo5lTYIfI96oK61F8vSDHS36dgRnvtAdqYSRknMD6CT+ZDfYIVyZ2r7o/q8VGSQ
         8O7vmlmCA6xDg1kcS+P+t9K7Buo+wNUXD5VtSxoYBRGo+XSPod30yKzVvLDTWJ1vYZEB
         OA6w==
X-Forwarded-Encrypted: i=1; AHgh+RrkUfsWpp3jr7r8MXlTQEQ/hw9Z4DsjWEe8NrKdT3I+sSfg2UEvX/ARDlg+FC6Ymq58+T/1SaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9S45De2eCwvsjarKB5hvYuSIi5mpGOCrjYoFENviD/KarD88
	09edt+2byr2tWIRlc1XQW2iA+nBmIlrZxCqMbDUV0unGRgo2YZOHIpKn3nIoQaeUUJv0ON2WrVu
	BpshG3iZuU6CbzfLIe5GDosyyS5iKnwUypoBFYjwFf5KcjrKy5F3eUCoGGbA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2203:b0:491:c51e:189c with SMTP id
 5614622812f47-4ab38691a27mr211172b6e.24.1784767171495; Wed, 22 Jul 2026
 17:39:31 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:39:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6162c3.16bfb6d0.3c48cb.0007.GAE@google.com>
Subject: [syzbot] [net?] [nfc?] WARNING in nci_rx_work
From: syzbot <syzbot+0b9d9b42dd0539b0e9fe@syzkaller.appspotmail.com>
To: davem@davemloft.net, david@ixit.cz, edumazet@google.com, horms@kernel.org, 
	krzk@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1229e2e57a5c Merge tag 'v7.2-rc3-smb3-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170c5789580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c4196ba0e33631d
dashboard link: https://syzkaller.appspot.com/bug?extid=0b9d9b42dd0539b0e9fe
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e39c7e41c516/disk-1229e2e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cb6d56cd3388/vmlinux-1229e2e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c229a44ba578/bzImage-1229e2e5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b9d9b42dd0539b0e9fe@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue nci_cmd_work on wq nfc2_nci_cmd_wq
WARNING: kernel/workqueue.c:2306 at __queue_work+0xd4a/0x10a0 kernel/workqueue.c:2305, CPU#0: kworker/u8:4/75
Modules linked in:
CPU: 0 UID: 0 PID: 75 Comm: kworker/u8:4 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/10/2026
Workqueue: nfc2_nci_rx_wq nci_rx_work
RIP: 0010:__queue_work+0xd66/0x10a0 kernel/workqueue.c:2305
Code: 49 81 c7 70 01 00 00 4c 8d 35 36 66 cd 0e 48 89 f8 48 c1 e8 03 80 3c 18 00 74 05 e8 c4 b8 a6 00 49 8b 75 18 4c 89 f7 4c 89 fa <67> 48 0f b9 3a 4c 89 e8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ef e8
RSP: 0018:ffffc900015e7998 EFLAGS: 00010046
RAX: 1ffff1100549d422 RBX: dffffc0000000000 RCX: 0000000000100000
RDX: ffff8880528c7970 RSI: ffffffff8ba1ec40 RDI: ffffffff905ab090
RBP: 0000000000000020 R08: ffff88802a4ea0ff R09: 1ffff1100549d41f
R10: dffffc0000000000 R11: ffffed100549d420 R12: 0000000000000008
R13: ffff88802a4ea0f8 R14: ffffffff905ab090 R15: ffff8880528c7970
FS:  0000000000000000(0000) GS:ffff888124f54000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b34012ff8 CR3: 00000000355ce000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2452
 nci_rx_work+0x235/0x4b0 net/nfc/nci/core.c:1579
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	49 81 c7 70 01 00 00 	add    $0x170,%r15
   7:	4c 8d 35 36 66 cd 0e 	lea    0xecd6636(%rip),%r14        # 0xecd6644
   e:	48 89 f8             	mov    %rdi,%rax
  11:	48 c1 e8 03          	shr    $0x3,%rax
  15:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  19:	74 05                	je     0x20
  1b:	e8 c4 b8 a6 00       	call   0xa6b8e4
  20:	49 8b 75 18          	mov    0x18(%r13),%rsi
  24:	4c 89 f7             	mov    %r14,%rdi
  27:	4c 89 fa             	mov    %r15,%rdx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	4c 89 e8             	mov    %r13,%rax
  32:	48 c1 e8 03          	shr    $0x3,%rax
  36:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  3a:	74 08                	je     0x44
  3c:	4c 89 ef             	mov    %r13,%rdi
  3f:	e8                   	.byte 0xe8


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
