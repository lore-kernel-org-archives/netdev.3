Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6637B3F9;
	Tue, 30 Jun 2026 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826279; cv=fail; b=R6HuaNl/OKlVLG4AuDHAp19IuJCH/MhjzMtiC3PofQSEmQWKpSHaLu3TKCJhdylLb6iKzV9EDCPUqgv/ZVaPXs8Dcw8L0Ak+3OI/A6rtr48I4IKedBx7qbOmYuRX/XSkD2RtEbVisdDx3n1RG6/OpY9lcvNIXuU+gjHvOTBwTQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826279; c=relaxed/simple;
	bh=013odVLPLi3XbVotLhtPZeiARrowLxJTCPQpkX/U3ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oTPrFHUdjU1yCzoR2OLcfD+QuLt6IFNt2glzRSdTWPe1Z+k1nPznJ8kGId2nJBw5GSELrIhsuSSXmxWQ7Wxopv+Amq06VKS+RwMH+3jrPYfBn2VBbg5pfaadjFKS0cTRPL4gTDpd0CbRcD2/GAN6CSFux515BlQnN6IMCsRKQNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=NPS0pjgb; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="NPS0pjgb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdQcP5UxkU1qTZJ9Kp/ZYzyRxfJCY9GRiwYdhil8ExR+ccPTmecLjTrMP5rbVlUm5M8kkv37bM00oHfd7IaPsJUSJBAMSRSptPUBoiyZl3ThcHjrGelKQ6Sf2T+8L7dAqB/F+cQkbnBit8ERBgRZ0C/g+nysmaZRK3uDAxSmfNKvi+8urPUYOylc3wKyZYoqS2AKioQ7uaJ8x4/jkHbKXbvWkm/Sb9KzTEaUJI1IAIbD1i5rGJG4MzuwQhTvbC6mUigS5uzIHyGSiW9rr7TNlKaZeEa2P4w0EvpU+lbTyWTuLw1twL7KAHtQkKV9daFBpFGyLnElCzI4ZDRpRqICMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbXlLovb4H6Gdc9uKHB/7utx5WZwtewrEyKBzVtoB50=;
 b=HYJjY4OBV+fv6SFJWILmS9iCenyAfuqkksc/LEe0pp+NLAlGTdN/g0tT4UitA6ipvNG2OAJCKLwpu/m9aIhIlab8sDPBvKuVd/PlpfemeRlP+pWHqZOAoAJgOrGoBpTBbdJc04Jkw6k5CBLd1zg1Id6IOJyZv3cXuVIsvcUYEQIzbYG8Ke0xWtA1IqI8ypIGFiOUg7A/PCCzQSpD7V1F/0RRYiK/wUJrqoROdXEwdhm9lem8eIA21naWHjc9KBP9KBMJcoA2ylWEafQ9YMTd0jzZpIhHKkzWtJ2dj0aCC5Xbxpwskin/+upYgTil9HY7wuA4zXMbgDXu5mUVg6ESdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbXlLovb4H6Gdc9uKHB/7utx5WZwtewrEyKBzVtoB50=;
 b=NPS0pjgbJUvlaIJijqnT74UQl+djnpmIMmRe0grkdMm4CkJ0SeZuZ6z7dKu+MlRw+jFZfBGrHfV8ykIxSVTLy+5GALmQRaq27u7CcvIjvAPsI6J43lRw81/AZnia9UiudMrxaM3BK6DN+q39Bnnsjt4wJ5K71rTZAlEZuBKZCbKCdeVxQhidmOYxgg5M2Q4MdL34QI/E6MUJ5nqu8Gem+5xHKXVWgYCnTIUPi40EvF2EC3rytjm8hD7yGpAHI/ImRt4spfi/ZQ+br0K3Yz1x2wLUL/BdFcQ60Zu1XmZaktSno9v/M6KyeesyAYRELeJr77fVu9Fk0Qk31PKYA1XitQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB6955.namprd03.prod.outlook.com (2603:10b6:510:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:31:11 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:31:11 +0000
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
Subject: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2 board
Date: Tue, 30 Jun 2026 06:31:07 -0700
Message-ID: <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd68589-d105-456b-d096-08ded6abd9c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|55112099003|6133799003|22082099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SaUnW4cDPJntbX4RB3Sqtil75RRNviQPtVCVGQccuckM76Lb3qbZUQjCmxpC/sW1obcsdtOEpO1iTNWwQ9F9A5KtlM842Ce/S4P0aXDfd0Xr6Ehs913fGfDNueKMD92BOYkyBX3t9pwNsOOTJWQOn+qvUeCHn6QYjXEozZ9yvV/zcHcPtrHC0qZNDvUigXqeliJRzPbVYBM6WbvWXHvRNa65D6lOuDM3irtT4H8zvFuzqbS75s02RY065G1Q51fc/ajUR9YV1xn/fMjzUXpiKkwHt1c8YkgXeZFYElgYKps1Uc7R6KgGpXMgls5J8kDQcBGmlYtgBFZQ0DKoq6cmNEBrRqrRsFmspQczUyt1DJ3Wht4HDHSqlYnXOldQ+jA4eR/RFnrfdowuzSBPp6JcwcPFGIPpdVzXDNCzjm3QKPE7j890xtV9hXSpwhN7FM+V0GpB6LsEjxuMgLM+hrWM5GwENvIOHwS79ZJtkNrkPWY1/loCE4mXK5P908Pv1k1dDP1pB90q/Akl/JF/pM6iOjU/jhAyUcU5y0XID+FmPdPEmPNwTrg59P/Z9RIrwxL4Zy5FpBuA0GRwXTdDIgTEMz6Z7xw4UH95yfIiajkj10CZWZTRT80an04JsS47w96s1k6WDj35uEXXjLiPGecrfjpWHmjL6F3YxT9sI+VBoNA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(55112099003)(6133799003)(22082099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vK04y0P+amQ20U97TKXazpva5MSENAf0/t1SDSoq4He2wfLcfEUBAYFmip4G?=
 =?us-ascii?Q?0algSExyA2o10ckOXBU3cHeggCv4sVefLRmhTGvEPIg5Nun9j4b800YkrEpd?=
 =?us-ascii?Q?77y70fq0UQVbh4fvjYUPNh6qY6uR8yUqyP8Dz8ZNXbWhq6R6oYnTpYOnxPqR?=
 =?us-ascii?Q?BccIinw++xGBy5ryJHcdsFQaiM4Sx7oFKbhlBQKL3ycAcPqR27dnEYBiqmgw?=
 =?us-ascii?Q?unpuM4nAfGOxl2NqPOrt0Xrp3dT+jIhAAZut8ZrtnnIUghF9v9NQUj8bMilM?=
 =?us-ascii?Q?rJzeKF+AIH3UtHkOK3zDFYqflWEG2UB1qv0UccFrkdFQhL+cG+Y5xkUKirby?=
 =?us-ascii?Q?JjKJTl5CyTSUaggG/8KXBYbwrCfkfxzwHcwW/1fUm9ra1+gB0WscnnjwbAb3?=
 =?us-ascii?Q?t9kiPZE8meoeVJ6XAwwFMei1S6+qJqoZWivgvKCt6D1I6vCeqlD90T1YFrlt?=
 =?us-ascii?Q?CnQ4A0MWLE7zX8tVF0DnUWcl8Eh4IAar4K38eRJlUBU+R4nnU2lM96ai2awh?=
 =?us-ascii?Q?lGvVEkO3RxZe5qIoxNEDspmCHE6/SjcZ7iCw8L0si998yExXHQmk+UgSecRR?=
 =?us-ascii?Q?hJ1xCAh4ymqTyLFK6egULOKkg0E/Imr+aVX0HYYhR9H8ZJuf32hrkOdvo/Zv?=
 =?us-ascii?Q?x+K/hD7piK0/glyVdmbXhz7JmiSeyWjnGwIS2l/AkPc/5Sj7iQvhKQwG247w?=
 =?us-ascii?Q?T66BouDMv6kLzuT9cOCVqGeMIiOdv6mkaj71XXbF/u3RKXKz7eFA/UeFM2AJ?=
 =?us-ascii?Q?9BtycQJX9rayzz007t3Lno2MZ8ov700hPIWeXxCAau/zeDqAcSaxQ22poc5G?=
 =?us-ascii?Q?LbIgiHyLHk2c98GFGTW/WzShmUqPMw6d7VvXGQpuCa0gC08vLW9DhxKAqc/G?=
 =?us-ascii?Q?w80u1iQa5d/zUu9wYIEh4az2WjZlNVz04doF5sMNqAc7Mp/B1ujhtReG9Ufo?=
 =?us-ascii?Q?srpAL6BjAFV3Afo+XtoN8pAmxEo6p+frTxsK25N739tSICbrFjH7FjbubMBQ?=
 =?us-ascii?Q?IsSysVSbewq9uL4VDywZjYl20hvva/wUyqURoZzL1V9p7eZQw/Dx5SdsFwN3?=
 =?us-ascii?Q?/shaP6skCULX/s9muNO/moM8SA9NH+ySc0ykpUbyNoc/pUbDpNfsm7l1ND+L?=
 =?us-ascii?Q?yTbcckkm/S4xzoZbPsimqH+KtKKVm/GYAfsAVYA0Tad5e5zoj97bB3YuPh94?=
 =?us-ascii?Q?AI0/dEqgOYgryE0iKoIJRsZY1i81FOoCbTFsSLAkhWWD+ShnkcMkcryp/rlm?=
 =?us-ascii?Q?jUk1u8IJC3YfsBom8j9XXQoI8MSmHXeoWF8CoTJaVAw0Qa9GaPdJN0BTD4pT?=
 =?us-ascii?Q?15cNmXopnPBXd79WK4v5zzKYH0Kb/R2a/L02DPJkFXRScDJF4XxOS9hHHFh7?=
 =?us-ascii?Q?wz09gI0Gy43vZFOHgtOzl1Ju4Xxhoqb0L4eXXoPiIFlCdrQZ3eT9nmq5zz07?=
 =?us-ascii?Q?9Y3U78agDbONqPO8BPyDWNpOjPoBPkO6b6UT31JS0hHVEDM3of1u8rJdaoMQ?=
 =?us-ascii?Q?96/vU4mWbQUytPdfoPkGWtUMadcvIzDPB0QHn2Pdnns0uWZnMpABlIH0HHC7?=
 =?us-ascii?Q?JDQmxqwIBQBHpKUI1zY+CbLrnIgYUsJvz4+ASzHoEZB2zZxepp1mgEDSd6FW?=
 =?us-ascii?Q?dpEuUMSMl4uxDTBtWi3VVJIdB00e2vtYVJ9HYhHe9YR29Y0jd0A6orZJeoZc?=
 =?us-ascii?Q?gE4KvdsJcl8kiufcJPdGsZg29ocZImnMLGnSHkutAP6arA2z1dF5denImfDt?=
 =?us-ascii?Q?w7TbezWaoIs0pG6qXeda1smzf3pI2sCGTYZJABJaMET9Y8Mj5e4jIghZOsYJ?=
X-MS-Exchange-AntiSpam-MessageData-1: oinD/mptHUTLrA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd68589-d105-456b-d096-08ded6abd9c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:31:11.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yv8MPrMUhzVbFAG46/VTn1vsouKzd7BR3sSvBLXuC63EozAeAIFoQt5B9CAdKkWLOz+OjQzc82UKFRrkJDLRmroFK62iTEQYkQXIryEI7Pv2EhZEyCbwkgIrB7n46oXeOPW38EL8JP8tXvLH6Whkig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6955

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Add device tree for the Intel SoCFPGA Agilex5 SoCDK TSN Config2 board
variant. This configuration enables gmac1 as a TSN port alongside
the standard gmac2 Ethernet port.

The TSN port (gmac1) uses GMII internally in the MAC but connects to an
RGMII PHY. The mac-mode property is set to "gmii" to reflect the
MAC-side interface, while phy-mode is set to "rgmii" for the PHY-side
interface.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 arch/arm64/boot/dts/intel/Makefile            |   3 +-
 .../intel/socfpga_agilex5_socdk_tsn_cfg2.dts  | 133 ++++++++++++++++++
 2 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 270c70fdf084..fc7ba2c6384b 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -4,10 +4,11 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex_socdk_emmc.dtb \
 				socfpga_agilex_socdk_nand.dtb \
 				socfpga_agilex3_socdk.dtb \
-				socfpga_agilex5_socdk.dtb \
+			socfpga_agilex5_socdk.dtb \
 				socfpga_agilex5_socdk_013b.dtb \
 				socfpga_agilex5_socdk_modular.dtb \
 				socfpga_agilex5_socdk_nand.dtb \
+				socfpga_agilex5_socdk_tsn_cfg2.dtb \
 				socfpga_agilex72_socdk.dtb \
 				socfpga_agilex7m_socdk.dtb \
 				socfpga_n5x_socdk.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts
new file mode 100644
index 000000000000..f84f41a647ae
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts
@@ -0,0 +1,133 @@
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
+/*
+ * gmac1 is the TSN port. The MAC operates in GMII mode internally
+ * while the PHY-side interface is RGMII, so mac-mode and phy-mode differ.
+ */
+&gmac1 {
+	status = "okay";
+	phy-mode = "rgmii"; /* TX/RX clock delays provided by Agilex5 I/O hardware */
+	mac-mode = "gmii";
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
+	phy-mode = "rgmii"; /* TX/RX clock delays provided by Agilex5 I/O hardware */
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

