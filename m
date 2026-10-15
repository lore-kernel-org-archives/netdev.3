Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768004E323F;
	Thu, 15 Oct 2026 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061770; cv=fail; b=P/YiNfFg+xD9r4+gWnycqx2tLctEmPZvBvpDnu8PLBKwSe8gQm4Oadb3PBSfUNCb2O8ZImiv9VYgXCOF9I8jK5Sc6Vpq/umyHRzYwtt0xTOBMhL8az29niPTn188aNFIl7mQS/dSk13amu2mcvSDHlz1WC7vmrWIb/PzKstWSK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061770; c=relaxed/simple;
	bh=tDFq+3FMo0qtGmLyNvlsP7nyzbdN0qx/zSHzBP2RfNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mHSkZJXYTJGn7Gj7qfU+hMgRKNtKqR7DjT0QHp54i62Vx91jIUm209jgPlMuypRz0oiUEssQBp2RTk2k4NGNk0ep7XRb5tIJLJZ6NaGlYF5Ijpstu5hxYUY4/4/QBJsE0i4Y+1z8u6UKPISNaY7QNMpmGjgSk6lnR8KOPVzxUkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m7zM0v6Z; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m7zM0v6Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeYlX+jGO9/gAjWDR3AqJtNY6pNZUfjEDGgjLd/+dBe9VjRHR4PCi7fmHtppT8unDeG82kNdR65FsiAfS9bIVRV2ZZikVbGCsH9sTrch+2plstz3jL3UvbnhC6IRIVB/k02EkyrYLwT1ToiZC/uW51ZvhkkGe92DfizAoWIJ3AggsOUMvITWVoO1rCRCx8Bd7ObLoUPUQVAif420jrB8ArYA6zEZdRxPMrJbOvoZS0/MWi8iCTH5pfHR3uZ2lHCXFh2DdXV6Ny+Ws0cfhAMULhb8PRqCTlp2nlW+0Hbf7czaXPNkeIHaDVv3vP5BCAG+zuRmU/m3EK5p62eDYP8Bzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dq55UUh2TLFkzGZ02GYv7GC3AKTDwssjvfiPAeNYOms=;
 b=D27WY2C39p3H1kOLpX6923pwSX3wno/hZY4a8aCbTmfCRiPqL9UTQbEV8lzDiZ3USXLYZSqBO0qJHwx3PDGSfQWkM6tQf+U2yuZKIi60jFaHMFd//9EywCKV4kD2DF6JgVZ+mIwwI+NxybS6t9cJ3COgfpbvEXiXvXV7kdPMUlpbgWcFgF2xPtTlHRZHx5gSooIZBNGanXIq+gk1zDk/6VXmRjNCULhOtknS3WJvuqfpiFMN552mfIu4TPl3hsbPykUQoR+iSes35ZI9jG6ZRPE/ls/EamoTnUXW87+eCTkoOna2OuPABIUfJStWiWDD2oZVRs2FRPGzIMb0QG7YOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dq55UUh2TLFkzGZ02GYv7GC3AKTDwssjvfiPAeNYOms=;
 b=m7zM0v6ZK7bRo2RzSdSd0NZr89Yh0JZqziLXLvkAnEuhgZUfUed9/J//+XgnQr2VjiaCJdabJREesDeoYP0Gq8wQNJ9CP77NlugJSemKSOZXMsU00ZD5YGUjiqq/IaRyLqBuN9HXdM/ZULQdTkfR6F7ApiOduv5uQGNHcbT7EFgRy+IufOqZmoqMK6vU5RL5Apz+mTpN5hOPiKueUTbcLEAwJOCLgP4x/9aCHX1vOjOk5tIvjS7d6zHfuChgRdD+IG2oDzzZbyPNgQXeGWEfyTOKxWysg9Hdvf+204M1sHAgtAEwe6IB5ByeAtEk+xZMsh/JZ593DBhD3PxbSpojwA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:56:03 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 10:56:03 +0000
