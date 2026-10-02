Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F664825A9;
	Fri,  2 Oct 2026 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934609; cv=fail; b=I2JLZIBRI0DrZY0zSjrW6gt19vF461lwDbMZpv67h2zfiW6V66BnWXF0OIJnd/HgKOw+T6B/SySVjABr2fAal7cf1WtJZToYZhKlvpRdXi/Pk6KUBrPmNWx6hKMyrUjelsq/D0L6UqUeu7TihS+b9vYF62eHjC3ZGsg9XtiYCsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934609; c=relaxed/simple;
	bh=TsaXMdbcjKnhZLCgXBENKITr6BRCJ1FZ7Hu3ni8UQG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BDB+Q+eu2XpZSTaq2MtUTVoopiZRWBXeFcemCDBGc7cY9/LqkT6kvEgqvM8nakqm3UMyBmPSlKZVsvbZwrr71IxTTqjFbRys+qDid5Bi6sHW/wNj9XLIHU4FHC9HxdCmObLiYFBoVqCEIYVly4tVafWp/KbiLtCZNmpSCBi8nmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=fLpLNOok; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="fLpLNOok"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4HfYl+SqPSlT/PCM2RlLpofX325JnkiqEAfEr0xTi0uKDpEpijtfG6FTvE1BnY5IbDjn0zm77KbKQBV+vaTW40vRPv2W53++iPNbe0ToU75/lvgEraHifleppdAFZTMHAkKdh/9aV9Yv6yxTgl3b+1LH6F4eaTASnh1SDieYO97lL2fCYTuCc7emOsezx9qgqEg2EWi+5+DU4sM9NLKHw0631fdd9n1L9l0l1EONew/XUGuZolnNC6IgcGpJKmu/6W29PlKx55Z8k+xfuVGQPVh2wuzIU9LJkONWXmbz9qifMil7lJfYYVmVurrZOA1GqHkoMeBH5g57kzJoFM+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqAlterKQYE8JG95SP+eGi77TEbqrDs01JRO3oEZ5rc=;
 b=dCwzYNc0fYl45AxDCsjnR2G1xxRc/TqQMdaU33621U94dLyW/U+LedsTMEEAiMQFannX43wKkdNBmcV4jNtWRoK9ar17T0NylXnCFfm604TvDRFRpin8I1t0dwE35Z3fh/KK8DSu698NwyPQWOcQo+LGfbM9oz89rFwhlg3U8fn0l5OlGVzn7m1mH/U3KkrnEwlPkewEiyTYG5GxfV2w6/DT9KEOGjloxAMEAXTUlNPBKDc2FGSv7dZgnB/F3XbfjRjlEH/gt/FklKX0/aeGfSYlrxXUuxLSAH7g8HiKijJzMBIEqHyC5N2nHaQ7/xTSVk9zIwT1WwlLtEoXqXJjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqAlterKQYE8JG95SP+eGi77TEbqrDs01JRO3oEZ5rc=;
 b=fLpLNOokxE6RmLzClN8wxZG6IYYYYpNs3rV5t8GzZVX3T2Slamn9WOSAk+Ou3Va82+bjZdPSWNXVGWWkJpujHkf2bnrwBwJ/GnT+q9zSJ0OzqH/DZhsbDyNImz3q78LU4zlXv/I80jvtplIUKi6oR0rd3DrP85p3tdQgPQCCcUQ=
