Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5364C424D75;
	Mon, 31 Aug 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188925; cv=fail; b=hdUL/HcmPVGn52r1Wcd4NIFO8xVAeFAEF+60ZVpJeC/zsjOsZO6TCxVO065TINKETrqv/FSg5LUxnlIvUwmUY0eJ+TC8HSfcBckbE4yXEDLEuzBWuT7sdogj086+bXWBMDvMFc3ioSOtn64bfjTLj6MVHETnsg53L4NwFF7iAfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188925; c=relaxed/simple;
	bh=NZXG35c8H5uRRWe4b1J5BA/X1XXitzy9kjdj3ZE+W3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mB5wpvwuUM11SZ9CD0ew7WChKygUhpSpdhmrxfFBhwO530BdIxVyBnqUEKt3A2Z+/vwxNTyMhXD8x+nfapFe20pbtIDUQ9TQXXzAbr5ds9S7NzbzqlgL3dzJxiMttiSgB066LHJDM6wdRsaYr0K/EuMTvOienbvCIeilXiLPAPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lKYwXRYS; arc=fail smtp.client-ip=40.107.208.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lKYwXRYS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQ5i/BKky3RZX+yIt2y7SvFTCw0ZvxrYoJ9+hw30ZJLmqUQNngoB1F4B2W2y989eAThMpqYqHm80zC1t1JZQlt8h4JxxHmWxcqJ8iE0XXvhDQgmQsq4vIY+1ZKSYx4Pr8Zm7NUApGmogzXyQJGcctIMwlOeU5zxtvH+D9Yt6c0M+l4Dw2WlW4T8ZUG8+Gu2yPVJdr4LmvQe5SoJ3DBEzyQVm1lnuP+FGNAz/goVMV/cbAG5xzcDhRqljAgPS8fr9HTxCLUCiHpuzc83dzPIEx4Adss155l/eHtxOlWL7HfzxDvX6j9esnlQJDPCaH1ilHk+aCruIJLNPAqviZc3PqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT55Hvmm2/JZAOAZlYrRj07fOuazW0zYIN28WEzCJmA=;
 b=StBvoh2xlDeKax8Tq4EL7AAC7b37Uqzo1AOhiHC+s214eVc/8FyFtA6b1kDTTZZ13UpA+9ihhStObWSkcl0iy8rWYRUBnU6Gr5Mhf1uatLbRTvLPv4v6NtR34G0MNlVEFgsZNH9r3e0/VYK+kQ66TWnt2krmF2JZVZpoqq+vekY29hOi4B3DcgtmOVI17W53wZLk9aldG+vcp75IxQcTm6VkOzYtwMRvEa+KUUdtMyUyp+n0HBrW/Zsn1ztUyNm6E4PQt70at7sq8ycbJbQa4Co4HL4weGnZ/gn0Tbs85wdN4nug4DsgqBHpPhShXhXz+amTsnOGCTT+w38DUZd0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT55Hvmm2/JZAOAZlYrRj07fOuazW0zYIN28WEzCJmA=;
 b=lKYwXRYSyRAhLRpfGYm7I2SOmpLc9v8mizqIlfs93NjVjKLkj64WIIo3mBtwqjH/xvt4dhkSbgS7GS2h2xOcJuSgItbl4bZhRDBj1alq5/p2qHBg4WV6MuBQq2U9DQwCMqBvlqCOwDADcgzEC1+UmiA50CiJ7pOwQIcXPq3q2Mk=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:08:27 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::4) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 15:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 15:08:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 10:08:25 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 10:08:21 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH net-next v3 1/6] net: xilinx: axienet: Introduce axienet_config for MAC-specific ops
