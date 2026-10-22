Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671937;
	b=bbRHo270P3nlBKBWeMtzARKOsJF/MtmaCeX95m8qLKybIzXUrdtNvbHe0FqLOu7hF7kJ
	 DDy93gmvKU3/C4cLPumRiUamdGzs2nFl+wWC5X+Ovfs9HTwC4bxFRtXkjhOt3BkP8Mu6D
	 fviS/Q1ztrFaPCsPkHO/iDi9U7ugUW5KdNhiertUmC3/dQfXlCJSK3vAtgGMSFD0VIdyR
	 LgpEPv+iSl8KZ6Jp+cJMNrKu46LuEGbqaKlzak1g4x6pCqlOeul7lFfaBrfao6JMzA8eh
	 UmiFrr6KTU3in2kJwrxMimeJmkePQrA4K3idaG0pEtOXRhNlBIkpfugeoExAKRkH9GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671937;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=oGTKf0vd3XnDdgrOiuLtYsbrUDrGmhfVdo6r5lqdEM4=;
	b=uYeJ7cB0GHZHHfHablP2IUr6xKD2xN9qxixQPO0KBAxCmClFSFJw3QHmHM19hJDJzVFE
	 X70odIrZCS7BFaBlmdq3Cu0JdNcdk6EfMlKRTkZx1cKz7XQrLjWBfI6GOKjcxLXHo9sGW
	 VydhRN3EX/LiAFuGhwl1tHm75Yt1yVNFNNh07PXEHB9ELLpTvlN5aKPjv4PpOUvw4Vgx4
	 5WQMJOacP+fi4jK/5jSrTcLPsVFRkUAK+Xbnqz3895tXEoisZe5gTsKuceEAWBmp8AN6h
	 VlT268zOY7yBxnuS7zBsiC96Ix8eNxSSg9BjVmdv+e388JxR0LRtlzRgfgwXrysrRfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=bBJY3V4f;
	arc=none smtp.remote-ip=113.46.200.218
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417F606A31B;
	Thu, 22 Oct 2026 12:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0417F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=bBJY3V4f
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oGTKf0vd3XnDdgrOiuLtYsbrUDrGmhfVdo6r5lqdEM4=;
	b=bBJY3V4f3Kq6ayaEGPP+4SzvQpwobH8/R2XNTmKM3WsOacML3+lQpo+549zjk+1WyJ7tbrS/k
	OtJHoaC4sLt6SrnslQ1SAmedH8nSg+/v6w7zwsTieF8ee9uaeuoD3kYiR9YoSiA7JqV9zAyfXW2
	oTZ2w58ozZxA7AK423P+VZQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4j9QN65Kr6zpSvH;
	Thu, 22 Oct 2026 20:25:26 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id D160A40561;
	Thu, 22 Oct 2026 20:25:28 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.38) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 22 Oct 2026 20:25:27 +0800
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
Subject: [PATCH net-next v18 2/4] hinic3: Add ethtool statistic ops part2
Date: Thu, 22 Oct 2026 20:25:16 +0800
Message-ID: <ec560d40a490d476f3efc705de207b4f746e45ab.1792671176.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1792671176.git.gongfan1@huawei.com>
References: <cover.1792671176.git.gongfan1@huawei.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 211 ++++++++++++++++++
 1 file changed, 211 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
index 43e0ba798cbf..e1f23e2477fa 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
@@ -663,6 +663,212 @@ static void hinic3_get_ethtool_stats(struct net_device *netdev,
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
+		netdev_err_once(netdev,
+				"Failed to get eth phy stats from fw\n");
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
+		netdev_err_once(netdev,
+				"Failed to get eth mac stats from fw\n");
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
+		netdev_err_once(netdev,
+				"Failed to get eth ctrl stats from fw\n");
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
+		goto get_rmon_stats_err;
+
+	ps = kmalloc_obj(*ps);
+	if (!ps)
+		goto get_rmon_stats_err;
+
+	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
+	if (err) {
+		kfree(ps);
+		netdev_err_once(netdev,
+				"Failed to get eth rmon stats from fw\n");
+		goto get_rmon_stats_err;
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
+	return;
+
+get_rmon_stats_err:
+	*ranges = NULL;
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
+		netdev_err_once(netdev,
+				"Failed to get eth pause stats from fw\n");
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
@@ -674,6 +880,11 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
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

