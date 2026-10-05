Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010025.outbound.protection.outlook.com [52.101.193.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271D424D72;
	Mon,  5 Oct 2026 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190893; cv=fail; b=URzT5GFGpzI0Z7F1caQ6Vd4iuA9XQpCZ/BQuRQxeAxT6ot95FbtCY+8ssxLfW4m2at/F4ZPCGz0FxPjhizv1if32qtEO+DPHDMtnbqUFhzpt9J/Zt3DerH9hoh1CAGn8ZfcSBiJ01R9HjNMInmcx2N1CmPfevoB/v5yTBNuV2yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190893; c=relaxed/simple;
	bh=eZmyGynWt3FiyzAFPmrphwqIWhHAHm2hzFpSbkeASlE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SB4xyThdNbXj9pRXTuNAwNKAfevzytWZhTL/mJUz2t/kliKxrxlcStbM5NtjrcbINLr+RXiIDLRK5gAVsl4TCUWCFuZ3Tg0Q7KC0UnEABNqoFeExXu5dFRQsnexJIQlw7MqYzwGvMEP6aPRA0ADPkBH8BX77u8aBptWs3GgN0lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X16g0ER2; arc=fail smtp.client-ip=52.101.193.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X16g0ER2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhW5bAfqMuLYH5o2RQjOGhKHLunKcNZYM+lJ0q7X5LBy+kemBwU+CYn5/vHaDE5xVwXL462jUrCa93lm4aoSxAlrazgImuDGYniIiI6hSYLXOOUQpEYcEAd+f07sUP6G7pSDjcIRA8qCy0bZzj43UNto0Vx1Lrqw0xWw9IZAduZVIotMGCo/Qay9vrEA1jZConnzgM3mI+3Pgt1V8YExiKYtek2CGSL0o4GNIclQw4OuX8xyYv744ODfBTaqIilq4+6Gd8/WAZ2dRsTAYIdsg5JhMkC6fWk+sAkr6nZ3vuYJB5kS+0cwOxM/G63r5uhYTCELvMfk+gftJRWLkX2Byg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM+w9dAhOqYOsdbCTWJUkHo0nJbx2ufXR/nhjZmBaGM=;
 b=ij5CzMEiP++vOWhtJYFDzheG6fm5xSBFjLjl1GZzAqgnm5a5B5F0CoplZrCouogWnWpwr/9tBljj1kSGNTwoJqwo9lMEzsvs1VRCyg1PIp0U4Nkm0zSrgUFGB/DG2gh8lH2jmkPFjp7nHJnsXClgeeVygw42MUYIU1JwhTKVxBiXIHONw0o+gUXZTna+ESncFJFNr2/AgfOL/xdFxWqPHN8WRwoO32ZyQSS5IoD9PA5HwYJazK6TquxxSgiEJ0vL4klBSbHo2u/KiNLu/INS8tlDfTiD5+EQPHoYFQw2RVHNn4L0Q7+tz3getVvKNZtOXkQ3W6QOhSnx+Z0DlCcDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM+w9dAhOqYOsdbCTWJUkHo0nJbx2ufXR/nhjZmBaGM=;
 b=X16g0ER2aJl3f/CI78TxejPbAMkuI7P1dLJYjUI7fceL/CWswaxm14RErdQRpXrUbY0k5HTZnrRBd9cGVdUdgdCY7Jyh3bFvCxMa6DawDKjTAokVtccvPzt8rW2yojPDIbZJ1ixFC8bbDFvBl4bdlmkN9/Wxra34sjG4tZK/tl8=
Received: from MN0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::32)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 5 Oct
 2026 09:01:26 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:208:52a:cafe::a9) by MN0P221CA0020.outlook.office365.com
 (2603:10b6:208:52a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 09:01:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Mon, 5 Oct 2026 09:01:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:01:10 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:01:07 -0500
From: Kusuma Vasana <kusuma.vasana@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <Kusuma.Vasana@amd.com>
CC: <git@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V4] net: axienet: Clear stale AXI DMA TX/RX status before re-enabling interrupts
Date: Mon, 5 Oct 2026 14:31:06 +0530
Message-ID: <20261005090106.1594994-1-kusuma.vasana@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: f5470441-6882-4fbc-c433-08df22bf3c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|5023799004|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	6pi8cee971pPgK5p4L2yb8/XPlkEX+5+kvznsqkSB8ETeOuHydhb3iifo0C+mmlT8ohLYwzu5gJBLETBY3zorxTo20B0bi/w1BPCFFUHhH7UlbMyaM2GD20L0FJeLHXPsRtM6WZO6MuaXucaj0lWnnn1ipSlF6mjjEPJXfRbMD0GkcJKZMtAyhsZ9Ng/DqtiDCfheE3eL2Rl9x0Xq92X6kgf024XhL4v4ooRqFAdxL42zW6oeA7dWCVXHIfkDPlxDbfH7yA+ADUf6rdyYKApMpTaShDOgubVrS/F+i9XotYC1oN9qgT0PLKnRuYfJh2J1X19upxnnC3Vw1mR47LJgLcTlwELWg+phjWhQFwLmSPSAYw2pPfPZYhnJ4h90grfhJcAP+U7YWV5l0lpMpvYkosqi+68kZiZen7WKUgUjpuNOXLUUj+ohYZPZfKHEQ6LCEmyhSV/HIJCtxobWGfVO2sZ2OO+rqYqNgcl48ZeNvVLmWs9kJ4X7EOp9J2qx+UcggrzFH1MBmChoyDIdYzSqdlhGmtcgoQ0kh/FwR58s3PJg/nHcbUwX3S2SlI0LqAZqPw8MRcfajgL8tZUSbnMyju42HqTIdiAnxl3veiVsNmpG0/tcCx9L+wXDlO54uFB8IJJiby9PodfN4Z2uMl4G1tQQdDMDMM+/zv1JxqkfskTlAGVoI6trZFaFkyWJOXb0cA7HRWysZMuJk2mlT1HTQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ceDzd5bNlIhkbbOdcLjp1QJxsPO4/IBjtDoyFR03TR9GMP/5f6biZAkyOi/BQqXhlpihYPjnCfdlnooAunFjQ8lpg+G7AwGEUeDA0k/+qkU7A9fZJWOe3ydBZXDArK1UTeQ0UwtEiz0qbBuSrRbvHYz23gJNPfkt0xz2+KHzO3lGJmbzmx1cDeRHtPWXmeKW1EsHeI9ZWzltUlLlJF0y32QiKTkGoyXV2jn73I1Mtfd9FNsc9lwFRFy1RDSdu9GnAGWlzmXtnpF4nolLnOvcovZx9Un069V0LC2k4ojRaZaYaJ7rW1SDggc9n+3Ip9ktyqcnEIM0AW3NqfCXehu2GmA9Hkd3IBa6BbkMjlXusUcZE4PD4aF+uf7b+AGIrgAXTgo2UAmq43O1hChD90z2Gz29eBfRzsalmFs5/2rvgfbhn99OSXM1FZnLJc41/CrF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:01:25.4217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5470441-6882-4fbc-c433-08df22bf3c3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998

