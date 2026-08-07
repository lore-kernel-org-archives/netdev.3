Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E936E489;
	Fri,  7 Aug 2026 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099507; cv=fail; b=JIXFR4kqb+xwL4thyUf3Utz/aVn4hNQJIF7MFMySJouqbrHx2vsjjW7zpGm48Atu1in0y2++5praP8HftDaZbsyYJ1QBiYyk3OfO8UU67brTnGGpLnIJv7FHnnaAius59v2Y5GS2OEiYzIj7mPOK9CL1qcc49R+lmzxHxuZ8wKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099507; c=relaxed/simple;
	bh=nWa95cwKh/XRnZJfsI4ZtXvtR9Fd3C8JqgJDDgCELbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4jLV+LmQEMJ+mWkl3ocxLfr2IGf/6D2Id0kRB29V+nk0YltWuTCWMzLn73bpVVzCVhgLdVuFg0uLwQalZNLkBxy8rb6i7ZKOpKIQnpU9VCq48K0KsbgXE+zGcgbpSxUPDdpVv6fWYc4d++2lA0n6g5spW9GZIHELqhlUrSDRVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HErSrf4x; arc=fail smtp.client-ip=52.101.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HErSrf4x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyV7f3kAxhoqSFU1MA8lxuoDaDndGVzUAS+60lWKv4RcYMHNeqgkVc+L96Cgf5rqWHQCi24SZf5XSVw74AXZ9CkpituodfPirgWkJLYXZ8igfVTIbztpws/ux3zdPRD35kL0MYn2LDlbPuLw35l50j7jRz8phxmcn62tV5T34gogkP5n29sk5W8aMEog0oSMbrZ2Dg9WTXY/Pmt+po793qyHFdbC9IgXJEtIWzMSLO6fpsyS8oWxxC4TC5YbwJsumOv2VWXHGYzM9hDTlMYPbU+HBILCSlO/MqBdJjGkC17g907inQvfgteHDk9lP7oOvuOcSxJsdD+iP+mXGIAjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z7YSlLcSEWihjddIE9/NWotmgKRdM2161jQscE9tlc=;
 b=obTryEfriDE8nEdN7awPnPOmuc1z+0FQvQVi5sTw3/OgN80SJLLNFQiknxKMlrQ9mJ9uwWmw+6osX55oGU1ZNdgYLIOAxnv3mjw5E2KQ5MnNL0YejXSKy+7Iu3DVZM2Q0pznj4KQWuNp2VGfn/KI3hbmFgFlXZnMBWsIK9bedjvHy1ECiuo7FI8lLkzpiPc/UYrBFJHkvXZX+83krzXZiS0DngQ0kWeUKw0Qq92S1xpKt7wAUaYf6Ap/CjAzX/Wz/N9AqmagrPY+3GitYSz6lkQFgDjdaKZ7C5jy8jKyIJEXUOvBIRneFUiSRYsVnrmatpmPmTmr2Q/6yVmK+IUjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z7YSlLcSEWihjddIE9/NWotmgKRdM2161jQscE9tlc=;
 b=HErSrf4xoQj+ZdODPg9YI+as3iIsHvhHeAQhw8reiWTCh/HgwRpMzK74+NqMTBUnsWpgR8L5h9+9ALufwvAE+c8/tAsEecBzhzztL8byuWkKxuYj5di7Go3+hSAnaI0rbaXJntHHiy6x+ubHTGlqPONALZ25/UnBxBfXJXFfdfo=
