Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F31940A956;
	Fri,  7 Aug 2026 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099589; cv=fail; b=bc7u7V5ZkD06TtzwfjjFf+FetIfJiJy9thHUkX05eK3o0E6nlvbqFGIqJRdXeA/t8UZiN7AOOEgAYcvDt8r/12Cb5PRfRf3r7AUnSSDituTC/EXIqHeu9lZbIMfKUexyQZHWFF+rqjnbiwqhe18EXdg0vuVAXvmKpfAKp7bjmXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099589; c=relaxed/simple;
	bh=rPkMvDBAYh4TM25RljQL4omfv7FPlgVv6iA1YYgXaHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwP2bUQCfaTQ6tYn7rDh9pEC+wegiT7mCdJUDA70VKVe0riiDaGhOCyfnbBEXCOPWawd6paj5lmDEwLtKkaMC4eO23jEOZi00dzVYc4FcGWATVjAPf3NlBKM6l8KWw4y+rks7uh2g0ZnGAzWJR9ow4AmF7vt/LKVj6CS72wtWLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wAkYpUnt; arc=fail smtp.client-ip=40.93.196.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wAkYpUnt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZVbqsOMHmG74cWK4hivqcKg/8NCOBRK3aoyGaBSoRoiNVC5s0GAT/6tTKylaselmrdCaX1eEgIkw22YdPX+JpHGzOeC8VuvnE1GiHZw6WDEhLsn2ddlTi211zXIVomKcE6d42rInXXhXyJsQbzRFLeuFqqrcioUBwtowGRpbSNi0ldKIWZKo0sdfR87r4ZO3BiGAUj1UoI4XsEX3gcriUFtgJsN21i6ef/bExvqSGKQX3mAJHTZDl4rWcWuoINI7Yz7kIPoyuAtNDjaT97DuEOKQn3rUw5JMWuR0gQ8u5pwH8X23ouQGcB8JCBOe/edHS2671N9mu9hO3WopdRUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CUphzZKQw89pUogMi5SHkAL8gVvfeiITpu2q/Xf3/s=;
 b=nqEwJaKcXRQhQZmDHB+zhDSYMjul26iI24XqHgBJ5MRh+FqyxK/u4ovy9usj5JK/4dIMBd3q/HfliQbQvo2BcAhtFRbl6YaEa12vPLHUHGFGV8owzyHaB+Rtp0jvX91X+aApARPpZORP7e71OBCJ/+ue25ldCEhlVb6xN+RQtJiBRz9ean+gNrnH/c+Kz+Q8fyqvaYrY4nC8znTFamIlf+LkFE2+qxXKshlUGeGJXcqRVwzETOFfqcybgTs3YXFTlBsT6FAIIgqKV6CSrCdias71igc/tihyHDu2swc+KiMBYYRYC1PTYnty1GzaYf2LL78akBX0lN0QuixLpwgNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CUphzZKQw89pUogMi5SHkAL8gVvfeiITpu2q/Xf3/s=;
 b=wAkYpUntG7IhQngbbKK2qZz2Fkq3lqjqebbEt8mYWN43Ra/valRT0vxmKqhRr7+Nm9yGz39i2vM4UV3+UYP6lpAWkPZPCi6MQeAsgxi6CpBXKH60Pwv2DlVTB+AgMJtBHbiUo3z4FcX8El+PWdpL7MzUCrJAbS7X1Wxl7x7+Yfc=
