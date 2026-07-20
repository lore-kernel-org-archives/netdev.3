Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C892C08BB;
	Mon, 20 Jul 2026 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784510504; cv=fail; b=PHpQ3hxjHv3Wb60ZXJvlu9qe9FT0HEe+FRjFUDqYwZ7bYt3F7CsNTJKRWYpZeCDKpgdF+nwgRgoh2wpVJSpbSp0cqIjlhXsHfaC1uf0Rvy+SSsq0YRHETggvTFG7CvVBwKOd1t594GfrKMwVfbOb2fmGiZ1o6ih74rmtJbOLDME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784510504; c=relaxed/simple;
	bh=5/Bc5Un0GdpHJDd1r7BgwqhZVWL+xMcrfc9fkh6rjK4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PxXT9qikXsfvYwh2VZfp8w7DhObRd3tFynUUU0ftnJaX9U7oL9xg+W/ZsSVrPobrZrz50vLEMqIPoajTlLcXG6ZP9dqsBeS5ogckAl6dyEIZcgQ2iAbwvSs5WHaxBB+VnO9QSYvAKrm3nXlJDqDaf+9wjGhdLMyaDp+KYLhgpl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=F7igHP1N; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F7igHP1N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtVxJC7S4YAV3893VaUDmh4yDLTTOAoNby/08CfrjIDPGTZAwUMSMgWCH/guxCPJ6rSyJaWEIr2hdjltrKA4iwZF0ve95vagtC6g0UduR3seN9UEeDtVd+ofC1axsTGZvak9a005L0i0Z1p7+vBnLR1NWoRxbPdABODdMFmsrbgp8PZmOku5wp7USTj79SYMClHhk8xDHLCLthsbrmCWc3fMsnxeiQK93dOre4bjvTdQ17onLM9EIi5kv0ZonRkPoi0PYaPKFtGDUap3ywK0DUZhRSv+VMxeFUl6Wtl0740ehHI6HK3a8e3KF0F7HwDsOGGB+6evR2DVfwu0bf7+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzBDseF5+L0KoATMQnQCe5n3WNMCksWRsxOdlZolFHY=;
 b=rJhPWIDwi5bqiq+nLqSdj5RxcMsEJ4SWRUk9Qtk+XELSTqdKuX0JJbddFCRldxmK31nIu/Ux1ubTDdNPmLgzvlC/OJAEjKB2mqeC5UgWwCRIDPbFUFG2P31gEd5gZUUE8PTRb6YJ9tSDE8UFGNdk6eLpeP/K6+iaO2mnSGidZFhjnlQBWWryMVE8J6tZIDnulbJ7FznCHKqEYfijdDtW6o95iwruQHvTDT99MJiF9P6esuyLPChVPgAZAIwaAh20tkNRnlyGSxLNDIeBh97+qVwYy5HD4hlP3OW8xN9cSVWVinChQXRCS698oOTfdGLmAoxeHRRHTCRO4u6dR38CKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzBDseF5+L0KoATMQnQCe5n3WNMCksWRsxOdlZolFHY=;
 b=F7igHP1NYjkuFdmDeI2ctFq3X2cMf0dlpyM6dtRlBv0JvjcPMLMDxjsOXFYm8bb7+2heOB5GGLX9KytdB7gATmiveAah7pbHd3VbAZfRoF+dmmcSO0ecChqJYFsVnZ78ButAYeNwCwyrX9YAaBXH5Njc4jMflYVxHMaQ076q2E69J38bBmHHZVWryJRdmaSoKyCHnNNa2b7Y88muSipuXSJHN4m0oKyeDflB4bRuLzIt1KiOtLPO/2AeLcXobRMduf+74/EqxGZdZ0LoPOw5cnvNw5sx7ALk2wCTyB0Swn9vNhbiDnufuFz3ZIZfT9gVBZkVVFGn46IMz+D12zGTAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB10011.eurprd04.prod.outlook.com (2603:10a6:10:4c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 01:21:38 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 01:21:38 +0000
From: wei.fang@oss.nxp.com
To: richardcochran@gmail.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com,
	vadim.fedorenko@linux.dev
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v1 net] ptp: netc: explicitly clear TMR_OFF during initialization
Date: Mon, 20 Jul 2026 09:25:08 +0800
Message-Id: <20260720012508.23227-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::9) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB10011:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e74d71a-78a7-44d3-e97f-08dee5fd3eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|23010399003|7416014|376014|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	B+3JsG6JczHZxf+WIfWtOU1GrU/xU3tCU7KsB6ifWpJ7SDGo4FVGrWKslupnXMEe8Mt46UshvYamz0JMs+Elm7fBfoHw1zXfUZ1ujrbt+D6MKcCkMTyHHcGMExvfnwOoLiC/APPoHzyPJ4Q1qN1IQvYYI5yDulRqwAzgx6KvKeYAPBgCkrHndXH+qUsflm5MbTs/aHyKUaM6rmKA8triQlWs0iT3KB9C2CDn/xx+TPo05rdELJlBxe8LxLntYKbmFD566DuL+F3Ur5IaugEk+A3R5nKMKMMuaeFUaSf65R6lFlwck5+zYfS8Y6r74gnwcGi/+YrJ7g9/BgewnybsonHDdsUHNa9oWYO8jQJqNJGdljJSWoCM8rFmG0etv8uY3SUIkCbxMCLTq8Il85j9irQRMGrX0K21mpLCdUdeOIAXtD52kSvY7vX7532abT1+yzgoLE3aKxL9WyNik/6P/HUZ26UGXRQs7AEu2YwiJW2oT683oPc6OVq7wTcFIRZptP+jp6lrhwh6bDJvH7bdU0pR6vYacSXNPX7reEoJvIi5QASxhsIaW0TqRXkmrD/Iap9otlmTmmC8Z8ChzDr0yjbme9HOxE8cYHPA12Nf6jrL0EM6pRRE2XF5pEm9FzjKELYte4MPfV6CgziENiH476O5TzX6b52Hwp5HQwN/HE4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jwN7nwdlIE36FHwLw8nVoeqIRWN65MdyKM3b9MdaV6guXKjXkREpRpLso1DM?=
 =?us-ascii?Q?DIIxE4SpJAikOn5Q+BJaVVEO/e82+IfXgZd7zNkj12aSA28i4kkqyRGj3tmj?=
 =?us-ascii?Q?DYC/0kk5m+ANMSbhdLqVfO/azNi8YwehOJ5zstfKD4t6HvnLOnUeFeNTNQPT?=
 =?us-ascii?Q?iegO9GkJVyqdlF9B+Q+dzodfESS8e5fBYQ3BtPPhsySNSx431qb8I1S949yL?=
 =?us-ascii?Q?8CZUOw7XAxDGNSTANJuNfbBHN9S74bWDdbFRuJyBmq6BUAcJM6+j2Ppmjnz7?=
 =?us-ascii?Q?X+krcIDe4J8aXMj4kXTGazwd5JF5E4DViw/u9sZ0uGu2b84MBwZNSEL5cHlQ?=
 =?us-ascii?Q?2Y/iKYgXWZVsIGWsM5IMs86RxC/VYVsVlrIDy/v3j5i5yyP4GDRdNycUrMLj?=
 =?us-ascii?Q?0BEl4GPXYfnSRgdjbZRMWKHBJrQmlPup+qj0OUy1w/9X3khFtOQA+FKV8BXV?=
 =?us-ascii?Q?mgpTrWmyeOl5zKDM5bLyCGdQO2uUGz4lBGu3fWxZODUt5qKCLC//ZYYnlORD?=
 =?us-ascii?Q?xY0lT3KTnE5hA8R+nE11rGIUhJ64IOtrQPqLi3AW8hYPHcpzRqRjJTgKGG0F?=
 =?us-ascii?Q?94lxZQHWVxMsP6c2Gu/vemWGFQ9uXfnoKC9KQl8hFE9OQSuR7zIiiemW63oA?=
 =?us-ascii?Q?LBF7ynG24BuWfkRC0hw+aNfZVkYtRlZwPHuXYU5dUepSwombUeElPArJp6Vn?=
 =?us-ascii?Q?ohKD+nQfy1ZW+Dai0ZUS9p5fDYl8ZYOQbR0Bx1bd6Ke9McV9+Lr177V29x9j?=
 =?us-ascii?Q?zbgphjVCfsCayaGIroRY8L6RxCgJPDqDt0R1tN8Ux98EU1UoC0TxV0DmGb3n?=
 =?us-ascii?Q?NL3kPby8iuPutrWJg/j/Fe5OP1CG3a889GEWQiyBjMOdcE5vshpn1anEPLXD?=
 =?us-ascii?Q?13YQlgjkshRiyv8zwqBx3NTiIk6KAgtDBmCe0kGaf4tZKOWRVSRPUHBougym?=
 =?us-ascii?Q?KKyxH6StRO2jryPJVI7MrKY9HincHvcayuH1+HMnAV/+YPuR49oEeqJDeOBN?=
 =?us-ascii?Q?dTy9kuxp9bG7X5WUBokLo/nZMWS8yhd30VUYmi6GtQe49ekCS++FJsEnXhfc?=
 =?us-ascii?Q?heLwEV7y3HM7guMPiuWU770FmCdhQhzQR5YxwGpOMK0leGO2t/4puFsGR5I2?=
 =?us-ascii?Q?uM5NusVGOGDPYDzIYvlc7zwddaddSWE+V5b6vC2Hp+i6wlhoAEAxxKL5PJ6j?=
 =?us-ascii?Q?BQaU7VatCYYcD4JeG2vzxwJC9pCmYh3XoHhujOUjs6iKpgqt30Jx5XMXbn4l?=
 =?us-ascii?Q?cVY22eid5Kx5MN09/4wfL3Gl3xb6iOi5PkpkAeoO721vl9KqBr8F70H5oW9R?=
 =?us-ascii?Q?00lmdnlpxP50tztd6Xdyd98FuNU29DEfOhq55UUsbdXNKKD06Jsfrk4PJYFf?=
 =?us-ascii?Q?fYmjKFcQeWpcC03pr9vVbE7jvU+LY0X1amtjUpUp2nD8oZn3hr8fY4lK7Py6?=
 =?us-ascii?Q?uLo9cAnpX1WcvQt+YW+Ec64qrmDWWluReqCy0uvnXCZ5yRtt+2n1cWV73Fk5?=
 =?us-ascii?Q?g0o+9zRJi7iVz1cyxDO23K7kJReBkkpW8D143sSZ9lRAldEHhY9tZexKQv8+?=
 =?us-ascii?Q?uLAumJRIIhXOjujoL4ByaEh7aBRXDrXSQ7//Ht5aKK3KIJWbIe7yfVelHKsL?=
 =?us-ascii?Q?2LE0uVoWI7yiJeAl/mjnnvqUlbQKWco7nSn4Wfzrsf61Vunv7xiNaK9brzDb?=
 =?us-ascii?Q?ykCcgXXE3VfllLkfzg7kEv+p462leyjptHpRHMrW111NKzjzQma1PwRdkWfu?=
 =?us-ascii?Q?7Ecu4wnEu1qb8LEkRDZgHh5297Q2Nj1zWs/eNgoeW66FuO12mIHe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e74d71a-78a7-44d3-e97f-08dee5fd3eed
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 01:21:38.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sxRgaHF8+CaC7HnC85n8Kr0zsJoCYIwrF0F2TOEi1VSVjG5/J5PB08gc++BkZrLHa+NToJRqpkHLN8QynKVUojzLK7tHcki/oJnG+Xiu1ekMYU9C1VXSPkOsZO9oPvF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10011

