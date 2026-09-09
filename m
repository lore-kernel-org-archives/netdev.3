Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228565964E0;
	Wed,  9 Sep 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963706; cv=fail; b=s7AIIWDZboEa3iLNopYzr/zB+72uP+2dWP+VAqWVnvQvoU2QJ/j50c8XKMVA1OfVnBVzjicuZD+Ey74QZLmaWRF8zzHNJqM7npQN8IAZ9xvxR16T4NWHkIcjvY6wb5pdl61zqjx//EwSb4GpWZ+rnfd0h0X8m35H9xS0bEeWBsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963706; c=relaxed/simple;
	bh=n/Emb784ujvTbfD5TJTYVWkQz17F79Dg01+7Csb97+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haBTgA7UrFvFu1XAWX6vy0x+0Wrad0OIIBSbRuVNLjJt8SnMvOdi6dvS7C+j8bheAZTb+MGNTRknXiXv3fwk0Uj8AErwVlIzf+mHb+H8KNYVbXf3eMFAg4x+x1uZg+07lPc2JQApZJrLNCAn6LbSFPz24Wo8sXHU6ibenDEXwpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3tH6VCoL; arc=fail smtp.client-ip=40.93.194.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3tH6VCoL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NM/8y4VaxHA3NFJNcfB0HkFrDN8V29zUFxIEvtLSiQh6FJ7sDAQ7ED1qRoXFG7JsgMEfy8Gsl07lLb7b9Yvo5SSK0wfzudn60+W8fNYy0m8iA4aoGui2pVHEqqLQ4MPN1/hdskCACv3R92cOOpOurM0rq9E0j+ND7GRAtSPxRN20uxyut5JcV3Ck4WffGnnpVgEcM65XS6j+AsMFZs5UJCJmMLRDF4jAthsH+Oh4bMO1oNvum+s+v3fAevAILR85L22W6V2/S5uZIBEl2sKw+S16RKedbklX/4n7FddM8idqCmXUUJoaxfxPwjvCGHExqBk1bBT9Zu29Hfm3KoE9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E/kv/H5ufDQ85jNTsAkh48mf3JkECJWRHkbqHnSx7k=;
 b=BxmrBMt7+l9QP/3bpvYR26raLC/ArQc8EiTKySLRx/gP1wP4FavjXpbt1wm0QQ4pw7g8w3mI0JLzwpDs0M/59mu9R1ReGDOnSWsrljkO7UujpfNq3Qm7kFGH8PWUKv6sNJnr/LA6qhELzL1daERWvWSRCF9LlYy0VanfRTFQCCHbY7zWnvUFs07E3+KhqYwvic2EEF0jEGFm6vGlfGQBYIVF08bcdUyH3McT6fjZLLQFAqiBnnOXvKa/9G1f3flgMHCZ8eRYxC6qWQj3ZpHKmt07I/v5X3QMlFDHzER2eSwjEpPo8NVtTL49n737EK/JI8c0z4yGhsOvD8W9d9aNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E/kv/H5ufDQ85jNTsAkh48mf3JkECJWRHkbqHnSx7k=;
 b=3tH6VCoL+TIRG597GiItf6rQFKaMRpKSlKmUcOIpxM2BTiSGNijm4kIqFyVENQVUOHdmolIJJ9Q58DAhKS1dAK+uNnU9do8i8i/t/5Uq2eq+ogkg20Br+ToJHVjeABy8ZXj4vSmt7fWP9zOPQbWsADt/FxM7sFXvtlyrp/pCL8o=
Received: from SJ0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:a03:33e::11)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 14:21:37 +0000
Received: from SJ1PEPF000037BB.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::7b) by SJ0PR03CA0036.outlook.office365.com
 (2603:10b6:a03:33e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Wed, 9
 Sep 2026 14:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037BB.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 14:21:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 09:21:09 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 09:21:07 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 3/4] net: macb: Add MQPRIO qdisc hardware offload support
