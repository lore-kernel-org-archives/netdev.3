Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5D3B0AE3;
	Mon, 31 Aug 2026 03:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146585; cv=fail; b=i73phfnB57e7MDQZp7MjnpqqSjmUYzckN/sFLY4384lfxFOBd/w2l9W0A9HOGJ7ZRw5CZMYChzXS7cPX/rh4dTtkx4RTf3jDuMKQ9gf8KOS6DbKoBNK0a7HhWyNPsD6c12H9BtK7dKa0KQg1DYA7CDmWmgB3zhAy5oHww7rhCnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146585; c=relaxed/simple;
	bh=FvoNA5zxY9x6KUnK0N0ZopA8lyDBs8eTZVcANUS6O5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=teNlxEK1N3FuUNYLZOIaYcqphOIY+HpaycunqSS086pn43ZPnYQRrR6xMHm0ZPsCkJvS7iV5RUNNHi4aTB3AHFEoVeYSpOYFM84vtOojbFhhmnRxoHLA4QenXGZ9BaPEUjnlCWUZGiFHxg9GQTF6OoPeHgoUfakQGf0J9IO5PyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bTtiFDgw; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bTtiFDgw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaSyph10Q7F1q2k2/kLpO/IRXX3thqQfsGMvjbVTH1YgmoJzwB7A2kYA0v1cep2obQRCt3N4RnNwO42fBjcYvL+1nj9Zte+vJfB9Q9tjP5L0tkOUXlR6JwK7bzqzAD2rcjjoSbb72/ohThDIc+ftBMISICQbHQUWyNiSl0A31DRVznYWhSHqDbXkWoCqaSGB+JcDJMBRFq5fgJMRmZu7xTbaha7kFSFi4zxo7ytZvR7sXQD0ISeAsUqMVjAhcWh+QeWv4LQnkWZc+1R3rQh7hzZW2GjTtESM0N2NpME4sRN/dfbc2dGkGkKuHs3yaI5Q4y2FKRuqsOSdWI0hdOIPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGkEIe6LsFWgM1FLv0uWC6VvqkUyCNT8OzIdO5IFlL4=;
 b=mfacBKd4IvygLEwYWkZegu2dF3hQW3mMu0tZu3T05wrzfPiJ2QI8tRe3uFO4+RZA0ZzJQNPeVHILiLoBWF69C/65B4aXm0GZ94fz/GuoOTPiOt4JOQoHz6suf7JMRd8TZzPBCkaJ+eC8PX7zKgiUZmKMbmseZ9RwCtRUEKoGRtl7lWjFn954be8wMmS9bLevgjbclvXX9zNztZPtQw0+RrUW7c6ULis5jl38T+DzvcGRPrm/KFJWOxUvEOzFZEuoYJTZk+S9X6DD5DUQlFjdnqYmX0+5TE9ivF4nNxXmjEacU3x1RnXoIlrGM9LFu5pi479ePFyZQCcPkFldTqwNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGkEIe6LsFWgM1FLv0uWC6VvqkUyCNT8OzIdO5IFlL4=;
 b=bTtiFDgwinnc2Iupv//giWYZTm7Eu+nCuP3jIcMhCw1QpO2SBk4RFuCZcm5ux5oODd2YG99hRrM6gfed0I9yAMhM6QrbkLdgljw2yJHCCphTlR1Pq8aF3ELasvLaJL8N6/zapyC+8mom8qMZoUTjsNv381cVZYe2vdzw4A8yKzCO7v3G05UvX/S0tL0mcZ3M/LwjbXAj+x+cjxp/1a2oIdNjZQB8HRaIJHYikoEohuTiXEnR3enwmlkyLrW+jNT7zTSUJijjFgfdx6xZdn3TGrw+KNlB5hXZUnw80i/w7OEf/N9RU698xwDYMPf2qN18Ku4fwCWfh7Xj/oUFKvvFAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:23:01 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:23:00 +0000
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
Subject: [PATCH v3 net-next 07/15] net: enetc: add .ndo_set_vf_mac() to the enetc v4 driver
Date: Mon, 31 Aug 2026 10:54:33 +0800
Message-Id: <20260831025441.635045-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: c90964e4-8d39-4d7c-45b5-08df070f293b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|7416014|376014|10067099003|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	yssGNCio/Ikb+j8dQZ4UVRhGIj1APdOJ+bM5qbeCTzCEtAn7HC6I7bb+Kexg/WV1TR0EzxnOdESI/XZ/jvNvOjT5nU5yJ8M06haR9L7VcmdacZZGxb3If9bSKuJ5REbmuHmBopFSUM6pNBQ89Kqf3W36tjEajfX+9zeJfTPkKpBr80/TM4UrkLn6kRwi/IHWHI/ttSmSr71N9rI2JxHPNQh+IcjDkA/gT3ADOSHTfkTiV6z8mN2F4/iessAdEtAFIasUzBemE1qpjK96NGmt8nwwbwdH8CLptN7bvlK9Ay4wwIBl3C/ker8FBQIjSuaVnoEeJLfS1jPpPIUA7Gh/s/6ppKRPD0Bj67mCHJbP+ckdWMvC1M8r4Hswjp2TDokOUTCC/frDUJYEgfNmWtLWuNc53//2SZ+ocZZpQ3doQkTtzspmKzddynKiCJcPhrGCyo+G2IOUWke6ugJH4TgndQnnR0ORfbgYhQjj0IKLg93kAs4LSHe/gXNNVLMaJ6i0lZZwXZ1E0xP6mUPHqhY0BnpH3/GNs4Cfn9Um+szNgMy2LmZKw+GK8ihYwV68bGGwlnn462lXYMoSr6/aHEW6q7ndwHwhLe4zV6ilT52V2yuC0pfJnEVkVdffTy1fGxwx7yDD2YlHbf67plstNY98U4gXQ1kRMGgeCXl0MI4lMKXYHdTlLwgOqjEG3hdX32fLcKV7yV0QOpPjone+z5E8bQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(7416014)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QlnPzIPk3iYO4poXcsZ4WFzLns3PqEgsmvHlmcitv9wV4emms2Nllw8EhteZ?=
 =?us-ascii?Q?QRBPsgkrYeWqonlwXIMtCwUqQYt6vDCjY9FKh0XDLOngNGjF9gPPuJmvQBSe?=
 =?us-ascii?Q?ZkLVY5aRcHLy9bXVrNnTqpACsdaM1Lc8unJmKfkANeEOlJGLwCSAPQqjq7jW?=
 =?us-ascii?Q?U4DD2UjF/VMj6rryq9yBG/GaIS6J+FdHqs0aUzecDUbnBpE7vKhKrFoAth4m?=
 =?us-ascii?Q?8UyW2Q4pD6q9tuBkQSm2Y8tXaesc3NzT82F1+SSFXX4nuW7TVYjkyBhzQWzm?=
 =?us-ascii?Q?iJXl7Oequ28SDJJBf4hkhCrvYeYbPWWHqpiFFDn343oY9bVqnFUZk4W2C8Ki?=
 =?us-ascii?Q?+OuDd8gWHJKieKJ4tS/rHDanPwReOscW43jGxclhMPjQK4UvfGQreBZsvDFV?=
 =?us-ascii?Q?zCv8xz6mJVeLi9I/LSH2hWFvYfdwh2f9Ju89y81RUa5olXzEC4REON05+6/w?=
 =?us-ascii?Q?13K+fpTFaJ0AZcqjySva0qGv13m7SiT3uRCQbAHqF1hGhPsSBMVHQ71T2B1U?=
 =?us-ascii?Q?jdRjNul2oywGF31NlT5ceVBvrKM1oBb3uACgh9MSN2bI+Yt8I/Uoe2tbu2wc?=
 =?us-ascii?Q?5I/c7bBhdEheb+nJ2+Gf5kIr+eBbA5pcb4+3hDv4o4/uyuas7+X+4WLhxZ6a?=
 =?us-ascii?Q?zAKG35VROEYUFutIIEoe6rPncZIGO00fpUteoduIikUuSGIugC2HiaMkt9RB?=
 =?us-ascii?Q?cE0LUQborl8FrUopXli1ENKbdayDa/Q58bXtx0mSeLcRd/nUACkv2JRZyuPH?=
 =?us-ascii?Q?ybkeJWRKhhRVC9iXmMbIatAguiSj9e97Ble0jkCOAiqCvRSbRY4b4vAsDriK?=
 =?us-ascii?Q?dF3fllsSusKNiL9C3KkeR/zT3VAP6jH0GfVgzOvl1mjo1nMoszMwKuzzraDH?=
 =?us-ascii?Q?69ivEurFLPi+4tfaad6K3iOLIb8YpO7dgUYy9No4xS0DO2qN6/Jo+uHvv7p6?=
 =?us-ascii?Q?3e3bNPYMykop4D8EOVrEwQb63pGcRZAOQhQFljhlUpXEexealmZWf2jZvptn?=
 =?us-ascii?Q?Jne+zG67OOsGon3jrr+utgqHCYmaHQRGdnKlBrh6vUsYP/1eiwgheacl3Ypx?=
 =?us-ascii?Q?rLC/s2FcuR6lYGG+IH+qKux3ebB1nB9VYW/c1ymZ1GE4x0tQNoQfctp/CMqg?=
 =?us-ascii?Q?sp8+6ebeCO/h6x7gbpPZNopPfqGfgJUFO/VosFDFdLlCgBkVAOhvkWOfj5vz?=
 =?us-ascii?Q?4y+YeW1vepvRVLG8NqIUL8nEF/MWMVM9eXnVFUwW6dHlm5nIDpiiDEuEfALZ?=
 =?us-ascii?Q?Kbnfjr1NLRDsrqZq/h8M9EIV7/gJ6Tw3pIvIkU+lRxMUFzkoXl3AjUC4T/ul?=
 =?us-ascii?Q?mtHgTIr7hvLKYIN0t1ppa/pfmtWSMCiyCgvy8/ojcqxXSiU5JJnUrm3S4em6?=
 =?us-ascii?Q?4o8ewZrnmChK71IbXKbcD+egBHLIUgjvhkv5WQf5D6l2RexA6WjtFNMqv6l5?=
 =?us-ascii?Q?Vn/nTin0iLSYrqFwxei3ZnpzrrF5K12548tcdhFE67IUKmf0znbz1qkn+jZK?=
 =?us-ascii?Q?QNiKyOJhPxAjWsL0XuUxivyxOaaGpRsTHdm8ZPsc8StmLwsecutD7RCdhQh0?=
 =?us-ascii?Q?5jqg1IG/WsfEGhKQwTOuaWdSsd7oTAunJfWPM5EFSzxqqwl30HEAmdynpUPc?=
 =?us-ascii?Q?yUgKzwDPls0wnBwxHE0RWKEb/M/nZN4q2PVrk/fxxv7VOYJkIiGTxtcWsojb?=
 =?us-ascii?Q?PGrYjztOTHkH0iPdEXRhDJyJxKcmOQe0Wq5nIRxvjuwAqOU3iL0TeH0cJi4w?=
 =?us-ascii?Q?C9enGwmE/vqSpd5aFcG1NNnKWEzLjI7GrsNoiiAZ1WvtjVac0svo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90964e4-8d39-4d7c-45b5-08df070f293b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:23:00.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZxiQl38KLYWZHP8C5AUXKn/V2EBfHZyOkirQDmLU+HIP6OgV80EACwz/1QPxe56GmKa8nfWMGfjtIv5ZKkD288Ho/KduwFantO0VOFUzC+MQd3kyajv5rEIDN269oQQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

From: Wei Fang <wei.fang@nxp.com>

Add .ndo_set_vf_mac() to the enetc v4 driver to configure the MAC
addresses of VFs.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 17fd9ee27942..eeb70feeb773 100644
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

