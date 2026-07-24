Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C443FD05
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927321; cv=fail; b=psVTtNVemtgGcid2aqwp3ZVxluNej70QOrZcpQEIFd6UHNlX2GkGpWEoAFNiKBpLKv0Dbdqop2fSS4JmAUItwlNKrrbT4u3Tjb8/t05zbxIzFq3vH3lR7ffV1cAhYq5vZabdKGKv9HfVGdbNXoqiPw3xn9XpmfGZG0F+QgBS3ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927321; c=relaxed/simple;
	bh=dG/COgwh0NoOT6WqdH/M/pfkH7EATnPPSWOpHc+vZNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SI9jPhs4yPRoh0ChqAUvjMtd8p8mVWWDom/DfGrXzuIz7bUGKqsShJmgXgNO45obOS7qGsOkhNidQOyRyrXfnCdq2DqybXf4xh6qCgcEyhKDbpLjKu6DsfEcMioKMm5Z9yrxqZWSaMywPlBgPHRjf9ONbFfQ9wVIm4ZDj6GORDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kiujpQXp; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kiujpQXp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+kl/7mmjyolcyTgGrm9oSDw0f7S6l0wGXeCNdPZ3Eql45mfY24lJXgr1K6ZAcjBu2vfefh0BflG1dI3sT+nZb5CTdDJcBjJsa4Z6vHdxYKdxKgiYSSi0RKrwvAUQTwF+GQmutP43nD7PyF2ocvpRVmb1MUywKOUGra+FVTGHoN80NdI0A65CznRfLEWYU21iKl9hp4ijWrisrSPNF+f/GDkd/jwrYd/6jMKbDsBlzNyY2CixYwkX1i9hKLIoixD1mcgfABdvw2QdVTJhMSlGtV8lD1+UlC7NKE4hd8Y8Wo8C5NNTMcMnHax5iYh+nACesLex3laOCXzzdIhEMLdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnGNbDreLBo2YDmpuXJMh9zNcEZ16ayisOtkuCfjSQY=;
 b=SzREwQ4WvcWWjO9Y7dY/YGoZFELsYEdT4P6+uoM7lfHlw0A1Rvl+k3IMrEPZsj4+HjC+BvFxNUObvOiHu217+pYki6kgz9L1hAFBwFKk2k8Ukx//KDZQK8Mm3BJtLhtGj+qGSm6JL0W03mjmq57pUyc9mvn+0EdKLebA4ifbVqHP8pSeLlpZ6MRfUw+ujWvUOdpcnLXEZFKSwiq3+9gwPaClBvCR323mY0zW5StRpfhQmOJp1ejaHIi9N+Vbrj8XeiqOmGCrit8kmSPiGr0ic0WtqObkYyWgv2wbbAFmcC1KFahlyTbyHx/KgEnAeQBtpz40QEDkhtVWT8wKwO8vtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnGNbDreLBo2YDmpuXJMh9zNcEZ16ayisOtkuCfjSQY=;
 b=kiujpQXpiwiJWBBtFZrZpwWzwzEvNGjEK5dfF8T2I7HHsTAuSI3KxDdA9yRt9Y2Ekw7o0r9hLPeTdV5FaUlpmXjt+5zYrVPAqMbp6U23OFNrOp9aBSI3K3h7S94x6bbOXPb6tPtSs4ZFeyXMUoF0m4lCGzykwOCYynxRQ3/hun4=
