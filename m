Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC2542FCD4;
	Fri,  7 Aug 2026 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099552; cv=fail; b=fh3xO1k6xVrSZOxBgSMKfrrOqr6VHknF1IqS3dD3AeJt1SLe2myzziV7RNhLWY4YPVT/NpQdC2tlGpQUF8OLH+OjPWBN2GDq3IiOQxMJhxFwjxKUKfpgS303nuGqsBUWcspHA+5t07nTTeERPlC/jX/YZvRfoKVQcIka3+afhmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099552; c=relaxed/simple;
	bh=JRSjAaFrfAlYdJ4lG9p2oNgL2Gl+OibOFGaLbOn0pjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lp7caHxWXs5I1XdDEW/b7n/jed9RxkHG3h0RUBQEagbwCIQKzYaUY0Tzw/gXxbuteqpxWZkvNkVbf2UYQLRPDPW0it7pqxXweNhbXyIxZ+tgk5dgWvO3Vg6NVe0F7TUSRrd3e8Kbdh80AjLUbE6GqheqfxlYA/fBcJaBb6rD33M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VddpJUdH; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VddpJUdH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhajPZhU1BYNwUIbNtVGefh6N0OvQOHQ764y0309AZM+Jsp/6I1eZmM/X70NQr66CG9UY4rt7ON+ldnN6if/D2eNE02zaeGoSVyRUZSk20dGbhu/vZOLtrPeaR8Gzzfkn1K7yFp41f9xQH3sMrwMWJxxcrJP7Uu7jvfauItYq3u29JDuZBjCbJGxbvIPau1gVpXErrd9kmM5eLVGHvbDGl3gjs0rKXpGFKiwzXfY3YG8mmECjAl+k83ddbqZT/kUjH5ZG0yrsv9i4TVx2wN6VWZrkA60TiFDO2ZAgYNtODCrYqdBoxAjx8MNj05vvlRk8sYypfCuoe4qGg8uBl5Sqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPOeu0CoNKd2KdnippYDzdSf360pLV/BSVzDzxhxSzQ=;
 b=WDygq9PE8JmSI6kykKs4+xhmTfHYoC+WLl3QxObxv721sg6lGDW10wTRThk5rJN9eN7I+36KGtGRdBnukqeNqukjzklgEcj1ltQC1dkrNno45e0bYEBQ1eiYix9Vwt7cHnb/JG1HpdhE1ndaVtNERAE29C7paYQ7jCYVzJ38JygmMdM5iXx0BuJrINV/ad0J7GtrOOj8xqgkgIpTbWpXpZvVGoNG+fk3Zp+U484sN9JCG7FFVyt4hbCUMcBlffcPgP0fTsHW/o2rk88yTeIPYSYuS4mrcuWJgAYFbRXE+ZdfRmYUZZUK4fb32JOZci4zwtiDd3nN1RPwLHOSOVGsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPOeu0CoNKd2KdnippYDzdSf360pLV/BSVzDzxhxSzQ=;
 b=VddpJUdH9vvPu2Drkk9YKEzTi/VAV/yQQKgYN7l2zOlcVR3hOWiJ+xY+Ko/78JTy4t1RIPTvesc4wdU2ThGB63rOGh9m9j4gNMw3LIx/CgVt3MZHgjcyZcCG19zoWClj8xSbXNGo9Zknm/nuGkzVIPVfRCNpJwrQeFbih2//hL8=
