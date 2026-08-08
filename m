Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF633B14B6
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219834; cv=none; b=Ybx02IQIA+IHFGk04zBrjtcOoNFNSM+R7EhMMAfesj+8nffK0cEbMYafpkt0wVUHYCJ4ODIMh9JzSB0KFg9V397lET2uz1w+cE8YCe1kde92qZtnl6uyggiju71u2ppwvgKxjDBCm/oCnSd+IEtBUylZ5HUPu+CUOT2Vsh9lzmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219834; c=relaxed/simple;
	bh=K+WjQb2QRaZMmsDC9lRnHGrtcqT4lUg5LzTKfgMMjdY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LuMRO0ZMaufu/jcWp+oEk+pdAQdtYTnYj5a312yAwp2MtfHK7xje6LgXvSLN/UakYMhAxS+R1+Cz6XOSNuKnMgCEao7WMCv94reMEYECFFWqVVuEMKSZWh8U5a6Ke+27WfE+YJI9akLJlCehxFnBewFzMuQMPNZas1Fz+43uKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-4519fdc5145so690411fac.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 13:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786219831; x=1786824631;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PBfcAZEEzM9IT3BBX5aXyz/xvHwpceg7nRUDkBwJfoc=;
        b=stDbtfAlZeUHoM7FrYVbAHhRQ2bEgSm//tDrbN9s56zfRj4WMD6Vio61O8NDxO+ZQY
         foOijbl30OV5D9G5uCful8dpvdylXgh4Dc6mb1Ij2NT/5uqmbrXV8/gYeZrV5OWbLbG3
         Qnz8qUaM1n67IeUBH5C2DSmENY9bw6mqmkdqGS2O4C9o5Ly3oU314DDsHODtC+tMAIVb
         LDqPaw/yPAoElVyRGKUgNm68Axm2dULFuqf49czDAVs15WRVmyIcUSs0P1nSFtdmB73U
         9zTXelawaNgoa3SzysUxaOIsGMMnTQ1Wp/XHOyIzt1gWNBsk/8zfh7AyXuN2fpIV9OQx
         8Beg==
X-Forwarded-Encrypted: i=1; AHgh+RqX8tK0KWeZOfWlzOhG6jOBzEGL+HqHCchydq0NYjkXvQxABUsPlfEfVP71nvvsviITuiAzFUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0MObqdoANyHMEWaxVM0TBaHGCYEtj1BYiqlzRdIwe9xvl9T3o
	ooiK1aIVkJTKiNR8Pa73YY39QtutSr+UgZ+7ekMXit6qQuPeuyNzx8wtMS5in9NYsbeIp3DYt9X
	PIk+aMceNS4daNKYHB1F+6pHXkUO6wDz/d3mZQ2y10qR7PeDOV93VKesIkDo=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:170e:b0:497:df42:1e05 with SMTP id
 5614622812f47-4b13323c85bmr10329586b6e.8.1786219831343; Sat, 08 Aug 2026
 13:10:31 -0700 (PDT)
Date: Sat, 08 Aug 2026 13:10:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a778d37.01d0871a.3a0d52.0071.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in nsim_bus_dev_max_vfs_write
From: syzbot <syzbot+034625f56d7756bdd6f7@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0d8395707651 Merge tag 'soc-fixes-7.2-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1291fcc6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acc0a882b963ae23
dashboard link: https://syzkaller.appspot.com/bug?extid=034625f56d7756bdd6f7
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fcd7b9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2018c5f56c1d/disk-0d839570.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3bfeae099eec/vmlinux-0d839570.xz
kernel image: https://storage.googleapis.com/syzbot-assets/37bf23e44126/bzImage-0d839570.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+034625f56d7756bdd6f7@syzkaller.appspotmail.com

INFO: task syz.2.3306:9302 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.3306      state:D stack:28248 pid:9302  tgid:9302  ppid:5736   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7383
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0xccc/0x1bd0 kernel/locking/mutex.c:821
 nsim_bus_dev_max_vfs_write+0x206/0x410 drivers/net/netdevsim/dev.c:276
 full_proxy_write+0x135/0x1a0 fs/debugfs/file.c:388
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdede59e0d9
RSP: 002b:00007ffd58ff29c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fdede825fa0 RCX: 00007fdede59e0d9
RDX: 0000000000000001 RSI: 0000200000000180 RDI: 0000000000000003
RBP: 00007fdede635024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdede825fac R14: 00007fdede825fa0 R15: 00007fdede825fa0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8ebe8200 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8ebe8200 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8ebe8200 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x3d/0x184 kernel/locking/lockdep.c:6775
1 lock held by klogd/4952:
 #0: ffff8880b843b520 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2c/0x140 kernel/sched/core.c:667
