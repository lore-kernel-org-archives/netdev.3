Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B32D7386;
	Thu, 23 Jul 2026 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798177; cv=none; b=nyAoxnMuTcIMRwJVwnrpeHJFTKgJYzv151gr2SQ2otnuTX/jUXGKx8w7lH1JketGeHA/7yQo69ZsDkpJMXNDWql/YUhhDq129MPmB02dkfvvr4x0wFye40kXnM0P3AbxU+VzDy5mz1zjk5/f9KO+K/1+pQGIo6uCz3HB8KAMO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798177; c=relaxed/simple;
	bh=ZNZca9q7oIuQIk0TjnWuv+7+cXeSoMqf9t4GrDwoDI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RUywFz34RisTUIFBaHPoRUpGz/YZw/EQHjTnbMHwuDHX1c2DTudsu2Cu0BT1bhXmcKH4NjCwLJ5yMIIjSUp6/F5ZXStfPIIfDXZEtwp+rMTMCHV+QFAvm+ZVCQqZcImm0WsK29KjA9/UvtejlsbuTtulp4G5iV1xuF1zSkCn7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rJRf+0q3; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rJRf+0q3"
X-UUID: 22e9cae2867711f1b1788b6acf885367-20260723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FF3CQzDN2xFla8uEGiPnMoAn7bZknuWf8Lkei7xVdww=;
	b=rJRf+0q3Wg7NVFVGhL5r+U2UFGGdy4CAWJKBVXNU+COj2vLdPvVruSoJ1mRsUm6z8xYIKkPaZAfCIPAt47STz4TDovz5GRp2LPJ1LTrCRg+IoBT9Pfi4y3lSvScpl3OHTaESPKX30lHuTKqW4u6Zb2lSCIcqwQ8Ls7RmEaFiDck=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18,REQID:61b2da62-6deb-4969-b767-57d630263602,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:8a735a6,CLOUDID:9b457719-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,SF:102|123|836|865|888|898,TC:-5,Content:0|15|50|
	99|100|101|123,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 22e9cae2867711f1b1788b6acf885367-20260723
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <zhaoping.shu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1497837608; Thu, 23 Jul 2026 17:16:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 23 Jul 2026 17:16:06 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 23 Jul 2026 17:16:04 +0800
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
Subject: [PATCH net v2] net: gro: avoid nesting TCP GSO skbs in skb_gro_receive_list()
Date: Thu, 23 Jul 2026 17:16:01 +0800
Message-ID: <20260723091601.72103-1-zhaoping.shu@mediatek.com>
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
aggregated into a TCP GSO skb with frags[]. GRO may then
aggregate the skb again in skb_gro_receive_list().

This can create a nested GSO skb, which is not handled correctly by the
later GSO segmentation paths. When the skb is segmented by
skb_segment_list(), it not be fully restored to the original packets.

Avoid this by setting NAPI_GRO_CB(skb)->flush for GSO skbs before
aggregation.

Signed-off-by: HW He <hw.he@mediatek.com>
Signed-off-by: Zhaoping Shu <zhaoping.shu@mediatek.com>
---
v2: Take Antoine Tenart's suggestion
v1: https://lore.kernel.org/netdev/amB7wb1A2Oo2dv5d@kwain/
---
 net/ipv4/tcp_offload.c | 1 +
 1 file changed, 1 insertion(+)

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

