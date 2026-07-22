Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ADD23ABB9;
	Wed, 22 Jul 2026 02:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784688159; cv=none; b=NWHeJNaR6v4NfGoNIUdGzBx+KsWxzvTsujquvwd4Fqw80EqJHrmnFCpR8ObuutBwFHaoxSKXnlOVn1WyPB+POhNvB3tsg0XH+GH4j7cYYX/V3ykK5pJ4dIql1+LQvqkyobfcACRrglhnnpth/kKicaapOqwMUxm9OyWwBm8rHLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784688159; c=relaxed/simple;
	bh=JTmQWGleZYZi5qu00uUJy/YMAJtCJomOz+ezqkGYVe0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CoBN53dgS/yHSYYWPWDb4ssIboVsxPDMK1GG2uNlZ/K41rcFALiHSVk7RT9zVJCihp1RD8SxSm3ObvgS9olU5oaExmxAfdmpqw4y5NxLbZbtrKD6M+U+zTR426KwONS311ETui2f+bZxR9kYrTyN07KAWn/AzutYTFdM/YN1Cjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uRE3I9s7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uRE3I9s7"
X-UUID: f8585a60857611f18dc8c9802ae25ab1-20260722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UyfeTtjC2ZIxhQHTBzzT24VyhmFbnqE24bjSAL7D0M0=;
	b=uRE3I9s73UtNQnCH1Ggdc+jPjkpYkIOObCZOurF9JQLFsUnwLBO/LFeQcJ/5O7RUW6ig6Cbq3AxjcVLAmk5FsQcfaqFOT6WK4dGuOB1/8YvQV6kH+c9sOVcukNTH8wZMqjA/ZOWw249kU2bnA5aio+a6KuA624e8WgqxorW+dIg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18,REQID:b72a14bd-1ffd-4710-b964-060f5c2a6b15,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:8a735a6,CLOUDID:dc332954-ba59-46c6-b844-86065e9edbd3,B
	ulkID:nil,BulkQuantity:0,SF:102|123|836|865|888|898,TC:-5,Content:0|15|50|
	99|100|101|123,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f8585a60857611f18dc8c9802ae25ab1-20260722
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <zhaoping.shu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1069145966; Wed, 22 Jul 2026 10:42:24 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 22 Jul 2026 10:42:23 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 22 Jul 2026 10:42:21 +0800
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
	<lambert.wang@mediatek.com>, Zhaoping Shu <zhaoping.shu@mediatek.com>
Subject: [PATCH net v1] net: gro: avoid nesting GSO skbs in skb_gro_receive_list()
Date: Wed, 22 Jul 2026 10:42:14 +0800
Message-ID: <20260722024214.24845-1-zhaoping.shu@mediatek.com>
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

On devices that support both NETIF_F_GRO_HW and NETIF_F_GRO_FRAGLIST,
the hardware or driver may deliver packets that have already been
aggregated into a GSO skb, either with frags[] or frag_list. GRO may
then
aggregate the skb again in skb_gro_receive_list().

This can create a nested GSO skb, which is not handled correctly by the
later GSO segmentation paths. When the skb is segmented by
skb_segment_list(), it not be fully restored to the original packets.

If the skb is marked with SKB_GSO_DODGY before segmentation, for example
after a protocol change from IPv6 to IPv4, the nested GSO skb is
segmented
by skb_segment(), which may hit a NULL pointer dereference when the skb
contains a nested frag_list.

Avoid this by setting NAPI_GRO_CB(skb)->flush for GSO skbs before
aggregation and by checking the flush flag in skb_gro_receive_list(),
following the existing logic in skb_gro_receive().

Signed-off-by: HW He <hw.he@mediatek.com>
Signed-off-by: Zhaoping Shu <zhaoping.shu@mediatek.com>
---
 net/core/gro.c         | 2 +-
 net/ipv4/tcp_offload.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 35f2f708f010..27c9813495f3 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -229,7 +229,7 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 
 int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 {
-	if (unlikely(p->len + skb->len >= 65536))
+	if (unlikely(p->len + skb->len >= 65536 || NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
 	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 3b1fdcd3cb29..c363434a5646 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -332,6 +332,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		flush |= skb->ip_summed != p->ip_summed;
 		flush |= skb->csum_level != p->csum_level;
 		flush |= NAPI_GRO_CB(p)->count >= 64;
+		NAPI_GRO_CB(skb)->flush |= skb_is_gso(skb);
 		skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
 
 		if (flush || skb_gro_receive_list(p, skb))
-- 
2.17.0