Received: from SJ0PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:33f::15)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 10:46:19 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::5f) by SJ0PR05CA0040.outlook.office365.com
 (2603:10b6:a03:33f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.9 via Frontend Transport; Fri, 7
 Aug 2026 10:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 10:46:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:46:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:46:17 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:46:12 -0500
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
Subject: [PATCH 18/20] net: dsa: xilinx: offload the bridge FDB to the switch CAM
Date: Fri, 7 Aug 2026 16:14:29 +0530
Message-ID: <20260807104431.157230-19-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3c2e77-7177-4fa9-13f5-08def4711d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|82310400026|376014|1800799024|36860700016|921020|6133799003|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZN/ltZ0Ynx6mg6lD2jF1NxxOkOIeO3JTolwHEmFFbmt10K+ebQs/ayuMC2z5RlmE5sK6W3oLEBcwLog/aKWSrUT3WZDpu5EWFZ51DKcfnaXFyzgnAKuaqRzDM3QJTuW0uew+l2YIKAgWtIhLe4HydivDf4KScnznzsg38NWmDtVgFMbQsgjVxInAjcpMbLE4n96D5FkhO/f4vk4RASXu6BlgNAk2TaOfRBB8M3EXzDib+eZ/Y1GG9PuCQ2RR7OvJ+6cFqTJtYV9QT3+WXPwB0ao4jNA+hI9EWKMtAxMAgeArglRsj0RThHHEV67NeO0Za+0oGU12XeE67hacS/85wCNl7G4HPMLkSvEjx6VkuvygZe52wxgj+pjtniWQmeMqHDCK5RTgTZsjIsYKzov14W9t1hDbA/b17CkweLFfJfGzhrDn7rM7z+RweLpmCImZEnoPvz8/WAd3mjVFlatnkV0JPwGoh++JWEvgvC1oyFa9PnWYdYxQiiCbmm0LbW3yiBM1gxQmV+FyLhuUad70qYVkedKFfpe7R114dcYTAdNbyYNXpv74Sfk0bpsFC3Rrs4fNnU1/dtAxt4ShOOBNbJWhzYf/wgogud2T1wIua3kC+if19sB/Cmd9NQbrIX3/Kn+N8tlmtaALgWddoE/M5UMbJGEaca4o6+8AuG9gRVc6s+8eVCmxDXA5kdbDeLF0w4LVd+nO4U0dpU9T/w5TJkth/PXyIvIHH6HQjRg1auIxsZRSXw70L63wfDvy7b2F
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(82310400026)(376014)(1800799024)(36860700016)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KPV/rQQrsEJn6WVtgR/OPCYTnBXyxkbHcjkQRvZmAmEVCzHX1eWvKSiz+RGP/Is1cQMetuy8pXofg1oLAQI1O5GodkHlKHYSf/cOU9zyc29lmUjtpNIDHfH0Al9g4damUGjDXqQW1p4FBeunNTigwhOPcTdeAfWQG0JOxN2i8OPh0DbImez1fLnQ6MKXNSs9a/kN1uRbLY3CLVrrylo69PS0W1qEYsGwEilOuuR8pgHxhq6ERxkoVFkwcNFLf210J4nyF8LGImPdIizFNCGf48J5HMS4Kqmhy7A87znjDUQlfqpe4GpHekxPCu65jrxRSxEvaqcBiNM4yD3Q86wRs1OyxF25ns7L65r82YlxwbNG76ZS/bD7z4re2p/XZxYJOH1L5fYj6K9vDrxfIneLe7/92KMsG7HfUOLMyJqAzu+8rZ17zWknDqjdDQKj4Izn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:46:19.0015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3c2e77-7177-4fa9-13f5-08def4711d2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115

The switch resolves forwarding through a stream-destination lookup
CAM that maps a (destination MAC, VLAN ID) key to an egress port
list. Back the bridge FDB with it.

The CAM is an indirect register block. Load the key and port-list
registers, write the opcode (add, delete, read, or read-key) to the
control register, and wait for the operation to finish. Add a mutex
to serialise these sequences.

The fabric also learns source MACs into the same CAM. Enable the
learning engine in port_bridge_join, and add port_bridge_leave to
disable it once the last user port leaves, so entries accumulate
only while a bridge spans the ports.

port_fdb_add and port_fdb_del read the entry, set or clear the
calling port's bit in the port list, and write it back. Delete the
entry once no port references it. A (MAC, VID) reachable on several
ports then carries a correct multi-port list. The DSA "no VLAN" key
(vid 0) maps to the default native VID that an untagged frame uses.

port_fdb_dump reports a port's learnt entries. The hardware scatters
them across the port's read-key region. Scan all of it and report
every slot that is present. The CPU port has no such region.

port_fast_age flushes a port's learnt addresses from the CAM.

Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 drivers/net/dsa/xilinx/xilinx_tsn.c | 301 +++++++++++++++++++++++++++-
 drivers/net/dsa/xilinx/xilinx_tsn.h |  93 ++++++++-
 2 files changed, 391 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
index 9a4d4a2fb892..57558b0e2613 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.c
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.c
@@ -174,6 +174,31 @@ static int xlnx_tsn_set_port_state(struct xlnx_tsn *sw, int port,
 	return 0;
 }
 
+static enum tsn_port_state xlnx_tsn_get_port_state(struct xlnx_tsn *sw,
+						   int port)
+{
+	u32 mask, chg_bit, reg;
+
+	if (xlnx_tsn_port_state_bits(port, &mask, &chg_bit))
+		return TSN_PORT_STATE_DISABLED;
+
+	reg = sw_ior(sw, TSN_PORT_STATE_CTRL_OFFSET);
+	return (reg & mask) >> __ffs(mask);
+}
+
+static int xlnx_tsn_port_state_cycle(struct xlnx_tsn *sw, int port,
+				     enum tsn_port_state state)
+{
+	enum tsn_port_state saved = xlnx_tsn_get_port_state(sw, port);
+	int err;
+
+	err = xlnx_tsn_set_port_state(sw, port, state);
+	if (err)
+		return err;
+
+	return xlnx_tsn_set_port_state(sw, port, saved);
+}
+
 static int xlnx_tsn_mdio_wait_ready(struct xlnx_tsn_mac *m)
 {
 	u32 val;
@@ -495,11 +520,32 @@ static int xlnx_tsn_port_set_mac_address(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+/* Enable or disable the hardware address learning engine globally.
+ * Standalone ports do not learn. Enable when a port joins a bridge,
+ * disable when the last one leaves. The sub-qualifier bits below are
+ * inert while learning is disabled. Caller holds indirect_lock.
+ */
+static void xlnx_tsn_set_global_learning(struct xlnx_tsn *sw, bool on)
+{
+	u32 reg = sw_ior(sw, TSN_SW_ADDR_LEARN_OFFSET);
+
+	if (on)
+		reg &= ~TSN_SW_ADDR_LEARN_DISABLE;
+	else
+		reg |= TSN_SW_ADDR_LEARN_DISABLE;
+	sw_iow(sw, TSN_SW_ADDR_LEARN_OFFSET, reg);
+}
+
 static int xlnx_tsn_port_bridge_join(struct dsa_switch *ds, int port,
 				     struct dsa_bridge bridge,
 				     bool *tx_fwd_offload,
 				     struct netlink_ext_ack *extack)
 {
+	struct xlnx_tsn *sw = ds->priv;
+
+	scoped_guard(mutex, &sw->indirect_lock)
+		xlnx_tsn_set_global_learning(sw, true);
+
 	/* The switch fabric replicates flooded frames per egress port
 	 * on its own, so the bridge does not need to clone-and-send.
 	 */
@@ -508,6 +554,24 @@ static int xlnx_tsn_port_bridge_join(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static void xlnx_tsn_port_bridge_leave(struct dsa_switch *ds, int port,
+				       struct dsa_bridge bridge)
+{
+	struct xlnx_tsn *sw = ds->priv;
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_user_port(dp, ds) {
+		if (dp->index == port)
+			continue;
+
+		if (dp->bridge)
+			return;
+	}
+
+	scoped_guard(mutex, &sw->indirect_lock)
+		xlnx_tsn_set_global_learning(sw, false);
+}
+
 static void xlnx_tsn_port_stp_state_set(struct dsa_switch *ds, int port,
 					u8 state)
 {
@@ -539,6 +603,217 @@ static void xlnx_tsn_port_stp_state_set(struct dsa_switch *ds, int port,
 	xlnx_tsn_set_port_state(sw, port, hw_state);
 }
 
+/* The CAM status enable bit reads 1 when the block is ready to accept the
+ * next operation.
+ */
+static int xlnx_tsn_cam_wait_ready(struct xlnx_tsn *sw)
+{
+	u32 reg;
+
+	return readl_poll_timeout(sw->sw_base + TSN_CAM_STATUS_OFFSET, reg,
+				  reg & TSN_CAM_STATUS_READY, TSN_SW_POLL_DELAY_US,
+				  TSN_SW_POLL_TIMEOUT_US);
+}
+
+/* The CAM control enable bit self-clears when the operation completes. */
+static int xlnx_tsn_cam_wait_done(struct xlnx_tsn *sw)
+{
+	u32 reg;
+
+	return readl_poll_timeout(sw->sw_base + TSN_CAM_CTRL_OFFSET, reg,
+				  !(reg & TSN_CAM_OP_ENABLE),
+				  TSN_SW_POLL_DELAY_US, TSN_SW_POLL_TIMEOUT_US);
+}
+
+static void xlnx_tsn_cam_load_key(struct xlnx_tsn *sw,
+				  const unsigned char *addr, u16 vid)
+{
+	sw_iow(sw, TSN_CAM_KEY1_OFFSET,
+	       ((u32)addr[0] << 24) | ((u32)addr[1] << 16) |
+	       ((u32)addr[2] << 8) | addr[3]);
+	sw_iow(sw, TSN_CAM_KEY2_OFFSET,
+	       ((u32)addr[4] << 8) | addr[5] |
+	       FIELD_PREP(TSN_CAM_VLAN, vid));
+}
+
+/* Look up a (MAC, VID) key and return its current egress port list, or 0
+ * if the entry is absent. Caller holds indirect_lock.
+ */
+static int xlnx_tsn_cam_read_portlist(struct xlnx_tsn *sw,
+				      const unsigned char *addr, u16 vid,
+				      u8 *portlist)
+{
+	u32 ctrl;
+	int ret;
+
+	ret = xlnx_tsn_cam_wait_ready(sw);
+	if (ret)
+		return ret;
+
+	xlnx_tsn_cam_load_key(sw, addr, vid);
+	sw_iow(sw, TSN_CAM_CTRL_OFFSET,
+	       FIELD_PREP(TSN_CAM_OP_MASK, TSN_CAM_OP_READ) | TSN_CAM_OP_ENABLE);
+
+	ret = xlnx_tsn_cam_wait_done(sw);
+	if (ret)
+		return ret;
+
+	ctrl = sw_ior(sw, TSN_CAM_CTRL_OFFSET);
+	if (!(ctrl & TSN_CAM_FOUND)) {
+		*portlist = 0;
+		return 0;
+	}
+
+	*portlist = FIELD_GET(TSN_CAM_PORT_LIST,
+			      sw_ior(sw, TSN_CAM_PORT_ACT_OFFSET));
+	return 0;
+}
+
+/* Add (add=true) or delete (add=false) the (MAC, VID) entry carrying the
+ * given port list. Caller holds indirect_lock.
+ */
+static int xlnx_tsn_cam_write(struct xlnx_tsn *sw, const unsigned char *addr,
+			      u16 vid, u8 portlist, bool add)
+{
+	int ret;
+
+	ret = xlnx_tsn_cam_wait_ready(sw);
+	if (ret)
+		return ret;
+
+	xlnx_tsn_cam_load_key(sw, addr, vid);
+	sw_iow(sw, TSN_CAM_TV1_OFFSET, 0);
+	sw_iow(sw, TSN_CAM_TV2_OFFSET, 0);
+	sw_iow(sw, TSN_CAM_PORT_ACT_OFFSET,
+	       FIELD_PREP(TSN_CAM_PORT_LIST, portlist));
+	sw_iow(sw, TSN_CAM_CTRL_OFFSET,
+	       FIELD_PREP(TSN_CAM_OP_MASK, add ? TSN_CAM_OP_ADD : TSN_CAM_OP_DELETE) |
+	       TSN_CAM_OP_ENABLE);
+
+	return xlnx_tsn_cam_wait_done(sw);
+}
+
+static void xlnx_tsn_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct xlnx_tsn *sw = ds->priv;
+	int err;
+
+	err = xlnx_tsn_port_state_cycle(sw, port, TSN_PORT_STATE_FLUSH);
+	if (err)
+		dev_err(sw->dev, "port %d: fast age failed (%d)\n", port, err);
+}
+
+static int xlnx_tsn_port_fdb_add(struct dsa_switch *ds, int port,
+				 const unsigned char *addr, u16 vid,
+				 struct dsa_db db)
+{
+	struct xlnx_tsn *sw = ds->priv;
+	u8 portlist;
+	int ret;
+
+	if (!vid)
+		vid = TSN_SW_DEFAULT_VID;
+
+	guard(mutex)(&sw->indirect_lock);
+	ret = xlnx_tsn_cam_read_portlist(sw, addr, vid, &portlist);
+	if (!ret) {
+		portlist |= TSN_PORT_BIT(port);
+		ret = xlnx_tsn_cam_write(sw, addr, vid, portlist, true);
+	}
+
+	return ret;
+}
+
+static int xlnx_tsn_port_fdb_del(struct dsa_switch *ds, int port,
+				 const unsigned char *addr, u16 vid,
+				 struct dsa_db db)
+{
+	struct xlnx_tsn *sw = ds->priv;
+	u8 portlist;
+	int ret;
+
+	if (!vid)
+		vid = TSN_SW_DEFAULT_VID;
+
+	guard(mutex)(&sw->indirect_lock);
+	ret = xlnx_tsn_cam_read_portlist(sw, addr, vid, &portlist);
+	if (!ret) {
+		if (!portlist)
+			return 0;
+
+		/* Drop the entry once no port references it. Otherwise
+		 * rewrite it with the updated port list.
+		 */
+		portlist &= ~TSN_PORT_BIT(port);
+		ret = xlnx_tsn_cam_write(sw, addr, vid, portlist, portlist != 0);
+	}
+
+	return ret;
+}
+
+static int xlnx_tsn_port_fdb_dump(struct dsa_switch *ds, int port,
+				  dsa_fdb_dump_cb_t *cb, void *data)
+{
+	struct xlnx_tsn *sw = ds->priv;
+	unsigned char addr[ETH_ALEN];
+	u32 base, ctrl, key1, key2;
+	int ret = 0;
+	u16 vid;
+	u32 i;
+
+	/* Learnt entries live in a per-MAC-port read-key region. The CPU
+	 * port has no such region.
+	 */
+	if (port == XLNX_TSN_CPU_PORT)
+		return 0;
+
+	guard(mutex)(&sw->indirect_lock);
+
+	if (port == XLNX_TSN_PORT_MAC2)
+		base = TSN_CAM_MAC2_READ_KEY_BASE;
+	else
+		base = 0;
+
+	/* Learnt entries occupy non-consecutive slots, so scan the whole
+	 * region and report each slot marked found.
+	 */
+	for (i = 0; i < TSN_CAM_READ_KEY_COUNT; i++) {
+		ret = xlnx_tsn_cam_wait_ready(sw);
+		if (ret)
+			return ret;
+
+		sw_iow(sw, TSN_CAM_CTRL_OFFSET,
+		       FIELD_PREP(TSN_CAM_READ_KEY_ADDR, base + i) |
+		       FIELD_PREP(TSN_CAM_OP_MASK, TSN_CAM_OP_READ_KEY) |
+		       TSN_CAM_OP_ENABLE);
+
+		ret = xlnx_tsn_cam_wait_done(sw);
+		if (ret)
+			return ret;
+
+		ctrl = sw_ior(sw, TSN_CAM_CTRL_OFFSET);
+		if (!(ctrl & TSN_CAM_FOUND))
+			continue;
+
+		key1 = sw_ior(sw, TSN_CAM_KEY1_OFFSET);
+		key2 = sw_ior(sw, TSN_CAM_KEY2_OFFSET);
+		addr[0] = key1 >> 24;
+		addr[1] = key1 >> 16;
+		addr[2] = key1 >> 8;
+		addr[3] = key1;
+		addr[4] = key2 >> 8;
+		addr[5] = key2;
+		vid = FIELD_GET(TSN_CAM_VLAN, key2);
+		if (vid == TSN_SW_DEFAULT_VID)
+			vid = 0;
+
+		ret = cb(addr, vid, false, data);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
 static void xlnx_tsn_phylink_get_caps(struct dsa_switch *ds, int port,
 				      struct phylink_config *config)
 {
@@ -643,7 +918,7 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
 	struct dsa_port *cpu_dp = dsa_to_port(ds, XLNX_TSN_CPU_PORT);
 	struct xlnx_tsn *sw = ds->priv;
 	struct dsa_port *dp;
-	u32 mgmt;
+	u32 mgmt, reg;
 	int ret;
 
 	if (!dsa_is_user_port(ds, XLNX_TSN_PORT_MAC1) ||
@@ -656,6 +931,22 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
 
 	sw->conduit = cpu_dp->conduit;
 
+	/* Pre-arm the learning sub-qualifiers for when a port joins a bridge:
+	 * learn untagged frames under their ingress native VID, and allow
+	 * learning on VIDs with no membership entry while the bridge is
+	 * VLAN-unaware. Both bits are inert while global learning is disabled.
+	 */
+	reg = sw_ior(sw, TSN_SW_ADDR_LEARN_OFFSET);
+	reg |= TSN_SW_ADDR_LEARN_DISABLE | TSN_SW_ADDR_LEARN_UNTAGGED_EN |
+	       TSN_SW_ADDR_LEARN_NO_VLAN_EN;
+	sw_iow(sw, TSN_SW_ADDR_LEARN_OFFSET, reg);
+
+	/* On a CAM miss flood unknown tagged unicast frames to all ports. */
+	reg = sw_ior(sw, TSN_SW_CTRL_OFFSET);
+	reg &= ~TSN_SW_CTRL_UCAST_MISS_MASK;
+	reg |= FIELD_PREP(TSN_SW_CTRL_UCAST_MISS_MASK, TSN_SW_CTRL_UCAST_MISS_FLOOD);
+	sw_iow(sw, TSN_SW_CTRL_OFFSET, reg);
+
 	/* Route CPU-originated bridge-group control frames (STP, LLDP) to
 	 * the single wire port whose MAC-nibble field matches the frame's
 	 * source-MAC low nibble, instead of flooding to both.
@@ -743,7 +1034,12 @@ static const struct dsa_switch_ops xlnx_tsn_switch_ops = {
 	.teardown		= xlnx_tsn_teardown,
 	.port_set_mac_address	= xlnx_tsn_port_set_mac_address,
 	.port_bridge_join	= xlnx_tsn_port_bridge_join,
+	.port_bridge_leave	= xlnx_tsn_port_bridge_leave,
 	.port_stp_state_set	= xlnx_tsn_port_stp_state_set,
+	.port_fdb_add		= xlnx_tsn_port_fdb_add,
+	.port_fdb_del		= xlnx_tsn_port_fdb_del,
+	.port_fdb_dump		= xlnx_tsn_port_fdb_dump,
+	.port_fast_age		= xlnx_tsn_port_fast_age,
 	.port_hwtstamp_get	= xlnx_tsn_port_hwtstamp_get,
 	.port_hwtstamp_set	= xlnx_tsn_port_hwtstamp_set,
 	.get_ts_info		= xlnx_tsn_get_ts_info,
@@ -778,6 +1074,9 @@ static int xlnx_tsn_probe(struct platform_device *pdev)
 	sw->dev = dev;
 	sw->mac[XLNX_TSN_PORT_MAC1].sw = sw;
 	sw->mac[XLNX_TSN_PORT_MAC2].sw = sw;
+	ret = devm_mutex_init(dev, &sw->indirect_lock);
+	if (ret)
+		return ret;
 
 	ret = xlnx_tsn_map_reg(pdev, "switch", &sw->sw_base);
 	if (ret)
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
index d46150535775..a94f5124a33d 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.h
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.h
@@ -63,18 +63,104 @@
 #define TSN_SW_MGMT_QUEUING_OFFSET		0x00054
 #define TSN_SW_MGMT_QUEUING_EP_SA_EGRESS	BIT(4)
 
-/* readl_poll_timeout() parameters (in microseconds): poll until
- * the port-state change-commit bit self-clears.
+/* Shared readl_poll_timeout() parameters (in microseconds) used at
+ * two call sites: the port-state change-commit bit and the CAM
+ * operation enable bit. Both self-clear when the operation completes.
  */
 #define TSN_SW_POLL_DELAY_US		10
 #define TSN_SW_POLL_TIMEOUT_US		5000
 
+/* Stream-destination-lookup CAM: maps a (destination MAC, VLAN ID) key
+ * to an egress port list, backing the bridge FDB. Access is indirect:
+ * load the key, value, and port-list registers, write the opcode, then
+ * set the Enable Operation bit in the control register. Poll CAM Init
+ * Done in the status register to 1 before each operation to confirm the
+ * block is ready. Enable Operation self-clears when the operation
+ * finishes.
+ */
+#define TSN_CAM_CTRL_OFFSET		0x01000
+#define TSN_CAM_STATUS_OFFSET		0x01004
+#define TSN_CAM_KEY1_OFFSET		0x01008
+#define TSN_CAM_KEY2_OFFSET		0x0100c
+#define TSN_CAM_TV1_OFFSET		0x01010
+#define TSN_CAM_TV2_OFFSET		0x01014
+#define TSN_CAM_PORT_ACT_OFFSET		0x01018
+
+/* Control register: set to start an operation, self-clears when done. */
+#define TSN_CAM_OP_ENABLE		BIT(0)
+/* Status register: reads 1 when the CAM is ready for the next operation. */
+#define TSN_CAM_STATUS_READY		BIT(0)
+#define TSN_CAM_OP_MASK			GENMASK(2, 1)
+#define TSN_CAM_OP_READ_KEY		0x0
+#define TSN_CAM_OP_ADD			0x1
+#define TSN_CAM_OP_DELETE		0x2
+#define TSN_CAM_OP_READ			0x3
+#define TSN_CAM_FOUND			BIT(7)
+#define TSN_CAM_VLAN			GENMASK(27, 16)
+#define TSN_CAM_PORT_LIST		GENMASK(10, 8)
+#define TSN_CAM_READ_KEY_ADDR		GENMASK(19, 8)
+#define TSN_CAM_MAC2_READ_KEY_BASE	0x800
+#define TSN_CAM_READ_KEY_COUNT		2048
+
+/* HW reset-default native VID; DSA's "no VLAN" (vid 0) maps onto it. */
+#define TSN_SW_DEFAULT_VID		1
+
+/* Switch Control Register: switch-wide control fields. */
+#define TSN_SW_CTRL_OFFSET		0x00004
+/* Per-port native-VLAN untag enables: strip the tag on egress when the
+ * frame VID equals the egress port's native VID. Only the wire ports are
+ * untagged; the endpoint port is left tagged so the host keeps the VID for
+ * software classification.
+ */
+#define TSN_SW_CTRL_MAC1_NATIVE_UNTAG_EN	BIT(18)
+#define TSN_SW_CTRL_MAC2_NATIVE_UNTAG_EN	BIT(19)
+/* Action for an ingress frame whose port is not in its VLAN's member
+ * list: forward to the processor or discard. Pinned to discard. This only
+ * matters once a VID's Port-List-Valid bit is set, which happens only
+ * while VLAN filtering is on.
+ */
+#define TSN_SW_CTRL_MEMBER_VIOL_MASK		GENMASK(9, 8)
+#define TSN_SW_CTRL_MEMBER_VIOL_DISCARD		0x1
+
+/* Forwarding action for a tagged unicast or multicast frame that misses
+ * both the CAM and the VLAN membership list: flood, to processor, to MAC,
+ * or discard.
+ */
+#define TSN_SW_CTRL_UCAST_MISS_MASK		GENMASK(1, 0)
+#define TSN_SW_CTRL_MCAST_MISS_MASK		GENMASK(3, 2)
+#define TSN_SW_CTRL_UCAST_MISS_FLOOD		0x1
+#define TSN_SW_CTRL_MCAST_MISS_FLOOD		0x1
+#define TSN_SW_CTRL_MISS_DISCARD		0x3
+
+/* Hardware Address Learning Control: switch-wide learning behaviour. */
+#define TSN_SW_ADDR_LEARN_OFFSET		0x00048
+/* Disable the global learning engine; set to 1 while every user port is
+ * standalone, cleared to 0 when at least one port joins a bridge. The
+ * sub-qualifier bits below are inert while this bit is set.
+ */
+#define TSN_SW_ADDR_LEARN_DISABLE		BIT(0)
+/* Learn the source MAC of untagged and priority-tagged frames against the
+ * ingress port's native VID; the reset default excludes them from learning.
+ */
+#define TSN_SW_ADDR_LEARN_UNTAGGED_EN		BIT(1)
+/* Permit learning on a VID that has no member entry programmed in the VLAN
+ * membership memory; the reset default only learns already-configured VIDs.
+ */
+#define TSN_SW_ADDR_LEARN_NO_VLAN_EN		BIT(3)
+
+/* Map a DSA port index to its bit in a switch port list. */
+#define TSN_PORT_BIT(port)		BIT(port)
+
 enum tsn_port_state {
 	TSN_PORT_STATE_DISABLED = 0,
 	TSN_PORT_STATE_BLOCKING,
 	TSN_PORT_STATE_LISTENING,
 	TSN_PORT_STATE_LEARNING,
 	TSN_PORT_STATE_FORWARDING,
+	/* Not an STP state. Writing it flushes the port's dynamic learnt
+	 * entries and leaves static FDB entries in place.
+	 */
+	TSN_PORT_STATE_FLUSH,
 };
 
 /* Per-MAC MDIO controller register window, sitting at +0x500 inside
@@ -218,6 +304,8 @@ struct xlnx_tsn_mac {
  * @nb: netdev notifier that handles NETDEV_REGISTER on each swpN
  *	to set its final MAC, and NETDEV_CHANGEADDR on the conduit
  *	to refresh the shared prefix
+ * @indirect_lock: serialises the CAM and VLAN-membership indirect
+ *		   register sequences
  * @mac: per-MAC state, indexed by user-port number (index 0 unused;
  *	 MAC1 at [1], MAC2 at [2])
  * @ptp_timer_irq: 1 PPS / RTC-overflow interrupt
@@ -239,6 +327,7 @@ struct xlnx_tsn {
 	struct net_device *conduit;
 	u8 mac_prefix[ETH_ALEN];
 	struct notifier_block nb;
+	struct mutex indirect_lock; /* serialises CAM indirect access */
 	struct xlnx_tsn_mac mac[XLNX_TSN_NUM_PORTS];
 	int ptp_timer_irq;
 	struct ptp_clock *ptp_clock;
-- 
2.34.1