Date: Mon, 31 Aug 2026 20:38:11 +0530
Message-ID: <20260831150816.1020883-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260831150816.1020883-1-suraj.gupta2@amd.com>
References: <20260831150816.1020883-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|DS7PR12MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b6c8e4-3c21-4e49-1e66-08df0771b556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|7416014|376014|1800799024|921020|6133799003|10063799003|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9jcJ+1rcV4AG9M1qt0iefMN6qdWBWY8XxE+fhiQW15cT3TWYyI2pQPlAsQStSnCpzC1osNTBPr2L9Br0UjI7YmeVe/kIm6N0UZDxysgwgqoaA88B2OVBTfQGG5has1kOsYnf9LBgYp1agyzg2YjP8H5lb5gpyBzRrvycp+dbDqPXCaGvatDZbbse4W9cl2tDOgcF7kueyUdUMOqvDLRUK6b4NtGNcwNP6Z7dSM4/sgS4PaZBFEWwhdw8jqqONbBqw5Zs5qXJh8gWEKqw/Mh6bSgS06+Ru7sZU0wjxHR2Yl3TlsPFkaSEbRbMwOm8vjdoDTaCWDcJhKgr7qJYUv0MuwxZW1X6IwiFDrgWm4oLctakrxwsKboFjiHWDLeornCgNh1lwtZhWqxo+t7S7b2srFKnlOHq1IT5siAa8qxFl+Hxw9706Kfc7YqmPG+jj/b/zVnXLN5XD1zeFZM0ehmsTjJITF5p4v8wEg9my1YPlGpT7s6rgFm4SwJU7TGqnR1eXZcfSNQBxbpBfJRDLw6vwSHIGWM1lC7/Pw0pOXreQZ3T6fO54mLBwnuxLnVP7of2Oi64NI9giYqGSzNPmEWmgvYM10XjXl7MHlEazPpFD0+Oy8X3riANHyzjfBjzO9xZf0fITCvlD4mLWXakXfgA5AeheD5vxY3f/v5TI/ejn7L35HBZCpLQV8DmOKNzq8EZ+F4n/sP+RCPmobjhI8fbJG8qOqAtQqunUSr4msEIyBvP6eXmeKglg9Ct0pbwCTi7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(7416014)(376014)(1800799024)(921020)(6133799003)(10063799003)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SdhX2bz9BXp81MxTqvW5Ywjz/oQEy8ukYZM0SACEt7rGLC2gW5rhMZ1Fh0Fey5mXfnmB8dcGVmOGS+K7YKW6TsODuvgTzRoH4NBlDrgFjDAwCrkQy9xBuzD/F1+BMTIpdYh9Z5PFkY0zCrd6oZdQA4r61PQBiaun+mOVeiGfHWdshyW9WsksEwqWb7+ab3yGw5jjJIqXjwEJrDqB9n5zXBr60at4RvyaR/XvSv1tMXpUMNeVGmxqhI9cCMUdYhkHQIK3MSm6Q3eszrWZ/PKXOzvlaIQ15gNQ8GW+h2DTgNj8REDHIuSxEmI6H+GWVjZ0XdaeuY+nG5NTTKsVKNotJtuRaseyQfpEzuSxHArlEiVq6rKL+4KgA6cy8EVviN/6j9nzjEnvn7z4//30Sb5Y0B6ZAcIuo5MDMXg6xyqTVlNrnUJN24S6Ip8r69OFjAuD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:08:26.4197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b6c8e4-3c21-4e49-1e66-08df0771b556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552

Introduce an axienet_config structure to abstract MAC-type-specific
operations, preparing the driver for supporting additional MAC types
beyond the existing 1G Ethernet.

Add axienet_config with capability flags (mdio, mac_irq, legacy_dma,
uc_filter, mc_filter, vlan, jumbo, dma_tx_csum, sw_padding, internal_pcs),
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
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 391 ++++++++++++------
 2 files changed, 319 insertions(+), 124 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index fcd3aaef27fc..40f03c9eb382 100644
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
+ * @legacy_dma: MAC supports the legacy (non-dmaengine) DMA mode
+ * @uc_filter: MAC has unicast address filter registers
+ * @mc_filter: MAC has multicast address filter registers
+ * @vlan: MAC supports VLAN frames by default
+ * @jumbo: MAC supports jumbo frames
+ * @dma_tx_csum: MAC supports TX checksum offload
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
+	bool legacy_dma;
+	bool uc_filter;
+	bool mc_filter;
+	bool vlan;
+	bool jumbo;
+	bool dma_tx_csum;
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
index 67d1b8e91d68..5c59423bd778 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -33,6 +33,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/skbuff.h>
 #include <linux/math64.h>
 #include <linux/phy.h>
