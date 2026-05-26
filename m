Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962D2FFF81;
	Tue, 26 May 2026 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781754; cv=pass; b=LJttRQayDIGRMxYL74Gmt+sB10KoRWdECKZJ0XG0H7wHcGvT7SL9iMjxedOdXcNdndUezJQGoIXk1HlYCqlZVPLOJ5OOUipPwoulALoMkZi0SlJXqT1nbPYX7oiLpRNC6qbRvktPh+TUMSJoKB0WRs37YgNRdb7r9TAOdFcyB/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781754; c=relaxed/simple;
	bh=f3UC/LMFvMD6vgsXH62KkjzguDAXgLanNrQVh5aFKxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGL11CyJcyqCTnjzFp/5i/NGflID2paYUdU6HkFrbd9ICx9va2yXlnqBkT+D/28L66XMtyJVlQdwfTsd3a3n/f5Ph1xnZTDcwaBl86MFbJH2EwjhWJp9yJLYJLHGh/xKc3mZ0tk88dMdlW+aUtPLYa3d8rAAiehEhXCzW1QRHkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b=DF2BHMFb; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b="DF2BHMFb"
ARC-Seal: i=1; a=rsa-sha256; t=1779781706; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=E+bI56Bum6oCmHw7eAeve/aOI2EJmToMGD4E3jijyvM0Q+5X2krhWIZ0VnrfGw+GJO6dLKk3yWyQ8f5aDsCufPRXcWDpZrmR6kYvaj1WwbCYwmF2luYf4dB1Z3cTY1d+4JfHk3L0ta6pFd8zVZjC8dyWJF/j5x5Wq5eT8ZSIye4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1779781706; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RcYJkbepy0hFGDpKlaCDfg2/HYEIPKovcL1K3xETJ5c=; 
	b=NRZloqY9nNnmyjjvT7tv2I05n9k4YaADsSMtPOTR4xYv4/PyZkUeO1ia+ltu50IYuL1Twyage0rLdGPXeqjViAAStCoXAY2oRuhXCsc6R6zb+iRIbd73Vz6Srz/Y8hY9Py3dl92sYBLnNz4D+pwYpSpPzyLsvvOwlmJWbx+y2Fc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=kshitiz.bartariya@zohomail.in;
	dmarc=pass header.from=<kshitiz.bartariya@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779781706;
	s=zoho; d=zohomail.in; i=kshitiz.bartariya@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RcYJkbepy0hFGDpKlaCDfg2/HYEIPKovcL1K3xETJ5c=;
	b=DF2BHMFbOPkHACvwB/z+p1lJvJtdXl0muPaoruDwgDeYY/1gKvFcZyRrPJN7bZs1
	jRabxM4g03HT6NGtkJKus497wGLwN76waZAEimtIxwpTRF04mfxHnGvYwRVpo7XQ4rj
	OGh88OXSLuxy41M/YOpnVD85QUxr9QltPz7XzTbU=
Received: by mx.zoho.in with SMTPS id 1779781697849939.3097201310651;
	Tue, 26 May 2026 13:18:17 +0530 (IST)
From: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
To: kuba@kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] ixgbe: implement get_queue_stats_rx
Date: Tue, 26 May 2026 13:17:38 +0530
Message-ID: <20260526074744.36315-1-kshitiz.bartariya@zohomail.in>
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

Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
---
v2:
 - Removed setting of hw_gro counters as ixgbe doesn't advertise it
 - Removed idx and ring checks as they are already checked against 
   real_num_rx_queues
Thanks Jakub Kicinski for the review comments.

v1: https://lore.kernel.org/lkml/20260523144022.36484-1-kshitiz.bartariya@zohomail.in/


 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2646ee6f295f..2184213727c7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9740,6 +9740,21 @@ static void ixgbe_get_stats64(struct net_device *netdev,
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
@@ -11643,6 +11658,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->phy.mdio.mdio_write = ixgbe_mdio_write;
 
 	netdev->netdev_ops = &ixgbe_netdev_ops;
+	netdev->stat_ops   = &ixgbe_stat_ops;
 	ixgbe_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
-- 
2.50.1 (Apple Git-155)

