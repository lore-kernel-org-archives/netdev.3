Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCB46D577;
	Fri,  7 Aug 2026 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099592; cv=fail; b=QqjjM2ZlrtheLnaotdJw97SaQEoNRX4Ws7v0nDdnI3/rCYPEK/Bc15Ccg45vI+C5qSIfYVnsc/objuUA+BkTUanRiCmyzt2l8oa01JlJmFBFKExA6exkNTzg6cF8WiJ9UGwwtAGEcu5Rb7TgC/silAeDNkuDqCFRz+nvJPHEnYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099592; c=relaxed/simple;
	bh=RX7UdVq9aCUT+geaJ+GUSkDIp4ZfM3uzZswTVViPEmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIsGJGiFinQ2+BYxg8dmOkAepBHhJXOvnKw9nskWmu0j842ppWrDerU/rzWpzn213d5To/P5U7EutSJLTgPO5GPWDCo5aDbiwhxOYJg7syEUHPp1cvpAAW7WlrppJ9aEYIrI8LmPpdnnimGMcEORoIAxkty1OVmDNerFVjnHzBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EnkIxH8c; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EnkIxH8c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mG2qiq6ulEvbrsZhyt6OT9tPBKjEZvVS63aQESMC2R7g06vHPAmORRqLQF6d6i1CzkfMwgKjc0eDndcArMA2vxwXc388M59f5hfWCRR3BmOAEP+MRTVg13BWtc0VfyMPA7REq+jPVaThl0Z+97ptDu9ehPmADQm8QcvSEkw3uD3DtoR1pzxznn47f4Gbq/jD7xQCZ27RtB4i1e5fnilk75MK2cx9Jpn1SGwmk3z2/naFzt68Z/vM0XasRtfoPoX6pE4B+EXSWKRYR73lGxzu5qTSp4NnBk17bCnD3nwdVqgY2iQ3JYj7UE0pOCWgatmHPB8f6lg48YZEzVzov6f17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElPrYku5hZS69V5JsbOr73/5/q9Y6OBUCb4suy4hExA=;
 b=o4dVH1pE+m+M8bTOAcQAjIUJDBYPDHWstEFFh26wMDydym3RFOSLd3uLHOv1WBusa5GnfA2QQLVnW4uHFZ8oismlRSFFSfag6kEbHViU3z5PWshsPvcMwoDWRjDb24aC8J5bCryz3p+99er16SAdyzn0bX0nTmXQ/94kQOue3kayEqArm0g8F1k4q7R02zwwrIqJlT8FxThwsd8qT79wv7ALyI/A4Mi3C/wPLOCMtIJjSQqM6Z3eU4FyfjLgrZR03GlX86QCD64fhek4f2CnKXUK9pMxuuKi6WAsgySEU01jR9BaZGbp75A4r6eC7eqCZfWPKiaiaEi9UxrJtwXOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElPrYku5hZS69V5JsbOr73/5/q9Y6OBUCb4suy4hExA=;
 b=EnkIxH8cHjzas6bAfXupyp46Vs00VkjcIYDkt+NRFjjVHX/ge/K2IA+4d/YVyDuGww5AmcXIK8MFtF78+vbqaph/e0XhBQRePp5mwfdYMHTUXmF1/2vy0kWXGSSjSb29eSgURqk6OpYlY5jMzQwoY7v8P3BBJT6U9gWTiQKdxGM=
