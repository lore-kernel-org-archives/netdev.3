Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C09B3AFD15;
	Mon, 31 Aug 2026 03:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146614; cv=fail; b=gs00IozFmeOd+fmWrosOM99jrxUB5zXvXZav6QS6qKIxRsPlKSnjjqjXWuP1L8Nnl0fa3jqjVO6t/xzM8NwAHzL/ZLgr0Tkqe2qYUf/XjeMbTjzRLJm+aXQPFMS91AaKbwdj6VFJ+re7lob1DYDdJxY9NjfV2ihJJ0Ozhap+A0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146614; c=relaxed/simple;
	bh=f4dZCR8MLMHmh7GAyKRlYsVUC+r1Ml0lHG0sIRRRVoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u5AAnya8b8RTfTiHUJtErd1w+C6DbkSP7KllVu9yNR8z9TJFdOYRWAOpfMiYpbHpN8o1v9u6c4tFcyI+y2tiSJzml3vNVKSloFb8ogGJKITZICUAcifexnnEGyxefn3cvdiE+sb4IdciXZXd6Rn88eg5CFhbdZmt0fvjW/MAA0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sfoUPyjW; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sfoUPyjW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSftt+PxItlM4aLYw8W+2bWHFXQIVd7kFlJP7gC/+q2TBgaXDFJtEonYTBI+IXJdxKnefe3TbRrV5pGxsgXBUpOVnGPD34XYSEgGykCMqZyYMUzuLI0pVbw5OIm+gjBU2E4UQeBhnzobMKuZwp9+2yX1AudoT2xTUrqX5boCJ5c0l7t/7ZQ9MY5iIp3FBIx0xtfyh+W1o7X6OFwB/19LrGLTccnq/63s8XV+U7JA1qL4eqTq4/bk5wDguEoVvPMKoCHPLSEcro4wrPmooQnNL9bZcAu7Jq+Iojvjm53PQTUI8d2DVAfSLIfpmXF1Z7vGCYn6NInvEMUHkCDzIHmtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yx71gO+niPEOMEHRNQVeUENZJ5OIgP9U2LAsJ1VRYic=;
 b=UeEW6qd+OMDDVWhu4OipSG8CAxqtTzMu3PCmyIA/qsy+c3tE0qBb1aut+4XK5CyC3Qe16UwMV6onZ958KNiVUbsuqmses7RrJmW9ViLc1lYFW7FuKoFIFUbNTnbe8g4PPoNYNmzNBl9qaDqafIrhunMFqKxq9fPtAs5xpq3l5gKAq88o94etazolswfX1AYo+m8iaLo24lkE6o0khexWiOh9Ib7ewkJv5X4p6KXg8HkADFVSH0L97YnTgIjB/yFbGBJl3XYVADhk0wv0nRMCtWVlMVc2QArAs3S/tgMeG12uc9Zl5CkVdvqMlGN4D4yCIy/8xLMbKfEq28BZ3LEZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx71gO+niPEOMEHRNQVeUENZJ5OIgP9U2LAsJ1VRYic=;
 b=sfoUPyjW0RxPVPmSxAWcf5dFrt/4W3LSAGnwBlvpIE1hYdl740ngfLbwQDZ+dFbKAe+jl3murZiziL53Y0zb1sUnRAoK7xC0++zQg4zfjB860Q23SqcO0zd0J2UmJcGWfnqEDMjigu/OSqMxE+0ko1sCMCn9xBDdy8pzlYBOZLH6z+xrkW47lU6astgpeqJw6Pd3zriS3fbbq9pbSg9SP7cwScueuv/8YoRHYDyJ02iAwy00JPULG5WgDDCTAM0wyF+tyEmX2rzdIl+snlxjmuFlROK7zXGGCWfwlA174cZy+ZTnVSlr6a4Myd63P2uroeyl3/kECxiC6hEpAICIig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8474.eurprd04.prod.outlook.com (2603:10a6:102:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:23:30 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:23:30 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 12/15] net: enetc: add VF support for i.MX94 and i.MX95