Received: from PH8PR07CA0013.namprd07.prod.outlook.com (2603:10b6:510:2cd::14)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 21:08:30 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::5a) by PH8PR07CA0013.outlook.office365.com
 (2603:10b6:510:2cd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 21:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 21:08:30 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 16:08:28 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Fri, 24 Jul 2026 21:07:26 +0000
Subject: [PATCH net-next v9 5/6] pds_core: add host backed memory support
 for firmware
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260724-upstream_v8-v9-5-8425762b8b7f@amd.com>
References: <20260724-upstream_v8-v9-0-8425762b8b7f@amd.com>
In-Reply-To: <20260724-upstream_v8-v9-0-8425762b8b7f@amd.com>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Brett Creeley <brett.creeley@amd.com>,
	Eric Joyner <eric.joyner@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>, "Vamsi
 Atluri" <Vamsi.Atluri@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1d8a6e-1956-4509-427a-08dee9c7b66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|22082099003|6133799003|56012099006|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	hE4OPIwNmBliuhqGZe1JpvIG//Cd211L4g+lZ9AX5RsHYtAXOx81SoJj0oLHM5lkK0QsW8pjBSpM+YUMOlBUE+yXFW6io5SpW3s53lPQAc9JQBAaeNQudQWR03Rtwmzq0yDzEJzvM0DteAJozM9kYTQ0OgLH3JyOWiRa6a3HnFwhewgAsZpCqJSooIN9Vy1OIvuYpvAlGB3LINKFxmr/B/o3lTM2XJmukNy217in8sIXBMgEwQTEYa5jA7xKtVBNx4fw7gp5DhW+GjFR/MFbUE9I8KwNYVPgeGPXwayAJ5cIIQIYEJVHqbpn81dxd92HsVeqdSSVI2tmRYP9Sxx8QZOcFFlGIK8oRq6q27JIyMqUA1jNshJY1cjKcDbnWyKK3mAJJ4cJCsFvSuJEyGmktNxwuDks6jJkHp9l5qkICVhX3cnq3XR42Z5I052J/WYBpDIw7jD49ERguqU+ms6cv3TLgOSEJBEra4wx2f+Kxw4uiEUk/xaLfcfE/z21t0Tf5aUD+2rclVUMrK1VjFi1GYGwu0Uvm4Qd0b3lPm+ISczWE6UZf4tcNSdz4mxpQcT5NveMLJ8121vk5Jy4yc8tOzqw/EnHEvYEp/Mr06ciT3Mlxo1meVroYWar2JxfSUFh8Japo/+0OIsslINrtNoyvUqcWvFC0dUL58Khk7hT/ZGu8eyk/RB0tdMDPVdeVnksuhDrVHJUSvohEVazb41cTw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+onYhdwS+U25lDg7fm7zeggbPPvXRCG7GeyonHVL3FONzKkRcdbs+kHThKFeY0eoTwoa0MYZOfcMRDUgLTLyoB6dkyiGMMutj6aX0ZHaIP87tvQgiMEKwrE+P76KWqCyqDOCFSstS3IKaUldu4R7SKa+9mHqKM4EDCu1WF6K7uUsoqVL8S8jqR8bGTaB5N0wpCmsduAFi0z+7m79cYiYejnZn3o5QRsSqEGJFmCfZLfXCnznD7E33h8uog3gM884/Gy+dOETF8eVuZCapSrtCe02mrc2BvPO98yPWqOK1qh4fe3o5cBaBEhE4XnnJz76g8tnIPW2aUJkSuN0hYs/fmn4J7zr4lR/F4TDgA93V9mUtl2Q8cjQ12KhWCujKfzAygBf/Y5C2py8zalI5DR6k/brBkuy2bgUOvzZyL1CC/vKls7flpa2508SUULeUid2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:08:30.1273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1d8a6e-1956-4509-427a-08dee9c7b66e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092

Some newer AMD/Pensando cards have minimal memory and there are cases
where components, specifically in the control plane, need more memory.
This series adds support for host backed DMA memory that can be used
by the firmware for the previously mentioned cases.

Host memory allocation is best-effort: if some allocations fail, the
driver continues with whatever succeeded. Firmware gracefully degrades
when less memory is available than requested.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Vamsi Atluri <Vamsi.Atluri@amd.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 160 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/amd/pds_core/core.h |  22 +++++
 drivers/net/ethernet/amd/pds_core/main.c |   2 +
 include/linux/pds/pds_core_if.h          |  64 +++++++++++++
 4 files changed, 248 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 51d21328c73d..26ddcbbfc14c 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -506,6 +506,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->viftype_status = NULL;
 	}
 
