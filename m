Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095974B5157;
	Tue, 15 Sep 2026 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495750; cv=none; b=NALMM1Znlq2jU/FgkI2gaT5gO8msArkT+6bhSfCb4qPXMMrrmm+8b7Slkp4S2dX+Ut24cS51FSg9Fbf340sPMom/ozAuRQ8Hpi/aGyYBzU72kUdkX5gjNaTPD6kFpEiyCh+Pr5KjHIIQVup6d57jVN5iWR5KvtXtJ+9TywFuJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495750; c=relaxed/simple;
	bh=wO6axGIKOhfenEGMVpWnsJs5pqR+Ba/x+yymSQyA1gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eKQZzi9JySoNacMlLTUl1HkDi5KLPSZXIMokyxKjR7DhHbOqBruF1PGFU0+vYvNHDxBphWPtSbzkoZCfTfTjv8mQwMJ7sxAmBPW8py1HKXZTJutobLq8hDnI2R6UmX7jXe6BCC+WshFEvo5CRdZ1VHhmHJRV65HZ5yav8jttg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBbB6lji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBbB6lji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F651F000FF;
	Tue, 15 Sep 2026 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789495748;
	bh=TbS5+eAoperqzH4Qxn5jakyXJ/vxBpTbLqm86TWgeFs=;
	h=From:To:Cc:Subject:Date;
	b=UBbB6ljiAcuASgHRJewlODd5EnEh2g7DptJkMXyZdM/dinYABY6NuHuj68uAsSTsv
	 bNnse+lysTPWLf5JrtgY39tN3XoGiIeCeCPNDtWzlDXKz9P0zDU8uTEuUWFZ82AN+r
	 qhRwZUkTTR8Q6nge3nhQzMscnOMU6misRen5btnqU72frhYTEf22CNGC7BvoyxQBHu
	 LqTubIKQ60sGEylMI/ZVO9R5NCopNl7+IrG4sEf7LGMv8iMyEoOJa5e7fTnC5Z0Jn+
	 zEiERZn0UPb5v+gniLiOrZjvVCC3wnZzeNESojlC4ZyBpI+NVSJQarwYXIyR+INL3w
	 OAAgrdhxMnVlQ==
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
Subject: [PATCH net] eth: fbnic: Keep real queue counts synchronized
Date: Tue, 15 Sep 2026 20:08:57 +0200
Message-ID: <20260915180859.4157646-1-bjorn@kernel.org>
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
allocation maximum. fbnic selects smaller defaults and can change its
private queue counts while the device is down, but does not publish
either value until the next open.

Resume can also allocate fewer IRQs and silently clamp the private
queue counts. Queues can share NAPI vectors, so changing the
configured queue counts is unnecessary.

These mismatches can expose an inactive queue for memory-provider
binding or hide an existing binding. A later channel expansion can
allocate the queue without recognizing its memory provider.

Publish default and offline channel counts immediately. Reset RSS
indirection whenever the queue-count helper runs. Preserve queue
counts across resume and share the remaining NAPI vectors when fewer
IRQs are available. The RSS table remains valid because it indexes RX
queues rather than NAPI vectors.

Fixes: da43127a8edc ("eth: fbnic: support queue ops / zero-copy Rx")
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Link: https://lore.kernel.org/netdev/178915061000.219967.7726187707862333281@kernel.org/
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  7 +++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 29 +++++++++++++------
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  3 --
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   | 12 ++++++--
 4 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 0e47088ec44b..bec611387333 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1626,6 +1626,13 @@ static int fbnic_set_channels(struct net_device *netdev,
 		return -EINVAL;
 
 	if (!netif_running(netdev)) {
+		unsigned int rx_count = ch->rx_count + ch->combined_count;
+		unsigned int tx_count = ch->tx_count + ch->combined_count;
+
+		err = netif_set_real_num_queues(netdev, tx_count, rx_count);
+		if (err)
+			return err;
+
 		fbnic_set_queues(fbn, ch, max_napis);
 		fbnic_reset_indir_tbl(fbn);
 		return 0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 10bf99be3f24..3b44a0ec2a8d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -702,11 +702,12 @@ static const struct netdev_stat_ops fbnic_stat_ops = {
 	.get_base_stats		= fbnic_get_base_stats,
 };
 
-void fbnic_reset_queues(struct fbnic_net *fbn,
-			unsigned int tx, unsigned int rx)
+static int fbnic_reset_queues(struct fbnic_net *fbn,
+			      unsigned int tx, unsigned int rx)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
 	unsigned int max_napis;
+	int err;
 
 	max_napis = fbd->num_irqs - FBNIC_NON_NAPI_VECTORS;
 
@@ -717,6 +718,14 @@ void fbnic_reset_queues(struct fbnic_net *fbn,
 	fbn->num_rx_queues = rx;
 
 	fbn->num_napi = max(tx, rx);
+
+	err = netif_set_real_num_queues(fbn->netdev, tx, rx);
+	if (err)
+		return err;
+
+	fbnic_reset_indir_tbl(fbn);
+
+	return 0;
 }
 
 /**
@@ -785,9 +794,9 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	if (default_queues > fbd->max_num_queues)
 		default_queues = fbd->max_num_queues;
 
-	fbnic_reset_queues(fbn, default_queues, default_queues);
+	if (fbnic_reset_queues(fbn, default_queues, default_queues))
+		goto err_free_netdev;
 
-	fbnic_reset_indir_tbl(fbn);
 	fbnic_rss_key_fill(fbn->rss_key);
 	fbnic_rss_init_en_mask(fbn);
 
@@ -832,13 +841,15 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
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
index eded20b0e9e4..ddf1b674737a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -86,9 +86,6 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd);
 void fbnic_netdev_free(struct fbnic_dev *fbd);
 int fbnic_netdev_register(struct net_device *netdev);
 void fbnic_netdev_unregister(struct net_device *netdev);
-void fbnic_reset_queues(struct fbnic_net *fbn,
-			unsigned int tx, unsigned int rx);
-
 void fbnic_set_ethtool_ops(struct net_device *dev);
 
 int fbnic_ptp_setup(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 8b9bc9e8ea56..4dda566d580f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -472,6 +472,7 @@ static int __fbnic_pm_resume(struct device *dev)
 {
 	struct fbnic_dev *fbd = dev_get_drvdata(dev);
 	struct net_device *netdev = fbd->netdev;
+	unsigned int max_queues, max_napis;
 	void __iomem * const *iomap_table;
 	struct fbnic_net *fbn;
 	int err;
@@ -510,12 +511,17 @@ static int __fbnic_pm_resume(struct device *dev)
 
 	fbn = netdev_priv(netdev);
 
-	/* Reset the queues if needed */
-	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
-
 	rtnl_lock();
 	netdev_lock(netdev);
 
+	/* Preserve queue counts, as RX queues may have memory providers bound.
+	 * The RSS table indexes RX queues and remains valid. Rebuild only the
+	 * NAPI layout, sharing vectors if fewer IRQs are available.
+	 */
+	max_napis = fbd->num_irqs - FBNIC_NON_NAPI_VECTORS;
+	max_queues = max(fbn->num_tx_queues, fbn->num_rx_queues);
+	fbn->num_napi = min(max_queues, max_napis);
+
 	if (netif_running(netdev))
 		err = __fbnic_open(fbn);
 

base-commit: 83a945a529d6e002dd7339c532288a931f463dba
-- 
2.55.0

