Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC440B119;
	Thu, 24 Sep 2026 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277513; cv=none; b=lkbPZ8RIB0cX3+VAuY99YVS8SJz+xYCMkNbiBmjcRdG7/V0MYMdz51Q5prkAv5hOeAfieJucQf1skM2IsifiASw92+ClgG2CQbT3eYJPptZcZ7X/rqpGNIIzM1jPvFgJu3gRiYQjqZ4XJFDx/ulJ3tnQJgDiarKOtLk/0TnQ3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277513; c=relaxed/simple;
	bh=PfzflYVojz2F8W/RURGiDHsaB3bxSYPZItPj6bOaMbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rFgWRrxA0J5faEwxGj9rPxLTTNte8Fjfvo1S1Eo9AUvTcqgT7IL5b4VNuMdaWoRGn/WrifRIDoPv7KWbm9igwNiBkJMgSVuJjSyrlxATIiwI6gAQLTvWPB8bCv+Mmvsyb6J6QlkiRnxWX+Jq3ZlKAxSB9CnT9PFdGWkU8smk3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+ScGZ5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+ScGZ5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565461F000FF;
	Thu, 24 Sep 2026 19:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790277504;
	bh=DJ2MmdM0yHNEK3B5BgB8Z1ljlTxkm/Ft9anLyNTa6gY=;
	h=From:To:Cc:Subject:Date;
	b=a+ScGZ5xhoZbu4oWo2WByhNO+FSU6gbiQuMrsxFJC0USSH2+1PlPzTeEnuwEPhZpn
	 LOCH38IDyNRMTpbicgrJGvtMfmxvcNsMvNQEXm3V082pIimtRTSXc0wIDS1nDPlmXc
	 /9omk/lVRJAn2RcPcMGDmF0yMwgmT6QZS3QbyK/rx7xn1n5CCYqvsKiSh67l8viIqa
	 moo/sh3rDdMo0dNHXIDziHWTQO79lEOaWi+a+pEZx/gZitC1bH/TqesxvKavQWQHVw
	 +1MfmDrxWpYmehsLAD1aN1C/RxPYXRyFegQzJXzQHiVR0Q2WkvcWYySSl6KeWL029u
	 McrR2b/gcBJSQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org,
	Sashiko <netdev-bot+sashiko@kernel.org>
Subject: [PATCH net v2] eth: fbnic: Keep real queue counts synchronized
Date: Thu, 24 Sep 2026 21:18:15 +0200
Message-ID: <20260924191817.1843726-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

alloc_etherdev_mq() initializes the real queue counts to the
allocation maximum. fbnic selects smaller default queue counts and can
change its private queue counts while the device is down, but it does
not publish either value until the next open.

Resume also rebuilds the queue layout. It independently caps the RX
and TX ring counts at the number of available NAPI vectors, then sets
the NAPI count to the larger ring count. This happens even when the
number of available vectors has not changed. Combined configurations
with more rings than vectors lose rings, while separate RX and TX
channels are paired into combined channels where possible.

These mismatches can expose an inactive queue for memory-provider
binding or hide an existing binding. A later channel expansion can
then allocate the queue without recognizing its memory provider.

Publish the default and offline channel counts immediately.

Keep the configured queue and NAPI counts across resume. Suspend
clears num_napi when it frees the vectors, so track the configured
count separately. If resume gets fewer vectors than the configured
layout needs, fail with -ENOSPC rather than silently change the queue
configuration and its bindings. The netdev then stays detached until a
later recovery or a device reprobe.

Fixes: da43127a8edc ("eth: fbnic: support queue ops / zero-copy Rx")
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Link: https://lore.kernel.org/netdev/178915061000.219967.7726187707862333281@kernel.org/
Signed-off-by: Björn Töpel <bjorn@kernel.org>

---
Hmm, this was trickier than expected...

The policy when resume gets fewer MSI-X vectors than the configured
layout needs is not obvious. This version fails resume, which keeps
the queues and their bindings intact, but leaves the netdev detached
until a later recovery or a device reprobe.

Is it intended that fbnic_set_channels() accepts combined_count above
the number of available IRQs? It spreads the queues over fewer NAPIs,
and fbnic_get_channels() reports the ring count as combined channels.