Date: Wed, 9 Sep 2026 19:50:55 +0530
Message-ID: <20260909142056.1433875-4-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
References: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037BB:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 8022ee94-0084-4807-2ba4-08df0e7da824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|10067099003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fF6VSyTVdEQg1BLXVJRvsCxJN43c57RiE3CacYuVU+a9ss/D7owTnBJuYmyAOmHyKzUXGmGH/Ip5Ct1jSfls+bNd3Ia4CKUaPe991GXCkMduwcdJ17uBuRAMAo9tdVrZFj+/yIZSL7n4l0zPZYpKj2JwTUVSPMOUBgWIh6zXv2E3vXnWnx98FaVcLoEA9s896oAikZz67FaewUu5gGPeb30MAfQx8wfEoW0tfz0p4aTXu2R1D9hhRS+2NiMkUD9ihgOUyTFEXS0lPt3jVUgBXWSTpW2Wrgv5LrUUMMJ0+tz5PJjyXaTD5JhExC+COAP2VV/qbFGTR35AgOQP1lZcfwzAE/epacEeYNKTzXh2HBiGTFEEpereB7nnXm4JdrUTOQNGCoXpSO75XJpTXJtI+mlTkoLCpeFwaRneIDs6PQkYDaaudIdyd5QRy75HhI2vCIhBTjoJDb8kXN3JF6xBg+LNd7lyC+bnEq2ganYcjdHjA/BjV33e3p96ea7bnkDFeXs6ODItpS3OTZ4x9Lf3LRHfGSZSjFzhs8R4Wz2Cgd1K63otvgvyBEpsyI0RYbfPS7m5UARL990ILZHwFKekEmWqBonRtcAcxXv3hSoXLl79FWlXtDvC7LSH+lc8wlr3nlOwKa8F/I3hbiXPQOOuMSvix9PJnEk5wsewGH9AiOUj2tes5og0CZUjVlsiqZ6XULBAkdvKZzWGj6kqv6JKqg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ulmo0QQzeSAdbHweQgUaNmWZr6oYcTSusDAp6IVulAbQfDH0aRvwXe0yv/1m9E5kj3T2Fa4yI1eB9qD6NuguvCz1V0ribUUrtaHleg5zSzkR9zUc1sfBxyKQyxphSMwJhU7DGnipmOZrAT0txgcxxBPhvMUwgGvdyvyNIwFdym5gENEk4bRSk/UlbP5WFSejDAzbNhjN6Vo8vP9RvTJRzTGOcBNHdVeIku1jFxhrS49VgOuTGaRSt/jL5WtEYFB1F/Zk0SEszVhT3+vMeWM9cr8Dkai4+cjqozYgczKSgY9w+0hhha2ITnYymo5ADqa1PFni/xyvJDo3PouDTLKTbmvcnEknTWgJauuFt0ELrWQQ5CW/yUUnMZZiJNuuthC4FV25Xw3WRqolDiCtZlEWOt5P8wah0EPk42a8ZIyj+QOtv0uf57K32+9eSzvq52Id
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:21:36.3276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8022ee94-0084-4807-2ba4-08df0e7da824
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977

Add support for TC_SETUP_QDISC_MQPRIO hardware offload, allowing
traffic class to queue mapping via the mqprio qdisc.

Implement macb_setup_mqprio() which configures TC-to-queue mappings
through netdev_set_num_tc() and netdev_set_tc_queue(), and resets
them when num_tc is zero. The driver advertises TC_MQPRIO_HW_OFFLOAD_TCS
offload level.

Add macb_tc_query_caps() to report mqprio capabilities. Setting
validate_queue_counts to true delegates queue count and overlap
validation to the mqprio core via mqprio_validate_queue_counts(),
avoiding redundant checks in the driver.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
Changes in v2:
- No functional change; rebased on net-next, which renamed the
  struct net_device pointer to "netdev" (was "dev"/"ndev").

 drivers/net/ethernet/cadence/macb_main.c | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ff7e02d3fab8..67150ff03066 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4492,6 +4492,60 @@ static int macb_setup_taprio(struct net_device *netdev,
 	return err;
 }
 
+static int macb_setup_mqprio(struct net_device *netdev,
+			     struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	u8 num_tc = qopt->num_tc;
+	int err;
+	u8 i;
+
+	/* Handle reset case early */
+	if (!num_tc) {
+		netdev_reset_tc(netdev);
+		return 0;
+	}
+
+	/* Configure traffic classes */
+	qopt->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
+
+	err = netdev_set_num_tc(netdev, num_tc);
+	if (err)
+		return err;
+
+	for (i = 0; i < num_tc; i++) {
+		err = netdev_set_tc_queue(netdev, i, qopt->count[i],
+					  qopt->offset[i]);
+		if (err)
+			goto err_reset_tc;
+
+		netdev_dbg(netdev, "MQPRIO: TC%d -> queue %u (count=%u)\n",
+			   i, qopt->offset[i], qopt->count[i]);
+	}
+
+	return 0;
+
+err_reset_tc:
+	netdev_reset_tc(netdev);
+	return err;
+}
+
+static int macb_tc_query_caps(struct net_device *netdev,
+			      struct tc_query_caps_base *base)
+{
+	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+
+		return 0;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int macb_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			 void *type_data)
 {
@@ -4500,6 +4554,9 @@ static int macb_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 	if (!netdev || !type_data)
 		return -EINVAL;
 
+	if (type == TC_QUERY_CAPS)
+		return macb_tc_query_caps(netdev, type_data);
+
 	bp = netdev_priv(netdev);
 
 	if (unlikely(!(netdev->hw_features & NETIF_F_HW_TC)))
@@ -4512,6 +4569,8 @@ static int macb_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 	}
 
 	switch (type) {
+	case TC_SETUP_QDISC_MQPRIO:
+		return macb_setup_mqprio(netdev, type_data);
 	case TC_SETUP_QDISC_TAPRIO:
 		return macb_setup_taprio(netdev, type_data);
 	default:
-- 
2.43.0

