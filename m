Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D423B14C0;
	Mon, 31 Aug 2026 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146627; cv=fail; b=mq33fJPrlwAdKoH4oNir2pB/lsVjkggazop1tE+Z3GjU32wgSVweF5mCdmWjoIG//R69vAW84NGYCGIltTB2IDze2N6x809BAd/gWUDbs7c/1wLlThawmtJAkWaqQrtmsjWFwEWuwCbrosvpxQrHrbSYNP4eJDUxB/+sNcCb4N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146627; c=relaxed/simple;
	bh=x4ZpcRv2lWzqSsv9MDgaGx+rGzQc04MGAe2gPJqdtE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NAGTrMXMUd3+KPJe5rqDfs7vO2Y1ojNfXLbDeCRfDgpAWbvu7lZ3I9ukxu6RRP1SdTVsqzieDk5Al3PZ17WVzlFYzeazYBtWvtcSHoe+Z9UuLABZzUxWByQTPNN0e5M6F2C36/c/Z3SmPr/LyoeVtVgbaclhVT7pzLM03nGJJ1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dXzXty1p; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dXzXty1p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvvywPCbiICF64iCbFjMDDim+Hd18arFfwtCnoEq/N/XgZAQhueuS7nVu9yQ1l8/bUAK5HBgpz3eMQuB2UK6lu5BGP2S5lnYdTzO1tPeTkeTHOcCM5/nuwAxsWPmVhlQkhWa0TfI3xIBQu/md9tYhlaOMEL8PHSr6Evn5JCHYt9EJFbrNnMK//IbCs0pTtOPis/uRjD+/ntxvgwKdUghjGgNDrnY7YHm1+EJ2u8B20j6bUEzSHS9+LTtf0vXeHdn9aiWf3gxY0Ioq3zO6sM3x5vKMpaIf1BbGAHs6aTOJBbpE2L1HsEKSkyolRaeNsF99eyDPClvySf+zqKFEg2JyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B8kH2n37T6K+KFaqktPyEs4dDL/KNyVisz6MOxSqvA=;
 b=dhDAAdeBPBS597+MdC2iqmGxE77N9UTDqGr8yH4sgI0JYAV4syqhiAWPjLMMJi7lbCSmclhro75A+kvf0kivXJ7VsTnPu83DwvTUbTq074s3FnPWNb2TybNk9CPZB80mv1vPcV8lR5Mk0oRU1lTMXHnYESyLNH9WZMJ0cJbxhSA3oJaVe6k6TiGqHDMjjt4DRaQ6+lyW1MXfMgcgb1VzKaStgMQPrHq67nIPxlzwf2OMeBHZGXkPZJwgPPBaNundPHidMtgZslotKdfR3GNQwzyqUqhQKzOAysxAxZoDHT9TQCY5p3gcwHVGDQczwXIDMqyTj2qBpGucsoANagdeGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B8kH2n37T6K+KFaqktPyEs4dDL/KNyVisz6MOxSqvA=;
 b=dXzXty1p+09w4OtTQ6uJJ/CrFmIy612lbmghS5NYfHlBR7GRjRGIMwY7FKTY56JL1Kd+6WfkfeW4cN9EktIJwBL1hVcWp3zyRfXXuJlZJVWhof2cKx+hYaTQp/B0RYzveU68LnuA6fPwCRZ0tJpyLM3oZjqUPEASSXjb+PNs2aG3nji17PG/OrBuJkiJuYwsEARyDbTLMkJgBS/SxwTWl1lODDXBTNdPZ9NZWjtoFAZQwc+GL/p730hUJjZuhvQcneVeSUBUDhwE/2s85i9vtsK7g5F4tpqCRyIsGiAenicPTeadc6UAeQ12hd890qf+MTd1bShtfE7NuIXkNVPYyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8474.eurprd04.prod.outlook.com (2603:10a6:102:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:23:42 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:23:41 +0000
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
Subject: [PATCH v3 net-next 14/15] net: enetc: add PSI-to-VSI link status notification support for VF
Date: Mon, 31 Aug 2026 10:54:40 +0800
Message-Id: <20260831025441.635045-15-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 2184ea99-92ed-4fc3-7aaa-08df070f414e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|23010399003|7416014|56012099006|10067099003|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	KnAwDq/gKWlNJv1tIakXr2wOvTw9tmOwrr0oWrMhQdmJWtVRHYGEyG9+RmnCcqyKgrqctR9CPGDQuVda1XySMH9ugNGnQid2g1xbzug/AGy2zliuHxBXP6+f8RGMXix3I+kZ7oa/labEKrE4l/+IcRh3cqFMM9vx51OFdBAY8BTVHMAaCsCctIIcZ9vOaHh8FVNEFauIO02AltNqu4skObb9S+FZ1Vo8N7/+XRAE13IqFB6sUGdQwNkdYEm4N6cvh9eO5TcE70UhLtMFWYSm9jUQa0lzuEqVeD1qICl1JoOQ4ik1di6labHUApc5tSAbDCwKMS4XcqNew9jq/ywRpbugy5wEIjFoQyZ75lZOSQT8kAD46YpLUXiGoNWMlNsPtHy93PBqrqJUWKrefdFV0koqmSyt59ZHVjrtmyp/W0npZr4hLsrLv0omafjxLfQTqPte8pO27m+p/SqzUcV8EKwfPUpfdENkD+lw1zGAMSofZSlRHVhs5pbiYAW8Awvj9KKNt24+7MQ2atsoN4Dehs3UHNpV2e8tqKCGp+tPKGF/L49HcZl38Pv238aDKWHpDvlZEvYvZMkCLzze5sQoWczuRWhfcXCalSGhQuPXr2eQyam/vIMGLUaTvTOo4VQTOZjGuFGT9/qxvhjZ6dmRciQPjRvQ/DQqUQQ1AAHAXNkB2ciNubI9O9lzGKts2a84/KFZ+FKswtGjLhWZBRNBdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(7416014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dZmgPZl9mkUiye6GfiC7yoDLwqlfKm62Pzu0uvNiBjj9+WyJK96MR61rZofY?=
 =?us-ascii?Q?nea9ubMeaGXj6LsDugtb6T4ZcRmtt3BPz32gQnL4bGY4QcAkwG+0E9Oq5RWd?=
 =?us-ascii?Q?zwkbePWAPTyarkASGydMhx7TpybZ53Ij6y5XfUranmy2yNPEgsmM0LHgNVaj?=
 =?us-ascii?Q?OGXqR1LhfMecFommkoHrNqwckCc6tD6T8G5/KDOiDZ7z9PBzhA8JBxd78V88?=
 =?us-ascii?Q?x/LnCYO6GdRZfGQsByHUcW0Tl97FzSR61Oim7uFxTR9LHXw1l++RHuU4d1s5?=
 =?us-ascii?Q?WaKKlUdQ81aN5S7JcRQIAmuvpZ5KMngv3IwEvH4T3oMSct+9KzCbqZxgeC7f?=
 =?us-ascii?Q?iaJDgJi/+q69vhbL50f6Ja4Ft1bl7PMRFyL9+FlJlpl3h3YcJabRtohN+GOH?=
 =?us-ascii?Q?mP+zLd/cAqfFwW/IASOUDq+Q36JyQ4s11QEK9+oJ3QpAPYqfRjI6zJApHJO5?=
 =?us-ascii?Q?SHJ0sm9+t0FQ90jT6OKpgIshJBZV2zU+iGIIVVLUInPlNdsBdFIFbQueNoyk?=
 =?us-ascii?Q?sKNexwDIw2xAlKzLP6rYjgR0Wnhwbc7N+1IE2M6sFqns/z0qlGTmVOEYtOeP?=
 =?us-ascii?Q?Sd6bTyeTdC/33Xdw36gXQCc15Z26Dn3qMU/YjYMKqAslu/T2CwjsxEAtMJOU?=
 =?us-ascii?Q?ZpY2zgAVH97OkwlEVy4mDsbgiaTGgWbY3MZikDJa8HHCw9Jwex+Ewj6r2/Ln?=
 =?us-ascii?Q?euBxvHE7Sk7cGfcjaiWakWyCghLLiFGrTtD6n1dxLAKulQ75wMObOf6PTadg?=
 =?us-ascii?Q?P+Y8mIvXUMXsSgnAfNVZgeOKXSrEaPU0OUhZQjECMEliL3gNVQGNKBi5dS98?=
 =?us-ascii?Q?FLnpESp7hOmGCWZZkHviSOgq8y6UASymhfWeju6Z2j9BOUFSGwQeURWBMXnv?=
 =?us-ascii?Q?qSAJGqNex0wAIY7VEqzwJDz2mh7v3d093g/Pi2QehGq3sJeXg5U64AnRFqeF?=
 =?us-ascii?Q?nJlRMHXGL6YLaycXmDMMLaAx3b/e56Ge7TSEBplmIN3ETGl2OlpFnH4KnCLI?=
 =?us-ascii?Q?BtIhc7z+uYaD7un1F/Um7WfTU6Im3PTZMh0mVaYcqcAB0X4hsLyCvx1cN0VC?=
 =?us-ascii?Q?/RROmMyQCmzWrmfI/2JSAFoa2SE5/AwJ25Pa14oG0qe0H2ZUBsUAAkSSKCfy?=
 =?us-ascii?Q?VyaN0nhKRDFO7m15L9TVlGT7N2O9M2oV16JAxGRCLQMjSsnOJYO5qgI2k5aK?=
 =?us-ascii?Q?eGybS+/mXvjG/5/Qp+xDNbUofE51o6+YBHxe0pT7fpqVHRQMQaEoIN/zUVpN?=
 =?us-ascii?Q?Y1Np7L/TRPvVM6h01NWjpI+lChaSUG6qZOlWghi/DA34LtGOlt63UnCbuvOj?=
 =?us-ascii?Q?W62QQ/a186IPxIZabSF3Yp2KL/cQiBpEV3Xus5rPohm83HtC0+z+YaBvOidj?=
 =?us-ascii?Q?0cGNM91bzqgYQFP2xgXkXHqLFb1+0MoRM90/brhAn6AAK/vxJwBB0DDsnldU?=
 =?us-ascii?Q?CuF4Rc1ex6iIBsoyQ0NV4hgzezebU8PlsrgCx/acYfN2NWimXgzO84dOsylQ?=
 =?us-ascii?Q?mZklnvUK7vZwX9XL2a58YNn/SLh2451YjzS+gn+B4sxb7/b1fLbnvO9Kw5Kv?=
 =?us-ascii?Q?sjwobr769IXFFWdDYZVaHUjCpXVUibRLF/fbpMg9JKr3BENZBW8tgkzaIBLY?=
 =?us-ascii?Q?I1h8+s8WOQmG9nw1TqrwcmgTY/ibf0b4B1RIGnkMnx3lAUvOBHlpaeQ50jgC?=
 =?us-ascii?Q?Cv/7qN0CAI7GTCz3FschKa7Cw9GZ/KcqwkYybzpX53hBf3xVh8UF5AfNXgsZ?=
 =?us-ascii?Q?0SF5LoDU9gDzoEKj4Lf9xHe06S7TAMeyeDRnAiPF2Giwi2199FFe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2184ea99-92ed-4fc3-7aaa-08df070f414e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:23:41.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7k2uKXpEv2nPDc+8ho3YG0D96j4/zkh5ljOnhEfzGVKFPtpk/P8Qm0E+CMRfFT5mFZ6L0WKEkVyGLN00MSWlK/1tNGGdjAHzQjPENAeJjRPa6sHmZ8jqYD7AAY2UrZmO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8474

From: Wei Fang <wei.fang@nxp.com>

Add infrastructure for ENETC v4 VFs to track PF link status changes via
the PSI-to-VSI messaging channel. Two new ops,
vf_reg_link_status_notifier and vf_unreg_link_status_notifier, are added
to enetc_si_ops and wired into enetc_phylink_connect() and enetc_close()
for the phy-less path. The feature is populated only in enetc4_vsi_ops;
rev1 hardware is not affected.

On enetc_open(), the VF sends a REGISTER_LINK_CHANGE_NOTIFIER message to
the PF through the VSI-to-PSI messaging channel. The PF records the VF
in link_status_ms_mask, and immediately sends the current link status so
that the VF carrier quickly reflects the link status as soon as the
interface comes up. On every subsequent PF link transition the PF
broadcasts a 16-bit notification to all registered VFs.

On the VF side, a dedicated MSI-X vector handles incoming PSI-to-VSI
messages. The interrupt handler schedules a work item which parses the
notification and updates the carrier state via netif_carrier_on() or
netif_carrier_off() accordingly.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  |  42 +++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |   6 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   9 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 219 ++++++++++++++++++
 4 files changed, 275 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 803c5c541a5c..fb5df740650e 100644
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
@@ -3011,6 +3031,7 @@ int enetc_open(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr_resource *tx_res, *rx_res;
+	struct enetc_si *si = priv->si;
 	bool extended;
 	int err;
 
@@ -3051,8 +3072,15 @@ int enetc_open(struct net_device *ndev)
 err_alloc_rx:
 	enetc_free_tx_resources(tx_res, priv->num_tx_rings);
 err_alloc_tx:
-	if (priv->phylink)
+	if (priv->phylink) {
 		phylink_disconnect_phy(priv->phylink);
+	} else if (si->ops->vf_unreg_link_status_notifier &&
+		   test_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED,
+			    &priv->flags)) {
+		if (si->ops->vf_unreg_link_status_notifier(si))
+			dev_warn(&ndev->dev,
+				 "Link status notifier unregistration failed\n");
+	}
 err_phy_connect:
 	enetc_free_irqs(priv);
 err_setup_irqs:
@@ -3093,6 +3121,7 @@ EXPORT_SYMBOL_GPL(enetc_stop);
 int enetc_close(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
 
 	enetc_stop(ndev);
 
@@ -3100,6 +3129,17 @@ int enetc_close(struct net_device *ndev)
 		phylink_stop(priv->phylink);
 		phylink_disconnect_phy(priv->phylink);
 	} else {
+		if (!si->ops->vf_unreg_link_status_notifier ||
+		    !test_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED,
+			      &priv->flags))
+			goto carrier_off;
+
+		if (!si->ops->vf_unreg_link_status_notifier(si))
+			goto carrier_off;
+
+		dev_warn(&ndev->dev,
+			 "Link status notifier unregistration failed\n");
+carrier_off:
 		netif_carrier_off(ndev);
 	}
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 8d7c1790b672..52bd502976ee 100644
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
@@ -334,6 +338,7 @@ struct enetc_si {
 
 	struct dentry *debugfs_root;
 	struct enetc_msg_swbd msg; /* Only valid for VSI */
+	struct workqueue_struct *workqueue;
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
 
@@ -429,6 +434,7 @@ enum enetc_flags_bit {
 	ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS = 0,
 	ENETC_TX_DOWN,
 	ENETC_RXBDR_CM,
+	ENETC_LINK_STATUS_NOTIFIER_REGISTERED,
 };
 
 /* interrupt coalescing modes */
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
index 4e717afba7f7..a4d0089ef1a9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -135,6 +135,52 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
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
+	struct enetc_ndev_priv *priv = netdev_priv(si->ndev);
+	int err;
+
+	err = enetc_msg_link_status_notifier(si, true);
+	if (!err)
+		set_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED, &priv->flags);
+
+	return err;
+}
+
+static int enetc_vf_unreg_link_status_notifier(struct enetc_si *si)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(si->ndev);
+	int err;
+
+	err = enetc_msg_link_status_notifier(si, false);
+	if (!err)
+		clear_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED,
+			  &priv->flags);
+
+	return err;
+}
+
 static int enetc_msg_vsi_set_primary_mac_addr(struct enetc_ndev_priv *priv,
 					      struct sockaddr *saddr)
 {
@@ -435,6 +481,128 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
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
@@ -447,8 +615,38 @@ static const struct enetc_si_ops enetc4_vsi_ops = {
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
+	/* The MR interrupt may be re-enabled by si->msg_task */
+	enetc_vf_disable_mr_int(si);
+
+	destroy_workqueue(si->workqueue);
+}
+
 static int enetc_vf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -520,15 +718,33 @@ static int enetc_vf_probe(struct pci_dev *pdev,
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
 	err = register_netdev(ndev);
 	if (err)
 		goto err_reg_netdev;
 
+	/* Enable message received interrupt */
+	enetc_vf_enable_mr_int(si);
 	netif_carrier_off(ndev);
 
 	return 0;
 
 err_reg_netdev:
+	enetc_vf_free_msg_msix(si);
+err_register_msg_msix:
+	enetc_vf_wq_task_destroy(si);
+err_wq_init:
 	enetc_free_msix(priv);
 err_config_si:
 err_alloc_msix:
@@ -554,8 +770,11 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 	struct enetc_msg_swbd msg;
 
 	priv = netdev_priv(si->ndev);
+	enetc_vf_disable_mr_int(si);
 	unregister_netdev(si->ndev);
 
+	enetc_vf_free_msg_msix(si);
+	enetc_vf_wq_task_destroy(si);
 	enetc_free_msix(priv);
 
 	enetc_free_si_resources(priv);
-- 
2.34.1

