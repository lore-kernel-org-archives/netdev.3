Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11F3B0AE7
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335021; cv=none; b=BWiVSDjuVp/Gton+bX+J2psgdI9J+MjmGml3XU7p/Kcwv32qzfZis0EFhaMpRvN8Y5wC1iU0CeME4vHM8s/flOk3HdKc3Cng9CG4TENfcSlDEg8RPnfNaQwPVeenswg2ElvgIKiIrCPraFZ1hygwcOGPvOgODH6vfOC17vvMFSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335021; c=relaxed/simple;
	bh=RleU7cNN1wOfOHEFXMjowd8IIs6GlYKSm1VisDWm+6U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UlhXNXZUsnH4b3pBEim2XWaMYKJgbTMV78IVT2HS+xgQ0Vv57YyIKur8xQ1buR7cAzLFn6/huXLA3SPvs/GV1h7y0o5ob45tRhveKHEBWQjMAYML/R1d7bDNp0Xiqyjh/fO9gPzzLegxaExo0t7Xj4isGPakW3OVvmtUIcXanLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f0.google.com with SMTP id 006d021491bc7-6a3900cb2b5so268227eaf.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 00:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788335019; x=1788939819;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Fyr7GjnemiBK6OzWbgukemJrSOlrcphd1h+NIeU+Ak=;
        b=IOPZ41kfZR8EWl8AaE5xvr3WAdbbUf+1WGqqNEjw4OSjClEfLz2skW2gQcqpsZV8G0
         O5BnzsYIWghZY423OlNU+siiDI5+QyvYyg6325eCmdRN5tft/HUbqPBfj3yjzpTaKpIL
         +rk22DG3ubCv0CznZRbNCzOqQ9dncx9ZKwEUwnm6sQ+c0rt6WoE19SHUJJduxpSvjF5J
         CrQG2fDDke4e1RTlFx5Eo4Q9q3bojrZ/f3KDqJdo4jg6p2FxqPtS+Q2I7g3ivroyWnfr
         UJiKJ2MD7d0jJRiK9VA1tpz1MwfIiQZmASdbDvLXRvAnAnKFbsYVYaIycJl+LqPpnIVU
         qsQw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6fW3+2xhdO00iqDUyWYAW0EgDuz/pp4FG/nRNgmh37abMXRZDg8yDBUVR8y7QeFmiG1e1p5o=@vger.kernel.org
X-Gm-Message-State: AFuF++nREdemShZPeAA6oSxbM0BTTdTHUjW7RasaA2QlPduBFGM6pQry
	gV+4h+lgR8K2NqpoIGbTkzPhGqw2CRKc/ExFbmHEi+Cvbfw58ZjT6pagWH70C0N6gGjmbV76Vqb
	Kh7aCrlglu4+JWOvHOstX9HeDFb8RlxE95//clcz02FK7yK8spd9OSZ/BY50=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168f:b0:6b1:9f9d:79f3 with SMTP id
 006d021491bc7-6b47e7beac8mr2231224eaf.17.1788335018735; Wed, 02 Sep 2026
 00:43:38 -0700 (PDT)
Date: Wed, 02 Sep 2026 00:43:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a97d3aa.e163c37b.143a1.0007.GAE@google.com>
Subject: [syzbot] [openvswitch?] INFO: task hung in ovs_dp_masks_rebalance (8)
From: syzbot <syzbot+75ce0a9129024fa8cbf6@syzkaller.appspotmail.com>
To: aconole@redhat.com, davem@davemloft.net, dev@openvswitch.org, 
	echaudro@redhat.com, edumazet@google.com, horms@kernel.org, 
	i.maximets@ovn.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a23cbb05744b Merge tag 'timers-urgent-2026-08-30' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1107a379580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=75ce0a9129024fa8cbf6
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eed599d932fb/disk-a23cbb05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74e8c268c325/vmlinux-a23cbb05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa91aebf1baf/bzImage-a23cbb05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+75ce0a9129024fa8cbf6@syzkaller.appspotmail.com

INFO: task kworker/0:0:9 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:22128 pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events ovs_dp_masks_rebalance
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 ovs_lock net/openvswitch/datapath.c:108 [inline]
 ovs_dp_masks_rebalance+0x2f/0xe0 net/openvswitch/datapath.c:2602
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/u8:1:13 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:1    state:D stack:22376 pid:13    tgid:13    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: ipv6_addrconf addrconf_verify_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 rtnl_net_lock include/linux/rtnetlink.h:134 [inline]
 addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4770
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/u8:2:27 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:2    state:D stack:23808 pid:27    tgid:27    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7419
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7c1/0x1550 kernel/locking/mutex.c:821
 ops_exit_rtnl_list net/core/net_namespace.c:173 [inline]
 ops_undo_list+0x28e/0x8d0 net/core/net_namespace.c:249
 cleanup_net+0x572/0x810 net/core/net_namespace.c:706
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/1:1:31 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:22232 pid:31    tgid:31    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events ovs_dp_masks_rebalance
Call Trace:


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
