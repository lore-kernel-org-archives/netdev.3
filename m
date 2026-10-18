Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8063EFD0E
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341650; cv=none; b=MdpTKMy1+SwcnfPFuYVemDcJqb3cxlsOtdvqH8HFC1Bgou+qJefBE0hsrjifHyfTQ7K//4RY/18qJYN/OuqBnwDEreCG1Wdbo0Lk2CgozTefwTbJdBfaCe6TLV1UhNoKDxaed93zCFQ7uti06Lt0s707nni71L0afB+wkWlHA88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341650; c=relaxed/simple;
	bh=OCSCW93Y4kHWYVnPcOVXR8ZtqxzyAMxkY98dXEr1dEk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=du02qsdRCU31EZiXKxm6QJYOuAk68fBPAJEbsMTq9lD6w326kbXbiJOuFILBJApc9pzXE7EOJNPoHUNFGlPD3AoGeoh6qhPJ5oeKuD0l+c7fm0893JfQ+6Oit0EWzZAjQCDtIjqzjglkpcm7n2Hbnx9IdIfMtMqae3kFuPbWe6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-809f1af7992so2802205a34.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 09:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792341640; x=1792946440;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MPWBcVTvoYhTjJI4nne5qY2qUIwLnIX/JTZ2gs8slhk=;
        b=brXeesZ8Cvi4sO6584N5YYixTymwY07pZTOk6APUOmgGUoU9/FO2OCc5Cjq2dNjjiV
         8xa4o2hNtFi0QwDpv6rDE+curwvLgUd7HrssHPLuBrOuf2i8PHde7G7Nr9wef0WKpy6S
         uXYtv+WUPxYKcwE2FDHD7k4yAYBqNEccPFidOEK3FkHVyxJFf9Ga2epRndqZGngJZiuH
         +H36wd3Dt3xV9qsfgOtP6wisyyvVdOPUMyU83TV5X04B5Y564ax1GwwI/ZVWmtTEDtYF
         e0Flh0I+WDtNXx/qCPyaDsj9GO+3OTIIvOstIY0qu0BhQQnl1y+t69pLFDamHSLzYhPh
         5ffQ==
X-Forwarded-Encrypted: i=1; AKwUvBy90xfSVEEXIVn8BljpdxLewUEjYN0FWpG2coEkvIHF5/4nf8CG2cOzelgnPEJLkUc5l2sps7M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKep9+ZMsC7vU7C4/oNhmoUSEVU8OErttTroyONfHQGXO/UNGGn
	uGPuRmLkGbYA7rlAD1XFEx58K/PQqXA5/AjG0Pxdf2+BSbfxuPCIHoVg1j6GalgwkOfEsmaCG1A
	3reglOrlpXgtFdqt8icqhpN37RSrzlnw8Mjyvtc4+uJOv92BMj+0lgSPPf6k=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:30a3:b0:4f5:20:d847 with SMTP id
 5614622812f47-53ccd9baeb3mr5544278b6e.36.1792341640383; Sun, 18 Oct 2026
 09:40:40 -0700 (PDT)
Date: Sun, 18 Oct 2026 09:40:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad4f688.a6d1a155.34a93f.00b6.GAE@google.com>
Subject: [syzbot] [nfc?] INFO: task hung in pn533_usb_send_frame (4)
From: syzbot <syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com>
To: david@ixit.cz, krzk@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ca3e345926b0 Merge tag 'bootconfig-fixes-v7.3-rc7' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fd53d1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4118aaa2d227be26
dashboard link: https://syzkaller.appspot.com/bug?extid=1c5368988052dc2d8201
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114a0171580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aa447bf88d66/disk-ca3e3459.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/95d31af25212/vmlinux-ca3e3459.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d7d904fe9fac/bzImage-ca3e3459.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com