If so, resume could keep combined layouts and convert mismatched rx
and tx layouts to combined channels instead of failing, so no rx queue
would have to be removed.

If not, set_channels needs fixing as well. Trimming queues on resume
would also have to repeat the core's channel-shrink checks for memory
providers, RSS indirection tables and ntuple rules, and account for
queue leases, but the helpers behind those checks are not exported.

Then again... I don't know how common the "resume and fewer IRQs"
scenario is. Maybe this approach is good enough?

Changes in v2:
- Keep the configured NAPI count in num_napi_cfg and restore it on
  resume. v1 recomputed it from the queue counts, which changed
  dedicated rx and tx layouts even when the vector count was
  unchanged. (Breno, Sashiko)
- Fail resume with -ENOSPC when fewer vectors come back than the
  configured layout needs. v1 kept the queue counts on fewer vectors,
  which could report more channels than NAPIs, in a layout that
  fbnic_set_channels() rejects. (Sashiko)
- Fix the comment and commit message that did not match the code.
  (Breno, Sashiko)
- Keep the RSS indirection reset in fbnic_netdev_alloc().
- Drop Breno's Reviewed-by, since the resume path changed.

v1: https://lore.kernel.org/netdev/20260915180859.4157646-1-bjorn@kernel.org/
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 16 +++++++++++---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 22 ++++++++++++-------
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  4 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   | 14 ++++++++++--
 4 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 76e9a545bb16..6be7ab0faa80 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -189,6 +189,7 @@ static void fbnic_clone_swap_cfg(struct fbnic_net *orig,
 	swap(clone->num_rx_queues, orig->num_rx_queues);
 	swap(clone->num_tx_queues, orig->num_tx_queues);
 	swap(clone->num_napi, orig->num_napi);
+	swap(clone->num_napi_cfg, orig->num_napi_cfg);
 	swap(clone->hds_thresh, orig->hds_thresh);
 }
 
