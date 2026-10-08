Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB1B19CD0A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791501346; cv=none; b=levXuLwCaxAhu03RMw9sSjdjc52K34iKw8qAs/FVNobMTVhYXni4h8bbjfw8uWwcnLurVuIiEmT1E7KwELaOhi8Dj2EfC1XPoY4KIjyjfsMzEu38yF1KLECpAioDL8OwG9eUru7q0yXhUyCj4L9bSqOI8KimnaC9vyIpiMiNyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791501346; c=relaxed/simple;
	bh=Lps8QlBz1qe2XErX0QpY7ac/a62Q252JM39AXWx00bk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pjgs+gGsO4MFKxOOQtH0pgCqsRLPF1bGnZ6oFeXXrounbvlrLSYJHn1I1s2tJsxMUPozP9TVjzCesgwhroQVGmuUNfq573Wwrq1KBZFHVjIvxq+2NT7VZUj+1vKqRv54rAIQyAiOwDAUPASD5rHiT0Rh9gVZPouZkwhwT2S/OCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4ab8b4887d4so5003220b6e.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 16:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791501344; x=1792106144;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uHd0Fh8ut3hmPf+EEeZiPFVKoeqTQDsUJUXgJqUE+nY=;
        b=obYUDRzsK3Ayb4+dgwNpuCJaFyJyFmB+CUDycKU9a3jzW4w72wAXpewxu1Rd3n4/LO
         mknGUA89P8gJsGdit2bCHPGNWCAe/r3qQIT/1/2oOr/Ock1l6LwdlXAw3wM6u0PQUM3W
         jHwl8QqkuPqLCj0YDJy1las4aMjythnVweJyArvsFehEFbTYCiHz/2//BgIg5OLPDlwh
         Q0Xi2YyO9TmphFV66sweQq0aEQ8qZE/xjDmjquVG8acQzdZ6AAAssOIFyleekX4OPXXL
         85w0k3eXIlk8v8SN7jGATGnjMwf6fw5nC6KYdOXXL0vkg85Jzh6AEpwun7ansp/hjSNV
         1G9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzVgLDg1Mo2xpiV0vY5E5/bpKhmgMxTRF1opnq/KzamO9n/YaK5H1vIQjR1peu3eOeledANJLA=@vger.kernel.org
X-Gm-Message-State: AFuF++kbFql5jCwCFg9N7nMdPDzGSbWzZbCBAfTIokb7jlI98CA7H5MU
	qBpYXgRXevPk6FURdwP0y1L9RefASzjOT+rh4d69quRFHk2l8RSIfNh+0W+up5bDnE+etCi1OZC
	eJaz5WE85w53/FVHI5i+UMDo5n4gqI+64SjDNFbfHiPdBbN3d4u9DyMQfJNc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:508c:b0:4b9:e5fa:8a14 with SMTP id
 5614622812f47-50c509541b4mr182482b6e.25.1791501344020; Thu, 08 Oct 2026
 16:15:44 -0700 (PDT)
Date: Thu, 08 Oct 2026 16:15:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac82420.a150a118.27e199.001f.GAE@google.com>
Subject: [syzbot] [net?] WARNING in vmxnet3_probe_device (2)
From: syzbot <syzbot+8eed6f83440ecdaf4be6@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, bcm-kernel-feedback-list@broadcom.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	ronak.doshi@broadcom.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b63ef2d55f2 Merge tag 'for-7.3-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130dc00d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1b274ca9837366
dashboard link: https://syzkaller.appspot.com/bug?extid=8eed6f83440ecdaf4be6
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-7b63ef2d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/673ec6e10d5d/vmlinux-7b63ef2d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8a9e8d61edce/bzImage-7b63ef2d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8eed6f83440ecdaf4be6@syzkaller.appspotmail.com

------------[ cut here ]------------
vmxnet3 0000:00:00.0: rejecting DMA map of vmalloc memory
WARNING: ./include/linux/dma-mapping.h:532 at dma_map_single_attrs include/linux/dma-mapping.h:531 [inline], CPU#0: syz.0.0/5317
WARNING: ./include/linux/dma-mapping.h:532 at vmxnet3_probe_device+0xab8/0x2e70 drivers/net/vmxnet3/vmxnet3_drv.c:4047, CPU#0: syz.0.0/5317
Modules linked in:
CPU: 0 UID: 0 PID: 5317 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:dma_map_single_attrs include/linux/dma-mapping.h:531 [inline]
RIP: 0010:vmxnet3_probe_device+0xb32/0x2e70 drivers/net/vmxnet3/vmxnet3_drv.c:4047
Code: 89 ff e8 81 3f f6 fa 4d 8b 2f eb 15 e8 47 bd 83 fa 41 bf 04 00 00 00 41 b6 03 eb 7d e8 37 bd 83 fa 48 89 df 4c 89 f6 4c 89 ea <67> 48 0f b9 3a 48 8b 04 24 48 05 88 c4 00 00 49 89 c6 48 c1 e8 03
RSP: 0018:ffffc9000e5f77c0 EFLAGS: 00010246
RAX: 1ffff1100004141a RBX: ffffffff91881d70 RCX: dffffc0000000000
RDX: ffff888000bca960 RSI: ffffffff90a9b020 RDI: ffffffff91881d70
RBP: ffffc9000e5f7950 R08: 0000000000000003 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed10000414b3 R12: 0000000000000001
R13: ffff888000bca960 R14: ffffffff90a9b020 R15: ffff88800020a0d0
FS:  00007f8c16ac66c0(0000) GS:ffff88808b0b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8c1695d9d0 CR3: 0000000013a35000 CR4: 0000000000352ef0
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
RIP: 0033:0x7f8c15b9e199
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8c16ac5fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f8c15e25fa0 RCX: 00007f8c15b9e199
RDX: 000000000000000c RSI: 0000200000000240 RDI: 0000000000000006
RBP: 00007f8c16ac6050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f8c15e26038 R14: 00007f8c15e25fa0 R15: 00007ffcf58e7438
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 ff                	mov    %edi,%edi
   2:	e8 81 3f f6 fa       	call   0xfaf63f88
   7:	4d 8b 2f             	mov    (%r15),%r13
   a:	eb 15                	jmp    0x21
   c:	e8 47 bd 83 fa       	call   0xfa83bd58
  11:	41 bf 04 00 00 00    	mov    $0x4,%r15d
  17:	41 b6 03             	mov    $0x3,%r14b
  1a:	eb 7d                	jmp    0x99
  1c:	e8 37 bd 83 fa       	call   0xfa83bd58
  21:	48 89 df             	mov    %rbx,%rdi
  24:	4c 89 f6             	mov    %r14,%rsi
  27:	4c 89 ea             	mov    %r13,%rdx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 8b 04 24          	mov    (%rsp),%rax
  33:	48 05 88 c4 00 00    	add    $0xc488,%rax
  39:	49 89 c6             	mov    %rax,%r14
  3c:	48 c1 e8 03          	shr    $0x3,%rax


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
