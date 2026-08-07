Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BA42FCC2;
	Fri,  7 Aug 2026 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099581; cv=fail; b=lHL5kT47Eq/wZSo/irGa049lV9LeWtjwyY8+6MG7pVqtB05xg8/SrrlDvMbNU8Jtmn+9n3xuDao/2iVmOO2a0Ox2WFo2Fs/PK0sU2K9/m+khJOAjcBfjBeLNez/OFymRq4OdJW4Wh6fsbel8Xue6mocubVcOnYZOBzr5FsdL6YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099581; c=relaxed/simple;
	bh=NfDQit/H3Gqagh4Sws8RM546+9gVhGWID3TQusJHj/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hrer07OJBhXOkfDGZD2jstfzz+kKlr3s3fnT830/PIzvswx6zc7n6DcDqPHm3gqttOUbHJhFxvSIyAaSEpxINj3qt2EQgxjJJKnNfkeHulfT8vgQbxaLb68tuuQ8H5jE8f63a3LS28GFWRS1xZTQ4712YCBbnQHAZHg7dbta9aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eAbRrOeP; arc=fail smtp.client-ip=40.93.195.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eAbRrOeP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+buBpvt5JsCgdxPLSp6vCIZnajXZ5Yl2SgJxOvCoxAcLrIWxehrvuge7M7g9a8v5Ededg7dZ9C3Af0WX4/YMAqsO2IBwlZ75foI3hp5uDnxBcFiZEW7EkRHQmrrIFUUEFMzBxM125/is+fgle9ilmkUOwUEOpVMn2FvQTlZxtnV6NDxenmwzfjdGdhF9NO43ZvvxsVQfO76a9lcRJNFSfh3i5aBZ0yTX2VlXZsxjLcs1rf1OospHC4Ay4gotPh3KAzK6QtMBu1iCgMfOfnw/OnyWIP5xjj+iLcSExH+tgLtZLAz07A0OaF/1rRF0zBPSOwQ2P1ZdAVRJRJbyseztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixdVkEx13j+MHIM09cGrssA2HKr9JeWH00Mqxzi/0N8=;
 b=eHJsiP7xkGpuTMP+okf+j670lBqzp6Qt43GXAhB4D3LGxt5Fjnvf8kAozm8NQz7/YU84dz5zocu1VY1pbL4xKjhX85lZi120K0K2CtUMgMTS9Vh6rZzq4qZK+LvbC1+U8lvP1bfZopIgGX2cn9RrKUR+l82rUYQhpCRzzD1QcZZirQ7iXzIh4pIbre0iCnUyLsi5Zb7dPt50sPfgnWNgMUPgVUCqt5Ro9unPdSkoLEPW1jlzrHV1ab8fxicwne+fqqO50D+ke42qEkcWH4qaxYS6HUsGGAa4itDNvNS0h2RkBLWswlFsXOOmqquFmiDy94E7BTbnf6QGcXqq602kOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixdVkEx13j+MHIM09cGrssA2HKr9JeWH00Mqxzi/0N8=;
 b=eAbRrOeP3HB3LZSr78K8BskcTKdNmafr+47iNlAff6bt6zaVoEAb0teXZ2XjTzeJih+p/2uppb7PZrshYiMAaKLBWLFrw7FbCbVD7PkZKI4VhKpxdO5NO8xOGVAZYDsWNCtZwXVMlciW5lFQWTbPgQ926WLt5MIc8X2Govm0L+c=
