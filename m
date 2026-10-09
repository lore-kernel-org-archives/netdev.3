Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9387F480DF0
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574061; cv=none; b=om/nKEMyZEBhRJKuS1HBd6eZayeyRuDOrGHP5JIm14Rid31Ykd20UXikXFjaCF2tixKOK0wsQupd4iCKBP+BeudNvHtMwnTXui11VW90NpZhYpHE0AAl4BV/tzInFB9e8TXbjdoYXec5mADQIChfOdjbkAqR/3n6iwm6e85VhMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574061; c=relaxed/simple;
	bh=L8gg4Kq6W+Ym35JCXkVX26+OXcaYYuFc4zMgWgsCAEc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L/4ew6GnnOPsJgcsAqtEM7poXH5B1qYyRJf5CpSrJQsj20OWGGhEUA0PPyXDrVpDdUMit0lIhxvqsCI3lHTzIw4vtZG8G4/blDbznvLb1i3PyTARDEYzxCM8NpxSbfRt7bBQ7CJ3s41/o6SQqiIj1GO7C6Upi8zc35Bo3ujAQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b2d1eb484aso230989b6e.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 12:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791574055; x=1792178855;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEDJMcpb2PLOS4ggAtHpAOc7GocOBl+0xfRC3Z6ZkJI=;
        b=mnNJ1azTvChCPLGxwKdlHxFt9BWXTZhQ0k7qpaUtMHHx6dLLtoFGMoOj7B7T/Bp+Al
         2/V85JnBt72OCxn2KhIiw1bwI4G9KkF1qhCucXGjESn/jGrTUNZeVT+F+tfs4v1iZGYR
         7BAMdHqSXT9DvjQ2K2tFs8PKFhxVLVlQ/mUSVIjBLYQ4yL+uJ+pkeHivis4pYPXBakey
         GLVWibIrs6ikaUO138R4ua40F6nmMfp5BX82XG1S6uf6vg9J4I+q1j81RU+4nqrU3F2F
         PZFuUe1UNP55YDAzCeut3KpJHdY8SZm6XyuK3OrePy2YO7tifpX94k27/brlOL7zh967
         mAVw==
X-Forwarded-Encrypted: i=1; AKwUvBx6d0YvwmNCsvRIt6u/kuTdJzW+JkLNFFlPSHqlSDt41m1LNlvZ8fYfFXqdCcgIsZj3fIuVxWk=@vger.kernel.org
X-Gm-Message-State: AFuF++naXYyygNOQpxsQKWKzk75RAOtHfbd6TZBGO6nRYyp2B3CLYSIS
	DT21QNFnjx1p1ezKiiPTgddh2KDf7s8qIpozwi39Ja9qzCH3CRPbykOqJe3NWy+1txgPyQzj1sJ
	itbbB8lHcuav66WXDIzv9ASnpjln6sE0Yp+Raj1bE5WNKf1QE5ERclGjp27Y=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:19a9:b0:4b9:e65b:8c33 with SMTP id
 5614622812f47-50c54177b94mr2989175b6e.33.1791574055178; Fri, 09 Oct 2026
 12:27:35 -0700 (PDT)
Date: Fri, 09 Oct 2026 12:27:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac94027.70ed5d86.2ac85.0078.GAE@google.com>
Subject: [syzbot] [sctp?] kernel panic: corrupted stack end in sctp_setsockopt
From: syzbot <syzbot+107afda010b4507a5c80@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    71c3e5409eef Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11a360a5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42bd821301b42742
dashboard link: https://syzkaller.appspot.com/bug?extid=107afda010b4507a5c80
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7596ece97a32/disk-71c3e540.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d2c36351098/vmlinux-71c3e540.xz
kernel image: https://storage.googleapis.com/syzbot-assets/396ce0b85b3c/Image-71c3e540.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+107afda010b4507a5c80@syzkaller.appspotmail.com

Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 UID: 0 PID: 10678 Comm: syz.6.1395 Tainted: G   M         L      syzkaller #0 PREEMPT 
Tainted: [M]=MACHINE_CHECK, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/23/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0x30/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 vpanic+0x594/0xaf8 kernel/panic.c:651
 vpanic+0x0/0xaf8 kernel/panic.c:788
 schedule_debug kernel/sched/core.c:6103 [inline]
 __schedule+0x18a0/0x2b00 kernel/sched/core.c:7133
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x13c/0x20c kernel/sched/core.c:7376
 __lock_sock+0x124/0x260 net/core/sock.c:3245
 lock_sock_nested+0xd4/0x110 net/core/sock.c:3858
 lock_sock include/net/sock.h:1713 [inline]
 sctp_setsockopt+0x1d4/0xe70 net/sctp/socket.c:4609
 sock_common_setsockopt+0xb0/0xcc net/core/sock.c:4050
 do_sock_setsockopt+0x1f0/0x330 net/socket.c:2397
 __sys_setsockopt+0x104/0x170 net/socket.c:2422
 __do_sys_setsockopt net/socket.c:2428 [inline]
 __se_sys_setsockopt net/socket.c:2425 [inline]
 __arm64_sys_setsockopt+0xc8/0xe4 net/socket.c:2425
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:796
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:815
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
Kernel Offset: disabled
CPU features: 0x0,50000000,00f00020,9c080a02,a84ff6a7
Memory Limit: none
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
