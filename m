Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7C23E325
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786182505; cv=none; b=mGk3jbui5o/0r6qoKnembRTnC/xdHERrFZ9boKc+XS0j8DzHIK3+YsshhTwQe4R22PwsJMXaC7rbbjNgxvnmg/S+Lao7ZKMGAzSby/mqM4refqjJ1B7Hlfj2MWuE6Mx/Nf+Q+ycQ7VVsfHgqipv6/OTv6uPPurqnbKBmd9+pZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786182505; c=relaxed/simple;
	bh=plAcaAfWJxE01uPirDC5GWjyqjI4nWQRqs3riEN01BE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P+odEhdcj9vxbJ7qhhcqpaOOsMaKiQRsRTnYHsa1pz1sgj/KiVcgpmFpYOXKTc8cg+VWhHc3qulrvTN+wfA75tEmyRP77/MQxDDg89iCLj30rwJu/Llj5lGexDOMFvUm6h+kXtyk86LmNLN7JDYuQe1+R+zxpFgTPdaxQApTGkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b1a69b1188so213534b6e.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 02:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786182503; x=1786787303;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vt1JeakK4SowEAXdUueofri/dxNTH8MVHlU3iQyRkbE=;
        b=IRXZDyJ1/GafRN+NytHYIY+kha7U5WQshQUCW4mtBzSZW4+UvtzYEIwPLS82WK+pUe
         cx4VU2Xaxonhh4D/Kr7dJaogH9hxesTa8NoedEEumGnuZ29rcjZHQOV5ShCNE8xsH43s
         8ozGsIZZLSnReMMQ1GSvW04pVaRbhxlpDhByXIlgcRSI9oSYKSSFXYakLsks+B0vVu+g
         idGT72AQQTviZ4Nj1GUZuef+GKnY03yhnryDsM4unpcnX9nxBJ8QmSepPUVO+UaAE9RJ
         Nywd6j6C8kIx4qgjJqQDj4J43sEUtegclGvMX5GS1pCk1FE/veJpaurejkcHhuVLU0RT
         3VpA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6TlaVSGgoxvM9MaTnJXB9mQO/sDfcnudj7Xkg8/IQPUm14ABzkU9WapqMOVvbTa6BdruLFks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5EtXAXh0iTRsY2PfkLZlUpikRJBBRrtxby5rXNbKc6HZiUSR
	SoNrGGmzlVoRIIP78dAglVHnZGwMlAGbPkYBIO754smRMj3epQkdnC4XH4vWl2KrKc6wkloKJei
	ZbWZon2sxB1HEDvqc6TNVLhBPiMNWM+cYfKewc3JQIXo7u6cUwt+0Cb/8SDg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:66d5:b0:4b1:b037:da8b with SMTP id
 5614622812f47-4b1b037ddabmr1851825b6e.11.1786182502947; Sat, 08 Aug 2026
 02:48:22 -0700 (PDT)
Date: Sat, 08 Aug 2026 02:48:22 -0700
In-Reply-To: <6a6d379a.2d659fcc.1d46f5.01a8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a76fb66.b50370da.49fe0.0025.GAE@google.com>
Subject: Re: [syzbot] [net?] [usb?] BUG: using smp_processor_id() in
 preemptible code in tx_complete
From: syzbot <syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a59f57e2aa12 Merge tag 'watchdog-for-v7.2-rc7' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127defb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d07fbc6821d72a61
dashboard link: https://syzkaller.appspot.com/bug?extid=04cd90bb99c6ef81a65d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17106fb9580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6048
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 2 UID: 0 PID: 6048 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(full) 
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
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6048
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 1 UID: 0 PID: 6048 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(full) 
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
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6048
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 3 UID: 0 PID: 6048 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(full) 
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
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6048
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 0 UID: 0 PID: 6048 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(full) 
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
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6048
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 0 UID: 0 PID: 6048 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(full) 
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
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6048
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 0 UID: 0 PID: 6048 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(full) 
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
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6048
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 2 UID: 0 PID: 6048 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(full) 
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
BUG: using smp_processor_id() in preemptible [00000000] code: vhci_rx/6048
caller is tx_complete+0x237/0x770 drivers/net/usb/usbnet.c:1301
CPU: 3 UID: 0 PID: 6048 Comm: vhci_rx Not tainted syzkaller #0 PREEMPT(full) 
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
vhci_hcd: connection reset by peer


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
