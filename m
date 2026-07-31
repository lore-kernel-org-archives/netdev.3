Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D22449B27
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518073; cv=none; b=aQcU+g1Z70/y9uKSAGbvJuhm77/tBPaPWE02KpUBwbsc0ZoI+3hCpvX9q6zCPqnmDIemc9Hv7eBKuNh32oxZqs4uk0So+d+c2PNiai8Pn9vNBXDM8SH63lXbn3ticnKRlNHg41h8kBOiqxScFBkBZilNrlQy80aBfl40g67x42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518073; c=relaxed/simple;
	bh=MaEk9IhYqtSp5p8XQpWZpSgVOWuSjHZoEn9KLCOdXmg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fVP0Pv64m7BUXLTzFRT3ZAuIjHj0X8gNWs0OM7rD7PaT4Z5XPhEMbrtX5Byva+fOW7tLJ3m3Bt9sCOm8qt3Hf2MCQyfRb2DV1zO5Yv/AqMC5MAIAdmhD3eKYatmZdxH9QHd3dlnG2iKJufdm0aars/1l6c+AAlOZkPzg6eH2y6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7e9f686e18cso1560737a34.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785518070; x=1786122870;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lWAzJCFBg4uy8Bt5Hyp9HNfzqLV/NPZfyz7dBiNQs4E=;
        b=Vl9GNnazbtWiJrwetyc9IKrvZfKdOx1RTEVSE4eOX32c6UqRUViWXsRjyszruJ53JC
         qGY42GLs2QlA41ZgHz6x8CPL29GIG2BFidaB30IleT6fA7kyzpngiBaUJ6zrtgUP3XHu
         0vaGs9zRfTHJcXiPZhhpJ9IuqdaCGfst5XQo8CF3Xo/IZBhaUa8HJGVWCFSVM1tiMdG7
         ceL3cqd0aRDwFuI7cOO55pLtE9Kt6Mt/hkQv55LIs2R138/LAgu44LHyJgL3dmARZtck
         9UfNqOb8hZvYFzn1GVP8XU/npA4pvyFBNNJW8bApsAY9nnRM9QG/UvxspSisarCi6gsS
         XxRw==
X-Forwarded-Encrypted: i=1; AHgh+RrY3s4MyR1LWmjLCbkXBUOFpHGH74ATnphG/LP1+BLo0YImpv9KiTpANDlxtCPyf1uik6mEW+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXX/31HmkV5kV08Bu6BsZVek5pX2W4JVqTnZsevgQkzNEw1ha
	lsVXt3sOUEbePuOoEF5J53EOGyC7JfJLC5cxOalcYKn+y5fYJPfBkTELGIJZiz7sTD7NuTUewCc
	rkb1oPpnAvzIVf3Ewlr66zWTVMJSLLYD7D1RUzCJ+5rsyTtEQ+bNWfj1S9F8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a0c:b0:4a3:ec8e:2052 with SMTP id
 5614622812f47-4af5e18ac5amr1294243b6e.8.1785518070536; Fri, 31 Jul 2026
 10:14:30 -0700 (PDT)
Date: Fri, 31 Jul 2026 10:14:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6cd7f6.2d659fcc.1d46f5.0198.GAE@google.com>
Subject: [syzbot] [usb?] WARNING in cxacru_cm/usb_submit_urb (3)
From: syzbot <syzbot+f254240f0da61e58c9ef@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, accessrunner-general@lists.sourceforge.net, 
	gregkh@linuxfoundation.org, linux-atm-general@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5d5fd841c346 Merge 7.2-rc5 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14ebcaea580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ec4d592e55f7960
dashboard link: https://syzkaller.appspot.com/bug?extid=f254240f0da61e58c9ef
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157ca5b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a77a49580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2ed536ae4daf/disk-5d5fd841.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab40098ccbf1/vmlinux-5d5fd841.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66d5c395f47c/bzImage-5d5fd841.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f254240f0da61e58c9ef@syzkaller.appspotmail.com

cxacru 4-1:1.0: send of cm 0x84 failed (-104)
ATM dev 0: cxacru_atm_start: CHIP_ADSL_LINE_START returned -104
------------[ cut here ]------------
URB ffff8881136a1a00 submitted while active
WARNING: drivers/usb/core/urb.c:379 at usb_submit_urb+0x1689/0x19b0 drivers/usb/core/urb.c:379, CPU#0: kworker/0:2/1122
Modules linked in:
CPU: 0 UID: 0 PID: 1122 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0x168c/0x19b0 drivers/usb/core/urb.c:379
Code: 00 48 8b 04 24 48 8b 90 b0 00 00 00 e9 70 ff ff ff bb ed ff ff ff e9 ac f1 ff ff e8 ae c8 ba fc 48 8d 3d 97 28 01 06 48 89 de <67> 48 0f b9 3a bb f0 ff ff ff e9 8e f1 ff ff c7 44 24 30 00 00 00
RSP: 0018:ffffc900030deb98 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8881136a1a00 RCX: 0000000000000000
RDX: ffff88810df81e00 RSI: ffff8881136a1a00 RDI: ffffffff8afa6430
RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
R10: ffffc900030dec20 R11: 0000000000000000 R12: 0000000000000040
R13: ffff88811dc98000 R14: ffff8881129a3000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888268636000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ae16b61948 CR3: 0000000115e52000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 cxacru_cm+0x202/0x950 drivers/usb/atm/cxacru.c:631
 cxacru_cm_get_array drivers/usb/atm/cxacru.c:722 [inline]
 cxacru_poll_status+0x147/0xdc0 drivers/usb/atm/cxacru.c:828
 cxacru_atm_start+0x203/0x240 drivers/usb/atm/cxacru.c:814
 usbatm_atm_init+0x196/0x360 drivers/usb/atm/usbatm.c:927
 usbatm_usb_probe+0x147e/0x1b50 drivers/usb/atm/usbatm.c:1178
 cxacru_usb_probe+0x101/0x200 drivers/usb/atm/cxacru.c:1370
 usb_probe_interface+0x386/0x9b0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 usb_new_device.cold+0x685/0x115c drivers/usb/core/hub.c:2700
 hub_port_connect drivers/usb/core/hub.c:5572 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5712 [inline]
 port_event drivers/usb/core/hub.c:5876 [inline]
 hub_event+0x314d/0x4af0 drivers/usb/core/hub.c:5958
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 48 8b             	add    %cl,-0x75(%rax)
   3:	04 24                	add    $0x24,%al
   5:	48 8b 90 b0 00 00 00 	mov    0xb0(%rax),%rdx
   c:	e9 70 ff ff ff       	jmp    0xffffff81
  11:	bb ed ff ff ff       	mov    $0xffffffed,%ebx
  16:	e9 ac f1 ff ff       	jmp    0xfffff1c7
  1b:	e8 ae c8 ba fc       	call   0xfcbac8ce
  20:	48 8d 3d 97 28 01 06 	lea    0x6012897(%rip),%rdi        # 0x60128be
  27:	48 89 de             	mov    %rbx,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	bb f0 ff ff ff       	mov    $0xfffffff0,%ebx
  34:	e9 8e f1 ff ff       	jmp    0xfffff1c7
  39:	c7                   	.byte 0xc7
  3a:	44 24 30             	rex.R and $0x30,%al
  3d:	00 00                	add    %al,(%rax)


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
