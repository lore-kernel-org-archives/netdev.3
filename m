Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270B470EA2;
	Fri,  7 Aug 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099564; cv=fail; b=ELv89Sf80azevaMj00rLkHLUGwBr+R2dP0y8c2bd7aWI1Ao9MQq0fhviiYWFm2t5wjKc5zHJ1n7YJoQHb7pC5JFHJCiZ+lEsR2W7f7ZyAgrdNIHUlO/FFWDv8sRV+Olxubrj5nsbNCybEksnm42k+1AMfO11kLl1BjfUWCrMcX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099564; c=relaxed/simple;
	bh=Qi3WN1vMCqZV6up4If/VMYNsugPjmvF0XJrsPz62Gzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSOOma4WLHmYbIdhbCBwPCkoB2a6JaLYLkgGIwaFF/ABvrQTz8jA0ksGFYchPXwnVHJfTun//zsSyeHmd57iTxqreW8kEWw7G1AgKnhbiEBkBII9R1shiXxQ6v8APFLINfuow0UQBcxQoDS5nl2Fso1uwTgduTv78SojtnoAZGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0N+psR4N; arc=fail smtp.client-ip=52.101.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0N+psR4N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXECfYn6nSpwsI7FFe/VEN6gkQyVWRqREZRGjp3hRCAPz3jRrEkGxuX63zmZVutgQmSGlg9f4j4AH7EtUwELhZDHeqio85tRV1/+PUBfLTT5sq1rulpb1PtCje0NHr/IaML2TK+HpEseGBrQBBYsvDWcLAplQ0Qsd/BEdv7YHbzBXe6pNfj9+issNLksvAOpJdBQo7YoFwHntdUa3lAOu2lK3cgXWhZvS7/lf4KdO2l8DGYK544eE/5Ifos3VFCiUiks9vYenK2YqW81NNWXX2AMpUm324PMv9SuNn2VYrj53dK+ES/7Vr/KWfmRVWX7EjaSBQvIbNbEQbXRUmZifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Sr1sb/O0aCK8QKKzAyL/9lHzwht58GnRXMrOOp4IwY=;
 b=S5shMqPDn6wQAOeQcnlVS4h6SWhV3R81iXC/y7MkKmzRfpX5pfQDGv53300o0SRzUDa8Khn/pOgC9zZR/pR6UW+B+CM/pwDwMR3n1DkDxq+zjcnSStxYKhyaJFW7l0OaxPebbx3JOOc0EwZuOYIYsxXsEygiutgt6HU+PNGKqKy38RaeCZj6V8xBDFPhjD9EIjPFghricQsdT8RP/4Vgnrase3iF5VrDmB0JtpkagOW7P1wOHDhQ4vfDM81+FP+BQdnNi7m4XENqOXnIZStyzY7bDLhRO12GfajeCvgDtIF04YxomNI4MMIpEoA5CwC0ihIoQcZv/qR56qJDGg+feg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Sr1sb/O0aCK8QKKzAyL/9lHzwht58GnRXMrOOp4IwY=;
 b=0N+psR4NvAreSWXqwo8/j0P7/Xr2+Vvo+rr9bGevOfHuY9l4inFBvhiFZqHh153N4D0JR+dBNGr25+pqnSVtrJZv3b/nuaS2NvgMB/bBFngFQRLRd0Lru/4Aki4VISNFFjxRDaKUV3mr7QMBkTO9WhuFCfBJT8yRB1q5KntA88A=
