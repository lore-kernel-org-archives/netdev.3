Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EAB44AB9A;
	Mon, 19 Oct 2026 03:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792381728; cv=none; b=F4pk2qk+9dREM1tycRupts29fSwybjFgsFQjkLBczZbOx6kDZrKDmIYE/SJSX38BTXsUXclxACrwG1TRI4BUeAe4ntqmsGIFrnyEmpLgkcNuEPKbbC5QKc/oZGLz63L6i2fjIIy1BVRSEP7/sCMX7serOXD6Sq5madMfkbmW3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792381728; c=relaxed/simple;
	bh=bL5GpubsC2SsCav4OzLno2QMjb+WhCTA22WdiGZIma0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rX63hAs3U+jk2qvFQuors6y3NwvZMDf+bMRgsK4FFAXrb7B331Z3d15MUnh9edJlYCY/g9PlT+N1Rtv0ugxF+Ws+3Sxu8Qd9H3lgQRT6TbZhTMQ15XOY8aNxSaD1I3LarnGit7NsFP4a2JVxcNIUT3f5NjCa4uKCuDF87P4naVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=J549ceGP; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="J549ceGP"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PL0JEFbpJLhFl/bIHa9gZmoBTG9za841mtk4/A8/zo0=;
	b=J549ceGPS21jdYl+jfrW74bxaL4iV+yqkE6Mq4Asr7pwSlLlgEKBv/c8O/EVekfeCCOFnfNqb
	yjq+LOh6EMmXXteUyoPC84vIQJ/MBdkah87R7VxkwOtkNEN2b8o5jkiTwWD6Q0eBtm5YNGRAYMp
	mcxHU64eAP0gBEoBq92u8mU=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4j7M353qJCzmV7R;
	Mon, 19 Oct 2026 11:48:33 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 75E5440561;
	Mon, 19 Oct 2026 11:48:36 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 19 Oct 2026 11:48:35 +0800
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
Subject: [PATCH net-next v17 2/2] hinic3: Add ethtool statistic ops part2
Date: Mon, 19 Oct 2026 11:45:38 +0800
Message-ID: <abc78c964dec55e440f8023db505632186d53d89.1792378301.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1792378301.git.gongfan1@huawei.com>
References: <cover.1792378301.git.gongfan1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)

