Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77735442398
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131968; cv=none; b=lU/B0bK0f0Cg46FC/TC18N4jNYy5DkSsKLaUbybuYmHp3c9BJCNrDVaPjWACoO3K/s+q1SZxPbwRD33laUBgggCjvr/TChCN4+qWj+anrAXNo1NS8Th6Q2yRvWzUlAGPeQgMZg/n0ff5wHTp2s3+kVD0oA/uHR34+gGQa+T5+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131968; c=relaxed/simple;
	bh=yS+RoPcbDxbTqFTWB3m9YlGpBMWAC3BYOILoVN6VhUU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CnSdMXVnRZJ+r2zYGjJvlbMlNn/Alr7qAo7WhLiKXPiGuE/ybp0G53PKdBaGC2jvIY5x8ctOa+KVyhBcBP7tzNK786lw9zIO7KeSVe6zyq0+HKYy7FXvZg7ZZ1tt/NLxLXuxfIlpwNXmlDu3dn9jJCIqLG+UPyxfPh6dcOPR9NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bQOSuvGA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bQOSuvGA"
X-UUID: eabe021a9bb011f1b1788b6acf885367-20260819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7Qk/nPnOw6aepbRPixLa0uauS/wumrW6H2o503UEaho=;
	b=bQOSuvGAAfNhxXtyCzrXX2ftp0Kn4jtrpGrWIPWZ3eXgCZv12Dj8YUZ/pEGS/EDNSWMope/jhmLIpY29qZ78SzYeTheI7s7q5sG9E51lCWzZ3p+bMTfyFYoDkF7Rs7mVMo3DElZpPgIhOsiIMbdlqx8Yo7yWX2Kxtw8wmXYH7/I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c9d4a66c-a140-488f-804b-4dc1053dd43b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:49ff07f2-0685-46a3-9cac-19d8f3a05ae7,B
	ulkID:nil,BulkQuantity:0,SF:102|123|836|865|888|898,TC:-5,Content:0|15|50|
	99,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: eabe021a9bb011f1b1788b6acf885367-20260819
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <zhaoping.shu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 758250979; Wed, 19 Aug 2026 17:32:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 19 Aug 2026 17:32:36 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 19 Aug 2026 17:32:35 +0800
From: <zhaoping.shu@mediatek.com>
To: <edumazet@google.com>, <ncardwell@google.com>, <kuniyu@google.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <dsahern@kernel.org>,
	<willemb@google.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: <haijun.liu@mediatek.com>, <xiayu.zhang@mediatek.com>,
	<lambert.wang@mediatek.com>, <Iven.Yang@mediatek.com>, HW He
	<hw.he@mediatek.com>, Zhaoping Shu <zhaoping.shu@mediatek.com>
Subject: [PATCH net v4] net: gro: Fix nesting of TCP GSO SKBs in skb_gro_receive_list()
Date: Wed, 19 Aug 2026 17:32:26 +0800
Message-ID: <20260819093226.193385-1-zhaoping.shu@mediatek.com>
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

Check skb_is_gso(skb) and current GRO method, make sure fraglist GRO
applies to consecutive non-GSO skb, others adopt regular GRO path.

Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")
Signed-off-by: Zhaoping Shu <zhaoping.shu@mediatek.com>
Signed-off-by: HW He <hw.he@mediatek.com>

---
[3]: https://patchwork.kernel.org/patch/14747095
[2]: https://patchwork.kernel.org/patch/14706032
[1]: https://patchwork.kernel.org/patch/14702209
---
 net/ipv4/tcp_offload.c   | 22 ++++++++++++++++------
 net/ipv6/tcpv6_offload.c | 15 +++++++++++++--
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 3b1fdcd3cb29..e74d99ca9fac 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -332,6 +332,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		flush |= skb->ip_summed != p->ip_summed;
 		flush |= skb->csum_level != p->csum_level;
 		flush |= NAPI_GRO_CB(p)->count >= 64;
+		flush |= NAPI_GRO_CB(p)->is_flist != NAPI_GRO_CB(skb)->is_flist;
 		skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
 
 		if (flush || skb_gro_receive_list(p, skb))
@@ -395,12 +396,20 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 	struct net *net;
 	int iif, sdif;
 
-	if (likely(!(skb->dev->features & NETIF_F_GRO_FRAGLIST)))
-		return;
-
 	p = tcp_gro_lookup(head, th);
 	if (p) {
-		NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
+		/* flist GRO applies to consecutive non-GSO skbs */
+		if (!skb_is_gso(skb) || !NAPI_GRO_CB(p)->is_flist) {
+			NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
+			return;
+		}
+
+		/* Fall back to the regular GRO path */
+		if (NAPI_GRO_CB(p)->count == 1)
+			NAPI_GRO_CB(p)->is_flist = 0;
+
+		NAPI_GRO_CB(skb)->is_flist = 0;
+
 		return;
 	}
 
@@ -410,7 +419,7 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 	sk = __inet_lookup_established(net, iph->saddr, th->source,
 				       iph->daddr, ntohs(th->dest),
 				       iif, sdif);
-	NAPI_GRO_CB(skb)->is_flist = !sk;
+	NAPI_GRO_CB(skb)->is_flist = !sk && !skb_is_gso(skb);
 	if (sk)
 		sock_gen_put(sk);
 }
@@ -430,7 +439,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 	if (!th)
 		goto flush;
 
-	tcp4_check_fraglist_gro(head, skb, th);
+	if (unlikely(skb->dev->features & NETIF_F_GRO_FRAGLIST))
+		tcp4_check_fraglist_gro(head, skb, th);
 
 	return tcp_gro_receive(head, skb, th);
 
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index f2a659cd6183..eec3778855eb 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -26,7 +26,18 @@ static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 
 	p = tcp_gro_lookup(head, th);
 	if (p) {
-		NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
+		/* flist GRO applies to consecutive non-GSO skbs */
+		if (!skb_is_gso(skb) || !NAPI_GRO_CB(p)->is_flist) {
+			NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
+			return;
+		}
+
+		/* Fall back to the regular GRO path */
+		if (NAPI_GRO_CB(p)->count == 1)
+			NAPI_GRO_CB(p)->is_flist = 0;
+
+		NAPI_GRO_CB(skb)->is_flist = 0;
+
 		return;
 	}
 
@@ -36,7 +47,7 @@ static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 	sk = __inet6_lookup_established(net, &hdr->saddr, th->source,
 					&hdr->daddr, ntohs(th->dest),
 					iif, sdif);
-	NAPI_GRO_CB(skb)->is_flist = !sk;
+	NAPI_GRO_CB(skb)->is_flist = !sk && !skb_is_gso(skb);
 	if (sk)
 		sock_gen_put(sk);
 #endif /* IS_ENABLED(CONFIG_IPV6) */
-- 
2.17.0

