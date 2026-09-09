Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE152ED35;
	Wed,  9 Sep 2026 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950234; cv=fail; b=gs4BfcJzbWzPMEnj3Eeo3GF8yxXZx0zn7PYlXfjZdBoXv7vFm7RH2h97g3JNzwNb6hx6U9er7eoL9BZdYtFtiSQdK1f+kjHSllvQtqV8Xa7uDk4/n7PEo7NZAddogx1MYvvGnK7Mto6b6mAb38yllMZQyqbJcpD/Vk6E89THlxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950234; c=relaxed/simple;
	bh=9TOGF6t0VpBRgi0ef1PpGegD+JSjksuT0uR9MyD10AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vv38ZLwcgyPwidgvx+miHkxRem3NXI+PizP6fSt2UXqpJxU68FblvkVkYt2uzIt3o9DomHk9RxkCfIavVvDAFlc41uCc/lB8QTqgyuoN6kdji3kuujRr0BRgcwe8stId7SI4JkuNxQRKaULdsyn9ooUderuzVJ/A1EEEAFkdVdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZJYqoLUs; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZJYqoLUs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMFs8yK9UD7fesYhMTfYbuI9jeNeDGbsBqzGseVduzfQZnw1Ld8Zxv15c7v6oZvGOfAO7ChY3oiqxZoAc6+L0gngxZtkRxLznmDE30U3Y9OcII4nkaGf02qYEE/zOfef0yIAp/olWNURhRQcNMXZzed3LHhIbpSmV7nk3xI/FkiEFY+mZyddlDohPKKxeROJxsvL3bShyj3iOEbFIggjLqg5mozYgaazYNF/yXoY9knwSZzBjrVrYQQNhs3HA4EGXVuCTE6vUhvhPgG/u4lOo1QD0FD0YDjFRlQ/pWLd4L69y+GvGD42EvdnHdo+rpzQj2syLZNyMzxWYxr7Z//DJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeJxVCMtshvofDxKxvgdYexeXI9ZNxF55qs+bUMrnuE=;
 b=vETMA/DwfD7pU8LHWhU4r0RNF6GoT5tYzq2kxG5w3pWN+RU4c7I52jlRw44gOwc/bEFaT2FrlljlChiMmbaBLUHDYZMHmmswS5nShG71yEgq9DoEkBqax15M+tgAuow6C+k5V6GpF3dSi5Nu21tVJZVdiV9Uv9AHs7RCyri/UlG9f2+DmDXRQtpVUyOSPVUYUyTEQQINIzgWNj1fJ/nFO/pHeEe+Xz1XH181NNiEaPcjOiTRac/0ani1k/u4GNh+cIB3D1qcMLYU1wluPxZWDtjNrJPco3nJb4FIyIWz3DCcD1Kmi5nTQlvKerCBARV6VEah5mi7TT16jNgIiYlTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeJxVCMtshvofDxKxvgdYexeXI9ZNxF55qs+bUMrnuE=;
 b=ZJYqoLUsxGALXw3lLs+IzEQhTw7ibBiz/IA442JsP8GGjW+9XkzNclcCUyNi043cUP6hzO6XqbW4doD6Y9lRlHzZ0R6o/JJsz8oBRRifmhPawBOTMv+rKlov+MDveAVR4Zxi8FZXPZYwuwuRvAuaVfjNz6/MTmxRFRitZDvEQiI6+m8NbH8BPtT8GkejlI0Nu6CuWjKPuE2SMqjA1hL/8qAyqaEhCRcV2ec1+dTf90Elvb/EHENa1knQ8kFqJ9Wd4iAg4dyxOr+ELmvkuLIHtfNyPHUFZYNTSxNnvO/KONo/U3ML6qH4N/hz8aZH8zRZZlkGq4U/3KkBgChNvcsebA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB617387.eurprd04.prod.outlook.com (2603:10a6:20b:7ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Wed, 9 Sep 2026
 10:37:09 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:37:09 +0000
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
Subject: [PATCH v4 net-next 14/15] net: enetc: add PSI-to-VSI link status notification support for VF
Date: Wed,  9 Sep 2026 18:07:32 +0800
Message-Id: <20260909100733.1139689-15-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0281.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AMBPR04MB617387:EE_
X-MS-Office365-Filtering-Correlation-Id: fead091f-67b5-44c2-2690-08df0e5e4cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|10067099003|22082099003|56012099006|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	6/yOtSifme3WLOesLR8ebWmfamkYUN1xW8ZQ3xxiE6cmAln26JfhHnSFPUH0OQePtxem/q2bY7PwVrQTghMwvzaHmR0xvvmz5BGGOqanaZpLA9rthkyx9/io7KufkzVHy+BbPmUScCZLY/WYtZ3kfX8o9RYWq+AR+lce8XIIxu/F/6Cz9FlM++nm0fbqu9ATCA3k7V2YFCoU0BmhyFh8QP1eW8y8E7NjG+dowvabK50mDTdO/9nbraDxRgy9zBZTdMl/wq7eyQ345A/cTLGZQJxsmXfgtVVM+CS0I+j4Gy9KHJjAy71z2uU5cuSHWO39CiwLChvczK1508tPWEqX6pTKPg23MMa0DfZQL4rb0No5Hk55oGJw9YcJ9YvHiLsA5KDqDTrTGUrkeGX3Dnx1biyYHVxVV0YJJNzs9775zoUQABhV0J0Mwtb8ZuQpvXJEebndtd9cfTOyupIJtYg4t2fNglmORCVzDj0iXDCwowRAhCbRZhS9jz02SbSDsyh2IQX81n+Om1w4xHt0mSzqHofS7VHuo7tG81bBddH/LJgb6N1A4zPH4XQwie2J8Gm0ycIbDaWnupmmM8Xt35zs93xnkDDkG2buyErP3adFjl7jtC7CEjHleCDNrWVCMGxvVBbSZaERmNwFlLuN4znSoRDik303KuvVXwSaWbXdiHlXk0x5Rwzoo9RYNwzu5EY7iUTOoCddR77KvVOxwCA8cg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A8I/D1f5ef8nEzU6Na58XnMechFaM1T2d5d/BY8vM9mgmEO9ouKNp1qO6CH7?=
 =?us-ascii?Q?jV7h9mD9EiIIISoqdw/Q4Hg5HkW9/BmHDZcC+2sEUI+icHebDcbrGKEofvkn?=
 =?us-ascii?Q?ZrgoQGnWg0pCZ9+pY+hnq5X7BzTAqDh/4ycvybwwEizLrX0tKuqyAABIIycM?=
 =?us-ascii?Q?2ugcFA91rZWs43BgxDFcSkUnd4dS5KRZgeDZAjcDswontMV3l4mgA51bZZiA?=
 =?us-ascii?Q?Xj9DQ6/2UpK39vowwQP059gfEO+6PTBrN40pA8zMDXd7saXmS8T3pMvettP4?=
 =?us-ascii?Q?B3bJXoKqLQekKtzQ76fptOYytcZdRjg/wn5LgecHeJP2rvDGBJFy1qQv1+uR?=
 =?us-ascii?Q?pMMxrcHzWB9Vuvq8GPr5feNVzrpFqNOUuBoTiJIO25UotHoTrtK7gyBqZR0V?=
 =?us-ascii?Q?wbT1FZ4rMJIB5mV/r2Rw3Cjjm5yUZYSwTG5GJbpEMbjepzJIp3zIqpeiLhxG?=
 =?us-ascii?Q?IrAFnNk0W7NrD0ox+rBiT7h9yY3X+HOQK+ZpB0oLu+1tM3c+j3UUki/H+cPy?=
 =?us-ascii?Q?V0I+BVvCGi0k3KCT/+rVmJmJRhOS7685dokJof8efcA/rF1NddmWHLzntZLO?=
 =?us-ascii?Q?YyqKu3GcmRWWDfV3nNX04JV+9Qv0pEIb2d25cjizfjlZ1Ci9Qu9TzZy99bM5?=
 =?us-ascii?Q?NKn9DgvC6O5kN7opTSxBUtix0qkoQpF2H3HK/IZtUcEnaKpZ61lVho73SnBf?=
 =?us-ascii?Q?3F+9b8QJIR/ahK50HSPq10+T703nqSpF1GY3cQM8oFTiUp0L/aXLLlC/aXhZ?=
 =?us-ascii?Q?0OLkdGN3wEpoSLC4vd6yQGS7UNetFvnnAZBdn009WH0yw2+T9ofwT6PS+NmL?=
 =?us-ascii?Q?oGsRP6zdTDwFXlaJjTZNYmmZBb8IUs39eNqWdrSbV5y7rTnaIxscwWM2YiHN?=
 =?us-ascii?Q?noeJy9piAcj2pXdFd3KscHuCd3OZPEswa7EzYvG9dXXK7YrNk3XrDoJBHCSq?=
 =?us-ascii?Q?g3vNHyYRQCjPXyhX5a36uoM3A/LancHhvQE1Wnmsd+8AHhu2wRVnmISQsDHc?=
 =?us-ascii?Q?REABs9V7dSQ2HyLlhIb4s0N5mEuE++ddBUr71xAPUWAcCceUtZNoFpTTYdXF?=
 =?us-ascii?Q?JbW71lrp8iNgQDYBKMm+fPA+l1AnQlzJtExNHeeomkefEfIP8uMMRdv5iCkv?=
 =?us-ascii?Q?PNbOmys4zOpasvCSK+1qIalecMEX1OXHNTkVGUegzSMLUc5nLN5jJCnsk2u6?=
 =?us-ascii?Q?OFea9BEP8CoZfU66iJkcVdEbtmUMKLNgWHL9mc34wVD4iwV++ZUy5uaSYu9a?=
 =?us-ascii?Q?kf2Gaqhcgt1v+rVHxMRnZFop9bnM2KAJmMIOYD4wnIlC1eGAbhpF9XaH1QIq?=
 =?us-ascii?Q?ryEg55LcgrqmnUUcjg+pMFaikjaYMQp9rCMfRuooMncoq5GFjldwkOis4bmM?=
 =?us-ascii?Q?tWq5OrYq4GT03XZ3U0DpXvex8mcgkqglRJ0DuMIL51Xd1w0Gd3gIONvXZiY1?=
 =?us-ascii?Q?URuRc4v8lQZDj7vj0K3UrvVK1ku0neyS6MJ5F9+6StIwTuVQPoAcKL/89PNt?=
 =?us-ascii?Q?oggbk1u8KHQUJ9c0RclCjMfj+KBoV2zgPIehHPQ0/Iw/9zivUk5X/PqTLlR+?=
 =?us-ascii?Q?ckpl7OsSFRCEs3Sz/+XK91dw85SdAP9jFR4sSrN5S6tzpXHTQw05l1Vs+ZjY?=
 =?us-ascii?Q?967L/yR0KwAjLH+9jtkWgGhWFX612ynHdaiptn2Dq56EBYPLle5QJiA1XduH?=
 =?us-ascii?Q?AnThljUpZEb4qWS4k6AUHtbzP5s3H4NifgQDHfTwJvU0NGpZOit9Jx6VBmns?=
 =?us-ascii?Q?Iqi/u9bGnJz8vMxvlZqXmw5mkKWLIpXFBc6/KDlTCcm6TFxw7q7W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fead091f-67b5-44c2-2690-08df0e5e4cc7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:37:08.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gC89LPYiHaW+qP4yw93Gux/tE8dM8uFBixWCiQZZ40pbFTWZrr0UhK4oaMxoKGYS/XSlLxR9Ly6a/t0U9Ad7WZ++NoY80XbOZePI1uEJFvXNDkIhE7uOemBT9Y5bllVB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB617387

From: Wei Fang <wei.fang@nxp.com>

Let ENETC v4 VFs track PF link status through the PSI-to-VSI messaging
channel. Add two enetc_si_ops hooks, vf_reg_link_status_notifier and
vf_unreg_link_status_notifier, populated only in enetc4_vsi_ops; rev1
hardware is unaffected.

A dedicated MSI-X vector on the VF handles incoming PSI-to-VSI messages.
Its handler schedules a work item on an ordered workqueue that reads the
notification via VSIMSGRR, updates the carrier state and sets congestion
mode from the PF TX PAUSE state in the message. Reading VSIMSGRR also
acknowledges the PF so it can send the next message. The workqueue is
set up in enetc_vf_probe() and torn down in enetc_vf_remove().

On a VF, enetc_phylink_connect() registers the notifier with the PF and
enetc_close() unregisters it. On registration the PF immediately sends
the current link status and then broadcasts every later transition; if
registration fails, fall back to the LS1028A behaviour and assert
carrier unconditionally. Register the notifier only after the Tx/Rx
resources are allocated in enetc_open(), because once registered the PF
may queue si->msg_task via a link-up message. An error unwind cannot
drain that work item, since enetc_open() and the work item both take the
RTNL lock and waiting would deadlock; and as __LINK_STATE_START is set
before ndo_open() runs, netif_running() stays true during the unwind, so
the queued work could still call netif_carrier_on() and leave carrier
'on' after a failed open.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  |  48 +++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |   4 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   9 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 209 +++++++++++++++++-
 4 files changed, 261 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 803c5c541a5c..04c49b680709 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2935,11 +2935,31 @@ static void enetc_clear_interrupts(struct enetc_ndev_priv *priv)
 static int enetc_phylink_connect(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
 	struct ethtool_keee edata;
 	int err;
 
 	if (!priv->phylink) {
 		/* phy-less mode */
+		if (!si->ops->vf_reg_link_status_notifier)
+			goto carrier_on;
+
+		/* For phy-less VFs on ENETC v4, attempt to register a link
+		 * status notifier with the PF via the VSI-to-PSI messaging
+		 * channel. If registration succeeds, the PF will immediately
+		 * send the current link status and broadcast future link
+		 * transitions; carrier state is then managed in
+		 * enetc_vf_msg_handle_link_status(). If registration fails,
+		 * fall back to the LS1028A behaviour and assert carrier
+		 * unconditionally via netif_carrier_on().
+		 */
+		if (!si->ops->vf_reg_link_status_notifier(si))
+			return 0;
+
+		dev_warn(&ndev->dev,
+			 "Link status notifier registration failed\n");
+
+carrier_on:
 		netif_carrier_on(ndev);
 		return 0;
 	}
@@ -3024,10 +3044,6 @@ int enetc_open(struct net_device *ndev)
 	if (err)
 		goto err_setup_irqs;
 
-	err = enetc_phylink_connect(ndev);
-	if (err)
-		goto err_phy_connect;
-
 	tx_res = enetc_alloc_tx_resources(priv);
 	if (IS_ERR(tx_res)) {
 		err = PTR_ERR(tx_res);
@@ -3040,6 +3056,10 @@ int enetc_open(struct net_device *ndev)
 		goto err_alloc_rx;
 	}
 
+	err = enetc_phylink_connect(ndev);
+	if (err)
+		goto err_phy_connect;
+
 	enetc_tx_onestep_tstamp_init(priv);
 	enetc_assign_tx_resources(priv, tx_res);
 	enetc_assign_rx_resources(priv, rx_res);
@@ -3048,12 +3068,11 @@ int enetc_open(struct net_device *ndev)
 
 	return 0;
 
+err_phy_connect:
+	enetc_free_rx_resources(rx_res, priv->num_rx_rings);
 err_alloc_rx:
 	enetc_free_tx_resources(tx_res, priv->num_tx_rings);
 err_alloc_tx:
-	if (priv->phylink)
-		phylink_disconnect_phy(priv->phylink);
-err_phy_connect:
 	enetc_free_irqs(priv);
 err_setup_irqs:
 	clk_disable_unprepare(priv->ref_clk);
@@ -3093,6 +3112,7 @@ EXPORT_SYMBOL_GPL(enetc_stop);
 int enetc_close(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
 
 	enetc_stop(ndev);
 
@@ -3100,6 +3120,20 @@ int enetc_close(struct net_device *ndev)
 		phylink_stop(priv->phylink);
 		phylink_disconnect_phy(priv->phylink);
 	} else {
+		if (!si->ops->vf_unreg_link_status_notifier)
+			goto carrier_off;
+
+		/* No need to check whether the previous registration was
+		 * successful. Sending the deregistration message has no
+		 * impact; the PF side simply clears the corresponding bit
+		 * in link_status_ms_mask for the VF.
+		 */
+		if (!si->ops->vf_unreg_link_status_notifier(si))
+			goto carrier_off;
+
+		dev_warn(&ndev->dev,
+			 "Link status notifier unregistration failed\n");
+carrier_off:
 		netif_carrier_off(ndev);
 	}
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 0501cc2fc304..d9e91832a9c1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -300,6 +300,10 @@ struct enetc_si_ops {
 	int (*set_rss_table)(struct enetc_si *si, const u32 *table, int count);
 	int (*setup_cbdr)(struct enetc_si *si);
 	void (*teardown_cbdr)(struct enetc_si *si);
+
+	/* VSI-specific hooks */
+	int (*vf_reg_link_status_notifier)(struct enetc_si *si);
+	int (*vf_unreg_link_status_notifier)(struct enetc_si *si);
 };
 
 /* PCI IEP device data */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index c18ad8b9b071..2c9d9042eb0b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -85,6 +85,9 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define  PSIMSGSR_MS(n)		BIT((n) + 1)
 #define  PSIMSGSR_MC		GENMASK(31, 16)
 
+#define ENETC_VSIMSGRR		0x208
+#define  VSIMSGRR_MC		GENMASK(31, 16)
+
 /* SI statistics */
 #define ENETC_SIROCT	0x300
 #define ENETC_SIRFRM	0x308
@@ -108,6 +111,12 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define ENETC_SICAPR0	0x900
 #define ENETC_SICAPR1	0x904
 
+#define ENETC_VSIIER	0xa00
+#define  VSIIER_MRIE	BIT(9)
+
+#define ENETC_VSIIDR	0xa08
+#define  VSIIDR_MR	BIT(9)
+
 #define ENETC_PSIIER	0xa00
 #define ENETC_PSIIDR	0xa08
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 8cf38c426dae..ee9567998c7c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -135,6 +135,37 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 	return err;
 }
 
+static int enetc_msg_link_status_notifier(struct enetc_si *si, bool reg)
+{
+	struct device *dev = &si->pdev->dev;
+	struct enetc_msg_swbd msg_swbd;
+	u8 cmd_id;
+
+	msg_swbd.size = ALIGN(sizeof(struct enetc_msg_generic),
+			      ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
+		return -ENOMEM;
+
+	cmd_id = reg ? ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER :
+		       ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER;
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_LINK_STATUS,
+				  cmd_id, 0, 0);
+
+	return enetc_msg_vsi_send(si, &msg_swbd);
+}
+
+static int enetc_vf_reg_link_status_notifier(struct enetc_si *si)
+{
+	return enetc_msg_link_status_notifier(si, true);
+}
+
+static int enetc_vf_unreg_link_status_notifier(struct enetc_si *si)
+{
+	return enetc_msg_link_status_notifier(si, false);
+}
+
 static int enetc_msg_vsi_set_primary_mac_addr(struct enetc_ndev_priv *priv,
 					      struct sockaddr *saddr)
 {
@@ -499,6 +530,128 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
 
+static void enetc_vf_enable_mr_int(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return;
+
+	enetc_wr(&si->hw, ENETC_VSIIER, VSIIER_MRIE);
+}
+
+static void enetc_vf_disable_mr_int(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return;
+
+	enetc_wr(&si->hw, ENETC_VSIIER, 0);
+}
+
+static void enetc_vf_msg_handle_link_status(struct enetc_si *si, u8 status)
+{
+	bool tx_pause = !!(status & ENETC_CLASS_CODE_TX_PAUSE_EN);
+	bool link_down = !!(status & ENETC_CLASS_CODE_LINK_DOWN);
+	struct enetc_ndev_priv *priv = netdev_priv(si->ndev);
+	struct net_device *ndev = si->ndev;
+
+	rtnl_lock();
+	if (!netif_running(ndev))
+		goto unlock_rtnl;
+
+	if (link_down) {
+		if (netif_carrier_ok(ndev)) {
+			netif_carrier_off(ndev);
+			netdev_info(ndev, "Link is Down\n");
+		}
+
+		goto unlock_rtnl;
+	}
+
+	/* Link is up */
+	enetc_set_congestion_mode(priv, tx_pause);
+
+	if (!netif_carrier_ok(ndev)) {
+		netif_carrier_on(ndev);
+		netdev_info(ndev, "Link is Up, tx pause %s\n",
+			    tx_pause ? "on" : "off");
+	}
+
+unlock_rtnl:
+	rtnl_unlock();
+}
+
+static void enetc_vf_msg_task(struct work_struct *work)
+{
+	struct enetc_si *si = container_of(work, struct enetc_si, msg_task);
+	struct enetc_hw *hw = &si->hw;
+	u8 class_id, class_code;
+	u16 pf_msg;
+
+	/* W1C to clear the message received interrupt event */
+	enetc_wr(hw, ENETC_VSIIDR, VSIIDR_MR);
+
+	/* Reading VSIMSGRR retrieves the message data and acknowledges to
+	 * the PF that the message was received and another message can be
+	 * sent.
+	 */
+	pf_msg = FIELD_GET(VSIMSGRR_MC, enetc_rd(hw, ENETC_VSIMSGRR));
+	class_id = FIELD_GET(ENETC_PF_MSG_CLASS_ID, pf_msg);
+
+	switch (class_id) {
+	case ENETC_MSG_CLASS_ID_LINK_STATUS:
+		class_code = FIELD_GET(ENETC_PF_MSG_CLASS_CODE_U8, pf_msg);
+		enetc_vf_msg_handle_link_status(si, class_code);
+		break;
+	default:
+		dev_err(&si->pdev->dev,
+			"Unsupported Message Class ID (0x%02x) from PF\n",
+			class_id);
+	}
+
+	enetc_vf_enable_mr_int(si);
+}
+
+static irqreturn_t enetc_vf_msg_msix_handler(int irq, void *data)
+{
+	struct enetc_si *si = (struct enetc_si *)data;
+
+	enetc_vf_disable_mr_int(si);
+	queue_work(si->workqueue, &si->msg_task);
+
+	return IRQ_HANDLED;
+}
+
+static int enetc_vf_register_msg_msix(struct enetc_si *si)
+{
+	int irq, err;
+
+	if (is_enetc_rev1(si))
+		return 0;
+
+	snprintf(si->msg_int_name, sizeof(si->msg_int_name), "%s-pfmsg",
+		 pci_name(si->pdev));
+	irq = pci_irq_vector(si->pdev, ENETC_SI_INT_IDX);
+	err = request_irq(irq, enetc_vf_msg_msix_handler, 0,
+			  si->msg_int_name, si);
+	if (err) {
+		dev_err(&si->pdev->dev,
+			"VF messaging: request_irq() failed!\n");
+		return err;
+	}
+
+	/* set one IRQ entry for PSI-to-VSI messaging */
+	enetc_wr(&si->hw, ENETC_SIMSIVR, ENETC_SI_INT_IDX);
+
+	return 0;
+}
+
+static void enetc_vf_free_msg_msix(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return;
+
+	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
+}
+
 static const struct enetc_si_ops enetc_vsi_ops = {
 	.get_rss_table = enetc_get_rss_table,
 	.set_rss_table = enetc_set_rss_table,
@@ -511,8 +664,41 @@ static const struct enetc_si_ops enetc4_vsi_ops = {
 	.set_rss_table = enetc4_set_rss_table,
 	.setup_cbdr = enetc4_setup_cbdr,
 	.teardown_cbdr = enetc4_teardown_cbdr,
+	.vf_reg_link_status_notifier = enetc_vf_reg_link_status_notifier,
+	.vf_unreg_link_status_notifier = enetc_vf_unreg_link_status_notifier,
 };
 
+static int enetc_vf_wq_task_init(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return 0;
+
+	si->workqueue = alloc_ordered_workqueue("enetc-%s-wq", WQ_MEM_RECLAIM,
+						pci_name(si->pdev));
+	if (!si->workqueue)
+		return -ENOMEM;
+
+	INIT_WORK(&si->msg_task, enetc_vf_msg_task);
+
+	return 0;
+}
+
+static void enetc_vf_wq_task_destroy(struct enetc_si *si)
+{
+	if (!si->workqueue)
+		return;
+
+	disable_work_sync(&si->msg_task);
+
+	/* Disable the MR interrupt */
+	enetc_vf_disable_mr_int(si);
+	enetc_wr(&si->hw, ENETC_VSIIDR, VSIIDR_MR);
+	/* Reading VSIMSGRR to clear the MS bit on the PF's side */
+	enetc_rd(&si->hw, ENETC_VSIMSGRR);
+
+	destroy_workqueue(si->workqueue);
+}
+
 static int enetc_vf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -587,15 +773,32 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 		goto err_alloc_msix;
 	}
 
+	err = enetc_vf_wq_task_init(si);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to init workqueue\n");
+		goto err_wq_init;
+	}
+
+	err = enetc_vf_register_msg_msix(si);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register msg irq\n");
+		goto err_register_msg_msix;
+	}
+
+	netif_carrier_off(ndev);
+	/* Enable message received interrupt */
+	enetc_vf_enable_mr_int(si);
 	err = register_netdev(ndev);
 	if (err)
 		goto err_reg_netdev;
 
-	netif_carrier_off(ndev);
-
 	return 0;
 
 err_reg_netdev:
+	enetc_vf_free_msg_msix(si);
+err_register_msg_msix:
+	enetc_vf_wq_task_destroy(si);
+err_wq_init:
 	enetc_free_msix(priv);
 err_config_si:
 err_alloc_msix:
@@ -628,6 +831,8 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 		enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
 					 false, true);
 
+	enetc_vf_free_msg_msix(si);
+	enetc_vf_wq_task_destroy(si);
 	enetc_free_msix(priv);
 
 	enetc_free_si_resources(priv);
-- 
2.34.1

