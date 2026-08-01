Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E51925BC
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542557; cv=none; b=jkT0yw9vFShVTZp/S1ruC7f7x5oireAjDW6TBgcMvapdqyGM9xnyjLdAqIp7/IG1cM25Bd1nV2DfiPnjpxxdrP4aGWUcWTM9wweaxvJMFutxAuV1LCx6DZmMTpajWcvutqbEXNNjDS1BJvLklJ8GwdHwEbmOKwXMvTHhmunrKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542557; c=relaxed/simple;
	bh=p0nvq2pg4g1m9iEALvXxfHMdBIN3r9SFBRoA9XmZuVI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A6XSyE3MMakeizWyV0EmG94/QZ8XhrsY6F7wvcDKS6dyaLRNFYgx3jTV7xaEIiWYD22O13O8k7BUxjid9/oJy/RpI57go6g+q2v4AktvWmV31IxU6jpNpeUezAZlbmWPTPT5FmN5qHWE7yrN9l8K+Qm2m5ExDUgN/lVCq/kK1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4a41f46d629so2042889b6e.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 17:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785542554; x=1786147354;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooV9V1hLPFUBNnjWINFU7u+kB9NOQ+rH4q05PzVcZcM=;
        b=okzyD0FnfdpOQDloT2BwdOcbCqZs0FP1abEcKl2KDSGrx77QGd+uHwHwYAuOGWUnnt
         et6WewawG5APWK8llhuuFT7kVZ60ICL9mqFIZmOoLxMa+ZZn9s8G903aKGEP0lXFGvdR
         0tvMtCMjRuAeZIHpv7IhvbCCPZRrM6xG8y6buD69ftRLd27gFZbjpi++xMgsEMNLUUiu
         aDN932MQOM+31xnM6rOtSFAf/cY52n4TOf50o9Cxbx0I4AapC41XhfpGpg3dHi+Fro4n
         fnyN5U0iqmLnpqAIZpQiO+/CHZgEPJUqpMVVlgTJFXR716j5bDjvsZ9W4dIp9HMZ2fut
         K55Q==
X-Forwarded-Encrypted: i=1; AHgh+RrQsTyWh9WgatO7lPnwhpIorOQVEUtVGdUkzBhfhsZHlKV/W4aAH8wc201LvEU7eAEFLbuwMAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwBPTwC8XWdQrHtHGPUcFXPqgetiUAlVutWCP3FPwgAwBVBAX
	4WlhEGc5V+sJue7ylaNrw5eOuFm5m3xvTf2OBLq3HaDhTFBPlOjb6ap7XxBDLid/QfzUsb864cj
	1QpkMuoTt2uGGt0xeibrd7QofIslBRMEAl+0Y1rh4H/h3cb+OVkrh790WXDo=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:67c3:b0:495:eb9f:53c4 with SMTP id
 5614622812f47-4af5e1f32aamr3902257b6e.9.1785542554330; Fri, 31 Jul 2026
 17:02:34 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:02:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6d379a.2d659fcc.1d46f5.01a8.GAE@google.com>
Subject: [syzbot] [net?] [usb?] BUG: using smp_processor_id() in preemptible
 code in tx_complete
From: syzbot <syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10cbd632580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=04cd90bb99c6ef81a65d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-11028ab6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2be78614a29/vmlinux-11028ab6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/301a11d315af/bzImage-11028ab6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6205
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 0 UID: 0 PID: 6205 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 check_preemption_disabled+0xd8/0xe0 lib/smp_processor_id.c:47
 tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 vhci_recv_ret_submit drivers/usb/usbip/vhci_rx.c:107 [inline]
 vhci_rx_pdu drivers/usb/usbip/vhci_rx.c:242 [inline]
 vhci_rx_loop+0x60e/0xa60 drivers/usb/usbip/vhci_rx.c:265
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6205
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 3 UID: 0 PID: 6205 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 check_preemption_disabled+0xd8/0xe0 lib/smp_processor_id.c:47
 tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 vhci_recv_ret_submit drivers/usb/usbip/vhci_rx.c:107 [inline]
 vhci_rx_pdu drivers/usb/usbip/vhci_rx.c:242 [inline]
 vhci_rx_loop+0x60e/0xa60 drivers/usb/usbip/vhci_rx.c:265
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6205
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 1 UID: 0 PID: 6205 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 check_preemption_disabled+0xd8/0xe0 lib/smp_processor_id.c:47
 tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 vhci_recv_ret_submit drivers/usb/usbip/vhci_rx.c:107 [inline]
 vhci_rx_pdu drivers/usb/usbip/vhci_rx.c:242 [inline]
 vhci_rx_loop+0x60e/0xa60 drivers/usb/usbip/vhci_rx.c:265
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
check_preemption_disabled: 7 callbacks suppressed
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6205
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 0 UID: 0 PID: 6205 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 check_preemption_disabled+0xd8/0xe0 lib/smp_processor_id.c:47
 tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 vhci_recv_ret_submit drivers/usb/usbip/vhci_rx.c:107 [inline]
 vhci_rx_pdu drivers/usb/usbip/vhci_rx.c:242 [inline]
 vhci_rx_loop+0x60e/0xa60 drivers/usb/usbip/vhci_rx.c:265
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6205
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 1 UID: 0 PID: 6205 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 check_preemption_disabled+0xd8/0xe0 lib/smp_processor_id.c:47
 tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 vhci_recv_ret_submit drivers/usb/usbip/vhci_rx.c:107 [inline]
 vhci_rx_pdu drivers/usb/usbip/vhci_rx.c:242 [inline]
 vhci_rx_loop+0x60e/0xa60 drivers/usb/usbip/vhci_rx.c:265
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6205
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 1 UID: 0 PID: 6205 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 check_preemption_disabled+0xd8/0xe0 lib/smp_processor_id.c:47
 tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 vhci_recv_ret_submit drivers/usb/usbip/vhci_rx.c:107 [inline]
 vhci_rx_pdu drivers/usb/usbip/vhci_rx.c:242 [inline]
 vhci_rx_loop+0x60e/0xa60 drivers/usb/usbip/vhci_rx.c:265
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6205
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 3 UID: 0 PID: 6205 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 check_preemption_disabled+0xd8/0xe0 lib/smp_processor_id.c:47
 tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 vhci_recv_ret_submit drivers/usb/usbip/vhci_rx.c:107 [inline]
 vhci_rx_pdu drivers/usb/usbip/vhci_rx.c:242 [inline]
 vhci_rx_loop+0x60e/0xa60 drivers/usb/usbip/vhci_rx.c:265
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6205
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 3 UID: 0 PID: 6205 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 check_preemption_disabled+0xd8/0xe0 lib/smp_processor_id.c:47
 tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
 __usb_hcd_giveback_urb+0x38d/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 vhci_recv_ret_submit drivers/usb/usbip/vhci_rx.c:107 [inline]
 vhci_rx_pdu drivers/usb/usbip/vhci_rx.c:242 [inline]
 vhci_rx_loop+0x60e/0xa60 drivers/usb/usbip/vhci_rx.c:265
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
