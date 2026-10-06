Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBB22425B;
	Tue,  6 Oct 2026 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791265880; cv=none; b=MUJr+BgdZDmBT3c4OPR0p7tW+pFqfRWAgHBOCgMn0sifmo5z81LF7CS4NbgcN0WFp0HsfF8Afwm2DMFiGcIK14RxLJ5E5VqXvDLdOKU9lrllOacHCc/SGPch5Mbwj7GBdAuIdYnKZ6+MePiPKrSxRsZ0aULi0TKmY2+dcMq63IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791265880; c=relaxed/simple;
	bh=Flej/Si3BF/Hnwj8YpLiKzBQAkqNLWnVyvQRCaOUqo8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JSvdvcDxOm6NduuEv/j3fS4NtwXrwdGB/gmEsHsKyBYdSvTtzZoIL6IZ/puNUAVYRsqDXBigvsivt2PhcUfPVUos6VKi0VXzkMXDLVikDMxShGydsZ/qj4u0IdGz3FrdGKMeHfPfO8IjUwZTq+LUohcNr6qLG8p7lpVbJvqjKdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Nm/JgnIs; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Nm/JgnIs"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E87B32083F;
	Tue,  6 Oct 2026 07:51:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qcXiOz0_STL0; Tue,  6 Oct 2026 07:51:06 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C9F2020704;
	Tue,  6 Oct 2026 07:51:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C9F2020704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791265866;
	bh=irMkt/RSxTLW+VpGUXoL/rJZxhAVO+9eBQsWI6pm0W4=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=Nm/JgnIsjB9oAOyKvQ+sXs6hNGbSpnKJ37AC3TepXzwbJPsa4ZsQXWxyDlNQubeiO
	 VERiVxLtpUiuKaBWlZTp6kUEFpk3t27ZD99TyzssGierPsXI73spKc70kUnjKF17dl
	 gP8pt1N1Lwf64jrbfxW5s05KtY3KdKgO4Tsbnv/m7tlOqRA/a7gPQd5nW5z7CeCkqB
	 9OP4W4yxqQNdIq4NLaEmvJ9bAiYeOw/cDBmKen1vjjmqR43BP9RIcd6rETog7wWTR3
	 8k8fguGkPzrFXsxDzJRtg9DhWFkDBztmYRH5IOdriu4mR71DmSuuS5TeHjsMyDitTK
	 TaiE5poyDxGdA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 07:51:06 +0200
Date: Tue, 6 Oct 2026 07:47:33 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Christian Hopps <chopps@labn.net>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Antony Antony
	<antony.antony@secunet.com>
Subject: [PATCH ipsec v4] xfrm: iptfs: fix pp_ref_count underflow when
 sharing page_pool frags
Message-ID: <xfrm-iptfs-pp_ref_count-underflow-v4-1-912fa72106f0@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-B4-Tracking: v=1; b=H4sIAN6HxGoC/63PTW7DIBAF4KtErEsETEztrnqPqor4GWqkGhBgN
 1XkuwdbUaSu2kWX89B8vLmSgtljIS+HK8m4+OJjaMPp6UDMqMIHUm/bTC4uT9Sn6gpN6ZzRnU2
 cQ6VzsJjdZ/yiTAIiAyYkY6Sta1WQ6qyCGTfAp4LmkZs4Tb5ueS8tguKc94pLq7XGzimNg1KCO
 acHMOxZoO221dT+9Ze97dsdfG/x6EuN+Xu/YeH74+91F0457ZwGCT2APfHXxs0B67F129lF/B8
 Ff6WgUYOQ0lrlgIvhJ7Wu6w2mkiY5sgEAAA==
X-Change-ID: xfrm-iptfs-pp_ref_count-underflow-063ee0302600
X-Mailer: b4 0.16-dev
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)

when using iptfs skb frags are either page_pool pages tracked 
via pp_ref_count (released by napi_pp_put_page()), or regular 
pages tracked via _refcount (released by put_netmem()).
skb->pp_recycle was unbalanced in iptfs and caused the underflow
that hit a bug.

