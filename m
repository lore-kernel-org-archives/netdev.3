Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D25399352
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785385562; cv=fail; b=k+Ggdc7qX4VrwlaK7MFCeIlNs/dlnwskmUWqOS/67m/5d+N8rTDvjDCM8Lg4+rDzusH2opYLCHY7d45CPGnk4JyMxyQHcRh6C1mAMioSwXJsEs64sjGmgVkeSEvWacsncKJMzvg5rO/xaQobqhWgdra+XECT2TiCrepzc/CR4A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785385562; c=relaxed/simple;
	bh=SbmavOW3bG/+5n9HH5ACEcANlGxY6b53kluWSUrmW4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=byC5C2zrTI563+B5OkMG1ette2aTRCs7t+KqB+Id7NsoZwv9AOHL4LIllMlkBunCr/Ha7++9Wsv2e40Y1gnRjN705sA6fplk3psUdxCb3M2+cR1wz/K+accZi16fAaRWt80rNHJ6ofiEl173msXq9SXsJbCmiI/7zard4Q1wBhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xPrMZINh; arc=fail smtp.client-ip=52.101.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xPrMZINh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wD5hIgSebFUqgmev1BeN7JMVV33/DhkePDFPfyK98hheKMjb4UyYniMCHpPNIeMHvup+4hpUqRwIqlql1isIil7zJKUkGxJJTF0dt+jl3VPsH5cjGm17yW+S8C8dL0lJ+4tsQLBGfQKLLaPGnnMaMtUb4EDoqSEY+e8bZKirf+pMka+al1SFx7CG4S+9Rfxk7Zju8kFSovpilZjhTif/sy35NC3Kz575GNKmqa6sBUqi61tL0h8JoX+AjbvMP2iF1ZfM+WmRP9McumNUhj5QNVSUJPRBfxDy1BRxX3zAn4Hjs1i9EHD8YL3nh+NYkTCSzc8DsZanfW4vFkgeNZLapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd29qJSSaguMJZB1VJpjyF/vSs3s8B36uJQKX6To5nA=;
 b=n6ft/8h9vDzPp6mNjb6wVdOWm3x+/pobskZi66eF7YDoeoAsTsbV1qjNXjQJ1wvFliRY6Bz/RxT0AVIJEw7hIVMyZe5oC8y6wxpq4MrLlMqgAzVbggN3f6TBO4m2iePXJTeNcUR9RYskN0Vf5mUE0xYb4D5bPRPi4j9rKH0OSNCPpEY8Q93L6RL9iYBEFKjKNJ/k/g8hPq10sv/wGUMI6ao6v9pUG74ozesYaxhTJPagSN4jDs8i1ctpUULaZdeYqPF/aGohc9ZZU+aENqe3guNieskRbe5BJxg3UCg0l+XwRZHg7upFgQvVKgGY4cEzVr9oa2vPVh9hwlJLtQwwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd29qJSSaguMJZB1VJpjyF/vSs3s8B36uJQKX6To5nA=;
 b=xPrMZINhl3VxwT65Lu+nLIHMT9yrzrH4fysr5P7E1huLUpXH60WKc9YvrMQp3HqC9etyw7cZ4lnPGjsZguxB88runSROq/34mxZDoRy4OOVTzktNQQ1j4BJVlym9fn3RInsJDWs1SGsQGZCGjq+5ss9FUnQkQIxC7Qmi07eNGhA=
