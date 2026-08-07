Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2EF374195;
	Fri,  7 Aug 2026 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099499; cv=fail; b=OpOWmOFQ2yPvQj9R35vGeK2K//KJr2b/KdzApe9hdk+rVusX6mLwa8II2/R1Nj+bu5KHI/LXAfNzKutLAMeHsZTcIruNzDNEqiaZWRaeGb2jPHjQz33knw7ZN7hRWkyNzeXQK8MFqezL0X9RrwenSmdepMj2b2kMwF0uYTPI9ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099499; c=relaxed/simple;
	bh=bVLXGWP+tkvlarabBDNsJRmiq/8gkmNDCPnkVCOQbLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Da5jVLbuxY9/CEzaP/XPEsUJHDeYqR8rtK7r4LvgarMa/2q4erjOklH3+gPPplmaQKV/e0lDkHrP7P0IIIJkR+RMjgClFMunmPYr6gZXOwTwq6/7eKxR5BVLnGS2LtBfvoPIFk+21IejlBeqJpiRDBztMVRi4WpOZnSYnviZmdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FtG5yJng; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FtG5yJng"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlPkHKyEbBZvM3sLVWXVF0+ahu/SD2WdFtsJ5aY0uHKSbfXPnbO4rZ2yzrOgcgYTm7LGb9RlJ+tSFYB965BobH4Ocz7NNouEs4wuMSfpxcp37aE/c8ElKg5l5hECWccx5wmLyopGdqzCN/slGfFt97zlzo2lSTOQOhGhzNU4UcnA++73pFjaYa1iZUTXa/VfmNhaGTwrAWca5Kln6ixyuidBbbADXkLfpbCMMRE7sGIRZ5g2lTJQYpz1mm/ZbuAB/TFUp3Q+emy65+JGSOjJyiapZUZsvCp8gzP+e9suNXDaMcbzr8WOHqJ4cXC9QDKlgVh0lLPOSWrK7M4HCFwAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UHbBhxfwNJqMbysL5dAOz8G3ClHDME2r4umW53mAFU=;
 b=BfOL/jGtG9UpiFiqsAez6u3W6rcwdRWK25ILbeVsNkxw0aTLgQjmBjBnWr4Z9JNqwK/DY3p3ZqwqcdPIvupzrd5mTolfsE1G0BioLp2XkErQq3fnAbpZOHudY3wCI4G4J01Q1AAM2bmlEflqCj13+4hFHEJ+lDJphPx0N2H67rJRjL/vzHoJ6tpdXbn78aaBcy9M2zniU6kdO9nWvGOJ7DcD+SM0UuA3APUnv0pn/g+4fVZmCV8QvFl8vLwJbDkR9gYcJllR27H3eG4eUcQcSG8FufdYWjczDco+M5UiZcy0rguKEdj9GrLmGuUOls88KyasrGUIlbM5X5+KZCPBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UHbBhxfwNJqMbysL5dAOz8G3ClHDME2r4umW53mAFU=;
 b=FtG5yJng4Dw2nk4RuelwkGLq+cNziVDfLKtTBF5nUO9WfKhJ5Lm+HXK+WUnVq1A70HSo09/nwjvy7HzunmAxez9ySdIJeI7N+SGnH66E372lZjKUWBqk5x9Q1hOiIix2kK9pOS4EL02oMs4EKdCnC1rujxl6lY9P6GHIx9GVnvk=
