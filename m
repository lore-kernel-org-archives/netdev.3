Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8E39A4DF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477870; cv=fail; b=lFy4np/L1Vla7VUHPX/wK+7COqr81UOIeRUZES4H+JS+AEB6a2F6VGgEbAMNa8aIhcgqKWh1g5f3ietBffY317VdPpcCm+0PAnkkck1sWodSvRx71P7kv+8Jvi0qHMGbP7LZcARr/z/TLHTWq+7JlzPeXD2t+0OQ0oaPN70biRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477870; c=relaxed/simple;
	bh=r3QfEZvB+uT7OM4ODxyV87aXSLfKv5kljAE/9+sfx/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QkEotC/uwKWKbdmLER+LnLyCIpI0x1d13swPa4+2rOaI4wDnf07LucbdVdXYD/CyH1YL7Xw/BSA1mK5uyBn0pm3k3DOFs1xIjkG8qqKfTe9A0iVu6EZpBWxj4c0E9w+3dgL2NH2cXvr9lu2Y82URaplmBkWqtUcm4OTO0G9IMQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vJr7uK7s; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vJr7uK7s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ6fVsMhBLsxgtcpW7PizhJWfZ0poqC6X8wS34m53zHaqBV4QIXeapx/yBXcJ3OcC6OkL3RakKU4P1Dw8it115TC1k+quiGQBZY9/nogtqyPB9+exAE4IArOUb64bYFq40fHxYLKn+htPKqlvDA9UwS1sTCOI0esnBlUlNUvsu0u8jekBVu/YN11xSjOJsMh0/Yn0AVeIHESBYg/wXe7tQyl0kV3/YWIWUewY5hVWNvkRqtHayaPrEbvU6wQrPniO5ojUYJ+4PruAyG6x9H7alImwiW3zM4HXCtOgVpidsDOskXB+I8FO/68WA9AfD9U6w5+sABIrh3H1rZ7iJ93hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07yFiyKQBCk2LNidlWdQ0f9D1xliuxOOemta7tP5p8E=;
 b=CGh1CQcsA7knRih/ip3Ir4iyE7vQOLd1Vkx0OHWpkgTfN7/SBd/ZuyctWMsnNbsagpypa9crIuOoXE2BOo3oQoBCLggnLI3bTbMv32AmJb/3yd/oDEh1L2mhYEQE9j1w+6oJi4H9lSgNa9M/P260ONDNshUtWKbinkRO8AGn0CVM1AlTyXH1SuXCop/Qe3OFHt3GWC4fwnNixQNbkaoyBCc1QUbluRcJ+R6/QJUc9FLyn8m3CuXE8cEadnfRI5Y2+2T7en57z0Q6iLJX1Y2eqHhMmPvyrbc1lb7j4UGtjmnaoHByzHeujPGyZKaFW2VW6vQercUuJ4nadrTFdXo4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07yFiyKQBCk2LNidlWdQ0f9D1xliuxOOemta7tP5p8E=;
 b=vJr7uK7syJ2z5jdYqdCEbS/FoKdQp0sdU47G2VU3jcibm5PzGqXljWL/rMQKaSyz4hXvMOYkYOOnpNP7WM0y51nO4RuyoTJBA+NveWw+3Keye7axmm7k0fHuZd3/vdiXyQb/XvN42/vLevqPWFaX4lIoUorZeZk89dpgwpb2MNU=