From: vladimir.oltean@nxp.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Zefir Kurtisi <zefir.kurtisi@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net 1/8] net: enetc: consistently track dropped frames in enetc_xdp_xmit()
Date: Thu, 15 Oct 2026 13:55:29 +0300
Message-ID: <20261015105536.1692348-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0008.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::13) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b18076-ddd7-40ed-7745-08df2aaae7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	YOou80IOPE52UukzLH3leXcVD2nkAiA0hYE1e+RAPexWc36jEGyw8xiRjQNntuRV+jxGtjaADpBbZsspppemKsoe15WiaDSki7YBvwdURRrWExwS22VzZInzUMF/y6fKy5G68o5XL7J77e1hIzocQnOGHy2TyF8jCgLkEvxvma2WKYL3FX+oo6vafNpwNWQL+YubsZl0ime1d9MCvTLH0858m7u9ub1d8AQUkfm0q9Jj5sR/nefVIhCfmcb9PNpNqMZBJqsBmwK2JbLeHNvB3eznU5J/O7t3+9lQmhsQRc1UpoJ+EVpfFfdFr8Pxaq0fW67ZbNMaFCkKbZOrgJxNp6UyL7MddSak0m4Lv1lvIne9JePHMYPphQJNhmD1Q5KzOSimJRkv/w87Nsmuz1lORS7Qjh7igoqGOdj9/HQOqMOUodOeYTiJS/cP6OBWmXDbsrRJOjcnhjQbGqKMU3zUInxiypXA0GApWsSPYhICKYns+QEYp+EAoMcO6iP6bD4WXJLn3LL6C5FKoXQ5IvanIHcAR2Za8zivG43p+ArznK2UvtXgp0hB3lyLZ4zmMEdUvh1AyShRbvxi4hPmgNFAYwv+ln56g3VdzoEM7TKkzh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Asrix8zLLixl2EHexUxdaRJNgSwQrvO5vopXAE1cT+eQpRoxCoX05HYFH9kK?=
 =?us-ascii?Q?asTpA2DAvkeWt8acdwn7GO4sJguocE1NLOgjWKHbQU1vV9C/n8+NZZyEWs5L?=
 =?us-ascii?Q?mxNkgJ00GTKcFb94QDTYpD1pZA+6/TlxwzKIHWEtxUAL977V1i1qE+dSZ+sN?=
 =?us-ascii?Q?sxsPIxf/15K+oJnYFOF2N9kDmMcSfzZjbEVYuPNJjVmgbATr2bUGVffhq2/Z?=
 =?us-ascii?Q?cqn0tr3X4Juj/10jl9mlQnBBtL5S86CG7zFMh6y7Vy1CBbJtQ0iQl9ugM6C6?=
 =?us-ascii?Q?uY8zKqoWOe9l/61SFF13tIaPQW+Lk6zdmoP45HEpl/APesc2ExJDeFoQLAXQ?=
 =?us-ascii?Q?kUiQZj0/DmdrMb3E5Hg09EuIFloE8+8PtTCRohpj8U2Ql6oJVjURQTnoGW7A?=
 =?us-ascii?Q?AW4RkEo7GZ1VmFeDjjsqjBo0gzuZZAjozxr0YJQztjAjg4gv+ItFW7EjcCkc?=
 =?us-ascii?Q?jrkXJyh9FkZnlrOuh9RPY8ZysrX5xFJGzyfUExSKD8qVsop8InGJ2rToeab9?=
 =?us-ascii?Q?zpkHJq0GZVOgk3NG97jUqfyl5XQ5BqhWlVNhMv5rVvd5LhK7BKkFXRwCVN9Q?=
 =?us-ascii?Q?bDTE+G5x5opWTi1c4adCP3qr2uMTQ2u4yvXyvOLNqRIu6YVZ60gxTFGRH0mI?=
 =?us-ascii?Q?ybd4fd6LN9w3Wc9SOUR6ps26jSJeAhUTpWuSKbwAiz5RLMVXIeddADc1Ppne?=
 =?us-ascii?Q?ejMcApbeX9/zsRpW8F2Cs9gO714zb4+3r7T60231VECHASgFbS1ar9RQ8vns?=
 =?us-ascii?Q?wW+W09DZCCG1+P42GDy5Fd2M4Rus2RwrEbMPGautq8Euqn+qkUL7AfdGw6Pz?=
 =?us-ascii?Q?iA+2iyu6BoMHznodfZ6w6GZLiGIbCTNDYV1Z4Ob9AmG82zlNA0eYr/gDddfx?=
 =?us-ascii?Q?WKVfzRT/ukvnja9jAp/ZPR4urHbw3lR5B9eFTvssMCK4NdadGSzI9afxiA4m?=
 =?us-ascii?Q?t72fNbWyCKS3ber2PwkC0rxzF/GjHr0zddDDMqdAqIyNNT2GeEEEKL28I+FE?=
 =?us-ascii?Q?u7yWDy4wMp/GR24JBkaW6H0viojSaL2uotS8fVDmAjdjM1dzE2ygH++J2N7n?=
 =?us-ascii?Q?Gny644hKV+d5w8zAe7tvZvcNtXy15BmHNgfd7DiAuyiFRk8ZAQQ0JBIFyOLC?=
 =?us-ascii?Q?uUN5EC/16v7Oy5Zk8OcclMi6D60YzQn5nImBbk5vGt6cx/SJKCUmfKmtCEx0?=
 =?us-ascii?Q?uNjABZlTEZHUf1QbcT+SXfzwin1RenX8Z5es2vhkOm+flG+zoLMGZUeu2+4Q?=
 =?us-ascii?Q?APBmUYbH7o6K6Tpyv2DYXsbAsNyrsgUv7IDwIY53U4Wpsv2B1J5N523q7uUT?=
 =?us-ascii?Q?FPdN5cmzZWvLP1Rc4ZN9O6kj/JVgObGH2y3ztHVNQhQu1HfQriBmsdhWZ81H?=
 =?us-ascii?Q?DeTXRaNIBbvLEJi2HC35NNJKkVpk3aU/MpUUWcSzG2sN3K79W41On7AiFKXG?=
 =?us-ascii?Q?aOrI5RT9EmxfrSJXjWuHmgUXDS6t/edZ0rpQSNGb8iLV+lnru/9cG8PaxulU?=
 =?us-ascii?Q?+N3QkOGRBir1ZKzowoAmUFH6g2y7dg7XPrtdFYSyycpAEDUvQUBb7fizaYN/?=
 =?us-ascii?Q?aumQBeyoCSv5ctXUIqhdPaW7Gz7af0PoTIjcEu63RylFk1cb7/2FsES435ua?=
 =?us-ascii?Q?aNj/quh8Dq5Lcy9wmgTe06q41dJzgnNiXMgGnGt357E9lLjfHVX5FWCpWCUU?=
 =?us-ascii?Q?DznMhIJM1Y1Go41Rx7jk0cR/bAzDtMARPQBRjoQo5vKOfG0JspvIgmXdAqt1?=
 =?us-ascii?Q?3py1F0KU5w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b18076-ddd7-40ed-7745-08df2aaae7ee
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:56:03.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxLeJ21JiXOxj6SFkqNW8OX4rcQ3jBZ8dNrnRg0CURgwRjqVTt2MMneJpS+SYeNVeL+MvYzDd12rtiF016xS3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

