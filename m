Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B68525A62;
	Wed,  9 Sep 2026 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950166; cv=fail; b=MaUC3gB0VhabjaoT4D4fVSCbGAgRv0e5RJbm/DjlOuPI68P/ZmQSUFvAQOGNS3iDUs0pcbFF93K7/WHbYsPgirMUXVLprgfbqoHWOX14ZHUuI2aNIlQMW6PI99j/fsbHIJsjeRJMHfpFMFY69x/fssmWeYlhivoQhH8E4Q1jC70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950166; c=relaxed/simple;
	bh=v/DZdvrQjwppZrE+dfxbe9RxBjQltuUWnbbE2qWsBP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=blNuAD/Jd7OX7EHoAPTm3ey0cx1bm1u80iZpr/wPTyWVIIgbDanEi9J75odeH8Hjb90JG0kcCb5R4P3fxT8BBWPcBVblmNYV4jRgEQ1uLoAXKd4HZBBEFecKoRQNEkzkkM4GMZ+XfXblhYMGNT2eIXB9JCWYYTGIJ7hi0/419Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=q08cOl5Y; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q08cOl5Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osNlMtWlquVBjctphfk/gzpZeoGhNb7yljoTixgfBCyo5++HUho+Kp9bUYtqA4A/zrKWnji6RbemgmXm7+2NVxjdGnfgHNY+94f2v/M5kkTMImYFGF7MnvWRXUJ+H2+dvG9qcLo+TD3K2FLKmpqkL7J7sP71JP109kxI36/wet6Is5Kthkee71crmOWFUk5cY/LTcG3x0KSeflo4yJugLDgZSoCIvDceu37XtRs1WPbcCOeOuknFWzZifFPZACgFj1kJxxkMH1d1kzLax3w6t8+NaNPp2kb3Gpuun0gtgBiH23lrXEWa9sasHR25loWeMNgaibqPvFCAHkK7RM46eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdjuMILEfV4fU1X8z5XqdT+77S0taxC6Wssrr4zj01U=;
 b=h7zmX5+d9kJiWLR9tM4WZDJT/SSmnByFY3OwvXPUjb9aS5ipad62xm6I4ZcQyeWFqj/IkD83Trh67PotTrYDyDe9BiuPgnviBeooSsNR47t4dRL78QX4GGz77vuAaT2IYCsEIynGSeePNI9EvA5dHB/jy8XdC9fgUEjV8TGM8UpL2jYPkhgc3CdB4nFUiHm/2EauWYYjCM5uMpriSIbS0EDiYXSVbU1kTL3r8xAccI7noHWItPO2ymksuc4h4UBZnyUe6W8XTJZBWO+8NPpgyrI+/Wd2wiKmpkRaHVsdyttMVBLbHlrDAqPrUPH6801sl6G66kasvEIf9CZaGJxCFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdjuMILEfV4fU1X8z5XqdT+77S0taxC6Wssrr4zj01U=;
 b=q08cOl5Ycp6Rl527zugclwAX3k9nZWppGRV6UTbOpi8cChmFqTPnWeJry+Y123ThZzyNFooTvoLUH2uP3lsQEyvaEPY0W6ZKtm13vSDE4WHD1LW2fT7bUDQzt2sORL38q2bZCcKTfRPgTrsUz9hANT19IJKW9XZWBWnUBBCmRA+BQIStVqUWypc48nQLVq5SKzY4eeP6B3fsHbEmm0FoCkcEChGz92MjDzEiN6RA2uJ7o31/8EBtDg0Y4j9UaXMSj+JZeSHwElSCZC8OPwME/Nptk+imKtPmtJgxM1glrAFIrBT4AkNGkFKbeDw70E/G5tbGwUPRWcnN0XlPSIpYzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB8PR04MB7066.eurprd04.prod.outlook.com (2603:10a6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:36:00 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:35:59 +0000
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
Subject: [PATCH v4 net-next 05/15] net: enetc: use enetc_set_si_hw_addr() to set VF MAC address
Date: Wed,  9 Sep 2026 18:07:23 +0800
Message-Id: <20260909100733.1139689-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0066.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::7) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB8PR04MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8aeaa1-9417-446b-0198-08df0e5e23a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Ew7a2pT06ky419bIRlZnDCaDkTGIZBZ3LBjmkyV9c0lXS3tAjkYvlkJSW3Oqt4cecrTfduqLZqCvDh9FF1RxBkMqpZ9nspzGgcdB/qr7+9lLCAJMw/mij7I+FVF4W2wqQoYbj2XSECBEZfaYU9+ryEmpoSHnrudW2ZCz/D3RKJCQjjHYxuxiZsqN85aRMDxyzSixfEn68A98gPTwWARS/yCx3caJMJF6C3G/jdzLC0pQESA4kihtnUKkfZ0YD5Qe5YVDLW+EkJV8TELwE8RYxNWlI/ZCDE2kAe9X6UZG/UzO7sF8N16K0l4bKm4cTKHtAV4wkq8hsVpGLTup5pNcnTSCsX6fgHwfOGFr9I8EVFYXmb5E9SD/rULEru/Ng+Xm7L78cWzAsrxS4kdNdTyqr+KykfFzn5Xf9GLJQ++G3rdbByvflgtkamOEOBRmn9cwmlS8ITd9eaR46VyPqUeRwrwjNfu5RT/JAhgNI/XIeXtBKRnO4QaM6DkfqB5JPxhe7MvQ2NoMPtA1NmQRbUFotMZ6cz0F8Og246hKGNjMKm66prg8hiUa6GHpMZWA5+Hh/vosHNLsLhuNjgnUtQOmnVNGaRbSz6VVGFgBZpRp+9zyUMS31i7/EQXMWDybwvK/yahJhpk+AnecIGSQBI1L2wlsztAmRrNG7cE1GoK7gzh9Q4/+bIpFti4WglChlvz7brBck7z/pm4KLembA0+0ng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?229iYEByOzBaUjXUaq7uWnHdJJI9I01/yCoCfBjChDQiDFwch8BiabQLTUDB?=
 =?us-ascii?Q?hyvGUoSuzMD0e2qhlL7SVeHPT8ggxh9V7L470cnBWC8h8ONDJX9SsYf4j9Vb?=
 =?us-ascii?Q?uWEy8vNocMjPj+RNcVVqRiPLasjZkssfHpPVNcVD+hbIYLChlyGKBd3j3CbM?=
 =?us-ascii?Q?ldb+L8CeDqkOx7cdNfkmrG+U6swKpn5P63ecRVeNppY6hZ4xuuF153FQG89I?=
 =?us-ascii?Q?N37hVCXeqWnotTL/c0izpGe6NbtNgTIqpqVXKsta89D8wIHHwLLYYYrXkYQH?=
 =?us-ascii?Q?9DsiAWr17wiiQ2nX0Iqe2Ltr1R91VjAeC0J92UvqYV78vgiGAl1dM9ID4+06?=
 =?us-ascii?Q?YBlwf9DNbC6nHVEk21tewu7pIik+OB9OhfPHiO3CB/YykktXUdTRSS2r22yD?=
 =?us-ascii?Q?Wivh002shWfOqBMsABOZVZMUN8GxoUIL/Iu5/wUb2rf9UjEZOJ7NtHwE3crj?=
 =?us-ascii?Q?y4XGTP2I2gCZQprH3FAcsGuxJCWBCaELSmRzp6l8i5KeeENFqkKktt8fsESX?=
 =?us-ascii?Q?4jwid2ZjQe0rIWOY3KQ7Hrn5HKAFJ7gZgo+FACixzNL6/VjqlhNiDqPOQYu6?=
 =?us-ascii?Q?jqvmP7NKKhGcoGs2zxZ5pkQuLgzj2+J5Di1SiTKEeTxAxgGE/RR7+Wxb6aTc?=
 =?us-ascii?Q?6CipkgZKx+IQgpfab9DUZJ/upMF5WGS/3yioL/dxefsR0HVgRnucMiuX0Dd9?=
 =?us-ascii?Q?xE1mcwhjQc3yyRaxrCV8dCvBqs3i9FpR3RB/aT2NxTsFAmL7pmubBejrZBg6?=
 =?us-ascii?Q?pdAy3PDJsDFFl065AMUUWOmkTOQKJpgjYNpWpazZUIFQqvTW0TfJt3ysnz5U?=
 =?us-ascii?Q?im1B+3Lu4pE3aMZthN0q6AI99oPlYYXuGzyk4gdWmupAdu6CRoV4dVRU9vAD?=
 =?us-ascii?Q?XJ8emfdxQiBwEO8EP07Pt3kOwgY6IS43iuhCBnHXAikEzT5qThO32G3kgjPf?=
 =?us-ascii?Q?D+cwN2q4y7DAEEzH+aCxY0Zq5fn+YA8yU4VGZy2Wi3SPb449beRdaUybodu8?=
 =?us-ascii?Q?qpBp4G8EuZHj1NXI0SQBntnRRL8RlVJhdfRCLIvfg8kQgRxA3zZC3IYiUmyW?=
 =?us-ascii?Q?+2wB6Q8o0YitgDv1uZtyn6p5XDnE/Mdyjm9udBWuSUAtMCuaSkuf0spvmPwJ?=
 =?us-ascii?Q?zD/kwi7Wg88qNbDhn5rXIwkOvNaKgInmIpr6izUwS0rUb7kzCHE+DDLzGrWH?=
 =?us-ascii?Q?sfVgwIvS5e87m9GBvSajxh2uyoe7aYwvd6j1EfCGJpZSHldePEzHsGiKksjN?=
 =?us-ascii?Q?MbaK3Ao2uZvzBxQ4xbUbCRQfeJSIYWcSSLQLfiEaleO/Hr5FMxaXHZ91kkAr?=
 =?us-ascii?Q?HqL+/0PgcqHVdH2BH5w6/a494OexrnK0NIwYeVqRvsp0bWARq2MgKkY4caSh?=
 =?us-ascii?Q?PO83OZk0SE1s1z0kPW2MQ6ZxMzPwR2xk8e8YyxkUsF5r1ejnPZdaRSaKp3R6?=
 =?us-ascii?Q?lm5H1yZxkcHhhxACX6wsFDe9Clmq8mMcAjvneFdkXHJPHxCuELYYh38YG9fE?=
 =?us-ascii?Q?hmDPYYUL/pSQ/eGnNBnlMORkI0cf48kTYJXBME1FSoKBWHxlVW9AMeZDUygM?=
 =?us-ascii?Q?yR/kPPXUt9L3GzNF+nflpBZUpND6PwMxpwH6iBmY5aBYeYD8DIuj4wogDBrq?=
 =?us-ascii?Q?y3tQLIuaMFBmLzkSh6WlS1ZKQuLRJfedgrEt4E8K8DGktygnagHBjLbNQhsG?=
 =?us-ascii?Q?6gmJOS0xXFAn92IvU2aQUlWJnR6ObkFhBtTObnidJ7OKTYxO/qaTyXGb5+Ap?=
 =?us-ascii?Q?uL1Z+6EDamJSfZmUqfAahloZosUaKTnsSnQEGp8zJdXcLu7hRn2O?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8aeaa1-9417-446b-0198-08df0e5e23a2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:35:59.8604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMivceoFqxDaBhCAPWNJDqF+n7Y83H4TuluMq4TwOFGnF6esSZ+LXUL66y9eLvLrUpikkn4i5EqIboKJ9NJsABa1m0JbX+6vPd/kQMtlL9AkbwgXq6BfFsV4FwpOz1Ks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7066

From: Wei Fang <wei.fang@nxp.com>

Prepare for moving enetc_pf_set_vf_mac() into the enetc-pf-common driver
by replacing enetc_pf_set_primary_mac_addr() with enetc_set_si_hw_addr().

This makes the VF primary MAC configuration path generic and allows
future enetc v4 PF driver to reuse the same interface.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a7bf4bfc25b7..b74d965e403e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -207,7 +207,7 @@ static int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
 
 	mutex_lock(&vf_state->lock);
 	vf_state->flags |= ENETC_VF_FLAG_PF_SET_MAC;
-	enetc_pf_set_primary_mac_addr(&priv->si->hw, vf + 1, mac);
+	enetc_set_si_hw_addr(pf, vf + 1, mac);
 	mutex_unlock(&vf_state->lock);
 
 	return 0;
-- 
2.34.1