Received: from SJ0PR13CA0114.namprd13.prod.outlook.com (2603:10b6:a03:2c5::29)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 10:46:11 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::2a) by SJ0PR13CA0114.outlook.office365.com
 (2603:10b6:a03:2c5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.9 via Frontend Transport; Fri, 7
 Aug 2026 10:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 10:46:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:46:05 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:46:00 -0500
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
Subject: [PATCH 16/20] net: dsa: xilinx: drive per-MAC PTP TX/RX hardware paths
Date: Fri, 7 Aug 2026 16:14:27 +0530
Message-ID: <20260807104431.157230-17-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: d0863d66-0f5e-4e50-dab3-08def471181a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|23010399003|82310400026|56012099006|22082099003|18002099003|3023799007|10067099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	J/J1uEZVnoAILiLAJ518ZiKILdvpViOqiKWQYuDmkT9oEedaQzSb8PjQipcPY+xK1CP2Sml39z+JNgVqMJMb9dzKaKULA3rwFtOxtXLc7rgkxhIBdNHBD0aPyAm2B8sYJ77Iyy2MGBq+jcC3mXST43/Tic2TmvCtYoPLXh+WxDxlxBhSMtQFf8W52nxaXXcbhVBTZ4ILvKrEi+pzK9sV1EbA7mgswT//MNsGJdFitEXv+53G7G6u4fPXbBpvIXPnv58ofnwYggDGOzrNFiWUOBEvqZAV3fX1gQBCyuZq/k7C6BCQWVpipHnOwnvcsdmuqNy73iWZe9VlGGzhDQfNJwLxvArCGSJCSSlDG87/npWo/2A5zXI1BfZ8CrR07i0lmHzoQ368HYBv+Ryq7v+c7IXxMjnxTF5K2SkzSDFic/pqVvn7a+v3X8zl/WEDBiZSFrdCy5hYBbRbxj1eyRpV2j4U7POurctVNzmpkic/pyk7RoYlzWeXvhER+aG/Y19u9ZB1B9xYv240xDttWFEv5ztcODhvm6E6NOrIEg0nAUB3XZ2dKU/8pig04460FY0tBwVz3ddfmSahouIdRSSE4RCM4r8pl+hnGgfkpOLjvOCCoCNwyJdJnrxdGQNwA0S2bRNOi5xJDy4bI1af4ZHtHvszRWmKLaYTsR8oHgwvCYj/X8hZdU8AdCL6TErjb5Iu/X8DPHev1YTEuJQT3vWttKxOugdA5fEvIO7L49wUI6CnWtrptNYQpKI9N/61gPdw
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(23010399003)(82310400026)(56012099006)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3YZLnVdmNJVpG5KD16k0CDwbLVIga6Pb7/pUMHB5yVPEhBsVq/riWejXQcpzTyTZ0UoBKfdthtxhGcMnWkN5DtBbg2GNHiUhGAu3nNSUILr8XeI51+Mi/E30Fha5HvACf3Lsx5Ca1+/Qolan4CqknzC3pmaQNt2qjodVa6A9Nk8OsNS+g6opMUp2FsNeEwIbFRu2cXUub8OeW6KKySCIrHptwohRUgJ1vuQ91ft5lv24BD89JCjPv9OUZXDb+4YBrr8SpKGCXF51MDQSPhujgWaqPpTLW6hes3tmuI2+Q97c6f4ivve414QDfYwvZtE2QEdQsKd65tiqG60Pnvhwwvul/At7ZGTChXEFmP7z/wdL+9fYbtFWvhhNGhEVBHsvwr3Twn6Pe7GzcMnq4wDhuX0GMrWSkT1LdrZYUIJzF07J1ZwPRbQQNx/zm3YHEQe4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:46:10.4990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0863d66-0f5e-4e50-dab3-08def471181a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

PTP event frames bypass the switch fabric. Each MAC has its own PTP
TX and PTP RX register windows in the per-MAC register space, plus
two dedicated interrupts. A frame captured in a MAC's PTP RX buffer
goes directly to the matching user port. A frame pushed to a MAC's
PTP TX buffer transmits out the same port without ever entering the
conduit or switch.

Publish the TX path to the tag protocol through ds->tagger_data
in setup(). Using a function pointer through tagger_data rather
than an exported symbol avoids a link-time dependency from the tag
module to the switch module.

TX timestamping accepts HWTSTAMP_TX_OFF and HWTSTAMP_TX_ON. Accept
any PTP v2 event RX filter and promote it to
HWTSTAMP_FILTER_PTP_V2_L2_EVENT. The per-MAC frame-filter block cannot
narrow the filter by message type.

Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 MAINTAINERS                             |   1 +
 drivers/net/dsa/xilinx/xilinx_tsn.c     |  24 ++
 drivers/net/dsa/xilinx/xilinx_tsn.h     |  76 +++++
 drivers/net/dsa/xilinx/xilinx_tsn_ptp.c | 357 +++++++++++++++++++++++-
 include/linux/dsa/xlnx_tsn.h            |  25 ++
 net/dsa/tag_xlnx_tsn.c                  |  29 +-
 6 files changed, 510 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/dsa/xlnx_tsn.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e91cb2a307d..c44b6fdd5b4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29615,6 +29615,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
 F:	drivers/net/dsa/xilinx/
 F:	drivers/net/ethernet/xilinx/tsn/
+F:	include/linux/dsa/xlnx_tsn.h
 F:	net/dsa/tag_xlnx_tsn.c
 
 XILINX UARTLITE SERIAL DRIVER
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
index 318d8b332208..e48c81f18d6e 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.c
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.c
@@ -18,6 +18,7 @@
 #include <linux/phy.h>
 #include <linux/phylink.h>
 #include <linux/platform_device.h>
+#include <linux/dsa/xlnx_tsn.h>
 #include <net/dsa.h>
 
 #include "xilinx_tsn.h"
@@ -679,8 +680,25 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
 	if (ret)
 		goto err_nb;
 
+	ret = xlnx_tsn_port_ptp_init(sw, XLNX_TSN_PORT_MAC1,
+				     "ptp_rx_mac1", "ptp_tx_mac1");
+	if (ret)
+		goto err_ptp_exit;
+
+	ret = xlnx_tsn_port_ptp_init(sw, XLNX_TSN_PORT_MAC2,
+				     "ptp_rx_mac2", "ptp_tx_mac2");
+	if (ret)
+		goto err_ptp_mac1;
+
+	sw->tagger_data.ptp_tx = xlnx_tsn_ptp_tx;
+	ds->tagger_data = &sw->tagger_data;
+
 	return 0;
 
+err_ptp_mac1:
+	xlnx_tsn_port_ptp_exit(sw, XLNX_TSN_PORT_MAC1);
+err_ptp_exit:
+	xlnx_tsn_ptp_exit(sw);
 err_nb:
 	unregister_netdevice_notifier(&sw->nb);
 err_mdio:
@@ -692,7 +710,10 @@ static void xlnx_tsn_teardown(struct dsa_switch *ds)
 {
 	struct xlnx_tsn *sw = ds->priv;
 	struct dsa_port *dp;
+	int port;
 
+	for (port = XLNX_TSN_PORT_MAC1; port <= XLNX_TSN_PORT_MAC2; port++)
+		xlnx_tsn_port_ptp_exit(sw, port);
 	xlnx_tsn_ptp_exit(sw);
 	unregister_netdevice_notifier(&sw->nb);
 	xlnx_tsn_mdio_unregister_all(sw);
@@ -709,6 +730,9 @@ static const struct dsa_switch_ops xlnx_tsn_switch_ops = {
 	.teardown		= xlnx_tsn_teardown,
 	.port_set_mac_address	= xlnx_tsn_port_set_mac_address,
 	.port_stp_state_set	= xlnx_tsn_port_stp_state_set,
+	.port_hwtstamp_get	= xlnx_tsn_port_hwtstamp_get,
+	.port_hwtstamp_set	= xlnx_tsn_port_hwtstamp_set,
+	.get_ts_info		= xlnx_tsn_get_ts_info,
 	.phylink_get_caps	= xlnx_tsn_phylink_get_caps,
 };
 
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
index 6063763b5c17..d46150535775 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.h
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.h
@@ -9,10 +9,14 @@
 #include <linux/bits.h>
 #include <linux/if_ether.h>
 #include <linux/io.h>
+#include <linux/net_tstamp.h>
 #include <linux/notifier.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
+#include <linux/dsa/xlnx_tsn.h>
 #include <net/dsa.h>
 
 #define XLNX_TSN_NUM_PORTS	3
@@ -127,7 +131,44 @@ enum tsn_port_state {
 #define TSN_TIMER_PULSES_PER_PPS	128
 #define TSN_TIMER_GTX_CLK_FREQ		125000000U
 
+/* Per-MAC PTP TX / RX register windows, sitting inside each per-MAC
+ * reg space. Each PTP TX slot is 256 B wide; the first 8 B hold the
+ * cmd1/cmd2 header, leaving 248 B for frame data. HW provides 8 slots.
+ * The PTP RX buffer mirrors the layout with a 252 B usable area and
+ * an 8 B HW timestamp footer.
+ */
+#define TSN_PTP_TX_CONTROL_OFFSET	0x00012000
+#define TSN_PTP_RX_CONTROL_OFFSET	0x00012004
+
+#define TSN_PTP_RX_BASE_OFFSET		0x00010000
+#define TSN_PTP_RX_PACKET_FIELD_MASK	GENMASK(11, 8)
+#define TSN_PTP_RX_PACKET_CLEAR		BIT(0)
+
+#define TSN_PTP_TX_BASE_OFFSET		0x00011000
+#define TSN_PTP_TX_HWBUF_SIZE		0x100
+#define TSN_PTP_TX_BUFFERS		8
+#define TSN_PTP_TX_BUFFER_OFFSET(i)	(TSN_PTP_TX_BASE_OFFSET + \
+					 (i) * TSN_PTP_TX_HWBUF_SIZE)
+#define TSN_PTP_TX_CMD_FIELD_LEN	8
+#define TSN_PTP_TX_MAX_FRAME_SIZE	(TSN_PTP_TX_HWBUF_SIZE - \
+					 TSN_PTP_TX_CMD_FIELD_LEN)
+#define TSN_PTP_TX_BUFFER_CMD2_FIELD	0x4
+
+#define TSN_PTP_TX_FRAME_WAITING_MASK	GENMASK(15, 8)
+#define TSN_PTP_TX_BUFFERS_FULL_MASK	BIT(TSN_PTP_TX_BUFFERS - 1)
+#define TSN_PTP_TX_PACKET_FIELD_MASK	GENMASK(18, 16)
+
+#define TSN_PTP_HW_TSTAMP_SIZE		8
+#define TSN_PTP_RX_HWBUF_SIZE		256
+#define TSN_PTP_RX_FRAME_SIZE		252
+#define TSN_PTP_HW_TSTAMP_OFFSET	(TSN_PTP_RX_HWBUF_SIZE - \
+					 TSN_PTP_HW_TSTAMP_SIZE)
+
+#define TSN_PTP_MSG_TYPE_MASK		BIT(3)
+
+struct kernel_ethtool_ts_info;
 struct mii_bus;
