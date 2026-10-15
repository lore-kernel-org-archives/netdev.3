Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06C3D9DB1;
	Thu, 15 Oct 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076582; cv=fail; b=Gh+REElz4jHoWJme3RR/p/YM1Hf5wwoPCDy9/ymTbdekUT/mHVJpXno4rLxgnu/wEbRFawK7ZatO1ZUIRHtl3Vz7LCAW9RRvLq+9pGGUXQ2O7lXAWOqV5t71C9rD6MqqAQkHEnwpced/UFQAZpcVoEPUJ8lKRa4KfhrOQYMW1gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076582; c=relaxed/simple;
	bh=fiaR3rkfQ8nNe2YxaIWZDqJdAm866djBjHFGIfhxqkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reovfmEOuc1mGfImoGCwEfFFX1wQCJXShUyIJ7vipBIb/5NcDAKMq4KNZC2rm6UpVyRM+k5MUvRqUles9dGM/XwVfp/CCdGKFk4orkCHX8LFM1763JAYg9eiZnc4XditqPKghalqsVSDueh7zqqjzTOa7yC/s9uc0LJm4+WKJi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JgmO9Nzs; arc=fail smtp.client-ip=52.101.57.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JgmO9Nzs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+d5I8//GfqES7J+Uue3eCrOJZZv5wkG7kQgkyop7zcsTZC194xn2vOlmE6Kh6N4Nd3+ev3VUyC4c5YcVUQjkSg45ZQquPQjGThqJ2F9+5jee9CEK0r7K5UJAtWsNfDE+MXU7jA9cIbqF3PoZ2/R2R5/xujOsiZvH4vFcM6U9kgC4OeaYIVv+O2cerfkB+CVspHcgC7/gg9xBE+5jYpTWkP9namXJ5kPJlUlrfpAzgNhMjxCvxLdI7GW+as1ykgC7rT5Y5gcT8jILMyz1gfm9JDEfYGeLlSNYTMdRIddoe2EcpcbETOLz4fp35b+NjlH1WS6ICxrEskdJLPAyW6KlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb9ZTlfndwYrtf3psGbWEiN/g61lOgMiTo8R4QUSWaI=;
 b=mhXIr6x0c/WKz6RuwRwsj8soNNbh/cn0FejsZGZE1y5Qgt/54agTAAsssRJf3Y38P4MnbjKi4J5NSuXdYlxmUXJd7Rm5uzWdqORDYNsNPjJzwSCXxobiIJ6n2vidV7ntSB3+5LlZha1R76AiLyvc/VzxGgyxmtIV0XJCu/BbfYGHQubVVK8b48gZzqkVfT+LcoonRJCba71t7FM3glkfTy5M0zeFiNkEa8pWoUBm1H/EcK9kqei+lCvKtsb1F+j4sdnMCJH5C/AEdpKSHumDNzjBIIEhtYp5Zi9FxhOPrHbiDjNCqmOq5BclxUjVMzkV2tJ3Ob5rl1GhqdSykbTbYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb9ZTlfndwYrtf3psGbWEiN/g61lOgMiTo8R4QUSWaI=;
 b=JgmO9NzsaA+l2HxArh+FU7Y5WmcqYLdfYhPIifegizgH9i62HVoO186HQVKPzU7Vsrw24s4U0STkqgRHLQC97YhsWzODioQy+lkQ5xUGx9G7VhOTDIY/XD2sNcj6/BrIkR+ZUWUOWriYfBClZtzMijtNMxn6WiK0NDNCUo1gWITohskUCXG457jaaPIvtZVlnpSZRdWl4SKxil079I/4rpXlhbDdCgTTCtxSDURuu8z5wVbCvOqVp+Cy5W0qULaIxDVd9dM2+WWCo09/UywBCQjYz/NF7pg+LIXTOy/VW1d+oLvn4lXu1c29OY6YuSwK7DuMYfjao6vjWlllMkQKxg==
