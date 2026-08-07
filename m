Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24237DEBC
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786080494; cv=none; b=DxYBBAnPa8IGLupG4NCxmnYh7HPIlb7sX9iqGPkzylp0ZWrBFmNxzvJLDMxulve8nTviymHjMkxH3WfuY6w4av4cVByxf3YaJqDxTN5vczXQqamJUQkjYja8RAwpfzDrto6ETCDIKnV8OaB95ZH/j3uvOaZduiSUgjLwqsxL2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786080494; c=relaxed/simple;
	bh=qFvp4uTofHAGTkfOnJ0T+NM7iIzp2wiRIOn9DUfpOUw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=rHxIEFQm1Jb7AHxf1eQkDgKxdvu0xnFbuAwdKSdWfUXNLAlTGXmKGAgwfIuVa4CVkdSvaGWRzTQq9KGubyvLVsqKef2IiJRSDbfdQmY6Q9PL2fDJmtKBi2RSwyqirVTCYL4unrm6cipxlVqnkBZz8cAb9yyEEpwDt2wnG2a9qhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-49001defc4dso3067409b6e.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 22:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786080490; x=1786685290;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TvTYXt+JOaan37lriLTI6Cyp2pGjz3SyqEWd9qAwVQU=;
        b=Ri+NMTScJvJXfJMBvLefTI6Mm35GAf//FawXV9JTgO0Y1fVzQCYxtr7rOrcOhVkAEg
         6wfbt1+jh5weWjPEMOxOi/Bv2fVjG3JXww121jBLIhqBgl4ZHvPJYdh2D+E2XAy8ekj+
         X64DHjbbnOQaRLKcjSgKqQlbM7Wlm+0BcKePB13uQRM8/Wwq3ZHFAxtbVEHd0SLQIf4M
         Xk8fv8tVNRM2MUTZvkeqfUe8US+6XbK+9hP/qd5Im8v/X0U+0ybd9QLzzsq8NP3lcFYl
         AGXiOxpsOIz4WLx4PGBfBWMqapxGlvx/+hL8/pdYQ9mSrEWKoWSRYaAd5gKXMVEgPNrE
         fs0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoabiZOFf1ByjKk4damBapcQd0V+rmEKoVaeKST4vPg8Wn0kHJEyyDRB/AaXfDnPfOijHmrkng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2W963xxuKsK03ZlaVlzEzDHqjcnR2ZaPXI2FyiPezOdW0P/VK
	zwxf7spmnb/uzYfAR8R0uUPoOuILeAMdg/I0F+Rsj2ri/07CcAAwtktGKtSJBZeXFsG0YGK81Ou
	1fot8V9sf7iMDDwmVGzbIjRivGBS0ip/R+QlzMNLfRxTvcc8JJijTqOQSuj4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c89:b0:6ae:4ff6:8d99 with SMTP id
 006d021491bc7-6ae96f658cemr10227803eaf.26.1786080490002; Thu, 06 Aug 2026
 22:28:10 -0700 (PDT)
Date: Thu, 06 Aug 2026 22:28:09 -0700
In-Reply-To: <20260807002250.1817498-1-antonio@openvpn.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a756ce9.01d0871a.3a0d52.003b.GAE@google.com>
Subject: [syzbot ci] Re: pull request: fixes for ovpn 2026-08-07
From: syzbot ci <syzbot+cifb58fcbd8413e765@syzkaller.appspotmail.com>
To: andrew@lunn.ch, antonio@openvpn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, ralf@mandelbit.com, sd@queasysnail.net
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] pull request: fixes for ovpn 2026-08-07
https://lore.kernel.org/all/20260807002250.1817498-1-antonio@openvpn.net
* [PATCH net 1/4] ovpn: fix NULL dereference when killing missing key
* [PATCH net 2/4] ovpn: finish crypto callback cleanup before peer release
* [PATCH net 3/4] ovpn: run deferred work on a module-owned workqueue
* [PATCH net 4/4] ovpn: defer key slot crypto freeing to workqueue

and found the following issue:
WARNING in __alloc_workqueue

Full report is available here:
https://ci.syzbot.org/series/a46f06c7-f8d8-4053-a746-91498a46c290

***

WARNING in __alloc_workqueue

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      594d905195024b228c962627ae5ae7c17bd582a4
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/cc426b49-07b7-496e-badf-5b0646780dd0/config

