Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67298526AB8;
	Wed,  9 Sep 2026 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950218; cv=fail; b=BEibkw7KXNYuoAtU0YaGSF8LgKEp1rJMljPOx0y2BZH/DCO7Jv4Fp5QXUarVD1SPswxVPLjGzlzeapbVWMLlvXUdUzV0pl11u0akeUSZRpZhlJU6xiqNKOX91BKSq3ZTUzEDNo8cpd1Ly1kyihj4RuAqnRwtYWXD11SkmT5g0l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950218; c=relaxed/simple;
	bh=A++GiLSFepCNqIHTVOlQwe3mnVDy+4mnzQsiFJC0lQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dNH9shsoEkJbwpOI8Wa5f/TCJnOxeBUWFxEowkrGeOfvsh7ZJDkpkKNq0L+OEmI1D10TTdd0apiHmCJZLYzK/1g9GYKiRm7ymuO6OuYWfl5Fp3WISJY8stIlOn75JS5kCGJ8mGk6aztgRqprRYcVSQ6vUXzF6fPMd8fzhpNfiak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=C4XxoNWV; arc=fail smtp.client-ip=52.101.83.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C4XxoNWV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf8sbF/PPFfnHyX4L9RBtg4ay8gUqajBenBpYwCn4BxJWONx9GpVojTxDowDPOR4jWeSVi3v2QlSe3dnPp74KJej6eO0e7B/DD3r0oIkOOtpv+tTY/2Pgdrhn2LVCaxuDaFdkLsl1G8PP+bqd+bWg9mdx04orRWaoFUabutRTghvphipNwxlS44awOQzrOdqziSWeVQxHggRpqxhuwsD5oPcduC/7msf1l1QRvo/pncPy5HDJ/f8FkR3oTlUbMc8OGbvuZHa+6HQOvkomLAWYQo2kZgmHvM+HP0HUI8PXCjMPysK/Bc4I8V/omBnWSfSDJy5kFIq1aoL/aLI0tZQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvfuFRWPaRwlqWa54qQ0IXio3FqoJ8m65oadvsduej8=;
 b=cE+CEFuHt7EcAzUvDi699cqTV4/OvGB+Onx4WJPPA6I5v98qNYnSSKD9L7SZkQH2xTrFrbHdxifYW2hmyk7Vx0/6QxjkDIDEHX9XWJd8LFI/YPCcaaoLGsMEKbDI2HzDRovltid9ltXQoW4xIvLkv3Wd27U0EMk5qXqGrUhYapPhBeL5d3RPPEF7IAioDN9pWRbq6fAEw/1wfpcsy1Wm/u4Pq9YTgW/6t6kOXJ+NXT1T4Sp4lZ+aFxU9J6Y1Swu9pUO0BhEglTEhCMnNgtHCio2umTsBOeeJlray7fxJYqUbEYpCDw6NAVNQ+oAFbFPJOGTtl6eX81MRiz0amDU5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvfuFRWPaRwlqWa54qQ0IXio3FqoJ8m65oadvsduej8=;
 b=C4XxoNWVzWUCsn4igE20E+OqSmFNxN0pao8+cEEfENYQ0GMSEDt9NI4YYi3pj6BcgQfEpRlBGIij0gOMK3nGVR5j+r0dFv+11yE/QnD6HfN0MScHYBqETv0/IIajRsZyF8hV1hEJxwpixF3ITVw3wic0m29N42QBfxlgNRaQ8IJiw6hKBca/azxhH5y6IUx8lK+4VSzb35lTasULFwiqoUDkNcz3SXIADW28FSvk1Gm8hx+J2qqasSePtPIcri+A4rbhtlN0XGu5/fIyuTjil6kZK24r/1O5GJk4Wde6W0xk9a+FobK0vgEr105SyaXIVjuAAhbio++5fq94ZWiRrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB617387.eurprd04.prod.outlook.com (2603:10a6:20b:7ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Wed, 9 Sep 2026
 10:36:53 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:36:53 +0000
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
Subject: [PATCH v4 net-next 12/15] net: enetc: add VF support for i.MX94 and i.MX95
Date: Wed,  9 Sep 2026 18:07:30 +0800
Message-Id: <20260909100733.1139689-13-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AMBPR04MB617387:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac90af1-171d-4ff0-c6bf-08df0e5e43a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|10067099003|22082099003|56012099006|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	LJNj393NUHGsGcoLCsB2mccB8lVQm9RDH874taxQXs2DTR9X+noPy+bzVNRKiSKNsjPGrbYVS4+xNNBFBtvG/5+63X3ZpUJEGXATAHGh6cfV292I90mRDJ5YVc4/XwwMwKg8cZAJA9eOBAbp7ZmpBSLuw0InFmGlbqfPSCHrK/WDOPTMBaM4K6VRzVI1JOM719DNikVR/34/h2zKtjGZOLgk0aFsr6KhTw62cRJDJnq4vnKsDIK87Dg4u0BynPi+gD8eyb2zdV7CpFLky4ADvGtXLB+9LRohh3ZQfT7TC9yEM0LTm/6ldect5lZ5v6img+zg2ZV8QvBvR0Q7QRGRgXqtMd8+xwGvVncej09/AemLYbSDIxCfx4tOCGHHKCl4eq7YeaWj5dFFiIJAPtWfQ4MHI/UWN4D1eb/C4ghltLbx+XGTDtQHsKGsCVFm/E9reGOyG6P8/qhyh1LfkSItFHDb/61/ehSLL8i1Mxs6XKKZYM6Mpm31wSI20J8PHAkiXquzKFvDID7BiTzxfD3g2Fknu/VtXJqHxWjoE+qAjORg/8UXzshXdpjp4lHH/8VyVSy0RfK2dR4mQejw9yXXakNxSeZPhD87JAbQ+cPkuxCqIudi95nGlQznOswOv7fYZ10eKr0rox60AwiXVsu+/WqayRthrffI9yev5/T7TPUqhNXm+sw+VkIb6Y0suxptyRacxqjFjLzQtaQ24zkPog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hl8ZozR/K2hfgztrejs66lmc+gsCwC6FhUCibQVA+U+eu4hd4rufJ0HizNax?=
 =?us-ascii?Q?yKZnD8Cu/PvEsfcgEoM+rj4AjXBr1MMuv6CWfMgVyiANfHhxFEQNi/NFlxD+?=
 =?us-ascii?Q?WUW1yGx0Wyv8NDzL2tFy16H6JXJD6bGxxcPjy2yi08vshgvGBvqlkgx/pcoV?=
 =?us-ascii?Q?HF3JZcN5VUTHbOZYfHfsvDSPW843KqT22I3E5+u+c6HOstfcccuFcXeysfjK?=
 =?us-ascii?Q?sy+FatiixFlt5S8oUpa9Vgokh5l3g+MPBTacmWdoNIv7O8r0ytg8JxS2btUg?=
 =?us-ascii?Q?lRlWI7xYSKxhCHEaCyBqfxhmY+AeoDD20+b8+yNKYuRwc1tva00Ks7QJ7Sz5?=
 =?us-ascii?Q?K+aa30k82TCm40HkdCj1VR5RWD7L7X6J7+N8EmsRl3edYcs9/IMasqabq3+z?=
 =?us-ascii?Q?zE/jpaFJ/fTXVeunB0kcOJRpsCFfH7W4awjV/wgdWd+FgG13G1JsybmrR4lA?=
 =?us-ascii?Q?P2eTtUrNtCivZJt4qoNpUMLn4tBkyFhBuPqWTV3ydXZNy9/cpKjimBe35CXE?=
 =?us-ascii?Q?Wzh0OOO8wDqVSCvM9jblgzpdNjzxrt1E6TCusmZgxOQMb4usV+QurwYC8Y1/?=
 =?us-ascii?Q?aTHOiMTK+Ltlofi+lHP494popwdfs89w0V/rSMsg3qD1WKgMowaAOvNx3+oa?=
 =?us-ascii?Q?r74fI7drwV1iXq6Hxt7eKmsxvkPrL7MoYjVxXz6r8enyt74kTf0ZH/H9alA6?=
 =?us-ascii?Q?oveA5zz/QMFW6RC4FRQ+1fKCiF7ti2xl5uwXXgRlux57uoIPhW1jPiu3otFU?=
 =?us-ascii?Q?JvBFDvPOA41ht7eN98jtT2SgpVBdU5GijQUulXJJxXQrMUMTxFm9Ls0zH4/k?=
 =?us-ascii?Q?aqtmSOBr0EIJ8VfYCkzh5t6IfJi/h7CH7Z3tjSNCiAeeAdtpVwwH6J2azqSo?=
 =?us-ascii?Q?gD8zlkDifBlIoDN0j7jxj1UJLfY+VHlqe3CNH5vB3w2uKKxRoAV1eUzISsuK?=
 =?us-ascii?Q?zlDoSuN44voMJVCXeNk8pRZHIki60ZpRXxW0xpgImloKNCCzF1Xot6RA4V+O?=
 =?us-ascii?Q?sDv3PmerC0by4PONYjNJvInPBfPh8mX4EMex8e/wQCVwLDt0f8ylJvYLJHbQ?=
 =?us-ascii?Q?Qj5asdz3xOxuKcBqm6TFIu5KGCh6F9AwyP+DF99QwYHJfRFtUgul8Ix2fJEX?=
 =?us-ascii?Q?Lfj6u7rcQSY7tUO4vxH9xKnib0NA0Mv9yb6yFq8+UkzV0wwldmiEYQK3WF/l?=
 =?us-ascii?Q?oyTt9pNTimRK1/rOtJk8S7i2KAGHxyWAcpKON3loVSqUvPQzeZ2RyCgvBsPq?=
 =?us-ascii?Q?jVRdR9SitE8nG8TDjk/AsHKwUTgPUPkxaXjUgaJ5iCMbardlFN/luDnp+8x2?=
 =?us-ascii?Q?Eu7itA0vuwTE58+/er2G29tQNikR6BPZ1H4JOynAPX0Yk0Fh0zOGpPefnPw6?=
 =?us-ascii?Q?6QTrMDThrIfrDl9GjpHVL89uIVpHqEfoyytgI/T7RMN3vFIxNSD1PNNCpDK9?=
 =?us-ascii?Q?TBmOw8TNr2enr4UdTqB/taX5obrg6OM/6QwBM1GzAR+ZdyVdTjkqIAEeutaP?=
 =?us-ascii?Q?LE1rH4mU2Ya+piPSpTeH4EpUtF/eEJzplPZp6kYPX/fnifEflE8PpD0jDy1h?=
 =?us-ascii?Q?OkgQueqUCsrVPRLMM/qInDfhpzJOB72nezZeWLIqS0FAbwUIXEcY0MlDQbDz?=
 =?us-ascii?Q?TGAU1iyhVCmFMW4sNWWbRVjsSWhJLQgUcbpjUYgiEIhHb4CEYJjE2vuhsdWW?=
 =?us-ascii?Q?QDgN46OIl/o+GSsV/kCsfDFO1fxIl/uyc6ia3UcIP/IREv/nXo9MicMvJ9rZ?=
 =?us-ascii?Q?1yGREGjxPn3dln9aF07eBsuldM96ASsTyG/28x9Xw7l/ji1Pw7Bq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac90af1-171d-4ff0-c6bf-08df0e5e43a4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:36:53.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaevNIo90Y0sW9ulxvIx1h/779XhKs10ThNQdaC5l/WyVo9MdIFO8ZFb6QqLpdgvCYncoG36oJsLQwa0quSshxrxXuVzFT/duM2T1Mi+i+HexXyDB9+dL0pxCNuoBuMx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB617387

From: Wei Fang <wei.fang@nxp.com>

Add VF support for the i.MX94 and i.MX95 platforms. Compared to the
LS1028A ENETC, the VF device ID is updated to 0xef00, so add it to the
VF driver's PCI device ID table. Also add the enetc4 SI ops and VF
driver data, and wire up .sriov_configure for the enetc4 PF driver so
that VFs can be created and torn down on these SoCs.

The number of VFs is not decided by the driver. It is determined by
each ENETC instance's SR-IOV hardware capability, reported through the
PCI SR-IOV TotalVFs field and configured by the SoC integration and
device tree. The driver derives it from pci_sriov_get_totalvfs() in
enetc_init_sriov_resources(); an instance that advertises zero VFs
simply cannot enable SR-IOV. So there is no driver-side revision or
device-ID check bounding the VF count.

For reference, the per-instance VF capability on these SoCs is:
 - i.MX95 (v4.1): each ENETC instance supports 2 VFs.
 - i.MX94 (v4.3) has two kinds of ENETC:
   - standalone ENETC, the same instance type as on i.MX95, but on
     i.MX94 it advertises no VFs;
   - internal ENETC connected to the CPU port of the NETC switch,
     which supports 3 VFs.

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
index 6a9b1e079ae2..24c1fd869c2c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -1158,6 +1158,9 @@ static void enetc4_pf_remove(struct pci_dev *pdev)
 	struct enetc_si *si = pci_get_drvdata(pdev);
 	struct enetc_pf *pf = enetc_si_priv(si);
 
+	if (pf->num_vfs)
+		enetc_sriov_configure(pdev, 0);
+
 	enetc_remove_debugfs(si);
 	enetc4_pf_netdev_destroy(si);
 	enetc4_pf_free(pf);
@@ -1175,6 +1178,7 @@ static struct pci_driver enetc4_pf_driver = {
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

