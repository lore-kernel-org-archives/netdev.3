Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792888538;
	b=YbTt6Y6KYXAb+q7dr01zORp2OOXrz9n8IwiBOPiRE1JleS5BxR80ZJLwg/l6w5oc3SHU
	 zdjnchJR93ilzremYzGu6F40dAdn94cOqgzJ/KbhwNaDRDRgSk2oOMyG1ZVddy+7rNPLs
	 zYX9GP6JUAl/rB8NnRPb0h7FtJh3Ukn0Kw1ei4mwMaplJItw/95RD0hiifOXxMmO0xCWd
	 Aj2QC13Bquyal4xADV6UI2J2fAJu2L+pVi28zAQBK39idH/3OLA1phFjAnrW3BL5yo+aw
	 57rSjODYWa4jrH+jIP501EmWUG3Tvm043T+xQK6uyPT3D2NhoJp6ou8wCyNZdh3gnsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792888538;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=XSpvoJJOnlwRIHqeOURy97S0PX5mhHQN8lVWg3MejC8=;
	b=c8WTzsY1YLX41Jm3tkN2+IHbiNFbHlamRVOXtkBiFbXMuc7GTEwruNBUvl/Q2VQ0jDXi
	 2Trl4bEH55OK6isqeRFiLQzi8VCk2HQwm7Ku9uTowpOEjMPVu122J2EAHqmZGQhN53ioU
	 53e1TQhe89jAAxKGC7tJFiWbbNfPbrbJ1GjBl3Su6xwvuC57m4KCEhKjEUYFad0vN2sRv
	 r03aIhMQ0YbovIJL4UwqNGC4uSHY7ftc81msO8GGRSbxPQy86md2KlnSf0LdgI3F3xJBC
	 MDguYgLMmWPLXo0v9TZWsiJTbEKzFMCzJ+cGybKgCgzPu2OkPw1qPCRPkpv1P4F+aKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A27F606A31E
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 00:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A27F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-5384e381fbbso1921635b6e.2
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 17:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792888537; x=1793493337;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSpvoJJOnlwRIHqeOURy97S0PX5mhHQN8lVWg3MejC8=;
        b=eDGCEta6sQfvXba7mHZSaqdbzcyqcJ29vEEKfmF9aP0CUUHdW+zviNYaPlLiwp8YpP
         Yzk9suCowggGJ4KVQcPhjdOylL00YSTDwI7rvAqxBl4b8hffEK2/+7s37AIfAYKlxm8B
         dEOcHUgPt1sovlgmhX2Syqi/khZAaWCAFehiv7OAqw8d7fP3Iqr1nolfqQ6m9+CjByrI
         38I1QHdPuEN+Ah1tBBvsfjlKzUBjgiZFa19TIG9Xtqrlw0umeAFwA7Vw+vbw8hDXfBKY
         le1IB6Bix975xNekmkoSZVPCS1G8Ax7V9R0STXEz/+jMY1fG8515PpGDjwePh53oedtD
         g1Wg==
X-Forwarded-Encrypted: i=1; AKwUvBzKE7VeN1IezG15FUSsYI2I+b76K6ovSWI6/UaAOR73mRn/JGHbm4KVRfCRvlm/vaC9iPmPU00=@vger.kernel.org
X-Gm-Message-State: AFq9FYImhTP7Mg1XPMUpcwWcxcZ8zpv1OcZXyr7bvKIerSIULKrjvt9N
	f8gD9K+REPcaxmsXOGjp4Qltne5TcNetFZnyuOuhwf7P2My0NXCdyh9JeR5zLBDvJrWtGf+SmQs
	w1kmRFrm/FGqvVhYx68W/AIT1hdobN+bLFqkuCAADVCWmvdJ0vO+zo7Zwoqg=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f5e:b0:4d6:9232:b3be with SMTP id
 5614622812f47-55c003118a5mr2285739b6e.53.1792888537264; Sat, 24 Oct 2026
 17:35:37 -0700 (PDT)
Date: Sat, 24 Oct 2026 17:35:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6add4ed9.67317f00.38c4bc.0066.GAE@google.com>
Subject: [syzbot] [smc?] possible deadlock in __smc_lgr_terminate
From: syzbot <syzbot+7ea1f5efd5de7e24f1de@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@kernel.org, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f47d223627f8 Merge tag 'vfs-7.4-rc1.sync_close' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1413290d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8fd4ba7675545d0
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea1f5efd5de7e24f1de
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54bd1c4ffe03/disk-f47d2236.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c7d29f96e65/vmlinux-f47d2236.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6342fb551ce8/bzImage-f47d2236.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7ea1f5efd5de7e24f1de@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
kworker/0:2/7972 is trying to acquire lock:
ffff8880419c3118 (sk_lock-AF_SMC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1715 [inline]
ffff8880419c3118 (sk_lock-AF_SMC){+.+.}-{0:0}, at: __smc_lgr_terminate+0x19e/0x6a0 net/smc/smc_core.c:1580

but task is already holding lock:
ffff8880326f9298 (sk_lock-AF_SMC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1715 [inline]
ffff8880326f9298 (sk_lock-AF_SMC){+.+.}-{0:0}, at: smc_listen_work+0x5e/0x1410 net/smc/af_smc.c:2463

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sk_lock-AF_SMC);
  lock(sk_lock-AF_SMC);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

locks held by kworker/0:2/7972: 3, last CPU#0:
 #0: ffff8880344a4938 ((wq_completion)smc_hs_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff8880344a4938 ((wq_completion)smc_hs_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff8880344a4938 ((wq_completion)smc_hs_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff8880344a4938 ((wq_completion)smc_hs_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900045ffc40 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900045ffc40 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900045ffc40 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900045ffc40 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff8880326f9298 (sk_lock-AF_SMC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1715 [inline]
 #2: ffff8880326f9298 (sk_lock-AF_SMC){+.+.}-{0:0}, at: smc_listen_work+0x5e/0x1410 net/smc/af_smc.c:2463

stack backtrace:
CPU: 0 UID: 0 PID: 7972 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
Workqueue: smc_hs_wq smc_listen_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x27a/0x290 kernel/locking/lockdep.c:3085
 check_deadlock kernel/locking/lockdep.c:3137 [inline]
 validate_chain kernel/locking/lockdep.c:3939 [inline]
 __lock_acquire+0x25db/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 lock_sock_nested+0x41/0x130 net/core/sock.c:3865
 lock_sock include/net/sock.h:1715 [inline]
 __smc_lgr_terminate+0x19e/0x6a0 net/smc/smc_core.c:1580
 smc_conn_abort net/smc/af_smc.c:1019 [inline]
 smc_listen_decline net/smc/af_smc.c:1978 [inline]
 smc_listen_work+0x69e/0x1410 net/smc/af_smc.c:2588
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x470 kernel/kthread.c:436
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