Received: from SJ0PR13CA0072.namprd13.prod.outlook.com (2603:10b6:a03:2c4::17)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 04:25:55 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::ae) by SJ0PR13CA0072.outlook.office365.com
 (2603:10b6:a03:2c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8 via Frontend Transport; Thu, 30
 Jul 2026 04:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 04:25:54 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 23:25:52 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Thu, 30 Jul 2026 04:25:23 +0000
Subject: [PATCH net-next v12 6/6] pds_core: add debugfs support for host
 backed memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260730-upstream_v8-v12-6-136cd174ee85@amd.com>
References: <20260730-upstream_v8-v12-0-136cd174ee85@amd.com>
In-Reply-To: <20260730-upstream_v8-v12-0-136cd174ee85@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: acec5b28-4954-4ff6-5bff-08deedf2a58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dwHn7J1EFKtUZTBxcLstm3RyapH/KwRWIQHrEq1tRhwNj/0aFuP7KBB0tCoVt5+G/GTc0PohwaPFL7D3e+fFrTX4qTrRgGbipifMrVmdX+aJfkOVzhdT9AG4RYZoW2vpUIhZLV1JceO9F6QsEFul2675zT+UVPbuXNMTOJ+YGhG/DIy8hgReyQrwEMY90rqDyHmM8k+7qbYRY6qjynO5Aryee5IaZfCRuVGuu2eRXWSHspXmpNg542I7fjI36mo+L1KNJtPIoRe+WIOnj92rplyIh0MsfeD3yeQfh582C7fA7At7DT/ySIqzgQPbGFOh1ehPxwYlW93/dxbLQQNVJIaiR0cD+ug48F3lnxF3YohXsx5ZzATc4g2SBsUAuHwpHOwFfe5mKdNaAlgiEy4BhFfH9/vcH58pmE5d+K64Es54RFxGOJ9+ljyUH+Qmk4G6m7iqqE3ouOjTH/uDc/Xk0IvkVqYRRrA0qwNazdfVUJ8aefAsjO7IqlA1UKOy8kKt4ykjf6lEXK8Q0ytMekMBiqoFlAOucUXKsM+NquWpMV1U/jwmnDSFuuy/jQXsAvDwUMM3MogZdAbvYcHbuyFJpg0RXX9V0mFysHC+MSItq7EAZgQEHh2ILWM2DXPvd5OSq3u01VxSsAr+MKQ+biLfP6MUg1IhDDO95fWYAl43bSoh09TJWV43eq4r3+bnNpwjLRPMtMq+C8vSHJYgKeO4Fw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	666gTl6Au3V+GSnyhSeNv4/a4TJzB+qAHlaqZmBHoZAs8AhiSe1QZgd8/tv2lTHbUr80kzQ12smVga0oOTdaIgSv2JvuEIjmysJVUEE2cqV0/9k2YuPUv9lwpaZCadVB8pIFHTViN3xlEuMFbjSQWU74q1JHKi8RPOebPoIrWTh6s2BD/TdAnC+PdtHRHBWxcLHUQgBILDPgivPYO5ltjExj+qlSVIljijaz1oJHZrRJzNzK5JD1gWMi1igCqYQwOYvqzx1eBdiHUyFRvEuhJDl+W95swbhfVFfwptXPwZ3nLF0qjEAql/EHSBhMvYdvRVBbwXBy73y+eoeLnYMGq9n7XrZkoKOVwdnHI/VKQm4oF29ndWHXRjR+LUgMW9SMfZ4zAwkyQSTYH+fGGm/GnippahAwIL2nhNjmpx/UxAJ0Xg/PXFU+t3PKOABFTV8l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:25:54.7023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acec5b28-4954-4ff6-5bff-08deedf2a58a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797

Add debugfs entry to dump host backed memory allocations for debug
purposes.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Vamsi Atluri <Vamsi.Atluri@amd.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c    |  2 ++
 drivers/net/ethernet/amd/pds_core/core.h    |  1 +
 drivers/net/ethernet/amd/pds_core/debugfs.c | 45 +++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 26ddcbbfc14c..922e3ec8af1b 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -506,6 +506,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->viftype_status = NULL;
 	}
 
+	pdsc_debugfs_del_host_mem(pdsc);
 	pdsc_host_mem_free(pdsc);
 	pdsc_dev_uninit(pdsc);
 
@@ -517,6 +518,7 @@ int pdsc_start(struct pdsc *pdsc)
 	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
 			   PDS_CORE_INTR_MASK_CLEAR);
 	pdsc_host_mem_add(pdsc);
+	pdsc_debugfs_add_host_mem(pdsc);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 085f2e988aa0..791756a50870 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -306,6 +306,7 @@ void pdsc_debugfs_add_irqs(struct pdsc *pdsc);
 void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq);
 void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq);
 void pdsc_debugfs_add_host_mem(struct pdsc *pdsc);
+void pdsc_debugfs_del_host_mem(struct pdsc *pdsc);
 
 int pdsc_err_to_errno(enum pds_core_status_code code);
 bool pdsc_is_fw_running(struct pdsc *pdsc);
diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index 810a0cd9bcac..ef0a1b7d159b 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -178,3 +178,48 @@ void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq)
 	debugfs_remove_recursive(qcq->dentry);
 	qcq->dentry = NULL;
 }
+
+static int host_mem_show(struct seq_file *seq, void *v)
+{
+	struct pdsc *pdsc = seq->private;
+	struct pdsc_host_mem *hm;
+	int i;
+
+	if (!pdsc->host_mem_reqs || pdsc->num_host_mem_reqs == 0) {
+		seq_puts(seq, "No host memory allocated\n");
+		return 0;
+	}
+
+	seq_printf(seq, "Host memory requests: %u\n\n",
+		   pdsc->num_host_mem_reqs);
+	seq_puts(seq, "Tag    Size         Order  PA\n");
+	seq_puts(seq, "---    ----         -----  --\n");
+
+	for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
+		hm = &pdsc->host_mem_reqs[i];
+
+		if (!hm->pg)
+			continue;
+
+		seq_printf(seq, "%-6u %-12u %-6u %pad\n",
+			   hm->tag, hm->size, hm->order, &hm->pa);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(host_mem);
+
+void pdsc_debugfs_add_host_mem(struct pdsc *pdsc)
+{
+	if (!(pdsc->dev_ident.capabilities &
+	     cpu_to_le64(PDS_CORE_DEV_CAP_HOST_MEM)))
+		return;
+
+	debugfs_create_file("host_mem", 0400, pdsc->dentry,
+			    pdsc, &host_mem_fops);
+}
+
+void pdsc_debugfs_del_host_mem(struct pdsc *pdsc)
+{
+	debugfs_lookup_and_remove("host_mem", pdsc->dentry);
+}

-- 
2.43.0

