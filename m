Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0E2525A8E;
	Wed,  9 Sep 2026 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950203; cv=fail; b=FpjDor7zg30ltvj2INKYW3Iac1UnXg+3j7wzWT96ctb3rmL2FkcNZBi3nzLUDu8TP/oWTkL5GAxybVkDxZjbviHVqJCyjlHSkG7ToYz6zyPcdLMRD2gAUUBozMpkDhORKcNKI7+xK2KhbzDw7kTswR5vnNhFcsB0l/Y8G5L8pyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950203; c=relaxed/simple;
	bh=O3ORr5+0JXLZEPqLmfAoQ/LoqXN3s5S0WtTX84avgD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pxCAOuWqlHcXHTQ0nB5Ti/NhluhYIt5IN2L6IQJ0AD3WW1KxZEbYxeAJr6PDxWC77gDN6Z3yqvrruFLbiHa4cNJY2x5aIBXtVwIKuNpm3k0VaG4B+bT1n1GPslq2Uq8V0G7wfO5zOx9u+dq8SJddmwjll9OjjbE1w0mve5YQtyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hgvYVoVr; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hgvYVoVr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2v06nz2TIOBYhiBJUoUqfz52RmRFTuelAaeOopmFr5i4sXkTRPkYkqPlgufKZBbscms1sefhGntxQgd/YN+5bkL/z2sy5lsmpQ+zPHZuUhgGWiKExhBUZOCpuhPQ75X/yBv4SRyEhgNmikIiTGUSQ/uwiOVt5whLkRywWGwo/ypdMneHnxJ2F+sX+IeW3Nms7bv76ebzRg8y2PQS9HgUwIaLkCIKZfoWWJCYd/kGjoOFsY1NDIwbnN1ALIA1xu3XUOW3kpQNeyjoSQ+pX62Q8h3FW48fFaY+ecppP6smVh4v5+jG33OJQaB7E5mraRAQJXedAQ8skJLuoshPuZkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXZSpiFVHNek1yJ5ukn0PaAYvFvD9aT73Qcv/tFiMKg=;
 b=fWBCOontX7wwnn3xyOCfkFxfJ74nupP+kEKuB5GAFuOzswPT395RJfipIcpXJllf0TeCPLEtZ9NmQGecPEPqUTn7H5ITwvGxx06jIBX9mvdJhsU3y13BsoQyqoyvbA/6W0KcID9pFh2G+p4zEnZU1GzvVThwk1BUYXob9uUny5/iB+4CyMjG7oklZcdxl+CGuEuCV51GwFrY+Ihi3QeX2orUiyO7FCKg5yOkkpN9TorE2iJiFjiDuTdD16/AhsO77vmf3Hm/D/E/e7zLTN7k/FN4ZipsIt39uJ2am9GPV5xW4iGqyasBCTB2/ATTU2CrUgRr4Q6BCO5acHbJoqq2Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXZSpiFVHNek1yJ5ukn0PaAYvFvD9aT73Qcv/tFiMKg=;
 b=hgvYVoVrk4S3oVhYTopqv8CbiMJIywgc5U7ZuV0FGgqUElKpN4IztjN0Uu2syCg6FDDm5CHOIQhAeTBeGxcTQt+d4XOXXrFcOH8MM/DWcJr96aNh5O5lgN4B3aI8E6ZsKiUEFdve8YPeSzuX6HDpDkE5odwRsF+LqYZhnzBDHDN62Kb7F86bxk+GL8BHzEWTBGk5PzgMzF9V3Spl/kCGGsc2k65WTGj8PE7KWqMDsOsH74AZK0qrMumjXLPcknxOBJnxkBfN+BZarc9ir4pi5ObD7v9HuffIt9mG39iHcApgz8+IN7Sjv97ZNuGAxlZ8nyxJKKkrpWI7PQdaXDDzdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB8PR04MB7066.eurprd04.prod.outlook.com (2603:10a6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:36:39 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:36:39 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net-next 10/15] net: enetc: simplify and rename PSIIER enable/disable helpers
