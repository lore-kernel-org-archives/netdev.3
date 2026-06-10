Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2092.outbound.protection.partner.outlook.cn [139.219.146.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E151DED5C;
	Wed, 10 Jun 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081925; cv=fail; b=QN/lR7A6XqzleA39FwDeco7Q3TuTE9DUvrV8GDeevBu4+Afg+m2lsE0nx9aY4tP5ZQEPD15q58oJOtK65vUPStiI0P1LfBsNIXG0+heRJoNfkzb36sSS8LNICOQ93Xem1UuY0wo/PtwtC0Rc7GhJYDuDXHCwQutRzKLLs0c2Uyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081925; c=relaxed/simple;
	bh=uuS7Z/OnUaRx0ipCk38rwokwFZ3uGRaRUep5wA+qHZM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ID2DeD3u0z323viQ5LeHTPaVnsF35vY5aCqlM1seE8xnxyo7FBqHRCVa1ISykX/b5vzbeCHTU4RHUTbCOuOAF9QckGOiSH8YS8lki1vGUqlzKXx1SLN7kAbqVN/BLRUWjIn/6IVLLfO3RckKFA5G6feR5vFoaiz/QArHYUtW7q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7nK+rbJ/LnyavzDqDAOHyLcukRYImY5j5vkd7BxtJAgrjuW6zqWVOWRTQD7VRBcM7xfoKV5WKDeHNUs9+/GzDnDKd36x53GlLCyxN3wWDnbdJ0EoSwdluiRdSrpsDcdMn1C1APz8uY3MJcQR45zhNXAIAxXiiStKEFgTWnqhH/9ui7LneRaK8PqxaK8ZQUMsS/mx5T7rO0XD8GwAIPvW+ezDzcQ+SgGGa/9uTWFQh7qnrY28H4tbnglc1iBDMhonr5ycA4Xuw170kyOVKuZexID3EdjrbJWyU+L4QkRG5o9OD/xIeuX21pe72O6iYhx+OQIYTP3BD6RxDG0CHIcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuKI66Tywao39mljkuv1jh7fhZWDa9HYGp0/kLCikAs=;
 b=C5lqorg47/ZRAcQils/pflOVG61ZcjFHpR7FTkEkPquUlfFoecRoCFNWwzDrBTh0z7NSuVbuUSo1RwgGz43gvy+ASfYw/PD8Dch+QE4LWFGxrqQKeecZFZdDgs6QjeR8GQBTP5n9D7N2BTS0dgsgQQiYLKqwyzgM7cBPXZXnvhMihayzsEstF9bf7ZldN9R0Lo4EDvR6H7FFB9edfq2dAYpuioUkFZ+GzGHfKxMiu/Vw9OZ/PMAYYmg+cZIJw3Rctg79nzJavf8Ex4u1vKd9piJ1WV17AWNt1yqqd2YN1b6/eB/aLexnVbGWZwuGcr4RmWl33JiAVfoYfVY5D7vKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0512.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 07:24:29 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.21.0092.014; Wed, 10 Jun 2026 07:24:28 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 0/6] Add synopsys designware GMAC NCSI support
