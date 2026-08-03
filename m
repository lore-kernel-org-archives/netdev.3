Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E29A35AC09;
	Mon,  3 Aug 2026 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727464; cv=fail; b=MeKz0A+aeDaEak0noAZVf6UdpKu2qqQyVaD6klHe2ZAossr1w5WVWTiEE0mH6EwEjZGRVDwWu5sZTmIj+H6HjPUcbMCdn07g+wOjDXSI7CBu0lapRQi3B3xD9QaCmwjptaOjpANmSqfhs0eAALWWJ+06lp3mvEE2+miC2vMAYto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727464; c=relaxed/simple;
	bh=URRBNtFzTBAxjFHptIB66TViC9StMudPBlAQzjSKg+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YWHJbLbOc/GUctcN1NCHrPmXHgWPIBG6cfiyiOY2w7n/XHeDrc+2vfcRvsV4OPA8KTEq3fmp9WFE6KY0JsMAymFmAdRM0XyJdaMt+UVA3X+i0VAEH+AuZUzr+NIsKpJj3d+s51xYudHJvgEwMo0TpzZhPNxchZceaPeADHQ/oZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=JaboJjSA; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="JaboJjSA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArjT0fFT0t452IVWkyR4FKdxePWuQ/8XCOm5m0Zj0nix1gSG9i1ofs9onjzfK3/HGZaWQBu/8JBmWXQ3NcYyID42xD28QzZXM7xjDnkIBm9KnvbqQGrMyTT5y1XpeK6SBpaFyd5u2zoUoXg7nHNdL5egjaRvJoJ+hEs2MN7PINLQyz3EMPZxlILuI1nY0AkVZfFcLsYItHaBuCRa4B+qYb7qb94TQUuoVfmbpQFa7kT0mD/BI0vUPc2H/jugP/7KVim1k6E3Rt3rgiPGwVcbOQ0xo0g1xic/Hm7N6C7c6lCsaiGkh+GhnxWhyyTSPeL45eCS6l9IoM8tGq4a6BScTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP8JV9eHYwWWRZUopaC5eRaMMVrOz/akRyJcnvFgkbE=;
 b=Wb5w3/YcXfcCvFeYxxK9xcNRJQkdC9ESntohb9PVHJcHCP2jEN8VcXsmOsFYG96HE2YYXqCVLjWFsSiQG8yIzNIyWSSvbS9cm+KTiDZSIZm6b2dvO9hTlw/cRx5WF3rXvfh76/cvNfTCoOzVAdE0MnucUwc2+DkPfkb42hJzIMxEWrERq0meTjK+KAaX0opvUln2hnc+l7Q72SdX0uu84qTAduSho64URkotdOzH4GZFGwsANxqo5H0Kp1PcaEOSWESNbudJ57A5j5KzGDpHb8SrA9LGL3zxs1bMUKiWqI6xwcfwyNEnT+iQrGe+w0SymCtHez25ge/2/SwmsDXq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP8JV9eHYwWWRZUopaC5eRaMMVrOz/akRyJcnvFgkbE=;
 b=JaboJjSAiMFi2T9+rQ68bZeIw9o2la+aqgwA+Od8IqrZlo/tiQETl/Cv91Dya7TcpeHFg4byJD9sMOZkrUmyJx+VABbGwrVYSnqNeSrDv/tjGLxrSyFf5sFQg9kT/4WXJbxiYj9fmbF4cAqKFNSzIHijBJqB+eFZkX9VeEV9BKx/QHvgF97l3b3rPHF7kIgehzY1gICQgdxNgOxU+fouLnZ6l+x1RKf+VdPZ06BcYIiRyCPg+y4F6Ql1sh5adSSWWDnp7I+Z2WAqgblLGEPLaGLdpg+y39qcUZuMeHMuTDbwnU9bsKLbxpM7izPWspouL40cAfVakmc8ynXbDwpFeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CH2PR03MB5335.namprd03.prod.outlook.com (2603:10b6:610:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Mon, 3 Aug
 2026 03:24:01 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 03:24:01 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: stmmac: fpe: Enforce pmac_enabled in set_mm and keep it on at init
Date: Sun,  2 Aug 2026 20:23:56 -0700
Message-ID: <20260803032358.16282-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260803032358.16282-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260803032358.16282-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|CH2PR03MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c00d02-efc1-4f03-e0cb-08def10ea930
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|56012099006|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4ZLgwismA4KbkKf6jsQoI+BnRDFFKgVBfgxUqHXcvMXGtlBzQCmNhuHiJjSogK+qFDm7yBMlYG8J18OOAzSUmtk+b0RRk4eeUKX7cEQo+562UC/QgR3s63lx8oqSwfQEXrNj7Kisw6prshnehhppIdit65J3DzLfPHPSLQKNGl2gZQg4z/SvzC/UOqHxIedevIsnNA5OLSCO0yqmhi1u4lT59KJVXO5WdoZOJA7nok7RjtEM9VVus+VvYApLDkTHss8G6PrCYPoOLKHAo0demOqPJCJ+bIZkpNVNuOKwD2pBhbMQyjRUBvOISBlTjrcrIglKexEIhw0d+MWPP0km/RhfKLF8vRcITnqlru+oYQX0nmtkP2FeC4dhLLmOvdIh5qK0emGJQVE7AX/woSX1FH2EwmLQudb58UDPNbeEHMVJ6FDHb5D4IPef00FX1lt/CRLRKh9HXyFC1WPezf8eExTAJUBfzm3f0Bc+ppgcBb8illMFkZMpXwefyeMEQeeYWFKQNTVNEyVQUwWtmpdWKK3Wy2Jy6kLV7wk/fGwiFfNbkH+XAQDIkpjVKthBFwVvRyqiD+oOVPZ6QU5WkK1UzdKatxvjquEMGa9CMwszZdOOEJyHDr8+cPEziAW3754kA6jy0HXbH5zM0CJC15HBpV9vSToDU3mi1V4Y4w0xy6o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(56012099006)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vYoV736RG+JJZJZl9veT9SlDRKOKRuWIRgOzbu8KcgV51L7ODvoQ6+dN002y?=
 =?us-ascii?Q?jplek8GkTk01lmlUtzTG1W09yo1NTvFmY5sSpZ4mtuuBUyYPK5XT3niVCs+Z?=
 =?us-ascii?Q?ADfWRnQdp+JwzmQR4qoCoExyKSRBQ85K4jkAEoTdLr++mGgn4JY5ONLqiFVQ?=
 =?us-ascii?Q?EtsB7UfLKaITCdEv0QkOrYoC/Paw4MPlsRx/f+BnNKoyK+er5ZAsMymkddQs?=
 =?us-ascii?Q?xnhpVSMWPNe/JJoIsjchBzToTP90szvKhrcHwGkOgkj1ppAUf8SPjLYNrhWv?=
 =?us-ascii?Q?c+R6Vd/8fhQISMeyZQ6RyD8eKyMFO0SDhGJb2tOws38HtGgSE4wxpMnui4by?=
 =?us-ascii?Q?rWw+VbCPQv6T7beElpdt6e8kZaJHUL9e5flKWmP4bI/RBvMdI/ma8ZY+2xA9?=
 =?us-ascii?Q?jbo0iLrkK7qwLQhzVIEQgqfwEMFch1OBFQI3Uv0USYIg/LujcoM6piR9OaN7?=
 =?us-ascii?Q?PBa467Q6wWqZONhsvDy6NwEWGBsAwCvxWwcc2xnF+HbWwSj46fCg3ztba+kz?=
 =?us-ascii?Q?oZppbr8ao24W8+bLa0QbZ0xyY9aB/tlQzhFL9mllsbRJ8P6FG7blo+3v66Av?=
 =?us-ascii?Q?bJAZh5vqcOae0HqbgTFRrUGm4TnjGVUaUrGQ1KKfMDZT5uPHoOV2J2XainFD?=
 =?us-ascii?Q?X+VUAvbqtRigcJNNzELRJoAxo1sHpDn9zxrmanq5hBomNedWxHUhy/7zonJb?=
 =?us-ascii?Q?GpFboyVRmpYl0nzL+v/smUTJL86H68lHDTigQXZ3yekYl/W6CQsZSJ7Z6e/d?=
 =?us-ascii?Q?p7LRiqguU61Od9EaRJPHz10jybT/NrqParrjqsf7k77lscUZzQZ9+uscPIUj?=
 =?us-ascii?Q?29hYEs8SfEWsvDxlYCpDBhq66C8LClIW32CP8Lnsqr5j7cdleFCMg6BWiRaB?=
 =?us-ascii?Q?T7v209qnse0C3bUH19PtjpWfAh3a4WcHbbLJtVd3cr0L1Rzu7wvnrYx1tOw0?=
 =?us-ascii?Q?N9UbOPpg27g4mcpSAs36BizK9uqgkgZZ/pfzZZ3o0epqwLUoLqG0+oogKCPt?=
 =?us-ascii?Q?2DzQbdtRcqncIPWipyqAQP0WOG7jqTzehK8TKuz9O7WhuHyNGMFZIWQNtNL1?=
 =?us-ascii?Q?3XXzNf5lNt7eaQxFVqR+PWPFKZdkJpv91UquoMgE4iTu/6VrJDZ1M9sCMTv8?=
 =?us-ascii?Q?DO00qe+miYRARx6thiRAxr6Xh6+tlFz1STwDnGPkHBGDYsHApHww/37xVgjv?=
 =?us-ascii?Q?lG5DjOT9wVIzwDZs7EbFrWLI+l57oZ6wX5JeHBzHc/LXLQ9UHISYqvnpXsfz?=
 =?us-ascii?Q?5jIeEZvrqQ89bmSFF8PJKXuVlqJ4S3p0qh7Q0i91Go8bh3F1CpxpXhF90t/H?=
 =?us-ascii?Q?FIQ62YVgKNUIXWHoUi5P6vdLJEZKDcnpsnrRbKv62i0bxzjMCLmfIZUMco3I?=
 =?us-ascii?Q?AeTOvRMwc7J6NbtxHwsVaKk9fHyPW/xXqDPMMRnaRuToOUtW2whwyBG6xhGu?=
 =?us-ascii?Q?nGcPhGsDROYMgkQduAZx/w36B+lC1mITKUZqJBuqfhF+N9UArqc1j0VQ9noc?=
 =?us-ascii?Q?0wi89/+uKaj1Dna8ikSoJwN2WrY1fQ/nqFQ9O/trim6GQQon6IfsP5u44ks9?=
 =?us-ascii?Q?NdlawZDnrkpEu1q4kvK8e/8k2fLiXZ7QTcqXky3zjr5bAihBYfIuZshqxTYM?=
 =?us-ascii?Q?OBwkLxtcteq9K78GLIWKjcoOIghvO8qV5xxV+xpCl/9Q81HIosqTMZSBTTrE?=
 =?us-ascii?Q?pt/LsAkbstFuLie9NKIv59p/GhanT+QhMdF/S83VEZjCHUzOoij2brMghPd8?=
 =?us-ascii?Q?UcPHU+awGVwLoTx6tmSxVMmsQn5Fu+R2Gwe4yPsAeK8yubV3lAH7ALkaBBKx?=
X-MS-Exchange-AntiSpam-MessageData-1: F6MaFNZiWzWteg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c00d02-efc1-4f03-e0cb-08def10ea930
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 03:24:00.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TET0nX+buahhKQjiZDRVE8q8sD69AeVkcAh8sX6ZRvJmaA/qx3IX8p0pTC0EY2JsfrSpptEOQrTq/L34Pdw3lSQwpYmvlgYfG8esWEbwXNmcCnxx/GhnrGOByX17pztRjqrIht/G+hrbterDDmgBmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5335

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The preemptive MAC in DWMAC is always enabled, meaning DWMAC is always
ready to receive preemptive mPackets. Initialize pmac_enabled to true
at init time and reject attempts to disable it via ethtool set_mm.

Also add a missing fpesel capability check in stmmac_set_mm() to return
-EOPNOTSUPP early on hardware without FPE support.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v2: No changes. Collect Reviewed-by from Maxime Chevallier.

 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 7 +++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c     | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 92585d27ab88..8ebdd249e5c8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1064,6 +1064,13 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 	if (err)
 		return err;
 
+	if (!priv->dma_cap.fpesel)
+		return -EOPNOTSUPP;
+
+	/* DWMAC always have preemptible MAC enabled */
+	if (!cfg->pmac_enabled)
+		return -EINVAL;
+
 	stmmac_fpe_set_add_frag_size(priv, frag_size);
 	ethtool_mmsv_set_mm(&priv->fpe_cfg.mmsv, cfg);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index c54c70224351..2f880c5e35b0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -176,6 +176,11 @@ void stmmac_fpe_init(struct stmmac_priv *priv)
 	if ((!priv->fpe_cfg.reg || !priv->hw->mac->fpe_map_preemption_class) &&
 	    priv->dma_cap.fpesel)
 		dev_info(priv->device, "FPE is not supported by driver.\n");
+
+	/* The preemptive MAC in DWMAC is always enabled, so initialize
+	 * pmac_enabled to true to reflect the hardware state.
+	 */
+	priv->fpe_cfg.mmsv.pmac_enabled = true;
 }
 
 int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv)
-- 
2.43.7

