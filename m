Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B515131A7E2;
	Wed, 29 Jul 2026 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289978; cv=fail; b=JvZFiryjPWyAeci8e6w2zLg3qATJ093oC1JLavoe5bZKYAT043Z5ZSMi+hG0gm853eHIkzmrn61tLYrJYfeDhA6Y6Ze3dvG0fuOGY9HF0b0xHxJyoxHdQXHn5Y5kYzvxxO/pLcGgZD/4i/gKzWq5x67fCh/VwUIOSfHiZCmyHlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289978; c=relaxed/simple;
	bh=UR2lhzfMuQv6xDn0XSLOsWHb2LOmO1TK0ByRA+VLQ28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=quCHnGVQTg70XU6VQFCNtJf9XyrLQ6zVy6t7HqFEH4sevIPpxouqpG/w2eRhlemMbOwqqNWTK5fePT+d8FLGFolx/oQGBG6PYKYhm4DrhDMCVS3OMdkbJbpXiopUIYGU/ygW503qMA7hKRUyO03IzLtqT6gSctbTcDEhyK1qqPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=W5cmn2ym; arc=fail smtp.client-ip=40.107.200.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="W5cmn2ym"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U96mYbuosxWaaQLullFXOB+OeQw3dTrEVTiPq2dCkqTpXAOb+UYllmaBuTh0fTTVQ3KGo/6yY3YTNx4G2LCAuwy/2c8OaoFQUcBeTlxDiSyLTlIPCaU/rFkPwhD+Vya0cSk9HB8ndW7cGK9VafjRt8CA9wQ8MDDohqhLjd7xjZmXW3Z3FMn+GLNI2pneY2WUVibdOsTeDsBWGfYpim5ThlcivYGd63XQar/iGeNgUkbDAaAS0SvjvJO8viSXRLljxZHjuhUHu/hkf7636HXHWJfpbFfnvybhYz7dkKZL7oncJeD88yJmtmgRxdHqtjsI6dDNLaUsHVlRAq5UbPNNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9ePummqKP2g28m4WdrfWQf4wVyWYDYoB86igByoVPU=;
 b=VzAR8qzX3FizFg9HAixQJ40+vxoW1KMZQsxhJamdhsi5Qf6/vvTqlj/rq7pOWqO8pjfPKvv63nrNlxWXNTTNk8jxKurVl+6bzVLy1NeIGbgHACtBBVhbzlJiDA2r7gEr+tIYc2fc3PhBtZPuBV1GuGSndU5JPMkVWZPDe6ogbNq+ShyjZ67qSUg/kI/XYQy9d5j5OiXWnqaoOQLXxnYhVz0ZtYZ9h189r7+mP54zrcVoZJdEeyVBNkj/5DZYtK6yJ+X+bFEP2f2AhWQf98Pmfm+vkMn2bPILi50jpjNWO3354v27Pm2TMowo+IerzuH/+FIU8JEIs3hWmw3kdsPmfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9ePummqKP2g28m4WdrfWQf4wVyWYDYoB86igByoVPU=;
 b=W5cmn2ymbb5Ou1Ay9h3IhVlHGS0WUGU1P7LXB/MlVgj5L/q8Q1W4wtsIeWnIJWt8Jdythj+/LhE+L1VYT5lMngsMYC4iV9fHDsD5udC+jQalIexlvZ7sOQK0L8v8teJ1KJtd4jnrcFIVxgIOVyVQeZpeO+fsVhm3mh/yW1lyGrX55FEKtTrOJ+OJHn/wVGBUWNEaQuBCM4MSXTBKoEQFnLIoUlKz8DKXvNTF7xdZ7Bw/wgBnAwEP2J9AvS0T/4OWtBpS1bEh3dK2CDtVX5OHlLRZMrrjTnj7+k5CJO0m+5ygqpvb93aC6zJrIXaQCWCpj/Ey32ImSIsBH/uZpFD4pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MN6PR03MB7550.namprd03.prod.outlook.com (2603:10b6:208:4f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 01:52:51 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 01:52:51 +0000
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
Subject: [PATCH net-next 1/3] net: stmmac: fpe: Enforce pmac_enabled in set_mm and keep it on at init
Date: Tue, 28 Jul 2026 18:52:45 -0700
Message-ID: <20260729015247.25774-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260729015247.25774-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260729015247.25774-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::14) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|MN6PR03MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: b1539016-e992-4569-4b8f-08deed1418f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|56012099006|11063799006|55112099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	a6+b1ll1iY9vvzxec5U3W8bPEtqQ+I6zXpOObP+sy/aZINJvG7556Fi3qyAb997JPh6FjisqlqgDP88tBJ6CC1Ri4f1ek+ubhto4Ooh0SWIaeLeG9MPFc1x4NlTjmh9Nfz67Ll4fjocQ16ksa3KH+j4Gg3vSZ1Co/JjgvhANSKp7x0+VGwgN0yGh+dAP1XfNs7iao+wQ1AnFXH+1gFYDrjLMtmTJsM4FDpGAk0JPP+FkJb95N3mPO5ihjxl8saef/V+eR8rMsFmi1XQTkYN9HBkwi1VwRPu/v9KvX+AY70YDWe2Q8btcqu30cQSAayBc6HYVrYKdJaiVrv2AFY3vS6bM42cb6G60tyKvq2qeNjtzcoBBIQCig6r0LPZ7G2qsCDxsnGXq4jo6hU9Xr+5q6eXEEcd6kzdbAierPswM5YOnR1unpbyEqZripCtwgsD89t1EloZaOkPJH31B1KavVu3WFTiZdDxTMAf5cUIPryGgYssRQvyaqW7HTyjNYhBQLlqeE6uAruD20FjjT0cQyI2MHY0CmDse3YOM1JW7Zc+zvPjz1qOQyhnM/VqkD/xcm8pIyaH68XC54MucHvce5KoDtagUguu6yDEVb5uVK0XBorVEibdPZh3SD7Ti0eDBofiUdaPwS8F9SHND3FMEb/QUaoVgWW0jordEfUxxJlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W6vvtdiUwjwEThPgI01Yw3YF1SHJWWTM8GRL8oDIIkaUpbTsLVUesyt3cWlH?=
 =?us-ascii?Q?LdqOp3I6RWWtimYblQNu2eZZR7DYQCrS+TesymJLT5DJIr6mpqlNcRSFzJgA?=
 =?us-ascii?Q?x2WVkCmhxs1NMO1gRC0SvigNr/EBd5BhnbMiSKzMDAb2O+4brwlog0HSfUof?=
 =?us-ascii?Q?S/ETVkJsphafIXVvDORi/cfq6qLhFonEZMhw5zozxMjw6LwQ6uOrdv7RnpD7?=
 =?us-ascii?Q?sZl1cLWcCyMLTJJi0OkwUs3rLEo2Awzzo7RoikN10ZRuOIk5OeDBjdgkCUHq?=
 =?us-ascii?Q?pWpUFZeyqOHaCOGdlDjmG8ju8EW+lSq7Pf7Z6oAR/gXEhY/9yB7waii9PuCE?=
 =?us-ascii?Q?XGPYmk1f/Mf5FxprQC3eOqUafQ1smGyDJqmllf+K2yDqaDvfyv2UpxGT/r08?=
 =?us-ascii?Q?MlqffNZYBt3KsXqmc/wByEFVe8iZy6On2ovT3FlOtqBAkwvScQmjMc8OgRqz?=
 =?us-ascii?Q?HqFksnTsKknWVsr8AW8s+6MLWp1HCuiPPM60VdR0SE2p0aRhXBy7CseKmVWg?=
 =?us-ascii?Q?Ydh0XOFC2g15SBthPZQAHlmoURmxsOyihq14CAagzWADhRkAXMIiXT2l8A9Y?=
 =?us-ascii?Q?NHXrpD0iy77B8LVqPOfJYu50NtLJrBLl9Xfkw5wlYBUZ8c2UFkXOPjd8ZW7P?=
 =?us-ascii?Q?KcVyF9KjxngEeM258FL5t2+0UDwYiqCDyJ0DVbqFJo5YhfZiQnx4bxYbJl3I?=
 =?us-ascii?Q?P+nPLeJd74ADGSzZLn2EXxa31AFysnMXDb2Ug/Dc2AcL/DM/Yw/eHaJgXSMf?=
 =?us-ascii?Q?MiaNLI6f05Xvw+1GVBTFNgRHSoOv9YOInBDGGF6RC1H1wT8Te2h7cIMNQWPk?=
 =?us-ascii?Q?PjXicR0IFXsg+Rpvz+9MbXEALAGe2JSFbFee8W4Nh/Pq6cfzbpY3MdGDW9Ii?=
 =?us-ascii?Q?WgI7XcNPbePPa8bpaFCbmNgvM2EmeETkJf/GnQ9WHKNf7o5RAxjYLgT6Yo5+?=
 =?us-ascii?Q?J5cpLXpt4n2SLDWli2CXATEV9x/E91m6i9pwFBPJu49EHU2XVir0zBkTH8f6?=
 =?us-ascii?Q?YCYKFplHo61pJ0lPJS9+vzUmvpisyA8Dn1hvFtcla+C7fXtpcLhD8pRDdAQp?=
 =?us-ascii?Q?urSpknXknAre7Q9ptcjKvp/s7zcRT6wP7aDBznIHp/VQcM8UuyyzikKWWySF?=
 =?us-ascii?Q?+3mnDgL/cS/wNHuM1sVV2DL9DSN68WYjpQCMtwMD9CeI8McEAAoYMAQM9f3j?=
 =?us-ascii?Q?OrMPW7zi9tU2wvyW55wfVaLspVaaO59VAVVR+ovbaCT1J3JoDhWzwRu7nTL6?=
 =?us-ascii?Q?xJa+v0dCVr04xwhZmlScVaaAjut4kkmRxPHUzII9lEcE3E2xVMePMxbBqwzs?=
 =?us-ascii?Q?8ba06Q3wOf1YQrdJ0yfvK+7x4gg6stzsUNv4/6iK6pruOhkXDnDuaGSA2t/0?=
 =?us-ascii?Q?dt/12RPpWLJsqhsJkCjJ3CDaE6G5Qo6FzmimlIigek8sjHxlBw6YthKGBvuH?=
 =?us-ascii?Q?vf337wK4HXJwTSWeuR/nlVf2ewc2wbkI745XdQnkRx/mDy69moYqC8sMn80d?=
 =?us-ascii?Q?D2sDavDvisiYFrlwOkHHF7DsEXbWww+9lraVtd61kzhQ+3siW724b4jbZ6sM?=
 =?us-ascii?Q?AeY20BcKYO5qAhqPfR6knOh69Sln2A7N/koav5rK8+5XX0g9oClfMiGf0+TZ?=
 =?us-ascii?Q?/74UvUxfKyELz4sqwjW3dqk6Y013XLnYYfGxQSnsu6STmq5JNZQw+8ojw6ul?=
 =?us-ascii?Q?P/Jssaj2r2rjNYWa7swprFePjg6nu2JwIGF3qyK2tbnA2OMDOPpc2U9rJ8hc?=
 =?us-ascii?Q?LhwmEDt/VxXcUuArbyBmgeUbfAS7teQpJbTePLpTbqhjsNH3KkKeoB/8XJGT?=
X-MS-Exchange-AntiSpam-MessageData-1: VO/ZuH7wxw2afw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1539016-e992-4569-4b8f-08deed1418f0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 01:52:51.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSt1KpOXZPndjoUOfZ5rofXewZRQGBoFAZlga+aSkTEtYNfaBU8QDlxKq+2lqVTH16tIUyTFCuZ9Eeo9dhm8tL5DtRj+HkVYi421B2FETYttf4/Rjn0LOy/KXA6jOqDYe0Owk6Zn+Jud9Y9JqiCTVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7550

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The preemptive MAC in DWMAC is always enabled, meaning DWMAC is always
ready to receive preemptive mPackets. Initialize pmac_enabled to true
at init time and reject attempts to disable it via ethtool set_mm.

Also add a missing fpesel capability check in stmmac_set_mm() to return
-EOPNOTSUPP early on hardware without FPE support.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
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

