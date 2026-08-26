Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1164A330668
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747487; cv=none; b=luChhg+/t0Hxb16VnftfCUykUmyZ2Fuw2kG6sfO/bhSfllXzX0/W3SXldw0n0m8G24f6MDl7bcCNPR+Rv+Hv2K7gOtOAkOGqlJkR2b108hM2fIPy2tN0+/pu4mXaz3xaEjA1k+hSuGaMU2KWk5IKqjfVdydwrV6sN5XBazmF6jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747487; c=relaxed/simple;
	bh=qAlyxPM7Lg7f626GpbeCuw6YN2xFCN87UHi8PK5zOf0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Cx0NfGQA4RmOrRCHvPP8e76Dub2fgCpfB7WxwO+QzkLMR7TNZeFSTO9kAjqI2n2zE2bhOb7VARCBD7KU+XeijTBnHIFHcRZy6eoZ6yf4w0e2gdBN8KHABLPM+cX4EYmkaM+YfF+osGIMaxplRaCkunMvJKbHXMlxlyuqu+wrCaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7eb641eaf5eso1727596a34.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 05:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747485; x=1788352285;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xUk6okt1NTmx+4909s3MTkb4s5ZrorNTE81WWU4YUTY=;
        b=M299HRoF9f0JmuNu4EdSLx9V7MtOb9jjagJlnpUWzUdTM0xSnvOezS0HaRrvmd62JB
         emFL/HXWfGVgdonAplhu+nEu1PK1zJxEu8G4DdjTipiUqxmsD+SujUOK2IQz5xdff4k9
         PO/Ci6tAZQqbvjSA9/i9iAj2EI9Pucmyxr78Yo1VQT1iR8UGSyCtCEkS0+FRcQVDUEow
         mlj8qxxw78pXp2RkLOt/XnJ4qkyhdT3xVKTI67N+lt8I23hLBJ6HVJa1SWxJCm6pWScH
         PCywEzjlcY6JwXzRCbloFQNJHAzpKNjYBf7l+c6vnAkhO4N0NrNpellAs6CGDC0xZgqa
         hXWQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7Fp+mYbwGbqABeGL1IA/+p7vL9To1ipGVEHdi1aStcAFMffO5m2X9qfLvRV6PABepf+2vvf8=@vger.kernel.org
X-Gm-Message-State: AFuF++k+9mpo/LQmr7CZSGYdni+Jtb4MqY05i6F6wfxVh9Kk/chPmSYJ
	5moviwU5wkp1X8wsexOrZMnSC6bbb583/sKWJc16IFuvEOn85Wp25n4G7n0bN6Rr80dckxt7hxe
	KdAUzkzyY65sdaLhKaTTBiqLy0rmxT/Fpq9lh06TfMe35M30yAyEnS9Grtrk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:561c:b0:6b1:5865:a95a with SMTP id
 006d021491bc7-6b1a040216bmr4067204eaf.15.1787747484962; Wed, 26 Aug 2026
 05:31:24 -0700 (PDT)
