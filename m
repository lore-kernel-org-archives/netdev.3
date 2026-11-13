Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591165;
	b=bMyD/FJ0TJkVw6qppwOiIcyQPwSmNzKuALITt0zwrEYV16RF6lCa6OXNjX79uoaxmMT9
	 w2ExecVoDEjJlsbGeTkmrtGd8mSCqsh9mIognfqBlDtfK4RPPGhuc9JmOI+tuJTZRrhEs
	 5SrFtqAy1vVcI8LRXvP5vZPgFwt6AoDuNXK1ZgjSMgNbs4o9KN8Vfxw6lSwZxVlwo/9lw
	 Gfk3DYMqrwOPgG3tlp4p6ZSj0n9SU/s6d86cR9yx/k6O9/ApSYESioB4/Qa7M3oXG8JZV
	 AwFcDSzkMWnRr6pgEMERgGeOUo5QZHRAxaHh9XucJ+hZ67zFSSTc6XkNT7U/DofH9gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591165;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=X4Gk1je5U4hhPB3NCDUJLIMtp9BaK7grFH6EFEKxriA=;
	b=k1QV7Hn5sH8IWoZIodu9Bynuq8HUcsI1LNlk9yfR7o4h/boirzP9NPGeHhITlvdk1vLs
	 XbDk8XMS5scUj9YJC1tH+z2EPFi1Lw8hHPiuw/Fyb8sX6bFDfB6oKAJFE5yy5srqzm2Fq
	 8Nvt4M8zpSQ+nJAQF0YQg94nHUNv3wMqGbE0urHZnTLjBrBiGPcoLHSF5QlFiWeGc0lgV
	 7+fa+kjWN0KqAQFtYoPu9MSKkhslE9IQ2EJJ9K41df/TL5YLtZKseHQRg/L4BCVOVSziZ
	 D4K4DSvF+fj2Mw8kE0MurdbXVI6SOW5xcq7Co9Dx4e/Dt9gPjxK6MU6QPtKV76d5BEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2N47fq6K;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E7606C09A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD1E7606C09A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2N47fq6K
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A75691A1647;
	Fri, 13 Nov 2026 17:32:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7685F60015;
	Fri, 13 Nov 2026 17:32:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CBCD11BC1273;
	Fri, 13 Nov 2026 18:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794591158; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=X4Gk1je5U4hhPB3NCDUJLIMtp9BaK7grFH6EFEKxriA=;
	b=2N47fq6KiueMr/uxC2+77rrDMAOYyqqnUsHhWmxsREblSJaMjtsHx4DtXy06lYsJB/KErm
	OL6uvmbCo7Q10STA+gtmmWbk3xtW/jlM1YAY8QWmgmHRiLZbgPBhgCPuBrIXE0WEPbYvOv
	dB4NqbtE6hMK7SvkqeqrT0ALp+o+uL/8bV+ujNCMGwsTvgA/h9cTAwcmq5CsDKQT8iJyDV
	E85amyDivi/WIB1MJZeS/Mk1p0w/rUznhx/2ub66wSfrELNHaf7Iqi/9wYI1yGi2FVRWG2
	y6pSz6tlJjCNglZdhPU6XhrYxTWfzYJXiDCMAJPMCyjuNxD8s8m/nfR1Vo99RA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 13 Nov 2026 18:32:03 +0100
Subject: [PATCH net-next v6 2/2] net: macb: distribute evenly Tx SRAM
 segments
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-macb-set-channels-v6-2-5de59d9e7f02@bootlin.com>
References: <20261113-macb-set-channels-v6-0-5de59d9e7f02@bootlin.com>
In-Reply-To: <20261113-macb-set-channels-v6-0-5de59d9e7f02@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, Paolo Valerio <pvalerio@redhat.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

GEM has registers to configure the Tx SRAM segments distribution across
queues. The reset value is apprioriate (even spread) but we need to
care if/when number of active queues is modified (or if we inherited
unevenly initialised hardware from bootloader).

To distribute segments, we take as input the number of queues
(ctx->num_queues) and the number of segments (found inside DCFG6).
Its output is a number of segments for each queue, formatted as
powers-of-two (eg 2 for queue 0 means it has 2^2=4 segments).

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      | 14 ++++++
 drivers/net/ethernet/cadence/macb_main.c | 76 +++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 0879fb2b198b..cc57071c869a 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -194,6 +194,10 @@
 /* Screener Type 2 match registers */
 #define GEM_SCRT2		0x540
 
+/* Tx queue segment allocation */
+#define GEM_TXQSEGALLOC_LOWER	0x05A0
+#define GEM_TXQSEGALLOC_UPPER	0x05A4
+
 /* EtherType registers */
 #define GEM_ETHT		0x06E0
 
@@ -545,6 +549,8 @@
 #define GEM_PBUF_CUTTHRU_SIZE			1
 #define GEM_DAW64_OFFSET			23
 #define GEM_DAW64_SIZE				1
+#define GEM_SEGMENTS_BIT_SIZE_OFFSET		16
+#define GEM_SEGMENTS_BIT_SIZE_SIZE		3
 
 /* Bitfields in DCFG8. */
 #define GEM_T1SCR_OFFSET			24
@@ -657,6 +663,13 @@
 #define GEM_CMPCEN_OFFSET			30 /* Compare C Enable */
 #define GEM_CMPCEN_SIZE				1
 
