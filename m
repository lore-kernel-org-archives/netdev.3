Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF0438483
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469827; cv=none; b=DirPJGE1w2idi2PdpW3G1OlhNl94Du+dQY1Zrngj4CvPcmrTldGZZibGKDxnSH8HHo4bHYuOYaeb+LpmPJzqh2HQnMdYdZih0BLSHTjAbeE3RZdtdljSH0VHokq1eGJ2/wgqk5Ga4wA2gYm+drPKnrCW3sCHKaFVPGYVbzSnd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469827; c=relaxed/simple;
	bh=ZMAS3E9j6guUG9C13FpjLUN66YGxgAho2vklUgymVs8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m0yzg2MVgKaqHZNDAPOkXe5Epw2MbfiAXQt21DzlqkPdlxAFAaKNEhMdLpfBK6Ank+z2yCbtbRJlr5XfI7P92DqUQ/Z4zK0LK/jA60Cee6npblIwtDhR2ILgTx25ub8oogRKFD5AfhSo3u+UAqTOBcqzjg4gFOLmm0BPgFbclH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-7edccf768b0so77255a34.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 14:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788469824; x=1789074624;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SXrcCRkvCBUp2HS0ccYv5OYt7PvG5Ui9nBgoL6YqwJ8=;
        b=eI1zRfiklHFl5bOhzr7CmfHsOzEcrOykWEEZH2k48QlhkEzjvFlfnlhGBVk8GUU7J4
         tY5uxQt8it55HBc7+HcI011/TV7zFHI+RbKqFKmhnP72F9xJPFKBtM4pzjIvZS8DRo9Y
         +ks7F5ieDNwzJSPvpQCkJeStw58DrJJi+Uwqs4OHHPJEBoGoSa2oqH7nwXJkz8KmmxGS
         gW9C81IKhHCfqv1vgRvMCGZplrm2J61UPDeXkbOB813JQ/9QbKtaMaSKfzRxt0+tHv0R
         vE5MQ0BDfLpZ6Q9rZEZtaqP0NIxMfhcNwP7zqe0/cxN79bB5qJHLVqUY1qJ+F1fHprqf
         0XXg==
X-Forwarded-Encrypted: i=1; AKwUvByEzrtN/HxixguyXz0nvgzMCebA9OOmF3qrXPY9KMkE0c/U2Bc2XD5Of8N/VVBwpb0xmx27c4s=@vger.kernel.org
X-Gm-Message-State: AFuF++lAMOW4t36pOeVn0jbnR9/zVC53Uax1WHMciuvZTrnB2Of1d2R4
	3IRmJIqWOLHvhhY0Yb9lG7K8UjRtZ92g3m5GnEvGlu/l060KqDHPCsJmY4+mjupgUjCUpBXIlxp
	mXBvJ2XKpJK/SxHerL50C96aw3nYemhK/cqHRRA8TGKF9ID3JHqJ7Dj9go4Y=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4dc7:b0:6b1:8a52:62c9 with SMTP id
 006d021491bc7-6b6fe59c6d4mr1517710eaf.34.1788469823852; Thu, 03 Sep 2026
 14:10:23 -0700 (PDT)
Date: Thu, 03 Sep 2026 14:10:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a99e23f.9266084e.bf0d7.027f.GAE@google.com>
Subject: [syzbot] [net?] [usb?] WARNING: suspicious RCU usage in phy_detach
From: syzbot <syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	hkallweit1@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    edc1518454f6 usb: typec: hd3ss3220: Add support for supply..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=150248f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c451f9f64434b622
dashboard link: https://syzkaller.appspot.com/bug?extid=694b49f41098a5df4fd7
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14734b49580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b8a8fc7809a/disk-edc15184.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ff1ab9249a0/vmlinux-edc15184.xz
kernel image: https://storage.googleapis.com/syzbot-assets/249551c4918b/bzImage-edc15184.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com

asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
drivers/net/phy/phy_device.c:1944 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by kworker/1:1/29: 5, last CPU#1:
 #0: ffff8881066e8940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3362
 #1: ffffc900001f7d18 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3363
 #2: ffff88810abc71d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88810abc71d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x1bb/0x4510 drivers/usb/core/hub.c:5912
 #3: ffff888106f7f1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff888106f7f1d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4d0 drivers/base/dd.c:1073
 #4: ffff8881057351a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff8881057351a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4d0 drivers/base/dd.c:1073

