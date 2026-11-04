Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784422;
	b=efbBRdhzT53L52dUwQe4zSADWvx3q/4Bk1MaSZx3/SF6ke6oEVuw4hz8DuD0Kg8IWEeE
	 DzzohaVMO/10AcpRp46Z2k0zSi2USbMhdeiARy7bWhRcmlMVqNYkQVNa8o43y4SyxvQ7f
	 duUj/TEh132vOhNX6uzHI0ZcFoY5lCMXzh4vXfk92Yo8FAFPFeUMiS5Rzo/XQxZJdDv7M
	 taTCzik/KWU/aFK6isqgewMDp2Wh7lXM1nhguuAPUeLP0kzgvqRg/GK2LazHH8o5Fv+gk
	 5mPXRwOYbvPi941fs0CuPFV71zL7AQnqGIjM9H9N71hZNC4HhyfdaIpdmarqVjtQ6bQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784422;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1kZKljOSU9Gpxp18mCjcoRE1zYq6GzmBNFPS7GceyQU=;
	b=Nred8uMJ32JHugiwLmr/SdVArxLt2QKo07lvrv3YQjpKULF8tGKmdbAcmwU/6wQaGLWp
	 8IoLlLhXhmMqsM1tT8pj8P0B4FLLHlXRPGYVYgjhMlzvDTW14dnMfW6tA4j7fwIfPWFVk
	 u4nqH1HTlGYuQiPEXrlfnchXrRxtxwvslE36uXxpdzzrK9lxHTL81Xw2oXMDhqCePjth+
	 P0CFWov9dFzJn/8sFNkEfzvr3UXDZ/+EHAYB5jVTvv1WIcny81VNioHOSBuf3/tkIzpNb
	 xLJ75B4zvKPsGJUi/vPfutR73TcU7pxWVqEqH6QWaOQJJGt4hGAUOr5KpGiyeWg4xOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=N6CJttgu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.42
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1784C606A32D;
	Wed,  4 Nov 2026 09:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1784C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=N6CJttgu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A11XpliOhV1ffX9NDseczPcgP/LM/Xjlc6WNjE/N5K4s41RYWAmCSLzQ1iLFr1xbWbstDdx6lidHHzjpMTIhOaKnYb9xXq6/B7RjGr3EpTuf9wYUO20F3V5gnknM/sykm/lsfL1H9+v3C7SHxg629GN3twPQcEn3YnDld7EB+NUxhPqtLwgl6lk0H3ml4KWylNAqxsS02pmApnhOYll1FP9KMuSnvsXgSwi2iVX7vQ6eprDMLhPsUwHh++rBtfewE6JwNdLVpUVow7TNPPcEqcnTAe+2eztlyyP0PPSfvqJ3MDqsNyP+su7lGNMJj9iCVgwc4YVB1tQYtRHlSpzRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kZKljOSU9Gpxp18mCjcoRE1zYq6GzmBNFPS7GceyQU=;
 b=XkdgBIzTInR0pgbeGlPcUsZLNuuhwd5xe0dXu8c77h+0++w+1O94hye34pbtTOCuVpsaX0aGzLZ0Zt6CNdkWOPpeWuZ6gXM1z9WuCifzLxX9rSSW3BHEgzYT3DVEqzc6DM983KAahRocInmSRIOYFvIYvJ20kbkFM/0ESbnhSdv3oUgvJhzIvFDE7m75/sNCh9ZgaPkxIMQ4o1y1XJC9wY9rNp+HULs3MppF7seMl89W1x8Vx7pSVOa4FlVdsjI9QyNppdxWwNdpV/REn5XuJ0x2bYFsscCFEB+VcRxifMIRg9wgmHPmsdTpJ++gDaLz2Sd8cE1/0ziwl95L/9kzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kZKljOSU9Gpxp18mCjcoRE1zYq6GzmBNFPS7GceyQU=;
 b=N6CJttgumzSX4i7xtfu6e1YxPE+vktiOuuLoypyrxX1qRFU9lEfpKaH2SmFWzM8eOmSVNi7G6qabTDTKuHK+rSCWhRCtgmLoVPEGfSDb7EfnC38+BNtlbNdfTmxu1M7CKKzDuNOu03g6KqX+ij8PBt1fCjmyiwPnP7qRNHBVxK17nF8dNW/JotVIUCy3WRuZEIcR2HoBC9SMwfOLqotsRuy1zXbWmPeQVHJgqX8XT6lWkgjJnyt6aSGpuRzE33x223pV6qTpa5gcSasjljnhboeSYMRlyq+sZDcJna2ncAk88f69JSeI3n+hpoOCs2CM5fblHgdThK7I5eZGtcuQ+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from BR2PPF9D47B45B4.eurprd04.prod.outlook.com (2603:10a6:2d0::cd)
 by AS8PR04MB7494.eurprd04.prod.outlook.com (2603:10a6:20b:23f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 09:26:57 +0000
Received: from BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 ([fe80::6e42:6ee4:6b13:69cd]) by BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 ([fe80::6e42:6ee4:6b13:69cd%7]) with mapi id 15.21.0546.021; Wed, 4 Nov 2026
 09:26:57 +0000
From: xiaoning.wang@oss.nxp.com
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH net-next 2/4] net: enetc: add i.MX952 NETC blocks control support
Date: Wed,  4 Nov 2026 17:22:15 +0800
Message-ID: <20261104092217.1730351-3-xiaoning.wang@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104092217.1730351-1-xiaoning.wang@oss.nxp.com>
References: <20261104092217.1730351-1-xiaoning.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0113.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::14) To BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 (2603:10a6:2d0::cd)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BR2PPF9D47B45B4:EE_|AS8PR04MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e1eda9-a315-4bc9-72ab-08df3a55c5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|261028144727099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|11063799006|10067099003|56012099006|22082099003|18002099003|261102123227099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3eGQyBwgtiZYSBfi7j4Cx57hjG+Ux7aH+P0Vjk/Bk9djgwACjK0JsjDsB15602FgorhyWDdY5sM7RrEuFY5rkNKuOlJvz5pDOkP0LNW/OYqttQ2J2tQDZk31eGhq26Nz4vtJYwQe9rqWiRXP2bDVGOFrASm15X31zd7T88Ekzlz9adnKtzdPWASOpv+VG+nGvj/8x6pomZRJxmFrsjSRJm3IABhCZ7EvSmol0+WAT1e6Z5vA//dRh9GKROidRZsiisASy9aIkNfLWWk+rxRQwo3BeuGny+CuI9BX6X2JZyylCuw+6ApRwsBEMD912WhaKIm1xWag15gPvzCoaxg90xRKdkv8uWZ3fU602vspRsyV5k0PlU1KgOmwLu3ivIdkEdgyCAJT3ge63/DOod2W+RRCV5nZh2tmqhG31QcDkxAGxIyp45Ud2d6tR9Xo7vOJEpWRUyv9ybmoJDCvLCNMi32j5rLIc4Te0jSi8cFQcYwlJOmFZN94BH/qwIvicJQocDmGVsSkC6Yys8+JNG+Wa+DwhnieIdijYlKsgQtnLdcWFPxxV+tz3yGVXxkfSSofycytCV1HuKEwat7EOpHA3MCRADuCc6KwIrdcJMAHKLdgEJA6NnGvku5Juz2/gBs94OhAfddj2F8+9sw0N1S9Tx5JM57ZLysbYm+rSyUwjtE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BR2PPF9D47B45B4.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(261028144727099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(261102123227099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjL2Vn0K985hSYtIvQ/aDpq0xa1gDzwEoHj2P699ET1iE8sYjnNrWoy5N0n4?=
 =?us-ascii?Q?6ZH2lL/4EZvUFIZgTqwf+UqVYRPfO/sfFEnEWORp0r0X8EJedyRGp6QuY9BN?=
 =?us-ascii?Q?ebK32pjbZbS+WIZA7PQPheMgVfMOW2RwJtDhSnX23QnD7Ir6r5VvQMgFQJQU?=
 =?us-ascii?Q?e/91p0fKNWrt/i+RVgbML4NZJFQW0Fi/45HfEOzpeVeavvoKQBVi0rv+1NPr?=
 =?us-ascii?Q?e0NrOVH2/1PfGBLvgy9xIZUmFHzouU0TH6nTvTQhK2HgmZAucYM09DRT6u4N?=
 =?us-ascii?Q?Evh+GkS6T1svgpVL3PrPxVEo8nQgmfGvGnn7E+0fQ17tZr4OPRDbbzBo9XVG?=
 =?us-ascii?Q?b1n9B4eJSCuJp4J1w5yjMSUmf6lYMSdt8hQySmMFx1OL13NYe7ZwVGDYMgqc?=
 =?us-ascii?Q?iWOiEPRwx6gbwnGIA6iV+rMIEbj6ufaA2pHrBSaq4fevdNkpeKDfTN8THHSA?=
 =?us-ascii?Q?yH/ZefXnC1rQUmT9G+9lQur2WLbF61V3uaD9mv3p0xX1uRMBlR8I6UgKVLop?=
 =?us-ascii?Q?uJ6xg7tDQ6sqyte3U/HeYJxzTMbWkhyYcOwc/X8aC7XyYmObK0XaAT86AtNP?=
 =?us-ascii?Q?lx4MnWIV2F2vp5iyxeFPko/3qaMo1zgcYF5w/dttiwOL+CY2D7HGM6HTBaID?=
 =?us-ascii?Q?hPpK52++TNWftLAsTVQIO+C8LqviitNQIr9ooyaGUIZlW2+A5gEgU/6Kl73n?=
 =?us-ascii?Q?FMyrmWRnPU6cID7gko/MjBikb084i0L5HNXvuuGPPIPbxOGukdgsVD7agsEE?=
 =?us-ascii?Q?MJ0bF03GJ4qx6X6Qa2PSgfGSDv0PF+Xm595UlQKPEPVgWLUWe9LfHScteaMz?=
 =?us-ascii?Q?NUZfmttAJXep3AAHph58kq2G1fdVtqqblavEiFezzqksynJkvCXsHf7zU5tq?=
 =?us-ascii?Q?t0GYn1Xon1tqhdxqXDvwxJXH8XOh28cE4D6AUse+cslJ5zBU6dcuoQV8maLN?=
 =?us-ascii?Q?hnRIKo+4ZaoQaCDqw4nWDbbMnDGMpkXR2jA+3RQx2QFg75Uj4q4KvrrCd7/T?=
 =?us-ascii?Q?3BbXrX9Ze8mARI+YtCppT5pWR+tsY2+GpSYV48mK1StqKfj+hjbL/2m4PZ1k?=
 =?us-ascii?Q?yF1O9YI4gJnIqqEzJGdTU5vyohvcpjB4Zh8CfYqPlX7euBlWqJkGs/n+Mz9r?=
 =?us-ascii?Q?L8MxbWx1zUf6Cl8F7u3jbHT2FGiWG3bbeUvV2sAS4QIk4Qg+HDgni8CqcOD+?=
 =?us-ascii?Q?wy0kzIC1lsN9w2WJ4qN6hCCujlO88iE7aqm93T43bnprvE2Iltpznxb4Zn1A?=
 =?us-ascii?Q?ebNcEgyarc4c4fpIlqCwpw5HED9rX8NWi1i9oIMVViWylePs7i/3X+YP7Pxy?=
 =?us-ascii?Q?238dJR7Rdv/Bkl21yaMv4zM8cCIfWcJ2oOefHhBhAogFeU/peJHaTtcbvdN+?=
 =?us-ascii?Q?BrA8tfkLPB+FgD8+RADQONgrX6D/PZeVU8ypsSpR204PCSHQ7cGCy9/Hz9xt?=
 =?us-ascii?Q?nk4PNA4cYPkRbmIsjxTnE5wDy8ugbv4TZv6Pd+hYQmL7XA4s7pV2WlB1lWyi?=
 =?us-ascii?Q?pf6O8oIVwGW+hVXE/a8ZvlvObs5wlOAfLAigJzGPuSkQvGoNtzw64p2TJtTh?=
 =?us-ascii?Q?uvhnWrTEiuDRZwboV20xtX4KXw+Msx/c2Cm8ogkzjVbFsjiLRbjb+rW93I/2?=
 =?us-ascii?Q?jGyO4IOo76q+/sGEDE+UUAb9qX3a4qYJUW44KtJCjnZHLfBMeHx4i6Orr4OT?=
 =?us-ascii?Q?tA3TpCKCXrBhxCIJXQdq+JolIVyFhddgY7sD0kX/5kufmdh0RjG15kmeBaFG?=
 =?us-ascii?Q?IiLt7OTrahr+w99FFd8Xv36YURUNXqS1SFQ5U7dP/vsJ0kB4576l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e1eda9-a315-4bc9-72ab-08df3a55c5b6
