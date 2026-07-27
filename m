Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7E35E1AE
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119167; cv=fail; b=ZokxDRqVylQIb5S137O48fmtQEA8nBaWlROzmiAzW/cQqr4pxdVhxDfMK7TsQhuZa468ZRnH/PbMozGgiQYFvfXwc97REjfVxxB5zYdg5ONF6tfz1BkqAucS1Ce/WswWWaUh08vulvgHvJgbqRaksWF5egDs4lyI/8RBA9B4ywI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119167; c=relaxed/simple;
	bh=/dbGznSLtjXLgCnjdtGGot5aUz6QSKkSj9krpGyOMUc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZQRxYB+KAzFP7TrdhRrS/HHqjo3+WEUoA7c6l8BDJ5vjPqdPX9891eAhCxfpnRrO0saDDD/0ZV8jWSvP9zErLPP9mNxhh3nAKo+16wDulCHlRHkx+T3FnR7XSP9x7AHPFfNJm6aGGqK0VTfZvssFwspDjwgpE5qwVnEDF6s9qwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ia6lfhj5; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ia6lfhj5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GH2qGTAG4FEMLu7QYhyGkDaC7Ks7inDtGdZgThDyBIItbYon0bUtmNtVHObXfSfSsclLWi8z/qxYp+oCJlEpRYOt3wHTyef8H/LEHI26TAHDotvO34uSB7qsLOLigE/6VFa0UJWgJvY3DrvvSuorNksyGh4FhgJpLL9Ar0a/UlUAkqEohkYkzYPp9k+8g6fLSLN6iP3FAOIXN5bcT9yWgTHs24jmX75spwO8LQbN/qW4ks7+bkTDOGrtD0k8uPVzc6aBrcHzWtgqxIZj43U7J4EY7+5FTICr6IlksjauaGnhZY2zNtDlf4rJ1G04FwIDBwdmPZF91uvNBR5f8EpPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXXbYSlJrAIQh6WjjXcKGyNcy7wMRuU6o5o8dvezkI4=;
 b=UW6jtPrElh7bsCLl1i/2fwBX8MjSvt5zhjUA+8WochN3aEV7HS2ufQ/iifGRZF0zkX0S7JYjIHO2bqNRK0URXoAtDBYRfw8cMc6MORaYMndSe1h7/YF+JtT5DHI53Is1txf2GcDLhGc2BXMFNs+POUrDdH5KdzvQb/iFUoj5pIt0wff577lcYZjY1GDnYX1AqIa/2+CnvZAobPYM11VCqz8Em/gKzI2jp3N/QxuooaUtdAFk2ivwYIo5988WvqVDC00menDcVrxlATQ+D8o/kiVSNTxBuPzYTQWhOykj+6E1Lcw8JejNVKfX3y+q0q1SmUa8U1SZOm/xY3vVaFQtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXXbYSlJrAIQh6WjjXcKGyNcy7wMRuU6o5o8dvezkI4=;
 b=ia6lfhj5i7M2yPl0rlgXps0Hk39qjn7Gc7E3DAmS/ltox57X3Ia6aWXDJCTmDbcbwZs4merfqGNmqW42M/fSv8hx+zt/jQIXSx2Z/Eby8pxuexO2/x4Z8MgMnagtZX5QgJiih2eRkitMhQUyaHrcT/eQ9Bq/ogRKQCwxLd6585d0akL/Q7P8mJbnBmmWlAVW75OJ3gOF/TUeXePSxgC0DadQ8XYUWVWi/FFrRoLXr8S1Yy4OL2+xDFbnkCXlz3wQkdMxNe0AgJyoZdLSkijj4aGf/OypV81yiSfWgTGqaELyvRovmW6KL7lKtpwERSuCw03bzhA8VRgJfZtnaxonkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM6PR03MB4921.namprd03.prod.outlook.com (2603:10b6:5:1ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 02:25:59 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 02:25:59 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: rohan.g.thomas@altera.com,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	richardcochran@gmail.com
Subject: [PATCH net] net: stmmac: Fix E2E delay mechanism
Date: Sun, 26 Jul 2026 19:25:24 -0700
Message-ID: <20260727022524.7521-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::21) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DM6PR03MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: 5702a38a-8f08-4f76-f61c-08deeb86650f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|55112099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	J5w55UA4rzqRVzAiLTmaSi+5/xN0pnpC9VQyXVFvJ1nFs8GyKwE3p599TDfP6khSjzCL1/2JS/eW5p3uLq+WU+Imfdf6w1wxBJ5l+YxP/wieRXqevrii0dQXq23aqf5+KfsGPQCrFI68RiXYu+sB6lVN0oCLplFqnogQsCVBf5oflJM5/rbOCByxVj6C+/o2E1znTcHu/XneDeXoAaOsvwvw/z0zXpHNB2otQL+FwcglPBzxkmok0Ed02PusuJgIg1i6ALYBl45GY/w9eKA/gLz/WKPPai6Z2kpn471oR8h07R9j3gg8z+XiO/8MIerfiMfwwShCJZpoLHYAV7ZH0CP2AVe70IQcHO5I8AeCSaA8/EaofsYCuO4kl/IsFEG3nnYsgMcd7UMcg76K2euEWTYJ3J9z57i35GKiysYr6VIO+y75Wz2GPL1GNR7e47yKdEgSmINSe/FeR4b1fJy3gByIY4WvRaHCEbMcIg5DjX0ccG1BfzX9mY4yCPZBsj9L1JFUtX9LHj/LZEN86+0q1Z+Mz3bxZGfwQwzmF3AUzK9Ruiw0jrV5XuyIKmJFaLo+FVqQ2dhmTqUsGKrd5A74ZG2JSiWxSFVK/ItNmoE7ROI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(55112099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ec/kPOio0KRozjuKSX0pg2dCRZEV0dsQCX0UkjUJrhNdpDpDohvHZybHs3R?=
 =?us-ascii?Q?7Qg204ZQD5PPgUIEFAJ06QBpJFiOxB+9sMCChoqc/lZmG9c0Szondl3gYqRy?=
 =?us-ascii?Q?EdDIdjjJ+HaVJERpxeZf9EWVYxQ4HcHv/qZLAen7S8w88cZn4xLhuxcZSxCF?=
 =?us-ascii?Q?XlYMK5tG524iMskJ+HIHzMqAMN1RLpBrkPoPVB4KacKjVcWC3WTv0trSLuex?=
 =?us-ascii?Q?l0cUDPrxrBsC0ZuRrN907sPzvufywYR5s+lGS6WGtMeDdSL/r8rnfeIOQEN9?=
 =?us-ascii?Q?etJUYEgwHBCec3vgfdzgM7ao6e2nSDeIIYG4+1dXd64RFtJ8H9ZpYSoCayWa?=
 =?us-ascii?Q?3xxfzjlCDNxXD4xYqP5dABgc7i22sp1KZT1Z9rvn0fgjbqGV++a7wWA6cZHC?=
 =?us-ascii?Q?eBpOw4Jq5w0uHzwBKDCMvZDyW7MEVZeJG4kdECiCGn68vd6kRG11tksqk2hL?=
 =?us-ascii?Q?j7QJ0t/E1kaJaUoABNyQ2XB9tOGeBBxXh+nqOdmObUSDbhA3d49n2qBpRPTC?=
 =?us-ascii?Q?JqvUbQ8kx5W4UIXC5q5l4PvdiDEG6ldBUu1LnsWrK3XAAc38UxgDqn6seXaU?=
 =?us-ascii?Q?sqfu2ChnyYW6AkC68HluIkF/+sDP/hXKxFzfhXshUny6HFER5Efs6aN6uQTY?=
 =?us-ascii?Q?dOfYid2xazWxB8eIAPZ1FFi+HnjcomLo/If5k6tsfBh1CweJNjexPq91w8+4?=
 =?us-ascii?Q?dheSddEVSBxjtY9UN4/atBD/UovULzdqd6Mb47pVUp+wQLCO0h3y3KN+v0MZ?=
 =?us-ascii?Q?LARpAyySGbnyJG4BLwMEcQ4IElJSYd4EdDASHANAx3OwjpgbJbWFctIeTlL5?=
 =?us-ascii?Q?Y+8lDYovujiAmj4TmD8ANuvHIUz+MdMQgAnDsaAwH7xE2eQOgEXCatLyl9Y9?=
 =?us-ascii?Q?M0QnIQTD22BLO/WbayIINPVDpE0feed/tJYOQ7J+Tr3dXrZK2Ca4MlH+e8xw?=
 =?us-ascii?Q?WERukNc/a/U4yFwAUb6+j2qlJlvZUsRe9OnrUuBrRdKS7AGmOYFMgo1u8ePn?=
 =?us-ascii?Q?iDHr7pm0OhQbL6/4wRSQ6on6v+JeWtqffubez70/98Cmumx31nIbzrj0NBpA?=
 =?us-ascii?Q?bQx/7UijkMA1RzUES4WD2j6eIdLJ52+BNw3rrWVeKlq4+K5+JddVZMU5tiKn?=
 =?us-ascii?Q?dl2NXbXvEq45Fs7IXrhL+DPvMj4BGOqwdox34tIHq8EriQ8omOtHoWk3HPcQ?=
 =?us-ascii?Q?4ldzWGtNYe0acraKObrNk3e31NoBkSXulDFYQDp+fksyxnN9tbmHyNk2eAn5?=
 =?us-ascii?Q?q5Jin6IrAbxQOgNtm8rgQ5moYS/KZ0Yg2SeSY8qUmR40BTP+kMg9Q+eTp+Aa?=
 =?us-ascii?Q?Hz2S4c/kOjigP2qqy/XUvzgKRKgFD4QIUwPtSnbq05F9AKXB7cD/ieV5QVru?=
 =?us-ascii?Q?9ak/fQ3jCIKreYhBQwxyVgGn+g45UvgUyeuY3wAF70+pzbnxlTES5PPtR86/?=
 =?us-ascii?Q?NXP7mEydj7yEhYUajFBiIHX+PTgLadAZJj9GPEgY0lQfkv4JBG8+l1yzWSPz?=
 =?us-ascii?Q?uMsJQlzpnw7nlSrtNpx++vIr6XE6iFoi9cQ6o5O58XlBnjIXHkf0rBnyrmPz?=
 =?us-ascii?Q?zqLwubsUFjACYvCB3bUCY8E9vXhSt7kD58hBmBcmWbrpdZMOq48w3gOLganz?=
 =?us-ascii?Q?kunIxpBxmQ/MSNGNmLJf9J05IwtjCdsyiTSnHwqkfOkd+gc9bPYntWsoRQjV?=
 =?us-ascii?Q?MIEUX+MNNe2ZXqhTeT05x0wibg+JzCuaHgNpV0Cx4cODfUg+rAVnw32w1FyH?=
 =?us-ascii?Q?mumih5jM1XR1t73Gn0esR4t9ZDXuLSc0VLFpQl9TE2I8BQNrGpd5tq885LUo?=
X-MS-Exchange-AntiSpam-MessageData-1: YOsXWngufa+WYg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5702a38a-8f08-4f76-f61c-08deeb86650f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 02:25:59.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10bM0R01cgAbXKouemRRMN+OxxTtU9lCrUY0VyUTWS+pbLrcyBzx3HzHDJkv5rVr1RW4qRIR2TkJZNPaf9UUuMT/Pbe3Rjzbi9wNGdbKJMXLed+vPjUeb3XRovv1uhAKlaojZVLmW+d9Ls8/RaLyCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4921

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

For E2E delay mechanism, "received DELAY_REQ without timestamp" error
messages show up for dwmac v3.70+ and dwxgmac IPs.

This issue affects socfpga platforms, Agilex7 (dwmac 3.70) and
Agilex5 (dwxgmac). According to the databook, to enable timestamping
for all events, the SNAPTYPSEL bits in the MAC_Timestamp_Control
register must be set to 2'b01, and the TSEVNTENA bit must be cleared
to 0'b0.

Commit 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism") already
addresses this problem for all dwmacs above version v4.10. However,
same holds true for v3.70 and above, as well as for dwxgmac. Updates
the check accordingly.

Fixes: 14f347334bf2 ("net: stmmac: Correctly take timestamp for PTPv2")
Fixes: f2fb6b6275eb ("net: stmmac: enable timestamp snapshot for required PTP packets in dwmac v5.10a")
Fixes: 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
This is a resend of a fix originally submitted by Rohan G Thomas. The
previous submission (v2):
https://lkml.org/lkml/2025/11/29/71

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff88d3..24d8c6e9f1df 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -755,7 +755,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
-			if (priv->synopsys_id < DWMAC_CORE_4_10)
+			if (priv->synopsys_id < DWMAC_CORE_3_70 &&
+			    !priv->plat->has_xgmac)
 				ts_event_en = PTP_TCR_TSEVNTENA;
 			ptp_over_ipv4_udp = PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp = PTP_TCR_TSIPV6ENA;
-- 
2.43.7