Received: from CY5PR15CA0181.namprd15.prod.outlook.com (2603:10b6:930:81::16)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 15:02:44 +0000
Received: from CY7PEPF000000F4.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::8a) by CY5PR15CA0181.outlook.office365.com
 (2603:10b6:930:81::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 15 Oct 2026 15:02:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY7PEPF000000F4.mail.protection.outlook.com (10.167.247.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 15:02:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:02:13 -0700
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:02:11 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>
CC: <maxime.chevallier@bootlin.com>, <Raju.Lakkaraju@microchip.com>,
	<cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH net-next v1 2/5] net: lan743x: start phylink last and stop it first
Date: Thu, 15 Oct 2026 11:00:41 -0400
Message-ID: <84c495b24206953fb799d4070c4d99ff27efb829.1792008404.git.cbabroski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F4:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c65f6a-d2c6-475a-b419-08df2acd5dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|921020|261009223027099003|5023799004|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r7bWmJQLW3MXbM+2i4+BtuZKl1sk7INjuZfG2yGBGeGY5ApsFrk2nauwfxd11FZc4HJ2P1dGmoGk7OHcGEe/6H72wB64Cx9jeSQMHLQE6AzEHLGz22bYqnhSN+RhFrRPrZWxoIF8XvEomgFwBw9UqO93ygKDP9TRJ+V1aawHtGHXIArR7y+M5lAZi1YTnbxFFtIeGTQzB+zi8EqZaxHyPBKfKQJtiUKyyS6G6r+jeneenkx9qGV8D3JCNF42sVOqQtYwVU07g8/sxftMFKpVNMyXFc/h4y/pjtCBsx1iv21cPztYWFsCENLKigRr2UcPIEMpamY6El8NPPQt6rUXSjFd9Gd2l8d9yLj/CT0oUcoiE2nU/I5RLTAel7R1wx09rkZkWrddtoAnj9QwCOfRv3MN5Pja1z++Ek83c6gUGJUTxgiHeNDQlohsU+UY7YiumHwUb0W7/N/X7l4kQQQVkZkVObZwG8uzbdifmYW2iONxlmJE9ERRC5GThlhAxVYXmXCoGuAVL+P9Rvzvq6WW4Vfb1dpvgwUQ+ZG5G8sSb/eIsfK/twiGMBWFZb/KYzBZ0w+mmUWhlskdnVd9FuvW+FMEh4puzjhTcBvXDyaIuBqBDtHd3PAdyNXcLmqnf5JFLR8mGQJZ+CM2RLhyEo20RPih047dGgIPlG5dOI8a5BkYkMyfaWpTh8Dp5JqKw/8L3154oKfL+GIZOGp1L1aKYsiWwQ4wNsmVlJvF82P4CGhPyRPBnZHQzJn+qccMbcOP
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(921020)(261009223027099003)(5023799004)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V1MvY0OLwvXaukv/pxVIoQyY6A/6GA6Wq9fdCSl6sTPT5dQ7gqlxj2BFfXityo1zhSU/E3SHHhamlVpICXyW31gmlzjeolocdTG4xULBfK+hrsZ1PrVnryH508i/JyPQrq7/hHaewtJ/SNjOey2j4b/I2TH1biOlnPk7rlILniGlvSFHl5unUpKGBmxBMpwxltqrLF3UDDtt/hXr+k2ZFH8j10ofaxGR3At2mjJV8lqBV3+hwSq55TfJpYX8nlqP8TAxrojSuCQ/7wCa9tykK6Fd3FL4q2m0129rbfcZ1rBa0buP5Gix0ZA5OfRbUCQJjhDlg1CctQWrH4acqp8+FJNV1DOJYQ2AoHWvi0TA+wOb6gxU3BjlgWJTOsjUq+MxEJB8y16apadb5Sxv3Hk0RXOVbfjndyZragpEpFlPwt1rS6xQzeWCljOBx49vCjxt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:02:43.8311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c65f6a-d2c6-475a-b419-08df2acd5dc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200

lan743x_netdev_open() starts phylink before the RX and TX rings exist,
and lan743x_netdev_close() only stops it after the rings are freed. The
mac_link_up() callback wakes all TX queues, so it can run while there is
no TX ring to transmit on.

For ndo_open and ndo_stop the qdisc is not active at that point, but the
suspend and resume paths call lan743x_netdev_close() and
lan743x_netdev_open() directly with the qdisc still attached. A link up
event in either window lets the stack call ndo_start_xmit() on a channel
whose ring is not allocated yet or has just been freed.

The error path of lan743x_netdev_open() is also wrong: a
lan743x_ptp_open() failure jumps past lan743x_phylink_disconnect(),
leaving phylink started and the PHY attached after open has failed.
Every later open then fails because the PHY is already attached.

Connect and start phylink as the last step of open and stop it as the
first step of close, as other phylink users do. If phylink fails to
connect, nothing is attached, so the error path only needs to unwind the
rings, PTP, MAC and interrupts.

Fixes: a5f199a8d8a0 ("net: lan743x: Migrate phylib to phylink")
Assisted-by: LLM
Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 9e1276cf313c..583f631df701 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3334,6 +3334,8 @@ static int lan743x_netdev_close(struct net_device *netdev)
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 	int index;
 
+	lan743x_phylink_disconnect(adapter);
+
 	for (index = 0; index < adapter->used_tx_channels; index++)
 		lan743x_tx_close(&adapter->tx[index]);
 
@@ -3342,8 +3344,6 @@ static int lan743x_netdev_close(struct net_device *netdev)
 
 	lan743x_ptp_close(adapter);
 
-	lan743x_phylink_disconnect(adapter);
-
 	lan743x_mac_close(adapter);
 
 	lan743x_intr_close(adapter);
@@ -3365,10 +3365,6 @@ static int lan743x_netdev_open(struct net_device *netdev)
 	if (ret)
 		goto close_intr;
 
-	ret = lan743x_phylink_connect(adapter);
-	if (ret)
-		goto close_mac;
-
 	ret = lan743x_ptp_open(adapter);
 	if (ret)
 		goto close_mac;
@@ -3387,6 +3383,10 @@ static int lan743x_netdev_open(struct net_device *netdev)
 			goto close_tx;
 	}
 
+	ret = lan743x_phylink_connect(adapter);
+	if (ret)
+		goto close_tx;
+
 	if (netdev->phydev)
 		phy_support_eee(netdev->phydev);
 
@@ -3414,8 +3414,6 @@ static int lan743x_netdev_open(struct net_device *netdev)
 			lan743x_rx_close(&adapter->rx[index]);
 	}
 	lan743x_ptp_close(adapter);
-	if (adapter->phylink)
-		lan743x_phylink_disconnect(adapter);
 
 close_mac:
 	lan743x_mac_close(adapter);
-- 
2.34.1

