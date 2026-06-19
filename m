Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6E18027
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896542; cv=none; b=SvYDTXRMWlXACicOi64xgpUnzGW7pgJWuu4XOFkoyL08HK6gTa1DQhFaKXfovXorWqrie5SDBGQ5S4Tj0rqWGKVPyFDhnJ5Ho8rF6SCIdZZr4ADZNnhxWtGJH5iewFL7cH8k7fujoOiOI8B3DJs4EypJZZLdTF95Es3vk9c/nkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896542; c=relaxed/simple;
	bh=qeFtPSk0a9t/cwi5Hoey59XuV/cxhN+y6cziJ+Nqt74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOKisZF328v9l8nD+vFW5uv/lV8rqtHg/1YAebYeKufh1z5p8ln6B3+czuS8R+T0od4qjPFnzbuf5bYA6IWaUQAWIKMRf0zijDWH7ISUMlqNAZm+umnCkFRjJdfNPMZ5lihWhTO6G/Ln5vn/q4ortNUTbcGwZMZxa5tVCiR3ZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCF1wsic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCF1wsic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785751F00A3A;
	Fri, 19 Jun 2026 19:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896540;
	bh=CIDFxpy+sKiaQWkwBZwhwNK8JQ039FvamiFsGnGHZzM=;
	h=From:To:Cc:Subject:Date;
	b=UCF1wsic6WZAAVggrn3YafiDJ1Z/3+sr/LqjQ+56D5RciZFna13BCPEsSC092t3zw
	 QKdtMZ3aqxVltk2GK3/M6EvoUEwpup+LN4jnov/aM+XmZ+1zqVXTxeKUDTiLL0qlV0
	 Apgl3RTTKZhYANYFY+pJqOB/aQyrWzdrmluaWm6wb1MzU9j/qVmz0qK0tiLU2GgQhY
	 +uI1uMiU+gH0EIcMGKGzb3eBwyd/GBUC223qOLSOPuVC6EyLLze77S34fMpD6Blsh/
	 q+mrjsDf8EX+pYVV+cRiMQKbLXBuyhNTdt0ikubN13K4zSPEgBtSkLsz2VnpnQaNz3
	 nHijKkKkdjvag==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net v2] eth: bnxt: improve the timing of stats
Date: Fri, 19 Jun 2026 12:15:38 -0700
Message-ID: <20260619191538.104165-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel selftests wait 1.25x of the promised stats refresh time
(as read from ethtool -c). bnxt reports 1sec by default, but
the stats update process has two steps. First device DMAs the
new values, then the service task performs update in full-width
SW counters. So the worst case delay is actually 2x.

Note that the behavior is different for ring stats and port stats.
Port stats are fetched synchronously by the service worker, so
there's no risk of doubling up the delay there.

The problem of stale stats impacts not only tests but real workloads
which monitor egress bandwidth of a NIC. The inaccuracy causes double
counting in the next cycle and spurious overload alarms.

Try to read from the DMA buffer more aggressively, to mitigate
timing issues between DMA and service task. The SW update should
be cheap.

Fixes: 51f307856b60 ("bnxt_en: Allow statistics DMA to be configurable using ethtool -C.")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com

v2:
 - split the accumulate into port and ring
 - make the sync only cover rings
 - remove sync from callbacks which use port stats (which are fetched
   synchronously by the service worker)
v1: https://lore.kernel.org/20260618181358.3037661-1-kuba@kernel.org

With this patch I had a 50 clean runs of ntuple.py in a row.
Previously it'd fail within 5 runs at most.

Hopefully this is good enough, in the past I sent an RFC to
convert the driver to use SW stats for everything. That felt
a little drastic.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 48 ++++++++++++++++++-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  1 +
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6d312259f852..6335dfc14c98 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2620,6 +2620,10 @@ struct bnxt {
 #define BNXT_MIN_STATS_COAL_TICKS	  250000
 #define BNXT_MAX_STATS_COAL_TICKS	 1000000
 
+	/* Protects stats_updated_jiffies and writes to sw_stats */
+	spinlock_t		stats_lock;
+	unsigned long		stats_updated_jiffies;
+
 	struct work_struct	sp_task;
 	unsigned long		sp_event;
 #define BNXT_RX_NTP_FLTR_SP_EVENT	1
@@ -3027,6 +3031,7 @@ void bnxt_reenable_sriov(struct bnxt *bp);
 void bnxt_close_nic(struct bnxt *, bool, bool);
 void bnxt_get_ring_drv_stats(struct bnxt *bp,
 			     struct bnxt_total_ring_drv_stats *stats);
+void bnxt_sync_ring_stats(struct bnxt *bp);
 bool bnxt_rfs_capable(struct bnxt *bp, bool new_rss_ctx);
 int bnxt_dbg_hwrm_rd_reg(struct bnxt *bp, u32 reg_off, u16 num_words,
 			 u32 *reg_buf);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 055e93a417b6..7513618793da 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10530,7 +10530,7 @@ static void bnxt_accumulate_stats(struct bnxt_stats_mem *stats)
 				stats->hw_masks, stats->len / 8, false);
 }
 