Date: Mon, 31 Aug 2026 10:54:38 +0800
Message-Id: <20260831025441.635045-13-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0255.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: b7931a74-4b96-4b5a-71ba-08df070f3aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|23010399003|7416014|56012099006|10067099003|11063799006|18002099003|22082099003|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	pbjmnLb6TGos3EZWfse7JuXwlpUTQVMX3f/QPwXzGqDfXR6+6z54TPUwBJfFIRpGykIEHg7K5brF7AKAyMZneECOQ1TMA5XuVhlEK3mu5FMptgyJWRLSwx6EQ4rzZ1FucKeSj1THrTg4IMJNXE/xH7Vkq5qfOUlscNUeLsjCMArmjwWOjfGhYufA0A5nMf7FulKbbZ8Z1CWWmQ7mwqAKq2UtykYWi9OnohMbT7ew6gNOcBXgEu7cH22bt8SM35oQpiEDB5U7yB6iotbZCWLU8R6pVTh//t4iNutYn6yXDNsGxmEmaJkSpVTeJp4/edXsFG1CHQRWCfivL86DBxm8BadiMGhiV+zpQfRqHhnVNxjGKNiOWlF0kiUekH6KH8kF4KnoMN+79hYRbpPwXsuuBh+hjOa08UPlfbLcpePJneiAiUan/mgB5NN5F61o+s1VWg/MKHQcwgJxMh00mTgXhBOBKPQJl/dwPTxHZ4nk5tau89flNwbL/GS+6gzjLBx2ytQ2GAKQKQGtpx/7mQ4kEQ7Lu7YobnDHG3laN9DZ8M5Mzx6oLNk/dJ1GOnqJ7g6aTr6EK/LYPdSgY9AseQSvvhKZfsvDdQEv/vNj5R7rRwqWUOW9mG4O2T/N5VMuG4u6rjd9K4aWNiKz1TcVAWW9RXO2eO2d7BxW6UeZAc1Sv/5yTnS4SFLsUmfkq6p+XTLspBkH2US+5bRQ1NbfkZt7bQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(7416014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2vEDli3tX26NyCo3AeSWNQbrb1fKgcawaBAVaw3XRUzlrd0+zczvxDwV0JmA?=
 =?us-ascii?Q?plEPmJPwYZKP96EUmH+3kwgb92e315lcue1UMAqHXBGOEIMnad9/T7lb/gJP?=
 =?us-ascii?Q?irJnlqIFOt5dm+yzU4FhWKuyZjl6qlDQpOkT/hAo/hJ5YxZOBkVOuXaaYzRM?=
 =?us-ascii?Q?SAvEFmal2T/2HL5WGgA6JJTWv5ZZ7VYO93K3i2sGA9Ewp9UXUjtLI3J1mmZS?=
 =?us-ascii?Q?m0vMgD7/GzSRW4AwP4h1dvyUkYbwyP8k550kxWdDn/3C1YcJFqpsJ5hNj+hV?=
 =?us-ascii?Q?8y3tiTusr4mjhpNLTjQ4nE8sFvkxYt1diJP5T0Gb00Wfl/MkzzSg7bRWuXtM?=
 =?us-ascii?Q?0yhoVxMVRwRq25IogFJhmwJSJm+c2vFWhOIU+WLIH+5QvF4kRxdnbRpKirMa?=
 =?us-ascii?Q?wCOhND2EuvCb8GMCXtnwYArSKfGZv4qpLumn8hnuM8gOzVvwv/lNLl0qtiq+?=
 =?us-ascii?Q?PSww0pwyYnB4UaJpYdUCffC8bGgAQGZ5ogCssfqMu5187c1EnssxOIotmMNK?=
 =?us-ascii?Q?0dTkA5+7/chhATIDeIiyzPH2E5G9ZtnyOUOYboDrC2W0H7jH0BuQOq6ZPmPG?=
 =?us-ascii?Q?ThWTQ7E7pN2Nn4Ip5YS01wXtq/TXYG23VJFhJqSVfr1/1ZMFmxfnTNxw0K3I?=
 =?us-ascii?Q?WpEIIj8D3Kr7Rfd9DWioKMu7VcTBEX8RYIkwxcN/Cq4hvdZayA9aMgVwX5bV?=
 =?us-ascii?Q?LwgElHWIzOpBWTxNGQZfCJVZciz8hU263SF2lG00C0AMBJpfwmjd3UcaoGui?=
 =?us-ascii?Q?qcFGfYHHArcmIKTUWzEvVSdqFFQH9NZYncvnxrq0cvXRP1lrZxRaAmtQdN6E?=
 =?us-ascii?Q?psUN2MrlDUTzTMRro3+nBFysGbO02I6Pfpzw8CtW0+Vqs/vuTgtBC647ZTw4?=
 =?us-ascii?Q?gABVU2ZQ+naaUzfbtGVtlgY7f6JSBN5YWPfvr2gU4YHMX7tkywZQ3Jbrr9VX?=
 =?us-ascii?Q?QAMl4Js1QJtIDRujezBD8mQkxbFQxS5xNkHROnh75xdfTMjhHnOfz+3mvLRb?=
 =?us-ascii?Q?rw8sKbP5xkTuRcC6MMd8zydcOl89helHqHCTJb6GWAFu+g9li0sbHjnZ4snI?=
 =?us-ascii?Q?o0xw3RpVzprzyAv7FEk4UPYqQCi9Al9Ku4jvHPzj8UGYJQUiNQ8rLHR41wVF?=
 =?us-ascii?Q?1DJHaHVKd7BrpfgobLd+MmCNo1bo6ub7POkPj/bc40k++WBdkamGTjDPzPEY?=
 =?us-ascii?Q?sgiNuTPSp7QPKAiFm6gTLGCj+ZXx0ua64JlmSShYjPnucH3HSs1yjFlnYwTe?=
 =?us-ascii?Q?sL95ntVHUWaP/O0hgqoiOtmmnR31KAudIAv3PJO7fws3ccyAiTMLMlKctbzp?=
 =?us-ascii?Q?1FLUkfmTyRTXmki5xEP33uGfWq8m8dCaxKk/Fhq0UnGtuHOTMximc6DR0qvv?=
 =?us-ascii?Q?DyauX5tTJJ2QChyYAvJfCxovmWZayJ7ouEziL2iPIiKBVSc1lhYh5r9paCgr?=
 =?us-ascii?Q?hu92RQiceU+Kegf4mqintqjgATiZq9DmaTAS3Ffy7dehREKOttD2nj37h464?=
 =?us-ascii?Q?UBPibEMNx5TesIgtubBYDu+iEIFdT+9zL+IuPfVLRwsQ29bGD6T4WL26DO9P?=
 =?us-ascii?Q?OGUomxxWaKKCeYLXkbYFoiWqfNge1pATp7pqAYnxxRVrNI0q99lUUDpCdetG?=
 =?us-ascii?Q?S8RJ7sE0dU+2xLr5Rnl4EWNBBWX4qsywzjnJkSyOzjnSlqq0PY1cRb6KvPFn?=
 =?us-ascii?Q?r9UvMxlvkfT1S8iy1esTaZT2DBL0jE8QWkzVTdvWsqv94qoA7eWdf1vJh4U5?=
 =?us-ascii?Q?0DIogwuzyivaKaYPNvUarFt3T+qF5hZ8vMKx3mr+AKl1iQOufRsg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7931a74-4b96-4b5a-71ba-08df070f3aaa
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:23:30.1184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22lEjMM1myyXmNXnU0Hf1GAwOdwzaU1K7HEXxfe+A6qCkoCRSnimTW93LkEq8XsEJ/eB4Bd+KGifRGcjbWCAxnX94yukfHFMMlKnR9pmffdldrnRGREQRhumK84u71E4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8474

