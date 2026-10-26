Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040229;
	b=1BQniDsamE7gEEb3r9vhWA7YukQ2eD5gwsV0Zsq6VPdUna8IRjZrRe68qqiNzTeNOcei
	 RkEA5CwyQFDVJVEJOoNeS0BONREirefrkQk4d47DRjkYhqS//zocxu3nMIe95Uzi40wkJ
	 qQYEhmSpjqoHvJg63e64xWOQfNYrQaBUKTaxr9Cyd0p2p0IgyCqNcfMzFsFsoVNJR+hei
	 nijtTtuFagq2GnugwXNQ28zS3IrB3tFK6hXGD1joMERuh6bcjhtRNhThErWYKLJ2gOkuq
	 jl348UrOsbblvFSwp13ecqGYk8K4eBhdia2gYb2MA/FKao6cRza6QtEik6BWNCzRiww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040229;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=i4UzkNbvNTYKSyP4hKdp39ju0DTMoVudmB8zmNuX+3g=;
	b=qHcz3VTPMo3NpGIejFKOgMfbyzp+b+zAUwYqVEdnV59Rk/cLSedY9Ak5ObUSz1PYXjwH
	 bI3DIaJ440ya2HFcYui4D8kNJ6+uIcB2C2F/ZxHCfzyaZrRlgdJQNayussxA85rQGirAA
	 L75WHfP82UQWb8U0tm50vSGsyCKJSzXsEKwbzo4ukvqKcPdX9G0fgU1gl2ztbVvMThWkw
	 h7OzjHZM3YE/HoDcjXc4m5fREtKUINiFCVfc2FLR62MSfRfO7je64K5Pce2EtE3qcfhhn
	 fW3Io9ilIPSTkKueJuKsJYvD2NhCMxxbzrsEjrbW9oBBGlsJf8GweN/ZZ5OvXGTfYjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512C606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8512C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-54d6281f6dbso3720631b6e.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793040228; x=1793645028;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4UzkNbvNTYKSyP4hKdp39ju0DTMoVudmB8zmNuX+3g=;
        b=QZgnXTpJBXOtWD0E4f5xKxxn2Cd1GCACA5ddj34Ue/KPPV7lJ34iBgYJ7YEYC3duMp
         dFV3eM5xZX0WUivAUWLHv+o1j46YPNdSJA/g5yyjeDmtObWcN7pwVUNbNgklP4awFkgq
         sYViekvKOxgq/SVLQSB4JUEQt8uxR12zf5Wd7j5g/ANIBjWfQ3rV6pNMKpeN9M27wHFp
         t3+27If+3u0N/EVM5i5W3CyLRJ2vZyxhBNSeVDXr/BEJ36MXsozVavqM89pY4y+OcdZy
         pAsGDTibwahmKFHk44DSBwTrrwZEi4LWDIVU0pUGfuDrlIwVn8vvVjpg2A8O0hvHJSDT
         mnEw==
X-Forwarded-Encrypted: i=1; AKwUvByXA/nev5/Rdh1n8+ecTYlf5QekqgsBZeuQAlgRPVr2mETlwEHtrakndj8IUYj1UzwDODZ4YGQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLd00GVFFZFuwDElb+sO3whnOxEbX//wHeXhOs2C3An/ObaAfbo
	rnclx76w3sMBC3arrdGkCEvDxyHXuu/FYd3BLsZPc72XvTZE+RpxKAL2CFeofgt4ylAIEIMmAL+
	rQ0y7dIKAOccA+neB4HZ7YzdugM5VX6hAAfihUtIW7DaX8KCsp4v8VfgY7fE=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:124d:b0:4f1:f700:d447 with SMTP id
 5614622812f47-55c00377693mr4646304b6e.61.1793040228466; Mon, 26 Oct 2026
 11:43:48 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:43:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6adf9f64.6200f071.51519.0ed1.GAE@google.com>
Subject: [syzbot] [net?] KASAN: null-ptr-deref Read in netlink_has_listeners
From: syzbot <syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c03c1a14507d Linux 7.3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13a01ae1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ccb65e03706547e
dashboard link: https://syzkaller.appspot.com/bug?extid=1269fe6cc2016008124e
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11515031580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in netlink_is_kernel net/netlink/af_netlink.c:88 [inline]
BUG: KASAN: null-ptr-deref in netlink_has_listeners+0x3d/0x3f0 net/netlink/af_netlink.c:1390
Read of size 8 at addr 0000000000000578 by task syz-executor333/5617

CPU: 0 UID: 0 PID: 5617 Comm: syz-executor333 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:82 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 netlink_is_kernel net/netlink/af_netlink.c:88 [inline]
 netlink_has_listeners+0x3d/0x3f0 net/netlink/af_netlink.c:1390
 genl_has_listeners include/net/genetlink.h:644 [inline]
 devlink_nl_notify_need net/devlink/devl_internal.h:238 [inline]
 devlink_port_notify+0x18c/0x520 net/devlink/port.c:559
 __devlink_port_type_set+0x5f1/0x7a0 net/devlink/port.c:1237
 devlink_port_netdevice_event+0x25d/0x3a0 net/devlink/port.c:-1
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2313 [inline]
 call_netdevice_notifiers net/core/dev.c:2327 [inline]
 unregister_netdevice_many_notify+0x1a76/0x2140 net/core/dev.c:12580
 unregister_netdevice_many net/core/dev.c:12635 [inline]
 unregister_netdevice_queue+0x2f5/0x340 net/core/dev.c:12436
 unregister_netdevice include/linux/netdevice.h:3490 [inline]
 nsim_destroy+0x275/0x800 drivers/net/netdevsim/netdev.c:1198
 __nsim_dev_port_del+0x14e/0x200 drivers/net/netdevsim/dev.c:1472
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1486 [inline]
 nsim_dev_reload_destroy+0x288/0x490 drivers/net/netdevsim/dev.c:1710
 nsim_drv_remove+0x58/0x170 drivers/net/netdevsim/dev.c:1725
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x444/0x560 drivers/base/bus.c:664
 device_del+0x524/0x8f0 drivers/base/core.c:3965
 device_unregister+0x21/0xf0 drivers/base/core.c:4006
 nsim_bus_dev_del drivers/net/netdevsim/bus.c:488 [inline]
 del_device_store+0x2b5/0x370 drivers/net/netdevsim/bus.c:244
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb10e25df77
Code: 48 89 fa 4c 89 df e8 98 1e 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffd1f1777c0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000555587f6f400 RCX: 00007fb10e25df77
RDX: 0000000000000003 RSI: 00007fb10e29d08b RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd1f177938
R13: 0000000000000002 R14: 00007fb10e2c5c80 R15: 0000000000000002
 </TASK>
==================================================================


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
