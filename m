Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86513A258
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218951; cv=fail; b=u8fq/0chaH1QAjEFlK4tTFUTsT7rrqGdDY1ehUV6DRfvDs2k3x2mTp3xWdmGdTGyuQWE01Qoic6m8IXEtZJ9HVH7vk/PTRoe8F3l7XjOt2bxwuP5ZZXsqCLy5CE8pp2geh4lzWnq/hTqOTJTW3RH0HCHUwIGFjUqlb1mVyBnjTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218951; c=relaxed/simple;
	bh=7iHTyKdSATHAjH6J5GnlijEUtvDxHn5gTxiyAKz35x4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IZRSFxY6ajSCqoQxuSgudAncZc9OI/h3mRdOLrZeadGoKtre5pRxAKCckk0wcDZ3ON1BEeVxow1RPVvH85cCo70GP5UiHORuza/zNm25ymF6waHO7eAGOnhEYXdCytXDxSOrPWx2RMVhJCXLyqOAtdpjBLNC5/BOAHPCQUM+vII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Hs7rEnH9; arc=fail smtp.client-ip=52.101.52.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Hs7rEnH9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZU2tBjYiMZZI20sOe6XaYhC7uclWWUO36axnqh0rqAoU6PrBI57f+0aiD1aVMJLNbGvhbuB+CxTbfW+RPdZjnK/lpEiqjmvWDG/cQveUs9wIES6omFUdqm1KdTPoc/kDv4U6fdjaeDMf8mytWu4vq0CLl/59La4wmurhQpdiuA6wPX4+ZXYctKLy/c9BMAfOUVyF1jEit4ymYf0hz6p/Mon0OmaaFDR9JE4KXYngy2DRMP+Vglr77+BO9Wgr58GlHfU8LFKbxnzmJLzTsK3XX8q5n1zLO0l45r0rGKTwcnMyN1WuYWO7DJ1oErU4kDEKvjaGuVAW8KePSLTKbCAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Zg67UvBHAxJ0vmJ4ktMbJqwx6eTZ4SBU6O8qA220gk=;
 b=j5Iv5x2eCOfs2iaDH8HNtvK7qePjGSAxubBeYW4j77D6FmC0Xfh0kI+zORcP/Aa5B1YN5vGYVII6IjErfsAwlaXWEyhwK4rKqVaESMJkRCge9J2RuToxrqG6MRp8iKywMQurQ89AKLjzJ680hDYQ0xFmEw0GzW/dsvBbKmNCMU/1JrCsQkrXJZCRpYLaRju/Ht2eYnTuug0z93hQ0zyQO8I512NjFImySuBjUxkuHdoiJW8dcfW3tXgvTDagBt/GiEMKxbcpsec6dKJd7oeRB14+NDiI10hYRrf5htTwekBDXYGvhHu342ztGuuzZzfjfzy9I7BQDfjJ/2NbK5zm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zg67UvBHAxJ0vmJ4ktMbJqwx6eTZ4SBU6O8qA220gk=;
 b=Hs7rEnH9FLfL3ey2GONScX5mID20lOX7EmbBTmvLeK1m574GRWZ7FbLCdhBWgb854nX2Gy2WcYhXK9Pmja2K52HnCsyL7xfnTCQPu4XZtLWQul0PQrOvBR+bCrJ5g1qwQsultxWJq+K7H1ECBYsqlVjyVFMVUg3dYJVP0ZuIYNaYZkG+61tuxsyt+RIvmi0iCB98XT7Y6cRKDQuo3ZAkT+6JjDtlgmll4dYJVaCVyaSERHUCqdi0XlJrJdVDS/UEAySsJfaVmEIBR+1JCDVDG6NtIpS9hhGF2OaS+G4hRVvaBdN2C7UhLeFfAHbVTZ2FIfzi3jID2u93aeDDBigIwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM6PR03MB5273.namprd03.prod.outlook.com (2603:10b6:5:240::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 06:09:06 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 06:09:06 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: rohan.g.thomas@altera.com,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	richardcochran@gmail.com
Subject: [PATCH net v2] net: stmmac: Fix E2E delay mechanism
Date: Mon, 27 Jul 2026 23:09:04 -0700
Message-ID: <20260728060904.31993-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::10) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DM6PR03MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4e1559-9a81-4186-df2b-08deec6ebaa3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O1XaIYMF0Qx9DjJhAZUefFPHg81/9IX63RujNxo8aOdWcDtNAral4EdsaxxQbXrk0H1tnpyg40CDMpq0eDLKXqQgxsclyiXvRti8bmuSO3owunca5WqyyzCAXVYI9+5Bb0w3yj9Fsa8fGSDCwZY7EirG2ZOb30o7MYUt3kJUptHEaf/3qjOqZMHUL3rHybR06XV84ROjJqewWk+/PryCHqcLgm5NAzm56Or/hwsu++6NyeG7QOaWSbydu9QFwF+3GzdPS2ROiVSj4WYSlAzEbfUHPXUbsifeYPNfxgfBrUYdd3eUracKA80bF0z87SYmU/cXP/43E6JtPwyGiXCBDoCmkRJ4rsuLJz/28caVmYw3Y9HB3123pkKTzWcVVMvOyQWIzYvq4qO4fCi5n9eexH0sos0inU+5odH/J2B6BxJaBzYt9zkWn7K7/ZCfr7NNSmWMksZQwkZF9sdRI6o/METPMzLqV1iZp10Sdc7a1LhXIlIKjfwNvuUKVavYyGlOnw0dgWW9vq3Hsl4iXGx21tpE3NGGPDXNn0e3G6vyqSXR9+bZapKOz9OKAEHFkDjnr9MJYwktwYnIRUjr7V2LIZIFOQkgLJUFASifqEeDpBD4TxdJYCCjCoYU3gIvFednk71PGbBjX3Y2dmfQmSTcLpL4cMZ8h6wKjdG5kvQge6A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j9/+6aPlZ8ApjtlWZNFpQ/IwAWzJmDJj1NYkD4B8Twu6vp9vOAK8s3uazSsa?=
 =?us-ascii?Q?rVnr4udSW2h15LyaF+R6+jJTMax5+K71iyXODHfNFJ0VZnGpqhslPrHKv+hC?=
 =?us-ascii?Q?U40EHnw1TTgPYQuAjvWgT15DCIy7l1Ks4LCEY/upPMirDlxdu05uqqvSqxfi?=
 =?us-ascii?Q?rOPxt7pL/55VucKSdR01Zu1GzyI7S6AbFXAOydkb9KQlL7SAlPG9njjt6KfU?=
 =?us-ascii?Q?ue1nOHn+qKTgbzSX2UrLqI0wxrZHftnplmcLx6jOvNFEu4hQ9oESEd+IhSQN?=
 =?us-ascii?Q?M9GtCguAropLa2+RCQOWzMd9fq/Kpwy8MtOjuP7/fLT56l7vBmACZthecSns?=
 =?us-ascii?Q?peqNtiN90NSDO2jnh+LlZ4EY0/BBX1c6HtKfpEu6vpONwtWvcAzQfGbjq8qa?=
 =?us-ascii?Q?WVRPyg8k4dI1L6gl4xl6zSey7MgMIymda0zFXSTiRwhEPzwH6TbdN1WJA48/?=
 =?us-ascii?Q?v3mwQxe82kmsYBpbW/Jm/4MN+WZHF7XQT2TbOgwSQl6SfZ7hH4i94dCQSzFS?=
 =?us-ascii?Q?Gww6SA32Rd4gvrBWG1rneUq3zbDedbEXdNLWUnqM6pQ8l/a4JJeu3JK8FNcj?=
 =?us-ascii?Q?S3xWjQtrZyk6/zhpzO/tbzIkZMrAo12JuLtWrmCoCNO8D2+R2U1tby2XOocS?=
 =?us-ascii?Q?R3SuguB0v/744Y/Xlg2pAkBJ8ojQRfOHkPd1KilFBDr4sx0Gers0DZEeCEmK?=
 =?us-ascii?Q?M4IxCHwq/EbnEnR2Ffn/l8GtXyXlJZViOD/x8WDWbj0KkqpOAIQRYg6a+hI1?=
 =?us-ascii?Q?SUWqzl6uix3kE/uvslQd1ljjtLF9cgJFTvI+qf1aJO421DQ0s2xkR3lahNJV?=
 =?us-ascii?Q?7RRC7uVBTUVoVjzvbAP6g/09hm9m/CG8qSi0vCFJyYUbQ1wwpx8H6xNjNRXI?=
 =?us-ascii?Q?aIJ9B8UnWot9DfrqXkUOmkiFJ9YDlJCqCRkPoWs7and39XKGKR0NpxN54ii9?=
 =?us-ascii?Q?NsEmzpYZgGDXd5wu6D/bo7Bu2yyYmEFoaNrjHQn7unA+NODNX0CmfdYP/rjZ?=
 =?us-ascii?Q?1dovs5cs04HAVNDbdk7Ac4nLe+3Q5opnZlRSgkDd0XoWM2IxbHrTypLgV2Jr?=
 =?us-ascii?Q?dNI91m5AKpZ+UYNFptSVOYu24PRJ/VGGAE6a0nrSo5AWse+XxV2mBDTDCa38?=
 =?us-ascii?Q?Yix3QaD7+k5arQBV23P+IPmHhuy38/JH/jmoz6ARFv+JI5I1/KQD0Z28mfvZ?=
 =?us-ascii?Q?QevLaaG/S8Mxpxazv6RqQxfTfv/fd256a1YjNwbgyvRhshUXB+4iAZrLwNc9?=
 =?us-ascii?Q?ycr2y8/n1DCIbc2lc3D1uDClKktYofaIuY0pJC8i6AnXYmsVibFVYf30db66?=
 =?us-ascii?Q?0QLjQusR2XRR3dyHKPkwLTH8A3tL8HmoUyQ0YYbetWfOrVCVWscpHFtxxcMw?=
 =?us-ascii?Q?juijgo6EUghpg9361EW+3ia9+kUX27+xooyY7aczyORzLBGLNqGmixw7mt4B?=
 =?us-ascii?Q?G75DjFE/zGCoxtA5OcsIh/UqBcUNW8yCOCC7RzHZLpAfnULg2I/TGpwR459J?=
 =?us-ascii?Q?OC8D9JXORYAx0rEBAO9ZpbuKAmAEgIWXvXAvHoHCQLVGzuf2YagnwUF88lbG?=
 =?us-ascii?Q?BMZ+JAXma1FkiI42TYl6Min3pVqhXnFWr48i9sQ9Bu3jui3syis7RUxg1vJU?=
 =?us-ascii?Q?KaZdgO6/aBr7tw/auP9n2AYQIeNpAQyymq3bcmHd6Y2tvfuqID5DpMJMqydj?=
 =?us-ascii?Q?7onCNtybzlo+naXJ9vaEIVpQqQEUHNe49dGxP0ongrW3ZWQ9AlEmLqeZmF2Z?=
 =?us-ascii?Q?Y8def9lmGU7V1zGI/OnJ/9Sp2IfQr3MPnV6RW0ST+DPAqyqC8OnGNrRngbl6?=
