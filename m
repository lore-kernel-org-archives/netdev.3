Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370598;
	b=Lrhjot126g+C2qsAvSRsvcu4ZB6mwSMwWeCbf1MMvyYNstC9y7oZusxyJQZ+BvpHQJZ2
	 IUn9QMS+utoR4HuvVi+8sfbZhi3bsJA2TAXrL5jDvjIipVd1mLaYj4zYpSAOrQpeq6I7o
	 aEO4DVK3sSgl/mUuej7DY4BpHAC08VkbhmymZ27lXEc+b/CDiRIdlOU/U3KY8kSzz7oYg
	 kJTLkrQp0Twnoy8V239PU3MvMcCzK7MwNuMstJEP0WVywkHxV3bpbOCTcxj5I24FnzJ8W
	 QgfNrpFmMF6uFdO/MKaLeDYCZhI5DxFNW+ZS1UtDp+kyPZbNSo3zbDULI/OcLOoE+FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370598;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=PH24/CkFIlFDQLRPs9ZYSKVMAHSU2dBRKimO+qBdRYM=;
	b=0G4LgvVwKqCZ8oQoT1MaSoI5NGC4TWCfQ0n174a4R62Q0j6Bqy4Om8K2G1o3o+XwRbRB
	 Vr4fZTepJUjrQecNWHMBSqDy0/AQuCMrogooJdLtdgbRPmXU1UAwCA7VVYZc2A84xO1r/
	 2hMx44/eXLoB248VzZwCqL0juMgt+gK3w1Z9NOU6rB8ZI1lSNAnFV/ARLHO9k1fokLHk8
	 LJJjOuyHmppk1lIKJldf+6Idnqh8xYFXIKRNNwoysaH7rjiWNEeg7i6l8d2zB9uLHr3V1
	 AFp7yMefNnL58I+ZuIwUwVrnWTVEMz1I0spiFPKcK7PaV80KUCEeYa6bqhc+DQsidjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rG7PRtQP;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51041606A331;
	Wed, 11 Nov 2026 04:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51041606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rG7PRtQP
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PH24/CkFIlFDQLRPs9ZYSKVMAHSU2dBRKimO+qBdRYM=;
	b=rG7PRtQP1joLXvZml0b34urbgsc9JZyuYxb4M5sxVTUs7JDkoWYtt+OJaeSF8GxsX2dlJHhF2
	HvchDWDOJIIyTkwXtZU6napEKpcRkvj9lOFaZX3PfTf3qsidnyO8O2Lo6rJs/gSNSi1S+iEUBXc
	t8nOjKd6mYBn/AteYlHb0RM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jPVZW1l1xz1cySM;
	Wed, 11 Nov 2026 12:16:19 +0800 (CST)
Received: from dggpemr500009.china.huawei.com (unknown [7.185.36.55])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B4864055B;
	Wed, 11 Nov 2026 12:16:34 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr500009.china.huawei.com (7.185.36.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 11 Nov 2026 12:16:34 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.220.94) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 11 Nov 2026 12:16:32 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri Daskalakis
	<dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>
Subject: [PATCH net-next v02 1/5] hinic3: Solve an stall issue in hinic3_rx_poll()
Date: Wed, 11 Nov 2026 12:15:43 +0800
Message-ID: <7b1857bfd040c90baa1777c4c18be56551c4c1b0.1794371175.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1794371175.git.gongfan1@huawei.com>
References: <cover.1794371175.git.gongfan1@huawei.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemq100015.china.huawei.com (7.152.185.230)

When Large Receive Offload (LRO) packets are large, such as 32KB, each
packet consumes 16 Work Queue Elements (WQEs). If multiple large LRO
packets occur at this time, it will cause rapid consumption of WQEs in
the RQ and WQEs cannot be replenished in time. The chip will drop
packets due to lack of WQEs, causing the RQ to be unable to receive
packets. Furthermore, the NAPI instance will not be polled again,
resulting in residual packets in the RQ.

When napi_alloc_skb() fails inside recv_one_pkt(), hinic3_rx_poll()
breaks out of the loop without advancing rxq->cons_idx or clearing
rx_cqe->status, and returns nr_pkts (< budget).  hinic3_poll() then
calls napi_complete_done() and re-enables the edge-triggered MSI-X
interrupt while the unprocessed CQE remains at the head of the ring,
stalling the receive queue until a new packet arrives to trigger
another interrupt.

Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 309ab5901379..f2262cdd6628 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -555,6 +555,7 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(rxq->netdev);
 	u32 sw_ci, status, pkt_len, vlan_len;
 	struct hinic3_rq_cqe *rx_cqe;
+	bool poll_again = false;
 	u32 num_wqe = 0;
 	int nr_pkts = 0;
 	u16 num_lro;
@@ -571,8 +572,10 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 
 		vlan_len = le32_to_cpu(rx_cqe->vlan_len);
 		pkt_len = RQ_CQE_SGE_GET(vlan_len, LEN);
-		if (recv_one_pkt(rxq, rx_cqe, pkt_len, vlan_len, status))
+		if (recv_one_pkt(rxq, rx_cqe, pkt_len, vlan_len, status)) {
+			poll_again = true;
 			break;
+		}
 
 		nr_pkts++;
 		num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
@@ -581,12 +584,14 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 
 		rx_cqe->status = 0;
 
-		if (num_wqe >= nic_dev->lro_replenish_thld)
+		if (num_wqe >= nic_dev->lro_replenish_thld) {
+			poll_again = true;
 			break;
+		}
 	}
 
 	if (rxq->delta >= HINIC3_RX_BUFFER_WRITE)
 		hinic3_rx_fill_buffers(rxq);
 
-	return nr_pkts;
+	return poll_again ? budget : nr_pkts;
 }
-- 
2.43.0

