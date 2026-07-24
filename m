Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106643C7A5
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927317; cv=fail; b=YKInZQNKVajG/Q5wyz2KLAE5ELGyGjP+RP8tdxlIQxjjabgXuZNDhFT/u4LDHyxxdvAF3lIedE0A7lnDiMO9IobtDefBKN0Xqy5eA7bhPtYmumJJD8CENdwGffSZY4sbSfVBBxYhG0hNXvRAcRruT+Xyn36Bz7AB+XV6e2RFjTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927317; c=relaxed/simple;
	bh=guFpHg1GbPV8TsgGx/u2pKGg9+vP5ImX7ZjIvo3rNiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FPekI1c9Zu2C3HV2vcHN+Tj8sF2xDYydCw8BuW4W4Sq5vkHLx0Zszj2p/et0WgrWdXTiRJMVCEhXDuuO1ZXk/k7IDeCHIpvkQHuAEr604p0pGR60JUZxna8WME8IBqwxy2MDfS9AK8Ch1OJ53bjYYlwaimt4ZS1q3TuzuxL313o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z7T0PM8K; arc=fail smtp.client-ip=52.101.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z7T0PM8K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrIXWwoHAx2vkqtJGv6LVNwDwCAbFYXSWZ7EpM2K2GKKeQr066UBgkj0EXWuJTe9Rsyr+p9ntojtpuBu7uIpe8iLPQTiKZ3joqzmHeMtcANHMZAD/FjlEIuG01+gEbeYpx+bN8yvLpwfEIiMRiTO860CgtatmK5pZqZOWNAoDxjJp24ubFaHHTYHZacNUEvV2V8q/jOg9j3bKn4A545CYdGUFjGDj2ftBUnpzDFcKA3E6tVeePSjGEKqdIx3bppzt231k0n2VOv0kJVXsitGDJv6OeeVo8QN/uhe14Wr/dqrG4nJnR3McILC7jks4TzwclvhtAQyoUtpLSd1unA6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAyWVBDYfLR246USWY7ntzN5LazpiNAkWZV/4PFab9Y=;
 b=b7SQR0AX0cxolqG2VUAibiF54CMF3lYx4UnnloqPLFA2+sYyLat+T21i18RZRcdUnziFXkMjBWXMGtvKcSardZclegbc63Y6bD6SMWkPBWvEty2mDCkWdnVsxqnHZ3KiG5AXjiKutLeujSIbq874TilhkiQR5tc/zXLlLxGGIFQYcw6T2HrKl4dbbo/6a9lMjj1dcf2OmwdX1Mcg/ovctYKw5OVPaA0H5HWg5q5VRIPYmqg9lvSKUXTGI9JuMP7kO9ON3AD9hl2PzK+IPWIiyGn2AHDoWONyQI5bLMv/8xojgnq8C+20fSCG88R8aXhgt1tIzZZlmd7FG09SAGw9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAyWVBDYfLR246USWY7ntzN5LazpiNAkWZV/4PFab9Y=;
 b=z7T0PM8KEOwzyreekXwytAwYinXb+IshNrrTzi+75A4IWuWkOFcvGMjllf0KjUpgxBlH21BnVKppiNbXUKyazHl5R+GEin2DQWG+URGBfRDE4/cn7qgMBm97yDIe8elfM26lHeTa3cjeGgBKrrGm5bHac1yYZSOaeHuXTptVRbk=
Received: from PH8PR20CA0005.namprd20.prod.outlook.com (2603:10b6:510:23c::13)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 21:08:26 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:510:23c:cafe::24) by PH8PR20CA0005.outlook.office365.com
 (2603:10b6:510:23c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 21:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 21:08:26 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 16:08:01 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Fri, 24 Jul 2026 21:07:22 +0000
Subject: [PATCH net-next v9 1/6] pds_core: add support for quiet devcmd
 failures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260724-upstream_v8-v9-1-8425762b8b7f@amd.com>
References: <20260724-upstream_v8-v9-0-8425762b8b7f@amd.com>
In-Reply-To: <20260724-upstream_v8-v9-0-8425762b8b7f@amd.com>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Brett Creeley <brett.creeley@amd.com>,
	Eric Joyner <eric.joyner@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: fd23ecba-6b44-41c1-d363-08dee9c7b41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kEo9ERSbt5Vk9UIMlgft4OJwITRvbf/kcz0sUp59c1RFojF4J0ATlT8zog22kYXjxgihgER0s71oa3F7EiGugbcd8LI2nubpGO/L6Et2iO04lQEaB7tyLumVuXbYkAPPH6bQdfT2sls9iyrZnKrKJ98WDFaNobiLNNcFpbfukjh3ckbK+ZGj6mwYRczWNr78vvhWPstCtVi3sQdzjCAszn7lKlxMILPUXh56KRw3ouu/w15jn8wdXe+Kzbm41vdHKbpfZ0wCMuv/PRSB4GiRq/2AnI0zZNmgqMgr/IGBloVRGr29nhqTOSDx5ZSkDVa6Ept59u1+omCLI70Y7ON3qLp0wz0x3R//eour2YWB7ZtwG1mVEOtibKXuY9yb6pZ1WjNDelexX7kn1FQOkFcxHXWNDjCLfMFtuIL+wozzExyMVv0OExJmrIXxWVWe6LDg72aa73CU17CrkImnMosxcVi9Qs/mH45mIFnHLXcAaxk4KJYUMckOlH7cDDBhz5Iho8H5KLbTmw84wa9bMv79DR1xFok2mTAyQMl7affTKtfdYxrtU2nXyEbrutoRu1AXqwyeJEytkTwVvC4mvoff1/CyniC2ZeNN2ah7uowD24mp7SlOYZlBpu8FgVSEiJlowefPOeEvM63+W8JcS9uPy0EH7sOtXdEBfKTa1vHFF7kGIPk9HPBeT8JEYdts7XiLTbZRVEdUYxaEWHpyY9+TDg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B6PynZeGBU8xkbLS9o0FyVUx8fYDavV8JAQr3vqdoNmwmcOdKWn2krIvBGdlD4sk9cWzQAVXbooc2dFcXo+C9HfQGJvqLVxgmAxHrxYCll/p2pFBNYasHFStsj3lCevXTq9w1zedU5Q4Z3mgsKwno9KN7Mf842szbcMn3qWJxlCa2BMp9PQ47iYOO7Euh8kdZEEqB+vP/jVOzyyGSipbTalhSu//ds/7b9QnTbQIdUKgS1+zSVDw8HTNzhULMY0/rRLBMsh4xB/zCCNqy9cTaGJs1fZRvoKPEZlPkjK8Fbm8tP/MF4oEe7UVRhFhcLF4hj+ZkIH++5hoM6hND/rm4MObXgp1b90Zk9pCBRC71GcuNvfbCc+kHpnOAktRC/RtHPuNz2zgclkw99QxkS56LpQijNY8m/xLpPyBbuoq9EMbmoXHsGj3Vh+CxK7h45jM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:08:26.1721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd23ecba-6b44-41c1-d363-08dee9c7b41b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148

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

