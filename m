Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7EC463B9E;
	Fri,  2 Oct 2026 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945792; cv=none; b=ODpPCbDE2uH8VRS1kzCiHs+Dbw4w3lug78xQVaAJ5wk6MlLxlViLZzrZ0NNq5PglL4OMfjUtx6ofCOIZdpl4o6l/MH+9TlSwG+xBOip3NkzT4xjfszfKxA6M9bAJFvA5GrrOxWSyzLB84VTM5wWEyPktr6X2TjWn6nwinGmaAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945792; c=relaxed/simple;
	bh=T4fuTxunZdZYPuJm6LMyWjURfWOfio5sktJpQ2o1TBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoffhPHXEfj8bIkLVSQb0scVNuEpNMuYjllpXp0YyQUpKUA+PxZQEQ5lMDAfGBwROTUI2wy5+j69FckpeDdG7g2dBhlwRrlEXYySSoDTOLgYtn5MF+DnLiH0B0tOnM2k4VzukG69hg/1L7SjJp5lQ6JoDjJzDA6KcLmQOgoliRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc39c37f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc39c37f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99831F000FF;
	Fri,  2 Oct 2026 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945790;
	bh=uAcHLpZr4RDbBlI0aWaEWGUu72LvrY12ousTiZnfd4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zc39c37fUsTYuSn0nPGlifnj8ZqyyrDatWjI84WenhpN9I+YSKKx0MJV+k1mz9cMX
	 DunJKjtqzJnYoU376VXTn00mOhxK9IrH5L+iXzeKS5TKNidDCJ9X+l+emgb5wb0d0x
	 Z1b7bq8TzLu8QZuHbOzw3IXErqDTz+LP4GMmdZZ2rUeS2/gW38yJni0lwQJhyYNPsP
	 Dg5sGV91Uk4xKFJMwhh5FjPjfSgkgkXbpyKrpevniqHvSEvM5LBUFTDsp8oll6ahx7
	 bfD4CZmvhIys5ZLZXddy4jSLc/WVYhMp5SJ8529KrTG+/yqxjfCT17l4J2IDXVPsBX
	 GK1a6UI1L6hRA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com (reviewer:META ETHERNET DRIVERS),
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Sashiko <netdev-bot+sashiko@kernel.org>
Subject: [PATCH net v3 2/2] eth: fbnic: Publish real queue counts
Date: Fri,  2 Oct 2026 14:56:15 +0200
Message-ID: <20261002125617.409447-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002125617.409447-1-bjorn@kernel.org>
References: <20261002125617.409447-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fbnic exposes more queues than it configures until open, including
after ethtool -L while down. A memory provider can bind to an
unconfigured queue.

Publish the selected counts at probe and on offline channel changes.

Sashiko flagged the mismatch by code inspection; it was not reproduced
on physical hardware. Tested with fbnic QEMU on Debian sid: offline
ethtool -L changed RX/TX queues from 2 to 1 to 3. Reopening passed
DHCP and ping. Network selftests were not run.

Fixes: da43127a8edc ("eth: fbnic: support queue ops / zero-copy Rx")
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Link: https://lore.kernel.org/netdev/178915061000.219967.7726187707862333281@kernel.org/
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  7 +++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 29 +++++++++++++------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 76e9a545bb16..b96354e56517 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1631,6 +1631,13 @@ static int fbnic_set_channels(struct net_device *netdev,
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
index d1ed29312d54..1e16e10f3505 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -709,11 +709,12 @@ static const struct netdev_stat_ops fbnic_stat_ops = {
 	.get_base_stats		= fbnic_get_base_stats,
 };
 
-static void fbnic_reset_queues(struct fbnic_net *fbn,
-			       unsigned int tx, unsigned int rx)
+static int fbnic_reset_queues(struct fbnic_net *fbn,
+			      unsigned int tx, unsigned int rx)
 {
 	struct fbnic_dev *fbd = fbn->fbd;
 	unsigned int max_napis;
+	int err;
 
 	max_napis = fbd->num_irqs - FBNIC_NON_NAPI_VECTORS;
 
@@ -724,6 +725,14 @@ static void fbnic_reset_queues(struct fbnic_net *fbn,
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
@@ -792,9 +801,9 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	if (default_queues > fbd->max_num_queues)
 		default_queues = fbd->max_num_queues;
 
-	fbnic_reset_queues(fbn, default_queues, default_queues);
+	if (fbnic_reset_queues(fbn, default_queues, default_queues))
+		goto err_free_netdev;
 
-	fbnic_reset_indir_tbl(fbn);
 	fbnic_rss_key_fill(fbn->rss_key);
 	fbnic_rss_init_en_mask(fbn);
 
@@ -839,13 +848,15 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
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
-- 
2.55.0

