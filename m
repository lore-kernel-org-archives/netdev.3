Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89D73C2D;
	Mon, 17 Aug 2026 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786935740; cv=fail; b=AEys2Y2OeGM6vL9y7iXLfuy+3lwxU4PPQ8GhIqnrKuvHGombWKIk8fxGmIy69pJuCjcDTWSGsZUghSdJl9hX5JtJ3e8fAVgKXL/EU10voqOHBcVQIQKz24US8pujeePO3P/DSwuom34abFrLKyG3y4fhRcvsxl8jgFMwzaB4kaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786935740; c=relaxed/simple;
	bh=JeJOtPiUxsPMtr7Mdr2BatLI+Co4hTDdzYl26XzAnCs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cfeAVVFBzv2d/v5OanG3I5YwdG5WE5MJ7uOjF0J3VqSaFmlFPONktVxlmW0lvoBWzyx4eXg9M6gEUpJqvQ+0VvBnMGCdIK6ZiCbB+Upfwehvfmr8m4erextmRZCrwiJGCQAZOuIC4ouOYc7k1HIEGQLJskqdl5wQVgkQPdz4c60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=NmlN7+Gr; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="NmlN7+Gr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vc2oXwAM3qvzUKJdljM1U1ZCFRN/XG5X9dZqjqcvBdL1up/1JR8ZGDTJQay2gUu9wHwdwZtzaxvok6GVOSY7eLgZWF5i/phWwHL/OOHmIbMTL6yMRIguC/fTSFt5koXWvLQQ0rSlHFFS3EOSgkf31vV6SvwnuGbjlOhV9zryvfrgzwi3lzLDtOBgV1Ah8emc8KakuSagWvMpPcfy60CXUpjG22Lhb9tqHvxs1H46DN7++0I7Y2dAKM4qk3kZJB6z2x4vWtO3ecksUF/71p8qlJ45KBBPm8YDFq5eOtRC6PCNkyH8BzbLpKsJBHZBdQxMIc08fokjaZWeFfBgoPflAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQc4NM0CJk48Hzha/ebNuAXxZ60yYVENMrz0w7mNJ4U=;
 b=tkdlQSXGuvQOxvpEMfGM0r1pTc4SRlFTNZgdgxo49Tb1bddcgJSzid3DYKK3EtJir8lsAywtdD0pu7ci96JqLvtAWH3z4PWewMDUZwx+L5qNg2Si4W8Uqm+Mkpmo9m3oxSP7yZSwHTxw/HMRuKStcvUBnobb0TVR1JbxwQSIj8L4T2O8xXxBj1SPTwuhfqgtV8t5ee4N0MdnjHNUanhR1ZrnVMKybJCcKcMVGj7NUup0VQjF1UCz4HQVMzkY6Vs+bGwQDD9NNsAgx6xf3j1kFi2t0Q5OtIsHag80CAYcBjM/T5V266OchA4hlxBbLO76jxf/A0GRt7jR+Qv3Y0rCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQc4NM0CJk48Hzha/ebNuAXxZ60yYVENMrz0w7mNJ4U=;
 b=NmlN7+Gr3zZXP259jAwf94Oj50cOymfzzZcq1+A9nmGsAxa7doC1V45NPc5yrUyk0iYENFMYCNZM4dYSPYVE96H03ro44HW4vwba9hCK/a+IfaAxySXllvPv8scJMjkRpWq0AaF1HfXeU6kcaiJ3hD1cwXScuQCErgUtrpHEhpORQSIs4hELba3/GiPVx38ZzqrUNUMcvhT69zWEcpYvYjZq5FVphihXRwyNVTAY9O0RslO4HSBqCFAGZnt/MUzyXu7SoJcIR+M6G/oA7xX180FRzb+4ar0itdOIXT6+blYLj8cFgDLFK4+3lGSJEt2DhdA0AvNnNGMKvHI4uQifEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by LV4PR03MB8355.namprd03.prod.outlook.com (2603:10b6:408:2da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 03:02:16 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 03:02:16 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Add Agilex5 SoCDK TSN Config2 board support
Date: Sun, 16 Aug 2026 20:02:09 -0700
Message-ID: <20260817030213.6769-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:334::11) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|LV4PR03MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0fc05d-bd38-469e-fec9-08defc0bf1ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|56012099006|10067099003|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	lVraguPMq5QmiHOl9VTXFQwK1k+bTcoZZyy/RB69bQdj1sMngGhjMBpCgo9gLXmmeYzs0Fdyy4QNNRsHTYGhEFVLOLfep+3lH9yq4FX8S+LNGNUqpxN7QkcNpCO+aDDxM+x2sJODp3L3YxxEo/uiArTWg1Dt+wtLUy92CJ2zgAiKoqyooGa1lwLdM3CsMvkH9UKL5YLRg4keepa/PNcgiL+zMKzPFPbxunoREgFGqyZ4/4vAHTy+glLQfJU0Rt4vkveszSmbzhY6cSlREcE/KYRJmGfaoCU3r/jdTrEVN64BjMU53EePUzVBYtmgzUqSjIzYCz8/ViGXAgkwsDxrUGnP91Vx5KshBNqqc6P+xL4buP2nlVvecip3zSuSFuTUJKO35hXJPku9JWMgiqToz9lTjJB+AzZ3olY4hrR4+00MgIwmJKMRnIcBagJkQ34gov9ts7tTs/bm5HYbaFE8Nf10kQL5QJ7ZEAA0V4BcoXqoMxX91xi2IVMRjgcTbAWMYjZZO7/16/+yUc3rJAfpvIwK4y7jDzJsYiwLOLQ1l1cagTLABc+mSTRhOF+9+e1LGxt274ipa1ytvtXJAiNYyWIgxDmypVdr/o4III4hX9yaly99cv1CBHaOOIQCMzUZa5ASGkKvv3GQ97kq3WBOc0t8VegJXDCTAxCTrTpnfc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BACYYntt4KPqWxsj0bI7bEUOsSqJS4Yrxvl92O3YToSf0sWIXb5AI5DRI/aI?=
 =?us-ascii?Q?qoql6tCLfrMv01hQe0jwz4kIiGKWLuDidtx+NWl59hOJfNkfJ3RfYx5ssOcd?=
 =?us-ascii?Q?EDEsQQvZExgliHqtcGY8qBOTyowgNP1/94femMk7p6+fWXsmftuqto365utN?=
 =?us-ascii?Q?ISRWCHilv5bRK8HObTX6jG+Gi7BTcPuwx6tTp+GNnHlHzkS3ztk9P7PuOks3?=
 =?us-ascii?Q?P5hl+ck0a020KGUTwdg1uR4hPpoz/mRzU+BtJllDWqTUrHftjFqkE1Eo3mL6?=
 =?us-ascii?Q?kPJJ+3c0oul4SBtBcwg1GAjR2V3ftnxaqSEPN6m0Rb0KGXTcu5iZnpWE8wub?=
 =?us-ascii?Q?9hClfe33ynkifI8/Jp+wiMmuGUWVcHhucQtGozdrBLGsLTLPP3jnBfhlIscJ?=
 =?us-ascii?Q?/dLSuO8Ta4ADNUkBYgsFb91Wg73Pj/X/hR7ckMg7unYAO0FEGdZHV/ZhIyul?=
 =?us-ascii?Q?Peqgn1DKelOlpc9+rjJbYXX1QWWAl0yzuZpIYF7qS09W86UEiGisGpPeFILO?=
 =?us-ascii?Q?4+dD6ooR+WKCCPiAe+cwuNCtATf/C0nXDS2ncTPsYCfbi20GgOsacmnyuFTh?=
 =?us-ascii?Q?nrtEhUa6fBEJDzXR7WVdh+dD3OfuK5Wgi5yxBIhGyDHz+jOX1oSF6XTd3azl?=
 =?us-ascii?Q?WXwHYmqOgJNgmvDn051VfUEal+1y6K6jbUk1tDueSOTYmxpYFil+FHHGEgBF?=
 =?us-ascii?Q?xVzuzknL0/PMlVT8k7MllEhlfF2sHm5C3ofh3dgYzrg5EM0mPcoGXloSUhCK?=
 =?us-ascii?Q?yTR++HpKhkmkpnCW2LxcpjCrShvLii28wzDENrezQ+td20WcJ+QY0XLRiA/A?=
 =?us-ascii?Q?AazqyedJQnEdlVvdDhhsaNQpkoBV/eOxLgqV5PilSq6ggXCo0rYnyHjOgzvu?=
 =?us-ascii?Q?2K2lPbaW70e5ESQ6dxzdB4kqeAyak1w99ZGtiT5pWW0+YD65G5VwO6vAbP5G?=
 =?us-ascii?Q?gPlpLaPRAu5mFo6EnNBYKO2g/76q82U0xnkCJ6IsIVeUnkEgHF1P+/Ut0hcR?=
 =?us-ascii?Q?i5MVIWACACKkBSkw5guI9l6CG+lHX4TpDq/+EyUeqd9KkNsyphgyhjYm8fYy?=
 =?us-ascii?Q?iG+hqtqMcJbbwj0Xbv75asEfcTRjVNSBjufW48lobmUBaA2O03bCcW9IydZF?=
 =?us-ascii?Q?8QPSbDacKv1pbZO+lqCUN39cvW2yqVG/+X4EXHErXe+kjZLR3yQSyWkhjc48?=
 =?us-ascii?Q?IpgVkx3YHBKtaF6rLBa3YiUbIrGz1HJmBlR6PjJc2ktWiG6K4jhpkVDkQXx9?=
 =?us-ascii?Q?XJh5YikGieV8v6eJ+fURma7uPHT0Vigs/RQ/EmPfC+XuDXhdK9NwlqbXEthj?=
 =?us-ascii?Q?CErnQnABdg3vglA/m5rGPcOSi/WFgIEEf0G+8GWYqA2SOwQBualt/RojJna3?=
 =?us-ascii?Q?IYW2Kw8Sd/akdxhIA+rV8LLmCVWCeO35YpN3x/NtaXibI+Lofqxh70tyqrdn?=
 =?us-ascii?Q?e3T8eAmBAHn8Lz9vBhjropQ8A7+UbJUWaPE0l2N6tsly3BD6An5ZuLz2OOct?=
 =?us-ascii?Q?nRblzlyLTRMKETW05gfXheNtVUQf13Xj+Fw0x/rZxYaZr3AUDBelC2n41Bcn?=
 =?us-ascii?Q?rdXVOw34tHH4nJWHuqDhW3N/TMcRFs31gzCkVwSt1gXdbtx7dI8AP/iswn6/?=
 =?us-ascii?Q?nt5ovhQQtSJz7d7rX5VKKKXDCsSsKieqew1hVww5R5+qpSxPbomtvL63O7jF?=
 =?us-ascii?Q?SQIMwCKJebgI7wyubO0YZxlMKinUZyreVWhgtinD5sePEYZ3zjEQhO71zi6G?=
 =?us-ascii?Q?iLngnrRMY5yJXkE4BI8wWWcd48u55ZSRQstLXT6tmFaCrSc2fnQEQRPuEy5A?=
