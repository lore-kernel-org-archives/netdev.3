Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761DD3BD241
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624494; cv=none; b=cvQYcRC2uRyRjKOl2U32eh+Fh33T0pAvfELp6tuC850XDQImkBUtoCrMzMLmpf4CsMgcmCLwYQeFT4K7nO19pmMjDu+ze+ufG3R1gvWfWokyI/uQjXTvwIpau76vIZKpd/uBK6Cg0Q9U2ioqkXXSPG+NXImKpkajlm+58Oj+ZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624494; c=relaxed/simple;
	bh=igbiI04Xvhk7YawMFY5L+lMPd1dL5HaPYU2VeX+vk08=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h1eEf62dvSMmDLKsHKkU7N11Vf7ziKiZz0ta+CXE03sUepmCkfdxRgHZyA+yPILDBblMTyhtHyVBJ5wF9hNGraNlV9/isnkikletzIwShHci/YNQIGHvOFSPP28GeT0BLquoVPc0i44HWy2utRDxNs1ZxwkRH7jn2dJhm6VFuGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b26d8d2498so5679534b6e.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790624491; x=1791229291;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhC/AiPsvX7sAIQK8MFKaiafgpDl/ZKIcUAkTRAJ2cg=;
        b=q3Spvl/Xh4k/XGqLf5FL9Y4imseCk0oOB2ak4IlwSjS38sNc5AhXQx2FZCoYz7uz0N
         0JYYJXGesS36Uev1txMuH6rRPCxGG8RHyxHK9CoqcvaG+e7rn2lc5hC7GQZIjLtNwkyv
         JuNBCrDXqzVlpVdw5o4DRA/UicriZIQEpd8RToXrggN+2UY6jRdQlBn9mfgTvDfNhFPk
         Zv+Ac9pjWZlbqe9BE/8MJuiDhTc1icfjT75rVUhvzT7Guf6iilM5iZDxXk2p+dNoJMUq
         JGmqyhmdZXo7Re9r0jfdWdqrdp6PTDro2ZPmSkb3l2oS0fanEy86FKXRAWDp7Iwl7RXp
         UNaQ==
X-Forwarded-Encrypted: i=1; AKwUvByKfKnBOIW5y0zabZzsNu0d79cF6og1V9d6E1Kd+er77/u9KghRtVC7c/2FCcYIyDCOOAzE+jA=@vger.kernel.org
X-Gm-Message-State: AFuF++m3JVfvwT0h8fFTJy4He+5UiMBNskHo6dUqxtUEsyY8Rpy1SYbo
	fblQ+PjavVy38UC/4rWGwZNbSySnKMQxY+STnKm3GeVoKHnIvxdbtMktCAenkAz51Q4R6oC9EQQ
	1ZrWg3fh5TMzm20E43RaZPI6mqlRgF+q1FFpfWWtQsOwCY7+Bv2V46mVyknk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f06:b0:4b9:e5fa:8904 with SMTP id
 5614622812f47-4d72cd31708mr15583967b6e.23.1790624491377; Mon, 28 Sep 2026
 12:41:31 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:41:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abac2eb.3654fce1.1bec97.0000.GAE@google.com>
Subject: [syzbot] [net?] WARNING in __skb_flow_dissect (8)
From: syzbot <syzbot+9408fbe0e6452a12e9ab@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8e60d3ddd25 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14800605580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=375776a45e10c065
dashboard link: https://syzkaller.appspot.com/bug?extid=9408fbe0e6452a12e9ab
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12800605580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138b2605580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ca9fd6dc9b6c/disk-e8e60d3d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/690b32d87cdf/vmlinux-e8e60d3d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35db39da550c/Image-e8e60d3d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9408fbe0e6452a12e9ab@syzkaller.appspotmail.com

