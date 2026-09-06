Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27825331EB9;
	Sun,  6 Sep 2026 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788708775; cv=fail; b=F7lAM7BYWfvzCX2d5oeLocmFbnxEw7hdf55k72zjUHc/Ou6lgNKidT40xQuT6uSPgEjxv8znesBSrpwno96m2MOtut0+sdWZhjSGWUqq1SfphNx+s4POoJNWxLI1gVAP04cQ+lR/cDZr+8NLzPLcQaUm7+5XDYYpvV+9dlwe0Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788708775; c=relaxed/simple;
	bh=PnODsNWDyzyiwg5vvFQ+w+OUXTrJap8xcnz7WCwsM68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e7yEMvi4+CWFmxhNWSmjuXR+XgSwoxqAxSsErYEUCvTsyGDNmFIEWl8PZfmDM+mwECybGWgZ8LP3UkYt4PErDDecSqQsHHSngu+sWiK+urd52mDE9uJ8E6S/IWk6xjZDn7pxo4/GVbyI8iUvJhXnimmAXozjsyJUzhi6l5l4XzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zxB9u+6n; arc=fail smtp.client-ip=40.93.196.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zxB9u+6n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYU5nWxO2ASXQBPiO+7iQVG7JAO2//3Nf1FIp60yBnKHQlj2zBpKDFuRBj5yVark9OTXgR6PxNxmI3wziwmZ9k6MtF2oix4iwrpoK+0/ULuL8uO7MOJDv0V1Hzx5E8MX6iKmvU6n2Xm+CZ6fQL64cJEcrG+xwkgSaOLsk5L5TzHEQLEewqlH3fl98lgGk/DPt/687Hcz0UQP5IMKRB6a4gNyGK4D4k0qBrJ4NWqhi7/sjS3hqUHLh44MRfN4vdKj5/puXL4Z/6xnSp4TMnQVMeAX/gssepFOmefxIs0A3dBh3tvq55w2xaA5IF6376Q5ePGpH1bLkOAN+iJvIjBdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2kym+OYk5U5tlDcWQAPSS3U4RWUcvfHHUMVoM6f4eI=;
 b=wdesCzRH5aOe4Wt2AKhqtFNlIDF0KXfsxuOe11yjssAaDcIDn4eCoGLPLs3fBcS8Num+E6yCVezqjo9lUyNfMM6GWhkAcD3o5Zow8ckoTkOnIwcpEFfPhhPLvxdbJdb78NKib+oeaPyoNPGKy7PyHloXJYmPIihEOInu3V1Q7aYTE0gM28t7wHi7B9IBBOOEqOGihFqV0VF379Syi38IZXeHRdfbGfIbyXYljHt44id/4tzlsm/8N/OTjdO4NTsBAI1QyZMQAKigb6jZ8E12fF7P0OD9/4to6aA2y/EZJGely1/wf+ipG4fKJbpK5uMGdhFonrLuQNCMONuAaw4rlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2kym+OYk5U5tlDcWQAPSS3U4RWUcvfHHUMVoM6f4eI=;
 b=zxB9u+6nrxCA0QMYUPP9BKcvCQK72aieaLhg5BLChy4ufa/kRyrvQNRlDt2PW58xR0vrPD/SNFISfelRNfTIC+diOGuogutBKHVu3hHJSl5iJG8piLUoKGX9G7gpR4oX5NqicBSIl/zRp2++5ricPcl1Xb23VqdrwwC5PjxuxMk=
