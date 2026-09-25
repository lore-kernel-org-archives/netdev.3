Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CD147D93E
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328256; cv=none; b=AGVMNr8ezwWbhn2s+iq/jcZ+OrE7h1w31jIQ30ACj5NXk1j9kuooqKazzuUvGCv+gVPj3g3MxQHj8bEQT++BWZUG52IC7FGmVCuUUmYjiZkxkLJ7c/aNtKQWXwbPQwYP4wcAMx8cH+zmIt+/l1HysfqDshw4rSe/8ZB0bbH/D58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328256; c=relaxed/simple;
	bh=Mun91e+a2sgF6TvIy/utfHU4x6hsKg0c3RJ65Bt4F9Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Oua8MLB3PkV0hp39t/OxRM9mfvYlA1LRqaWfzjA0QbT4qeYkWQm7lvZD3yxFwGto6RZF5KxIc8VlgH8HH9Ec2Mbkz9iCy776uw02vVfGgf4yRFm4pvqH8ceg8XeTj3cXRwnNkHkPcA6AE3iKVlTsG9udfQnFzsKN+qwL1btyr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4519ef1babeso727266fac.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 02:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790328251; x=1790933051;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SG9sz1wN9Eat286bNsFicmln6CdKM5JJEaOgRGJ1Aao=;
        b=krhesFqLS8CO9Y7pkslGIWkChgsx2Y2yGIKtzbbSIo3zo92/F0Fpiyts0LwhLHD3vV
         /VxddZgcrUiH7X+GDdbsMEjIs+L9dzKsRWdTef1s2180D4H8VA9H0omgNVNLPShF/bWT
         Z6+CfX6pwABnZ2ramXpJGQnIPsWfHNBL/P6Stlf4279y+cNWkoRn7JPxOyBbUUnSNj8R
         PsUOZlCY3sK07WvLlFwYg91h5RHRhZ9TbPgMb0dbZV62ZS24VvEiDyNS0HOF6KYys23T
         E3Fx7Oaa87BRJh0mN7DuHfHiwLHx7GDxBrrq/HiRxWqQuyODCvLUx/T7CGMVkwAcepFI
         RWqw==
X-Forwarded-Encrypted: i=1; AKwUvBxcxflJgh6dHCS912lYGeu/13k/+dxBz74j/34W/jagIuCwhdNQHNMp2j7LbTjZafnGS9o2Lbo=@vger.kernel.org
X-Gm-Message-State: AFuF++lcno4d5TO0QORZH3ACTb1BGxPiFgumZ1AxJ3plQ/E2uAPz9bFj
	H9f8tGRe1sQoT4oUpGAP2GlP7izsD2yONmN+mZF8hxpDE1SSkjPYC3WGaYSbqfA59M4ml7MazjI
	P2A3/zvxnBAhCrhRB544eNvX5fAv3JRovY5rk5R14hThuGbc9j96SeBVhM1o=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:11c9:b0:4b3:98f4:f057 with SMTP id
 5614622812f47-4dc57e294demr1386127b6e.3.1790328251491; Fri, 25 Sep 2026
 02:24:11 -0700 (PDT)
Date: Fri, 25 Sep 2026 02:24:11 -0700
In-Reply-To: <6b07af04b3ba66a09009e1a0a7b98ec5ec85d3a0.1790109248.git.sunnytiwari@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab63dbb.7eec07f4.c25c.0005.GAE@google.com>
Subject: [syzbot ci] Re: net/rds: replace tasklets with workqueue
From: syzbot ci <syzbot+cic449f4593b46dd93@syzkaller.appspotmail.com>
To: achender@kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rds-devel@oss.oracle.com, 
	santosh.shilimkar@oracle.com, sunnytiwari@google.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] net/rds: replace tasklets with workqueue
https://lore.kernel.org/all/6b07af04b3ba66a09009e1a0a7b98ec5ec85d3a0.1790109248.git.sunnytiwari@google.com
* [PATCH net-next] net/rds: replace tasklets with workqueue

