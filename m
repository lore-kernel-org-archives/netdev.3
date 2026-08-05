Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329B156F45
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908368; cv=none; b=Wp7/bh7+8E7NGVjvNxNuTka4W5adx8LmRWdyEY/AH0NHl0YFVH7Em8XBMQOetC5K4OF13ujzNvmoNMZHXEsl3cbytk1Hn9dnj4wqtfaoilWlzgCoQodtJWK2xXg3r12X3ezhRSoym4tcDt2UgA06fKR+fa4mBTtqobeBPAhw3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908368; c=relaxed/simple;
	bh=5dkO/+MHHbLNQVuquxJBRi2O+U/g3DDfmq2qnK0XN9U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AdYXd235+CMoHbeRtdZaGI2qBtysuZuRQKkqAUzf900JxDbfGS7Jg7o2fkTJleDQXeqADtO3gNN+gE1FrBo5rEpo7W/claMS8DO7PJl5x+abbTvaKwzUAAf2Aq0ugb9JJWZo7SVy04PS53SfnuS1gb3U7I32MAkl3murc3hNVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7e99ff505c2so400421a34.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 22:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785908366; x=1786513166;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HLAjEQo6xRfqW4g5SgiyVPySEm6vIHHokNUrcSuFS/s=;
        b=KzJ+gSQay2HeJJrgS35bxec9x347GgvpprZZfWMSJHjAnKsnhdVNjSZkg/cmv4jMCK
         HV8V14PJoYC7cuozy1eCx4jRfDoMnQRM6iUaYoB7VrGu3jr4E8tgA5rJvaQ6qJm+E5D0
         e0PmLS5qWyTPiloduADUr06Z9Dxhba/6THjUlZJ2sVUVCetzMOzjz1RGrC5p0gWeqtzw
         asv8g1zd6fDw/jJ7DL+CEzZ5lIXKpediUQSq9S6o4Nl5zA+eQf+PZZu/u/cNJdpwEi09
         F8/Mt0y6bGb8V4afiIgxvW1aZsMIXmbqaaw0mReqv+EtnqPd/ClExAvpVw3fl/AcENBT
         pRUg==
X-Forwarded-Encrypted: i=1; AHgh+RpVNjFWZzHKa1P9vmeB1IfSLz5Un7AEjr2lXYJRR82NRgtrDgB1VE1m0JbfrSR9B2otdsItDTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVBqI4lEE5eDuopzp9Io3negQ5sItPfJ79UFYQ7DHQ6j7YQ4NM
	0EE3wT+v6kI4b2uyEYDml35yr9hoObUBJr8VnllG/pKpibl/dGwvS1hz01Hi74KF/Qkc5BxQbhb
	l4wBvXjFYY9v3s28JrHAazc4EARsLOQ4b2jhiJuW5uhjxr4UrbyZ/+UK88BQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8384:b0:6a0:ff94:df7b with SMTP id
 006d021491bc7-6ae970be67amr1965539eaf.35.1785908365950; Tue, 04 Aug 2026
 22:39:25 -0700 (PDT)
Date: Tue, 04 Aug 2026 22:39:25 -0700
In-Reply-To: <6a71fd31.9511d2ce.1fc5b9.033c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a72cc8d.13623e66.bdc14.004e.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in copy_from_sockptr
From: syzbot <syzbot+6c98d6eb7aabb6b1ad39@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, davem@davemloft.net, edumazet@google.com, 
	eric.dumazet@gmail.com, horms@kernel.org, kuba@kernel.org, 
	linux-atm-general-owner@lists.sourceforge.net, 
	linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7235a3e71949 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1596dbb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccf4bea59f67007
dashboard link: https://syzkaller.appspot.com/bug?extid=6c98d6eb7aabb6b1ad39
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167ecbb9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd45635beaae/disk-7235a3e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7d2e6507223/vmlinux-7235a3e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5b5d8de4cea/Image-7235a3e7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c98d6eb7aabb6b1ad39@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr+0x44/0x1b8 include/linux/sockptr.h:61
Read of size 84 at addr ffff0000d23743a0 by task syz.0.17/4925

CPU: 0 UID: 0 PID: 4925 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
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

Allocated by task 4925:
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

The buggy address belongs to the object at ffff0000d23743a0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 allocated 4-byte region [ffff0000d23743a0, ffff0000d23743a4)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff0000d2374460 pfn:0x112374
flags: 0x5ffc00000000200(workingset|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000200 ffff0000c0001500 ffff0000c0000348 fffffdffc32f1f10
raw: ffff0000d2374460 0000000800800041 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d2374280: 07 fc fc fc 07 fc fc fc 07 fc fc fc 07 fc fc fc
 ffff0000d2374300: 07 fc fc fc 07 fc fc fc 05 fc fc fc 05 fc fc fc
>ffff0000d2374380: fa fc fc fc 04 fc fc fc fa fc fc fc fa fc fc fc
                               ^
 ffff0000d2374400: fa fc fc fc 00 fc fc fc fa fc fc fc fa fc fc fc
 ffff0000d2374480: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
