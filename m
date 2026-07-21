Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BCA46E004
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661227; cv=fail; b=HjVcGM+Um++9E1oXwPfy1/O80QD+UD8LwlTSIo3+EZi4DoP9N+AbxyKFJfTVyHsX8V1ExsTS5noNAUnX/UYby2BNgeUGcej4ScybmhS0Emq13+5iAxg41SLpjkEBVwEq6UgWngck2wwD8zIQnlbCmJmLfqo6cJ6PtltqAKwH2No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661227; c=relaxed/simple;
	bh=IzShBh0kG6I08oTtlhlOB647OYwxZHypYKztdHrmxug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=k2lE3X5jVuJ87wgZsjW4rWxhXwuvr6Rzeag3Ws3RHqJBE3GbRT9yehFrmnJFt5x27Cebglb2NaDvPu/NYx5GzGWvmzHuI+1cW36Lr4s1SXJKqcrbko1Q48X6CnjmtGlgLIh1NNtF0yYSg54GdwrJETFuFFhhv9f1nZGj+1eDZ7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H8O/b1Ge; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H8O/b1Ge"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spMnDV3+FhFPXimBVuNTKMOrkt/DelFWa/VYHfH/iMBe4dbjHVK5DHjwty2jNtrnh5FrcZPIIhM6NS0ZJ2AzKd9+fXZ+wscaluIZu4I1iSeXBqB0RKZIfr4bqV+e+My4MMDbGpK3FYIni5YXZDh5aVHRgLhsIWSish1YHfxPklQj/AmyrUeyIlMrguv3ZRxv7tt9xCNVFCsi0VTkIa0VQzcWjWZR0HnEamRlYZP04wHgTkwSvL61ckWClgBnPRA4myNiqg3OVeVoLLlYoxcB4NnePzs2UoPda+eiAcrZ+H69wWuDXYWVVZKZlsUO/vuNPVxKeR+ZPYatfe1odjYs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUQxQYE07Yfg3X+0ARB44SRPfiXP/Txn23Av6k8HPxw=;
 b=ijFTsLqItEQNmVBfzuUARbQ2rxsTgIa8wrlmDfwtAEIEDENm6/LJfxZzySdYH6XGvwV6P3kg9RtOPkNMt3yzXHIDw0U26Xc1tGLC++OgyOTt8GdBTARb+8M2jR8BaHqbW+wlfjQdsM8iIHKXP8o/xCr7HoRSQMEeWURIEy4/BesZnyYDybKOzisVLkpLuG4O5I5826Wl6Rek1MHOxbQYUJY4WTeHUzNhiR6LFQb0zo90KfxxLF+QZ4Xa9asVSk3NXFxmdWym4FwOB/4zRFhWe+Q8ke1ysYmT9/yit67y8BNURoo68jdlyp2exhcnOS/bt9XpIQV00r9S5iudUruIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUQxQYE07Yfg3X+0ARB44SRPfiXP/Txn23Av6k8HPxw=;
 b=H8O/b1Ge9Vz4UhTHiIXtC+Wjv6A/4CW3t/GD+UwZYNCUjF+adQBUQXs5BvbdRnr2LO3oIdpt1i/mn9A3eRxmN9waRdQ0EPZi5TA/v9MItgdQaJENyV2Ovxi9fgivw+VYKXMP92HT5TRChqj3qqj9IxgR7TxirJoWMsNkXBZoD6o=
