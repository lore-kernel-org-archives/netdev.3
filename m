Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D742238B124
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297174; cv=fail; b=I4ycP3bfFRON1v6onzsmgr7u4bfP8kWzGss7t/iXryC/IsyV4BEUIja9Il2PaNUzao0FEzI1sS6M3zKDHfqNCVksfe/GMhyaoRolsvDV9OtNcfvCDKGGtfcvTulLaExp9+CI8Pcbjk068zCNC5ld7UMZNUHTDXeLv5pXJyYEtQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297174; c=relaxed/simple;
	bh=SbmavOW3bG/+5n9HH5ACEcANlGxY6b53kluWSUrmW4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dB7dmrGBYjJGsphPegRFvcKIoqolWEgH8QIz9aW4sMxnRMH0Dlp7bjU8/tfIkWSYRVl2YniO7SyHU9+48tGTihqIokGLAS9qfM+xeXFwKuzkzgOgrr05rLCKhQ7wvKFgpTdD46m5ZPPiE5aIQ1gm/iU9hBCVQ2CGwydk4cPkhCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jv7ME55q; arc=fail smtp.client-ip=52.101.61.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jv7ME55q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIIfEj/m2qt/Uw3N+mSinAYt09a/kV6VagqN6shQavtpiE3aX57/SQmR9+qKGNQM/R+Mj+InzNzShhLxYg3oje2jJYeySJGBZX+Ly+HvjPImUN7xluCamFON6FVpls8iqRntV1NS4gt2S3lpWjFp9xL8W4c3qp0njeVzOqhnw6y4hVO8NfEvzOwJZYUnVaMXDT3x7ushSauQmoLsqWN9LxLO349Tyoqga6jm3BNyWN9V7qNTC8FA1Q4cg8w7zynAijkUDck2wfjZhzu+YECBX9++d77ZVqkM+wjbyrO5S8at2x7lJmKDw+dpPnidChQGCe8PkTGCfPFT5XlRqwcZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd29qJSSaguMJZB1VJpjyF/vSs3s8B36uJQKX6To5nA=;
 b=hwFE/eaDeqXIfUlTnR1CGB9wM2WiprAU5VhJ+ZuObH+PE7qe0QRCxuZlLRxuc9YzA2oegUoAqavb5APrc4Q60Av7990JF3/FrWgf9Mk2i7Y9XXvujcSbTObRgMSCEo6sH7yFspLATJ2lAkoelQUVWd4V6TdbkGfe1EfcdIW1bg8JnLYrEVoOQf7GMk6adTaLW01agIuKzcf6vUuP4ajlpDi1TyXM7yAfn882mTWAcZBvjy/fRt1rvVKtZMKcsERIIqAzKUYJdQ8VE8wgN0NyhCi3MgCZonOaL15xc+YwCxe73JQvpfCI5W9MrguKdTNdIhYOTPLJReglleMKkaqbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd29qJSSaguMJZB1VJpjyF/vSs3s8B36uJQKX6To5nA=;
 b=jv7ME55qYcXsVEdaVqn1j/bn9RxeFyVeVEUhBHVlitJmf83YBqkBOwbMiab8+pcV8uzmDrnE+pDOx7tzgK9dlh0L0+/12pbdkjqdGo6NjGM9zPe4lTrK53LiT6dOiaBCAs1Z2qbtlG83QbeAfkZ+3PVl8+BEEimvXtv9M8+FEew=
Received: from CY8PR12CA0030.namprd12.prod.outlook.com (2603:10b6:930:49::8)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 03:52:48 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::1e) by CY8PR12CA0030.outlook.office365.com
 (2603:10b6:930:49::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 03:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 03:52:48 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 22:52:47 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Jul 2026 03:52:01 +0000
Subject: [PATCH net-next v11 6/6] pds_core: add debugfs support for host
 backed memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260729-upstream_v8-v11-6-e4b7d5bb2913@amd.com>
References: <20260729-upstream_v8-v11-0-e4b7d5bb2913@amd.com>
In-Reply-To: <20260729-upstream_v8-v11-0-e4b7d5bb2913@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9d9083-b5e2-4ac4-8e11-08deed24db2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9FV9LhqGrEJkiBysBr01eW9Pb4TjiTa4yzV9iTlPXJJ2Ebti023Dwh1oW/G2sWTRYm7tCnkTemde3UL2mN6wQFjX/QB52O1hDqZfZFxiXqp9gxMWd2++voWCItI4VDO6ZvDUQXI50a2/BUEf0vvOExzxcLRTwcEnlhSzyKoTScDd7Qo20BZ43pFdcrZLwL3ht4rWnecCKyDF05ALLWBAoRuHtsV+KiaA4Ov7jxKM1K2EQC3WbBxb6B6Gi3d+TBIO1RfQRrg8ZsTHTv92o9It0uHCnI0fRDxJxIfuFhPS0B8KHJEFyJU7jpxR/+BY8wcLtTN/j5fa7cwQYH9dXa/SQ1uBubwsgUnZN9yLg0c1t3zizAGg7v4z0b8wQdgE3eHjW0ymUnJmcWD8yZJfftPt48McmU0BxEmQmHXhnDiPBFH6CzUApvG+9O+nO37XsPFVa5amIf8b6hr2YuNw1R0SauxVDUIY2Af77o/WTqd+W9Ghpb7NW+7thysmj9lkhU80XBQdTYYSfdwb+BY4TB3g7H89jiZRFY7v1qNvz1CoBpDzlX2VrcLm/7I4KNmedK3SjyupA7vU9A/UFw9hyeqG29rb6YGZR2/hu1q3pDwCjvWOQK3wNg4lXFyfNUscVi+PcOu37rD6ekJ3MSviN5WMTOAKEkJWlveZ1j9eir34x7YOp73KqV3PHIkILvPr4OuwZ7ZHpsNX5sgy6Gxn6D4q9Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lg9oAn4VNYlKHudp5Fky/5jPD5KxiwMh6ojUYodBhx/Hv84uV5hXL4PwHvUVjMp7ghb5lM7vJDljOcJrjCCxPevF+owuA6cu+OIT2RQm6V2uJ4636BL/IazABKzRwWWqgSu1BNtB/hnURcQ34qHLxtO524CprB5gvOxp9n62idAeY2JEHeo7BpOtaQXtlemVns5XAU0M09QB9yVTNrl15MOqbljT+iQk/9vQRluqg/4HivZ0SlBckgqN5F5uO9N+QkxW22wV10VQr2VHaJldv+koOJp877NY180UcqkhSbP7RT3DTJAqz3+o2WsWY3QAKnkHw0Nbw9cjathPW1FDIpCkfaIrz+xWgl1lfuWXlo3GhoGP9S2N9SKa4BK3UOxoz33GyKDs2ydWvb7iBVaGxPufMkspRv6jpBzuB+jd/XxJ8ZWqDELd6ajYQxVa8wSd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 03:52:48.4037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9d9083-b5e2-4ac4-8e11-08deed24db2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379

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

