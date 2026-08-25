Received: from mail-oi2-f2.google.com (mail-oi2-f2.google.com [74.125.231.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B813A5456
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647291; cv=none; b=CNPQUxr1zuaduUxX61t1KdmwtGbylVN8OSyAyYauAZyhxQTPw4chlmm8RprSedwb3njpY9yI83i5K1kkBkoRlhqBIW25/vbg/sw8lZAiEfiv/Ui5pxR9D1vpa8W5EEDRHIDj114F0tK3r8aUSHLhereVxQRWZKyCOAJkjPKuOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647291; c=relaxed/simple;
	bh=JjDmOj1GqFNPXlCmwyCFyqPpBM4BQfOkb/aT67Mi1vQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MVYaLABOrSP58Rrb1jtnqBwWnTvzH7zYoXRhnN11lRE0bTb5DrJfroNaOkfF7/OgAqDE1Ds8ECzARwnHgjk0NT73XKNdKrB/k1W3lBw1HQOv6HnWdqFDHZ+Rn1EOIBS/V4kH/dOlYv+RkxCOHSqH4NA9p7k1l4TVXUfenI3Aaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f2.google.com with SMTP id 5614622812f47-495d5d27acfso2078041b6e.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647288; x=1788252088;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRK/PKPVvSzj2nn7/8M9Fn4v9/q4xHzhBBlzpDw/nIk=;
        b=aKn643+cPl0AyL4TyHf3EF1cKJno5VhCbqHDv2UdjTbCKPHOCKsx81DfINuiHnEgUJ
         +O/2t8WTb9vCxnSYAJiCiL1cJLAf+LlPN9b3jnhtcve8abdPTpMhpkrQrSUFdev/mdEe
         vk1xFs+JiPJsiDlxsJvABymQjh9S/Bnvf4kNuFnqQM9JGKqQ3bRJPAJouMGRwhZSht2w
         R5u7TZjLAJrFZ6N0xthOTFKzPRoWHSuaznAY/aF4BhkW1cmCQVocEbeF8rjjJ7tUnTjh
         oVGUiqh/v0IbAO3MXK8/wvttSHz4YifrAOVnicwX3CT2UwVxsHLmJxDLbdJX4+Z/zdoo
         HxwA==
X-Forwarded-Encrypted: i=1; AHgh+RooT8SrYVqFg1d9h6gCfW6Zxx9kYbAigTztF64F5DhZMs/rSBdJdV7LeBi0OSHd/4/qHoy8KkU=@vger.kernel.org
X-Gm-Message-State: AFuF++kj+Y74UqjOG+eGvY73R0qp9mtE6EPEYEPnDobo09JWGj0Uqp5V
	b42K2kwSk6dZkDAmlsOTBDF5Lqaow/MgjvNTnpCwtifDgwK3fthhgESu8aeh88iKCHWvbGmpPYq
	QiR/MHs3Ms4rTKqruTi2i0ltLJIS4h1RAeKJ6s+ShaBJY9FYOfsTXvIWcOdE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:22ab:b0:4a3:f4b7:cbdf with SMTP id
 5614622812f47-4b2ef3b0cb6mr31741226b6e.15.1787647288622; Tue, 25 Aug 2026
 01:41:28 -0700 (PDT)
Date: Tue, 25 Aug 2026 01:41:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8d5538.91706f20.ef82.0009.GAE@google.com>
Subject: [syzbot] [net?] WARNING in trace_event_raw_event_icmp_send
From: syzbot <syzbot+6d2762674103618994b0@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    68f892e99df9 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1570b979580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=6d2762674103618994b0
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f98dd20a7b98/disk-68f892e9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/441f1ad32549/vmlinux-68f892e9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8da5227b7dc8/Image-68f892e9.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d2762674103618994b0@syzkaller.appspotmail.com

binder: 11339:11341 DecRefs 0 refcount change on invalid ref 3 ret -22
------------[ cut here ]------------
WARNING: ./include/linux/skbuff.h:3087 at skb_transport_header include/linux/skbuff.h:3087 [inline], CPU#1: syz.7.1884/11341
WARNING: ./include/linux/skbuff.h:3087 at udp_hdr include/linux/udp.h:23 [inline], CPU#1: syz.7.1884/11341
WARNING: ./include/linux/skbuff.h:3087 at do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline], CPU#1: syz.7.1884/11341
WARNING: ./include/linux/skbuff.h:3087 at trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11, CPU#1: syz.7.1884/11341
Modules linked in:
CPU: 1 UID: 0 PID: 11341 Comm: syz.7.1884 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : skb_transport_header include/linux/skbuff.h:3087 [inline]
pc : udp_hdr include/linux/udp.h:23 [inline]
pc : do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline]
pc : trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11
lr : skb_transport_header include/linux/skbuff.h:3087 [inline]
lr : udp_hdr include/linux/udp.h:23 [inline]
lr : do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline]
lr : trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11
sp : ffff800094826d60
x29: ffff800094826e40 x28: ffff0000d2770000 x27: ffff0000f3109e76
x26: 000000000000ffff x25: ffff700012904db4 x24: 000000000000ffff
x23: 00000000000000a0 x22: 1fffe0001e6213ce x21: ffff0000f3109dc0
x20: ffff0000fbb766f0 x19: ffff0000d3be1d48 x18: 00000000ffffffff
x17: ffff80008a7d6000 x16: 0000000000000004 x15: ffff80008a35fda0
x14: ffff80008a5d5e28 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000080000 x9 : 00000000000033d0
x8 : ffff8000a22ec000 x7 : 0000000000000000 x6 : 646165725f756372
x5 : ffff0000fbb766e9 x4 : 0000000000000008 x3 : ffff800085503d58
x2 : 000000000000ffff x1 : ffff0000d3be1d40 x0 : 0000000000000001
Call trace:
 skb_transport_header include/linux/skbuff.h:3087 [inline] (P)
 udp_hdr include/linux/udp.h:23 [inline] (P)
 do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline] (P)
 trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11 (P)
 __traceiter_icmp_send include/trace/events/icmp.h:11 [inline]
 __do_trace_icmp_send include/trace/events/icmp.h:11 [inline]
 trace_icmp_send+0x320/0x49c include/trace/events/icmp.h:11
 __icmp_send+0xcfc/0x11d8 net/ipv4/icmp.c:1013
 ipv4_send_dest_unreach net/ipv4/route.c:1280 [inline]
 ipv4_link_failure+0x57c/0x8dc net/ipv4/route.c:1287
 dst_link_failure include/net/dst.h:438 [inline]
 vti_xmit net/ipv4/ip_vti.c:271 [inline]
 vti_tunnel_xmit+0xe40/0x17a4 net/ipv4/ip_vti.c:307
 __netdev_start_xmit include/linux/netdevice.h:5397 [inline]
 netdev_start_xmit include/linux/netdevice.h:5406 [inline]
 xmit_one net/core/dev.c:3889 [inline]
 dev_hard_start_xmit+0x1dc/0x9d4 net/core/dev.c:3905
 __dev_queue_xmit+0xed4/0x2bc0 net/core/dev.c:4878
 dev_queue_xmit include/linux/netdevice.h:3448 [inline]
 packet_xmit+0x6c/0x314 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3107 [inline]
 packet_sendmsg+0x2f40/0x3e78 net/packet/af_packet.c:3139
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg+0xc8/0x17c net/socket.c:790
 __sys_sendto+0x250/0x328 net/socket.c:2252
 __do_sys_sendto net/socket.c:2259 [inline]
 __se_sys_sendto net/socket.c:2255 [inline]
 __arm64_sys_sendto+0xec/0x10c net/socket.c:2255
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x19c/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590
irq event stamp: 3053
hardirqs last  enabled at (3052): [<ffff800082179080>] get_random_u8+0x3d8/0x7dc drivers/char/random.c:539
hardirqs last disabled at (3053): [<ffff80008690cc28>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:445
softirqs last  enabled at (3024): [<ffff800084c0e4cc>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:698
softirqs last disabled at (3028): [<ffff800084c7a6c0>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (3028): [<ffff800084c7a6c0>] rcu_read_lock_bh include/linux/rcupdate.h:893 [inline]
softirqs last disabled at (3028): [<ffff800084c7a6c0>] __dev_queue_xmit+0x1fc/0x2bc0 net/core/dev.c:4796
---[ end trace 0000000000000000 ]---


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
