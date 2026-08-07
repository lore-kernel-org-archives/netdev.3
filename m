Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FBE42FCC2;
	Fri,  7 Aug 2026 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099542; cv=fail; b=PII4qSlhCKlwfpD8JY2t42nr5dTpvnCo7PYTFGuytFpImZiJ0LK24McUI4EHAJwBvSgaH2m+3nmEO3mjVwiZxdbs7r/h55g9Y3Go4IQCzhO+El2OP/mmS618PCnxNFpA9S52sCtqvVjMgclnpOYvXIYygU8oUsOMv4H40xxmT6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099542; c=relaxed/simple;
	bh=xiOdPf+JmIIavDsBUHotwIfRTJkYLABoRX9gBHFlf70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmIxoegir34muzWCVT+okJJxJ/oj3Wy5kicBtAVGlIQg0Qiv0vbkVAVerAYrRn0OoUOFuuDFbQUzZFLUI2kazXoW/BsOAHXbXMdXOPRkUj8/KYc6MV2XIPf9DtsZY5wiGD6RrrAIcIj+CYPwgEVJOu8Ll/SwY90VLg3jB3jEqrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OqWED1Cq; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OqWED1Cq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCYqem8rBI2QZjGuHSFfWxTUFIw5WpOmTlZo5YkKh3ZNMCqExEWPw3wdHqtqz78kt3GUhp30cLyw/FaWh9I3DXtxTEqapE84s5GFcxRQmCcpi8j8f4U2zinUz4ioIIzB0cZLmAKCoavH1HAFKgbyGea1vOjKx7Qc75cicft831fYfHoSYbnZIE1iSTNQSImAdEdFzRV811oHipu79m1d3M3mBSHm7nMxkPyLczjZYkEMFhYORhl1pZ0g9g2rzqfI2pp7+ebX3F3OrsmX3fGdDmm9aECHHpFp0QuVTnLDhfqzCgM5mp8cKx5Ch0L2uVvSDd1RTTK/ojHtFK9zfUT23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJPoxpUO28vkt+Xzt2+HLrMEFtqmCbP0XZfa4v90xPo=;
 b=tF06/hFbY+efs6hbCHes7DiGbvjOF/vV9/tUIDWLUBp5RX17nkFTEy69CMwPIB1kUEGZm75dVR53hVbTGvlqCUeHebHiBR0Wqw4vSKet4ikq5w2ht+Of5iuNZ2r33xX56KzWbfovfWcsD0cS+4ZryNy6HhcY9glMPZ93bTyxYvAyf4oIaclObSJciud6nB8DDWs2JG5mOYy+rCL4/0MqJNTscqjPZ73QWmfCUaxdpMS1inJXyru7XATZY7lZYGdyF/LPLMlM/92YUTIjplXwSfXXZwgYLOyuN52LptagseaZ9/q825ldG9qONX/Us8IuxbgBG9BqiNz5JV/S1Q5mFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJPoxpUO28vkt+Xzt2+HLrMEFtqmCbP0XZfa4v90xPo=;
 b=OqWED1CqJLPVsY0mm22+TsJI25TkuubGfvWFmu69thmjkmPDVQlVykUYqHaO5oPlnT5zbxHaMgJVsbjapkxQwIPjLyrjDNIW+ep6GMJQIXMw5dOAaBZoVoXh9t/EgzDJABx8+v7XL/t+b6hKVs1eCVGh0bJOZSa+dcqNNV/a2K0=
