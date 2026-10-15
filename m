Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E751EE0E;
	Thu, 15 Oct 2026 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061806; cv=fail; b=IEacd/IidBD8uUgzsHtxUqTZYx0rqWyI1lVpX+ywcsKwVggBLO4aBGqc5kIFQ7DBKjqTYXhJWBZfvbSvjdBtdV3ovNNMXeXgeRG+TYbRiWdSuAvZRGaqayri/monVdkRY/zARlMamlL0STFyilrBRCIPCXvojhTqcUb3KcecmYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061806; c=relaxed/simple;
	bh=Uwi14s+M+BVzOaRlH1QiDFnuBV0wYhpcf8J1c/61Gs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FSIb0E6JjtuQ5N/ESlVdQAPm2xyPuplT1484rUC2AhW1UOhlPnCD6+rZYW7lL79NeW6xxwC2S++5YJZ3eYL5EJa1YMOviWeypvw1ZGoLPUHx4FR8lFWoZ1XESynslqneF2aHGBMa1KPnpH/xJ40hS4sfUi11UipvhwBJ1XbYhvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wb3eHGXm; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wb3eHGXm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1/JrnWjRvUcZlSu8W7ZZ/uVpq2lCMAoua19OGYX5ueq4uSeMxe7/MDT+H2gOBjXrVhIuJgY/c1mFc9N9iJN6l2a/6aOlcyZlfmjQmHq7SAIvxBZl2yjmesUnox39y87OVYAgkJtJQx6EYadh4iDwRyP84wNc4Davsi2q6wXsYUKfyafm4FHev7QcgBAlPZhVqb5D3EO/f2ZXIxDEQy/LH3CAUHRepmE1v05IyV7AbO0MCi18Hwa3ZrIu05w7a7cD+fHRvGPXZY+u4aJE+lqHwqB3l2akglGE2YggXQSY2EKzrC0Tn2fGMm53pPVNrUd3cTQJpVKSjazy7q6CI/LIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91VUJoUU2BDSMgstoYT27SvRiIaNecUmcc8uBkHRKrM=;
 b=ktI7mJ7XsgwO5IWF5rUHTqIJuqNp8FL/AXNVEWOWErew1mcykNIHE4748kJhN/2vveHZo4Tc6BlI1muD58hB3D+KYWwF97fFPMrV+8ToBQcxyqRYKl8ZnXd1AjFyK/A/7zh/xak3sohWpnMolLo3XUng4+MlmfzlO0aTUmASzXCJrwxnRbHyN+JirlRrXVsEgS/vWVkGxx4AABEZplzyE97zW7sq/VY0y8WX1Maq3Bepzi/CiWa7+3NvwINHo2dof1m1kPBNN5m3HqQP7uJN3VZLer6lmApZf9gzw/xJkUTuII+x7ARR2x2++2L2KSIH3q2kZVdwwlp4nK72cl8VVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91VUJoUU2BDSMgstoYT27SvRiIaNecUmcc8uBkHRKrM=;
 b=Wb3eHGXmll4hzzk6vXPQFqzEDYPCZKyMUFpEAO8tmDfLdAUTdYy3lbsRJOM37tmerqo/D+Q3ReCutSfRbQiwYjQJW87oyzqe8UgUE4oFq6MtWBf5moYF7Ezr6zFWPWiwQKK8C9TAqIsq/9oXjdvrKRn57M0Ka4zrCKlHrbsjNZwmmOlxIeNmXtC468GcQDk40PU0SRxlXGMY0AtV1MO5Q6bEgwuCE/L/yn9b1HcfFCgkdR8TkhPp/k30spZi7VUfXSRZBUjmbFLiLzm4gtMHCM2bSoUy+gCZ65khoG21GJi2RPrFOZjlLbi+SBBnL/ChFZj9hvZtm25Sc5O8DZ5eIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:56:16 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 10:56:16 +0000
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
Subject: [PATCH v4 net 8/8] net: enetc: ensure enetc_xdp_xmit() calls enetc_update_tx_ring_tail()
Date: Thu, 15 Oct 2026 13:55:36 +0300
Message-ID: <20261015105536.1692348-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::14) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 0776be2e-b916-4ccb-dff2-08df2aaaefa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	e8wDNt2v55dT4NBl6s1W4fNv3A3hUz8dyhsPDZmQbnjYYPdSqOg745RW1hjRV8gRFKNI60TVJLyDe+azu67Vq/kQ+QZh4Ib1Ll1VLqHgSgdZd0B9xEHpwuJjfucn7hEqayII+Fp5MEaazZL45sfvMROnEsKvszKq3HCmntPLQ4muQb91CjsLSIn476JggtCwZtAXPvsunDwcebhJENg5M2hsA379PAw2D4beTD5Ztgyadnw/nZGEYR0f6CQwugJMVlMc4t/fS/e/RqRDg/FlcpQjo+VhS0lVgDt6vIvyFtVHofNUSutvGlGHdsFRyOxNnZnozyeYtAESsci0yb5arDz7ClYsOhzYBuIZhg2OsqjWNFU11mAroDvkOifp+6MbMu/yLWoSWf0POxlks0JLFb/hYQauO4EpFgSC/ci0BkC4D0tJYfLGDDu8MxNePM+8LhmbRwmIzbkqAYuLISEqo4P4tFeHvefNG7Axr+5EdOFBc1s5loo0+7pvvg1ZABYo+yFe0IKkvPnvvG56CIkIOvaFmWTeCNcUhOtGlABNE7v4+KK4Kfiw2ydZ8yVkKmHQoEldX1bgoiRs28HFWlTX/eLX7gXf1RqunFnXAOWQkk0g9L5snysk3knuXV4shKceAgmnlCRq4iwEm1SWvzepMznsjFkPHMfGKuO/9sY4xhI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dlCgBwRDx2R0VDiB107SCFzc6diug95ZfWyJvF2mDjd+g6FEHKKtyVLwh/MQ?=
 =?us-ascii?Q?Cp+hh0MYlmQpsDy5qcgdz4Ljy98Xh+bTnd8kGobZYA5vev4MloWciLIY+2BE?=
 =?us-ascii?Q?je/996nNAkOCrPe32eQi2TsVpHCjQmHy9UfoWew+nS2tmdIF8osIE2k3VdFc?=
 =?us-ascii?Q?or9m1n9MIQWy2OB0jMZI62H2Z6/syEiVvYCMcsCwdVT/UlG0s3QraY53QW4n?=
 =?us-ascii?Q?oOBicj38PUWvUu+BAHO3HDt5GR8ALv1OZjowb2EASv5hCUrBjJInuHA3Vk6y?=
 =?us-ascii?Q?CKFdJZauy/JQJNrT6XrVOP1XXoA5vQ/8qwu1aIy0xjHcGVTzDqO1MpTGOYYc?=
 =?us-ascii?Q?M9atVEiqBp3bGuo7FnhbC45zM6VuM1Jziq8OFUhcUsFOA5B+rcwzaPmcKlrg?=
 =?us-ascii?Q?4c+/QNHHLdp37wcq/gwNWabXVXXdm0vf4ih+GEZmP3u90R5ut21CCtBWix+K?=
 =?us-ascii?Q?k+WPvwwDPXXgdEC1vtIFLwriamDAShnrIhmTHHuUdclQTgSxRQqLD/KupLD+?=
 =?us-ascii?Q?oeTt3GclP+aZXybiNa/ew8u2tkSHvjPD9a3ZRwOCw3Fw7Ih5+A4Vyf0zZpDZ?=
 =?us-ascii?Q?cn5DfLs3j4tVxI8GOq13YT4qcc7Zddbc6gQm0DycCBWxxr3gEiH6KYrNeTL6?=
 =?us-ascii?Q?0LfqFV2dPoMdpj8b2BLFUGhqfGjSkZMWrmuzPJgn6eTf2oJQSZEXoyIU7y3l?=
 =?us-ascii?Q?/Qhu/v/LtspAf0MP7LYaWrKtXU8uU1M03jtVrG+v7I2enILysnFWKW5RthpW?=
 =?us-ascii?Q?iKiGuAP/SaELUuqRw/iDZefmAQd+WzOtugy1DYoAalMOOf09KQIdHftP2mOI?=
 =?us-ascii?Q?7KoUGbWt/5UmvqIKYEOvOpim809cUm1n5MYXWwv7YKO2mdxWAKUCZoBdvor4?=
 =?us-ascii?Q?KnlRb2hcpptm/fYj/LQQgqBwB5LjkRYLc7JWSc8q7MENO04xVpl+JWKDMYtu?=
 =?us-ascii?Q?JSa6lWlRla6Dxx1uYAsD8XcJQorVlLBfci0L7TmsPdJIbtce3vU3IK6ZPWlb?=
 =?us-ascii?Q?azIo02q0Jmvyq/WgrF96Pl2zJYEfHQ3rCGCWExgcENW5iq5/UArZQGoXeoH0?=
 =?us-ascii?Q?kwbFqmQT9cWbzVnxqMpi5IF4GAn6vX5ESeVe1lCdquFNxTdx8d1uCgrrB+z6?=
 =?us-ascii?Q?cIjzj5rwL/niZzJGzLcPRG5JTEMSgtWZJMu6rTgTurrQ/cviWqGr/1HhRL6a?=
 =?us-ascii?Q?L/Bz1Hb2hhvEu9pHdk5LmIbiEQfU30mWTcjQdFgYNHse9mNoFCNlPKZ4sXz2?=
 =?us-ascii?Q?oiFiTkkDwYeFWRXWCyD9DSroxhfXE8xvA/51+9lUbBe7JyxkFQXnvPf0B4Gn?=
 =?us-ascii?Q?G3p/iJSeGRVPjIjEnGk8r1KQRMA/JTuC0Vac21SJTRD6ONdW74Dk2Bk6musR?=
 =?us-ascii?Q?vU6GqFxSErv6NvunvMXr/H/fb4REi0OvYAvxBl6a47QlpWZNT9KnhTGb3B87?=
 =?us-ascii?Q?ITIopSTedk+9mo6lG+NLy/Fi6kHsZySEHdSQg5YNmNvyiNxQaj3OSXAU3QEa?=
 =?us-ascii?Q?j12abEy9ciVL7aWx1GTmgAElysVL1qZ7nbOGCyNSDl9vlxCKNIr76o64vHhB?=
 =?us-ascii?Q?riZXklh6C9yR1z4nRxNme3FLkYz6zQW1jCzwY+n4j52IIz/Wry8zGT5WjKVD?=
 =?us-ascii?Q?9BXIuvguajERAhSLR6QnaUN0a6b8PpyMH4sjWt42/e0fYIcNA96SKqIRLBN6?=
 =?us-ascii?Q?56phh3mXGhtXHtdUpc92iEGut8lTkyDazMI0ORMNIA7W/p7hBYHDBwXzobC1?=
 =?us-ascii?Q?xs1htivDgQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0776be2e-b916-4ccb-dff2-08df2aaaefa5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:56:16.4850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdYHDc5D7dqclecMr2ZB+XRpT1GSIZCypSp+h58sKyS2vbbzfm3gsdFTSvD/TN8W6VEKoycVqdv7pBiDPIju4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