From: Wei Fang <wei.fang@nxp.com>

This patch adds VF support for i.MX94 and i.MX95 platforms.  Compared to
the LS1028A ENETC, the VF device ID has been updated to 0xef00.

On i.MX95 (v4.1), each ENETC instance supports 2 VFs.

The i.MX94 (v4.3) has two types of ENETC with different VF capabilities:
 - standalone ENETC (same as i.MX95): does not support VFs
 - internal ENETC connected to the CPU port of NETC switch: supports 3
   VFs

The driver is updated to recognize these SoC-specific VF capabilities
and handle each ENETC instance accordingly.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 15 ++++++++++++++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  4 ++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  6 ++++++
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 20 ++++++++++++++++++-
 6 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index db5c17a44613..f425f82a6213 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -69,6 +69,7 @@ config FSL_ENETC_VF
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
+	select NXP_NTMP
 	select PHYLINK
 	select DIMLIB
 	select CRC_ITU_T
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 80f0082f6c63..803c5c541a5c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3794,6 +3794,13 @@ static const struct enetc_drvdata enetc_vf_data = {
 	.eth_ops = &enetc_vf_ethtool_ops,
 };
 
+static const struct enetc_drvdata enetc4_vf_data = {
+	.sysclk_freq = ENETC_CLK_333M,
+	.tx_csum = true,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
+	.eth_ops = &enetc_vf_ethtool_ops,
+};
+
 static const struct enetc_platform_info enetc_info[] = {
 	{ .revision = ENETC_REV_1_0,
 	  .dev_id = ENETC_DEV_ID_PF,
@@ -3807,6 +3814,10 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = ENETC_DEV_ID_VF,
 	  .data = &enetc_vf_data,
 	},
+	{ .revision = ENETC_REV_4_1,
+	  .dev_id = NXP_ENETC_VF_DEV_ID,
+	  .data = &enetc4_vf_data,
+	},
 	{
 	  .revision = ENETC_REV_4_3,
 	  .dev_id = NXP_ENETC_PPM_DEV_ID,
@@ -3816,6 +3827,10 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = NXP_ENETC_PF_DEV_ID,
 	  .data = &enetc4_pf_data,
 	},
+	{ .revision = ENETC_REV_4_3,
+	  .dev_id = NXP_ENETC_VF_DEV_ID,
+	  .data = &enetc4_vf_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 09025e7a2a3a..e23d8d82d2ba 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -12,6 +12,7 @@
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
 #define NXP_ENETC_PPM_DEV_ID		0xe110
+#define NXP_ENETC_VF_DEV_ID		0xef00
 
 /**********************Station interface registers************************/
 /* Station interface LSO segmentation flag mask register 0/1 */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index c421c0e7355b..a945a120c553 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -1121,6 +1121,9 @@ static void enetc4_pf_remove(struct pci_dev *pdev)
 	struct enetc_si *si = pci_get_drvdata(pdev);
 	struct enetc_pf *pf = enetc_si_priv(si);
 
+	if (pf->num_vfs)
+		enetc_sriov_configure(pdev, 0);
+
 	enetc_remove_debugfs(si);
 	enetc4_pf_netdev_destroy(si);
 	enetc4_pf_free(pf);
@@ -1138,6 +1141,7 @@ static struct pci_driver enetc4_pf_driver = {
 	.id_table = enetc4_pf_id_table,
 	.probe = enetc4_pf_probe,
 	.remove = enetc4_pf_remove,
+	.sriov_configure = enetc_sriov_configure,
 };
 module_pci_driver(enetc4_pf_driver);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 07b7832f2427..7965dfd06f5f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -859,6 +859,9 @@ static int enetc_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc,
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int i, j;
 
+	if (!is_enetc_rev1(priv->si))
+		return -EOPNOTSUPP;
+
 	switch (rxnfc->cmd) {
 	case ETHTOOL_GRXCLSRLCNT:
 		/* total number of entries */
@@ -903,6 +906,9 @@ static int enetc_set_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc)
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err;
 
+	if (!is_enetc_rev1(priv->si))
+		return -EOPNOTSUPP;
+
 	switch (rxnfc->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
 		if (rxnfc->fs.location >= priv->si->num_fs_entries)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index a60af40d8546..322705202d49 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -285,6 +285,12 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 		ndev->features |= NETIF_F_RXHASH;
 	}
 
+	if (si->drvdata->tx_csum)
+		priv->active_offloads |= ENETC_F_TXCSUM;
+
+	if (si->hw_features & ENETC_SI_F_LSO)
+		priv->active_offloads |= ENETC_F_LSO;
+
 	/* pick up primary MAC address from SI */
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
@@ -296,6 +302,13 @@ static const struct enetc_si_ops enetc_vsi_ops = {
 	.teardown_cbdr = enetc_teardown_cbdr,
 };
 
+static const struct enetc_si_ops enetc4_vsi_ops = {
+	.get_rss_table = enetc4_get_rss_table,
+	.set_rss_table = enetc4_set_rss_table,
+	.setup_cbdr = enetc4_setup_cbdr,
+	.teardown_cbdr = enetc4_teardown_cbdr,
+};
+
 static int enetc_vf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -311,7 +324,11 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	si = pci_get_drvdata(pdev);
 	enetc_vf_get_revision(si);
-	si->ops = &enetc_vsi_ops;
+	if (is_enetc_rev1(si))
+		si->ops = &enetc_vsi_ops;
+	else
+		si->ops = &enetc4_vsi_ops;
+
 	err = enetc_get_driver_data(si);
 	if (err) {
 		dev_err_probe(&pdev->dev, err,
@@ -413,6 +430,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc_vf_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_VF) },
+	{ PCI_DEVICE(NXP_ENETC_VENDOR_ID, NXP_ENETC_VF_DEV_ID) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_vf_id_table);
-- 
2.34.1

