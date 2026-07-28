Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FE175A7B;
	Tue, 28 Jul 2026 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785205747; cv=fail; b=mdJBeZcBWfGJTLL9gxMlL/AyHONz0X2r+iZnChM3Li1Ke8Ej5H1xkSd9pq2PkVEmBGeUHjX1XpekSwBCsRXgxGGYinIAP9L/gu5Hus/XbuMihLrk2tLVO5U2UCiIWT8kdu/XRfezGTaPtt9uUH+vwikeHeTnbC594hmyqTUXzWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785205747; c=relaxed/simple;
	bh=LIFVnK3qWqhzpxnpniUqUK7Y/y0VRui10ZoHAXcbJZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WZstdOrhpSpCWMmN5rnB7eS7x94nMmUjLtpap3Q8ZkQDS4qLqJ6qgpzmMdjuOvpBeg1tGj0RWW4SiD7aCXeX7owTsRb/eRpYOpY6LJoMt6y8Wm7wIUJ6gJQB1jlFGFMPf0TkV5ZpwIOh1WXrI2FPBSNa6rV+JyGgN1s8S4YvMiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GkxIsIiw; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GkxIsIiw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duMttZlDvKgX0NN0GylgFWq58eZueKxVzSwWMkHn8Ffh6q8XKbUMVLTXpUhIXsSj6iNq1nUwgPBnrGl4ipEurjXEUKdQNq8uMBOvV7nApzuUCqskhX1mWiFyJFtbgfGGEk2ek9PxWCC2fsQoKx31Au8qsVyUiL1N0kVGWBZG9dBNrfW+N0USQtsVSvyD9O28VEkRbGxBgFQBhUekpq/8pYz+yra4r/NfJ+H5yIArDvZysv2y3yn0dDwF28HLbkrjM4zuuYmBMIVLq6g/f/0Klmn6XimzziQ6+CTAdlkWuaU3m+MAtJ5WauzARnP6i+MrGCEkb+oQ5KfsLF8lCF7opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fw09qL983/31aK+D4lX8CLSJPk4syhoR8jvDgeBLNVo=;
 b=Cixz0ddrSHC/+QMKC5kmjhHdMk36SEbW9wDCgCTT/gYOOXNzFwRl3mlSy01RcOTYesoLGzyhmLe4foz5aqQpRH86TwCXUV+VYZnV5BX1FwD50EtGMMlj0ihcJX9BHV2GFvl7wC06kdLvfERHRIofrsg8EM3R+CpEx8KtQrW+KsF5wa6Q2VcIKfcSeyoA1G1+XTVe+g9jK7DkCyn95a1e6qM/3Dn6d+TPylrq9r+cIhN2R2FPwGVgY/t8HTt8WtqlP9JKI1AZJVANPqfrVizAmwPrb9FwsmOYiGSFlH8zfWGCIFeV5D9Dj0VnCPCyTDki5aR/ghbi1zfcBgYDg4MB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw09qL983/31aK+D4lX8CLSJPk4syhoR8jvDgeBLNVo=;
 b=GkxIsIiwknuFEwzuZtEMO6rwQoZsbH1AO86vgGfleUbgUhMbUtL/ozS5QYsntfOwDwt8KVBZUEwkmdo5n3u5ChYoSDuJdOPQK8+SrSoAlLcqRJ5VD4XOcmKVSb5VZ/HKKKeoDQawCgBBI/Wsedq5ZyoHwyH9tTNBIrlzPS1K79+YQp7nt6b4ZbqyQW5JJs/mKYxge2ZiD4n10IPo2K9HDITc3ijbAeFNG54EGLSIc7p6AxBKbc3CBI+OE+EEtz4i9FiwycnyPWi2FyDdNhpVSjgwK4ToKX9TPhPCIGMKc5Dy2ckFukS2dIZZsNraUUUc2jZS9k5XmqqSERTxBmzIeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB12186.eurprd04.prod.outlook.com (2603:10a6:800:331::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 02:29:02 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 02:29:02 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: enetc: restore RX ring congestion mode after ring reconfiguration
Date: Tue, 28 Jul 2026 10:32:16 +0800
Message-Id: <20260728023217.2499420-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728023217.2499420-1-wei.fang@oss.nxp.com>
References: <20260728023217.2499420-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI0PR04MB12186:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a707b80-d3ef-4dc7-1ff4-08deec4ffcbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|19092799006|18002099003|22082099003|56012099006|10067099003|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	DNRh7RWidoBsuV4Wa9GK5IwmabIzpJo6C0gT7Hz63aO51qxIHl2bvniYeaa2vRwUnMXziBX4fpH5ifrFJi3r7VWt2qC0Ehtn0VaIaCOX/0N5DkubAqB1YFq8izFwOEecNtxFUcJIedJjL6XQftQ35p4JIadHtmyuZx3rHh6kn3lF65wxxy01VpBeueQGTTOFRAEdQ58XyTqT+YVBYPb6RvkTDiSZJaqAE/ZzxlmtxCHQ9Tlwu2i9oDm0KJ820diAuGTShs/4vOqwUoYVprXupH86KJiHkQZoVSrhoLT88bI8x8YwpV3gCJ7mqKDbsl4GWEONTsn/l0YKsc3WrTQ2tzSJP77Z9CIYu8+CerkirdtYfqCEVODVJTeNQf4y7Vq1lIwr7UNkAXDaCtkK3JcV1Exv2+knAz7NT28VfNmxz8ErD+GcTitm0bUzSaPijGSzrADxOMsKHm/yvbiKq+hoC11i4wuwzvKC/hGvAzKlMCelWFUfnGM5q7LNqea4Q/3/RQ6lcxvP+mIBvMKIdqU4zeCGe9tix/TTDx/5TUys62GFFHNJxRsbFtDUm4uHKtUVkxhxCIAIbY0Qgh8aRNQsRPs43Lv2XvsbJxCIEbQPBWV4SmbHYdtwlgwMLSf9OkBBdG4rvIaCicj8G8HN1HKolAGd6ZIvleqFMstR1m0AMTk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(19092799006)(18002099003)(22082099003)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YWASk5MVNwPyQGGA0NEfqoC7hvyqQEcCrB4CIOuB+EiEhH/tYbBGXa7ai70S?=
 =?us-ascii?Q?9MU9CKZDlL1OUAz8ag7BNngvSGEWpJi5lI7KLEGcAqEsVS8Xdc1TsDDKhTa/?=
 =?us-ascii?Q?XVktQ9xiroWqzOdoTRZwwVh7Jtm7F1UeDKwvwjQXHDsM2edxm8fdMGx2JcB+?=
 =?us-ascii?Q?AK0WcVTZwB2N6lYvACLj9sVETUncEA2ti9/nsrbzQTYc5E/vx4tG7G9fCeHG?=
 =?us-ascii?Q?rtHFicuL/Sd++aQ8Bkthvh+aePZt/Pv+KGfMRi/ie/BAVVZECqq1YvNcG+dV?=
 =?us-ascii?Q?2/g+jjR/Qvm75uhXzw0md9zuAR+kIqzrlmRkaaV9p6Af87hA0UzG4gJQ6UhN?=
 =?us-ascii?Q?w/nMTlln3p1wwc+T8Xhz8B/dzSmAPg37mL/9Lzb29hygUwtWkeEtrmdfotwt?=
 =?us-ascii?Q?tC5fTHkZ8gMOGwcYv+eUGRzRssjqOIXA6/YFssWxt6cbzjzCwWJwG6yWtGVl?=
 =?us-ascii?Q?2qPjBKAr86Tz1yWfuq09ZLjUr5xLvKhUbqvUIFk1jXijhU00PGJHuM91QQls?=
 =?us-ascii?Q?tOBm9iih287ucxZLJ8gYGhQaOotCOIWVIKipQ2Iiq+HX5KY5SpWJergY+CFs?=
 =?us-ascii?Q?Zt5RaeymKvGWPGaIU0uqp8U7OqOnb3wqsWlD6LKr6Zc7M/hamMeGg37gfjMZ?=
 =?us-ascii?Q?R4kniVFMSHhMRNWAxZi1rHVvaVbxR13+FhpkyzlgHAIfYmlEjOIU2BSDQQ96?=
 =?us-ascii?Q?SS1XER3fUCl57XXzNTLzlltDvFLq3qeqVNfYtQrGSty21ezrdNkVFO0JLKSu?=
 =?us-ascii?Q?eX1JY2kvz6LKG3paC9aM7cTSYyi4UGGN15agw6GzDvsRPK2ebu7LKz5sUxsk?=
 =?us-ascii?Q?kIjdWcRASTmZGeXx153NyoUTf/C4JGwOdsosnyJ//Zu2eLD0MY254zwCnfHb?=
 =?us-ascii?Q?7aMtXmPXjbId3qPtY3Z9WKFqeYBfqI7pzP28osC50U7ZCUlKk5FtgABh2SMt?=
 =?us-ascii?Q?op31rFuy2BU+slU+g3O2freXd3pwAKgHeRM6b5PWdGP+6iTECp3LSS+arQfc?=
 =?us-ascii?Q?PwHU44XuAajwZNZWwaTUTjeJsCOdOgweU5LJhXVxT3c1AEFd1PhrHrmO/EJd?=
 =?us-ascii?Q?IVtIdmpWBd3JRqkKsAStgh8v7MvU7ZE+ikBqIgFIDpLsuGmZ3STWPEJy6vls?=
 =?us-ascii?Q?hc6IqMChoNpvKhLw3avJy1qYfTW5ReNhp6TUlL9mWg8MBmjHd++/DQBTruIG?=
 =?us-ascii?Q?E89h5c8dRQ6OBnuHh6dYrbCtQGJyXyDr28iUoVjR9UyiMHkC6qGeFHE64DKd?=
 =?us-ascii?Q?aL2AZoLORnDGAF9F3uwaBAlNgjc6r6Of9V5cE9IT7KoRX4F32w92fbeoQusR?=
 =?us-ascii?Q?UCp14HvyI4v5PcXRYIZf3+Iki1Ck5XlJeMyusveccDBae6wrxOPO6NAUNqDx?=
 =?us-ascii?Q?CfLhZkQWgoP3eSHFXcX2vWYj+IUbnhesWlPeF/bvo+DrGToFdektGf6MoJfV?=
 =?us-ascii?Q?DItRs5y+v4xW2PXgyp6TMZ5oZvwuCdzy4txyjYjy7NTVYtS62QaF/TdT5hwQ?=
 =?us-ascii?Q?A+69TDtGI0cyQK124RFeoiuRkPt8P5WUnY6Eu5VOIpuJgTQxlxJgUFcG48WO?=
 =?us-ascii?Q?byOT+Eq+vybDQPOqvUKdqBPTQ7kxLvKe75HoklRflXP8m6z9FxHkbDXOPFJy?=
 =?us-ascii?Q?8Tcat0YrvH2++3OItqAsqP/weNUd+Zlycc34RPUseCrWnGwXWDlJknqihKGE?=
 =?us-ascii?Q?QwiDS3uixJ0uM1KCjB28mkSWD6CgBaNL/XOeCaymOsn8WCq9SVuVRgIkW+4x?=
 =?us-ascii?Q?aEvDfLQbjMqkGWm1CeUM4EWsChOv+o0eaaZQGo0/0aIFXhsMrJCy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a707b80-d3ef-4dc7-1ff4-08deec4ffcbe
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 02:29:02.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxHkJdHqjsKNpbsxsLU6qOjO/YZ69GnSgPGw8O0HyJO+wqmzYp/TgE4yc0XrQraxvom7ENy04rqEXFxotRScDw/SR4ePSP1LGQaMAu6GW5xfKaNADxJq/P9UXPTcU92w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12186

From: Wei Fang <wei.fang@nxp.com>

The congestion mode (CM) of the RX BD rings is only configured in the
phylink .mac_link_up() callback enetc_pl_mac_link_up(), where the
ENETC_RBMR_CM bit is set when tx_pause is enabled. This callback is
only invoked when the link status changes.

However, enetc_reconfigure() tears down and re-creates the RX BD rings
at runtime without any link status change, for example when attaching
or detaching an XDP program, or when enabling/disabling PTP RX hardware
timestamping. During ring reconfiguration, enetc_setup_rxbdr() rebuilds
the RBMR register starting from zero, which clears the ENETC_RBMR_CM
bit. Because the link status remains unchanged, enetc_pl_mac_link_up()
is not called again, so the CM bit is never restored.

As a result, the ENETC MAC can no longer generate PAUSE frames when
congestion occurs at the ingress direction, and flow control stops
working after such a reconfiguration.

Track the desired CM state in a software flag ENETC_RXBDR_CM. Set or
clear the flag in enetc_pl_mac_link_up() according to tx_pause, and
clear it in enetc_pl_mac_link_down(). When the RX BD rings are
(re)configured, enetc_setup_rxbdr() consults this flag and restores
the ENETC_RBMR_CM bit accordingly, so flow control survives ring
reconfiguration even when the link status does not change.

Fixes: 5093406c784f ("net: enetc: implement ring reconfiguration procedure for PTP RX timestamping")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c    | 4 ++++
 drivers/net/ethernet/freescale/enetc/enetc.h    | 1 +
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 8e3f345dd9aa..9282e13ccfb2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2631,6 +2631,7 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 static void enetc_setup_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring,
 			      bool extended)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(rx_ring->ndev);
 	int idx = rx_ring->index;
 	u32 rbmr = 0;
 
