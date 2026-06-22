Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68DE34EF0D
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 04:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782101904; cv=none; b=qzewVg2SeagHmBolPHQTOv4qdqfOU8oRmdQV0oUX0fBIW/ayF314Ilz3EY7S9AjjwF7OU8wv/HAWK2v5s8h3NhyrZhDgigDcARmAuciuIVDzQhNVddmS3cI8iscidT8Zprnw2zmgW5C/Y7czbu6FeKuFozqjjBK7SNlgQ0xgZ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782101904; c=relaxed/simple;
	bh=hyo4TwXHLo5SRa0kqf49RYReYGuWQPpaVPOS5+PweOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kIqeijYZdvemzl1+CveX7uu1+Ah+JE2x6WfFMrbZ/nGx7jZ2qkFY7ynpQ1EQ2mkFsBqJ88JCs8d780fyiNIj0xYvrWD/2xCX9GBMHnn8Wj5LfhIDIL2joLs//VK29ExtywhJnqI3VdWnKvsLrpXFx7UfTCsRmkyo8N8vb8Ad40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=meng.ding@siemens.com header.b=BJLvzfX+; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=meng.ding@siemens.com header.b="BJLvzfX+"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260622041810248c6b0dd900020702
        for <netdev@vger.kernel.org>;
        Mon, 22 Jun 2026 06:18:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=meng.ding@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=lQ6820iITIA8rfRG1G6WnH79UtAQMYvsY0SEqnsvm9s=;
 b=BJLvzfX+eCse1bfv8oRwaLkLaDZqHeFNHEvkIKrDlz0z8cMJhrriAOT0sdf5h0OJ7PGAcy
 RIKExtWEyn/jwOq1JOyh9ZInEE08LBG4MBu+KKv5/2WVTYzaknxfQ8ikiRb4L71adsm6ZITv
 FE9Pl5VMqt5Y+GiLK1UbdhpR+s7eYS+ZgSQpC1s+U8FPk+xSCkuYEvQiZHa0GrvwsUeJpVG2
 omrB6/iBQHPk8y3pIegqtLHQ8cFwWcEq1g0tlSBnlPl5n/LRn8eEN5Gr6mbagkzZfiH4gP/I
 YYB/AHiQoypuTMk/tyNlE0hbxEYEgCorVLS1EptyWkBa4HeMVNIU09xg==;
From: Ding Meng <meng.ding@siemens.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com
Cc: intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	meng.ding@siemens.com,
	wq.wang@siemens.com
Subject: [Intel-wired-lan] [PATCH net] igc: Fix RX HW timestamp reporting when NET_RX_BUSY_POLL is disabled
Date: Mon, 22 Jun 2026 12:13:23 +0800
Message-ID: <20260622041718.6106-1-meng.ding@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1335312:519-21489:flowmailer

When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps
from the NIC no longer works as expected.

This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the
SKB NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp()
fails to perform its driver lookup, and the igc driver's struct
net_device_ops::ndo_get_tstamp is never invoked.

Instead, get_timestamp() falls back to use shhwtstamps(skb)->hwtstamp,
a field that the driver has not populated.

Fix this by populating the hwtstamp field with the correct timestamp
in the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.

Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
Co-developed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Ding Meng <meng.ding@siemens.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 38 ++++++++++++++++-------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 8ac16808023..1da8d7aa76d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1992,7 +1992,26 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
 	return skb;
 }
 
-static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
+static void igc_construct_skb_timestamps(struct igc_adapter *adapter,
+					 struct sk_buff *skb,
+					 struct igc_xdp_buff *ctx)
+{
+	if (!ctx->rx_ts)
+		return;
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
+	skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
+#else
+	struct igc_inline_rx_tstamps *tstamps;
+
+	tstamps = ctx->rx_ts;
+	skb_hwtstamps(skb)->hwtstamp = igc_ptp_rx_pktstamp(adapter,
+							   tstamps->timer0);
+#endif
+}
+
+static struct sk_buff *igc_construct_skb(struct igc_adapter *adapter,
+					 struct igc_ring *rx_ring,
 					 struct igc_rx_buffer *rx_buffer,
 					 struct igc_xdp_buff *ctx)
 {
@@ -2013,10 +2032,7 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 	if (unlikely(!skb))
 		return NULL;
 
-	if (ctx->rx_ts) {
-		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
-		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
-	}
+	igc_construct_skb_timestamps(adapter, skb, ctx);
 
 	/* Determine available headroom for copy */
 	headlen = size;
@@ -2686,7 +2702,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		else if (ring_uses_build_skb(rx_ring))
 			skb = igc_build_skb(rx_ring, rx_buffer, &ctx.xdp);
 		else
-			skb = igc_construct_skb(rx_ring, rx_buffer, &ctx);
+			skb = igc_construct_skb(adapter, rx_ring, rx_buffer, &ctx);
 
 		/* exit if we failed to retrieve a buffer */
 		if (!xdp_res && !skb) {
@@ -2738,7 +2754,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 	return total_packets;
 }
 
-static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
+static struct sk_buff *igc_construct_skb_zc(struct igc_adapter *adapter,
+					    struct igc_ring *ring,
 					    struct igc_xdp_buff *ctx)
 {
 	struct xdp_buff *xdp = &ctx->xdp;
@@ -2760,10 +2777,7 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
 		__skb_pull(skb, metasize);
 	}
 
-	if (ctx->rx_ts) {
-		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
-		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
-	}
+	igc_construct_skb_timestamps(adapter, skb, ctx);
 
 	return skb;
 }
@@ -2775,7 +2789,7 @@ static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
 	struct igc_ring *ring = q_vector->rx.ring;
 	struct sk_buff *skb;
 
-	skb = igc_construct_skb_zc(ring, ctx);
+	skb = igc_construct_skb_zc(q_vector->adapter, ring, ctx);
 	if (!skb) {
 		ring->rx_stats.alloc_failed++;
 		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.47.3