2 locks held by getty/5353:
 #0: ffff8880373500a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032332e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x419/0x14e0 drivers/tty/n_tty.c:2211
7 locks held by syz-executor/8899:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff8880236dc480 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
 #4: ffff88805b6db128 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1102 [inline]
 #4: ffff88805b6db128 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff88805b6db128 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb2/0x620 drivers/base/dd.c:1369
 #5: ffff88805b6da258 (&devlink->lock_key#2){+.+.}-{4:4}, at: nsim_drv_remove+0x4a/0x1e0 drivers/net/netdevsim/dev.c:1799
 #6: ffff888059584140 (&sb->s_type->i_mutex_key#8/2){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1069 [inline]
 #6: ffff888059584140 (&sb->s_type->i_mutex_key#8/2){+.+.}-{4:4}, at: __simple_recursive_removal+0xe0/0x5c0 fs/libfs.c:619
2 locks held by syz.2.3306/9302:
 #0: ffff888020aea450 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff88805b6da258 (&devlink->lock_key#2){+.+.}-{4:4}, at: nsim_bus_dev_max_vfs_write+0x206/0x410 drivers/net/netdevsim/dev.c:276
2 locks held by syz.4.3307/9303:
 #0: ffff888020aea450 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff88805b6da258 (&devlink->lock_key#2){+.+.}-{4:4}, at: nsim_bus_dev_max_vfs_write+0x206/0x410 drivers/net/netdevsim/dev.c:276
2 locks held by syz.1.3308/9304:
 #0: ffff888020aea450 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff88805b6da258 (&devlink->lock_key#2){+.+.}-{4:4}, at: nsim_bus_dev_max_vfs_write+0x206/0x410 drivers/net/netdevsim/dev.c:276
2 locks held by syz.3.3309/9305:
 #0: ffff888020aea450 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff88805b6da258 (&devlink->lock_key#2){+.+.}-{4:4}, at: nsim_bus_dev_max_vfs_write+0x206/0x410 drivers/net/netdevsim/dev.c:276
4 locks held by syz-executor/9361:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff8880716e6c80 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9365:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff888034a0ec80 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9368:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff888079407080 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9374:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff888033b25080 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9441:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff88807946c080 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9466:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff888071f27480 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9470:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff88802cd2ac80 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9471:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff888059892080 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9472:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff888071c50080 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9546:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff888056c2ac80 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9568:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff88802172f080 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9571:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff888033bf1480 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9572:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff888033ce6480 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9576:
 #0: ffff888025c42450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff88807b9d7c80 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888029fee0f8 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #3: ffffffff900046a0 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x480 drivers/net/netdevsim/bus.c:234

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x12d/0x151 lib/nmi_backtrace.c:122
 nmi_trigger_cpumask_backtrace+0x21c/0x2a0 lib/nmi_backtrace.c:65
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x141/0x190 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xcb1/0x1030 kernel/hung_task.c:561
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
RIP: 0010:rcu_read_unlock include/linux/rcupdate.h:869 [inline]
RIP: 0010:batadv_iv_ogm_slide_own_bcast_window net/batman-adv/bat_iv_ogm.c:801 [inline]
RIP: 0010:batadv_iv_ogm_schedule_buff+0x724/0x15e0 net/batman-adv/bat_iv_ogm.c:862
Code: 00 00 48 8b ad c8 01 00 00 48 85 ed 74 12 e8 03 cb 89 f6 48 81 ed c8 01 00 00 0f 85 e3 fe ff ff 4c 8b 74 24 08 e8 ec ca 89 f6 <e8> 37 88 38 00 31 ff 89 c5 89 c6 e8 4c c5 89 f6 85 ed 0f 85 65 03
RSP: 0018:ffffc90000127aa8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff8b808e0a
RDX: ffff88801eac0000 RSI: ffffffff8b8089f4 RDI: ffff88801eac0000
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888077fc5000
R13: 000000000b46a101 R14: 0000000000000068 R15: ffff8880794561c0
FS:  0000000000000000(0000) GS:ffff888123eed000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e4c0393be0 CR3: 000000000e994000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:918 [inline]
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:911 [inline]
 batadv_iv_send_outstanding_bat_ogm_packet+0x548/0x800 net/batman-adv/bat_iv_ogm.c:1807
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
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
