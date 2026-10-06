Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B13231A23
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308253; cv=none; b=BUbPV0UnOnWHRrjviqaeHBY/OshL3a3w8ikoaBvRuUeeQhHKV/KvtFuGFyHBqVi6sm2GIiQPIzjHiLO4RbXx/Tt3DSeF1GSBMNlLSuWthG3x7iTr2bVHc1KauV8SfBfcScrR4cqtlYsRayNJGjkyRjt1gtWCemSqrlNaDYH4f/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308253; c=relaxed/simple;
	bh=BB7ewGovhu4MSrOWBRZnHNV344mJ5PXjSAUmYoEazO8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vg3wCYQncJB+VoMBG+MHeH0H1Kc0PzkjS2kuLiajhdhJvRLq7fpXPf5n1uaS5Qiqxj2c+dLmUGznYvYZIwjQn9JP66tH4t416PqxiQ0S52gDFnVjjArhkm36FldqjtEckyof7SDMJctR4yGw/B7UQurY0RL8yOH0Gf1xnYJmXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b2f2b8d88fso4829095b6e.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791308248; x=1791913048;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVcsB60Zl7yo3MKdVLZ6HX/11QQ4rgFmV8cazyWLwJA=;
        b=WZfFNdBj+g4UIo9MxmaxJL6vGiKCDAduphA+dCuUOJzx0ot18E8djohRRoV0n+Yhcp
         C4NMwB0buqwVGzME2n8p/2YwdSx6jiTGrvn4VRSSjFhYaMx8hud1alLR8Eway3zXgx12
         R6/F/pXvAiIaComabUeXBI9iN1/lSjKKXmFbuMGYbEepUJuMHEDL8HcQ/I3+XEjVZKHl
         U99fmIC27dG/qYfgC4Zi3B4WhXZDeWOCcqPSpYhs+fXgWoL/IknH0keHHUXn5in0vW9O
         VhHiG7BAeIojm4qeuhmL3D5L5SzceNRw7CyTYFp+vmaFCqodiwQG2571YqMn9yZ4ZvXE
         TVXw==
X-Forwarded-Encrypted: i=1; AKwUvBxNdw1kczEMYjcVgEbykBfgr4ESauq+aWq/SbbkHiVbE25uBTIr66Fj3gXDC1+h3U7wsAlghzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lHuPvBkWhMVRwLTSTPDAzS1javg/IDkCwsciYpopZ6VWAOoo2x
	vKgNBBj/EeDEVUjoAFwen3iQcEVxSNsLuXfYcPAYNs+vUp7EjWdi4Q8zw0NGUK1gy2Exww0XVDI
	Fhat6BrkniloEYv6NE0XJZ5FW+eW6SNnuO4d4nY4bQRfK/+Jps0wwZoLtGWA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:19a0:b0:4eb:80c0:f4bc with SMTP id
 5614622812f47-4fb3fc31683mr2729295b6e.10.1791308248622; Tue, 06 Oct 2026
 10:37:28 -0700 (PDT)
Date: Tue, 06 Oct 2026 10:37:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac531d8.9ad129c8.3ce5b3.0006.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in inet6_rtm_deladdr (3)
From: syzbot <syzbot+55141a0ffa0d17f01c71@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@kernel.org, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    71a77ab76e74 net: allwinner: remove dmaengine_desc_free()
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=3D11c35b15580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9d4242cb1c54cdf=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D55141a0ffa0d17f01=
c71
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-=
1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D117d0bf558000=
0

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d76c0fee00e/disk-=
71a77ab7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e11b9983b85c/vmlinux-=
71a77ab7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb1e5e65fd8f/bzI=
mage-71a77ab7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+55141a0ffa0d17f01c71@syzkaller.appspotmail.com

INFO: task dhcpcd:5279 blocked for more than 146 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:21384 pid:5279  tgid:5279  ppid:5278   t=
ask_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7433
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 rtnl_net_lock include/linux/rtnetlink.h:134 [inline]
 inet6_rtm_deladdr+0x249/0x390 net/ipv6/addrconf.c:4835
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7137
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2575
 netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1364
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2713
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
 __sys_sendmsg net/socket.c:2799 [inline]
 __do_sys_sendmsg net/socket.c:2804 [inline]
 __se_sys_sendmsg net/socket.c:2802 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2802
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbec6fd7407
RSP: 002b:00007ffd81dc7b70 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fbec6f4d780 RCX: 00007fbec6fd7407
RDX: 0000000000000000 RSI: 00007ffd81ddbd50 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd81debf80
R13: 00007fbec6f4d708 R14: 000000000000002c R15: 00007ffd81ddbd50
 </TASK>
