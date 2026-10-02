Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424E47DD7A;
	Fri,  2 Oct 2026 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934604; cv=fail; b=SByWzQI0w5/JUXCqlVCXr8WEynj2MKdLZyhBmXJHzYKFEnGzXZjFVSkSDRtpJwzTzPUCkZFhLXIXfFOuH5FkjuTMTSvHTF/S8zR8B9mLOmYvW2hcE3KublgwNAQF2AQLfHvvzugQrPHcCtIsHq1kR7igPHFY/ZzP2bPTVrlxWHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934604; c=relaxed/simple;
	bh=RbTvUpsJnnUI1OEqGUbUI4wBld+WXF6zHPxN260TwAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=C2hA7VyuRv1JOZSxbLy59OULAcIi39Du+7Gxb/haks6fLfDg5g89zUSTfWkcpa1VBzPPRC7pERIqE7Fgg05zjVgrfyqj0SpEAm9PhaUxG2pufsMY7McRbyWCgk/pAl6m1F5OFNsPAovTuX771pO06ccZXBw1LofH0d+GdAPqkis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=GqdioX2G; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="GqdioX2G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvPR18lMKkOnr6Z+mt9FvsiO1dJa6CJt2tZ77f6xEjI5lse/EnJo2baTZYu7RthjIQ3J72KZI8CZeMFFjBCxtsU1V/BM8KP/Hp3+EQ6cF26wmCNJWIB81AFGD1XDrnGRlL+1oHbFBdKjL8ZN5Xwn+9Ge9JmYmcE77T+OlnEGMyL4fsjRzeFjZHnWxOQBl8BD775lE+8wgIztiPB+J11HXY/EqmZiMpZxM7FXnPhwNOxQunFg9E4DRw8J+GPHCF0WWqf0Y4o2u5F68kiM73TLKfQnra126aMu0Jpmo2D5bJhA5qJFmNdpAsEJlMm2b+47V6dJR1QW87YEY9iXTAq4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJE0s5uoQU+frJUt1aMmpvLr1PoXnpQL3pajrrBcrUY=;
 b=fhvKlzdiERvpkj1vqMhARnNDAcuQ+xmnLOsmVtdiVJ70+A7I5YIzD0piG7I/Ly4sQrJvm4n/BvAG5u/pKaVYP8iKgc01YOAjv9MwlSiie4Y5SBAj1zFUGvLD51beZEjIMQk3D2xshR4z2PtUO/7f54iYdzbfnh4zQMOHeQXha+ldgIV2scyS1M83tbER76FNGY+9Uvk6bPDYnnaqD99u/ee+58Q9a3VQknrp33lqmcakeflm/KIu54784EoJRrCMGbQWCOBalpioDCPXoSX9W3Q6GCm7DzYuql+oThoO7CtPvkM6Xe1FlNUMxkLUgUpfDHJermAi6eWdRYCqQUgfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJE0s5uoQU+frJUt1aMmpvLr1PoXnpQL3pajrrBcrUY=;
 b=GqdioX2GSo/sGGYzx1UETQSjvFcb+AmO9KMRY5KMGVmxNhcGEsMUEylGU8bzY7pi2l4vyOwr9OuAzcDP6Ky/6t8QKXLvq+XE81A50JdTivEuBDw3bYw6rXOjF7+lkaiWs7WiCQ+tZdzKBviKhTEpOaOY1TFONtKXTgjO9XuYph4=
