Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C80D37F322;
	Wed,  5 Aug 2026 03:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785901567; cv=none; b=bp7jYGG8Y4pwlRLVkmspbZHtuAIA30CF8IIhZLa/fa+XRq+D4x/djfaLazZkgHsH6YhC8WVIpaYszQWxPLuZo9Gkt/VTlDVDD3m9KhKgAdbwiqEQfAFfDVewSheGFuAUgNPM2086aeaqiRihxLZkyY0Cgx3ro1jopHC0Ob2dI9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785901567; c=relaxed/simple;
	bh=UPAjB0BdsiGVSp/QBakciyTb0Cb2PgDPRyhiNB6yjbg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ORP8wt0IUkr/VTOxX/XbkT96UhKmB2ubAjJbOc94lOgZppReHPRkxq8HgAKNgyiic0D7FWqwekgSLw6TWey0TOHHMUf2xZkv8wykdPtSW4qyVsoMuTNDkK2MV/RtwyouilNUR3da7BmcpZ3ieM289XqTiyMMCbi2oBjRIeWYZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Tp0/Var9; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Tp0/Var9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cmpSACpQmSDOvkCsslSgBCvhphPrgzodOLZTrWWOAUY=;
	b=Tp0/Var93VcbMnNN/DXf5t3Qwl9TbSqrL6DVz1Mmr38m/M3Yqmtm11CWu20dFVskW8sl/gzBe
	9mitCO1ZFNe2Leu7zofD3tG05KcR4ruf0j7/cqAgDgoPf5yaXFjztC/lFXGwpvKz8lOufXI/haO
	0kIl9iGHsO61/UVxWGM/i+0=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hFGKq3hP4zmVWY;
	Wed,  5 Aug 2026 11:36:31 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id E01CE40586;
	Wed,  5 Aug 2026 11:46:02 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 5 Aug 2026 11:46:01 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Teng Peisen <tengpeisen@huawei.com>, Wu Di
	<wudi234@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Larysa Zaremba
	<larysa.zaremba@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chen Anwen
	<chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>, Zhang Min
	<zhangmin548@huawei.com>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>
Subject: [PATCH net] hinic3: Fix SKB linearization mismatch and silent TX drops
Date: Wed, 5 Aug 2026 11:45:55 +0800
Message-ID: <ca8f219dd1eac99e41e22477bd0902b92ec7628e.1785899557.git.tengpeisen@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Previously, hinic3_send_one_skb() cached the SKB fragment count before
calling hinic3_tx_offload(). If hinic3_tx_csum() falls back to
skb_checksum_help() for unsupported tunnel packets, the SKB may be
linearized. Continuing to build the TX descriptor with the stale
fragment count leads to a descriptor mismatch, which can trigge
out-of-bounds DMA reads or IOMMU faults.

Furthermore, the old code ignored the return value of skb_checksum_help(),
transmitting corrupted packets with incomplete checksums upon failure. It
also failed to increment drop statistics across various TX error paths,
causing packets to be dropped silently without notifying the user.

Fix this by:
1. Moving the hinic3_tx_offload() call before calculating 'num_sge' to
   ensure the correct fragment count is used if the SKB is linearized.
2. Propagating skb_checksum_help() errors and returning
   HINIC3_TX_OFFLOAD_INVALID to properly drop the skb.
3. Adding missing statistics increments (dropped, map_frag_err,
   unknown_tunnel_pkt, skb_pad_err) across the TX error paths so these
   events are correctly reflected in interface statistics.

Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 31 ++++++++++++++++---
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 9306bf0020ca..45effdddb434 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -97,8 +97,12 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,

 	dma_info[0].dma = dma_map_single(&pdev->dev, skb->data,
 					 skb_headlen(skb), DMA_TO_DEVICE);
-	if (dma_mapping_error(&pdev->dev, dma_info[0].dma))
+	if (dma_mapping_error(&pdev->dev, dma_info[0].dma)) {
+		u64_stats_update_begin(&txq->txq_stats.syncp);
+		txq->txq_stats.map_frag_err++;
+		u64_stats_update_end(&txq->txq_stats.syncp);
 		return -EFAULT;
+	}

 	dma_info[0].len = skb_headlen(skb);

@@ -117,6 +121,9 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
 						     skb_frag_size(frag),
 						     DMA_TO_DEVICE);
 		if (dma_mapping_error(&pdev->dev, dma_info[idx].dma)) {
+			u64_stats_update_begin(&txq->txq_stats.syncp);
+			txq->txq_stats.map_frag_err++;
+			u64_stats_update_end(&txq->txq_stats.syncp);
 			err = -EFAULT;
 			goto err_unmap_page;
 		}
@@ -260,9 +267,11 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
 		if (l4_proto != IPPROTO_UDP ||
 		    ((struct udphdr *)skb_transport_header(skb))->dest !=
 		    VXLAN_OFFLOAD_PORT_LE) {
+			u64_stats_update_begin(&txq->txq_stats.syncp);
+			txq->txq_stats.unknown_tunnel_pkt++;
+			u64_stats_update_end(&txq->txq_stats.syncp);
 			/* Unsupported tunnel packet, disable csum offload */
-			skb_checksum_help(skb);
-			return 0;
+			return skb_checksum_help(skb);
 		}
 	}

@@ -412,6 +421,10 @@ static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
 		offload |= HINIC3_TX_OFFLOAD_TSO;
 	} else {
 		tso_cs_en = hinic3_tx_csum(txq, task, skb);
+		if (tso_cs_en < 0) {
+			offload = HINIC3_TX_OFFLOAD_INVALID;
+			return offload;
+		}
 		if (tso_cs_en)
 			offload |= HINIC3_TX_OFFLOAD_CSUM;
 	}
@@ -539,12 +552,17 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 	int err;

 	if (unlikely(skb->len < MIN_SKB_LEN)) {
-		if (skb_pad(skb, MIN_SKB_LEN - skb->len))
+		if (skb_pad(skb, MIN_SKB_LEN - skb->len)) {
+			u64_stats_update_begin(&txq->txq_stats.syncp);
+			txq->txq_stats.skb_pad_err++;
+			u64_stats_update_end(&txq->txq_stats.syncp);
 			goto err_out;
+		}

 		skb->len = MIN_SKB_LEN;
 	}

+	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);
 	num_sge = skb_shinfo(skb)->nr_frags + 1;
 	/* assume normal wqe format + 1 wqebb for task info */
 	wqebb_cnt = num_sge + 1;
@@ -560,7 +578,6 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}

-	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);
 	if (unlikely(offload == HINIC3_TX_OFFLOAD_INVALID)) {
 		goto err_drop_pkt;
 	} else if (!offload) {
@@ -604,6 +621,10 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 err_drop_pkt:
 	dev_kfree_skb_any(skb);
 err_out:
+	u64_stats_update_begin(&txq->txq_stats.syncp);
+	txq->txq_stats.dropped++;
+	u64_stats_update_end(&txq->txq_stats.syncp);
+
 	return NETDEV_TX_OK;
 }


base-commit: 2195424c3da2ef1829a63b807e3a900a90e57d85
--
2.54.0

