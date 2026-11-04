Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784429;
	b=Q+PjOsr7uBcinwpZHbJLycwjOZKZl6rOEeTt4NG7GzBlBZmtVM/liP4n7Nztc8Sx6rY1
	 yzbBRYGnbecGum3Ls3jf5NkwEApFS+9mze15Hg5cr5qTliKm/fkNoN4rr3Br0ZrM0jhd5
	 kMpqCLxwfoUAyaCZ/sNe1b6DAUqqOELAYtzZVPZE+/dS4nnU3sEaXRccsTm7fd0dQND2b
	 9efH9Ar6l8jKkMis2M0VJYRzAYNBNDRF2AQWCQeluF+ySYiHk3V6Sk036Ml4nIySOBMCP
	 hpEP7A4gTSURmPxUB2iGxPIylbR0o4RQ8EKNWleTNEB8y0wV0s7iShVk/pxOZPNtnLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784429;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=uySEQ8Z7qP4/XJ638uqw46XAQIqA3zRu4cPDTqpB2Do=;
	b=DMgxysLVXmfzcl60CJ2HgtagAB9IZPdkrpDJMQzxN6tMSM1baTHDc06GNN2fFSTqRr/x
	 /sapIbp9LggXmFS9ORb6ncJIytKYI288/edHOmdAQXUQ7J3E1b63t5d1cyNHhJTzevxWb
	 0ypshCxDhCmlrCN1HzN0yn6JOKn3xfP53b4nosBYJCep896c00MUK/3RVvGbIc7TL7P1C
	 Jae3Jwat+dMHwAQqoOtxMrWdHBPphja7uBonScsnKrhnzRkmQfQmWIYRFz/TbLrjwZMN7
	 BP/27D9ttD6KPvI1AH0SI+gKG5L9lSlnoUsntp4TW9AOpTtObRzYokcpB/F+kCHjKAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=s77dHWsG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.33
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B6606A338;
	Wed,  4 Nov 2026 09:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 765B6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=s77dHWsG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM6v4m/K0x1xPymIIQNuBHyzgmwJ2EYfag2MWUcW5aXjp37IWfYYhOElKpq2K+poy6hw9Osj+GuLJWpydi+2yTlzpv6DlgGid7+F81w9N3/HKSfqxdiOdau7YBXVFySr7SbafwdvztC46TaiA1VTJqrItfJz7fa2nCP+IEF+Q0+Yr0vEYsuqX/djJr6ZJsk04Okb4coFEq6kTG649pUXbltVLRw8RVnnT/OHE/u81ZC9rlHd6fhOJLyG40ivoo2p5Aden6aZtIW33YFaGzw/Ew9OFeTJacGPGu8lTLKTd/B1N8rT8h0CNWZmq07NkPMgvjt4szKZPY+umQhTIDkOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uySEQ8Z7qP4/XJ638uqw46XAQIqA3zRu4cPDTqpB2Do=;
 b=RAL8DQ4tGs8wfJG1W3DE4Qih8NSSuVoNt+Ukn0+ED+lnqtE165h18r9Wcq9pb1oS6yxO5NvcX5Kn5Ycz2NKXuSatdSURnQW1MAj0gRpiSfxaZv1cgGmIhsX1Yabxk+hDky+GQNqrHNafGUenKT4OHsPi8jAqsavcxLmSxbI2jhWH63OgEltXcgseVpUtW7Ehfd5z8OoelxnGQUjYd5A0sf/t4Jtf5frFAfbz4od+Csx3maxB6qexwAEaVXtqpf0JE7dqU8atZfSCzhGGSNd6YYETfXsgJ/8QciwE3m/+Vc2s1laitrNcP22hYU1NeTXHPKnRLcdl/YmPa4YVLLTeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uySEQ8Z7qP4/XJ638uqw46XAQIqA3zRu4cPDTqpB2Do=;
 b=s77dHWsGdOAW7CsF8TRB3kavS5CLtE9Nq/4gBGek55wxjVufS783GbhOUj4YMlXucQMUm5GzmZzpMXfR9dD7NwV7XGpZRG4rCjr2/aJ0tfRUfiDUZOtkMlAamRPuh2DGdmrSKFbG+USs30O8lTcdWzuW/FaBLASR+MPodrZyF5MD34lAH2rdlVGED2/8RHaGD+yZ2yRvKU0FbdC4cAXg9hxhu/0kWgvvOIb08uIqGXXRtiY0jI9IC/SeeZ5LjQ5rHjoE3DFX/TSUFlBvqNMGHWC+4tD872myUSqOxBnUH5i3Be7PVHSL8R6WJxuRfSnQ1H+uTwFwn1vFVMmsslWZzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from BR2PPF9D47B45B4.eurprd04.prod.outlook.com (2603:10a6:2d0::cd)
 by AS8PR04MB7494.eurprd04.prod.outlook.com (2603:10a6:20b:23f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 09:27:05 +0000
Received: from BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 ([fe80::6e42:6ee4:6b13:69cd]) by BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 ([fe80::6e42:6ee4:6b13:69cd%7]) with mapi id 15.21.0546.021; Wed, 4 Nov 2026
 09:27:05 +0000
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
Subject: [PATCH net-next 3/4] net: enetc: add i.MX952 ENETC support
Date: Wed,  4 Nov 2026 17:22:16 +0800
Message-ID: <20261104092217.1730351-4-xiaoning.wang@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104092217.1730351-1-xiaoning.wang@oss.nxp.com>
References: <20261104092217.1730351-1-xiaoning.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0036.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::18) To BR2PPF9D47B45B4.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a8b7e8ca-c26b-4689-bf7b-08df3a55ca6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|261028144727099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|11063799006|10067099003|56012099006|22082099003|18002099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	2I5CJqrEzA5J2g/3PgzgQT8546CJgZr+7aWY8U1T7lmEDK47eGdEIqFrSvzuizDtI3hqU6Hbh1zE8kHGKgGMieVksq/pY2HiTMVcVsaUscSVVSQdBTBAGb+j+GoiSYi7F9IB2k1SIoRq92SGpdwWWUlfPadm1/55hDcySy/Mt3NjWrUPanqcsehBeSsmvuQCHv8uR+djaN1PnuantFAGUZW8PS+VuINwbptoRXJuTfEWUwmHj5XwgbvfIMO/bGIjOeGcrn9B2FtAf9PScl80sj2UH5W1KJZPl7B8HjaONq9GFB+S/DaLB10m4LoJB8jsS5mCJ7UsKgpM9CYz/9X/oPlBFvA+YD6SKJgOQ1JG2WEy/IAa5WY/Kkzxbe/zA9u0BVtHK2BQbUqxEVvUXvJou8k0zrvkL8QCm2nBY0Oj1oU04q9fjouBbcom5kikmi+DXcS74uTDnjeFrAGFPDnJeghzWkc1JFNsBCDhv8uh1gqsmHZ4VMlVZSmVlgdDc0RNs834lveaDO7JM4BahBnTZul+6gmZe1b83wuR+dWIe1KOJXF13H8HXFjH5zl1D5mkcWasC4B6UQpFhiEg6pRuWZeppqbIsC7PgiBGCb0cHo02Vz+UMT+Ro6M4Kk4g23fx7JlywnnAtY8wIXiLrZj1tKnkis2MFYBlD3HGdW1XR78=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BR2PPF9D47B45B4.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(261028144727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ang5xQSUl2CKOYUnvF/BgigAO+YcxUsD8FI61Lw7C3XtmcMln8vOde5rO02A?=
 =?us-ascii?Q?2+jZJpn5X007K9Iu4srV6MMvoiG39yW9ckUzz3FteS5uhXbMhY0LApUSgfMM?=
 =?us-ascii?Q?8EPWPYRkWLahwlAQJXoJiaZdaYpb+ElJU5vv2uNyzUdHFkc+8xINat6lueSh?=
 =?us-ascii?Q?IKwhF8Uz+1LlnT53PjCB56+KlyDxdxEJqce+G1f9yVKiP/GAxVlsSNmw6mh7?=
 =?us-ascii?Q?80dRo72FI/6vjUoWKqc1JgtBjSo3xR6pF18wLdTB6GY0SHivmbQDaPtb5Kqz?=
 =?us-ascii?Q?T4XQJf6QNO/GIXubeHXMu96sUXPrWqPqGebvT9P1gXFL0iYr6yvdCXNkHDTx?=
 =?us-ascii?Q?xRLM1TEMgUxkj347S8geBaVH7zGZ92t4cZFkz26VrVRqLcHuS0WYW+puF+aK?=
 =?us-ascii?Q?nRk7x1ESl+rirhqljvtClGXReuHHJD24KD/rCiNlseRUQMEEs7uAW6TFuRqA?=
 =?us-ascii?Q?JHcJvihEe0SY86lhuPTEtP5Iit1DBAkEucZxgm1FZtlqK3OxqyCilE+kP7rz?=
 =?us-ascii?Q?3CiLljjJ0DJXbfQz+A6qxtJ9ve61gTY4uR2kk03fATlmZXefG+F9cRws+Tav?=
 =?us-ascii?Q?dWtlpelPPuNNNTePkaiXmCHMMBjI2y0QHi//gOU0pC+V28w3W1KetspsAuWf?=
 =?us-ascii?Q?IwIAwdlbVLF1ga//+iK+Uirai8DvBkiVgZepJiM64P/BljnT4tQanYZiL30a?=
 =?us-ascii?Q?U6gZvZTGZGszTkH/H5eotojuX1w5Yq+uzZtoFJLYfAXJ3n5KSOt/5PADSgCO?=
 =?us-ascii?Q?D2zL1MekkcnhCBJ+UuN88m0WpX014vNaW985oN54PbzNoOwV90TeFdCdtC9K?=
 =?us-ascii?Q?sXmVqRJkA50HcuGR1DcoWsE78IeMjatIB53IZ4YuS74Zrjsju4YdWzAraSdo?=
 =?us-ascii?Q?kS+EgyCKc9YixP2OKso9TuD/S+DldGetzMvaXB4EmxoeLJ/JT1vdRifOZe/Z?=
 =?us-ascii?Q?Vj+Blr9nllv1rtzW0FRKx/5RA9qA0kHi88HYIMARfw1LDgayMYSN7MwdqbXh?=
 =?us-ascii?Q?eIIkMau7I4nX/WEy+2GjikJopSODd8JGWj37sNP+EonIrYrLTr5bfjpR4FsS?=
 =?us-ascii?Q?VvuGmpFwYKhK4adEiblUcILPSireY+3FaPqT6bYtI30mDgobbpCMJo1UiR6r?=
 =?us-ascii?Q?Qo0Hhw0YmufzQm3znSyAmUkyHQk52EUZwMiTYRyc/IcrWd+pZG/n/UesIXit?=
 =?us-ascii?Q?qE6INDfX3lI0tb1fyQnovwtxR0bFxm/VzLAW9dDuXHx+5P7Lyz7y7H2jSH7d?=
 =?us-ascii?Q?AOAls+5NHPnXk6guRA+MpyKcX9qyzqn2tbQJDkihx1yhFbRM2LC8o92WYA/x?=
 =?us-ascii?Q?+BXDLkZ8knGjW70m0WRo9M+vpXZjbfYjvb8vXIQ05Ji+KiAEspoYoPH9kNb8?=
 =?us-ascii?Q?dO7iO370LpCjUjUSutlEv2CbVDg26hpoG1BMyQN8JdqDRUy1D1CsCW+zTfon?=
 =?us-ascii?Q?+9oY3afJ/RmhbUY6wJAqaj+TWA5CVWHf0zBa6J/u/+XSkWqEozqKltyqnRN+?=
 =?us-ascii?Q?Ppn2XF4dxeqomd1gKXoYZ3Oci62F7etcECpjHQFVJ0iDW9ML6YSr+1Ya8ppn?=
 =?us-ascii?Q?4AId/keG9h+Om7YDBRG44IYvldMXSBvDtmvIm+3E7VFIcWjFs2JAhGvuBAeS?=
 =?us-ascii?Q?GY3havuY2DSvNyRQfoWaPcqphsuptlVQUMoRzr8QCN74VG9ZF+TBCC/uW/en?=
 =?us-ascii?Q?oJ0/cN/e+9Saw4SHIfALbmbAGDp/+Xiqj7vm9s2bLSPj8FLscwJ1wmD6bqvs?=
 =?us-ascii?Q?h+R+/3gTABPCw4NoD1Op//bOymfQclwPZyszlUOkGdBN91fbrG4mrhDvO09c?=
X-MS-Exchange-AntiSpam-MessageData-1: 2X+9yAKwjDv7fQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b7e8ca-c26b-4689-bf7b-08df3a55ca6a
X-MS-Exchange-CrossTenant-AuthSource: BR2PPF9D47B45B4.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:27:05.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1TbZ3DbppPhvb50DMakrVrQJHSkBaVXeQKJ7LTgs+Ot4U+PJCOAYpvFwg0IxAvjttvbMka+NygV/A0S0HH3z18/+jNZPeqiVQETrUAjblOZAVdotbd5kiJFtvxU+xHs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7494

From: Clark Wang <xiaoning.wang@nxp.com>

The driver gets the driver data of ENETC based on the IP revision, so
the ENETC PF and VF fail to probe on i.MX952 because its revision(v4.6)
is not present in enetc_info.
Add the v4.6 entries to enetc_info.

Unlike i.MX95 and i.MX94, the NETC system clock of i.MX952 is 133MHz
rather than 333MHz. So add the new PF and VF driver data with
ENETC_CLK_133M for ENETC v4.6.

In addition, similar to i.MX94, the PTP timer is function 1 of device
0 on the PCIe bus of ENETC 0, so update enetc_get_phc_index_by_pdev()
to support getting the PHC index for ENETC v4.6.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 23 +++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  1 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c6571b5cc842..4ef387578b1e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3812,6 +3812,14 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
+static const struct enetc_drvdata enetc4_6_pf_data = {
+	.sysclk_freq = ENETC_CLK_133M,
+	.tx_csum = true,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
+	.pmac_offset = ENETC4_PMAC_OFFSET,
+	.eth_ops = &enetc4_pf_ethtool_ops,
+};
+
 static const struct enetc_drvdata enetc4_ppm_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.tx_csum = true,
@@ -3832,6 +3840,13 @@ static const struct enetc_drvdata enetc4_vf_data = {
 	.eth_ops = &enetc_vf_ethtool_ops,
 };
 
+static const struct enetc_drvdata enetc4_6_vf_data = {
+	.sysclk_freq = ENETC_CLK_133M,
+	.tx_csum = true,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
+	.eth_ops = &enetc_vf_ethtool_ops,
+};
+
 static const struct enetc_platform_info enetc_info[] = {
 	{ .revision = ENETC_REV_1_0,
 	  .dev_id = ENETC_DEV_ID_PF,
@@ -3862,6 +3877,14 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = NXP_ENETC_VF_DEV_ID,
 	  .data = &enetc4_vf_data,
 	},
+	{ .revision = ENETC_REV_4_6,
+	  .dev_id = NXP_ENETC_PF_DEV_ID,
+	  .data = &enetc4_6_pf_data,
+	},
+	{ .revision = ENETC_REV_4_6,
+	  .dev_id = NXP_ENETC_VF_DEV_ID,
+	  .data = &enetc4_6_vf_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 7965dfd06f5f..3c6c6fc0ab8c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -1149,6 +1149,7 @@ static int enetc_get_phc_index_by_pdev(struct enetc_si *si)
 		devfn = PCI_DEVFN(24, 0);
 		break;
 	case ENETC_REV_4_3:
+	case ENETC_REV_4_6:
 		devfn = PCI_DEVFN(0, 1);
 		break;
 	default:
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 2c9d9042eb0b..339691cdf44f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -414,6 +414,7 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_REV_1_0		0x0100
 #define ENETC_REV_4_1		0X0401
 #define ENETC_REV_4_3		0x0403
+#define ENETC_REV_4_6		0x0406
 
 #define ENETC_G_EIPBRR1		0x0bfc
 #define ENETC_G_EPFBLPR(n)	(0xd00 + 4 * (n))
@@ -1050,6 +1051,7 @@ struct enetc_cbd {
 
 #define ENETC_CLK_400M		400000000ULL
 #define ENETC_CLK_333M		333000000ULL
+#define ENETC_CLK_133M		133000000ULL
 
 static inline u32 enetc_cycles_to_usecs(u32 cycles, u64 clk_freq)
 {
-- 
2.43.0