Received: from PH7P220CA0084.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::7)
 by IA4PR12MB9809.namprd12.prod.outlook.com (2603:10b6:208:54f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 10:45:36 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::86) by PH7P220CA0084.outlook.office365.com
 (2603:10b6:510:32c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 10:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Fri, 7 Aug 2026 10:45:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:45:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:45:27 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:45:22 -0500
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
Subject: [PATCH 09/20] net: dsa: tag_xlnx_tsn: add skeleton tag protocol
Date: Fri, 7 Aug 2026 16:14:20 +0530
Message-ID: <20260807104431.157230-10-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|IA4PR12MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: ecaaf5b4-d13a-4df9-a9f7-08def471039b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|921020|56012099006|11063799006|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	aBTDdXK9oDgbTTJXqaC0RoK+9KKlfcrQfwdREJUtHKF9oomfWXvA4qHvMdSsICVGYUpr5/wpsTFlvvPF77kcVpYUt7bN5kp89fnHdmH/K+re7r95VqNbkXzdlTUNAx0IoM6TtyJCLF3u9Nc+LGSFGuDtFXmkX+k8Kudu9WulqapKsDWAcpSCkFpo7IeptFOgIshorCtalWOu48yQ3C7k7NkfvBOonRWL42flzE3Av+/69Ivf3SKrZzjevRbUXvWDEcTiBN/MHMtNN0e167nbnPn0M5Cb30UGwXws4S0E83hlh+SaLMUpyFrhF2PintKSjtHnxA+6dafy79TSXb/rrKRLAunS9LYyq2HxXjX7c3R6sxQcT9dSLAAAsM+Cv8UUq9pvDjUjq8T6yEi5hMTUx6esHPvK2OvUd8uU5QSvKvIADK5YyVWErju/zmz37Pp+hd8xcX8uwNa/MuChbfyT4aH9JyOIN+HfwWFokXxiFqisBkOl1d6fsxKy0I0N6lL4fPvX/r5AF9vAY0GfcbDkTPmKb6CHVbjXai845VdFNo59ntan3jBHE1huE0kr016Xv45c3h6vM9SHc5JFeY7sb+oTdaAvgbiWeRktMw81DiCwAPOmJD92T/geeVdljoTCtNyKMgJ49DdLVtkFrueFnZYq/HLv0TcrqTgx9j0tzPfHtAJ4xrlOIOtZUCbPHskVNL5SKksTLOSAmhV1uoZiZadFF159FV7WS/r7agoanrVDgXOtkd3/BeNovglL3MXD
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(921020)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jeEm+a6Hq921y4TDImadQjdRIsTmYeyGNV+ElgnY6nzhQaYTNaWHXYIgrIYewQxlGAzmEcoKTRIhS85ZbwyP218Ew5vlnHj9z1frbHWPTL0c8Vxh07cM54WiK9/v1Vj2FSKoIdjuOTf16sSL6/7AtzWsARV9hxCko+ZZbKuKJJlhJUaWbPnGbeMDqY/t/jwXo1T9Xw62/2Awxm58KDnYecyQHPfTjPK7iiu3Wywd96o258esYVSBoqY9kl9aW1xHOKxB04WTu168fbABbMPniDtNVpFr+qNUn0Y8n/SPGC5pFO9/WkA1h49/MqqFiJX7w/6FNcx5yraNYRcfY/7z4/ktjb1Y3RNBtZQh7cHpfry+vkS95iV6K5xH0fgCxsDzOi0Kuvs0IbbGHx5QP43JiUx13xhTWHBh4qV/zmfHOg3ntAFS+PrVVeXW2K29ZaNm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:45:36.0863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaaf5b4-d13a-4df9-a9f7-08def471039b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9809

The AMD/Xilinx TSN Endpoint Ethernet MAC IP does not insert an
in-band CPU tag on the wire. The EP MAC driver attaches a per-port
metadata_dst (METADATA_HW_PORT_MUX) on RX to carry the port
classification out of band. The tag protocol therefore has no tag
bytes to add or strip.

Add DSA_TAG_PROTO_XLNX_TSN and register NET_DSA_TAG_XLNX_TSN as a
no-op tag driver. A later patch adds the PTP TX intercept to reroute
PTP frames through the per-MAC PTP TX path.

Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 MAINTAINERS            |  1 +
 include/net/dsa.h      |  2 ++
 net/dsa/Kconfig        |  9 +++++++++
 net/dsa/Makefile       |  1 +
 net/dsa/tag_xlnx_tsn.c | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 46 insertions(+)
 create mode 100644 net/dsa/tag_xlnx_tsn.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e5b95b3bfa21..6fbe83fb3953 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29614,6 +29614,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
 F:	drivers/net/ethernet/xilinx/tsn/
+F:	net/dsa/tag_xlnx_tsn.c
 
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6f7f5c17b532..f0cc5b49407a 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -60,6 +60,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_MXL862_VALUE		32
 #define DSA_TAG_PROTO_NETC_VALUE		33
 #define DSA_TAG_PROTO_KSZ8463_VALUE		34
+#define DSA_TAG_PROTO_XLNX_TSN_VALUE		35
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -97,6 +98,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
 	DSA_TAG_PROTO_NETC		= DSA_TAG_PROTO_NETC_VALUE,
 	DSA_TAG_PROTO_KSZ8463		= DSA_TAG_PROTO_KSZ8463_VALUE,
+	DSA_TAG_PROTO_XLNX_TSN		= DSA_TAG_PROTO_XLNX_TSN_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index d5e725b90d78..8ca48ce46ec1 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -221,4 +221,13 @@ config NET_DSA_TAG_YT921X
 	  Say Y or M if you want to enable support for tagging frames for
 	  Motorcomm YT921x switches.
 
+config NET_DSA_TAG_XLNX_TSN
+	tristate "Tag driver for AMD/Xilinx TSN Endpoint Ethernet MAC"
+	help
+	  Say Y or M if you want to enable support for the AMD/Xilinx TSN
+	  Endpoint Ethernet MAC IP. The IP does not insert an in-band CPU
+	  tag; port classification is conveyed via metadata_dst attached on
+	  RX by the EP MAC driver, and PTP TX frames are intercepted in the
+	  xmit hook to be steered into the per-MAC PTP TX register window.
+
 endif
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index b8c2667cd14a..6ba6c3a95976 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_NET_DSA_TAG_RZN1_A5PSW) += tag_rzn1_a5psw.o
 obj-$(CONFIG_NET_DSA_TAG_SJA1105) += tag_sja1105.o
 obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
 obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