Fix by taking the page_pool reference only when the destination has
pp_recycle set and the fragment's page is actually page_pool owned,
matching skb_pp_frag_ref(); fall back to a plain reference otherwise.
Also added fix for netmem/devmem fix.

The fix was tested on virtio NIC. The netmem/devmem fix is untested.

See the kernel splat, before. Observed under normal traffic using virtio
NIC, when a page_pool frag is shared into two extra skbs.

[   96.908140] ------------[ cut here ]------------
[   96.908143] WARNING: ./include/net/page_pool/helpers.h:297 at page_pool_put_netmem.constprop.0+0x1f/0x40, CPU#0: swapper/0/0
[   96.908150] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W           7.3.0-rc2-00486-g49bf62d4ca1d #27 PREEMPT(full)
[   96.908153] Tainted: [W]=WARN
[   96.908155] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   96.908156] RIP: 0010:page_pool_put_netmem.constprop.0+0x1f/0x40
[   96.908159] Code: 90 90 90 90 90 90 90 90 90 90 90 48 89 f0 48 83 e0 fe 48 8b 48 28 48 ff c9 74 20 48 83 c9 ff f0 48 0f c1 48 28 48 ff c9 79 07 <0f> 0b c3 cc cc cc cc 75 13 48 c7 40 28 01 00 00 00 0f b6 ca 83 ca
[   96.908161] RSP: 0018:ffffc90000003c98 EFLAGS: 00010296
[   96.908163] RAX: ffffea00043a92c0 RBX: ffff888104124300 RCX: ffffffffffffffff
[   96.908165] RDX: 0000000000000001 RSI: ffffea00043a92c0 RDI: ffff888101c4b800
[   96.908166] RBP: 000000000000000c R08: 0000000000000042 R09: 0000000000000a00
[   96.908167] R10: 000000000000014f R11: 00000000000007e0 R12: 0000000000000000
[   96.908169] R13: ffff8881009c8800 R14: ffffea00043a92c0 R15: ffff888100b6f9c0
[   96.908172] FS:  0000000000000000(0000) GS:ffff8881f887c000(0000) knlGS:0000000000000000
[   96.908174] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   96.908176] CR2: 000056208ebdbd44 CR3: 00000001109b3001 CR4: 0000000000170eb0
[   96.908177] Call Trace:
[   96.908179]  <IRQ>
[   96.908181]  page_to_skb+0x1f3/0x210
[   96.908184]  receive_buf+0x712/0xca0
[   96.908188]  ? detach_buf_split_in_order+0x5d/0x110
[   96.908191]  virtnet_poll+0x1da/0x460
[   96.908195]  __napi_poll.constprop.0+0x2a/0x120
[   96.908197]  net_rx_action+0x11a/0x230
[   96.908199]  ? raise_softirq_irqoff+0x5/0x20
[   96.908203]  ? __napi_schedule+0x31/0x50
[   96.908206]  ? vring_interrupt+0x77/0x90
[   96.908209]  handle_softirqs+0x11e/0x270
[   96.908212]  __irq_exit_rcu+0x53/0xf0
[   96.908215]  common_interrupt+0x95/0xc0
[   96.908219]  </IRQ>
[   96.908220]  <TASK>
[   96.908221]  asm_common_interrupt+0x22/0x40
[   96.908224] RIP: 0010:default_idle+0xb/0x20
[   96.908226] Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d 1d c5 01 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90
[   96.908228] RSP: 0018:ffffffff82a03e08 EFLAGS: 00000216
[   96.908230] RAX: 0000000000000000 RBX: ffffffff82a0b480 RCX: 00000000ffff3972
[   96.908231] RDX: 0000000000000000 RSI: ffffffff822110bf RDI: 000000000003c07c
[   96.908233] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
[   96.908234] R10: 0000000000155cc0 R11: 0000000000000000 R12: 0000000000000000
[   96.908235] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000013ab0
[   96.908238]  default_idle_call+0x3c/0x70
[   96.908240]  do_idle+0xdc/0x200
[   96.908244]  cpu_startup_entry+0x29/0x30
[   96.908247]  rest_init+0xe8/0xf0
[   96.908250]  ? __pfx_kernel_init+0x10/0x10
[   96.908252]  start_kernel+0x5fd/0x600
[   96.908257]  x86_64_start_reservations+0x20/0x20
[   96.908259]  x86_64_start_kernel+0xc9/0xd0
[   96.908262]  common_startup_64+0x129/0x148
[   96.908265]  </TASK>
[   96.908266] ---[ end trace 0000000000000000 ]---

Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
xfrm: iptfs fix
---
Changes in v4:
- add devmem/netmem ref count also
- EDITME: use bulletpoints and terse descriptions.
- Link to v3: https://patch.msgid.link/xfrm-iptfs-pp_ref_count-underflow-v3-1-9266ddaf3129@secunet.com

