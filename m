Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4044A3E0;
	Mon, 21 Sep 2026 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024768; cv=none; b=JrvGdwvUpecd9NuXpceduP7Bh9dK7c7vSPsPy1jZz6uEmI7cvmtEuqI6qI/qRwYy7CRxH8X3qtMtJPG3rz96MBomCgIH34Ethkz6Fwrgv06nRe2XLNh9Obitb4AqxtEl260j629nTa+CiJiBrzyYFjF9bBbdpc2M4Kkr7NrzNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024768; c=relaxed/simple;
	bh=xo15Ldlf6HjKkt0noKy+MZtF37UoEIRBemOaxRp/cAg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r8U6aSA9uxNSya25gObae9cSBd1Wo8vyRdSBGoljDzEutuVDOZYAxJ6Wn25d3lH5pmkIchtoHikYtKvIy8+lUG9s8fldj21ZNbERFzu51UYkTGUQIHWGAK0qhuXu1p/aBSQuQtMi0G4Bkwbe4SpUsWj7hqH059l+veMfhxAtxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=U9tDJgMX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="U9tDJgMX"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 26BAF205E5;
	Mon, 21 Sep 2026 23:06:04 +0200 (CEST)
X-Virus-Scanned: by secunet
X-Amavis-Alert: BAD HEADER SECTION, Improper use of control character (char 0D
 hex): Subject: ..._count underflow when sharing page_pool frags
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DH2UkIVxXXVe; Mon, 21 Sep 2026 23:06:03 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 00F54201CC;
	Mon, 21 Sep 2026 23:06:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 00F54201CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1790024763;
	bh=gwDoVM4+Ii4zvTTYqAXB09NiO/zmd5p1gu/QkmFAlow=;
	h=From:To:CC:Subject:Date:From;
	b=U9tDJgMXUbXiRlLSXHsVHLqGln0dWvLAgmO3N65Ps9XPfyGRtG1tBXZmD2ikIDaA3
	 EjSM7Gj3Kd/DtSqLXNyR+7Vvn4YTqpIm1QE1M0xiJZJKUsZDeZzG7rN12BhBaOfbXj
	 +HIl6GMBAC0FnRbR+MQ01kt6XappkGc0SlNuhoPNwbpFdpt3Cj+2FvS+aHxdGNbgVy
	 DA7eXr8MLrjAncVU/TPFAtyvYnvpCmHQiuJvYit4Gp3+//+nqhrCfuR/s4kmnUPiDY
	 hf5uhK02tlCpcZ4LrcapzU+QFxQ7vDMbcC5FRZozNdI50LVAqEUbnxHsXzJ3922YrL
	 /+0aBLD4bl/sA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 21 Sep
 2026 23:06:02 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Christian Hopps
	<chopps@labn.net>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec] xfrm: iptfs: fix pp_ref_count underflow when sharing page_pool frags
Date: Mon, 21 Sep 2026 23:05:49 +0200
Message-ID: <xfrm-iptfs-pp_ref_count-underflow-v1-1-5fb363833d41@secunet.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: xfrm-iptfs-pp_ref_count-underflow-063ee0302600
X-Mailer: b4 0.16-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)

skb frags are either page_pool pages tracked via pp_ref_count
(released by napi_pp_put_page()), or regular pages tracked via
_refcount (released by put_netmem()).
skb->pp_recycle was unbalanced and caused the underflow that
hit BUG().

Fix by taking the share with page_pool_ref_page(), matching
skb_pp_frag_ref() in skb_try_coalesce().

Reproduced by sharing the same page_pool frag into two extra skbs,
releasing both before the page rotates out, then forcing rotation --
trips WARN_ON(ret < 0) in page_pool_unref_netmem() with the bug,
silent with the fix.

