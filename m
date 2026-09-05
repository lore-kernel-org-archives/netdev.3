Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA5F2E06D2
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616842; cv=none; b=tP3Y1YasQtPrGOTGgoosLvUPd4F6SOeQV9yNW0WlH/QCcMddaiTUfx31pKeJJma0NunLCGzL+i791ZYIqZLpyib2cCBMyiyhtEzB4wH+VXj2Oh5gF4AEwtvqhHjDDabGoycpJYYpjpgwD44AJrOwkzTE3yXfyUtnK9OksUchMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616842; c=relaxed/simple;
	bh=7NwBpm0C1FLF+kYXPASGbIf8/Uxzy6O/7cUeUmnNlQQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YrBftM3trBSEzjYBs2prk9PVBgQxPZUUSWHfsizikF/JqGsib2vcZCu8HS8/E+9YjPGdsqJBDEPa/6qZWvnfLIZ8T6DwBoTW2okPhcAXTa3UzDATaXmVF3W54xpY1VHLjogeTw9ALBPv2HB1S0hwp9OlOCQFe360TJuzsP/+TJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f0.google.com with SMTP id 006d021491bc7-6a3900cb2b5so838737eaf.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 07:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788616831; x=1789221631;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=focEC3DqDk0O4jsiJOz9zVQ7X7PAcbJMwH+HkhI9hZA=;
        b=E5SCP2GW/Himo7T2XpWPbM2UZnMtH9FytN8obsjWCa0iIXNsWhTuaEBsH+rq2QakO9
         vYAc596YVO/E6PCqv9kw/tahamtoIenEFJWahfuQRW75hy4eM6z8RyI/PDNe4/8dSTFE
         vDwexxSrTacK4qmyihs0QYA/icUzJW51P38KSqDixuA94B1LEhc4+nNpT8FpOtFud+CW
         l9RsQfEaGvzQoTHjE+KVa9i+bfaCdSjlHLdqjSIJo/DOdLAD94mWZk6Vzrg6lRWZgh5d
         119yS5tQ3gStlpUzr4jkNrEHJqMks0BVQhdnD+8tsZVeR8K+S3ijsPyNsbyMx0P5ea+b
         RyYA==
X-Forwarded-Encrypted: i=1; AKwUvBydZ58qscQL2fF35Ia8q2o8rIxuY/3kyDOHKMK5iKd5KRUtcbrHRzK1UIvdTVGUIZL+U64j5E4=@vger.kernel.org
X-Gm-Message-State: AFuF++kmZeJm94sGvU4DVpYn2CGuQb0HSYF+QZm6xUjy55t4xxvZXnpF
	5N3YsooT1SbvqKApx7SbWG4L9larNcvZKYIOvFAVv2YJ0k5IaMBZA3zxTEQsRHnNh1hT5D9OYWQ
	QdS+isuqiGkYFLMKNIeh7IIpoRwlA0rTpr+83v/hd/LSEG+f2kraOTyIJIdw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b94:b0:6b1:a5c7:58ff with SMTP id
 006d021491bc7-6b6fcdcfd63mr8053847eaf.26.1788616831189; Sat, 05 Sep 2026
 07:00:31 -0700 (PDT)
Date: Sat, 05 Sep 2026 07:00:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9c207f.a6639fcc.23b8b0.0002.GAE@google.com>
Subject: [syzbot] [usb?] [nfc?] KASAN: use-after-free Read in pn533_acr122_is_rx_frame_valid
From: syzbot <syzbot+1853daab1a47603d4678@syzkaller.appspotmail.com>
To: david@ixit.cz, krzk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	oe-linux-nfc@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    edc1518454f6 usb: typec: hd3ss3220: Add support for supply..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14f27215580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c451f9f64434b622
dashboard link: https://syzkaller.appspot.com/bug?extid=1853daab1a47603d4678
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15de68f9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c86b49580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b8a8fc7809a/disk-edc15184.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ff1ab9249a0/vmlinux-edc15184.xz
kernel image: https://storage.googleapis.com/syzbot-assets/249551c4918b/bzImage-edc15184.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1853daab1a47603d4678@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in pn533_acr122_is_rx_frame_valid drivers/nfc/pn533/usb.c:325 [inline]
BUG: KASAN: use-after-free in pn533_acr122_is_rx_frame_valid+0x132/0x150 drivers/nfc/pn533/usb.c:315
Read of size 1 at addr ffff88816b5da3ce by task swapper/0/0

CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 pn533_acr122_is_rx_frame_valid drivers/nfc/pn533/usb.c:325 [inline]
 pn533_acr122_is_rx_frame_valid+0x132/0x150 drivers/nfc/pn533/usb.c:315
 pn533_recv_frame+0x1b7/0x6d0 drivers/nfc/pn533/pn533.c:2203
 __usb_hcd_giveback_urb+0x38e/0x610 drivers/usb/core/hcd.c:1657
 usb_hcd_giveback_urb+0x3ca/0x4a0 drivers/usb/core/hcd.c:1741
 dummy_timer+0xdb2/0x3700 drivers/usb/gadget/udc/dummy_hcd.c:2019
 __run_hrtimer kernel/time/hrtimer.c:2067 [inline]
 __hrtimer_run_queues+0x462/0x9c0 kernel/time/hrtimer.c:2124
 hrtimer_run_softirq+0x1ca/0x360 kernel/time/hrtimer.c:2141
 handle_softirqs+0x1d9/0x9b0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x192/0x210 kernel/softirq.c:767
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: bf c3 01 e9 43 fa 02 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d e3 ff 1e 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff89607d00 EFLAGS: 00000242
RAX: 000000000009c36b RBX: ffffffff8962c940 RCX: ffffffff878789d5
RDX: 0000000000000001 RSI: ffffffff89327d4e RDI: ffffffff87d2a600
RBP: fffffbfff12c5928 R08: 0000000000000001 R09: ffffed103eac673d
R10: ffff8881f56339eb R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 1ffffffff12c0fa4 R15: dffffc0000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:62 [inline]
 default_idle+0x9/0x10 arch/x86/kernel/process.c:768
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x3ae/0x5b0 kernel/sched/idle.c:355
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:454
 rest_init+0x2d3/0x2e0 init/main.c:727
 start_kernel+0x489/0x490 init/main.c:1185
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x12b/0x130 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x158
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16b5da
flags: 0x200000000000000(node=0|zone=2)
raw: 0200000000000000 ffffea0005ad7688 ffffea0005ad7688 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff88816b5da280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88816b5da300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88816b5da380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                              ^
 ffff88816b5da400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88816b5da480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
----------------
Code disassembly (best guess):
   0:	bf c3 01 e9 43       	mov    $0x43e901c3,%edi
   5:	fa                   	cli
   6:	02 00                	add    (%rax),%al
   8:	0f 1f 00             	nopl   (%rax)
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	f3 0f 1e fa          	endbr64
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d e3 ff 1e 00 	verw   0x1effe3(%rip)        # 0x1f000b
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	c3                   	ret <-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  36:	00 00 00
  39:	66 90                	xchg   %ax,%ax
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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