Date: Wed,  9 Sep 2026 18:07:28 +0800
Message-Id: <20260909100733.1139689-11-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB8PR04MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb33d00-c095-4bee-833a-08df0e5e3af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	g0q3WUKzTLhEWt7uZW3blNnc3CZWH6g7pusk+K2ju/wAmFrwRX6+LK6qb2IrK74aNPUvjl0JP748R2Ln/G5UhtNaaqI/cswoZA0tVSZo7PmTflk+levZyw1vzwrax+livtk9lXYCalOqnDM4oSP73QPQ5RYW+W48NeLYpK+fFeuYMmRkrd35k4ksTMuhxRRJ+pYFaiTK7zeJK5pOJYm1aof6owXb4vS3Cf71Gv/8kjp5fBVPehV0ln3kTzuzXNa/yZ3cD29TDf8FItoohP4aw1Uav5rAWsoClc9DYyggUhCi7ye0gbqAElGjQKuLCfiY8iUcKKWvez/W3ggnmcBjOY39k/zaLVokvIlAGdyXxrJtKDCtZKCxmCXEaGsL9AjCU3Bb+nw3xsd1lQRaa/Sb0tWNowyhKKfZF39PUekhsboT3fw1LmqaQm09KNMmnrZ2BKSwt0Dfy9wvSSWiiuBSkwSs96lbzz6DJZWodUjTTyAuBLmTClPWPmZJhJ2KVI+ekx12HKJa2spyAGLzfxI9enJqiYIYPDEj3SMsY71ubmbD4DnTTSzKxUV8NyAkwj/Q2PdLGjFlwAY/8YnaANHk4Sg+EA69SW3jIdyFCkBlBmSuAP8d17/nHjuyr/leQeLVqE3l4qCmROrimXWNv5YIpuoozWEaHyLiLla/HdwqQjDWkFt/J1hEOCt4A8YKgQ/cNRqnEHKMeMv3JLQGG/DFag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fTUPCDyhvELqPSNnChU7kUeD21ngtKMCs/bDGrWOPmE8ElUkn6F083dk7/BQ?=
 =?us-ascii?Q?qyd5Ki9Odgu+cDBXnqqOWTVGhFAWGpyBkJk8M4BotcI6EsLxw3Ijk8A93nuy?=
 =?us-ascii?Q?z63HhEYLFDGnwquYciR3IuNhUJNSPxWwg3SCAr0QzS9jfJE/bsYF0y9z/M2H?=
 =?us-ascii?Q?ZtTKm9alOkq1LXb/+p6/o7PfvPBN14iz49oe5iGef2nWxGktri9VbWSRoHLI?=
 =?us-ascii?Q?QeTmWKms0UFO/Upx/VGj8vziqyJkE5mbX0Clu5G1G6KCjdydA/nLKAsA6svJ?=
 =?us-ascii?Q?pVi88bbP5V3XHv2cCbqHP7kKoK/oBX1+jy2xP0tvbR2PTROsILpgVynKPuPY?=
 =?us-ascii?Q?J7E0neBbksNJI2E2AElfGLOk5OiFV7GWRdyddFzH4rXV5LxJG+jkiLUWL/wx?=
 =?us-ascii?Q?hEe6V2ePV9Av1JMgptP4E79nwrdRJUjpEzONxm8MCY6J4vJvPi9a/R/ZR8v4?=
 =?us-ascii?Q?HFP5ea0J3iJOeA2XZ/bcczFRJcIv1UL/SGOL5Xenu4m9JlIwC7kkiCJEGQzo?=
 =?us-ascii?Q?Gy0T/LdWYmo43cHlQQQztmR2sBmQ2OrBEjmN0wrhyXhcDrEzpUDqwMC8fh8f?=
 =?us-ascii?Q?8c58nW9OjdpS8lwtahg75OnJmHEkKGCmFV4I1yEJNLxd4FXv0RW4sabuOcKh?=
 =?us-ascii?Q?K44njw1585Jo75Pc7iiI8aUTGTIH3eWxA7EMy/uewCtmeIq93UUp+0E8bNSr?=
 =?us-ascii?Q?ONbGZZb6NhWa88yeVrCDqa2Ego4CG85gYnvTBGPQ9huB3IwjrxNTsDZ4599B?=
 =?us-ascii?Q?BRey8kbIdJQszPJzNVLd8kQqxWtiwf1929MdV0dlrE4iftdUfm6ejiYuydIR?=
 =?us-ascii?Q?Wt/Ni3sic6SJBcz1yhCJKfnE5r2/dDNqhd27ok9FoepYp+HVCQv1jyOgFbEh?=
 =?us-ascii?Q?ptYG087NnGvGE9aTwQ2k7fu4rQugTHcD5rM7DztmsjZL7fZzzmzPSspd84cU?=
 =?us-ascii?Q?vNu1bde78N/0Pdc453zBywUI6TEob/tDSEDOe052RqJe1ThQdF3p60N+x7uA?=
 =?us-ascii?Q?bLs8N37363ckgsbTXizUlrq6rLA8quPJNi+f1e3KhrgzYPchlt/93n6Lhutn?=
 =?us-ascii?Q?L4nQpgT+IwzJqZh/QCI4CQIgXtJlB1q1AzN9oAo3neQXG4IrJpTcWA7DwgUW?=
 =?us-ascii?Q?vsNxZGOW4IxqpOZSpUFceZkqQDK4d3+xm1LFSJC/ycU7Gl2WDajk6qidQVLq?=
 =?us-ascii?Q?0f0w+i6HmCF09MJg1b2O6QhhSvN7msTvjH5NwIr8dkJIgbOuuWv3YE8xGyw0?=
 =?us-ascii?Q?cz3YueSvwHjIL4K0nA18+cQn0daqJyU49vyQRvwdbaIIRjtjiTpsPqUBeG/V?=
 =?us-ascii?Q?mj0Bc7HHKml3BS/vG1CopuUw/rJKvt4VPPhFiNDuguW54msAE1Wcc0AErcks?=
 =?us-ascii?Q?SFs7+N/UU1bImDx2eO4mYHO63M66IsginOlhX+GH8NF9qLDSRpAEonCUSWxE?=
 =?us-ascii?Q?FHuHZkmUNUrxYJSlvF1qdIyf5nJUPEOvXvFHz+bMbzrNli3dXcviHnjAZ8g5?=
 =?us-ascii?Q?7HSvvMR9L8yMgk/KMh0kTu0jiuYhLQc+m28R3FHJoyiWO6DAOtCNXWmW2oJW?=
 =?us-ascii?Q?rI5FOrXAe5OSTdv/MXuaKle0y9NBkZ9942Q9pameL5CYzxZhLiGTIQjjfZ+b?=
 =?us-ascii?Q?wCC4ggHCTzN8cgfcV66Hxxmc/uMEr/d9p7itWDK88MG0I9qNp7uW9+tRIuJu?=
 =?us-ascii?Q?KL/sCyicg96f/TM+jttDlvBd4DqKa6WBwBdmYtqbV3FSv1ttBdS7bR5W+uZw?=
 =?us-ascii?Q?d/ruil2DypCeWgOuhTVFUgTDV2LISJI0EgjThcxTvYS3m9zElekk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb33d00-c095-4bee-833a-08df0e5e3af0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:36:38.9529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM0sZul347M4ITrqULWvDNmV1mH4zT1XQ/YR8kgyEtlm0fKcGVDfzuS12SqyyYHdPb2mHTKnUbPiUcKB4reM1kUCNjdMGblYLr8vsSGZR/3+6L4p86BpgFgMQfB5+p4H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7066

