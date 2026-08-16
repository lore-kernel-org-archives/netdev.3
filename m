Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443383403FF
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786865365; cv=none; b=pIU1hnnllDuXID/WgtABVIDNd+79epvgZ67D8eaUyi2ovNBd/DSTuLPb5v9vcN/AqyU3oKt6DaJpIoDPe5yKQs/mMpTJtJxX9GSkqc1n2QNU6iGM7XEgHfdBzra32e0Z2YsPfO0qysodnC4CQdvW4ndedom0/V4Wr0eToQhUMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786865365; c=relaxed/simple;
	bh=WmZphvtE1BQNd8vk74XA18i5Fgu3ou3hMfWuxOjzI5M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vy28hTGM9H0sTFiwsaxXlzwCqXuCbrLlak1mJLpCj6VgiWDcA1/4aZoO+23JY1AoU+i7bLbYGKagKsfLeHx8PEmncTLVIL9Qd9Ypn/Pbwtkw3AAkJuyT5S8kaQN8IL6yWbfcnTVA1T2oHXNftgMK8ZlCtIdDNuqAnyk4MiG00Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4af9bf0f53bso2911648b6e.1
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 00:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786865363; x=1787470163;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bWBxWeN+PrBCWKECGhpw+SwY5KcGyzTXh/pPfmx183o=;
        b=HeHoUzRD/R7/Z8oSAOV9Pj8iDKKalXDD104sYPDT3g6EOsXGhQVToH0PYR/8ukrIRZ
         mBFnDLeTqjKCSVziWBdzRDHMOgBP5aGHrCQX8rYlkyxgx6GdB3BD7mK11NJSupOTas9b
         WO2lTQqjpEQLp0BRhFI/FMBWal2C0ogPoFQQW0EfUYp6WJKAKScqKGUYMBDcvcDRnzJA
         Dlp2ssNESkUQQw4P85mRJLlAH+8SY174Px/2YftswjfdBhgYRrXylYTn2UZdP2h96okR
         a7jLsXZvJJrDfrPC4C+Hf+2ObzVMAivt7mNvWyOuOW1YJOJ+REeV9pJrGLv//P8hZuZM
         I/tw==
X-Forwarded-Encrypted: i=1; AHgh+RpECH2fL8jcznqSfg7Sd+nPcAKMLi3rzjqcrmW5dUnA/xhnadWFw76gEK+KpHwwwFj6r0EmRKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxon2zBFSr0rU4Z4p85fMe0WPn35+DatRNfL8ZBX/j5NpueiRHV
	BrxceJuyAmGYPZbU10W0PR+MrYJIAj4je4U527D7hw+F5naoZGe9Lo3NEm+/J0CSegbkxWCcBU2
	nLaAtr8Ji0MVM93dWRe081GDXd1mvxuvQXgKKxVFs6rTbFCcyVD43M2NFphc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f07:b0:495:da3c:1aa with SMTP id
 5614622812f47-4b241e16cbfmr16800896b6e.16.1786865363281; Sun, 16 Aug 2026
 00:29:23 -0700 (PDT)
Date: Sun, 16 Aug 2026 00:29:23 -0700
In-Reply-To: <6a74aa44.01d0871a.3a0d52.0029.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8166d3.f7a79266.2f965f.000f.GAE@google.com>
Subject: Re: [syzbot] [intel-wired-lan?] BUG: unable to handle kernel paging
 request in e1000_get_cfg_done_82571
From: syzbot <syzbot+8ce4dba751e79facdc38@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, anthony.l.nguyen@intel.com, 
	davem@davemloft.net, edumazet@google.com, intel-wired-lan-owner@osuosl.org, 
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	przemyslaw.kitszel@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3eb40771c00a Merge tag 'soc-fixes-7.2-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1553c6c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d67342c314f228d
dashboard link: https://syzkaller.appspot.com/bug?extid=8ce4dba751e79facdc38
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c39279580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17167279580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3eb40771.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/08eda747d304/vmlinux-3eb40771.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24378ecbcb01/bzImage-3eb40771.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ce4dba751e79facdc38@syzkaller.appspotmail.com

