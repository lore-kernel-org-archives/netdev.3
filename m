Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5C3F9F56;
	Mon, 10 Aug 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374488; cv=fail; b=XMn50ISFfhLqZqLzrsgTcIGeEaBJ+j+T2VHMZpacM7FjM7h5Gn4xjrUSYBuosTx4HIYBl/UNEc6KEC8rJlI3hmsa8kMyGmDr/VXXjhMQWMJ2ulOEg3yE9nf/7JakbKgEM6Z/Br2dd7iOrTqyKMDCAngV141xxJLxN2NeKyeACJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374488; c=relaxed/simple;
	bh=jcwJ0VWDMajwn1a5MRBdIga+XXRoFCNfs4G/sE5KWQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhC8wsxu2dy/3/mZfoVGcKR9o7BONfQ8Xb6ftI7qo+kE9owOW5V2QAPMwp4SEndvWj1nfC9WRAQYG2W0IU3uVN1Z+/FnA5xL+ao26tNxZB7lR86jdcpd3MWwNsPulmALpmxIZd8cWuFaXd5NlECjEO5TkVyGJ/4iSIhGapRlzyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SdkZ59uE; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SdkZ59uE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiAOfzya+HQRIuzeGkJexxww6PLkZ0AH0qAi8Labeh2wrjq0pEL0yJRv0IHdbAAsYGAYFEfLhhvKCJx4ZY+vewT3DP543en3tUdpuC/QkIEvJ0bDy33aXBNlBw7utJuLtcH1Z8agHE3YgbuJkyJ+i/+GBz/LYZ0rNuVt6VHjKsWrLaHDXr4jHGt/ux8iAyTbBvjebPDmC56s8v4th6SyBB6QFZgq7LWtk+j/UNoMBH4h60SX3rGT29iqRM4i447WnY9qyHjMsAhYX4jm0kXdcJRANxOxTcBngixXPRfO3f47clX8flPkH5enJI23o7ACWM6WKVc0+ITZraJQFUEP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHxPiAJVguKbFmSUg19Ymm4D1i17zb9IYHkOCwuT4HA=;
 b=O1RDhl0+ikg1+2Zsrqd28Uh0vXD07pJTA42/8lRTOX1rYFcgubDWAgP/WLnRmX1qH6phmQh+uYiwhlluRxA8LJFPn1HgHrh8zQFKoM5cwpLp7W1ITzctaoFGerqqI4cBJw+Y8qO3dFMAUzoujRR1ppRsHuWsk7K0prGlyfyS/WzK7Vn/w1gDOei6AiDi77Pi/McNG1KFOgEq5S5MbAvhBe04pmt1MdtXCWBMgps1g1eCXNZyaikgRDIVvT8Uc1uxr6UhSjEI836/mLF5Yk8KXR91TNhxxkABsW1PZKHqVUTQSWpkym4NC3zBzoPuOeLdTI5/0u2Kx6+xLmFrUzLKqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHxPiAJVguKbFmSUg19Ymm4D1i17zb9IYHkOCwuT4HA=;
 b=SdkZ59uExlYjGtUkx6i4Pl8JptZpSR6Ozw+1vQstWeAheGmp6IJf4YHBhhRk+VcDTKJ2rDNfAw4sWCu0q/rQsUPoOp8uVexv6iYjnWPy5l/swbGXmw7Zpd+LKtbtcDeFIsdgQiCuJABgo1noSmAijnJS+8QAwdov3StQktNLO+eiBXbZmIuzGC5qC4RK71QPa13HGTBr/hm0VJxWchXqcwYbmYF7G27slaYyTfiO1+KB/fAvKFGDjkSlUoW6wax/WBEg2VNnjgSlcTwh/AiqIUHA2uNzjjWIXr0Sw6WTjTdB4YJqpMHDHI0SyVhHy1XC8FDFeXckgcVxP21KobNPsQ==
Received: from DU6P191CA0037.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::16)
 by AS2PR10MB6997.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:08:02 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::5c) by DU6P191CA0037.outlook.office365.com
 (2603:10a6:10:53f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 15:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 10 Aug 2026 15:08:01 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 10 Aug
 2026 17:13:30 +0200
Received: from localhost (10.48.87.235) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 10 Aug
 2026 17:08:01 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next,PATCH 1/1] net: stmmac: Fix manage error case during stmmac_dvr_probe
