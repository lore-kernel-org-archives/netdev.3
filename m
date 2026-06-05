Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013029.outbound.protection.outlook.com [40.107.162.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421F477E28;
	Fri,  5 Jun 2026 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644222; cv=fail; b=b8XHUlBmW3TqNuwl9S2LvKrnt3bBxkStCKu+F0pjSIj6WRyAenP8rXQUYFSYWP1zovvLKnCeZCmcjfL8aXpUPEKt4Vvgt3UAAmMauz2rqfBgLwcAKBxUamCI7p7XrdUdeM45J77VMNXelRb58eQD0ucxDnl0iDQ/vjhHfEGn4FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644222; c=relaxed/simple;
	bh=zNoYouql9AB/9hQJaqDWLQoMUM9RReOf9KQ5JzrVJ3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O8I1kzGr7Ul4nWmdeZ269lQKwZSbfaqX2cea547hLQLWNw4/5EOjvnUbOqjNaMDWNsV9pSwTrVquqVUxaCeL8PU3iCZkLVn2//k4UOAe21F1TBIJ7xtjsTgOrNWhEXOUs2R4XPjgU51yb0U7QxfpYj42ImGo3Z9L8Tu+K0E89sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TMqWMqIC; arc=fail smtp.client-ip=40.107.162.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TMqWMqIC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3Og8aKMHkUZd9nbFDwy8pijPW9sQjqwOw+Uk6KlNFw0PIaDoGOmtyXFLuWMWr/oS9tW7aAsRKZ5fxCl09J84dI9o1SA9ezsodGoMn/6VvmvwhQOvw5JsLwEJPXe3luyjAYtOh1u9rsQI2aaV6DiNTvv6hJ5/E8cjeqX/aadB6LUCFpztYtVGAaR1+nh8JhRrz8z1v282T62FCl2TZYaEetAPwh0h7DUoEXUmwKpnAS++hE7MLMuZ4SpoEt1MZ2KzZ39nJTmSmo3nqXzHrIadnkOjG2rHHw7+EsSaTmdTsjP0Z2jsZ72Weosgw6IvhukSbeCtoIEvNeaKqnCptVAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXr8uG74g5OOqx0G3jq0H85+1FrSpwkC1VxymMI70gE=;
 b=VZSnjIib2y+YoYuzrkBbOcPybQrKeFoAqwX6lXON+ge5PNLKBa0tX+Tq6axRDAjTRq8fdRxVvSwXI0MMdgo6hCwrJLs2hJwO8Jg0ZnBDsAmKw4wtnKxqmrODjtu+vc7dcr8eEyxRUPdcx68XHLjzPN1nzXjJBby13bqDBINtCKnLqmGchLD/gftcGN3BvkWa//9+elcwXVIU/niJplsMXnY+7evaYNLRgKIVTz/6/oqVXgSX+WPch2sfYxqoAC8ZEegnGBpEtBZsHavxu6vBhEWhC1S17uFH9eLc/lzXjvcGotSjwSHWyuCPTAm+WyltbDno2Kn2CyYTu0bk+KQwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXr8uG74g5OOqx0G3jq0H85+1FrSpwkC1VxymMI70gE=;
 b=TMqWMqICR52c5XJud1xTR/3Ln7N0A8j9AiPigfT2gX9K8IqwQgyvc5rN+li7cyLh9OZCf84VlcOKnH6edpQO+7bgET/+XuMaTCt4kXCZRi2l7Ow4CTQ347oxs1COf6mXnf8UV9b2FXusscpC7cfnbPUwmibfiyuNOqPFyvpT4Dp2rS7Qe2QsckriAaxR5h17FKpO5sYcUZT0GmI9Lc6bZcwtDdxp7g2wBgnh/ZwJ6Eu1uN/Pbr3EHFOvmJvIZewFzkjLlUKrX3aek+f5008kFzW3CXOxSK4m/ynGdwEfbCU/OXkOYznSXUYFNvpuSIsPvTRA8B2EUS8bmdOzWfML4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:23:38 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:23:38 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 07/15] net: enetc: add .ndo_set_vf_mac() to the enetc v4 driver
