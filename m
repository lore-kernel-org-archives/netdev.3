Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E69D470444;
	Tue, 13 Oct 2026 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857724; cv=none; b=sVNhCqI2h6INBEozTV98I5r130vQNTjSFzFI3M/Ako1w0jy54fw+4G6T6UrjSmhhXOHzWoSCwbnrLVS1fhSJ/GlUDlGyy5EIuZzRBm1KSpzghsALppaPboOKKpmoax9v6ZYO03Yb/nQfUDX5ex978+tjJpc3hl70O9CIzuh1jLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857724; c=relaxed/simple;
	bh=QLnOxLPUP5lCg92xLZNh5DUwkpBJeFHsL9h3tp7CVdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwsBOOTz76bBkPcI+Eol0tGHd9gf0cOYxZ0DAJgoCa+yN3zXb+RbmTuH9zQSl7LkYUxIRucBsimg9UprolyaGmJ8rWAvTkS23afRvSj/Qe4nt21NF3wKOyIeoco5XPh1oOEzJjmU4uDp+ivboFbMwzj9y4tx7DfcePuap40GFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TWKceBG+; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TWKceBG+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7dvdcgZ1W0Um6wZk/UfCfW+nbD3HbmHaeSJMTMy7Is0=;
	b=TWKceBG+tScFKMoWoD5ZpUEvu32a88gWhkSYBrF/1AI/lWhSlxVJR5g2yC3O0Ut4rc7qFyns2
	WHORIzBAJgF87v3AakttDD69fuojCAvpzKM8wAVWXN/WMJMauyzbb2i7fPY/sXDZcHLrln9VNaQ
	1OHirpTz21aCqb0o2lp4fIo=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j3d0Z1xSVznTZX;
	Tue, 13 Oct 2026 10:03:26 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 49EEC40586;
	Tue, 13 Oct 2026 10:15:19 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 13 Oct 2026 10:15:18 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri Daskalakis
	<dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>
Subject: [PATCH net-next v14 2/2] hinic3: Add ethtool statistic ops part2
Date: Tue, 13 Oct 2026 10:15:04 +0800
Message-ID: <d3d6148426f3228b52e9b8082262aa71c7fdf6dc.1791858167.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1791858167.git.gongfan1@huawei.com>
References: <cover.1791858167.git.gongfan1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)

  Add PF/VF statistics functions in TX and RX processing.
  Implement following ethtool callback function:
    .get_eth_phy_stats
    .get_eth_mac_stats
    .get_eth_ctrl_stats
    .get_rmon_stats
    .get_pause_stats

  These callbacks allow users to utilize ethtool for detailed
TX and RX netdev stats monitoring.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 178 ++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index 3863d26542ad..f61337d49444 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -723,6 +723,179 @@ static void hinic3_get_ethtool_stats(struct net_device *netdev,
 	hinic3_get_drv_queue_stats(netdev, data + i);
 }
 