@@ -1586,13 +1587,14 @@ static void fbnic_get_channels(struct net_device *netdev,
 	ch->max_combined = min(ch->max_rx, ch->max_tx);
 	ch->max_other =	FBNIC_NON_NAPI_VECTORS;
 
-	if (fbn->num_rx_queues > fbn->num_napi ||
-	    fbn->num_tx_queues > fbn->num_napi)
+	if (fbn->num_rx_queues > fbn->num_napi_cfg ||
+	    fbn->num_tx_queues > fbn->num_napi_cfg)
 		ch->combined_count = min(fbn->num_rx_queues,
 					 fbn->num_tx_queues);
 	else
 		ch->combined_count =
-			fbn->num_rx_queues + fbn->num_tx_queues - fbn->num_napi;
+			fbn->num_rx_queues + fbn->num_tx_queues -
+			fbn->num_napi_cfg;
 	ch->rx_count = fbn->num_rx_queues - ch->combined_count;
 	ch->tx_count = fbn->num_tx_queues - ch->combined_count;
 	ch->other_count = FBNIC_NON_NAPI_VECTORS;
@@ -1605,6 +1607,7 @@ static void fbnic_set_queues(struct fbnic_net *fbn, struct ethtool_channels *ch,
 	fbn->num_tx_queues = ch->tx_count + ch->combined_count;
 	fbn->num_napi = min(ch->rx_count + ch->tx_count + ch->combined_count,
 			    max_napis);
+	fbn->num_napi_cfg = fbn->num_napi;
 }
 
 static int fbnic_set_channels(struct net_device *netdev,
@@ -1631,6 +1634,13 @@ static int fbnic_set_channels(struct net_device *netdev,
 		return -EINVAL;
 
 	if (!netif_running(netdev)) {
+		unsigned int rxq = ch->rx_count + ch->combined_count;
+		unsigned int txq = ch->tx_count + ch->combined_count;
+
+		err = netif_set_real_num_queues(netdev, txq, rxq);
+		if (err)
+			return err;
+
 		fbnic_set_queues(fbn, ch, max_napis);
 		fbnic_reset_indir_tbl(fbn);
 		return 0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 10bf99be3f24..895add19131b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -702,8 +702,8 @@ static const struct netdev_stat_ops fbnic_stat_ops = {
 	.get_base_stats		= fbnic_get_base_stats,
 };
 
-void fbnic_reset_queues(struct fbnic_net *fbn,
-			unsigned int tx, unsigned int rx)
+static int fbnic_reset_queues(struct fbnic_net *fbn,
+			      unsigned int tx, unsigned int rx)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
 	unsigned int max_napis;
@@ -717,6 +717,9 @@ void fbnic_reset_queues(struct fbnic_net *fbn,
 	fbn->num_rx_queues = rx;
 
 	fbn->num_napi = max(tx, rx);
+	fbn->num_napi_cfg = fbn->num_napi;
+
+	return netif_set_real_num_queues(fbn->netdev, tx, rx);
 }
 
 /**
@@ -785,7 +788,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	if (default_queues > fbd->max_num_queues)
 		default_queues = fbd->max_num_queues;
 
-	fbnic_reset_queues(fbn, default_queues, default_queues);
+	if (fbnic_reset_queues(fbn, default_queues, default_queues))
+		goto err_free_netdev;
 
 	fbnic_reset_indir_tbl(fbn);
 	fbnic_rss_key_fill(fbn->rss_key);
@@ -832,13 +836,15 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	netif_tx_stop_all_queues(netdev);
 
-	if (fbnic_phylink_create(netdev)) {
-		free_netdev(netdev);
-		fbd->netdev = NULL;
-		return NULL;
-	}
+	if (fbnic_phylink_create(netdev))
+		goto err_free_netdev;
 
 	return netdev;
+
+err_free_netdev:
+	free_netdev(netdev);
+	fbd->netdev = NULL;
+	return NULL;
 }
 
 static int fbnic_dsn_to_mac_addr(u64 dsn, char *addr)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index eded20b0e9e4..89944c1bdaa4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -41,6 +41,8 @@ struct fbnic_net {
 	u32 rx_max_frames;
 
 	u16 num_napi;
+	/* Configured count, retained while suspend clears num_napi */
+	u16 num_napi_cfg;
 
 	struct phylink *phylink;
 	struct phylink_config phylink_config;
@@ -86,8 +88,6 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd);
 void fbnic_netdev_free(struct fbnic_dev *fbd);
 int fbnic_netdev_register(struct net_device *netdev);
 void fbnic_netdev_unregister(struct net_device *netdev);
-void fbnic_reset_queues(struct fbnic_net *fbn,
-			unsigned int tx, unsigned int rx);
 
 void fbnic_set_ethtool_ops(struct net_device *dev);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index c6698e3002a1..48279a5214c8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -479,6 +479,7 @@ static int __fbnic_pm_resume(struct device *dev)
 	struct fbnic_dev *fbd = dev_get_drvdata(dev);
 	struct net_device *netdev = fbd->netdev;
 	void __iomem * const *iomap_table;
+	unsigned int max_napis;
 	struct fbnic_net *fbn;
 	int err;
 
@@ -519,8 +520,16 @@ static int __fbnic_pm_resume(struct device *dev)
 
 	fbn = netdev_priv(netdev);
 
-	/* Reset the queues if needed */
-	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
+	max_napis = fbd->num_irqs - FBNIC_NON_NAPI_VECTORS;
+	if (fbn->num_napi_cfg > max_napis) {
+		netdev_err(netdev,
+			   "Unable to restore channel configuration: %u NAPI vectors required, only %u available\n",
+			   fbn->num_napi_cfg, max_napis);
+		err = -ENOSPC;
+		goto unlock;
+	}
+
+	fbn->num_napi = fbn->num_napi_cfg;
 
 	if (netif_running(netdev)) {
 		err = __fbnic_open(fbn);
@@ -529,6 +538,7 @@ static int __fbnic_pm_resume(struct device *dev)
 			fbn->num_napi = 0;
 	}
 
+unlock:
 	netdev_unlock(netdev);
 	rtnl_unlock();
 	if (err)

base-commit: fc6d80eb504458d6416b75a94188b268c95c6533
-- 
2.55.0