Date: Mon, 10 Aug 2026 17:07:49 +0200
Message-ID: <20260810150749.458682-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810150749.458682-1-christophe.roullier@foss.st.com>
References: <20260810150749.458682-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|AS2PR10MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: b4873e18-75ba-463b-3255-08def6f12c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|921020|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	OTAgsZjky4u8d6fE+xgouwV4tEqNCFR/rKPQCkxz2PXku0PC9nQp1fEc5cP0r+eBLAPIctMIg6Prx4AtuxLhu/ILDzd14iOl/Y6k1qXYViiZ3xcjZfgFBIodk6MeNoK9yf3hzAglQsRLiQRsqYfhcX8zA0CrgLlAIjSZItqwCRcHziLItaONhygeU53xdoh7NPoeluDA+OGGHjGVDC1Q2nA01mo32H6Ur6ceKvX8FFGprJr3GVtv575E6VZKc9E7BVzP4sICDNE0X3hNpCYdRIGNhco/vTULv8OZ1blm/Ouk1NqNV7SfXpRNazkpxTN9P1NaqxvQI2Ca2NAofytaurfkfgcX+/b+RDEB/MRKs2uT8ryunU70GwzbiNZudVJOti/h/LR2gfohLZxotE/a95nHWxGCwYf3c3cFuvNPSBW5NEcx4tyipbCxKCeTeRLpsikaOi5HB+CUfe64IsrdMb3e6SeeuEFErZA485Vzyy1uAG+2OCeoqWg5RbjJeQRkayIGurvRPvlqJijEqTVMapBrO8J+P1JphB2p7dAuiBxdYaJl3GRaAxFX5CxZ8ruoZMh/m9VPRR+0qfQKPEjOwtjuvhZQNZBSSJIaiI+vcLjs3CVMiLrDDs+7ntQEh5B1aI2gocj0M45sSG66q1+RnysEDckgCF70bm2cauG1Qd/D9iuEyC5agfiO8F4Zb7HnaJ/Bb5q9zyqc4Y4aOXCtm1ykizpE4EDPL4hrxl+tKZE=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(921020)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eO7wklSvuHFdY64MYQtV0jM55yjSlQ/Ul1XMtQ6bf3nm2F2GD8Do3ovFy4pDbjG6eOyCKnBJEy0R0JHqY3SWjLe4oqAjtUGEsIduBqEXGZ4VnS6RM3CRIDGwn4E/+wXXh7e/pT+TaDjDsPbzQUFMDoUWPctkf2k/s/HF1liT25sotaYeV3WLhMpdar5WPQa9AqKXTgf9/xpro4nO+aX1uno32BZrmcjqaOEBhQ0KSPx5z2Mvfia+QhuvOmPVUCZFMARYEwKLeUzLI7grX+yDVS4VK1G5WSSTdtSY0QtwqOuSLl1rOhmNyjrkjqOPae7vpI6doYTsAhkOjyeiWj8YMydJhn+wvO3HCShN5Ow38TQWYWvnc2Ja8iqtdSruL0bOtIXYdHE9nESI3sLluke9ODJSMor8vHmv5jqGIjSv1xmcwGMWhYAu65w7jyLs9URE
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:08:01.8526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4873e18-75ba-463b-3255-08def6f12c0d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6997

In case of error during stmmac_mdio_register, pm_runtime is not
cleaning before exit probe.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
Fixes: 5ec55823438e ("net: stmmac: add clocks management for gmac driver")
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b2b7d0242dd3c..37d06fc6dba47 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8080,6 +8080,8 @@ static int __stmmac_dvr_probe(struct device *device,
 error_pcs_setup:
 	stmmac_mdio_unregister(ndev);
 error_mdio_register:
+	pm_runtime_put_sync(device);
+	pm_runtime_disable(device);
 	stmmac_napi_del(ndev);
 error_hw_init:
 	destroy_workqueue(priv->wq);
-- 
2.43.0