+/* Bitfields in TXQSEGALLOC (Q0 at 2:0, Q1 at 6:4, etc.) */
+#define GEM_TXQSEGALLOC_MASK(q_) \
+	({ \
+		typeof(q_) q__ = (q_); \
+		GENMASK(4 * (q__) + 2, 4 * (q__)); \
+	})
+
 /* Bitfields in ETHT */
 #define GEM_ETHTCMP_OFFSET			0 /* EtherType compare value */
 #define GEM_ETHTCMP_SIZE			16
@@ -785,6 +798,7 @@
 #define MACB_CAPS_USRIO_HAS_MII			BIT(26)
 #define MACB_CAPS_USRIO_HAS_REFCLK_SOURCE	BIT(27)
 #define MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE	BIT(28)
+#define MACB_CAPS_TXQSEGALLOC			BIT(29)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e7325af4b399..dc1624815f71 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3432,6 +3432,63 @@ static void macb_context_swap_end(struct macb *bp,
 	}
 }
 
+/*
+ * Distribute evenly available segments across queues. The computation is
+ * complex because (1) segments are counted in powers of two and (2) a queue
+ * can only use up to 8 segments. There are four types of cases:
+ *  - Sharing all segments equally is doable. Take num_queues=4 and
+ *    num_segments=16. Each queue will get 2^2=4 segments.
+ *  - Sharing all segments is doable. Take num_queues=5 and num_segments=16.
+ *    Three queues will get 2^2=4 segments and two will get 2^1=2 segments.
+ *  - Sharing all segments is not doable because not enough queues are
+ *    available. Take num_queues=1 and num_segments=16; queue 0 can only have 8
+ *    segments.
+ *  - Sharing all segments is not doable because not enough segments are
+ *    available. Take num_queues=4 and num_segments=2.
+ *
+ * We start by computing the power each queue will have. For num_queues=5 and
+ * num_segments=16, each queue will have at least 2^1 segments. That leaves us
+ * with remaining_segments=6. If we increase the power for a queue, we get a
+ * delta of 2 (2^2-2^1). The first three queues will therefore be advantaged
+ * and each have 2^2 segments. The remaining 2 queues will only have 2^1
+ * segments.
+ */
+static u32 gem_sram_distribute_segments(unsigned int num_queues,
+					unsigned int num_segments)
+{
+	unsigned int pow, remaining_segments, i;
+	unsigned int num_advantaged_queues = 0;
+	u32 val = 0;
+
+	/* When growing the max # of queues, make sure to return a u64 here and
+	 * to write into GEM_TXQSEGALLOC_UPPER.
+	 */
+	static_assert(MACB_MAX_QUEUES == 8);
+
+	/* pow=0 for all queues. ilog2(0) is dangerous. */
+	if (num_queues >= num_segments)
+		return 0;
+
+	pow = min_t(unsigned int, ilog2(num_segments / num_queues), 3);
+	remaining_segments = num_segments - num_queues * (1U << pow);
+
+	/* We can only distribute remaining segments if (1) there are remaining
+	 * segments and (2) we did not reach the max segments per queue (2^3).
+	 */
+	if (remaining_segments != 0 && pow != 3) {
+		unsigned int delta = (1U << (pow + 1)) - (1U << pow);
+
+		num_advantaged_queues = remaining_segments / delta;
+	}
+
+	for (i = 0; i < num_advantaged_queues; i++)
+		val |= field_prep(GEM_TXQSEGALLOC_MASK(i), pow + 1);
+	for (i = num_advantaged_queues; i < num_queues; i++)
+		val |= field_prep(GEM_TXQSEGALLOC_MASK(i), pow);
+
+	return val;
+}
+
 static void macb_init_hw(struct macb *bp)
 {
 	u32 config;
@@ -3465,6 +3522,20 @@ static void macb_init_hw(struct macb *bp)
 	if (bp->caps & MACB_CAPS_JUMBO)
 		bp->rx_frm_len_mask = MACB_RX_JFRMLEN_MASK;
 
+	/* Distribute Tx SRAM segments evenly based on active number of queues.
+	 * TXQSEGALLOC is only documented for some GEM integrations.
+	 */
+	if (bp->caps & MACB_CAPS_TXQSEGALLOC) {
+		unsigned int num_segments;
+		u32 val;
+
+		num_segments = 1U << GEM_BFEXT(SEGMENTS_BIT_SIZE,
+					       gem_readl(bp, DCFG6));
+		val = gem_sram_distribute_segments(bp->ctx->num_queues,
+						   num_segments);
+		gem_writel(bp, TXQSEGALLOC_LOWER, val);
+	}
+
 	macb_configure_dma(bp);
 
 	/* Enable RX partial store and forward and set watermark */
@@ -6234,6 +6305,7 @@ static const struct macb_config zynqmp_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
+		MACB_CAPS_TXQSEGALLOC |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
@@ -6285,7 +6357,7 @@ static const struct macb_config versal_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
 		MACB_CAPS_NEED_TSUCLK | MACB_CAPS_QUEUE_DISABLE |
-		MACB_CAPS_QBV |
+		MACB_CAPS_QBV | MACB_CAPS_TXQSEGALLOC |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
@@ -6296,7 +6368,7 @@ static const struct macb_config versal_config = {
 static const struct macb_config eyeq5_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_QUEUE_DISABLE |
-		MACB_CAPS_NO_LSO | MACB_CAPS_EEE,
+		MACB_CAPS_NO_LSO | MACB_CAPS_EEE | MACB_CAPS_TXQSEGALLOC,
 	.dma_burst_length = 16,
 	.init = eyeq5_init,
 	.jumbo_max_len = 10240,

-- 
2.56.0

