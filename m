Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D404582C9
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699166; cv=none; b=rcxdHEmbmDSy7pgzNGh8ihfDO5iBpjJTjmbtDDovfVKgu9FbsT/GCgGi5HK52MUqkhCfBek0cq51lZf8GtxKXgIiJtzyCuk3Pmpd0UfKAqXa6g5VjkjxrG25nDkhfd2v3RZHcg7O5bOWTRSBJZXC4ckhaI6NjvZ8T9U2A/p/Sns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699166; c=relaxed/simple;
	bh=JmT62r1LQFUMewiOjNoxJSZLjb5Rke2Ty3fgGYMzUjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZIV8F+9Vkc/9JiSMxoAkl/2NJu+r1mY4AiDGh/vBARzO1YyBdV+1rIL0o4qcUQGYY0oy48QzMogaVGlwnw4q33Wpvb2jdQH+x2tuztt5UvwaVED72lyz7SlIPw0Ajff6xEkKKZp2dbTewinXpmvKwBZ06tunFBTg9kGKfor4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=aFQbwDBU; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="aFQbwDBU"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202608140909112dddadcb2a000207cd
        for <netdev@vger.kernel.org>;
        Fri, 14 Aug 2026 11:09:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=WMBYKt6pXyX/he4h/0lqd2dFpbK1SOcahc23JBZCrXA=;
 b=aFQbwDBUcXsjxrjR8In9gObCKyk903HbObS6ctu+LEEll4GHW3elsYUCydAboMMbBzV7Bu
 mfUOCTgmQcCoiNpLcqqoXbfDV04op8pXs8d2JBgAHBvog7K7t3zzGahO7GvZfXe2tbYkgnUH
 RPlEIqQI9JfWX3Ri6wEtJGvqwZi+6tAEiQrUfqAWF9ikIm4zXRccK09Gq8h9OvUU6BTBT8AF
 VhzdVsX8SNKgMRrsz66YULWck4n1nT7aH/8pfrSq+oX5Eg0fy7c3cbOFSP/aM9iLIQ7K5UP+
 q0hjdJsWV5i6ceaoQry7XxIYENBYFqCx0ZwMb9Y+uQTqEBvndaiNviGg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Linux Team <linux-imx@nxp.com>,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: fec: support receive flushing via fsl,rx-flush-queues
Date: Fri, 14 Aug 2026 11:09:01 +0200
Message-ID: <20260814090906.2225075-3-alexander.sverdlin@siemens.com>
In-Reply-To: <20260814090906.2225075-1-alexander.sverdlin@siemens.com>
References: <20260814090906.2225075-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The FEC/ENET controller can flush frames stuck at the head of the RX FIFO
when their destination ring has no empty buffer descriptor, instead of
letting them block the FIFO. This is controlled per RX queue through the
RX_FLUSHn bits of the QOS Scheme register (FEC_QOS_SCHEME).

Parse the new fsl,rx-flush-queues property, build the RX flush mask and
program it in fec_enet_enable_ring().

Erratum ERR050395 (e.g. i.MX8QXP) can cause an RX path lock-up when
flushing is enabled on more than one queue at a time. Rather than encoding
that limitation in the binding, enforce it in the driver: reject a
configuration that enables flushing on multiple queues unless the
controller advertises FEC_QUIRK_HAS_MULTI_RX_FLUSH, which future parts with
the erratum fixed can set.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/ethernet/freescale/fec.h      | 14 ++++++++++
 drivers/net/ethernet/freescale/fec_main.c | 34 +++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 7176803146f3d..4af3ae286895f 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -186,6 +186,7 @@
 #define FEC_RCMR_2		0xfff
 #define FEC_DMA_CFG_1		0xfff
 #define FEC_DMA_CFG_2		0xfff
+#define FEC_QOS_SCHEME		0xfff
 #define FEC_TXIC0		0xfff
 #define FEC_TXIC1		0xfff
 #define FEC_TXIC2		0xfff