-static void bnxt_accumulate_all_stats(struct bnxt *bp)
+static void bnxt_accumulate_ring_stats(struct bnxt *bp)
 {
 	struct bnxt_stats_mem *ring0_stats;
 	bool ignore_zero = false;
@@ -10553,6 +10553,10 @@ static void bnxt_accumulate_all_stats(struct bnxt *bp)
 					ring0_stats->hw_masks,
 					ring0_stats->len / 8, ignore_zero);
 	}
+}
+
+static void bnxt_accumulate_port_stats(struct bnxt *bp)
+{
 	if (bp->flags & BNXT_FLAG_PORT_STATS) {
 		struct bnxt_stats_mem *stats = &bp->port_stats;
 		__le64 *hw_stats = stats->hw_stats;
@@ -10575,6 +10579,41 @@ static void bnxt_accumulate_all_stats(struct bnxt *bp)
 	}
 }
 
+static void bnxt_accumulate_all_stats(struct bnxt *bp)
+{
+	bnxt_accumulate_ring_stats(bp);
+	bnxt_accumulate_port_stats(bp);
+}
+
+/* Re-accumulate ring stats from DMA buffers if stale.
+ * uAPIs for reading sw_stats should call this first.
+ *
+ * We promise user space update frequency of bp->stats_coal_ticks but
+ * the update is a two step process - first device updates the DMA buffer,
+ * then we have to update from that buffer to driver stats in the service work.
+ * Worst case we would be 2x off from the desired frequency.
+ * Sync the stats sooner, if stale. The 20% threshold was chosen arbitrarily.
+ *
+ * Ideally we would split the user-configured time into two portions,
+ * i.e. also lower the DMA period by the 20%. But the DMA timer seems to have
+ * too coarse granularity to play such tricks.
+ */
+void bnxt_sync_ring_stats(struct bnxt *bp)
+{
+	unsigned long stale;
+
+	if (!netif_running(bp->dev) || !bp->stats_coal_ticks)
+		return;
+
+	spin_lock(&bp->stats_lock);
+	stale = usecs_to_jiffies(bp->stats_coal_ticks / 5);
+	if (time_after_eq(jiffies, bp->stats_updated_jiffies + stale)) {
+		bnxt_accumulate_ring_stats(bp);
+		bp->stats_updated_jiffies = jiffies;
+	}
+	spin_unlock(&bp->stats_lock);
+}
+
 static int bnxt_hwrm_port_qstats(struct bnxt *bp, u8 flags)
 {
 	struct hwrm_port_qstats_input *req;
@@ -13577,6 +13616,7 @@ bnxt_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		return;
 	}
 
+	bnxt_sync_ring_stats(bp);
 	bnxt_get_ring_stats(bp, stats);
 	bnxt_add_prev_stats(bp, stats);
 
@@ -14753,7 +14793,10 @@ static void bnxt_sp_task(struct work_struct *work)
 	if (test_and_clear_bit(BNXT_PERIODIC_STATS_SP_EVENT, &bp->sp_event)) {
 		bnxt_hwrm_port_qstats(bp, 0);
 		bnxt_hwrm_port_qstats_ext(bp, 0);
+		spin_lock(&bp->stats_lock);
 		bnxt_accumulate_all_stats(bp);
+		bp->stats_updated_jiffies = jiffies;
+		spin_unlock(&bp->stats_lock);
 	}
 
 	if (test_and_clear_bit(BNXT_LINK_CHNG_SP_EVENT, &bp->sp_event)) {
@@ -15488,6 +15531,7 @@ static int bnxt_init_board(struct pci_dev *pdev, struct net_device *dev)
 	INIT_DELAYED_WORK(&bp->fw_reset_task, bnxt_fw_reset_task);
 
 	spin_lock_init(&bp->ntp_fltr_lock);
+	spin_lock_init(&bp->stats_lock);
 #if BITS_PER_LONG == 32
 	spin_lock_init(&bp->db_lock);
 #endif
@@ -16056,6 +16100,7 @@ static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 	if (!bp->bnapi)
 		return;
 
+	bnxt_sync_ring_stats(bp);
 	cpr = &bp->bnapi[i]->cp_ring;
 	sw = cpr->stats.sw_stats;
 
@@ -16084,6 +16129,7 @@ static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
 	if (!bp->tx_ring)
 		return;
 
+	bnxt_sync_ring_stats(bp);
 	bnapi = bp->tx_ring[bp->tx_ring_map[i]].bnapi;
 	sw = bnapi->cp_ring.stats.sw_stats;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 56d74a3c24b7..62bc9cae613c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -606,6 +606,7 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
 		goto skip_ring_stats;
 	}
 
+	bnxt_sync_ring_stats(bp);
 	tpa_stats = bnxt_get_num_tpa_ring_stats(bp);
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
-- 
2.54.0

