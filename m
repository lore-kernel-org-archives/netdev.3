Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B4E3AA1BF;
	Sun, 20 Sep 2026 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789919062; cv=none; b=YTAY8na2TbnECISns/32arXOBnPlwIRBH8nUNFAd9kwB5FMe+21noH9hwtCUk7Jzge0Ty8wYVfBXxx+IobkRuumXVhunlKXmK9Fte4eOSaJW0DrZrERDJzlipioNORiybgke3abBHw10oVvfXxUrC/yZgipxW6ESekTYpfFRtSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789919062; c=relaxed/simple;
	bh=NXcvxngyirprKDf9xt5cFxOxuDfXXH/UxbKlRb7nn0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jlr2eDbLSesRS/OYs0G2S/Y7VHXTUGpfctdmkFarv+edEi8xDUguz+Gt7GMoFPqSn6Y1aNDjUisjDat0JE2kQKjGW+TWnWUgsgImI2eKlF0XSzgiCc4GPBQpyHNwxg0nud3B6kNi6Ci83ODdg4NYl0ctApTc2wa321hIwJvaWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=IHf43IOK; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="IHf43IOK"
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id D3F9F240875;
	Sun, 20 Sep 2026 17:44:14 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 9822F24046F;
	Sun, 20 Sep 2026 17:44:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1789919052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AecNapTxF362oY8rExZxZezRuqvp1u2dtTLC2cyGOGo=;
	b=IHf43IOKsxj6P1o2SIUddEo/Cckd8cLCRycpgDVjDrjv5WRVZCeIUt4wUHTHFZRIl5nMkj
	pX/2PjUJcfHFktbABB01Jeiu9Wemam/gFyzgr1Qaau/Bbo3Z1ouKeuGoVxB3jQHSKeN3Hn
	vibJXJPpmmL+nnH2uf/jTMEOozuxzrW5q2Tei5kzal9Om+TPOKqTOmtD5hud1dc/6f9joo
	WC6wojI6BCXc6438Uj+NijGEzR8nWHrj49NaWEoxicg8XKV4sM3ZwZCugBIl7DA0P7Kjxk
	Vi9kW9Hi7mB5xvuAhqU5YY4bO0wO8BINmaroYWnwBagDjhoRd1lb0D+PehnfWg==
