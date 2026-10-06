Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A23E63AC;
	Tue,  6 Oct 2026 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284802; cv=fail; b=W8Hnw0saA167i6/0cvAKazzama/98zaCJZHs2qv6QmYeb2GXpWpBL/5f6WNkCFxJsRlxLl8NNaYpn9DqNvD1IMlloPBcTcrnTxYG0LBLmFfoYMaJoeun7c8pS1Xw1F19dqDhY7y7wmqMg2T5rVEIoWqq53FhlBEUdbExYQMeQM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284802; c=relaxed/simple;
	bh=B9UGznqSOA2RT2DlJh3hZ36TzcVCW4117R7poAXZtu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dT0tL05YG/zvArkRUdhbgNbNBg4gI61uwBDbNKHPvsuUmXYTWx9v5zhPtITyKbLmJ/TaUABTYCnKTDbtkENRF4Mk80+Fl3GMuqkQitzLlIDVRdec5eFLuAuv3/7/Xvlgt2OaTMT7iH0pdWlL+fnIjgRZH5v1YrFzXje7a6uBIcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BwksmGgS; arc=fail smtp.client-ip=52.101.61.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BwksmGgS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9O/lRt8NH32ufOBF2UH7C707woDNooedHOR53Up01Hs5n0XGoTrA+9ZvIfo1VBjK9sO9qVmLkmkrra0hheii6fPwjcCMiBoqFCliFdSIf7Eewf27x31qFLWHEOkfppRyr4LDcEZSq0l4ErfZPWQuXEZFxpoDK6ZmnpAWw/vFzYX1RRBLZNkk0WC+2mMHC2HMnm2nGTm4GN/6vzM9/yS20zzOSuY7OcaJHiuyXg5H1cxN08yu4bb83xgNKfcGwT4jnU+0/unklvGrGIceJyZaAHqgSLJrN5iK3bkPHJ8dzDqeasJxaKS/NgY3pzapMh216pIqB2ou8+u0tvPyscS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysimD8y23wnCWk8PWiB3KA4qu0/ygyC0bAAZymVPoPk=;
 b=F68UJknE63DM2XImSar3jZx+yv9jZpoZP286/SdZMRwub9BuOXyk3kbKJ4sq0qvuAGOfgN65I00XtlCvpwXwRFWJioqhuzE4ATo9HfrF2Q4LzEb9y2j2Kr1dVm8/k9zYp4YnfrRYbOETGa0Uy6QQxCG1UPoZFTy+uXkRmh9z+v+MjGsqBXb03QxPn+u6CunGXC1uRZnhN8uYfOd+QfsCgcjNiAbXOjdT3kspRcpJEmRCa2iTIbvgXxkKioE2ohjjvrla/3y8lAV1xcD4KUgD69/DoGQQWnObgsFUTUNiQABJK3oL8Gv8XxkpKl8MYGEogjDZSv2xqhJGpi+sgaf/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysimD8y23wnCWk8PWiB3KA4qu0/ygyC0bAAZymVPoPk=;
 b=BwksmGgSgHIl2nSgzge++YlWtID4c4gKJFgNfARZ0XWePGAI2JQzZqKbcVzBppDCeEhB0e5W7RawAG7KwTU8B4XtkQRSSkUlQ/cPFaxuzx1ZLGBe1GdN3yW7orYliqSP2+N0cat01I1WjejZ4ey3vkGYazCn7Zr3dz+aAd2HDWQ=
