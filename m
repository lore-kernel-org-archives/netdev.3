Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79442BC42;
	Fri,  7 Aug 2026 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099542; cv=fail; b=cbtMHigPbCSFjrJlLJ7VnC5KqpCQ0mtyFNAruzTKScZ31HG0AAYd8860IJ1ZBEMAclxDnvkXtsNu1WXytrwKPMRSCdzPM99FugBmtwQGgi/BjTSHec02Fl2SiHzvwEY8PTGzTq0Lhb6u8JiD40BczH8T9KcRza4kxlpBRgOW9Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099542; c=relaxed/simple;
	bh=Jl3KG6DeHv/x3TwuuaqHy6v5DPfMZ0/LxRUwI98fRxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuaHQduf2qf+ckfSU95vYxHvDrPh1PDsJr8sXtosoPt8Eogk9h7DuWZpGOJ5RcPRrFLFm3yLDB7B2NBwhIrP7PP1DHhpyikibNtO9bTpBfbT7kAdUDHNpubZWpQepbO3PzUXQ2QKEHL+rxVr2INs7/zYSY7VmCm87kSez/I2nwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SbtW7Lcz; arc=fail smtp.client-ip=52.101.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SbtW7Lcz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZCBcU1FQDk6tIg2UgRTmjpGHcHpoUw1rhwsSxbAcmr6DzWDcRvUf32J9W9v60SwumWd8j0TL5zrX58c3xjE6D4U5KSl7aRffzpgpmY/VY0ZoxFTlLpJsDdTvh15LsW4sViBEDpz28FnoV+ckaPfyW4seJNZyEcIIfLxOstk4wOJqkwq5QEn5fePnequXyr8aVJBhdkN5gPOJ71ox81YtbnW/LTBsiPI8hblgjV+1vTMxOwjE4O59wGxpMXwhfRW5DW4zeZ7SD5YplUyVyhuqrTROpA687zhK/5bhJ5HeelMM6utI+1DkuH4TdKbYHUk14ho1SM7/kVgqNOfYHuc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjRCnsRS8PgVP4le0P885dYY+YZS/CRkd66GnBdteN8=;
 b=R6w0ChcYHigx5iQNhwi9gPWmuwi1WY+1HFW27fgAjMGmCjMvNcL7ac9hgVtH2+KnqdReiSxNtx6DvpFm9gOsuVGwKt5hk+2d9kVKLoWBTuabK7WgKjKJGDbENrtqWah9oRYyszc6YHIODUdDO1/It4OO7iMLEJWnM6q5IHYASeoxSfCNMtN1TlCzvGxZjABHeOsCfiCKRRar9rSa4gRF+nk6nURPkbhv4rc9FtTJwz7rgBgF0nl/Q1ZcjDdCAmFHCl4E5W9o7OlKLOv6MKnh4GVJM6gISHrZbGAd910BktKCp3Sm11FpcUnyzTmTyf7haGhklFzEF2s23xOvksCIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjRCnsRS8PgVP4le0P885dYY+YZS/CRkd66GnBdteN8=;
 b=SbtW7LczoEWiA29cLf5Qh3b28CV2OevHEitWaz5Q/9SzMae14Uaeeq6ZsNwFi4aBqQAlYKmrtFZ3RGm53f+FaRSX/9S0fzonmVKHp2D5bTiXCeenLvqSFnq5W0BxnlpX3Z9FOl5Sn7qwzpLnQ6wTPSPqIsTn5Gn6mrAPuVrpIcY=
