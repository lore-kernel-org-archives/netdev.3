Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16654652;
	Mon, 10 Aug 2026 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786323462; cv=none; b=WCbgycPAeDi/OTIeflP4Xa67LJmS2p4Wly+vXl4EiHkZ6txFMFMp/2WsdyOCXnFuf6eQE0nhfmm8iZ24YqIEMuxg6k+Xtzjzqyrh/DhWOWw2lDYwSkkDAcil9B963CyxrQqsAXRsitRdFH+K5DPXymiq3wmt9UUrZL7SqsyGjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786323462; c=relaxed/simple;
	bh=GfgY8O0J2ffAHdu5F2U5peqoLzRw+JRWfU3Fix4dAuA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aCBdC3oEpj+LClw7iOMe37IgmDfUXV+cIQUIyoPZiyf3+JLPaFKNUZO4iRADXTigRNNGBmADt+HgSJPpBX4NI/7JyIH2kAS+wF6iZE5iCZtyE/Rn2wpiOijK2+i3BrdCyvktXzANSA1GEGDqcr23wA9/SvZHzo5zafb3ztZRFXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=G3DT65bV; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="G3DT65bV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7RLgHnk2O+mardnN2/VLpLm/wznio/mdtwTSJero/ro=;
	b=G3DT65bVjLEgWtZ7JxUs9YwE3FLNfZpxZS+oaCmCV0jxYk307F83oLIU/kYx+BmDRHyBJLqZf
	bbibRSrz9D6nvJ4aAd5vOGnk+z6v6jUYlbdZg3319Ax4VBZ7GTYNJMFuOInVhrDGwlcfmDSzTew
	dgtwRymy8bzUIV0B3vIA9JI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hJGKx5rF3z1cyTD;
	Mon, 10 Aug 2026 08:47:01 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 92FDF4055B;
	Mon, 10 Aug 2026 08:57:36 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 10 Aug 2026 08:57:35 +0800
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
Date: Mon, 10 Aug 2026 08:57:32 +0800
Message-ID: <f742377e33f33541420c0ba741925180517b3a9f.1786091276.git.tengpeisen@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 9306bf0020ca..cc541e7a2318 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -261,8 +261,7 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
 		    ((struct udphdr *)skb_transport_header(skb))->dest !=
 		    VXLAN_OFFLOAD_PORT_LE) {
 			/* Unsupported tunnel packet, disable csum offload */
-			skb_checksum_help(skb);
-			return 0;
+			return skb_checksum_help(skb);
 		}
 	}

@@ -412,6 +411,10 @@ static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
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
@@ -545,6 +548,7 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 		skb->len = MIN_SKB_LEN;
 	}

+	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);
 	num_sge = skb_shinfo(skb)->nr_frags + 1;
 	/* assume normal wqe format + 1 wqebb for task info */
 	wqebb_cnt = num_sge + 1;
@@ -560,7 +564,6 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}

-	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);
 	if (unlikely(offload == HINIC3_TX_OFFLOAD_INVALID)) {
 		goto err_drop_pkt;
 	} else if (!offload) {

base-commit: 2195424c3da2ef1829a63b807e3a900a90e57d85
--
2.54.0