Received: from MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::26)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 10:45:46 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::96) by MW4P220CA0021.outlook.office365.com
 (2603:10b6:303:115::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 10:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Fri, 7 Aug 2026 10:45:45 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:45:43 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:45:38 -0500
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
Subject: [PATCH 12/20] net: dsa: xilinx: register per-MAC MDIO buses
Date: Fri, 7 Aug 2026 16:14:23 +0530
Message-ID: <20260807104431.157230-13-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ead036-2a87-4f97-ad10-08def471092c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|921020|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	y6C2utmDFOxz1+7bxW2RK0wmMui9JZnCncrIyVpAps55p40ChEqzNrfGJkmdBDRoD0zR20zgtPOVy5bHYMVsFE+zpVWQzsGJQrt4C9aZeWQXHJiEwqqiWaZgXHkZ1p7oEfprlDsD1Vcd1w3DQibNFlK2J9/8TQeDaa9a+Dagwpno1Z4AYXleyEw34oHiB90v6Z7/z85ShdSiM8JQsYXUkk0JyOW9ePVt+QcH3e0HCLrH184iYOvfPK4XS5XJjY8SuMqeUKO6QS7izgrJTzU5FZGs+Tx09qYzwaRijenrHb9KwbN+0JA1asTod3g9gcdfE6gRX7rdKn2Z99c6YtL6cJ7NuVsGYomnMFq5jn2AiPIKKBcayU0cLJJSAFcSslxcCKDmq4B5jqYzQ+kfmeJq+YDBvbn99itusSuh/ZYK2LGQMDOKFwHkUbLV4/JnjyJWIbTIQs91psEJChThL+7fkHaTxxsF/r9ZygBpMarIdQkwOgW1SET3/NBsDse4uBXcKOFspbq60l0WIY68nScRr3I031culGjZBK6hMn3VlfPTK3lSbe83sWxCn0ZOdCT6wTyXF0ciUoPcJn7/dwaRw7zGkv4Si4G827d1giFdSoeTrK8KVYB/Nincc6Swo8pNv02ffm32XWCpbqhg0NJy8fPyKmOMj/kT1D83mgWcEiZfdEWolKCLfQUEaEAeFIRa0H0w8FC/dPLqigpoXN/XB+i3fF9GOK/EeZAxyew6kfxwZm1XaJ1dIqQv3gg3mcJg
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SETF4ugH9MadoLD3LaUJovhx8hwk+kFslREP0I+BUVpx6YupJGrN2zfg6W59NDpe6MZ4NviGKcaiu3+TwkNaLppuZC0KWv6toZqKjxNOy1fzyjUNc1MXY/PBl3l61AciouxvSvGsXU2RB7SAeSwH2F8uNtBaMAbDhKuAT77BC4htf+mAB+L0t1OCjWHIi4fU5qEb4ozNlOzQoeKzLCLDOoJVuC5pbBZ+MY2Rai5R5kavTYweY2jayQO7RtT180gxEQ1ZuaViTeaVZuOalPYZiaHXK/UX5x9L8VZdX+U6EIyk/QMfpgE74hdvKUCJK2eAE+l3kU0qLXW4P+kbxhlYa5fT7gxOJwnyKHC/hmijhEWpRaMnPWHo1T1HgyrZx1njbdFfAIk11WIXF/76Hn4ww0Z582tJ8fT979Ljy/i8Qkw85/yBP/ay50A5k2aM0AZy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:45:45.4338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ead036-2a87-4f97-ad10-08def471092c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029

The TSN IP exposes one MDIO controller per MAC at +0x500 inside
each MAC's register window. Register each bus under the matching
mdio-mac1 / mdio-mac2 child of the switch node.

A new struct xlnx_tsn_mac groups the per-MAC register window and
the back-pointer to the parent switch. MDIO callbacks and log
helpers pull what they need from it. The clock divisor comes from
the IP-wide s_axi clock, owned by the parent IP wrapper node, so
read its rate from there rather than holding a private reference.

Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 drivers/net/dsa/xilinx/xilinx_tsn.c | 203 +++++++++++++++++++++++++++-
 drivers/net/dsa/xilinx/xilinx_tsn.h |  54 +++++++-
 2 files changed, 251 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
index 020b1622670c..542b74514ed3 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.c
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.c
@@ -4,17 +4,24 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk.h>
 #include <linux/if_bridge.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/mdio.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <net/dsa.h>
 
 #include "xilinx_tsn.h"
 
+#define TSN_MDIO_MAX_FREQ_HZ		2500000
+#define TSN_MDIO_READY_TIMEOUT_US	20000
+
 static void sw_iow(struct xlnx_tsn *sw, u32 off, u32 val)
 {
 	iowrite32(val, sw->sw_base + off);
@@ -95,6 +102,190 @@ static int xlnx_tsn_set_port_state(struct xlnx_tsn *sw, int port,
 	return 0;
 }
 
+static int xlnx_tsn_mdio_wait_ready(struct xlnx_tsn_mac *m)
+{
+	u32 val;
+
+	return readl_poll_timeout(m->regs + TSN_MDIO_MCR_OFFSET, val,
+				  val & TSN_MDIO_MCR_READY, 1,
+				  TSN_MDIO_READY_TIMEOUT_US);
+}
+
+static int xlnx_tsn_mdio_read(struct mii_bus *bus, int phy_id, int reg)
+{
+	struct xlnx_tsn_mac *m = bus->priv;
+	int ret;
+
+	ret = xlnx_tsn_mdio_wait_ready(m);
+	if (ret < 0)
+		return ret;
+
+	mac_iow(m, TSN_MDIO_MCR_OFFSET,
+		FIELD_PREP(TSN_MDIO_MCR_PHYAD_MASK, phy_id) |
+		FIELD_PREP(TSN_MDIO_MCR_REGAD_MASK, reg) |
+		TSN_MDIO_MCR_INITIATE | TSN_MDIO_MCR_OP_READ);
+
+	ret = xlnx_tsn_mdio_wait_ready(m);
+	if (ret < 0)
+		return ret;
+
+	return FIELD_GET(TSN_MDIO_MRD_MASK,
+			 mac_ior(m, TSN_MDIO_MRD_OFFSET));
+}
+
+static int xlnx_tsn_mdio_write(struct mii_bus *bus, int phy_id, int reg,
+			       u16 val)
+{
+	struct xlnx_tsn_mac *m = bus->priv;
+	int ret;
+
+	ret = xlnx_tsn_mdio_wait_ready(m);
+	if (ret < 0)
+		return ret;
+
+	mac_iow(m, TSN_MDIO_MWD_OFFSET, val);
+	mac_iow(m, TSN_MDIO_MCR_OFFSET,
+		FIELD_PREP(TSN_MDIO_MCR_PHYAD_MASK, phy_id) |
+		FIELD_PREP(TSN_MDIO_MCR_REGAD_MASK, reg) |
+		TSN_MDIO_MCR_INITIATE | TSN_MDIO_MCR_OP_WRITE);
+
+	return xlnx_tsn_mdio_wait_ready(m);
+}
+
+/* Round up so the MDC frequency stays at or below TSN_MDIO_MAX_FREQ_HZ,
+ * then clamp to the 6-bit field maximum so the value stays within the
+ * field and does not corrupt TSN_MDIO_MC_MDIOEN.
+ */
+static u32 xlnx_tsn_mdio_clk_div(struct xlnx_tsn *sw, unsigned long host_hz)
+{
+	u32 div;
+
+	if (!host_hz) {
+		dev_warn(sw->dev,
+			 "s_axi clock rate unknown; clamping MDIO divisor to max\n");
+		return TSN_MDIO_MC_CLOCK_DIVIDE_MAX;
+	}
+
+	div = DIV_ROUND_UP(host_hz, TSN_MDIO_MAX_FREQ_HZ * 2) - 1;
+
+	/* HW ignores MDIO Enable when Clock Divide is 0 */
+	if (!div)
+		div = 1;
+
+	if (div > TSN_MDIO_MC_CLOCK_DIVIDE_MAX) {
+		dev_warn(sw->dev,
+			 "MDIO divisor %u exceeds max %u, clamping\n",
+			 div, TSN_MDIO_MC_CLOCK_DIVIDE_MAX);
+		div = TSN_MDIO_MC_CLOCK_DIVIDE_MAX;
+	}
+
+	return div;
+}
+
+static int xlnx_tsn_mdio_register_one(struct xlnx_tsn *sw, int port,
+				      const char *child_name,
+				      unsigned long host_hz)
+{
+	struct xlnx_tsn_mac *m = &sw->mac[port];
+	struct device_node *mdio_np;
+	struct mii_bus *bus;
+	int ret;
+
+	mdio_np = of_get_child_by_name(sw->dev->of_node, child_name);
+	if (!mdio_np)
+		return 0;
+
+	bus = devm_mdiobus_alloc(sw->dev);
+	if (!bus) {
+		of_node_put(mdio_np);
+		return -ENOMEM;
+	}
+
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s:%s",
+		 dev_name(sw->dev), child_name);
+	bus->name = "Xilinx TSN MDIO";
+	bus->priv = m;
+	bus->parent = sw->dev;
+	bus->read = xlnx_tsn_mdio_read;
+	bus->write = xlnx_tsn_mdio_write;
+
+	mac_iow(m, TSN_MDIO_MC_OFFSET,
+		xlnx_tsn_mdio_clk_div(sw, host_hz) | TSN_MDIO_MC_MDIOEN);
+
+	ret = xlnx_tsn_mdio_wait_ready(m);
+	if (ret) {
+		dev_err(sw->dev, "%s: MDIO controller not ready: %d\n",
+			child_name, ret);
+		goto err_put_np;
+	}
+
+	ret = of_mdiobus_register(bus, mdio_np);
+	if (ret) {
+		dev_err(sw->dev, "%s: failed to register MDIO bus: %d\n",
+			child_name, ret);
+		goto err_put_np;
+	}
+
+	m->mii_bus = bus;
+	of_node_put(mdio_np);
+	return 0;
+
+err_put_np:
+	of_node_put(mdio_np);
+	return ret;
+}
+
+static void xlnx_tsn_mdio_unregister_all(struct xlnx_tsn *sw)
+{
+	int port;
+
+	for (port = XLNX_TSN_PORT_MAC1; port <= XLNX_TSN_PORT_MAC2; port++) {
+		struct xlnx_tsn_mac *m = &sw->mac[port];
+
+		if (m->mii_bus) {
+			mdiobus_unregister(m->mii_bus);
+			m->mii_bus = NULL;
+		}
+
+		/* clear the enable bit even when no bus was registered (failed probe) */
+		mac_iow(m, TSN_MDIO_MC_OFFSET, 0);
+	}
+}
+
+static int xlnx_tsn_mdio_register_all(struct xlnx_tsn *sw)
+{
+	unsigned long host_hz;
+	struct clk *s_axi;
+	int ret;
+
+	/* per-MAC MDIO divisor comes from the wrapper node's s_axi
+	 * clock
+	 */
+	s_axi = clk_get(sw->dev->parent, "s_axi");
+	if (IS_ERR(s_axi))
+		return dev_err_probe(sw->dev, PTR_ERR(s_axi),
+				     "failed to get s_axi clock\n");
+
+	host_hz = clk_get_rate(s_axi);
+	clk_put(s_axi);
+
+	ret = xlnx_tsn_mdio_register_one(sw, XLNX_TSN_PORT_MAC1, "mdio-mac1",
+					 host_hz);
+	if (ret)
+		goto err_unregister;
+
+	ret = xlnx_tsn_mdio_register_one(sw, XLNX_TSN_PORT_MAC2, "mdio-mac2",
+					 host_hz);
+	if (ret)
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	xlnx_tsn_mdio_unregister_all(sw);
+	return ret;
+}
+
 static enum dsa_tag_protocol xlnx_tsn_get_tag_protocol(struct dsa_switch *ds,
 						       int port,
 						       enum dsa_tag_protocol mp)
@@ -160,7 +351,7 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
 			return ret;
 	}
 