Received: from SJ0PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:33f::26)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 10:45:35 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::7d) by SJ0PR05CA0051.outlook.office365.com
 (2603:10b6:a03:33f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.8 via Frontend Transport; Fri, 7
 Aug 2026 10:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 10:45:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:45:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:45:32 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:45:27 -0500
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
Subject: [PATCH 10/20] net: dsa: xilinx: add skeleton driver for TSN switch
Date: Fri, 7 Aug 2026 16:14:21 +0530
Message-ID: <20260807104431.157230-11-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 119e406c-600e-4415-8c88-08def47102de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|1800799024|82310400026|921020|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Y2PN6FqMoIVp48AKYJMnHH+cD2i5gzlR1CZCthhQNI5B2I9qdW9VUmsVYrUko5V2rd1MwKBZRuxyT72qVCg1tSNaapH1Keam/b/sY49l2prkFF4qH3m7WMFxb2LCtULQEtekKrxPOlqgHMF2tPdvmc3Sj66WXp44fhgkb/qxpwZBzkKUM36gFL7ItI939BpohL870sTTIGa2spzmDPLEPlbjSI4Cnk7VCtFo6FEDb/JVQAimRF9oej5QpEhpKRGnAcKmVj1PdHAl0P7Grjy2KHHP6UOU/GnT8uUTLbqeU7XoCLFSR8YBfg4P4+pLP4eqD5TNvCiEG8NaTRQlap8Ma9DqzwBV60YgD9ZoRLKdCVcHwnaGvQWCcClvR+acjJ7o4FKYF+SDWRLXUjwMu9DuYYYCEwKpES6Lx5bjRqEX9JVJZPBZfK34SYasjeF9yCC3Crmli3p6D4TyVtk6CLKY6aG3SXNzi/hlYAgaGw/N90ep9H5aOOOh9uX4C9tNf2G5Io4VN8MS9gF9GvjLYVybbo3xiwI8sXUu0LFZIY6U3Oc2INI/jmZGcmc4+EM+xk5Qgu9BUNHrKXuiSuuMp4CLCWUPCJlJblmdoymc5qjHOtvM5MXS6j67Co0ecu+yMt0hxyPciQ5gwsi4lE5QunjvwhX1fyiu2d8E4IxO10xmLdJTa4Hu/Eh3MdSND6ZIkjSgl2ofoqkElOrCFhqd4ytyrovGDwpv3IMc7ByJgIrFzjuUfHf7lmSXghkXwKSsIZbW
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5C0kFU/0Pt8AbcZThcsbZR+SsZDeJKuCjgLKCIQoD9HvNihkQg4JZoSLDeBnkrp9T9YLBAb+VhJXVPHpng+RddfuvZ2Fa0fRQvfIihrbKPuNtKDY6mG1xWPP+CVfP4lWrspH+ABA7t8GTL5nm4xIyZ6npj9hCtuK2ZtS1Mtzogji/XNbTR8i+bjO1ZynZb79A/+xtcH/oRNpuwmJ2pPpf4Uc42xZ+fZLowolJHf1QZwsZjrHGgI9bXsl8ZekFsfc3DQZRl00N7D8/lwocT8stdav+w99rRTWvN/nJJ5NZmgwjRd+OtK3GJNkU2AKnnAAWB+feL7CbV71CoIcQ0Y279VhMPFTBZwl7sllC3YXhxqxEWOZUVsOMKuX7lR8CJteos95/TJwg4/Ekzk8N4OOjh7GNuYqkgLQpOgLetVllb0UzKGud1cZWwIkVeGxBCYu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:45:34.8466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119e406c-600e-4415-8c88-08def47102de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074

Add a skeleton DSA driver for the three-port switch block of the
AMD/Xilinx TSN Endpoint Ethernet MAC IP. It binds
"xlnx,tsn-switch", maps the switch fabric and two per-MAC register
windows ("switch", "mac1", "mac2"), and registers a dsa_switch with
num_ports = 3. Port 0 is the CPU port, wired internally to the
endpoint MAC. Ports 1 and 2 are the external user ports backed by
MAC1 and MAC2.

At this stage only get_tag_protocol is wired. setup and teardown
are stubs. MDIO, phylink, frame filtering, and PTP follow in
subsequent patches.

Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 MAINTAINERS                         |   1 +
 drivers/net/dsa/Kconfig             |   2 +
 drivers/net/dsa/Makefile            |   1 +
 drivers/net/dsa/xilinx/Kconfig      |  11 +++
 drivers/net/dsa/xilinx/Makefile     |   3 +
 drivers/net/dsa/xilinx/xilinx_tsn.c | 126 ++++++++++++++++++++++++++++
 drivers/net/dsa/xilinx/xilinx_tsn.h |  31 +++++++
 7 files changed, 175 insertions(+)
 create mode 100644 drivers/net/dsa/xilinx/Kconfig
 create mode 100644 drivers/net/dsa/xilinx/Makefile
 create mode 100644 drivers/net/dsa/xilinx/xilinx_tsn.c
 create mode 100644 drivers/net/dsa/xilinx/xilinx_tsn.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6fbe83fb3953..0e91cb2a307d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29613,6 +29613,7 @@ M:	Srinivas Neeli <srinivas.neeli@amd.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
+F:	drivers/net/dsa/xilinx/
 F:	drivers/net/ethernet/xilinx/tsn/
 F:	net/dsa/tag_xlnx_tsn.c
 
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 4ab567c5bbaf..1404a77579f1 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -84,6 +84,8 @@ source "drivers/net/dsa/qca/Kconfig"
 
 source "drivers/net/dsa/sja1105/Kconfig"
 
+source "drivers/net/dsa/xilinx/Kconfig"
+
 source "drivers/net/dsa/xrs700x/Kconfig"
 
 source "drivers/net/dsa/realtek/Kconfig"
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index d2975badffc0..75b8449b575e 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -26,4 +26,5 @@ obj-y				+= ocelot/
 obj-y				+= qca/
 obj-y				+= realtek/
 obj-y				+= sja1105/
+obj-y				+= xilinx/
 obj-y				+= xrs700x/
diff --git a/drivers/net/dsa/xilinx/Kconfig b/drivers/net/dsa/xilinx/Kconfig
new file mode 100644
index 000000000000..0bd5efe8490b
--- /dev/null
+++ b/drivers/net/dsa/xilinx/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+config NET_DSA_XILINX_TSN
+	tristate "AMD/Xilinx TSN Endpoint Ethernet MAC switch support"
+	depends on OF && HAS_IOMEM
+	depends on NET_DSA
+	select NET_DSA_TAG_XLNX_TSN
+	help
+	  This enables DSA switch support for the three-port switch
+	  block of the AMD/Xilinx TSN Endpoint Ethernet MAC IP. Port 0
+	  is the CPU port, wired internally to the endpoint MAC; ports 1
+	  and 2 are external Ethernet ports backed by MAC1 and MAC2.
diff --git a/drivers/net/dsa/xilinx/Makefile b/drivers/net/dsa/xilinx/Makefile
new file mode 100644
index 000000000000..334f0f979276
--- /dev/null
+++ b/drivers/net/dsa/xilinx/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+obj-$(CONFIG_NET_DSA_XILINX_TSN) += xlnx_tsn_dsa.o
+xlnx_tsn_dsa-y := xilinx_tsn.o
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
new file mode 100644
index 000000000000..6b285c528724
--- /dev/null
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD/Xilinx TSN Endpoint Ethernet MAC DSA switch driver.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <net/dsa.h>
+
+#include "xilinx_tsn.h"
+
+static enum dsa_tag_protocol xlnx_tsn_get_tag_protocol(struct dsa_switch *ds,
+						       int port,
+						       enum dsa_tag_protocol mp)
+{
+	return DSA_TAG_PROTO_XLNX_TSN;
+}
+
+static int xlnx_tsn_setup(struct dsa_switch *ds)
+{
+	return 0;
+}
+
+static void xlnx_tsn_teardown(struct dsa_switch *ds)
+{
+}
+
+static const struct dsa_switch_ops xlnx_tsn_switch_ops = {
+	.get_tag_protocol	= xlnx_tsn_get_tag_protocol,
+	.setup			= xlnx_tsn_setup,
+	.teardown		= xlnx_tsn_teardown,
+};
+
+static int xlnx_tsn_map_reg(struct platform_device *pdev, const char *name,
+			    void __iomem **out)
+{
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource_byname(pdev, name);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(base),
+				     "failed to map %s reg window\n", name);
+
+	*out = base;
+	return 0;
+}
+
+static int xlnx_tsn_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dsa_switch *ds;
+	struct xlnx_tsn *sw;
+	int ret;
+
+	sw = devm_kzalloc(dev, sizeof(*sw), GFP_KERNEL);
+	if (!sw)
+		return -ENOMEM;
+
+	sw->dev = dev;
+
+	ret = xlnx_tsn_map_reg(pdev, "switch", &sw->sw_base);
+	if (ret)
+		return ret;
+
+	ret = xlnx_tsn_map_reg(pdev, "mac1", &sw->mac_base[XLNX_TSN_PORT_MAC1]);
+	if (ret)
+		return ret;
+
+	ret = xlnx_tsn_map_reg(pdev, "mac2", &sw->mac_base[XLNX_TSN_PORT_MAC2]);
+	if (ret)
+		return ret;
+
+	ds = &sw->ds;
+	ds->dev = dev;
+	ds->num_ports = XLNX_TSN_NUM_PORTS;
+	ds->ops = &xlnx_tsn_switch_ops;
+	ds->priv = sw;
+
+	platform_set_drvdata(pdev, sw);
+
+	return dsa_register_switch(ds);
+}
+
+static void xlnx_tsn_remove(struct platform_device *pdev)
+{
+	struct xlnx_tsn *sw = platform_get_drvdata(pdev);
+
+	if (!sw)
+		return;
+
+	dsa_unregister_switch(&sw->ds);
+}
+
+static void xlnx_tsn_shutdown(struct platform_device *pdev)
+{
+	struct xlnx_tsn *sw = platform_get_drvdata(pdev);
+
+	if (!sw)
+		return;
+
+	dsa_switch_shutdown(&sw->ds);
+	platform_set_drvdata(pdev, NULL);
+}
+
+static const struct of_device_id xlnx_tsn_of_match[] = {
+	{ .compatible = "xlnx,tsn-switch" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, xlnx_tsn_of_match);
+
+static struct platform_driver xlnx_tsn_driver = {
+	.driver = {
+		.name		= "xlnx-tsn-switch",
+		.of_match_table	= xlnx_tsn_of_match,
+	},
+	.probe		= xlnx_tsn_probe,
+	.remove		= xlnx_tsn_remove,
+	.shutdown	= xlnx_tsn_shutdown,
+};
+module_platform_driver(xlnx_tsn_driver);
+
+MODULE_AUTHOR("Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>");
+MODULE_DESCRIPTION("AMD/Xilinx TSN Endpoint Ethernet MAC DSA switch driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
new file mode 100644
index 000000000000..0f9af866bd18
--- /dev/null
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * AMD/Xilinx TSN Endpoint Ethernet MAC DSA switch driver.
+ */
+#ifndef _XILINX_TSN_H
+#define _XILINX_TSN_H
+
+#include <linux/types.h>
+#include <net/dsa.h>
+
+#define XLNX_TSN_NUM_PORTS	3
+#define XLNX_TSN_CPU_PORT	0
+#define XLNX_TSN_PORT_MAC1	1
+#define XLNX_TSN_PORT_MAC2	2
+
+/**
+ * struct xlnx_tsn - per-IP switch state
+ * @ds: DSA switch
+ * @dev: backing device
+ * @sw_base: switch fabric register window
+ * @mac_base: per-MAC register windows, indexed by user-port number
+ *	      (index 0 unused; MAC1 at [1], MAC2 at [2])
+ */
+struct xlnx_tsn {
+	struct dsa_switch ds;
+	struct device *dev;
+	void __iomem *sw_base;
+	void __iomem *mac_base[XLNX_TSN_NUM_PORTS];
+};
+
+#endif /* _XILINX_TSN_H */
-- 
2.34.1