X-MS-Exchange-CrossTenant-AuthSource: BR2PPF9D47B45B4.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:26:57.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbqlfO7y/7XktPzW67RWjJPx402Nh+85kk/GbT4oFW3G56nDLOwXiNHx5/g6l7bfaVBIJClBXt54X1gPpTPU0PmL0565SWCzMorhSTv8TOZvlG+sOMRTxKjXaxv4C7rb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7494

From: Clark Wang <xiaoning.wang@nxp.com>

The NETC of i.MX952(v4.6) has two standalone ENETCs.
 - ENETC 0 is on PCIe bus 0 and supports RMII and RGMII.
 - ENETC 1 is on PCIe bus 1 and supports RMII, RGMII and SGMII.
Add the netc_devinfo for i.MX952 to do the following pre-boot
initialization.

1. Set the MII protocol of the links in NETCMIX according to the
   'phy-mode' property of the ENETC nodes. RGMII is used by default.
   The PCS configuration required by SGMII will be added separately.

2. The reset value of the ENETC 0 transmit byte credit registers
   (E0TXHPTBCR and E0TXLPTBCR) is 0x5dc, which is only suitable for a
   maximum frame size of 1536 bytes. When jumbo frames are used, the
   byte credits are exhausted too early, so HTA has to wait for the
   credits to be returned, which reduces the transmit throughput. So
   set them to 0xc35, the same as the reset value of the ENETC 1
   registers.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index c7eb0234c785..7320ea0e713f 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -67,6 +67,8 @@
 #define IERB_EMDIOFAUXR			0x344
 #define IERB_T0FAUXR			0x444
 #define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
