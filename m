Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACB4D9553;
	Thu, 15 Oct 2026 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061772; cv=fail; b=lsxennmJ3xG8tabqWT9Qo5afC5CppAXrQJK4rqLCZ1SWIPRRBAf9L+VKCfTHwznswrE980ztIdOrqygHA3wuSyB5+k2NPoyUMwbJI+q8sTpPnT1pkUZT8lEDNEGwUvIyJ8z+CcLDz/YZTZIddaEpfVa5gTaR+d8ztRxFHH/M2Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061772; c=relaxed/simple;
	bh=I7Fjo5Tdeor3LVR6RkmqpyVp+t3zXjdAStrj1Yi8peg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iakPWcb9C8dcPimMImGpC1UIePSHwyTQ8BPKhQhNX6qhCk9p3pG8kkIsy7tymwhCJedTkL0beRJWFIpUOFuqVW/4Rrgnr+9ZdyD/Yf4txA2PKlOTJuktDRLsAHlMIF2d0JQL10YzjmhWiKHvljN2+43cpdrd6AJZ+XssnvSJoYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AHnm0G3U; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AHnm0G3U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeT5/1PP+jQKxa3ZqljthAlxsthAVUgINBj73y2NkiObwpzf8m3Kgk/JRbai3+1zjBePAlAPuG8uu4giaC8i5eDAvL6UNNkNIDx3xqlEL2VO0G+yMBjQVwHjRkjYSowOugsUce4Afdkv4y26GCPxo6YcQdJ4J7vwwYMkVoIXjXC0iSEw3rr9RCtkKv4YhBHrVGH7PACGwIUodNL7H9MhbAk/I9dzfub/jvfInWtWcvxrJbwV3k+hPxBewpylLSjBBCKIDRGWaRUDMB5rM34Gp/ZnAa6z8iFQGbo00SFp7iVkqRyk5BnIjhfPuWX2ybEvf1mREvxiiUAaFaxYa8CFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6IgIzmhzHXLIs/pzs3siPlBEOyRGBdirYwgN2oLoU8=;
 b=la5aNoRdplcS1D95eofVdVYIbqXI8WmBfvFHCLEd79D8BSMwLoVcMeJIwpoq312vfQua+1F2+hac0wjqOEot21CYRL1+x8pevTATuw7HNokZDWeoxDqKvR8gQdo+GJoLFBRTclxxinI048vkBBt0jgrsGOe9TXHUu0YksnlvTRwEfPU5UhPWCxthIziiRxrzKDlkpcfZczIW+rJlhxuLt53m+7KJG/odFUD9cSHBabxQNYNUVz43GrC+ZjPQ3xjFN1tfzEkWMMVRXitYa6yAMLrjm/XPjcWb04qUsWU79u4KDa0Nz3mPGIdkXx9OVYMtezIr6Yt0cWfw5Ug7Jy5rhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6IgIzmhzHXLIs/pzs3siPlBEOyRGBdirYwgN2oLoU8=;
 b=AHnm0G3U68WxQQmtwjIjVHy0/j06L30DAG/mkseZHrYnqs8XSsjeIxgAyVPRcsZUW9N6m57inxcsB7Ww9NX1vERjXekzNg1+RY16uFWp2NB7tQjlDJVjlNlEmLwmZOcp5vE/DGrsNKRJzbCWnzME1cpkBNvyv4p6VqCLTUfYcomM1anwxAM9MuduDC9OCmcnTyFIeTt+CyCTKJFB4hiDrpxbEtQl9OdzEO4S2Zigl4+VqojMCDmjqQdJRME0UEQPW0behfVh4YIewxY3Nm3W51JxgsjGF36Equqp+tQR93uxzDoUJ9TAuk2Xw7Yv2FqfTu8jF6cGdroSes4EjMB+mQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:56:05 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 10:56:05 +0000
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
Subject: [PATCH v4 net 2/8] net: enetc: serialize access to the same TX ring from NAPI XDP_TX and ndo_xdp_xmit()
Date: Thu, 15 Oct 2026 13:55:30 +0300
Message-ID: <20261015105536.1692348-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0014.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::19) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4c61d6-114d-4fe9-07c2-08df2aaae91e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ai9x/hLIZibdAHdTfkTNAguTPKqZ3HRPtjGjUK9cge0Hjar1jxtApFMeUobIkRznx6l5ZaALegXbYYhTvJ+hKMWFMqBXM2c3t+Z7PkhoE5VgB5vzADIORYd7vWlscwzqNmajNs1QuKcQ5wPlbNaHdqLz5B+/e/xutPnbE2OtgisiD+WN8UpdxQNJM8UCTSQ/HkVu+M+LRS5HjLRsA4GiMDzSa0wVl34beKySebGrzN92dCdpbtWC8yBrg9oldcLxJ/KJ7S4AbePPtdsbehHro16HjkMZHAaAKFC32/ahfZylUenZkou08PBHBHzBd8Oyh9laRK6LPAF4Z1RscChQ7LyIrtMFbfcbN2o+QuY682x3qbbHL58iCICf2KlNpbK77d4lsziXCVqe8magv7rIdYKIlCS3WPnw4bNf1wkBjdRe9xo19Kg4Nd71fBjT9mj/0b2Mff3ULV69Oou3LBjhDDU2nPQcsNhd9jT4SR6Y3glMMUPChOQO20VD8nTf/DOCX9Lpa7f2q+fX406XKfjLfBVtBHQkRLLje7193nvppo1PVsREyyOc6ELfO9b+jKyqE5RHwZxgTyaJLGkP08yQWnRAWpaU1ecs2DNLA40PDqDzWcWIFJbmm2R6FJDSYq6gguw4WchgeGq0puKTD48O4Zatt9XWt4xLnlWMZLu9Bws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ck3Y46ydkFoiCnA8T6Fqu3ElI8rSntUXlPYNaS0P/zjuKQwio/LObVQuNcAy?=
 =?us-ascii?Q?1L4BQ4nF0y70vyd0GbPbeXYXFWQPlkvfOHnNi7Gx6Y/7fD7GNbGT3fUly3OT?=
 =?us-ascii?Q?wKxvTCBINs7mujOaiAocGzjN1WQf6MkM8whKv/sL9XRZIftpZUjbsUBvJG0V?=
 =?us-ascii?Q?ISReg732WvBVeuemFzzuxJ5iztk1bnlffS/8lvcY0z6RHWfriAcqhR/RZhem?=
 =?us-ascii?Q?W2jveigpQkZfXdOupZDFOY0U3oAvPkzPmzpLjibOE9DrmkS4DmfL2P8rUihF?=
 =?us-ascii?Q?Tn4BtTW4nldO/J0jTs6P+PtvNxlAO7guuK4hvcfpzEFM/QbWzpXXtU4WNajw?=
 =?us-ascii?Q?XOkOAtZ+yE0WRclccXn6Bp14zd9WdyesF5pj2rky44RqP9cH9nBgkZOmVHJA?=
 =?us-ascii?Q?WiNqHyhkugyQaJV67OPvKSY+0BrDNeBwMLQwrfJPzqvKRCEYvgxXkqdI9hso?=
 =?us-ascii?Q?aqjvhqlkHTWjxbi7CyQ7eEkJg2Aj1yW1k6d6ILaMT0rON1OIG9+W9OSbxNLp?=
 =?us-ascii?Q?uowfgYZ0iZ6otzJ2AOSTdXTYYhwrAXgQMHBz1ZNy6Vr60Wlxf5nxH0IbRAiY?=
 =?us-ascii?Q?7XVZZRszRCsFFaAeIxHA0a204db7+QEccQJ1K5XleNu7M38rxqmf0cyv0H7z?=
 =?us-ascii?Q?S6J/1ou+UkeKgX98u+2rbK/mpBfCNWni4n8YHTVOBmJTRYvPyqGmCI/6uNgf?=
 =?us-ascii?Q?sVSaEW6E1fHQOfmtCaO2LqPoQooJA+x4LS1pmwpbbr5mwRZEJxJ9gJ/xWgEr?=
 =?us-ascii?Q?RvjsOJ5S+g603e9sdJSW3Hjmc5HlEcCBZYekcZ8X+ugcFi9NNC6LjqiXu1kW?=
 =?us-ascii?Q?Jaybau4TJOHW08D73EC4jw6W1xdv2F7nBeRBlPaM3wiuHbjOyoPnbd+GOaeX?=
 =?us-ascii?Q?T6xF+3mcKW5O4kaOT9twHv+DM1zvMQ/t/YsOrp6XAN5X/VuF53fMmtzreNkf?=
 =?us-ascii?Q?DgkEpZJmuFkAvxtxBx0bxGQc0M49L9OueJK5BVS7MCtlOpp01yEAA+IB782J?=
 =?us-ascii?Q?aFX9wbZ/P2W/5SBcmmhEuFD4btr1RxYvLTnFmTpP1Pz1wFSasogLzdUz135Q?=
 =?us-ascii?Q?TpXnJ6MSxTKKcRA2yQjCls7c4jaU+jDNDnf/5EPMd6KEBpYw9IbxPfFFOVrS?=
 =?us-ascii?Q?XDtuP8TEtPgO6pTbpQ5mnOXWiyEOba1sO5ynbXV9zf1VSGCzvsuQsox8VXpi?=
 =?us-ascii?Q?wxoIn5d4+tvBlJZmYPaFNdh47zPWLeN8R4OHYGM0FVOPbE3PhXEo9SIaqJel?=
 =?us-ascii?Q?+VJZy9Z7CECp+nYqtbgVjeQOCK7kGBvKPivG/a1x0rRadvF+2f5/y0Tama9b?=
 =?us-ascii?Q?pLXFY/A+YddAV9DNPjcmauoob2MuHeN2XClEHBizZieOBolVS7AIwpsWJaov?=
 =?us-ascii?Q?G0br9mkadUr3WPgQyyvEdrZEPWBojGQ8EnCWMa2eONFurRdwgO1qkKpan03x?=
 =?us-ascii?Q?TQDKJq5YlxRCcUiJ7th8uatO4Hl2XcoC44yLWrWwsS/uvAtouFTLzQdd6F6D?=
 =?us-ascii?Q?A3cpPWHChB7Q8HG6DGSpEcK8LJ1AT4IjSHTzD4iQgsmm8W82iYCXtxxDiypR?=
 =?us-ascii?Q?ES8rH7ZytD+VuiIxq06txgii2wTLI5sA13JU0ciEjBRjonzYZf+53N1pwvKk?=
 =?us-ascii?Q?U9MZAknrL0IIZv8IGGZyHEFPt7wCS9N3FwQSvmO8R5NVpZbc0LNCrlBjpyEN?=
 =?us-ascii?Q?JjDDpyx+TOOFYG58/b0OmaK1Oa6yKkeBLSLIi8/rcmsYMK/UnxFCFAS+Qv8N?=
 =?us-ascii?Q?dizR5LjCiQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4c61d6-114d-4fe9-07c2-08df2aaae91e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:56:05.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efyObNRt70SlevXgV0qhZUDEL4T319S2B/wh5qhcF+gT7b5MF9wZHYfEX1IuQwbikGrskdzzYrqe7uE/pL5D0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

