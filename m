Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FC3B1BD
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786234236; cv=none; b=ZhZIcl0TnBHt/C4FliyZlQCl2o0RGJuZ+2ylXQOxGBLuJtLvPokIEmXYFSA1m6BPNa59QUklB3k7DXV0MG2fQ6kVQQ6AO8Y/+PxtMRw4S3w9edHBMVl83nY4aTdtveCaiCLUtpuvpvju64MzORXjgC/fhfRSir97VKrI+luPcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786234236; c=relaxed/simple;
	bh=EVjqzTyBIQUScx4OoilyVB6MkIju0Cew2ZRpO2LJ5s4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V9oCJzx7pc/Q4tdwNaHZjj5XYqhJIFMwk9cxqjuuuZc+BC0IgVUOKN1KCJlcR6AP+bANsOA0HdCSqob11++2umb0iIk6Ttu93TaOgfhGAvo0e1/+P07I2NniKD4jQkf/u16Iyv5s6zZ1p+Vvql10HQEFk+QN/6dfdViLZOD0u4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4b1bc2e44e0so676085b6e.0
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 17:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786234234; x=1786839034;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MHcrVMejL/6U7ZutYrRKD6/LsQCEvCJ8P9YiT8P97/A=;
        b=cKBSw6TdFndk3XZKP13oN9ew9Gx9F3S7QwLQIz//gXZhwPKKejl0RDEunXxpFEniZP
         NT4yhEA1Htwyjx6X3zdaRgj0CWqh/oM5GNcMF2SETjU+GfTVoyN7cO3HWrxCNN0wH9G5
         JzFjrvRXkQGINfzGPkQN3pHHHSsMiY9IrGSQJq9+PBIR8MCXPEuBXUHVbs+hoMu9XxSb
         enqtFydB1CWw0dI8D/5F2uqRmZ7mJZDG+RAuS6n1/nrDp26GodbsnnO/RQP71ovNwUrT
         KvaObLpWluVwFAFLdN59XS9PWk0TtFh9WT8xa3zMebX1VfK/6jByO1wGVNy76dqy0n9U
         Xa8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrxERdqp7XVuhOFUtBLfPJXkeBlZDuLJ5lOXrFnER/nyWdS9TMG3zQXO+DsJjNhiiFe1Zlo35E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2TL23CPxqwknj0VZBFeP/Sm2tOCVoFgjWwqFhn9Z55Jwr/Ks8
	W9tlJrn4P+eYuvZ36HTj9R7yRtb3h7ByuqKvCrA+vF2g3kula9HglzvGyJwLt0cp8BpF1zbsjKO
	bzpAADjFnGIsp3o1pZFTVb3fthrt12+Ol3m2XX38iCFuSGNLvWB6TscsoQw8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2445:b0:497:da47:df4d with SMTP id
 5614622812f47-4afadfcf73bmr17367700b6e.16.1786234234039; Sat, 08 Aug 2026
 17:10:34 -0700 (PDT)
Date: Sat, 08 Aug 2026 17:10:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a77c57a.01d0871a.3a0d52.007a.GAE@google.com>
Subject: [syzbot] [intel-wired-lan?] kernel panic: UBSAN: panic_on_warn set
 ... (3)
From: syzbot <syzbot+167d8196c0bada4210fa@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	przemyslaw.kitszel@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a24bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=167d8196c0bada4210fa
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fb497cc0c8d/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/663ccee34982/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+167d8196c0bada4210fa@syzkaller.appspotmail.com

Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 3 UID: 0 PID: 14356 Comm: syz.5.433 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 vpanic+0x552/0x970 kernel/panic.c:651
 panic+0xd1/0xe0 kernel/panic.c:788
 check_panic_on_warn kernel/panic.c:525 [inline]
 check_panic_on_warn.cold+0x19/0x34 kernel/panic.c:520
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
RIP: 0033:0x7f53bab9e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f53bba7f028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f53bae26090 RCX: 00007f53bab9e019
RDX: 000000000000000c RSI: 0000200000000280 RDI: 0000000000000006
RBP: 00007f53bac3500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f53bae26128 R14: 00007f53bae26090 R15: 00007fffaac44238
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
