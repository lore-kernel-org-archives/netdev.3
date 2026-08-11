Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5598283FCF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407881; cv=none; b=ikzcOc1a+iE9eIGGEBOTDeYXiz8s5yVQEz2mDV4JFFTV6Hr/VpJOj+xH/hs+n11/tPQ+A7qV3c8+V4zqE0bdpsAlRqc8W49GJd+ODzTz++vvaGjfwWjmp5dKm/sQAwPvbe1Rw7QnUTeqXEmqe+DQ0cxVsZgTnqrOzjdVmprJtrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407881; c=relaxed/simple;
	bh=zaT3w+byGPNooBHKLRI6E4tYpVh9Cr1pq+X2kvGEWok=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aHZCg33PrxI1ve9WoN9TO2SPX9nx096FcBlwiEL1aRmwnsie5E9IRvWLkQO/pd6xIwsCtDD9s+xzgWsPqe6tM22J+Zbi+mU85OiwKyKjH5jjtoZ8to/AGFzt3DdBVUtVHwFs01uEHFgy9hz3woL7Dz91UaCi+vBE81GLWNJ+kn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4ab4ca7ce3fso2378082b6e.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786407879; x=1787012679;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UiGGue9L5xMMwAImhWVVc3948hLhf/ZrXuZQe8xPGNo=;
        b=mU8bUtDtf9Qtq669cn/BtFOp3xYV5V3CiPoFwOFdbvnD+p6pMl7o5jqLDag1ACk7sB
         gWKfJJYFfVSMlnelOd6QAJ1cUIjhkAVwEp99OQKo+PFiAxlwnMbDQU2BcgHcMnLrsmXp
         lOlNn/10f0JwAOz23WXMcRrzLFu+XZ7kyQHqTjVHASnAYjOZ8rB3aC8ZIV/eC8OXZCGo
         1P5vR9GBSTYRUxhQ508x4vHlL+MQ4EC1097iPwIHsgJy2ITw3RREsElVff03y/YGvnnO
         08fDPEoJi4+lSaCFgC6WrSW4Y0Am0coQkrIvHfqoQHRZp3B4yFakfxtUIXOzdScyIJva
         tYKg==
X-Forwarded-Encrypted: i=1; AHgh+RpU3IFrAEn8YhldPUQTada2/5qnLkWkm29Ko2N4bJGdjGibggMuMY7/Hh2VaYgin6xtuMP0ny8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkwloB7TkMCJIXVOaUvXXN1zVBuxelFc7uAz+bVNQcE9jaX51g
	nMyq+Lxxu2W/dKBbmHvmBKxQRgObMwDyCjODqjC46L+9ivG+AeFft6SmrWes4eHem/Dw5JFSoQY
	7cRqsR39Y+n9r+71GuJC5eMqiqBnJh9F4M+bWu2DoKLz8wO9ZrbbHiRzlS3I=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f0c:b0:4b1:b037:da8b with SMTP id
 5614622812f47-4b1e78869efmr2612129b6e.11.1786407878743; Mon, 10 Aug 2026
 17:24:38 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:24:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7a6bc6.01d0871a.3a0d52.00b4.GAE@google.com>
Subject: [syzbot] [net?] WARNING in __virt_to_phys (6)
From: syzbot <syzbot+204eda57286574703583@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7235a3e71949 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=134277b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccf4bea59f67007
dashboard link: https://syzkaller.appspot.com/bug?extid=204eda57286574703583
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd45635beaae/disk-7235a3e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7d2e6507223/vmlinux-7235a3e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5b5d8de4cea/Image-7235a3e7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+204eda57286574703583@syzkaller.appspotmail.com

