Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF73E63A4;
	Fri,  7 Aug 2026 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096238; cv=fail; b=HtFa+LKN1nM0HHODZElvJS/QIieO9qEz+thZUAes276g7NNriOSpDw/1uXIJoQUPAN9ytD35WoOdbBatQXPOztKT6Amn7uwUvKNyrrkYmTTYTzjHUVQvig1cGJwe9SlqyNldy8LbMohhVGwyEraLm5s8dRYQj7G0CiJSY4Gd6N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096238; c=relaxed/simple;
	bh=4Bws6HnIDlgC+E31lqedBS8jcW55xbuUPuWvTei5TpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ilti4D+GSIjRg8qk4whT8MR5g8Lqy4Pma5DtyJqe13DxqP8vfkvZUxB8e4erXWzFv1fkn0Wm1OuMoVCfoI328N+FaTwG/bDmYhyD49kvmfXG4q6jwA+6lq5ywHtGI/SSh7GRIiBIlWRXIaNQt2+5oDxBC/p1K+dKr2GeywxdyyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wqo/8h5O; arc=fail smtp.client-ip=52.101.85.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wqo/8h5O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaUZLs8YcXexm+I/NaRDeTKsZBTINpd/csHcSeH+1Pru5CGE36+0U+7oR3Av7scmPUAHRoPsWmslj9K9PoP8IoclFO4D1sdio3U6GwWNdHvOiqEpFF7daARgJT3/KzuXockCIMhyamRpgjW66esYNEQiO7F+n5x/Drk+fUsxgwuwy4OPuKoGZOCkazBqUXZMq4xg+QGWgamGRgbS845pEBgqmR1T1RErQnVkT2fGvGXTEo3ieGNJ2Z92bA64jQkK76c1CN0uGE3g/C3QnCCH/GT5inmtp24kypfQhIZAtkBdWewx4MQlHs8ojE4VKhLcWo/S1wkKTmVdVzZQwzFp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBDfLn4ZfX8bCFrdM375szH+rT5KMoaYpRTRK4BXkF4=;
 b=ktkEgvnx9Lzz1pVyhDSfC4mxtXIZUFog7InJ6jRDolh5DfKHNN/qh59vYS4OMYIeaKEgqz8d+Trc4fl1AQVRkW6mcmFj4x//Mgpp92g2MS5vu3ZVCE8XL7plT77MByzNfSffKf/cGVcx1jUnNxMzSnrDTr6GUKFX7iz21D8AY8USx/e7X94ZHfXN42+XZecT0izgkqWLck4jrNJyU2UqJlVV6O1kWhb0z5oiN1ky5ViP5dE1kWEisvwpYQh7A+LGNhQYA4GiGkY66virbNgmKGTy1afjwE04suY1oTGYottR6rfqU7W2mnDzVaqy1j9wo+nnv7tMZo+9lDipDLj3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBDfLn4ZfX8bCFrdM375szH+rT5KMoaYpRTRK4BXkF4=;
 b=Wqo/8h5OGP4RG+qIlaqwFnSVh8y1eNhTdYMjknMJ8n0DO05KFqpWxNc3oXpdQjhDm4UdWXwH3gIxi4lu1oizM8Ob3IPqyhPkwZ0Lpo6DHpP9SueZUp8U7K3jvibiEGgG9NROSLOHByitrtwAu+WskgNJNQq3zr+IJ/1h0ZIfrKQ=
Received: from IA1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::9)
 by LV9PR12MB9781.namprd12.prod.outlook.com (2603:10b6:408:2f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 09:50:32 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:464:cafe::45) by IA1P220CA0018.outlook.office365.com
 (2603:10b6:208:464::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 09:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 09:50:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 04:50:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 04:50:26 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 04:50:23 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/4] net: macb: Add MQPRIO qdisc hardware offload support