Received: from SJ0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:33b::15)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 10:44:56 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a9) by SJ0PR05CA0010.outlook.office365.com
 (2603:10b6:a03:33b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.9 via Frontend Transport; Fri, 7
 Aug 2026 10:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Fri, 7 Aug 2026 10:44:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:44:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 03:44:53 -0700
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:44:48 -0500
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
Subject: [PATCH 03/20] net: xilinx: tsn: add endpoint MAC driver skeleton
Date: Fri, 7 Aug 2026 16:14:14 +0530
Message-ID: <20260807104431.157230-4-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be49f92-972b-4186-c213-08def470eb8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Kk7HYo+hZHoy60mAGpGdF2wbOf5SZdW4L3Rht0K5wa9xPN/xvmB4X0PZN6QBfFP9POzQB95PScnYNivpVPWNdcS+quFdFgPJZfpPE230c3x7bgK+Bua47xZI+NFhWs7SU3QOiHOPJgGNJxqRldUFmQ6xYBfAiqOX1jKhSxfmciwwKVcSMlFfQ7a5STeAIRXHrmRbaKSbtcyUr9+Q+9kO00dD2H5RRRtakcDq0ESd+yFD0JofrM8oX/LzOBgriUmkp1laXIL1rjcW94ioeGhRotZmX4SCeHvQV94/AUa1sepHgo97TQjEOBENizoctygQd3qfBXUm1zxZGUv/Xue3PG2uuwdCxK9VQAZf9rpfwcszbeswlkI1HabaNXeO0qcora4T0lzDTvYZ7H/NHoAmKEZF4c32ZZdvsIy7T9tfSM/InVQFqpMq2cxcYF5TtrUbSenlWKf5YkBLhvakpOfFBiR12N2UuqD0fvnkQiELjqkEotvRet1GlUpjGVHeh7z0jmmo1JnJcKuR/mseLgYuXK6bHoAiYQirFVqKzvIPJdM9nmzx1UhWtGk4wmD6gliV5wdcXxYkfS4xk8fMSwY6JL6J9DUo3btFm4OVFJjMs+tGxUUQ5b63K6zaLO6F7r4ygmsjrSpmMhxSDaNgfGDk6rr3ysVqc3u7ZTmqX5DtunstvXChKYLFSdBJLFXeCh08P7BA9vjzNrAmQ+lrfXxjhTWitLigej8rCsoW+tYMqaTPnghXCZKZafF2aDgXi0bJ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BWrBl0ybsT6Y0P+cyWUlXgZDbyrXgcEnWrX0U/t3KUGi3bmU2ApryyjjnensiigKOFHwS7B5JxtwyQhjb3NKVI2zRLojfMjZ4icG5wq9OVRH/xz5hzZcnDg1uuxmU9c1s5ndjeXHfhNm4OP2lCgBX+sUE9jR41LPbSL2SIDdGrxc/cbnUOOoyZasO3vQjqKA7EC+KxA6YctTpoPMI049a1Kfg6bv7ZcvsfXG26Ma7k2+6jGzGTbRNrhbtXc1Va1chwwF1rsiiyP1IH3Fb31KNQX2ukl8lI86UmnVvHokSmlPD2LozmFz3cUJQ6DI2Zg+dW89l3iTydjhZn4z0/ho/jzSMab+fvSBVyNzVDoBcHJBpl/7A0qhXK8o+K1LJ7nqgDSTIZwCvUAUrLXCGd3CntQjp237sEAld84RWv0070l4cjloQfcsFZGQOXAPTLud
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:44:55.7360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be49f92-972b-4186-c213-08def470eb8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597

From: Srinivas Neeli <srinivas.neeli@amd.com>

The TSN Endpoint MAC owns the IP's host-side MCDMA data path and is the
netdev physically wired to the CPU. The DSA switch needs this netdev to
exist as its conduit.

Add a platform driver (compatible "xlnx,tsn-ep-mac") for the endpoint.
Register the netdev named "ep", set its MAC address, and provide minimal
netdev and ethtool ops. This skeleton handles device bring-up only, with
no data path yet. So ndo_open just starts the queues and ndo_start_xmit
drops frames.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 drivers/net/ethernet/xilinx/tsn/Makefile      |   2 +-
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h  |  15 ++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_ep.c   | 152 ++++++++++++++++++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_main.c |   3 +
 4 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ethernet/xilinx/tsn/Makefile
index 6f99226f3dc8..5886828b386f 100644
--- a/drivers/net/ethernet/xilinx/tsn/Makefile
+++ b/drivers/net/ethernet/xilinx/tsn/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_XILINX_TSN) += xilinx_tsn.o
-xilinx_tsn-y := xilinx_tsn_main.o
+xilinx_tsn-y := xilinx_tsn_main.o xilinx_tsn_ep.o
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
new file mode 100644
index 000000000000..b0757e22d1fd
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD/Xilinx TSN Endpoint Ethernet MAC driver, shared definitions.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef _XILINX_TSN_H
+#define _XILINX_TSN_H
+
+#include <linux/platform_device.h>
+
+extern struct platform_driver xlnx_tsn_ep_driver;
+
+#endif /* _XILINX_TSN_H */
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
new file mode 100644
index 000000000000..9b556edf5423
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD/Xilinx TSN Endpoint MAC driver.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/if_ether.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "xilinx_tsn.h"
+
+#define DRIVER_NAME			"xilinx_tsn_ep"
+
+/**
+ * struct xlnx_tsn_ep - EP MAC private data, embedded in net_device priv area
+ * @ndev: the conduit netdev ("ep")
+ * @dev: backing device
+ * @regs: EP MAC register window
+ */
+struct xlnx_tsn_ep {
+	struct net_device *ndev;
+	struct device *dev;
+	void __iomem *regs;
+};
+
+static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	dev_kfree_skb(skb);
+	DEV_STATS_INC(ndev, tx_dropped);
+	return NETDEV_TX_OK;
+}
+
+static int ep_open(struct net_device *ndev)
+{
+	netif_tx_start_all_queues(ndev);
+
+	return 0;
+}
+
+static int ep_stop(struct net_device *ndev)
+{
+	netif_tx_disable(ndev);
+
+	return 0;
+}
+
+static void ep_get_drvinfo(struct net_device *ndev, struct ethtool_drvinfo *ed)
+{
+	strscpy(ed->driver, DRIVER_NAME, sizeof(ed->driver));
+}
+
+static const struct net_device_ops ep_netdev_ops = {
+	.ndo_open		= ep_open,
+	.ndo_stop		= ep_stop,
+	.ndo_start_xmit		= ep_start_xmit,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_set_mac_address	= eth_mac_addr,
+};
+
+static const struct ethtool_ops ep_ethtool_ops = {
+	.get_drvinfo	= ep_get_drvinfo,
+};
+
+static int xlnx_tsn_ep_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct net_device *ndev;
+	struct xlnx_tsn_ep *ep;
+	u8 mac_addr[ETH_ALEN];
+	int ret;
+
+	ndev = alloc_netdev(sizeof(*ep), "ep", NET_NAME_UNKNOWN, ether_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(ndev, dev);
+	ndev->netdev_ops = &ep_netdev_ops;
+	ndev->ethtool_ops = &ep_ethtool_ops;
+	ndev->features = NETIF_F_SG;
+
+	ep = netdev_priv(ndev);
+	ep->ndev = ndev;
+	ep->dev = dev;
+
+	ep->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ep->regs)) {
+		ret = PTR_ERR(ep->regs);
+		goto err_free_ndev;
+	}
+
+	ret = of_get_mac_address(dev->of_node, mac_addr);
+	if (ret == -EPROBE_DEFER) {
+		goto err_free_ndev;
+	} else if (!ret && is_valid_ether_addr(mac_addr)) {
+		eth_hw_addr_set(ndev, mac_addr);
+	} else {
+		eth_hw_addr_random(ndev);
+		dev_info(dev, "no valid MAC in DT, using random address %pM\n",
+			 ndev->dev_addr);
+	}
+
+	platform_set_drvdata(pdev, ep);
+
+	ret = register_netdev(ndev);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to register net device\n");
+		goto err_free_ndev;
+	}
+
+	return 0;
+
+err_free_ndev:
+	free_netdev(ndev);
+	return ret;
+}
+
+static void xlnx_tsn_ep_remove(struct platform_device *pdev)
+{
+	struct xlnx_tsn_ep *ep = platform_get_drvdata(pdev);
+
+	if (!ep)
+		return;
+
+	unregister_netdev(ep->ndev);
+	free_netdev(ep->ndev);
+}
+
+static const struct of_device_id xlnx_tsn_ep_of_match[] = {
+	{ .compatible = "xlnx,tsn-ep-mac" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, xlnx_tsn_ep_of_match);
+
+struct platform_driver xlnx_tsn_ep_driver = {
+	.probe	= xlnx_tsn_ep_probe,
+	.remove	= xlnx_tsn_ep_remove,
+	.driver	= {
+		.name		= DRIVER_NAME,
+		.of_match_table	= xlnx_tsn_ep_of_match,
+	},
+};
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
index 1ef1b0c2ee6e..3df8c026741f 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
@@ -16,6 +16,8 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include "xilinx_tsn.h"
+
 #define TSN_NUM_CLOCKS		6
 
 /**
@@ -86,6 +88,7 @@ static struct platform_driver tsn_driver = {
 
 static struct platform_driver * const tsn_drivers[] = {
 	&tsn_driver,
+	&xlnx_tsn_ep_driver,
 };
 
 static int __init xlnx_tsn_init(void)
-- 
2.34.1