------------[ cut here ]------------
virt_to_phys used for non-linear address: 00000000b1de4396 (0x17ffffe791001021)
WARNING: arch/arm64/mm/physaddr.c:15 at __virt_to_phys+0xe8/0x130 arch/arm64/mm/physaddr.c:12, CPU#0: dhcpcd/4400
Modules linked in:
CPU: 0 UID: 100 PID: 4400 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/02/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __virt_to_phys+0xe8/0x130 arch/arm64/mm/physaddr.c:12
lr : __virt_to_phys+0xe8/0x130 arch/arm64/mm/physaddr.c:12
sp : ffff8000997e72b0
x29: ffff8000997e72b0 x28: ffff800088b0b6a0 x27: ffff0000c7228000
x26: 17ffffe791001021 x25: 0000000000000204 x24: ffffc1ffc0000000
x23: ffff80008869e000 x22: 000f600000000000 x21: 000000000000002d
x20: 180fffe791001021 x19: 17ffffe791001021 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000001 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000002 x9 : b196a926009aaa00
x8 : b196a926009aaa00 x7 : ffff80008048e080 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000802f8070
x2 : 0000000100000000 x1 : ffff0000c7228000 x0 : 0000000000000000
Call trace:
 __virt_to_phys+0xe8/0x130 arch/arm64/mm/physaddr.c:12 (P)
 virt_to_phys arch/arm64/include/asm/memory.h:369 [inline]
 virt_to_pfn arch/arm64/include/asm/memory.h:383 [inline]
 virt_to_slab mm/slab.h:193 [inline]
 qlink_to_cache mm/kasan/quarantine.c:131 [inline]
 qlist_free_all+0x58/0x120 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x118/0x124 mm/kasan/quarantine.c:286
 __kasan_kmalloc+0x2c/0xb4 mm/kasan/common.c:406
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_node_track_caller_noprof+0x434/0x6d4 mm/slub.c:5471
 kmalloc_reserve+0x118/0x214 net/core/skbuff.c:637
 __alloc_skb+0x230/0x610 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 alloc_skb_with_frags+0xb8/0x690 net/core/skbuff.c:6769
 sock_alloc_send_pskb+0x740/0x850 net/core/sock.c:3013
 unix_dgram_sendmsg+0x434/0x1078 net/unix/af_unix.c:2136
 unix_seqpacket_sendmsg+0x108/0x1d0 net/unix/af_unix.c:2537
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg+0xc8/0x17c net/socket.c:790
 sock_write_iter+0x220/0x310 net/socket.c:1241
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x51c/0xa0c fs/read_write.c:687
 ksys_write+0x12c/0x228 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x84/0x98 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x19c/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
irq event stamp: 345484
hardirqs last  enabled at (345483): [<ffff800080491644>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (345484): [<ffff8000868e6198>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:425
softirqs last  enabled at (343926): [<ffff800084c14ca8>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:698
softirqs last disabled at (343924): [<ffff800084c14c90>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (343924): [<ffff800084c14c90>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:697
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address 005fffff638e0048
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0
[005fffff638e0048] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1]  SMP
Modules linked in:
CPU: 0 UID: 100 PID: 4400 Comm: dhcpcd Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/02/2026
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : _compound_head include/linux/page-flags.h:226 [inline]
pc : page_slab mm/slab.h:159 [inline]
pc : virt_to_slab mm/slab.h:193 [inline]
pc : qlink_to_cache mm/kasan/quarantine.c:131 [inline]
pc : qlist_free_all+0x68/0x120 mm/kasan/quarantine.c:176
lr : virt_to_phys arch/arm64/include/asm/memory.h:369 [inline]
lr : virt_to_pfn arch/arm64/include/asm/memory.h:383 [inline]
lr : virt_to_slab mm/slab.h:193 [inline]
lr : qlink_to_cache mm/kasan/quarantine.c:131 [inline]
lr : qlist_free_all+0x58/0x120 mm/kasan/quarantine.c:176
sp : ffff8000997e72e0
x29: ffff8000997e72e0 x28: ffff800088b0b6a0 x27: ffff0000c7228000
x26: 17ffffe791001021 x25: 0000000000000204 x24: ffffc1ffc0000000
x23: ffff80008869e000 x22: 17ffffe791001021 x21: ffffff1000040000
x20: 0000000000000000 x19: ffff8000997e7330 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000001 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000002 x9 : 0000000000000000
x8 : 005fffff638e0040 x7 : ffff80008048e080 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000802f8070
x2 : 0000000100000000 x1 : ffff0000c7228000 x0 : 18007fe923801021
Call trace:
 virt_to_slab mm/slab.h:193 [inline] (P)
 qlink_to_cache mm/kasan/quarantine.c:131 [inline] (P)
 qlist_free_all+0x68/0x120 mm/kasan/quarantine.c:176 (P)
 kasan_quarantine_reduce+0x118/0x124 mm/kasan/quarantine.c:286
 __kasan_kmalloc+0x2c/0xb4 mm/kasan/common.c:406
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_node_track_caller_noprof+0x434/0x6d4 mm/slub.c:5471
 kmalloc_reserve+0x118/0x214 net/core/skbuff.c:637
 __alloc_skb+0x230/0x610 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 alloc_skb_with_frags+0xb8/0x690 net/core/skbuff.c:6769
 sock_alloc_send_pskb+0x740/0x850 net/core/sock.c:3013
 unix_dgram_sendmsg+0x434/0x1078 net/unix/af_unix.c:2136
 unix_seqpacket_sendmsg+0x108/0x1d0 net/unix/af_unix.c:2537
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg+0xc8/0x17c net/socket.c:790
 sock_write_iter+0x220/0x310 net/socket.c:1241
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x51c/0xa0c fs/read_write.c:687
 ksys_write+0x12c/0x228 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x84/0x98 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x19c/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
Code: d346fc08 927acd08 cb151908 8b180108 (f9400509) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d346fc08 	lsr	x8, x0, #6
   4:	927acd08 	and	x8, x8, #0x3ffffffffffffc0
   8:	cb151908 	sub	x8, x8, x21, lsl #6
   c:	8b180108 	add	x8, x8, x24
* 10:	f9400509 	ldr	x9, [x8, #8] <-- trapping instruction


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