INFO: task kworker/0:0:9 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:23360 pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
 pn533_usb_send_frame+0x31d/0x5e0 drivers/nfc/pn533/usb.c:187
 pn533_send_cmd_frame drivers/nfc/pn533/pn533.c:444 [inline]
 __pn533_send_async+0x4d2/0x730 drivers/nfc/pn533/pn533.c:473
 pn533_send_cmd_async drivers/nfc/pn533/pn533.c:512 [inline]
 pn533_send_cmd_sync drivers/nfc/pn533/pn533.c:633 [inline]
 pn533_get_firmware_version drivers/nfc/pn533/pn533.c:2537 [inline]
 pn533_finalize_setup+0x28b/0xf80 drivers/nfc/pn533/pn533.c:2734
 pn533_usb_probe+0xd37/0x10e0 drivers/nfc/pn533/usb.c:572
 usb_probe_interface+0x788/0xe50 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1bb5/0x2260 drivers/usb/core/message.c:2274
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x9aa/0x1690 drivers/usb/core/hub.c:2713
 hub_port_connect drivers/usb/core/hub.c:5585 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5971
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/0:1:10 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:23688 pid:10    tgid:10    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
 pn533_usb_send_frame+0x31d/0x5e0 drivers/nfc/pn533/usb.c:187
 pn533_send_cmd_frame drivers/nfc/pn533/pn533.c:444 [inline]
 __pn533_send_async+0x4d2/0x730 drivers/nfc/pn533/pn533.c:473
 pn533_send_cmd_async drivers/nfc/pn533/pn533.c:512 [inline]
 pn533_send_cmd_sync drivers/nfc/pn533/pn533.c:633 [inline]
 pn533_get_firmware_version drivers/nfc/pn533/pn533.c:2537 [inline]
 pn533_finalize_setup+0x28b/0xf80 drivers/nfc/pn533/pn533.c:2734
 pn533_usb_probe+0xd37/0x10e0 drivers/nfc/pn533/usb.c:572
 usb_probe_interface+0x788/0xe50 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1bb5/0x2260 drivers/usb/core/message.c:2274
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x9aa/0x1690 drivers/usb/core/hub.c:2713
 hub_port_connect drivers/usb/core/hub.c:5585 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5971
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/1:2:1234 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:24232 pid:1234  tgid:1234  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
 pn533_usb_send_frame+0x31d/0x5e0 drivers/nfc/pn533/usb.c:187
 pn533_send_cmd_frame drivers/nfc/pn533/pn533.c:444 [inline]
 __pn533_send_async+0x4d2/0x730 drivers/nfc/pn533/pn533.c:473
 pn533_send_cmd_async drivers/nfc/pn533/pn533.c:512 [inline]
 pn533_send_cmd_sync drivers/nfc/pn533/pn533.c:633 [inline]
 pn533_get_firmware_version drivers/nfc/pn533/pn533.c:2537 [inline]
 pn533_finalize_setup+0x28b/0xf80 drivers/nfc/pn533/pn533.c:2734
 pn533_usb_probe+0xd37/0x10e0 drivers/nfc/pn533/usb.c:572
 usb_probe_interface+0x788/0xe50 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1bb5/0x2260 drivers/usb/core/message.c:2274
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x9aa/0x1690 drivers/usb/core/hub.c:2713
 hub_port_connect drivers/usb/core/hub.c:5585 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5971
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/0:3:5349 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:22960 pid:5349  tgid:5349  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
 pn533_usb_send_frame+0x31d/0x5e0 drivers/nfc/pn533/usb.c:187
 pn533_send_cmd_frame drivers/nfc/pn533/pn533.c:444 [inline]
 __pn533_send_async+0x4d2/0x730 drivers/nfc/pn533/pn533.c:473
 pn533_send_cmd_async drivers/nfc/pn533/pn533.c:512 [inline]
 pn533_send_cmd_sync drivers/nfc/pn533/pn533.c:633 [inline]
 pn533_get_firmware_version drivers/nfc/pn533/pn533.c:2537 [inline]
 pn533_finalize_setup+0x28b/0xf80 drivers/nfc/pn533/pn533.c:2734
 pn533_usb_probe+0xd37/0x10e0 drivers/nfc/pn533/usb.c:572
 usb_probe_interface+0x788/0xe50 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1bb5/0x2260 drivers/usb/core/message.c:2274
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x9aa/0x1690 drivers/usb/core/hub.c:2713
 hub_port_connect drivers/usb/core/hub.c:5585 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5971
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.3.20:5891 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.20        state:D stack:26568 pid:5891  tgid:5891  ppid:5760   task_flags:0x400040 flags:0x08080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7433
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 device_lock include/linux/device.h:1104 [inline]
 usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
 chrdev_open+0x4d9/0x600 fs/char_dev.c:411
 do_dentry_open+0x816/0x1380 fs/open.c:996
 vfs_open+0x3b/0x340 fs/open.c:1101
 do_open fs/namei.c:4866 [inline]
 path_openat+0x1443/0x1d60 fs/namei.c:5029
 do_file_open+0x23e/0x4a0 fs/namei.c:5058
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_compat_sys_openat fs/open.c:1485 [inline]
 __se_compat_sys_openat fs/open.c:1483 [inline]
 __ia32_compat_sys_openat+0x131/0x160 fs/open.c:1483
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 do_int80_emulation+0x198/0x500 arch/x86/entry/syscall_32.c:166
 asm_int80_emulation+0x1a/0x20 arch/x86/include/asm/idtentry.h:598