The AXI DMA interrupt line is level-sensitive: it asserts whenever
the IOC (XAXIDMA_IRQ_IOC_MASK) or DELAY (XAXIDMA_IRQ_DELAY_MASK) bits
in the status register (XAXIDMA_TX_SR_OFFSET / XAXIDMA_RX_SR_OFFSET)
are set and their corresponding enable bits in the control register
are active.

During TX/RX, interrupts are disabled in the control register while
NAPI runs. Completions arriving in this window cause hardware to latch
IOC/DELAY into the status register regardless of the control register
mask state. After NAPI completion, re-enabling interrupts immediately
re-asserts the IRQ line due to these stale status register bits, even
when no new work is pending.

This results in a stale interrupt and redundant NAPI poll cycle with
no new work pending, causing unnecessary CPU processing.

In the initial driver, the status register was cleared after polling
all packets, which naturally consumed any status accumulated during
processing. In later versions of the driver, status register clearing
was moved to the ISR before polling begins, leaving no mechanism to
clear status bits that arrive during the NAPI poll window.

Clear the status register IOC/DELAY bits before re-enabling interrupts
and recheck the next BD to catch race-window completions. Both are
skipped on budget exhaustion. On the RX side, both are additionally
skipped on refill failure.

Signed-off-by: Kusuma Vasana <kusuma.vasana@amd.com>
---
Changes in v4:
- Read back SR after W1C so the clear is posted before the BD recheck.
- Document that poll may return @budget on that recheck.
- Drop the incorrect "leave IRQ armed" wording for RX refill failure.

Changes in v3:
- Updated the commit description.
- Restricted TX/RX status-register clear and completion recheck to the
  NAPI completion path, with RX only when refill succeeds.
- Rechecked descriptor completion after status-register clear to handle
  race-window completions.

Changes in v2:
-Added net-next prefix in the subject
-Updated the commit description

---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fcf517069d16..4d8169fc39cd 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -986,7 +986,8 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
  * @napi:	Pointer to NAPI structure.
  * @budget:	Max number of TX packets to process.
  *
- * Return: Number of TX packets processed.
+ * Return: Number of TX packets processed, or @budget to continue polling
+ * after a post-clear completion recheck.
  *
  * This function is invoked from the NAPI processing to notify the completion
  * of transmit operation. It clears fields in the corresponding Tx BDs and
@@ -1018,6 +1019,17 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 			netif_wake_queue(ndev);
 	}
 
+	/* Clear stale IOC/DELAY bits, flush the clear, and re-check for
+	 * race-window completions. Skipped on budget exhaustion.
+	 */
+	if (packets < budget) {
+		axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET,
+				  XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
+		axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
+		if (lp->tx_bd_v[lp->tx_bd_ci].status & XAXIDMA_BD_STS_COMPLETE_MASK)
+			return budget;
+	}
+
 	if (packets < budget && napi_complete_done(napi, packets)) {
 		/* Re-enable TX completion interrupts. This should
 		 * cause an immediate interrupt if any TX packets are
@@ -1204,7 +1216,8 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
  * @napi:	Pointer to NAPI structure.
  * @budget:	Max number of RX packets to process.
  *
- * Return: Number of RX packets processed.
+ * Return: Number of RX packets processed, or @budget to continue polling
+ * after a post-clear completion recheck.
  */
 static int axienet_rx_poll(struct napi_struct *napi, int budget)
 {
@@ -1301,6 +1314,18 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
 	if (tail_p)
 		axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, tail_p);
 
+	/* Clear stale IOC/DELAY bits, flush the clear, and re-check for
+	 * race-window completions. Skipped on budget exhaustion and on
+	 * refill failure (cur_p->skb == NULL).
+	 */
+	if (packets < budget && cur_p->skb) {
+		axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET,
+				  XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
+		axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
+		if (cur_p->status & XAXIDMA_BD_STS_COMPLETE_MASK)
+			return budget;
+	}
+
 	if (packets < budget && napi_complete_done(napi, packets)) {
 		if (READ_ONCE(lp->rx_dim_enabled)) {
 			struct dim_sample sample = {
-- 
2.43.0

