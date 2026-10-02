Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460A47F77B;
	Fri,  2 Oct 2026 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934605; cv=fail; b=DTtg7fwmO3yh02NKcxZGeIpzGaHbYk2IPHsqc7VOIRsMweaQGgT/tbJQukvVu1+jA7FSQHEtGsI+OeZcjiFRfWliL5xeqvGQhVGQKYFbufGN95RTLrXOcqIjYG7UnZ2813BGi/8jnC6wa6kZPM1bbLHU8dh9/8PGKBw4E92Ksw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934605; c=relaxed/simple;
	bh=Z5eWUMhECD6ubIIiGbStKJXNdayJxST7mJ3oJ7x4ZyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XDZHsu/0/rQMaefXLvbsC/zl8bDYY5yTe1qqb8x8Ra5zwheV64pQPOc5wQywb/qLLtl3hS64EEw0ftd7HdczrsF7bwujSqWL0ir3dNug9F//zyUI5ISpqagEklqJ2ot30B1Hriq39z4nUFhdDq6M9NwYk2suuYiaCsXuB0lQbQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=aW8GDcOx; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="aW8GDcOx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4KE8uV96i4e30EI7dyBYUOG+Jcmdu7OD/+XiZLo3vzvS/x9LsrOPMvC5Vptnrj3hq2XcnhsmsqszzU+V9SQ6TCWI/+OVlxVrPgX1FsjJqB1Ne7Bq1T8UHdtBEeC/DhECJT9bqlTpbFB9yn3lKXrCzENdlcnaXnPjK4EwdhxL6YRJQwN3Bm7+9HmDArQ3iVXFtl4wNuht/Lw3UhbRPq1pN9pD3oSSC0qSvr23HzwxJRiGsNtirJmqDJKD/vvIfvv+ToQpaSOwf4L6asbfdP5Ll/xuQ98QpHKSQi4dRuZ0Anp2vT+G9/2JJxWCpZZNm9hFdk1qscLmI1x9JvJJSEgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eH+aKylyKaYOSh0SIOvvcQylJaJnJCo7yobbNIcC32o=;
 b=jFZGMm5TmDadXEO+t8Dz9DBbYC3B6kJL6vFmDf0eyUMImCq44aeocsWPzcnQaD8cFvmEweD15ZNdv1NuZTYb0gbBe7Npn2ye7TPPX6wN8WHfY6DZX8HHBu98BKCKeQPtA8izwZIL0q1Fyh2pwc6w+R04n/QZqYJ/KvPZNs2+GAFZ2Fge7Aw10CULBAd2dVhG+zCQnCZeqd0HTqB6ViWlXU1Zqf85CQ41KvXmNR2VIYyb169gXV299yp5KBooIDFiyC55VTgZlw4dHYR/939Ns64y5jIDhTZeLPjZKNMF1Qx5CWkYDeIwD74qJhoP0IDa1LVBGrPkP0Qch5Pwf9rjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH+aKylyKaYOSh0SIOvvcQylJaJnJCo7yobbNIcC32o=;
 b=aW8GDcOx88Ng4qNQmE4TB/HOX3LbFIad6tprtrzlw3OrmdrqQJgFDoN2Gs5Qai14yC2XlAKffKTsXz5zM68OLQaEbVc9gbPUlmSgL+ZnbR+l5oDRxklGM4THKmfO+oD6edrqUQTB6KpMIajQnrGGoRD0MTkBDLzBJj+O0H27kJU=