Received: from Til-Notebook.lan (unknown [IPv6:2a00:1f:5743:bc00::d0f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 63596240350;
	Sun, 20 Sep 2026 17:44:08 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net-next 2/2] net: airoha: Add XDP statistics
Date: Sun, 20 Sep 2026 17:43:29 +0200
Message-ID: <20260920154329.161755-3-mail@tk154.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920154329.161755-1-mail@tk154.de>
References: <20260920154329.161755-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 6e5446
X-Rspamd-UID: 047c72

Track and expose per-device XDP statistics via ethtool, covering both
the RX and TX sides of the XDP data path.

A new struct airoha_xdp_stats is introduced and embedded in the existing
struct airoha_hw_stats. It contains the following counters, all protected
by the existing u64_stats_sync:

  rx_xdp_pass            - frames passed to the networking stack
  rx_xdp_aborted         - frames with XDP_ABORTED or unknown action
  rx_xdp_drop            - frames dropped by the BPF program or on error
  rx_xdp_tx              - frames sent back out via XDP_TX
  rx_xdp_tx_errors       - XDP_TX failures
  rx_xdp_redirect        - frames successfully redirected
  rx_xdp_redirect_errors - XDP_REDIRECT failures
  tx_xdp_xmit            - frames successfully submitted via ndo_xdp_xmit
  tx_xdp_xmit_errors     - frames dropped in ndo_xdp_xmit

The airoha_run_xdp() function is reworked to update the appropriate
counter after each XDP action. The airoha_xdp_xmit() ndo_xdp_xmit handler
is updated to record the number of successfully transmitted and dropped
frames.

The ethtool interface is extended with three new callbacks:

- get_strings: emits the XDP counter names followed by the page pool
  stat strings obtained from page_pool_ethtool_stats_get_strings().
- get_sset_count: returns the combined count of XDP and page pool stats.
- get_ethtool_stats: reads the XDP counters under the u64_stats_sync
  seqcount and appends page pool stats collected from all active RX
  queues via page_pool_get_stats().

PAGE_POOL_STATS is selected in Kconfig to enable the page pool statistics
infrastructure required by the ethtool callbacks.

Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/airoha/Kconfig      |   1 +
 drivers/net/ethernet/airoha/airoha_eth.c | 131 ++++++++++++++++++++---
 drivers/net/ethernet/airoha/airoha_eth.h |  14 +++
 3 files changed, 133 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
index 1f6640a15fc9..3fa7683a79e9 100644
--- a/drivers/net/ethernet/airoha/Kconfig
+++ b/drivers/net/ethernet/airoha/Kconfig
@@ -20,6 +20,7 @@ config NET_AIROHA
 	depends on NET_DSA || !NET_DSA
 	select NET_AIROHA_NPU
 	select PAGE_POOL
+	select PAGE_POOL_STATS
 	help
 	  This driver supports the gigabit ethernet MACs in the
 	  Airoha SoC family.
diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 71b25f225a8a..29b837204842 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -864,6 +864,11 @@ static int airoha_xdp_xmit(struct net_device *netdev, int n,
 	spin_unlock(&q->lock);
 	rcu_read_unlock();
 
+	u64_stats_update_begin(&dev->stats.syncp);
+	dev->stats.xdp_stats.tx_xdp_xmit += n - drops;
+	dev->stats.xdp_stats.tx_xdp_xmit_errors += drops;
+	u64_stats_update_end(&dev->stats.syncp);
+
 	return n - drops;
 }
 
@@ -871,40 +876,56 @@ static bool airoha_run_xdp(struct net_device *netdev, struct bpf_prog *prog,
 			   struct xdp_buff *xdp, struct airoha_queue *q,
 			   struct airoha_queue_entry *e, struct page *page)
 {
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_hw_stats *hw_stats = &dev->stats;
 	u32 act = bpf_prog_run_xdp(prog, xdp);
+	u64 *count;
 
 	switch (act) {
 	case XDP_PASS:
-		return false;
+		count = &hw_stats->xdp_stats.rx_xdp_pass;
+		goto update_stats;
 	case XDP_TX:
 		if (unlikely(airoha_xdp_xmit_back(netdev, xdp, q->qdma) < 0)) {
+			count = &hw_stats->xdp_stats.rx_xdp_tx_errors;
 			trace_xdp_exception(netdev, prog, act);
-			page_pool_put_full_page(q->page_pool, page, true);
-		} else {
-			e->buf = NULL;
+			break;
 		}
-		break;
+
+		e->buf = NULL;
+		count = &hw_stats->xdp_stats.rx_xdp_tx;
+		goto update_stats;
 	case XDP_REDIRECT:
 		if (unlikely(xdp_do_redirect(netdev, xdp, prog) < 0)) {
+			count = &hw_stats->xdp_stats.rx_xdp_redirect_errors;
 			trace_xdp_exception(netdev, prog, act);
-			page_pool_put_full_page(q->page_pool, page, true);
-		} else {
-			q->xdp_flush = true;
-			e->buf = NULL;
+			break;
 		}
-		break;
+
+		e->buf = NULL;
+		q->xdp_flush = true;
+		count = &hw_stats->xdp_stats.rx_xdp_redirect;
+		goto update_stats;
 	default:
 		bpf_warn_invalid_xdp_action(netdev, prog, act);
 		fallthrough;
 	case XDP_ABORTED:
+		count = &hw_stats->xdp_stats.rx_xdp_aborted;
 		trace_xdp_exception(netdev, prog, act);
-		fallthrough;
+		break;
 	case XDP_DROP:
-		page_pool_put_full_page(q->page_pool, page, true);
+		count = &hw_stats->xdp_stats.rx_xdp_drop;
 		break;
 	}
 
-	return true;
+	page_pool_put_full_page(q->page_pool, page, true);
+
+update_stats:
+	u64_stats_update_begin(&hw_stats->syncp);
+	*count = *count + 1;
+	u64_stats_update_end(&hw_stats->syncp);
+
+	return act != XDP_PASS;
 }
 
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
@@ -3676,12 +3697,96 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_xdp_xmit		= airoha_xdp_xmit,
 };
 
