Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C348A8BE;
	Thu,  6 Aug 2026 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039966; cv=fail; b=GMzM6ZL6oJCrN14rKDq3bXd2BoFYOytWz3c9RlcNEobitwyaNDAIh7fmY+zcf47B9xgsWQgTZTOGxo7gK/nMCmnCiSU2rm1KVQ0vTjhGidouBSRVar72UeHnVXhcZZ5QKu2z+y2F3aMMjd0MMYJgC4D/Lz4/wcmfjqAqGgmqIT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039966; c=relaxed/simple;
	bh=hvtCyXwKAUjo3G8xxB2TQq62cZaiGVgLl0xjYiO5KRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeeGzlFXSUBb93GEnGsBJLpxOswJ9aYKIGc3i1RhsUoaPcyQdmIPn1WHbRgIJ1ElukukkW/gK/exJcNvcqPruMwNi9QijSJ04co+4sIkvHsFJLmdTZdP60DpmfBVPpYFsc7C9sis9+WLK8NCyNAiUUjRZ+9cnE4HoKMDBC3SmbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iKcofA2n; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iKcofA2n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wK8AYc5Sx0DtHw9huwWEtg01axlrVVH6EURuG3c8uxCcJJ0i+EWA01JGB1d/Whtokph3/m3EQ9d8+vXogFacCHyP9vLEcl2T2Wt1sy5bsTKGEfABfPXFZJjxr7xHO1V+vgRL2NEbS+hrWZbiuZSru0HPnN1No43mhX7QamJR/RF2Q7MNZsPj9nx8eE7V+/Xfjh3U79XgO7t4KijORXzUCqRLG1mUrPjgteKKjC9aFe1wcbo4+//DeekITsYsKkyon5GwDzt1Q5xpvJdtiFiqqlfrNYNLpSHPk6uK0zLRKr6NkIcI6XsK5kHlKz6M+QCpIHX+Rim3BJh5z0G1GJKoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nU3YM/BXNkpa6X8NBlT3MYByrBCoqp2orspy7P608Qk=;
 b=u+PAYWdLYxs4sMggfut0QdejHcXN3NTxb9VWfwYWRZzvOXs4ZbUM8BmEpTBr72ZPV0UuWaMBwABm0kMW4dL8VZ2npNzE8gDIFqCEzZwZexuq+QKJblFJinzVej0fi78/U+7yw3l5lov1q/T2MlrEAPurACr581a9eBk6VpJjun4bJc/61u5X8g3oviaU/g5QocCYypf7mh2jclTaxhmmrd6nGfxdh8HLtGnML6DchkdxKAfYBObLF3WVUOTsGo5EdwadEXE3eZrpUj/3EpLp4LCrd3ebIJLPUaZJW5h2aXxJH/J+vwAFT6ln7PJPdFZZcf4d9Ohnko4lu3Rp41I9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU3YM/BXNkpa6X8NBlT3MYByrBCoqp2orspy7P608Qk=;
 b=iKcofA2nsVAoEYFXM2UzwWVqNgghNhZea6CRRUZwLFBbZFCo6aRm8OkSW03VKm+ofCT0Tab1v9OUJ+BKIiUfAiXaWT/SV23wTSgh6mEary4NMhSr+QLPyVgN9OgLB10sVrBYtUj1wILmouJ/wzYtiKqDtY+4xL+Ztp4HOhkuHys=
Received: from CH0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:610:e7::13)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 18:12:40 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::3f) by CH0PR03CA0218.outlook.office365.com
 (2603:10b6:610:e7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.20 via Frontend Transport; Thu, 6
 Aug 2026 18:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 18:12:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 13:12:39 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 13:12:33 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Brian Masney <bmasney@redhat.com>, Stephen Boyd
	<sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<driver-core@lists.linux.dev>, Danilo Krummrich <dakr@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Russell King <linux@armlinux.org.uk>, Shuah Khan
	<skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v2 5/7] net: xilinx: axienet: Make axienet_rmon_ranges non-static for reuse
Date: Thu, 6 Aug 2026 23:41:51 +0530
Message-ID: <20260806181153.1213996-6-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806181153.1213996-1-suraj.gupta2@amd.com>
References: <20260723123838.125145-1-suraj.gupta2@amd.com>
 <20260806181153.1213996-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b613f6-cdcc-44b9-3798-08def3e64dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|921020|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9Y6wN6NP8cdyWcl6+F08TyZlfKXoxG1RalelC5HqlgU8LOWjMQRBU+6U3CQISPZI6UVIFJX+mQCa4O7kveF2ObHxOLruCfThduAnUD9hpAWjv/M4GoB7BRSnDwuk4PI1l5GpBDx7hxN/CMTgsoNTvYrrd0IyQGHjv4JhfC3Rm9FqzJC8hkZ3V49Xhk3uFLGMYH1G7i3KW+19gNZfzsUzVWRC7EDHNZ4Ohs5chtTTO6rX0W+bBuwOfl3WK1rUyFYp6D3DPsQ3TPJbZjAhTapkbnqUxW5IuVUYdmj3j+M0CVW9zO3GHYHs7PMJKtkixoWoFF98GXrsAm2xMfTlOdASsdhXKx405DHYzGhZHe7pTs0fGwbKb4CVdMgEFqfE7oRhNgy/yzub5BdMPc8InkeY21bQtvBfQY7KD4ofJAbUaTzTFsFm8t+Jq/O2PkElWovUZtqvJS/pKQjxPy7GVW5ve7OyFIe/4Qv+dktamBRsLgUC9Nmtk1EhHtYMNw94vw3ybocQIBOfwAQEXyQZ5aRDJlxpIaeCns9+/Mb3EylS/B7VsdgVdIP7vCHVx5tkfPIa6/OAcpQvSNVd8kUTbB5+l0CKhSmOffo2x9hyUZ1CjvYC7spVH5nM5xMEqTCAst5D4ojxugtxbrQ3RKrnkQHs3rAzI42nBSy1Ntzs6cr8WD6zM96bKlmYT9j3OunnUXOD6R/s4VK1SQPkdANrzQ1zJb/bQIybHJKbh75MfZl344RdKgHjgaY73qTL/uJSJm6j
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FeN2hg47TTpU1OfADrY9TUI81+HzOvSUcJifL6xdmOd9Hy5RxcG8g8Oyv11Cg4ujatFyzrekw++zpcGsnWvZB0safrr4mwq67/aMIr00fgBU3KYMHCZGi9ErL+oFKabuKQocJXQXYubGa2bbxDuiUz47qjnJHlygomq5Cx4JjYKPm8jUV2yaVZMMAHZORm9l0Rwx6szP/0PObvIKji3eIIvOH7MpHfJCATcwgIY+qRznRXLTAby6Uy/Sw0ZsPAdf+fVWHUJFd2uAKxVwiIjwA4pnblGiXoOvD1PgKAeRcpdypEP6MBqZPECETpXesN95VTZDE29T/I45UChlpo9u95x9rQxkYAWlvq6Tj1wWcuu+gjwrhcpNKHroTO3rq8kGZp2tNshpzXj3ex4NuNdFJjlGPtdPMEIS0UvCetxbAL5V4tmtR0MSFNaTaPjaDsc1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:12:40.5025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b613f6-cdcc-44b9-3798-08def3e64dc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762

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

