Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548A415F25
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661221; cv=fail; b=Di1Nxt537gLRDuPG4RO8ikLpdCuCU7XJpNl42PAh5jBLuNBn+d0Fk9RhPkdmoyK9N633sDnHrJgZAcMfrZyvDN37cjjXpOixQmkAhcy/Pr8yfzUOGi4j7vmfaGY9+2MTLmiJnuu1qsr4BggCXFA+8i9a4Dz0mmELxOW5/SaP6zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661221; c=relaxed/simple;
	bh=guFpHg1GbPV8TsgGx/u2pKGg9+vP5ImX7ZjIvo3rNiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Es9ozkE0R1d1mFfOe5tGNp/+w7eVLwgjUOiwwdTc1IFqW2FO6hTyjPz7Qf218uGxpJUi5hQ5jIQUikeFEcjPJ06V4YgJEn0YKb/hnN/5im/+Nh9Dgge/xf98Ka8bpktkXYSLtYBo4HduS4/hEmnwdH1XJre5Fr9PB9YQRPBVTZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cyiyygif; arc=fail smtp.client-ip=52.101.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cyiyygif"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hv6CeTflDuNKY8hN9aqCK1OjqLaX6FRgmyFJf9RiH3l4mGCQPUXG+xNqYvB0pdkr08MqDwNsoG2FQPrzzDbEJdh1SlgYCORq3E7idy5kahjAo+lBCfBJIgPnt/yD00Tkc3kbxLxa488NCgdhTn+8x802Nz4TMrXPvTHpQInr4PlKPjE+DrcVmWlx2oOij9pN89Q4s8naG8DyCZWmEBSEQ15S5//K+rqVoSZW0wihpCO3vZj0CUBYTW+/0Xy0FG+DTTJrfg9oNwu0Pb7lLneiCH2MxQgcBNIdPpWflSatlZuyFda8rY4+v3mv4JaHUACnKDQhaqBeqtHWtYLJYX9w8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAyWVBDYfLR246USWY7ntzN5LazpiNAkWZV/4PFab9Y=;
 b=p5dv3QDDlsq27Yuj8GIGs04QsP+tDxL99X5qSO4RwnjL890Iif3zvLffnHsjGTIOmhbhCkz5xlvOAA/LRXGEvwUNTYhIrB4Shu8Y9FPZyaKQ+CDmt3dGFK/79RDU4uaAKzXcXtNfTaexkq8DIfG9C0o8gSze06DJS3MJxbYBVgl4vF/+D0x27D/MYCfUJPSIUMaPhxGDqiKprObQvSYdmU8pCTj62QSSx4GbR8XJl0Ip4BLZDohXQoBBHe6Gfnkq2+0AgSqIVCVTfjEoRdqqZxvMWpjBe8W9KyzAMRAeoT6AGK/6kqmDRz34Gci7toheZN4AGWfZdw40JEq8AE1rpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAyWVBDYfLR246USWY7ntzN5LazpiNAkWZV/4PFab9Y=;
 b=cyiyygifyI4O7ibHG8ZMGte2wuCCPk21H8YqJffZ4XDNLq8+aILLwiSjJ2AQWPswanp6zU/1ARTAAV5/RGoS6xM9RIM7PLBBcieo8IgXGWABMr9+mogfUXey3goRBSiA+fX9lgCSQQpzgtv+7cTuOdsHR4u8SDtuRCt2aH0FY5E=
