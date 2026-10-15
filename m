Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCA4A206F;
	Thu, 15 Oct 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076581; cv=fail; b=ghCZlMSnmsnczE3Kvszuj4gB2gm+e4wwxVXPvqXhj+yGkqWJT95Eox5XNUysb2Ujz9Ay/kyg/6xmZSXUv3CfedU2GjQS/KpRZ2g8Ltf23Ra2wYUM+PW6ddu2VUVbWv9BkhyYKDjGmloyjR3Ef8MtH9+3yRdGTZTS12Eh9rAJRtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076581; c=relaxed/simple;
	bh=2hW+QD8bo20tyG7bg3ZFn2quWQlL8jFXyPgiYlUrB9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxMIRVAiSNcvg4RaDjzGs60x6gFGgV5UDFFLJ1OZSDeTbHdCZUPuhVkm6IuBSHM2VjUjq2zUdG5wRp2bbU4/Q9F9+Ceb8jjw+6xHQwn+03OzXlh4oAHiDPsGS6bZ9I/NZorcBWAC+ezzMkPikMxD1il8Yx2uwQy+KMvJuDX9sgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j9FJrmrZ; arc=fail smtp.client-ip=52.101.46.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j9FJrmrZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3LGmmmAYePMQh3iz8DREbYu0wTORSI4UKJ7lT0jRPTrONB+iBEqmEj8Q62aYf1MYgag08scT9DoSGQ1wAJciO4JwxU12t6I7fedqwahxuB4QLp0zVziZm5V3fsoo9kUQKfGJw8ER8jMiyAkwH7Ohz9Hd0fPbOqLTO4eKtBNKv6P+anazkITqdi0JxBG3FmcbJezRekEFzQr57f3VN7OVsZFfG23/uLWw+EjlWE6fRMjupRazYwxobxpvGfxGbcNCDyJz4Ls4vnwCi3YXqV7Eh8ANBKKwolF/fFvMO3Huwss3GWjUc7t1/zlwvVGwCfv6KGm18J8lfzZtobnhsootw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+vvwXkZYeiJaxeS4DurjELi26p2FTxHJw0Tc61Hyc4=;
 b=lUqaf3FwenUC0RglVEbfAb4G+OwsZ6QQAOBLrQ6RA9aew0TTb9RRNaL3slj+qBE9qmEFZ0F85uYZm1rssyS2VFpJRbaBiMbDbJIPvKV2/idhEHy36DOYG273KFFgG31DZXDyArVz2noKUA+IXoLjNAM0d9Xfzza7c1TG8upnkUeNlZzxmgsZGivzLz5FRMAPrQhaZ3t8CUlMIcBzehkTDx/ds0x6euFAabWZZDz6uzLaOqu5iI1h1dOSqAnOMFxfPJRJ1Wx8t92om2eLE52uY/Fw8Ue3+MLh1W/VhC0nJNzI2ps2mMginxENpNzGRgSMTXb/J4VwOQAq2slqQTCG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+vvwXkZYeiJaxeS4DurjELi26p2FTxHJw0Tc61Hyc4=;
 b=j9FJrmrZvpvK12DhcczvGuKfvguhFcLYoI+i0YBSOzBNuzz7qa4FKr1zf9Vi7Bnhiis8r4c+AX6iqmiJvr2iPy4nshovr8JxZT5QZ+rVRscnGrCIBwO7BaTgMd6DLBlReXvlCTTQe8/BF3VanTqmDIb99RB3O/AMTA8vjUhhNmNCIJkwqoO6gLN3jMSBYT0YuGbVpTZhb8221cqUE4RLNkTFU0/UePZgp3XtPU9wE3ev2HJ39HAesA8b8R6O6cQqlQjqqpyIoODbRqD86PzjC33DjwsvYOO4wp9iJ9uO1wrp0V449DrqFEYltiEJPn3IBf6Y2zPhCwHIbrggjgV11w==