X-MS-Exchange-AntiSpam-MessageData-1: 5ruTuZ/tvYK15A==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0fc05d-bd38-469e-fec9-08defc0bf1ae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 03:02:16.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0OyHGG6hyv2sozbyAWIbIyqcuwGcloaZYIhWml4tZIaW5VRjIR2XVXE3rlwWw+RnX9BlgvuKtHEOveQOYVNaovtlKcqPfRgZ8Z1IFBS+1DRWcevehX/un4LST/CdYKhrCn+9YFeHJoBXw7o9J5ecw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8355

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

This series adds support for the Intel SoCFPGA Agilex5 SoCDK TSN Config2
board variant, which enables gmac1 as a TSN Ethernet port alongside the
standard gmac2 port.

The TSN port (gmac1) connects to its PHY through a GMII-to-RGMII converter
implemented as FPGA soft IP. This converter provides the RGMII TX/RX clock
delays, requiring the MAC interface selector to be configured for GMII while
the PHY-facing interface is configured as RGMII without delay duplication.

Add altr,socfpga-stmmac-agilex5-tsn for that integration. It is not listed
as compatible with altr,socfpga-stmmac-agilex5 because that port has no such
converter. Patch 4 adds dedicated match .data ops for the required
interface setup.

v5:
  - Replace of_device_is_compatible() probe check with dedicated
    socfpga_agilex5_tsn_gmac_ops via match .data, per Krzysztof Kozlowski
    and Dinh Nguyen.
  - Drop altr,socfpga-stmmac-agilex5 fallback from the TSN compatible list
    and rewrite the net binding commit message to explain the hardware
    difference, per Krzysztof Kozlowski.