+#define AIROHA_ETHTOOL_XDP_STAT(x) { #x, \
+				  offsetof(struct airoha_hw_stats, xdp_stats.x) / \
+				  sizeof(u64) }
+
+static const struct {
+	const char name[ETH_GSTRING_LEN];
+	u32 offset;
+} airoha_ethtool_xdp_stats[] = {
+	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_redirect),
+	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_redirect_errors),
+	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_pass),
+	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_aborted),
+	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_drop),
+	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_tx),
+	AIROHA_ETHTOOL_XDP_STAT(rx_xdp_tx_errors),
+	AIROHA_ETHTOOL_XDP_STAT(tx_xdp_xmit),
+	AIROHA_ETHTOOL_XDP_STAT(tx_xdp_xmit_errors),
+};
+
+static void airoha_ethtool_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+{
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < ARRAY_SIZE(airoha_ethtool_xdp_stats); i++) {
+			strscpy(data, airoha_ethtool_xdp_stats[i].name, ETH_GSTRING_LEN);
+			data += ETH_GSTRING_LEN;
+		}
+		page_pool_ethtool_stats_get_strings(data);
+		break;
+	}
+}
+
+static int airoha_ethtool_get_sset_count(struct net_device *netdev, int stringset)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(airoha_ethtool_xdp_stats) + page_pool_ethtool_stats_get_count();
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void airoha_ethtool_get_ethtool_stats(struct net_device *netdev,
+					     struct ethtool_stats *stats,
+					     u64 *data)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_hw_stats *hw_stats = &dev->stats;
+	u64 *hw_stats_base = (u64 *)hw_stats;
+	struct page_pool_stats pp_stats = {};
+	struct airoha_qdma *qdma;
+	unsigned int start;
+	int i;
+
+	if (netif_running(netdev))
+		airoha_update_hw_stats(dev);
+
+	do {
+		start = u64_stats_fetch_begin(&hw_stats->syncp);
+		for (i = 0; i < ARRAY_SIZE(airoha_ethtool_xdp_stats); i++)
+			data[i] = hw_stats_base[airoha_ethtool_xdp_stats[i].offset];
+	} while (u64_stats_fetch_retry(&hw_stats->syncp, start));
+
+	rcu_read_lock();
+	qdma = rcu_dereference(dev->qdma);
+	if (qdma) {
+		for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+			struct airoha_queue *q = &qdma->q_rx[i];
+
+			if (q->page_pool)
+				page_pool_get_stats(q->page_pool, &pp_stats);
+		}
+	}
+	rcu_read_unlock();
+
+	page_pool_ethtool_stats_get(data + ARRAY_SIZE(airoha_ethtool_xdp_stats),
+				    &pp_stats);
+}
+
 static const struct ethtool_ops airoha_ethtool_ops = {
 	.get_drvinfo		= airoha_ethtool_get_drvinfo,
 	.get_eth_mac_stats      = airoha_ethtool_get_mac_stats,
 	.get_rmon_stats		= airoha_ethtool_get_rmon_stats,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.get_link		= ethtool_op_get_link,
+	.get_strings		= airoha_ethtool_get_strings,
+	.get_sset_count		= airoha_ethtool_get_sset_count,
+	.get_ethtool_stats	= airoha_ethtool_get_ethtool_stats,
 };
 
 static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index cfbc0b8f5bf9..d2ac295c49e9 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -236,6 +236,18 @@ struct airoha_tx_irq_queue {
 	u32 *q;
 };
 
+struct airoha_xdp_stats {
+	u64 rx_xdp_redirect;
+	u64 rx_xdp_redirect_errors;
+	u64 rx_xdp_pass;
+	u64 rx_xdp_aborted;
+	u64 rx_xdp_drop;
+	u64 rx_xdp_tx;
+	u64 rx_xdp_tx_errors;
+	u64 tx_xdp_xmit;
+	u64 tx_xdp_xmit_errors;
+};
+
 struct airoha_hw_stats {
 	struct u64_stats_sync syncp;
 
@@ -259,6 +271,8 @@ struct airoha_hw_stats {
 	u64 rx_jabber;
 	u64 rx_len[7];
 
+	struct airoha_xdp_stats xdp_stats;
+
 	struct {
 		/* Previous HW register values for 32-bit counter delta
 		 * tracking. Storing the last seen value and accumulating
-- 
2.55.0

