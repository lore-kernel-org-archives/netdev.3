Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22223BCF7;
	Thu, 13 Aug 2026 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786585277; cv=none; b=VLHxtOoHq0JdtFTiNGX48luV0LWnJnKiOy/E6gbWHYLTCFE7Iex3jPSVXziQXPrEcP4u6OkrnNRGDe7GW2kfiJsolYsLV75Uo7X+rX09zy4Ai9AqW5DSn1xTw85wYPk2JEQ4EQpOxbf23iXOHRm7L9SZalI7db3PhN2Zx7Fq4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786585277; c=relaxed/simple;
	bh=bxkLu3fyyraEN5gaXO6GsU9qwQB/hqKxW2kFSvRZlhg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CdYnuDd+CqQMR/LdDW1bmii0Gz7F6XMQ1a6BW85ZPv9u46aKcHkTRVJMRvPJBR3Hu/pBB7q49OmhB4rwXHne1emE3X0mIw0oFwUFbXHS8vcf4y7xDV9N6DhWrZ1u6h6F+UWeYeCsFaXzRw8PtP/EerhFL/mp3XK0Kx5IMmvXWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Mxe22oy1; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Mxe22oy1"
X-UUID: 0b0ac9ac96b811f18dc8c9802ae25ab1-20260813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qGRpOM/KyLSRqGYlhqMn9rv/CZjCp3mr3TzX59jyJJo=;
	b=Mxe22oy1kHFf8edanl6+FWeXFkISXdrF6RysrgaP4MYfxvyh7BWR5/a8dMr+5ANn8kjghAxzoddqhVRUiA9FJg8gXWX6JBNHljopM/Scfw7Og2I1K3lPsf18gNuz7NNVSFvKeBcX/+ZKKAb3/f0cwsdKv1HvNBvpWsgh8zjbnrc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a26be445-13b6-4fbe-94f1-8551c42ba7e2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:9f5b32d7-14c8-4b83-920f-b89c490eb93f,B
	ulkID:nil,BulkQuantity:0,SF:102|123|836|865|888|898,TC:-5,Content:0|15|50|
	99,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0b0ac9ac96b811f18dc8c9802ae25ab1-20260813
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <zhaoping.shu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1465950932; Thu, 13 Aug 2026 09:41:02 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 13 Aug 2026 09:41:01 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 13 Aug 2026 09:40:59 +0800
From: <zhaoping.shu@mediatek.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <ncardwell@google.com>,
	<kuniyu@google.com>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <willemb@google.com>,
	<alice@isovalent.com>, <sd@queasysnail.net>, <eilaimemedsnaimel@gmail.com>,
	<imv4bel@gmail.com>, <hw.he@mediatek.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: <haijun.liu@mediatek.com>, <xiayu.zhang@mediatek.com>,
	<lambert.wang@mediatek.com>, <Iven.Yang@mediatek.com>, Zhaoping Shu
	<zhaoping.shu@mediatek.com>
Subject: [PATCH net v3] net: gro: Fix nesting of TCP GSO SKBs in  skb_gro_receive_list()
Date: Thu, 13 Aug 2026 09:40:56 +0800
Message-ID: <20260813014056.160533-1-zhaoping.shu@mediatek.com>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: HW He <hw.he@mediatek.com>

A device supports GRO_HW, and the device driver enables the
NETIF_F_GRO_FRAGLIST feature. During a tethering test,
skb_gro_receive_list() reaggregates the GSO packet. However,
skb_segment_list() cannot segment this packet back into
the original packets, which leads to IP fragmentation or packet drop.

Scenario (Tethering/Forwarding):
1.Driver submits a single TCP packet, P1. P1 is kept in the
gro_list as the first packet.

2. The driver submits a TCP GSO skb, P2. P2 has already aggregated
multiple TCP packets by HW_GRO, and its non-linear data is stored in
frags[].

3. P1 and P2 match the GRO rules, and since there is no local socket,
they are aggregated by skb_gro_receive_list(). The resulting skb,
P3, has a frag_list entry that still contains frags[]:
P3: [ Linear Data ] -> frag_list -> [ Linear Data ]
                                    [ frag[1] ]
                                    [ frag[2] ]
                                    ...
4. Later, tcp4_gso_segment() or tcp6_gso_segment() calls
skb_segment_list() to segment P3. However, skb_segment_list() only
segments the entries in frag_list. It does not segment the frags[]
inside P2, so P3 is not restored to the original packets, which leads
to IP fragmentation or packet drop in the following path.

When NETIF_F_GRO_HW is enabled, do not set NAPI_GRO_CB(skb)->is_flist.
Fall through to the regular skb_gro_receive() path instead of
skb_gro_receive_list().

Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")
Signed-off-by: HW He <hw.he@mediatek.com>
Signed-off-by: Zhaoping Shu <zhaoping.shu@mediatek.com>
---
[2]: https://patchwork.kernel.org/patch/14706032
[1]: https://patchwork.kernel.org/patch/14702209
---
 net/ipv4/tcp_offload.c   | 7 +++----
 net/ipv6/tcpv6_offload.c | 3 ++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 3b1fdcd3cb29..641c47fb1ea2 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -395,9 +395,6 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 	struct net *net;
 	int iif, sdif;
 
-	if (likely(!(skb->dev->features & NETIF_F_GRO_FRAGLIST)))
-		return;
-
 	p = tcp_gro_lookup(head, th);
 	if (p) {
 		NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
@@ -430,7 +427,9 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 	if (!th)
 		goto flush;
 
-	tcp4_check_fraglist_gro(head, skb, th);
+	if (unlikely((skb->dev->features & NETIF_F_GRO_FRAGLIST) &&
+		     !(skb->dev->features & NETIF_F_GRO_HW)))
+		tcp4_check_fraglist_gro(head, skb, th);
 
 	return tcp_gro_receive(head, skb, th);
 
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index f2a659cd6183..e983f55c4419 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -57,7 +57,8 @@ static __always_inline struct sk_buff *tcp6_gro_receive(struct list_head *head,
 	if (!th)
 		goto flush;
 
-	if (unlikely(skb->dev->features & NETIF_F_GRO_FRAGLIST))
+	if (unlikely((skb->dev->features & NETIF_F_GRO_FRAGLIST) &&
+		     !(skb->dev->features & NETIF_F_GRO_HW)))
 		tcp6_check_fraglist_gro(head, skb, th);
 
 	return tcp_gro_receive(head, skb, th);
-- 
2.17.0