INFO: task syz-executor:5779 blocked for more than 146 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22440 pid:5779  tgid:5779  ppid:5777   t=
ask_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7433
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 rtnl_net_lock include/linux/rtnetlink.h:134 [inline]
 inet6_rtm_newaddr+0x667/0xe00 net/ipv6/addrconf.c:5063
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7137
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2575
 netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1364
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 __sys_sendto+0x408/0x5a0 net/socket.c:2281
 __do_sys_sendto net/socket.c:2288 [inline]
 __se_sys_sendto net/socket.c:2284 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2284
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f90a4d5e98e
RSP: 002b:00007ffce1a5ca78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000055556acd4500 RCX: 00007f90a4d5e98e
RDX: 0000000000000040 RSI: 00007f90a5b54670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffce1a5caf4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f90a5b54670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:5786 blocked for more than 146 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22312 pid:5786  tgid:5786  ppid:5776   t=
ask_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7433
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 rtnl_net_lock include/linux/rtnetlink.h:134 [inline]
 inet6_rtm_newaddr+0x667/0xe00 net/ipv6/addrconf.c:5063
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7137
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2575
 netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1364
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 __sys_sendto+0x408/0x5a0 net/socket.c:2281
 __do_sys_sendto net/socket.c:2288 [inline]
 __se_sys_sendto net/socket.c:2284 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2284
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f49fad5e98e
RSP: 002b:00007ffcb123a088 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000555592acf500 RCX: 00007f49fad5e98e
RDX: 0000000000000040 RSI: 00007f49fbb54670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffcb123a104 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f49fbb54670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:5788 blocked for more than 146 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21384 pid:5788  tgid:5788  ppid:5780   t=
ask_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7433
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 rtnl_net_lock include/linux/rtnetlink.h:134 [inline]
 inet6_rtm_newaddr+0x667/0xe00 net/ipv6/addrconf.c:5063
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7137
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2575
 netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1364
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 __sys_sendto+0x408/0x5a0 net/socket.c:2281
 __do_sys_sendto net/socket.c:2288 [inline]
 __se_sys_sendto net/socket.c:2284 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2284
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f38ba75e98e
RSP: 002b:00007ffd3291ce18 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00005555567c6500 RCX: 00007f38ba75e98e
RDX: 0000000000000040 RSI: 00007f38bb554670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffd3291ce94 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f38bb554670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:5790 blocked for more than 146 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22056 pid:5790  tgid:5790  ppid:5783   t=
ask_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7376
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7433
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 rtnl_net_lock include/linux/rtnetlink.h:134 [inline]
 inet6_rtm_newaddr+0x667/0xe00 net/ipv6/addrconf.c:5063
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7137
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2575
 netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
 netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1364
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 __sys_sendto+0x408/0x5a0 net/socket.c:2281
 __do_sys_sendto net/socket.c:2288 [inline]
 __se_sys_sendto net/socket.c:2284 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2284
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f17c395e98e
RSP: 002b:00007fff4c19eac8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000055557bded500 RCX: 00007f17c395e98e
RDX: 0000000000000040 RSI: 00007f17c4754670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007fff4c19eb44 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f17c4754670 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
locks held by kthreadd/2: 1, last CPU#0:
 #0: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_lock_acquir=
e include/linux/srcu.h:198 [inline]
 #0: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_read_lock+0=
x27/0x60 include/linux/srcu.h:305
locks held by kworker/0:0/9: 4, last CPU#0:
 #0: ffff888058931940 ((wq_completion)wg-kex-wg2#2){+.+.}-{0:0}, at: rcu_lo=