v4:
  - Fix wrong email address in Acked-by tag from Krzysztof Kozlowski on patch 1.
  - Add Reviewed-by from Andrew Lunn on patch 4.

v3:
  - Add missing Acked-by from Krzysztof Kozlowski on patch 1, inadvertently
    dropped in v2.

v2:
  - Replace mac-mode DT property with compatible string-based detection per
    Andrew Lunn's feedback.
  - Use phy-mode = "rgmii-id" to correctly reflect MAC-side delay handling.
  - Rename compatible string to altr,socfpga-stmmac-agilex5-tsn for
    consistency with existing altr,socfpga-stmmac-* compatibles.
  - Fix Makefile indentation reported by Krzysztof Kozlowski.
  - Add DT binding documentation for new net compatible string (new patch).

Nazim Amirul (4):
  dt-bindings: arm: altera: Add Agilex5 SoCDK TSN Config2 board
  arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2 board
  dt-bindings: net: altr,socfpga-stmmac: Add
    altr,socfpga-stmmac-agilex5-tsn compatible
  net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA
    converter

 .../devicetree/bindings/arm/altera.yaml       |   1 +
 .../bindings/net/altr,socfpga-stmmac.yaml     |   4 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../intel/socfpga_agilex5_socdk_tsn_cfg2.dts  | 130 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  23 +-
 5 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts

-- 
2.43.7