From: Wei Fang <wei.fang@nxp.com>

The PSIIER register controls two categories of interrupt sources:
message-receive (MR) interrupts, which fire when a VF sends a mailbox
message to the PSI, and VF FLR interrupts, which fire when a VF
performs a Function Level Reset.

The current helpers enetc_msg_enable_mr_int() and
enetc_msg_disable_mr_int() use a read-modify-write sequence to update
only the MR bits in PSIIER, intending to preserve any other bits that
may be set. However, VF FLR interrupt support is not yet implemented,
so PSIIER only ever holds MR interrupt bits at this point. The
read-modify-write is therefore unnecessary overhead.

Simplify enetc_disable_psiier_interrupts() to write 0 directly to
PSIIER, disabling all interrupt sources at once, and simplify
enetc_enable_psiier_interrupts() to write the MR mask directly without
reading the current register value first.

Rename both helpers from the MR-specific names to names that reflect
their true scope, i.e. managing all PSIIER interrupt sources rather
than just the MR bits. This prepares the code for a future patch that
adds VF FLR interrupt support, at which point
enetc_enable_psiier_interrupts() will be extended to also set the
corresponding FLR bits.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 30 ++++++++-----------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 22f5485e968a..aa37a0123274 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -15,23 +15,17 @@
 					    ENETC_MSG_CLASS_ID_MAC_FILTER) | \
 				 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE, (code)))
 