ck_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888058931940 ((wq_completion)wg-kex-wg2#2){+.+.}-{0:0}, at: rcu_re=
ad_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888058931940 ((wq_completion)wg-kex-wg2#2){+.+.}-{0:0}, at: proces=
s_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888058931940 ((wq_completion)wg-kex-wg2#2){+.+.}-{0:0}, at: proces=
s_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900000e7c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: rcu_lock_ac=
quire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: rcu_read_lo=
ck include/linux/rcupdate.h:849 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: process_sch=
eduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88807f233ea0 (&handshake->lock){++++}-{4:4}, at: wg_noise_handshak=
e_begin_session+0x36/0xbf0 drivers/net/wireguard/noise.c:822
 #3: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_lock_acquir=
e include/linux/srcu.h:198 [inline]
 #3: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_read_lock+0=
x27/0x60 include/linux/srcu.h:305
locks held by kworker/u8:0/12: 4, last CPU#0:
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90000117c40 ((linkwatch_work).work){+.+.}-{0:0}, at: rcu_lock_acq=
uire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90000117c40 ((linkwatch_work).work){+.+.}-{0:0}, at: rcu_read_loc=
k include/linux/rcupdate.h:849 [inline]
 #1: ffffc90000117c40 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_=
work kernel/workqueue.c:3361 [inline]
 #1: ffffc90000117c40 ((linkwatch_work).work){+.+.}-{0:0}, at: process_sche=
duled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x6=
0 net/core/link_watch.c:313
 #3: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_lock_acquir=
e include/linux/srcu.h:198 [inline]
 #3: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_read_lock+0=
x27/0x60 include/linux/srcu.h:305
locks held by kworker/u8:1/13: 4, last CPU#0:
 #0: ffff88807a0ac940 ((wq_completion)wg-kex-wg2){+.+.}-{0:0}, at: rcu_lock=
_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88807a0ac940 ((wq_completion)wg-kex-wg2){+.+.}-{0:0}, at: rcu_read=
_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88807a0ac940 ((wq_completion)wg-kex-wg2){+.+.}-{0:0}, at: process_=
one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88807a0ac940 ((wq_completion)wg-kex-wg2){+.+.}-{0:0}, at: process_=
scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90000127c40 ((work_completion)(&peer->transmit_handshake_work)){+=
.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90000127c40 ((work_completion)(&peer->transmit_handshake_work)){+=
.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90000127c40 ((work_completion)(&peer->transmit_handshake_work)){+=
.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90000127c40 ((work_completion)(&peer->transmit_handshake_work)){+=
.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:347=
9
 #2: ffff8880258dd440 (&wg->static_identity.lock){++++}-{4:4}, at: wg_noise=
_handshake_create_initiation+0x12e/0x810 drivers/net/wireguard/noise.c:529
 #3: ffff88807f234888 (&handshake->lock){++++}-{4:4}, at: wg_noise_handshak=
e_create_initiation+0x13f/0x810 drivers/net/wireguard/noise.c:530
locks held by khungtaskd/31: 1, last CPU#1:
 #0: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock includ=
e/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks=
+0x2e/0x180 kernel/locking/lockdep.c:6871
locks held by kworker/u8:2/36: 3, last CPU#0:
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90000ac7c40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, a=
t: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90000ac7c40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, a=
t: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90000ac7c40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, a=
t: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90000ac7c40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, a=
t: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88805a0d0800 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_const=
ructor include/net/cfg80211.h:6906 [inline]
 #2: ffff88805a0d0800 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_wo=
rk+0xb4/0x420 net/wireless/core.c:550
locks held by kworker/1:1/44: 3, on CPU#1:
 #0: ffff88805888dd40 ((wq_completion)wg-kex-wg1#2){+.+.}-{0:0}, at: rcu_lo=
ck_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88805888dd40 ((wq_completion)wg-kex-wg1#2){+.+.}-{0:0}, at: rcu_re=
ad_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88805888dd40 ((wq_completion)wg-kex-wg1#2){+.+.}-{0:0}, at: proces=
s_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88805888dd40 ((wq_completion)wg-kex-wg1#2){+.+.}-{0:0}, at: proces=
s_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90000b47c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: rcu_lock_ac=
quire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90000b47c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: rcu_read_lo=
ck include/linux/rcupdate.h:849 [inline]
 #1: ffffc90000b47c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90000b47c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: process_sch=
eduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff888032cb3ea0 (&handshake->lock){++++}-{4:4}, at: wg_noise_handshak=
e_begin_session+0x36/0xbf0 drivers/net/wireguard/noise.c:822
locks held by kworker/u8:4/59: 3, on CPU#0:
 #0: ffff8880310aa940 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: rcu_l=
ock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff8880310aa940 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: rcu_r=
ead_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff8880310aa940 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: proce=
ss_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff8880310aa940 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: proce=
ss_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc9000200fc40 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0=
:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc9000200fc40 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0=
:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc9000200fc40 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0=
:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc9000200fc40 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0=
:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:134 [inline]
 #2: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x116=
/0x15c0 net/ipv6/addrconf.c:4230
locks held by kworker/u8:5/61: 3, last CPU#0:
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc9000203fc40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:30=
9 [inline]
 #1: ffffc9000203fc40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [=
inline]
 #1: ffffc9000203fc40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [in=
line]
 #1: ffffc9000203fc40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/=
workqueue.c:3479
 #2: ffff8880593f2258 (&devlink->lock_key#5){+.+.}-{4:4}, at: nsim_dev_trap=
_report_work+0x57/0xb40 drivers/net/netdevsim/dev.c:834
locks held by kworker/u8:6/149: 3, last CPU#0:
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90002f57c40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:30=
9 [inline]
 #1: ffffc90002f57c40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [=
inline]
 #1: ffffc90002f57c40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [in=
line]
 #1: ffffc90002f57c40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/=
workqueue.c:3479
 #2: ffff888034160258 (&devlink->lock_key#3){+.+.}-{4:4}, at: nsim_dev_trap=
_report_work+0x57/0xb40 drivers/net/netdevsim/dev.c:834
locks held by kworker/0:2/989: 2, last CPU#0:
 #0: ffff88805891e940 ((wq_completion)wg-crypt-wg0){+.+.}-{0:0}, at: rcu_lo=
ck_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88805891e940 ((wq_completion)wg-crypt-wg0){+.+.}-{0:0}, at: rcu_re=
ad_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88805891e940 ((wq_completion)wg-crypt-wg0){+.+.}-{0:0}, at: proces=
s_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88805891e940 ((wq_completion)wg-crypt-wg0){+.+.}-{0:0}, at: proces=
s_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900052bfc40 ((work_completion)(&peer->transmit_packet_work)){+.+.=
}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900052bfc40 ((work_completion)(&peer->transmit_packet_work)){+.+.=
}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900052bfc40 ((work_completion)(&peer->transmit_packet_work)){+.+.=
}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900052bfc40 ((work_completion)(&peer->transmit_packet_work)){+.+.=
}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
locks held by kworker/u8:7/1014: 3, last CPU#0:
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900052ffc40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:30=
9 [inline]
 #1: ffffc900052ffc40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [=
inline]
 #1: ffffc900052ffc40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [in=
line]
 #1: ffffc900052ffc40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/=
workqueue.c:3479
 #2: ffff888076ff3258 (&devlink->lock_key#4){+.+.}-{4:4}, at: nsim_dev_trap=
_report_work+0x57/0xb40 drivers/net/netdevsim/dev.c:834
locks held by kworker/u8:8/1119: 6, last CPU#0:
 #0: ffff888020aaf940 ((wq_completion)writeback){+.+.}-{0:0}, at: rcu_lock_=
acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888020aaf940 ((wq_completion)writeback){+.+.}-{0:0}, at: rcu_read_=
lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888020aaf940 ((wq_completion)writeback){+.+.}-{0:0}, at: process_o=
ne_work kernel/workqueue.c:3361 [inline]
 #0: ffff888020aaf940 ((wq_completion)writeback){+.+.}-{0:0}, at: process_s=
cheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc9000546fc40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0},=
 at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc9000546fc40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0},=
 at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc9000546fc40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0},=
 at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc9000546fc40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0},=
 at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88803594a0e8 (&type->s_umount_key#34){++++}-{4:4}, at: super_trylo=
ck_shared+0x23/0xf0 fs/super.c:670
 #3: ffff888035948c98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_do=
wn_read include/linux/percpu-rwsem.h:77 [inline]
 #3: ffff888035948c98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writ=
epages_down_read fs/ext4/ext4.h:1887 [inline]
 #3: ffff888035948c98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writ=
epages+0x205/0x3b0 fs/ext4/inode.c:3031
 #4: ffff88803598e938 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1f=
bf/0x2200 fs/jbd2/transaction.c:444
 #5: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_lock_acquir=
e include/linux/srcu.h:198 [inline]
 #5: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_read_lock+0=
x27/0x60 include/linux/srcu.h:305
locks held by kworker/u8:9/1121: 3, last CPU#0:
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc9000559fc40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, a=
t: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc9000559fc40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, a=
t: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc9000559fc40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, a=
t: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc9000559fc40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, a=
t: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88805a0c0800 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_const=
ructor include/net/cfg80211.h:6906 [inline]
 #2: ffff88805a0c0800 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_wo=
rk+0xb4/0x420 net/wireless/core.c:550
locks held by kworker/1:2/1220: 3, last CPU#1:
 #0: ffff88805891ed40 ((wq_completion)wg-kex-wg0#2){+.+.}-{0:0}, at: rcu_lo=
ck_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88805891ed40 ((wq_completion)wg-kex-wg0#2){+.+.}-{0:0}, at: rcu_re=
ad_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88805891ed40 ((wq_completion)wg-kex-wg0#2){+.+.}-{0:0}, at: proces=
s_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88805891ed40 ((wq_completion)wg-kex-wg0#2){+.+.}-{0:0}, at: proces=
s_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc9000593fc40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: rcu_lock_ac=
quire include/linux/rcupdate.h:309 [inline]
 #1: ffffc9000593fc40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: rcu_read_lo=
ck include/linux/rcupdate.h:849 [inline]
 #1: ffffc9000593fc40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:3361 [inline]
 #1: ffffc9000593fc40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: process_sch=
eduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88807d605440 (&wg->static_identity.lock){++++}-{4:4}, at: wg_noise=
_handshake_consume_initiation+0x1a2/0x9b0 drivers/net/wireguard/noise.c:598
locks held by kworker/R-bat_e/3226: 5, last CPU#1:
 #0: ffff88803125e140 ((wq_completion)bat_events){+.+.}-{0:0}, at: rcu_lock=
_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88803125e140 ((wq_completion)bat_events){+.+.}-{0:0}, at: rcu_read=
_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88803125e140 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_=
one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88803125e140 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_=
scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc9000f0dfc20 ((work_completion)(&(&bat_priv->tt.work)->work)){+.+.=
}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc9000f0dfc20 ((work_completion)(&(&bat_priv->tt.work)->work)){+.+.=
}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc9000f0dfc20 ((work_completion)(&(&bat_priv->tt.work)->work)){+.+.=
}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc9000f0dfc20 ((work_completion)(&(&bat_priv->tt.work)->work)){+.+.=
}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: local_lock_acquire i=
nclude/linux/local_lock_internal.h:46 [inline]
 #2: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: process_backlog+0x3d=
e/0x18b0 net/core/dev.c:6757
 #3: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:309 [inline]
 #3: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock includ=
e/linux/rcupdate.h:849 [inline]
 #3: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: nf_hook include/linu=
x/netfilter.h:249 [inline]
 #3: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: NF_HOOK+0x9e/0x3c0 i=
nclude/linux/netfilter.h:323
 #4: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:309 [inline]
 #4: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock includ=
e/linux/rcupdate.h:849 [inline]
 #4: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructo=
r include/linux/rcupdate.h:1216 [inline]
 #4: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0x=
8f/0x2550 arch/x86/kernel/unwind_orc.c:495
locks held by kworker/u9:1/4933: 5, on CPU#0:
 #0: ffff88807f23a140 ((wq_completion)hci2){+.+.}-{0:0}, at: rcu_lock_acqui=
re include/linux/rcupdate.h:309 [inline]
 #0: ffff88807f23a140 ((wq_completion)hci2){+.+.}-{0:0}, at: rcu_read_lock =
include/linux/rcupdate.h:849 [inline]
 #0: ffff88807f23a140 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_wo=
rk kernel/workqueue.c:3361 [inline]
 #0: ffff88807f23a140 ((wq_completion)hci2){+.+.}-{0:0}, at: process_schedu=
led_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90004c07c40 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}=
, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90004c07c40 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}=
, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90004c07c40 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}=
, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90004c07c40 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}=
, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff888028df8ea0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+=
0x242/0x430 net/bluetooth/hci_sync.c:335
 #3: ffff888028df80b8 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x=