e1000e 0000:00:03.0: The NVM Checksum Is Not Valid
BUG: unable to handle page fault for address: ffffc9000374c0b0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1c000067 P4D 1c000067 PUD 1d6a8067 PMD 2645e067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 5948 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:__er32 drivers/net/ethernet/intel/e1000e/e1000.h:604 [inline]
RIP: 0010:e1000_get_cfg_done_82571+0x68/0x150 drivers/net/ethernet/intel/e1000e/82571.c:850
Code: 00 00 ba 02 00 00 00 e8 c6 6e c5 04 31 ff 89 ee e8 3d 77 10 fb 85 ed 74 4e e8 c4 7c 10 fb 41 80 7d 00 00 75 5e 49 8b 44 24 08 <8b> 98 10 10 00 00 81 e3 00 00 04 00 31 ff 89 de e8 13 77 10 fb 85
RSP: 0018:ffffc90003737850 EFLAGS: 00010246
RAX: ffffc9000374b0a0 RBX: ffff88802c8d15b8 RCX: ffffffff86ffdd0d
RDX: ffff888024450000 RSI: ffffffff86f9f6bc RDI: ffff88802c8d15b8
RBP: 0000000000000064 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802c8d15b8
R13: ffffed100591a2b8 R14: ffff88802c8d15c0 R15: 1ffff920006e6f25
FS:  00007f474f1f86c0(0000) GS:ffff8880d5cde000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000374c0b0 CR3: 000000002793c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 e1000e_phy_hw_reset_generic+0x1f2/0x260 drivers/net/ethernet/intel/e1000e/phy.c:2167
 e1000_phy_hw_reset drivers/net/ethernet/intel/e1000e/e1000.h:542 [inline]
 e1000_probe+0x2446/0x36b0 drivers/net/ethernet/intel/e1000e/netdev.c:7725
 local_pci_probe+0xdd/0x1b0 drivers/pci/pci-driver.c:332
 pci_call_probe+0x176/0x800 drivers/pci/pci-driver.c:394
 __pci_device_probe drivers/pci/pci-driver.c:455 [inline]
 pci_device_probe+0x1cd/0x370 drivers/pci/pci-driver.c:489
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 device_driver_attach+0xd1/0x220 drivers/base/dd.c:1203
 bind_store+0xf4/0x190 drivers/base/bus.c:267
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f474e39e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f474f1f8028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f474e625fa0 RCX: 00007f474e39e0d9
RDX: 000000000000000d RSI: 0000200000000240 RDI: 0000000000000005
RBP: 00007f474e435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f474e626038 R14: 00007f474e625fa0 R15: 00007fff59364b48
 </TASK>
Modules linked in:
CR2: ffffc9000374c0b0
---[ end trace 0000000000000000 ]---
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:__er32 drivers/net/ethernet/intel/e1000e/e1000.h:604 [inline]
RIP: 0010:e1000_get_cfg_done_82571+0x68/0x150 drivers/net/ethernet/intel/e1000e/82571.c:850
Code: 00 00 ba 02 00 00 00 e8 c6 6e c5 04 31 ff 89 ee e8 3d 77 10 fb 85 ed 74 4e e8 c4 7c 10 fb 41 80 7d 00 00 75 5e 49 8b 44 24 08 <8b> 98 10 10 00 00 81 e3 00 00 04 00 31 ff 89 de e8 13 77 10 fb 85
RSP: 0018:ffffc90003737850 EFLAGS: 00010246
RAX: ffffc9000374b0a0 RBX: ffff88802c8d15b8 RCX: ffffffff86ffdd0d
RDX: ffff888024450000 RSI: ffffffff86f9f6bc RDI: ffff88802c8d15b8
RBP: 0000000000000064 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802c8d15b8
R13: ffffed100591a2b8 R14: ffff88802c8d15c0 R15: 1ffff920006e6f25
FS:  00007f474f1f86c0(0000) GS:ffff8880d5cde000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000374c0b0 CR3: 000000002793c000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	ba 02 00 00 00       	mov    $0x2,%edx
   7:	e8 c6 6e c5 04       	call   0x4c56ed2
   c:	31 ff                	xor    %edi,%edi
   e:	89 ee                	mov    %ebp,%esi
  10:	e8 3d 77 10 fb       	call   0xfb107752
  15:	85 ed                	test   %ebp,%ebp
  17:	74 4e                	je     0x67
  19:	e8 c4 7c 10 fb       	call   0xfb107ce2
  1e:	41 80 7d 00 00       	cmpb   $0x0,0x0(%r13)
  23:	75 5e                	jne    0x83
  25:	49 8b 44 24 08       	mov    0x8(%r12),%rax
* 2a:	8b 98 10 10 00 00    	mov    0x1010(%rax),%ebx <-- trapping instruction
  30:	81 e3 00 00 04 00    	and    $0x40000,%ebx
  36:	31 ff                	xor    %edi,%edi
  38:	89 de                	mov    %ebx,%esi
  3a:	e8 13 77 10 fb       	call   0xfb107752
  3f:	85                   	.byte 0x85


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