Received: from PA7P264CA0196.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::9)
 by PA4PR02MB6510.eurprd02.prod.outlook.com (2603:10a6:102:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 2 Oct
 2026 09:49:51 +0000
Received: from ZR1PEPF0000E460.eurprd04.prod.outlook.com
 (2603:10a6:102:36d:cafe::15) by PA7P264CA0196.outlook.office365.com
 (2603:10a6:102:36d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 09:49:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 ZR1PEPF0000E460.mail.protection.outlook.com (10.167.241.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 09:49:51 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 2 Oct
 2026 11:49:50 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 2 Oct 2026 11:49:50 +0200
Received: from pc67698-2615.sto.se.axis.com (pc67698-2615.sto.se.axis.com [10.133.4.43])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id EEEFA2AE7;
	Fri,  2 Oct 2026 11:49:49 +0200 (CEST)
Received: by pc67698-2615.sto.se.axis.com (Postfix, from userid 22105)
	id E07E6591DF0D; Fri,  2 Oct 2026 11:49:49 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Fri, 2 Oct 2026 11:49:15 +0200
Subject: [PATCH v2 4/5] ARM: dts: axis: artpec6: sort all properties
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261002-b4-artpec6-cleanup-v2-4-8452b5d045ad@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6705;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=RbTvUpsJnnUI1OEqGUbUI4wBld+WXF6zHPxN260TwAo=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqv343Lg43EWpZc4LJImnf/fjNGe9Muo0rdfK8i
 cBGzT1fgT+JATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCar9+NwAKCRCwB25JC3Fh
 az52B/4mPjn+l0u2eD79Csbe29Z5I+zLLa8/SK9vTYR3s6Y6KuCU2uJbEekudRK+Vm81ZpA8j0P
 9sbg3Nb1n0zlYxhloLYxCOJMSjfr32ztTNkL22nx0u8nrYahRoWVF67TGL/11XaG9ZWveqsndEg
 ZZuNONuVlSDBI1vdxObs2zrNUF0YxDfe/c8Xdw5cyAtAaR3R5Ui2+mVOAX1w3HxUy9Nq9w6lB1J
 ARFNdkuAR7mjWvzbLQ0eHQJXdCT3AonmNa5qJ6+vf1bETKnsMljYF46ksG05JqEDyOR+pEeRjVz
 8z0dKdU6QfmH+9zSgXnMYT5HexPIPXqnPJ01U0qnI+XZOPt2
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E460:EE_|PA4PR02MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be0c8f5-f49a-4858-4432-08df206a80e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2xsZ9BwPjOLBHgBxQs2djaZmIVw4gVMyK6Mvsvzbap9dQg9GRAb6c8T91tg7TLCqayNdvRWyV+o78TmP6/qmxZgpshAhm9V8vOZU4tNCdpZvBTH7qATuXhXjqcgH3XjiyHfBwzhJ3Wc3YCJ7hRUB2U6inXaeoL32Wymwpa5P3A7as1OmSTDZuGm2aXMVaqK3RxKq55W0+cwC5f/yqsEIK2Yl7QNuEAD82TTU4GQFdo9D4+1YOSKnH+ogLP8j8xAU2SYBlkTPu/nFDe0fHja6aIh0oKSOlleXpLaBlSsEA56TRX79ScuUkS9n38WZmF3cev4o3PCyU84nCcwvXOh69Ie4YMYi/Lgzh5qj9cIltS3AD4yNzYsN+nOXFZcstDrZXL6OubSuHCXH0JUVR6zsxaS955rNExJrltLiRfUy4eMULLgjGKgov1bX7DBqC56g/YAsbegStwOAWD88VPKIbQInVPB5/KOG73IERHKUnGlTlj7JXOvQCuQbekb43O/lGrhrDofEjdV7EamkRLiqMoBCwwTXMmBUCTNbMfd2xNNt3fVVRB1HH9NNPLc6sRh1NKvnH0PfogD60t+YKFRys2YBdAR7Ltli9BtcspWHNj9W1hGzZdlu7W4FbJiUrLAka1wgUzzHRu2PyGKNl5CFzdYXa+qiM0NfT1eVIPrbreLhd+jBmXZ2LYvPxRCdvWJ/SnTXFxP6JOcnuvPM0M/M1g==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YNz0FGPFYt2H7XP0W8gEzPO2gRqzTdRpEQFoL6CgUqyOGHYV1pvFlk38xCZYC0mOadT+KBQUErALWNMyJVSzkPPfCWgQMs7lnuYhN8qosV1h6iPomx4KGY93hliVujGLN17OQbNsLJnBRYePyk9dX+kggToMzZRRJ57RX/DxGq+pD7AOnnmgEQvjribAKiCWj2/85ndPuKe26IZZBwbAvRdZV3rBMufJm+9gXzmVizr0P7Z10pm2zAHcu8WmjusE+CtngqQq89zMChEqZOtcXFjPkD9YYvNVPUW8MZBQ0YI8nAM2WnJ237ituHX+AryFnTL4dg8p4sXRo1/nlQJ0EKSOjE2LF4ufqt8Ythb8nkQ2XrqzajHVe5uNY6SPiZnBtf3kacX+1t8GclvqLSU/sBMlChley3UUa5HfcTrQOuPtIbJq3miasRhMIVRwi/7Z
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 09:49:51.0584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be0c8f5-f49a-4858-4432-08df206a80e6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E460.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6510

To make as easy as possible to read devicetree nodes, the properties
should be alphabetical, with a few exceptions (compatible, reg,
status, ..). Update the ARTPEC-6 dtses to use preferred style. Issues
are detected by dt-check-style when run in strict mode as:

  axis/artpec6.dtsi:93: [property-order] property 'compatible' out of canonical order (should sort before '#clock-cells')

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 arch/arm/boot/dts/axis/artpec6-devboard.dts |  8 +++---
 arch/arm/boot/dts/axis/artpec6.dtsi         | 40 ++++++++++++++---------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/axis/artpec6-devboard.dts b/arch/arm/boot/dts/axis/artpec6-devboard.dts
index 042a9cc920c6..9a91f9758442 100644
--- a/arch/arm/boot/dts/axis/artpec6-devboard.dts
+++ b/arch/arm/boot/dts/axis/artpec6-devboard.dts
@@ -46,18 +46,18 @@ &pcie {
 };
 
 &ethernet {
-	status = "okay";
-
 	phy-handle = <&phy1>;
 	phy-mode = "gmii";
 
+	status = "okay";
+
 	mdio {
+		compatible = "snps,dwmac-mdio";
 		#address-cells = <0x1>;
 		#size-cells = <0x0>;
-		compatible = "snps,dwmac-mdio";
 		phy1: phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
 			device_type = "ethernet-phy";
+			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index 2f75a9df0963..6e69cde0a609 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -45,9 +45,9 @@
 #include <dt-bindings/clock/axis,artpec6-clkctrl.h>
 
 / {
+	compatible = "axis,artpec6";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	compatible = "axis,artpec6";
 	interrupt-parent = <&intc>;
 
 	cpus {
@@ -89,21 +89,21 @@ scu@faf00000 {
 
 	/* Main external clock driving CPU and peripherals */
 	ext_clk: ext-clk {
-		#clock-cells = <0>;
 		compatible = "fixed-clock";
+		#clock-cells = <0>;
 		clock-frequency = <50000000>;
 	};
 
 	eth_phy_ref_clk: eth-phy-ref-clk {
-		#clock-cells = <0>;
 		compatible = "fixed-clock";
+		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
 
 	clkctrl: clkctrl@f8000000 {
-		#clock-cells = <1>;
 		compatible = "axis,artpec6-clkctrl";
 		reg = <0xf8000000 0x48>;
+		#clock-cells = <1>;
 		clocks = <&ext_clk>;
 		clock-names = "sys_refclk";
 	};
@@ -124,26 +124,26 @@ timer@faf00600 {
 	};
 
 	intc: interrupt-controller@faf01000 {
-		interrupt-controller;
 		compatible = "arm,cortex-a9-gic";
+		reg = <0xfaf01000 0x1000>, <0xfaf00100 0x0100>;
+		interrupt-controller;
 		#interrupt-cells = <3>;
-		reg = < 0xfaf01000 0x1000 >, < 0xfaf00100 0x0100 >;
 	};
 
 	pl310: cache-controller@faf10000 {
 		compatible = "arm,pl310-cache";
+		reg = <0xfaf10000 0x1000>;
 		cache-unified;
 		cache-level = <2>;
-		reg = <0xfaf10000 0x1000>;
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		prefetch-data = <1>;
+		prefetch-instr = <1>;
 		arm,data-latency = <1 1 1>;
 		arm,tag-latency = <1 1 1>;
 		arm,filter-ranges = <0x0 0x80000000>;
 		arm,double-linefill = <1>;
 		arm,double-linefill-incr = <0>;
 		arm,double-linefill-wrap = <0>;
-		prefetch-data = <1>;
-		prefetch-instr = <1>;
 		arm,prefetch-offset = <0>;
 		arm,prefetch-drop = <1>;
 	};
@@ -160,16 +160,16 @@ pmu {
 	 * leave the unwanted node as disabled.
 	 */
 	pcie: pcie@f8050000 {
+		device_type = "pci";
 		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
 		reg = <0xf8050000 0x2000>,
 		      <0xf8040000 0x1000>,
 		      <0xc0000000 0x2000>;
 		reg-names = "dbi", "phy", "config";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
 		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000>,          /* downstream I/O */
 			 <0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>; /* non-prefetchable */
+		#address-cells = <3>;
+		#size-cells = <2>;
 		num-lanes = <2>;
 		bus-range = <0x00 0xff>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
@@ -226,9 +226,9 @@ pinctrl_uart3: uart3grp {
 
 	amba@0 {
 		compatible = "simple-bus";
+		ranges;
 		#address-cells = <0x1>;
 		#size-cells = <0x1>;
-		ranges;
 		dma-ranges;
 
 		crypto@f4264000 {
@@ -283,14 +283,14 @@ dma1: dma@f8019400 {
 		};
 
 		ethernet: ethernet@f8010000 {
-			clock-names = "stmmaceth", "ptp_ref";
+			compatible = "snps,dwmac-4.10a", "snps,dwmac";
+			reg = <0xf8010000 0x4000>;
 			clocks = <&clkctrl ARTPEC6_CLK_ETH_ACLK>,
 				 <&clkctrl ARTPEC6_CLK_PTP_REF>;
-			compatible = "snps,dwmac-4.10a", "snps,dwmac";
+			clock-names = "stmmaceth", "ptp_ref";
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq", "eth_lpi";
-			reg = <0xf8010000 0x4000>;
 
 			snps,axi-config = <&stmmac_axi_setup>;
 			snps,mtl-rx-config = <&mtl_rx_setup>;
@@ -333,8 +333,8 @@ uart0: serial@f8036000 {
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
-			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
+			pinctrl-names = "default";
 			dmas = <&dma0 4 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma0 5 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
@@ -347,8 +347,8 @@ uart1: serial@f8037000 {
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
-			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
+			pinctrl-names = "default";
 			dmas = <&dma0 6 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma0 7 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
@@ -361,8 +361,8 @@ uart2: serial@f8038000 {
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
-			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
+			pinctrl-names = "default";
 			dmas = <&dma1 0 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma1 1 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
@@ -375,8 +375,8 @@ uart3: serial@f8039000 {
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
-			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
+			pinctrl-names = "default";
 			dmas = <&dma1 2 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma1 3 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";

-- 
2.43.0