tipc: Started in network mode
tipc: Node identity ac14143b, cluster identity 4711
tipc: New replicast peer: 10.1.1.0
------------[ cut here ]------------
WARNING: net/core/flow_dissector.c:1131 at __skb_flow_dissect+0x910/0x5368 net/core/flow_dissector.c:1126, CPU#1: syz.0.17/4912
Modules linked in:
CPU: 1 UID: 0 PID: 4912 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __skb_flow_dissect+0x910/0x5368 net/core/flow_dissector.c:1126
lr : __skb_flow_dissect+0x910/0x5368 net/core/flow_dissector.c:1126
sp : ffff800094906200
x29: ffff800094906700 x28: 0000000000000000 x27: 0000000000000002
x26: 0000000000000000 x25: ffff0000d05fd3c0 x24: dfff800000000000
x23: 0000000000000000 x22: 1ffff0001114beb7 x21: ffff800088a5f5b0
x20: 0000000000000000 x19: ffff700012920c58 x18: 00000000ffffffff
x17: ffff8000863d2120 x16: ffff8000863d32f4 x15: ffff80008a707000
x14: 000000000064059a x13: 0000000000000009 x12: 0000000000000009
x11: 00000000d6794b26 x10: 0000000000000003 x9 : 0000000000000400
x8 : 0000000000000000 x7 : ffff800084c05fcc x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800084c05fe8
x2 : 0000000000000001 x1 : ffff0000c46c9d80 x0 : 0000000000000000
Call trace:
 __skb_flow_dissect+0x910/0x5368 net/core/flow_dissector.c:1126 (P)
 __skb_get_hash_net+0xe0/0x29c net/core/flow_dissector.c:1903
 skb_get_hash include/linux/skbuff.h:1663 [inline]
 seg6_make_flowlabel+0xcc/0x1ec net/ipv6/seg6_iptunnel.c:132
 __seg6_do_srh_encap+0x320/0xbf4 net/ipv6/seg6_iptunnel.c:161
 seg6_do_srh+0x4b4/0xa44 net/ipv6/seg6_iptunnel.c:431
 seg6_output_core+0x164/0x688 net/ipv6/seg6_iptunnel.c:681
 seg6_output+0x44/0x1ac net/ipv6/seg6_iptunnel.c:744
 lwtunnel_output+0x3d0/0x664 net/core/lwtunnel.c:356
 dst_output include/net/dst.h:470 [inline]
 ip_local_out+0x110/0x148 net/ipv4/ip_output.c:131
 iptunnel_xmit+0x50c/0xd38 net/ipv4/ip_tunnel_core.c:97
 udp_tunnel_xmit_skb+0x220/0x348 net/ipv4/udp_tunnel_core.c:187
 tipc_udp_xmit+0x75c/0x9c0 net/tipc/udp_media.c:202
 tipc_udp_send_msg+0x214/0x374 net/tipc/udp_media.c:274
 tipc_bearer_xmit_skb+0x260/0x3b0 net/tipc/bearer.c:576
 tipc_enable_bearer net/tipc/bearer.c:366 [inline]
 __tipc_nl_bearer_enable+0xc90/0xfb0 net/tipc/bearer.c:1048
 tipc_nl_bearer_enable+0x2c/0x48 net/tipc/bearer.c:1057
 genl_family_rcv_msg_doit+0x1e4/0x2d4 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x43c/0x620 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x238/0x414 net/netlink/af_netlink.c:2575
 genl_rcv+0x38/0x50 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
 netlink_unicast+0x600/0x7f8 net/netlink/af_netlink.c:1364
 netlink_sendmsg+0x648/0x948 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:800 [inline]
 __sock_sendmsg+0xc8/0x17c net/socket.c:815
 ____sys_sendmsg+0x3d0/0x6c8 net/socket.c:2713
 ___sys_sendmsg+0x198/0x224 net/socket.c:2767
 __sys_sendmsg+0x158/0x204 net/socket.c:2799
 __do_sys_sendmsg net/socket.c:2804 [inline]
 __se_sys_sendmsg net/socket.c:2802 [inline]
 __arm64_sys_sendmsg+0x88/0x9c net/socket.c:2802
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:796
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:815
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 1573
hardirqs last  enabled at (1572): [<ffff80008030a2b4>] __local_bh_enable_ip+0x14c/0x234 kernel/softirq.c:478
hardirqs last disabled at (1573): [<ffff80008685dbf4>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:483
softirqs last  enabled at (1546): [<ffff800084bb85e4>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:698
softirqs last disabled at (1552): [<ffff8000863d31fc>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (1552): [<ffff8000863d31fc>] tipc_udp_xmit+0xb8/0x9c0 net/tipc/udp_media.c:181
---[ end trace 0000000000000000 ]---
tipc: Enabled bearer <udp:syz1>, priority 10


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
