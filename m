Received: from smtp-relay3.dhosting.pt (smtp-relay3.dhosting.pt [176.221.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B312212548
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.221.38.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784451793; cv=none; b=R0nNwCrN4mhvZK56YeI74i158z7yehz7RheMr+1961C1NcRJVRZ3N0VTfXAZn/HgeoTzT17Umap14XkROrKIy1XV8yvRxP+kPPlh4oVcLPfNc9gK5Gov2+mmPIAl3UNvRmGn5PcvsjpJGZxuP8AC5Jvf3Mng8N7x7YFvSBTKobM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784451793; c=relaxed/simple;
	bh=RSVXWfxniqZCTZ2T5EqSzqlYamQRa124sR9c49BBG3g=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=mkdfhQZsgorOfEihXPm1TZ55LeDyHDDcMSRIaNYiAdPjrvHzrQQAMQbRnXtcl873ppgQqkzm4+lT4ktVkIWDVIO0i3jYdksXdbfPL77SvSDZYsM/mJ82BMs6lmGYwXmlQnSFrvWzqE5FHg9vSC7h9dDS4xWO/vDcGqy6S+RLCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decimal.pt; spf=pass smtp.mailfrom=decimal.pt; arc=none smtp.client-ip=176.221.38.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decimal.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decimal.pt
Received: from fastmail.decimal.pt (mail.dhosting.pt [185.99.235.86])
	by smtp-relay3.dhosting.pt (Postfix) with ESMTPS id 0005D101EC0
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 10:03:05 +0100 (WEST)
Received: from fastmail.decimal.pt (localhost [127.0.0.1])
	by fastmail.decimal.pt (Postfix) with ESMTP id A38C11009DD
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 10:03:05 +0100 (WEST)
Received: from dhosting.pt (webservices.decimal.pt [185.99.235.92])
	(Authenticated sender: mysql.jorge@decimal.pt)
	by fastmail.decimal.pt (Postfix) with ESMTPA id 8488210083D
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 10:03:05 +0100 (WEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jul 2026 10:03:05 +0100
From: Jorge Bastos <mysql.jorge@decimal.pt>
To: netdev@vger.kernel.org
Subject: tc/iproute2 7.1 crash with kernel with and without SECCOMP
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <41a5cb8db248eb2c76707289d10f7459@decimal.pt>
X-Sender: mysql.jorge@decimal.pt
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Howdy,

I have some VM's that were working ok, and since arround kernel 6.18x 
and 7.1x kernel crashes when using fireqos, that uses "tc" from 
iproute2,

I'm using now kernels with SECCOMP because of ssh 10.4+,
How to make this compatible and working?

Thanks in advanced,
Jorge Bastos


BUG: kernel NULL pointer dereference, address: 0000000000000628
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0
Oops: Oops: 0002 [#1] SMP PTI
CPU: 1 UID: 0 PID: 14042 Comm: tc Not tainted 7.1.3 #1 PREEMPT(full)
Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, 
BIOS 090007 05/18/2018
RIP: 0010:tcx_miniq_inc+0x2c/0x40 [sch_ingress]
Code: 89 fb e8 f7 77 52 e1 85 c0 75 18 48 8d 3d 1c 3d e7 ff ba 81 00 00 
00 48 c7 c6 23 70 0d a0 67 48 0f b9 3a 48 8b 83 00 02 00 00 <ff> 80 28 
06 00 00 5b c3 cc cc cc cc 0f 1f 84 00 00 00 00 00 90 90
RSP: 0018:ffffc9000064f930 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff88805783b808 RCX: 0000000000000000
RDX: ffff88805783b800 RSI: 0000000000000082 RDI: ffffffff82465bc0
RBP: 00000000fffffff4 R08: ffff888004cc6e88 R09: 00000000000000d4
R10: 00000000000000d0 R11: 00000000000000d5 R12: ffff88805783b808
R13: ffff88808c92efa8 R14: ffff888004651000 R15: ffffc9000064fb48
FS: 00007fb985608780(0000) GS:ffff888180ab3000(0000) 
knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000628 CR3: 00000000a2b34004 CR4: 00000000001706b0
Call Trace:
<TASK>
ingress_init+0x6e/0x110 [sch_ingress]
qdisc_create+0x297/0x370
tc_modify_qdisc+0x639/0x6c0
rtnetlink_rcv_msg+0x278/0x2d0
? __kmalloc_node_track_caller_noprof+0x37/0x320
? __alloc_skb+0xc3/0x110
? __pfx_rtnetlink_rcv_msg+0x10/0x10
netlink_rcv_skb+0x83/0xe0
netlink_unicast+0x11c/0x1b0
netlink_sendmsg+0x271/0x2d0
sock_sendmsg_nosec+0x32/0x40
____sys_sendmsg+0x10b/0x180
? copy_msghdr_from_user+0x6a/0xa0
___sys_sendmsg+0x79/0xc0
? ___sys_recvmsg+0x82/0xb0
? __handle_mm_fault+0x71f/0x7a0
? css_uses_rstat+0x9/0x20
? __css_rstat_updated+0x22/0x70
__sys_sendmsg+0x63/0xa0
do_syscall_64+0x116/0x2a0
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fb98529bcb2
Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e2 39 83 fa 08 
75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 
18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
RSP: 002b:00007ffd5106e180 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000055bdbf033640 RCX: 00007fb98529bcb2
RDX: 0000000000000000 RSI: 00007ffd5106e240 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 000000006a57f9a8 R14: 00007ffd5107e540 R15: 000055bdbf033640
</TASK>
Modules linked in: sch_ingress sch_htb ifb xt_tcpmss iptable_mangle 
xt_tcpudp xt_conntrack iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 iptable_filter ip_tables x_tables aesni_intel gf128mul 
libaes aead crypto_skcipher rtc_cmos button sg sch_fq_codel loop fuse 
configfs
CR2: 0000000000000628
---[ end trace 0000000000000000 ]---
RIP: 0010:tcx_miniq_inc+0x2c/0x40 [sch_ingress]
Code: 89 fb e8 f7 77 52 e1 85 c0 75 18 48 8d 3d 1c 3d e7 ff ba 81 00 00 
00 48 c7 c6 23 70 0d a0 67 48 0f b9 3a 48 8b 83 00 02 00 00 <ff> 80 28 
06 00 00 5b c3 cc cc cc cc 0f 1f 84 00 00 00 00 00 90 90
RSP: 0018:ffffc9000064f930 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff88805783b808 RCX: 0000000000000000
RDX: ffff88805783b800 RSI: 0000000000000082 RDI: ffffffff82465bc0
RBP: 00000000fffffff4 R08: ffff888004cc6e88 R09: 00000000000000d4
R10: 00000000000000d0 R11: 00000000000000d5 R12: ffff88805783b808
R13: ffff88808c92efa8 R14: ffff888004651000 R15: ffffc9000064fb48
FS: 00007fb985608780(0000) GS:ffff888180ab3000(0000) 
knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000628 CR3: 00000000a2b34004 CR4: 00000000001706b0