Date: Wed, 26 Aug 2026 05:31:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8edc9c.4d659fcc.734b4.0002.GAE@google.com>
Subject: [syzbot] [nfc?] general protection fault in nfcmrvl_bulk_complete
From: syzbot <syzbot+59d5e6a8ed04e6a000c8@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1606d979580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
dashboard link: https://syzkaller.appspot.com/bug?extid=59d5e6a8ed04e6a000c8
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17dbd415580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59d5e6a8ed04e6a000c8@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 1 UID: 0 PID: 6013 Comm: syz-executor208 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:nfcmrvl_bulk_complete+0x33f/0x630 drivers/nfc/nfcmrvl/usb.c:70
Code: c1 e9 03 80 3c 01 00 0f 85 f8 02 00 00 49 8b ac 24 b8 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7d 20 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f 85 9e 02 00 00 4c 8b 7d 20 49 8d 47 18 48 89 c1 48
RSP: 0018:ffffc900006a0b80 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffff88801dfd0500 RCX: 0000000000000004
RDX: 0000000000000000 RSI: ffffffff867e2673 RDI: 0000000000000020
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888036f1b838
R13: ffff888036f1b848 R14: ffff88801dfd058c R15: ffff88801dfd0540
FS:  00007f4e3ac2d6c0(0000) GS:ffff8880d5ca2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4e39c2aff8 CR3: 000000003c99a000 CR4: 0000000000352ef0
Call Trace:
 <IRQ>
 __usb_hcd_giveback_urb+0x38e/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 dummy_timer+0xdb2/0x3700 drivers/usb/gadget/udc/dummy_hcd.c:2019
 __run_hrtimer kernel/time/hrtimer.c:2067 [inline]
 __hrtimer_run_queues+0x462/0x9c0 kernel/time/hrtimer.c:2124
 hrtimer_run_softirq+0x1ca/0x360 kernel/time/hrtimer.c:2141
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x194/0x210 kernel/softirq.c:767
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:lock_acquire+0x5e/0x370 kernel/locking/lockdep.c:5890
Code: 05 4f 8c a1 12 83 f8 07 0f 87 da 00 00 00 48 0f a3 05 d6 04 5d 0f 0f 82 b1 02 00 00 8b 35 7e 36 5d 0f 85 f6 0f 85 c7 00 00 00 <48> 8b 44 24 30 65 48 2b 05 ed 8b a1 12 0f 85 f1 02 00 00 48 83 c4
RSP: 0018:ffffc90003b1f358 EFLAGS: 00000206
RAX: 0000000000000046 RBX: 0000000000000001 RCX: 0000000000000100
RDX: 0000000000000001 RSI: ffffffff8e3add81 RDI: ffffffff8c615f80
RBP: ffff88806a53fd28 R08: 0000000001cd9d1b R09: 000000000000002c
R10: 0000000000000200 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
 local_trylock_acquire include/linux/local_lock_internal.h:53 [inline]
 alloc_from_pcs mm/slub.c:4769 [inline]
 slab_alloc_node mm/slub.c:4907 [inline]
 __kmalloc_cache_noprof+0x124/0x6b0 mm/slub.c:5480
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 nfcmrvl_submit_bulk_urb+0x9c/0x420 drivers/nfc/nfcmrvl/usb.c:116
 nfcmrvl_usb_nci_open+0x112/0x1b0 drivers/nfc/nfcmrvl/usb.c:181
 nfcmrvl_nci_open+0xcf/0x120 drivers/nfc/nfcmrvl/main.c:28
 nci_open_device net/nfc/nci/core.c:490 [inline]
 nci_dev_up+0x17b/0x680 net/nfc/nci/core.c:643
 nfc_dev_up+0x1b6/0x3a0 net/nfc/core.c:118
 nfc_genl_dev_up+0xa5/0xf0 net/nfc/netlink.c:775
 genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2556
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:800 [inline]
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0xa4d/0xbe0 net/socket.c:2713
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2767
 __sys_sendmsg+0x160/0x210 net/socket.c:2799
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4e3b48499e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007f4e3ac2d008 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4e3ac2d6c0 RCX: 00007f4e3b48499e
RDX: 0000000000000000 RSI: 00007f4e3ac2d090 RDI: 0000000000000003
RBP: 000000000000001f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 00007ffcf4794ce0 R15: 00007ffcf4794dc8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:nfcmrvl_bulk_complete+0x33f/0x630 drivers/nfc/nfcmrvl/usb.c:70
Code: c1 e9 03 80 3c 01 00 0f 85 f8 02 00 00 49 8b ac 24 b8 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7d 20 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f 85 9e 02 00 00 4c 8b 7d 20 49 8d 47 18 48 89 c1 48
RSP: 0018:ffffc900006a0b80 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffff88801dfd0500 RCX: 0000000000000004
RDX: 0000000000000000 RSI: ffffffff867e2673 RDI: 0000000000000020
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888036f1b838
R13: ffff888036f1b848 R14: ffff88801dfd058c R15: ffff88801dfd0540
FS:  00007f4e3ac2d6c0(0000) GS:ffff8880d5ca2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4e39c2aff8 CR3: 000000003c99a000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	c1 e9 03             	shr    $0x3,%ecx
   3:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
   7:	0f 85 f8 02 00 00    	jne    0x305
   d:	49 8b ac 24 b8 02 00 	mov    0x2b8(%r12),%rbp
  14:	00
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	48 8d 7d 20          	lea    0x20(%rbp),%rdi
  23:	48 89 f9             	mov    %rdi,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1) <-- trapping instruction
  2e:	0f 85 9e 02 00 00    	jne    0x2d2
  34:	4c 8b 7d 20          	mov    0x20(%rbp),%r15
  38:	49 8d 47 18          	lea    0x18(%r15),%rax
  3c:	48 89 c1             	mov    %rax,%rcx
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
