Received: from mail.dspace.de (mail2.dspace.de [80.228.58.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC8189F43;
	Thu, 13 Aug 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.228.58.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613461; cv=none; b=VkYBjlIzwBLnKnJb6RKYUJEE6U6vqJgEItgstx8Lli9j5F5ZrFDY79BiOLOJJXI6X1ER0LtFpvqxsHVld2YPBDfTuskeekI31aPpdXaz7f9IgsHNR8F1PY+XFwgxtYW8fATftRW4fwa83cGiHfkNXxpGp9AURE9jYMbbktUBN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613461; c=relaxed/simple;
	bh=8X239YuAcOMnYnc9AYNbHk2ZSZRs/OAMvBKwGsVjT/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qTZooBjNavGlOoKcJhipKyTal1lq59iPB9L8qQtZXHavCAmX/62Mq5mdSH1Onp859zTZ+HcFk93daD/yObp6icsQ6Fm5yCpkLRxxUHAJo6rA7wvJks1t0jWfK8LjIW0j+qTAHTmzj9OaM0wdaFc0TwiWL8JGezc0fZTnT13mGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dspace.de; spf=pass smtp.mailfrom=dspace.de; dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de header.b=TlT49dYF; arc=none smtp.client-ip=80.228.58.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dspace.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de header.b="TlT49dYF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dspace.de; i=@dspace.de; q=dns/txt; s=dkim1;
  t=1786613457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EDSkPuqhX2mTjBU0NGJ0mhlqwLsfOa/ZlZKhNfqTkIE=;
  b=TlT49dYFspAdZLK5pdzZgANV/tieBjSeP4FUAkkNTOn02SKE9g/Tyu4X
   689+5UPlJTwzXGJtWRKYPm/mx+266XvJrTLGcX4finQUZo+lSKrwHR2bF
   M/zqUaX0CidcGgmBPJPhCzVfq+Ut4fzX2ZPOCG0FHQysS/cl6f+LfYV/P
   I=;
X-CSE-ConnectionGUID: 4pMY4SRqRjO/kfYRxSLhhg==
X-CSE-MsgGUID: UQ4DYQivQVqB0KVExOVYiQ==
X-IronPort-AV: E=Sophos;i="6.25,221,1779141600"; 
   d="scan'208";a="4838231"
Received: from unknown (HELO Z1-1000) ([10.1.1.222])
  by mail.dspace.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2026 11:29:45 +0200
Received: from VM-Z1-1000-LIVE.dspace.de (localhost [127.0.0.1])
	by Z1-1000 (Postfix) with ESMTP id F32AB60038;
	Thu, 13 Aug 2026 11:29:44 +0200 (CEST)
Received: from exchange.dspace.de (EX-DE-PAD-SE.dspace.de [10.100.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Z1-1000 (Postfix) with ESMTPS id DC3CF60036;
	Thu, 13 Aug 2026 11:29:44 +0200 (CEST)
Received: from PascalKW11-NB.dspace.de (10.183.71.218) by
 EX-DE-PAD-SE.dspace.de (10.100.196.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 11:29:43 +0200
From: Pascal Kneuper <PKneuper@dspace.de>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
CC: rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	0x1207@gmail.com, si.yanteng@linux.dev, larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pascal Kneuper <PKneuper@dspace.de>,
	Daniel Baldin <DBaldin@dspace.de>
Subject: [PATCH net] net: stmmac: restore NET_IP_ALIGN in the non-XDP RX
 path
Date: Thu, 13 Aug 2026 11:29:23 +0200 (CEST)
Message-ID: <20260813092923.284285-1-PKneuper@dspace.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX-DE-PAD-SE.dspace.de (10.100.196.14) To
 EX-DE-PAD-SE.dspace.de (10.100.196.14)
X-C2ProcessedOrg: 563f5800-21cf-4d8d-8aed-fddd1469e4ee
Content-Transfer-Encoding: quoted-printable
X-TBoneOriginalFrom: Pascal Kneuper <PKneuper@dspace.de>
X-TBoneOriginalTo: andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
X-TBoneOriginalCC: rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	0x1207@gmail.com, si.yanteng@linux.dev, larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pascal Kneuper <PKneuper@dspace.de>,
	Daniel Baldin <DBaldin@dspace.de>
X-TBoneDomainSigned: false

Fix an alignment exception panic on ARM32+stmmac in the non-XDP RX path.

Since the non-XDP RX path was converted to zero-copy, the page pool page
is handed to the stack directly as the skb head, and the offset the DMA
engine writes at is what determines the alignment of the packet headers.

Before the conversion the payload was copied into an skb obtained from
napi_alloc_skb(), which reserves NET_SKB_PAD + NET_IP_ALIGN. The
conversion moved the headroom into stmmac_rx_offset() but only carried
over NET_SKB_PAD, so on architectures where NET_IP_ALIGN is 2 the IP
header now lands misaligned.

On ARM32 this is fatal, because ldm and ldrd trap on unaligned addresses
even when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set.

Any received echo request panics the machine, e.g:

  Unhandled fault: alignment exception (0x001) at 0x81873062
  Internal error: : 1 [#1] SMP ARM
  Hardware name: Altera SOCFPGA Arria10
  PC is at icmp_echo+0x38/0xa8
  LR is at icmp_rcv+0x22c/0x370
  Call trace:
   icmp_echo from icmp_rcv+0x22c/0x370
   icmp_rcv from ip_protocol_deliver_rcu+0x2c/0x224
   ip_protocol_deliver_rcu from ip_local_deliver+0xc8/0x1a0
   ip_local_deliver from ip_sublist_rcv_finish+0x3c/0x50
   ip_sublist_rcv_finish from ip_list_rcv_finish+0x110/0x118
   ip_list_rcv_finish from ip_list_rcv+0xc8/0xdc
   ip_list_rcv from __netif_receive_skb_list_core+0x170/0x1c0
   ...
   napi_complete_done from stmmac_napi_poll_rx+0xcb0/0x1030
  Code: e24dd068 e59020a0 e28dc010 e0822001 (e8920003)
  Kernel panic - not syncing: Fatal exception in interrupt

Fix by adding NET_IP_ALIGN back to the RX offset, which restores the
alignment the stack used to get.

Note that commit a955318fe67e ("stmmac: align RX buffers") made a similar
change in 2021 and was reverted by commit 12d125b4574b ("stmmac: Revert
"stmmac: align RX buffers"") because it caused packet corruption. That
patch raised the offset from 0 without adjusting the buffer size
accounting, so the DMA engine could write past the end of the RX buffers.
Commit df542f669307 ("net: stmmac: Switch to zero-copy in non-XDP RX
path") since derives the page pool allocation from stmmac_rx_offset(), so
the extra bytes are accounted for.

Fixes: df542f669307 ("net: stmmac: Switch to zero-copy in non-XDP RX path=
")
Cc: Daniel Baldin <DBaldin@dspace.de>
Assisted-by: GitHub-Copilot-CLI:claude-opus-5
Signed-off-by: Pascal Kneuper <PKneuper@dspace.de>
---

We hit a reproducible panic on 6.18 on an ARM32 board with DWMAC1000 caus=
ed
by a regression from the zero-copy RX rework. Any incoming ping kills the
machine:

[   19.402031] 8<--- cut here ---
[   19.405088] Unhandled fault: alignment exception (0x001) at 0x81873062
[   19.411587] [81873062] *pgd=3D0181141e(bad)
[   19.415587] Internal error: : 1 [#1] SMP ARM
[   19.419838] Modules linked in: mod_dsproc(O) mod_dsnsm(O) mod_dscma(O)
[   19.426351] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G           =
O        6.18.37-rt6 #2 PREEMPT
[   19.437089] Tainted: [O]=3DOOT_MODULE
[   19.440559] Hardware name: Altera SOCFPGA Arria10
[   19.445239] PC is at icmp_echo+0x38/0xa8
[   19.449153] LR is at icmp_rcv+0x22c/0x370
[   19.453145] pc : [<80874f44>]    lr : [<8087522c>]    psr: 40070113
[   19.459382] sp : 8100fc00  ip : 8100fc10  fp : 8100fd08
[   19.464581] r10: 00000000  r9 : 93476380  r8 : 00000000
[   19.469779] r7 : 80e89900  r6 : 80e89900  r5 : 93476380  r4 : 93e3e900
[   19.476275] r3 : 00000000  r2 : 81873062  r1 : 00000062  r0 : 93e3e900
[   19.482770] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt user
[   19.489873] Control: 10c5387d  Table: 13fb004a  DAC: 00000055
[   19.495590] Register r0 information: slab skbuff_head_cache start 93e3=
e900 pointer offset 0 size 184
[   19.504694] Register r1 information: non-paged memory
[   19.509725] Register r2 information: non-slab/vmalloc memory
[   19.515359] Register r3 information: NULL pointer
[   19.520041] Register r4 information: slab skbuff_head_cache start 93e3=
e900 pointer offset 0 size 184
[   19.529140] Register r5 information: slab kmalloc-128 start 93476380 p=
ointer offset 0 size 128
[   19.537721] Register r6 information: non-slab/vmalloc memory
[   19.543354] Register r7 information: non-slab/vmalloc memory
[   19.548986] Register r8 information: NULL pointer
[   19.553668] Register r9 information: slab kmalloc-128 start 93476380 p=
ointer offset 0 size 128
[   19.562249] Register r10 information: NULL pointer
[   19.567017] Register r11 information: non-slab/vmalloc memory
[   19.572736] Register r12 information: non-slab/vmalloc memory
[   19.578455] Process swapper/0 (pid: 0, stack limit =3D 0x(ptrval))
[   19.584434] Stack: (0x8100fc00 to 0x81010000)
[   19.588773] fc00: 00000000 ffffffea 00000000 00000000 00000000 0000000=
2 81873062 80779c30
[   19.596913] fc20: 00000000 00000000 00000000 00000000 93e3e900 0000000=
0 b81b3d0a 93e3e900
[   19.605053] fc40: 93476380 80e89900 80e89900 00000000 93476380 0000000=
0 8100fd08 80779d8c
[   19.613192] fc60: 93e3e900 93476380 93e3e900 8087522c 80a7e794 93e3e90=
0 80e06a38 80e89900
[   19.621331] fc80: 00000000 93476380 00000000 8082c0e4 811521c0 9353915=
c 93e3e900 80e89900
[   19.629471] fca0: 00000000 93e3e900 8100fcd8 8082c3a4 8100fcd8 8100fcd=
8 00000000 8082b2f8
[   19.637610] fcc0: 8100fd08 8100fd08 8100fd08 8082ba4c 80e89900 98973c0=
a 8100fcd8 8100fcd8
[   19.645750] fce0: 93e3e900 93e3e900 8100fd48 81bc8000 80e89900 8100fd4=
8 81bc8000 8100fd08
[   19.653889] fd00: 80e89900 8082c598 8100fd08 8100fd08 8100fd3c 81bc938=
8 80e06f00 8082c4d0
[   19.662029] fd20: 8100fd48 81bc8000 00000000 80e06f00 81bc8000 8079ba6=
4 81bc9388 00000000
[   19.670168] fd40: 81bc9388 80e06f00 8100fd48 8100fd48 00000000 0000000=
0 81bc9388 81bc9388
[   19.678307] fd60: 8100fd8c 00000000 80e08040 80e896e8 81bc8580 8079bfe=
0 81bc9328 93e3e900
[   19.686447] fd80: 8100fd80 8100fd80 00000000 81bc9328 00000008 807d3e0=
0 81bc9388 00000488
[   19.694586] fda0: 81bc9300 00000000 00000001 81bcb580 ffffffff 8079c1d=
4 93e3e900 0000003c
[   19.702726] fdc0: 81bcb580 0000003b 81bc8580 00000000 00000488 0000000=
1 81bc8580 000000c8
[   19.710865] fde0: 81bcb580 806b3680 00000400 00007e83 8132af80 0000000=
0 81bc8680 81b64000
[   19.719004] fe00: 00002824 00000000 00000001 000000c8 00000001 0000000=
1 00000040 0000003c
[   19.727144] fe20: 00000008 98044760 81bcb140 000000c8 0000003c 0000000=
2 00000000 00000001
[   19.735283] fe40: 00000000 00000000 80e7ee58 00001000 00000000 0000000=
1 0000003c 81bc9300
[   19.743422] fe60: 00000002 8187307c 00000040 80e09778 80e7cae0 97c331c=
0 81873040 8187307c
[   19.751562] fe80: 81873040 81873000 81bc86c0 20070193 00001000 0000000=
0 81bc8580 98044740
[   19.759701] fea0: 98044760 80e08040 80e04f30 00000001 00000040 81bc930=
0 8100ff07 00000000
[   19.767840] fec0: 8100ff10 80e03d40 16ee6000 8079c2d0 81bc8580 0000000=
0 00000004 81bc9300
[   19.775980] fee0: 0000012c 8100ff08 fffbb7ec 8079c534 97c346c0 80d4e6c=
0 8100ff18 80e08040
[   19.784119] ff00: 81bcb000 00bc8580 8100ff08 8100ff08 8100ff10 8100ff1=
0 00000004 97c36d00
[   19.792259] ff20: 20070193 00000003 97c30090 801bc02c 00000000 801aaf9=
8 97c2ff40 8193eb80
[   19.800398] ff40: 813cd46c 813cd46c 00000000 0000001e 8100ffd0 801846e=
c 00000000 97c2ff4c
[   19.808537] ff60: 00000001 0000001e 80e7c470 00000004 00000008 80e0308=
c 80e08040 00000101
[   19.816677] ff80: 40000003 0000000c 80e03080 8012f47c 9c80210c 8100ffd=
0 80e03080 8100ff90
[   19.824816] ffa0: 80d49208 00000005 00000000 80d4ca40 80d4ca40 fffbb7e=
b 80e03d40 04200002
[   19.832956] ffc0: 9c80210c 80e7c474 80e08040 ffffffff 80e01f7c 97fff19=
b 80e08040 80baf400
[   19.841095] ffe0: 80e01f40 8012f740 8096f200 60070013 ffffffff 8012fa4=
c 8096f200 8094326c
[   19.849232] Call trace:
[   19.849238]  icmp_echo from icmp_rcv+0x22c/0x370
[   19.856356]  icmp_rcv from ip_protocol_deliver_rcu+0x2c/0x224
[   19.862085]  ip_protocol_deliver_rcu from ip_local_deliver+0xc8/0x1a0
[   19.868502]  ip_local_deliver from ip_sublist_rcv_finish+0x3c/0x50
[   19.874659]  ip_sublist_rcv_finish from ip_list_rcv_finish+0x110/0x118
[   19.881162]  ip_list_rcv_finish from ip_list_rcv+0xc8/0xdc
[   19.886627]  ip_list_rcv from __netif_receive_skb_list_core+0x170/0x1c=
0
[   19.893219]  __netif_receive_skb_list_core from netif_receive_skb_list=
_internal+0x1b0/0x298
[   19.901535]  netif_receive_skb_list_internal from napi_complete_done+0=
xfc/0x1cc
[   19.908813]  napi_complete_done from stmmac_napi_poll_rx+0xcb0/0x1030
[   19.915234]  stmmac_napi_poll_rx from __napi_poll.constprop.0+0x2c/0x1=
80
[   19.921910]  __napi_poll.constprop.0 from net_rx_action+0x110/0x284
[   19.928151]  net_rx_action from handle_softirqs+0xf0/0x238
[   19.933619]  handle_softirqs from __irq_exit_rcu+0xbc/0x130
[   19.939170]  __irq_exit_rcu from irq_exit+0x8/0x10
[   19.943944]  irq_exit from call_with_stack+0x18/0x20
[   19.948897]  call_with_stack from __irq_svc+0x6c/0x94
[   19.953932] Exception stack(0x80e01f48 to 0x80e01f90)
[   19.958960] 1f40:                   00000003 00000001 80e01f80 4000000=
0 80e04f10 00000000
[   19.967100] 1f60: 80e08040 80e04f50 97fff19b 00000000 80baf400 80e07d6=
c 16ee6000 80e01f98
[   19.975238] 1f80: 8096ebb4 8096f200 60070013 ffffffff
[   19.980266]  __irq_svc from default_idle_call+0x2c/0x30
[   19.985472]  default_idle_call from do_idle+0x8c/0xf4
[   19.990504]  do_idle from cpu_startup_entry+0x28/0x2c
[   19.995535]  cpu_startup_entry from kernel_init+0x0/0x12c
[   20.000910]  kernel_init from start_kernel+0x624/0x634
[   20.006041] Code: e24dd068 e59020a0 e28dc010 e0822001 (e8920003)
[   20.012106] ---[ end trace 0000000000000000 ]---
[   20.016702] Kernel panic - not syncing: Fatal exception in interrupt
[   20.023063] ---[ end Kernel panic - not syncing: Fatal exception in in=
terrupt ]---

Decoding the last few instructions:

  e59020a0    ldr r2, [r0, #0xa0]   ; r0 =3D skb, +0xa0 =3D skb->head
  e0822001    add r2, r2, r1        ; r1 =3D 0x62 =3D skb->transport_head=
er
  e8920003    ldm r2, {r0, r1}      ; <-- faults

That is in icmp_echo(), where the struct icmphdr contains a __be32,
so it has alignment 4. On ARMv7 ldm and ldrd always trap on unaligned add=
resses;
it looks like they are not covered by CONFIG_HAVE_EFFICIENT_UNALIGNED_ACC=
ESS.

From the register dump skb->head is 0x81873000 (page aligned) and
skb->transport_header is 0x62 =3D 98:

  64 (NET_SKB_PAD) + 14 (ethernet) + 20 (IP) =3D 98    98 % 4 =3D=3D 2

ARM32 has NET_IP_ALIGN=3D2, and the headers should have
landed at:

  66 (NET_SKB_PAD + NET_IP_ALIGN) + 14 + 20 =3D 100    100 % 4 =3D=3D 0

So the driver is handing the stack packets whose headers are 2 bytes
off.

This seems to have been introduced by:

  df542f669307 ("net: stmmac: Switch to zero-copy in non-XDP RX path")

Before that commit the payload was copied into an skb from napi_alloc_skb=
(),
which reserves NET_SKB_PAD + NET_IP_ALIGN, so the DMA buffer offset had n=
othing
to do with header alignment. After it, the page pool page *is* the skb he=
ad:

  skb =3D napi_build_skb(page_address(buf->page), rx_q->napi_skb_frag_siz=
e);
  head_pad_len =3D ctx.xdp.data - ctx.xdp.data_hard_start;
  skb_reserve(skb, head_pad_len);

head_pad_len is just buf->page_offset, i.e. stmmac_rx_offset(), i.e. the =
offset
the DMA engine writes at. The same commit changed stmmac_rx_offset() from=
 0 to
NET_SKB_PAD, and I think the NET_IP_ALIGN part was simply lost in the
conversion, since it used to come in implicitly via napi_alloc_skb().

Fix by adding NET_IP_ALIGN in stmmac_rx_offset.

I found while researching this that essentially the same one-liner was tr=
ied
before and did not end well:

  a955318fe67e ("stmmac: align RX buffers")                    [v5.14-rc1=
]
  12d125b4574b ("stmmac: Revert \"stmmac: align RX buffers\"")   [v5.14]

In 2021 stmmac_rx_offset() returned 0 for the non-XDP case, and that patc=
h
jumped it straight to NET_SKB_PAD + NET_IP_ALIGN, without touching any of=
 the
buffer size accounting. That accounting problem no longer exists, because
df542f669307 fixed it as a side effect of needing a correctly sized page =
for
napi_build_skb():

  dma_buf_sz_pad =3D stmmac_rx_offset(priv) + dma_conf->dma_buf_sz +
                   SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
  num_pages =3D DIV_ROUND_UP(dma_buf_sz_pad, PAGE_SIZE);
  pp_params.order =3D order_base_2(num_pages);
  rx_q->napi_skb_frag_size =3D num_pages * PAGE_SIZE;

The allocation is now derived from stmmac_rx_offset() instead of being
independent of it, so the two extra bytes are accounted for automatically=
.

Test setup:

  SoC        Intel/Altera Arria 10 SoC, armv7l
  MAC        DWMAC1000, Synopsys ID 0x37, User ID 0x10
  Kernel     6.18.37 + PREEMPT_RT

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
index a71f0df263785..2a57415be25cf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1529,7 +1529,7 @@ static unsigned int stmmac_rx_offset(struct stmmac_=
priv *priv)
 	if (stmmac_xdp_is_enabled(priv))
 		return XDP_PACKET_HEADROOM;
=20
-	return NET_SKB_PAD;
+	return NET_SKB_PAD + NET_IP_ALIGN;
 }
=20
 static int stmmac_set_bfsize(int mtu)
--=20
2.47.3