-	return 0;
+	return xlnx_tsn_mdio_register_all(sw);
 }
 
 static void xlnx_tsn_teardown(struct dsa_switch *ds)
@@ -168,6 +359,8 @@ static void xlnx_tsn_teardown(struct dsa_switch *ds)
 	struct xlnx_tsn *sw = ds->priv;
 	struct dsa_port *dp;
 
+	xlnx_tsn_mdio_unregister_all(sw);
+
 	dsa_switch_for_each_user_port(dp, ds)
 		xlnx_tsn_set_port_state(sw, dp->index, TSN_PORT_STATE_DISABLED);
 
@@ -207,16 +400,20 @@ static int xlnx_tsn_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sw->dev = dev;
+	sw->mac[XLNX_TSN_PORT_MAC1].sw = sw;
+	sw->mac[XLNX_TSN_PORT_MAC2].sw = sw;
 
 	ret = xlnx_tsn_map_reg(pdev, "switch", &sw->sw_base);
 	if (ret)
 		return ret;
 
-	ret = xlnx_tsn_map_reg(pdev, "mac1", &sw->mac_base[XLNX_TSN_PORT_MAC1]);
+	ret = xlnx_tsn_map_reg(pdev, "mac1",
+			       &sw->mac[XLNX_TSN_PORT_MAC1].regs);
 	if (ret)
 		return ret;
 
