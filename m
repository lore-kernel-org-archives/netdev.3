Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD413C0634
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820517; cv=none; b=kDgVO2aqGTNLnekdZwAlxrMGA99FkiZ8kt/8QlntPDU+u7L1M4EXdJSqsz9LItA/SrLNshtWRHmBfH6CQSOPpGkRyguUCc2n2XiHwb7hbWNwqQSISLLO838GrX5xlFvFmWxeqpMrYI/iwkud42euTrDIRTTJ/sr6AHhpH1UI/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820517; c=relaxed/simple;
	bh=ZWzqkQLtX7zz0s1ftCBsHz18fzzkbkjrDXkDpSa/SoU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s0oB0EYJghXqHmfs+LqH+hZCl2PRYhhnoqdXCeZSVFXFQTLuy4Q02DT24GUdkGgo+EeNYXxYBP6d5vfcH3524/ksatok4q5Be3DAmeUNWIdih7cD6cDEHT38D0MOkw2cvGrsyEyV8pZY42vepTIjUnyjk242M/tama/N5N38rX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b37733badcso1952057b6e.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820515; x=1788425315;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lk+8DHm03+mbNTwBCk8aXo/WXlgLh75aMPO/lE04rrk=;
        b=Paqbiq+mrTf5fPLJshpLw+pASc7TPBbvplErUt3Yd3zBbfSZRe0aAICCv3FCLzNq2r
         WiK3BzgxAmQChYS1quCP+FWTuXNt1HZaJaeVKyadFZNBTRPK20h/bjC2tzwxScr5iC9d
         MvbSvbRq+gW4IYT9Uc/+Ib+uslPgeAlNU04NFbeB6LW1l7C7MlRz1r5nIfWctSTWRmwU
         UTAhwWH6H/q0Qy1N+WrB5zZywoaTL9dwII90gDDjZHlHs4RmAqVLN0KUTrwkOUNQ4w2E
         baDoE6IEHV3rVMyT97fDGMnaZcJteFWgYlTEkMpUICx0/VTT1O/enqQ1hrpO/Et0N2UD
         MJfw==
X-Forwarded-Encrypted: i=1; AHgh+RoxlmRSxxfMVkwzQHOawsbfZ+sN/r1258s81pPFqyUXRWjWQntMDKmJAJ0ORrJbj2orOHSA8OI=@vger.kernel.org
X-Gm-Message-State: AFuF++klLs7C/v7LzePQjiHWuvQDvzYYl4pKA0osqgI4BmjrR9fMoz85
	Qg+kY1mSwxHpEcVeBH5Cia0slJXcoQncuUZN09KTxgJNfe46PGnpSlMBcXEUlhb8OCAAnSOGRBI
	/Uhes4RiyTd6bAJ+AO4sOAZoYP4hPHGFIF4zlX4dVLUSyHxGgpmbiKIsHYtU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2f1a:b0:495:ff85:d33d with SMTP id
 5614622812f47-4b366af5570mr14345201b6e.12.1787820514926; Thu, 27 Aug 2026
 01:48:34 -0700 (PDT)
Date: Thu, 27 Aug 2026 01:48:34 -0700
In-Reply-To: <6a8d5538.91706f20.ef82.0009.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8ff9e2.1d9ded08.62e62.00c9.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in trace_event_raw_event_icmp_send
From: syzbot <syzbot+6d2762674103618994b0@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	eric.dumazet@gmail.com, he.peilin@zte.com.cn, horms@kernel.org, 
	idosch@nvidia.com, jiayuan.chen@linux.dev, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, xu.xin16@zte.com.cn
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    68f892e99df9 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10735625580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=6d2762674103618994b0
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104dd579580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d2762674103618994b0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: ./include/linux/skbuff.h:3087 at skb_transport_header include/linux/skbuff.h:3087 [inline], CPU#1: syz-executor414/5032
WARNING: ./include/linux/skbuff.h:3087 at udp_hdr include/linux/udp.h:23 [inline], CPU#1: syz-executor414/5032
WARNING: ./include/linux/skbuff.h:3087 at do_trace_event_raw_event_icmp_send include/trace/events/icmp.h:30 [inline], CPU#1: syz-executor414/5032
WARNING: ./include/linux/skbuff.h:3087 at trace_event_raw_event_icmp_send+0x48c/0x6ec include/trace/events/icmp.h:11, CPU#1: syz-executor414/5032
Modules linked in:
CPU: 1 UID: 0 PID: 5032 Comm: syz-executor414 Not tainted syzkaller #0 PREEMPT 
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
sp : ffff8000985f6d60
x29: ffff8000985f6e40 x28: ffff0000da5d0340 x27: ffff0000dec03d36
x26: 000000000000ffff x25: ffff7000130bedb4 x24: 000000000000ffff
x23: 0000000000000030 x22: 1fffe0001bd807a6 x21: ffff0000dec03c80
x20: ffff0000c1afa014 x19: ffff0000d477d7c8 x18: 0000000000000000
x17: ffff80008a7d6000 x16: 0000000000000004 x15: ffff800084be8404
x14: ffff800084be8240 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 000000000000007f x9 : 0000000000000400
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000008 x3 : ffff800085503d58
x2 : 000000000000ffff x1 : ffff0000d477d7c0 x0 : 0000000000000000
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
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590
irq event stamp: 12633
hardirqs last  enabled at (12632): [<ffff8000804e3a00>] __call_rcu_common kernel/rcu/tree.c:3184 [inline]
hardirqs last  enabled at (12632): [<ffff8000804e3a00>] call_rcu+0x460/0x75c kernel/rcu/tree.c:3279
hardirqs last disabled at (12633): [<ffff80008690cc28>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:445
softirqs last  enabled at (12592): [<ffff800084c0e4cc>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:698
softirqs last disabled at (12598): [<ffff800084c7a6c0>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (12598): [<ffff800084c7a6c0>] rcu_read_lock_bh include/linux/rcupdate.h:893 [inline]
softirqs last disabled at (12598): [<ffff800084c7a6c0>] __dev_queue_xmit+0x1fc/0x2bc0 net/core/dev.c:4796
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