+struct netlink_ext_ack;
 struct xlnx_tsn;
 
 /**
@@ -137,11 +178,32 @@ struct xlnx_tsn;
  * @regs: per-MAC register window, from reg-name "macN"
  * @mii_bus: MDIO bus registered under the "mdio-macN" DT child,
  *	     or NULL if absent
+ * @ptp_tx_irq: per-MAC PTP TX-completion interrupt
+ * @ptp_rx_irq: per-MAC PTP RX interrupt
+ * @ptp_tx_lock: serialises the PTP TX slot allocator and the TX
+ *		 completion path
+ * @ptp_txq: in-flight PTP TX frames awaiting timestamp completion.
+ *	     Each frame's slot index is kept in skb->cb[0].
+ * @tx_tstamp_work: work item queued by the PTP TX IRQ to drain
+ *		    ptp_txq and deliver timestamps through skb_tstamp_tx()
+ * @ptp_rx_hw_pointer: HW write pointer snapshot read in the RX ISR
+ * @ptp_rx_sw_pointer: SW read pointer; drained until it catches up
+ * @hwtstamp_tx_type: current SO_TIMESTAMPING TX type for this port
+ * @hwtstamp_rx_filter: current SO_TIMESTAMPING RX filter for this port
  */
 struct xlnx_tsn_mac {
 	struct xlnx_tsn *sw;
 	void __iomem *regs;
 	struct mii_bus *mii_bus;
+	int ptp_tx_irq;
+	int ptp_rx_irq;
+	spinlock_t ptp_tx_lock; /* serialises PTP TX slot alloc + completion */
+	struct sk_buff_head ptp_txq;
+	struct work_struct tx_tstamp_work;
+	u32 ptp_rx_hw_pointer;
+	u32 ptp_rx_sw_pointer;
+	int hwtstamp_tx_type;
+	int hwtstamp_rx_filter;
 };
 
 /**
@@ -167,6 +229,8 @@ struct xlnx_tsn_mac {
  *	       used as the starting point for adjust_by_scaled_ppm()
  * @pps_enable: user requested PPS event delivery
  * @countpulse: timer-tick counter, reset to zero every TSN_TIMER_PULSES_PER_PPS ticks
+ * @tagger_data: PTP TX callback descriptor handed to the tag protocol
+ *		 via @dsa_switch.tagger_data
  */
 struct xlnx_tsn {
 	struct dsa_switch ds;
@@ -183,6 +247,7 @@ struct xlnx_tsn {
 	u64 rtc_value;
 	int pps_enable;
 	int countpulse;
+	struct xlnx_tsn_tagger_data tagger_data;
 };
 
 static inline void mac_iow(struct xlnx_tsn_mac *m, u32 off, u32 val)
@@ -197,5 +262,16 @@ static inline u32 mac_ior(struct xlnx_tsn_mac *m, u32 off)
 
 int xlnx_tsn_ptp_init(struct xlnx_tsn *sw);
 void xlnx_tsn_ptp_exit(struct xlnx_tsn *sw);
+int xlnx_tsn_port_ptp_init(struct xlnx_tsn *sw, int port,
+			   const char *rx_name, const char *tx_name);
+void xlnx_tsn_port_ptp_exit(struct xlnx_tsn *sw, int port);
+void xlnx_tsn_ptp_tx(struct dsa_port *dp, struct sk_buff *skb);
+int xlnx_tsn_port_hwtstamp_get(struct dsa_switch *ds, int port,
+			       struct kernel_hwtstamp_config *config);
+int xlnx_tsn_port_hwtstamp_set(struct dsa_switch *ds, int port,
+			       struct kernel_hwtstamp_config *config,
+			       struct netlink_ext_ack *extack);
+int xlnx_tsn_get_ts_info(struct dsa_switch *ds, int port,
+			 struct kernel_ethtool_ts_info *info);
 
 #endif /* _XILINX_TSN_H */
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c b/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c
index 75c177f752f1..740d92e3e80d 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c
+++ b/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c
@@ -1,18 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * AMD/Xilinx TSN Endpoint Ethernet MAC DSA switch driver:
- * PTP hardware clock.
+ * PTP hardware clock and per-MAC PTP TX/RX paths.
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/ktime.h>
 #include <linux/math64.h>
+#include <linux/net_tstamp.h>
+#include <linux/netdevice.h>
 #include <linux/of_irq.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/time64.h>
+#include <linux/unaligned.h>
+#include <linux/workqueue.h>
 #include <net/dsa.h>
 
 #include "xilinx_tsn.h"
@@ -233,3 +241,350 @@ void xlnx_tsn_ptp_exit(struct xlnx_tsn *sw)
 	ptp_clock_unregister(sw->ptp_clock);
 	sw->ptp_clock = NULL;
 }