Received: from PR3P192CA0010.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::15)
 by VI0PR02MB10876.eurprd02.prod.outlook.com (2603:10a6:800:211::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 09:50:00 +0000
Received: from MI3PEPF0000849B.eurprd03.prod.outlook.com
 (2603:10a6:102:56:cafe::81) by PR3P192CA0010.outlook.office365.com
 (2603:10a6:102:56::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Fri, 2
 Oct 2026 09:49:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF0000849B.mail.protection.outlook.com (10.167.240.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 09:49:59 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 2 Oct
 2026 11:49:49 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 2 Oct 2026 11:49:49 +0200
Received: from pc67698-2615.sto.se.axis.com (pc67698-2615.sto.se.axis.com [10.133.4.43])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id EA91C7A;
	Fri,  2 Oct 2026 11:49:49 +0200 (CEST)
Received: by pc67698-2615.sto.se.axis.com (Postfix, from userid 22105)
	id DD008590CC4D; Fri,  2 Oct 2026 11:49:49 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Fri, 2 Oct 2026 11:49:13 +0200
Subject: [PATCH v2 2/5] ARM: dts: axis: artpec6: align all continued lines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261002-b4-artpec6-cleanup-v2-2-8452b5d045ad@axis.com>
References: <20261002-b4-artpec6-cleanup-v2-0-8452b5d045ad@axis.com>
In-Reply-To: <20261002-b4-artpec6-cleanup-v2-0-8452b5d045ad@axis.com>
To: Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson
	<lars.persson@axis.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>
CC: <linux-arm-kernel@axis.com>, <kernel@axis.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Henrik Grimler <henrik.grimler@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2861;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=TsaXMdbcjKnhZLCgXBENKITr6BRCJ1FZ7Hu3ni8UQG8=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqv34w2OB3h7jo7ZIFgMJRr2QrvkXEKkfaG3n8N
 jCYx4hzxluJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCar9+MAAKCRCwB25JC3Fh
 a6tJCACMfgPB7s04vzpMhW9D7U1HBfaDApUL2nGg8HPbeCmyHqXVHbzlnXseQEF/5Pyz3LFivoT
 AzjDgR0tRHj5Z7/lfkO0Cup2EdtxfSCwMX5qxUD5nl83oTPFMnATFno5ozrFqh3vem5HoynAWBK
 TeOeNI2p/wIp0Q59QpYEdORRbK1YhlNA9LD3aQV1rs7doieiVfkjpGTj9Zn0+HpGjK+Njz9H0Xy
 TT8PcLEvWXOoipApPPjBl/XiogouIcp1sgjEsIhPr0Pd9WNRbKweP8utw7qokIxRLg84RTAdsCH
 H6vQBeuFd1AcBcQIoi1URDs1DkDnmg/9ABmhp7+rjdHStRLO
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000849B:EE_|VI0PR02MB10876:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fac6916-f5e2-4eae-a4ad-08df206a8618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O/lsnGAgOPP6NNvoQkPeOfzZ5TjcR4OKC8TbtyGwzJyCdv8DtdEDT2RMMGfJ4pZ5ipyDV046MNQLRTtG9jfhoiloQzOnk7JOtbcmK8SrxUCPGhEYQarK/cU03QgArecW8wDkDbo7FOP1YGB9jstT0dpjqIyh0BBSn7yZZuY8p0KS9U/e7rRtemAZt1nJPyk7tfYLl4iNbtxe/MESdCyHTuBm8vq/L54eWAUPn/3gBjtGd2oEozssph7i+UguqxRHxHYfxaKdl3KdA9o2EU/Kx2dmbkTASJsZQ6oKcQjljtd/ieKGEXxmdqdQ+srLXhioAuetSV0GpqirOb6LGNsrdaUCpvFH3wdJpu91id6geZD2by0nHc/U0k0/hdepVqz3IR6fA/oeIGxripRCuVxthiKa68fH49WPBeNZ/GqlZqwIYMJ31psujhvPLAum9ymxeppo1mqCBDdDI/7jOEpZPrQS7bf2l1RNWEuuZQyn0FFmiVHovUMJ+xjnlcBlq8fR86OT0iUbBGhYRAD3C9dHZuj5pmtVmukLoqbBpyR3nweq795SAvtJ2ZccDmIFCbt/ipaQjQOZpHrvvOrPxmbgnJ8cr04AfDjkYkFYcQqjMnuxvleGV4T3dFBvz+srh4sxTLAkUmkXtcCBI8BaC1qyTAs6ylXVsgJm7uclWfH/f/fqnSy5GH9lPCS0Uw7jHCbm4x50BSPS5vItgfRdbJtqRg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mug2yT4RTxzdzFSWTCPaxxTpu5LT2/JXa/S/OrFAzOizvlCJTeUenscgHEYUZetQYzpnRe1IuZDavrlecRBh7Yn7u/ROU1X7Q3B5AUrmEP/DYyQt4Kf1QbO5dZhTUiDr/Tc59XJUJS7bK94tSGCArj0nUEo/AKAfuS3cdv2VDLq56AHQuqZ2c24iStC1EKUVSNsI9CBiDXWd30IHVBhFIZq3l0QStn621OQiwnUVdRbliRtgDukjQjL24ma17wvtk0FP+tmM4DCl7BAlAlxzlkdg8mJDZuCmrPeHr01ztiwVM+b49j5/oD3y6PHm5K1X7NTe3QLm6hoX3zOXoCTv9ZBkM8h4ywzpolSrjXamyxTcKH+zMP/DDxxnxYFuLxHxANOkaZpO9mmrbPWn75UnxMYcoVfLqTn+h7Vh7J0fZ+CCI6dqaXp1+kSNwafKhz1c
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 09:49:59.7680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fac6916-f5e2-4eae-a4ad-08df206a8618
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000849B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10876

dt-check-style in strict mode reports that there are a bunch of
multiline properties that are not aligned, fix them to make the dts
easier to follow. Fixes dt-check-style warnings like:

  axis/artpec6.dtsi:290: [continuation-alignment] continuation should align to column 34 (to < or ")

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 arch/arm/boot/dts/axis/artpec6.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index ce642dcc754e..d6610f62ca25 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -151,7 +151,7 @@ pl310: cache-controller@faf10000 {
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
@@ -287,7 +287,7 @@ dma1: dma@f8019400 {
 		ethernet: ethernet@f8010000 {
 			clock-names = "stmmaceth", "ptp_ref";
 			clocks = <&clkctrl ARTPEC6_CLK_ETH_ACLK>,
-				<&clkctrl ARTPEC6_CLK_PTP_REF>;
+				 <&clkctrl ARTPEC6_CLK_PTP_REF>;
 			compatible = "snps,dwmac-4.10a", "snps,dwmac";
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
@@ -333,7 +333,7 @@ uart0: serial@f8036000 {
 			reg = <0xf8036000 0x1000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
-				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
+				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
@@ -347,7 +347,7 @@ uart1: serial@f8037000 {
 			reg = <0xf8037000 0x1000>;
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
-				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
+				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
@@ -361,7 +361,7 @@ uart2: serial@f8038000 {
 			reg = <0xf8038000 0x1000>;
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
-				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
+				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
@@ -375,7 +375,7 @@ uart3: serial@f8039000 {
 			reg = <0xf8039000 0x1000>;
 			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
-				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
+				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;

-- 
2.43.0

