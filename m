Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21E6285041;
	Mon, 20 Jul 2026 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513562; cv=fail; b=nf1GM5nejissMPnrRKTtoS0Jke2gQLngiEYlXN8K6b2DRhHMqiSWeY3Q0juNST4XXsgZr02uSOKyUSScuolJVE9fLHJXe/mSS5zC7fsOkW/ZQ3Lznta6yG1xvo6DeKyoAQKErjKs+5nsqvW8mBCKgA7bXzXG8Xwc1mKCGWhxE1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513562; c=relaxed/simple;
	bh=bHKC97jZ63s6Jb95NrktiwUZ+LNixxlw3EPgJ8VzS7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJrENBPyuBYkZz++8drmmXFkq105KaioYXno0lT0KhkcsRIfcE416y5AO6LfkarrAfpTpvUlWBguJOKZqq8UheuNiMqLGU7pFN+j14bGJVxa+aEQWVCI72sXBmUKMAxqNFkvul/o6Z8AfKUXk1xIsbrjA4R0ztnDrV1nMwiqwVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hLTnWaxt; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hLTnWaxt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paPPXXL6mCHYmEn86O7khICCKfy0Bm3dgz+/w4Kn0rpxFiGWjfbzjn6vzNQghx36aICjlFEdggJvO98vakNXmcLEyq+r5E3Q93OTiqH5X+kGTf9G78GsS2ixqEK7x0rFxnsapu3o83PheJ3WONiNqKcrsOZcM696cPF6Q+HSV1tbq1vueYQBf4wAWaOd5PCZ3CKFVSO/8DiQ2wgN/3RTR66xyaT+3JLp4HcQqG3tJn11Dw2t6Qvu8VtMa3OB1hV2S9mV0Wrr44Lk7HIBvkFHn8ILG407gVWI7A6upASFwXCfNd4bPttqfpcEOI76EFYxjRHy7dlFjpBA+eZkCH2law==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inQ3ZI5MR1NIw05ZhIFaYKjrAJlJ+Efmiu4/L2Xnz1A=;
 b=Rr8m9HifmFILPvIx/dXki5lE2Pcw4UmG7iNAC8UhdjxP7E+E4Dx8v4MyjH/c/+MxhEcE2w4lurj9dibLOn/y9WTglKZ1W+c7tw/5AaoEhJG7Yqf1besoCG2M1uypAnWHKvCV0eLsOSdIFOJpkt/0bmbnqRw8SHRNfvQgcgaDr4hSPRULONCE7U1JnLAPTURQQxYU3dS9F8whLrDGjaVDNmK/rFLXGJ8trtnmgG7lxTfNHc8pFFg/WfPgQGSaWl2iiiYjKLRF8M9uBVMBtQNXvX2etkocmplQvDpkKPuAww63I8XnxyUzH5uMsBtH1abaDPM1IakJqSvDgwmJqcIb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inQ3ZI5MR1NIw05ZhIFaYKjrAJlJ+Efmiu4/L2Xnz1A=;
 b=hLTnWaxtA/dFJA+nkwYz6aZzsaAXxfKBzSLj4EWU+0QNX3okv/+mFm3YYOjPpxLE49dy5nmDXJXHax9zNCSJeeO6SbQOt3m+bkc6GxDG1BXcAkOKtanMLtYIhteaBH7wqSrPw4dlSVoLi3TW09mqn+7aA5/wi81eAZXsp9kryo+FbBCH5Uc1Crtf+Jte2VrQidRBtfWiASyMPPpCaxQNGPOtZbDWptTpa1vzI0L3RfbGyc+sJagnEWUrhRpK+cTRuBsTF36Qpm67EdJ3/hVg8iis8pTP5C86tZaw+5eENJhlhXJNU9vNlIZ89UA4yMAEaxHTqfIkMhCPqnreuMKELQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 02:12:37 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:12:37 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND v4 net-next 07/14] net: enetc: differentiate phylink capabilities for pseudo-MAC and standalone MAC