+	pdsc_host_mem_free(pdsc);
 	pdsc_dev_uninit(pdsc);
 
 	set_bit(PDSC_S_FW_DEAD, &pdsc->state);
@@ -515,6 +516,7 @@ int pdsc_start(struct pdsc *pdsc)
 {
 	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
 			   PDS_CORE_INTR_MASK_CLEAR);
+	pdsc_host_mem_add(pdsc);
 
 	return 0;
 }
@@ -681,3 +683,161 @@ void pdsc_health_thread(struct work_struct *work)
 out_unlock:
 	mutex_unlock(&pdsc->config_lock);
 }
+
+static void pdsc_host_mem_del_one(struct pdsc *pdsc, u16 tag, u8 reason)
+{
+	union pds_core_dev_comp comp = {};
+	union pds_core_dev_cmd cmd = {
+		.host_mem.opcode = PDS_CORE_CMD_HOST_MEM,
+		.host_mem.oper = PDS_CORE_HOST_MEM_DEL,
+		.host_mem.tag = cpu_to_le16(tag),
+		.host_mem.reason = reason,
+	};
+
+	dev_dbg(pdsc->dev, "Sending devcmd for mem del tag %d\n", tag);
+	pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+}
+
+static int pdsc_host_mem_add_one(struct pdsc *pdsc, int index)
+{
+	struct pdsc_host_mem *hm = &pdsc->host_mem_reqs[index];
+	union pds_core_dev_comp comp = {};
+	union pds_core_dev_cmd cmd = {};
+	int err;
+
+	cmd.host_mem.opcode = PDS_CORE_CMD_HOST_MEM;
+	cmd.host_mem.oper = PDS_CORE_HOST_MEM_QUERY;
+	cmd.host_mem.index = cpu_to_le16(index);
+	dev_dbg(pdsc->dev, "Sending devcmd for mem query index %d\n", index);
+	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+	if (err || comp.status != PDS_RC_SUCCESS) {
+		dev_err(pdsc->dev, "mem query failed err %d status %d\n",
+			err, comp.status);
+		return err ? err : -EIO;
+	}
+	hm->size = le32_to_cpu(comp.host_mem.size);
+	hm->tag = le16_to_cpu(comp.host_mem.tag);
+	dev_dbg(pdsc->dev, "mem query returned size %d tag %d\n",
+		hm->size, hm->tag);
+
+	if (!hm->size || hm->size > PDSC_HOST_MEM_MAX_CONTIG) {
+		dev_err(pdsc->dev, "invalid size %d for tag %d\n",
+			hm->size, hm->tag);
+		err = -EINVAL;
+		goto err_del;
+	}
+
+	hm->order = get_order(hm->size);
+	hm->pg = alloc_pages(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN, hm->order);
+	if (!hm->pg) {
+		dev_warn(pdsc->dev, "alloc order %d failed for tag %d\n",
+			 hm->order, hm->tag);
+		err = -ENOMEM;
+		goto err_del;
+	}
+
+	hm->pa = dma_map_page(pdsc->dev, hm->pg, 0, hm->size,
+			      DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(pdsc->dev, hm->pa)) {
+		dev_err(pdsc->dev, "dma map failed for tag %d size %d\n",
+			hm->tag, hm->size);
+		__free_pages(hm->pg, hm->order);
+		hm->pg = NULL;
+		err = -EIO;
+		goto err_del;
+	}
+
+	/* Track this allocation so pdsc_host_mem_free() can clean it up */
+	pdsc->num_host_mem_reqs++;
+
+	memset(&cmd, 0, sizeof(cmd));
+	memset(&comp, 0, sizeof(comp));
+	cmd.host_mem.opcode = PDS_CORE_CMD_HOST_MEM;
+	cmd.host_mem.oper = PDS_CORE_HOST_MEM_ADD;
+	cmd.host_mem.tag = cpu_to_le16(hm->tag);
+	cmd.host_mem.size = cpu_to_le32(hm->size);
+	cmd.host_mem.buf_pa = cpu_to_le64(hm->pa);
+
+	dev_dbg(pdsc->dev, "Sending devcmd for mem add tag %d size %d pa %pad\n",
+		hm->tag, hm->size, &hm->pa);
+	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+	if (err || comp.status != PDS_RC_SUCCESS) {
+		dev_err(pdsc->dev, "mem add failed err %d status %d for tag %d\n",
+			err, comp.status, hm->tag);
+		err = err ? err : -EIO;
+		goto err_del;
+	}
+	dev_dbg(pdsc->dev, "mem add completed for tag %d\n", hm->tag);
+
+	return 0;
+
+err_del:
+	/* After MEM_QUERY succeeds, firmware expects MEM_ADD or MEM_DEL */
+	pdsc_host_mem_del_one(pdsc, hm->tag, PDS_RC_ENOMEM);
+	return err;
+}
+
+void pdsc_host_mem_add(struct pdsc *pdsc)
+{
+	union pds_core_dev_comp comp = {};
+	union pds_core_dev_cmd cmd = {};
+	u16 count;
+	int err;
+	int i;
+
+	if (!(pdsc->dev_ident.capabilities &
+	     cpu_to_le64(PDS_CORE_DEV_CAP_HOST_MEM)))
+		return;
+
+	cmd.host_mem.opcode = PDS_CORE_CMD_HOST_MEM;
+	cmd.host_mem.oper = PDS_CORE_HOST_MEM_GET_COUNT;
+	cmd.host_mem.index = cpu_to_le16(PDSC_HOST_MEM_MAX_COUNT);
+	cmd.host_mem.max_contig = cpu_to_le32(PDSC_HOST_MEM_MAX_CONTIG);
+	dev_dbg(pdsc->dev, "Sending devcmd for mem get count max_contig %u\n",
+		PDSC_HOST_MEM_MAX_CONTIG);
+	err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+	if (err || comp.status != PDS_RC_SUCCESS) {
+		dev_err(pdsc->dev, "mem get count failed err %d status %d\n",
+			err, comp.status);
+		return;
+	}
+
+	count = min(le16_to_cpu(comp.host_mem.count),
+		    PDSC_HOST_MEM_MAX_COUNT);
+	dev_dbg(pdsc->dev, "mem get count returned count %d\n", count);
+	if (count == 0)
+		return;
+
+	pdsc->host_mem_reqs = kzalloc_objs(*pdsc->host_mem_reqs, count,
+					   GFP_KERNEL);
+	if (!pdsc->host_mem_reqs) {
+		dev_err(pdsc->dev, "failed to alloc host_mem_reqs array\n");
+		return;
+	}
+
+	for (i = 0; i < count; i++) {
+		err = pdsc_host_mem_add_one(pdsc, i);
+		if (err)
+			break;
+	}
+}
+
+void pdsc_host_mem_free(struct pdsc *pdsc)
+{
+	int i;
+
+	if (!pdsc->host_mem_reqs)
+		return;
+
+	for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
+		dma_unmap_page(pdsc->dev, pdsc->host_mem_reqs[i].pa,
+			       pdsc->host_mem_reqs[i].size,
+			       DMA_BIDIRECTIONAL);
+		__free_pages(pdsc->host_mem_reqs[i].pg,
+			     pdsc->host_mem_reqs[i].order);
+	}
+
+	kfree(pdsc->host_mem_reqs);
+	pdsc->host_mem_reqs = NULL;
+	pdsc->num_host_mem_reqs = 0;
+}
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 73356c74bb9f..085f2e988aa0 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -5,6 +5,7 @@
 #define _PDSC_H_
 
 #include <linux/debugfs.h>
