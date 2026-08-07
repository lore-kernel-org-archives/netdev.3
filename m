Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F554334C0;
	Fri,  7 Aug 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099598; cv=fail; b=VhKc5PODw7KfcrotaO3fmV8bbOA+zPx3LbkHlvO+AllEm4O1GD8cq0n3xGv/z9Zt5TsC7fVsRTnnztfN7W5dybWOgbGtYkNEOQuXHJsX9TK0hjxGnD1r1IHUtEBfAAVRLKzyKoo/g2+IAJz3NrPfgK5qbo2PDo4MkJAKKG8ChfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099598; c=relaxed/simple;
	bh=ZoUuuRRKWiJ4geVvBui8Ujgx96KFMArmlaAjrS6fZaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVVAoFlelhr8HvpdBMDtVw1aEw5ApVnfQLDIC6nEGKs28HcqKhQqQYScv/hgR0v59tcg3BRbVWSmHjO70Aesj2JQ/fBvKjawjwrpst9nOBZOw6hKmQJfYKvmbYAheHaELhdyu+0HYPGWd3ikzYDv4+mX+l6PW6O9MhKEotJ6YuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QoGSTnbY; arc=fail smtp.client-ip=52.101.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QoGSTnbY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZNE0OCBFKm85DKz5jhw2eDzah6RjLoV2Tvj7ek+ZNOIiIH1HVwfIbbAuvW0D+T5r0FXse1XU9Gp7NS//mLGgvB8ViJFQ7m+e7owyUd8wKe/1hTjZxPO//ahqtxGhoV0YsMnD+d77Xa44KcE2Rb12F6ZicmjPR2P8PThb+yYhjumbcGAT5kWyn7NXdoJikDKf6vTxCSkdiw4X7cfsDHuR7J5PEdpuXZSlJa0BZAVtZS8VRQ+/nbc9uFeYN/myLvM7sZcyn14Fo3zXjP2+PQ7ttdHATTHywF3YZcgaTazdwUOZ8kRnR+7hmV5FG53odAUep6JxQXQqVLP50NowZAfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyVpYFDqp7DKzmvb3OYbYySE/GVOTMB2NAk3snkagzM=;
 b=nqlQjhNPFQcx47CEr+n1rMCU+tCrwRuM3vRCLPDYX4zfBQk7+OLXn9C2OGN+SKups7ym0we1xAtNFCA2OH/ahKf0PmT0QQmco3Fa3TEN4wLtCeGq6kwpzLbaEk9uSLoopBnY8v8MpVpNj2PpFMqEQCIcU673J4KbobqV9E45dyvkfyQNflul9jYv25mPoWvgxg6Fn0usQiIX8XdeH3h8wozJm2ldDBnadqqF7YnCPmbcyrY15kQYgRYDa7NtA/8cGHR+excpvWbCnBKOiFxBxDTXWDAwhXTKcg7xWzmeNmfUXfgAEDAkXriMc/vbmOWXBre6iSafB7Dr5YSDT/lfkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyVpYFDqp7DKzmvb3OYbYySE/GVOTMB2NAk3snkagzM=;
 b=QoGSTnbYcP2lHymLGcCDfzZ90mPHEYbHw8KoGtgYff1x55ih5+4kC8n4PyTGDETR10tmG9etMjzeKUcGZvjgA+Zrn+r3LlzqtXXW59no3ECMKZTxagNBBIxX2fkAAAomIWMNZncsRehKw0tFPgPncqU/T9EqkDkneJ1tF71Rnis=
