Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE243F2109
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883996; cv=none; b=Xf7pyjpbYWhq+Bw6QgfN6yLgYK/gCP3tS9vopGWYzEIj4OicMqdwnIfF4/MEDIj2HC1P9Kmc3tKoXXND8NHsg7H84f6sPLjrvz6XG3WRVCE7f3i8vC60atj4Ynl+WOG25DYQCdITag3SAXK+71YBSHYcnYQvGGr1Lo/oPwrIic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883996; c=relaxed/simple;
	bh=q8JUQtwmBkGdzP9AVqFrRwWEEAzEdUBfHebz4tNgDZ4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bM0ggHAvJgFMzLvfzdW/6SW6p1SyAXboK0PvyqXAXBUyfEAxuajRNMUt6twpOltyEKlyZcdrkW4hBAqmu9IS7Geu2ew4wd0lhG71Pl4N4xFybHGNMB0fQcN3py1Af/EpnoQCwEeMpdeY0qS3WMqJwv47P7RagtvN2e5iAPCGnHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4a485034d01so239978b6e.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 02:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784883989; x=1785488789;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UEEVDgpXsiLEBvWS6Q+gjpqzJEU1dEip0c1iKH1l8Tk=;
        b=dISXB748gugNiI2h+tqewzp6TtjqjzrCYN2Ghy1EJUtZYofVQ733oenEoSSJBjMlED
         nRcTILdYxXT3bYoACgfX/wSDpaYRIqKPqYAejzKK8sFuB37RZOlQ8bKxuzbh8NziQYwv
         eIOpd9eHM6R8SsTfPNCkPzlal+dnr1IxFxxKQEPm8zahuD/CXjAX5JK9ugS/FaHWSD/z
         TViL3OjFrpnahLkxpCCdoVGXt4QIZr4Bw4duHyz04rjU2Iq3XAuvy3iqFU2tMadquQeu
         A3UFM8Q8RxVONUEvmdtmJFrpZItvHZdovjEEnHnaYNSj2ucwkHy0FBXAgo+1SmXMeu28
         /wBw==
X-Forwarded-Encrypted: i=1; AHgh+RqXybhuOKrDgl/3rc3tCPJUh73yOeiu9C+C4V6eewC/Yer7NiL0CdpvGIbsAx07McBFibluB2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBfU6V9y/9FD5cCNe0CcUpltG8asrF7n11RTrGc9MrmKe/zI2
	ZcMVkAbklkg9MDrXule0x41YRP1BMXMWgwKB4Deu4YKlwHpXPdef18+zYyntNGjbz+i/fXZ8+it
	3tiU2sXB62BjXgfAOZByGRfAzQc7EM+strRT1iBD/cx5CnvZyjAlfe+aTj8k=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4446:b0:4a4:80be:3ae9 with SMTP id
 5614622812f47-4ab354af89amr3538908b6e.28.1784883989531; Fri, 24 Jul 2026
 02:06:29 -0700 (PDT)
Date: Fri, 24 Jul 2026 02:06:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a632b15.dde6c935.cf6c8.0011.GAE@google.com>
Subject: [syzbot] [net?] memory leak in udp_tunnel_nic_netdevice_event
From: syzbot <syzbot+eca845fb8c18dd6b44c1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dd3210c47e8d Merge tag 'regulator-fix-v7.2-rc2' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b4f0b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b80376788da8bcda
dashboard link: https://syzkaller.appspot.com/bug?extid=eca845fb8c18dd6b44c1
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b4f0b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e0d432580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5fb3ad85541d/disk-dd3210c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df0f959008a1/vmlinux-dd3210c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/383375b1d360/bzImage-dd3210c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eca845fb8c18dd6b44c1@syzkaller.appspotmail.com

2026/07/12 04:07:42 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888127d5f840 (size 96):
  comm "syz-executor", pid 5806, jiffies 4294942188
  hex dump (first 32 bytes):
    00 00 00 01 00 00 00 00 48 f8 d5 27 81 88 ff ff  ........H..'....
    48 f8 d5 27 81 88 ff ff 10 7d da 84 ff ff ff ff  H..'.....}......
  backtrace (crc 99fdb6c8):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4625 [inline]
    slab_alloc_node mm/slub.c:4945 [inline]
    __do_kmalloc_node mm/slub.c:5361 [inline]
    __kmalloc_noprof+0x3bf/0x550 mm/slub.c:5387
    _kmalloc_noprof include/linux/slab.h:973 [inline]
    _kzalloc_noprof include/linux/slab.h:1290 [inline]
    udp_tunnel_nic_alloc net/ipv4/udp_tunnel_nic.c:756 [inline]
    udp_tunnel_nic_register net/ipv4/udp_tunnel_nic.c:833 [inline]
    udp_tunnel_nic_netdevice_event+0x804/0xab0 net/ipv4/udp_tunnel_nic.c:931
    notifier_call_chain+0x59/0x160 kernel/notifier.c:85
    call_netdevice_notifiers_info+0x7d/0xb0 net/core/dev.c:2250
    call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
    call_netdevice_notifiers net/core/dev.c:2302 [inline]
    register_netdevice+0xc10/0xeb0 net/core/dev.c:11478
    nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1070 [inline]
    nsim_create+0x424/0x5b0 drivers/net/netdevsim/netdev.c:1152
    __nsim_dev_port_add+0x266/0x450 drivers/net/netdevsim/dev.c:1509
    nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1570 [inline]
    nsim_drv_probe+0x79c/0x930 drivers/net/netdevsim/dev.c:1731
    call_driver_probe drivers/base/dd.c:628 [inline]
    really_probe+0x12f/0x3a0 drivers/base/dd.c:706
    __driver_probe_device+0xe9/0x1a0 drivers/base/dd.c:868
    driver_probe_device+0x28/0xf0 drivers/base/dd.c:898
    __device_attach_driver+0x10f/0x170 drivers/base/dd.c:1026
    bus_for_each_drv+0xd2/0x130 drivers/base/bus.c:500
    __device_attach+0xf9/0x290 drivers/base/dd.c:1098
    device_initial_probe+0x6f/0x80 drivers/base/dd.c:1153
    bus_probe_device+0x3e/0xb0 drivers/base/bus.c:620

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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
