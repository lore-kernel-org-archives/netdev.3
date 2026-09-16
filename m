Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BDE382F0C
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558882; cv=fail; b=leGR0prbMJ/ghn9Q9IWtjYphf3wSpfigcemdvFz0yjjLzvfBXFs1+sLeJv0eVC8lGE/uE1fzNSasIFpDBtSXLbkiBK5qdkBW7w4O9UNQ7US/n3guLMg82FPxRWZZcj3rCsfS5hvYYvq+VIFcg0Om0Tk9zZTkwzA45LFxvjDikBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558882; c=relaxed/simple;
	bh=Pgt0ZhKcR+FhpfU7WyAfXy6QJXcMRyYDVpkS3hdwCss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=arhaZef+dhJptAkPCjoaf9BZsYtaIOO+1NPzZCeWND3TkVAoK+O2ELClox3QEW3kR+hoWmGWX5xmFhGlcZ8GuzmpuWnfwxrSgmzorDyvdE8oD00klki9HLfu3DUeh3z3HJ5A3KQljesIlpOa9i8cAXVTMPRuRkJZjvYbKDGFuSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N164x4B8; arc=fail smtp.client-ip=40.93.194.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N164x4B8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCu3oKzl0CFx9fF+i5Ru06mJO7fxCzGvI4KCRgIkomA9LNAU2lu6pxYEx7l+8TNjieEFceGItSxxi6zm/U4o99s39J++FuhpVmC/PCn6vP/sxygKHIUdv5MZmFTQG7DWRCJn6gj/aKS2+6DROEAFhlhsVyWLUswhhjEaOWj5+Z0DVuCht8D0tIMoDSUL3GMbFugbyNtBirw8aQzjieGa2tGORjMLYkSVs9jbnS/KdxfhZvpwvaqz+4aBBKom8g+Fh0hCJUCaQEM6WMQsyVK/VlBE9NOn3p8/bnBw/ijq0iSZVqFVJjY01tzHJOrLO/4ZLvIQneYO222nIB9D9ILaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsgZGAwd+JJ3tW7tKOCH6RH2/Gl47Hn8u4muvv6bqWM=;
 b=FswWh0VaQu94UYPjAMcIYvsmHufuvuIzOY4ygbgn6ZZuBhm9YU3pif4hx/sH82i4L785neroW0fjb/wz8WkGuID5E2JejpinBtHlH347s4Z2CksPCigqHdcbctKT9oWA6XVpHYa/CUd8ZUasiRlgJDHwKoXaY0paFhI116oI+12J9H68dnkLptlD3nLcyw6LJmnBKd/L7izula7GG08/TeJ8vWlBIyVYSW3bA5KxK/tFF3YAblgPAkQs6jqxLJ2NKjRPC49y48KHY7GaLqAwGgQr9wGT5PTDW5nB6ewXiSPZcZWQ4ETY+Hj2+GdWPT7Vr2MyEF7kVUDPqPa1C/DQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsgZGAwd+JJ3tW7tKOCH6RH2/Gl47Hn8u4muvv6bqWM=;
 b=N164x4B8IJv3QzFmFKtXSfVlBAzhbzD4VDgpwq4csqPVgvjBPANepX0qRpgqaS/RNy3YGRxgiINxUlmUaOqo7XsiGJCoJD0S9Sd3rOlkGfese1xsk25BbZxWDyAX1JpeVnlOmq2aVBuLgy4skMNxcUHyRTX2ngMhwg1E5c2qTvc=
Received: from CH2PR18CA0007.namprd18.prod.outlook.com (2603:10b6:610:4f::17)
 by PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 11:41:11 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::1a) by CH2PR18CA0007.outlook.office365.com
 (2603:10b6:610:4f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 11:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 11:41:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 06:41:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 06:41:10 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 16 Sep 2026 06:41:09 -0500
From: <alucerop@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, Andy Moreton
	<andy.moreton@amd.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH net-next] sfc: add X4D PF support