@@ -322,6 +323,10 @@ struct bufdesc_ex {
 #define RCMR_CMP(X)		(((X) == 1) ? RCMR_CMP_1 : RCMR_CMP_2)
 #define FEC_TX_BD_FTYPE(X)	(((X) & 0xf) << 20)
 
+/* FEC_QOS_SCHEME bits */
+#define QOS_RX_FLUSH(X)		(1 << (3 + (X)))	/* RX_FLUSHn, n = 0, 1, 2 */
+#define QOS_RX_FLUSH_MASK	(QOS_RX_FLUSH(0) | QOS_RX_FLUSH(1) | QOS_RX_FLUSH(2))
+
 /* The number of Tx and Rx buffers.  These are allocated from the page
  * pool.  The code may assume these are power of two, so it is best
  * to keep them that size.
@@ -499,6 +504,12 @@ struct bufdesc_ex {
 /* Jumbo Frame support */
 #define FEC_QUIRK_JUMBO_FRAME		BIT(25)
 
+/* Receive flushing (QOS Scheme register RX_FLUSHn) may be enabled on more than
+ * one RX queue at a time. Parts without this quirk are subject to erratum
+ * ERR050395 and must limit RX flushing to a single queue.
+ */
+#define FEC_QUIRK_HAS_MULTI_RX_FLUSH	BIT(24)
+
 struct bufdesc_prop {
 	int qid;
 	/* Address of Rx and Tx buffers */
@@ -604,6 +615,9 @@ struct fec_enet_private {
 	unsigned int num_tx_queues;
 	unsigned int num_rx_queues;
 
+	/* Bitmask of RX queues with receive flushing enabled */
+	u32 rx_flush_mask;
+
 	struct fec_enet_priv_tx_q *tx_queue[FEC_ENET_MAX_TX_QS];
 	struct fec_enet_priv_rx_q *rx_queue[FEC_ENET_MAX_RX_QS];
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index ced4dbf8cd90f..a4fe8423630b5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1090,6 +1090,15 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 			       fep->hwp + FEC_RCMR(i));
 	}
 
+	/* Enable receive flushing for the selected queues */
+	if (fep->rx_flush_mask) {
+		u32 val = readl(fep->hwp + FEC_QOS_SCHEME);
+
+		val &= ~QOS_RX_FLUSH_MASK;
+		val |= fep->rx_flush_mask;
+		writel(val, fep->hwp + FEC_QOS_SCHEME);
+	}
+
 	for (i = 0; i < fep->num_tx_queues; i++) {
 		txq = fep->tx_queue[i];
 		writel(txq->bd.dma, fep->hwp + FEC_X_DES_START(i));
@@ -5239,6 +5248,31 @@ fec_probe(struct platform_device *pdev)
 	fep->num_rx_queues = num_rx_qs;
 	fep->num_tx_queues = num_tx_qs;
 
+	/* Enable receive flushing on the requested queues. Erratum ERR050395
+	 * restricts flushing to a single queue; only accept more than one queue
+	 * on controllers known to have the erratum fixed.
+	 */
+	for (i = 0; i < of_property_count_u32_elems(np, "fsl,rx-flush-queues"); i++) {
+		u32 q;
+
+		if (of_property_read_u32_index(np, "fsl,rx-flush-queues", i, &q))
+			break;
+		if (q >= num_rx_qs) {
+			dev_warn(&pdev->dev,
+				 "fsl,rx-flush-queues: queue %u exceeds num-rx-queues, ignoring\n",
+				 q);
+			continue;
+		}
+		fep->rx_flush_mask |= QOS_RX_FLUSH(q);
+	}
+	if (hweight32(fep->rx_flush_mask) > 1 &&
+	    !(fep->quirks & FEC_QUIRK_HAS_MULTI_RX_FLUSH)) {
+		dev_err(&pdev->dev,
+			"fsl,rx-flush-queues: RX flush on multiple queues not supported\n");
+		ret = -EINVAL;
+		goto failed_ioremap;
+	}
+
 	/* default enable pause frame auto negotiation */
 	if (fep->quirks & FEC_QUIRK_HAS_GBIT)
 		fep->pause_flag |= FEC_PAUSE_FLAG_AUTONEG;
-- 
2.55.0

