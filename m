Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33F363086;
	Fri, 17 Jul 2026 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279826; cv=fail; b=TJL+vYmN/g79PBvLHx1LAsCL83mTkavrA3eFHMf2T1WOeQ/ylCKNLtlrnUE588AGgM4jN9P0PtRLCij96NcnyQoqwffOXdmRsWXlu4GUHXllp+Igrg4i4rvd30Vr6vtzMpaPZh0ffUVM7aG0guzLqHxDv1HwjKLPeprKuAHTeFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279826; c=relaxed/simple;
	bh=6z1pnP8ob0SFc/wTV5PchDwpQ5MpcaM6ELNLLu+UzY0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iGv6z+9w6HErujcN/kZXsjkKw/WgKiZ10ZPOUy20NAq+Zhla6aJdR8xQ/zRngLxVTrIjR3NL558FaPn8fP+elsRIqPVBrsPsuFSusobiAUKQX6eQ4inF4C5YvnB+xYU61QPxAEOt9VQBmH/GUkBVXf3UYuBKsZDBjji9EVwK4bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZmKFpwR0; arc=fail smtp.client-ip=40.107.130.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZmKFpwR0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7pYvBOJSpaeVq6Si6rdBZN5fACeTKEjF5WKxbjOmtCEYwPEbuPz79gMyVAi5PGdDu7k1s/zi90a3q4wB8CiZwEmQp+muAP2/K69dDFHYXXTrObL19HZvmYJIxhPWsTMP3lQLe9HjSdoUdlbRI/ei3pl7QLSOWB87aiLdw9VE7snxXPHPFeF7+FASwBXZsyvCJTAH2uCK2bScBi5zrAgH62mHlJfaS4Z/hSy7v+1GVzUyYLGdPr4vSaU6zqCqWAq4TUvVJbpM9vv98TohO00O5W7XekW5GZp2WnmbUO/5+/R2Xjv1dvKJBX0VNpTzvaV21bYOXPmYA636ElnjLKJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hStVCcvlszOCuw5905A2alrTqAzpf+TCIVs+5/AX4zU=;
 b=QJdD7tJdHBdaQRCYEiQwW7UxtYQI8EDtho6XypaUgU9Kg01rAF/px3f75Kpu6dxHRhWWJZejV95QjbNmGWIYeYcfhgkJPA/sW7YAzFjQkbKWCYVxmOTiAQ0Nau0cgbSImbXiX+bhTnN97kUDXhKwXagllqVe+RsRfuV68HDpQjB8sAzEYsOpIaBgoCdGWaKkDvDElkSdt8q1GsX2Nm/7oMbWwL22KcaRTSPuOSoHKwMxB6lRJONYM62PiOpjAQI5GSLrU+2JN9ohrfIZJ4WdPacSgBoq09rUeDLFCKP28+vH7/Z6ZM6gib0L5t1JmNESAM+LZUzpcK0zTjCS6mPxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hStVCcvlszOCuw5905A2alrTqAzpf+TCIVs+5/AX4zU=;
 b=ZmKFpwR0+y8P2OUIKxHof+6k7sekH0NWeXDxPBr5Ge7krZWePnTrSkCbY+OX0V8caUSctTd/UTlXmyjmWxd0LwvrrhFkATnH1nDarYx/nnPMeks3okpl9YPleGpcJFiN/32SitDNRS1D6Ee0LxRAHq5vLs98tn6hDtnftxFRwqouXnMSbSjZNrdUXcuSW+Uv4LKtmcVTFaBJJc7pkf6zR8D9NkeyXg2yWoZCkEaUIRQfkd1XyYeY1uxWQdww2sZGGE5bpBOIkoc3jCZNyArrPoAP4810FPBvKAokffgFGDcJf0UsfuTSIIQclBroEOqBmyd+oVwyydRaouTb5wUpGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB4428.eurprd04.prod.outlook.com (2603:10a6:5:35::11) by
 PAXPR04MB8640.eurprd04.prod.outlook.com (2603:10a6:102:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:16:58 +0000
Received: from DB7PR04MB4428.eurprd04.prod.outlook.com
 ([fe80::2c47:ed15:8f49:9185]) by DB7PR04MB4428.eurprd04.prod.outlook.com
 ([fe80::2c47:ed15:8f49:9185%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 09:16:58 +0000
From: xiaoning.wang@oss.nxp.com
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	leitao@debian.org,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH net V3] net: phy: motorcomm: read EEE abilities in yt8521_get_features()
Date: Fri, 17 Jul 2026 17:16:52 +0800
Message-ID: <20260717091652.230617-1-xiaoning.wang@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To DB7PR04MB4428.eurprd04.prod.outlook.com
 (2603:10a6:5:35::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4428:EE_|PAXPR04MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: 59323055-ee3c-4f7f-deca-08dee3e4275b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006|23010399003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W5P+E2hO4WTGZMTFIB7kBQgSuwwhfqw5Pz8TgWfAE97Na7UGQP30xcdtdVFPewIrNNItLCUj8OK7ugbpO3SEVBnl3ukKkASuUYeIhyZ/4R4DRaxMAf7vhOLZVGFmjoAaYfzqliTbfTUWZfr/+0rzlgqHf5a45IdK4zw0w+Gn8LtVq9puSwqKagvMid1j+fKMY6spp8Y/UXj67GCG7YmOZy1pKB4BMHDjfWvox+R4p4guPsnJW4ay1vUkWh7oET+/accDF8ETXlp17xCLzHzc7FT9e7ACLkRIkwQVPAIPzvIrCN1F93cvsiV9uXT0Kp5ViJGqWKYOJ2amhZu65DDlkJPDFtg4cpuuZ0nybHwPkmzxli9rh8o+OFPgn79KgJxvzum1zqkA8X6HCHzfVc2Zt9Waj5lIY3994h/hlygASApkd5VOF8iQ0wVcT0kniXvY9T2iJngccZeveVhrZZE3bLshHoQsCWaycNGYvItsiJR0gZoQhy2rL09ouTMlXcxmt1xQ5Y2HaGQwo5v9o5+JvdJS6rzsqYXXEtypmhofaORbUClVm/b1fpDzRIRl9arrumK1lzFtgbKb5+R9HZ42b0Jcqnho+qwFqVg8cMDha243gE8B/mKIvbh2BQESQp8bjMS8Do/YhXSlXHN1wyxzw+2WDBEmlrbvjIIeBWKxivQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4428.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xLonuTJwCNzjlSjtbNb7e9HC4OWFsyWkarReJAZwYgHM6PiSaOTdJuJaExox?=
 =?us-ascii?Q?XEVrYT1hRh3+rKycLfUSi6SnFHiiCiHrIWBCk1UA0/kRNaosYXp+paHlqbJl?=
 =?us-ascii?Q?qoapXxHcolepgJCELUKuty15FPtzapAN9hSqSjJMUMo1Up0qfckzWbJy16oS?=
 =?us-ascii?Q?rXM2xTnaTGVNMI6WyQZPApGCN7Lky7yMKy8YTupzaNC534CmW0Z4V4X+nOCQ?=
 =?us-ascii?Q?jbI7amGRqDGG8QJCoRFaJw63kgqvEe2l+NgLcpOhzgvaEWDoG+d4hehMKD1t?=
 =?us-ascii?Q?dxFak0PuWoV+QIR4ADQEDjss/lP4fHwLRJqW6RCDsvBaHrZxyohdcOOQvXTY?=
 =?us-ascii?Q?/rIlqsJVi4WhJR37NxUOjyqedK2z4MMbFbFvS+MKZxe3Rw6PJjEdZyQUOAyH?=
 =?us-ascii?Q?RiEAEgLaCrLEmSc/VfZSqunLJAX8D77dvrVXomBpDAeMabJ6lC1IOjiSDg/g?=
 =?us-ascii?Q?UxJEn3/NktaeOQIqp+KWhrfdr8lZkq+Ye/Cxps3plYwaSALaLOGw/v52AO1j?=
 =?us-ascii?Q?MYrKhrAqC+A1AKf6RQjSH0pf+NX/4PQ8MLa4qjKt7Yx/NRp7swek5xj7An3x?=
 =?us-ascii?Q?Ov7PAKoKoHGjEbbWaT9qPjp28bFU7a14UXnGi5Ayz1KrVZIhvXEr2zmM3Ukm?=
 =?us-ascii?Q?B1aMHjz4BEtcP8iEZybLJ77A5r2CfJyIgUfRuN5oGP0BoUzWiShxoorrQrVo?=
 =?us-ascii?Q?RcQYr+GNEybGdFLsLtrHcts/oc7L0lJOK7iL6e6GUwdSrWd3YDuUHp1FKzt2?=
 =?us-ascii?Q?RwWFsu1qTE2l36TNnTWQ2f5iLdhFmlQN7jBIWzljeuFBAlvDI5CR2Ud3PhBg?=
 =?us-ascii?Q?uqGtN0TFb2re1lvbB1IyPLj0dywpt1wX83uUrFkWqWAaf7769YhdevpCAC8k?=
 =?us-ascii?Q?+xJITyZ9JYYeKW84HqP0C7Ive0n/yF96gcOpndha3Jn9QhCkmJaSENW8cTfD?=
 =?us-ascii?Q?zaeE/TJL8Pcmcg0cA1ZN07rylI29TW3Ltn+2FIaTRw5FG91GKLtlLTipwy1+?=
 =?us-ascii?Q?RrXlX8rHN3ROnGBiVqnUZr3Vh0Dv0Qu1plVaQ/FP3GPcEq931kWF2jZYdZal?=
 =?us-ascii?Q?9nJrFpd7zBKF44dwBWuBrwD11UbN+4aTyoERan5HWGYk+w3VV3lrJ++ozaTu?=
 =?us-ascii?Q?07CDqw5U2+kmIqtCHJTydQ2G4T19ctGCpsvXHrCbDq8eE9q+KSplW43CPL60?=
 =?us-ascii?Q?wdDQdctsnvDK7iIkhdLmIS0T3TIGRgBYUTeHpQoeG9K5fHbjUT4tIyoAnCxD?=
 =?us-ascii?Q?nmMmCHkS8Cz8YbT87aFJ6/O9NfNQoTbumaaNx50Q606PU6aAcdkDH8fXgqFz?=
 =?us-ascii?Q?2MwcT1lfJsUgIrr9yTBiWJc9M8HJE2gxJ3LO8Jo5ViCssSbxi7aBkSOzinsW?=
 =?us-ascii?Q?dmimSm9MIaMfgF1cRnc4C2fYmrku3LQH1d2I3IhKPsFyRQhKz8CXLFbdTe9f?=
 =?us-ascii?Q?M7ABQkCK4xra40HMuRcDhksfrfKPwFBXU074DD9D2TZV7sfDWR4pu8SyOyQ7?=
 =?us-ascii?Q?pNNvxptYyNuLClzmdgiQ5+xLAz7Nl9xUqRPn6Lye/wUU81fmxoep3wzwGsV9?=
 =?us-ascii?Q?Q08rc9Gnbsf5XnI9+Di1mUBJj9htaKceVeMzNRHu+jgKMJaTyXsPyGTDU7Ll?=
 =?us-ascii?Q?F13z2WU77/e6zBfHxdzGfWr8g4rvEuAqAdFH5dfr+BY+cGyMXLTb5t6KOycx?=
 =?us-ascii?Q?cvChFHxNfPBabaOAEaRVvtLxjVx4VLO8NgTjAg5RxW2s7saiF8OFU8cepXKr?=
 =?us-ascii?Q?26akDC/unCOSQXxtXDfSGOQFxGQJJQ5w7C1qzPwqCyhMu1A0Qd08UzEAHFWn?=
X-MS-Exchange-AntiSpam-MessageData-1: jrUqvMkMFGsgeQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59323055-ee3c-4f7f-deca-08dee3e4275b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4428.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:16:58.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+Prc9jFgDtFzv1d1FEVkY7qgVXuUZc4lzhyb1EmQGr6+t/r9urVQgycQS/TDZayiFcqKczX16i9lDeCBU80lFMuczMhZzy3QjjoRadEdIf38oeOwuh6/f3HBMavHm5m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8640

From: Clark Wang <xiaoning.wang@nxp.com>

In phy_probe(), genphy_c45_read_eee_abilities() is only called when a
driver uses phydrv->features. Drivers that implement .get_features are
responsible for reading the EEE abilities themselves.

yt8521_get_features() does not do this, so phydev->supported_eee stays
empty for YT8521/YT8531S and "ethtool --show-eee" reports "EEE status:
not supported", even though the PHY has the standard EEE capability
registers.

Call genphy_c45_read_eee_abilities() at the end of yt8521_get_features()
to populate supported_eee.

Fixes: 70479a40954c ("net: phy: Add driver for Motorcomm yt8521 gigabit ethernet phy")
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
V3 changes:
- Replace the uncommon "ret ? : ..." expression with the usual
  check, and move the check right after the first yt8521_get_features_paged()
  call, which was the only path missing it.
- Collect Reviewed tag from Breno.

V2 changes:
- Return the value from genphy_c45_read_eee_abilities.
---
 drivers/net/phy/motorcomm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 5071605a1a11..6b710c02264e 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -2481,6 +2481,8 @@ static int yt8521_get_features(struct phy_device *phydev)
 
 	if (priv->reg_page != YT8521_RSSR_TO_BE_ARBITRATED) {
 		ret = yt8521_get_features_paged(phydev, priv->reg_page);
+		if (ret < 0)
+			return ret;
 	} else {
 		ret = yt8521_get_features_paged(phydev,
 						YT8521_RSSR_UTP_SPACE);
@@ -2490,7 +2492,8 @@ static int yt8521_get_features(struct phy_device *phydev)
 		/* add fiber's features to phydev->supported */
 		yt8521_prepare_fiber_features(phydev, phydev->supported);
 	}
-	return ret;
+
+	return genphy_c45_read_eee_abilities(phydev);
 }
 
 /**
-- 
2.43.0