Date: Wed, 16 Sep 2026 13:56:41 +0100
Message-ID: <20260916125641.12238-1-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|PH0PR12MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 615e3ec8-2650-4112-3abe-08df13e76800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	dE1o+gThEbvmKUzeh3rpLLZpqgj08sNvXS4wOXdJ3Pqsgdm0FOwdt+0wCaw4cdKtlv57p9P8gRPRXaML4r7C5dwGgs0YHbEo9sooroKrVaXpBIxyOC/GKMqHvCCZkKsBqPO+NJJDZv8K8FevGn91AAmmiAQ1irCA3uTOGcA7CeMcHxK1A79FmiP9TwkdxSv0Smmn2x33eyIZdCxXuDHmjg9ZERiz/TLNhz4t3kIxHJVS62tA6jODCBIZznI+6GsRcjwocMHUqs5y0+yQ4p0wIB2xrR4+g6XlbBPrQ4qp+toPzXeoKe2KRTtVrWSV6vui311X4KCfanCNh+fj1dmdIZKEOhLlxVjzmudkdsSf6MyuTnh4UVescyNOL4pjTXgbyy3Tpkfxhq7W26QD6cTgRUDKNCHptWEh8FXbh4pT4HfHblk/5xh/W1qp4zkFITCLEl9+psP8VZBbbGYsTfZC1/6gUHXmq7l4+7DdVw50iyUG8DNsvXN8DKKl0nlQ+5JrIofLl4sM/cyrcAkw3VQ2vzYrKoBZ7U393AFKOga9UCLr9+cCI6A0Wv5j5AXl5PDSUN0lqLBtFNdYI1NC36pa9f8TL0FoKjNCtIuJ3CLzWhd9jYfLHRcJo8hG2OJKXGcO7bdAonTZcBJ/oO4UCq0OI3HmmIfSKBgiTc6IKpgmG/ktzNKFKhvSyGuqT6G2EntA8tLw12YGCnjfBQ5fmtOXwA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tze6Ap7f90kyg0n9kkZ8NjNTyhUGr6gesCSf/y+/w1I6I7y4mr1F4qvnr1SpKPxglN5RY0ZsyDUfoo9aVqM6fgJBJsbOOyP4cOu+ldQyQEsaEj1vQJd7kMOVzuF3EUq8duOgcrsekm84xkB6yjDhqLWP+dwFA12dPyZtzG/g65fTjyXn69IcmhlPDMn5AY+scdOsIg/VTCGAGkwPrJmZl6XwSKsVx79WYLq4VHHUnjerTw7kjPeVidHd0tdtPA6KcExNnyb31ulFvpZzq87rV2XRplw2PiLyicrpG3aK1f+4ZCeYbW8dhm2BcI/ysAH5qlzvuJx87FdM80eFjTUDOT6yFEB3EY7yrBFuw73iOTkhfeiDxrftKDzWDK75fVf7lIZ6AZcAeJH22K2hy8swSQLcvn3BomR8j62hKMKAJvM/ObMWaZCQIzcZhlkYVMFp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 11:41:11.2572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615e3ec8-2650-4112-3abe-08df13e76800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8773

From: Andy Moreton <andy.moreton@amd.com>

X4D is an X4 controller instance as an IP block in an SoC.
It has the same feature set as X4.

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 3806cd3dd7f4..953f1d90b9b1 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -904,6 +904,10 @@ static const struct pci_device_id efx_pci_table[] = {
 	 .driver_data = (unsigned long)&efx_x4_nic_type},
 	{PCI_DEVICE(PCI_VENDOR_ID_SOLARFLARE, 0x2c03),  /* X4 PF (FF only) */
 	 .driver_data = (unsigned long)&efx_x4_nic_type},
+	{PCI_DEVICE(PCI_VENDOR_ID_SOLARFLARE, 0x8c03),  /* X4D PF (FF/LL) */
+	 .driver_data = (unsigned long)&efx_x4_nic_type},
+	{PCI_DEVICE(PCI_VENDOR_ID_SOLARFLARE, 0xac03),  /* X4D PF (FF only) */
+	 .driver_data = (unsigned long)&efx_x4_nic_type},
 	{0}			/* end of list */
 };
 
-- 
2.34.1

