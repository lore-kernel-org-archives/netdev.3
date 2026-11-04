Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784405;
	b=Gd0esbv/o1StbueNSd/fWh0NWuZuvvllyFf14SW9Kl6n85NJbGRB7AJcnSkN2YLOdJTf
	 OV8pGORhlv2d7GI1v3jtya6s7aQ607oZOPwHEQZ+TE+vnXtAUsk4xBnkLdJdmKANqdL+w
	 XrR408yhwehWKTou+VXzHyxotNKd1/eiy1Desz6jDZsoHcj9QyuvDWhbfDKi3yEFZUkmd
	 2lfE8S4/ry+4pvruQqxe7kDyDrdJIzckLO/LOcdgdt1US5U3MjMD8/iNEadbMMBki5Wbs
	 3wgeMUzwjU4obd3iipIvMyTWihTGQxtqox0IyosGG0HRZQ4OS9pOHke6z4gXdMpnnBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784405;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=luo2vR3FK6z7nOyeke0OmbmgHdSPLDb8Km5jsMeUmpY=;
	b=2CuRU2wV6nYXQSpmS8BHSAA5rUkvKZqOKOWH2+u9jtzFijf0mllFNt9UIWVAG/ngi+ke
	 4yh7bL/glL6I+zbgTNQgSCISQKxmguI3cswAanqywoOps384j3Z96mX1ggTRrtiz484l9
	 BlUgkq4KPjWxcInb1ELYg8+gCqpjqpar286Tq4COrA+cxkjL4oE59AFperaT7NLaxlffR
	 wIxdVkafUPmckWGugTai6GaPeMLEfD9YMLoJR0F8Jn4bgi5FyWoBj/Ah3vE6RHGROUJaB
	 hDzF7dlKGmXC3QHbW0cvKkTQWS+rrr84f82TkqvMkWq+rWRblOjztWcv91dTKA4T/Aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=O1beGY8+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.13
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D77606A31B;
	Wed,  4 Nov 2026 09:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D77606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=O1beGY8+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weu1p9JjeF1xVQNx8EEo0tW5FobXw0gSRv3DaQXn52FB/eqGC5YfZAeFJxky2zwZM5QWZ1vbNXPl8Pq+I8P//oXLYbdi3VihukDUuWTwAKehwZhDVdOdjkvKzrZgv3AI6mAwFqDj7pqqvsGbq0fD63nxiDeCntHVUzUD8GM1RrCM8eF0KbjjMCbkZBZIr9QYKHYnoC830qUv8IJhrQroyTDfyDT+yjEhVHe0QIXITjsQse/0gBJtrICJVw1/0Hi/S3f4hOGsymPhihvOJkIEbs8phZYsBkJJz3mK1UqeZYg1p760EgNPuj9oYq0YPs4gW1zVtoLcUQtmuwaB576U7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luo2vR3FK6z7nOyeke0OmbmgHdSPLDb8Km5jsMeUmpY=;
 b=plzO5yYEFIQ81Mw69tT3YHfpEic7ac6a4Y+PYXyukf27JVWcU2kaDteEK+P9cksG+URPDR3CbTjVolq8bsGC9mirEGZbqBPFFzYqH+i7b39lHIprsOURmEeW+xREP3O5MI4VJbakkOTn8jJT3z0XMMqC4F6luhckrcVIxpKd39usQDlVB8wAbcKT+dCiq6qeXYsMjZ6dPmEcTGAJmlzLaKLzPF/Uhz8vpddaUmVSZuYL/5U/JFWQn/QLA8FQ9Jt0okdZUzT+87ASsIUHklAb0VjPWqkw4J7SmmsTgT8KbT6l4DUDN+x8qqd6iP2hjdU4geWyQsA0rJsQF/vxfMtsJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luo2vR3FK6z7nOyeke0OmbmgHdSPLDb8Km5jsMeUmpY=;
 b=O1beGY8+aqpVcssYOanPZuMbIr5o+W8eQlVJcWJChdSVwUCQIKvT9tQj3LXP2YFrP1D2MwwE9g1I54uxBevRYsf6GNoN44QqAod4PGExCM2xKqkXsge/PSyBvdPzG5SrXzsWIgvsAB5bGRZi00L/2RwzCqFxtxJ4TDGw9SR2e1iALiZvb1y2FWrZF4ILJiBbDGH/cMDU32ASXhny5zBDJ8ozefCBzem3HRmT3ENcOcVSuomMwSlyNcjGTgOijyMYHYPcRRbyKjphOo3RReQXLKjr+cMd0wuI15xISuB1DzuRq/3FS40xBorDlpagG5/MkAE37wNtv/dzaSKv120Q1A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from BR2PPF9D47B45B4.eurprd04.prod.outlook.com (2603:10a6:2d0::cd)
 by AS8PR04MB7494.eurprd04.prod.outlook.com (2603:10a6:20b:23f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 09:26:41 +0000
Received: from BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 ([fe80::6e42:6ee4:6b13:69cd]) by BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 ([fe80::6e42:6ee4:6b13:69cd%7]) with mapi id 15.21.0546.021; Wed, 4 Nov 2026
 09:26:41 +0000
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
Subject: [PATCH net-next 0/4] net: enetc: add i.MX952 NETC v4.6 support
Date: Wed,  4 Nov 2026 17:22:13 +0800
Message-ID: <20261104092217.1730351-1-xiaoning.wang@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0124.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::8) To BR2PPF9D47B45B4.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 9673c050-85db-4772-1604-08df3a55bc68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|261021121427099003|261022113327099003|261021123027099003|261009223027099003|11063799006|10067099003|56012099006|18002099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	G5Q67+Vd6Ildhub+e7CxF8g0NaREEyL9e1xq3EDiicwniaPN8f2OzQlpvp9AoEJH+yQtHd1+sH6OdMVHtUvAFtMy+sFTBGmjKuQBLBm3u8QdnQsuBb8IFpEybMrenwCOLwWUBFQAPyhSCL63HS01AkIAa5Nv/6xEcDgRcIg2QUtI98QqBBls61nehq9y2y/zP1MtsB9XcGD3mTb67Qhxy86pbXrTXbA8l85ONkM9M5m/YPVv9xTqcBWIGeAJy5KZ/gAKxslsAkhyirzXL5Ee3NBdQT0OEdOv33SpWhTDREQ2IfCG6y0jxm5jOq32FBcvHPeappIoU72L8Hae3wsZ/73OdJycFa+MWT8r/h7zt+hnAKTvfXPxWiq5ayK26Gzs9LpzOHf1L7MBafI0aiX4rMD/MdkU07yO96p/HNo+BESDm+1z+RpRB5a0pbFyW02zNCFyiV0oyYAFmgSWnAHHYqUutHEvdFeIREm8B3NrMUOKIJ5Phxc/V4u9DN1pjeWY1uj6XxvG3SWPYhcYijy4Vw6dvaP2HN8CClLysariUjn37Y/bru4RPWfxBupz3q3bDsTqAS1yEi3gwG5vDqOuilnz4FBMH8gQRKMy7yWO/E6TFahvi6+V6b118f2hz70YjkYxaqp1q6TQ6/dq27QKoh4YV8RFo+cc5+utHhNjWn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BR2PPF9D47B45B4.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(261021121427099003)(261022113327099003)(261021123027099003)(261009223027099003)(11063799006)(10067099003)(56012099006)(18002099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zwZYm7ola12/EesEZegVZvBYnF0V33ujn6t8+P92cd/34i9iDWiHgbwrUPN7?=
 =?us-ascii?Q?xCxljMGWcL2UTjQlmYxi9by5P8jsL8FXVEbJ0w/nveiUBNlqTVbGjANYmrwv?=
 =?us-ascii?Q?KQh3/LJJQERm+F89RV4BQA3ssiRngljP/8XxT7Nn5V9LCs0C7nIEa27j5x/m?=
 =?us-ascii?Q?mfEwMYfTqOGny9JkVvYC4UnQEwKjXZxm9l773DdoFBuG/VBAqKaJeCMfUQB8?=
 =?us-ascii?Q?9jOahBIivkOKg++U6GjuGVdq9YhCUwA8tOrJNwc+rQ/nc0hZiKCZXk/YbrQh?=
 =?us-ascii?Q?PYY9UZy0qM7GTJXrpycr8r6F7iJ8WY/7WaW9fqIeV3IZclK81C6nixrRrYeM?=
 =?us-ascii?Q?3l99ekxZMFalpYb6/0+6aMsxX4pHimZ/lwHd/nDANB1iaexpujqCMi9O1kJ2?=
 =?us-ascii?Q?3C1TVn8Zy0TBlQHQzFed2IOOt5PhUtQsVDuH1gH5+EQGX384lNSBOtx5TE56?=
 =?us-ascii?Q?3lyM4i6wkOa5bvmDG6K5y4JDNYNCwgbQUQuJu/Q1rNTm1dHQMO+xL1de7ZyY?=
 =?us-ascii?Q?CwFuGUPcx+j71D70Ghq0OX93VBcHQJiQFFyBU6+ZeUCbJtmEp+8Q8bg/IN8t?=
 =?us-ascii?Q?eUDhmwOrlzjrBQcb+jUyiNIFRw/NXtRtO8M/v8SZVfKTJOSjE+VfR6nvvcOM?=
 =?us-ascii?Q?KbuFCCKGOupwQ0ACWjKj2jmbEYV5tQkMuetK6lws9X0FS1j70uiejIAGhwHg?=
 =?us-ascii?Q?wOQBQVR4oveOdPnbuOMb19o18keNHGFtudXejVoShnLK92SAWM/oAJlEd0UZ?=
 =?us-ascii?Q?em6x0XUa2dxfO0hozLAsDk6A5p+6QtKvxdHXsPKHZIcXml2CvVmZd9FTxJkM?=
 =?us-ascii?Q?V4Bal6TzbueaSh9uo57BHi+D3/f9xWfuR/qTG1A/yrKzxYL+3xD/lCp2f0M2?=
 =?us-ascii?Q?+m8VfOUhqrNTx3s6dJSx9Q1Wq1LiK7QBhVtdT+U+szCHxFDY+sP1UbA+8cFZ?=
 =?us-ascii?Q?yJ6wTW1+3OUJ2a7zJjrDiFziCf8Z7Ga5BwB3tDsWFUVZ/Zd/cDxUFJOBkBoH?=
 =?us-ascii?Q?eAw+AnR5twXP9q3T5Vys7m9Hk755ISMRmw85mY9jjee2+YnqYZM0UTGvsWV4?=
 =?us-ascii?Q?gLd3OcXmXClroXXIjxaWOAe+cfupSSEeRueJ69TkcMChpm3mswe4M7ECNkYO?=
 =?us-ascii?Q?kqrAaEoNhxk9t3IXIu8XGSCgqO7FfIC+++AzfrLe0eIINor4VQe+t9vOoIaG?=
 =?us-ascii?Q?uaPIKL5YzyoLpuyKrOGZCNg2Lf+C74pdvBa1eTwRtNcUL4dkUeJr9kA7WJfw?=
 =?us-ascii?Q?3GPuNuDPhLSTv3spL+FiQt25N1igZiMv2Jhz83vpW6cDMH8lASgCkaY8Nyaq?=
 =?us-ascii?Q?VFrFYGfdLNYzpdcH/7l8Uk47s3s9X8pTNncJGIU5IHSfmisAokltk37DiMDc?=
 =?us-ascii?Q?U/XcF3AMVyCdHs6pVibHloWUo3ecGpOPBpUKaxSvepyCYIXCfCxYcTRg/8RG?=
 =?us-ascii?Q?56q6OVV1onu2t0hweqnFf0avO/MZB37Jhwci6zDQgE6YcmD63I21ZNSTVPYh?=
 =?us-ascii?Q?Hvn0LwdPMRJFpYepckMI+M2xf/q3jWjKQFSesYlbRQdxhu9oODghLwHTS+4z?=
 =?us-ascii?Q?qSnSwk9iPAN8ejmGQREq2GbTMau8AoosmwxVYJuKLXtjkIixjJvPzCg2XV0g?=
 =?us-ascii?Q?BITdb/BkLBHC7e5kVFMOeCoT8d6t5oz7XLqKZ2AB7N4Zu6AxDCHIGfQ6gKi/?=
 =?us-ascii?Q?XM0ovkzUKl54cEvLQUf8DlVAIBDDkhYxJSH+lQHBj7d8waxEspHgB/mddm5O?=
 =?us-ascii?Q?XJO6YL72upK5pO7iwCN0Hz/wvnEgqTBnuMg57Z41spwNaWl8bSfkegXbQaxB?=
X-MS-Exchange-AntiSpam-MessageData-1: 2xeTXcX8yzBIxA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9673c050-85db-4772-1604-08df3a55bc68
X-MS-Exchange-CrossTenant-AuthSource: BR2PPF9D47B45B4.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:26:41.8782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCQHRWkDJDnA33P0RmuN7o9Yd5TjVrT9S0B4nj+rESamPtuO9g75pNJxMKu6492iFI7V+4IzIusH1mN4SEvDPngCl4SnmNv2wWZAjVU7JJL4QjZ4NKybnP7mFDk3PQxO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7494

From: Clark Wang <xiaoning.wang@nxp.com>

This series adds Ethernet support for the NXP i.MX952, whose NETC is
revision 4.6. Its NETC integration differs from i.MX95 and i.MX94 in
the following ways:
 - there are two standalone ENETCs and no switch: ENETC 0 on PCIe bus 0
   (RMII/RGMII) and ENETC 1 on PCIe bus 1 (RMII/RGMII/SGMII), plus a
   single IEEE 1588 timer;
 - the NETC system clock is 133 MHz instead of 333 MHz;
 - the reset value of the ENETC 0 Tx byte credit registers is too small
   for jumbo frames.

The DTS patch set will be sent separately after this series is applied.

Clark Wang (4):
  dt-bindings: net: netc-blk-ctrl: add compatible string for i.MX952
    platforms
  net: enetc: add i.MX952 NETC blocks control support
  net: enetc: add i.MX952 ENETC support
  ptp: netc: use 133MHz as the default reference clock rate for i.MX952

 .../bindings/net/nxp,netc-blk-ctrl.yaml       |  1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 23 ++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  1 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  2 +
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 76 +++++++++++++++++++
 drivers/ptp/ptp_netc.c                        |  7 +-
 6 files changed, 109 insertions(+), 1 deletion(-)

-- 
2.43.0