[  113.863676] ------------[ cut here ]------------
[  113.863687] WARNING: ./include/net/page_pool/helpers.h:297 at page_pool_put_netmem.constprop.0+0x1f/0x40, CPU#0: swapper/0/0
[  113.863706] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc2-00235-gddb06ebf175f-dirty #5 PREEMPT(full)
[  113.863713] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  113.863718] RIP: 0010:page_pool_put_netmem.constprop.0+0x1f/0x40
[  113.863725] Code: 90 90 90 90 90 90 90 90 90 90 90 48 89 f0 48 83 e0 fe 48 8b 48 28 48 ff c9 74 20 48 83 c9 ff f0 48 0f c1 48 28 48 ff c9 79 07 <0f> 0b c3 cc cc cc cc 75 13 48 c7 40 28 01 00 00 00 0f b6 ca 83 ca
[  113.863731] RSP: 0018:ffffc90000003c98 EFLAGS: 00010296
[  113.863738] RAX: ffffea0004192d80 RBX: ffff8881017e1200 RCX: ffffffffffffffff
[  113.863742] RDX: 0000000000000001 RSI: ffffea0004192d80 RDI: ffff888101ce2000
[  113.863746] RBP: 000000000000000c R08: 000000000000003c R09: 0000000000000a00
[  113.863750] R10: 0000000000000001 R11: 00000000000007e0 R12: 0000000000000000
[  113.863754] R13: ffff888101ce3000 R14: ffffea0004192d80 R15: ffff888100a779c0
[  113.863763] FS:  0000000000000000(0000) GS:ffff8881f8a8b000(0000) knlGS:0000000000000000
[  113.863768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  113.863773] CR2: 00007ff837b28000 CR3: 0000000106e91005 CR4: 0000000000170eb0
[  113.863777] Call Trace:
[  113.863784]  <IRQ>
[  113.863787]  page_to_skb+0x1f3/0x210
[  113.863798]  receive_buf+0x712/0xca0
[  113.863807]  ? detach_buf_split_in_order+0x5d/0x110
[  113.863819]  virtnet_poll+0x1da/0x460
[  113.863829]  __napi_poll.constprop.0+0x2a/0x120
[  113.863838]  net_rx_action+0x11a/0x230
[  113.863847]  ? raise_softirq_irqoff+0x5/0x20
[  113.863857]  ? __napi_schedule+0x31/0x50
[  113.863864]  ? vring_interrupt+0x77/0x90
[  113.863871]  handle_softirqs+0x127/0x260
[  113.863880]  __irq_exit_rcu+0x50/0xf0
[  113.863888]  common_interrupt+0x95/0xc0
[  113.863910]  </IRQ>
[  113.863914]  <TASK>
[  113.863917]  asm_common_interrupt+0x22/0x40
[  113.863924] RIP: 0010:default_idle+0xb/0x20
[  113.863932] Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d 9d d0 03 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90
[  113.863937] RSP: 0018:ffffffff82803e98 EFLAGS: 00000206
[  113.863943] RAX: 0000000000000000 RBX: ffffffff8280b400 RCX: 00000000ffff49ff
[  113.863947] RDX: 0000000000000000 RSI: ffffffff821f82b0 RDI: 000000000003e4f4
[  113.863951] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
[  113.863955] R10: 000000581b92d59c R11: 0000000000000000 R12: 0000000000000000
[  113.863959] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000013a90
[  113.863966]  default_idle_call+0x3c/0x70
[  113.863973]  do_idle+0xdc/0x200
[  113.863987]  cpu_startup_entry+0x29/0x30
[  113.863995]  rest_init+0xbd/0xc0
[  113.864002]  start_kernel+0x5fd/0x600
[  113.864018]  x86_64_start_reservations+0x20/0x20
[  113.864029]  x86_64_start_kernel+0xc9/0xd0
[  113.864036]  common_startup_64+0x129/0x148
[  113.864048]  </TASK>
[  113.864051] ---[ end trace 0000000000000000 ]---

the above warning repeated several times, 8 in this run, and then hit BUG.