RIP: 0023:0xf71e762b
RSP: 002b:00000000f75df58c EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000f75df650
RDX: 0000000000105b01 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
INFO: task kworker/0:5:5892 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:24296 pid:5892  tgid:5892  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
 pn533_usb_send_frame+0x31d/0x5e0 drivers/nfc/pn533/usb.c:187
 pn533_send_cmd_frame drivers/nfc/pn533/pn533.c:444 [inline]
 __pn533_send_async+0x4d2/0x730 drivers/nfc/pn533/pn533.c:473
 pn533_send_cmd_async drivers/nfc/pn533/pn533.c:512 [inline]
 pn533_send_cmd_sync drivers/nfc/pn533/pn533.c:633 [inline]
 pn533_get_firmware_version drivers/nfc/pn533/pn533.c:2537 [inline]
 pn533_finalize_setup+0x28b/0xf80 drivers/nfc/pn533/pn533.c:2734
 pn533_usb_probe+0xd37/0x10e0 drivers/nfc/pn533/usb.c:572
 usb_probe_interface+0x788/0xe50 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_set_configuration+0x1bb5/0x2260 drivers/usb/core/message.c:2274
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c3/0x3b0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c4/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:620
 device_add+0x7d7/0xb80 drivers/base/core.c:3776
 usb_new_device+0x9aa/0x1690 drivers/usb/core/hub.c:2713
 hub_port_connect drivers/usb/core/hub.c:5585 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x28e8/0x4d30 drivers/usb/core/hub.c:5971
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.0.17:5893 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:27384 pid:5893  tgid:5893  ppid:5753   task_flags:0x400040 flags:0x08080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7433
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 device_lock include/linux/device.h:1104 [inline]
 usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
 chrdev_open+0x4d9/0x600 fs/char_dev.c:411
 do_dentry_open+0x816/0x1380 fs/open.c:996
 vfs_open+0x3b/0x340 fs/open.c:1101
 do_open fs/namei.c:4866 [inline]
 path_openat+0x1443/0x1d60 fs/namei.c:5029
 do_file_open+0x23e/0x4a0 fs/namei.c:5058
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_compat_sys_openat fs/open.c:1485 [inline]
 __se_compat_sys_openat fs/open.c:1483 [inline]
 __ia32_compat_sys_openat+0x131/0x160 fs/open.c:1483
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 do_int80_emulation+0x198/0x500 arch/x86/entry/syscall_32.c:166
 asm_int80_emulation+0x1a/0x20 arch/x86/include/asm/idtentry.h:598
