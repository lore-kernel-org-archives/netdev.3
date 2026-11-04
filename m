Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784437;
	b=OOWmB/VRCZ1r9SkC7Lvq2i5IMunpmL2gRnnr9tzn41GjaxW6maUXNDqgS2MxvRGLu56c
	 X5kYkt2XtBxi1sn2MoXSnOPI2QX2p3rHfTDXPO2XRVf/9YdGine6itOTkGBQUeu3RvBWQ
	 k4M4YMSD9f5SAI/0cXp0Xx8e9NH1hNCHzZpyyEPV6Vfpr4ayief5RRxLDR2vTut9pLLJS
	 d/KB8LCZNLQIv7g9aEHnv2mOjyvuqtxAjtvYOHbKgaq1ti/CyL8QmJ0/0RC8evWpH375s
	 LnB1sz5fWPZPHalbCIVyyMOMaW36NzTCJsgBXy7CUDD+apSyzxGqCYGR9GnMBmqdq4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784437;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+xcRtcDi1v5qZcrvAk6CV/CKDvUloupDmG4G+GxYwZg=;
	b=OEZl03bT/jCJ4r026twmNL0NKct56FXpVuOvexBIHKieJn+oQDX1R5Vm1Fc7kJTSYi6X
	 Eva1iNljkHCMmO0BmRRKiUjBwPzepx53MUW+VcGaho6Ga3Nr5KE5bjcicBbMfhT8l+fLn
	 ve/V34WR55Jiw2oJ5SrOgAvCufAQvuiLipUMf4Z1yaLUuxxoCVWU8YdFYR7Vx5JvdDiBM
	 LkvfqMqbNTcxbFKhgH4enEXzQuby1LwNE4VCx+t9CspRbjJi1IdK3+stcl9TwSIQbFn+K
	 Ti4Jh0+IkY/Rpit7eblgbOPFhd5w83wil6HSHGwzlMMfofBtcolPmXw5H4o8nAppCLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BQggmJ9s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.70
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4B606A33B;
	Wed,  4 Nov 2026 09:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A4B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BQggmJ9s
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip3APCIP4g4+qnGmDs8EP/blu73O9JLRwtkBA7DVLMQbR3kuXF5JDv8HLGTtl64M2ACMHK70kTt3GdOgZHKqZ5H3Mu6zjekKN22Ne0X7mmOg1kAogiU+tigdvrJv+frAZ4qKtVj8k1rrKNEtqHSr1F+RHyPK3d82NNJz+t7eHYbdMX7gOM1NT2pp8ONeYpPaFJRYaiRGI2Nv4uy9RjxepLoQXSmTDTTU99PyyesCH7gFi5URteho6XEZSXAT8vjSclUnjfO/2Tjn1qocBd8kgNptCgGB/ux3g1H13HMj7iXP7r4c8H9QAxXUbFaTnWtVaz8NvahHjP8UB7U2EDuQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xcRtcDi1v5qZcrvAk6CV/CKDvUloupDmG4G+GxYwZg=;
 b=vL+7coauKmRYDRu4QBRDyzWIcSOp6ivrhvKkGsoYLcEgfg5vFs79o7LCXyjh7769XpHUpvVD42yUU9CYdaFeqrVgO0zwVMwmh7xu1vRMOntVC89AQAwQE9AFkEz6XqNctswaCvEHG5w8aRMqyaeX4qqLAmNOtDLf6LOqvqvYsWey9+YRUd3cYFoLHxycWn7x67XyuuPF3fdhZFScc755Z/0nZgJiB4zTziMVNTq6XEX1Vus4xR9QJBS2CZ7UsUy6rsot1H7na/8iLy9giVtajCm7BxuRSHakQpX4Teybv8c722+YeWTSeCe5mXlxJjl3NTGm8o3WUuRB/pqZWA72nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xcRtcDi1v5qZcrvAk6CV/CKDvUloupDmG4G+GxYwZg=;
 b=BQggmJ9sTeAlIfHLEo47FMeGovcrJFcHU2m/JeEA/w2PrjXv2YQsirWXdEhv7iGpqjP/66l01hEdBE9vWuZNklg3fBX20skgtUcsYgIWwpRWft7uSq9LwQQsg7m4+/t2wQa7ykYTJyQxaWxdzms4At3KkQHmzNwZuVtUr1MrOnUfL4E0l/38vgaQ7nKlEQ5+KuIbB/gnEq7JV4PrTiJ8itDQvq9Bj9D24pBfCCjKRc4azQ8QknV5LTsAj7CDgFCkZ0VVOb2eUasz9k52br3+9qKj9n9NvkKcLAn44Wu4iHEjzyUAkT62IAeyrm5Nejwi610hMbObDPFFJuRUueq6gg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from BR2PPF9D47B45B4.eurprd04.prod.outlook.com (2603:10a6:2d0::cd)
 by AS8PR04MB7494.eurprd04.prod.outlook.com (2603:10a6:20b:23f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 09:27:13 +0000
Received: from BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 ([fe80::6e42:6ee4:6b13:69cd]) by BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 ([fe80::6e42:6ee4:6b13:69cd%7]) with mapi id 15.21.0546.021; Wed, 4 Nov 2026
 09:27:13 +0000
From: xiaoning.wang@oss.nxp.com
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH net-next 4/4] ptp: netc: use 133MHz as the default reference clock rate for i.MX952
Date: Wed,  4 Nov 2026 17:22:17 +0800
Message-ID: <20261104092217.1730351-5-xiaoning.wang@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104092217.1730351-1-xiaoning.wang@oss.nxp.com>
References: <20261104092217.1730351-1-xiaoning.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0068.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::7) To BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 (2603:10a6:2d0::cd)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BR2PPF9D47B45B4:EE_|AS8PR04MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d303bc6-9c2e-44ef-1612-08df3a55cf71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|261021121427099003|261021123027099003|261009223027099003|11063799006|10067099003|56012099006|22082099003|18002099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	FniLkbpaZ4DGyveUOwQVC6/3Orxi+PET/21degk4IWFpRBpLETF/CLkXpmmYPPuq4NeeQIvErkmIJ+5p+KZg0LzTTvSz4+Rbil82scWdlskONhf3cTXpS9PhcqSv5naoa3rZoyJzkC5t3Y3F6bD9UwSWww8VrU7aeLsK1H/tgoFDw5xTvL6a3kfHhDMehqwjFG/BUbZVtFtv7+68zHu8PGScWTc03BMZP6GoAifVRoULQWPpzCVgrFcslKzlUxcVRzS9tsB9rrV+3HtwdCQJ/2dnN2vHW/GgyIknoj7BwV8fARkwld9u4h87ILzvc2xCzGixT7KIM26RIXkj3EpM1Dtagz/7VkfjVPuij5esdo+8KYmtW6aCv8EJs4q3WXgp6rAn9ipj/X4eaBkLJkyIyFBmPtODHu7jwoYZXv8tW4xrpEyV7pwizAnlbrdjVWg3tarOaqmHcq7KEBVn4O+sNGJHTvGKR+Kjce4RAad5HBIjv6tQGyu144pYY1M2Hz9E+Mo800P/hbkU/J09/yBVjcIQASDJiIvIy4IiYQNtxAKosDF76A6iNZsB649EFtQSLnUZB8WMoNv25wzqRn61S/CE+Hhi7Qx9hNZZIQh++w/fgBWuJZfduRLWNbMAv2AXpPSQwrQ15gWT9SQT6kTD89qWomuxBWxnesRXgPuxCvE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BR2PPF9D47B45B4.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(261021121427099003)(261021123027099003)(261009223027099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3c2Pik0fdo5I6QytVubNBxlCaHmX4EInMyvToCctc5We3T4+RLvc0d5dUcSA?=
 =?us-ascii?Q?BAe3njTlcTBVqoT1DkpUvy43EGvH1Eua9eFFP1iL0qxy5G8PHFPqktgYoWi7?=
 =?us-ascii?Q?NSLhSzvlbafhOoD9shO370jaYh/V1wBgFSUfGHtJ4S2AmQknoQVx8rZhNrxw?=
 =?us-ascii?Q?R2yptti0E79JM/GoYZJGeJa3M8QHpshUsV/uBAcAQVwlvzp9BuguUu9p9TTC?=
 =?us-ascii?Q?VS2vMsmZV07oI/a7jWYVelS5SOqih9somSWeE6Tn5n6CYulEE673uJUJLrMS?=
 =?us-ascii?Q?xlEnQGaI1mEj05yn8MZTRc/NWR9cEjQZ8q/1ede9NuNrL+4aPDZBQ9SUyVEe?=
 =?us-ascii?Q?v6nfm5WomMpx8cNrbS+LK4tjfLMzi5LL+9mCNtAZpd+Ma/djPy8uhJC2Wxyz?=
 =?us-ascii?Q?AG89OI20Yf5S3h6KWOqIkEPLXtdwsn63HUxC2Fei34mG0m/DWVfs5cjuogPe?=
 =?us-ascii?Q?1iHxwqelagvtPGEOjAAld90+GpGQg/JsQugBr2fRDmfMbt0o4sjcc9zm3eAh?=
 =?us-ascii?Q?kQHrfk4YNJCqFs1aOn1Vt7POJwBSZuYMa8vuseHpUy0O+yiR3/codrE3CXjJ?=
 =?us-ascii?Q?DliRjesCafDdZX+eHdMUW34tplSFy8TlIHcqRPfTGA5LABRJg1ckqOQOur/V?=
 =?us-ascii?Q?Nf9X+e1apja0hivT0Mv75GeANT1pCG92ckRHbh/+M7bRuv3PZ2sYOkFOxzVh?=
 =?us-ascii?Q?nyARs8/WrCbSeCxquo4/C8BnKAJP3myQT7Vm8TClJEhIesr1eXd4eguf5L+n?=
 =?us-ascii?Q?c6srVsDq4vINXkh+c2V3ZhK/Xi9fqDdMxLZUr+O2AoXksOuwRwEEYy9cxHHF?=
 =?us-ascii?Q?WFi7XcRKyo1/Dz2K1KrjVd1dmd92Te15DwZi98rlans0lpy8N8ux7GONw005?=
 =?us-ascii?Q?Sblbs1EqL2wpyHnrkbarHuSv2bUQ0JMUyyoYwl/6bgYjI49i0UVIGF23lkkv?=
 =?us-ascii?Q?wlntXDblNymWlLCfT/FRDm/0FjdxEz5UYtiw3CDg5jDr1UdbgiJvOF8WeFiR?=
 =?us-ascii?Q?yAlbozRVg+QU4AViZaPix/mq1j5kTj/fabzegZXroGU+dkr0AdXdo7hRsAsO?=
 =?us-ascii?Q?+djO2vjUWIb+2hg4itrJ1go8UFzKo9CAHKl1qDvvpjpBkT0xC3doqdqmSFRD?=
 =?us-ascii?Q?Dw9sAYqNt/G4qpVkn2DPJGUOjkEVv9++8crUVearF66dnw/lnxHjwLN+MnMp?=
 =?us-ascii?Q?RTvnEkYU7u/OCopzjkNSTgR4DhvlkZYX+f+ZVo5RWd6kjBMCDC0tvij/leTt?=
 =?us-ascii?Q?zTSNiGAyBbgTqu/E51/C+0ZQEc12FNsjTF6BWKGV8le6JYmiT/Fk2OXXi60w?=
 =?us-ascii?Q?kJKVqXPx5ox17AsUVV2ljm7YMdfHauJiQ2fbv9kcRL39psLAT/sDGLcsvjhd?=
 =?us-ascii?Q?jy2Uz5v3Vkuj3W1PnHFkfNh3kqN8xyxBw3APIdT3I/u7AcZ78rEv9PQtKXjH?=
 =?us-ascii?Q?E15RIskJjGlp9Bi8pOYc1UQow6UZmhnNKRDzjut7dxz0biC4Oy9++6ShEESY?=
 =?us-ascii?Q?IGiO37tkmdhtgqNF5nOnPX2hl1QZTVWhzqP7SU6HGRHmjhCF6EV1j674pc6B?=
 =?us-ascii?Q?SKw8pNwTuXx2ilvwmSCTuFNUJQnFjC0moztYLSeot6wl1Qh85RExQoGWiILA?=
 =?us-ascii?Q?Aye1cNdb/Iqx0PbSuBMSRMweHrrfLwxX6N31raf228YnHB1ufC79/2hL6qRT?=
 =?us-ascii?Q?DWfMrOx3U5vgsEvHyn+DfE1QoF0BaSbieyLOwiHbsqXxfK3M31o375kGWeiC?=
 =?us-ascii?Q?fjLjackcTLX8zyiRHaWFmHgjcD4Flidx4sVpRvqgqI64FvLPDlGV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d303bc6-9c2e-44ef-1612-08df3a55cf71
X-MS-Exchange-CrossTenant-AuthSource: BR2PPF9D47B45B4.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:27:13.7532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3hH3WMKbLEdRT6EY6d3L/uRdNXqs62Sy0QcblQC98UyV1fPdRiWkISOY/QQU0vz5myOHVgkUzQDYSJzfNSeeOinzEFJKqP1QMDDpxSh8L7kTxbdkgfbSfXd5dLMbSU4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7494

From: Clark Wang <xiaoning.wang@nxp.com>

If the 'clocks' property is not present in the DT node, the NETC system
clock is selected as the reference clock of the NETC Timer, and the
driver assumes that its rate is 333MHz. However, the NETC system clock
of i.MX952 (NETC v4.6) is 133MHz. Therefore, use 133MHz as the default
reference clock rate for i.MX952.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 19ca99d80e95..e2f7dd8595f1 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -72,6 +72,7 @@
 #define NETC_GLOBAL_IPBRR0		0xbf8
 #define  IPBRR0_IP_REV			GENMASK(15, 0)
 #define NETC_REV_4_1			0x0401
+#define NETC_REV_4_6			0x0406
 
 #define NETC_TMR_FIPER_NUM		3
 #define NETC_TMR_INVALID_CHANNEL	NETC_TMR_FIPER_NUM
@@ -88,6 +89,7 @@
 #define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
 
 #define NETC_TMR_SYSCLK_333M		333333333U
+#define NETC_TMR_SYSCLK_133M		133333333U
 
 enum netc_pp_type {
 	NETC_PP_PPS = 1,
@@ -858,7 +860,10 @@ static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
 
 	/* Select NETC system clock as the reference clock by default */
 	priv->clk_select = NETC_TMR_SYSTEM_CLK;
-	priv->clk_freq = NETC_TMR_SYSCLK_333M;
+	if (priv->revision == NETC_REV_4_6)
+		priv->clk_freq = NETC_TMR_SYSCLK_133M;
+	else
+		priv->clk_freq = NETC_TMR_SYSCLK_333M;
 
 	/* Update the clock source of the reference clock if the clock
 	 * is specified in DT node.
-- 
2.43.0