Date: Wed, 10 Jun 2026 15:24:14 +0800
Message-Id: <20260610072420.64699-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0512:EE_
X-MS-Office365-Filtering-Correlation-Id: a46c2ebf-a157-4dfd-7be4-08dec6c14edb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|52116014|18002099003|38350700014|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
 PktLCY6AbJIXcFluilk720P2jYYrqplSecRdRqkN3+3P56mou8sH3ueTEkcGJEvW3MbPbhj7SErJa3ruxf/rIHEDSmBucXSItlpxTeTDgcIBKdBKyQmG4lqFYEEEBucUKNnjUZRVXy8/ENlG214dvZIGNw5Y/5o480QFl5wM4MdvXFbvAOc3q+5cxOOf28ICrF0mYX7kohoWIP/qyfXlMyNoAThimQgpEnoeEY6blK7UD8oeAQY6yH4usn1NpD4V9qqtvFmKyAcsu24COceOGtBCa6c6TWMnaAcGvQJBLfpsF0uexy2/2fkZ7GjCgbbEXqm5gR3jbUK41mBxxkG2IlkNwpeA3SNpl8RcFbYoh1s/HNeeNyl1FgsinAx4bou70M+ZRcIBTBkgP6uOKOeCO2+9kqOUf0+MuOPcS6yqizyQ7HVCfYl6SQmpodm3yrT/v/iRztTUUpJgO+nWgCOUT3CBf6JgVVX0jHa66IqDKYRf3UkX7JXqjK7SCMaqc5T8r0lS1jWCJKPUT1jvtsFnZAcf5YqAfCcfahcAAHLIOCmLo2yGLl3Kmuc4YFfFhsxkyPcJpAo8oGpjDEjREvaRZQ==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(52116014)(18002099003)(38350700014)(921020)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?tevXf8MfahSqYbYTlQUZZNFrGdlycCWIgtc2DZiWg9FaC1N2Z4JKDuiX4ePT?=
 =?us-ascii?Q?S4eQJZ6ELwEMuZCp23/a7sk3tw4qw8VZMI8QJlmSNoWeVcP52UzA8FwRD35X?=
 =?us-ascii?Q?4DBYSGyTTpHcYrjoTnKJ5EzpMuBLbaQ99bFHjYxhKxK4onGv+nFuNTHaUIx8?=
 =?us-ascii?Q?L4EOLwvgwDlPRz47RPJm058BaKOiLJ8TWRv+vbY5ZMON92OKa1TFvko/B5kZ?=
 =?us-ascii?Q?VCWjq/rSft0UYWgWszm8HY0KL/Qe0VXldu4EFJKmOZyRHxMB1ipii3oiKmgT?=
 =?us-ascii?Q?y6C/f60RtBTzqNwUNyRKC/nFDkpCWcmcvWddaBksOci19xm1JI3JqjN03Jw7?=
 =?us-ascii?Q?2XrOhP+FOcyeoZ4RYLZVfSo02NhlMscfx2QQlpqDqbePlqhz6UNO1zL9XFdK?=
 =?us-ascii?Q?erKmUCUPSYvIapKm/6DPaGe4qfJbNgCHlkJz8a+xHNzepjIYol9y5Ht6OsLW?=
 =?us-ascii?Q?BoXpuSPST9HxVE4sfkOsuI556XWdZddN1bPFM4xzTAlwoQ9xFt3+4Kj6sg4R?=
 =?us-ascii?Q?qZOVSmjB5EqXCAgfJ908aF4bxkl+aXFP9eNAGXF9ug+xj6xCqzjdCZH7oaJ9?=
 =?us-ascii?Q?FCcsmMwQUHJjVXAlOwEoFRzPbZU9fkTK3xw5DN+hKuC8o3pSkCq9G20eTaSH?=
 =?us-ascii?Q?tZDL0aEznJJ0zWlATtNNbGpQOhJC147b7o8E6GIOIvzz89vp3M9plS5yr+yy?=
 =?us-ascii?Q?QpecDIW6C03JeJF9pXBcyLkZvC9mSkW2Jv95w9xCW3IkTtZx/bzHc+p9Z8a0?=
 =?us-ascii?Q?Qqk32buUlxszOoqvK3ilpl4qDn0Dl3r7TM88fe9MZiyg7EYekVSbE/7BTwNb?=
 =?us-ascii?Q?ThxeO4Akl/B41u7EPLSyR3iAy+argy7fRiKo1tIOqd/AXg/hi225zp3004PI?=
 =?us-ascii?Q?5RwVok0azK1hP6vdAPzUeZ0b0zUADCvWK+M7NF2oShY6oKjsjK7QIInn5iNz?=
 =?us-ascii?Q?J93CFaJtC9AndHbSia7lxuy/lEKOw/P11MjO+oVbuQU3UvsmkTGavCfpS8oy?=
 =?us-ascii?Q?VY3xljE5Fzz9trUOvECCeNf/BllapQFPTTUkZlsvyFUEpVIgXFkE+tnepkTk?=
 =?us-ascii?Q?ZW2YwbxxYEzDJUCijHGhf3ViRUYqRr6ruO+nx9QcKSvaY0yX3Lq7RI4oEStR?=
 =?us-ascii?Q?l/lVNv5VtdkaNsxydrYSaWaqOH2RCyUcBIM3r7VF3f0WMiXKNXwMXRsRSxHq?=
 =?us-ascii?Q?ZUB3jEW6ZkSPdeeXBdCGyVaBGy6xl8nb0qN5jPQNlzh6tmIE8cazwC3nQ/FC?=
 =?us-ascii?Q?tKLv193mDX1WQ0zPKqdh8yG0Wdl2DLwSSkiiUusJl4oP4J3zOAXY3zuQHqRE?=
 =?us-ascii?Q?K6LPCEasf7IeadlP78wcXQpfbEX6ILPmeDJwBCWNC8RgPZmvFPp6wJ+a0Xkp?=
 =?us-ascii?Q?rCbohaV2AUZA0Uw29H92X/0eYLHz7KJb2J37fNRdMziUBdczcrA25btuu60Q?=
 =?us-ascii?Q?7iZyebi7TlL7nh3lyLG990Qww2XYpLEtI7CNUTEDBiLD1BWJfrZfM2FQ+wqr?=
 =?us-ascii?Q?3lv1Sp//qrI7aTzUc7t906RqKhXIIn7tESbvLRmvrcukBMxlB96GI7LN6BfR?=
 =?us-ascii?Q?edUv/2beDFgKie2+jdxXnXFL9ysOzaUR22qsD//JQcdHyk7PX4djKrDKTPmI?=
 =?us-ascii?Q?46KG/+ITqFMfLWL0WwSEQqWcs2siC3TMM/I0XITsMp7o5kFemsZCDqK4pOYp?=
 =?us-ascii?Q?nEmyOZ111AyJ8NdUvSkwTHg0sjX80nnbP2zEZAd3K5PXQWutoQRoXyOVRida?=
 =?us-ascii?Q?bnMHXZ8ehg6ohTxHRvXjjSIoJD+3Zjs=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46c2ebf-a157-4dfd-7be4-08dec6c14edb
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:24:28.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0x1ywA8PyMABgfVhyu443Z+MThAH//4GFHkJXpOTQk/HDsYzpZHolPlk/QWMWVcpT9cR1Usjjxe1tFc0Er0VfWaQ2jWtwX231zzKGn/KTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0512