RIP: 0023:0xf715762b
RSP: 002b:00000000f754f58c EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000f754f650
RDX: 0000000000105b01 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
INFO: task syz.1.18:5894 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.18        state:D stack:26880 pid:5894  tgid:5894  ppid:5763   task_flags:0x400040 flags:0x08080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7433
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 device_lock include/linux/device.h:1104 [inline]
 usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
 chrdev_open+0x4d9/0x600 fs/char_dev.c:411
 do_dentry_open+0x816/0x1380 fs/open.c:996
 vfs_open+0x3b/0x340 fs/open.c:1101
 do_open fs/namei.c:4866 [inline]
 path_openat+0x1443/0x1d60 fs/namei.c:5029
 do_file_open+0x23e/0x4a0 fs/namei.c:5058
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_compat_sys_openat fs/open.c:1485 [inline]
 __se_compat_sys_openat fs/open.c:1483 [inline]
 __ia32_compat_sys_openat+0x131/0x160 fs/open.c:1483
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 do_int80_emulation+0x198/0x500 arch/x86/entry/syscall_32.c:166
 asm_int80_emulation+0x1a/0x20 arch/x86/include/asm/idtentry.h:598
RIP: 0023:0xf70f762b
RSP: 002b:00000000f74ef58c EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000f74ef650
RDX: 0000000000105b01 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
INFO: task syz.5.21:5895 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.5.21        state:D stack:27288 pid:5895  tgid:5895  ppid:5759   task_flags:0x400040 flags:0x08080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7433
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 device_lock include/linux/device.h:1104 [inline]
 usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
 chrdev_open+0x4d9/0x600 fs/char_dev.c:411
 do_dentry_open+0x816/0x1380 fs/open.c:996
 vfs_open+0x3b/0x340 fs/open.c:1101
 do_open fs/namei.c:4866 [inline]
 path_openat+0x1443/0x1d60 fs/namei.c:5029
 do_file_open+0x23e/0x4a0 fs/namei.c:5058
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_compat_sys_openat fs/open.c:1485 [inline]
 __se_compat_sys_openat fs/open.c:1483 [inline]
 __ia32_compat_sys_openat+0x131/0x160 fs/open.c:1483
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 do_int80_emulation+0x198/0x500 arch/x86/entry/syscall_32.c:166
 asm_int80_emulation+0x1a/0x20 arch/x86/include/asm/idtentry.h:598
RIP: 0023:0xf717762b
RSP: 002b:00000000f756f58c EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000f756f650
RDX: 0000000000105b01 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
INFO: task syz.2.19:5898 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.19        state:D stack:27352 pid:5898  tgid:5898  ppid:5761   task_flags:0x400040 flags:0x08080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7433
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 device_lock include/linux/device.h:1104 [inline]
 usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
 chrdev_open+0x4d9/0x600 fs/char_dev.c:411
 do_dentry_open+0x816/0x1380 fs/open.c:996
 vfs_open+0x3b/0x340 fs/open.c:1101
 do_open fs/namei.c:4866 [inline]
 path_openat+0x1443/0x1d60 fs/namei.c:5029
 do_file_open+0x23e/0x4a0 fs/namei.c:5058
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_compat_sys_openat fs/open.c:1485 [inline]
 __se_compat_sys_openat fs/open.c:1483 [inline]
 __ia32_compat_sys_openat+0x131/0x160 fs/open.c:1483
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 do_int80_emulation+0x198/0x500 arch/x86/entry/syscall_32.c:166
 asm_int80_emulation+0x1a/0x20 arch/x86/include/asm/idtentry.h:598
RIP: 0023:0xf71a762b
RSP: 002b:00000000f759f58c EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000f759f650
RDX: 0000000000105b01 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
locks held by kworker/0:0/9: 6, on CPU#0:
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900000e7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802b4c31d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802b4c31d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5917
 #3: ffff888076f191d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff888076f191d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #4: ffff888076cf81a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff888076cf81a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #5: ffff88805d7fc430 (&priv->cmd_lock){+.+.}-{4:4}, at: __pn533_send_async+0x279/0x730 drivers/nfc/pn533/pn533.c:470