+#include <linux/mmzone.h>
 #include <net/devlink.h>
 
 #include <linux/pds/pds_common.h>
@@ -23,6 +24,12 @@
 #define PDSC_SETUP_RECOVERY	false
 #define PDSC_SETUP_INIT		true
 
+/* Use fixed 4MB instead of PAGE_SIZE << MAX_PAGE_ORDER to avoid
+ * cpu_to_le32() truncation on large-page configs
+ */
+#define PDSC_HOST_MEM_MAX_CONTIG (4 * 1024 * 1024)
+#define PDSC_HOST_MEM_MAX_COUNT  256
+
 struct pdsc_deferred_dma {
 	struct list_head list;
 	dma_addr_t dma_addr;
@@ -149,6 +156,14 @@ struct pdsc_viftype {
 	struct pds_auxiliary_dev *padev;
 };
 
+struct pdsc_host_mem {
+	u32 size;
+	u16 tag;
+	u8 order;
+	struct page *pg;
+	dma_addr_t pa;
+};
+
 /* No state flags set means we are in a steady running state */
 enum pdsc_state_flags {
 	PDSC_S_FW_DEAD,		    /* stopped, wait on startup or recovery */
@@ -210,6 +225,9 @@ struct pdsc {
 	struct pdsc_viftype *viftype_status;
 	struct work_struct pci_reset_work;
 
+	struct pdsc_host_mem *host_mem_reqs;
+	u16 num_host_mem_reqs;
+
 	struct pds_core_component_list_info fw_components;
 };
 
@@ -287,6 +305,7 @@ void pdsc_debugfs_add_viftype(struct pdsc *pdsc);
 void pdsc_debugfs_add_irqs(struct pdsc *pdsc);
 void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq);
 void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq);
