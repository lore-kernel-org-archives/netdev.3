Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0908440A0E
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927324; cv=fail; b=ZXu6mY5yn0T9Kz4H3s3Bir97vg7e/ZOS5FyX3eMSH2oj5Bf7ki9Y3aOn0RZpIq8oZB9TbwSh67CjI9Mp+0wIGKhI4oK1wEM8+R8NJ11AeyIkH7syK5FHESszliVc6WQystBQI8DzvUsvtdEWJ1tp1v79Ya2+sp/xFGWhayIhmvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927324; c=relaxed/simple;
	bh=SbmavOW3bG/+5n9HH5ACEcANlGxY6b53kluWSUrmW4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AbHqKUl84VjFtqkN4VmXkjp9Fl4O6MVX0yn52daUUps0EiHlF/+TZeGVvKo1Bt8WcFq9j6Xn8v21mm7oULkxiV1k+GfwaSP/TFtm13103vpes2dpzOmcK6LFbZQ00y18fcPpmWSSQjrFoT3Je1gNSNkmlvpXk+XmRa/pzpmPX6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eOlO62p3; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eOlO62p3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y84BU02jzKcAd7SKarOpAPsWY5B8RYl7n7UBsUa0J8Bav1ny1b/3+TfZZVkjRCZc9ZO9k7wFUR1hbOYJc8hDA4+Dbzo2JhEO9RKWCqob2Ky/esI0q5+z6qzTr3Rl/BSolMSF2FY/c4Z1VkreT8H2f1ZJpBQxzKKVQu0TNeG8O4qZQuy2ktpvhkginvxSJVMf+0VbO9b/hu0OUWljA0/mo1rPdg78LXEOFYZRK2a0dWOEE1F7mDJjjZ/zLxNjf+RJpoLP0M823ZuP5wzpi70u1wNXbMeIGZZOfnii6GJjG2mqltW62m/i8r7LlzWY0gD3sMLm8XdtGbXWM0zM7sp8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd29qJSSaguMJZB1VJpjyF/vSs3s8B36uJQKX6To5nA=;
 b=OZidKmMJbuRrIeaE/qdYUKOD/LkV3csXBhpG1a7b21Wls3NuDPVLgYhf9sjDhcuMqMI1f9FWKVbz6cOfNEXvNcWXfdqeb1EOo1KqU7wyabxS64vnDt4h23kAWXvf4QqDwwtkA8rMmlH33d3E44auPg2osXXBNEBKmw/NbYcPKYxIIzBcxs8DVcYX3hOXxm8n+nJbHVF6C2RRDRbacmb2dpRJSo7fqkLbsLoHuoxKP3EdtLuRAu/66ZQLWHQFVf6muJwf066m++aTSCsKc3Oi7953cPOU5nw9mmqOxJJp5RvLz1U20Xis3V0Oj1maR8A4PPTA46eyKE4Wjz82I7Uspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd29qJSSaguMJZB1VJpjyF/vSs3s8B36uJQKX6To5nA=;
 b=eOlO62p31ZhoIn4LXBRL691hngPMeODKaEjx361UleLeJFSvCOHDpdK8PeVR/4I9dtWPqKIEV8DZGGko3pgpYjLdKrYu/aeP/J4EwLu0ZDXV3vCAyh3CUkKybXg3ScQMX60pQilAcJvmspYA5GQhUVMJlhY0zKnM9+KY1TgGcDs=
Received: from SA1P222CA0123.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::10)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 21:08:31 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::9a) by SA1P222CA0123.outlook.office365.com
 (2603:10b6:806:3c5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 21:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 21:08:31 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 16:08:30 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Fri, 24 Jul 2026 21:07:27 +0000
Subject: [PATCH net-next v9 6/6] pds_core: add debugfs support for host
 backed memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260724-upstream_v8-v9-6-8425762b8b7f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d213ed-5b08-435d-5b1d-08dee9c7b701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	l5JJHKOb9dPJjFI9BxLXS2YKZHxU10SuwGmcSUkAcB5GRL5vyH1OQCechX7b2u85yaQFJAs9wn3wJW8MrXyFARlvmj7VvtRjY+q9WAIGGH90QsNZcnrNekLNC3bt0PreBaTEHZJZG8VZ6qd8gj3ssVYaEWZyjbsfGzQBo6Jcfvnmuk/TmU/Vfe6o0Epf/tyqbtzelmrDGvyEkoF+DNvFctbFZA0OEm6trpjfwEFQm5qC86+SoRJSpqoIW122BMuZVX32EOyinA4P6zkAkuYOoFsStSuR7sMbWekDoj63dDvaaOy8FQ8kGZWgj8VY66eDyBcsMRn/yigMdBB+bwnTE/Jd+KZgC7T0q8AjV9Kokh5hpMiO9VVrJw4CbN1pXrrC4Bu5uMS7Mt/1UrXp5uE0FPbz4ocgA/TRTmvg72GugsbtNNBOXDNow7Mco+UE+yJde6JKnDKQ6VodDHjw9IjqCVZj0BXKhx0nV9b8tkKDdLNReDKncZC8P/CbSXi/NLfTh8aTc2ASu4y1Es4iXr42N4GWqYyff7gF86y/qhl56NxXpqFotiQJngWforfAEqPi/apb5zK5ESLsCFKeqQBsSkru9CXV4RPPsmWiYkhpeNOBL8PoTAzaKk9sLA3RY2NQL8McBy1T/sPgaNv465hkzKp+TXN9BQCm5PU4MIVW4lLBmuNHdR6lr101If0uL+JFQ22d5MGq6KTlLPt03OhFag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YTibXqR5oB2SbdBCw2fbrWggDnJp6wt/WQi3ko/EMie24w2+Yf2uzoM+7+UHtUpJWhmVLxp4j9hYeA1bMGUFZGHEHcxcm2hR/AMIaUt6eB6srzeQuc7c4Nksn545sUbwugJBxsFr9Y9+bq0TKZwJCb26MAr9XXMuwdUtdLffwsFWhxoywlh1a0aModyeYf3ICaIUQK2XlJk1LjLS1ME0lVtcQG/9cUR1aUSq9orYLuCeMRY6uRdUrmcLt4k5TUT+yk8fa87nlRx1r1lMxzrJVooZiNe7NAqBNMRDy9l49qZHLz4U648Dei7HsMHgY/zy822EkP90P8e+B53kMqmfVmzhi9hx9CIqHmyyhT13vRgF3MkjEtBOS+GEp2gZwOZMrx4Nc4qvZ6WsP8pGod+Ow89Gdo34+/zuHiCQaFjM13+fwssR5lOfkCEcr+Sqb6NR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:08:31.0438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d213ed-5b08-435d-5b1d-08dee9c7b701
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915

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