locks held by kworker/0:1/10: 6, on CPU#0:
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900000f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900000f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900000f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900000f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802b42d1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802b42d1d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5917
 #3: ffff88807dabc1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88807dabc1d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #4: ffff888035d751a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff888035d751a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #5: ffff88805cc8b430 (&priv->cmd_lock){+.+.}-{4:4}, at: __pn533_send_async+0x279/0x730 drivers/nfc/pn533/pn533.c:470
locks held by kworker/u8:0/12: 3, last CPU#0:
 #0: ffff88801c0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801c0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801c0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801c0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90000117c40 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90000117c40 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90000117c40 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90000117c40 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff888059dc6258 (&devlink->lock_key#27){+.+.}-{4:4}, at: nsim_dev_trap_report_work+0x57/0xb40 drivers/net/netdevsim/dev.c:834
locks held by kworker/u8:1/13: 3, on CPU#0:
 #0: ffff88801c0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801c0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801c0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801c0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90000127c40 ((linkwatch_work).work){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90000127c40 ((linkwatch_work).work){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90000127c40 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90000127c40 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffffffff91255c80 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:313
locks held by pr/ttyS0/16: 2, last CPU#1:
 #0: ffffffff8fc36518 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:314 [inline]
 #0: ffffffff8fc36518 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:439 [inline]
 #0: ffffffff8fc36518 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x30/0x60 kernel/printk/printk.c:291
 #1: ffffffff9bd4be38 (&port_lock_key){-.-.}-{3:3}, at: __uart_port_lock_irqsave include/linux/serial_core.h:613 [inline]
 #1: ffffffff9bd4be38 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x67/0xc0 drivers/tty/serial/8250/8250_core.c:413
locks held by kworker/1:0/25: 6, on CPU#1:
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900001f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900001f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900001f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900001f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802b5021d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802b5021d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5917
 #3: ffff888078d5b1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff888078d5b1d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #4: ffff88805c32c1a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88805c32c1a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #5: ffff88802a06a430 (&priv->cmd_lock){+.+.}-{4:4}, at: __pn533_send_async+0x279/0x730 drivers/nfc/pn533/pn533.c:470
locks held by khungtaskd/32: 1, last CPU#0:
 #0: ffffffff8fd5c8e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8fd5c8e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8fd5c8e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6871
locks held by kworker/u8:2/43: 2, last CPU#0:
 #0: ffff888033a1a940 ((wq_completion)bat_events){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888033a1a940 ((wq_completion)bat_events){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888033a1a940 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888033a1a940 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90000b37c40 ((work_completion)(&(&forw_packet_aggr->delayed_work)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90000b37c40 ((work_completion)(&(&forw_packet_aggr->delayed_work)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90000b37c40 ((work_completion)(&(&forw_packet_aggr->delayed_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90000b37c40 ((work_completion)(&(&forw_packet_aggr->delayed_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
locks held by kworker/1:2/1234: 6, on CPU#1:
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc9000558fc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc9000558fc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc9000558fc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc9000558fc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802b1391d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802b1391d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5917
 #3: ffff888079e5f1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff888079e5f1d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #4: ffff88805d0d71a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88805d0d71a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #5: ffff88807f7bb430 (&priv->cmd_lock){+.+.}-{4:4}, at: __pn533_send_async+0x279/0x730 drivers/nfc/pn533/pn533.c:470
locks held by kworker/u8:10/3346: 3, on CPU#0:
 #0: ffff888033b11140 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888033b11140 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888033b11140 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888033b11140 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc9000e76fc40 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc9000e76fc40 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc9000e76fc40 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc9000e76fc40 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffffffff91255c80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:134 [inline]
 #2: ffffffff91255c80 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x116/0x15c0 net/ipv6/addrconf.c:4230
locks held by kworker/0:3/5349: 6, on CPU#0:
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90003587c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90003587c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90003587c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90003587c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5917
 #3: ffff88805d7fd1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88805d7fd1d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #4: ffff88807dabd1a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88807dabd1a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #5: ffff888078e15430 (&priv->cmd_lock){+.+.}-{4:4}, at: __pn533_send_async+0x279/0x730 drivers/nfc/pn533/pn533.c:470
