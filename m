Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD146EF62
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655134; cv=none; b=lhNCmq+5O+VWXg0+INBuul1pPmDdfNanqSZtdMGCSwbdfgmjCZqro3b2ZRxDDhhcqiqZDWe+Ko65uriiipQTu6jccqlDS1urWWIB7xGSR8SALWhBWHTBhGphOtkjfkbslwwrw1yryXdWGWuPUL9Ab1sEaE4QTDWA/FSq97lT9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655134; c=relaxed/simple;
	bh=RzEhLitbuFE5c49mic/FxVJN3KkaVMCXjL2DM+xyRv4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j6A+5T6Jz1cW5cp16TCAE1aTbBmo9V3tbqXXL3BRR7gCLKg/ccE5i1lMCykjJBSwfd0Jlwi8Sj7BcsazQlhQ4mTZRuhml+mHvk9bpNEmofnBrbCyPEizzWb7kHPvH4XfonCtgqjO7AFdm6i+EZdT99ZSRaj4XSQpg2I8xBxKO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6ae4622d842so271296eaf.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 14:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786655130; x=1787259930;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g6AkYXzHt3HDrsgn/d6vZ9xWa23uiub/SG2FBKrx1Ak=;
        b=PjY8odphwXVLAmmMYSZHYlgrfuA+9YWUcTMnPj1rAp3snfDxTDsK3Yma1M2SQdiKvB
         8WGk3r/64lGAH/nB+VegGNRWqv688KSelMma3UZTYv62ud240z24hhYgcrynRL+y+EFF
         qsfnPiN9Cs90/PFKLPXGUSaDYUIQwtnqAfiW2kZxQR+JXCuUVfgzET4gDqEj0ldlrEaA
         wFJu6MS0az0rX7C4hB6CuRRys3X6fKK1HLhY1GcqpeIciUTJLB9XhBEQAL0lonJP1O5W
         N/AAeR9XSNu3YX3P4pO1izbBUIQoMRvpwea4pLVLNvSwS4kbu/L4Ly0WzEeodna2kAX2
         sHUA==
X-Forwarded-Encrypted: i=1; AHgh+RpIRUpYqPivEfA+vaDSTHTac8MkWM7VkRf1BZ6dalZ9AN/FN5ne6EvqWQfOsLZ7GHFAH+w9NGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzdCH5t72dRTEhzfG+WuDbOCqmE0UvSSBCtM+IJ1rATMXHPRpi
	dmxVr7kWhsPom1tYYQcmWaWBu9qG9qsI3IF41sB8KMrQC1NxkX5LdlwhGIH00peSBCHTSM7pWRl
	55wxAD0jPc0SfyXIaiPdy5qmpymG5t4UAbvmSxntsdv8x1g0AX5OXJrHyjGU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81c8:b0:6b0:ace7:c413 with SMTP id
 006d021491bc7-6b0d5fd3426mr1361902eaf.6.1786655130674; Thu, 13 Aug 2026
 14:05:30 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:05:30 -0700
In-Reply-To: <699fbc78.050a0220.1cd54b.000b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7e319a.ec5dc6cc.21cb3f.00bb.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_set_active_links (3)
From: syzbot <syzbot+582469b3a9ef5f13606b@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3aa1dcaa4f6f Revert "wifi: mt76: Disable napi when removin..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f09c79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=582469b3a9ef5f13606b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15747225580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+582469b3a9ef5f13606b@syzkaller.appspotmail.com

------------[ cut here ]------------
sta0: Failed check-sdata-in-driver check, flags: 0x0
WARNING: net/mac80211/driver-ops.h:1723 at drv_can_activate_links net/mac80211/driver-ops.h:1723 [inline], CPU#0: kworker/u33:4/93
WARNING: net/mac80211/driver-ops.h:1723 at ieee80211_set_active_links+0x2d0/0x970 net/mac80211/link.c:651, CPU#0: kworker/u33:4/93
Modules linked in:
CPU: 0 UID: 0 PID: 93 Comm: kworker/u33:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:drv_can_activate_links net/mac80211/driver-ops.h:1723 [inline]
RIP: 0010:ieee80211_set_active_links+0x2d7/0x970 net/mac80211/link.c:651
Code: 05 00 00 e8 5b de da f6 48 8b 34 24 48 81 c6 20 01 00 00 48 89 34 24 e8 47 de da f6 48 8d 3d e0 87 03 06 48 8b 34 24 44 89 fa <67> 48 0f b9 3a e9 e0 fe ff ff e8 2a de da f6 0f b7 c5 4c 8d bb 50
RSP: 0018:ffffc9000165faf8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888038876c70 RCX: ffffffff8b2f94de
RDX: 0000000000000000 RSI: ffff888038874120 RDI: ffffffff91331d20
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888038875928
R13: 0000000000000000 R14: ffff888101a90f40 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880d5de9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562bad7c5000 CR3: 000000000e994000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ieee80211_if_parse_active_links+0xbb/0x120 net/mac80211/debugfs_netdev.c:732
 wiphy_locked_debugfs_write_work+0xe6/0x1c0 net/wireless/debugfs.c:248
 cfg80211_wiphy_work+0x2b7/0x550 net/wireless/core.c:538
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	e8 5b de da f6       	call   0xf6dade62
   7:	48 8b 34 24          	mov    (%rsp),%rsi
   b:	48 81 c6 20 01 00 00 	add    $0x120,%rsi
  12:	48 89 34 24          	mov    %rsi,(%rsp)
  16:	e8 47 de da f6       	call   0xf6dade62
  1b:	48 8d 3d e0 87 03 06 	lea    0x60387e0(%rip),%rdi        # 0x6038802
  22:	48 8b 34 24          	mov    (%rsp),%rsi
  26:	44 89 fa             	mov    %r15d,%edx
* 29:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2e:	e9 e0 fe ff ff       	jmp    0xffffff13
  33:	e8 2a de da f6       	call   0xf6dade62
  38:	0f b7 c5             	movzwl %bp,%eax
  3b:	4c                   	rex.WR
  3c:	8d                   	.byte 0x8d
  3d:	bb                   	.byte 0xbb
  3e:	50                   	push   %rax


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
