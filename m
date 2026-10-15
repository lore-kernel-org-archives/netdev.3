Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB4F5237B7
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068280; cv=none; b=E3MQwV2dTzmotRy1syjZS9gXtm/Pv8cj9gayFAFEds5DY2br0Ij6tXZGR5hRvsMwI1+Y1yQetjFqfq2dx8DRtLNwpY4b/XQT5F+5OQzevQUc/1L7ETWkYRGAhl8iVAC0mm/w1Fm/6ZEECiGyRkliX1zI9uIWqEAGRoT2o+08A0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068280; c=relaxed/simple;
	bh=5qhaWzhdS3osLaGeSAZyD/YR16YDXoXP1Hs+7UcmpXQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JKa1l/j66qpTLeWTp3c5Ks0xB0NQ5Tz9TRARosiPmE6aJAuRRiCaJyw11y2cU3Lhid5xcKNwr5t9UwKFYl7S9opekzDbYMW+7/ycV1bCJrUI2HihCRZxBaW9Q/b0FpI4r/536a0EhqhcN9QSveeuGfqcpxvdWz4/pSqqK19LsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c307941971so7768067b6e.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068278; x=1792673078;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hE3+QeYBz3abijvNNrapvmbBeHvYU9X5O/L1CcRTiDs=;
        b=OtyTDQ2FT0SVxyT6aB9I6c1e9a+yKmsJnyfzuq73dpi6N3seTnDfX/mYRBZJPQMFSO
         z96skbktlySKSzjY9kC40aKS0Dr75w78IsLb0+slBEJqOF44rZAYwiiGgcr2cNWgv419
         6sFJD6t9yswna5nZd1EP20FxijQaFCrFZQIMt5Pwp2wo8cFzSPbx2n+b+jaf34XMkJg1
         wsZiYgWF1qPP4bXEzaSms3hJ7cyic1S4tTm7BSfiXwzhFMaXwKAoKAEimivTpIp6MGu8
         yrfvgLXvcx1H2AIlR4SRilR69KHtLcCWooWqU+6gEGf/VM6ZSKBezk/VHCdm4dpMff2p
         bqHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOoJ2ca2zf8qsft44r/ncFGf5XVj5ct+hUfAXejPY/RABH2M9Na2Go51NRK8caR/OERdcm2B8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxh9uP8e80yLlyePKTH4h0wRtYM3R728lQSB+37IMjn8CxZaJH
	5PXz3aMH7KYhm7MaFXj5qVNugsgRfIvJ+RulBtTlJOktXOOmH8Q+F8npktObQuoFzBgo0cnWiut
	CtDSN1q3frzWoUqP+Gsa3woi9kEtf48YSvoCcmJ8S3DC0/j37vSK1lww5mX8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1310:b0:4c4:5f5b:6918 with SMTP id
 5614622812f47-50c5237ca39mr16065006b6e.16.1792068277935; Thu, 15 Oct 2026
 05:44:37 -0700 (PDT)
Date: Thu, 15 Oct 2026 05:44:37 -0700
In-Reply-To: <6ac82420.a150a118.27e199.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad0cab5.5f317f00.247b6.0069.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in vmxnet3_probe_device (2)
From: syzbot <syzbot+8eed6f83440ecdaf4be6@syzkaller.appspotmail.com>
To: andrew@lunn.ch, bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, ronak.doshi@broadcom.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0fcb05b72344 Merge tag 'libcrypto-fixes-for-linus' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16328171580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ccb65e03706547e
dashboard link: https://syzkaller.appspot.com/bug?extid=8eed6f83440ecdaf4be6
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1209b29c580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8eed6f83440ecdaf4be6@syzkaller.appspotmail.com

------------[ cut here ]------------
vmxnet3 0000:00:07.0: rejecting DMA map of vmalloc memory
WARNING: ./include/linux/dma-mapping.h:532 at dma_map_single_attrs include/linux/dma-mapping.h:531 [inline], CPU#0: syz-executor621/5600
WARNING: ./include/linux/dma-mapping.h:532 at vmxnet3_probe_device+0xab8/0x2e70 drivers/net/vmxnet3/vmxnet3_drv.c:4047, CPU#0: syz-executor621/5600
Modules linked in:
CPU: 0 UID: 0 PID: 5600 Comm: syz-executor621 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:dma_map_single_attrs include/linux/dma-mapping.h:531 [inline]
RIP: 0010:vmxnet3_probe_device+0xb32/0x2e70 drivers/net/vmxnet3/vmxnet3_drv.c:4047
Code: 89 ff e8 31 23 f6 fa 4d 8b 2f eb 15 e8 f7 a3 83 fa 41 bf 04 00 00 00 41 b6 03 eb 7d e8 e7 a3 83 fa 48 89 df 4c 89 f6 4c 89 ea <67> 48 0f b9 3a 48 8b 04 24 48 05 88 c4 00 00 49 89 c6 48 c1 e8 03
RSP: 0018:ffffc900047a75e0 EFLAGS: 00010246
RAX: 1ffff110061ea41a RBX: ffffffff91882270 RCX: dffffc0000000000
RDX: ffff888030efd880 RSI: ffffffff90a9b2c0 RDI: ffffffff91882270
RBP: ffffc900047a7770 R08: 0000000000000003 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed10061ea4b3 R12: 0000000000000001
R13: ffff888030efd880 R14: ffffffff90a9b2c0 R15: ffff888030f520d0
FS:  00005555736d9400(0000) GS:ffff88808b0b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f97b57c8330 CR3: 00000000454d9000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 local_pci_probe drivers/pci/pci-driver.c:354 [inline]
 pci_call_probe drivers/pci/pci-driver.c:416 [inline]
 __pci_device_probe drivers/pci/pci-driver.c:478 [inline]
 pci_device_probe+0x48e/0xd10 drivers/pci/pci-driver.c:512
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __driver_attach+0x339/0x600 drivers/base/dd.c:1292
 bus_for_each_dev+0x23b/0x2c0 drivers/base/bus.c:383
 do_pci_add_dynid drivers/pci/pci-driver.c:70 [inline]
 new_id_store+0xb8f/0xc40 drivers/pci/pci-driver.c:272
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f97b57d02f7
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffe613544f0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00005555736d9400 RCX: 00007f97b57d02f7
RDX: 000000000000000d RSI: 00007ffe613545a0 RDI: 0000000000000003
RBP: 00007f97b580b2c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe613545a0
R13: 0000000000000002 R14: 00007ffe61354580 R15: 0000000000000002
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 ff                	mov    %edi,%edi
   2:	e8 31 23 f6 fa       	call   0xfaf62338
   7:	4d 8b 2f             	mov    (%r15),%r13
   a:	eb 15                	jmp    0x21
   c:	e8 f7 a3 83 fa       	call   0xfa83a408
  11:	41 bf 04 00 00 00    	mov    $0x4,%r15d
  17:	41 b6 03             	mov    $0x3,%r14b
  1a:	eb 7d                	jmp    0x99
  1c:	e8 e7 a3 83 fa       	call   0xfa83a408
  21:	48 89 df             	mov    %rbx,%rdi
  24:	4c 89 f6             	mov    %r14,%rsi
  27:	4c 89 ea             	mov    %r13,%rdx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 8b 04 24          	mov    (%rsp),%rax
  33:	48 05 88 c4 00 00    	add    $0xc488,%rax
  39:	49 89 c6             	mov    %rax,%r14
  3c:	48 c1 e8 03          	shr    $0x3,%rax


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