locks held by getty/5375: 2, on CPU#0:
 #0: ffff8880376410a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000323b2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
locks held by kworker/1:4/5828: 2, last CPU#1:
 #0: ffff88801c069d40 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801c069d40 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801c069d40 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801c069d40 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900040d7c40 ((gc_work).work){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900040d7c40 ((gc_work).work){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900040d7c40 ((gc_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900040d7c40 ((gc_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
locks held by kworker/1:5/5845: 6, on CPU#1:
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900038a7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900038a7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900038a7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900038a7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802b7021d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802b7021d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5917
 #3: ffff888026e8d1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff888026e8d1d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #4: ffff88807b75d1a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88807b75d1a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #5: ffff88805b321430 (&priv->cmd_lock){+.+.}-{4:4}, at: __pn533_send_async+0x279/0x730 drivers/nfc/pn533/pn533.c:470
locks held by kworker/1:7/5857: 6, on CPU#1:
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900037a7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900037a7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900037a7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900037a7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802b6b31d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802b6b31d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5917
 #3: ffff8880276e01d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff8880276e01d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #4: ffff88807b75f1a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88807b75f1a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #5: ffff88805b323430 (&priv->cmd_lock){+.+.}-{4:4}, at: __pn533_send_async+0x279/0x730 drivers/nfc/pn533/pn533.c:470
locks held by syz.3.20/5891: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by kworker/0:5/5892: 6, on CPU#0:
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90003757c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90003757c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90003757c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90003757c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802b3af1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802b3af1d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5917
 #3: ffff88807e3401d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88807e3401d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #4: ffff88807dabf1a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88807dabf1a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #5: ffff888033f02430 (&priv->cmd_lock){+.+.}-{4:4}, at: __pn533_send_async+0x279/0x730 drivers/nfc/pn533/pn533.c:470
locks held by syz.0.17/5893: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.1.18/5894: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.5.21/5895: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by kworker/0:7/5897: 6, on CPU#0:
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90003727c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90003727c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90003727c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90003727c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802b6051d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802b6051d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5917
 #3: ffff88805c6c81d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88805c6c81d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #4: ffff8880276e71a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff8880276e71a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #5: ffff8880223c8430 (&priv->cmd_lock){+.+.}-{4:4}, at: __pn533_send_async+0x279/0x730 drivers/nfc/pn533/pn533.c:470
locks held by syz.2.19/5898: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by kworker/0:11/5986: 6, on CPU#0:
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888021eb4d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90002f47c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90002f47c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90002f47c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90002f47c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802b5c61d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802b5c61d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5917
 #3: ffff88802d7d31d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88802d7d31d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #4: ffff88805ca1a1a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88805ca1a1a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #5: ffff88805c436430 (&priv->cmd_lock){+.+.}-{4:4}, at: __pn533_send_async+0x279/0x730 drivers/nfc/pn533/pn533.c:470
locks held by syz.6.22/5988: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.4.26/5989: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.7.23/5990: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.8.24/5991: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.9.25/5992: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.3.27/6065: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.0.28/6085: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.1.29/6086: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.5.31/6087: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.2.30/6088: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.6.32/6160: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.4.33/6173: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.7.34/6174: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.9.36/6175: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.8.35/6176: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.3.37/6260: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.0.38/6267: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.1.39/6268: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.5.41/6269: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.2.40/6270: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.6.42/6345: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.7.44/6360: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.4.43/6362: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.8.45/6363: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz.9.46/6364: 1, on CPU#1:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz-executor/6384: 1, on CPU#0:
 #0: ffffffff91255c80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff91255c80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:366 [inline]
 #0: ffffffff91255c80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc10/0x1c30 net/core/rtnetlink.c:4219
