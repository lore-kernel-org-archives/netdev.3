Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253993;
	b=4FFXMOPw8O9hnRL0mZsy3TbEvWgM+FDAsUuM5fNQ519KhW6NDa5AifVo1q5z9g/z738E
	 evSsvraVAu7CrqCW9ZCk80E0hMtyt9egxZDqTHdcvdETHIsHc8UI72FPSZq4pZ7eqVFy1
	 KJDXFkb1/yMLJ3wlk8561q6BNYEDhCSQe3zJd87DkmLt3n+gnDkrEqkOZFWJ3ifD41JOW
	 dacqy5vejhIecQSDlRkgGkViO3AZrirzgYKDNyMFkCItrXVP08qAZCcjGbIS9i3Wg7QNe
	 7u/TjelawrCLtuJ2ZuXFTRTEGHyPFY0fM5dPXgT074SfJvq9PdXl0wCQRsbKVrXo6TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253993;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=T1kF2VKjyUzgUdkoi4y6yZVOWYKXz6GWaQQaQakuJzM=;
	b=hN0nlIhKq8z+kU7HNPkWOeuckUZFt+kIWRXgwzEFRJ6TlfdRYqVl+7kooGPbYou1pftb
	 AywR4SvwuIcrsNkMUz6ljbBwMBiWDnDf0/gEGQrjoJDC/TzrSROfbIqRdegLKIskFQzh0
	 WiOAWYjSuKozopfCZklK21nAAF5ep3C2jyaYhxQxZRTFHxJnq/joKQcKSVGjijiF00mpD
	 xHkypMX8B7Ddf6gab0DUcGo7XtI7WKNaP0PLpPTlSYHQSVmG8v44SX1XyLT8ilY4bMjeO
	 NcseyPvAt+xw331BH/Ug4mIOIZBlOGDqsDUVy7dsy7duNDsouX8HhDpPjVCZo8XB4iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16A606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E16A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4cc89e86e4dso2696932b6e.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793253992; x=1793858792;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T1kF2VKjyUzgUdkoi4y6yZVOWYKXz6GWaQQaQakuJzM=;
        b=UHxfrxXxCeJabFEZdr5uD+NUwb+ZjGEv47wfBcFMn+MOaPeJOsj4/9cdrdpMv9cIaa
         AJGNXlJmImDK5rgimUr4B17+BTs5+jcX3o/+7bRtQ64ou5BCGoKgzAs3O3SdxlbWm13Z
         TbUwS8U/neANnOqEo2QrWT6cIM8+smzpatjhbJMXrfIvP0H2vTeog8svXQprcz79fo8J
         vygrt0baoVEVNOW3gJRSvq41u+2qZcNu+wcyVjkgD6sCoQu7ach6Jk5zBph162VO8xi+
         kBBu5tQ/Wgffn9hjsUwMY81ZzW64gxqiEnw3gx8Aoj7tVp1tej7zFN3ijncHvy6At31I
         PlfA==
X-Forwarded-Encrypted: i=1; AKwUvBx2rSltUQ9a16SOTr0K95uuwKc1RZk3K81icQ+sJ3/UOA24pmPsvJJDun2wGxfMKR+qV055DPI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoRRMP2MsrcDvlOKOrcB5prRvgqbnef3xlvxyav+08XpJ1DkmA
	rqrkROvYAu9gnvYRt97pUsHWjsvBxAPgBg9C8M4M//IUmlTHzpKmvoUgvJLeuAUIMeAH9agPMXr
	ZZy+EVtksBM2zIT1k11LaOU60+Q8hvc8zJTmKSCxXBXFttFjZz8+J6py6Zqg=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fec:b0:4e6:6079:c33d with SMTP id
 5614622812f47-56382187468mr3050688b6e.10.1793253992039; Wed, 28 Oct 2026
 23:06:32 -0700 (PDT)
Date: Wed, 28 Oct 2026 23:06:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae2e268.f90c38ad.2dc092.0080.GAE@google.com>
Subject: [syzbot] [net?] [usb?] WARNING: suspicious RCU usage in phy_detach_internal
From: syzbot <syzbot+583f42a41879bb60de32@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b4b543fa187 Merge tag 'parisc-for-7.4-rc1' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=154321a5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e675f1e23c1386c8
dashboard link: https://syzkaller.appspot.com/bug?extid=583f42a41879bb60de32
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1629188d580000

AI-generated root cause summary:
In phy_detach_internal(), dev->hwprov is accessed using rtnl_dereference(),
which requires and asserts that the RTNL lock is held. However, network drivers
can attach and detach PHY devices prior to net_device registration (such as
during USB probe in asix/usbnet before register_netdev()), where RTNL is not
held. When phylink_connect_phy() fails bringup and rolls back via phy_detach(),
the absence of RTNL triggers a suspicious RCU usage warning. In a production
kernel without lockdep, the pointer dereference proceeds safely and no memory
corruption, leak, or denial of service occurs.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=583f42a41879bb60de32

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+583f42a41879bb60de32@syzkaller.appspotmail.com

asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
drivers/net/phy/phy_device.c:1831 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by kworker/1:2/1133: 5, last CPU#1:
 #0: ffff888105ee2d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1461/0x1b10 kernel/workqueue.c:3470
 #1: ffffc90002e3fd18 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3471
 #2: ffff88810b3d21d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88810b3d21d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x1bb/0x4510 drivers/usb/core/hub.c:5917
 #3: ffff8881135751d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff8881135751d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4d0 drivers/base/dd.c:1073
 #4: ffff888113fa31a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff888113fa31a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4d0 drivers/base/dd.c:1073

stack backtrace:
CPU: 1 UID: 0 PID: 1133 Comm: kworker/1:2 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 lockdep_rcu_suspicious.cold+0x4f/0xb2 kernel/locking/lockdep.c:6972
 phy_detach_internal+0x6a5/0x830 drivers/net/phy/phy_device.c:1831
 phylink_connect_phy drivers/net/phy/phylink.c:2452 [inline]
 phylink_connect_phy+0x22e/0x2b0 drivers/net/phy/phylink.c:2436
 ax88772_init_phy drivers/net/usb/asix_devices.c:714 [inline]
 ax88772_bind+0xbb1/0x1520 drivers/net/usb/asix_devices.c:925
 usbnet_probe+0xbb3/0x27e0 drivers/net/usb/usbnet.c:1812
 usb_probe_interface+0x386/0x980 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:503
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:623
 device_add+0x121d/0x1970 drivers/base/core.c:3776
 usb_set_configuration+0xd97/0x1dc0 drivers/usb/core/message.c:2279
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:503
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:623
 device_add+0x121d/0x1970 drivers/base/core.c:3776
 usb_new_device.part.0+0xcc2/0x1686 drivers/usb/core/hub.c:2713
 usb_new_device drivers/usb/core/hub.c:5838 [inline]
 hub_port_connect drivers/usb/core/hub.c:5585 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event.cold+0x51a/0xe9d drivers/usb/core/hub.c:5971
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3495
 process_scheduled_works kernel/workqueue.c:3578 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3659
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
asix 7-1:0.188 (unnamed net_device) (uninitialized): Could not connect PHY
asix 7-1:0.188: probe with driver asix failed with error -22
usb 7-1: USB disconnect, device number 2
usb 7-1: new high-speed USB device number 3 using dummy_hcd
usb 7-1: Using ep0 maxpacket: 32
usb 7-1: New USB device found: idVendor=17ef, idProduct=7203, bcdDevice=2e.36
usb 7-1: config 0 has an invalid interface number: 188 but max is 0
usb 7-1: config 0 has no interface number 0
usb 7-1: config 0 interface 188 altsetting 0 bulk endpoint 0x82 has invalid maxpacket 32
usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 7-1: Product: syz
usb 7-1: Manufacturer: syz
usb 7-1: SerialNumber: syz
usb 7-1: config 0 descriptor??
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 7-1:0.188 (unnamed net_device) (uninitialized): Error reading Medium Status register: ffffffe0
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable hardware MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to write reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to enable software MII access
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -71
asix 7-1:0.188 (unnamed net_device) (uninitialized): Could not connect PHY
asix 7-1:0.188: probe with driver asix failed with error -110
usb 7-1: USB disconnect, device number 3
usb 7-1: new high-speed USB device number 4 using dummy_hcd
usb 7-1: Using ep0 maxpacket: 32
usb 7-1: New USB device found: idVendor=17ef, idProduct=7203, bcdDevice=2e.36
usb 7-1: config 0 has an invalid interface number: 188 but max is 0
usb 7-1: config 0 has no interface number 0
usb 7-1: config 0 interface 188 altsetting 0 bulk endpoint 0x82 has invalid maxpacket 32
usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 7-1: Product: syz
usb 7-1: Manufacturer: syz
usb 7-1: SerialNumber: syz
usb 7-1: config 0 descriptor??
asix 7-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 7-1:0.188: probe with driver asix failed with error -32
usb 1-1: USB disconnect, device number 4
usb 1-1: new high-speed USB device number 5 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 32
usb 1-1: New USB device found: idVendor=17ef, idProduct=7203, bcdDevice=2e.36
usb 1-1: config 0 has an invalid interface number: 188 but max is 0
usb 1-1: config 0 has no interface number 0
usb 1-1: config 0 interface 188 altsetting 0 bulk endpoint 0x82 has invalid maxpacket 32
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??
asix 1-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 1-1:0.188 (unnamed net_device) (uninitialized): Error reading Medium Status register: ffffffe0
asix 1-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
asix 1-1:0.188 (unnamed net_device) (uninitialized): Failed to read reg index 0x0002: -32
asix 1-1:0.188 (unnamed net_device) (uninitialized): Could not register MDIO bus (err -5)
asix 1-1:0.188: probe with driver asix failed with error -5
usb 1-1: USB disconnect, device number 5
usb 1-1: new high-speed USB device number 6 using dummy_hcd
usb 1-1: Using ep0 maxpacket: 32
usb 1-1: New USB device found: idVendor=17ef, idProduct=7203, bcdDevice=2e.36
usb 1-1: config 0 has an invalid interface number: 188 but max is 0
usb 1-1: config 0 has no interface number 0
usb 1-1: config 0 interface 188 altsetting 0 bulk endpoint 0x82 has invalid maxpacket 32
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??


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
