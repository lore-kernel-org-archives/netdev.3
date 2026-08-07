Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280EC430306;
	Fri,  7 Aug 2026 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099580; cv=fail; b=oMnLMJm97fiqA9BgeMVKjRYJC0wWA/TlBbBLt1axDSmS3j0xsR3cnRqG8G6tw2c3TV4jCvtwYVFNddVED/bT9OzHpk48dShLMSeuo42HC315JYdfjuCQ08l+cW9wZi59UMGYvxtxD60zBLMzNWEiZAT5VXx/kofi35qDRPGkY8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099580; c=relaxed/simple;
	bh=gMWpJfSseFH+3wQQU1yhevcjSEv0nC8eq6jg94/MjKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=al8PyVna5WP/vH50Ht9JtL6VkYR3SrK0hLVtFcG7GiDLQAaprshjDvTUeuayj9wG2acT8qQNa98jLWmnn05Vvz+mT4ukSDtxNDVVb01Byt6AGijLkAkaL429+9qEuLtMdEOGQ6TUWXu77CAiPaGewf0+qmGCD1w9eXImFh1Ewzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wiYal0zc; arc=fail smtp.client-ip=40.107.209.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wiYal0zc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWI86B8JRdHCE4g8KgL6lBDOUK1W6B5l9ThoM0NEtV/Z0vQb4fv38Fw6lfefGcLnAbEAt7Sr1nqtR2N+4jVtI3Ra/jUHkJHPxPykRcHaKMRv/uPdVgnjiC0wBHvNJ7sSM2AzZNSUjx+HzgljaEm4oioQc0aE3a09VmKogZ9vWUqZYbpwg4HUcZZnUs30G0Neu8LloLcpHQlc1rOvzbYMrxAfpX0MLMR/nozgHh1GBAj1DAugN/kVggyNBYtX7wAxpvhWiSHMCDRpm7xVyEK1xv2SPcjGRAvZu5kK1doR81obHUs56j+WXE9WtE0pNi24CNQoVVcoE41chqvKHsw9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/iV3m62o/n22HBm8ytnCnDNr4sVxWvgGfyMbJKoD84=;
 b=QAJHCulcptMPd33ry0+RFKak9WCCxuRO9gHFwkF+OuH4A3VImtPx+nwbjOKGuqvkNRr9B+JmrwBcifwdrCKgzOggwEnWU00jxERKbE5ThpGhPm38c8hO2sQ+TlqsweI9YKMFqCbaLTCwIczpq+IcIhvYaRQJkP5d11Ph/6xFjHvgAJbZTtEayM8GKiD+sRrYT9vifT5YUT8Uy1YjmsA0BCxJxtot62xCmaHsj3EYpSNEjPhW5WczP8bDYoZDcS+7yWhVeRDa/RkgHEMO7a5tZXwfIcX+6EaovJ/lS6NpR0sgOJxiPC83PA6mDu/B+0rYwn2hxdSUvV0HN9NAH1CFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/iV3m62o/n22HBm8ytnCnDNr4sVxWvgGfyMbJKoD84=;
 b=wiYal0zchggyIUzAykVVIIDLGQRPHvMGNH/UsJvox+d+LrA0IW/41mGLKVShWQfidgb79YHlYkqg2IfgLZP5XXn4izYkfQXrbI2c3KcF5w/c+Tk9QnYf7ApVtsQPlQ8vJZX612eGmYPFSaIyNucjypBCDU+3tKs+Ql6fB98mVSI=