-static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
+static void enetc_disable_psiier_interrupts(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
-	u32 psiier;
 
-	psiier = enetc_rd(hw, ENETC_PSIIER) & ~ENETC_PSIMR_MASK(pf->num_vfs);
-
-	/* disable MR int source(s) */
-	enetc_wr(hw, ENETC_PSIIER, psiier);
+	enetc_wr(hw, ENETC_PSIIER, 0);
 }
 
-static void enetc_msg_enable_mr_int(struct enetc_pf *pf)
+static void enetc_enable_psiier_interrupts(struct enetc_pf *pf)
 {
+	u32 psiier = ENETC_PSIMR_MASK(pf->num_vfs);
 	struct enetc_hw *hw = &pf->si->hw;
-	u32 psiier;
-
-	psiier = enetc_rd(hw, ENETC_PSIIER) | ENETC_PSIMR_MASK(pf->num_vfs);
 
 	enetc_wr(hw, ENETC_PSIIER, psiier);
 }
@@ -41,7 +35,7 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 	struct enetc_si *si = (struct enetc_si *)data;
 	struct enetc_pf *pf = enetc_si_priv(si);
 
-	enetc_msg_disable_mr_int(pf);
+	enetc_disable_psiier_interrupts(pf);
 	schedule_work(&si->msg_task);
 
 	return IRQ_HANDLED;
@@ -581,7 +575,7 @@ static void enetc_msg_task(struct work_struct *work)
 	}
 
 out:
-	enetc_msg_enable_mr_int(pf);
+	enetc_enable_psiier_interrupts(pf);
 }
 
 /* Init */
@@ -656,8 +650,8 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
 	/* set one IRQ entry for PSI message receive notification (SI int) */
 	enetc_wr(&si->hw, ENETC_SIMSIVR, ENETC_SI_INT_IDX);
 
-	/* enable MR interrupts */
-	enetc_msg_enable_mr_int(pf);
+	/* enable PSIIER interrupts */
+	enetc_enable_psiier_interrupts(pf);
 
 	return 0;
 
@@ -699,16 +693,16 @@ static void enetc_msg_psi_free(struct enetc_pf *pf)
 	struct enetc_si *si = pf->si;
 	int i;
 
-	/* disable MR interrupts */
-	enetc_msg_disable_mr_int(pf);
+	/* disable PSIIER interrupts */
+	enetc_disable_psiier_interrupts(pf);
 
 	/* de-register message passing interrupt handler */
 	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
 
 	cancel_work_sync(&si->msg_task);
 
-	/* MR interrupts may be re-enabled by workqueue */
-	enetc_msg_disable_mr_int(pf);
+	/* PSIIER interrupts may be re-enabled by workqueue */
+	enetc_disable_psiier_interrupts(pf);
 
 	for (i = 0; i < pf->num_vfs; i++) {
 		enetc_msg_free_mbx(si, i);
-- 
2.34.1