@@ -2666,6 +2667,9 @@ static void enetc_setup_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring,
 	if (rx_ring->ndev->features & NETIF_F_HW_VLAN_CTAG_RX)
 		rbmr |= ENETC_RBMR_VTE;
 
+	if (test_bit(ENETC_RXBDR_CM, &priv->flags))
+		rbmr |= ENETC_RBMR_CM;
+
 	rx_ring->rcir = hw->reg + ENETC_BDR(RX, idx, ENETC_RBCIR);
 	rx_ring->idr = hw->reg + ENETC_SIRXIDR;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 04a5dd5ea6c7..341f54856deb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -419,6 +419,7 @@ enum enetc_active_offloads {
 enum enetc_flags_bit {
 	ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS = 0,
 	ENETC_TX_DOWN,
+	ENETC_RXBDR_CM,
 };
 
 /* interrupt coalescing modes */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 2d687bb8c3a0..3fb689d27a02 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -633,6 +633,8 @@ static void enetc_pl_mac_link_up(struct phylink_config *config,
 	}
 
 	if (tx_pause) {
+		set_bit(ENETC_RXBDR_CM, &priv->flags);
+
 		/* When the port first enters congestion, send a PAUSE request
 		 * with the maximum number of quanta. When the port exits
 		 * congestion, it will automatically send a PAUSE frame with
@@ -652,6 +654,8 @@ static void enetc_pl_mac_link_up(struct phylink_config *config,
 		 */
 		pause_on_thresh = 3 * ENETC_MAC_MAXFRM_SIZE;
 		pause_off_thresh = 1 * ENETC_MAC_MAXFRM_SIZE;
+	} else {
+		clear_bit(ENETC_RXBDR_CM, &priv->flags);
 	}
 
 	enetc_port_mac_wr(si, ENETC_PM0_PAUSE_QUANTA, init_quanta);
@@ -683,6 +687,7 @@ static void enetc_pl_mac_link_down(struct phylink_config *config,
 	struct enetc_ndev_priv *priv;
 
 	priv = netdev_priv(si->ndev);
+	clear_bit(ENETC_RXBDR_CM, &priv->flags);
 
 	if (si->hw_features & ENETC_SI_F_QBU)
 		enetc_mm_link_state_update(priv, false);
-- 
2.34.1