a6f/0x1190 net/bluetooth/hci_sync.c:6008
 #4: ffffffff8ed62c68 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_loc=
k kernel/rcu/tree_exp.h:311 [inline]
 #4: ffffffff8ed62c68 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rc=
u_expedited+0x2d0/0x770 kernel/rcu/tree_exp.h:966
locks held by klogd/4972: 2, last CPU#0:
 #0: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_lock_acquir=
e include/linux/srcu.h:198 [inline]
 #0: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_read_lock+0=
x27/0x60 include/linux/srcu.h:305
 #1: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:309 [inline]
 #1: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock includ=
e/linux/rcupdate.h:849 [inline]
 #1: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructo=
r include/linux/rcupdate.h:1216 [inline]
 #1: ffffffff8ed5c8a0 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0x=
8f/0x2550 arch/x86/kernel/unwind_orc.c:495
locks held by udevd/4983: 2, last CPU#0:
 #0: ffffffff8f4f2938 (tomoyo_ss){.+.+}-{0:0}, at: srcu_lock_acquire includ=
e/linux/srcu.h:198 [inline]
 #0: ffffffff8f4f2938 (tomoyo_ss){.+.+}-{0:0}, at: srcu_read_lock include/l=
inux/srcu.h:305 [inline]
 #0: ffffffff8f4f2938 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_read_lock securit=