Received: from MN0P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::6)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 19:51:02 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::2c) by MN0P221CA0003.outlook.office365.com
 (2603:10b6:208:52a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 19:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 19:51:00 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 14:50:59 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Prabu Thayalan <prabu.ponrajthayalan@amd.com>, "Nikhil
 P. Rao" <nikhil.rao@amd.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net 1/2] ionic: add missing dma_rmb() after the completion publish check
Date: Tue, 11 Aug 2026 12:50:38 -0700
Message-ID: <20260811195039.1315045-2-eric.joyner@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811195039.1315045-1-eric.joyner@amd.com>
References: <20260811195039.1315045-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe80cb6-79fc-40ab-5930-08def7e1deb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|56012099006|5023799004|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lFLkkyXjkGYAbrnzcgmrLYp0CLnutH0JjjcMMZIAZVaf+8KxZQF6ov3/y+ME4PeZovfE4jVxrcDZclR/vF3tGPzcM25ktyADDnYqcy7ychLPvkIaIlnsedKg/eYpmjNt5Zxhz+P4YYjUUjOZiFhGvO1ECWCuq/q75R/mn9+lNU5JAmCgo5zVKkSYbKMyXmxFfoloryGR21fjHqsB74PiDDsk+6kmWWw/TZ+8QiM5r/PjvYbiu1U1SKXNT9gdnjyAnlaGrFIXYY8q6W0WVJFoNOZV3XAtaYavvxdk0UcxBuWg7rinB0rD4pRtiJXrs9DHcJYnrI80cCHG048K+U1vhvSqg24oBbn7dDmlGH+qVHUdQlF3MVkdCKNlYKC0N1/5P5KZ0mxfYLOl9tsCo2FW0rEfUgBauhsDVMH9Kkyci/wdrhDk+9vD1Ri/1V9A8ctiMabQBj8WDjdZswm/8gTHZ7c4fckOqjb6njIkOUEoBJ35pIm+dCujyu7H4++bTpbgnxwXaNuxFsGXtVwqMUA+qXp7Wz3sE+CrnvE3YmhBE4DE550W2k7f/W9viogzqWDSATrgVpAXHZsSPFsYO5HxlMhkYu3xvOYedzP7s1hErHOfZ+Xr9FZok/BUOQpB7KvngYsmQAxtJ7DbsfCbLeq3uo0gBAt2+Z9FqGuTCr3eZF/faPNNQegPKrxDuD3eSK2HEJukANUc0Ghmai1uhWO1dw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(56012099006)(5023799004)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NDs6b4mjQAY/OjoHgssoes5nw0CaZDnJgQzzphZNlpY79+COyxy3AN7NNWjffW9bf87zoEtuft/YCS40mtC1x1aDkZYyIZUUlrkiF0u+iKSHC9jv5XnPcdz+e9ABD+AU77RYTaa6vk7ER0nCmDpCQ0KJJSxxF1aNmkF80ndesgFnRByGqqbGA6zpALd4kQEn8PYyP0Cg2nLlVgf5lhVrLYitZQpJXfiFqogPoMaBXb1gDvLYI680l+HewHYxTxI9EybDMENuRpqnhnZmKAWyLiSfdJTzi1jiI/NIDqnOk196AHZJ3Nwgu0kHqHMEtAYSmd15mO9N01Yw/wjXVVX4gglt6wsvFDJDX1n8fHRT2My2lPDQyMbrJ+j6La/5nABYs7CtKISQ88CvBCHVQ4RFg6VEzFCUGj0AIj9QJx3A0oPkXrGwZcRLna+IgVeQgtb/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 19:51:00.8551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe80cb6-79fc-40ab-5930-08def7e1deb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667

Each completion service routine tests a device-written publish flag and
then reads the rest of the descriptor with nothing ordering those loads.
A control dependency does not order loads, so a weakly ordered CPU may
satisfy the payload reads from a cache line state observed before the
flag became valid. Add the barrier to all four completion paths.

Fixes: 1d062b7b6f64 ("ionic: Add basic adminq support")
Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
Fixes: 77ceb68e29cc ("ionic: Add notifyq support")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 4 ++++
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 6e6f3ed07271..10501be9ef95 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -269,6 +269,8 @@ bool ionic_notifyq_service(struct ionic_cq *cq)
 	if ((s64)(eid - lif->last_eid) <= 0)
 		return false;
 
+	dma_rmb();
+
 	lif->last_eid = eid;
 
 	dev_dbg(lif->ionic->dev, "notifyq event:\n");
@@ -314,6 +316,8 @@ bool ionic_adminq_service(struct ionic_cq *cq)
 	if (!color_match(comp->color, cq->done_color))
 		return false;
 
+	dma_rmb();
+
 	/* check for empty queue */
 	if (q->tail_idx == q->head_idx)
 		return false;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 301ebee2fdc5..5b58460350be 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -734,6 +734,8 @@ static bool __ionic_rx_service(struct ionic_cq *cq, struct bpf_prog *xdp_prog)
 	if (!color_match(comp->pkt_type_color, cq->done_color))
 		return false;
 
+	dma_rmb();
+
 	/* check for empty queue */
 	if (q->tail_idx == q->head_idx)
 		return false;
@@ -1249,6 +1251,8 @@ static bool ionic_tx_service(struct ionic_cq *cq,
 	if (!color_match(comp->color, cq->done_color))
 		return false;
 
+	dma_rmb();
+
 	/* clean the related q entries, there could be
 	 * several q entries completed for each cq completion
 	 */
-- 
2.43.0

