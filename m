Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E120B340409;
	Thu, 16 Jul 2026 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168438; cv=fail; b=ec9zOZLz6jJayRwVe+83pM1K7pML7VKtI30G/BQOg239SbjCfbJGFb59SP6KotKd+WoKxglIybyfnQU71/4pH7FUtlXITSZvwmGSFS4e6ywwU2PGzAnCVR3vnIN1K0A6XKTqL2UPnYVZMDbEnOcb5UGfeQLGT6DFv8vtszcLS/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168438; c=relaxed/simple;
	bh=379baYBYTfikFoorwm9/iJdbd9FmrFdW05SefflRxzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=llgjp4YmvmsY703J18Duue42kNzbToy4VN1T/XRo2IoUGuLObRwTnnOwcvjVlo7QVAaj2YsOf+OYcsNMkCZQ0MeOC2o3ThFC61fTdIiRlpAv/QRgwuYjclJrZRPfwHw5073jq6tSlFOelauKVNnrnRkwSWajdQP0tEjOCbPxgOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=P2T67gTh; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="P2T67gTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceZAbWqlWrDYcV7NGX0IEqhOMlDqcw7wPjOnPSNEHyIigVU0eQBY0oi0vRM/K0GlgiQstoe7fbGErcuEp7SgJ19P1exYbIJLUtLAe5qywGNbyKHldh3eVgvVeOhTTnLKfIkohjVuFdgO3be5CL/P10m4jx0rxeQ7fsQEdtQby8TFzPDbqL3DIWGpzuduiQTpaG2ryI5gWWR0Nc0aEY/FxkNYR3cYemxD5k/HvBLnTwYy13TrHDpB+TFMTfyhbfN0MvjPTgS9sBVw2kV5fQhAqk9L6YDQ2996yxtS22kgX1HX3RVoVs/BY7jy9DCGjneINteoP8SX8tbHYnIsdHGJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjMbZguedR12RMg1/SKY7IcKNWiCB0QdZptHZPsGaiU=;
 b=APecCjrlnYDYf5zQ2Nw+3ytyiaUeHL0Uwja198uwbOVA3PFZbyWCtHQix6ICa7Z5+7M767jPssE4fvvQlMEh7z5tDFHxXOmKnm9XcUNVo+XIie0BGgWrMFVJk6xF5JVFigx2IS4PeEb8tRX+tPOhDrdytGzYbyMGPb2PyB9W+oH2YM5SeNoGpm+O4L41b7hxl+PbZcCY8vsUdUgM7Jv+y2o9tfT1SJxVLmHaa/H8sVREN+6dQ/C2KKtHk6ckBKJ/9xgoieaVLVSdDPO2FzvR9sQwFvCypyLs+7YHPC0NIOWFzclWC9Lkbsrkk6dQJZXow7M1Ftcir+qC32qEcROJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjMbZguedR12RMg1/SKY7IcKNWiCB0QdZptHZPsGaiU=;
 b=P2T67gTheGJ6pyNA7AtnnvFkqZxOa3Kbuf5+Qq+c2/w8epkEE031zpxPgY8hjbHmAl3L0A3E93Nc3o5FB+V+699+VLoVvVapYubb1FSRjtk4s62O9DKiNu9Uu0QG5xgH70G344wksdZWCdcWAnypkRj8QzcUsh2aEjmDnfI9GJWkM500UMdItJ4hYNh1aMVmR96aQlvxxCZy+ElZQMu6Yr8yPyAg1hOkTbkcrRKj7LXFfsRMMX3M950qLD4usdPjlI8WybiUoJj74tHF42hrFaHivguYNYXACjs1HSwKdSNuwRkl96Gr8p3PzVfirC1wYWEOjPuu8a9cGskFEFD7rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CH7PR03MB7884.namprd03.prod.outlook.com (2603:10b6:610:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 02:20:32 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 02:20:32 +0000
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
Subject: [PATCH v4 2/4] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2 board
Date: Wed, 15 Jul 2026 19:19:30 -0700
Message-ID: <20260716021932.20037-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: e2fc884c-5001-4483-bec7-08dee2e0cf1b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	pAmxoKlBFDDfIArXkMyg8Ozfj2b0gnjGeeolDKxlg+bTkRlDmB6Mnl+RONC2crajiIE/y8aFCgfWJHPV29R1EfMY+RZ+OodBYXtlifRBGKyOuUmeo6fvJkIJ9RncQ1H20aClVd3kb9IWp6rM1iwKSrMvTFkdNtGg8hLI1QR3SRQWIjChtDNwuFYh2vU9OoCVP/78zX+Z1nYr27BtnfVc6r5jFiveMLb2P+8OsTc5ceS+hi6ekNQQklawvkUql+z8CeGHkjTBKLKv54PMXkOLLcBBOaXXziwj/MF22kXGog5LTh5PcD02vvjaiYzZvIHK9cMk2f3ZJreAbM6PogWtdLOH6C4/kw//9fdvGSArjGUMuYFm4xmnakg3NrwJjjv1Jd/N2uAA8s2Arhe/+XdabuD1SEfgZ6BxbW6aNUfllNIIQL3HNY0F/oriC/BaVSVIGZmR3deX/mNgqLujOQeVu1ISCpOOCeerFrAbw7tqV48Fp06PWSTcVCOymIw7OEO4VO7+QTVo0iAqd/xcHFjBGUj7+lEbzU87wstXmf2cZhrFyHnqGh1s/EOfaa6JCx/ZYaZx8c4caK/MoCLaGuB1GWLyAlbZSQ8IDZQkevxWR2szPbW4OCFg7+ASaKt5LkyjkoD2Rue8d9t0cGRqgrJ0hxfJQsUw1Krzmdf8XKaW4Jw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d/+x2okkEh+2bRKpxzDNF9B5Nsw006reTa+L1jK9vuYfVcGstJY5CDLiOQne?=
 =?us-ascii?Q?ewXLfiiZYKjSuV/zVoYOY6qh2VwBgfhoJsAlxZ5F0X3CyPZAqy1qUsqwtl+W?=
 =?us-ascii?Q?z2FvCKQm0aZsBEbKx1ODTSfj0O50+fUuRvpkhK68Yo1eu+tRt+eT3tLWu2HZ?=
 =?us-ascii?Q?5Aoq6BYGFZCoKhhyCagGvMcIWPt5qLmHaXFkuNBhAiRLGytmaKmvXTfe6zrP?=
 =?us-ascii?Q?vB2MttNHKaLiqgRzr8WnPfDd6atLVG3xy7+4/q0oTuXT31VLcj1cjlU1zzdC?=
 =?us-ascii?Q?c3XPg5/oCTtcKNdjeZvkM0NUjJYQQUIN7M1Ab2t9RpOCpkmYjJpuKcTtn8dN?=
 =?us-ascii?Q?ej2/nKQ5gWkeskNexNtN9DoHxv5m739fsTtjF1UBNxy2N8DIKK1cLWXysBdn?=
 =?us-ascii?Q?+nMNr8uoWu5tGWWY9bq39J7ExcDbh6cTnlCo6qfG6AqWadkmBiL2xz7AzTnj?=
 =?us-ascii?Q?nHnWcy/kxW+pY0hkq2hKyV2MXR3pN7tf8uREpWlrj1LgwMfJBYCmp9RuaCY3?=
 =?us-ascii?Q?LABwDCuxsXB6qKMLtDeJbqtqEPj3uo7a5d1oIMBFS217Ct9iIeRsrLtjbY1V?=
 =?us-ascii?Q?aYKLrD7IDXhoSumpBzpd7yNVWFK6tEkxOrFMopZ6cNFxobx6H6r85CW+bd8C?=
 =?us-ascii?Q?XpeqQ297FPeC3wBRPR0O6CfuBOnsyFRlzEoErg2a24RyHoIOEyKa5y8XkP82?=
 =?us-ascii?Q?0eu7SWEKd/afixsPGj9FoQTBwaVkzgA2j76dubi2nrBuJKlLaqy8SStxPKA4?=
 =?us-ascii?Q?FfVWNjhmiKVUjWuEybVykXRdJzCAm2q2TZbqHTxn+D5c0yC12M83FM7N1rkO?=
 =?us-ascii?Q?ClnZesD/rPZ82SwaF+tyjp7YvT6YJnwSI6Nhdpitxx6GR+9pFvhc791KOugB?=
 =?us-ascii?Q?8q+nkLN0TJzU2Af4uZJwvECK7vGbbwvqbMBUDnkMaf4gz1Vsfei68edQhx9x?=
 =?us-ascii?Q?/1tn2jCWJwjWJdljThgx1qdMHM8T9G/Ub1ain26MlrLiiReoFARGiDrFG7pE?=
 =?us-ascii?Q?smV9lsiar9tihEMbHap/SqnaIG1mi2US30MEWSW7cO+qpWesmXBBGSVUZQkV?=
 =?us-ascii?Q?88DK5fTc3k7OC9io1Z20dKNXwBMRYmHJJD560Fy9tZGS7DGCvLuGqpnVf2VC?=
 =?us-ascii?Q?5p1GgsQCva0QOJHgwVcbtNbqWjA7h/TqBtbSXAbOQ90L7aolFz0ndPS+4MQZ?=
 =?us-ascii?Q?zWMD6OG0sXcVxYnXXlwejj/VLO4J38/IXi7cmEqDoROA7aw5OW1ZeGCSOXDf?=
 =?us-ascii?Q?vO1WSd0lX1vkH+Vkd5UwZ6ylXgbOSADIEOhubrJg9sWXWeC1pjseGn+3QwNa?=
 =?us-ascii?Q?Mww6e6fOXXZbPTSqILQIpYHtDskMNgxrP1obh2c9kiPxjeCtJC8FDt0+BDub?=
 =?us-ascii?Q?fgq4VQyGYtFqR0M66bVyLmiIi8+cs7Onm2rgNXsL+g+HsZuJJdSvV3GeKmyX?=
 =?us-ascii?Q?Xi6AEBpU8GfzupO964OYJCZzB6wRQUBiJxYIKXpLOoNPozRPJjPZSnBBW3SZ?=
 =?us-ascii?Q?Prg2UOE4UNsY1fAegp6Etc1F/hWGMdx2daEYRlW5uiFLgeu02Ke26Aj1cWLR?=
 =?us-ascii?Q?uJ7ZrEiuIBd9UIqvKSO8noSh5wO8LxQ4l/DKBk2LeVufbMnMXj1bw+UmXTLi?=
 =?us-ascii?Q?wBm3O4oySbYY7+zslHTNy82e/6nbGApTT0sON/BPgt84I5oyaqJOpLI3kfAr?=
 =?us-ascii?Q?8nN28tWbRGCiZ85k9f4duKetk7aBgiAAAMFe8Z33UamLGKyyBItjKqmjdZKD?=
 =?us-ascii?Q?ltsGzrVjv+9Mt9FOwIY8yLNv4ZdlifFLY0zRhj8LgjhSbn0PRdK1WMsjgJPs?=
X-MS-Exchange-AntiSpam-MessageData-1: 0GBRcqjHVRbntQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fc884c-5001-4483-bec7-08dee2e0cf1b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 02:20:31.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCRPROs1Jj+bFM81thNBP8lDu1aRK0QAHwjSxq1CgYoP2bdi7R/IbCsbty0pFLrZbppfZzZy+/EdsYeVyvRvBqlMPhIqMVFdz1hCMPtH2BQMvyN7v8WaraHQgjZa5rn2FEvbQrmF3k0AG3r61ojcfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7884

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Add device tree for the Intel SoCFPGA Agilex5 SoCDK TSN Config2 board
variant. This configuration enables gmac1 as a TSN port alongside the
standard gmac2 Ethernet port.

The TSN port (gmac1) connects to its PHY through a GMII-to-RGMII
converter implemented as FPGA soft IP. This converter provides the
RGMII TX/RX clock delays, so phy-mode is set to "rgmii-id" to reflect
MAC-side delays. A board-specific compatible string is used so the
driver can detect the converter and strip the delay bits before
configuring the PHY.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
v4: No changes from v2.

 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../intel/socfpga_agilex5_socdk_tsn_cfg2.dts  | 131 ++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 270c70fdf084..ce7cf3a63275 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex5_socdk_013b.dtb \
 				socfpga_agilex5_socdk_modular.dtb \
 				socfpga_agilex5_socdk_nand.dtb \
+				socfpga_agilex5_socdk_tsn_cfg2.dtb \
 				socfpga_agilex72_socdk.dtb \
 				socfpga_agilex7m_socdk.dtb \
 				socfpga_n5x_socdk.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts
new file mode 100644
index 000000000000..bf13ccfc1faa
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026, Altera Corporation
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 SoCDK TSN Config2";
+	compatible = "intel,socfpga-agilex5-socdk-tsn-cfg2", "intel,socfpga-agilex5";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "hps_led0";
+			gpios = <&porta 11 GPIO_ACTIVE_HIGH>;
+		};
+
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gmac1 {
+	status = "okay";
+	compatible = "altr,socfpga-stmmac-agilex5-tsn",
+		     "altr,socfpga-stmmac-agilex5",
+		     "snps,dwxgmac-2.10";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac1_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		emac1_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "micron,mt25qu02g", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+		cdns,read-delay = <2>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x04200000>;
+			};
+
+			root: partition@4200000 {
+				label = "root";
+				reg = <0x04200000 0x0be00000>;
+			};
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.43.7