This patch set is for adding jhb100 GMAC NCSI function.
jhb100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
Managent Controller). Similar with Aspeed 27x0.

jhb100 contains 2 synopsys RMII(RGMII can be use as RMII) interfaces
GMAC, can be use as NCSI GMAC (network controller sideband interface),
do not connect with mdio PHY but connect with host server OCP network
device and share with network port.

The code which calling NCSI netdevice API is similar with
driver/net/ethernet/faraday/ftgmac100.c

The NCSI example:
_________________                 _______________
|               |                 |             |           ___________
|       CLK_50M |---------------->|             |<--------->|         |
|        TX_EN  |---------------->|             |<--------->|         |
|        TXD0   |---------------->|  OCP network|<--------->|  RJ45   |
|BMC     TXD1   |---------------->|    device   |<--------->|  port   |
|RMII    CRS_DV |<----------------|             |<--------->|         |
|port    RX_D0  |<----------------|             |<--------->|         |
|        RX_D1  |<----------------|             |<--------->|_________|
|_______________|                 |_____________|
				    | | | | |
                                    | | | | |
				    host server
				    PCIe interface

The jhb100 minimal system upstream is in progress:
https://patchwork.kernel.org/project/linux-riscv/cover/20260508053632.818548-1-changhuang.liang@starfivetech.com/

The patch base net-next (base commit list below)

Minda Chen (6):
  dt-bindings: net: dwmac: Add snps,use-ncsi property
  net: stmmac: Checking whether priv->phylink if NULL in NCSI case
  net: stmmac: Add register NCSI device support
  net: stmmac: Add NCSI VLAN setting
  net: dwmac4: Add NCSI mac speed and duplex setting in NCSI case
  net: stmmac: ethtool: Do NOT call phylink function in NCSI mode.

 .../devicetree/bindings/net/snps,dwmac.yaml   |   7 ++
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  15 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   1 +
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  32 +++++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 108 +++++++++++++-----
 .../ethernet/stmicro/stmmac/stmmac_phylink.h  | 106 +++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  10 +-
 include/linux/stmmac.h                        |   1 +
 8 files changed, 246 insertions(+), 34 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_phylink.h


base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
-- 
2.17.1