y/tomoyo/common.h:1112 [inline]
 #0: ffffffff8f4f2938 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_path_perm+0x251/0=
x560 security/tomoyo/file.c:826
 #1: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_lock_acquir=
e include/linux/srcu.h:198 [inline]
 #1: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_read_lock+0=
x27/0x60 include/linux/srcu.h:305
locks held by dhcpcd/5279: 1, on CPU#1:
 #0: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:134 [inline]
 #0: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_deladdr+0x249=
/0x390 net/ipv6/addrconf.c:4835
locks held by getty/5374: 2, on CPU#1:
 #0: ffff888034e130a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait=
+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000322b2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_rea=
d+0x45a/0x1360 drivers/tty/n_tty.c:2211
locks held by syz-executor/5658: 1, last CPU#0:
 #0: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_lock_acquir=
e include/linux/srcu.h:198 [inline]
 #0: ffffffff8eeac630 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_read_lock+0=
x27/0x60 include/linux/srcu.h:305
locks held by kworker/u9:2/5692: 5, on CPU#1:
 #0: ffff888078123140 ((wq_completion)hci1){+.+.}-{0:0}, at: rcu_lock_acqui=
re include/linux/rcupdate.h:309 [inline]
 #0: ffff888078123140 ((wq_completion)hci1){+.+.}-{0:0}, at: rcu_read_lock =