X-MS-Exchange-AntiSpam-MessageData-1: muOrwwSlRvyrTQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4e1559-9a81-4186-df2b-08deec6ebaa3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 06:09:06.1287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVT/JcE4ngRT+5CKw/ujq0cj8AT/E10l4zos1UveTgr3PtzRxztS9ODbJwRw+4GZM9SQvwitloQXbfn2rRIw5SIWC2FAWu0tYXHwb/sZNxeOmDmd8y1/WXmTmihXHNf10XvoxMw9/pIx/WJkltiF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5273

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
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
This is a resend of a fix originally submitted by Rohan G Thomas. The
previous submission (v2) went silent without being picked up:
https://lkml.org/lkml/2025/11/29/71

Changes in v2:
- Replace !priv->plat->has_xgmac with priv->plat->core_type != DWMAC_CORE_XGMAC
  since has_xgmac was removed in 26ab9830beab (Jakub Raczynski)

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff88d3..2cd95fb8bc71 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -755,7 +755,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
-			if (priv->synopsys_id < DWMAC_CORE_4_10)
+			if (priv->synopsys_id < DWMAC_CORE_3_70 &&
+			    priv->plat->core_type != DWMAC_CORE_XGMAC)
 				ts_event_en = PTP_TCR_TSEVNTENA;
 			ptp_over_ipv4_udp = PTP_TCR_TSIPV4ENA;
 			ptp_over_ipv6_udp = PTP_TCR_TSIPV6ENA;
-- 
2.43.7