This commit adds five standard ethtool statistics callbacks to the hinic3
driver: get_eth_phy_stats, get_eth_mac_stats, get_eth_ctrl_stats,
get_rmon_stats and get_pause_stats. Each callback reads the physical port
counters from firmware via hinic3_get_phy_port_stats() and copies them
into the standard ethtool structures.

Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 202 ++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index 64c862052f1e..2ae4d5afe90d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -696,6 +696,203 @@ static void hinic3_get_ethtool_stats(struct net_device *netdev,
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
+	phy_stats->SymbolErrorDuringCarrier =
+		le64_to_cpu(ps->mac_rx_sym_err_pkts);
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
+		netdev_err(netdev, "Failed to get eth mac stats from fw\n");
+		return;
+	}
+
+	mac_stats->FramesTransmittedOK =
+		le64_to_cpu(ps->mac_tx_good_pkts);
+	mac_stats->FramesReceivedOK =
+		le64_to_cpu(ps->mac_rx_good_pkts);
+	mac_stats->FrameCheckSequenceErrors =
+		le64_to_cpu(ps->mac_rx_fcs_err_pkts);
+	mac_stats->OctetsTransmittedOK =
+		le64_to_cpu(ps->mac_tx_good_octs);
+	mac_stats->OctetsReceivedOK =
+		le64_to_cpu(ps->mac_rx_good_octs);
+	mac_stats->MulticastFramesXmittedOK =
+		le64_to_cpu(ps->mac_tx_multi_pkts);
+	mac_stats->BroadcastFramesXmittedOK =
+		le64_to_cpu(ps->mac_tx_broad_pkts);
+	mac_stats->MulticastFramesReceivedOK =
+		le64_to_cpu(ps->mac_rx_multi_pkts);
+	mac_stats->BroadcastFramesReceivedOK =
+		le64_to_cpu(ps->mac_rx_broad_pkts);
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
+		netdev_err(netdev, "Failed to get eth ctrl stats from fw\n");
+		return;
+	}
+
+	ctrl_stats->MACControlFramesTransmitted =
+		le64_to_cpu(ps->mac_tx_control_pkts);
+	ctrl_stats->MACControlFramesReceived =
+		le64_to_cpu(ps->mac_rx_control_pkts);
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
+		netdev_err(netdev, "Failed to get eth rmon stats from fw\n");
+		return;
+	}
+
+	rmon_stats->undersize_pkts = le64_to_cpu(ps->mac_rx_undersize_pkts);
+	rmon_stats->oversize_pkts  = le64_to_cpu(ps->mac_rx_oversize_pkts);
+	rmon_stats->fragments      = le64_to_cpu(ps->mac_rx_fragment_pkts);
+	rmon_stats->jabbers        = le64_to_cpu(ps->mac_rx_jabber_pkts);
+
+	rmon_stats->hist[0]  = le64_to_cpu(ps->mac_rx_64_oct_pkts);
+	rmon_stats->hist[1]  = le64_to_cpu(ps->mac_rx_65_127_oct_pkts);
+	rmon_stats->hist[2]  = le64_to_cpu(ps->mac_rx_128_255_oct_pkts);
+	rmon_stats->hist[3]  = le64_to_cpu(ps->mac_rx_256_511_oct_pkts);
+	rmon_stats->hist[4]  = le64_to_cpu(ps->mac_rx_512_1023_oct_pkts);
+	rmon_stats->hist[5]  = le64_to_cpu(ps->mac_rx_1024_1518_oct_pkts);
+	rmon_stats->hist[6]  = le64_to_cpu(ps->mac_rx_1519_2047_oct_pkts);
+	rmon_stats->hist[7]  = le64_to_cpu(ps->mac_rx_2048_4095_oct_pkts);
+	rmon_stats->hist[8]  = le64_to_cpu(ps->mac_rx_4096_8191_oct_pkts);
+	rmon_stats->hist[9]  = le64_to_cpu(ps->mac_rx_8192_9216_oct_pkts);
+	rmon_stats->hist[10] = le64_to_cpu(ps->mac_rx_9217_12287_oct_pkts);
+
+	rmon_stats->hist_tx[0]  = le64_to_cpu(ps->mac_tx_64_oct_pkts);
+	rmon_stats->hist_tx[1]  = le64_to_cpu(ps->mac_tx_65_127_oct_pkts);
+	rmon_stats->hist_tx[2]  = le64_to_cpu(ps->mac_tx_128_255_oct_pkts);
+	rmon_stats->hist_tx[3]  = le64_to_cpu(ps->mac_tx_256_511_oct_pkts);
+	rmon_stats->hist_tx[4]  = le64_to_cpu(ps->mac_tx_512_1023_oct_pkts);
+	rmon_stats->hist_tx[5]  = le64_to_cpu(ps->mac_tx_1024_1518_oct_pkts);
+	rmon_stats->hist_tx[6]  = le64_to_cpu(ps->mac_tx_1519_2047_oct_pkts);
+	rmon_stats->hist_tx[7]  = le64_to_cpu(ps->mac_tx_2048_4095_oct_pkts);
+	rmon_stats->hist_tx[8]  = le64_to_cpu(ps->mac_tx_4096_8191_oct_pkts);
+	rmon_stats->hist_tx[9]  = le64_to_cpu(ps->mac_tx_8192_9216_oct_pkts);
+	rmon_stats->hist_tx[10] = le64_to_cpu(ps->mac_tx_9217_12287_oct_pkts);
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
+		netdev_err(netdev, "Failed to get eth pause stats from fw\n");
+		return;
+	}
+
+	pause_stats->tx_pause_frames = le64_to_cpu(ps->mac_tx_pause_pkts);
+	pause_stats->rx_pause_frames = le64_to_cpu(ps->mac_rx_pause_pkts);
+
+	kfree(ps);
+}
+
 static const struct ethtool_ops hinic3_ethtool_ops = {
 	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
@@ -707,6 +904,11 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
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