include/linux/rcupdate.h:849 [inline]
 #0: ffff888078123140 ((wq_completion)hci1){+.+.}-{0:0}, at: process_one_wo=
rk kernel/workqueue.c:3361 [inline]
 #0: ffff888078123140 ((wq_completion)hci1){+.+.}-{0:0}, at: process_schedu=
led_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90004667c40 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}=
, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90004667c40 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}=
, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90004667c40 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}=
, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90004667c40 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}=
, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802277cea0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+=
0x242/0x430 net/bluetooth/hci_sync.c:335
 #3: ffff88802277c0b8 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x=
a6f/0x1190 net/bluetooth/hci_sync.c:6008
 #4: ffffffff903dbd40 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm i=
nclude/net/bluetooth/hci_core.h:2164 [inline]
 #4: ffffffff903dbd40 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0=
x17f/0x370 net/bluetooth/hci_conn.c:1442
locks held by syz-executor/5778: 5, on CPU#0:
 #0: ffff888073f14ea0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close n=
et/bluetooth/hci_core.c:500 [inline]
 #0: ffff888073f14ea0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_unregister_dev=
+0x232/0x5c0 net/bluetooth/hci_core.c:2694
 #1: ffff888073f140b8 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x6=
16/0x10c0 net/bluetooth/hci_sync.c:5605
 #2: ffffffff903dbd40 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_disconn_cfm i=
nclude/net/bluetooth/hci_core.h:2179 [inline]
 #2: ffffffff903dbd40 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_hash_flu=
sh+0x99/0x260 net/bluetooth/hci_conn.c:2785
 #3: ffff88807f23d2f8 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_conn_del+0x9f/=
0x550 net/bluetooth/l2cap_core.c:1816
 #4: ffffffff8ed62c68 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_loc=
k kernel/rcu/tree_exp.h:343 [inline]
 #4: ffffffff8ed62c68 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rc=
u_expedited+0x38d/0x770 kernel/rcu/tree_exp.h:966
locks held by syz-executor/5779: 1, on CPU#0:
 #0: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:134 [inline]
 #0: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_newaddr+0x667=
/0xe00 net/ipv6/addrconf.c:5063
locks held by kworker/0:3/5782: 2, last CPU#0:
 #0: ffff88801b069d40 ((wq_completion)events_power_efficient){+.+.}-{0:0}, =