Received: from MW4PR04CA0240.namprd04.prod.outlook.com (2603:10b6:303:87::35)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 15:02:45 +0000
Received: from MW1PEPF00018894.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::8b) by MW4PR04CA0240.outlook.office365.com
 (2603:10b6:303:87::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 15:02:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF00018894.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 15:02:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:02:11 -0700
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:02:08 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>
CC: <maxime.chevallier@bootlin.com>, <Raju.Lakkaraju@microchip.com>,
	<cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that fail to stop
Date: Thu, 15 Oct 2026 11:00:40 -0400
Message-ID: <bf487e5d01fe6352069d4314087f680fea717cc5.1792008404.git.cbabroski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00018894:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c26746b-226b-4c5c-883e-08df2acd5d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|56012099006|921020|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mb2yl8P+4xoRAFICGWbcNGiIaVozBWnmv3vVrE5Hi1rNJCwfhecmO6BvfJf5RLHZLDHpZJxeGzRMB9ZI5pnFmAJ3nLjub9kh/2IjkusZNKR7ATfL5bpMcmwgW5ibgjdtAlAJBtGojdo9J5C9NZH4zlq3K2jA9oDWMWrLT14HF8JmPowVMrl1otf2f2zvzdYbJ9aYMvY+G0jCWw+y9ncfiYcCeY2PJKFtrTFWFLbEUDQ9zPi/hvVz3pEu29Cm4N7aqtT9YaiCCi5FsdPr0s5Z6HK7fR/yJk6cImE87ZHASjF9Km/Mp1UPzfRFYdiiZIT0Z0Xf6JnK3rwGJ2c3Nte1Dp1UmtCY6r1vITuG2I83IBk5EdvdERj96lsHfoeie9wTSyN4p5NLsq+5iYjAJ+O3amsExoNSafQ1ZcaOnA4XRrDN2hSHnKdetcVcp2a1jwjf1/wwDT6OysIR/19pAH8FtYQbUhFOpUlS44uowGSxpBMtHpdJc1NwBrXMEjnN2uJlUwn1J+ApYl0hKp7zRzbDQeLISCMeYqzxh/ejup2TRNdTePechNuqb76PyIRuTnud+nhbGyE8eNADPa2F1w7aIesOOK23d23C8TYXIsyFnesvlwM2892rU7BML4vQKt/wOb4pSnUQ4OpdzyxQ6Z0GPPiZJBNQeFB/i+trMv21WVsm0H5hshxGdhnWvhVUr7oNEFUyPNrAuFMpEen7Ruzgeli795pSJeHFFD3dn5Xdy19OjHFIM3+sdah7oEqyE994
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(921020)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Qa3WUW/nAmPHipi+0CW5Pu0luf5z/HFwZW+oweux16KRZ66OVi8j9HI/gNfjUIMcCAplqaxvFVCaLQCsp4riJaPm4eb42vO1+gEjJQuyjzSVC3kwSSLLtj93SqbAT94gdGyfW+AQ5jFKLibYZQQK6CcAgflqUtJdkOnLhkPRK6KKVFcnlmHktFugsut4Rvgq6trFEn+mw20jeaBz5zLokIRDABWJ4J/FunItXzNyAnwBbip1Rw3DV4sK0Uhgh/Gecl1KIksJHogilTeVdwoJIGzxPKR7BoWU+YJ1DKRuVhWq05/7HabTvhvtoBR3pGwGipVpifkvpVx7QAnIP2Q1TjSrfTBvzYogDlcul6paer+a4N09boRadBWF/l1LDf5NmZyA6a+2QWrlhxvEN8AIf4csFXCOX+C0woh9TefZjOw6BkpFqK7i3sYMSy7oj3ee
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:02:43.3635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c26746b-226b-4c5c-883e-08df2acd5d7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00018894.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326

lan743x_tx_close() and lan743x_rx_close() ask the DMA controller to stop
the channel and wait for it, but ignore the result. If the channel is
still stop-pending when the wait gives up, the descriptor ring, the head
write-back buffer and the packet buffers are unmapped and freed while
the channel may still be fetching from or writing to them.

A TX channel has been seen to stop making progress, with its head index
no longer advancing while DMAC_CMD still reports it as started. A
channel in that state may not honour the stop request either, and
closing the interface would then free memory the engine can still
access.

If the channel is still stop-pending after the wait, or still reads as
started, issue a channel soft reset and wait for it before anything is
freed, and log when that happens.

Use the same helpers for the channel resets that lan743x_tx_open() and
lan743x_rx_open() already open-code, and log there too if the reset
times out.

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Assisted-by: LLM
Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 64 +++++++++++++++----
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 82d3ec20ba25..9e1276cf313c 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1584,6 +1584,15 @@ static int lan743x_dmac_tx_wait_till_stopped(struct lan743x_adapter *adapter,
 	return result;
 }
 
+static int lan743x_dmac_tx_reset(struct lan743x_adapter *adapter,
+				 int tx_channel)
+{
+	lan743x_csr_write(adapter, DMAC_CMD, DMAC_CMD_TX_SWR_(tx_channel));
+	return lan743x_csr_wait_for_bit(adapter, DMAC_CMD,
+					DMAC_CMD_TX_SWR_(tx_channel),
+					0, 1000, 20000, 100);
+}
+
 static int lan743x_dmac_rx_get_state(struct lan743x_adapter *adapter,
 				     int rx_channel)
 {
@@ -1613,6 +1622,15 @@ static int lan743x_dmac_rx_wait_till_stopped(struct lan743x_adapter *adapter,
 	return result;
 }
 
+static int lan743x_dmac_rx_reset(struct lan743x_adapter *adapter,
+				 int rx_channel)
+{
+	lan743x_csr_write(adapter, DMAC_CMD, DMAC_CMD_RX_SWR_(rx_channel));
+	return lan743x_csr_wait_for_bit(adapter, DMAC_CMD,
+					DMAC_CMD_RX_SWR_(rx_channel),
+					0, 1000, 20000, 100);
+}
+
 static void lan743x_tx_release_desc(struct lan743x_tx *tx,
 				    int descriptor_index, bool cleanup)
 {
@@ -2221,11 +2239,22 @@ static int lan743x_tx_ring_init(struct lan743x_tx *tx)
 static void lan743x_tx_close(struct lan743x_tx *tx)
 {
 	struct lan743x_adapter *adapter = tx->adapter;
+	int ret;
 
 	lan743x_csr_write(adapter,
 			  DMAC_CMD,
 			  DMAC_CMD_STOP_T_(tx->channel_number));
-	lan743x_dmac_tx_wait_till_stopped(adapter, tx->channel_number);
+	ret = lan743x_dmac_tx_wait_till_stopped(adapter, tx->channel_number);
+	if (ret < 0 || ret == DMAC_CHANNEL_STATE_STARTED) {
+		netdev_warn(adapter->netdev,
+			    "TX channel %d failed to stop, resetting it\n",
+			    tx->channel_number);
+		ret = lan743x_dmac_tx_reset(adapter, tx->channel_number);
+		if (ret)
+			netdev_err(adapter->netdev,
+				   "TX channel %d reset timed out\n",
+				   tx->channel_number);
+	}
 
 	lan743x_csr_write(adapter,
 			  DMAC_INT_EN_CLR,
@@ -2271,11 +2300,11 @@ static int lan743x_tx_open(struct lan743x_tx *tx)
 			  FCT_TX_CTL_EN_(tx->channel_number));
 
 	/* reset tx channel */
-	lan743x_csr_write(adapter, DMAC_CMD,
-			  DMAC_CMD_TX_SWR_(tx->channel_number));
-	lan743x_csr_wait_for_bit(adapter, DMAC_CMD,
-				 DMAC_CMD_TX_SWR_(tx->channel_number),
-				 0, 1000, 20000, 100);
+	ret = lan743x_dmac_tx_reset(adapter, tx->channel_number);
+	if (ret)
+		netdev_err(adapter->netdev,
+			   "TX channel %d reset timed out\n",
+			   tx->channel_number);
 
 	/* Write TX_BASE_ADDR */
 	lan743x_csr_write(adapter,
@@ -2775,6 +2804,7 @@ static int lan743x_rx_ring_init(struct lan743x_rx *rx)
 static void lan743x_rx_close(struct lan743x_rx *rx)
 {
 	struct lan743x_adapter *adapter = rx->adapter;
+	int ret;
 
 	lan743x_csr_write(adapter, FCT_RX_CTL,
 			  FCT_RX_CTL_DIS_(rx->channel_number));
@@ -2784,7 +2814,17 @@ static void lan743x_rx_close(struct lan743x_rx *rx)
 
 	lan743x_csr_write(adapter, DMAC_CMD,
 			  DMAC_CMD_STOP_R_(rx->channel_number));
-	lan743x_dmac_rx_wait_till_stopped(adapter, rx->channel_number);
+	ret = lan743x_dmac_rx_wait_till_stopped(adapter, rx->channel_number);
+	if (ret < 0 || ret == DMAC_CHANNEL_STATE_STARTED) {
+		netdev_warn(adapter->netdev,
+			    "RX channel %d failed to stop, resetting it\n",
+			    rx->channel_number);
+		ret = lan743x_dmac_rx_reset(adapter, rx->channel_number);
+		if (ret)
+			netdev_err(adapter->netdev,
+				   "RX channel %d reset timed out\n",
+				   rx->channel_number);
+	}
 
 	lan743x_csr_write(adapter, DMAC_INT_EN_CLR,
 			  DMAC_INT_BIT_RXFRM_(rx->channel_number));
@@ -2810,11 +2850,11 @@ static int lan743x_rx_open(struct lan743x_rx *rx)
 
 	netif_napi_add(adapter->netdev, &rx->napi, lan743x_rx_napi_poll);
 
-	lan743x_csr_write(adapter, DMAC_CMD,
-			  DMAC_CMD_RX_SWR_(rx->channel_number));
-	lan743x_csr_wait_for_bit(adapter, DMAC_CMD,
-				 DMAC_CMD_RX_SWR_(rx->channel_number),
-				 0, 1000, 20000, 100);
+	ret = lan743x_dmac_rx_reset(adapter, rx->channel_number);
+	if (ret)
+		netdev_err(adapter->netdev,
+			   "RX channel %d reset timed out\n",
+			   rx->channel_number);
 
 	/* set ring base address */
 	lan743x_csr_write(adapter,
-- 
2.34.1

