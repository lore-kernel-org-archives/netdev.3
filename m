Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BA651C348
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 23:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119554; cv=none; b=nDflGjwscRyVd0AIbvPCh6YYMeNYg+pNNvJIaxlsfrBvOXPStBtHAQUFbVnuM8IdWR3laE8NYD8r+dfj3J7fpZ91Tl3Ov6tU8CPw0JadP/ek/r9BchGZOaf6y/WRNOZ3tfVi9BIm68wXcUk37u32ldvGeHgacbsVIfaOif7e8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119554; c=relaxed/simple;
	bh=uH7vxHkVKKcpii8qgs07msHfGgkJGl9tsudcHAs05AY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hny1tvsl8+XIxqhwXhQNjAWoLAOuE/j3m7nwiJaZRbAswO907LyERxPAYesiYivLS+hr84O8wctdJV6m5+dmbBWaR7DkXIbUWV8hK2AtWnjBwCFBiHnt2e6Asxk5yFkpHX2grfU+gvAzTKpY4P5P0aUTC/Knlka8J0zO+p/OOus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-4d3834b9ed5so114946b6e.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790119530; x=1790724330;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kl2ZXxQAeH8BEDvdB3GjRz7M3jT3/RNYuB+XsUsBvjE=;
        b=xkLGAPzAtBYrfacKJf2SaL2B0z3KrrJwvsFLpkOuJwEP/Gcqv8UBJn8/R9YsRF3G+3
         hlgmkAUNFH/2KlSfQOZMr7qfRxolfPyEe52u6Lw/L4U9O2Qxiz6MbdZ50SJeqoJu9GIW
         j7zEJ7kWt8pM+5wtNVS7BxeFRw6Ba8takiOZmqwIIDcjtvxenY1ej2TLc32IrIksu0If
         iuU9W1eUjmDXlGL/Flfmo8tmAqTtBe1TQgsdF+X+NtU4I9mS1zfp6UU3pwvwSn9OX2Bj
         IsS7H1NbjjvCcxjWD1MEk12wFjj2eiUV7R+euXywbiXLe2nlcG04GWxLaDdkO8D/NdRr
         C4lg==
X-Forwarded-Encrypted: i=1; AKwUvBx36uKXgBnpCJGizxgIpcFxDe49cuaTTH7wqMhDRUt3aoZsOgbjunwmuUD2/j21pZ1l1PBduqo=@vger.kernel.org
X-Gm-Message-State: AFuF++mrqvqk9lT4MpmLOAa0h7p7oq7kUdapU0n261HDMZ/eerPhP91r
	EM5z78Qg1jtofH6u6QhRwnHgZoroaJ+vn+8ckb18SPoOrCQViUpICt8p7o11u9bYRlY9dzhnWF3
	UQO6dhBN9EIu5FuqRKs4HYAmqGHtS0bMbl5Cuv443tsC9lo1CZpfIgodWVDY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c8e:b0:6c2:21ab:ec92 with SMTP id
 006d021491bc7-6d2d034466amr808545eaf.30.1790119530008; Tue, 22 Sep 2026
 16:25:30 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:25:29 -0700
In-Reply-To: <6a85042a.4d75e56a.c9a88.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab30e69.3179f8cd.1e36b2.002c.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in vmxnet3_probe_device
From: syzbot <syzbot+e39090bc9b3cf457717f@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, 
	bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, ronak.doshi@broadcom.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c4e9f74da438 Merge tag 'v7.3-p5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13688405580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b924f079099ba6e
dashboard link: https://syzkaller.appspot.com/bug?extid=e39090bc9b3cf457717f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c1b4c9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144d7805580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c4e9f74d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1fb74cbe085d/vmlinux-c4e9f74d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee8335337423/bzImage-c4e9f74d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e39090bc9b3cf457717f@syzkaller.appspotmail.com

------------[ cut here ]------------
vmxnet3 0000:00:00.0: rejecting DMA map of vmalloc memory
WARNING: ./include/linux/dma-mapping.h:532 at dma_map_single_attrs include/linux/dma-mapping.h:531 [inline], CPU#0: syz.0.17/5475
WARNING: ./include/linux/dma-mapping.h:532 at vmxnet3_probe_device+0xab8/0x2e70 drivers/net/vmxnet3/vmxnet3_drv.c:4047, CPU#0: syz.0.17/5475
Modules linked in:
CPU: 0 UID: 0 PID: 5475 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:dma_map_single_attrs include/linux/dma-mapping.h:531 [inline]
RIP: 0010:vmxnet3_probe_device+0xb32/0x2e70 drivers/net/vmxnet3/vmxnet3_drv.c:4047
Code: 89 ff e8 e1 b3 f6 fa 4d 8b 2f eb 15 e8 37 0c 85 fa 41 bf 04 00 00 00 41 b6 03 eb 7d e8 27 0c 85 fa 48 89 df 4c 89 f6 4c 89 ea <67> 48 0f b9 3a 48 8b 04 24 48 05 88 c4 00 00 49 89 c6 48 c1 e8 03
RSP: 0018:ffffc900046777c0 EFLAGS: 00010246
RAX: 1ffff11003ece01a RBX: ffffffff9087fdf0 RCX: dffffc0000000000
RDX: ffff88801f3c32a0 RSI: ffffffff8fa99b40 RDI: ffffffff9087fdf0
RBP: ffffc90004677950 R08: 0000000000000003 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1003ece0b3 R12: 0000000000000001
R13: ffff88801f3c32a0 R14: ffffffff8fa99b40 R15: ffff88801f6700d0
FS:  00007f931f3316c0(0000) GS:ffff88808c2c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000043cf1000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 local_pci_probe drivers/pci/pci-driver.c:354 [inline]
 pci_call_probe drivers/pci/pci-driver.c:416 [inline]
 __pci_device_probe drivers/pci/pci-driver.c:478 [inline]
 pci_device_probe+0x48e/0xd10 drivers/pci/pci-driver.c:512
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 device_driver_attach+0xe0/0x1d0 drivers/base/dd.c:1203
 bind_store+0x1d0/0x220 drivers/base/bus.c:267
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f931e39e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f931f331028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f931e625fa0 RCX: 00007f931e39e159
RDX: 000000000000000c RSI: 0000200000000240 RDI: 0000000000000006
RBP: 00007f931f331090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f931e626038 R14: 00007f931e625fa0 R15: 00007fff4d3aed68
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 ff                	mov    %edi,%edi
   2:	e8 e1 b3 f6 fa       	call   0xfaf6b3e8
   7:	4d 8b 2f             	mov    (%r15),%r13
   a:	eb 15                	jmp    0x21
   c:	e8 37 0c 85 fa       	call   0xfa850c48
  11:	41 bf 04 00 00 00    	mov    $0x4,%r15d
  17:	41 b6 03             	mov    $0x3,%r14b
  1a:	eb 7d                	jmp    0x99
  1c:	e8 27 0c 85 fa       	call   0xfa850c48
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