Received: from DM6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:5:174::20)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 19:13:35 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::93) by DM6PR21CA0010.outlook.office365.com
 (2603:10b6:5:174::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.4 via Frontend Transport; Tue, 21
 Jul 2026 19:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 19:13:35 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 14:13:34 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Tue, 21 Jul 2026 19:13:09 +0000
Subject: [PATCH net-next v8 1/6] pds_core: add support for quiet devcmd
 failures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-upstream_v8-v8-1-1ea9a8b7c4ff@amd.com>
References: <20260721-upstream_v8-v8-0-1ea9a8b7c4ff@amd.com>
In-Reply-To: <20260721-upstream_v8-v8-0-1ea9a8b7c4ff@amd.com>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Brett Creeley <brett.creeley@amd.com>,
	Eric Joyner <eric.joyner@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d075e28-d23d-4acf-c251-08dee75c2985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C5/lPU4w9ADN/AyJpH+MS6WjXR/IABxYDgykNI39DyLsyvgM2bzZ/xaUEBlhx5SH633ztk+sFcR86Za2ny6DZHC1wg0UrRjfh4s6+g6UnXDYkjwuEV0n+gYAScVveWoMNRYyjbLzqQOUhY1o0dQeVltKAef5VDW3fYNdRqPETbfqjJNbZkPzSd6GVdVvYrEH6vPg5GjXTRJa8VDLs7sp2vAeXNIQeXhzOLbFG3ZWchbNaV0izeUNpK3dOwRoUuyudbOGh8mNPUT3EMVNBtiMFOSxe8fZ2x4sCui10L5l1oojiYepJo9cagmj6v4bj5ZehnMF/v23U5TeI5dSJsNdjc2XVyHNayTUYb13EeTNzzTIKVMnHhVkmFhb/zgXZ2lSOtgQ+sztJ523+yCOSSDhxTWWb1KaIP+qGfRghbIeeBJtkOyKeGr/Ro88XnGaX80Kfku2Nv8jcRbBV30wn4nCeL5/RzH5KuRWf0vl8G0CuA11H0ADLJvtzOh/Mml5A1qp5WSBt18J4IiRuY693Lra+4h6w8WAtvGtAdACxu3sU4mXN+c2fevpRm4fRalgodyEJzyu1RaHTVfS8wylUct16GOHCasIXFSTzFUUqgnCmFOaCnaARPwngB9PO6Lrqb3pfZ7PSyvL/oAt4SmUJrlNnNO5URasdEhs0ejI/E4HVbkmQIXWHyODmfLnuEzNw/APRIODqTYTuohEb0mkS1PnbA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	maHknKacEOUWSQEu4YCVuGJoG/T8LtbsT96GcGLGYPPxVtdWyJYVCPeAkd1n2mxx9PGBsHKOo58PBb6MxikYkoh9B+YBXvsZxwWuejTYR5TmN4yWAQpPIQ3S0CUmmSfIbJzSjZ+8tqqS+kGpj/XAHtTIGOha3O/qrPWFpE/8200U7pOKewnTY9Ew9SyGZa0phPfuddK3Bc2M6NnN4RrMBwOEgvuxsg7xH8Gp7iwqnfQliE/cdd6YSQ4kp7xmNkmt0wb/MRctU0XtCHkLcvHN0Ryx4tlcB/HIsCEUErrP1qDl1I5lYn4wfhnmHgu8wYSRO/mSiOXVpJYfD6COPP883II3kln/ix0wYm86vaTVhJYYt++duUZ3w4R309Re4bWrHFOdXBUM2+EEHse2slj2OG/yHj0+PAvRZGKMDi5aPEy/rJdkemdG9aHa/fsXwKhP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:13:35.2416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d075e28-d23d-4acf-c251-08dee75c2985
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171

From: Brett Creeley <brett.creeley@amd.com>

Currently there aren't any use-cases that require special handling
on whether or not to print devcmd failures. Specifically
non-generic failures, i.e. not supported failures. Add support to
allow these messages to be suppressed. This will be used when
adding support to negotiate PDS_CORE_IDENTITY_VERSION_2.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index bded6b33289c..dd9989cfe6b3 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -126,7 +126,8 @@ static const char *pdsc_devcmd_str(int opcode)
 	}
 }
 
-static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
+static int __pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds,
+			      const bool do_msg)
 {
 	struct device *dev = pdsc->dev;
 	unsigned long start_time;
@@ -179,7 +180,7 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 
 	status = pdsc_devcmd_status(pdsc);
 	err = pdsc_err_to_errno(status);
-	if (err && err != -EAGAIN)
+	if (do_msg && err && err != -EAGAIN)
 		dev_err(dev, "DEVCMD %d %s failed, status=%d err %d %pe\n",
 			opcode, pdsc_devcmd_str(opcode), status, err,
 			ERR_PTR(err));
@@ -187,8 +188,9 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 	return err;
 }
 
-int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
-		       union pds_core_dev_comp *comp, int max_seconds)
+static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+				union pds_core_dev_comp *comp, int max_seconds,
+				const bool do_msg)
 {
 	int err;
 
@@ -197,7 +199,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 
 	memcpy_toio(&pdsc->cmd_regs->cmd, cmd, sizeof(*cmd));
 	pdsc_devcmd_dbell(pdsc);
-	err = pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds);
+	err = __pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds, do_msg);
 
 	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
 		queue_work(pdsc->wq, &pdsc->health_work);
@@ -207,6 +209,12 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 	return err;
 }
 
+int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+		       union pds_core_dev_comp *comp, int max_seconds)
+{
+	return __pdsc_devcmd_locked(pdsc, cmd, comp, max_seconds, true);
+}
+
 int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		union pds_core_dev_comp *comp, int max_seconds)
 {

-- 
2.43.0