+#define IERB_ETXHPTBCR(a)		(0x3070 + 0x100 * (a))
+#define IERB_ETXLPTBCR(a)		(0x3074 + 0x100 * (a))
 #define IERB_LBCR(a)			(0x1010 + 0x40 * (a))
 #define  LBCR_MDIO_PHYAD_PRTAD(addr)	(((addr) & 0x1f) << 8)
 
@@ -89,6 +91,10 @@
 #define IMX94_ENETC1_LINK		4
 #define IMX94_ENETC2_LINK		5
 
+#define IMX952_ENETC0_BUS_DEVFN		0x0
+#define IMX952_ENETC1_BUS_DEVFN		0x100
+#define IMX952_TX_BYTE_CREDIT		0xc35
+
 #define NETC_ENETC_ID(a)		(a)
 #define NETC_TIMER_ID(a)		(a)
 
@@ -368,6 +374,56 @@ static int imx94_netcmix_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int imx952_netcmix_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	phy_interface_t interface;
+	int bus_devfn, mii_proto;
+	u32 val;
+	int err;
+
+	/* Default setting of MII protocol */
+	val = MII_PROT(0, MII_PROT_RGMII) | MII_PROT(1, MII_PROT_RGMII);
+
+	/* Update the link MII protocol through parsing phy-mode */
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
+			if (bus_devfn < 0)
+				return bus_devfn;
+
+			err = of_get_phy_mode(gchild, &interface);
+			if (err)
+				continue;
+
+			mii_proto = netc_get_link_mii_protocol(interface);
+			if (mii_proto < 0)
+				return mii_proto;
+
+			switch (bus_devfn) {
+			case IMX952_ENETC0_BUS_DEVFN:
+				val = u32_replace_bits(val, mii_proto,
+						       CFG_LINK_MII_PORT_0);
+				break;
+			case IMX952_ENETC1_BUS_DEVFN:
+				val = u32_replace_bits(val, mii_proto,
+						       CFG_LINK_MII_PORT_1);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_MII_PROT, val);
+
+	return 0;
+}
+
 static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
 {
 	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
@@ -783,6 +839,19 @@ static int imx94_ierb_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int imx952_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+
+	/* The reset value of ENETC 0 Tx byte credits is too small for
+	 * jumbo frames, so use the same value as ENETC 1.
+	 */
+	netc_reg_write(priv->ierb, IERB_ETXHPTBCR(0), IMX952_TX_BYTE_CREDIT);
+	netc_reg_write(priv->ierb, IERB_ETXLPTBCR(0), IMX952_TX_BYTE_CREDIT);
+
+	return 0;
+}
+
 static int netc_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -882,9 +951,16 @@ static const struct netc_devinfo imx94_devinfo = {
 	.ierb_init = imx94_ierb_init,
 };
 
+static const struct netc_devinfo imx952_devinfo = {
+	.flags = NETC_HAS_NETCMIX,
+	.netcmix_init = imx952_netcmix_init,
+	.ierb_init = imx952_ierb_init,
+};
+
 static const struct of_device_id netc_blk_ctrl_match[] = {
 	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
 	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = &imx94_devinfo },
+	{ .compatible = "nxp,imx952-netc-blk-ctrl", .data = &imx952_devinfo },
 	{},
 };
 MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
-- 
2.43.0

