Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633D3D4132;
	Wed, 25 Mar 2026 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442247; cv=fail; b=RaMbuhuikaEUKD1P/HOhCoIWsNVZ2d0bq+Koc9Ec3WxURcmVi7g36hdkuTuKqRPagSiClqJWWe8sN9quNJ30Ouc+w+PtmeSYN5ZujnPYXjDnLrKukGVyBGbi27kl0G5MXpuYzcGn4l72EKNdZpdlAmfroPBaR3BBqz3FUruxboU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442247; c=relaxed/simple;
	bh=17TBLeYd6IZYd00gyp72MiKkZcV8LEzGH3cZNWAByqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMNY4lgFuXKjx9IhGQK8qrx2p3o7aPkTLm1x5kLCLmrqVbimMklugjK5UJCS7kcExw1mXd/m/10OnaEdxLxsebm7fa23nU5ugropCTWMtA3iY+ejrHTYX9w/juSYGUGd3GbOiT/BnuL7naYUFsdPIXkXKAgC4+EynJqsHHEr/+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fp7WMDUJ; arc=fail smtp.client-ip=40.93.196.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fp7WMDUJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zq9kO5hqWBV2U5GmrWhclVEtV6HU7BSiezn1GcRJ0A0JEdBORQvr66U0YN4gjLbgW2u/cUgFxz7EbqA9McnWBcTDgEOpx3foCU/u1ryeRpIOgdJxtVMyTScUe7HWkIt1QiW6gTZ0+KQihSLMayTykBT3B9nDV8joq5Hwa9rwQdL/QXsBjDlQwQbTb0dw0qXFYdz5V+neG5idGAqezZH7sJNge1bSjoHSl1dadHJcqvlXiNy9ISYSEq6tyMyuZzdoA1BPw1dLWJckEE9Jo/gUOKPaSctzSq1lKTr2rKLuOSqRkbzS0dOCX8mom1k8ZJlTsycNFpgN8oAvpUkpKQw/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bRiNRtgnqkJ67Mg8EIBLs82K4MpTNnw8rA5LlF5OMQ=;
 b=drQDILtpHc7HondGBkr3TZMyH7srV6KjQMNQDZ2U0h0H2EdMZjoK50++3Bgc02hhkvEFmbppr3jm7ICqU2Wa2VJOIE+p+qQPLGNVQJV7YvyWHBh2BHnNNxfHFwb3m/0ZV9wdaKN3S4Qh9aUeEUgobxxft/Ptyp9NH+VER+Grwqb4sdGtWp1AaC3qkfur7+xAB+tlpX/8SePRz3lxb3xkSzMjQZBIegPbvVeu3QUFOqfAD7p9JPppc+i4nqfv5uuGlCCGAc4ej1uNNJzZYA+NNTSn+E/oQZJdIqhcFso7nWAh94NjyvveMq8PKi0p9YMaZXNHUykgOjuq8eqFF28y8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bRiNRtgnqkJ67Mg8EIBLs82K4MpTNnw8rA5LlF5OMQ=;
 b=Fp7WMDUJW+9MVtFI54fpBpP8Q6A0N1eA3gDUeeEHFH42qCOl1o3lia0YeE6wf1GS8Kr5kp+2Dd4r5/2EHIZUG+2K3KbC5YV/3qPJUm3j8ic5/PoGriLRG0Lq88ymKFV/nb3Cob8wpPsQWa8+vJ121CfRH5ZF3vNJWbr9xtwJtMc=
Received: from PH8P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::26)
 by SA2PR10MB4475.namprd10.prod.outlook.com (2603:10b6:806:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Wed, 25 Mar
 2026 12:37:23 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::89) by PH8P223CA0030.outlook.office365.com
 (2603:10b6:510:2db::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 12:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 12:37:21 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:37:14 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 07:37:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 07:37:13 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PCakEZ270453;
	Wed, 25 Mar 2026 07:37:08 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <Frank.Li@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <nm@ti.com>, <ssantosh@kernel.org>,
	<horms@kernel.org>, <c-vankar@ti.com>, <mwalle@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 4/6] net: ethernet: ti: am65-cpsw-nuss: Do not set buf_type for SKB fragments