Received: from DS1PR02CA0023.namprd02.prod.outlook.com (2603:10b6:8:44a::19)
 by SAWPR12MB999141.namprd12.prod.outlook.com (2603:10b6:806:4e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 19:13:41 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:44a:cafe::7c) by DS1PR02CA0023.outlook.office365.com
 (2603:10b6:8:44a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 19:13:41 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 14:13:37 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Tue, 21 Jul 2026 19:13:13 +0000
Subject: [PATCH net-next v8 5/6] pds_core: add host backed memory support
 for firmware
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-upstream_v8-v8-5-1ea9a8b7c4ff@amd.com>
References: <20260721-upstream_v8-v8-0-1ea9a8b7c4ff@amd.com>
In-Reply-To: <20260721-upstream_v8-v8-0-1ea9a8b7c4ff@amd.com>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Brett Creeley <brett.creeley@amd.com>,
	Eric Joyner <eric.joyner@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>, "Vamsi
 Atluri" <Vamsi.Atluri@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SAWPR12MB999141:EE_
X-MS-Office365-Filtering-Correlation-Id: 18269cbd-710b-4553-9d6b-08dee75c2cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|22082099003|18002099003|3023799007|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	yrbxoZavoxwJIRL1lniDFW25g2iSUIwQ6zYCB0PR6nwoE6qiocX/NTXfAnlXvEQuz50HyLkcTw7f/aObWvQavho31xNV8j0B9iNcS9g3YWCe4OJkIaggKD1rNyxl0G6QPlKBHgi5ZFf6Jk+b7TQbcRvfPjR7WITFIhYhN3JFpG4pwehIJynmRk7rzy01f7fjysa4j/fXY9stp7Dd7BsORWt5fqx6Ru53TnGfbGI61E5h8TaY0Tqv6dva4iSwkxjvLS8TqcwjGi+J+yBXpziHNcYk4vU2WurrBTEq+83Ffrth2DDuXwuTD9x4IWW3VZcDRElaANo+/96oTH0aJVkSIKz7tVBNVHQWrnm5KmrL3Fdpx8HVQOFHo+NhPsyGDwmxgUFv51Njiy6wjzAaylgN7CMk7fvdn3ub1rutwrNMfSf5TagjgujlWI6dZYJztZ0yklVcu10IyXk1GBlK68I136KYzfBuoj0nSHh7ItCVPZlxRcWd381LWmhhEZzAS8RwXgd9M7jsX1nNUKxTXz6GuErl5o3icMvZALr87IVpLCM6eVVnYtlE8NqNHpLLxCagk9VdaYBWU4yMSC8kD5/DMcW7tuC0JFromGAmtNvw5WuZqiE0my/1+4ST541zfkGoAKR8crAaU9a+dR3pRnmZ7adXsBZL4mWdHgGERTpXiQtr8ycXR5M1nUxc0KmOJsSJe3L1hvoWRiKghOXB5YnJ3A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5qnwtrfl2NTuxz5wpqVc/1yXFuy0uE9iFpb4uvHegtdz7rkE+KTfipmAaIHpmByXMYn9E5iGTbiOwLueNPUrLdmTfuItlETKWQmBNpP7cWPM7oBSsEUf5IsCgw2N27WBq0cZsoqPOw15ukMgsa+Uu/HgFDGSFoVs00rvp4iKHUWSvKvElj3XvffVI0HCV7oNVPd7XFUOLnHlMGNZoWo1Wq6eAc+Ko6X2KgLberO/+ZNJ4Wrr60wsr5RidDaAAByH0qeCL7EtimPZxXpnZ9di/S10sLeIXMkzIvvboeXNaoisZIABpaeC8VCMKgv4bmwUkhY58n2Rx3TIng/o3tgDHiwQuZOMM9eGidau+xyrhvexTWf6EtY3CQR7/C8Pb8loe9ygk6dchetjfIOl9kypeUDhurpxtMCTG/1a8zIXXc2g5wVQ3Ig5xfp7eHQj9bgr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:13:41.0202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18269cbd-710b-4553-9d6b-08dee75c2cfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999141

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
 drivers/net/ethernet/amd/pds_core/main.c |   4 +-
 include/linux/pds/pds_core_if.h          |  64 +++++++++++++
 4 files changed, 249 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index a7a0bcf98ed3..356a69c895b6 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -500,6 +500,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->viftype_status = NULL;
 	}
 
+	pdsc_host_mem_free(pdsc);
 	pdsc_dev_uninit(pdsc);
 
 	set_bit(PDSC_S_FW_DEAD, &pdsc->state);
@@ -509,6 +510,7 @@ int pdsc_start(struct pdsc *pdsc)
 {
 	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
 			   PDS_CORE_INTR_MASK_CLEAR);
+	pdsc_host_mem_add(pdsc);
 
 	return 0;
 }
@@ -673,3 +675,161 @@ void pdsc_health_thread(struct work_struct *work)
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
index 5b82743782c9..22fc8281e1a3 100644
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
@@ -437,7 +439,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 		pdsc_sriov_configure(pdev, 0);
 		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 
-		timer_shutdown_sync(&pdsc->wdtimer);
+		pdsc_stop_health_thread(pdsc);
 		if (pdsc->wq)
 			destroy_workqueue(pdsc->wq);
 
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