The enetc driver uses a struct enetc_int_vector which holds a fixed
mapping between the interrupt vector and the RX ring it services.
While this mapping is fixed, it has been pointed out that the IRQ
affinity to a CPU can be changed by user space, so there is no fixed
mapping between that RX ring and a CPU.

That means that on LS1028A, NAPI on CPU 0 can service RX ring 1, and if
a BPF program requests the XDP_TX verdict, received traffic will be sent
to the TX ring reserved for XDP_TX associated with that RX ring.

At the same time, XDP_REDIRECT on CPU 1 can also call ndo_xdp_xmit(),
and this selects for transmission the XDP TX ring of the current CPU,
aka the same as of RX ring 1.

This is bad, because the transmission code is not written with
concurrency in mind, and access to the TX BD ring pointers as well as
the statistics counters is unsynchronized.

Create a spin lock in struct enetc_bdr (common between RX and TX rings),
initialize the lock for TX rings and use it to serialize these two
problematic code paths. Since the calling contexts are always softirq,
we can use the plain spin_lock() over spin_lock_bh() which is also more
expensive.

Specifically, the spin lock only synchronizes the stats counters
relevant to XDP (xdp_tx/xdp_tx_drops) and the TX BDR producer state
(next_to_use, tx_swbd[] and hardware counterparts). The rest should be
not necessary.