[  146.743192] ------------[ cut here ]------------
[  146.743200] kernel BUG at net/core/skbuff.c:5289!
[  146.745219] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[  146.747359] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W           7.2.0-rc2-00235-gddb06ebf175f-dirty #5 PREEMPT(full)
[  146.752482] Tainted: [W]=WARN
[  146.753718] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  146.757698] RIP: 0010:__skb_to_sgvec+0x226/0x260
[  146.759646] Code: e6 89 4c 24 08 e8 fa fd ff ff 85 c0 78 2e 8b 4c 24 08 41 01 c7 29 cb 74 26 01 cd 4d 8b 6d 00 44 8b 74 24 04 eb 86 85 db 74 15 <0f> 0b 41 bf a6 ff ff ff eb 0b 41 bf 01 00 00 00 eb 03 41 89 c7 48
[  146.767755] RSP: 0018:ffffc90000003c78 EFLAGS: 00010206
[  146.769965] RAX: 0000000000000001 RBX: 0000000000000078 RCX: ffff8881060ebec0
[  146.773018] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffea00041b7200
[  146.775910] RBP: 000000000000006c R08: 0000000000000000 R09: 0000000000000000
[  146.778716] R10: 0000000000000058 R11: 00000000000007e0 R12: ffff888100b25eb0
[  146.781355] R13: 0000000000000000 R14: 000000000000006c R15: 0000000000000002
[  146.783911] FS:  0000000000000000(0000) GS:ffff8881f8a8b000(0000) knlGS:0000000000000000
[  146.786704] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  146.788578] CR2: 00007f9245e088a0 CR3: 0000000106575006 CR4: 0000000000170eb0
[  146.790880] Call Trace:
[  146.791601]  <IRQ>
[  146.792190]  skb_to_sgvec+0x11/0x40
[  146.793267]  esp_output_tail+0x184/0x420
[  146.794450]  esp_output+0x12e/0x160
[  146.795407]  xfrm_output_resume+0xb22/0xe10
[  146.796571]  ? __memcg_slab_free_hook+0x50/0xe0
[  146.797842]  ? iptfs_delay_timer+0x8a3/0x920
[  146.798987]  ? kmem_cache_free+0x210/0x270
[  146.800061]  iptfs_delay_timer+0x5dc/0x920
[  146.801135]  ? net_rx_action+0x1fc/0x230
[  146.802172]  ? rb_erase_linked+0x3b/0x60
[  146.803175]  ? __pfx_iptfs_delay_timer+0x10/0x10
[  146.804346]  __hrtimer_run_queues+0x117/0x1b0
[  146.805452]  hrtimer_run_softirq+0x43/0x90
[  146.806474]  handle_softirqs+0x127/0x260
[  146.807421]  __irq_exit_rcu+0x50/0xf0
[  146.808304]  common_interrupt+0x95/0xc0
[  146.809229]  </IRQ>
[  146.809733]  <TASK>
[  146.810200]  asm_common_interrupt+0x22/0x40
[  146.811176] RIP: 0010:default_idle+0xb/0x20
[  146.812154] Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d 9d d0 03 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90
[  146.816515] RSP: 0018:ffffffff82803e98 EFLAGS: 00000206
[  146.817661] RAX: 0000000000000000 RBX: ffffffff8280b400 RCX: 0000000000000000
[  146.819210] RDX: 0000000000000000 RSI: ffffffff821f82b0 RDI: 0000000000050834
[  146.820733] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
[  146.822261] R10: 0000000000155cc0 R11: 0000000000000000 R12: 0000000000000000
[  146.823751] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000013a90
[  146.825225]  default_idle_call+0x3c/0x70
[  146.826032]  do_idle+0xdc/0x200
[  146.826645]  cpu_startup_entry+0x29/0x30
[  146.827412]  rest_init+0xbd/0xc0
[  146.828039]  start_kernel+0x5fd/0x600
[  146.828755]  x86_64_start_reservations+0x20/0x20
[  146.829677]  x86_64_start_kernel+0xc9/0xd0
[  146.830470]  common_startup_64+0x129/0x148
[  146.831247]  </TASK>
[  146.831661] ---[ end trace 0000000000000000 ]---
[  146.832554] RIP: 0010:__skb_to_sgvec+0x226/0x260
[  146.833442] Code: e6 89 4c 24 08 e8 fa fd ff ff 85 c0 78 2e 8b 4c 24 08 41 01 c7 29 cb 74 26 01 cd 4d 8b 6d 00 44 8b 74 24 04 eb 86 85 db 74 15 <0f> 0b 41 bf a6 ff ff ff eb 0b 41 bf 01 00 00 00 eb 03 41 89 c7 48
[  146.837105] RSP: 0018:ffffc90000003c78 EFLAGS: 00010206
[  146.838095] RAX: 0000000000000001 RBX: 0000000000000078 RCX: ffff8881060ebec0
[  146.839418] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffea00041b7200

Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v1->v2: rebase to latest ipsec

- Link to v1:
https://lore.kernel.org/all/xfrm-iptfs-pp_ref_count-underflow-v1-1-47b319c6d2f6@secunet.com/
---
 net/xfrm/xfrm_iptfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 6920940a35b4..d3bca90e2c38 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -14,6 +14,7 @@
 #include <net/icmp.h>
 #include <net/ip6_route.h>
 #include <net/inet_ecn.h>
+#include <net/page_pool/helpers.h>
 #include <net/xfrm.h>
 
 #include <crypto/aead.h>
@@ -486,7 +487,10 @@ static int iptfs_skb_add_frags(struct sk_buff *skb,
 			tofrag->len -= offset;
 			offset = 0;
 		}
-		__skb_frag_ref(tofrag);
+		if (walk->pp_recycle)
+			page_pool_ref_page(skb_frag_page(tofrag));
+		else
+			__skb_frag_ref(tofrag);
 		shinfo->nr_frags++;
 		shinfo->flags |= SKBFL_SHARED_FRAG;
 
@@ -2171,7 +2175,11 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
 		new_truesize = SKB_TRUESIZE(skb_end_offset(from));
 	} else {
 		iptfs_skb_head_to_frag(from, &toi->frags[toi->nr_frags]);
-		skb_frag_ref(to, toi->nr_frags++);
+		if (from->pp_recycle)
+			page_pool_ref_page(skb_frag_page(&toi->frags[toi->nr_frags]));
+		else
+			skb_frag_ref(to, toi->nr_frags);
+		toi->nr_frags++;
 		new_truesize = SKB_DATA_ALIGN(sizeof(struct sk_buff));
 	}
 

---
base-commit: 868f63c8bfafa9b827168c9126f85264c39c02ec
change-id: xfrm-iptfs-pp_ref_count-underflow-063ee0302600

Best regards,
--  
Antony Antony <antony.antony@secunet.com>

