Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EF3AFD15;
	Mon, 31 Aug 2026 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146573; cv=fail; b=sTBYT82deV+EnXuB/w14AdGU10cVt+41P1UZIIPO9+cf/M/LYcKcfiBjVvHIRXgu5mUC/Di24wYQ3k+tUKN8Vf/3TEpwgrs+9kf9TdtRAXh4otnyr5alOu/ujDKfcuFySoSySDfepq1Epl2wgMBigauXtw+6hmlFTL4nXE9YOFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146573; c=relaxed/simple;
	bh=v/DZdvrQjwppZrE+dfxbe9RxBjQltuUWnbbE2qWsBP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NEMxrAWxQo1GADZBp+iTL6aSokOh+iCgb52B3fYw32RcRo5sCf/bmxTpaWrfdW6H5TzCpAmP44qSJ3jG1JyFAUL/RB/vB4AsePnu1nC4L3I6JUim6xBq8yyudfI1cvNAvzyZF63Z04omfhEkFp0CtvVrdQOLLFLm8hJk/IMmIFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lvYAY27/; arc=fail smtp.client-ip=52.101.84.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lvYAY27/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbvTy5hdxxdpINrZhJEflgHYH40bZ9sgyl5JVovmiMg92USAmGhkqRp+LCUgEbOw2GcXXQG3ggbR59yhAZrWPg6+pZvnQHqBS3MOxL8zWWfaIwEApIF057DCudoTNk0DgCbDEiCpOI4VfBwMOSEmT437vnXNWoEI60a5ANdgspWMPsZLbQpRpUWHSrc8ZAC3iRIaRp8XFnYAvxoNVUeHNZQw0XQdeNuYDrw6ZwW5hTR6Hf6SkYL7lrFbYPDPzOGQ0uBduMicyIj/2lmy7DkBmq/AXBTU2YA6sbMkZPVzmZ4s9WPuLxwZtoxHQGXVMwj8aA9GHni2TNGk4/e1PU8J8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdjuMILEfV4fU1X8z5XqdT+77S0taxC6Wssrr4zj01U=;
 b=qVnSQpdjTJ2FSi8CFWQ5wFmi/Du9Cz95ECqW592NUdTGPUbpFGTTg+G2uwgevijkKmOVCb3gB/Fud/nxzzerbri9y87zJD1fY32Smz87MFQm0CAItZ+AIhjjxKi+jptmbjRyhU7A5oC8+OKJG7rKLmIUYVCSRuHhqZC9CmItotqPXODnWoXCl27GS9mq1kpPWQR/ZXDOiU7Pu9yHJtHdzm5BmB7j6jYr6JBUveWcfCGYvV3rK6FfLDzmaNOFiMBW7ONn3//+ekVCKzSXt8Jcnr6x04UKRsbu0lPHe/d/wI2Jh4zFqdkF1IgMMOG7SJRI+JG3WZ2VpEzJJ7JCAvqtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdjuMILEfV4fU1X8z5XqdT+77S0taxC6Wssrr4zj01U=;
 b=lvYAY27/bOJekos5TCFcdxKu6kGYIFrxyNOvDFl9jHWqhQoCxABNNeV68g6aU8p9t57BhbBbtYJX0mqfCUn2W/lGBzgDWLkpoQcVG/A15+hvw8WnxFiY/Pxrr5b6xik4yGzKxomjdPr60iYimlon4vbq4myEI7p9VxKVlblRUZFMXpaBQspdjSIihhmRu1MS8kkJjk1jyIfX+VtjoBn0HLi5n108LUy6qCids3N1Kd/KRbpQl6CSlQ7BxfogXcx1JCx+tj3xlFa+xSerAoMjsI1Bbmk5GUf7J9FuEZmAL7dWk2DJmnoYXcNP9+XoGyP/atBHf/BqEOLC33eB6pUdhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:22:48 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:22:48 +0000
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
Subject: [PATCH v3 net-next 05/15] net: enetc: use enetc_set_si_hw_addr() to set VF MAC address
Date: Mon, 31 Aug 2026 10:54:31 +0800
Message-Id: <20260831025441.635045-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 552aac9a-bafa-46c4-e4d5-08df070f21fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|7416014|376014|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	rOXrC+pj5iO+leI9Nuy1f0jM1ctYXdrTvYhyn9UBvuvGIr0XcUqz9xA7eGVK+r7rNNmxH1FoEkwGbU+aZF1epr+BBB6kAPEhU1+duifWrpB2Lis/khCU+7eLEH4COtHSaaRNrvHg11CxUOWT9OJOrc35dackOqdBvsh8GqCqXa4VlKJIrjqxL9Y1sR2celd5SvbYdwt/USzh/k8NHKLA4M22BDX8v50JDOi5PmMydJi0gOOLscVVVX0CVWpv/JXg/24d+UdR8u2SByYv5yHBNRIIe9iGSePF809t0bOiF+tPbI6jfT854C0c8oKUAVfCzHHMrYnCfq+OPfvMXc12Wit0zMnw+uulCDihvUrGWJIpJCIxDwM8lhKP36ZbGPULt+iWceLXxvbjz3NMiDkL6hjBEjcts4kZToJyGTY/jbDrMKvu8XKTrAYg+aRHxxKwfVkndgQJYvO2nda5aTZAgByzB1PS1oV1w3xGeosFu5RHNtCUMbD5vqSbK6beyuIiuKYW7BUrSdEVpjM3i2JYNWws54tyQfLgGO3tP9bG0JempYzYmjDOAZ1WM+JsugDZs+6BMU3DcPvr4TgN0PqflZlRUH57aN0EKOtqf5C1MFLLfMmJuoH+8QmdKPBe/ffKC8ZmbNOV9k4moe0ahOSCgedT7B1IbZilOVMPW1ouP4nxOzCM24SO9V2kziszt3Bby6D3mcp/Z38SEkoHDN1ggQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(7416014)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rtwWp6+65Pw/SgMFMUo6g68cp104GLz/oIwWPNPGFXNpKqtays1Jv9Cfq+6p?=
 =?us-ascii?Q?46yVdUYy/NVR2R+MSgplIR3GYxAnyM7++QKTSJsYkxdJuN5gld3pv3kASJe3?=
 =?us-ascii?Q?6pw6k3Dfi/XW3mrjea+tJduuDvUYegu7E3VL3YuN5TvJDu3Gu4UaiSLh9ZOH?=
 =?us-ascii?Q?rOWmaxZulU7+eYbDUjn2i03g0xmvlqq1pVezYLeKjMIaeSyY73osTRDWwVS7?=
 =?us-ascii?Q?h3lkEAyGgRlGY85LEABMyHaLjrijCQMG02SrBRtKL5S9MzI4XGCxfi9IifAX?=
 =?us-ascii?Q?mCUV9MOSBg3MrV+mde9NcUVzyg5BiakM4O853cwwreqLgqlntEOj9RfIErUM?=
 =?us-ascii?Q?bwK+4UAyyoH0bfWHR7uUgXgddxuDY5qUKHAMiTdgvYp3GXU6zuJU2v35MBYp?=
 =?us-ascii?Q?tI4GgQLXFcJu21r74Yzd+HUsM10sNYhBNeYjuy+NGm3Yzptubf6d62wRuAZE?=
 =?us-ascii?Q?K8vN8BdE1dDnJVyhNkdr+UJyAOe5iImtvsQY9IMIadre5b53ZZI6QvonwiKn?=
 =?us-ascii?Q?6w7w6NXfp+cky1iBqmUUG1LRHfWXkLvpP7SxqZCX2o80sqbDR9Lt7jo1OvYK?=
 =?us-ascii?Q?AGzn4Co+NjSCi4oQeJVvoEHFPaLbpnWi72yDLXrbAYzypy6IitwQiTJBOvd4?=
 =?us-ascii?Q?CTcmlOB6t3WjLWScuuz3OGNdHSeccqZsBYdWtvtuXxQbXub2gUlvzXCfqL/K?=
 =?us-ascii?Q?90tA4dy0OJp8fgASKMoCkW7MSOhVMeawTbAUEvnwbniALEm4QqQG687qqVTC?=
 =?us-ascii?Q?/Zscj7UIsHg581tzRjDsbB56O48kqZWmH9Hk5rW4MVfcZViI8Vmu9auEAq9W?=
 =?us-ascii?Q?xhSFJLzJTWfvaEZllc6GQnvKIQ2eOHjDwlb4hj+gArbH7LJONq+5HDg060aA?=
 =?us-ascii?Q?VfzYJaTUySzxk4Yk/CnbMg4C8ND8z1wQGLMUDGcD0oRnZxFU1hy7D1QuBRSd?=
 =?us-ascii?Q?fWMFm5YDt/+8YW/7UV13shokEBuFVihX4em4Kp3v8J4cw+cls0LmO1ezGjZj?=
 =?us-ascii?Q?l6sWpMb2bnE76PpLWd28TdXINFyqIWogai85Vntxr2fX+XTiZJ5m2PNEQ3R1?=
 =?us-ascii?Q?guyLrKTEaMIpXFxG31eigs54D/sFOpavfvgrHOiz9Gitws1DeMzDWxoBUA0e?=
 =?us-ascii?Q?BUoh4a+GWf0L6PCqMt/uGCJT9JWCsttx7lNP+21zbPA+puUsIZUpKfEr+59E?=
 =?us-ascii?Q?0c6hvbIHmUZKsIvyGqLXJQ+VS29Ceg1Xq9Zu1UIWZquSG44CI0bJpp0SSwjG?=
 =?us-ascii?Q?O3QjcH014Oj2t2WRLT+I8E2HXqtXDmS8FHFFktuCG/G0rmSBoRxpe1SB++xW?=
 =?us-ascii?Q?Ya7HNRriSui0Azp2e7xgJxj8tP3Ysu6jhs6ksWPtkuDbn/MMW0bPkPYh3W7P?=
 =?us-ascii?Q?0irX/u5bsxE+8iJt6qwz2gGaZyRvSDOmwq76Y99VVvhawPHvDrWKHCk1PRh3?=
 =?us-ascii?Q?Vcurkj3bardnl1F2MnDcDoFdxvpV0dFT1NSwUfk5aEHBv31ARpnR6NCgvMAR?=
 =?us-ascii?Q?gWn8B5Bcjuo6njKRIAG43WR7Lp3Tmrcc+whu+Nf/O5Thz+o/swOnK9f2AAt1?=
 =?us-ascii?Q?UVQKrnrkbo5YMG5TkfdxTPwW9SIin1HqSDSwXoUPBz0vrF8tUPDBRIYipCHj?=
 =?us-ascii?Q?Qdwb//IFZ96U9wCx1uZfF3dj+5u+hD3+JhLH3JEbs5r9mbao7KdFUEJXaM4K?=
 =?us-ascii?Q?GVacQCikvQ7tbBZGFKI92emfiqoTdv4/QqRckKpEre7J4oO10agVuFXyKMd9?=
 =?us-ascii?Q?CY7xMJvZsahIONKGI3uYW8E9LSajrWrY8Q4VSOjpfmTXdCj1INBZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552aac9a-bafa-46c4-e4d5-08df070f21fb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:22:48.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPVWn7WGZq/LMMi4R+icpDMv7YhLwThvam/POkezjJJrnpaDzJwnmMivT6mbjHXMoCeJlD7BFvBQfc3fHbo4fqfwxRbP8uunsMDDLNGMuH1Y5AJVvSeALihqSa2FgRc9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

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

