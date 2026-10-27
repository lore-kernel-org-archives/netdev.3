Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126141;
	b=uNBmYlS/rYaWRovfQk/VrU1oCPDLTXr7IG0dBywaMO0aFXoB0dlQWlRvXHQhC6vF/7q0
	 HJGoPOFgbc9OmiB8reJXqMS7kjjFvMeq4Eg6Ov4TD9LkZ1uLqaij/nBbBW2kQu3ndvdit
	 ZZ172kp0177r69VfoSDGHyj4Is1fir4S2ZPsbBG6Tx4a0HsZLHcnpbWcwGesgMDXQtyJw
	 u3egFz+gltQZX/XcfGbHmUwYmNIpO1Atpc9UZEHsrH+UjIFN68AvXX2htjtcG18bgSgNt
	 QQ8iHMSSdM8/3e+RluCTDm+5GlYJMl7srvw9WuvVCu4jhUc9VMzUzQETJnirqJ+9iUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126141;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type:Content-Transfer-Encoding;
	bh=icU5FPIfE2ifa6n5IT2LKqpdSdDGJMCO7cWloXgDCKU=;
	b=q8CkmW4CEymRUm6F74au1Yk+FK2rWJ1o/Pst7LbnHyKf7NC0VO73YM61E4jEh1TP3An0
	 Wf0vziebyYScb4yoOhfghx9OeO8xBX1I/RYbcj91cJcKHyq0qb378W9VCCk/LhtICdbc9
	 0+mpkBzFwTnnBbyjUOZAOIQOfOIkojE4xJNuL+Ac/0cyrv6EX5vAFl6wHZfpLabsRH9d4
	 xKNzDLfDJ2MuOLu55C2/UzDwXBQCSSehoOG8msK3aJJv9hpuq8albAzj8LbxLKThMfDOZ
	 LkKzXyAYATcYVPG5bueO3XoSqJ7LdjLrU2VsF8vUKvkMWnuLMStzeMgjH6aVFv97kJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CBB606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 18:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5CBB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-54dbbf252cdso306292b6e.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793126139; x=1793730939;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icU5FPIfE2ifa6n5IT2LKqpdSdDGJMCO7cWloXgDCKU=;
        b=hPInwcJWXTNpND6rkDvTGDL62kE77crQDvBuDraf4rKjKQN4FgnG9GFHqxkRGDTrQ3
         HBvk3iL3iV8HOMqCM1zjxOHY9mX4xWAgaT8YKiKolbWqtEtOdafrqIljHFJykAEypKrX
         cSCJCx1V0lT0VVJfuDNU7oPF4eiVEYKTz06Q3b+B1rwwS1mN3IjJQ0GtGRvbnvpVk7mO
         NlavCkIqCcDpyy0snMgqyyW4mp++eylSfUrLrGBveFP6x7RljDdN8//rqsP6V5P1mRrZ
         6iRncCZxoE6kPbsAJ9ZtoYCbW3VO9EIAcbMqAsKTf+T3IwfCoNRdVUlmRnAHy9xCH9E5
         VwSg==
X-Forwarded-Encrypted: i=1; AKwUvBzZxdXbv2nBuPRaQ62UUomdUCm4r4ifGfZnnXC31uap+sa3tIrE2imCyulSubgWcUAvFRPjhok=@vger.kernel.org
X-Gm-Message-State: AFq9FYItYC1CxfMol3h1MpAGeFnN9AwDddbvAHhwIM7j/RpQfWvBmuyx
	qXax8kS+rTTXI68YHQhpO+sabzDQbaLWn5MoOCQSl5YZGYz4n+NlcEYHyHgvOVaX9cp/+Ya98JU
	xWXX8w75Q4mydf/H2Vw3alk8+ylA+7JhUhIqzyqOTvsPaG9qyFZag67M/0DU=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1822:b0:533:be44:82e with SMTP id
 5614622812f47-55c0032b4bbmr7072186b6e.40.1793126139700; Tue, 27 Oct 2026
 11:35:39 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:35:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae0eefb.47d0a7c9.33355c.007b.GAE@google.com>
Subject: [syzbot] [net?] WARNING in nsim_dev_netdevice_event
From: syzbot <syzbot+a104228f8a378b00e6ad@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    21a7f44fd076 Merge tag 'devicetree-for-7.4' of git://git.k.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D13fd8a95580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db5f7e4c9e8708c9=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3Da104228f8a378b00e=
6ad
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2ef34699400d/disk-=
21a7f44f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bb6890c72238/vmlinux-=
21a7f44f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35cd2b481e0f/bzI=
mage-21a7f44f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+a104228f8a378b00e6ad@syzkaller.appspotmail.com

