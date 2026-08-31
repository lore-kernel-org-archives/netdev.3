Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378452E068;
	Mon, 31 Aug 2026 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188941; cv=fail; b=a4JOQ7nOClLdIFwe/kWB27EIrr4nhu/A+tBFSQ/8VbTh7K6S+2VpDOQyUTp3Uja5uKXzrRPgshyryggXRVJFmUdW9t3fxhY9GIMxLI0ud5doLYeWX9RmWTkh6NbXyN3M+pO5W3xjslQqdP9lNcEPgK7qYFeMhoeYlfpUia21nGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188941; c=relaxed/simple;
	bh=hvtCyXwKAUjo3G8xxB2TQq62cZaiGVgLl0xjYiO5KRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xuh78f8zoYzl3pe8apkoaisLWwZdkgd0oI2FyimR0g+jSY0XZ1CkBciZFZH4QCKh58Tyb/aUTQkInM7j9KIQbZp+BMCNIlIBSIM0oWHZahKXzCxqjW2I7Xdvg3bw1HIfHqbtPFML716itkq2im+CGegou5wD0QhyflFs+jw2eo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DiQDXy+N; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DiQDXy+N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKeZVaN85nQsnmCXMVFCJjWAE5r5SlnOJ6XFFbxx6ZhWVnndsQVyq1wk32CwRI2SKxtA2kfzrFkxeWLmO+KGo+TMbsNgkWTTRj2twgTkKl7jJggTPp4rG6tGS003Lxx6VuV596r7amkFlBTLiMyOsolIbcsH0wdqyRi3UDymQmVcp43w7fwDoLjtP+MzhG0SspU57jBHgEuLTaGiY9WGNv85eeBfJ7zKbOP8ja2+Uc33ObiSNe+sYiwkVGc4ihljqRkyBZp/SlFOiCoBBNIFLWcInHsFLsCbIXWfx9h8anYWw1jCYPm3XwCHDKEP9kQ7WD57uN/v7IlPQaYYzQ8XQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nU3YM/BXNkpa6X8NBlT3MYByrBCoqp2orspy7P608Qk=;
 b=UKL2C6lRg5XkqvQi5HcVk/1kz5/EQwKqtq550CuiopTmalSb9hgB2ljxR1h5ZMAoVI+iQ/iz4hU+AGaLL03y/eecPnLLAAbMXAML9hvsn10lnqfzJg65K5UZXPEdOy+44Qv9L3WUSTXVugVFNpUjcaDaVwViwn7JZVshMHafJ8JS1vrKqyhXwtBfesbL3C8D73JxLu1ue9BXmqILzWJq6M5wdNWgk+zCy3QNc33oGUvmTBNhHNNpO01EqSm5DITkEtV6VO4vePemWpPGP122TWI2h9dAoxzcxlMa2zgf5I8/9h/0SVWnNJN6Q0lWx8kp0e8YqzlGcNpG+pxf3WoBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU3YM/BXNkpa6X8NBlT3MYByrBCoqp2orspy7P608Qk=;
 b=DiQDXy+NqVAt8A5zPQqEvUM7NUIPpg+hmfdvDt5Dvze0igI8vDMn6MBHGUZxYIjNPvcTXGchIrXJw9j+FNozRhQ1OPuUENgYk7zw8Teqe8kxsEHoHlglY4Y3+StSyBQbdYGlmmgryaabadxNEkU0hlXRMYWz/uJEhVf2ntJ5Eww=
Received: from SJ0PR13CA0088.namprd13.prod.outlook.com (2603:10b6:a03:2c4::33)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:08:55 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::6a) by SJ0PR13CA0088.outlook.office365.com
 (2603:10b6:a03:2c4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 15:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 15:08:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 10:08:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 10:08:39 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 10:08:35 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH net-next v3 4/6] net: xilinx: axienet: Make axienet_rmon_ranges non-static for reuse