Date: Wed, 25 Mar 2026 18:08:40 +0530
Message-ID: <20260325123850.638748-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325123850.638748-1-s-vadapalli@ti.com>
References: <20260325123850.638748-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SA2PR10MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9c62b2-9204-4ead-6ec4-08de8a6b429e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zjyukiHjf72O5BY0I1mFKqDRG7ucqt3HxvYS0JHvCOveMD36rlyjM+H/02JgtsHQjVPA17Sauw/abzTJDD01xQHzsVZth4Z2b2Cnmzxx+UmftR6z9Mvu/UEjKByOUfhRDWqf5qB1XehBWpaX7Rdwo4+u2+1efihy/KcKNkj68tR3ZluCz/NRfkC4abWheyuRARmtrMDZFEm0Mqfd3COH5P+N0THiLlDpmrQYgwGNav9fnLWPHWcREV1lMKwQUL+flbgvJfKY+6K933lGPo8iG1aHVXfl/V7JmvZhD1Al3t5wr8z1nWt2QNyknPxA7FHWROrtQ0Y5djJBsubebWsn4DdMyYF8dXerQcyR/5+8gGbU418UOoAiw/wUJrSHKvcPSaO4epFCSty/sYCIOJWgcRba9umY6B+Z+gh+UFv0VHyBh31tRdkthor8ZVkejs0nUceq6pQyMXf551wL8HcVywapdcKHm/W5UJwV3tPZ9N7pMIRKKaDwe/N8iJCzk0Umo+/Ci3FulRS2jKWpZoV0xUeQMjW4ehcJB6syDNfgQOip0+uMRkVp691SWOIaOyHsrjfPdJ2B++mlC+LDR5zst+xscwGQ5RiyQBqblanHGWU98y2ebVIusfAZRdPmlr5SsPPXBRNxCUHHHJoEhtXvTbc/rSyu2oyHZfLv7N3EJJTFmtGCYsYSwePpexdNfs7C8StLrbQNj/CuRpCO1ACNQXaWIFx4F8zMtO4NI/FK0tWwUpYzvf8CcJQtdE7bavf/PgZVllWW/GzGjgM3dzdM4DVmwZ2wD6i7UycKuF7CPnT6pjAEg6y9nuQXlx/3gqu6
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hgq0etyJ6qn9Sp++C+F9TIsel5Ks+73BBvijN3OtHA1duWNuna8oKZr7Xc1TMQDNMnvXkpwuz0PhHvbMgKohb0kb37xs0imvqhGAce/DlcuUG4UfiVySaMDKRbPoSXJeCtTYyLtgQ+YsrXv+oP9hASMEUrPWu5gq7Ix02RfjCmh7T4qT7NtR8VevNy2BjgzLzVMRsckpf0mZ+b7kZ4GuDGqqGWrCH8rYV+xmhPWL0vVsMOXVvOpTiWthXKSKulapxnlT4AwuuM+3h0HX9iuyaG51vOG9mTYPrQYrV9idWXnSymcS8XP4HKmuD08a+C3UJhigs/MVCgCjY58VqJijNGyYzJq3JL9dU09dn1fEdf7Svl9h7u84pO3NNqUVX4yHqrqJbKomA7755HNE6fdMEaWwxrqXGvVjwAiSMYzwZ7yjCrNgazwlOvELvMDpKn0z
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:37:21.6273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9c62b2-9204-4ead-6ec4-08de8a6b429e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4475

There are two kinds of descriptors:
1. Host Packet Descriptor
2. Host Buffer Descriptor

Unfragmented SKBs are always associated with a single Host Packet
Descriptor. Fragmented SKBs on the other hand have the Start-of-Packet
SKB associated with a single Host Packet Descriptor and the remaining
fragments are associated with a Host Buffer Descriptor. A single Host
Packet Descriptor is linked to a chain of Host Buffer Descriptors for
fragmented SKBs with as many Host Buffer Descriptors as the number of
SKB fragments.

Since packet completion handling only uses the buffer type of the Host
Packet Descriptor, setting the buffer type of the linked Host Buffer
Descriptors is an unnecessary operation which wastes CPU cycles per SKB
fragment.

Hence, do not set buffer type for SKB fragments.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index d9400599e80a..6df6cb52d952 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1678,9 +1678,6 @@ static netdev_tx_t am65_cpsw_nuss_ndo_slave_xmit(struct sk_buff *skb,
 			goto busy_free_descs;
 		}
 
-		am65_cpsw_nuss_set_buf_type(tx_chn, next_desc,
-					    AM65_CPSW_TX_BUF_TYPE_SKB);
-
 		buf_dma = skb_frag_dma_map(tx_chn->dma_dev, frag, 0, frag_size,
 					   DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(tx_chn->dma_dev, buf_dma))) {
-- 
2.51.1

