Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD3A4C6515
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279968; cv=none; b=S+RWudTSh+zVV4hFipysqhSMuqstZ48jaTE7gSNFpaX8UntSMHajb6mB9KTkJZej2qMaS7cDHR9z4FPoWCgzTsq4aPGOkk9NTGBCP95lX6tROZhU9gAb53g5PgqXXvDJXtfY8+c64yij1HxYA46Oyq9/QlKMEYzoqrOUNr79gJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279968; c=relaxed/simple;
	bh=Om8QVDq28H9G3gWnEUo3TvC9RgqqsvTtpFUYujbaF7o=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pmjIRtDVRINSmIBh5uDwcUIIpdfP+wD/laJbE0t2dYprmNy3L3bnFarsIa+hiC/bT3WRFtm/dlwuo4Y3kMHZg42UvGmNmPnJEwPgzi+zDKVd+rybg4M0OomR6KStsAoRxsck2Dqy+s1Y3zfPKJh9o/D3jKey4VuJ1Et7r3XfuK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Vm8Zly1V; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Vm8Zly1V"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5C9F3208A6;
	Thu, 24 Sep 2026 21:59:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qZS8vX-CSxBX; Thu, 24 Sep 2026 21:59:12 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4CE9D2088F;
	Thu, 24 Sep 2026 21:59:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4CE9D2088F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1790279952;
	bh=DvL99SpEFE7lpAy/nOHOYbKllKVhgraC3p6BptSDa74=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=Vm8Zly1Vme0ENPRMg+Ek0Dmzd7NFYm5V4k3Catnf0yM+wh71k2AVrK80jV2zWXb/l
	 /6tSg1rEFwrkXJOgdVMogVuMuohmHXTmHJfr0u7GYcewqLONW2yGPLG0WobZ7FHJTS
	 ErelMjotRyHmqum71MU6KB3SrK9amTu4Njz8eMz7ksKMTk+QF7/iYDeiH802LPPzZl
	 DyvflgvLSUP6VbyI6Dp4zX8OguZcnNjg0Uw9g2cjn3Iks4kvzgHXLsYNURHRKspEr4
	 unA2hDLXYKGmVNWy8oKiMj7D/QBWiReOix83YxbdQpgRdWW6OjOywr6vdU/1NdYjSn
	 dBpCiv1dBOF2w==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 24 Sep
 2026 21:59:11 +0200
Date: Thu, 24 Sep 2026 21:59:03 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Christian Hopps <chopps@labn.net>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, Antony Antony <antony.antony@secunet.com>
Subject: [PATCH ipsec v3] xfrm: iptfs: fix pp_ref_count underflow when
 sharing page_pool frags
Message-ID: <xfrm-iptfs-pp_ref_count-underflow-v3-1-9266ddaf3129@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-B4-Tracking: v=1; b=H4sIAPl7tWoC/62PzU7DMBCEX6XyGSP/tMbpifdAqLI3u8QSsS3bC
 UVV3h03IK5cOM6s5tuZG6tYAlZ2PtxYwTXUkGIX+uHAYHLxDXkYu2ZXKjMPuVHlOV8K0gXSEht
 f4oiF3tMHF0YjCi2UEYL1uHcVuS8uwnQHhFwRfn1I8xza3bfGktFgPTlyg7fqSRoLg1SG7EmZI
 +gBhPqO5v43XPe2Lz/A125PobZUPvcNq9yPf9ddJZf8RF4bbbUej/K545aI7bF327Gr+h/Utm1
 fJzTJAWcBAAA=
X-Change-ID: xfrm-iptfs-pp_ref_count-underflow-063ee0302600
X-Mailer: b4 0.16-dev
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)

skb frags are either page_pool pages tracked via pp_ref_count
(released by napi_pp_put_page()), or regular pages tracked via
_refcount (released by put_netmem()).
skb->pp_recycle was unbalanced and caused the underflow that
hit BUG().

Fix by taking the page_pool reference only when the destination has
pp_recycle set and the fragment's page is actually page_pool owned,
matching skb_pp_frag_ref(); fall back to a plain reference otherwise.

See the kernel splat, before. Observed under normal traffic when a page_pool
frag is shared into two extra skbs