The lock placement is inside a 52 byte hole in cacheline 1 of struct
enetc_bdr. The hole is now 48 bytes in size.

Testing shows for a single-CPU XDP_TX flow on 1 interface, 64B packets:

 Unmitigated MPPS    Naive mitigation MPPS   Batched mitigation MPPS
 2.32                1.9                     2.2

where 'naive' means locking per packet in enetc_clean_rx_ring_xdp(), and
'batched' means what this patch is doing, i.e. acquire the TX ring lock
at the beginning of the poll cycle, irrespective of XDP program verdict
(necessary only for XDP_TX), and release it around xdp_do_redirect()
and napi_gro_receive(). We then reacquire it around
enetc_update_tx_ring_tail(), so that no matter which CPU rings the
doorbell, the correct producer index (tx_ring->next_to_use) is committed
to hardware.

Note that in principle we could drop the rx_ring from struct
enetc_int_vector, and as in the ndo_xdp_xmit() case, dynamically pick up
in the NET_RX softirq that RX ring which corresponds to the current CPU.
Because of the softirq context, ndo_xdp_xmit() would be excluded from
running in a lockless way.

However, doing this seems counterproductive to the user space intention
of changing the IRQ affinity. It opens the door for user space to move
all interrupt vectors to the same CPU, which will leave the other RX
ring unprocessed. This seems like a bad idea considering RSS/RFS.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4: patch is new
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 21 ++++++++++++++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h |  4 ++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 103335f3d418..bd824b55a916 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1814,6 +1814,7 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	int err = 0;
 
 	tx_ring = priv->xdp_tx_ring[smp_processor_id()];