Received: from BN9P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::24)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 11:06:08 +0000
Received: from IA0PEPF00000042.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::52) by BN9P221CA0026.outlook.office365.com
 (2603:10b6:408:10a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 11:06:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000042.mail.protection.outlook.com (10.167.249.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 11:06:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 06:05:58 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 06:05:54 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Michal Simek <michal.simek@amd.com>, Russell King <linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 1/6] net: xilinx: axienet: Introduce axienet_config for MAC-specific ops
Date: Tue, 6 Oct 2026 16:35:45 +0530
Message-ID: <20261006110550.1990213-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006110550.1990213-1-suraj.gupta2@amd.com>
References: <20261006110550.1990213-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000042:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: a58fe453-df11-43b6-84c4-08df2399d245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|23010399003|82310400026|36860700016|376014|22082099003|18002099003|6133799003|11063799006|5023799004|10067099003|56012099006|10063799003;
X-Microsoft-Antispam-Message-Info:
	njhfSW+ELtza+TXx6+bgOhSH1RvtgRsDW8lXiq+2OH0xfj/Jpqs2KNi55vM1C520TdrdycDWgHPRrCEdFa4pjZ9wXrmdyQVQcP1qAktlgagSOnULfNDzIUxabZ0Wfuu9Z43rii0Nd+AzlWwiMl460oUf0RbHzBJGJZwmsuPumhWzYbJdrxcOQG/UfYSaiiwKlMDhuJr5+lvgaMm0LSHqDp85GPmtnFNv1WJn8IPfGla1rSoN684ZhWRqYWNIiqnVDthMadH7N00C3j4FMJXr66wMEv47F8sNMPg63G0whr0u7h6HyjOlDcumDLEf00rUJiF3q24qxZNBcC9BW0xtiAGhwGa6xH/pfjL0AdJj8dUCYkTkvuUPv5Nw4VnVRrCC1/RWUZV3LY4cJpsi4CkyQ22QeHS/WrUwIfLCqgzdkMb1MysHmuM0PpYmnrIkqxpkBgVhfj9lgHQY1IsTXuAwEACSWvVgrF4rrlemw4SGlcsCtlY9AbCBoaP+4mk/iqtHATREbIuBp9uxpMqGUmENKSJxCXQjftU5jGYvw2tHxYaLlKh+7hxqtFlfVfnmT/Ob2yLMZqxpj1Mz5oOsNtsoJk5U+TKRMaOyYCNj6oB4PrDfqisuRPKoH90OO1Y1t36I9s7jFSrZLukB7AWZJDaOHZf2CcQq69WoPDkaF9eM/7rOqEzIuq60/wE4FFqfwe2TxTZJQGTQMBC/8XtHw9mHag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(5023799004)(10067099003)(56012099006)(10063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QeE0PaDiL4G6MfJeCls+pBGhMEllVbqSq2q1RaChANMA64T8cGPhT6IgSmW8j/byZE2yByBQ+IYAGCjAJoq0jnKZ+q8dEgAl7jqqfeHpyUgqldpZyl6cABKFfXDLr19gBJpWlUoCWZzSE4cUrGJa2r4Wu9V9nG0dCdIGrPJiPfLdfILu8nEQ3yW5Gs/XpjTwN3gUTeASTsn9wpzIOofJijVxlfXKlBJ5r+C4xs3YJBB1AehZnfFxQq+gLEor6dgQX3MPWdzqVLlwULN3YZvrgKCGWV4huyl+JlI6szzsMyZEmsazLEpBOdiYBx2Vqk3qrQW3S9b6JEqfxbYUxOJ4kDdsQu/Znt2O1SF3Zh0zcANRrQQw4KVX6vLag5BfK8wVvLcVVK005XwKoDO5lgInvsyHhzkGl9UiHiRTU343wqs3ylHI+5mQvwlqOtbQ2NSg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 11:06:07.4198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a58fe453-df11-43b6-84c4-08df2399d245
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000042.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

Introduce an axienet_config structure to abstract MAC-type-specific
operations, preparing the driver for supporting additional MAC types
beyond the existing 1G Ethernet.

Add axienet_config with capability flags (mdio, mac_irq, non_dmaengine,
uc_filter, mc_filter, vlan, jumbo, tx_csum, sw_padding, internal_pcs),
the register-dump count and callbacks (clk_init, setoptions, probe_init,
gt_reset, mac_init, mac_link_up, get_regs, phylink_set_caps, pcs_ops,
stats_update), and populate it from the OF match table. Convert the
common code to consult these capabilities and callbacks instead of
open-coding 1G behavior, so a new MAC type can be added without adding
MAC-specific conditionals to the shared paths.

No functional change intended for the existing 1G path.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  52 +++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 396 ++++++++++++------
 2 files changed, 323 insertions(+), 125 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index fcd3aaef27fc..591eb57fad25 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -545,6 +545,7 @@ struct skbuf_dma_descriptor {
  * @tx_ring_tail: TX skb ring buffer tail index.
  * @rx_ring_head: RX skb ring buffer head index.
  * @rx_ring_tail: RX skb ring buffer tail index.
+ * @axienet_config: MAC-type specific configuration and operations.
  */
 struct axienet_local {
 	struct net_device *ndev;
@@ -626,6 +627,57 @@ struct axienet_local {
 	int tx_ring_tail;
 	int rx_ring_head;
 	int rx_ring_tail;
+	const struct axienet_config *axienet_config;
+};
+
+/**
+ * struct axienet_config - MAC-type specific configuration and operations
+ * @mdio: MAC has an MDIO bus for external PHY management
+ * @mac_irq: MAC has a dedicated core interrupt
+ * @non_dmaengine: MAC supports the non-dmaengine flow
+ * @uc_filter: MAC has unicast address filter registers
+ * @mc_filter: MAC has multicast address filter registers
+ * @vlan: MAC supports VLAN frames by default
+ * @jumbo: MAC supports jumbo frames
+ * @tx_csum: MAC supports TX checksum offload
+ * @sw_padding: Short frames must be padded in software before transmit
+ * @internal_pcs: MAC always drives an internal PCS
+ * @regs_n: Number of MAC registers exposed through ethtool -d
+ * @clk_init: Callback to get and enable the MAC-specific clocks
+ * @setoptions: Callback to program MAC hardware options
+ * @probe_init: Callback for MAC-specific probe-time init, or NULL if unused
+ * @gt_reset: Callback to reset the serial transceiver (GT), or NULL if unused
+ * @mac_init: Callback for MAC-specific bring-up after the DMA reset
+ * @mac_link_up: Callback to program link speed and pause on link up, or NULL
+ * @get_regs: Callback to dump the MAC registers for ethtool -d
+ * @phylink_set_caps: Callback to set phylink MAC capabilities
+ * @pcs_ops: phylink PCS operations for this MAC, or NULL if unused
+ * @stats_update: Callback to latch/accumulate the periodic MAC counters
+ */
+struct axienet_config {
+	bool mdio;
+	bool mac_irq;
+	bool non_dmaengine;
+	bool uc_filter;
+	bool mc_filter;
+	bool vlan;
+	bool jumbo;
+	bool tx_csum;
+	bool sw_padding;
+	bool internal_pcs;
+	unsigned int regs_n;
+	int (*clk_init)(struct axienet_local *lp);
+	void (*setoptions)(struct net_device *ndev, u32 options);
+	void (*probe_init)(struct axienet_local *lp);
+	void (*gt_reset)(struct axienet_local *lp);
+	int (*mac_init)(struct net_device *ndev);
+	void (*mac_link_up)(struct net_device *ndev, int speed,
+			    bool tx_pause, bool rx_pause);
+	void (*get_regs)(struct axienet_local *lp, u32 *data);
+	void (*phylink_set_caps)(struct axienet_local *lp,
+				 struct phylink_config *config);
+	const struct phylink_pcs_ops *pcs_ops;
+	void (*stats_update)(struct axienet_local *lp);
 };
 
 /**
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 2844cd43f6d9..43a3f8dedbbd 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -66,16 +66,6 @@
 
 static void axienet_rx_submit_desc(struct net_device *ndev);
 
-/* Match table for of_platform binding */
-static const struct of_device_id axienet_of_match[] = {
-	{ .compatible = "xlnx,axi-ethernet-1.00.a", },
-	{ .compatible = "xlnx,axi-ethernet-1.01.a", },
-	{ .compatible = "xlnx,axi-ethernet-2.01.a", },
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, axienet_of_match);
-
 /* Option table for setting up Axi Ethernet hardware options */
 static struct axienet_option axienet_options[] = {
 	/* Turn on jumbo packet support for both Rx and Tx */
@@ -420,6 +410,9 @@ static void axienet_set_mac_address(struct net_device *ndev,
 	if (!is_valid_ether_addr(ndev->dev_addr))
 		eth_hw_addr_random(ndev);
 
+	if (!lp->axienet_config->uc_filter)
+		return;
+
 	/* Set up unicast MAC address filter set its mac address */
 	axienet_iow(lp, XAE_UAW0_OFFSET,
 		    (ndev->dev_addr[0]) |
@@ -469,6 +462,9 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 	u32 reg, af0reg, af1reg;
 	struct axienet_local *lp = netdev_priv(ndev);
 
+	if (!lp->axienet_config->mc_filter)
+		return;
+
 	reg = axienet_ior(lp, XAE_FMI_OFFSET);
 	reg &= ~XAE_FMI_PM_MASK;
 	if (ndev->flags & IFF_PROMISC)
@@ -577,14 +573,25 @@ static void axienet_stats_update(struct axienet_local *lp, bool reset)
 	write_seqcount_end(&lp->hw_stats_seqcount);
 }
 
+/**
+ * axienet_1g_stats_update - Refresh 1G MAC hardware statistics
+ * @lp:		Pointer to the axienet_local structure
+ */
+static void axienet_1g_stats_update(struct axienet_local *lp)
+{
+	axienet_stats_update(lp, false);
+}
+
 static void axienet_refresh_stats(struct work_struct *work)
 {
 	struct axienet_local *lp = container_of(work, struct axienet_local,
 						stats_work.work);
 
-	mutex_lock(&lp->stats_lock);
-	axienet_stats_update(lp, false);
-	mutex_unlock(&lp->stats_lock);
+	if (lp->axienet_config->stats_update) {
+		mutex_lock(&lp->stats_lock);
+		lp->axienet_config->stats_update(lp);
+		mutex_unlock(&lp->stats_lock);
+	}
 
 	/* Just less than 2^32 bytes at 2.5 GBit/s */
 	schedule_delayed_work(&lp->stats_work, 13 * HZ);
@@ -695,6 +702,32 @@ static void axienet_dma_stop(struct axienet_local *lp)
 	axienet_unlock_mii(lp);
 }
 
+/**
+ * axienet_1g_mac_init - 1G MAC-specific bring-up after the DMA reset
+ * @ndev:	Pointer to the net_device structure
+ *
+ * Return: 0 on success or a negative error number otherwise.
+ */
+static int axienet_1g_mac_init(struct net_device *ndev)
+{
+	struct axienet_local *lp = netdev_priv(ndev);
+	u32 axienet_status;
+
+	axienet_status = axienet_ior(lp, XAE_RCW1_OFFSET);
+	axienet_status &= ~XAE_RCW1_RX_MASK;
+	axienet_iow(lp, XAE_RCW1_OFFSET, axienet_status);
+
+	axienet_status = axienet_ior(lp, XAE_IP_OFFSET);
+	if (axienet_status & XAE_INT_RXRJECT_MASK)
+		axienet_iow(lp, XAE_IS_OFFSET, XAE_INT_RXRJECT_MASK);
+	axienet_iow(lp, XAE_IE_OFFSET, lp->eth_irq > 0 ?
+		    XAE_INT_RECV_ERROR_MASK : 0);
+
+	axienet_iow(lp, XAE_FCC_OFFSET, XAE_FCC_FCRX_MASK);
+
+	return 0;
+}
+
 /**
  * axienet_device_reset - Reset and initialize the Axi Ethernet hardware.
  * @ndev:	Pointer to the net_device structure
@@ -710,19 +743,23 @@ static void axienet_dma_stop(struct axienet_local *lp)
  */
 static int axienet_device_reset(struct net_device *ndev)
 {
-	u32 axienet_status;
 	struct axienet_local *lp = netdev_priv(ndev);
 	int ret;
 
+	if (lp->axienet_config->gt_reset)
+		lp->axienet_config->gt_reset(lp);
+
 	lp->max_frm_size = XAE_MAX_VLAN_FRAME_SIZE;
-	lp->options |= XAE_OPTION_VLAN;
+
+	if (lp->axienet_config->vlan)
+		lp->options |= XAE_OPTION_VLAN;
 	lp->options &= (~XAE_OPTION_JUMBO);
 
 	if (ndev->mtu > XAE_MTU && ndev->mtu <= XAE_JUMBO_MTU) {
 		lp->max_frm_size = ndev->mtu + VLAN_ETH_HLEN +
 					XAE_TRL_SIZE;
 
-		if (lp->max_frm_size <= lp->rxmem)
+		if (lp->max_frm_size <= lp->rxmem && lp->axienet_config->jumbo)
 			lp->options |= XAE_OPTION_JUMBO;
 	}
 
@@ -739,26 +776,18 @@ static int axienet_device_reset(struct net_device *ndev)
 		}
 	}
 
-	axienet_status = axienet_ior(lp, XAE_RCW1_OFFSET);
-	axienet_status &= ~XAE_RCW1_RX_MASK;
-	axienet_iow(lp, XAE_RCW1_OFFSET, axienet_status);
-
-	axienet_status = axienet_ior(lp, XAE_IP_OFFSET);
-	if (axienet_status & XAE_INT_RXRJECT_MASK)
-		axienet_iow(lp, XAE_IS_OFFSET, XAE_INT_RXRJECT_MASK);
-	axienet_iow(lp, XAE_IE_OFFSET, lp->eth_irq > 0 ?
-		    XAE_INT_RECV_ERROR_MASK : 0);
-
-	axienet_iow(lp, XAE_FCC_OFFSET, XAE_FCC_FCRX_MASK);
+	ret = lp->axienet_config->mac_init(ndev);
+	if (ret)
+		return ret;
 
 	/* Sync default options with HW but leave receiver and
 	 * transmitter disabled.
 	 */
-	axienet_setoptions(ndev, lp->options &
-			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
+	lp->axienet_config->setoptions(ndev, lp->options &
+				       ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 	axienet_set_mac_address(ndev, NULL);
 	axienet_set_multicast_list(ndev);
-	axienet_setoptions(ndev, lp->options);
+	lp->axienet_config->setoptions(ndev, lp->options);
 
 	netif_trans_update(ndev);
 
@@ -916,6 +945,13 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 	int sg_len;
 	int ret;
 
+	if (lp->axienet_config->sw_padding && eth_skb_pad(skb)) {
+		/* Pad short frames; the MAC does not append Ethernet padding. */
+		ndev->stats.tx_dropped++;
+		ndev->stats.tx_errors++;
+		return NETDEV_TX_OK;
+	}
+
 	dma_dev = lp->tx_chan->device;
 	sg_len = skb_shinfo(skb)->nr_frags + 1;
 	if (CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX) <= 1) {
@@ -940,19 +976,21 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 		goto xmit_error_drop_skb;
 
 	/* Fill up app fields for checksum */
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
-			/* Tx Full Checksum Offload Enabled */
-			app_metadata[0] |= 2;
-		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
-			csum_start_off = skb_transport_offset(skb);
-			csum_index_off = csum_start_off + skb->csum_offset;
-			/* Tx Partial Checksum Offload Enabled */
-			app_metadata[0] |= 1;
-			app_metadata[1] = (csum_start_off << 16) | csum_index_off;
+	if (lp->axienet_config->tx_csum) {
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
+				/* Tx Full Checksum Offload Enabled */
+				app_metadata[0] |= 2;
+			} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
+				csum_start_off = skb_transport_offset(skb);
+				csum_index_off = csum_start_off + skb->csum_offset;
+				/* Tx Partial Checksum Offload Enabled */
+				app_metadata[0] |= 1;
+				app_metadata[1] = (csum_start_off << 16) | csum_index_off;
+			}
+		} else if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
+			app_metadata[0] |= 2; /* Tx Full Checksum Offload Enabled */
 		}
-	} else if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
-		app_metadata[0] |= 2; /* Tx Full Checksum Offload Enabled */
 	}
 
 	dma_tx_desc = dma_dev->device_prep_slave_sg(lp->tx_chan, skbuf_dma->sgl,
@@ -1740,8 +1778,8 @@ static int axienet_stop(struct net_device *ndev)
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
 
-	axienet_setoptions(ndev, lp->options &
-			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
+	lp->axienet_config->setoptions(ndev, lp->options &
+				       ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 
 	if (!lp->use_dmaengine) {
 		axienet_dma_stop(lp);
@@ -1767,7 +1805,8 @@ static int axienet_stop(struct net_device *ndev)
 	}
 
 	netdev_reset_queue(ndev);
-	axienet_iow(lp, XAE_IE_OFFSET, 0);
+	if (lp->axienet_config->mac_irq)
+		axienet_iow(lp, XAE_IE_OFFSET, 0);
 
 	if (lp->eth_irq > 0)
 		free_irq(lp->eth_irq, ndev);
@@ -1936,30 +1975,18 @@ static void axienet_ethtools_get_drvinfo(struct net_device *ndev,
  */
 static int axienet_ethtools_get_regs_len(struct net_device *ndev)
 {
-	return sizeof(u32) * AXIENET_REGS_N;
+	struct axienet_local *lp = netdev_priv(ndev);
+
+	return sizeof(u32) * lp->axienet_config->regs_n;
 }
 
 /**
- * axienet_ethtools_get_regs - Dump the contents of all registers present
- *			       in AxiEthernet core.
- * @ndev:	Pointer to net_device structure
- * @regs:	Pointer to ethtool_regs structure
- * @ret:	Void pointer used to return the contents of the registers.
- *
- * This implements ethtool command for getting the Axi Ethernet register dump.
- * Issue "ethtool -d ethX" to execute this function.
+ * axienet_1g_get_regs - Dump 1G MAC registers for ethtool
+ * @lp:		Pointer to the axienet_local structure
+ * @data:	Buffer for register values (zeroed and sized by the caller)
  */
-static void axienet_ethtools_get_regs(struct net_device *ndev,
-				      struct ethtool_regs *regs, void *ret)
+static void axienet_1g_get_regs(struct axienet_local *lp, u32 *data)
 {
-	u32 *data = (u32 *)ret;
-	size_t len = sizeof(u32) * AXIENET_REGS_N;
-	struct axienet_local *lp = netdev_priv(ndev);
-
-	regs->version = 0;
-	regs->len = len;
-
-	memset(data, 0, len);
 	data[0] = axienet_ior(lp, XAE_RAF_OFFSET);
 	data[1] = axienet_ior(lp, XAE_TPF_OFFSET);
 	data[2] = axienet_ior(lp, XAE_IFGP_OFFSET);
@@ -2000,6 +2027,31 @@ static void axienet_ethtools_get_regs(struct net_device *ndev,
 	}
 }
 
+/**
+ * axienet_ethtools_get_regs - Dump the contents of all registers present
+ *			       in AxiEthernet core.
+ * @ndev:	Pointer to net_device structure
+ * @regs:	Pointer to ethtool_regs structure
+ * @ret:	Void pointer used to return the contents of the registers.
+ *
+ * This implements ethtool command for getting the Axi Ethernet register dump.
+ * Issue "ethtool -d ethX" to execute this function.
+ */
+static void axienet_ethtools_get_regs(struct net_device *ndev,
+				      struct ethtool_regs *regs, void *ret)
+{
+	struct axienet_local *lp = netdev_priv(ndev);
+	u32 *data = (u32 *)ret;
+	size_t len;
+
+	len = sizeof(u32) * lp->axienet_config->regs_n;
+	regs->version = 0;
+	regs->len = len;
+
+	memset(data, 0, len);
+	lp->axienet_config->get_regs(lp, data);
+}
+
 static void
 axienet_ethtools_get_ringparam(struct net_device *ndev,
 			       struct ethtool_ringparam *ering,
@@ -2636,13 +2688,9 @@ static void axienet_mac_link_down(struct phylink_config *config,
 	/* nothing meaningful to do */
 }
 
-static void axienet_mac_link_up(struct phylink_config *config,
-				struct phy_device *phy,
-				unsigned int mode, phy_interface_t interface,
-				int speed, int duplex,
-				bool tx_pause, bool rx_pause)
+static void axienet_1g_mac_link_up(struct net_device *ndev, int speed,
+				   bool tx_pause, bool rx_pause)
 {
-	struct net_device *ndev = to_net_dev(config->dev);
 	struct axienet_local *lp = netdev_priv(ndev);
 	u32 emmc_reg, fcc_reg;
 
@@ -2679,6 +2727,19 @@ static void axienet_mac_link_up(struct phylink_config *config,
 	axienet_iow(lp, XAE_FCC_OFFSET, fcc_reg);
 }
 
+static void axienet_mac_link_up(struct phylink_config *config,
+				struct phy_device *phy,
+				unsigned int mode, phy_interface_t interface,
+				int speed, int duplex,
+				bool tx_pause, bool rx_pause)
+{
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct axienet_local *lp = netdev_priv(ndev);
+
+	if (lp->axienet_config->mac_link_up)
+		lp->axienet_config->mac_link_up(ndev, speed, tx_pause, rx_pause);
+}
+
 static const struct phylink_mac_ops axienet_phylink_ops = {
 	.mac_select_pcs = axienet_mac_select_pcs,
 	.mac_config = axienet_mac_config,
@@ -2696,7 +2757,6 @@ static const struct phylink_mac_ops axienet_phylink_ops = {
 static void axienet_dma_err_handler(struct work_struct *work)
 {
 	u32 i;
-	u32 axienet_status;
 	struct axidma_bd *cur_p;
 	struct axienet_local *lp = container_of(work, struct axienet_local,
 						dma_err_task);
@@ -2709,8 +2769,8 @@ static void axienet_dma_err_handler(struct work_struct *work)
 	napi_disable(&lp->napi_tx);
 	napi_disable(&lp->napi_rx);
 
-	axienet_setoptions(ndev, lp->options &
-			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
+	lp->axienet_config->setoptions(ndev, lp->options &
+				       ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 
 	axienet_dma_stop(lp);
 	netdev_reset_queue(ndev);
@@ -2755,29 +2815,114 @@ static void axienet_dma_err_handler(struct work_struct *work)
 
 	axienet_dma_start(lp);
 
-	axienet_status = axienet_ior(lp, XAE_RCW1_OFFSET);
-	axienet_status &= ~XAE_RCW1_RX_MASK;
-	axienet_iow(lp, XAE_RCW1_OFFSET, axienet_status);
-
-	axienet_status = axienet_ior(lp, XAE_IP_OFFSET);
-	if (axienet_status & XAE_INT_RXRJECT_MASK)
-		axienet_iow(lp, XAE_IS_OFFSET, XAE_INT_RXRJECT_MASK);
-	axienet_iow(lp, XAE_IE_OFFSET, lp->eth_irq > 0 ?
-		    XAE_INT_RECV_ERROR_MASK : 0);
-	axienet_iow(lp, XAE_FCC_OFFSET, XAE_FCC_FCRX_MASK);
+	lp->axienet_config->mac_init(ndev);
 
 	/* Sync default options with HW but leave receiver and
 	 * transmitter disabled.
 	 */
-	axienet_setoptions(ndev, lp->options &
-			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
+	lp->axienet_config->setoptions(ndev, lp->options &
+				       ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 	axienet_set_mac_address(ndev, NULL);
 	axienet_set_multicast_list(ndev);
 	napi_enable(&lp->napi_rx);
 	napi_enable(&lp->napi_tx);
-	axienet_setoptions(ndev, lp->options);
+	lp->axienet_config->setoptions(ndev, lp->options);
+}
+
+/**
+ * axienet_1g_phylink_set_caps - Set 1G phylink capabilities and interfaces
+ * @lp:		Pointer to the axienet_local structure
+ * @config:	Pointer to the phylink_config structure
+ */
+static void axienet_1g_phylink_set_caps(struct axienet_local *lp,
+					struct phylink_config *config)
+{
+	config->mac_capabilities |= MAC_10FD | MAC_100FD | MAC_1000FD;
+	__set_bit(lp->phy_mode, config->supported_interfaces);
+	if (lp->switch_x_sgmii) {
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+	}
+}
+
+/**
+ * axienet_1g_clk_init - Get and enable the 1G MAC clocks
+ * @lp:		Pointer to the axienet_local structure
+ *
+ * Return: 0 on success or a negative error number otherwise.
+ */
+static int axienet_1g_clk_init(struct axienet_local *lp)
+{
+	struct device *dev = lp->dev;
+	int ret;
+
+	lp->axi_clk = devm_clk_get_optional_enabled(dev, "s_axi_lite_clk");
+	if (!lp->axi_clk) {
+		/* For backward compatibility, if named AXI clock is not
+		 * present, treat the first clock specified as the AXI clock.
+		 */
+		lp->axi_clk = devm_clk_get_optional_enabled(dev, NULL);
+	}
+	if (IS_ERR(lp->axi_clk))
+		return dev_err_probe(dev, PTR_ERR(lp->axi_clk),
+				     "could not get AXI clock\n");
+
+	lp->misc_clks[0].id = "axis_clk";
+	lp->misc_clks[1].id = "ref_clk";
+	lp->misc_clks[2].id = "mgt_clk";
+
+	ret = devm_clk_bulk_get_optional_enable(dev, XAE_NUM_MISC_CLOCKS,
+						lp->misc_clks);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "could not get/enable misc. clocks\n");
+
+	return 0;
 }
 
+/**
+ * axienet_1g_probe_init - 1G MAC-specific probe-time initialization
+ * @lp:		Pointer to the axienet_local structure
+ */
+static void axienet_1g_probe_init(struct axienet_local *lp)
+{
+	if (axienet_ior(lp, XAE_ABILITY_OFFSET) & XAE_ABILITY_STATS)
+		lp->features |= XAE_FEATURE_STATS;
+}
+
+static const struct axienet_config axienet_1g_config = {
+	.mdio = true,
+	.mac_irq = true,
+	.non_dmaengine = true,
+	.uc_filter = true,
+	.mc_filter = true,
+	.vlan = true,
+	.jumbo = true,
+	.tx_csum = true,
+	.regs_n = AXIENET_REGS_N,
+	.clk_init = axienet_1g_clk_init,
+	.setoptions = axienet_setoptions,
+	.probe_init = axienet_1g_probe_init,
+	.mac_init = axienet_1g_mac_init,
+	.mac_link_up = axienet_1g_mac_link_up,
+	.get_regs = axienet_1g_get_regs,
+	.phylink_set_caps = axienet_1g_phylink_set_caps,
+	.pcs_ops = &axienet_pcs_ops,
+	.stats_update = axienet_1g_stats_update,
+};
+
+/* Match table for of_platform binding */
+static const struct of_device_id axienet_of_match[] = {
+	{ .compatible = "xlnx,axi-ethernet-1.00.a", .data = &axienet_1g_config },
+	{ .compatible = "xlnx,axi-ethernet-1.01.a", .data = &axienet_1g_config },
+	{ .compatible = "xlnx,axi-ethernet-2.01.a", .data = &axienet_1g_config },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, axienet_of_match);
+
 /**
  * axienet_probe - Axi Ethernet probe function.
  * @pdev:	Pointer to platform device structure.
@@ -2828,27 +2973,13 @@ static int axienet_probe(struct platform_device *pdev)
 	seqcount_mutex_init(&lp->hw_stats_seqcount, &lp->stats_lock);
 	INIT_DEFERRABLE_WORK(&lp->stats_work, axienet_refresh_stats);
 
-	lp->axi_clk = devm_clk_get_optional_enabled(&pdev->dev,
-						    "s_axi_lite_clk");
-	if (!lp->axi_clk) {
-		/* For backward compatibility, if named AXI clock is not present,
-		 * treat the first clock specified as the AXI clock.
-		 */
-		lp->axi_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
-	}
-	if (IS_ERR(lp->axi_clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(lp->axi_clk),
-				     "could not get AXI clock\n");
-
-	lp->misc_clks[0].id = "axis_clk";
-	lp->misc_clks[1].id = "ref_clk";
-	lp->misc_clks[2].id = "mgt_clk";
+	lp->axienet_config = device_get_match_data(&pdev->dev);
+	if (!lp->axienet_config)
+		return -ENODEV;
 
-	ret = devm_clk_bulk_get_optional_enable(&pdev->dev, XAE_NUM_MISC_CLOCKS,
-						lp->misc_clks);
+	ret = lp->axienet_config->clk_init(lp);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "could not get/enable misc. clocks\n");
+		return ret;
 
 	/* Map device registers */
 	lp->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &ethres);
@@ -2859,11 +2990,12 @@ static int axienet_probe(struct platform_device *pdev)
 	/* Setup checksum offload, but default to off if not specified */
 	lp->features = 0;
 
-	if (axienet_ior(lp, XAE_ABILITY_OFFSET) & XAE_ABILITY_STATS)
-		lp->features |= XAE_FEATURE_STATS;
-
+	/* Only honour the TX checksum offload property on MACs whose DMA path
+	 * can complete checksums. Otherwise the stack would hand down partial
+	 * checksums that the hardware never finishes.
+	 */
 	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,txcsum", &value);
-	if (!ret) {
+	if (!ret && lp->axienet_config->tx_csum) {
 		switch (value) {
 		case 1:
 			lp->features |= XAE_FEATURE_PARTIAL_TX_CSUM;
@@ -2939,7 +3071,17 @@ static int axienet_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (lp->axienet_config->probe_init)
+		lp->axienet_config->probe_init(lp);
+
 	if (!of_property_present(pdev->dev.of_node, "dmas")) {
+		/* Non-dmaengine mode is only supported by some MACs */
+		if (!lp->axienet_config->non_dmaengine) {
+			dev_err(&pdev->dev,
+				"Non-dmaengine mode not supported by this MAC, use dmaengine\n");
+			return -EINVAL;
+		}
+
 		/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
 		np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
 
@@ -3025,7 +3167,10 @@ static int axienet_probe(struct platform_device *pdev)
 		struct xilinx_vdma_config cfg;
 		struct dma_chan *tx_chan;
 
-		lp->eth_irq = platform_get_irq_optional(pdev, 0);
+		if (lp->axienet_config->mac_irq)
+			lp->eth_irq = platform_get_irq_optional(pdev, 0);
+		else
+			lp->eth_irq = -ENXIO;
 		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO) {
 			return lp->eth_irq;
 		}
@@ -3078,10 +3223,12 @@ static int axienet_probe(struct platform_device *pdev)
 	lp->tx_dma_cr = axienet_calc_cr(lp, XAXIDMA_DFT_TX_THRESHOLD,
 					XAXIDMA_DFT_TX_USEC);
 
-	ret = axienet_mdio_setup(lp);
-	if (ret)
-		dev_warn(&pdev->dev,
-			 "error registering MDIO bus: %d\n", ret);
+	if (lp->axienet_config->mdio) {
+		ret = axienet_mdio_setup(lp);
+		if (ret)
+			dev_warn(&pdev->dev,
+				 "error registering MDIO bus: %d\n", ret);
+	}
 
 	if (lp->phy_mode == PHY_INTERFACE_MODE_SGMII ||
 	    lp->phy_mode == PHY_INTERFACE_MODE_1000BASEX) {
@@ -3105,23 +3252,21 @@ static int axienet_probe(struct platform_device *pdev)
 			goto cleanup_mdio;
 		}
 		of_node_put(np);
-		lp->pcs.ops = &axienet_pcs_ops;
+		lp->pcs.ops = lp->axienet_config->pcs_ops;
+		lp->pcs.poll = true;
+	}
+
+	if (lp->axienet_config->internal_pcs) {
+		lp->pcs.ops = lp->axienet_config->pcs_ops;
 		lp->pcs.poll = true;
 	}
 
 	lp->phylink_config.dev = &ndev->dev;
 	lp->phylink_config.type = PHYLINK_NETDEV;
 	lp->phylink_config.mac_managed_pm = true;
-	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
-		MAC_10FD | MAC_100FD | MAC_1000FD;
+	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
 
-	__set_bit(lp->phy_mode, lp->phylink_config.supported_interfaces);
-	if (lp->switch_x_sgmii) {
-		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-			  lp->phylink_config.supported_interfaces);
-		__set_bit(PHY_INTERFACE_MODE_SGMII,
-			  lp->phylink_config.supported_interfaces);
-	}
+	lp->axienet_config->phylink_set_caps(lp, &lp->phylink_config);
 
 	lp->phylink = phylink_create(&lp->phylink_config, pdev->dev.fwnode,
 				     lp->phy_mode,
@@ -3164,7 +3309,8 @@ static void axienet_remove(struct platform_device *pdev)
 	if (lp->pcs_phy)
 		put_device(&lp->pcs_phy->dev);
 
-	axienet_mdio_teardown(lp);
+	if (lp->mii_bus)
+		axienet_mdio_teardown(lp);
 }
 
 static void axienet_shutdown(struct platform_device *pdev)
-- 
2.25.1

