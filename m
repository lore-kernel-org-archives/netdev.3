Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E33264D5
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030599; cv=none; b=EufyJkDKONbGBncN6RY8Lg9aIMJluy9KQ5HPV8zY0LE5/IR14FmKm4JKxwjVN2m34N3I6mtpfcE/LXMqllY67pCHIcAPC/s8h9aQiGYRSFxdKecFSPLuY0VBOWhzTil6AluWxAYzDCfkM8Zxy+TMER3t1M9ZW83/hIIfEtOy4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030599; c=relaxed/simple;
	bh=X4b87L5ecjSjKnaUKSrQ5m2mVH/82ufWNzyMskRHz+4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QY7Nw/VDQaiyIegJcnrE3MmyHPnFkgXWzfCGnuqqhSUmOBbin++n1VVbGWgBAdINMFUJ4EsKhT5dZii2UBZogOcMffZIlcMRa67CkJy4yHHLDklAndFyZR0+wtJexX08ap0en0a5CAdAbwe/InZt4oYpISNkGGd99vYkWcckd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-49f3a97f1caso1174928b6e.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 08:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030597; x=1786635397;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yg5XgpDj8AgqqB0BK6OhjlrRk5Vk4TngM7ime0NiK3E=;
        b=XOWkm3W9UJEu2k2OyieBqGKzhZ6Ko9ZxuepAyMorQ+2Rz/Z+5G2K7YW13A2r5it7lQ
         HFMEzlvCW2EOnEe4hTIzIUUdNKGz5p+fie19S224f9mXA6DgqzlCW2C1gQ73zpRADWgA
         F5XmVzbCbCtg0u3eaG7xKVW/dv2iM1lypVPhalSjKRdKNU5AftbaFdXTExmZmMyvLeoh
         lSE0MzPrJjaj6cAuxfJ6ZrKKhey0tOG90+I6cwxMvvsgUlcZCnjMIot5muvLwKP9bWbU
         NX/7x7PSkhC2XO+aZzUWVTSVFEjYrHskZVj2Or/muxiQnDnllnzRFOolnmabQAhyukXF
         fnPw==
X-Forwarded-Encrypted: i=1; AHgh+RpbNbFPH14acBH/XDp0bk1FRGw4S1MB/w1JmfsNp88K5qFgWWdgViKo/lsxXT7G+1XlCh3jfoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4sVaQzFgpnUrG1c7L+yZx5BoAYGL8NkYdwWCylrtFfFMcduy
	02ATFi5gPymz/GCHE0dbbEtkbjKZegv/JEemQxF19vSL5pxGyWlTv9pw8dNkoXVE06YsCxS67aU
	UzC+QFrhuW11VhTHpAWddh06XI84IiFqIQgPpd9xR5DqHYDVd4lZAF7/YvRc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1927:b0:497:d371:21c8 with SMTP id
 5614622812f47-4afae27b56emr10300335b6e.19.1786030596845; Thu, 06 Aug 2026
 08:36:36 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:36:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a74aa04.01d0871a.3a0d52.0025.GAE@google.com>
Subject: [syzbot] [intel-wired-lan?] UBSAN: shift-out-of-bounds in e100_eeprom_load
From: syzbot <syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	przemyslaw.kitszel@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15087e32580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ed13b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162c5bb9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fb497cc0c8d/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/663ccee34982/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com

e1000e 0000:00:02.0 eth1: removed PHC
e1000e 0000:00:02.0 eth1: NIC Link is Down
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/net/ethernet/intel/e100.c:768:21
shift exponent 65529 is too large for 32-bit type 'int'
CPU: 0 UID: 0 PID: 5934 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
 e100_eeprom_load.cold+0x55/0x9e drivers/net/ethernet/intel/e100.c:768
 e100_probe+0xd07/0x1ab0 drivers/net/ethernet/intel/e100.c:2921
 local_pci_probe+0xdd/0x1b0 drivers/pci/pci-driver.c:332
 pci_call_probe+0x176/0x800 drivers/pci/pci-driver.c:394
 __pci_device_probe drivers/pci/pci-driver.c:455 [inline]
 pci_device_probe+0x1cd/0x370 drivers/pci/pci-driver.c:489
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 device_driver_attach+0xd1/0x220 drivers/base/dd.c:1203
 bind_store+0xf4/0x190 drivers/base/bus.c:267
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f60d819e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc13c52ae8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f60d8425fa0 RCX: 00007f60d819e019
RDX: 000000000000000c RSI: 0000200000000280 RDI: 0000000000000005
RBP: 00007f60d823500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f60d8425fac R14: 00007f60d8425fa0 R15: 00007f60d8425fa0
 </TASK>
---[ end trace ]---


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
