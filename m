Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E7843B3E4
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856591; cv=none; b=KRERZw4dn/vGHEn4IHVKLnmb4yEQvLzWJXLsf7/bxj1UUJI5f9nUiokbBz174EHdGQ4WfpwKgsExyhW/PtJo7Dxsr6n8pjqINRRzK14Jn5kPQbe6UhxD9UuTDGROVxebcqiosHMiaWlAZvBL5rTDlQVVPB43keV8Be6DkFteBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856591; c=relaxed/simple;
	bh=pQWAYqh2xqpeXx1NEBFyw1zxNHUzKZb8gT+yYQTcxHU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qZrjvZQxo3cycJJR/GLbdoB/SDOoYseCocJzFwhhJhrVChhbnwaOtrQrY4+U71vnovwkMLtO/Pp0dXbNq/9axnmntjuBc5JYUlk3ORVhumVOL0ZQuPthBt/lh4FCPkrJnKPlYGLw4I1ASw20i/M8b/ZhLP7zRj3ZHbS9NHxLYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6ae4622d842so3286090eaf.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785856588; x=1786461388;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=24I+lqcuZffBwX5yC4AvKAXX5oLIsikw6M1VJ5x4MPM=;
        b=Ldw4F4BrWtvyfWGH7NQ2etoQQ1I3f4v0vxr3TlmRoDcTqSWotDutGxp239rhUBUPhO
         q2M+bxxxcCeDc8miycaVXV9E5jvym4GLbuTJvBIuqTzlPkex3xrMmCLoSeAa/mTLY0J4
         gmgQyKmAw/tYOzXnOYLkqsZdh91Cf7gneAVUYuGx+2LF+NG9mmRVZBEbu8UkdfP2tHmv
         Q6hOphJ2Zd9TQObC9JzYbT5LMWJNBGAJEJKkqIsL91ygcGqxMdFl5SK2AO7ixxHcdeW4
         egi8gRPG/qc77GI/1Fy1X6JqPURlC/8/1MJrij32kFV2M+yluUNwbWsM7kKvh8sYaGcZ
         9H/w==
X-Forwarded-Encrypted: i=1; AHgh+RrAO/wql8bdG7l41636EwJ4qxr+ZXdKpBpEr7DKEQLP5HO8I+1GPXkjy3FiVAXDZMxhMuoO6hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5WCfP5IYb+2RMmkmKVyuUZEYc71W2YdbP6ATVypAgDcerAbxA
	IAnsysd7n5OuOM3KBFWvRNu2dg/oX71Hs2jG7++/NZ/moZ75GtERHPbPDTwCKkfTAz5f2gUIUy0
	GpL4XFdrUCuretPw+N8J7lRYE1Z81JbkgZXP7cKIst5OepgXniPZF1Vy9yYc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168f:b0:6aa:ef00:d568 with SMTP id
 006d021491bc7-6ae433d209bmr18009309eaf.33.1785856588295; Tue, 04 Aug 2026
 08:16:28 -0700 (PDT)
Date: Tue, 04 Aug 2026 08:16:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a72024c.13623e66.bdc14.0019.GAE@google.com>
Subject: [syzbot] [net?] WARNING in sk_mc_loop
From: syzbot <syzbot+22c3218a6fa219e47321@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d1ad8fb2ac6a ipv6: fix Route Information option length val..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13ece3b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=22c3218a6fa219e47321
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6ac38c0667ca/disk-d1ad8fb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/044e6f86eb06/vmlinux-d1ad8fb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3d3c493512e/bzImage-d1ad8fb2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+22c3218a6fa219e47321@syzkaller.appspotmail.com

------------[ cut here ]------------
1
WARNING: net/core/sock.c:782 at sk_mc_loop+0x126/0x160 net/core/sock.c:782, CPU#0: syz.2.1295/10498
Modules linked in:
CPU: 0 UID: 0 PID: 10498 Comm: syz.2.1295 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:sk_mc_loop+0x126/0x160 net/core/sock.c:782
Code: 08 48 89 df e8 db 03 9c f8 48 8b 1b 81 e3 00 00 10 00 31 ff 48 89 de e8 48 71 2e f8 48 89 d8 c1 e8 14 eb 0b e8 5b 6c 2e f8 90 <0f> 0b 90 b0 01 5b 41 5e 41 5f 5d c3 cc cc cc cc cc 44 89 f1 80 e1
RSP: 0018:ffffc90000007708 EFLAGS: 00010246
RAX: ffffffff8998a7a5 RBX: ffff88803229c000 RCX: ffff88802f8b0000
RDX: 0000000000000100 RSI: ffffffff90010c60 RDI: 0000000000000011
RBP: 0000000000000000 R08: ffff88802f8b0000 R09: 0000000000000002
R10: 000000000000000a R11: 0000000000000100 R12: ffff8880786423c0
R13: 0000000000000010 R14: 0000000000000011 R15: dffffc0000000000
FS:  00007febde0176c0(0000) GS:ffff888124f4d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000000f000 CR3: 000000005637a000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 ip6_finish_output2+0x62b/0x13c0 net/ipv6/ip6_output.c:84
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x337/0x540 net/ipv6/ip6_output.c:246
 ip6_mr_output+0x53e/0x1170 net/ipv6/ip6mr.c:2458
 dst_output include/net/dst.h:470 [inline]
 vrf_ip6_local_out drivers/net/vrf.c:406 [inline]
 vrf_process_v6_outbound drivers/net/vrf.c:454 [inline]
 is_ip_tx_frame drivers/net/vrf.c:556 [inline]
 vrf_xmit+0x1a60/0x1b40 drivers/net/vrf.c:568
 __netdev_start_xmit include/linux/netdevice.h:5400 [inline]
 netdev_start_xmit include/linux/netdevice.h:5409 [inline]
 xmit_one net/core/dev.c:3889 [inline]
 dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3905
 sch_direct_xmit+0x257/0x4c0 net/sched/sch_generic.c:372
 qdisc_restart net/sched/sch_generic.c:437 [inline]
 __qdisc_run+0xb11/0x1620 net/sched/sch_generic.c:445
 qdisc_run include/net/pkt_sched.h:120 [inline]
 net_tx_action+0x7cb/0xc30 net/core/dev.c:5863
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:914 [inline]
 __dev_queue_xmit+0x1edc/0x3820 net/core/dev.c:4913
 packet_snd net/packet/af_packet.c:3083 [inline]
 packet_sendmsg+0x3d95/0x5040 net/packet/af_packet.c:3115
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7febdd19e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007febde017028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007febdd426090 RCX: 00007febdd19e019
RDX: 0000000000000000 RSI: 00002000000000c0 RDI: 000000000000000d
RBP: 00007febdd23500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007febdd426128 R14: 00007febdd426090 R15: 00007ffdcdf75b38
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