+void pdsc_debugfs_add_host_mem(struct pdsc *pdsc);
 
 int pdsc_err_to_errno(enum pds_core_status_code code);
 bool pdsc_is_fw_running(struct pdsc *pdsc);
@@ -346,6 +365,9 @@ void pdsc_fw_down(struct pdsc *pdsc);
 void pdsc_fw_up(struct pdsc *pdsc);
 void pdsc_pci_reset_thread(struct work_struct *work);
 
+void pdsc_host_mem_add(struct pdsc *pdsc);
+void pdsc_host_mem_free(struct pdsc *pdsc);
+
 void pdsc_deferred_dma_add(struct pdsc *pdsc, struct pdsc_deferred_dma *entry,
 			   dma_addr_t dma_addr, void *va, size_t size,
 			   enum dma_data_direction dir);
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index c15a1e376353..5e1b07850163 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -21,6 +21,8 @@ static const struct pci_device_id pdsc_id_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, pdsc_id_table);
 
+static void pdsc_stop_health_thread(struct pdsc *pdsc);
+
 static void pdsc_wdtimer_cb(struct timer_list *t)
 {
 	struct pdsc *pdsc = timer_container_of(pdsc, t, wdtimer);
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index 5a1fafaccf20..901e1e628f89 100644
--- a/include/linux/pds/pds_core_if.h
+++ b/include/linux/pds/pds_core_if.h
@@ -46,6 +46,7 @@ enum pds_core_cmd_opcode {
 	PDS_CORE_CMD_SEND_COMPONENT	= 9,
 	PDS_CORE_CMD_FINALIZE_UPDATE	= 10,
 	PDS_CORE_CMD_MATCH_RECORD_DESC	= 11,
+	PDS_CORE_CMD_HOST_MEM		= 12,
 
 	/* SR/IOV commands */
 	PDS_CORE_CMD_VF_GETATTR		= 60,
@@ -110,9 +111,11 @@ struct pds_core_drv_identity {
 /**
  * enum pds_core_dev_capability - Device capabilities
  * @PDS_CORE_DEV_CAP_PLDM_FW_UPDATE: Device only supports FW update via PLDM
+ * @PDS_CORE_DEV_CAP_HOST_MEM: Device supports host memory for fw use
  */
 enum pds_core_dev_capability {
 	PDS_CORE_DEV_CAP_PLDM_FW_UPDATE = BIT(0),
+	PDS_CORE_DEV_CAP_HOST_MEM = BIT(1),
 };
 
 #define PDS_DEV_TYPE_MAX	16
@@ -837,6 +840,65 @@ struct pds_core_match_record_desc_comp {
 	u8 rsvd;
 };
 
+/**
+ * enum pds_core_host_mem_oper - HOST_MEM sub-operations
+ * @PDS_CORE_HOST_MEM_GET_COUNT: Query number of memory requests
+ * @PDS_CORE_HOST_MEM_QUERY:     Query details of a memory request
+ * @PDS_CORE_HOST_MEM_ADD:       Provide allocated memory to firmware
+ * @PDS_CORE_HOST_MEM_DEL:       Notify firmware of memory deallocation
+ */
+enum pds_core_host_mem_oper {
+	PDS_CORE_HOST_MEM_GET_COUNT	= 0,
+	PDS_CORE_HOST_MEM_QUERY		= 1,
+	PDS_CORE_HOST_MEM_ADD		= 2,
+	PDS_CORE_HOST_MEM_DEL		= 3,
+};
+
+/**
+ * struct pds_core_host_mem_cmd - HOST_MEM command
+ * @opcode:     Opcode PDS_CORE_CMD_HOST_MEM
+ * @oper:       Operation (enum pds_core_host_mem_oper)
+ * @index:      Memory request index (GET_COUNT: max_count, QUERY: index)
+ * @tag:        Tag for this memory request (ADD/DEL)
+ * @reason:     Reason for deletion (DEL only)
+ * @rsvd:       Reserved
+ * @max_contig: Maximum contiguous memory size (GET_COUNT only)
+ * @size:       Size of memory in bytes (ADD only)
+ * @buf_pa:     DMA address of memory (ADD only)
+ *
+ * Unified command for all host memory operations. Fields are reused
+ * across operations to minimize opcode space usage.
+ */
+struct pds_core_host_mem_cmd {
+	u8     opcode;
+	u8     oper;
+	__le16 index;
+	__le16 tag;
+	u8     reason;
+	u8     rsvd;
+	__le32 max_contig;
+	__le32 size;
+	__le64 buf_pa;
+};
+
+/**
+ * struct pds_core_host_mem_comp - HOST_MEM completion
+ * @status:       Status of the command (enum pds_core_status_code)
+ * @oper:         Operation that was performed
+ * @count:        Number of memory requests (GET_COUNT)
+ * @size:         Size of memory request in bytes (QUERY)
+ * @tag:          Tag for this memory request (QUERY/DEL)
+ * @rsvd:         Reserved
+ */
+struct pds_core_host_mem_comp {
+	u8     status;
+	u8     oper;
+	__le16 count;
+	__le32 size;
+	__le16 tag;
+	u8     rsvd[6];
+};
+
 /*
  * union pds_core_dev_cmd - Overlay of core device command structures
  */
@@ -860,6 +922,7 @@ union pds_core_dev_cmd {
 	struct pds_core_send_component_cmd     send_component;
 	struct pds_core_finalize_update_cmd    finalize_update;
 	struct pds_core_match_record_desc_cmd  match_record_desc;
+	struct pds_core_host_mem_cmd           host_mem;
 };
 
 /*
@@ -885,6 +948,7 @@ union pds_core_dev_comp {
 	struct pds_core_send_component_comp     send_component;
 	struct pds_core_finalize_update_comp    finalize_update;
 	struct pds_core_match_record_desc_comp  match_record_desc;
+	struct pds_core_host_mem_comp           host_mem;
 };
 
 /**

-- 
2.43.0