[   52.644633] ------------[ cut here ]------------
[   52.644649] WARNING: ./include/net/page_pool/helpers.h:297 at page_pool_put_netmem.constprop.0+0x1f/0x40, CPU#0: swapper/0/0
[   52.644665] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.3.0-rc2-00485-gcda8dccdef8d #19 PREEMPT(full)
[   52.644669] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   52.644672] RIP: 0010:page_pool_put_netmem.constprop.0+0x1f/0x40
[   52.644676] Code: 90 90 90 90 90 90 90 90 90 90 90 48 89 f0 48 83 e0 fe 48 8b 48 28 48 ff c9 74 20 48 83 c9 ff f0 48 0f c1 48 28 48 ff c9 79 07 <0f> 0b c3 cc cc cc cc 75 13 48 c7 40 28 01 00 00 00 0f b6 ca 83 ca
[   52.644679] RSP: 0018:ffffc90000003c98 EFLAGS: 00010296
[   52.644683] RAX: ffffea00041cc200 RBX: ffff888105335100 RCX: ffffffffffffffff
[   52.644686] RDX: 0000000000000001 RSI: ffffea00041cc200 RDI: ffff8881013fa000
[   52.644688] RBP: 000000000000000c R08: 000000000000005e R09: 0000000000000a00
[   52.644690] R10: ffff888106834fc0 R11: 0000000000000020 R12: 0000000000000000
[   52.644692] R13: ffff8881013fb000 R14: ffffea00041cc200 R15: ffff88810097d9c0
[   52.644698] FS:  0000000000000000(0000) GS:ffff8881f887c000(0000) knlGS:0000000000000000
[   52.644701] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   52.644703] CR2: 00007fd8753ec180 CR3: 0000000106f2e004 CR4: 0000000000170eb0
[   52.644706] Call Trace:
[   52.644710]  <IRQ>
[   52.644712]  page_to_skb+0x1f3/0x210
[   52.644719]  receive_buf+0x712/0xca0
[   52.644724]  ? detach_buf_split_in_order+0x5d/0x110
[   52.644730]  virtnet_poll+0x1da/0x460
[   52.644736]  __napi_poll.constprop.0+0x2a/0x120
[   52.644745]  net_rx_action+0x11a/0x230
[   52.644748]  ? raise_softirq_irqoff+0x5/0x20
[   52.644754]  ? __napi_schedule+0x31/0x50
[   52.644759]  ? vring_interrupt+0x77/0x90
[   52.644765]  handle_softirqs+0x11e/0x270
[   52.644769]  __irq_exit_rcu+0x53/0xf0
[   52.644773]  common_interrupt+0x95/0xc0
[   52.644782]  </IRQ>
[   52.644784]  <TASK>
[   52.644786]  asm_common_interrupt+0x22/0x40
[   52.644790] RIP: 0010:default_idle+0xb/0x20
[   52.644794] Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d 1d c6 01 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90
[   52.644797] RSP: 0018:ffffffff82a03e08 EFLAGS: 00000212
[   52.644800] RAX: 0000000000000000 RBX: ffffffff82a0b480 RCX: 00000000ffff0e38
[   52.644802] RDX: 0000000000000000 RSI: ffffffff82211089 RDI: 00000000000ec84c
[   52.644804] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
[   52.644806] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   52.644808] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000013ab0
[   52.644814]  default_idle_call+0x3c/0x70
[   52.644818]  do_idle+0xdc/0x200
[   52.644823]  cpu_startup_entry+0x29/0x30
[   52.644828]  rest_init+0xe8/0xf0
[   52.644833]  ? __pfx_kernel_init+0x10/0x10
[   52.644836]  start_kernel+0x5fd/0x600
[   52.644846]  x86_64_start_reservations+0x20/0x20
[   52.644850]  x86_64_start_kernel+0xc9/0xd0
[   52.644854]  common_startup_64+0x129/0x148
[   52.644860]  </TASK>
[   52.644862] ---[ end trace 0000000000000000 ]---

Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v2->v3: check page is pp before pp_ref_count bump. create helper func

- Link to v2: https://patchwork.kernel.org/project/netdevbpf/patch/xfrm-iptfs-pp_ref_count-underflow-v1-1-5fb363833d41@secunet.com/
v1->v2: rebase to latest ipsec

- Link to v1: https://lore.kernel.org/all/xfrm-iptfs-pp_ref_count-underflow-v1-1-47b319c6d2f6@secunet.com/
---
 net/xfrm/xfrm_iptfs.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 6920940a35b4..229f84ac6a31 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -14,6 +14,7 @@
 #include <net/icmp.h>
 #include <net/ip6_route.h>
 #include <net/inet_ecn.h>
+#include <net/page_pool/helpers.h>
 #include <net/xfrm.h>
 
 #include <crypto/aead.h>
@@ -449,6 +450,20 @@ static bool iptfs_skb_can_add_frags(const struct sk_buff *skb,
 	return true;
 }
 
+static void iptfs_frag_ref(skb_frag_t *frag, bool recycle)
+{
+	struct page *head;
+
+	if (recycle && !skb_frag_is_net_iov(frag)) {
+		head = compound_head(skb_frag_page(frag));
+		if (page_pool_page_is_pp(head)) {
+			page_pool_ref_page(head);
+			return;
+		}
+	}
+	__skb_frag_ref(frag);
+}
+
 /**
  * iptfs_skb_add_frags() - add a range of fragment references into an skb
  * @skb: skb to add references into
@@ -486,7 +501,7 @@ static int iptfs_skb_add_frags(struct sk_buff *skb,
 			tofrag->len -= offset;
 			offset = 0;
 		}
-		__skb_frag_ref(tofrag);
+		iptfs_frag_ref(tofrag, skb->pp_recycle);
 		shinfo->nr_frags++;
 		shinfo->flags |= SKBFL_SHARED_FRAG;
 
@@ -2171,7 +2186,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
 		new_truesize = SKB_TRUESIZE(skb_end_offset(from));
 	} else {
 		iptfs_skb_head_to_frag(from, &toi->frags[toi->nr_frags]);
-		skb_frag_ref(to, toi->nr_frags++);
+		iptfs_frag_ref(&toi->frags[toi->nr_frags], to->pp_recycle);
+		toi->nr_frags++;
 		new_truesize = SKB_DATA_ALIGN(sizeof(struct sk_buff));
 	}
 

---
base-commit: 868f63c8bfafa9b827168c9126f85264c39c02ec
change-id: xfrm-iptfs-pp_ref_count-underflow-063ee0302600

Best regards,
--  
Antony Antony <antony.antony@secunet.com>