@@ -64,16 +65,6 @@
 
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
@@ -418,6 +409,9 @@ static void axienet_set_mac_address(struct net_device *ndev,
 	if (!is_valid_ether_addr(ndev->dev_addr))
 		eth_hw_addr_random(ndev);
 
+	if (!lp->axienet_config->uc_filter)
+		return;
+
 	/* Set up unicast MAC address filter set its mac address */
 	axienet_iow(lp, XAE_UAW0_OFFSET,
 		    (ndev->dev_addr[0]) |
@@ -467,6 +461,9 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 	u32 reg, af0reg, af1reg;
 	struct axienet_local *lp = netdev_priv(ndev);
 
+	if (!lp->axienet_config->mc_filter)
+		return;
+
 	reg = axienet_ior(lp, XAE_FMI_OFFSET);
 	reg &= ~XAE_FMI_PM_MASK;
 	if (ndev->flags & IFF_PROMISC)
@@ -575,14 +572,25 @@ static void axienet_stats_update(struct axienet_local *lp, bool reset)
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
@@ -693,6 +701,32 @@ static void axienet_dma_stop(struct axienet_local *lp)
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
@@ -708,19 +742,23 @@ static void axienet_dma_stop(struct axienet_local *lp)
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
 
@@ -737,26 +775,18 @@ static int axienet_device_reset(struct net_device *ndev)
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
 
@@ -914,6 +944,13 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
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
@@ -938,19 +975,21 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
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
+	if (lp->axienet_config->dma_tx_csum) {
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
@@ -1738,8 +1777,8 @@ static int axienet_stop(struct net_device *ndev)
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
 
-	axienet_setoptions(ndev, lp->options &
-			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
+	lp->axienet_config->setoptions(ndev, lp->options &
+				       ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 
 	if (!lp->use_dmaengine) {
 		axienet_dma_stop(lp);
@@ -1765,7 +1804,8 @@ static int axienet_stop(struct net_device *ndev)
 	}
 
 	netdev_reset_queue(ndev);
-	axienet_iow(lp, XAE_IE_OFFSET, 0);
+	if (lp->axienet_config->mac_irq)
+		axienet_iow(lp, XAE_IE_OFFSET, 0);
 
 	if (lp->eth_irq > 0)
 		free_irq(lp->eth_irq, ndev);
@@ -1934,30 +1974,18 @@ static void axienet_ethtools_get_drvinfo(struct net_device *ndev,
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
@@ -1998,6 +2026,31 @@ static void axienet_ethtools_get_regs(struct net_device *ndev,
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
@@ -2634,13 +2687,9 @@ static void axienet_mac_link_down(struct phylink_config *config,
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
 
@@ -2677,6 +2726,19 @@ static void axienet_mac_link_up(struct phylink_config *config,
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
@@ -2694,7 +2756,6 @@ static const struct phylink_mac_ops axienet_phylink_ops = {
 static void axienet_dma_err_handler(struct work_struct *work)
 {
 	u32 i;
-	u32 axienet_status;
 	struct axidma_bd *cur_p;
 	struct axienet_local *lp = container_of(work, struct axienet_local,
 						dma_err_task);
@@ -2707,8 +2768,8 @@ static void axienet_dma_err_handler(struct work_struct *work)
 	napi_disable(&lp->napi_tx);
 	napi_disable(&lp->napi_rx);
 
-	axienet_setoptions(ndev, lp->options &
-			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
+	lp->axienet_config->setoptions(ndev, lp->options &
+				       ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 
 	axienet_dma_stop(lp);
 	netdev_reset_queue(ndev);
@@ -2753,29 +2814,114 @@ static void axienet_dma_err_handler(struct work_struct *work)
 
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
 }
 
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
+}
+
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
+	.legacy_dma = true,
+	.uc_filter = true,
+	.mc_filter = true,
+	.vlan = true,
+	.jumbo = true,
+	.dma_tx_csum = true,
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
@@ -2826,27 +2972,13 @@ static int axienet_probe(struct platform_device *pdev)
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
+	lp->axienet_config = device_get_match_data(&pdev->dev);
+	if (!lp->axienet_config)
+		return -ENODEV;
 
-	lp->misc_clks[0].id = "axis_clk";
-	lp->misc_clks[1].id = "ref_clk";
-	lp->misc_clks[2].id = "mgt_clk";
-
-	ret = devm_clk_bulk_get_optional_enable(&pdev->dev, XAE_NUM_MISC_CLOCKS,
-						lp->misc_clks);
+	ret = lp->axienet_config->clk_init(lp);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "could not get/enable misc. clocks\n");
+		return ret;
 
 	/* Map device registers */
 	lp->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &ethres);
@@ -2857,9 +2989,6 @@ static int axienet_probe(struct platform_device *pdev)
 	/* Setup checksum offload, but default to off if not specified */
 	lp->features = 0;
 
-	if (axienet_ior(lp, XAE_ABILITY_OFFSET) & XAE_ABILITY_STATS)
-		lp->features |= XAE_FEATURE_STATS;
-
 	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,txcsum", &value);
 	if (!ret) {
 		switch (value) {
@@ -2933,7 +3062,17 @@ static int axienet_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (lp->axienet_config->probe_init)
+		lp->axienet_config->probe_init(lp);
+
 	if (!of_property_present(pdev->dev.of_node, "dmas")) {
+		/* Non-dmaengine (legacy DMA) mode is only supported by some MACs */
+		if (!lp->axienet_config->legacy_dma) {
+			dev_err(&pdev->dev,
+				"Legacy DMA mode not supported by this MAC, use dmaengine\n");
+			return -EINVAL;
+		}
+
 		/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
 		np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
 
@@ -3013,7 +3152,10 @@ static int axienet_probe(struct platform_device *pdev)
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
@@ -3066,10 +3208,12 @@ static int axienet_probe(struct platform_device *pdev)
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
@@ -3093,23 +3237,21 @@ static int axienet_probe(struct platform_device *pdev)
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
@@ -3152,7 +3294,8 @@ static void axienet_remove(struct platform_device *pdev)
 	if (lp->pcs_phy)
 		put_device(&lp->pcs_phy->dev);
 
-	axienet_mdio_teardown(lp);
+	if (lp->mii_bus)
+		axienet_mdio_teardown(lp);
 }
 
 static void axienet_shutdown(struct platform_device *pdev)
-- 
2.25.1

