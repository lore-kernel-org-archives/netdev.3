Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0546EF64
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661227; cv=fail; b=eORsimAAYvLHmFxYgsQwNkulxh5Nt/ECakbaAppd3CrProRxCOwiW8Dric4HTcBVomaQLG1+Ck407CKtOGMVrzoRTLPuXPSDLHsVJ2dww266pkdXnqYCc1icPhRg7ruTeD+yMPXQw8LiqWec31qyWhDb2KyrohZdpl0tp09Gp6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661227; c=relaxed/simple;
	bh=18mRLgepXvyAN0+Wp5Ct89iEbYnF1hVYUoPEjDZuBiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=B/jxGcl5K3I4Czul3JbHmNRoeh7RGAIER6G4ZL2fX0gMthjVTRZDAdLgm/rBspCPoNw75sm3bo8B/qCva2ZTIqdsmIhLfEFHvS43QARY85bru5mEJBuVjKqRbK3Q59oHFE+cMVKyxWyuV52/dlpiAv6HZM3ncvoPYMhfy2elanA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bs0M1dsg; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bs0M1dsg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbTCPmrEf+seqQeriwL8bUC7EruzyHzMrfzhEth8HC+PibLoAoU1kVLMde+9YyxKn8aYtZXDR2eTW0beex5L30Mog3KhxHUPgXlhRHJgbCAzobMYP3uHULRO35I5JIW/wYeeU+aNxQQ+iFmjaXSv3DQZo7iFcNBp7CGdeJ5V0pOqfwEjAX1vLpWA2tA18AqmnukwNYI9Bcz8ltiEd6HxOfD2Ff93Iyjt1ffQ88/897vpZCRYjuhgkYnG5g/eD77lDBPzklBYEbNEGxYMhXf+9JfDBJJOLKNPBboLTtP99pQeVIlb0JO1KbFqtMXmr3+IgcngM1kt8y9635MbA6RwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sh/nMFJkVKIRY+4scoLIyzZICrREMKMLPvg8PQwnO0I=;
 b=ah8NLMZpMxq0VDUFNsuaDDCEMLuxPRDlRwU74BdIfjcTbKTCp8rAOxUR84qPApkxDpLLi9i8FFf/DjAIF7YmXKNSGZW7BtNXFe91jSz8qvMFI6biiL9DUZjdlz1/abNKiCWj7/2u0cU9BzZYraTMno/ooG6cWVE2fFMlPwM1A/dX/z86eHaT+RPbWoI9ZmlxNFva6Emh4CVuLxTX1jO4PJax6TZzq9eZmKiCTzyia+tXPZ4BDz3Hi8r/HwEycFKipeXXJaA2fkI5X6pGvFXh2mL90bHRlnDsuzckLLFXEwcjgFVkj7LRtYo/aq6AyZ95VlBcCDJTMHya5gVtu9XADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh/nMFJkVKIRY+4scoLIyzZICrREMKMLPvg8PQwnO0I=;
 b=bs0M1dsgkVqdGaOVFGaXutgOuaYVfTrtu4AJGkh7uw5tMD84DhkzDYZHz+S5ARW8jqAM1fZ1Cv96PoNopdz4CRl1gVVkByCi2gRZbO6ZLSIgSN+YATA6zgjUBs7XFFjMMmh8H3ENVG6+gyqd+yF5NlXvkTPtBmf0s1GTmlteN3Y=
Received: from DS1PR02CA0019.namprd02.prod.outlook.com (2603:10b6:8:44a::17)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 19:13:41 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:44a:cafe::78) by DS1PR02CA0019.outlook.office365.com
 (2603:10b6:8:44a::17) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 14:13:38 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Tue, 21 Jul 2026 19:13:14 +0000
Subject: [PATCH net-next v8 6/6] pds_core: add debugfs support for host
 backed memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-upstream_v8-v8-6-1ea9a8b7c4ff@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4313c7-679f-4e65-c27b-08dee75c2d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	+/TpzPhLE75IakX5TBfRV2O1p6JJ8urUplHC7Kc3V+astI9PhxlGB5iUavsPq9JB5O5dz1rTu0zfs8Lud14Xrn/hdiBzBs4vfNjRfX/s7EmFGimAVsX5ZG8hr4/6Q2w0Czq/iHZyg7N4vMqngigBndC58CfGkefUBZCgMAxalTFH570aUwZGRiItH7rkADeQN/hz6Fvr8TjQ99f8s3BJdaScNDDrqsgXrFmMA1uMTig9mx/bpMfUU6ckLj5wjoxHMfu79Zxgps0Zukh0iGLGqBf/5Bc7bcfcD4vYf/zzi8MdzKJjnlnzRjmB+DFJOYTd8rp0SVO+fKwEtU1UcG0jaO9vU5y7uiH10GgyjY2mDtmhS5GoyAEnFrDPbCVDcbRvtsVLL8CVB7F1yHEwBx1VHJfLbDDHcB16zX0Y/0nJzo+SLf6kOniXBFgjS9/e0yzMjq6OnPNG+uxgz7vaGHXHmCWBnpEq4rgB7j+Hq0JVI5WHksBxcqU1ZZwAN0RZiecC2ZGoo+FY1s7AHgheOg6o6Knt4WV05PRgEnqnevzmFfNGXOuKE/y4aME7yKntQ4TeBAFVlohfFtfUOy5ivZ1nIUnIuSVZfiMWMec/rHO02xaAuYiwKip69ahhPOeJ9OLbAmnTTQWwckv94KkPGQvZ2PArVWossF1MnsufpkgIGSWjyekMqP4tS4+d59pWJyI9OIMP/OO0YynhAlyFJbBrUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xb9Ozn85XsrFxoKtN6jav83THcPLRjJAucBxNJbUycz+q09vmL0Vydc3b3H07xrbTWT3Qu5SiPG3ms0NyTX5sVzVG7EZRIl6T8CMVBwI2Xk8Xw2MG3j+t/FFGb4v504WAjKTbMNq7Czv//mpM0N0UzAbaCvtvdTkJ+gsAAYDoMG/eZoflZRuWx9URVOaknhwxwBm6NgJrXRkmvRA99VrA7E7RZnCdozmLU+ynukRK78hkm4ltgXn78T8lD+rV1azrxRcVbRE9jRT5+fZhkFgGsb0hCMGvMj6/7aCZgfWrZEjBPqA9doGz6Uzj0uoE/bn0K76k5hnPyjcxaOKhnGmVRecK1KQzjZCwKBzcc48yf7ftMHBxI2vEJrySp+ahDI5CmZpx8UkbrjXhHyZRf3bVs3fu5tCH4bMQWToHVEjkEC3jdp9A6xItqrBTfwzR9GM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:13:41.6922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4313c7-679f-4e65-c27b-08dee75c2d63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286

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
index 356a69c895b6..d4857bf4860d 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -500,6 +500,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->viftype_status = NULL;
 	}
 
+	pdsc_debugfs_del_host_mem(pdsc);
 	pdsc_host_mem_free(pdsc);
 	pdsc_dev_uninit(pdsc);
 
@@ -511,6 +512,7 @@ int pdsc_start(struct pdsc *pdsc)
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

