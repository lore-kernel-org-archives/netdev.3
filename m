Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBF440929C;
	Thu, 16 Jul 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206135; cv=fail; b=B7CNoqpzbUHclU9+hPH5wbIK0vRRHuVSMHS2emaD5MsUTDc2iZ3lcZHOuPLUGxhE1B9+yQIIjx88+oRSknHXWwlDCPdZYV5aNhNFQLSyH94ggJuFefVLEmNn1515UajdEIY4OMtT8i4Qf1uI5IbTl69N//Gh9WVZXasaSue5jvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206135; c=relaxed/simple;
	bh=sWgMekHMDXidzMsGagBe6BYiBDQWt4nPAlec51lpV68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nr73AMJgUcNENptt9oLptWGcgRyF4OCMkMzGR2MMLXoty+NW+dv7M6km5UA+2LzN3CssOc1UgKFtGaEVG/KhVEZfDWGm65iPSNbyatXDqF32U/hnIxjN5WQRJt1cEHOzt4hhfFALjMNu7rE9/AvUFCQ8avUD2H3dp2vTbvQ4bpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aqziUj06; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aqziUj06"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChsLAxFjG6rTS7ixR9QDqHd5kX+aO0nIs13isluBM4Wd5vkaNCmUb8JfNfFVZczSwe4DYrkEYSpHkTIYx2v2UzY2V3ZZz3tTLXCiiwNa8gcg8XOaorqkWJB//ZNqbb0Rt28KaHybzp1rQWygZTU8SbV4HDPoewQUtFWJjTgcDd94+n9ux/Jy9eszXhCejtawarUQrcyUvN+a9bIEQX+Xh4XY/OfNzYxCU9xjVvIX/uHnSN9tOf0Sk6d51k2tED2kWUsZWYQcHJChrtyNkyDL38/IvRVZ0Bk5ackK2UepoE6lIFzpaEK/GG404hBwv8khgtZ+YMrywRKkLnoCaa97cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO85MVJ/GroYzN+9MZfoFUtca8YGfxaXtsNEwIUviEk=;
 b=m5gfZBGzB48xB6gMQJ3Mi7NLHQee5V7Knr8pfcDMG4DLtNMtudrICOLS5fAMcl85uAZrwHyfRgPLcj0tIE0e9NbKDyzbvw860TVkdNw1k+6fXohq3au/fdW76cby7c4KftWZWhFs9YJfCD1ZkrGWhRa8r5lL0WwQhwNZPfvzWPY/cWPaTXK4HSGDc6nF7xYyhEF5QfxzxqNqxMhr3ePE84fZMaUyViBVkTSKA1RfrlN/RYQi1PM505UFGKygtv0EjcaWkIH87Lx9KDEhl2w3+sjBkXu+k3UZVVl9wA4g/IYe/VYcr70z0WKsWyOuE9t/0/ghelxsp1OI+6mmhDyfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO85MVJ/GroYzN+9MZfoFUtca8YGfxaXtsNEwIUviEk=;
 b=aqziUj06ErLBGI6Sm40O11n1OVvxLk9sxtW+8T2I1k3q9aN3tSWW6r9gFfi3xybIRZgh6rIh6FTzE8HCyPdYwxCUlwAtQD1BugvrUBM3PolyaNMGtXCnhYRk57KY3Q4/Nd58qQyHhzSuDA6Pivv2qblolS8FT2hmmeqrsmDkanQ=