+
+static void memcpy_toio_32(struct xlnx_tsn_mac *m, unsigned long off,
+			   const u8 *data, size_t len)
+{
+	while (len >= 4) {
+		mac_iow(m, off, get_unaligned((const u32 *)data));
+		off += 4;
+		data += 4;
+		len -= 4;
+	}
+
+	if (len) {
+		u32 leftover = 0;
+		u8 *dst = (u8 *)&leftover;
+
+		while (len--)
+			*dst++ = *data++;
+		mac_iow(m, off, leftover);
+	}
+}
+
+static void memcpy_fromio_32(struct xlnx_tsn_mac *m, unsigned long off,
+			     u8 *data, size_t len)
+{
+	while (len >= 4) {
+		put_unaligned(mac_ior(m, off), (u32 *)data);
+		off += 4;
+		data += 4;
+		len -= 4;
+	}
+
+	if (len) {
+		u32 leftover = mac_ior(m, off);
+		u8 *src = (u8 *)&leftover;
+
+		while (len--)
+			*data++ = *src++;
+	}
+}
+
+static void xlnx_tsn_read_tstamp(struct xlnx_tsn_mac *m,
+				 struct skb_shared_hwtstamps *hwtstamps,
+				 unsigned int off)
+{
+	u32 captured_ns, captured_sec;
+
+	memset(hwtstamps, 0, sizeof(*hwtstamps));
+
+	captured_ns = mac_ior(m, off + 4);
+	captured_sec = mac_ior(m, off);
+
+	hwtstamps->hwtstamp = ktime_set(captured_sec, captured_ns);
+}
+
+void xlnx_tsn_ptp_tx(struct dsa_port *dp, struct sk_buff *skb)
+{
+	struct xlnx_tsn *sw = dp->ds->priv;
+	u32 frame_waiting, cmd1, cmd2 = 0;
+	struct xlnx_tsn_mac *m;
+	u8 free_index;
+
+	m = &sw->mac[dp->index];
+
+	if (unlikely(skb->len > TSN_PTP_TX_MAX_FRAME_SIZE)) {
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	scoped_guard(spinlock_irqsave, &m->ptp_tx_lock) {
+		frame_waiting = FIELD_GET(TSN_PTP_TX_FRAME_WAITING_MASK,
+					  mac_ior(m, TSN_PTP_TX_CONTROL_OFFSET));
+		if (frame_waiting & TSN_PTP_TX_BUFFERS_FULL_MASK) {
+			dev_kfree_skb_any(skb);
+			return;
+		}
+
+		free_index = fls(frame_waiting);
+		cmd1 = skb->len;
+
+		mac_iow(m, TSN_PTP_TX_BUFFER_OFFSET(free_index), cmd1);
+		mac_iow(m, TSN_PTP_TX_BUFFER_OFFSET(free_index) +
+			TSN_PTP_TX_BUFFER_CMD2_FIELD, cmd2);
+		memcpy_toio_32(m,
+			       TSN_PTP_TX_BUFFER_OFFSET(free_index) +
+			       TSN_PTP_TX_CMD_FIELD_LEN,
+			       skb->data, skb->len);
+
+		skb->cb[0] = free_index;
+		__skb_queue_tail(&m->ptp_txq, skb);
+
+		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
+		skb_tx_timestamp(skb);
+		mac_iow(m, TSN_PTP_TX_CONTROL_OFFSET, BIT(free_index));
+	}
+}
+
+static void xlnx_tsn_ptp_recv(struct xlnx_tsn *sw, int port)
+{
+	struct net_device *user = dsa_to_port(&sw->ds, port)->user;
+	struct xlnx_tsn_mac *m = &sw->mac[port];
+	unsigned long frame_base;
+	struct sk_buff *skb;
+	u16 msg_len;
+	u8 msg_type;
+
+	if (!user || !netif_running(user))
+		return;
+
+	while ((m->ptp_rx_hw_pointer & 0xf) != (m->ptp_rx_sw_pointer & 0xf)) {
+		m->ptp_rx_sw_pointer++;
+
+		frame_base = TSN_PTP_RX_BASE_OFFSET +
+			     (m->ptp_rx_sw_pointer & 0xf) *
+			     TSN_PTP_RX_HWBUF_SIZE;
+
+		skb = netdev_alloc_skb(user, TSN_PTP_RX_FRAME_SIZE);
+		if (!skb) {
+			DEV_STATS_INC(user, rx_dropped);
+			continue;
+		}
+
+		memcpy_fromio_32(m, frame_base, skb->data,
+				 TSN_PTP_RX_FRAME_SIZE);
+
+		msg_type = *(u8 *)(skb->data + ETH_HLEN) & 0xf;
+		msg_len = get_unaligned_be16(skb->data + ETH_HLEN + 2);
+
+		if (msg_len + ETH_HLEN > TSN_PTP_RX_FRAME_SIZE) {
+			dev_kfree_skb_any(skb);
+			DEV_STATS_INC(user, rx_length_errors);
+			continue;
+		}
+
+		skb_put(skb, msg_len + ETH_HLEN);
+		skb->protocol = eth_type_trans(skb, user);
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		if (READ_ONCE(m->hwtstamp_rx_filter) != HWTSTAMP_FILTER_NONE &&
+		    !(msg_type & TSN_PTP_MSG_TYPE_MASK))
+			xlnx_tsn_read_tstamp(m, skb_hwtstamps(skb),
+					     frame_base +
+					     TSN_PTP_HW_TSTAMP_OFFSET);
+
+		dev_sw_netstats_rx_add(user, skb->len);
+		netif_rx(skb);
+	}
+}
+
+static irqreturn_t xlnx_tsn_ptp_rx_isr(int irq, void *data)
+{
+	struct xlnx_tsn_mac *m = data;
+	struct xlnx_tsn *sw = m->sw;
+	int port = m - sw->mac;
+
+	m->ptp_rx_hw_pointer = FIELD_GET(TSN_PTP_RX_PACKET_FIELD_MASK,
+					 mac_ior(m, TSN_PTP_RX_CONTROL_OFFSET));
+	xlnx_tsn_ptp_recv(sw, port);
+
+	return IRQ_HANDLED;
+}
+
+static void xlnx_tsn_tx_tstamp_work(struct work_struct *work)
+{
+	struct xlnx_tsn_mac *m = container_of(work, struct xlnx_tsn_mac,
+					      tx_tstamp_work);
+	struct skb_shared_hwtstamps hwtstamps;
+	unsigned long ts_off;
+	struct sk_buff *skb;
+	u8 tx_packet, index;
+
+	guard(spinlock_irqsave)(&m->ptp_tx_lock);
+
+	tx_packet = FIELD_GET(TSN_PTP_TX_PACKET_FIELD_MASK,
+			      mac_ior(m, TSN_PTP_TX_CONTROL_OFFSET));
+
+	while ((skb = __skb_dequeue(&m->ptp_txq)) != NULL) {
+		index = skb->cb[0];
+
+		/* HW writes ascending slot indices into the TX status field
+		 * as frames depart. Any queued skb with index > tx_packet
+		 * has not been timestamped yet, so requeue it and stop.
+		 */
+		if (index > tx_packet) {
+			__skb_queue_head(&m->ptp_txq, skb);
+			break;
+		}
+
+		ts_off = TSN_PTP_TX_BUFFER_OFFSET(index) +
+			 TSN_PTP_HW_TSTAMP_OFFSET;
+
+		if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS) {
+			xlnx_tsn_read_tstamp(m, &hwtstamps, ts_off);
+			skb_tstamp_tx(skb, &hwtstamps);
+		}
+		consume_skb(skb);
+	}
+}
+
+static irqreturn_t xlnx_tsn_ptp_tx_isr(int irq, void *data)
+{
+	struct xlnx_tsn_mac *m = data;
+
+	mac_ior(m, TSN_PTP_TX_CONTROL_OFFSET);
+	schedule_work(&m->tx_tstamp_work);
+
+	return IRQ_HANDLED;
+}
+
+int xlnx_tsn_port_ptp_init(struct xlnx_tsn *sw, int port,
+			   const char *rx_name, const char *tx_name)
+{
+	struct xlnx_tsn_mac *m = &sw->mac[port];
+	int ret;
+
+	skb_queue_head_init(&m->ptp_txq);
+	spin_lock_init(&m->ptp_tx_lock);
+	INIT_WORK(&m->tx_tstamp_work, xlnx_tsn_tx_tstamp_work);
+	m->ptp_rx_hw_pointer = 0;
+	m->ptp_rx_sw_pointer = 0xff;
+	m->hwtstamp_tx_type = HWTSTAMP_TX_OFF;
+	m->hwtstamp_rx_filter = HWTSTAMP_FILTER_NONE;
+
+	m->ptp_rx_irq = of_irq_get_byname(sw->dev->of_node, rx_name);
+	if (m->ptp_rx_irq <= 0)
+		return dev_err_probe(sw->dev, m->ptp_rx_irq ? : -ENXIO,
+				     "failed to get %s IRQ\n", rx_name);
+
+	m->ptp_tx_irq = of_irq_get_byname(sw->dev->of_node, tx_name);
+	if (m->ptp_tx_irq <= 0)
+		return dev_err_probe(sw->dev, m->ptp_tx_irq ? : -ENXIO,
+				     "failed to get %s IRQ\n", tx_name);
+
+	mac_iow(m, TSN_PTP_RX_CONTROL_OFFSET, TSN_PTP_RX_PACKET_CLEAR);
+
+	ret = request_irq(m->ptp_rx_irq, xlnx_tsn_ptp_rx_isr, 0, rx_name, m);
+	if (ret)
+		return dev_err_probe(sw->dev, ret,
+				     "failed to request %s IRQ %d\n",
+				     rx_name, m->ptp_rx_irq);
+
+	ret = request_irq(m->ptp_tx_irq, xlnx_tsn_ptp_tx_isr, 0, tx_name, m);
+	if (ret) {
+		free_irq(m->ptp_rx_irq, m);
+		return dev_err_probe(sw->dev, ret,
+				     "failed to request %s IRQ %d\n",
+				     tx_name, m->ptp_tx_irq);
+	}
+
+	return 0;
+}
+
+void xlnx_tsn_port_ptp_exit(struct xlnx_tsn *sw, int port)
+{
+	struct xlnx_tsn_mac *m = &sw->mac[port];
+	struct sk_buff *skb;
+
+	if (m->ptp_tx_irq > 0)
+		free_irq(m->ptp_tx_irq, m);
+
+	if (m->ptp_rx_irq > 0)
+		free_irq(m->ptp_rx_irq, m);
+
+	cancel_work_sync(&m->tx_tstamp_work);
+
+	scoped_guard(spinlock_irqsave, &m->ptp_tx_lock)
+		while ((skb = __skb_dequeue(&m->ptp_txq)) != NULL)
+			dev_kfree_skb_any(skb);
+}
+
+int xlnx_tsn_port_hwtstamp_get(struct dsa_switch *ds, int port,
+			       struct kernel_hwtstamp_config *config)
+{
+	struct xlnx_tsn *sw = ds->priv;
+	struct xlnx_tsn_mac *m;
+
+	m = &sw->mac[port];
+
+	if (port == XLNX_TSN_CPU_PORT)
+		return -EOPNOTSUPP;
+
+	config->tx_type = m->hwtstamp_tx_type;
+	config->rx_filter = m->hwtstamp_rx_filter;
+
+	return 0;
+}
+
+int xlnx_tsn_port_hwtstamp_set(struct dsa_switch *ds, int port,
+			       struct kernel_hwtstamp_config *config,
+			       struct netlink_ext_ack *extack)
+{
+	struct xlnx_tsn *sw = ds->priv;
+	struct xlnx_tsn_mac *m;
+
+	m = &sw->mac[port];
+
+	if (port == XLNX_TSN_CPU_PORT)
+		return -EOPNOTSUPP;
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+	case HWTSTAMP_TX_ON:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	/* The per-MAC RX filter is left at its power-on default, which
+	 * captures L2 gPTP event frames (ethertype 0x88f7) only. PTP over
+	 * UDP is not supported. The filter cannot narrow by message type,
+	 * so any L2 PTPv2 event request is promoted to
+	 * HWTSTAMP_FILTER_PTP_V2_L2_EVENT.
+	 */
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	m->hwtstamp_tx_type = config->tx_type;
+	WRITE_ONCE(m->hwtstamp_rx_filter, config->rx_filter);
+
+	return 0;
+}
+
+int xlnx_tsn_get_ts_info(struct dsa_switch *ds, int port,
+			 struct kernel_ethtool_ts_info *info)
+{
+	struct xlnx_tsn *sw = ds->priv;
+
+	info->phc_index = sw->ptp_clock ? ptp_clock_index(sw->ptp_clock) : -1;
+	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+			    BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT);
+
+	return 0;
+}
diff --git a/include/linux/dsa/xlnx_tsn.h b/include/linux/dsa/xlnx_tsn.h
new file mode 100644
index 000000000000..34a451f4568a
--- /dev/null
+++ b/include/linux/dsa/xlnx_tsn.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * AMD/Xilinx TSN Endpoint Ethernet MAC: shared tagger / switch
+ * private interface.
+ */
+#ifndef _NET_DSA_XLNX_TSN_H
+#define _NET_DSA_XLNX_TSN_H
+
+#include <linux/skbuff.h>
+#include <net/dsa.h>
+
+/**
+ * struct xlnx_tsn_tagger_data - per-switch context for the tag protocol
+ * @ptp_tx: callback that copies a PTP event frame into the per-port
+ *	    hardware TX buffer and holds the skb until the TX IRQ
+ *	    delivers the timestamp. Consumes one reference to @skb.
+ *
+ * Set on @dsa_switch.tagger_data by the switch driver in setup()
+ * and read by the tag protocol's xmit hook.
+ */
+struct xlnx_tsn_tagger_data {
+	void (*ptp_tx)(struct dsa_port *dp, struct sk_buff *skb);
+};
+
+#endif /* _NET_DSA_XLNX_TSN_H */
diff --git a/net/dsa/tag_xlnx_tsn.c b/net/dsa/tag_xlnx_tsn.c
index de352aa3d9a8..6f487ad7bcf9 100644
--- a/net/dsa/tag_xlnx_tsn.c
+++ b/net/dsa/tag_xlnx_tsn.c
@@ -3,14 +3,41 @@
  * AMD/Xilinx TSN Endpoint Ethernet MAC tag protocol.
  */
 