+obj-$(CONFIG_NET_DSA_TAG_XLNX_TSN) += tag_xlnx_tsn.o
 obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
 obj-$(CONFIG_NET_DSA_TAG_YT921X) += tag_yt921x.o
 
diff --git a/net/dsa/tag_xlnx_tsn.c b/net/dsa/tag_xlnx_tsn.c
new file mode 100644
index 000000000000..de352aa3d9a8
--- /dev/null
+++ b/net/dsa/tag_xlnx_tsn.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD/Xilinx TSN Endpoint Ethernet MAC tag protocol.
+ */
+
+#include "tag.h"
+
+#define XLNX_TSN_NAME	"xlnx_tsn"
+
+static struct sk_buff *xlnx_tsn_xmit(struct sk_buff *skb,
+				     struct net_device *dev)
+{
+	return skb;
+}
+
+static struct sk_buff *xlnx_tsn_rcv(struct sk_buff *skb,
+				    struct net_device *dev)
+{
+	kfree_skb(skb);
+	return NULL;
+}
+
+static const struct dsa_device_ops xlnx_tsn_netdev_ops = {
+	.name	= XLNX_TSN_NAME,
+	.proto	= DSA_TAG_PROTO_XLNX_TSN,
+	.xmit	= xlnx_tsn_xmit,
+	.rcv	= xlnx_tsn_rcv,
+};
+
+module_dsa_tag_driver(xlnx_tsn_netdev_ops);
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_XLNX_TSN, XLNX_TSN_NAME);
+MODULE_DESCRIPTION("DSA tag driver for AMD/Xilinx TSN Endpoint Ethernet MAC");
+MODULE_LICENSE("GPL");
-- 
2.34.1

