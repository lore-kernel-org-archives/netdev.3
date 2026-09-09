Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67C852940A;
	Wed,  9 Sep 2026 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950178; cv=fail; b=sYqK+ktoGlClU80XToIpRJ6CDBxrVG38sc6ko5MYh/KtkLdt6qMM8V0sGrCJAa1QGyJq6QBd4y41JDEeRvWFR20phlb+7pCDZJ0gCE1Yu2vyc9YYn3lE18BR3AHdx1lehkEKmraQWFn4Knk5Ny+k6RXS3rk5F3ttM8Q/nkTXihA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950178; c=relaxed/simple;
	bh=Za7SMqOVkW9ROk1fPourKrPBXJDfEVpFkeC6rdSZ2Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GAT48/jBx94RgcEbxcUMTICS43+My/8jS/SCLrq+FaSbHCRMoXJSBRmotwp43j8rC2e1PVWlUJvknbFQrVKyBqvbK+Jwlubv9HOyhsYQ8s7ZRoZ9kiOC1EJEm1IeNP+GEarRrVFmM/4TnshTHbV64qJIV0LkiWyM7owo72dPLI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kY3QZ5gI; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kY3QZ5gI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBjICfSxaclauKd3eMQF1DfRYLh0BBz+TB6QSSp82ZB3pqjgRjkh/XwSpbKanr4K+wlzERru7RAbWZ3dlMJvVr32FMtt52eh/Z3vP1ZXEm+SRJUGlb/66ePSFQYBHqf0BnZiGHhQPYuFPkwteByiJ136jxqFliMUwoFy8RPQq4zx/tC7tVNX/o3+KuQEyJzNKcYA7A0Yng3hKZ2CTBYPmdQFzj4R8Tmln8oJE4x+KllH9SMx4u7xQ6K/kIU4dFaeP3RIuDLKF4ycE9wxrodtcB/gijWM03iQjah6zwrz5VwKJHD0W/dnHxQn7RGRYdNg/cTvgdZnpeoFJyxE6jp95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+g4u22iR/ROj4smlyHwiq0AsxgvM1x+IAErPDXluIY=;
 b=bH+sGV1QdajKexHg5zZHGaV0nCxn92dVYiVDA1Hr+Gfw7NejvjQSb38OvR5E20VQEhTxHexI8aKguWNd0tznqIYG36hN7+GStJdGCj7drjvYcCevDJ4F+tE+07eLPCSM9mUxiSdZY8km4jFT8DUGepUY/PEIGmmHMc88YcP811DpjuOoc/PupIYRPPL3YQDH8zF/knTSjABkhBrhlbgEiPVFUUhO77KjFbrVhLvEMkSfBc+vGxu02CAFHNA37fZd6tEy4WQHtnKSaNw5rq/YtfFI5t5coSRwaL2eTUCwEUaW6psUVhfbFeQaHQW4v7GWAbBaZu6b8gaUK6mmYG/jyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+g4u22iR/ROj4smlyHwiq0AsxgvM1x+IAErPDXluIY=;
 b=kY3QZ5gIFsCy2jovHPg3bqrladxCNoItFK2Vt35ftYZ49iiVoT9S8DUSRTEDgqZlJXB6FDlK1ZYLRBeWAAXWO4vtztjZfcJNI7IczWwx00RmIeUrmr1C5+TrxisAd43CRSdaoNZiTRnjI82lUXCj5GA3AWxIH55cD1V+5vuR4k+fZB4fBwmDbBXm6UVPfhKLegFtAijW6Jh1uXcFUuQ0QrMtclcAh8qjmlulrtEeh9FWyVEHA6gOzFWN6SUmPOKYTk2E9EtZe8zLe6sWtFU4U6WM9lJk6sNEQrJlXJP1lsc+hx119EjPrrtM7K3kxB8Qbi7SmsWVZ/EsTfe/eDaiMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB8PR04MB7066.eurprd04.prod.outlook.com (2603:10a6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:36:14 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:36:14 +0000
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
Subject: [PATCH v4 net-next 07/15] net: enetc: add .ndo_set_vf_mac() to the enetc v4 driver
Date: Wed,  9 Sep 2026 18:07:25 +0800
Message-Id: <20260909100733.1139689-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB8PR04MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 058973d3-f2d0-43c6-f94b-08df0e5e2c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	PvKAumbUd9/i519wMIcrn1BzKysy0/5O1Lg7BuiusmJv00exXGCLn+2kBl7vuoCtA7kw7QyXbf2+19b8Ub9VaspiRcI03+qCVsfmCT7y5g4lNSplncfm9IVajwO/Wq1uLIaEwATAcFFXQ8fOztK/EVHI5huKMjB/4lQTCOHUI3Z5PwUq1jNi5WxJvh2A5ub7+ryEDc3d1jmpsh/eIAeiYcMJB4DMTdMbda4g3AVeIAPOokaDKUBgV2vj+PQxhnCCa48hekjv4KBWkztuor501CiJzD/36tqTVn4K2PG9Ctb8iFLMA98pXpDcbidXrQ7kzluaoVqJIeq3kMdDHrUfreEOll3DCJ3KIIL8O0gZghvGkIT+TbYyiR/8fiEIboowry/sgN0/gnxIDp07qVzCIfcwUqh5lu7FPV5rTIpddiLxhKKjhJn4Kmb1j6E2p1bfXCTSN8qBBvtFP1kQ6LhKbexMNuT1sMXp9jnE/zNPjKfjXlIT8fQIH1TDz0py4M/Si9j4y85g/hYHf0uNky1+JpIXSRS5opWu+Ck/LyByMetWFsJdWtrR6cSeDEoRqnr6zWZABYunblfRjZeMv1ELEQ5ZLZdgSL1ASnweea+BGnq4f3Tfw+T6x0hzcjq3b+tnfHZeJNoDfA7CO89+5S5hAvXjALTLkKYLXorsB2xeSUxczqZaDEc6Dw4uwx14mBeSz9stqnBGduj/s9rFD+ckqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NjJT1+plHmeFHghJ5Nd1ux6uamOuupKBYIinj9DDk3ZSf2pEmbr38HRfhhWZ?=
 =?us-ascii?Q?UXFDEoj0V6yEbuEtCJsBxlBZqxEFOJBPIoaw2QMAEpPAc9Nq7CmK4XqTGvex?=
 =?us-ascii?Q?RqQNDb8g5UzE5RKzSTS7vb93r3jDCBRCHYt7PW/UV7tITui9L/cZXvcPmLHF?=
 =?us-ascii?Q?GjePkehXzNuz9fIfR9r44zy1QjlvAvmNktna7lLn0AK/w6juN5XuJIsmYpgi?=
 =?us-ascii?Q?27AK8idfAW3fyfs0T27UUm10Itqb/jgJuVLOTxLMu14IPn8lmm9K1FxxwQV2?=
 =?us-ascii?Q?WXEPLdvBM5V9ZicnhMv0gELaPliC+0oFo2eTaDZnh5p385+d0SMBXjVhsDDX?=
 =?us-ascii?Q?M212Ap7MLrU1seIte46DNrqDGN9sU0Qxge4vcJDI7l6WMUFq7t0+jJkdiuds?=
 =?us-ascii?Q?62MqfCvcvV0cNz6tPO+Qm3p2G7AQa4F3F8p0BFFIJsj/YILHyf3QLM/vIGtL?=
 =?us-ascii?Q?KFCC0km7zHA4P+z7y1HC0ID3pzvRzLHaswoscPZL9SexjXsajZpGWVxVtqJL?=
 =?us-ascii?Q?DnjZvknxt/Fg3jVR7apsG/1jQq0uVsA2UbmLLzfXYGgGXefO8crdsUAHcIfr?=
 =?us-ascii?Q?VWVnGBTPIzbgm8H9EsHO4CfvgwGFXebxX9ds8boUUjuh2W/ZCC2D6o5IDO2p?=
 =?us-ascii?Q?QyqYeieHKRMFIKsMUS4L0m812yFMJk+F5g/03B/KnBg4ZGM9TckAAF3Rhui+?=
 =?us-ascii?Q?c+aE/1Ltn3aRbeIAa26zQTHhd4uyWSyQjPAsmcfxvDqBQCXOhgMgz6cU6xcj?=
 =?us-ascii?Q?7pa/GGZ8uZRkhbmxUZ6fGOMgJJ5UdOVrE/X/qvUcQnVYljSevq9PeKjKzbtg?=
 =?us-ascii?Q?UYzT6q+5d8edBvvyyeZaMvP0U+4kqomtzUln4XaybQM70t7XpMtDXJpgQ51m?=
 =?us-ascii?Q?EzrOZ4hXVyQlh2KuyHf0da2Ra5xUg/Pfc88pXplxCBxV4WyH4rn/d2sQt1eT?=
 =?us-ascii?Q?3G/zETlwHLijLGOGbylPwrNLrCeYPW8Amfsn8w/AAJ31Zjbb6+DHqhi5VQc8?=
 =?us-ascii?Q?MIr5y9BI4caT3yAfh7SmpzRbhmp2SIytAh/PCEJXlqjyUga28R/JGy+phG7Z?=
 =?us-ascii?Q?dA7ulfCncIBDakPmb3hnl3MiyhELj/HcvMf3V5nxbYs+7560I0fJuv4Yq3NX?=
 =?us-ascii?Q?vFXcS/1Liya4DaKoVjkajY2JG4TIhgB9ERjTlNNX37PTZj4yOgBBUUZ8o0KK?=
 =?us-ascii?Q?frekDkJNO752oPDP7oKDi3aehnPV4kKd9yR0595rwYEIJsmKU7A/gkAMHaQg?=
 =?us-ascii?Q?q5DZI0Qjni44gqriD/rywfLfq+G51tSQAFcG988mHxFXzH3MesALPYoqg2mB?=
 =?us-ascii?Q?LtZtBmA1dcK4vq+IarYMUAM9rRQNkW1CNBPBwy03x9MYD+Zu6qSkuwUNNkMp?=
 =?us-ascii?Q?S9ZzjnqjeyTrQlCzBO36WrM/jt9jBAL4MbLxv9EEH6GfTSbj6jTMlZ9ZGuOg?=
 =?us-ascii?Q?WcTshLMvjUpmBjTsAkgXUTlasQpH/IjNJ2MQO/DbFfus+KLynykLETIDzEEc?=
 =?us-ascii?Q?LDHLOGD6iGiGUf1o5ZhalneRNWo01bSLknF5wNCteGoowHd2wXIPYxKf2VS0?=
 =?us-ascii?Q?uswnA2H3r39I4gfM4RnqMBe/2k3RbnMz31jMQJJ5ZUbO+F0zJY1B9zfpk0lh?=
 =?us-ascii?Q?RpMpz2SYFwvxqgJT7Vapnd1EDtwrJPgSwPkYG2r/ZUNRpXjCeICb1tuRIpML?=
 =?us-ascii?Q?/LMfI55TmJhlrLuJpJcNNrGnFAm3KCr64hHqJ/pY2DBQXW30p6H+qGWEYqwR?=
 =?us-ascii?Q?wHU5jqeVdEN0lZFxzCIHhH6FORgZw7C5JxauX+tIPYOYT/46ABsQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058973d3-f2d0-43c6-f94b-08df0e5e2c16
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:36:14.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuSr6iqSct8kuQgYAWDRzzeVLSonP8/wNTL5DZmIA2hvDJ6dM3WJ3QqacoGlm3MRBiOAA6op9vu+7Cd8AzJ1Ot1zlALtO/FEbdxMa2RrjON5jaJbAlMOnL1pE3AlVnjs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7066

From: Wei Fang <wei.fang@nxp.com>

Add .ndo_set_vf_mac() to the enetc v4 driver to configure the MAC
addresses of VFs.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index e20989b6f8b4..a44d50b7fd2a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -579,6 +579,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
+	.ndo_set_vf_mac		= enetc_pf_set_vf_mac,
 };
 
 static struct phylink_pcs *
-- 
2.34.1

