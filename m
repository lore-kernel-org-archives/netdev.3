Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB182DFA3A;
	Tue, 28 Jul 2026 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785205751; cv=fail; b=OS6c26256TGgt6TsSPH1NNU3hAYNcQsuO/qXdpfD+D1wN0x1xXcuWeAHnxUWCamChpEWJA/soQYIzJUipE78FATIQA5z4T09qIxs8pRYlCXpLW00bhhztG9S1Ov2cavM4w/j7R0xqm7u31ILH8s076+7e91Otq20adoh5IMCx3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785205751; c=relaxed/simple;
	bh=PAAGf+lAqBkIxS37bc1kUfp4n10bGzRsNAJl8hlAr98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uRmanIi5/gP1l8NyDnBPYCgX8VOOi9M1/7bTp0aG/06h/4o776VrAiBRB7SlZJdr6qpezU7InzBoEOePAC0wHQGD90YuAIlb4M5Z2/77PvapS34kcCOjZOG4dSiATmIuxAHu/2Nt0cQVez4PM1nQeyASCL+rM79LPFgOpeyaGsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PgXD8eRg; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PgXD8eRg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSPh1X3J+lZ8LoGYILHv8c+69sDYDaa0J89eS38X4OELTzLpXVCefcrYuachMGpDJe9U33VZpNo9OMztocW5gPokFbjhBFdMHSOa6DkW24PP5LSo0qU12XWC8k95isnxPTEWMVNhqMdW4SChltYRB1Fnnifzp4qPmfKdaCZCfDzENZZS6ruvUdxDIBqoQ7uDYAwG/pO1xSWoJKuplHZwn1fOP+Re/vnRQ4OOBa1Q3AwDZB3T8CXHlCqoAnCpjvMHQmKzWRHifYP195EYVBrU84jIMzEfl/LDq3Ax+6ys45khbyO9Em18B0jk+MRn2yp+irBULtWrhDt5gLZ6Hx2xuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2EbKCLWKFXWvIyMmT9bKUim9Xv67Tdas8R4TvZGnvk=;
 b=yLS78J6Jx0PvTdNXcDptUzV+FDZ4bSP71o00PYpCMzkNI8A/oyTKmQv6msfJO1aRk9XBuyIHITg2lu3H61PtAIF7ApxjTPqIvFr1FTHJLK5bm9ujiK4Lim8DkrfdjE4siwj0A8uFycRy4/sQXyBXEUuyvm8LvQPf/M9jCJL7Y1+uW3JvGoHRNAiME5Np0TBedUKzp9nyOGQI1VVm64iiQa9OugaZ2KXqslR/F09AvCGLK/f/4BRCZwMWcLGn+wIniWaycEhTAnAe4Sky2iyd0mVdv7gMWukBgLnHMRrrBJsJubKMcpHUxV3rMPa8bXQHXpHdc/uzY1UiDPunp/ucig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2EbKCLWKFXWvIyMmT9bKUim9Xv67Tdas8R4TvZGnvk=;
 b=PgXD8eRgx7gUrQfv2UKHEOAbfiBQYB5BKAH4GSCOdo0B36sg9NQNUi5dRAfVh2MMp29wl4ng76T6jWlAGNEc4Z9CL5QRGFNUUW50fXPa0WVBslyRDibHCViGrDoC9/W4UshHxWVD1busUJFSpIi/7au6D12FkI8GtJRJID357JKIfrMHuRiKA94KJZGojhMc6QW39XQ+KCxcuw/t2nAARIYgyq1kFFmW21M7z22Bai5J1D3RhBPrYSOHC3QaC9jwfz8IgFU1RIJuOOqLZERHtFyV10M8vsb7pSVu4kjUFVOsanSMGMiYy52cqUrdJm8R196kXi2d2bF+QKKh1fyiQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB12186.eurprd04.prod.outlook.com (2603:10a6:800:331::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 02:29:07 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 02:29:07 +0000
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
Subject: [PATCH net 2/2] net: enetc: restore RX ring congestion mode for ENETC v4
Date: Tue, 28 Jul 2026 10:32:17 +0800
Message-Id: <20260728023217.2499420-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728023217.2499420-1-wei.fang@oss.nxp.com>
References: <20260728023217.2499420-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI0PR04MB12186:EE_
X-MS-Office365-Filtering-Correlation-Id: 728f75a0-aab0-4abd-8768-08deec4fffea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|19092799006|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	0IHYbV4Gv028DMPqyvrn5Ur1lw2ADPQ9qb277UPHkjRYNGmufGW2+MqxIwO8GPT4bfj4BcVTuu51WUeWG9tTrOZT73BO6szyyjU7xt2uWwu+SMndgMiY/2HgKmSQOxuEXm/3vNFPmqP41gpixZ2x/+DITdq9G4HA3ShoHcyuyC3vJ2wd+vS+K7GcL/JRVle8/BM1/IaGKdpqcRQTxKHe37U+7JFHtaJCe2ozwem2D4kxThZWzHDaj4OOykrc0hiCEhpE6JtRtYRwPVxGMyiE2Jqyv12ztRlx0zVZCFNjMqoUBSAA87ICa3buuqVGtw3wDwPL3HRbdJh9LjipQ3nL+JBsR9pj6nkvwvPw7uN9Cw8xTN/Npsjy1vDjmlAyHNvJLJoqMwRWw3osSETWm4iqheeQE0RNPmoy+EubKooZ7xrK+hJ9wyBUy1PcxiuO64zRzhSFk2XD6cN58sy90nyCdzZKW7+zbBj66RW5Ybjh+6h/jLF7HTdZZDHDlKPSGDEEEz93KC2NBKC4qhG49HgCSIA9lX9PLuzhX3xgAhceUCb9ttA02zdrWjRtY5iEOJBOwtwl7PIeo/9bfTMOh4rCsBqMmQAx0yTr1GKKNzOYhqvoMiF9OEI/mYbrJtbpENGBzFBTw1Xj7dmT/75G+ACHYEEV52+9SE1GkIjAO77O5hM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(19092799006)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N33HdM9rAciWSHDZ9oHH4HLrXlrUh1ObC9sH4Re2yTPURiVaq6FMaYvONj+b?=
 =?us-ascii?Q?qIvH2G+neY79iXm+D4QABJIuzD9BnbEiV8i5lzkZdFrdRZ1pzbKKR0FPTC54?=
 =?us-ascii?Q?awrOmUrITaC5cJxznA7TQWC0ETeFWGrRwKjrxeKYJfJRpRnKhMcNRXxC51Ee?=
 =?us-ascii?Q?JMmveI9bKlTUG+Cs2un1Biyyih5F5Zi4lE3zDR2Rj3vw5dd1JBojPgTgayUV?=
 =?us-ascii?Q?7MIjqEHkIt6X/EC4lrHzo3aaa0aJ/HKuxiwbhSK2ibL7Mc3xcJjzv5BCvvg/?=
 =?us-ascii?Q?Dxlp2pSnWokDsqI0GCD6/mC7E1fLwJplbJtKXP5jGEf7CySJEv7oWIY9St65?=
 =?us-ascii?Q?5nzmE/OmLKmsgHfEBYjepb9S3/sLaORi9iM4XbqRlFinQg8eL9pbESsO+7Xp?=
 =?us-ascii?Q?7Ey1MSGBwX6JfdpU/MrOQqUz8OGtFMBaTB9l//Wxz8dm7msiOA+epHq0Rrj1?=
 =?us-ascii?Q?HtXFjkyQtB1vYk697KHxaMU8Ed/mSq9HKyLzUQsXOO2K5EM/oU7/hobgI2AK?=
 =?us-ascii?Q?tsPdFIhx/j2RarkmYXq6w6I6jAqWF3M8Pi65/9ikjh1AD5+NTFpYecGbVmws?=
 =?us-ascii?Q?QoD1f4FPyijPNGy6y9ZaRjacQq7LRnAbB82yFgfcyX1gnvh0Kt+jJ1wLJIrH?=
 =?us-ascii?Q?3wtKCtUCtITe7BcLtjAWD5gmpcvRrudt19xqfVBXVhuEC+qheTcjZbsscJXJ?=
 =?us-ascii?Q?GVvrPF9rgMTBcKRdmMdWW/x29iTYtHOmh38pOe7AvZ0cNwQOtmKhWWN6TEp3?=
 =?us-ascii?Q?WguqGLSmu91Yqb3opWUDAa21Y2CG8gHVHD/WMU8qM26mu66HhQyxunqquRSS?=
 =?us-ascii?Q?4fUkxMO2VEzmbJFyM25i9PyHY9QBd7tuAUm7lggzms1DR2BsNkhjxEtv4Ah0?=
 =?us-ascii?Q?dg8noEmi4F9h0M/WRWkYXrie/MegbTGw3cLsyPb9/m8BaqQ2f1MC8OzOHllH?=
 =?us-ascii?Q?AKOflqR0rsjs0XnExAKQFbI0ysBSHzKa3uFFI6HX/586yCFAM7wShjcdizqi?=
 =?us-ascii?Q?UKsBjrwC9CAckJrjECZlyEYykBS69Dx3AGif/RMBucr/wuuC+GTDDzEGiNBq?=
 =?us-ascii?Q?J8Rs/lgKWxLDyMzuOHoh37sL9j4GyrpJ+PYFUIw5lNeIIS3N/0H6RDHwBs2N?=
 =?us-ascii?Q?IQ5Nw22ixsqgvt5yrhIwRl5SsQEL4snKS/ggZrVkIgtOpnyBvRHd7TaBWstJ?=
 =?us-ascii?Q?EUP+Gbvbh+zKUOWA+6BPiSUZsvAIp8jQR9DFNCUERYGUYUG7eEH+kNQykj7p?=
 =?us-ascii?Q?k4kTrcGP8T1yaMTgfkio2vdkuX2uCnbmnpqxaEDw6YYuXw83dweLM+f7DqHA?=
 =?us-ascii?Q?jH8K/5dVwu1K7gGa3Yo/in+NSg2I/xJeVKNNczJrrWUl/RxB7YEjOTrzrQop?=
 =?us-ascii?Q?QvfqiOVOEUGdoMaJ3tg2NwlMmQ9+0vwy9DZV3GJWH82lvYGRH/fnAvTBa71T?=
 =?us-ascii?Q?aAzUwvoH5Bl7MvIFnU6bXjmvvnEwBX4UANJpUZaEufXKaqTkmbq5kOWBpPuQ?=
 =?us-ascii?Q?HUXp44uCWtXDKLLD8TVe0+ncZ3TlInlz9zigjVZNTEMoSgLANL4KoLER7ZIN?=
 =?us-ascii?Q?r/GaOyjyWxlMCHahCUD6GRHhmKlvJ7H0uIJlzqHpwHbd8GblDJTo6Yg0FAEM?=
 =?us-ascii?Q?k5xtNEGVfrdBtcuy6vJkJkaEL+yJnF6HTSZRpM3fFSNsgyNQfCFw73On+crk?=
 =?us-ascii?Q?rnLhyKOZbxD/OucOTPhaAD/rqQzj3PEpI+Y/aCFy6rioGW6ZvkzRPzfuquWt?=
 =?us-ascii?Q?gdqtFPc1YPwPPAtVFAiYYwQ/d6OERfSyElIenwdvfWxIsfEVfZq1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728f75a0-aab0-4abd-8768-08deec4fffea
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 02:29:07.5076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzkPBFmVhFqxtLpnbm8JL9ZNMa7QCv1b2EMQ0buXnFjbIz/ym8rlOBUQwrBkVgW7H7R/G5lkk+zydgWXaJmJpi6jWerFEo4RegMev5DPYuz9LkusKQ0Iu1Uurcc79Vqi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12186

From: Wei Fang <wei.fang@nxp.com>

ENETC v4 has the same problem as ENETC v1: the RX BD ring congestion
mode (CM) is only configured in the phylink .mac_link_up() callback,
so it is cleared when enetc_reconfigure() rebuilds the RX BD rings at
runtime (for example when enabling or disabling PTP RX hardware
timestamping) without a link status change, and it is never restored.
As a result, the MAC can no longer generate PAUSE frames on ingress
congestion and flow control stops working.

Fix it in the same way as ENETC v1, by tracking the desired CM state in
the software flag ENETC_RXBDR_CM. Set or clear the flag in
enetc4_set_tx_pause() according to tx_pause, and clear it in
enetc4_pl_mac_link_down(). enetc_setup_rxbdr() already restores the CM
bit from this flag when the RX BD rings are (re)configured.

Fixes: f5b9a1cde0a2 ("net: enetc: add PTP synchronization support for ENETC v4")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 437a15bbb47b..8db5a47fdbae 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -748,6 +748,7 @@ static void enetc4_set_rx_pause(struct enetc_pf *pf, bool rx_pause)
 
 static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bool tx_pause)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
 	u32 pause_off_thresh = 0, pause_on_thresh = 0;
 	u32 init_quanta = 0, refresh_quanta = 0;
 	struct enetc_hw *hw = &pf->si->hw;
@@ -764,6 +765,8 @@ static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bool tx_paus
 	}
 
 	if (tx_pause) {
+		set_bit(ENETC_RXBDR_CM, &priv->flags);
+
 		/* When the port first enters congestion, send a PAUSE request
 		 * with the maximum number of quanta. When the port exits
 		 * congestion, it will automatically send a PAUSE frame with
@@ -783,6 +786,8 @@ static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bool tx_paus
 		 */
 		pause_on_thresh = 3 * ENETC_MAC_MAXFRM_SIZE;
 		pause_off_thresh = 1 * ENETC_MAC_MAXFRM_SIZE;
+	} else {
+		clear_bit(ENETC_RXBDR_CM, &priv->flags);
 	}
 
 	enetc_port_mac_wr(pf->si, ENETC4_PM_PAUSE_QUANTA(0), init_quanta);
@@ -949,7 +954,10 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
 				    phy_interface_t interface)
 {
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
+	struct enetc_ndev_priv *priv;
 
+	priv = netdev_priv(pf->si->ndev);
+	clear_bit(ENETC_RXBDR_CM, &priv->flags);
 	enetc4_mac_rx_graceful_stop(pf);
 	enetc4_mac_tx_graceful_stop(pf);
 }
-- 
2.34.1