Received: from PH7P220CA0067.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::9)
 by SAWPR12MB999141.namprd12.prod.outlook.com (2603:10b6:806:4e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Fri, 7 Aug
 2026 10:44:50 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::1a) by PH7P220CA0067.outlook.office365.com
 (2603:10b6:510:32c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 10:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Fri, 7 Aug 2026 10:44:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:44:47 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:44:42 -0500
From: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
To: Srinivas Neeli <srinivas.neeli@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Michal Simek <michal.simek@amd.com>, Andrew Lunn
	<andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, Simon Horman
	<horms@kernel.org>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git-dev@amd.com>, <nagadheeraj.rottela@amd.com>
Subject: [PATCH 02/20] net: xilinx: tsn: add TSN endpoint wrapper driver
Date: Fri, 7 Aug 2026 16:14:13 +0530
Message-ID: <20260807104431.157230-3-nagadheeraj.rottela@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SAWPR12MB999141:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b921f22-af4b-4439-0a5e-08def470e86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	miwT/ok7fzuck7JyvDgHu4Zjjqrazj9NE96ppP/h6TFZ61ZOWH6LbukCZqQ24a7coq8Lvh1rJ40x7avuVblfDkJ2OjhnPWxfrmRYIQ1Jj2y2mr/6eexcta5RoTXGJNDYzoq7aOx1JkEj8J5FkDr/5xKIGUqQ3PVXXRgqb6sAIhHovjdVRmFciuYIGrWY83lMxzVNERziVP0RFZxTy6M+mLpwJBbrjJcLFs1yWzDgKgHVgiDcFn+r59q5zmo/7DrEdGO/ebvF4IoTgkN8//+kP0RUNGjsa/4IRGydbhKny1V2u8nBCQYnr3eneQT85V9ZgiyOBWFciHdt8IatHGUvmsJxpDJJZ8D2PGn3bBEKp5xmjiW5kJrx9L+TICEzDOg+oi3JXuKWNLARtGKBXEI1xQSjkpoXTllLlwmt11mIvSLrmC08Q/5xSqqTlAYcTtmQdHqU/jKjQjxZFVIejS3zRCivPgXr6vLaOGI2ChhPzer2tUxusrF+xcIqA4L/Z+E4BjkzXhcuHlF9t7hK6PjV8JqtXKEF1rHf81/8ihcZoZWV2nJRVk2tDFtb1wjAneZ0PpIRBqxUmDu3XopVP8D9j7n18R43yzLiw3tSwebf/KVig5aPCa2kE8y7g2z7Wq9DUOmlBoTyDA9qy0JeuLLniNYt7hbGlFNieoaz6BTkUrGgHYO71FkrHZ+sYN31dZ4bOwXF0rxsclwy36LA8UE2eJPkESxC7srVGXcKTLhIg74eWiWYpkT8qAj2V8EVLIsB
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T56Hz/ivpQ5GI0cnKpUuK4spESVekOOck7/qmmJ857y5VAKlg44i3ydb+zeA4TYULo51DlEEdu969X/Oc8LwC0lg8FgbjRHJ+i/1DxN46Rb1J5FDcfWTYTXYg++sGpBQINuy/+FAll0Ol1HVHi7/Y3a42Ych6FWu6nK3Dv6yy6502ZlFrHQSDq7wZTHSNU33o8WUBYxi+JM1UgQtc9z7+q01XMouYT+SGGc1KvZH83u6BWLFIcp00vd3uuNFIxt2AOqTB2ep/QM9nH1R4JSv1xQ6bmp9miWG+IYeWnvlAZ+dmHzofbgYoVRnLRRYsvNcUJkpffwbHlOKoW9Z7EBgrXicFlFAcTWAzF5DZ4ihfTvPYR2RMLZBuHdJD58u22eU4veow+986FypwCprIev7kEZirnQAXPsgxHQwk8mMtg4h7aaipHeN/O6xaFIpWKhL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:44:50.4827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b921f22-af4b-4439-0a5e-08def470e86c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999141

From: Srinivas Neeli <srinivas.neeli@amd.com>

The TSN Endpoint Ethernet MAC IP groups several sub-nodes under one IP
node with a set of IP-wide clocks. Each sub-node needs its own driver,
and the shared clocks must be running before any of them probe.

Add a thin wrapper platform driver for the IP node. Enable the IP-wide
clocks from the device tree and bind each sub-node to its own driver.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/Makefile          |   1 +
 drivers/net/ethernet/xilinx/tsn/Kconfig       |  15 +++
 drivers/net/ethernet/xilinx/tsn/Makefile      |   2 +
 .../net/ethernet/xilinx/tsn/xilinx_tsn_main.c | 105 ++++++++++++++++++
 6 files changed, 125 insertions(+)
 create mode 100644 drivers/net/ethernet/xilinx/tsn/Kconfig
 create mode 100644 drivers/net/ethernet/xilinx/tsn/Makefile
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ba41c224dd02..e5b95b3bfa21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29613,6 +29613,7 @@ M:	Srinivas Neeli <srinivas.neeli@amd.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
+F:	drivers/net/ethernet/xilinx/tsn/
 
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 7502214cc7d5..c6d704c8d3d4 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -41,4 +41,5 @@ config XILINX_LL_TEMAC
 	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
 	  core used in Xilinx Spartan and Virtex FPGAs
 
+source "drivers/net/ethernet/xilinx/tsn/Kconfig"
 endif # NET_VENDOR_XILINX
diff --git a/drivers/net/ethernet/xilinx/Makefile b/drivers/net/ethernet/xilinx/Makefile
index 7d7dc1771423..66dab012650b 100644
--- a/drivers/net/ethernet/xilinx/Makefile
+++ b/drivers/net/ethernet/xilinx/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_XILINX_LL_TEMAC) += ll_temac.o
 obj-$(CONFIG_XILINX_EMACLITE) += xilinx_emaclite.o
 xilinx_emac-objs := xilinx_axienet_main.o xilinx_axienet_mdio.o
 obj-$(CONFIG_XILINX_AXI_EMAC) += xilinx_emac.o