Received: from MN0P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::17)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sun, 6 Sep
 2026 15:32:49 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::3c) by MN0P223CA0028.outlook.office365.com
 (2603:10b6:208:52b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Sun, 6
 Sep 2026 15:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sun, 6 Sep 2026 15:32:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 10:32:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 10:32:47 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 10:32:44 -0500
From: Kusuma Vasana <kusuma.vasana@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <Kusuma.Vasana@amd.com>
CC: <git@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V3] net: axienet: Clear stale AXI DMA TX/RX status before re-enabling interrupts
Date: Sun, 6 Sep 2026 21:02:43 +0530
Message-ID: <20260906153243.1903501-1-kusuma.vasana@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad76a51-eda6-4612-8695-08df0c2c1bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	rrUZ2QAIWjw73mh6H9x6/24wALSSfKvwE6C1Wfc/RTR/WWSiTuZv/QPBS6PDK91WwbCOLEBaCsYtU6vptxIXMuzR64N3xiB0B2rk6UuF7bTepyoeNCj0zbcKuXouUkYCokej7y1cOVwxmeHCcX+C3PVJp2OU4aoClK4qgD0/Q1LmreIAX+piCH5HCLAMM9j1YQMx0qT8ezwvxUT16f4fAI15ht2NRy5KZuEOidmghrC8NqDjG9tu/SWIPG6gZvaDInAQ20acEdEQnjqbDTnQQyDaQYVLWgPVVn8xDCqHHSIThYCNcDPCb/z742QIVCHQ89/N69vxGuMbD6Jsc95keuFDKl1hiNYyBNZPX8eYBgakHHALJY7M3Lavx+uN3r1ICMsNjC9HOvUcdvrhNx8DyB6u3ygD8Om5hmD9tpOhWIkPhiwjiGzkqElHXZNxhiFW9ExRgqBeFjAJe511wX9d7dRPXuu+6U/AhzmybRXh7oZFyDo57vwe1a1zrZKTaeuMs7C1hVQNQ7/sihiRgwcKLr0cNV4srhg0ezgfzh+ibsomhj7ZRAy1X7/D6SL0QvtIleyBiY+mvvxKeiOiEYGMoSZ3UieoeOGbvX7iL/CCvxzshQUlzjKv+IvtFBwBl0VCSqelkZNOYNA/rDKgP2egtnDpJU1b+OMi0rKLKR5Rci4IgsKLN+FkI+MlYafXaryt7BYkQ4bE4XLWj/zjXfRYUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CRI/0uQBy6DsCBGLczBqIoZyH177GOwQjlFygfjBvMTLPDK4UaWpfskkhzN+B873gRdGY9J5gkYiwn2ktm70a7fKh2Onq8p8BJjgXw7ANZwL4aRI3Xf7YYtxaY+ejvcxfxdpoR6rOUJ+gcL/s0ngQBbUiqJiWtvLHSB+y/bd92RPzJUQRl9AOzRshmYX8OHcrej7xbEF3OwytIbsXKCySOnB5HSHejDwV9cADrXYpSTsBfRikY0vpSTQSvGP6AlubXtk3KNkPqzWnveUBjyzsbJ7S9uNB4SSiLbBOlzGzn+xIQ8eeUKVR6u6aT9pXh+cIhOrO1MNIeOt9WTai8fqgwl/wHwWpK9YdhXrnu3XE3No/sXs4a0qWnjZw7oyAmBSZeII0neVIl+jHmKbrzuX/Q9yG6CyOYrrATjYGibZ+3jbfqgWTAOj7n2bq5htLyIH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 15:32:49.1792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad76a51-eda6-4612-8695-08df0c2c1bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169

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
skipped on refill failure to leave the level-sensitive IRQ armed so the
poll is rescheduled on the next hardware completion.

Signed-off-by: Kusuma Vasana <kusuma.vasana@amd.com>
---
Targeting net-next with no Fixes tag: the extra poll cycle is a
performance inefficiency, not a functional defect.

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
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fcf517069d16..4816870e8502 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1018,6 +1018,16 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 			netif_wake_queue(ndev);
 	}
 
+	/* Clear stale IOC/DELAY bits and re-check for race-window completions.
+	 * Skipped on budget exhaustion.
+	 */
+	if (packets < budget) {
+		axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET,
+				  XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
+		if (lp->tx_bd_v[lp->tx_bd_ci].status & XAXIDMA_BD_STS_COMPLETE_MASK)
+			return budget;
+	}
+
 	if (packets < budget && napi_complete_done(napi, packets)) {
 		/* Re-enable TX completion interrupts. This should
 		 * cause an immediate interrupt if any TX packets are
@@ -1301,6 +1311,18 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
 	if (tail_p)
 		axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, tail_p);
 
+	/* Clear stale IOC/DELAY bits and re-check for race-window completions.
+	 * Skipped on budget exhaustion and on refill failure (cur_p->skb ==
+	 * NULL) to leave the level-sensitive IRQ armed so the poll is
+	 * rescheduled on the next hardware completion.
+	 */
+	if (packets < budget && cur_p->skb) {
+		axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET,
+				  XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
+		if (cur_p->status & XAXIDMA_BD_STS_COMPLETE_MASK)
+			return budget;
+	}
+
 	if (packets < budget && napi_complete_done(napi, packets)) {
 		if (READ_ONCE(lp->rx_dim_enabled)) {
 			struct dim_sample sample = {
-- 
2.43.0