Received: from DS1PR04CA0019.namprd04.prod.outlook.com (2603:10b6:8:243::6) by
 LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 12:48:47 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:243:cafe::70) by DS1PR04CA0019.outlook.office365.com
 (2603:10b6:8:243::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 12:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 12:48:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 07:48:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 07:48:45 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 07:48:41 -0500
From: Kusuma Vasana <kusuma.vasana@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <Kusuma.Vasana@amd.com>
CC: <git@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V2] net: axienet: Clear stale AXI DMA TX/RX status before re-enabling interrupts
Date: Thu, 16 Jul 2026 18:18:40 +0530
Message-ID: <20260716124841.2761722-1-kusuma.vasana@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df77dac-8239-462e-8d8b-08dee3389391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UzVl5lmmIIUNN5ZNPiMp5qXSFy0YYj2HmNeIhQYwpFF95h09EiRtIEGKJh02IKaDzCopM2TEmRWA2eegwTanrGAjHb7gDLspwvO1UHWo3ysch0aez+GTqWFIZtvYW0LUsTNxpY3KQRSK2M7oDTCl2xlKUGif4E+jh5CrWq009xzOb9ihfHLYCCsK9fzl0wwJ2VMZkuNhUmWLMH3wfaD5t9nqUPpco23pwNYjRiRMVRibo5eH99mELBT0HNM9VDiBymBMTp0GOdqrCudpbh/6yaVv88oinjVN5+XLhv67DdkLInVdEBj1Jfeh3RCe0ep8GvaL06PhXQQ4sk5j60XPZhDb7P1duDExj4tV0Ns+Okxkb+phdR5x/zrSgpUq59ZDcYS+5T8w6zYw0HY2/W36yrlOJbyVbR4DUYLkDLRJski8dz+HX68KMkEAO4j9O7G32KmFfVnH6HoH78vC2yqOR2P9FijIWPDovuvOYpI9AnVfpigSW1CdZOkV9n/H7j2QT14bhDxM51mstIUXR3Wxx3ckj5P7l+x0Y5afF593y3THoXKhXwGL2IOxwFyqTUcEzdv4HdzIe5Gkvv42MraKMZ5GIksZMlwj0pbHNJgBpIzEd0/+TSUn8rEkXww/EEWvWI0rX1a8umw1FvgZD4hs5n9imy0/uD23JGmCCrUXSKSv+K2CfWt59gGIlnzrg5J2ilnEJJCHWN/nVIP0unDCDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qpN7UDScsjVYISJxvVI9rXtrTL2Kk7eHRGDJh0u2Q/OtAsp8ffov0fWRrYMzzppTnxBZVVL9+cSuue8zQWSiafSywNZu8TAgwVTSP/f+0J6VkJvJxBKgsuT2eAGMZ8vAnQwB54FRpZZV8I1gegO39lxpq58fj/xQqNTR4OJqSOFdXpIA22f+pjO0fxKZufXMIpVsFtKpXXm+z5xyhAJHBx8/OCLulrcKw2GCHVw8eJcOxez9fOJYg3mV9icrNles8t4LOQew8TX+1Pv5U19Mb7S0iRllknE9dvBRzA5J8BLnAc08qBPHcMRzQkJgbJlngnLqgdAhELKcVorw2xdQ4RTiSDnvLWBA07RBjxcWoWzx1lUmilSieKiE0hI85zQlOah9X1qJ8FqWOfCJSjDctjD12Z6FlFT7Y17rM+w4SR/Z/hHLb3wDNXI7HXhqS7f2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 12:48:46.5856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df77dac-8239-462e-8d8b-08dee3389391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265

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
processing. When the driver was converted to NAPI, status register
clearing was moved to the ISR before polling begins, leaving no
mechanism to clear status bits that arrive during the NAPI poll window.

Fix this by unconditionally clearing interrupt status bits before
re-enabling interrupts in the NAPI poll handlers.

Signed-off-by: Kusuma Vasana <kusuma.vasana@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes in V2 :

-Added net-next prefix in the subject
-Updated the commit description

---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fcf517069d16..29050c8d04e2 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1018,6 +1018,13 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 			netif_wake_queue(ndev);
 	}
 
+	/* Clear stale IOC/DELAY bits that may have latched during the
+	 * poll window to prevent a stale interrupt when there is no
+	 * work pending.
+	 */
+	axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET,
+			  XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
+
 	if (packets < budget && napi_complete_done(napi, packets)) {
 		/* Re-enable TX completion interrupts. This should
 		 * cause an immediate interrupt if any TX packets are
@@ -1293,6 +1300,13 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
 		cur_p = &lp->rx_bd_v[lp->rx_bd_ci];
 	}
 
+	/* Clear stale IOC/DELAY bits that may have latched during the
+	 * poll window to prevent a stale interrupt when there is no
+	 * work pending.
+	 */
+	axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET,
+			  XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
+
 	u64_stats_update_begin(&lp->rx_stat_sync);
 	u64_stats_add(&lp->rx_packets, packets);
 	u64_stats_add(&lp->rx_bytes, size);
-- 
2.43.0