Received: from PH7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::10)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 10:46:15 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:33a:cafe::40) by PH7P222CA0027.outlook.office365.com
 (2603:10b6:510:33a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 10:46:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Fri, 7 Aug 2026 10:46:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:46:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:46:11 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:46:06 -0500
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
Subject: [PATCH 17/20] net: dsa: xilinx: opt into TX forwarding offload on bridge join
Date: Fri, 7 Aug 2026 16:14:28 +0530
Message-ID: <20260807104431.157230-18-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ebe81a-1e6a-470c-8a1e-08def4711a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|23010399003|82310400026|56012099006|18002099003|22082099003|10067099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	8shSmklXTXEfybsSsJbXGM7C2rEJuq1zXJ+rqW0FvC4NtQN8poMlU7Jc4cpRYaQjhBzuICDV1lw9BFj7HCZANFbllby7ORQ/nK+sA5aFMJ+B2U4lv1o0cwuaYuUgx8foClRLSvmw5BubUVi3ZmETmr6qqm6lIBI1AjaSnAmByM2x1WLpZ0EQW579KwdMy1mGuf4GCJNS0ehPi99asY/OkJXQlkrXxeMZaMjOA+/haVr0rkedZ8E6A8MmOwImJZ3Kp4YOQ1XJ7EPz53K05ksPx9TDsd/Ev/hDdv/7iTaa8i0ZMmZqv6L7cJVojWt9QkXZ8D2QMTCkbWBd+OsUkbI9ZeJtL8XIMQh/I0QM38nemBSkQFJkZRLGacKpR0M9mKTOKzIE2fKs+Jy51uwEN5rhuHqYvGX5Pbsqcvoy+XILdOjIfaOIRNy0eNYnTv3U2UlXYfvLyhpL/w49xSQ5sJojpASzhaoPgv1Cu9hIRDtU2+RMh+FCoZf1++Mm5jBm1Gw+k+bQx2vK4pZWNx0Vsl9CtQSAKokZ5UHL0lNckAF2eNJM9lEyoPtqJQ/zYvKWz2ocld6yF5Yc9LbvjBiZNnMPtlKQFJ5i+5hpUJ8w4TFzSoZwH1S5DXRKh8wNbgo7LZ31bGtMKN72MHL+zyj80vUqXGga26OJnpfd1lW7jBoiXr5Mp1hAJ/Pxi4vp1YY3Ujva8kzdEO9QBs/kkhNFmAp6610AdUafKAgZzLQ51tGInQ0h/V0NUtM8F7xjXxfEaweX
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(18002099003)(22082099003)(10067099003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yom7T2hiOdhzSapQ8OEx5uzHHA2WbtXulqYTKpz/Qksdqs5IdZRAqCWLwP/hGxqYRjc53qHRP4Quwn/v+caa7RmShzyT9X38YheKevsB/h7zXmSpr5eLUo1fX+0vGaPBXOn4qR4tnspL71AhpcDhkaRUIGF9ZTwTtZ5oz66C77niDv5SY+vZ5ONiu/e2sS/SE5ro/s6jCDOQVUeAileIPEpcWgw35bTqwex26Jrr7uANUTv2C2hSoqqsP6/qiQ9rBHF3drkhZZHold3SMfG/QQf0j1gLrWxSX/kGlduAY5gGNaUri+S79g9k8RzGEYshqGGAnj1cWzlwqRhUPFccEyuTPIwW+45aLJn9Hc55EBEZJMjEFyYoK3LapAKlr6CFDqiaOIVEY64Y5tS7pWY2IR24ylqUsGUEym+oSE6vnMg4namSQuCBpslDm1qkVv9q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:46:14.5895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ebe81a-1e6a-470c-8a1e-08def4711a8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481

Set *tx_fwd_offload in port_bridge_join. The bridge then sends one
copy via the offloaded TX path and the fabric handles per-port
replication.

The fabric offloads a single bridge across the user ports. Set
ds->max_num_bridges to 1 so the DSA core rejects a second bridge
instead of silently merging the ports.

Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 drivers/net/dsa/xilinx/xilinx_tsn.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
index e48c81f18d6e..9a4d4a2fb892 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.c
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.c
@@ -495,6 +495,19 @@ static int xlnx_tsn_port_set_mac_address(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int xlnx_tsn_port_bridge_join(struct dsa_switch *ds, int port,
+				     struct dsa_bridge bridge,
+				     bool *tx_fwd_offload,
+				     struct netlink_ext_ack *extack)
+{
+	/* The switch fabric replicates flooded frames per egress port
+	 * on its own, so the bridge does not need to clone-and-send.
+	 */
+	*tx_fwd_offload = true;
+
+	return 0;
+}
+
 static void xlnx_tsn_port_stp_state_set(struct dsa_switch *ds, int port,
 					u8 state)
 {
@@ -729,6 +742,7 @@ static const struct dsa_switch_ops xlnx_tsn_switch_ops = {
 	.setup			= xlnx_tsn_setup,
 	.teardown		= xlnx_tsn_teardown,
 	.port_set_mac_address	= xlnx_tsn_port_set_mac_address,
+	.port_bridge_join	= xlnx_tsn_port_bridge_join,
 	.port_stp_state_set	= xlnx_tsn_port_stp_state_set,
 	.port_hwtstamp_get	= xlnx_tsn_port_hwtstamp_get,
 	.port_hwtstamp_set	= xlnx_tsn_port_hwtstamp_set,
@@ -786,6 +800,9 @@ static int xlnx_tsn_probe(struct platform_device *pdev)
 	ds->phylink_mac_ops = &xlnx_tsn_phylink_mac_ops;
 	ds->priv = sw;
 
+	/* The fabric offloads a single bridge across the user ports. */
+	ds->max_num_bridges = 1;
+
 	platform_set_drvdata(pdev, sw);
 
 	return dsa_register_switch(ds);
-- 
2.34.1

