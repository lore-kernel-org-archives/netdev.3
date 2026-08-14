Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098BD3C1996;
	Fri, 14 Aug 2026 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717014; cv=pass; b=bQrjNHU07Va6qhg9QcHSL8UgxO+sI2NTWapuaiqDFs4Qfm20fHK3DPcs4J7MBDXcAtyhVProSd2KGfKOJLqliWjmk5zDCl1+7RWc8Q26mLWUl1/uFKDW6E7Yx07tX5mOMpadTiIZalPevD6FczeIWo+bnLr/kUxsnz6ylcCum7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717014; c=relaxed/simple;
	bh=gVoHh9TkCVZhnsk1QXTLXJVMBTczX2KmNWyOD+ybfEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5yd038XLn7lIxsxqZoxbHGiz0ZMwcLvS8xbfdRTMtjKkGBK+teATSvd8PLeszTAQVbq/QOa7aZXh/p/7hOCQLUOswI6ZuOEaGPLlNlUHQ8W8qcSboXUpUrHusqfkqLYOCPcav75MbgigLPZ0LCBiM925bN+nL00Lq9G8/J6/HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b=CNCKHwx1; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b="CNCKHwx1"
ARC-Seal: i=1; a=rsa-sha256; t=1786716950; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=DsyX1NpykwINFvpa0gxLI9NhnUBmDy9gS4DdSYaBcBI4jq9x9Oe6K0fMO7edmBjuD5MNUwofj7YnAdhjEg/fZYKoncdrDbc1rd9prRbZkwdOct+LmpnMSQV37K9iKMGIkVybkHHfgPf6VK8yfSmVtfv9LGXiN2TKmQD1L9esbMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1786716950; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9DBH7XKlPfrjHaUVL3AZlDDm3gDjRrjfpvNdyzQnvkU=; 
	b=YQ9QtpXUtVAiqr9OTTd2CszqDKiJr4t8ah/rv9F5u1E3MMSsohLprUgoeujBlZMBijYBrasEbPiITgu43uBSR6uE5y1h7ikWoCgpnF1cAF3M7tb3qhU9Y/1Qqkr8KCrWf6mAs7F4xZoPvSQDAeFLVA6489fzbyQD2GwCQTrs65A=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=kshitiz.bartariya@zohomail.in;
	dmarc=pass header.from=<kshitiz.bartariya@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786716950;
	s=zoho; d=zohomail.in; i=kshitiz.bartariya@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9DBH7XKlPfrjHaUVL3AZlDDm3gDjRrjfpvNdyzQnvkU=;
	b=CNCKHwx1jI01l8CTNhS0BSS6keDRNsCF3gnTA+HVqZdvEr/OnmK1MJ6MMgQ4EPQR
	BtAhM1wjZf3Vq6Y0pcJVA/7H0zbcn4ELfhS27PtOvMQ5SD+hpu3b18jrgua4lyamWI4
	XAnOSEuK4wZ52fdQTTveqp7KcJQ23k4JMkt40gdM=
Received: by mx.zoho.in with SMTPS id 17867169433445.956065004386005;
	Fri, 14 Aug 2026 19:45:43 +0530 (IST)
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5] ixgbe: implement get_queue_stats_rx
Date: Fri, 14 Aug 2026 19:44:36 +0530
Message-ID: <20260814141446.90544-1-kshitiz.bartariya@zohomail.in>
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
v5:
 - Added READ_ONCE() and NULL check for accessing adapter->rx_ring[i]
 - Added u64_stats_fetch_begin before reading stats from rx_ring
 Suggested by Simon Horman

v4:
 - Changed comment format from // to /* */
 - Moved ixgbe_stat_ops declaration next to the ixgbe_netdev_ops
 Suggested by Jedrzej Jagielski.
https://lore.kernel.org/lkml/19ed3cf767d.36a9bda531830.5017017162150392549@zohomail.in/

v3:
 - Added bytes and packets stats counters
 - Implemented ixgbe_get_base_stats function
 As suggested by AI on 
 https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603174857.78666-1-kshitiz.bartariya%40zohomail.in
 https://lore.kernel.org/lkml/20260612084605.19785-1-kshitiz.bartariya@zohomail.in/

v2:
 Amended commit message with command to get RX queue stats as 
 suggested by Jedrzej Jagielski.
 https://lore.kernel.org/lkml/20260603174857.78666-1-kshitiz.bartariya@zohomail.in/

v1: 
 https://lore.kernel.org/lkml/20260602100932.21838-1-kshitiz.bartariya@zohomail.in/

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8873a8cc4a18..560177f135ff 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9760,6 +9760,45 @@ static void ixgbe_get_stats64(struct net_device *netdev,
 	stats->rx_missed_errors	= netdev->stats.rx_missed_errors;
 }
 
+static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_rx *stats)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
+	struct ixgbe_ring *ring = READ_ONCE(adapter->rx_ring[idx]);
+	u64 bytes, packets, alloc_rx_page_failed, alloc_rx_buff_failed,
+		csum_err;
+	unsigned int start;
+
+	if (ring) {
+		do {
+			start = u64_stats_fetch_begin(&ring->syncp);
+			bytes = ring->stats.bytes;
+			packets = ring->stats.packets;
+			alloc_rx_page_failed =
+				ring->rx_stats.alloc_rx_page_failed;
+			alloc_rx_buff_failed =
+				ring->rx_stats.alloc_rx_buff_failed;
+			csum_err = ring->rx_stats.csum_err;
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
+	}
+
+	stats->bytes = bytes;
+	stats->packets = packets;
+	stats->alloc_fail = alloc_rx_page_failed + alloc_rx_buff_failed;
+	stats->csum_bad = csum_err;
+}
+
+static void ixgbe_get_base_stats(struct net_device *dev,
+				 struct netdev_queue_stats_rx *rx,
+				 struct netdev_queue_stats_tx *tx)
+{
+	/* ixgbe has no inactive queues */
+	rx->bytes = 0;
+	rx->packets = 0;
+	rx->alloc_fail = 0;
+	rx->csum_bad = 0;
+}
+
 static int ixgbe_ndo_get_vf_stats(struct net_device *netdev, int vf,
 				  struct ifla_vf_stats *vf_stats)
 {
@@ -11117,6 +11156,11 @@ static const struct net_device_ops ixgbe_netdev_ops = {
 	.ndo_hwtstamp_set	= ixgbe_ptp_hwtstamp_set,
 };
 
+static const struct netdev_stat_ops ixgbe_stat_ops = {
+	.get_queue_stats_rx = ixgbe_get_queue_stats_rx,
+	.get_base_stats = ixgbe_get_base_stats,
+};
+
 static void ixgbe_disable_txr_hw(struct ixgbe_adapter *adapter,
 				 struct ixgbe_ring *tx_ring)
 {
@@ -11663,6 +11707,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->phy.mdio.mdio_write = ixgbe_mdio_write;
 
 	netdev->netdev_ops = &ixgbe_netdev_ops;
+	netdev->stat_ops = &ixgbe_stat_ops;
 	ixgbe_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
-- 
2.50.1 (Apple Git-155)

