Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB32E8DEF;
	Mon, 17 Aug 2026 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786935747; cv=fail; b=FIvL0RLJs57HvDZ1oHj+Wj8u/wq9Kd91YXcWb/js3XpThN8cWHviw/+3E3GFukkzUqKdResGw3BLTZJbMMIh2oFtNVGDFSpdK2klITz+DKZ68ddOCA6B7kgZ8QKtftcT8EV+JSwYwqnoq0l4brVcEIKUAPs5zJSwK9dUQEZjQpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786935747; c=relaxed/simple;
	bh=HkSyzdQhbN2Oz88RL+cuhdKy+CutW5b+y1tMnN+TA+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aM6PY1sHYPGpLuL+3h73oKEEw3Vwlj8fGk8s5KquIvV+vpyC3ivyB9Xbv3ae0MZ53Z2qNeNZahz7DZ2vDYO5XNjruZKgSFvV65x8p5NhMCE1CUXpmGoN9I8LVUefVmPl0bEwpY/qdfkUNpJSuR1LXhsQXHQAQuyzzwrUszzDnH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=UcJ+g3b3; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="UcJ+g3b3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogNjHmViFv8+gmH1T/9lqhpd07bfXzy5P+yARZcYTuGSXdDgqUV4W0LqzTWrScACbZYPtsi9e5yXOVgHxDcp2Hfj+Y5Qb+HkKRRUjL8WEFOGLg8rb+mzdLRmpq3d0nCx/0dSk6DDEDZ0XWLYgF/07leCYeYD5QoxKcu6JCEZMSDQzEvdNej4iz5urEQieFa+QQfRXBQ0bQ7QaWnyAkylLbS9zTBXxMpFAAYHasji41cXDuaesy1rUdMT2vXrDyqfRbd1Y8t9UeehTGSkUeXGYBwyG607MBQwezFnCVwcnpE854KQNdbwQTJfTtJID+RPzcdDtpcXf35vj/xTolOUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2MtToyfmZ9gJboHQFx87ezcjXIB+E2cX7Y6naN5V6E=;
 b=w6IzHDkRwvMv927PceP7XbHONEgcmlgqOfNCxG3HpTQk2a7n1WdX9VKJouNHXT9YIJF4vEiSRZ+Q5e189j6oQ4yWOfT9iuSEKLIdTlclqBTR8jQp8ue4PmOGawal5oZDcqWFhxp7oqV8JumAvr2BCOqXr8W3cQYxaoWiuWGPFSTMbESu+CrPHFXUDPi+NRSXPiwLm1s3vK8Ai1V1JH8Ea043HkOC0hQbHHenZEpDvt4+UdKyKUNAOlfVgT0XGpG9TrDVhoVfkaO3BOH2XTyAjjwXv5TTl13p7GW2dpeaKy22jORYfNumPtDdgAJIwHOFKLKygnG+ceO0X5WORlQbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2MtToyfmZ9gJboHQFx87ezcjXIB+E2cX7Y6naN5V6E=;
 b=UcJ+g3b3/HtTjXe7tDh+nVczoW8D2pjm1PW/11Tfra95ceLMWMoosx2Zm4E2GpZmsERte09UwdNqmMcz4QE0EEirMtR0ePqPmn6dp8dCg6zp1BJ898rZD+EmqKOZgQZfMf6GaPXJLX159Nq3NwYExOKgpNXtEHiXWmM7AyH3C3SDu2xNAPmotVQojl45XsLVqX6xWEI1/QImZWLoPUeNDX9kuMyPNUa1o9YAUBH0hcx1jyoPL8Y9vCa6cdX9Dc5fhu5yWjHVmKD6JM5fyGInxq1xn7VT4ScO5FBTweKPtst4vu/sMi77JyFedmwb57C8rO4RJQKtQyxgyWnA+vDMSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by LV4PR03MB8355.namprd03.prod.outlook.com (2603:10b6:408:2da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 03:02:18 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 03:02:18 +0000
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
Subject: [PATCH v5 2/4] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2 board
Date: Sun, 16 Aug 2026 20:02:11 -0700
Message-ID: <20260817030213.6769-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260817030213.6769-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260817030213.6769-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2664c108-c002-473c-d5dd-08defc0bf24f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	KeWpJJ18s4aGxdnCTjqcuEd+FZIOmUszE9Luo5IykQH98iz0I/wLlHAbicDuWPW6B13IiaqDr3axr8Bgx8sfO9ULrQaPpPjyRvwefeT0njEvZwTWjFZuCviLqaYPsMpuJiNhSrZ33QsrCHWGn+L+jAXCeAQkVlk5mLuMSDIbfkM6gXi8lmYoMQWUnHdkqe8JJLtPo4Dp1DLXdFYKSS/8Z03QCXxUBwUkp2Sb1Qj4kWa9n0ACM+VwPsKU9GoSl1/7z3Wxnybkm/uVG9XGt6JluuLsK0nyH46uCzrtyzxyv7++7gzNR0DlkqDCYsr86x8vIcpLQ66ts9a9NHHiaC6K0gPu047EQjAioIMnuXnbhK9GSqbLYdULzTzkZV4aituur31xAATn01bTGY7jV8Wqs3qba6Mv4TabPkqSuXKljYK8eD3pfKTdwyYcbNGwZVU78OZiJFlWg6H7kviQdhaDntBP3XE+mwi8q9E7WC7hjGbBLlDKp5YeApUxFQ3zBr1MHv5wqke7DzizNh78RBlMRMBC3SCbDGjxIfPlD/eIhH9FO8kKL1oRh5q6C7KJ2S5M4h/LGvK3XjfQzUFreAGC9byj06wf6Nl1uIVltSLynCJAGtsW1Khh81D8Pk7tCgl3d9+MnrNM5ReEuIK+aLvRjblnkXdydgMSA/NRmSRGKSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hqFP9FLTYLjzPoaE3XMg24Hybmyd4MWvvaphUbURl7zIz6MAytpF/Xe/LGYv?=
 =?us-ascii?Q?iqX1P5t9gyqv0JYCBIF8Zeumq0cact0URtPHvfr425XplSP7me72OnGRTLuC?=
 =?us-ascii?Q?/POCLAkTXrmJmfmsApnPQ7r+KnH/q/lzi4DHKId1TPcitqs5GIvX8piMeR1a?=
 =?us-ascii?Q?4hP4Eha/USyJ0KmVMKANj84ukCTnrdTiB82CBxOJ+ZlxMNPoJaQTwAGd+Dzz?=
 =?us-ascii?Q?yGfMlKyjOyW2s6Mu8JIzIZgea7aG2oFGX4JSoxi8A1vZQpVF3B//4luVbrl0?=
 =?us-ascii?Q?FVcg/9MdwQg+js8G5EmVtQdNK2tXJjsxH8hmdMreLVLIyqu8mI+YjLkBRRZi?=
 =?us-ascii?Q?srErs+o6lQusOX9sQ1abUGpBHpyyl2HpgVfxr6y0xO1YlkciFyIQjzX+FcV+?=
 =?us-ascii?Q?KOlbZ2dzANM9dGqIs2AONLDf1ppeb8QZ8ZCGO4Jawju4sa0zRt1CZrMwXij7?=
 =?us-ascii?Q?G8pSdX+cjboZfUeYC0IsVSGWI5Ue+ctTAEtndLP4C7Uaih5xaiHr6V1szg0+?=
 =?us-ascii?Q?1dzfDuPRm8zLmfboy2+AZv+wt/S4nFm2V/AOWaE58JGppZ19DeWlXtEq9O14?=
 =?us-ascii?Q?ZLah8F7Z6mPItMdn28mIaVrvuKV/SSRnpGTqiv3ofGQYWl/8XCAYW3vHV73C?=
 =?us-ascii?Q?f1NQSMiN3uqNCkQ3hXtXmWq1vx9DjW1ffI/8mfXNRYAcwCaN5MbPYx+2UyHY?=
 =?us-ascii?Q?xxbZ8Hb1Kbni+on14N6jbzuCxJpbp+D86wbTXo7+d0kdYRHyDJBQDZsXRTN1?=
 =?us-ascii?Q?sBPFctwo29/xzHR1dIBdRy1KSvVD4HSNjiZRhYHTnyIQj+Wet2RwUYidw5L2?=
 =?us-ascii?Q?LaH1XFFNCiF1idnYbMzt5gbJ+IcS3yXG3AtWPsaejASEvqyDMMuseTYvsgb4?=
 =?us-ascii?Q?UFhqmECuy7TCJ+ga08xJX8xB93ZUpClWKNloY55CZl6uwinx8Vdha385JKYy?=
 =?us-ascii?Q?qg8AUtJHwJzWMzQfHIurAiQgitq160sUeuPROrwYkMfqoLKfvMpWBzSsqe8j?=
 =?us-ascii?Q?DxESsbZspGNE1keDOehB7gPwyNPANLhmDFioACKwOrylpr9w/EhnDLxariBS?=
 =?us-ascii?Q?lTdjSWX56qiNjXYnWVvQTgfY9W/Vb+fNdep92YMcB0fOzX5Tkdfov7Y96alA?=
 =?us-ascii?Q?j6Fex5koZzLHNVx2jYQu+U83x1Zh2BP92VcJVv8mI6gJc5wHa29AcNoIhPfJ?=
 =?us-ascii?Q?kZdUfwAjRN5iivW18Xq6aLoxl7eywIxYKNzjBobcNKNCRSKx/8nNsdzu+qwy?=
 =?us-ascii?Q?HFP2vx0BeBqxLEjQB/fgsm4l0EuPiYEz8RE/dwmCgDQNeqZhVNt5ZgaPuWkj?=
 =?us-ascii?Q?vMtUorHUOgTCZrGsnqxefVfqfAJTZOiBZyHiPAM1VkpGLVg9Bgz61mNEtnD1?=
 =?us-ascii?Q?MFZwcgE37YTCISYYmsAURWIwKiTU3FCB9UoAntDsi18R8C6Hg3P/xvomRIjd?=
 =?us-ascii?Q?z162BYuVI/1cXb+2y8sPrrBsDalLpbf+7nashXvUHA+y+u/Xg8kUCXqr/Et8?=
 =?us-ascii?Q?opuVHZaIUozetkSUBe1fg5ymU3WY2jPzJspnG0MPZ9prEEhXcc/Km4QXRftU?=
 =?us-ascii?Q?pgikV4jt1A1dXOpE/6fiQuAZec0AaiQgQxy2eITNVixR8BX5bTa5OnGxFpT/?=
 =?us-ascii?Q?H8OLYggDlh48d/310fYWdSjt7MMtuCKhCPJ0nEW4fq8pYlMyUtkNND6bL+vB?=
 =?us-ascii?Q?VcU2FT1siOad776xDyjqWsIqua96gNFVvtS7E8KRaMENiufpg/ZFIqqHbqgd?=
 =?us-ascii?Q?Eo6LPUWPCSQ4XCtQV/PEMJsfGQ35MG/S1NdzEjjz8v769JnSgck7AWdH9oYq?=
X-MS-Exchange-AntiSpam-MessageData-1: 8/tEkyUmvuC2gg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2664c108-c002-473c-d5dd-08defc0bf24f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 03:02:17.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKThI3EcsQ9G+/ND/BhGPo7CO+BOstqinoH29BfqIjy90/Y11dRE8RzQqlY2J1G6df0zLj87Um4IxwOotjFiqFFha1ZfoGYaDgqrTTXjd3Oyfv9Uvd9ifdeNexwj94SHYSnbJu+yc3QgKNCB3SF5cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8355

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Add device tree for the Intel SoCFPGA Agilex5 SoCDK TSN Config2 board
variant. This configuration enables gmac1 as a TSN port alongside the
standard gmac2 Ethernet port.

The TSN port (gmac1) connects to its PHY through a GMII-to-RGMII
converter implemented as FPGA soft IP. This converter provides the
RGMII TX/RX clock delays, so phy-mode is set to "rgmii-id" to reflect
MAC-side delays. Use altr,socfpga-stmmac-agilex5-tsn because this
integration is not the same as a plain Agilex5 GMAC port without the
converter.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
v5: Drop altr,socfpga-stmmac-agilex5 fallback; reword commit message.
v4: No changes from v2.

 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../intel/socfpga_agilex5_socdk_tsn_cfg2.dts  | 130 ++++++++++++++++++
 2 files changed, 131 insertions(+)
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
index 000000000000..9d39f843b424
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts
@@ -0,0 +1,130 @@
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