locks held by syz.3.47/6387: 1, on CPU#0:
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #0: ffff88802b5801d8 (&dev->mutex){....}-{4:4}, at: usbdev_open+0x151/0x770 drivers/usb/core/devio.c:1054
locks held by syz-executor/6389: 3, on CPU#0:
 #0: ffffffff91255c80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff91255c80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:366 [inline]
 #0: ffffffff91255c80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc10/0x1c30 net/core/rtnetlink.c:4219
 #1: ffff888043100e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2864 [inline]
 #1: ffff888043100e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 #1: ffff888043100e70 (&dev_instance_lock_key#23){+.+.}-{4:4}, at: do_setlink+0x3d4/0x4670 net/core/rtnetlink.c:3181
 #2: ffffffff8fd62ca8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:311 [inline]
 #2: ffffffff8fd62ca8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2d0/0x770 kernel/rcu/tree_exp.h:966
locks held by syz-executor/6403: 4, on CPU#1:
 #0: ffff888037f74460 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2756 [inline]
 #0: ffff888037f74460 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x22b/0xba0 fs/read_write.c:683
 #1: ffff888041778880 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1d8/0x540 fs/kernfs/file.c:336
 #2: ffff88802a82be18 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff88802a82be18 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x22b/0x540 fs/kernfs/file.c:337
 #3: ffffffff90acd060 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd6/0x370 drivers/net/netdevsim/bus.c:234
locks held by syz-executor/6410: 7, last CPU#0:
 #0: ffff888037f74460 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2756 [inline]
 #0: ffff888037f74460 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x22b/0xba0 fs/read_write.c:683
 #1: ffff88804177a880 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1d8/0x540 fs/kernfs/file.c:336
 #2: ffff88802a82be18 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff88802a82be18 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x22b/0x540 fs/kernfs/file.c:337
 #3: ffffffff90acd060 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd6/0x370 drivers/net/netdevsim/bus.c:234
 #4: ffff8880485e1128 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff8880485e1128 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff8880485e1128 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb9/0x880 drivers/base/dd.c:1369
 #5: ffff8880485e0258 (&devlink->lock_key#25){+.+.}-{4:4}, at: nsim_drv_remove+0x50/0x170 drivers/net/netdevsim/dev.c:1724
 #6: ffff88804de3f160 (&sb->s_type->i_mutex_key#9/2){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1069 [inline]
 #6: ffff88804de3f160 (&sb->s_type->i_mutex_key#9/2){+.+.}-{4:4}, at: __simple_recursive_removal+0x19a/0x520 fs/libfs.c:619

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 32 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:123
 nmi_trigger_cpumask_backtrace+0x17d/0x390 lib/nmi_backtrace.c:66
 trigger_all_cpu_backtrace include/linux/nmi.h:164 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 16 Comm: pr/ttyS0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:409
Code: e8 3e 6d 53 fc 44 89 f9 d3 e3 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 5f 4d c4 fc 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f c3 cc cc cc cc cc 44 89 f9 80 e1 07
RSP: 0018:ffffc900001578b8 EFLAGS: 00000002
RAX: 1ffffffff37a9700 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: ffffffff8574a2e0 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff9bd4be60 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888123bbf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f7f13500 CR3: 0000000073720000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:128 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:150 [inline]
 wait_for_lsr+0x184/0x2f0 drivers/tty/serial/8250/8250_port.c:2013
 serial8250_fifo_wait_for_lsr_thre drivers/tty/serial/8250/8250_port.c:3270 [inline]
 __serial8250_console_fifo_write+0xcd/0x3e0 drivers/tty/serial/8250/8250_port.c:3345
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3378 [inline]
 __serial8250_console_write drivers/tty/serial/8250/8250_port.c:3432 [inline]
 serial8250_console_write+0xa7e/0x1200 drivers/tty/serial/8250/8250_port.c:3496
 nbcon_emit_next_record+0xef5/0x1a90 kernel/printk/nbcon.c:-1
 nbcon_emit_one kernel/printk/nbcon.c:1157 [inline]
 nbcon_kthread_func+0x679/0x880 kernel/printk/nbcon.c:1271
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
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
