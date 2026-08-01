Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5675156F45
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542556; cv=none; b=pnxugIXr51diqws6q9gkfbM3mmki0Gv8OI7EjEdkYRT+xMrkbnrD2X/uvaoMmAePSNDablBOSvPFvpUvYplJiDDlmHcND2Vbc2O9NZiKWsNcYSCae/GaamD7f3TPM+pml8xWBf0arw1t+MNh2IOEeUSpHBZKbyVtK87POJivZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542556; c=relaxed/simple;
	bh=JaU3caxFVFwMyom75rwMTb7LERFctV23hSea/iGphe0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QRDPXYASUyPdMWjWvPNeuzHqMh3qfGgPV4lclMazlo0urIUa1c0R+8qgz7A9fgRRtE2w9OxytatCY5Mz7+z+8kE5f5t+lhZVcz153zUnMZN1U4mTuOe3+v/uatPGCJ0hdGodCx6SpY/kaRGn7V905C+4ao3e1PFpr3w2Mruv1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-495b0cf250dso1029093b6e.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 17:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785542553; x=1786147353;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFyCpefvMGzPrpmSLpCr1pgbbopabY4nKezDrskUMLM=;
        b=VaKj2V952GLP/4p2I0V3iPHoZhZnbbjyXaq+P1infko+vgWPhDRiVe7o0ALfu/bwj+
         KpvkcUJtIzMFOeCd3KzuTtwTZTLpHUcMa0UWuHtOE/kl8R4LHT86/EbTH5E5tmSlHPCp
         W04oDD+WFnleqgeBhQXAYLcowTskx6GffHGUXGu557p/Bd7Lk8RLkw5wcoqUt/CpQVkN
         la0I0HIkdEu9Mfh3YOJvUZtSfgHjnySntIv4qVo2Z0MI3NQBvnZm6a+nfbrbbJ3emJqt
         vK6qTd4ZDPZXSGcP0qd7EDxLHY9tovSKAFjRKqfmk4Br8DKDxdz0QycQ+9bJFcur6jpK
         JBDQ==
X-Forwarded-Encrypted: i=1; AHgh+RoLObwKniMYs1fa8cL/F2yDa8RHJ0HEci2gPaJZHZMJSly6ZajJbk1LJSSsDzuGrflE2BZf2QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDu57ToAnJrCP0+7kOkZdAQbKi0jLPpvs7azymVR8egz4W/HN
	TYxgcTjX6Qeeippi6zQMMyI/lO6QaniglFyMyaEwCTrHTYZru3XoY6kH4oiKHNhKb5Prml9vJZh
	gHsxS1wZ1lNCqam+FyLBoDiCX3Z/CkSsKaTq4l6c9wg6Olq/4YZ+ElYAa7xg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:17aa:b0:487:530f:5754 with SMTP id
 5614622812f47-4af5e2f59b4mr4105953b6e.20.1785542553628; Fri, 31 Jul 2026
 17:02:33 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:02:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6d3799.2d659fcc.1d46f5.01a6.GAE@google.com>
Subject: [syzbot] [afs?] [net?] BUG: using smp_processor_id() in preemptible
 code in radix_tree_node_alloc (2)
From: syzbot <syzbot+86abcd2aa855d0add658@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130cec99580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c05be6c9b0d36cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=86abcd2aa855d0add658
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-11028ab6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/511647651d7f/vmlinux-11028ab6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1c76180d0109/bzImage-11028ab6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+86abcd2aa855d0add658@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: krxrpcio/0/5331
caller is radix_tree_node_alloc+0x1b3/0x3a0 lib/radix-tree.c:263
CPU: 0 UID: 0 PID: 5331 Comm: krxrpcio/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
 radix_tree_node_alloc+0x1b3/0x3a0 lib/radix-tree.c:263
 idr_get_free+0x28f/0xa10 lib/radix-tree.c:1506
 idr_alloc_u32+0x18a/0x330 lib/idr.c:48
 idr_alloc_cyclic+0x9c/0x1b0 lib/idr.c:127
 rxrpc_alloc_client_connection net/rxrpc/conn_client.c:165 [inline]
 rxrpc_add_conn_to_bundle net/rxrpc/conn_client.c:353 [inline]
 rxrpc_bundle_has_space net/rxrpc/conn_client.c:404 [inline]
 rxrpc_connect_client_calls+0x74f/0x12c0 net/rxrpc/conn_client.c:524
 rxrpc_io_thread+0x2d9a/0x3290 net/rxrpc/io_thread.c:536
 kthread+0x388/0x470 kernel/kthread.c:436
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
