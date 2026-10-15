Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2426224AF2;
	Thu, 15 Oct 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076577; cv=fail; b=Ov6p7rxZKP1c+vCl06WEcElZAmBxpHBgH1MajL780O7u7ZO0RlgTu8zdJkpfOAVLPZ88Sx4xuyT0DfmPiuvTMxYwnH3mIEE8mfZgkqvmvCIDCuyKI3rvTa9r3yTdtIEVNspWpthHxCKg0cXkUhCH51oLvWkPN4ymocZuBvhkP6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076577; c=relaxed/simple;
	bh=jU5AbbjchBfjZRKDO8v4eQp/8XrZfiCqytb7tBLRawY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/VOPCFK0Wy/TvvtfIOYmBbc9BZwAJej9+5yfEVx977Ldp8bqVjWOnYcDMbcEJKvc/v03PnjX6HEB6D/qwjphHFNgQzoTkYiyyMlV1SrZfsVNFjhh+UhEBohh+uojZD1Zhqh+NkOfMiQ76kfFtNnqt6dR2HRnUUcg8A5tpDX33o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dMrdbcRE; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dMrdbcRE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3BIAAX73Wj7xSF/dmvjN7ILAYTwNxiilLfcU4UBEHufd5tnRnMJFKW6ZtHAix+F6D4jga5rV4hA8EZZMhkbyoZ+6y9gB1i+iyjqkAaH/d7LoXKUyCwHI5hmdx1JY4lWXJhC3muAf0QhX+MArcWDs+ItnSNBiscUiErxWaq3/ELJngtN/Uj6mqqHCXa+1YnIQRtt7NiZiY/DnvWWWZOTLC3hG+9Sep/s3SaEDyGFvjNz24FO/QKQudxvAr1nqQITsAdLSpGeNAgnBaTp7uaCHHpIb2Mlkn2GIvn/85hfdnyITYYm+tGzff9Wz4U0nCB8RGmHBabzp7BzfX9HD5KlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfK/ecA7f1HwBlEOaECNQ7MWs0DANIa8wBCgIx9+ldI=;
 b=QcNKW5L5IQyVsDDMmKfaa7VNBqe8yCVp8cO5/Tcy4nIKCHNfHV6rwoi/7au/VxLvZCt9Mc3CiJG9OVu7f+89dqzqnjj1w8w0sPqGpVAUEs6/AHb9Agi/W3Zfe/cwqstIHlK1VMJiSqdLlQ8herbzSg5rpSlsDFwCK2ijxOiEl6T7IGxdIHeXaqA1rPb+LyU/uPnKeCD9EWMY2xo1ToPkpseX9o/Jg1JaGhMgj3KYaZcJxMEcoS1zZajMY1JJ3QzxTxWuV5HNiiazqQYu/5wdWQjkJQIoPsfKJwAHsxtIChNgjAxms5+W2d/XkB5ST0750eBX3Uq1udgL6VRbBgLZuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfK/ecA7f1HwBlEOaECNQ7MWs0DANIa8wBCgIx9+ldI=;
 b=dMrdbcREy93A6safyO9U48YCMnB7AkOr8AGFUxQmMIgUTOsOuGtcejfic5SUoAUH6vHLXvWK+LN2ll+VsIG47e1LTnBleGvw3RUZ6YwW46Z0uQOp0aeYHK5nHt4qUHeJS67OHi8ESyHJoKWmE+7LMCikjI2mbKTqq6UQUZKDknUuKcNIuceoeU2NyW1shUpChY3GtVXqMQeZ78WJmYxOZc6/d7TnJelyF35ZvYYb1A39AxjP1Ve4EQyhy/m55yl3nZ053Kzg1IOQgxVHCEtUdTQMepnTgFQCtzoWMmatlJeT28XdVEfTMNTyQT2Ybsr5AzGJ8b15eNHUX8vSTSDOGQ==