2 distinct classes of problems:
(a) the following events from enetc_xdp_xmit() will result in the frames
    being silently dropped without any counter tracking that action:
    - failures in enetc_xdp_frame_to_xdp_tx_swbd(),
    - frames split across too many buffers
    - frames enqueued while the interface is down
    Similar to how enetc_xdp_tx() increments xdp_tx_drops, let's reuse
    this ethtool counter for the above cases too.
(b) enetc_xdp_tx() failures increment xdp_tx_drops by 1, but that is not
    necessarily correct. Wei Fang points out that on .ndo_xdp_xmit()
    failure, bq_xmit_all() drops all remaining frames from the batch,
    not just the current one. So we should in any case increment the
    xdp_tx_drops counter by the remainder, not just by 1.

A limitation that remains is that the xdp_tx_drops ethtool statistics
counter (already) tracks XDP_TX and XDP_REDIRECT drops in the same
value. We should distinguish between these at some point, but that is an
ABI change and is out of scope for a bug fix.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4:
- make sure the ENETC_TX_DOWN case also increments the xdp_tx_drops
  counter
- reword the commit message to enumerate the cases of silently dropped
  frames
v2->v3:
- patch is new; replaces:
https://lore.kernel.org/netdev/20260406204122.167237-2-vladimir.oltean@nxp.com/
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e91ba77a1532..103335f3d418 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1811,15 +1811,18 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	struct enetc_bdr *tx_ring;
 	int xdp_tx_bd_cnt, i, k;
 	int xdp_tx_frm_cnt = 0;
+	int err = 0;
+
+	tx_ring = priv->xdp_tx_ring[smp_processor_id()];
 
 	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags) ||
-		     !netif_carrier_ok(ndev)))
-		return -ENETDOWN;
+		     !netif_carrier_ok(ndev))) {
+		err = -ENETDOWN;
+		goto out;
+	}
 
 	enetc_lock_mdio();
 
-	tx_ring = priv->xdp_tx_ring[smp_processor_id()];
-
 	prefetchw(ENETC_TXBD(*tx_ring, tx_ring->next_to_use));
 
 	for (k = 0; k < num_frames; k++) {
@@ -1840,7 +1843,6 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 			for (i = 0; i < xdp_tx_bd_cnt; i++)
 				enetc_unmap_tx_buff(tx_ring,
 						    &xdp_redirect_arr[i]);
-			tx_ring->stats.xdp_tx_drops++;
 			break;
 		}
 
@@ -1850,11 +1852,13 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	if (unlikely((flags & XDP_XMIT_FLUSH) || k != xdp_tx_frm_cnt))
 		enetc_update_tx_ring_tail(tx_ring);
 
-	tx_ring->stats.xdp_tx += xdp_tx_frm_cnt;
-
 	enetc_unlock_mdio();
 
-	return xdp_tx_frm_cnt;
+out:
+	tx_ring->stats.xdp_tx += xdp_tx_frm_cnt;
+	tx_ring->stats.xdp_tx_drops += num_frames - xdp_tx_frm_cnt;
+
+	return err ?: xdp_tx_frm_cnt;
 }
 EXPORT_SYMBOL_GPL(enetc_xdp_xmit);
 
-- 
2.43.0