+obj-$(CONFIG_XILINX_TSN) += tsn/
diff --git a/drivers/net/ethernet/xilinx/tsn/Kconfig b/drivers/net/ethernet/xilinx/tsn/Kconfig
new file mode 100644
index 000000000000..45af4d3f10e6
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx TSN device configuration
+#
+
+config XILINX_TSN
+	tristate "Xilinx TSN Ethernet driver"
+	depends on OF && HAS_IOMEM
+	help
+	  This driver supports the AMD/Xilinx Time-Sensitive Networking
+	  (TSN) Endpoint Ethernet MAC IP. It provides the wrapper device
+	  and the endpoint MAC that connects the IP to the host CPU. The
+	  three-port switch is supported by NET_DSA_XILINX_TSN.
+
+	  If unsure, say N.
diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ethernet/xilinx/tsn/Makefile
new file mode 100644
index 000000000000..6f99226f3dc8
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_XILINX_TSN) += xilinx_tsn.o
+xilinx_tsn-y := xilinx_tsn_main.o
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
new file mode 100644
index 000000000000..1ef1b0c2ee6e
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Time Sensitive Networking (TSN) Ethernet MAC wrapper driver.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#define TSN_NUM_CLOCKS		6
+
+/**
+ * struct xlnx_tsn_ip - wrapper-private IP state
+ * @clks: bulk-managed IP clocks
+ */
+struct xlnx_tsn_ip {
+	struct clk_bulk_data clks[TSN_NUM_CLOCKS];
+};
+
+static const char * const tsn_clk_names[TSN_NUM_CLOCKS] = {
+	"gtx",
+	"gtx90",
+	"host_rxfifo",
+	"host_txfifo",
+	"ref",
+	"s_axi",
+};
+
+static void tsn_clk_bulk_disable(void *data)
+{
+	struct xlnx_tsn_ip *w = data;
+
+	clk_bulk_disable_unprepare(TSN_NUM_CLOCKS, w->clks);
+}
+
+static int tsn_ip_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct xlnx_tsn_ip *w;
+	int ret;
+
+	w = devm_kzalloc(dev, sizeof(*w), GFP_KERNEL);
+	if (!w)
+		return -ENOMEM;
+
+	for (int i = 0; i < TSN_NUM_CLOCKS; i++)
+		w->clks[i].id = tsn_clk_names[i];
+
+	ret = devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, w->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get clocks\n");
+
+	ret = clk_bulk_prepare_enable(TSN_NUM_CLOCKS, w->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable clocks\n");
+
+	ret = devm_add_action_or_reset(dev, tsn_clk_bulk_disable, w);
+	if (ret)
+		return ret;
+
+	return devm_of_platform_populate(dev);
+}
+
+static const struct of_device_id tsn_of_match[] = {
+	{ .compatible = "xlnx,tsn-endpoint-ethernet-mac-3.0" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tsn_of_match);
+
+static struct platform_driver tsn_driver = {
+	.probe = tsn_ip_probe,
+	.driver = {
+		.name = "xilinx-tsn",
+		.of_match_table = tsn_of_match,
+	},
+};
+
+static struct platform_driver * const tsn_drivers[] = {
+	&tsn_driver,
+};
+
+static int __init xlnx_tsn_init(void)
+{
+	return platform_register_drivers(tsn_drivers, ARRAY_SIZE(tsn_drivers));
+}
+module_init(xlnx_tsn_init);
+
+static void __exit xlnx_tsn_exit(void)
+{
+	platform_unregister_drivers(tsn_drivers, ARRAY_SIZE(tsn_drivers));
+}
+module_exit(xlnx_tsn_exit);
+
+MODULE_AUTHOR("Srinivas Neeli <srinivas.neeli@amd.com>");
+MODULE_DESCRIPTION("AMD/Xilinx TSN Endpoint Ethernet MAC wrapper driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