Received: from DS3P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::6) by
 PH6PR12MB902451.namprd12.prod.outlook.com (2603:10b6:510:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 15:02:52 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:8:45f:cafe::28) by DS3P220CA0007.outlook.office365.com
 (2603:10b6:8:45f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 15:02:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94F.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 15:02:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:02:19 -0700
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:02:16 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>
CC: <maxime.chevallier@bootlin.com>, <Raju.Lakkaraju@microchip.com>,
	<cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH net-next v1 4/5] net: lan743x: reset the device on TX timeout
Date: Thu, 15 Oct 2026 11:00:43 -0400
Message-ID: <784a571839d5dd83c2c3e8ea38844159f353de77.1792008404.git.cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792008404.git.cbabroski@nvidia.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|PH6PR12MB902451:EE_
X-MS-Office365-Filtering-Correlation-Id: 13afdd25-1bd8-4249-5bee-08df2acd6287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|376014|23010399003|82310400026|56012099006|921020|11063799006|261009223027099003|10067099003|18002099003|22082099003|20046099003|18096099006;
X-Microsoft-Antispam-Message-Info:
	NtGxYrqVJ8f3CTh4qUPDt83QhFpkwKN+WXIuFupZEHWkyGieRgE+uFtV1AkhBRqt+XFo+EZn6mxsmo+qzBekv484ep3anVIAmoXKZcipyRWLj4ZblY8/HOyXR29VAvJywAzJVA1i+d6mSf/D8P8Gr9WVOIaudFaHjQtzSs+/JaJtdHr85YjbGRU9VRPfL7fyMpBC5wti87vduYH4Hs2ndgBGwiNkHCtnDf8QfZJ3655njHUhdrZjgLzab+yK8RcIH1Zk1ouRTXz5GyRENlGq8FI0uSqlK1OPMiCGtxgosjvcdN5lnWxFbsj19ZMA9RhlSC3HGJBSP9hDLQxYAfD9CVoghXLwFtiEwPHumc8GWFuLuKkWjADSf4SxdcItmVKeiRsXRVPCERFskJ8bQk/pQnkAweBN7ZKjXjTOTATTlsn4fgA9tSD2ICWC5xSDqpRU6O2WqtnQfcCbglQquBGpUlRIuN6nVGItW9Q9AXoDKfr4g753QUt+CodNJnR2RjqB0byWlF7uxC0o+7M56YDeaXxZNIZS0I3L+C3i0R/YeRESrrC2vHC0BcT9e30vm8rfu3GCuSgFlX5Vmcm/3pdqpLqQfDDNjMZUTAh2zTTTvz8xWPXOtkdFUcHTSXPsszkPnMz7SfyvnN8LelqEv/mCR3llJAFaobNDwbRwI+/zPv5AjNEzKuTMIi4iGKQ8o57GUxnH13HkMPN0eI6a00YpfnLbMe9vwp5M2YZ/eeoMXlDJrgHI3YUucMFMddc/dlCz
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(921020)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(20046099003)(18096099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NE+bUm70e2/eGkBWBN7Qc2oXe2E10XHLHnIDrp1NlpwFNBVECj6O8hic9uvpYV3LM6NBvqa6g4XCXBRnmV/N34JgcuwzzLcrORzUidK6MhOfYVe1cJ03rA3N20LJDbNllHjgpM47Kt6JWWLGx6qZMxsYbuiqsFFFlKNZgm3o6EnXR1b2Nkjtpzd4BtA6VkswHuD9q9fHL05Nh1bxgQRMqOhKuJkfoHX+cczPaW7E5rsjkfIzKxjMSIwvdLEmOlFd941BqiorzbvL5O7xvK1VNfhTQNN1Tu+sYaDiX9BeTkw8gJb+VZ1rgGwfvRxC1Bn+S76ujksa43OqTtOY8Sxmxd76nJrYzwOphGj1g7iiC4+eIJM127DVZaIVmf/za/aQ4PWSzYFYUJIH8HfMYPR9cZbqz1lcKxg97kDgvexttRKnHDqlGxVYWkGn20G1Y2Y0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:02:51.7830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13afdd25-1bd8-4249-5bee-08df2acd6287
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB902451

The driver does not implement ndo_tx_timeout, so the core TX watchdog is
never started. If a TX DMA channel stops completing descriptors, its
queue stays stopped and the interface cannot transmit again until it is
brought down and back up.

Add an ndo_tx_timeout handler that schedules a work item to reset the
device. Under rtnl_lock(), the work detaches the netdev, closes it,
soft-resets the DMA controller, opens it again and reattaches it. This
is the sequence suspend and resume already use, with the DMA controller
reset taking the place of the full hardware init.

Because everything is reopened, the RX path, PTP and the PHY link are
restarted along with TX. For PTP, the reset has the same effect as
bringing the interface down and up. As on suspend and resume, the PTP
clock is unregistered and registered again, and its time is reset to the
system time. The hardware timestamping state is also reset, so the RX
filter returns to none and one-step sync insertion is disabled, while
the driver keeps its TX timestamping flags. PTP applications have to set
up timestamping again.

lan743x_dmac_init() did not check that the DMA controller soft reset
completed, so the work could reopen a controller whose reset timed out.
Return the error from the poll so the work can tell. Probe already fails
when lan743x_dmac_init() returns an error, so a controller that does not
come out of reset now also fails probe.

If lan743x_dmac_init() or the reopen returns an error, the interface is
taken down with dev_close() so it can be brought back up later. The
hardware is already closed at that point, so route ndo_stop through a
wrapper that skips the hardware close while the device is detached.

ndo_stop is called with rtnl held and cannot wait for the work, so it
only cancels a pending one. A work that is already waiting for rtnl
returns if the device is still down when it gets the lock. If the device
was opened again in the meantime, it is reset once more, which only
costs an extra link flap. On remove, the work is cancelled synchronously
after the netdev is unregistered.

Assisted-by: LLM
Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 74 ++++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  2 +
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 8d256a80dac6..2545a846478d 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1516,10 +1516,14 @@ static void lan743x_rfe_set_multicast(struct lan743x_adapter *adapter)
 static int lan743x_dmac_init(struct lan743x_adapter *adapter)
 {
 	u32 data = 0;
+	int ret;
 
 	lan743x_csr_write(adapter, DMAC_CMD, DMAC_CMD_SWR_);
-	lan743x_csr_wait_for_bit(adapter, DMAC_CMD, DMAC_CMD_SWR_,
-				 0, 1000, 20000, 100);
+	ret = lan743x_csr_wait_for_bit(adapter, DMAC_CMD, DMAC_CMD_SWR_,
+				       0, 1000, 20000, 100);
+	if (ret)
+		return ret;
+
 	switch (DEFAULT_DMA_DESCRIPTOR_SPACING) {
 	case DMA_DESCRIPTOR_SPACING_16:
 		data = DMAC_CFG_MAX_DSPACE_16_;
@@ -3335,6 +3339,12 @@ static int lan743x_netdev_close(struct net_device *netdev)
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 	int index;
 
+	/* lan743x_reset_work() takes rtnl, so it cannot be waited for here.
+	 * A running one returns if the device is still down when it gets
+	 * rtnl, otherwise it resets the reopened device once more.
+	 */
+	cancel_work(&adapter->reset_work);
+
 	lan743x_phylink_disconnect(adapter);
 
 	synchronize_net();
@@ -3431,6 +3441,61 @@ static int lan743x_netdev_open(struct net_device *netdev)
 	return ret;
 }
 
+static int lan743x_netdev_stop(struct net_device *netdev)
+{
+	if (!netif_device_present(netdev))
+		return 0;
+
+	return lan743x_netdev_close(netdev);
+}
+
+static void lan743x_reset_work(struct work_struct *work)
+{
+	struct lan743x_adapter *adapter =
+		container_of(work, struct lan743x_adapter, reset_work);
+	struct net_device *netdev = adapter->netdev;
+	int ret;
+
+	rtnl_lock();
+
+	if (!netif_running(netdev) || !netif_device_present(netdev))
+		goto unlock;
+
+	netdev_warn(netdev, "resetting after TX timeout\n");
+
+	netif_device_detach(netdev);
+	lan743x_netdev_close(netdev);
+
+	ret = lan743x_dmac_init(adapter);
+	if (ret) {
+		netdev_err(netdev, "DMA controller reset failed: %d\n", ret);
+		goto close;
+	}
+
+	ret = lan743x_netdev_open(netdev);
+	if (ret) {
+		netdev_err(netdev, "failed to reopen after reset: %d\n", ret);
+		goto close;
+	}
+
+	goto attach;
+
+close:
+	dev_close(netdev);
+attach:
+	netif_device_attach(netdev);
+unlock:
+	rtnl_unlock();
+}
+
+static void lan743x_netdev_tx_timeout(struct net_device *netdev,
+				      unsigned int txqueue)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	schedule_work(&adapter->reset_work);
+}
+
 static netdev_tx_t lan743x_netdev_xmit_frame(struct sk_buff *skb,
 					     struct net_device *netdev)
 {
@@ -3537,8 +3602,9 @@ static int lan743x_netdev_set_mac_address(struct net_device *netdev,
 
 static const struct net_device_ops lan743x_netdev_ops = {
 	.ndo_open		= lan743x_netdev_open,
-	.ndo_stop		= lan743x_netdev_close,
+	.ndo_stop		= lan743x_netdev_stop,
 	.ndo_start_xmit		= lan743x_netdev_xmit_frame,
+	.ndo_tx_timeout		= lan743x_netdev_tx_timeout,
 	.ndo_eth_ioctl		= lan743x_netdev_ioctl,
 	.ndo_set_rx_mode	= lan743x_netdev_set_multicast,
 	.ndo_change_mtu		= lan743x_netdev_change_mtu,
@@ -3567,6 +3633,7 @@ static void lan743x_destroy_phylink(struct lan743x_adapter *adapter)
 static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
 {
 	unregister_netdev(adapter->netdev);
+	cancel_work_sync(&adapter->reset_work);
 
 	lan743x_destroy_phylink(adapter);
 	lan743x_mdiobus_cleanup(adapter);
@@ -3761,6 +3828,7 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 			      NETIF_MSG_LINK | NETIF_MSG_IFUP |
 			      NETIF_MSG_IFDOWN | NETIF_MSG_TX_QUEUED;
 	netdev->max_mtu = LAN743X_MAX_FRAME_SIZE;
+	INIT_WORK(&adapter->reset_work, lan743x_reset_work);
 
 	of_get_mac_address(pdev->dev.of_node, adapter->mac_address);
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index d9495cf96b41..2697f0a2a83b 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -6,6 +6,7 @@
 
 #include <linux/phy.h>
 #include <linux/phylink.h>
+#include <linux/workqueue.h>
 #include "lan743x_ptp.h"
 
 #define DRIVER_AUTHOR   "Bryan Whitehead <Bryan.Whitehead@microchip.com>"
@@ -1075,6 +1076,7 @@ struct lan743x_adapter {
 	struct lan743x_phy      phy;
 	struct lan743x_tx       tx[PCI11X1X_USED_TX_CHANNELS];
 	struct lan743x_rx       rx[LAN743X_USED_RX_CHANNELS];
+	struct work_struct	reset_work;
 	bool			is_pci11x1x;
 	bool			is_sgmii_en;
 	bool			is_rmii_en;
-- 
2.34.1

