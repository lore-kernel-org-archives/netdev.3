Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44637DAAA;
	Wed,  3 Jun 2026 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508991; cv=pass; b=G1iUUbbuUBeqxsSuegGEsPanCCwDbgPCJ3ZQPcsKVmqUBIE3F7uTQ++2a9wePjRLe92ciz72GgNxAsWl1qZOcGFvgWVdH7yQBHGI7NERUDySKTQUzIchQhZYzKta3v9BzqtDrL6rwThGVV3NwR6+GHVt7ve9+Se2m2ahLjlO7mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508991; c=relaxed/simple;
	bh=qn4Xbf/WWOHVBZFJdav8CuNnyRclRIB3yJGwU+diUg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4rn6eMHXZOMOXniGE2m37BTfc3BDTqKTdoUcaAetatTiga9lUvurEOEGNeYw3aubGTBbTOoYJExdqmWpA1OXwbxmCyI0+jQ+qyycY0SxggEK1tA7cQuV2ORCCa+51J+Yd++4hcQDs7e15vtXevZCH9vFirXK8+vMsT0mH32MLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b=AG4UdUuk; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b="AG4UdUuk"
ARC-Seal: i=1; a=rsa-sha256; t=1780508959; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=bcuEN3Loxr2maewwW3jVN8NAa90rD75CIE3AB5effUT2kP1z0eKT+tw9cTw9APDbdC8XaYXcsoPvyS2FhubiF0y1mxXu3x0MDnvbxd9YQ7t4DWXAebWn0Nvora3GyhTiE13lnjQZGodzzsF3n/oP1pRuOVihCv01efHH4qTwW1s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1780508959; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FPznyU5UkNdxURZq6oQJT5Pk+LvQRwwY9+SyJbPJKOg=; 
	b=FK5we3P/Ng/fWco9yxFl0z3v+0nRIZBVkMU6D8oOysoWt4AguiEbKwlNS7/uz7vB1EM7mbKv3ASz+aLHCdXrKgi1AF/bVJkrtbSsDZpgdT5d0wQ0tW8P/mdKDv+OwgjYHZQRtXkBBaI/9DBsl56FmQhEB3gZ5OzCBlFyU2SyzC0=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=kshitiz.bartariya@zohomail.in;
	dmarc=pass header.from=<kshitiz.bartariya@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780508959;
	s=zoho; d=zohomail.in; i=kshitiz.bartariya@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FPznyU5UkNdxURZq6oQJT5Pk+LvQRwwY9+SyJbPJKOg=;
	b=AG4UdUukDI1kx2SEUEW7VmauTJZ48D1/IsszS/KJwl8xcKjlz4ZzC1wa7rpdI94D
	roMScs9BT18oyXUjybHnJ9pTM0iG7avHGL3xFoBgdkaKpJHYSCA4O1/q/Vni4n/1Xb8
	GTJsQE2KiDkjD6er9w56XUNV7ctheC/fD5dJRg58=
Received: by mx.zoho.in with SMTPS id 1780508952546283.8008332037757;
	Wed, 3 Jun 2026 23:19:12 +0530 (IST)
From: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	piotr.kwapulinski@intel.com
Cc: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] ixgbe: implement get_queue_stats_rx
Date: Wed,  3 Jun 2026 23:18:51 +0530
Message-ID: <20260603174857.78666-1-kshitiz.bartariya@zohomail.in>
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

 - alloc_fail: sum of alloc_rx_page_failed and alloc_rx_buff_failed

 - csum_bad: maps directly to csum_err, which is incremented for both
   IP header and L4 checksum errors in ixgbe_rx_checksum().

The new per-queue stats can be observed with:
  $ ynltool qstats show scope queue

Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
---
v2:
 Amended commit message with command to get RX queue stats as 
suggested by Jedrzej Jagielski.

v1: https://lore.kernel.org/lkml/20260602100932.21838-1-kshitiz.bartariya@zohomail.in/


 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bc16e4c93fd4..05d4b8aff1fc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9759,6 +9759,21 @@ static void ixgbe_get_stats64(struct net_device *netdev,
 	stats->rx_missed_errors	= netdev->stats.rx_missed_errors;
 }
 
+static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_rx *stats)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
+	struct ixgbe_ring *ring = adapter->rx_ring[idx];
+
+	stats->alloc_fail = ring->rx_stats.alloc_rx_page_failed +
+			    ring->rx_stats.alloc_rx_buff_failed;
+	stats->csum_bad = ring->rx_stats.csum_err;
+}
+
+static const struct netdev_stat_ops ixgbe_stat_ops = {
+	.get_queue_stats_rx	= ixgbe_get_queue_stats_rx,
+};
+
 static int ixgbe_ndo_get_vf_stats(struct net_device *netdev, int vf,
 				  struct ifla_vf_stats *vf_stats)
 {
@@ -11662,6 +11677,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->phy.mdio.mdio_write = ixgbe_mdio_write;
 
 	netdev->netdev_ops = &ixgbe_netdev_ops;
+	netdev->stat_ops   = &ixgbe_stat_ops;
 	ixgbe_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
-- 
2.50.1 (Apple Git-155)

