Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE028C009
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791608440; cv=none; b=ghANwS9rDCsiTrek6p5IUyXZ3FksfaAveAebwKfcTuEA+gPLmr+HtfsAGaID9ccjn6yQtcPJKathTCt80tlkQScdFlOQ0T7RjVs5dKgUUmErFRkfsT7fu0mM+nuiB7KjwbBOJ07hKmcsIuHB599HlyTW/BdnkIMYjq4sK84qsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791608440; c=relaxed/simple;
	bh=6lbDcEEQzMxUZanUbIXWQQRvNAzNlU06Z/mHfBfNw8I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UevHx4talpeaODA5xjERgPrDElXJ7cw06THQDaQdhztg7hiYk+6qfHZL/6aBFz9a1PrnHttzv0Pa4cwnuQwKR5qSkw0lIZyzmlXP7qUTEi+ZjTgFHZTC0AYa2FTB+gyA28Xe8eTasaF4odJChdSe9QdUTqpQqi3GJWNMx+3TSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4cc89e86e4dso799782b6e.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 22:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791608437; x=1792213237;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=us6ScB89JOPz+Y6KklNmPbHFhs0MEllFJihi/ZoHtfw=;
        b=RkaKtmbDoGx1YFUnMtR44/IuttlupDYLIYw9Ae+vxtviaH/LyJIEj/SFc1BcbJD1bl
         VKLFhH8RlGdSIDz41zXwnJCTekuY/m66BTm4RDDLdUDBPOBqTll7SXbW/R/UC0o/uKjx
         PfTm0muXeTag//VdWr8av7PDS5SMP2ELP0dQjlk+c+yc2/ISyeelKNJVM5DUORiB5tAz
         veKUVWNfN+2h26ZWdjXlFGI/Ng+qG+u6gsKAuaPuRcbw3bLpVpel83forlNgin0Uyi6f
         CfZfcWqyZs6SjjWS10NjFXk8mw0vR1G6wolHtjtD/v0lHvLE0iyIWanlc94rLlN8B3T1
         1W2g==
X-Forwarded-Encrypted: i=1; AKwUvBw5g3SBzuhlDwpefaf8/wqwN035RdJyQHt5ZRgA6eR1SunnSCVwTtbxbPkebikU2WK3M8tP95E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfZ47WOws1GCc4C8yNt+Sj+5h+Y+DHJ9m87b61tui/k3fHd3Rt
	wV1Im1RsGZZeJHXbw6NOHtUt9zH4M92KBiEUJrYBx33vANikUQfqAQMpZ/0r/H8zhtx5yDVYtD5
	MgVBesL4F8MIi6OrZy141XFPvMNGTWRt4i1ftPzaTPFbr5+oWhf13bwbvTu0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c3ee:b0:4e8:92e5:db5b with SMTP id
 5614622812f47-50c5b4648camr4475500b6e.54.1791608437351; Fri, 09 Oct 2026
 22:00:37 -0700 (PDT)
Date: Fri, 09 Oct 2026 22:00:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac9c675.a150a118.27e199.0024.GAE@google.com>
Subject: [syzbot] [net?] INFO: trying to register non-static key in neigh_periodic_work
From: syzbot <syzbot+2f98196f4b99dca2b979@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    71c3e5409eef Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15ae21c9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7205f05c11fb4dd
dashboard link: https://syzkaller.appspot.com/bug?extid=2f98196f4b99dca2b979
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1305400d580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/20ff6159ce99/disk-71c3e540.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d6172672705/vmlinux-71c3e540.xz
kernel image: https://storage.googleapis.com/syzbot-assets/923d5e083e1b/Image-71c3e540.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f98196f4b99dca2b979@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 3103 Comm: kworker/u8:8 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
Workqueue: events_power_efficient neigh_periodic_work
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 assign_lock_key+0xcc/0xdc kernel/locking/lockdep.c:1028
 register_lock_class+0xf8/0x31c kernel/locking/lockdep.c:1343
 __lock_acquire+0x140/0x2b08 kernel/locking/lockdep.c:5162
 lock_acquire+0x13c/0x320 kernel/locking/lockdep.c:5942
 __raw_write_lock include/linux/rwlock_api_smp.h:229 [inline]
 _raw_write_lock+0x48/0x60 kernel/locking/spinlock.c:335
 neigh_periodic_work+0x3bc/0x9ec net/core/neighbour.c:1004
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3479
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3560
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
Unable to handle kernel paging request at virtual address dfff800000000009
KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0
[dfff800000000009] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 3103 Comm: kworker/u8:8 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
Workqueue: netns cleanup_net
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : qdisc_reset+0xec/0x594 net/sched/sch_generic.c:1078
lr : trace_qdisc_reset include/trace/events/qdisc.h:128 [inline]
lr : qdisc_reset+0xdc/0x594 net/sched/sch_generic.c:1076
sp : ffff80009a317510
x29: ffff80009a317520 x28: 1fffe00018cc50ad x27: ffff0000c6628568
x26: 0000000000000003 x25: ffff0000c9624800 x24: ffff0000c6628018
x23: 0000000000000000 x22: dfff800000000000 x21: ffff800088a77ec8
x20: 0000000000000048 x19: ffff0000c9624818 x18: 1fffe00035bd7428
x17: 0000000000000003 x16: ffff800088a77000 x15: ffff800088b27700
x14: ffff0001adeba14c x13: 0000000000000001 x12: 0000000000000004
x11: ffff700013462e98 x10: 0000000000000003 x9 : 0000000000000200
x8 : 0000000000000009 x7 : 0000000000000000 x6 : ffff800084df21d4
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800084def98c
x2 : 0000000000000002 x1 : ffff0000cde31d80 x0 : 0000000000000000
Call trace:
 qdisc_reset+0xec/0x594 net/sched/sch_generic.c:1078 (P)
 dev_reset_queue+0x10c/0x1f0 include/net/sch_generic.h:756
 netdev_for_each_tx_queue include/linux/netdevice.h:2752 [inline]
 dev_deactivate_many+0x490/0x9d0 net/sched/sch_generic.c:1394
 __dev_close_many+0x178/0x648 net/core/dev.c:1782
 netif_close_many+0x1d8/0x51c net/core/dev.c:1824
 unregister_netdevice_many_notify+0x740/0x1760 net/core/dev.c:12530
 unregister_netdevice_many+0x28/0x38 net/core/dev.c:12632
 ops_exit_rtnl_list net/core/net_namespace.c:188 [inline]
 ops_undo_list+0x32c/0x81c net/core/net_namespace.c:249
 cleanup_net+0x474/0x6c4 net/core/net_namespace.c:706
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3479
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3560
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
Code: 14000002 96e12f3e 910122f4 d343fe88 (38766908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	14000002 	b	0x8
   4:	96e12f3e 	bl	0xfffffffffb84bcfc
   8:	910122f4 	add	x20, x23, #0x48
   c:	d343fe88 	lsr	x8, x20, #3
* 10:	38766908 	ldrb	w8, [x8, x22] <-- trapping instruction


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