Date: Mon, 31 Aug 2026 20:38:14 +0530
Message-ID: <20260831150816.1020883-5-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260831150816.1020883-1-suraj.gupta2@amd.com>
References: <20260831150816.1020883-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 0730f455-4557-4a22-a2e2-08df0771c5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|1800799024|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AUBBx/I3t4ylId3fhaaeiBqk4ZTYouzr20KKb57UDmyWJfGsl0kvxw27H/+ayAuCak/Bohf/n4MwRnNRBBR3RSDZ6D/FjD8Cq8QLHJYjY+FGIoL+2IPRK8xqJ0AsVwM05v3tzLlKDtt3VAv7vCdXo10RD3eslp31Gkd1Tw3BDZvcHAY+qn4W2kwU1W8azP5yu63gaiaXG1Nk/z9Zig1x4XKbiUDy2HVSR3+G39MT4R5QXD0HfqOogg8P9OuDW6hoLN+3A9F0tKXXXWIM5YQL7y9dEFKfxZUYYBHpdjs2S5pU5awfrixRqf6JbXQKIU+xr0Iqdp5q9UaugU7t2DeSRdG4DK7osBJBQuedjdk3GPflhSbCRCt56PbBAyNNv0pTirr8wOBCBilqn3tSIOzIps4cKjkdc4XLnMGGHwiy56cgBkV46faQH4aku4EGqF51YdkGhVjHCOuu5eCBO5XlzTfjO8a8GijRddb5Ru1+EwUDfT8ysuk30+8F1v6o262qgpwHjCOkKafwQh++efj6MWca1pV31bhFQYjnvAX9OtrnK0b4JGb8krfXiemyRjchr/WSDI58rQDOCAVJa4hye7rbZ340T4aGI95+TGH0P6pq5CDo5oHW1lVZ03EclGL6NCKFc64uCeMlj2sJLjVX2Iq/DeHVVmgPsEYiLE56lYM+ewERE8psgIFc2S94PwVrE6YR2XjWDV8o+z8wpwYrh4rpG8SMK0bQ0rHPCEcxz7RnHLkkr6TnMg6qGfRL1Qy1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r4OTS1G74lTwuu2CoZXYbjxvzuAg05O74ANBwKgvSAZrbIDQxX/bHNJ/d9H2iM7QTpzL3FlJakW/Y5YNvD/nD6AmUHep7+Dje2J+EEdNLGxyfAo8Ao/z1ESB+dDwI9onBlHKI/PmfPRJcHhs8KiuqKPa+vsg2RmfaswUs2USdGyhxaoXsb4DrCmNm3k/xBTjFsHcMv6N9Uu5n79qIwrbLgvn6+qyzfgx3PTZkVI49w0R4A2zdPC/qCAkW8+pUNQuU8aua3WKvcAcdvaLyfpRo7ya8pX8ToQXGW7lVMIb7W0gSxjpum38Z74AEpScnrWRZLHJ7STwoCMEx/6GJHnG7EA7eVgRwfi6OOcf0JqHKGdxGxPZ4B22DEFeDOgbQ1trz3tqhTsJIS359i1G7VzXLMZxa5stTXvzQAFZKvV9nsqn5xZ/Q+8xIdFAsTFFlkCY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:08:54.3295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0730f455-4557-4a22-a2e2-08df0771c5fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209

The RMON histogram range table axienet_rmon_ranges[] is MAC-agnostic.
Make it non-static and declare it in the shared xilinx_axienet.h so the
upcoming XXV RMON callback can reuse the same table instead of
duplicating it. Include <linux/ethtool.h> for the range element type.

No functional change intended.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h      | 4 ++++
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 295a1b835165..a1d15b4797ce 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -10,6 +10,7 @@
 #define XILINX_AXIENET_H
 
 #include <linux/dim.h>
+#include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
@@ -802,4 +803,7 @@ static inline void axienet_dma_out_addr(struct axienet_local *lp, off_t reg,
 int axienet_mdio_setup(struct axienet_local *lp);
 void axienet_mdio_teardown(struct axienet_local *lp);
 
+/* RMON histogram ranges shared by all MAC types */
+extern const struct ethtool_rmon_hist_range axienet_rmon_ranges[];
+
 #endif /* XILINX_AXI_ENET_H */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 5bffa5b9d0b4..19fe2fd81f3a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2498,7 +2498,7 @@ axienet_ethtool_get_eth_ctrl_stats(struct net_device *dev,
 	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
 }
 
-static const struct ethtool_rmon_hist_range axienet_rmon_ranges[] = {
+const struct ethtool_rmon_hist_range axienet_rmon_ranges[] = {
 	{   64,    64 },
 	{   65,   127 },
 	{  128,   255 },
-- 
2.25.1