Changes in v3:
  check page is pp before pp_ref_count bump. create helper func

- Link to v2: https://patch.msgid.link/xfrm-iptfs-pp_ref_count-underflow-v1-1-5fb363833d41@secunet.com
Changes in v2:
  rebase to latest ipsec

- Link to v1: https://lore.kernel.org/all/xfrm-iptfs-pp_ref_count-underflow-v1-1-47b319c6d2f6@secunet.com/
---
v3->v4: add devmem/netmem ref count also (Steffen)

Link to v3: https://patch.msgid.link/xfrm-iptfs-pp_ref_count-underflow-v3-1-9266ddaf3129@secunet.com
v2->v3: check page is pp before pp_ref_count bump. create helper func

- Link to v2: https://patchwork.kernel.org/project/netdevbpf/patch/xfrm-iptfs-pp_ref_count-underflow-v1-1-5fb363833d41@secunet.com/
v1->v2: rebase to latest ipsec

- Link to v1: https://lore.kernel.org/all/xfrm-iptfs-pp_ref_count-underflow-v1-1-47b319c6d2f6@secunet.com/
---
 net/xfrm/xfrm_iptfs.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 6920940a35b4..1c37bf820249 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -14,6 +14,7 @@
 #include <net/icmp.h>
 #include <net/ip6_route.h>
 #include <net/inet_ecn.h>
+#include <net/page_pool/helpers.h>
 #include <net/xfrm.h>
 
 #include <crypto/aead.h>
@@ -449,6 +450,28 @@ static bool iptfs_skb_can_add_frags(const struct sk_buff *skb,
 	return true;
 }
 
+static void iptfs_frag_ref(skb_frag_t *frag, bool recycle)
+{
+	struct page *head;
+
+	if (recycle) {
+		netmem_ref netmem = skb_frag_netmem(frag);
+
+		/* net_iov frags are always page_pool owned */
+		if (netmem_is_net_iov(netmem)) {
+			page_pool_ref_netmem(netmem);
+			return;
+		}
+
+		head = compound_head(netmem_to_page(netmem));
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
@@ -486,7 +509,7 @@ static int iptfs_skb_add_frags(struct sk_buff *skb,
 			tofrag->len -= offset;
 			offset = 0;
 		}
-		__skb_frag_ref(tofrag);
+		iptfs_frag_ref(tofrag, skb->pp_recycle);
 		shinfo->nr_frags++;
 		shinfo->flags |= SKBFL_SHARED_FRAG;
 
@@ -2171,7 +2194,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
 		new_truesize = SKB_TRUESIZE(skb_end_offset(from));
 	} else {
 		iptfs_skb_head_to_frag(from, &toi->frags[toi->nr_frags]);
-		skb_frag_ref(to, toi->nr_frags++);
+		iptfs_frag_ref(&toi->frags[toi->nr_frags], to->pp_recycle);
+		toi->nr_frags++;
 		new_truesize = SKB_DATA_ALIGN(sizeof(struct sk_buff));
 	}
 

---
base-commit: 86de3a1118a16dbbbe5fabe9aa20ffb93c072ed5
change-id: xfrm-iptfs-pp_ref_count-underflow-063ee0302600

Best regards,
--  
Antony Antony <antony.antony@secunet.com>