Received: from BY3PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:39b::25)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 10:46:30 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::47) by BY3PR05CA0050.outlook.office365.com
 (2603:10b6:a03:39b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.10 via Frontend Transport; Fri, 7
 Aug 2026 10:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 10:46:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:46:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:46:28 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:46:23 -0500
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
Subject: [PATCH 20/20] net: dsa: xilinx: trap link-local control frames to the CPU port
Date: Fri, 7 Aug 2026 16:14:31 +0530
Message-ID: <20260807104431.157230-21-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: a27e4b98-7617-44d0-80df-08def47123cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|921020|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lZNwlreApoTFzauDRTpv9o3YYW5yLAH6nGnxf9bwxdT46xpJyGdI7xkFchsPhOSLNMKqcC3k+yu6fqPK9+a7QzeZgZcVpPVrpm1g1VxKpMLWakethIwPaCQvqYfh3lH9cy9aNEcTxSd+TILnUTYz3utOzVueHWfBQwVfRSsdM2dxk/dSNCpueRWEuOSf4oVrHWc6oOakSXYDaals1T38DnVB0Ciag9OE5W/hK+sEQSnz2AzRJCu6Onq7VOA00Engq6QqQHD5UPqpkYdZB4+jPsjr3LpuhnVyqH2KlLGaqAIIdu5qn6n/cbU4y1xgifUlSE+ThYxs+AMGvmphYVrvDy9EFynHWPyZB7CJHQtp2p04E8ESMpzN5oWQdkAk0ESNnzRoSbm0ef0OKkbgT0gO2uZv0bkjBkFRCutU5M6Qk3yRM7Zlj7QTga+ewWQ1tKEW/PeSmIP4MWnbaLM9ZJ42xhr58vdd7DuPdmDVES4u6QGU7qV7Yp+yPDXs+ATu54ZgM7tyhbS0YTSyl+ZSQv1azyrX5+80OGEQHslDyCjwlY6u+7vvrcrlz2RHGUyuOrCCXpQeeSL39FuVw/6fKCgu6WyUSjDWtNjxNC3+qEIu+trR0oCmNO3pf0+xhiRaxbshj59qNa5NevuaMpflW+TI4RtZKQLkmzK6+cjx/3l4uA6/kCTij+nj3FJr0MVXv3Y8AEnBu6LXnY8yPEjsMUCTvFEmHI0OdBXcXdZwgmrJ890dYiH5PbAGfdWp3VuOwcyB
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L0+sRRuIcGsibYC1Eo8B4BzNrob8Q/KNJhzH8c13TMzf+Ucq+YXe5FYjeNGyeYUaPbg3O0ZghkKDoPDI3LkCRQ6L6umnMhNxoPdRACMyyvTGsJkBGZqawKxdXwuHVZOALd6hnfVOuZXyGec1aC0E3SGOPKpZr6V5+KcfWLv+wkLUA+6AjfDG3CBgqXVkQJY+M9+wEWyfV/rckFeoaLomvFy/V5115UCx5LqQoa1E1Hjl2+0D3H3u9mtMBFb0zTvCoaKDg214YkhbVUJ36Jtinm/LMe1bU4NeVN8yaOQ6i7cKUAVkb6cWOFdnB5Z+iVnymAJn6PZykRh6v/UNGkLp3vfz9PzG7S09q3Hc7dODiHSt07OTqwADyABh0y4fwa5eE62AX//dck0jO7kLSHfnlojTJmrPdv/HJhsaH6Jk/0LHxMSiJgkS9xIbi5FoUB7A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:46:30.1018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27e4b98-7617-44d0-80df-08def47123cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623

The TSN switch fabric forwards frames by CAM lookup. A frame whose
destination MAC misses the CAM is treated as unknown and flooded to all
ports except the ingress port. Link-local control frames (STP BPDUs,
LLDPDUs) use destination MACs in the IEEE 802.1 bridge-group address
range 01:80:c2:00:00:00..0f, which a bridge must consume locally and
never relay between ports.

Install CAM entries for the in-use bridge-group addresses (STP at
01:80:c2:00:00:00 and LLDP at 01:80:c2:00:00:0e). Set the forwarding
port list to the CPU port only and set the endpoint management queuing
bit in the port-action register. The switch then delivers trapped
frames on the management queue.

The CAM matches on (DA, VID) exactly. Untagged control frames are
looked up under the ingress port's native VID, so a trap entry must
exist for every native VID in use. Keep entries in sync with each
wire port's current native VID.

The CAM has no DA-mask capability, so covering all 16 bridge-group
addresses would cost 16 entries per VID. Only the addresses in
active use are trapped.

Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 drivers/net/dsa/xilinx/xilinx_tsn.c | 176 ++++++++++++++++++++++++++--
 drivers/net/dsa/xilinx/xilinx_tsn.h |   9 ++
 2 files changed, 176 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
index 7e5cf77cfa66..e35dbcdfcbda 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.c
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.c
@@ -671,11 +671,14 @@ static int xlnx_tsn_cam_read_portlist(struct xlnx_tsn *sw,
 }
 
 /* Add (add=true) or delete (add=false) the (MAC, VID) entry carrying the
- * given port list. Caller holds indirect_lock.
+ * given port list. Set mgmt for entries whose frames must be classified as
+ * endpoint management traffic; clear it for plain forwarding/FDB entries.
+ * Caller holds indirect_lock.
  */
 static int xlnx_tsn_cam_write(struct xlnx_tsn *sw, const unsigned char *addr,
-			      u16 vid, u8 portlist, bool add)
+			      u16 vid, u8 portlist, bool mgmt, bool add)
 {
+	u32 port_act;
 	int ret;
 
 	ret = xlnx_tsn_cam_wait_ready(sw);
@@ -685,8 +688,13 @@ static int xlnx_tsn_cam_write(struct xlnx_tsn *sw, const unsigned char *addr,
 	xlnx_tsn_cam_load_key(sw, addr, vid);
 	sw_iow(sw, TSN_CAM_TV1_OFFSET, 0);
 	sw_iow(sw, TSN_CAM_TV2_OFFSET, 0);
-	sw_iow(sw, TSN_CAM_PORT_ACT_OFFSET,
-	       FIELD_PREP(TSN_CAM_PORT_LIST, portlist));
+
+	port_act = FIELD_PREP(TSN_CAM_PORT_LIST, portlist);
+	if (mgmt)
+		port_act |= TSN_CAM_EP_MGMTQ_EN;
+
+	sw_iow(sw, TSN_CAM_PORT_ACT_OFFSET, port_act);
+
 	sw_iow(sw, TSN_CAM_CTRL_OFFSET,
 	       FIELD_PREP(TSN_CAM_OP_MASK, add ? TSN_CAM_OP_ADD : TSN_CAM_OP_DELETE) |
 	       TSN_CAM_OP_ENABLE);
@@ -694,6 +702,28 @@ static int xlnx_tsn_cam_write(struct xlnx_tsn *sw, const unsigned char *addr,
 	return xlnx_tsn_cam_wait_done(sw);
 }
 
+/* IEEE 802.1 bridge-group destination MACs. A bridge must consume
+ * these locally rather than relay them between ports. Each address
+ * gets a CAM trap entry pointing to the CPU port only. The CAM
+ * matches the destination MAC exactly, so only the addresses in
+ * active use are listed here.
+ */
+static const u8 xlnx_tsn_ctrl_das[][ETH_ALEN] = {
+	{ 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 }, /* STP / RSTP / MSTP */
+	{ 0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e }, /* LLDP */
+};
+
+static bool xlnx_tsn_addr_is_ctrl_trap(const unsigned char *addr)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(xlnx_tsn_ctrl_das); i++)
+		if (ether_addr_equal(addr, xlnx_tsn_ctrl_das[i]))
+			return true;
+
+	return false;
+}
+
 static void xlnx_tsn_port_fast_age(struct dsa_switch *ds, int port)
 {
 	struct xlnx_tsn *sw = ds->priv;
@@ -712,6 +742,9 @@ static int xlnx_tsn_port_fdb_add(struct dsa_switch *ds, int port,
 	u8 portlist;
 	int ret;
 
+	if (xlnx_tsn_addr_is_ctrl_trap(addr))
+		return 0;
+
 	if (!vid)
 		vid = TSN_SW_DEFAULT_VID;
 
@@ -719,7 +752,7 @@ static int xlnx_tsn_port_fdb_add(struct dsa_switch *ds, int port,
 	ret = xlnx_tsn_cam_read_portlist(sw, addr, vid, &portlist);
 	if (!ret) {
 		portlist |= TSN_PORT_BIT(port);
-		ret = xlnx_tsn_cam_write(sw, addr, vid, portlist, true);
+		ret = xlnx_tsn_cam_write(sw, addr, vid, portlist, false, true);
 	}
 
 	return ret;
@@ -733,6 +766,9 @@ static int xlnx_tsn_port_fdb_del(struct dsa_switch *ds, int port,
 	u8 portlist;
 	int ret;
 
+	if (xlnx_tsn_addr_is_ctrl_trap(addr))
+		return 0;
+
 	if (!vid)
 		vid = TSN_SW_DEFAULT_VID;
 
@@ -746,7 +782,8 @@ static int xlnx_tsn_port_fdb_del(struct dsa_switch *ds, int port,
 		 * rewrite it with the updated port list.
 		 */
 		portlist &= ~TSN_PORT_BIT(port);
-		ret = xlnx_tsn_cam_write(sw, addr, vid, portlist, portlist != 0);
+		ret = xlnx_tsn_cam_write(sw, addr, vid, portlist, false,
+					 portlist != 0);
 	}
 
 	return ret;
@@ -936,12 +973,93 @@ static void xlnx_tsn_set_vlan_only_learning(struct xlnx_tsn *sw, bool on)
 	sw_iow(sw, TSN_SW_ADDR_LEARN_OFFSET, reg);
 }
 
+/* Install or remove link-local control-frame traps for one VID.
+ * Each entry points to the CPU port and marks frames as management
+ * traffic for delivery on the management queue. Caller holds
+ * indirect_lock.
+ */
+static int xlnx_tsn_set_ctrl_traps(struct xlnx_tsn *sw, u16 vid, bool add)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(xlnx_tsn_ctrl_das); i++) {
+		ret = xlnx_tsn_cam_write(sw, xlnx_tsn_ctrl_das[i], vid,
+					 TSN_PORT_BIT(XLNX_TSN_CPU_PORT),
+					 true, add);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static bool xlnx_tsn_vid_in(const u16 *vids, int count, u16 vid)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		if (vids[i] == vid)
+			return true;
+
+	return false;
+}
+
+/* Keep CAM traps in sync with the native VIDs the wire ports use. An
+ * untagged BPDU or LLDP frame is looked up under the ingress port's
+ * native VID, so a trap must exist at each native VID in use. While
+ * the bridge is not VLAN-aware every port uses the default VID. Call
+ * again whenever a native VID changes. Caller holds indirect_lock.
+ */
+static int xlnx_tsn_sync_ctrl_traps(struct xlnx_tsn *sw)
+{
+	u16 want[XLNX_TSN_NUM_PORTS - 1], vid;
+	struct dsa_port *dp;
+	int i, n, ret;
+
+	n = 0;
+	dsa_switch_for_each_user_port(dp, &sw->ds) {
+		vid = sw->vlan_aware ? sw->pvid[dp->index] : TSN_SW_DEFAULT_VID;
+		if (!xlnx_tsn_vid_in(want, n, vid))
+			want[n++] = vid;
+	}
+
+	/* Remove traps at VIDs no longer used as any wire port's native VID. */
+	i = 0;
+	while (i < sw->ctrl_trap_count) {
+		vid = sw->ctrl_trap_vid[i];
+		if (xlnx_tsn_vid_in(want, n, vid)) {
+			i++;
+			continue;
+		}
+		ret = xlnx_tsn_set_ctrl_traps(sw, vid, false);
+		if (ret)
+			return ret;
+
+		sw->ctrl_trap_vid[i] = sw->ctrl_trap_vid[--sw->ctrl_trap_count];
+	}
+
+	/* Add traps at native VIDs not yet installed. */
+	for (i = 0; i < n; i++) {
+		if (xlnx_tsn_vid_in(sw->ctrl_trap_vid, sw->ctrl_trap_count,
+				    want[i]))
+			continue;
+		ret = xlnx_tsn_set_ctrl_traps(sw, want[i], true);
+		if (ret)
+			return ret;
+
+		sw->ctrl_trap_vid[sw->ctrl_trap_count++] = want[i];
+	}
+
+	return 0;
+}
+
 static int xlnx_tsn_port_vlan_filtering(struct dsa_switch *ds, int port,
 					bool vlan_filtering,
 					struct netlink_ext_ack *extack)
 {
 	struct xlnx_tsn *sw = ds->priv;
 	struct dsa_port *dp;
+	bool old_vlan_aware;
 	unsigned long bit;
 	u32 reg, data;
 	int ret;
@@ -967,6 +1085,7 @@ static int xlnx_tsn_port_vlan_filtering(struct dsa_switch *ds, int port,
 			return ret;
 	}
 
+	old_vlan_aware = sw->vlan_aware;
 	sw->vlan_aware = vlan_filtering;
 
 	/* Miss policy for unicast and multicast. It only kicks in when the
@@ -1004,15 +1123,23 @@ static int xlnx_tsn_port_vlan_filtering(struct dsa_switch *ds, int port,
 		ret = xlnx_tsn_port_state_cycle(sw, dp->index,
 						TSN_PORT_STATE_BLOCKING);
 		if (ret)
-			return ret;
+			goto restore;
 
 		ret = xlnx_tsn_port_state_cycle(sw, dp->index,
 						TSN_PORT_STATE_FLUSH);
 		if (ret)
-			return ret;
+			goto restore;
 	}
 
+	ret = xlnx_tsn_sync_ctrl_traps(sw);
+	if (ret)
+		goto restore;
+
 	return 0;
+
+restore:
+	sw->vlan_aware = old_vlan_aware;
+	return ret;
 }
 
 static int xlnx_tsn_port_vlan_add(struct dsa_switch *ds, int port,
@@ -1061,6 +1188,7 @@ static int xlnx_tsn_port_vlan_add(struct dsa_switch *ds, int port,
 		sw->pvid[port] = vlan->vid;
 		sw->pvid_untagged[port] = untagged;
 		xlnx_tsn_apply_pvid(sw, port);
+		return xlnx_tsn_sync_ctrl_traps(sw);
 	}
 
 	if (vlan->vid == sw->pvid[port] &&
@@ -1101,6 +1229,7 @@ static int xlnx_tsn_port_vlan_del(struct dsa_switch *ds, int port,
 		sw->pvid[port] = TSN_SW_DEFAULT_VID;
 		sw->pvid_untagged[port] = false;
 		xlnx_tsn_apply_pvid(sw, port);
+		return xlnx_tsn_sync_ctrl_traps(sw);
 	}
 
 	return 0;
@@ -1204,6 +1333,21 @@ static const struct phylink_mac_ops xlnx_tsn_phylink_mac_ops = {
 	.mac_link_down	= xlnx_tsn_mac_link_down,
 };
 
+static void xlnx_tsn_remove_ctrl_traps(struct xlnx_tsn *sw)
+{
+	int i;
+
+	guard(mutex)(&sw->indirect_lock);
+
+	for (i = 0; i < sw->ctrl_trap_count; i++)
+		if (xlnx_tsn_set_ctrl_traps(sw, sw->ctrl_trap_vid[i], false))
+			dev_warn(sw->dev,
+				 "failed to remove control trap vid %u\n",
+				 sw->ctrl_trap_vid[i]);
+
+	sw->ctrl_trap_count = 0;
+}
+
 static int xlnx_tsn_setup(struct dsa_switch *ds)
 {
 	struct dsa_port *cpu_dp = dsa_to_port(ds, XLNX_TSN_CPU_PORT);
@@ -1276,9 +1420,19 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
 			return ret;
 	}
 
+	/* Trap link-local control frames (STP, LLDP) to the CPU port.
+	 * Without this, a frame arriving on one wire port would be
+	 * flooded out the other instead of reaching the host bridge.
+	 */
+	scoped_guard(mutex, &sw->indirect_lock) {
+		ret = xlnx_tsn_sync_ctrl_traps(sw);
+		if (ret)
+			return ret;
+	}
+
 	ret = xlnx_tsn_mdio_register_all(sw);
 	if (ret)
-		return ret;
+		goto err_traps;
 
 	sw->nb.notifier_call = xlnx_tsn_netdev_event;
 	ret = register_netdevice_notifier(&sw->nb);
@@ -1312,6 +1466,8 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
 	unregister_netdevice_notifier(&sw->nb);
 err_mdio:
 	xlnx_tsn_mdio_unregister_all(sw);
+err_traps:
+	xlnx_tsn_remove_ctrl_traps(sw);
 	return ret;
 }
 
@@ -1327,6 +1483,8 @@ static void xlnx_tsn_teardown(struct dsa_switch *ds)
 	unregister_netdevice_notifier(&sw->nb);
 	xlnx_tsn_mdio_unregister_all(sw);
 
+	xlnx_tsn_remove_ctrl_traps(sw);
+
 	dsa_switch_for_each_user_port(dp, ds)
 		xlnx_tsn_set_port_state(sw, dp->index, TSN_PORT_STATE_DISABLED);
 
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
index 955041cde564..dbf330d3d615 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.h
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.h
@@ -100,6 +100,10 @@
 #define TSN_CAM_FOUND			BIT(7)
 #define TSN_CAM_VLAN			GENMASK(27, 16)
 #define TSN_CAM_PORT_LIST		GENMASK(10, 8)
+/* Classify a CAM-matched frame as endpoint management traffic so the
+ * switch delivers it on the management queue.
+ */
+#define TSN_CAM_EP_MGMTQ_EN		BIT(15)
 #define TSN_CAM_READ_KEY_ADDR		GENMASK(19, 8)
 #define TSN_CAM_MAC2_READ_KEY_BASE	0x800
 #define TSN_CAM_READ_KEY_COUNT		2048
@@ -342,6 +346,9 @@ struct xlnx_tsn_mac {
  *		   untagged; drives the native-VLAN untag enable
  * @cfg_vids: VIDs with a membership entry in the VLAN-membership memory,
  *	      used to walk and update Port-List-Valid when @vlan_aware changes
+ * @ctrl_trap_vid: native VIDs that currently carry link-local control-frame
+ *		   traps, kept in sync with the wire ports' native VIDs
+ * @ctrl_trap_count: number of valid entries in @ctrl_trap_vid
  * @indirect_lock: serialises the CAM and VLAN-membership indirect
  *		   register sequences
  * @mac: per-MAC state, indexed by user-port number (index 0 unused;
@@ -369,6 +376,8 @@ struct xlnx_tsn {
 	u16 pvid[XLNX_TSN_NUM_PORTS];
 	bool pvid_untagged[XLNX_TSN_NUM_PORTS];
 	DECLARE_BITMAP(cfg_vids, VLAN_N_VID);
+	u16 ctrl_trap_vid[XLNX_TSN_NUM_PORTS - 1];
+	u8 ctrl_trap_count;
 	struct mutex indirect_lock; /* serialises CAM + VLAN-memory access */
 	struct xlnx_tsn_mac mac[XLNX_TSN_NUM_PORTS];
 	int ptp_timer_irq;
-- 
2.34.1