Received: from PH7P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::16)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 10:46:25 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:33a:cafe::5) by PH7P222CA0014.outlook.office365.com
 (2603:10b6:510:33a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 10:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Fri, 7 Aug 2026 10:46:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:46:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:46:22 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:46:17 -0500
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
Subject: [PATCH 19/20] net: dsa: xilinx: offload bridge VLAN filtering to the switch
Date: Fri, 7 Aug 2026 16:14:30 +0530
Message-ID: <20260807104431.157230-20-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bdf564-8392-498e-be2b-08def4712089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|7416014|376014|11063799006|56012099006|10067099003|6133799003|18002099003|3023799007|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	zwXavk3eJfTJOYrkphTZSUyTZFl6UcKvy8G6KsUwp4399YJT67TC6TuOXykTX6baMcMXkhzw+hFBHybxURzZGSxXAQcqXha5Ad7PF+H+L9L3Mib+BCF0uK7lUhx9Togq+J9Atu6zygdSbIZ7zLUKnRpIN9DXRrkF4dp6hk8sCPZPsgClOtzN+H3yo8L60mINNyJjeFFiUU9ttAepQjznOaqOK0cOy3YfG6Uv3WxiZORRN9g32uT4JZjLF107kX4+G8oay0D3W8eRxkFWXmDnhm/upv73fMnv5UcOac1Fx/7qEhMHsu73yM9JSXKy6yJNS17d4fZ/CtCQlpl5MN77UJb6FQaXw56J7UeL/DBn9Wvv2f8XLLWB4LFo64MvuA0l9Gow+aaCbXWQ7FJ3xWkcfqYeCHmpCx1p8vMv6A4FQopKXYFEMOxEYflNxzDBT4xiRbRve/c0uxP2qDCde1UP+OXN+AHMwk80uXUWwl1ZvsB3hP/YlZX3hCw7YP8pafL0SjI6lQeCeTg7LRDCS+mFiUGV5SxN2Ukdl+G6F7qafsSiHe4Cp82vo3jFvgHlmsjyU3XrhNw4vjEueN/UKuWt9Y73Rw1Yv8tz07w6uJrRBmvGXalIFc05wH3Lc00sngygseXhsHiUF7PMjQ8y1Nqt0z5cw2ou3tjoFpw3q6jzNYUQpM+/GmnrpZJPK6ri8h6e5LtfSihw6SlUyO8tj6B36CeSdzTC4MR+4TaHdYzj4pfXrrwCZ9LWCkF01rQR4Bmd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(7416014)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(3023799007)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B5EFtou5SBXqkxpoGV6F6aaGmRcP1L+d5uAdZ+VxmvvSQ7YtEjHjAm26RF+R2BlGBk3rgmbBkv2tBcGI4p1M+0lRxpAZ5knr7z1CJ2u1QOsaoxp8C/882agc13VqdrkcQ1ZB0j1i4BYTnfC04WAyvvAmkf29EwqI8Ve3WeX2mugC4ECYo694YPoPoQy4SwrQly1OxdR6pUV9CN4cpTbv7QJhKEBuCa1QNdXhKjIfWBM0LhorGPLYQ2PtuPo72GacZOyhVoMlQGmNyW/oF6UgYHsmxjqYAukO2neGHRbfI/w7Bc1ZYi432nc91fludo6wyi8tATLCeNruMXv0KBRnHjjBl/TDSKqeORpIhZP1XUu0hd74wAHlWp/XcE1le80s8/ymZLd0SEhkQEsUAkOTAXAeYaJW2Oh4UZ13Gy8Slyh4Qgi1k+Hed8O77pco4zEu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:46:24.5633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bdf564-8392-498e-be2b-08def4712089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

The switch always keys the L2 forwarding lookup on {DMAC, VID}. A
per-VID port-membership table controls which ports each VLAN spans.
The ingress parser assigns untagged frames the native VID of the
receiving port before lookup, so tagged and untagged traffic share
the same {DMAC, VID} key throughout.

Wire bridge VLAN filtering to the port-membership table and
native-VID registers so bridge VLAN commands take effect in
hardware. Program the native-VID register on PVID changes so
untagged ingress lands in the right VLAN.

Filtering is switch-wide, so declare it global. The per-MAC
VLAN-enable bit adjusts the MAC's maximum frame length to
account for the 4-byte tag.

Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 drivers/net/dsa/xilinx/xilinx_tsn.c | 329 +++++++++++++++++++++++++++-
 drivers/net/dsa/xilinx/xilinx_tsn.h |  50 ++++-
 2 files changed, 367 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
index 57558b0e2613..7e5cf77cfa66 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.c
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/dsa/xlnx_tsn.h>
 #include <net/dsa.h>
+#include <net/switchdev.h>
 
 #include "xilinx_tsn.h"
 
@@ -804,7 +805,7 @@ static int xlnx_tsn_port_fdb_dump(struct dsa_switch *ds, int port,
 		addr[4] = key2 >> 8;
 		addr[5] = key2;
 		vid = FIELD_GET(TSN_CAM_VLAN, key2);
-		if (vid == TSN_SW_DEFAULT_VID)
+		if (!sw->vlan_aware && vid == TSN_SW_DEFAULT_VID)
 			vid = 0;
 
 		ret = cb(addr, vid, false, data);
@@ -814,6 +815,297 @@ static int xlnx_tsn_port_fdb_dump(struct dsa_switch *ds, int port,
 	return ret;
 }
 
+/* The VLAN-membership control enable bit self-clears once the indirect
+ * read or write completes.
+ */
+static int xlnx_tsn_vlan_wait_done(struct xlnx_tsn *sw)
+{
+	u32 reg;
+
+	return readl_poll_timeout(sw->sw_base + TSN_VLAN_CTRL_OFFSET, reg,
+				  !(reg & TSN_VLAN_EN), TSN_SW_POLL_DELAY_US,
+				  TSN_SW_POLL_TIMEOUT_US);
+}
+
+/* Caller holds indirect_lock. */
+static int xlnx_tsn_vlan_read(struct xlnx_tsn *sw, u16 vid, u32 *data)
+{
+	int ret;
+
+	sw_iow(sw, TSN_VLAN_CTRL_OFFSET,
+	       FIELD_PREP(TSN_VLAN_CTRL_VID_MASK, vid) | TSN_VLAN_ACCESS_READ | TSN_VLAN_EN);
+	ret = xlnx_tsn_vlan_wait_done(sw);
+	if (ret)
+		return ret;
+
+	*data = sw_ior(sw, TSN_VLAN_DATA_OFFSET);
+	return 0;
+}
+
+/* Caller holds indirect_lock. */
+static int xlnx_tsn_vlan_write(struct xlnx_tsn *sw, u16 vid, u32 data)
+{
+	sw_iow(sw, TSN_VLAN_DATA_OFFSET, data);
+	sw_iow(sw, TSN_VLAN_CTRL_OFFSET,
+	       FIELD_PREP(TSN_VLAN_CTRL_VID_MASK, vid) | TSN_VLAN_ACCESS_WRITE | TSN_VLAN_EN);
+
+	return xlnx_tsn_vlan_wait_done(sw);
+}
+
+static void xlnx_tsn_set_native_vid(struct xlnx_tsn *sw, int port, u16 vid)
+{
+	u32 reg;
+
+	switch (port) {
+	case XLNX_TSN_CPU_PORT:
+		reg = sw_ior(sw, TSN_EP_NATIVE_VLAN_OFFSET);
+		reg = (reg & ~TSN_NATIVE_EP_VLAN_MASK) |
+		      FIELD_PREP(TSN_NATIVE_EP_VLAN_MASK, vid);
+		sw_iow(sw, TSN_EP_NATIVE_VLAN_OFFSET, reg);
+		break;
+	case XLNX_TSN_PORT_MAC1:
+		reg = sw_ior(sw, TSN_MAC_NATIVE_VLAN_OFFSET);
+		reg = (reg & ~TSN_NATIVE_MAC1_VLAN_MASK) |
+		      FIELD_PREP(TSN_NATIVE_MAC1_VLAN_MASK, vid);
+		sw_iow(sw, TSN_MAC_NATIVE_VLAN_OFFSET, reg);
+		break;
+	case XLNX_TSN_PORT_MAC2:
+		reg = sw_ior(sw, TSN_MAC_NATIVE_VLAN_OFFSET);
+		reg = (reg & ~TSN_NATIVE_MAC2_VLAN_MASK) |
+		      FIELD_PREP(TSN_NATIVE_MAC2_VLAN_MASK, vid);
+		sw_iow(sw, TSN_MAC_NATIVE_VLAN_OFFSET, reg);
+		break;
+	}
+}
+
+/* Enable or disable native-VLAN egress untagging for a wire port.
+ * The endpoint port always sends frames tagged toward the host, so
+ * it is not handled here.
+ */
+static void xlnx_tsn_set_native_untag(struct xlnx_tsn *sw, int port, bool en)
+{
+	u32 bit, reg;
+
+	switch (port) {
+	case XLNX_TSN_PORT_MAC1:
+		bit = TSN_SW_CTRL_MAC1_NATIVE_UNTAG_EN;
+		break;
+	case XLNX_TSN_PORT_MAC2:
+		bit = TSN_SW_CTRL_MAC2_NATIVE_UNTAG_EN;
+		break;
+	default:
+		return;
+	}
+
+	reg = sw_ior(sw, TSN_SW_CTRL_OFFSET);
+	if (en)
+		reg |= bit;
+	else
+		reg &= ~bit;
+	sw_iow(sw, TSN_SW_CTRL_OFFSET, reg);
+}
+
+/* Write a port's native VID and egress-untag setting to hardware.
+ * While VLAN filtering is off, every port uses the reset-default
+ * native VID and stays tagged, so committed VLANs have no effect
+ * until the bridge goes VLAN-aware. Caller holds indirect_lock.
+ */
+static void xlnx_tsn_apply_pvid(struct xlnx_tsn *sw, int port)
+{
+	u16 vid = sw->vlan_aware ? sw->pvid[port] : TSN_SW_DEFAULT_VID;
+	bool untag = sw->vlan_aware && sw->pvid_untagged[port];
+
+	xlnx_tsn_set_native_vid(sw, port, vid);
+	xlnx_tsn_set_native_untag(sw, port, untag);
+}
+
+/* Restrict learning to VIDs that already have a membership entry.
+ * When on, frames with an unregistered VID are not learned, preventing
+ * a spurious CAM entry that would bypass the membership check on a
+ * later hit. When off, learning is allowed on any VID, as required
+ * while the bridge is VLAN-unaware. Caller holds indirect_lock.
+ */
+static void xlnx_tsn_set_vlan_only_learning(struct xlnx_tsn *sw, bool on)
+{
+	u32 reg = sw_ior(sw, TSN_SW_ADDR_LEARN_OFFSET);
+
+	if (on)
+		reg &= ~TSN_SW_ADDR_LEARN_NO_VLAN_EN;
+	else
+		reg |= TSN_SW_ADDR_LEARN_NO_VLAN_EN;
+	sw_iow(sw, TSN_SW_ADDR_LEARN_OFFSET, reg);
+}
+
+static int xlnx_tsn_port_vlan_filtering(struct dsa_switch *ds, int port,
+					bool vlan_filtering,
+					struct netlink_ext_ack *extack)
+{
+	struct xlnx_tsn *sw = ds->priv;
+	struct dsa_port *dp;
+	unsigned long bit;
+	u32 reg, data;
+	int ret;
+
+	guard(mutex)(&sw->indirect_lock);
+
+	/* Flip Port-List-Valid on every configured VID: set it to enforce
+	 * membership, clear it so VLANs added while filtering was off stay
+	 * inert.
+	 */
+	for_each_set_bit(bit, sw->cfg_vids, VLAN_N_VID) {
+		ret = xlnx_tsn_vlan_read(sw, bit, &data);
+		if (ret)
+			return ret;
+
+		if (vlan_filtering)
+			data |= TSN_VLAN_PORT_LIST_VALID;
+		else
+			data &= ~TSN_VLAN_PORT_LIST_VALID;
+
+		ret = xlnx_tsn_vlan_write(sw, bit, data);
+		if (ret)
+			return ret;
+	}
+
+	sw->vlan_aware = vlan_filtering;
+
+	/* Miss policy for unicast and multicast. It only kicks in when the
+	 * CAM misses and the VID has no membership entry either. So flood the
+	 * unregistered ones while VLAN-unaware, and drop them once filtering
+	 * is on.
+	 */
+	reg = sw_ior(sw, TSN_SW_CTRL_OFFSET);
+	reg &= ~(TSN_SW_CTRL_UCAST_MISS_MASK | TSN_SW_CTRL_MCAST_MISS_MASK);
+	if (vlan_filtering) {
+		reg |= FIELD_PREP(TSN_SW_CTRL_UCAST_MISS_MASK, TSN_SW_CTRL_MISS_DISCARD) |
+		       FIELD_PREP(TSN_SW_CTRL_MCAST_MISS_MASK, TSN_SW_CTRL_MISS_DISCARD);
+	} else {
+		reg |= FIELD_PREP(TSN_SW_CTRL_UCAST_MISS_MASK, TSN_SW_CTRL_UCAST_MISS_FLOOD) |
+		       FIELD_PREP(TSN_SW_CTRL_MCAST_MISS_MASK, TSN_SW_CTRL_MCAST_MISS_FLOOD);
+	}
+	sw_iow(sw, TSN_SW_CTRL_OFFSET, reg);
+
+	xlnx_tsn_set_vlan_only_learning(sw, vlan_filtering);
+
+	/* Apply the native VID and egress-untag settings saved while
+	 * filtering was off, or restore defaults when filtering is turned
+	 * off. VLANs added while filtering is already on are applied
+	 * directly by port_vlan_add().
+	 */
+	dsa_switch_for_each_user_port(dp, ds)
+		xlnx_tsn_apply_pvid(sw, dp->index);
+
+	/* The learning-control bits latch only when a port passes through
+	 * blocking, so cycle each port to make the new setting take hold.
+	 * The transition does not drop learnt entries, so flush them too -
+	 * they were keyed on the old native VID and are now stale.
+	 */
+	dsa_switch_for_each_user_port(dp, ds) {
+		ret = xlnx_tsn_port_state_cycle(sw, dp->index,
+						TSN_PORT_STATE_BLOCKING);
+		if (ret)
+			return ret;
+
+		ret = xlnx_tsn_port_state_cycle(sw, dp->index,
+						TSN_PORT_STATE_FLUSH);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int xlnx_tsn_port_vlan_add(struct dsa_switch *ds, int port,
+				  const struct switchdev_obj_port_vlan *vlan,
+				  struct netlink_ext_ack *extack)
+{
+	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+	struct xlnx_tsn *sw = ds->priv;
+	u32 data;
+	int ret;
+
+	guard(mutex)(&sw->indirect_lock);
+
+	/* The hardware strips the tag on egress only for a wire port's native
+	 * VLAN. Reject an untagged request for any other VID. The CPU port is
+	 * exempt as it always trunks tagged toward the host.
+	 */
+	if (port != XLNX_TSN_CPU_PORT && untagged && !pvid &&
+	    vlan->vid != sw->pvid[port]) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "untagged egress is only supported for the port PVID");
+		return -EINVAL;
+	}
+
+	ret = xlnx_tsn_vlan_read(sw, vlan->vid, &data);
+	if (ret)
+		return ret;
+
+	data |= TSN_PORT_BIT(port);
+	if (sw->vlan_aware)
+		data |= TSN_VLAN_PORT_LIST_VALID;
+	else
+		data &= ~TSN_VLAN_PORT_LIST_VALID;
+	ret = xlnx_tsn_vlan_write(sw, vlan->vid, data);
+	if (ret)
+		return ret;
+
+	set_bit(vlan->vid, sw->cfg_vids);
+
+	/* The CPU port needs membership only. */
+	if (port == XLNX_TSN_CPU_PORT)
+		return 0;
+
+	if (pvid) {
+		sw->pvid[port] = vlan->vid;
+		sw->pvid_untagged[port] = untagged;
+		xlnx_tsn_apply_pvid(sw, port);
+	}
+
+	if (vlan->vid == sw->pvid[port] &&
+	    sw->pvid_untagged[port] != untagged) {
+		sw->pvid_untagged[port] = untagged;
+		xlnx_tsn_apply_pvid(sw, port);
+	}
+
+	return 0;
+}
+
+static int xlnx_tsn_port_vlan_del(struct dsa_switch *ds, int port,
+				  const struct switchdev_obj_port_vlan *vlan)
+{
+	struct xlnx_tsn *sw = ds->priv;
+	bool last_member;
+	u32 data;
+	int ret;
+
+	guard(mutex)(&sw->indirect_lock);
+	ret = xlnx_tsn_vlan_read(sw, vlan->vid, &data);
+	if (ret)
+		return ret;
+
+	data &= ~TSN_PORT_BIT(port);
+	last_member = !(data & TSN_VLAN_PORT_LIST_MASK);
+	if (last_member)
+		data &= ~TSN_VLAN_PORT_LIST_VALID;
+
+	ret = xlnx_tsn_vlan_write(sw, vlan->vid, data);
+	if (ret)
+		return ret;
+
+	if (last_member)
+		clear_bit(vlan->vid, sw->cfg_vids);
+
+	if (sw->pvid[port] == vlan->vid) {
+		sw->pvid[port] = TSN_SW_DEFAULT_VID;
+		sw->pvid_untagged[port] = false;
+		xlnx_tsn_apply_pvid(sw, port);
+	}
+
+	return 0;
+}
+
 static void xlnx_tsn_phylink_get_caps(struct dsa_switch *ds, int port,
 				      struct phylink_config *config)
 {
@@ -900,10 +1192,9 @@ static void xlnx_tsn_mac_link_up(struct phylink_config *config,
 	}
 	mac_iow(m, TSN_SPEED_CFG_OFFSET, speed_cfg);
 
-	rcw1 = mac_ior(m, TSN_RCW1_OFFSET) | TSN_RCW1_RX_EN;
+	rcw1 = mac_ior(m, TSN_RCW1_OFFSET) | TSN_RCW1_RX_EN | TSN_RCW1_VLAN_EN;
+	tc = mac_ior(m, TSN_TC_OFFSET) | TSN_TC_TX_EN | TSN_TC_VLAN_EN;
 	mac_iow(m, TSN_RCW1_OFFSET, rcw1);
-
-	tc = mac_ior(m, TSN_TC_OFFSET) | TSN_TC_TX_EN;
 	mac_iow(m, TSN_TC_OFFSET, tc);
 }
 
@@ -919,7 +1210,7 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
 	struct xlnx_tsn *sw = ds->priv;
 	struct dsa_port *dp;
 	u32 mgmt, reg;
-	int ret;
+	int port, ret;
 
 	if (!dsa_is_user_port(ds, XLNX_TSN_PORT_MAC1) ||
 	    !dsa_is_user_port(ds, XLNX_TSN_PORT_MAC2))
@@ -941,12 +1232,26 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
 	       TSN_SW_ADDR_LEARN_NO_VLAN_EN;
 	sw_iow(sw, TSN_SW_ADDR_LEARN_OFFSET, reg);
 
-	/* On a CAM miss flood unknown tagged unicast frames to all ports. */
+	/* On a CAM miss flood unknown tagged unicast frames to all ports.
+	 * Also drop tagged frames whose ingress port is not in the VLAN
+	 * member list. The membership check only bites once VLANs exist.
+	 */
 	reg = sw_ior(sw, TSN_SW_CTRL_OFFSET);
-	reg &= ~TSN_SW_CTRL_UCAST_MISS_MASK;
-	reg |= FIELD_PREP(TSN_SW_CTRL_UCAST_MISS_MASK, TSN_SW_CTRL_UCAST_MISS_FLOOD);
+	reg &= ~(TSN_SW_CTRL_UCAST_MISS_MASK | TSN_SW_CTRL_MEMBER_VIOL_MASK);
+	reg |= FIELD_PREP(TSN_SW_CTRL_UCAST_MISS_MASK, TSN_SW_CTRL_UCAST_MISS_FLOOD) |
+	       FIELD_PREP(TSN_SW_CTRL_MEMBER_VIOL_MASK, TSN_SW_CTRL_MEMBER_VIOL_DISCARD);
 	sw_iow(sw, TSN_SW_CTRL_OFFSET, reg);
 
+	/* Every port uses the default native VID until VLAN filtering is
+	 * enabled. Seed the PVID shadow and program the native VID
+	 * registers to match.
+	 */
+	scoped_guard(mutex, &sw->indirect_lock)
+		for (port = XLNX_TSN_CPU_PORT; port < XLNX_TSN_NUM_PORTS; port++) {
+			sw->pvid[port] = TSN_SW_DEFAULT_VID;
+			xlnx_tsn_apply_pvid(sw, port);
+		}
+
 	/* Route CPU-originated bridge-group control frames (STP, LLDP) to
 	 * the single wire port whose MAC-nibble field matches the frame's
 	 * source-MAC low nibble, instead of flooding to both.
@@ -1040,6 +1345,9 @@ static const struct dsa_switch_ops xlnx_tsn_switch_ops = {
 	.port_fdb_del		= xlnx_tsn_port_fdb_del,
 	.port_fdb_dump		= xlnx_tsn_port_fdb_dump,
 	.port_fast_age		= xlnx_tsn_port_fast_age,
+	.port_vlan_filtering	= xlnx_tsn_port_vlan_filtering,
+	.port_vlan_add		= xlnx_tsn_port_vlan_add,
+	.port_vlan_del		= xlnx_tsn_port_vlan_del,
 	.port_hwtstamp_get	= xlnx_tsn_port_hwtstamp_get,
 	.port_hwtstamp_set	= xlnx_tsn_port_hwtstamp_set,
 	.get_ts_info		= xlnx_tsn_get_ts_info,
@@ -1102,6 +1410,11 @@ static int xlnx_tsn_probe(struct platform_device *pdev)
 	/* The fabric offloads a single bridge across the user ports. */
 	ds->max_num_bridges = 1;
 
+	/* The switch fabric is a single VLAN domain shared by all ports, so
+	 * VLAN filtering is configured switch-wide rather than per port.
+	 */
+	ds->vlan_filtering_is_global = true;
+
 	platform_set_drvdata(pdev, sw);
 
 	return dsa_register_switch(ds);
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
index a94f5124a33d..955041cde564 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.h
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.h
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/if_ether.h>
+#include <linux/if_vlan.h>
 #include <linux/io.h>
 #include <linux/net_tstamp.h>
 #include <linux/notifier.h>
@@ -64,8 +65,9 @@
 #define TSN_SW_MGMT_QUEUING_EP_SA_EGRESS	BIT(4)
 
 /* Shared readl_poll_timeout() parameters (in microseconds) used at
- * two call sites: the port-state change-commit bit and the CAM
- * operation enable bit. Both self-clear when the operation completes.
+ * three call sites: the port-state change-commit bit, the CAM
+ * operation enable bit, and the VLAN-memory operation enable bit.
+ * All three self-clear when the hardware completes the operation.
  */
 #define TSN_SW_POLL_DELAY_US		10
 #define TSN_SW_POLL_TIMEOUT_US		5000
@@ -102,6 +104,28 @@
 #define TSN_CAM_MAC2_READ_KEY_BASE	0x800
 #define TSN_CAM_READ_KEY_COUNT		2048
 
+/* Port VLAN membership memory: per-VID egress port list, accessed
+ * indirectly through a control/data register pair. The control
+ * register's enable bit self-clears when the read or write completes.
+ */
+#define TSN_VLAN_CTRL_OFFSET		0x01100
+#define TSN_VLAN_DATA_OFFSET		0x01104
+#define TSN_VLAN_CTRL_VID_MASK		GENMASK(27, 16)
+#define TSN_VLAN_ACCESS_READ		0
+#define TSN_VLAN_ACCESS_WRITE		BIT(1)
+#define TSN_VLAN_EN			BIT(0)
+#define TSN_VLAN_PORT_LIST_VALID	BIT(3)
+#define TSN_VLAN_PORT_LIST_MASK		GENMASK(2, 0)
+
+/* Per-port native (PVID) registers: the endpoint port at +0x40, the two
+ * MAC ports packed into +0x44 (MAC1 in the low half, MAC2 in the high).
+ */
+#define TSN_EP_NATIVE_VLAN_OFFSET	0x00040
+#define TSN_MAC_NATIVE_VLAN_OFFSET	0x00044
+#define TSN_NATIVE_EP_VLAN_MASK		GENMASK(11, 0)
+#define TSN_NATIVE_MAC1_VLAN_MASK	GENMASK(11, 0)
+#define TSN_NATIVE_MAC2_VLAN_MASK	GENMASK(27, 16)
+
 /* HW reset-default native VID; DSA's "no VLAN" (vid 0) maps onto it. */
 #define TSN_SW_DEFAULT_VID		1
 
@@ -183,12 +207,17 @@ enum tsn_port_state {
 
 #define TSN_MDIO_MRD_MASK		GENMASK(15, 0)
 
-/* Per-MAC receive / transmit / speed configuration registers. */
+/* Per-MAC receive / transmit / speed configuration registers. Setting
+ * the VLAN enable bit makes the MAC accept full-size VLAN-tagged frames
+ * without treating the extra 4 bytes as an oversize error.
+ */
 #define TSN_RCW1_OFFSET			0x00000404
 #define TSN_RCW1_RX_EN			BIT(28)
+#define TSN_RCW1_VLAN_EN		BIT(27)
 
 #define TSN_TC_OFFSET			0x00000408
 #define TSN_TC_TX_EN			BIT(28)
+#define TSN_TC_VLAN_EN			BIT(27)
 
 #define TSN_SPEED_CFG_OFFSET		0x00000410
 #define TSN_SPEED_CFG_MASK		GENMASK(31, 30)
@@ -304,6 +333,15 @@ struct xlnx_tsn_mac {
  * @nb: netdev notifier that handles NETDEV_REGISTER on each swpN
  *	to set its final MAC, and NETDEV_CHANGEADDR on the conduit
  *	to refresh the shared prefix
+ * @vlan_aware: true once bridge VLAN filtering is on. Until then the
+ *		native VID, egress untag, and membership enforcement are
+ *		all held back.
+ * @pvid: per-port bridge PVID shadow, written to the native VID register
+ *	  while @vlan_aware; defaults to TSN_SW_DEFAULT_VID
+ * @pvid_untagged: per-port flag tracking whether the PVID egresses
+ *		   untagged; drives the native-VLAN untag enable
+ * @cfg_vids: VIDs with a membership entry in the VLAN-membership memory,
+ *	      used to walk and update Port-List-Valid when @vlan_aware changes
  * @indirect_lock: serialises the CAM and VLAN-membership indirect
  *		   register sequences
  * @mac: per-MAC state, indexed by user-port number (index 0 unused;
@@ -327,7 +365,11 @@ struct xlnx_tsn {
 	struct net_device *conduit;
 	u8 mac_prefix[ETH_ALEN];
 	struct notifier_block nb;
-	struct mutex indirect_lock; /* serialises CAM indirect access */
+	bool vlan_aware;
+	u16 pvid[XLNX_TSN_NUM_PORTS];
+	bool pvid_untagged[XLNX_TSN_NUM_PORTS];
+	DECLARE_BITMAP(cfg_vids, VLAN_N_VID);
+	struct mutex indirect_lock; /* serialises CAM + VLAN-memory access */
 	struct xlnx_tsn_mac mac[XLNX_TSN_NUM_PORTS];
 	int ptp_timer_irq;
 	struct ptp_clock *ptp_clock;
-- 
2.34.1