Received: from SJ0PR13CA0221.namprd13.prod.outlook.com (2603:10b6:a03:2c1::16)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Fri, 7 Aug
 2026 10:45:57 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::a6) by SJ0PR13CA0221.outlook.office365.com
 (2603:10b6:a03:2c1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.8 via Frontend Transport; Fri, 7
 Aug 2026 10:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Fri, 7 Aug 2026 10:45:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:45:54 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:45:49 -0500
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
Subject: [PATCH 14/20] net: dsa: xilinx: program MAC frame filter and per-port nibbles
Date: Fri, 7 Aug 2026 16:14:25 +0530
Message-ID: <20260807104431.157230-15-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e48f40f-b9f7-451b-79e9-08def4710fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	ody5cAQAlHjix3lXw+ajYsiTqHURoiGPXbl8UcTnhlvbVIcRBl8o97DdJhMQY5gM+s0fgt6R4L7rPWu/WvKmHdhMAIsTIUfk2l+dcXtWWlHKN0NMDbZR0pxy964UweOlSTpTyn7xs4b5gZcEgW1JZclikssNsQgd8LTWEkhmTmTbNBt/vge01vr7OjZsdZl2NlWL/RP4Zj0G4z9xYRzXTA2wZFJ9dlp66hLXOIloXoD28iiMl4FZ7lpOlS0zhxTWs0ra/58TYtyPkdFEJ9DPl8DxgvDydgvVFvKXvEpBeU6a8kYt/SM5sMQuRuZzocT+/6DOcZGcxbF6C1RF/ZoYEqkt8fpcbJxEoPoEj+d2+Bi7soCdr6YD3XZMQPkPqGmDMYHXgM1YzI1bfA4accS6hPkIirIeRjWw5LN7lsyIReQOpk2gpQ6CIgG9dqhzbpCUbD+b24BNY6xML200siXbjsoQOISx9FJk/RpjxeZjmqhSJmL2jsD+oBa7jF0RNaPZSxhpWzJZRgeQuZlhP3sdPESTsXL2JpkQAhoyKQ36EwtqFSOwR8+QdeAxPrRyr1TBDV3VIGCA9wy+747XKyZl9OpgiEsyNtQTLmIR7cDxUOi2MCmncDplvEiP9Fsr44DclqMzGZMXnubf1LOP7zfjejWbA8fmFSRTohtRhML4jmD4hSm/ZgNytrF45oH64e9lKgZxX+a4xC6WD132Xan8Ao0aGYHhWSZGorxlN78FlG6+aftsoun7TSatrhc9I//+
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oX3337Y64yZKBa2ElCQeQf8MZjRlsf4/j0MPtwIs5cVR4hUtADuhgZN2dVSYOiqUqJhz8f/zx0NCZtM+ssdBXwS31FcRGcDbTX9lwSgFgB0KYdsHlPO1oQBYwUlMjWTo087fufL7HkyJl7NXuATTof3hWGzW+N3I3iDcH4M6DcBtxh6ZdPpCbXUv9qxP378F0MmybDgzxX4sV5hK+eVsEQ05D9mPH3Ht6McsM65VQXxldfx3QZlACNas3C8eMStMHIYIg2vCy74j2J9jyMl3bXuPEESArblcqPwpFHaGgx63C1QFiQ0pkwOsOVVYdU/DCLDXoEOgYQIeDDJ8XhM+sQD13udb4Wz1JwAr8cxifOtg5s8RTIc5aM3w8SfP0R/qk8YghKVjrBYdFg4BZE4ND7BDHATZ7M5ZlA+dmXaRsDD2FN0BsymFtZLyIxm4j5yX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:45:56.4196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e48f40f-b9f7-451b-79e9-08def4710fb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474

The switch fabric identifies a frame's destination port by matching
its MAC against a 48-bit address in TSN_SW_MAC_LSB/TSN_SW_MAC_MSB,
with a 16-bit mask covering bytes 4 and 5. Until the filter is
programmed, every frame misses the classifier.

Take the DSA conduit's MAC as a 44-bit prefix, wildcarding the low
nibble of byte 5, and program both registers. Each of the three
ports also owns a 4-bit MAC nibble field in the Switch Port State
Control register at +0x004C. The field holds the low nibble of
byte 5 of that port's MAC and covers the wildcarded bits, so the
fabric can still tell the ports apart.

Drive all of this from a netdev notifier. On the conduit's
NETDEV_REGISTER, derive the prefix, program the frame filter, and
set the CPU port nibbles for all ports. Handle NETDEV_REGISTER for
each swpN to set its nibble.

Reject port_set_mac_address whenever the requested address does not
match the conduit's prefix, or its low nibble collides with the CPU
port or another user port. The nibble is the only thing that tells
ports apart once the top 44 bits are shared.

Also route CPU-originated bridge control frames (STP, LLDP) to a
single port by nibble match instead of flooding both, since the
classifier can now tell one port's source MAC from the other's.

Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 drivers/net/dsa/xilinx/xilinx_tsn.c | 232 +++++++++++++++++++++++++++-
 drivers/net/dsa/xilinx/xilinx_tsn.h |  39 ++++-
 2 files changed, 268 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
index 86aba2e8b6e9..9826f006b078 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.c
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.c
@@ -5,12 +5,14 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/mdio.h>
 #include <linux/module.h>
+#include <linux/netdevice.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
@@ -33,6 +35,74 @@ static u32 sw_ior(struct xlnx_tsn *sw, u32 off)
 	return ioread32(sw->sw_base + off);
 }
 