usbcore: registered new interface driver udl
bochs-drm 0000:00:01.0: vgaarb: deactivate vga console
[drm] Found bochs VGA, ID 0xb0c5.
[drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
[drm] Initialized bochs-drm 1.0.0 for 0000:00:01.0 on minor 2
bochs-drm 0000:00:01.0: [drm] fb1: bochs-drmdrmfb frame buffer device
usbcore: registered new interface driver gm12u320
usbcore: registered new interface driver gud
brd: module loaded
loop: module loaded
zram: Added device: zram0
null_blk: disk nullb0 created
null_blk: module loaded
Guest personality initialized and is inactive
VMCI host device registered (name=vmci, major=10, minor=267)
Initialized host personality
usbcore: registered new interface driver rtsx_usb
lpc_ich 0000:00:1f.0: I/O space for GPIO uninitialized
usbcore: registered new interface driver viperboard
usbcore: registered new interface driver dln2
usbcore: registered new interface driver pn533_usb
nfcsim 0.2 initialized
usbcore: registered new interface driver port100
usbcore: registered new interface driver nfcmrvl
Loading iSCSI transport class v2.0-870.
st: Version 20160209, fixed bufsize 32768, s/g segs 256
ACPI: \_SB_.GSIA: Enabled at IRQ 16
ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
ahci 0000:00:1f.2: flags: 64bit ncq only 
scsi host0: ahci
scsi host1: ahci
scsi host2: ahci
scsi host3: ahci
scsi host4: ahci
scsi host5: ahci
ata1: SATA max UDMA/133 abar m4096@0xfebf2000 port 0xfebf2100 irq 26 lpm-pol 1
ata2: SATA max UDMA/133 abar m4096@0xfebf2000 port 0xfebf2180 irq 26 lpm-pol 1
ata3: SATA max UDMA/133 abar m4096@0xfebf2000 port 0xfebf2200 irq 26 lpm-pol 1
ata4: SATA max UDMA/133 abar m4096@0xfebf2000 port 0xfebf2280 irq 26 lpm-pol 1
ata5: SATA max UDMA/133 abar m4096@0xfebf2000 port 0xfebf2300 irq 26 lpm-pol 1
ata6: SATA max UDMA/133 abar m4096@0xfebf2000 port 0xfebf2380 irq 26 lpm-pol 1
Rounding down aligned max_sectors from 4294967295 to 4294967288
db_root: cannot open: /etc/target
slram: not enough parameters.
ftl_cs: FTL header not found.
wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
------------[ cut here ]------------
workqueue: ovpn is using neither WQ_PERCPU or WQ_UNBOUND. Setting WQ_PERCPU.
WARNING: kernel/workqueue.c:5852 at __alloc_workqueue+0x1cf5/0x2060, CPU#0: swapper/0/1
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__alloc_workqueue+0x1cf8/0x2060
Code: 38 00 e9 59 f9 ff ff e8 46 96 38 00 e9 26 fb ff ff e8 3c 96 38 00 e9 a7 fb ff ff e8 32 96 38 00 48 8d 3d fb a1 cc 0e 4c 89 f6 <67> 48 0f b9 3a 81 cd 00 01 00 00 e9 a7 e5 ff ff e8 13 96 38 00 48
RSP: 0000:ffffc900000677a8 EFLAGS: 00010293
RAX: ffffffff818e8c5e RBX: 0000000000000000 RCX: ffff888102a95940
RDX: 0000000000000000 RSI: ffff88810c4cf570 RDI: ffffffff905b2e60
RBP: 0000000000000000 R08: ffff888102a95940 R09: 0000000000000002
R10: 0000000000000102 R11: 0000000000000000 R12: ffffc900000678c0
R13: ffff88810c4cf400 R14: ffff88810c4cf570 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88818d934000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000e946000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 alloc_workqueue_noprof+0xe3/0x210
 ovpn_init+0x1b/0xb0
 do_one_initcall+0x250/0x870
 do_initcall_level+0x10a/0x1a0
 do_initcalls+0x59/0xa0
 kernel_init_freeable+0x29d/0x3e0
 kernel_init+0x1d/0x1d0
 ret_from_fork+0x514/0xb70
 ret_from_fork_asm+0x1a/0x30
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.