-	ret = xlnx_tsn_map_reg(pdev, "mac2", &sw->mac_base[XLNX_TSN_PORT_MAC2]);
+	ret = xlnx_tsn_map_reg(pdev, "mac2",
+			       &sw->mac[XLNX_TSN_PORT_MAC2].regs);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
index 1064cf1ce66e..025645a83992 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.h
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.h
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/io.h>
 #include <linux/types.h>
 #include <net/dsa.h>
 
@@ -45,19 +46,66 @@ enum tsn_port_state {
 	TSN_PORT_STATE_FORWARDING,
 };
 
+/* Per-MAC MDIO controller register window, sitting at +0x500 inside
+ * each MAC's reg space owned via reg-names = "mac1", "mac2".
+ */
+#define TSN_MDIO_MC_OFFSET		0x00000500
+#define TSN_MDIO_MCR_OFFSET		0x00000504
+#define TSN_MDIO_MWD_OFFSET		0x00000508
+#define TSN_MDIO_MRD_OFFSET		0x0000050c
+
+#define TSN_MDIO_MC_MDIOEN		BIT(6)
+#define TSN_MDIO_MC_CLOCK_DIVIDE_MAX	0x3f
+
+#define TSN_MDIO_MCR_PHYAD_MASK		GENMASK(28, 24)
+#define TSN_MDIO_MCR_REGAD_MASK		GENMASK(20, 16)
+#define TSN_MDIO_MCR_OP_READ		BIT(15)
+#define TSN_MDIO_MCR_OP_WRITE		BIT(14)
+#define TSN_MDIO_MCR_INITIATE		BIT(11)
+#define TSN_MDIO_MCR_READY		BIT(7)
+
+#define TSN_MDIO_MRD_MASK		GENMASK(15, 0)
+
+struct mii_bus;
+struct xlnx_tsn;
+
+/**
+ * struct xlnx_tsn_mac - per-MAC switch-side state
+ * @sw: back-pointer to the parent switch (for dev_* logging in
+ *	bus callbacks)
+ * @regs: per-MAC register window, from reg-name "macN"
+ * @mii_bus: MDIO bus registered under the "mdio-macN" DT child,
+ *	     or NULL if absent
+ */
+struct xlnx_tsn_mac {
+	struct xlnx_tsn *sw;
+	void __iomem *regs;
+	struct mii_bus *mii_bus;
+};
+
 /**
  * struct xlnx_tsn - per-IP switch state
  * @ds: DSA switch
  * @dev: backing device
  * @sw_base: switch fabric register window
- * @mac_base: per-MAC register windows, indexed by user-port number
- *	      (index 0 unused; MAC1 at [1], MAC2 at [2])
+ * @mac: per-MAC state, indexed by user-port number (index 0 unused;
+ *	 MAC1 at [1], MAC2 at [2])
  */
 struct xlnx_tsn {
 	struct dsa_switch ds;
 	struct device *dev;
 	void __iomem *sw_base;
-	void __iomem *mac_base[XLNX_TSN_NUM_PORTS];
+	struct xlnx_tsn_mac mac[XLNX_TSN_NUM_PORTS];
 };
 
+static inline void mac_iow(struct xlnx_tsn_mac *m, u32 off, u32 val)
+{
+	iowrite32(val, m->regs + off);
+}
+
+static inline u32 mac_ior(struct xlnx_tsn_mac *m, u32 off)
+{
+	return ioread32(m->regs + off);
+}
+
 #endif /* _XILINX_TSN_H */
-- 
2.34.1