Received: from PR3P192CA0019.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::24)
 by PA6PR02MB10591.eurprd02.prod.outlook.com (2603:10a6:102:3d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 09:49:56 +0000
Received: from MI3PEPF0000849B.eurprd03.prod.outlook.com
 (2603:10a6:102:56:cafe::a4) by PR3P192CA0019.outlook.office365.com
 (2603:10a6:102:56::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 09:49:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF0000849B.mail.protection.outlook.com (10.167.240.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 09:49:55 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 2 Oct
 2026 11:49:50 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 2 Oct 2026 11:49:50 +0200
Received: from pc67698-2615.sto.se.axis.com (pc67698-2615.sto.se.axis.com [10.133.4.43])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 06BD92AED;
	Fri,  2 Oct 2026 11:49:50 +0200 (CEST)
Received: by pc67698-2615.sto.se.axis.com (Postfix, from userid 22105)
	id E22485A2AC29; Fri,  2 Oct 2026 11:49:49 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Fri, 2 Oct 2026 11:49:16 +0200
Subject: [PATCH v2 5/5] ARM: dts: axis: artpec6: add more blank lines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261002-b4-artpec6-cleanup-v2-5-8452b5d045ad@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3722;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=Z5eWUMhECD6ubIIiGbStKJXNdayJxST7mJ3oJ7x4ZyM=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqv34669j8cX/2eLL+DfPg9e3M7meX/ac8N8pm1
 Fzk54Z6mCyJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCar9+OgAKCRCwB25JC3Fh
 awaHCACahLYM3iX5iiELshtG8+DIK4bIeqzYaR+ZcyktcQuNgVkbqlpwLb1SdxoQJZTHp4ys+t/
 PBBE/fWnO0S4BV4nA6Q5GfxstgfJUPElap7jSDaRmDmhmcmV3PMeLwUZYnqQ4tNw6Ol/nU+nQI0
 7W+TzKW2HIA8aCcv0pIWSkiFjvQLwiFpPcborFSJun24FNUO6xM4GJvRX90bW6Ko46YrWCEoGHZ
 qSxT0KMZ8gkub+jdAbq+yzqaLJHK9tmUc917TvIaqfMHOYCs8I7GO3f+AjCaTxHRZQJM//1d2IX
 cUJraEbMFr0ztsXN8hIjF7ud73dBCYqhZk8Mu3NMogVgu0wV
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000849B:EE_|PA6PR02MB10591:EE_
X-MS-Office365-Filtering-Correlation-Id: b24b206e-8fcd-4c9c-2766-08df206a8366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	JvNAi8iBFNPUE8eAr1wp3gK4Pjcd8TItdM6LCaOoEbFVFNIGfKmttZtaoqxEi2eqn56DrJW1/YipcJUkjFJ6BVecvYQ2zpQMYMRZOTGa2/YbuPhHkjokoaCh48jdVR8vNfMvJ6FYgg6S6b7K6i759bgvtgIr4lG0/arHLejB8Olxa5LvG/EfHumG6Dkslw4YxRiPxIkxCN6JvaxPgC43AbCUICf+fYFyfS9Cc/HRJIM7ErFj2jC64DRdatrYfAH+EFXsYe7+5egnTCeqzoG6/iNHDUYt0NLEP4jNKWYKI5uHQQg5Me8aZ0PJ3BtjYNZZv2gfubRY5Pbcto0lVoS5q0Qaza79xS/YNSJMV7PA0EEKt8clziQlkDzaeYRP3G2jSYbTBL3oFEQ9yOCkRhs71ATPjMTEGRiO4NmdROSSN5V0AisdwblsMvvRcQ+TgPPDNIFvIf7BmdnBa82AdnxwsHGRhjSx7pxEozMwVh4OCq2cEFpLmDXNEIv4mziFzbRzSQJ9j/GUSpDPl4kZyhQNyRXXpg2YLWEWntT/i5T1Yrnk05QNqHLmY8h2/bqHVdi5utsEcAv24m4TdkIPIFBMEpW4UpRRQ9M3AmjNVcz88tb13q6gMtiY0foiWMFpEw+cik8plI3HDIoPGk0Dc8WyL6r/utAJqP7tauPut+2nxbutYrLfOoVoUgx1GlfB4AAUDraUBDUVB4mzJcJQTSGCEA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U32CkIFZNyv7gbzcUAvKqFies/40zhvoIr2CdnGWukttTyc0EmDDfoPSAq41x5VzEnLKHS/VcgO5yJZEd7NpgXrrNzdecNmE4A/9rILM4XfkFcGmF5zhnYyx/ksDFAvmz9PhxZoqPbjvZSEeS9ashiwQEBt5yTHL28bZPaLQ8RoUdTDJtU1CUsXQ7oOHIM6inJRyVXdlh02pVYTt3vBkwSXHjmpBEbSlW9nDRoiC0dxZgEbqUSge89tSxxgDoJ7Z+FaumU0MgJZWXpD3QZm3uDqE51SsrbHfz6XPPUeJDidJuV8ThgzPpDzmJU5nBHslli9A6NEEzMEGE1NeCXsBDqJGtWknUp57SFRchl9BRHUiYzlvRltEQsSBNXqqUfM0mj0bliTrtqNCgkJXk5QRwOvRbGfLMZJw8ZkakSDWv8CJbxcQW6medn+6B+5mJmE1
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 09:49:55.2436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b24b206e-8fcd-4c9c-2766-08df206a8366
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000849B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10591

The status property, and each child node, should preferably have empty
lines before them to increase readability. dt-check-style in strict
mode reports this type of issue as:

  axis/artpec6.dtsi:186: [required-blank-lines] "status" must be preceded by a blank line

Fix all occurences.

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 arch/arm/boot/dts/axis/artpec6-devboard.dts |  1 +
 arch/arm/boot/dts/axis/artpec6.dtsi         | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/axis/artpec6-devboard.dts b/arch/arm/boot/dts/axis/artpec6-devboard.dts
index 9a91f9758442..55fdd610d3ed 100644
--- a/arch/arm/boot/dts/axis/artpec6-devboard.dts
+++ b/arch/arm/boot/dts/axis/artpec6-devboard.dts
@@ -55,6 +55,7 @@ mdio {
 		compatible = "snps,dwmac-mdio";
 		#address-cells = <0x1>;
 		#size-cells = <0x0>;
+
 		phy1: phy@0 {
 			device_type = "ethernet-phy";
 			compatible = "ethernet-phy-ieee802.3-c22";
diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index 6e69cde0a609..c9f671fd685a 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -120,6 +120,7 @@ timer@faf00600 {
 		reg = <0xfaf00600 0x20>;
 		interrupts = <GIC_PPI 13 0xf04>;
 		clocks = <&clkctrl ARTPEC6_CLK_CPU_PERIPH>;
+
 		status = "disabled";
 	};
 
@@ -181,6 +182,7 @@ pcie: pcie@f8050000 {
 				<0 0 0 3 &intc GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				<0 0 0 4 &intc GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 		axis,syscon-pcie = <&syscon>;
+
 		status = "disabled";
 	};
 
@@ -195,6 +197,7 @@ pcie_ep: pcie-ep@f8050000 {
 		num-ob-windows = <2>;
 		num-lanes = <2>;
 		axis,syscon-pcie = <&syscon>;
+
 		status = "disabled";
 	};
 
@@ -207,16 +210,19 @@ pinctrl_uart0: uart0grp {
 			groups = "uart0grp2";
 			bias-pull-up;
 		};
+
 		pinctrl_uart1: uart1grp {
 			function = "uart1";
 			groups = "uart1grp0";
 			bias-pull-up;
 		};
+
 		pinctrl_uart2: uart2grp {
 			function = "uart2";
 			groups = "uart2grp1";
 			bias-pull-up;
 		};
+
 		pinctrl_uart3: uart3grp {
 			function = "uart3";
 			groups = "uart3grp0";
@@ -259,6 +265,7 @@ dma0: dma@f8019000 {
 			dma-channels = <8>;
 			dma-requests = <8>;
 		};
+
 		dma1: dma@f8019400 {
 			compatible = "renesas,nbpfaxi64dmac8b16";
 			reg = <0xf8019400 0x400>;
@@ -338,8 +345,10 @@ uart0: serial@f8036000 {
 			dmas = <&dma0 4 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma0 5 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
+
 			status = "disabled";
 		};
+
 		uart1: serial@f8037000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8037000 0x1000>;
@@ -352,8 +361,10 @@ uart1: serial@f8037000 {
 			dmas = <&dma0 6 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma0 7 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
+
 			status = "disabled";
 		};
+
 		uart2: serial@f8038000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8038000 0x1000>;
@@ -366,8 +377,10 @@ uart2: serial@f8038000 {
 			dmas = <&dma1 0 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma1 1 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
+
 			status = "disabled";
 		};
+
 		uart3: serial@f8039000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8039000 0x1000>;
@@ -380,6 +393,7 @@ uart3: serial@f8039000 {
 			dmas = <&dma1 2 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma1 3 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
+
 			status = "disabled";
 		};
 	};

-- 
2.43.0

