Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E4346A0B
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 01:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787102253; cv=none; b=h6X72n49TjV3vACy3CH2O9f7tFqWfkwtXdWh1pPm57slW4+vPG+TgS6VTneIJ86P/KitaVUNK/C2FBJSNS1NsM/HjBSBDMFYwp7PXSUmmvhZMP8B7zw6rEukLEthrHM7KWhxfFik1+2CT02RHAWGqAAXMAKcu+8mf4rkqwnCPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787102253; c=relaxed/simple;
	bh=xg52mKlSGHve+lPWt95q+wJsDkxvKr+nIQQlwQoFe/U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GYuB5zSHSZ++KNSubISs4XQpBX4nd9bukMGS4iRPaL8DMb/fjxIbh1uqtIT47Xoj6MBwne8h97z/+ncopmsrTBhpyJwWkzxnCHshS+AvWDotm5d7arhXIPkGW8z/hFqu/QQCaH5F0iZ5rqJrjldVnwdns3gqGAHeZzojp80tlMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4afa222912eso421287b6e.2
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 18:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787102251; x=1787707051;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AsDt2aDCe3uKGplyc2i5OvRVIlvxlznmqAIuqlhbu2k=;
        b=L210bmTttcf1mBc34EDA5zA5ajOe8RGUfXkzf7R45V7TRYnAYsL7OCAohUARTm5Ov9
         Yhg0QILRH95n3Eq1gauBIb8Ab4bTNzzYPXVWm3qQzYZnRCT0v92H43ens2N8wxvN4IKH
         1VdmCtPVyt9mb5XTFiiYkkoCKZeL32lZzZtecXGrhWv9qhmhRJTmJxQxceODUdi2oasc
         aP7WHc/2DeO6TfQzV5PhPwah9RFNsgTZ5kIFMNflGL+bVkfWwEtLKWBNe1C8Q8jhxWw4
         x6tB/FqpSrw82mCpqacsE0aHijfhh6b+XcV1CmPGWVww3jQdviS0ubwE96rHHQ3LwbB2
         4F2A==
X-Forwarded-Encrypted: i=1; AHgh+RrquY5lgT2O/g94cptG35SGHghcWjaXPRQrRQmW21xW7MHAUCJB+8/kHhdQOG22qwpDuSHUOio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBmLcAPZnFzRePN5W3e+ObBfbMAaA+R0GI270sxlCzEc5Mvbt
	sPsQd78g0Qqo9nlzVTXXnxyBgBy8ZGY+hPYJK2pUgeeA8NB2Cw1h28YejV7dv6X/27fyGwu6rub
	BKwcMipDb1mFp35py6SM/MnCTLZmTlUyvFP7dBOQmdLwOIdTdkId0C2zvpws=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3197:b0:4b2:8e1c:5920 with SMTP id
 5614622812f47-4b2bc93d9c7mr778024b6e.9.1787102250988; Tue, 18 Aug 2026
 18:17:30 -0700 (PDT)
Date: Tue, 18 Aug 2026 18:17:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a85042a.4d75e56a.c9a88.001f.GAE@google.com>
Subject: [syzbot] [net?] WARNING in vmxnet3_probe_device
From: syzbot <syzbot+e39090bc9b3cf457717f@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, bcm-kernel-feedback-list@broadcom.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	ronak.doshi@broadcom.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5161661ae99 Merge tag 'sound-7.2' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10fb6279580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6a6de2292ff28
dashboard link: https://syzkaller.appspot.com/bug?extid=e39090bc9b3cf457717f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-a5161661.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/495a21a014c3/vmlinux-a5161661.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c83a709756a2/bzImage-a5161661.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e39090bc9b3cf457717f@syzkaller.appspotmail.com

oom_control is deprecated and will be removed. Please report your usecase to linux-mm-@kvack.org if you depend on this functionality.
openvswitch: netlink: IP tunnel dst address not specified
------------[ cut here ]------------
vmxnet3 0000:00:00.0: rejecting DMA map of vmalloc memory
WARNING: ./include/linux/dma-mapping.h:524 at dma_map_single_attrs include/linux/dma-mapping.h:523 [inline], CPU#0: syz.0.0/5315
WARNING: ./include/linux/dma-mapping.h:524 at vmxnet3_probe_device+0xab8/0x2e70 drivers/net/vmxnet3/vmxnet3_drv.c:4047, CPU#0: syz.0.0/5315
Modules linked in:
CPU: 0 UID: 0 PID: 5315 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:dma_map_single_attrs include/linux/dma-mapping.h:523 [inline]
RIP: 0010:vmxnet3_probe_device+0xb32/0x2e70 drivers/net/vmxnet3/vmxnet3_drv.c:4047
Code: 89 ff e8 d1 9e 02 fb 4d 8b 2f eb 15 e8 f7 68 93 fa 41 bf 04 00 00 00 41 b6 03 eb 7d e8 e7 68 93 fa 48 89 df 4c 89 f6 4c 89 ea <67> 48 0f b9 3a 48 8b 04 24 48 05 88 c4 00 00 49 89 c6 48 c1 e8 03
RSP: 0018:ffffc9000e24f820 EFLAGS: 00010246
RAX: 1ffff11003a4bc1a RBX: ffffffff90657ca0 RCX: dffffc0000000000
RDX: ffff88801fa17240 RSI: ffffffff8f872e20 RDI: ffffffff90657ca0
RBP: ffffc9000e24f9b0 R08: 0000000000000003 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1003a4bcb3 R12: 0000000000000001
R13: ffff88801fa17240 R14: ffffffff8f872e20 R15: ffff88801d25e0d0
FS:  00007fcafb3346c0(0000) GS:ffff88808c53e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcafb33d230 CR3: 000000001c30b000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 local_pci_probe drivers/pci/pci-driver.c:332 [inline]
 pci_call_probe drivers/pci/pci-driver.c:394 [inline]
 __pci_device_probe drivers/pci/pci-driver.c:455 [inline]
 pci_device_probe+0x431/0xc90 drivers/pci/pci-driver.c:489
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 device_driver_attach+0xe0/0x1d0 drivers/base/dd.c:1203
 bind_store+0x1d0/0x220 drivers/base/bus.c:267
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcafa39e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcafb333fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fcafa625fa0 RCX: 00007fcafa39e0d9
RDX: 000000000000000c RSI: 0000200000000140 RDI: 000000000000000a
RBP: 00007fcafa435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcafa626038 R14: 00007fcafa625fa0 R15: 00007ffc9d800cc8
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 ff                	mov    %edi,%edi
   2:	e8 d1 9e 02 fb       	call   0xfb029ed8
   7:	4d 8b 2f             	mov    (%r15),%r13
   a:	eb 15                	jmp    0x21
   c:	e8 f7 68 93 fa       	call   0xfa936908
  11:	41 bf 04 00 00 00    	mov    $0x4,%r15d
  17:	41 b6 03             	mov    $0x3,%r14b
  1a:	eb 7d                	jmp    0x99
  1c:	e8 e7 68 93 fa       	call   0xfa936908
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