and found the following issue:
WARNING in __alloc_workqueue

Full report is available here:
https://ci.syzbot.org/series/e7102860-1b25-4e10-b653-afe8e9820ef8

***

WARNING in __alloc_workqueue

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      42a9fb3382fc2573e92f41d203b095d9a372cfc9
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/220e9c3a-eede-449e-8bb1-d34ad95dc867/config

gre: GRE over IPv4 demultiplexer driver
ip_gre: GRE over IPv4 tunneling driver
IPv4 over IPsec tunneling driver
Initializing XFRM netlink socket
IPsec XFRM device driver
xfrm_iptfs: IPsec IP-TFS tunnel mode module
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
RPL Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
mip6: Mobile IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
ip6_gre: GRE over IPv6 tunneling driver
NET: Registered PF_PACKET protocol family
PFKEY is deprecated and scheduled to be removed in 2027, please contact the netdev mailing list
NET: Registered PF_KEY protocol family
Bridge firewalling registered
NET: Registered PF_X25 protocol family
X25: Linux Version 0.2
can: controller area network core
NET: Registered PF_CAN protocol family
can: raw protocol
can: broadcast manager protocol
can: netlink gateway - max_hops=1
can: SAE J1939
can: isotp protocol (max_pdu_size 8300)
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
Bluetooth: HIDP socket layer initialized
NET: Registered PF_RXRPC protocol family
Key type rxrpc registered
Key type rxrpc_s registered
NET: Registered PF_KCM protocol family
l2tp_core: L2TP core driver, V2.0
l2tp_ppp: PPPoL2TP kernel driver, V2.0
l2tp_ip: L2TP IP encapsulation support (L2TPv3)
l2tp_netlink: L2TP netlink interface
l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
NET: Registered PF_PHONET protocol family
8021q: 802.1Q VLAN Support v1.8
sctp: Hash tables configured (bind 32/56)
NET: Registered PF_RDS protocol family
------------[ cut here ]------------
workqueue: rds_ib_wq is using neither WQ_PERCPU or WQ_UNBOUND. Setting WQ_PERCPU.
WARNING: kernel/workqueue.c:5939 at __alloc_workqueue+0x1cd2/0x1fe0, CPU#1: swapper/0/1
Modules linked in:
CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__alloc_workqueue+0x1cd5/0x1fe0
Code: 0b 90 e9 6d fc ff ff e8 89 02 39 00 e9 7f fb ff ff e8 7f 02 39 00 e9 85 fb ff ff e8 75 02 39 00 48 8d 3d ce 68 ee 0e 4c 89 f6 <67> 48 0f b9 3a 41 81 cf 00 01 00 00 e9 10 e6 ff ff e8 55 02 39 00
RSP: 0000:ffffc900000676a8 EFLAGS: 00010293
RAX: ffffffff818ed98b RBX: 0000000000000000 RCX: ffff888102adda00
RDX: 0000000000000000 RSI: ffff888173f5d170 RDI: ffffffff907d4260
RBP: ffffffff8d43a5a0 R08: ffff888102adda00 R09: 0000000000000002
R10: 0000000000000102 R11: 0000000000000000 R12: ffff888173f5d000
R13: ffff888173f5d000 R14: ffff888173f5d170 R15: 0000000000000018
FS:  0000000000000000(0000) GS:ffff8882a8cc6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000eb48000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 alloc_workqueue_noprof+0xe3/0x210
 rds_ib_init+0x54/0x190
 rds_rdma_init+0x74/0x170
 do_one_initcall+0x250/0x870
 do_initcall_level+0x10a/0x1a0
 do_initcalls+0x59/0xa0
 kernel_init_freeable+0x29d/0x3e0
 kernel_init+0x22/0x1d0
 ret_from_fork+0x514/0xb70
 ret_from_fork_asm+0x1a/0x30
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.