+	spin_lock(&tx_ring->xdp_lock);
 
 	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags) ||
 		     !netif_carrier_ok(ndev))) {
@@ -1858,6 +1859,8 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	tx_ring->stats.xdp_tx += xdp_tx_frm_cnt;
 	tx_ring->stats.xdp_tx_drops += num_frames - xdp_tx_frm_cnt;
 
+	spin_unlock(&tx_ring->xdp_lock);
+
 	return err ?: xdp_tx_frm_cnt;
 }
 EXPORT_SYMBOL_GPL(enetc_xdp_xmit);
@@ -1998,6 +2001,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	tx_ring = priv->xdp_tx_ring[rx_ring->index];
+	spin_lock(&tx_ring->xdp_lock);
+
 	enetc_lock_mdio();
 
 	while (likely(rx_frm_cnt < work_limit)) {
@@ -2064,11 +2070,12 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			enetc_bulk_flip_buff(rx_ring, orig_i, i);
 
 			enetc_unlock_mdio();
+			spin_unlock(&tx_ring->xdp_lock);
 			napi_gro_receive(napi, skb);
+			spin_lock(&tx_ring->xdp_lock);
 			enetc_lock_mdio();
 			break;
 		case XDP_TX:
-			tx_ring = priv->xdp_tx_ring[rx_ring->index];
 			if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags))) {
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				tx_ring->stats.xdp_tx_drops++;
@@ -2101,7 +2108,11 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			break;
 		case XDP_REDIRECT:
 			enetc_unlock_mdio();
+			spin_unlock(&tx_ring->xdp_lock);
+
 			err = xdp_do_redirect(rx_ring->ndev, &xdp_buff, prog);
+
+			spin_lock(&tx_ring->xdp_lock);
 			enetc_lock_mdio();
 			if (unlikely(err)) {
 				enetc_xdp_drop(rx_ring, orig_i, i);
@@ -2117,6 +2128,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	}
 
 out:
+	spin_unlock(&tx_ring->xdp_lock);
+
 	rx_ring->next_to_clean = i;
 
 	rx_ring->stats.packets += rx_frm_cnt;
@@ -2128,8 +2141,11 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 		enetc_lock_mdio();
 	}
 
-	if (xdp_tx_frm_cnt)
+	if (xdp_tx_frm_cnt) {
+		spin_lock(&tx_ring->xdp_lock);
 		enetc_update_tx_ring_tail(tx_ring);
+		spin_unlock(&tx_ring->xdp_lock);
+	}
 
 	if (cleaned_cnt > rx_ring->xdp.xdp_tx_in_flight)
 		enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
@@ -3591,6 +3607,7 @@ static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
 		idx = priv->bdr_int_num * j + i;
 		__set_bit(idx, &v->tx_rings_map);
 		bdr = &v->tx_ring[j];
+		spin_lock_init(&bdr->xdp_lock);
 		bdr->index = idx;
 		bdr->ndev = priv->ndev;
 		bdr->dev = priv->dev;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index d9e91832a9c1..bc7c0740498d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -171,6 +171,10 @@ struct enetc_bdr {
 	void __iomem *idr; /* Interrupt Detect Register pointer */
 
 	int buffer_offset;
+
+	/* Serialize NAPI and ndo_xdp_xmit() targeting the same TX ring */
+	spinlock_t xdp_lock;
+
 	struct enetc_xdp_data xdp;
 
 	struct enetc_ring_stats stats;
-- 
2.43.0