enetc_xdp_xmit() keeps track of 3 numbers:
- num_frames: total length of passed struct xdp_frame **frames array
- xdp_tx_frm_cnt: number of frames successfully sent
- k: index of currently sent frame from array

With "k != xdp_tx_frm_cnt", the intention was to detect an early break
due to an inability to send a frame, and to trigger a TX doorbell
anyway.

However, that doesn't work because every time when the loop breaks,
k and xdp_tx_frm_cnt are mathematically equal.

The correct condition on which we should ring the doorbell is when at
least one frame was sent, and either the caller required us to flush, or
we couldn't enqueue the entire passed array.

After updating the enetc_update_tx_ring_tail() calling condition, we can
delete the 'xdp_tx_frm_cnt' variable, since it is equal to 'k' after the
loop exits.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
---
v3->v4:
- context change after introduction of &bdr->xdp_lock
- make sure k is initialized with 0 for the ENETC_TX_DOWN ||
  !netif_carrier_ok() early exit, like xdp_tx_frm_cnt was
v2->v3: delete redundant xdp_tx_frm_cnt variable
v1->v2: patch is new
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index fe5db840d2cc..9ae7fef377d1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1888,8 +1888,8 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct skb_shared_info *shinfo;
 	struct enetc_bdr *tx_ring;
