Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0703328616;
	Thu, 16 Jul 2026 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168435; cv=fail; b=NS/1rLkJHI8j0TIcOWJRhbb+azsGgBKJ6y7GVnEK1Z5Le/VKW/Ljda4xfq9Eu11PQIE230gpIxZfN4m5YZp0otIX+JydbRAHYvH4ONNaPNdb22rt5MEiAkfOCcttqajvZcLPJQw8vwLqz0E/lPCmIVC1z8bar2kP7OTdwDRPA5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168435; c=relaxed/simple;
	bh=fKKWwitsCp4EvCKvGKZ95vOhK/XjS8hDGM+tkWjuasY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IOVXXEgKjl7qxJVsbPc7V9rJZyVazColnKK96ggbuYZYdEP4g0eV5DQ20Lc5IS3WaibXitvC1yCOjD3NcYzrJpgE5atxwkUw5gy9s5wD7RdGDgmOzECmrH0nFSlJFQSerRlylhcoX840O7ftwHwGQfP2Ph0nFXn+KewT5GQDq4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=G+mqd2QR; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="G+mqd2QR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGHEYTewMTGI3dpaoUqr0skb4VAobuwmd9X77jck+U/gJScJVJFw5er05GqEZmZAm1tEZd3BJzdUvGWvn2F8FznvwJnKgTMHR9tQ0zFvhmy3rTqxDhdrvSZhP88TqAiNFiwZrAuzoGWfoYsyNsDYyIpAoB1Fw2d6fgOb8mW45D64yKzwNRaXrE0ieP5eLBQ5IqfsxHp1MOBz+FoSHTArlbGjqFeqgsne0SJCF4TpbIbaIQCi+RaQAkLFIshTTiPl4RYwWrcN7bAwRQn6wg4iE5ya26AaUGmeU1l7EBeGMDqEbD+101/5jmRZ94SkYi4c9KQ9tXSFC1ONvrmyq/beOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/Buge17DEsgmLwXXzvV6tF59R1WS2SxlCBeyiKGyew=;
 b=miigvP51NgGhDbC9vyLA4KQ8eNatVA0nE7dacMhQfeNGi9xppucu3LtLBVGBTRgP2QoG7/jFNbLrxvDbPO07Z8dAtz2UmOf8zuYn+GPMEjonbWyrTrXOVvDOVvkpHQmU9U96tLkIx1jhe5qMrJPUCPVs/3aXwryEsUwJDUcPnYraMC3cBxXePaabivG57XCv/3MBObJKlB2CbXkpSltbOc6IAIBKdgeC5WDbCKZlBRG3dyOmSoBtBx50b4yyTHiAgpPg2tHqoUBg/HIFaGV+FlgsVYHWkFVReBij4KOKwcvjCdZt6keaeRLgadqGN5ZPFqPtUG0gHmgwkghT+DlzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/Buge17DEsgmLwXXzvV6tF59R1WS2SxlCBeyiKGyew=;
 b=G+mqd2QR9zQYgOtVjpdmmFw7rHxhrf+IojW272OKyAXrwtp2BvEmgtJEcz+XNyk1c1ZzWE9Y668NfVHXb3+LTxW5a+qFNskqdYAp6s0hRRKtZuFqoLjdK0gDgsmyWWriTCcrSicrIWG8sJvDtn5UL8XF4xs2VOGKfXGDCDcLtOzHj82G8CrzZ885aUGfWqD94KgPIRyVxWGCjtuBkWk7liYohNgBQqFt7EBky0Qg0u+/TtLk2H2d79wSDXGBweyw02cT0VllJDVS5mxPF8IxvnJ+T3427qtEOQflAFY5nE3kgh0Ow2atYQmnvRZ/sNsy615Pv33oFmhx8qSeULbqzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CH7PR03MB7884.namprd03.prod.outlook.com (2603:10b6:610:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 02:20:31 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 02:20:29 +0000
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
Subject: [PATCH v4 0/4] Add Agilex5 SoCDK TSN Config2 board support
Date: Wed, 15 Jul 2026 19:19:28 -0700
Message-ID: <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|CH7PR03MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 912de732-a1c8-47ff-e92a-08dee2e0ce31
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|56012099006|10067099003|3023799007|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	WOnZLfOOqR7jt4Tkj2pSZPoIyn6KGCeX2l/kitG0Z1AKRfaKZVkcjOGHnPqp03zh3JzBT5NstKoJvhtrwP42143PYZpcTmvtG65QH2lBAvLbS5k2xbd+9IbwqqKtSMFBDezt2iiXGDhYH1RJ/vjRH5E/tYE99PQX6xy+sdo2hdNheDWild4N10CR5lHQp6gt4JK7fBfHNzfU08Ak+++SMcnfmmMr0VErOUpGcHr8oWaVcULpDfT9+ymWcgaaw5lcTDizOa6Ar6sWTgPLqD8LTklGlzGk2pDqr6Y9oVNXzXOX9PwBkbiG1dNnK3zV/r81WJt/eXy9jh1+JL/Loz4llXcNEdcJm/x724gaoB/jQ91RuePA/7Sc5e6vHdiSLh58fiIetN1iHuMh3DGrc/TBKSec+I7MgGzy5lRmJnHne8AA8UcKIA3mp6u3UHOC56bfoJ7jRMS+DXE7otYMRhOcP5nSCp8Njc2kSll3AGbyP0hzZtnYxKTANqzIzEcksZSzxdeyRSbdGTRa7ON/kOuqXRQCmchc4DYvF6Vvcvr0YUjghi1vS8mpVm1dYUoz5JflJPtj5DdWlAkYJZvDpnX6f8bd9Sn4hZUU4PRrRcpeVNSHvTqH2iWqEGP/F4KqBkN6lQDzeQgo6cmcjPbBJoqut0TwDXEvpvzBIPFKR6jspIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yynWSjN1PMmoHpM1m9vEqRkr43hlifNi/vnShb+KRDco3d5vX6pKZt68Fczg?=
 =?us-ascii?Q?OQyEv3WFG+xOyQrcjUbzj+OLCqCBp62GvTNm/49Nv8YiaQmsIUjDC+w02ogC?=
 =?us-ascii?Q?/1jWzp1XUMcRiBX8amXmsJwh4zQfWjOhka+jJtGeMlLiEgzymqpxj42fvZPC?=
 =?us-ascii?Q?tB8wTaGisl8Q31qyYDOxjnrcwT3e/ixJzVHgEIHWubFJ5TSNtjbCg7s1Bob9?=
 =?us-ascii?Q?gD9EzfTc6liQaZGD5UqwDNsGX+fdoFDtsSabK66CViHCmOfnmf1J4FO1vc+d?=
 =?us-ascii?Q?FMPMWRQ3cx4774JVnyiQj/2e1Kf7mjizhEGZLoKfogm4nVTlN7jStHWobMhU?=
 =?us-ascii?Q?ilNCN0PHozr4dwmqoTC2DzZ4rD4JsHJgyYDUTS3Kv6/Wi7Renwr5DKX34v+T?=
 =?us-ascii?Q?YALWO3ppIOoIjizQIbpXuNJTUB7b2wX+jJcpHSN6cfe5XqSjvEszjbGv8hSP?=
 =?us-ascii?Q?VogfLeWQ3pJhUy9vMi8CBiq33CcSy4sl+CD4AaCezMnBJ3m/WLK48DV/i2vi?=
 =?us-ascii?Q?mTW3r1o6OW7aarPSxt7BOu6SnxdE5HADI6Jwf3xnH0677FpiHFZh3Qo8WaQH?=
 =?us-ascii?Q?pvtNPHC8Tj2CmYcA7bvE6c4nkJtZ8rfD2MtFuWZrnByD2vqCMhWfuw+/gH45?=
 =?us-ascii?Q?V7Q8IUdMw9hw3gDAzR6B9ZOoxnboTaM55AImcjj75kYK9rLDpPsokrir/iUB?=
 =?us-ascii?Q?ZEqbmYMIWt3E9dwpKiiBy4+QiVb4roAQIkSq6/IHxpJhLKSps4jmAVrTRz+Z?=
 =?us-ascii?Q?hoF2KG03+FtK2MPy6BNqfe63mGA45voXkWdgnkCvuzKietKqBb2oj4LD5v4r?=
 =?us-ascii?Q?yMGxlZhBNHXGZRYaZ5E57H/TpYSZFKWb/qNBoiVtFW1dB3y5M1ZZe7bs2T28?=
 =?us-ascii?Q?a8GfvPReHV2Ep6mFPzGpoTCd784yWly6IKaYNByhH21TnxXbSMW14pFVFSjH?=
 =?us-ascii?Q?TszOjjZG+Dy58DVUe3khnhzSJx4L4FM/v/MxP0I2DdeQEC1wXXpL2V7RgC/Q?=
 =?us-ascii?Q?OXoz2Bxdyb5r0nzbC2YC8o2b0kgdJ3p1LHutq1VnpGRUdV2N3BvIQ+Jm+jDU?=
 =?us-ascii?Q?Kuv+U70w0oAqw8ZiSVDyI/TfFvizTdsItZoaxR0hPcvFDVkM1d3oDl2UllNA?=
 =?us-ascii?Q?gCaD9DJwyD8s5a36BJk7ESfDrD5Mw/9xvEK0muJ0y89PQsZEBqMBpkr+OEQT?=
 =?us-ascii?Q?FMH6ILirBbUgkELfhjRK1+ZN4WNlTvekGuttadq798fmKrwV7ttaMU6u2Qwr?=
 =?us-ascii?Q?0AfS2EgKe0eBOMAcZPk8wDMrzXGSJA8Kvz018TZM00El4kkR5srR+yRtIcYi?=
 =?us-ascii?Q?mCuSFhxiMA9md2HRgWFDZMEoFFuzN9mLi6gl9wxYt9aooWWNI018SKE3yvXu?=
 =?us-ascii?Q?8FclGcstOtntLxc2QspFz02gr//1v2DX76A7znSt2WM8ADg6aoWylX5aQ9tP?=
 =?us-ascii?Q?v9BWD2mk3JHvQ6IPWUCBaSfkg9HgVypbZ/NqmSPsS4h/NnZVLLwjifwbH50D?=
 =?us-ascii?Q?TPm7mwH7n+c2+hMmEFGYZe4QlMNefV3uRFHd7fcQK4QCiPr9dKlrZgqUEVq3?=
 =?us-ascii?Q?H3DTuWWIop41xV1KS8NznABFVsfUB4Tlk26k2WVJ5eXgszhoZTAXmtE1IL1w?=
 =?us-ascii?Q?f9fiDkDUIt2m5J+05Ro53rnKMsEhF1Jd4nWDbz43pRSgilwFj/JajqrY6yoe?=
 =?us-ascii?Q?ehlcYCX7cXLmW6zwZpQ8yMDOx7Gb4dLCuD4eI/6l+hdmJD3DlKNCs/UUBrxS?=
 =?us-ascii?Q?ujxp2nFtvD3BDDPG/z1hWjh3pQYT417Su0RqeOm5afJCf4+5v0Zq9DMLxx/t?=
X-MS-Exchange-AntiSpam-MessageData-1: pwmzKfiOr+V83Q==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912de732-a1c8-47ff-e92a-08dee2e0ce31
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 02:20:29.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14W1H5iVR3xarAzxb/EdObwd8Pl68gqkv7l2CR015ioKKMQCPWI0REH1AagyynzTqz3txRjxDX3I/23nyfaukISr1rO4lheocSXATps+ZHPoqT8FinogKOi7snBgYNOkHvEbJqTezf/e4AMM0sl2QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7884

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

This series adds support for the Intel SoCFPGA Agilex5 SoCDK TSN Config2
board variant, which enables gmac1 as a TSN Ethernet port alongside the
standard gmac2 port.

The TSN port (gmac1) connects to its PHY through a GMII-to-RGMII converter
implemented as FPGA soft IP. This converter provides the RGMII TX/RX clock
delays, requiring the MAC interface selector to be configured for GMII while
the PHY-facing interface is configured as RGMII without delay duplication.

This is handled by introducing a new compatible string
"altr,socfpga-stmmac-agilex5-tsn" detected in the driver probe to configure
the interface modes appropriately.

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
 .../bindings/net/altr,socfpga-stmmac.yaml     |   5 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../intel/socfpga_agilex5_socdk_tsn_cfg2.dts  | 131 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  13 +-
 5 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts

-- 
2.43.7