=06: left promiscuous mode
P=01=06: left promiscuous mode
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
WARNING: kernel/locking/mutex.c:625 at __mutex_lock_common kernel/locking/m=
utex.c:625 [inline], CPU#1: kworker/u8:3/50
WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x132a/0x15a0 kernel/lo=
cking/mutex.c:821, CPU#1: kworker/u8:3/50
Modules linked in:
CPU: 1 UID: 0 PID: 50 Comm: kworker/u8:3 Tainted: G             L       syz=
kaller #0 PREEMPT(full)=20
Tainted: [L]=3DSOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 10/07/2026
Workqueue: netns cleanup_net
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:625 [inline]
RIP: 0010:__mutex_lock+0x1331/0x15a0 kernel/locking/mutex.c:821
Code: 23 9d 91 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 46 02 00 00 83 3d 43 35 =
9e 05 00 75 13 48 8d 3d a6 34 a1 05 48 c7 c6 e0 27 2d 8c <67> 48 0f b9 3a 9=
0 e9 1d ee ff ff 90 0f 0b 90 e9 f0 f1 ff ff 90 0f
RSP: 0018:ffffc90000ba7040 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffff888021a8be80
RDX: 0000000000000000 RSI: ffffffff8c2d27e0 RDI: ffffffff91a02350
RBP: ffffc90000ba71c8 R08: ffffffff919d23e3 R09: 1ffffffff233a47c
R10: dffffc0000000000 R11: fffffbfff233a47d R12: ffff88807c371500
R13: 0000000000000000 R14: 1ffff92000174e1c R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88812373c000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb6d95f62f8 CR3: 00000000361d6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nsim_dev_hwstats_event_unregister drivers/net/netdevsim/hwstats.c:174 [inl=
ine]
 nsim_dev_hwstats_event drivers/net/netdevsim/hwstats.c:192 [inline]
 nsim_dev_netdevice_event+0x1e8/0x830 drivers/net/netdevsim/hwstats.c:207
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:86
 call_netdevice_notifiers_info+0x8c/0x100 net/core/dev.c:2310
 call_netdevice_notifiers_extack net/core/dev.c:2351 [inline]
 call_netdevice_notifiers net/core/dev.c:2365 [inline]
 unregister_netdevice_many_notify+0x1432/0x1d80 net/core/dev.c:12697
 unregister_netdevice_many net/core/dev.c:12768 [inline]
 unregister_netdevice_queue+0x2f5/0x340 net/core/dev.c:12564
 unregister_netdevice include/linux/netdevice.h:3509 [inline]
 _cfg80211_unregister_wdev+0x1c4/0x8e0 net/wireless/core.c:1503
 ieee80211_remove_interfaces+0x49c/0x6a0 net/mac80211/iface.c:2528
 ieee80211_unregister_hw+0x5d/0x2d0 net/mac80211/main.c:1725
 mac80211_hwsim_del_radio+0x31a/0x500 drivers/net/wireless/virtual/mac80211=
_hwsim_main.c:6302
 hwsim_exit_net+0xe91/0xf50 drivers/net/wireless/virtual/mac80211_hwsim_mai=
n.c:7365
 ops_exit_list net/core/net_namespace.c:200 [inline]
 ops_undo_list+0x451/0x8f0 net/core/net_namespace.c:253
 cleanup_net+0x572/0x810 net/core/net_namespace.c:706
 process_one_work kernel/workqueue.c:3495 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	23 9d 91 48 c1 e8    	and    -0x173eb76f(%rbp),%ebx
   6:	03 0f                	add    (%rdi),%ecx
   8:	b6 04                	mov    $0x4,%dh
   a:	18 84 c0 0f 85 46 02 	sbb    %al,0x246850f(%rax,%rax,8)
  11:	00 00                	add    %al,(%rax)
  13:	83 3d 43 35 9e 05 00 	cmpl   $0x0,0x59e3543(%rip)        # 0x59e355d
  1a:	75 13                	jne    0x2f
  1c:	48 8d 3d a6 34 a1 05 	lea    0x5a134a6(%rip),%rdi        # 0x5a134c9
  23:	48 c7 c6 e0 27 2d 8c 	mov    $0xffffffff8c2d27e0,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	90                   	nop
  30:	e9 1d ee ff ff       	jmp    0xffffee52
  35:	90                   	nop
  36:	0f 0b                	ud2
  38:	90                   	nop
  39:	e9 f0 f1 ff ff       	jmp    0xfffff22e
  3e:	90                   	nop
  3f:	0f                   	.byte 0xf


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