From: Clark Wang <xiaoning.wang@nxp.com>

The NETC timer does not support function level reset, so TMR_OFF_L/H
registers are not cleared by pcie_flr(). If TMR_OFF was set to a
non-zero value in a previous binding, it will persist across driver
rebind and cause inaccurate PTP time.

There is also a hardware issue: after a warm reset or soft reset,
TMR_OFF_L/H registers appear to be cleared to zero, but the timer clock
domain internally retains the stale value. When the timer is re-enabled,
TMR_CUR_TIME continues to track the old offset until TMR_OFF is written
explicitly. This can cause incorrect PTP timestamps and even PTP clock
synchronization failures.

Per the recommendation from the IP team, explicitly write 0 to TMR_OFF
in netc_timer_init() to flush the internally cached value and ensure
TMR_CUR_TIME follows the freshly initialized counter.

Fixes: 87a201d59963 ("ptp: netc: add NETC V4 Timer PTP driver support")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
No changes, just collect Reviewed-by tag
v1 link: https://lore.kernel.org/imx/20260706081232.3661826-1-wei.fang@oss.nxp.com/
---
 drivers/ptp/ptp_netc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 94e952ee6990..5e381c354d74 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -779,6 +779,7 @@ static void netc_timer_init(struct netc_timer *priv)
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 	netc_timer_wr(priv, NETC_TMR_ECTRL, NETC_TMR_DEFAULT_ETTF_THR);
 
+	netc_timer_offset_write(priv, 0);
 	ktime_get_real_ts64(&now);
 	ns = timespec64_to_ns(&now);
 	netc_timer_cnt_write(priv, ns);
-- 
2.34.1