at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b069d40 ((wq_completion)events_power_efficient){+.+.}-{0:0}, =
at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b069d40 ((wq_completion)events_power_efficient){+.+.}-{0:0}, =
at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b069d40 ((wq_completion)events_power_efficient){+.+.}-{0:0}, =
at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90004607c40 ((work_completion)(&(&tbl->gc_work)->work)){+.+.}-{0:=
0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90004607c40 ((work_completion)(&(&tbl->gc_work)->work)){+.+.}-{0:=
0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90004607c40 ((work_completion)(&(&tbl->gc_work)->work)){+.+.}-{0:=
0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90004607c40 ((work_completion)(&(&tbl->gc_work)->work)){+.+.}-{0:=
0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
locks held by syz-executor/5786: 1, on CPU#1:
 #0: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:134 [inline]
 #0: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_newaddr+0x667=
/0xe00 net/ipv6/addrconf.c:5063
locks held by syz-executor/5788: 1, on CPU#1:
 #0: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:134 [inline]
 #0: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_newaddr+0x667=
/0xe00 net/ipv6/addrconf.c:5063
locks held by syz-executor/5790: 1, on CPU#1:
 #0: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:134 [inline]
 #0: ffffffff90254c40 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_newaddr+0x667=
/0xe00 net/ipv6/addrconf.c:5063
locks held by kworker/0:4/5858: 2, last CPU#0:
 #0: ffff88801b069d40 ((wq_completion)events_power_efficient){+.+.}-{0:0}, =
at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b069d40 ((wq_completion)events_power_efficient){+.+.}-{0:0}, =
at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b069d40 ((wq_completion)events_power_efficient){+.+.}-{0:0}, =
at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b069d40 ((wq_completion)events_power_efficient){+.+.}-{0:0}, =
at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900033b7c40 ((gc_work).work){+.+.}-{0:0}, at: rcu_lock_acquire in=
clude/linux/rcupdate.h:309 [inline]
 #1: ffffc900033b7c40 ((gc_work).work){+.+.}-{0:0}, at: rcu_read_lock inclu=
de/linux/rcupdate.h:849 [inline]
 #1: ffffc900033b7c40 ((gc_work).work){+.+.}-{0:0}, at: process_one_work ke=
rnel/workqueue.c:3361 [inline]
 #1: ffffc900033b7c40 ((gc_work).work){+.+.}-{0:0}, at: process_scheduled_w=
orks+0x97a/0x1630 kernel/workqueue.c:3479
locks held by kworker/0:6/5944: 4, last CPU#0:
 #0: ffff88805888dd40 ((wq_completion)wg-kex-wg1#2){+.+.}-{0:0}, at: rcu_lo=
ck_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88805888dd40 ((wq_completion)wg-kex-wg1#2){+.+.}-{0:0}, at: rcu_re=
ad_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88805888dd40 ((wq_completion)wg-kex-wg1#2){+.+.}-{0:0}, at: proces=
s_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88805888dd40 ((wq_completion)wg-kex-wg1#2){+.+.}-{0:0}, at: proces=
s_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90003477c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: rcu_lock_ac=
quire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90003477c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: rcu_read_lo=
ck include/linux/rcupdate.h:849 [inline]
 #1: ffffc90003477c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90003477c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: process_sch=
eduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88801db99440 (&wg->static_identity.lock){++++}-{4:4}, at: wg_noise=
_handshake_create_response+0x14e/0x9f0 drivers/net/wireguard/noise.c:678
 #3: ffff888032cb3ea0 (&handshake->lock){++++}-{4:4}, at: wg_noise_handshak=
e_create_response+0x15f/0x9f0 drivers/net/wireguard/noise.c:679
locks held by kworker/1:6/6046: 2, last CPU#1:
 #0: ffff888058931540 ((wq_completion)wg-crypt-wg2){+.+.}-{0:0}, at: rcu_lo=
ck_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888058931540 ((wq_completion)wg-crypt-wg2){+.+.}-{0:0}, at: rcu_re=
ad_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888058931540 ((wq_completion)wg-crypt-wg2){+.+.}-{0:0}, at: proces=
s_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff888058931540 ((wq_completion)wg-crypt-wg2){+.+.}-{0:0}, at: proces=
s_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90003987c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: rcu_lock_ac=
quire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90003987c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: rcu_read_lo=
ck include/linux/rcupdate.h:849 [inline]
 #1: ffffc90003987c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90003987c40 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ((t=
ypeof((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker)))))((uns=
igned long)((__typeof_unqual__(*((worker))) *)(( unsigned long)((worker))))=
 + (((__per_cpu_offset[(cpu)]))))); })->work)){+.+.}-{0:0}, at: process_sch=
eduled_works+0x97a/0x1630 kernel/workqueue.c:3479
locks held by kworker/u8:11/6064: 2, last CPU#0:
 #0: ffff88801b0ab940 ((wq_completion)events_dfl_long){+.+.}-{0:0}, at: rcu=