Date: Fri, 7 Aug 2026 15:20:11 +0530
Message-ID: <20260807095012.640223-4-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
References: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|LV9PR12MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e85c64-2823-4550-b893-08def469525d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+0rNEXrXBUKbdDE3iHaGAQo6Yd+fks51qUErC7z/E4p1iqC6kXeYw90ZWOvaLBQtTWJ3WzsCkkzLhTywmRO0U3rq3RdMYQOqYFwzsMF8akozkLXvr+hfGldM2elBSRm9NQkTfb1kGI2pl5u9SEXAqyBgeK2PuBajdCcnezDWWiSGvpQH/ULgvu3Jt8CfTir6RhDCVyYZbplPTWw4TyDY0Zb7pE95EZTsXBliuxOIKLmJNPU8odI2RxllPWB2iHjo5g34SE5FXPxB7j41Jncfm+PmFbkJEIjixJdL8+/neugncMC6I0Kup7ffKDuXD8adFph4fQhRerzxOFNwTvniZ0InQjFCN3pcZXYWPRZhBhunVGOC8VcpoEtUaFV/PpyFFFeFFsQqWoWrBszlHg7nXLvUTosSRmPz6HAKiRfRhhx4fm9qT33TQtxU8F4VaGnPyLWzp7elIJgxaEdvEMuYhgXKsDLzF2l/GFH5CGpbW+n64K+9TWGqV4oJ+8PvyQA1gpa8tYjrKaMfq0Scre1d3NHC4pP6sj81MEv3ilgba7vMn93kuOY5kYbM8L3wOb7vgJYy7SkwHc9STvjwFLCpxj33HngCCpSr/aUxltnRwrNX4HM1dN87pPPoFR+fu4+qLU9vLw6lRfbVrzBp7pWVaJ6T1CobcVIVNj3HoNka1P5FbCb9uVhlUcd2Dbb7X4rbP7+bvNgfOfHr9i8R0tU1TQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o9lMCuUICL02Y1taiDV0VGo+YMiOlF7y+jGtLDxQgE+lfruI4miX6TXuGDyIn2FYU4shKr5PgVSzJc3Ic8kFFplRgZxQPaC2eVJPhwjJOEXx1bs/Tz8R06Tyt79/TAFauNhAhs7efIhIXD2f3H73zckV9FP1wLvbr8PtLScfFJrDZORAIWTm5KORQ3AfZIWN7iyfmtbpnGGyb/IkRTHIssdLf2F7n0gUvpDe53WuZK6F8Qt9x3fB2/vZbVFnSnrsNZH+udOuZ/pXc2/q8MJ26M/Kz4yWs37Y/PGnFirsVkTx11Oki8fpX7dHm+VGyU8AnVJvJJXA2jLvd0ApGmYDow1kmLUadwYJ9VHCq30uGe7BGfnuM8tt+taPnwvUlvTPMBxePNYWjn3uO6W8EsUxrhrPJCK94qbwK2mZS9sbvYUwztURHcScdg2W7NO0fi11
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 09:50:32.3379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e85c64-2823-4550-b893-08def469525d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9781

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
 drivers/net/ethernet/cadence/macb_main.c | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 508d952e2ae7..00355cc4b434 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4515,6 +4515,60 @@ static int macb_setup_taprio(struct net_device *ndev,
 	return err;
 }
 
+static int macb_setup_mqprio(struct net_device *ndev,
+			     struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	u8 num_tc = qopt->num_tc;
+	int err;
+	u8 i;
+
+	/* Handle reset case early */
+	if (!num_tc) {
+		netdev_reset_tc(ndev);
+		return 0;
+	}
+
+	/* Configure traffic classes */
+	qopt->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
+
+	err = netdev_set_num_tc(ndev, num_tc);
+	if (err)
+		return err;
+
+	for (i = 0; i < num_tc; i++) {
+		err = netdev_set_tc_queue(ndev, i, qopt->count[i],
+					  qopt->offset[i]);
+		if (err)
+			goto err_reset_tc;
+
+		netdev_dbg(ndev, "MQPRIO: TC%d -> queue %u (count=%u)\n",
+			   i, qopt->offset[i], qopt->count[i]);
+	}
+
+	return 0;
+
+err_reset_tc:
+	netdev_reset_tc(ndev);
+	return err;
+}
+
+static int macb_tc_query_caps(struct net_device *dev,
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
 static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type,
 			 void *type_data)
 {
@@ -4523,6 +4577,9 @@ static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	if (!dev || !type_data)
 		return -EINVAL;
 
+	if (type == TC_QUERY_CAPS)
+		return macb_tc_query_caps(dev, type_data);
+
 	bp = netdev_priv(dev);
 
 	if (unlikely(!(dev->hw_features & NETIF_F_HW_TC)))
@@ -4535,6 +4592,8 @@ static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	}
 
 	switch (type) {
+	case TC_SETUP_QDISC_MQPRIO:
+		return macb_setup_mqprio(dev, type_data);
 	case TC_SETUP_QDISC_TAPRIO:
 		return macb_setup_taprio(dev, type_data);
 	default:
-- 
2.44.4

