Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAA2264C0
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 05:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787116966; cv=none; b=Ehhd52NCRh/022SEQ6n2bnwM/VH0X0Cz3+UN0v3kIUVp3neEsWDcQ/z+0rkbYCHQIn3QNXdyG/ipmHMonbfPny8aL2LNg96Edz/2S4shN1ASkqXh6dxfKAN2rK/y1vSqXVWF7rRlXNqCVEJsXo7NKoqmlHlZYjyMY62KRIOKeX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787116966; c=relaxed/simple;
	bh=zLGKfpFVpvTKysp73BiHdafFNbAOOjcW2hoYffmXx1Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HFhPScToocN/etGD5F7HtYKFn9eeFkK1zRK4SAMFiHEYd2RgofOwPmudpA62hR6QpG3KIfX0sS2p2XdP31niZjGWXe0OnT8la3mawwx1f9ZJCrF+TwjDb+6u6/dW6rUQhUDhBR6qXY1CHGGRUUKbb/xIgHy+pMO2EXOq5bIW62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4b28d9952a5so945586b6e.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 22:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787116964; x=1787721764;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4jdYzixkR4xffbs5/m+OOw2qi2WWx8yCuZKRPQjX7oU=;
        b=tQwb4QO9V9ulq96JzNKaHMnVcIlcsu59ihT5VH/xzvmThvJlmUneaZU18SAsP6uQam
         sTK2Kwa+Dre3ea9TJXpETK7IqQ2o3CuVBorYkIkbB4x9nd5HW6JMvyOI0pYvYRnkiZ1e
         o3eRQoxPtVVLKokLAGx9MExQy0j88fj6KWUCCmBDbMnra2e28me7Ccpwo+CHY99MJOFj
         d/6GVXH7OHmt9cv3ONjP6h9AQSd0VI4YUiF0aQQ9dvzvCVwmFG15zEZA2qlwFJztqs7S
         ncQLXlMAZ1v/yYhyEPnlJd6X9Qwn0yVSp9ZBLK8loHWrj6ek2+pmm0FOFTNLaYaJ2qZw
         r/3g==
X-Forwarded-Encrypted: i=1; AHgh+RrauX1G8hKLAxRwf3TYr/INONNCJz/U6VJnqnIsOGwXAX5IEJdN07R01n3ZDm5xYsyYSUC99Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaH9xAavsMhpBu/izPGXUpBmPlBVcjY2S2NS8TD+Sf56VombpZ
	toL0IIhbxHhlMqCBcoWaAjmyUTsCCs9oCgn8txCpg2v8Avg5EPOrSnT9uohVu9+WpcjXO/P1S/V
	DkFgdvSslat/BH4FGy2eOuPyzuv10SxkDnkxGO3Afa0AHlVlru3j9KkzcoIM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1525:b0:4b2:8e51:aac2 with SMTP id
 5614622812f47-4b2bc93b5cbmr1792453b6e.8.1787116963849; Tue, 18 Aug 2026
 22:22:43 -0700 (PDT)
Date: Tue, 18 Aug 2026 22:22:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a853da3.ae6ddae5.3da009.0006.GAE@google.com>
Subject: [syzbot] [net?] [nfc?] KASAN: slab-out-of-bounds Read in __dynamic_pr_debug
From: syzbot <syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com>
To: davem@davemloft.net, david@ixit.cz, edumazet@google.com, horms@kernel.org, 
	krzk@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    21d6ac051080 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13653679580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=1e3df0852e82c21ca418
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/88380e2ddcb9/disk-21d6ac05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5dba5c2896b7/vmlinux-21d6ac05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52ac739e37e0/Image-21d6ac05.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com

dvmrp0: entered allmulticast mode
==================================================================
BUG: KASAN: slab-out-of-bounds in string_nocheck+0xd8/0x140 lib/vsprintf.c:648
Read of size 1 at addr ffff0000c2554ae1 by task syz.2.798/8384

CPU: 1 UID: 0 PID: 8384 Comm: syz.2.798 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xb0/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0x8c/0xc4 mm/kasan/report.c:595
 __asan_report_load1_noabort+0x20/0x2c mm/kasan/report_generic.c:378
 string_nocheck+0xd8/0x140 lib/vsprintf.c:648
 string+0x8c/0xc8 lib/vsprintf.c:730
 vsnprintf+0x880/0xd10 lib/vsprintf.c:2945
 va_format lib/vsprintf.c:1725 [inline]
 pointer+0x5e8/0x6b4 lib/vsprintf.c:2573
 vsnprintf+0x618/0xd10 lib/vsprintf.c:2949
 vprintk_store+0x344/0xb94 kernel/printk/printk.c:2307
 vprintk_emit+0x1bc/0x514 kernel/printk/printk.c:2455
 vprintk_default+0x54/0x80 kernel/printk/printk.c:2494
 vprintk+0x9c/0x114 kernel/printk/printk_safe.c:82
 _printk+0xe0/0x130 kernel/printk/printk.c:2504
 __dynamic_pr_debug+0x148/0x1e4 lib/dynamic_debug.c:879
 nfc_llcp_wks_sap net/nfc/llcp_core.c:344 [inline]
 nfc_llcp_get_sdp_ssap+0x350/0x3fc net/nfc/llcp_core.c:420
 llcp_sock_bind+0x2e0/0x58c net/nfc/llcp_sock.c:114
 __sys_bind_socket net/socket.c:1920 [inline]
 __sys_bind+0x1c4/0x268 net/socket.c:1951
 __do_sys_bind net/socket.c:1956 [inline]
 __se_sys_bind net/socket.c:1954 [inline]
 __arm64_sys_bind+0x84/0x9c net/socket.c:1954
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590

Allocated by task 8384:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:78
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:570
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_node_track_caller_noprof+0x434/0x6d4 mm/slub.c:5471
 kmemdup_noprof+0x44/0x8c mm/util.c:138
 kmemdup_noprof include/linux/fortify-string.h:715 [inline]
 llcp_sock_bind+0x2b0/0x58c net/nfc/llcp_sock.c:107
 __sys_bind_socket net/socket.c:1920 [inline]
 __sys_bind+0x1c4/0x268 net/socket.c:1951
 __do_sys_bind net/socket.c:1956 [inline]
 __se_sys_bind net/socket.c:1954 [inline]
 __arm64_sys_bind+0x84/0x9c net/socket.c:1954
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590

The buggy address belongs to the object at ffff0000c2554ae0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 1-byte region [ffff0000c2554ae0, ffff0000c2554ae1)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff0000c2554a80 pfn:0x102554
flags: 0x5ffc00000000200(workingset|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000200 ffff0000c0001500 fffffdffc318aa10 fffffdffc30937d0
raw: ffff0000c2554a80 0000000800800069 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000c2554980: 00 fc fc fc 07 fc fc fc fa fc fc fc 07 fc fc fc
 ffff0000c2554a00: fa fc fc fc fa fc fc fc fa fc fc fc 07 fc fc fc
>ffff0000c2554a80: fa fc fc fc 05 fc fc fc 05 fc fc fc 01 fc fc fc
                                                       ^
 ffff0000c2554b00: fa fc fc fc 05 fc fc fc 00 fc fc fc 00 fc fc fc
 ffff0000c2554b80: 00 fc fc fc 00 fc fc fc fa fc fc fc 00 fc fc fc
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