+#include <linux/dsa/xlnx_tsn.h>
+#include <linux/if_vlan.h>
+
 #include "tag.h"
 
 #define XLNX_TSN_NAME	"xlnx_tsn"
 
+/* PTP frames must go directly into the egress MAC's hardware TX buffer,
+ * not through the switch fabric or conduit DMA. Intercept here before
+ * dsa_enqueue_skb() takes the frame and hand off our reference: ptp_tx()
+ * consumes it, freeing the skb once the HW timestamp is read (or on
+ * error).
+ *
+ * VLAN-tagged PTP is not supported. Match on the L2 ethertype and
+ * skip any VLAN-tagged frame.
+ */
 static struct sk_buff *xlnx_tsn_xmit(struct sk_buff *skb,
 				     struct net_device *dev)
 {
-	return skb;
+	struct xlnx_tsn_tagger_data *tagger_data;
+	struct dsa_port *dp;
+
+	dp = dsa_user_to_port(dev);
+	tagger_data = dp->ds->tagger_data;
+
+	if (!tagger_data || !tagger_data->ptp_tx)
+		return skb;
+
+	if (eth_hdr(skb)->h_proto != htons(ETH_P_1588) ||
+	    skb_vlan_tag_present(skb))
+		return skb;
+
+	tagger_data->ptp_tx(dp, skb);
+
+	return NULL;
 }
 
 static struct sk_buff *xlnx_tsn_rcv(struct sk_buff *skb,
-- 
2.34.1

