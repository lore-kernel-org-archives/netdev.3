Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097C3515E6
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855284; cv=none; b=HtSFq0NCzDbGX+CDEWi1O1JWTRNyxG6Am3WrvIedJuJscl2Xfj/gmMjSA1SOzFqJo6oidYpopcOFKRb3xNMnKPUvabVPxjHBmYiqkCunMVZgA3ipo20ygwMiFOQhpKE9cZmXG1cJPPEUkNe1yIo/Hkz3JBttL154QQNYY6c2Icg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855284; c=relaxed/simple;
	bh=MHvfqMzWJCIzwPCPCdT7qnSES5IRseKtt11YKG6xgh4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ouPSnxYwR4HyaZHmwWZekddZdEAiVE6pHFASqqH/QlotZQTclEUbz23mAfoJg2Nc9yGdr6C0K/Bm5C5a/OVIICfGCuqyolk2rPqEVR9tZ0W37WyKuWQo875HJQFkv1JOe9CBlXyWNxah6uvSEWg7ZWOZMf0d4OWhK4fGBHBxmGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6ab1946bb8eso4508724eaf.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 07:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855282; x=1786460082;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UFZjNe0U8PqtcyKWiDu6G5GoYKJ0L+/pShagS309m68=;
        b=KfBOCf4QM6MJLRKYzo0C+qziRwEZ7vgg1uMGRY9lBUTMzVPp1CXIdGaMIDWeVYv41X
         nFSQupi9lRD9gIo/hx6Am0N3tHrzrrv2QM7rs1gOtgGQfRFeceVfsvbhLE94b7MMchEd
         IVBT9qtUvCXkQUuZSKYLJp3EgqF7BwvoZCCy1U2u4m3DnGqAHzBByyAM1ZNOWo4prsgR
         P6nFVk7/6sUnix8H/OgPxvNbTpHaweQdV7Zyl5NfYq0qdQWFMhcLU0JxChDZZAcl8jtV
         qRldpnjopClFo/Vi9GfpU49GaaZ6oXsxpfb7nPmJmQ7ccttHYTH5NLEyxITmoH7vIcJd
         uCng==
X-Forwarded-Encrypted: i=1; AHgh+RpKDybN+x1BB59Wr+jIDbCIJIz4CPrq15v4fP7CHinMK17lG5kXoqqxUAipInyUg1tC6cXtXak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtWTA420Tfd0i8exsK8Hzzyw9gzrdQWTn01qxugtGNnFf152S
	xHK2mFfuogERkGd9H1jQ+sk9saAKpzQt6yM1ucU3J5DgRExYUsgixAdQpfKTl2mdGZkgv+twVzv
	OwIxseK6K0FjfXXRFTLlEiYchRR/X7gzdzE3We5jbUUcND8gf5VRFvLJzuhw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:180f:b0:6aa:de29:651 with SMTP id
 006d021491bc7-6ae432d9c6fmr21903805eaf.16.1785855281830; Tue, 04 Aug 2026
 07:54:41 -0700 (PDT)
Date: Tue, 04 Aug 2026 07:54:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a71fd31.9511d2ce.1fc5b9.033c.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-out-of-bounds Read in copy_from_sockptr
From: syzbot <syzbot+6c98d6eb7aabb6b1ad39@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-atm-general@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7235a3e71949 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1429be32580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccf4bea59f67007
dashboard link: https://syzkaller.appspot.com/bug?extid=6c98d6eb7aabb6b1ad39
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd45635beaae/disk-7235a3e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7d2e6507223/vmlinux-7235a3e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5b5d8de4cea/Image-7235a3e7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c98d6eb7aabb6b1ad39@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr+0x44/0x1b8 include/linux/sockptr.h:61
Read of size 84 at addr ffff0000d50be5e0 by task syz.8.1592/10340

CPU: 1 UID: 0 PID: 10340 Comm: syz.8.1592 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/02/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xb0/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0x8c/0xc4 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x17c/0x1ac mm/kasan/generic.c:200
 __asan_memcpy+0x3c/0x84 mm/kasan/shadow.c:105
 copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
 copy_from_sockptr+0x44/0x1b8 include/linux/sockptr.h:61
 vcc_setsockopt+0x174/0x450 net/atm/common.c:725
 pvc_setsockopt+0x84/0xb0 net/atm/pvc.c:72
 do_sock_setsockopt+0x1f0/0x330 net/socket.c:2368
 __sys_setsockopt+0x104/0x170 net/socket.c:2393
 __do_sys_setsockopt net/socket.c:2399 [inline]
 __se_sys_setsockopt net/socket.c:2396 [inline]
 __arm64_sys_setsockopt+0xc8/0xe4 net/socket.c:2396
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594

Allocated by task 10340:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:78
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:570
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_noprof+0x340/0x6b8 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 __cgroup_bpf_run_filter_setsockopt+0x990/0xbbc kernel/bpf/cgroup.c:2103
 do_sock_setsockopt+0x2e8/0x330 net/socket.c:2350
 __sys_setsockopt+0x104/0x170 net/socket.c:2393
 __do_sys_setsockopt net/socket.c:2399 [inline]
 __se_sys_setsockopt net/socket.c:2396 [inline]
 __arm64_sys_setsockopt+0xc8/0xe4 net/socket.c:2396
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594

The buggy address belongs to the object at ffff0000d50be5e0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 allocated 1-byte region [ffff0000d50be5e0, ffff0000d50be5e1)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff0000d50beb00 pfn:0x1150be
flags: 0x5ffc00000000200(workingset|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000200 ffff0000c0001500 ffff0000c0000348 fffffdffc3001590
raw: ffff0000d50beb00 000000080080007e 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d50be480: fa fc fc fc 06 fc fc fc 05 fc fc fc 05 fc fc fc
 ffff0000d50be500: fa fc fc fc fa fc fc fc fa fc fc fc 06 fc fc fc
>ffff0000d50be580: 05 fc fc fc fa fc fc fc fa fc fc fc 01 fc fc fc
                                                       ^
 ffff0000d50be600: 06 fc fc fc 05 fc fc fc 05 fc fc fc 05 fc fc fc
 ffff0000d50be680: 05 fc fc fc 05 fc fc fc fa fc fc fc fa fc fc fc
==================================================================


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