+/* Cache the conduit MAC with byte 5's low nibble zeroed out. The
+ * frame-filter mask covers those 4 bits. The per-port MAC-nibble
+ * fields in +0x004C supply the actual values.
+ */
+static void xlnx_tsn_derive_prefix(struct xlnx_tsn *sw)
+{
+	memcpy(sw->mac_prefix, sw->conduit->dev_addr, ETH_ALEN);
+	sw->mac_prefix[5] &= ~TSN_SW_MAC_NIBBLE_WILDCARD;
+}
+
+static void xlnx_tsn_program_frame_filter(struct xlnx_tsn *sw)
+{
+	const u8 *p = sw->mac_prefix;
+	u32 lsb, msb;
+
+	lsb = ((u32)p[2] << 24) | ((u32)p[3] << 16) |
+	      ((u32)p[4] << 8) | p[5];
+	msb = FIELD_PREP(TSN_SW_MAC_MSB_MASK_MASK, TSN_SW_MAC_NIBBLE_WILDCARD) |
+	      FIELD_PREP(TSN_SW_MAC_MSB_ADDR_MASK,
+			 ((u32)p[0] << 8) | p[1]);
+
+	sw_iow(sw, TSN_SW_MAC_LSB_OFFSET, lsb);
+	sw_iow(sw, TSN_SW_MAC_MSB_OFFSET, msb);
+}
+
+/* True when addr's upper 44 bits match the cached prefix. The
+ * prefix has byte 5's low nibble already cleared, so byte 5 of addr
+ * is masked the same way before comparison.
+ */
+static bool xlnx_tsn_prefix_matches(struct xlnx_tsn *sw, const u8 *addr)
+{
+	if (memcmp(addr, sw->mac_prefix, ETH_ALEN - 1) != 0)
+		return false;
+
+	return (addr[5] & ~TSN_SW_MAC_NIBBLE_WILDCARD) == sw->mac_prefix[5];
+}
+
+static int xlnx_tsn_set_port_mac_nibble(struct xlnx_tsn *sw, int port,
+					u8 nibble)
+{
+	u32 mask, new_field, reg;
+
+	nibble &= TSN_SW_MAC_NIBBLE_WILDCARD;
+
+	switch (port) {
+	case XLNX_TSN_CPU_PORT:
+		mask = EP_PORT_MAC_NIBBLE_MASK;
+		new_field = FIELD_PREP(EP_PORT_MAC_NIBBLE_MASK, nibble);
+		break;
+	case XLNX_TSN_PORT_MAC1:
+		mask = MAC1_PORT_MAC_NIBBLE_MASK;
+		new_field = FIELD_PREP(MAC1_PORT_MAC_NIBBLE_MASK, nibble);
+		break;
+	case XLNX_TSN_PORT_MAC2:
+		mask = MAC2_PORT_MAC_NIBBLE_MASK;
+		new_field = FIELD_PREP(MAC2_PORT_MAC_NIBBLE_MASK, nibble);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg = sw_ior(sw, TSN_PORT_STATE_CTRL_OFFSET);
+	reg = (reg & ~mask) | new_field;
+	sw_iow(sw, TSN_PORT_STATE_CTRL_OFFSET, reg);
+
+	return 0;
+}
+
 static int xlnx_tsn_switch_status_ready(struct xlnx_tsn *sw)
 {
 	u32 reg;
@@ -287,6 +357,112 @@ static int xlnx_tsn_mdio_register_all(struct xlnx_tsn *sw)
 	return ret;
 }
 
+/* Build a per-port MAC from the shared prefix. */
+static void xlnx_tsn_synth_port_mac(struct xlnx_tsn *sw, int port,
+				    u8 *out)
+{
+	u8 ep_nibble = sw->conduit->dev_addr[5] & TSN_SW_MAC_NIBBLE_WILDCARD;
+
+	memcpy(out, sw->mac_prefix, ETH_ALEN);
+	out[5] |= (ep_nibble + port) & TSN_SW_MAC_NIBBLE_WILDCARD;
+}
+
+static int xlnx_tsn_user_port_index(struct xlnx_tsn *sw,
+				    const struct net_device *dev)
+{
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_user_port(dp, &sw->ds)
+		if (dp->user == dev)
+			return dp->index;
+
+	return -1;
+}
+
+static int xlnx_tsn_handle_user_register(struct xlnx_tsn *sw,
+					 struct net_device *dev, int port)
+{
+	u8 want[ETH_ALEN];
+	u8 nibble;
+
+	if (!xlnx_tsn_prefix_matches(sw, dev->dev_addr)) {
+		xlnx_tsn_synth_port_mac(sw, port, want);
+		dev_warn(sw->dev,
+			 "port %d: MAC %pM does not match conduit prefix; overriding to %pM\n",
+			 port, dev->dev_addr, want);
+		dev_addr_mod(dev, 0, want, ETH_ALEN);
+		nibble = want[5] & TSN_SW_MAC_NIBBLE_WILDCARD;
+	} else if (ether_addr_equal(dev->dev_addr, sw->conduit->dev_addr)) {
+		/* Either DSA inherited the conduit MAC, or DT gave port@N
+		 * the same address explicitly. Either way, assign a unique
+		 * per-port nibble.
+		 */
+		xlnx_tsn_synth_port_mac(sw, port, want);
+		dev_addr_mod(dev, 0, want, ETH_ALEN);
+		nibble = want[5] & TSN_SW_MAC_NIBBLE_WILDCARD;
+	} else {
+		nibble = dev->dev_addr[5] & TSN_SW_MAC_NIBBLE_WILDCARD;
+	}
+
+	return xlnx_tsn_set_port_mac_nibble(sw, port, nibble);
+}
+
+static void xlnx_tsn_handle_conduit_changeaddr(struct xlnx_tsn *sw)
+{
+	struct dsa_port *dp;
+
+	xlnx_tsn_derive_prefix(sw);
+	xlnx_tsn_program_frame_filter(sw);
+	xlnx_tsn_set_port_mac_nibble(sw, XLNX_TSN_CPU_PORT,
+				     sw->conduit->dev_addr[5]);
+
+	dsa_switch_for_each_user_port(dp, &sw->ds) {
+		u8 want[ETH_ALEN];
+
+		if (!dp->user)
+			continue;
+
+		xlnx_tsn_synth_port_mac(sw, dp->index, want);
+		dev_addr_mod(dp->user, 0, want, ETH_ALEN);
+		call_netdevice_notifiers(NETDEV_CHANGEADDR, dp->user);
+	}
+}
+
+static int xlnx_tsn_netdev_event(struct notifier_block *nb,
+				 unsigned long event, void *ptr)
+{
+	struct xlnx_tsn *sw = container_of(nb, struct xlnx_tsn, nb);
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	int port;
+
+	switch (event) {
+	case NETDEV_REGISTER:
+		if (dev == sw->conduit) {
+			xlnx_tsn_handle_conduit_changeaddr(sw);
+		} else {
+			port = xlnx_tsn_user_port_index(sw, dev);
+			if (port < 0)
+				return NOTIFY_DONE;
+
+			xlnx_tsn_handle_user_register(sw, dev, port);
+		}
+		break;
+	case NETDEV_CHANGEADDR:
+		if (dev == sw->conduit) {
+			xlnx_tsn_handle_conduit_changeaddr(sw);
+		} else {
+			port = xlnx_tsn_user_port_index(sw, dev);
+			if (port < 0)
+				return NOTIFY_DONE;
+
+			xlnx_tsn_set_port_mac_nibble(sw, port, dev->dev_addr[5]);
+		}
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 static enum dsa_tag_protocol xlnx_tsn_get_tag_protocol(struct dsa_switch *ds,
 						       int port,
 						       enum dsa_tag_protocol mp)
@@ -294,6 +470,30 @@ static enum dsa_tag_protocol xlnx_tsn_get_tag_protocol(struct dsa_switch *ds,
 	return DSA_TAG_PROTO_XLNX_TSN;
 }
 
+static int xlnx_tsn_port_set_mac_address(struct dsa_switch *ds, int port,
+					 const unsigned char *addr)
+{
+	u8 nibble = addr[5] & TSN_SW_MAC_NIBBLE_WILDCARD;
+	struct xlnx_tsn *sw = ds->priv;
+	struct dsa_port *dp;
+
+	if (!xlnx_tsn_prefix_matches(sw, addr))
+		return -EINVAL;
+
+	if (nibble == (sw->conduit->dev_addr[5] & TSN_SW_MAC_NIBBLE_WILDCARD))
+		return -EADDRINUSE;
+
+	dsa_switch_for_each_user_port(dp, ds) {
+		if (dp->index == port || !dp->user)
+			continue;
+
+		if ((dp->user->dev_addr[5] & TSN_SW_MAC_NIBBLE_WILDCARD) == nibble)
+			return -EADDRINUSE;
+	}
+
+	return 0;
+}
+
 static void xlnx_tsn_port_stp_state_set(struct dsa_switch *ds, int port,
 					u8 state)
 {
@@ -426,8 +626,10 @@ static const struct phylink_mac_ops xlnx_tsn_phylink_mac_ops = {
 
 static int xlnx_tsn_setup(struct dsa_switch *ds)
 {
+	struct dsa_port *cpu_dp = dsa_to_port(ds, XLNX_TSN_CPU_PORT);
 	struct xlnx_tsn *sw = ds->priv;
 	struct dsa_port *dp;
+	u32 mgmt;
 	int ret;
 
 	if (!dsa_is_user_port(ds, XLNX_TSN_PORT_MAC1) ||
@@ -435,6 +637,19 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
 		return dev_err_probe(sw->dev, -EINVAL,
 				     "both MAC1 and MAC2 must be enabled as switch ports\n");
 
+	if (!cpu_dp || !cpu_dp->conduit)
+		return -ENODEV;
+
+	sw->conduit = cpu_dp->conduit;
+
+	/* Route CPU-originated bridge-group control frames (STP, LLDP) to
+	 * the single wire port whose MAC-nibble field matches the frame's
+	 * source-MAC low nibble, instead of flooding to both.
+	 */
+	mgmt = sw_ior(sw, TSN_SW_MGMT_QUEUING_OFFSET);
+	mgmt |= TSN_SW_MGMT_QUEUING_EP_SA_EGRESS;
+	sw_iow(sw, TSN_SW_MGMT_QUEUING_OFFSET, mgmt);
+
 	/* CPU port stays in FORWARDING so host traffic always flows.
 	 * User ports start in DISABLED and transition from there under
 	 * bridge STP control.
@@ -451,7 +666,20 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
 			return ret;
 	}
 
-	return xlnx_tsn_mdio_register_all(sw);
+	ret = xlnx_tsn_mdio_register_all(sw);
+	if (ret)
+		return ret;
+
+	sw->nb.notifier_call = xlnx_tsn_netdev_event;
+	ret = register_netdevice_notifier(&sw->nb);
+	if (ret)
+		goto err_mdio;
+
+	return 0;
+
+err_mdio:
+	xlnx_tsn_mdio_unregister_all(sw);
+	return ret;
 }
 
 static void xlnx_tsn_teardown(struct dsa_switch *ds)
@@ -459,6 +687,7 @@ static void xlnx_tsn_teardown(struct dsa_switch *ds)
 	struct xlnx_tsn *sw = ds->priv;
 	struct dsa_port *dp;
 
+	unregister_netdevice_notifier(&sw->nb);
 	xlnx_tsn_mdio_unregister_all(sw);
 
 	dsa_switch_for_each_user_port(dp, ds)
@@ -471,6 +700,7 @@ static const struct dsa_switch_ops xlnx_tsn_switch_ops = {
 	.get_tag_protocol	= xlnx_tsn_get_tag_protocol,
 	.setup			= xlnx_tsn_setup,
 	.teardown		= xlnx_tsn_teardown,
+	.port_set_mac_address	= xlnx_tsn_port_set_mac_address,
 	.port_stp_state_set	= xlnx_tsn_port_stp_state_set,
 	.phylink_get_caps	= xlnx_tsn_phylink_get_caps,
 };
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
index 6286caff7a1c..a228a7bebd53 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.h
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.h
@@ -7,7 +7,9 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/if_ether.h>
 #include <linux/io.h>
+#include <linux/notifier.h>
 #include <linux/types.h>
 #include <net/dsa.h>
 
@@ -16,12 +18,29 @@
 #define XLNX_TSN_PORT_MAC1	1
 #define XLNX_TSN_PORT_MAC2	2
 
+/* Unicast Frame Filter: the switch accepts an incoming frame when
+ * its destination MAC matches this 48-bit address under the 16-bit
+ * mask in the MSB register's upper half. A set mask bit acts as a
+ * wildcard for the corresponding bit of bytes 4..5.
+ */
+#define TSN_SW_MAC_LSB_OFFSET		0x0000c
+#define TSN_SW_MAC_MSB_OFFSET		0x00010
+#define TSN_SW_MAC_MSB_ADDR_MASK	GENMASK(15, 0)
+#define TSN_SW_MAC_MSB_MASK_MASK	GENMASK(31, 16)
+
+/* Mask value that covers the low nibble of byte 5, leaving a
+ * 44-bit prefix common to all switch-port MACs. Those 4 bits are
+ * filled in by the per-port MAC-nibble fields in the Switch Port
+ * State Control register below.
+ */
+#define TSN_SW_MAC_NIBBLE_WILDCARD	0x000f
+
 #define TSN_SW_STATUS_OFFSET		0x00000
 /* Poll this before changing port state. */
 #define TSN_SW_STATUS_READY		BIT(0)
 
-/* Switch Port State Control register: packs per-port STP state and
- * change-commit bits into one 32-bit word.
+/* Switch Port State Control register: packs per-port STP state,
+ * change-commit bits, and MAC-nibble fields into one 32-bit word.
  */
 #define TSN_PORT_STATE_CTRL_OFFSET	0x0004c
 
@@ -31,6 +50,12 @@
 #define MAC1_PORT_STATUS_MASK		GENMASK(11, 9)
 #define MAC2_PORT_STATUS_CHG_BIT	BIT(16)
 #define MAC2_PORT_STATUS_MASK		GENMASK(19, 17)
+#define EP_PORT_MAC_NIBBLE_MASK		GENMASK(7, 4)
+#define MAC1_PORT_MAC_NIBBLE_MASK	GENMASK(15, 12)
+#define MAC2_PORT_MAC_NIBBLE_MASK	GENMASK(23, 20)
+
+#define TSN_SW_MGMT_QUEUING_OFFSET		0x00054
+#define TSN_SW_MGMT_QUEUING_EP_SA_EGRESS	BIT(4)
 
 /* readl_poll_timeout() parameters (in microseconds): poll until
  * the port-state change-commit bit self-clears.
@@ -100,6 +125,13 @@ struct xlnx_tsn_mac {
  * @ds: DSA switch
  * @dev: backing device
  * @sw_base: switch fabric register window
+ * @conduit: DSA conduit netdev (EP MAC), used as the source of the
+ *	     shared 44-bit frame-filter prefix
+ * @mac_prefix: conduit MAC with byte 5's low nibble cleared to zero,
+ *		forming the 44-bit prefix common to all switch-port MACs
+ * @nb: netdev notifier that handles NETDEV_REGISTER on each swpN
+ *	to set its final MAC, and NETDEV_CHANGEADDR on the conduit
+ *	to refresh the shared prefix
  * @mac: per-MAC state, indexed by user-port number (index 0 unused;
  *	 MAC1 at [1], MAC2 at [2])
  */
@@ -107,6 +139,9 @@ struct xlnx_tsn {
 	struct dsa_switch ds;
 	struct device *dev;
 	void __iomem *sw_base;
+	struct net_device *conduit;
+	u8 mac_prefix[ETH_ALEN];
+	struct notifier_block nb;
 	struct xlnx_tsn_mac mac[XLNX_TSN_NUM_PORTS];
 };
 
-- 
2.34.1