Date: Fri,  5 Jun 2026 14:55:42 +0800
Message-Id: <20260605065550.3038579-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0237.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dfb033-3f0e-410e-b389-08dec2d35cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	fdjXFHkLpubYMi9LWWFcYHp94ipV5+vHHNmf/wl8yzQZZygI2c6/wr88XdNDP/4c4jF53oQuSiM9/ATSu8kR4ywoBYJDDSlVZ5N12tf4AYEW5WvxNYPKB0K0BInNHmMiK/l01Hyfdb+m+QyUxvziXcFoviu6ifuqLOwW8Gq4JyJmS+ceFieIzNmSoqIs234JTs6UjkQE+yF9fI1Ar1nDqJCha1u/667fGu90UmoJvuB6Ak5JPcZgtIGfbmJTHEYC+BDueXGrMSrfqME76FXwr+WIILckFnFUEt/CqniVXAwmQJI9m8c8/nvt9pQzmlyC7bYMhdKjSyhGWDBQUj2mAKPdPQsv20nBn2K9dN9kvhuuDlMuKJ9SfW1DqUAHvHGae3Etf+iuKS1gz1efAtB8o5KI8/jarpfkf5X3NJf/8ITHvqxu+2WONRL/O/PgdqK7r6mM9kyjXZI2P5tcXfpSqO5/tP2tSlJ0cWhOyOdUZnGJ84/Rk62tZuqxIPA4Gwp0F1n0HQYZwWHwbn3H50pGq0gzOV0cVx2rjJnjyyMO8DfMxo7LkejfOQ4BO2KZE/YjCJpLXlYRKmnIccffXNY5H8bUidJ+JB8lR5+faTNAJIfSn9QyXVHjYTpDrpt6Dj/40GYueOfqDXooCzm6Inp2Scl/DC2+qQksTOQWcMr3eyL0lAh6Srrc10H9S0dznfZwDpQxyL0zAIjFSOs8ENsNPiwYrw6saP02CH7l8PJdu0A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0DpCA5lcwD60Mb3s1CYzVp4hwCRoIUCCsaCcssq47HB0LYFVoaGREk2b9AtN?=
 =?us-ascii?Q?ecnyYbC8i+AJ4uyRjmC/FGfp4kD7JBbEOL7gKh/QpkkyCnMaq7eUPmmcO+0u?=
 =?us-ascii?Q?krTxiruG1nZx7bDPHMXBM5ZIm87dbqdg7cozPZTW8/dvzGIzqKYn9r7bzodb?=
 =?us-ascii?Q?In33lG5eAiFqKtxdPwMnUCz5fBDnDYQ1VDi2eaLRam5lmIRKBsGJZTeyRQ+R?=
 =?us-ascii?Q?Bk59LSmoIy5H2KDrapN4XHTgW54rNlrsFirAJONUrbDrqO21376Ph0r1VwG2?=
 =?us-ascii?Q?crOdozL/7tVI89kS3CEzYvsnfAjDqXXHHVQr7Z/5baTAA/owQZk9J1VrHwR+?=
 =?us-ascii?Q?mSnto5Ix3E8y85kXu2AArzLEGldvop6hpauBwViRAStpS79DfGpAl57v3ajF?=
 =?us-ascii?Q?OmNG5rKpZPBEwr+0KqmzwAcljg8uBvsvGLbbPaIjAdvq7Agq8ozuR3Sl8mqz?=
 =?us-ascii?Q?4dc6AlmFKsQhfVEKWOaQM/TYk9ZawT2xENFBI/SWZiLUuMuxqq16q+tAO0a2?=
 =?us-ascii?Q?JpqTkVKE7Xs64mh0sbzxgE8x9vnMkNLr95yVaxqq2ueKladb9NghLHNHskVO?=
 =?us-ascii?Q?Cz9VrZ0OKaWkne+i6ik62iMxb82uPuAkbZwdphdk8fA+cEP7lK7tAVgKKyqv?=
 =?us-ascii?Q?s9D9PXTk/85j2Mgdj0cHkrwjvwKKpOqyxVrxsx9HaqCrhyTkISq7K4HaH37l?=
 =?us-ascii?Q?/Ra1isSo3bd6gq6h5JBy5th0sEDNwlQEBAtZPCqzDCu2Y1ZbSI+hiPGwmG9o?=
 =?us-ascii?Q?uXgUS8HBurQym3EeZ2cwGeV5Nl4ILU7C0rRZzHf75qw/Z0fcr4YbTw0w8IPG?=
 =?us-ascii?Q?tgofSXXs3k1umvEu1vX4tfw6tzUzdoHfeZJH5IVTC2A3KcHdr6s9rnrxqss3?=
 =?us-ascii?Q?pfZHJfbD6+nSl24W6C8yd8Kx/+HQTvTc9/pq2wRvdsG/eI29UrXH5Ig9FQCZ?=
 =?us-ascii?Q?agyyxhyxbJgJLE2zeMfQzPjrPSPY1+BQXg9SbR/7d0C5IBgLmmL/kbM9vwDw?=
 =?us-ascii?Q?ghNXjy9/EAwi76b9+ehiqvMdIOUmjEDLD/ja0Rfyac1JSBU/JVl7wFEajZOw?=
 =?us-ascii?Q?oERJMuRa/CMRxIixGLZ+harD45S0lfgwo+VZD6h7QtM14Luxm68nH1VS3jgA?=
 =?us-ascii?Q?wy/rgzMS3NVgEnO6OJTj+nMulmnU1stTCCpiigkrl7GSDWLol0yuhLg5/uJ0?=
 =?us-ascii?Q?/9vjCeHiQYc0/iBr7atj4TS22bXZ0X1BxnFamfBtrnYBxcBIJUVEb59EvF3S?=
 =?us-ascii?Q?tfEZdfz0J/sFfddqsb0fA/nzxu3UyKHw1alZcFk2Mv2I9gTqt2XbMlBNdPNH?=
 =?us-ascii?Q?znjWD28wChu8Cb/mf+7Sc76Q9l/xDVVOjM+MLSx8HDczwLYVmLsbrk86daZC?=
 =?us-ascii?Q?3I7AZat91PG6Qm+sQ/S8WehaXLCG33DEg/wBhtnYLwimnYtMna3AVPFOtsdu?=
 =?us-ascii?Q?cOWa+30BdhRFRuL6xpPeFFoXbjWwb0smNaSXCzYT2ayRFMW1L+0t3FQEIQLa?=
 =?us-ascii?Q?khzOkIQpq9vGtk13lfm8ckOfrant3gKmdgg7cw9a9M3nixgQbxsPXwLRiWg9?=
 =?us-ascii?Q?TM4ddwHkVcYL8HBgJM2bbD7JNjYFc/hbMrlUm5Xxx5bZZTpf6qNnZQjQuH9v?=
 =?us-ascii?Q?eT3k3DI8xTrW+NMmIJPboVpdSJ0ctNsdi4PAs37YnPcFDDa5PrxS0OyeXvt9?=
 =?us-ascii?Q?CdWwdaEd3kCF56630Tgy/sPWscpnAgzQz2ePgUvPVVrwCIbbe7MFZysWWkee?=
 =?us-ascii?Q?4UTIvndyCAO6+opCyoKtJBTDhijv6ehFEdHbYKHnKCcH3ONhk2nH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dfb033-3f0e-410e-b389-08dec2d35cd9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:23:38.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/kHuoLD55qw4TxWltTyIGZ5QNA3zL3T7ebJ7tcgg7FrdjP/O1xfNTuZpsiwXoQuQoElxCXVEtSebhBA9G0CEYzRMbBTqvzWcaI8FbQ3MDQt9BKEmyHBlTVLisgox9tR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910

From: Wei Fang <wei.fang@nxp.com>

Add .ndo_set_vf_mac() to the enetc v4 driver to configure the MAC
addresses of VFs.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index ad211eefd9d4..4cff2f1237f1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -571,6 +571,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
+	.ndo_set_vf_mac		= enetc_pf_set_vf_mac,
 };
 
 static struct phylink_pcs *
-- 
2.34.1