Date: Mon, 20 Jul 2026 09:43:09 +0800
Message-Id: <20260720014317.1059359-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10872:EE_
X-MS-Office365-Filtering-Correlation-Id: be462b6f-1987-4fcc-5175-08dee6045e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|921020|18002099003|22082099003|6133799003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	cDC8V2AA8HypMds1aLBNaKp6YIdsq1aN/5AZZPHupDidiNXTvrPoMaCA3FvcpJE+Pvb1sdb7dcOUluqtviV6ZAD+2BfEE20l7Xrak9tGACSE8m4tSygsVyhQGudbyPxsz1dnws8ajowjSeCqVKA/UFLe3mdM/ydaiihmtVmo+kCDxb7hNCoVCuPW7aohDVbLBBUMAKcO9g+BMLCJ7mpxVKI5F5PkcqSUzZ4+A60cBPskp9ybDcy/I56KwIEU8HN/E0UHI5mDgzRf4fqTTWXvFBve+yyDebDbViKsRNixpKkuDYbODpAhGbxG8xR/zfNQX02O2yG/9soQyJzmk0Dk7o3Tjr4Q6HvnPEMhe1CwBaVNN1xyE1coFZ1yiw9YolrKdZ16ivvHtxk1qSE5Y0CUjS/IX04ftZnjkkGHfoIvUDA5VcCV0Js8DPT4Aya5bHfZlrc+wb5kfPR5b4tUqhbI25g1JJX7a+A7dDwXTHnwZlXaDH5joq/XbktCbejliZTbP04SiNkUQqqKbTEpY7DAqNTZ+RXSUY10vZXj8OkMUVWIbUsDUIgI8UNGfNFhrtAqqX7ziqyDjB2P++yxAsYjq11bYq7zW9+TqLkbTj+lW52cjplpVjrqIucmm1UByGzlHvCB9kXt9lKghnkdV3rnqffljUfSXOgzn4c4BK+RLpU5HO8nY55ELhRgmhAP6w3T+v1Bwy7pYgD7fOyDD30XOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(921020)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R2TpdMaVEZNXOvJ1pxHHb16CsTBUL7fvA88+12cT7AHFpZU61PLYD/X6EB5G?=
 =?us-ascii?Q?mbrhKSf+5wtESzrQSSRVFrWWn1FW/67wIESzDnC6EpgTM/3cPybU6mKbHi+D?=
 =?us-ascii?Q?c1cZVOGZDVdQqnbH9RYJAMxO2qfp8FGgOhuY64SZZabtbJpSrp27JbIAiutN?=
 =?us-ascii?Q?rMOIj7e242R4dqRE4B5oKUF9EmpGrb+BweBBN7omzfLuOOGV6bc0CWl4bIHu?=
 =?us-ascii?Q?iUtbkFLfkPBKGG73mQDmD6yHlzWsvmtW5znkKR5DtwaRNbaLHP/TAWY7SAL/?=
 =?us-ascii?Q?0GHnNEuGS2LAe+UeIxgOnCZ5Mj7nypuk4LOUZQf83YsfxY1zYLupREz3lBSt?=
 =?us-ascii?Q?tLRpGE22y1hD39DhMfQ0lwN91NmDytXlqYK5Hhdqgm5GZisXGwdgWkP3VM9G?=
 =?us-ascii?Q?baQHsnmKcVbykQ9ahrW3LqEsP3xiyyLjOSm1015w+JJQ6EUehj04Ky2qUoMg?=
 =?us-ascii?Q?X6yKzDK09gTe/5uCIXyh/FlhoBu4JBf38w0iFKpdH/R9FmMc+PED59RweUsl?=
 =?us-ascii?Q?DpReHWe2ROyKpm9jJzLu/cHutT5Gm1Ijz7glmmxgi4XaDE2RxrpJX6DTfz+M?=
 =?us-ascii?Q?gocL283Twhet1hBD03jqCeZjx0nnxIOfI6PXkKJ5gzwGEwDqOAtK11ri5nXI?=
 =?us-ascii?Q?lWRfYNnjVCb/DmOlQEogTEhCQqjnLh4Ox72IXhhRX214VTz+eXthedea7EiI?=
 =?us-ascii?Q?m1+vQnAFuLMdmnFZF5d2OtQTB3Jc4U5iV7OYlsEGxKkGFwpHml8iVbuc2bqQ?=
 =?us-ascii?Q?QgbQz4M339W9dl4lBDYstYgITOB4nKIDwxHpU3bEXP+/XS3M4lMCDjH9WxEN?=
 =?us-ascii?Q?lAnFBW2d7t8dhEoylLiMKZe+CfVr18l2O1jyoc1P2wtmvbMIeJyDDiw4QFyr?=
 =?us-ascii?Q?FQHAhAaOhE3KXtrKrlVV0PeHjQhAoplASzouy+M8yAPIcPBjtJnjwOyV0b5T?=
 =?us-ascii?Q?jDQdlkTyZcpJbZ/Jsp37VKo3QaU1KDzh/FVLQLRDEiTUMBxLTJlRkKxotP9W?=
 =?us-ascii?Q?isAU+e5qLKUqi9ihWRQqrm9OFuqWosSuK5xVPEcf6PSmOJMRUSyDKXHYQdvO?=
 =?us-ascii?Q?FDX+fBlbuAM/NofYj+3zrQ3YNl1WjqCSJN5xRBrQ1SPPd8oI+uzBqTU3Ixt2?=
 =?us-ascii?Q?D9OD25mUV2F8A87TrLujABtk7Yt+tS5MoD7QMGjlaHfNYCEuEsnwLmlLZ+kM?=
 =?us-ascii?Q?P8sT2QAywsBOueqiBke8pm1wkvdr3q3OcEsCZFboRABRllHkKTIbwsPYU57K?=
 =?us-ascii?Q?pU91wRqBs6BxCkucyFc+eDCS4M0zz5EPylUj+/+LlStZUXx/H1aHseiXssij?=
 =?us-ascii?Q?mvduQx01ua2o3ow5Ak9VsO9MqSUzya1hpwLwSV+sJD48f/T/84z3nHJp2GUj?=
 =?us-ascii?Q?s/FoEb/JyyVyGLTFMwIqUHLAaYPnu1IWF/yAgUSajOz1r84EVI+ZB0qRLxDJ?=
 =?us-ascii?Q?Z6x3EbaJ5qhI6BS8UweGb92q/VevlKnvzC4E+5c9dVdBAsv3rXRCj6lXdmtb?=
 =?us-ascii?Q?voF1r1Ycx4Lv0puNC+21XFISeRnOS3d/K3NsiZztd7pBviSkCOjs3ipN0PiB?=
 =?us-ascii?Q?vOJAvOZOeMAXXkEscn3qr0Mif16PYQe30XKXqIiHF91KXTK2tcuttd4DT6Sm?=
 =?us-ascii?Q?tLMbvk0gFTjTsPcV7xbh/Vkz0bpNckdD+nt8tFZhDRj0iVOgqdGYbHlbZZQL?=
 =?us-ascii?Q?GS54M9SQiOlQ5IDQHPbkk7OxhugslxUhk4kNJzaic9m1Z0di3lC6jTcYcW93?=
 =?us-ascii?Q?NyHAW3EZEDkTnuvVJeSKhNYzrPZP0eBGRtADZV13QmoB8Z8iCInK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be462b6f-1987-4fcc-5175-08dee6045e68
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:12:37.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5ZJAIFvLK4PxHwC8nVhTE/UMJFn0xh/InjvM3BRuxDDLC7kxSXPXHdD67Yx7ybui5L0mt0EqeW0VKatB8VQtEgKI9197gMIz6Hrr3E/v3VStR0uI4tMDYo9ouzvXSJs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872