-	int xdp_tx_bd_cnt, i, k;
-	int xdp_tx_frm_cnt = 0;
+	int xdp_tx_bd_cnt;
+	int i, k = 0;
 	int err = 0;
 
 	tx_ring = priv->xdp_tx_ring[smp_processor_id()];
@@ -1925,22 +1925,20 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 						    &xdp_redirect_arr[i]);
 			break;
 		}
-
-		xdp_tx_frm_cnt++;
 	}
 
-	if (unlikely((flags & XDP_XMIT_FLUSH) || k != xdp_tx_frm_cnt))
+	if (unlikely(k && ((flags & XDP_XMIT_FLUSH) || k < num_frames)))
 		enetc_update_tx_ring_tail(tx_ring);
 
 	enetc_unlock_mdio();
 
 out:
-	tx_ring->stats.xdp_tx += xdp_tx_frm_cnt;
-	tx_ring->stats.xdp_tx_drops += num_frames - xdp_tx_frm_cnt;
+	tx_ring->stats.xdp_tx += k;
+	tx_ring->stats.xdp_tx_drops += num_frames - k;
 
 	spin_unlock(&tx_ring->xdp_lock);
 
-	return err ?: xdp_tx_frm_cnt;
+	return err ?: k;
 }
 EXPORT_SYMBOL_GPL(enetc_xdp_xmit);
 
-- 
2.43.0

