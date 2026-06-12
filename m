Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B005369203;
	Fri, 12 Jun 2026 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254037; cv=pass; b=dyHFKNvdVWw+OFvNlW0XKcB+7vYKsmCwwJ/qkBCgaCNllhVntOK2xlYEjelEtJASwMmrTtzULMOJTo/gHMiYybSObO92BepTZbsdXBbA9N5XvfDLVZfYIslCKueuGP1adRphp87MXa77nvqKrgBAWWoEatGS9zzuSXFaQKpU5OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254037; c=relaxed/simple;
	bh=2j0AgB1jx6p2RxECTQpkLHXs5LKei3KgrP1xtQbHgwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=piGFk7xdlixv2MDrgmUpRlvt5snkrUT7b2u+lpoStD/1GpHEZFOPxauIgQz9fuxHZYuj/aC/tC8o4FfyroeiJxsME0nrf4DLUpzyNnpHhDjFNb4fuaRsaWHBAnK+qg1YAMcSTB1w82TEj981qop9/aNmebvH1l3AenxlkyOdKiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b=LBgw4WBf; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b="LBgw4WBf"
ARC-Seal: i=1; a=rsa-sha256; t=1781253982; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=eGRnQKZ11G19/TkcercjgoM3fssebOrdkeJMdkeRwy+YwEy6WlhoPiF3PQIgrrhFREsNWHIoq87vhcV5e/s2AFshkpGp0hes5QJWqIcLd2ow+BTnS2O1EiVXS+/pW0rHq3J90PwKGZ8GpxaCwZo4ENlu0EE1/q1lwMkm73EYzAY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1781253982; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CQkfVgguiwXvWfXmmuDal+JSnpGF6rv8rLvpOvGFmys=; 
	b=Ge50CEadwc/P485gA/As2uyqGeK5FScBWWyCId+R1bNZqn36h2oZDCz0aisuYRGikR5B1FA1WswLeXIAlWzXNeYPxmwGjNfRgeXQzccydWftH7EChWzCgcFO6uhHqvG/9TFIm1L//6jEBbuZxADwwT15Hs0zMpaoBXcACyAmICo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=kshitiz.bartariya@zohomail.in;
	dmarc=pass header.from=<kshitiz.bartariya@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781253982;
	s=zoho; d=zohomail.in; i=kshitiz.bartariya@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CQkfVgguiwXvWfXmmuDal+JSnpGF6rv8rLvpOvGFmys=;
	b=LBgw4WBfeRtRalte0uMXurtgUjljsNJY5GJy/1Ep7WgBW/ZXgMgVVQpv4Ii0ZcN5
	PfmBA4KZC+/2pDHEY7YtmD5/Nd8J0W9htgBPgZiRtyYkoaKal6OMsiaszmfuOZXgw2H
	aosQRZrV6bUqobh6F1acEOKKXHlNpSMAEykAXD9c=
Received: by mx.zoho.in with SMTPS id 178125397351237.16656782640496;
	Fri, 12 Jun 2026 14:16:13 +0530 (IST)
From: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3] ixgbe: implement get_queue_stats_rx
Date: Fri, 12 Jun 2026 14:16:03 +0530
Message-ID: <20260612084605.19785-1-kshitiz.bartariya@zohomail.in>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hook into the netdev_stat_ops interface to expose per RX queue
statistics through the netdev generic netlink API.

The following counters are filled:
 - bytes: maps directly to bytes
 - packets: maps directly to packets
 - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed
 - csum_bad: maps directly to csum_err, which is incremented for both
   IP header and L4 checksum errors in ixgbe_rx_checksum().

The new per-queue stats can be observed with:
  $ ynltool qstats show scope queue

Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
---
v3:
 - Added bytes and packets stats counters
 - Implemented ixgbe_get_base_stats function
 As suggested by AI on 
 https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603174857.78666-1-kshitiz.bartariya%40zohomail.in

v2:
 Amended commit message with command to get RX queue stats as 
 suggested by Jedrzej Jagielski.
 https://lore.kernel.org/lkml/20260603174857.78666-1-kshitiz.bartariya@zohomail.in/

v1: 
 https://lore.kernel.org/lkml/20260602100932.21838-1-kshitiz.bartariya@zohomail.in/

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bc16e4c93fd4..fb15b70e91d9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9759,6 +9759,35 @@ static void ixgbe_get_stats64(struct net_device *netdev,
 	stats->rx_missed_errors	= netdev->stats.rx_missed_errors;
 }
 
+static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_rx *stats)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
+	struct ixgbe_ring *ring = adapter->rx_ring[idx];
+
+	stats->bytes = ring->stats.bytes;
+	stats->packets = ring->stats.packets;
+	stats->alloc_fail = ring->rx_stats.alloc_rx_page_failed +
+			    ring->rx_stats.alloc_rx_buff_failed;
+	stats->csum_bad = ring->rx_stats.csum_err;
+}
+
+static void ixgbe_get_base_stats(struct net_device *dev,
+				 struct netdev_queue_stats_rx *rx,
+				 struct netdev_queue_stats_tx *tx)
+{
+	// ixgbe has no inactive queues
+	rx->bytes = 0;
+	rx->packets = 0;
+	rx->alloc_fail = 0;
+	rx->csum_bad = 0;
+}
+
+static const struct netdev_stat_ops ixgbe_stat_ops = {
+	.get_queue_stats_rx = ixgbe_get_queue_stats_rx,
+	.get_base_stats = ixgbe_get_base_stats,
+};
+
 static int ixgbe_ndo_get_vf_stats(struct net_device *netdev, int vf,
 				  struct ifla_vf_stats *vf_stats)
 {
@@ -11662,6 +11691,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->phy.mdio.mdio_write = ixgbe_mdio_write;
 
 	netdev->netdev_ops = &ixgbe_netdev_ops;
+	netdev->stat_ops   = &ixgbe_stat_ops;
 	ixgbe_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
-- 
2.50.1 (Apple Git-155)

