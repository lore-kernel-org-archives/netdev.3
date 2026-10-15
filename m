Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7A51C04B;
	Thu, 15 Oct 2026 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061776; cv=fail; b=JHcH79kFFU9OGkdOY5YLmhK2U3v6I58qj6qM2oms9cjpUcDp1h0GeJ3SuFVtt2gWLxK5mxOU54c5Qa0WzeiqtIgSfq1PJz7US/hhLVwoKDaqPMnAbO4Tcls42ahZpG8UPyj1hvgEq+7wQFXhMg28V567yP6ruuY3iN1G8Diwi8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061776; c=relaxed/simple;
	bh=YqquoTc5BQL8pbpFZktO5fo4eNytCimcjB/beD3zStA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sxLQPl3ENnwCTjQy5tl7lMh20gveIoWCGaopavBnOBabjJ+jlIrcNv84D6A7njfjAFv/2AGS8PotegKqoeDpedWryxLtofCE8w96FZPP7+EbA34L8WKTpmq3pXx5JiSaduVi5qqidBSDfSWkFM3Kq4h2ErT9cvEOxFIwR+y+ETE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f2Qpjiog; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f2Qpjiog"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytZwyulhqBBmP0AbUgh3HBzI8RsWG06X7kf8h8fs2djY+CgTt/+xk8KOOLAczeyiDT9H1P1OdhEWpSDkYFwxTrpjmEgRP5TnhpxbXfo6PxsPtHc9mhG38mcc4zU9F1dD9C/ZRdL+BYHE0RmLmaH+XAl1ZxRiHcbVQ/66VnAdx126mdWgxGt/WxuHzZLRxJuBJ4g3imH+mYZooT6QY32l9+uB1kZk6tyq+qZ/8mhjSuYY/4KlRWA/77Vo7wQld4vzpQ2KddwYtnBo3TRwHPuICKqcefvUmvU7aVVNZF+/C0mvc5zGb7VVBhEQEykntH4FxQalr3I0CFu6JXdZycyL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O47kdzzRdRowhb58ZhPtJfxVdAJPQHiszfr7A1pA3UY=;
 b=n4ntycLnh+APSI91ZqcY2SUIVEtnoS4sMgq3BzhWPkmjq8Axpby6FFE6swlbUmwS0t4osAMADamby59g8fTgRSov3o9K81BmCDOrHFYYKlWVY1B810YaMp3UrNxynEHc/w45Bo3D1PEgAtxs5e60zg8RbGsVGrhknhu4zjI6VVT8dqKi5z4oDwvvUnw+DSFaJPU98f8xKXmAKXm56mw8Zqhc12u9sXhW3zqqsk3YSJCIYOjevon9WUgOl4mbgZznlFVwHlq7ioHBwwP+QXv4Cb7p/4YmQt0REV7i+BNKHbqib5KTWSKs8hSIo0IzPIQyLlthhOeEPx9Hd9m3Ls64xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O47kdzzRdRowhb58ZhPtJfxVdAJPQHiszfr7A1pA3UY=;
 b=f2Qpjiog1IXMKMiR9G0yXYzPTxuWSAX5/0HAiwwuWbXrjuDAbFiD9gY6RkLjCwqUMvF4CpSUd0mQXdcc3wPZfmcfqzkB+EC1TjjlS0E0cxQyuZfvboPRh0ul0Q0JnJNifIKQConK/fn7h3W8nGanoMK3Eq9aA4f5V4H2odeifo/2k1P2oJDD9X3LE34vP8luR++NC9uJvecD63OGgJJtrFrm/mMI7fMKWenczVk4r0reNMYwOIsFzKPITfOzG+s9XSBhSA09D8GzVMrZ5qENGVdutpWk72T4SHyUaSqafMom9uy2esjFOQXL9f0Oi4IHBDIq9rfzJwos06Cdxjsu1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:56:08 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 10:56:07 +0000
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
Subject: [PATCH v4 net 3/8] net: enetc: fix bogus TX ring consumer index after reinitialization
Date: Thu, 15 Oct 2026 13:55:31 +0300
Message-ID: <20261015105536.1692348-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0020.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::25) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 0903b73f-732e-43dd-8385-08df2aaaea40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2wvTE256h/ZZQnLfvnd6htAptQccjH0fqvW0GOlJwHaclv9tKRdwysJARiR414rrmNp5rcVlsdx1YA3bf2wg/cn9tUL6EtqkK1nEcdH4uHyH6j09X/ZHcTeCMLF9yjJ9PnHBDV/qyeNlyTAnKMk7+dLNT3hcCPpzk6tPHcI4XzRrYGq/894nE2oeFNBVSCaI1rVRqUgiKt0QopqGf385rlYx0vs/7eWkUlbedpT+Curf6FKVPdB+7rVprC8pIN/foH1s1anCcviR5DsPafYQXIRl/Pmfswq9r1wPwuKskvqL8De9WKWxBnrQuPb6LXvkyFuFzQUaTzp4hxrKuIb5dlPVSrzYbf4u2fohk2uneiPSQGw9ogQiq+tQGragXFKDVkuj2KTNjqYd6M5fDAPUbNO6Zph7AsgBfyEd03hGZHwJ/qpQp5mFJuxP2lmHj8e6ZexLuYihhxATqjc2Qgzkng4ICVWOsIg5mShr02UfoMmtQ0GYbtNEnw1sr0WSpdIAQg0Rplkj6PLu1z21+YBUYELW+GJRSi8lPPv2+okeFj+t+tNsWg2GOrA2rDrlKYYHqrVU6tH+oPKM02oIySeLoFITTsIfgVUwlQWwVDDTs6azbyCXP3yjFrzst2GrDesQ5R4hSgznx2r86961e5SJyyor5Bj7w9hHGFmWKAGW6V0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cdwoJ+XUyBzu47hwwiVs4IQuKOVXrL1qA8+t3r/mc0shINUs7PWgROJR/1Eu?=
 =?us-ascii?Q?2VHAMSdAyW0Z+h4xktX+kAz9vosRVrdQMXaqCvtqfqCacLRT/DoVq/GovSBs?=
 =?us-ascii?Q?+kUUeDVfhftkj9g0nrR5msK/9XflAtz4rKfYxzXDdohCuKhjWgirs085WLPX?=
 =?us-ascii?Q?Y1UvipGX18sWqCtLza7X6ejDZte24d15eBe8FcW5i5x/l4liV0DxhEyEhDhY?=
 =?us-ascii?Q?J5/KzgH/4pVAuSAh/Tajaj7P6D4mTUpOOlGgl2CKGQKBwouaN9d/tv9H1VZX?=
 =?us-ascii?Q?qmrnVB7h3mcZ8v23UGS+Nx2TmPboS3k7Fp02L1xd0VXli0QB6l+qmbpZ/dLL?=
 =?us-ascii?Q?GSOI3hJA9q3fTjpm2yR0lY0n2FLNzYiaKdKD6gjYmYrcpV54LdA7iOJFhJwu?=
 =?us-ascii?Q?zx/x+y00ff9zsA3S9cABbWW6hzoVOBqR5PJnQCC626tB3aco2iSWD3q1bkVV?=
 =?us-ascii?Q?NYQ+kUHBNMmJ3gOsqVDPOm2HpuD8b7tJ537OCw1d/H1swt7WfqezKtrKhhJp?=
 =?us-ascii?Q?lk98zHD71VLEe2tX0tJWVMDaxgjb1tT6yKOmzJJw9pF30cpJCRbg/sV+vegj?=
 =?us-ascii?Q?xqE1pw17hYH/YnCZ4qdQY7B3yCg1ADZGPeJRHaufOMGvOy6morT4iQ6cSYdF?=
 =?us-ascii?Q?lWc/qRE6eHFpvznUCEILQ7WQrpatNes5T0guLxTw3s05jZnancUwjqOhrJp7?=
 =?us-ascii?Q?s2mKQxmcOHgalGW3J//ijN0O6mQSIDIL7rdsB2dXJ4caoh0IIf0bx+i8Xl/1?=
 =?us-ascii?Q?RFuN5dHKMfnVOjaw/zMZ2lJXl7f8SQ0mfUb2R8K5GakrxwngzC9KGp88KVG0?=
 =?us-ascii?Q?UTPG9AHSY8LgJ5KicCEq6RtZWoVqNN+/oN4YNPZnmpyntZvCosS/iGAHallm?=
 =?us-ascii?Q?IjkDHe11GjPEAF+XHJZgR286kc9IJDEQUGhQm85Dm/8zuiHXETuw4Oj1b2NA?=
 =?us-ascii?Q?JrWoY1yO/hckHP9Lgj4t1pgyHlZCDno2S+BG9E+2qUrgFgCQcRorzqd63ZuM?=
 =?us-ascii?Q?4z1D49DOg9/uAegLxuTwFe7+wYvxNb612MawW92YTRmY7P1UeBGLN42S5bOc?=
 =?us-ascii?Q?F4ANWimXs/iwE4YUeeyRFtBVLStl/jnt8Zdi+aCCZ4Q0X0NsbzpXdUUEHlBo?=
 =?us-ascii?Q?WnXCjimGj1UY5RKIvUalM6H6LzXeXtMRG1NRimsxXOjfd6h/fDujcMrFIisl?=
 =?us-ascii?Q?6eike9BPRgQvyNqOONhrubgtktGgDNNAZ9ZnMQF1/q515/+SW0rjYfvBKYG4?=
 =?us-ascii?Q?0nGjSclBrdr7cDrWafG/g7tTqfUT/iXkmlmGUb0XzuequJsNuYkyiRXwAzjb?=
 =?us-ascii?Q?5+ugsR+X5abTS+lJxsVzO1Gw6UwMQn/fGFMnORBZfrBNTgl6LsjrKm1NZFWz?=
 =?us-ascii?Q?HanvQof5nHMmufvkFcTJ8qTTLetVD7TictmTin7VXWMcXCRGCkCUQcRVUBZx?=
 =?us-ascii?Q?UkKo+bjUm6bZ2fcYhhsCmwBSNdau6MH5V1VeCrtWJyIAhxX9VpBVUimSo5Oo?=
 =?us-ascii?Q?owj21Mhz8PTfHydGnGgcESB3lhsNO7RW+3fY1BxP9809dRD3kW0ThUwpvset?=
 =?us-ascii?Q?Zp8x+uPxcMxYZSf1T7bWgIqSbK4QS6j6cNgEXrfV5s9AmLSui48HbvOgVMLs?=
 =?us-ascii?Q?Y1tQw1fykX6Rcy8aXorxbXLaI7uBuMV7UMSbGLY3thhq4h0FVKxUBHFT6hES?=
 =?us-ascii?Q?H02v69YJM/CJX5WjohA3RbNhnUsHOYCh0ad2sdQa9i64qT89+AheyJFaeUQa?=
 =?us-ascii?Q?w8SZzFzLiA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0903b73f-732e-43dd-8385-08df2aaaea40
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:56:07.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yvr1vOrkPtzsr7DgGEEc1tMAjidF/n6H5F5dHd5mnRU65WtkTkwCTkIL7c4RfBpcCq/9+A+UFGvjaGDIl9i3Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

The TBCIR (Transmit Buffer Descriptor Ring Consumer Index) register has
the BD index as the lower 16 bits, but the upper 16 bits contain this
field:

  STAT_ID: Status identifier. Incremented each time the BDR_INDEX is
  updated and an error status bit was set for one of the processed BDs.
  Clears on read.

If there was any transmit error prior to the ring reinitialization and
this is the first time we re-read the TBCIR register, reading it will
give us a value with non-zero upper bits, which is saved in
bdr->next_to_clean.

If subsequently NAPI gets invoked and enetc_clean_tx_ring() runs, this
will dereference the &tx_ring->tx_swbd[] for the bogus (and huge)
next_to_clean index, and will result in an out-of-bounds memory access.

Other places like enetc_bd_ready_count() do mask out the upper bits, so
let's do that here as well.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v4: none
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index bd824b55a916..a2692761a6e2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2647,7 +2647,8 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 	 * adjust sw indexes
 	 */
 	tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
-	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
+	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR) &
+				 ENETC_TBCIR_IDX_MASK;
 
 	if (tx_ring->next_to_use != tx_ring->next_to_clean &&
 	    !is_enetc_rev1(si)) {
-- 
2.43.0