+static void hinic3_get_eth_phy_stats(struct net_device *netdev,
+				     struct ethtool_eth_phy_stats *phy_stats)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct mag_cmd_port_stats *ps;
+	int err;
+
+	if (HINIC3_IS_VF(nic_dev->hwdev))
+		return;
+
+	ps = kmalloc_obj(*ps);
+	if (!ps)
+		return;
+
+	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
+	if (err) {
+		kfree(ps);
+		netdev_err(netdev, "Failed to get eth phy stats from fw\n");
+		return;
+	}
+
+	phy_stats->SymbolErrorDuringCarrier = ps->mac_rx_sym_err_pkt_num;
+
+	kfree(ps);
+}
+
+static void hinic3_get_eth_mac_stats(struct net_device *netdev,
+				     struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct mag_cmd_port_stats *ps;
+	int err;
+
+	ps = kmalloc_obj(*ps);
+	if (!ps)
+		return;
+
+	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
+	if (err) {
+		kfree(ps);
+		netdev_err(netdev, "Failed to get eth mac stats from fw\n");
+		return;
+	}
+
+	mac_stats->FramesTransmittedOK = ps->mac_tx_good_pkt_num;
+	mac_stats->FramesReceivedOK = ps->mac_rx_good_pkt_num;
+	mac_stats->FrameCheckSequenceErrors = ps->mac_rx_fcs_err_pkt_num;
+	mac_stats->OctetsTransmittedOK = ps->mac_tx_good_oct_num;
+	mac_stats->OctetsReceivedOK = ps->mac_rx_good_oct_num;
+	mac_stats->MulticastFramesXmittedOK = ps->mac_tx_multi_pkt_num;
+	mac_stats->BroadcastFramesXmittedOK = ps->mac_tx_broad_pkt_num;
+	mac_stats->MulticastFramesReceivedOK = ps->mac_rx_multi_pkt_num;
+	mac_stats->BroadcastFramesReceivedOK = ps->mac_rx_broad_pkt_num;
+
+	kfree(ps);
+}
+
+static void hinic3_get_eth_ctrl_stats(struct net_device *netdev,
+				      struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct mag_cmd_port_stats *ps;
+	int err;
+
+	ps = kmalloc_obj(*ps);
+	if (!ps)
+		return;
+
+	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
+	if (err) {
+		kfree(ps);
+		netdev_err(netdev, "Failed to get eth ctrl stats from fw\n");
+		return;
+	}
+
+	ctrl_stats->MACControlFramesTransmitted = ps->mac_tx_control_pkt_num;
+	ctrl_stats->MACControlFramesReceived = ps->mac_rx_control_pkt_num;
+
+	kfree(ps);
+}
+
+static const struct ethtool_rmon_hist_range hinic3_rmon_ranges[] = {
+	{     0,    64 },
+	{    65,   127 },
+	{   128,   255 },
+	{   256,   511 },
+	{   512,  1023 },
+	{  1024,  1518 },
+	{  1519,  2047 },
+	{  2048,  4095 },
+	{  4096,  8191 },
+	{  8192,  9216 },
+	{  9217, 12287 },
+	{}
+};
+
+static void hinic3_get_rmon_stats(struct net_device *netdev,
+				  struct ethtool_rmon_stats *rmon_stats,
+				  const struct ethtool_rmon_hist_range **ranges)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct mag_cmd_port_stats *ps;
+	int err;
+
+	ps = kmalloc_obj(*ps);
+	if (!ps)
+		return;
+
+	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
+	if (err) {
+		kfree(ps);
+		netdev_err(netdev, "Failed to get eth rmon stats from fw\n");
+		return;
+	}
+
+	rmon_stats->undersize_pkts	= ps->mac_rx_undersize_pkt_num;
+	rmon_stats->oversize_pkts	= ps->mac_rx_oversize_pkt_num;
+	rmon_stats->fragments		= ps->mac_rx_fragment_pkt_num;
+	rmon_stats->jabbers		= ps->mac_rx_jabber_pkt_num;
+
+	rmon_stats->hist[0]		= ps->mac_rx_64_oct_pkt_num;
+	rmon_stats->hist[1]		= ps->mac_rx_65_127_oct_pkt_num;
+	rmon_stats->hist[2]		= ps->mac_rx_128_255_oct_pkt_num;
+	rmon_stats->hist[3]		= ps->mac_rx_256_511_oct_pkt_num;
+	rmon_stats->hist[4]		= ps->mac_rx_512_1023_oct_pkt_num;
+	rmon_stats->hist[5]		= ps->mac_rx_1024_1518_oct_pkt_num;
+	rmon_stats->hist[6]		= ps->mac_rx_1519_2047_oct_pkt_num;
+	rmon_stats->hist[7]		= ps->mac_rx_2048_4095_oct_pkt_num;
+	rmon_stats->hist[8]		= ps->mac_rx_4096_8191_oct_pkt_num;
+	rmon_stats->hist[9]		= ps->mac_rx_8192_9216_oct_pkt_num;
+	rmon_stats->hist[10]		= ps->mac_rx_9217_12287_oct_pkt_num;
+
+	rmon_stats->hist_tx[0]		= ps->mac_tx_64_oct_pkt_num;
+	rmon_stats->hist_tx[1]		= ps->mac_tx_65_127_oct_pkt_num;
+	rmon_stats->hist_tx[2]		= ps->mac_tx_128_255_oct_pkt_num;
+	rmon_stats->hist_tx[3]		= ps->mac_tx_256_511_oct_pkt_num;
+	rmon_stats->hist_tx[4]		= ps->mac_tx_512_1023_oct_pkt_num;
+	rmon_stats->hist_tx[5]		= ps->mac_tx_1024_1518_oct_pkt_num;
+	rmon_stats->hist_tx[6]		= ps->mac_tx_1519_2047_oct_pkt_num;
+	rmon_stats->hist_tx[7]		= ps->mac_tx_2048_4095_oct_pkt_num;
+	rmon_stats->hist_tx[8]		= ps->mac_tx_4096_8191_oct_pkt_num;
+	rmon_stats->hist_tx[9]		= ps->mac_tx_8192_9216_oct_pkt_num;
+	rmon_stats->hist_tx[10]		= ps->mac_tx_9217_12287_oct_pkt_num;
+
+	*ranges = hinic3_rmon_ranges;
+
+	kfree(ps);
+}
+
+static void hinic3_get_pause_stats(struct net_device *netdev,
+				   struct ethtool_pause_stats *pause_stats)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct mag_cmd_port_stats *ps;
+	int err;
+
+	ps = kmalloc_obj(*ps);
+	if (!ps)
+		return;
+
+	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
+	if (err) {
+		kfree(ps);
+		netdev_err(netdev, "Failed to get eth pause stats from fw\n");
+		return;
+	}
+
+	pause_stats->tx_pause_frames = ps->mac_tx_pause_num;
+	pause_stats->rx_pause_frames = ps->mac_rx_pause_num;
+
+	kfree(ps);
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
 	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
@@ -734,6 +907,11 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
 	.get_strings                    = hinic3_get_strings,
 	.get_sset_count                 = hinic3_get_sset_count,
 	.get_ethtool_stats              = hinic3_get_ethtool_stats,
+	.get_eth_phy_stats              = hinic3_get_eth_phy_stats,
+	.get_eth_mac_stats              = hinic3_get_eth_mac_stats,
+	.get_eth_ctrl_stats             = hinic3_get_eth_ctrl_stats,
+	.get_rmon_stats                 = hinic3_get_rmon_stats,
+	.get_pause_stats                = hinic3_get_pause_stats,
 };
 
 void hinic3_set_ethtool_ops(struct net_device *netdev)
-- 
2.43.0