_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b0ab940 ((wq_completion)events_dfl_long){+.+.}-{0:0}, at: rcu=
_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b0ab940 ((wq_completion)events_dfl_long){+.+.}-{0:0}, at: pro=
cess_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b0ab940 ((wq_completion)events_dfl_long){+.+.}-{0:0}, at: pro=
cess_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90003657c40 ((work_completion)(&(&ipvs->defense_work)->work)){+.+=
.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90003657c40 ((work_completion)(&(&ipvs->defense_work)->work)){+.+=
.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90003657c40 ((work_completion)(&(&ipvs->defense_work)->work)){+.+=
.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90003657c40 ((work_completion)(&(&ipvs->defense_work)->work)){+.+=
.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
locks held by kworker/u8:12/6065: 3, last CPU#0:
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_=
read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90004737c40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:30=
9 [inline]
 #1: ffffc90004737c40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [=
inline]
 #1: ffffc90004737c40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [in=
line]
 #1: ffffc90004737c40 ((work_completion)(&(&nsim_dev->trap_data->trap_repor=
t_dw)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/=
workqueue.c:3479
 #2: ffff888055669258 (&devlink->lock_key#6){+.+.}-{4:4}, at: nsim_dev_trap=
_report_work+0x57/0xb40 drivers/net/netdevsim/dev.c:834
locks held by kworker/u8:14/6067: 4, last CPU#0:
 #0: ffff88807a0ae940 ((wq_completion)wg-kex-wg1){+.+.}-{0:0}, at: rcu_lock=
_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88807a0ae940 ((wq_completion)wg-kex-wg1){+.+.}-{0:0}, at: rcu_read=
_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88807a0ae940 ((wq_completion)wg-kex-wg1){+.+.}-{0:0}, at: process_=
one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88807a0ae940 ((wq_completion)wg-kex-wg1){+.+.}-{0:0}, at: process_=
scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900032d7c40 ((work_completion)(&peer->transmit_handshake_work)){+=
.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900032d7c40 ((work_completion)(&peer->transmit_handshake_work)){+=
.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900032d7c40 ((work_completion)(&peer->transmit_handshake_work)){+=
.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900032d7c40 ((work_completion)(&peer->transmit_handshake_work)){+=
.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:347=
9
 #2: ffff88801db99440 (&wg->static_identity.lock){++++}-{4:4}, at: wg_noise=
_handshake_create_initiation+0x12e/0x810 drivers/net/wireguard/noise.c:529
 #3: ffff888032cb4888 (&handshake->lock){++++}-{4:4}, at: wg_noise_handshak=
e_create_initiation+0x13f/0x810 drivers/net/wireguard/noise.c:530

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(ful=
l)=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:123
 nmi_trigger_cpumask_backtrace+0x17d/0x390 lib/nmi_backtrace.c:66
 trigger_all_cpu_backtrace include/linux/nmi.h:164 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 3226 Comm: kworker/R-bat_e Not tainted syzkaller #0 PREE=
MPT(full)=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 07/24/2026
Workqueue: bat_events batadv_tt_purge
RIP: 0010:__xfrm_decode_session+0x548/0xb80 net/xfrm/xfrm_policy.c:-1
Code: 08 4b f7 4d 8d b5 94 00 00 00 4c 89 f0 48 c1 e8 03 48 ba 00 00 00 00 =
00 fc ff df 0f b6 04 10 84 c0 0f 85 84 03 00 00 45 8b 36 <49> bf f1 f1 f1 f=
1 f8 f8 f8 f8 e9 98 01 00 00 4d 8d 7d 58 4d 89 fd
RSP: 0018:ffffc90000a18000 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc90000a181a0 RCX: ffff8880320b8000
RDX: dffffc0000000000 RSI: 0000000000000100 RDI: 0000000000000000
RBP: ffffc90000a180f0 R08: 0000000000000100 R09: 0000000000000002
R10: 000000000000002f R11: 8000000000000100 R12: ffff888031177800
R13: ffff8880b2ee8000 R14: 0000000000000001 R15: ffff888031177800
FS:  0000000000000000(0000) GS:ffff888124dc7000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020ef09935000 CR3: 000000000eb48000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 xfrm_decode_session include/net/xfrm.h:1357 [inline]
 ip_route_me_harder+0x9fd/0xfe0 net/ipv4/netfilter.c:67
 synproxy_send_tcp+0x332/0x670 net/netfilter/nf_synproxy_core.c:434
 synproxy_send_client_synack+0x89b/0xde0 net/netfilter/nf_synproxy_core.c:4=
87
 nft_synproxy_eval_v4+0x362/0x4e0 net/netfilter/nft_synproxy.c:59
 nft_synproxy_do_eval+0x389/0x5d0 net/netfilter/nft_synproxy.c:142
 expr_call_ops_eval net/netfilter/nf_tables_core.c:237 [inline]
 nft_do_chain+0x48d/0x1b10 net/netfilter/nf_tables_core.c:285
 nft_do_chain_ipv4+0x195/0x290 net/netfilter/nft_chain_filter.c:24
 nf_hook_entry_hookfn include/linux/netfilter.h:165 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:619
 nf_hook include/linux/netfilter.h:280 [inline]
 NF_HOOK+0x21f/0x3c0 include/linux/netfilter.h:323
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:325
 __netif_receive_skb_one_core net/core/dev.c:6297 [inline]
 __netif_receive_skb net/core/dev.c:6410 [inline]
 process_backlog+0xa6b/0x18b0 net/core/dev.c:6761
 __napi_poll+0xaa/0x330 net/core/dev.c:7830
 napi_poll net/core/dev.c:7893 [inline]
 net_rx_action+0x61d/0xf50 net/core/dev.c:8050
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 do_softirq+0x77/0xd0 kernel/softirq.c:546
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x140 kernel/softirq.c:473
 spin_unlock_bh include/linux/spinlock.h:407 [inline]
 batadv_tt_local_purge+0x2c1/0x340 net/batman-adv/translation-table.c:1402
 batadv_tt_purge+0x35/0xa10 net/batman-adv/translation-table.c:3753
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 rescuer_thread+0x7c5/0x10e0 kernel/workqueue.c:3703
 kthread+0x38b/0x480 kernel/kthread.c:436
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