From: Claudiu Manoil <claudiu.manoil@nxp.com>

The ENETC pseudo-MACs are proprietary internal links that do not
implement any standard MII interface, so restrict their supported PHY
interface modes to PHY_INTERFACE_MODE_INTERNAL only.

Since pseudo-MACs can operate at any speed between 10Mbps and 25Gbps
in multiples of 10Mbps, set their MAC capabilities to cover the full
range of standard full-duplex speeds: 10/100/1000/2500/5000/10000/
20000/25000 Mbps.

For standalone ENETC (v4), expand the supported interface modes to
include 10GBASER in addition to the existing RGMII, SGMII, 1000BASEX,
2500BASEX and USXGMII modes, with MAC capabilities up to 10G. MAC_1000
is replaced with MAC_1000FD to explicitly exclude 1000M half-duplex,
which is not supported.

Note that 10GBASE-R mode of ENETC v4 has not supported yet, the current
patch adds PHY_INTERFACE_MODE_10GBASER simply as preparation for the
upcoming support of the 10GBASE-R mode.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  1 -
 .../freescale/enetc/enetc_pf_common.c         | 44 +++++++++++++------
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 06a9f1ee0970..8839cfb49bcf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2017-2019 NXP */
+/* Copyright 2017-2019, 2025-2026 NXP */
 
 #include <linux/timer.h>
 #include <linux/pci.h>
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index f24269a48c26..75ee117e9b1d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -602,7 +602,6 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 		val |= IFMODE_SGMII;
 		break;
 	case PHY_INTERFACE_MODE_10GBASER:
-	case PHY_INTERFACE_MODE_XGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
 		val |= IFMODE_XGMII;
 		break;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3597cb81a7cc..781b22198ca8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2024 NXP */
+/* Copyright 2024-2026 NXP */
 
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
@@ -359,7 +359,8 @@ static bool enetc_port_has_pcs(struct enetc_pf *pf)
 	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
 		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
 		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
+		pf->if_mode == PHY_INTERFACE_MODE_USXGMII ||
+		pf->if_mode == PHY_INTERFACE_MODE_10GBASER);
 }
 
 int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
@@ -400,25 +401,42 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 {
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct phylink *phylink;
+	unsigned long mac_caps;
 	int err;
 
 	pf->phylink_config.dev = &priv->ndev->dev;
 	pf->phylink_config.type = PHYLINK_NETDEV;
-	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
 
 	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_SGMII,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_USXGMII,
-		  pf->phylink_config.supported_interfaces);
-	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
 
+	mac_caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
+	if (!enetc_is_pseudo_mac(priv->si)) {
+		mac_caps |= MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
+
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_USXGMII,
+			  pf->phylink_config.supported_interfaces);
+
+		if (!is_enetc_rev1(priv->si)) {
+			mac_caps |= MAC_5000FD | MAC_10000FD;
+			__set_bit(PHY_INTERFACE_MODE_10GBASER,
+				  pf->phylink_config.supported_interfaces);
+		}
+
+		phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
+	} else {
+		mac_caps |= MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD |
+			    MAC_5000FD | MAC_10000FD | MAC_20000FD |
+			    MAC_25000FD;
+	}
+
+	pf->phylink_config.mac_capabilities = mac_caps;
 	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
 				 pf->if_mode, ops);
 	if (IS_ERR(phylink)) {
-- 
2.34.1