stack backtrace:
CPU: 1 UID: 0 PID: 29 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 lockdep_rcu_suspicious.cold+0x4f/0xb2 kernel/locking/lockdep.c:6938
 phy_detach+0x517/0x640 drivers/net/phy/phy_device.c:1944
 phylink_connect_phy drivers/net/phy/phylink.c:2251 [inline]
 phylink_connect_phy+0x22e/0x2b0 drivers/net/phy/phylink.c:2235
 ax88772_init_phy drivers/net/usb/asix_devices.c:714 [inline]
 ax88772_bind+0xbb1/0x1520 drivers/net/usb/asix_devices.c:925
 usbnet_probe+0xbb3/0x27e0 drivers/net/usb/usbnet.c:1808
 usb_probe_interface+0x386/0x9b0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3776
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3776
 usb_new_device.part.0+0xcc2/0x1686 drivers/usb/core/hub.c:2708
 usb_new_device drivers/usb/core/hub.c:5833 [inline]
 hub_port_connect drivers/usb/core/hub.c:5580 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event.cold+0x51a/0xe9d drivers/usb/core/hub.c:5966
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
asix 4-1:0.188 (unnamed net_device) (uninitialized): Could not connect PHY
asix 4-1:0.188: probe with driver asix failed with error -22
usb 4-1: USB disconnect, device number 13
usb 4-1: new high-speed USB device number 14 using dummy_hcd
usb 4-1: Using ep0 maxpacket: 32
usb 4-1: New USB device found, idVendor=17ef, idProduct=7203, bcdDevice=2e.36
usb 4-1: config 0 has an invalid interface number: 188 but max is 0
usb 4-1: config 0 has no interface number 0
usb 4-1: config 0 interface 188 altsetting 0 bulk endpoint 0x82 has invalid maxpacket 32
usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 4-1: Product: syz
usb 4-1: Manufacturer: syz
usb 4-1: SerialNumber: syz
usb 4-1: config 0 descriptor??
asix 4-1:0.188: probe with driver asix failed with error -71
usb 4-1: USB disconnect, device number 14
usb 4-1: new high-speed USB device number 15 using dummy_hcd
usb 4-1: Using ep0 maxpacket: 32
usb 4-1: New USB device found, idVendor=17ef, idProduct=7203, bcdDevice=2e.36
usb 4-1: config 0 has an invalid interface number: 188 but max is 0
usb 4-1: config 0 has no interface number 0
usb 4-1: config 0 interface 188 altsetting 0 bulk endpoint 0x82 has invalid maxpacket 32
usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 4-1: Product: syz
usb 4-1: Manufacturer: syz
usb 4-1: SerialNumber: syz
usb 4-1: config 0 descriptor??
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Could not register MDIO bus (err -5)
asix 4-1:0.188: probe with driver asix failed with error -5
usb 4-1: USB disconnect, device number 15
usb 4-1: new high-speed USB device number 16 using dummy_hcd
usb 4-1: Using ep0 maxpacket: 32
usb 4-1: New USB device found, idVendor=17ef, idProduct=7203, bcdDevice=2e.36
usb 4-1: config 0 has an invalid interface number: 188 but max is 0
usb 4-1: config 0 has no interface number 0
usb 4-1: config 0 interface 188 altsetting 0 bulk endpoint 0x82 has invalid maxpacket 32
usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 4-1: Product: syz
usb 4-1: Manufacturer: syz
usb 4-1: SerialNumber: syz
usb 4-1: config 0 descriptor??
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 4-1:0.188 (unnamed net_device) (uninitialized): Could not register MDIO bus (err -5)
asix 4-1:0.188: probe with driver asix failed with error -5
usb 4-1: USB disconnect, device number 16
usb 4-1: new high-speed USB device number 17 using dummy_hcd
usb 4-1: Using ep0 maxpacket: 32
usb 4-1: New USB device found, idVendor=17ef, idProduct=7203, bcdDevice=2e.36
usb 4-1: config 0 has an invalid interface number: 188 but max is 0
usb 4-1: config 0 has no interface number 0
usb 4-1: config 0 interface 188 altsetting 0 bulk endpoint 0x82 has invalid maxpacket 32
usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 4-1: Product: syz
usb 4-1: Manufacturer: syz
usb 4-1: SerialNumber: syz
usb 4-1: config 0 descriptor??
asix 4-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32


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
