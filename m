Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C73890F6
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170786; cv=fail; b=QGqgds196/VeCmIEA609F3yjdl7P5NHY7uW1PlfuXSnTlhF5AFAeHlT9DoUWl62NpZJ1N4aoG35pF8UjWu3zIJvafA62SLVnZYR3GjM30Rspy9hJhVn1qWyR7BMlefuKjaQucITh9dLtk2uFCuWjmCF1VfphS7gNFgq1JAENt3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170786; c=relaxed/simple;
	bh=1Uug1s3aO0AUMV4qKldg+si+q6qtaF+67b3ee2/BCrA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kc6C+hkFKp92RVshxg3/pW8bfNS2t0M6V2GvdP2OSe/Yrls2HlqT7aixSCi04rMh0HhwLdOaS2JZp7pxsm0Myh0vKXJRXH5QZVPFitXSOx0fMDOaN7yhWpscdv5yMJMjHnhQxITslsC3TZr9fgptN9sl7l208/dAcRF0lXANXmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3nOc5EFH; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3nOc5EFH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnEmi1UwrHjxo/PuQcrwIpI8fGdtOezxdEc4sJfBsEiTEGS8ihwunC2Jik1jbNj4EDN1za55q/uGcH78E7FW9Xtwy7gTilvE7B9n6W8aoTnt2dr40e7AiVVrAN9bVnCauaWYJvP9eEUYFdtY/kkBLlp2ywRt89v5VryfpLFbZmCwK9lZ/+K768omN1Z7EjJNVuB9zGF92JdovdCN9NbHM49qt+g6bRuNgfb0zhRvixAN4YAWg1sH1i9njZOn4OXijK3zvmXsn8py4tYxgYtFB6IxEYY1MCuL33ZXpbeYkhfYeAT8PJzaxyxUT9bbzooUQWkh/1CD/CkOYiiglIOdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou/yEKjfAxbHnNTCCJninrU/UEBPsuA4tpvsuHBWcms=;
 b=co88yzXT7EZACK4q3si0l/xEWxcu2eSq3/l6tIaKATzOcqQtoDRdKIlO2hMBTaarLQrmGWvLbNVTfaiwToeQagW+47B0biccT34hyiWYVvMrn+s4MR5ClMaybXisdiEos06JWcB+Ptc+EwX0Bxevj4cpTzhz5n2L52EauAhGhzu07A4tHy4Pu/y/OFnbH51tMJl1Xs+r63Wg9AdcYsNK4Tw5obOVGwvjlmvmlsISvdqwbXRlmNR2+Kixdlg2JnYBPmev9Mg3LRbz5Xi7vg9X7lG+QFZ8FdAMlePQHL8TVzuZPWvB+TF57Dld1ILdPk1GQxsus0Tkoq64KQfMQo0HCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou/yEKjfAxbHnNTCCJninrU/UEBPsuA4tpvsuHBWcms=;
 b=3nOc5EFHwxB8q5J3OkxWVXfqQDYnPa0P+fDyS7r0FWfskXaw29+1m9wFTmC6oGP1L7Pyn4GmwAB7BlEmA5OX31gs3eVn1PhV4h6cZJB4QfBen7paF3Weux86pMPYZPg6anZ7cLxLaDeiCQjNh1R+E3lzjHrUhURTCxfltggEwhI=
Received: from CH2PR14CA0039.namprd14.prod.outlook.com (2603:10b6:610:56::19)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 16:46:18 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::aa) by CH2PR14CA0039.outlook.office365.com
 (2603:10b6:610:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend
 Transport; Mon, 27 Jul 2026 16:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 27 Jul 2026 16:46:18 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 11:46:17 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>
Subject: [PATCH net v3] pds_core: keep the health thread stopped during reset
Date: Mon, 27 Jul 2026 16:45:48 +0000
Message-ID: <20260727164548.359562-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7294d2-dc5d-4ebf-207a-08deebfe94c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|11063799006|56012099006|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	QgpBhI6Wi71i5dCXTLm7R9iAeYHAnnUyQL6BycEL9b5mnquYrFsiRD9n0+FxgourVs8mVdNWAh94eWM7qp0aigw4XkJvg7pNOSYgC/VRzjba3jhjoeiSZJ7SODaj3PNTC9dGJhOLlQxJwADPp42enVXZVp0R8yYAc3Zgd3BkPJKx6pxlOwxExTyEFCoMYTqQX76bTkNI7JGORg2+w2Y525xf9EVOlmzw42Mypld8RqAsGG0uxH3xEBEI9M69FB1vy14o8dihqEAyIgpFU4xUteNioCXevS5ZfiOJL6fxLJYZexFF3zLdCmMclHixrktOOBQDKsLsXIvgdfYfy+GSC6cNjtEKbts/c3uXoDZdZ4+FOPnkWdLSZZZLFbEGMSTtm6UFOsZHV9LA2ivlPlb7TPoWdiZaYrkXRHmeBOQhNWdSHMPLro8/kfLAV6mm2T8lTk879wvc7OXJOklYvSQs3pncD5G23JM6Obcv+hvnSibaoK2JSO7/yi24MUPLMQqM7NABPTX94/DKvShEwAh34919e/AI5z/752Q3hK8JUHr9DNFaTvNtY3ii/niEKlaMDtSiRIBW7Zv9r0u+C2/XIpEpF2VVa3O99xlIcYp/6Esq6Ln6KP5PbAh6+3vqLRYywR45/7NIE+gAAqKyNTTRSQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tk24Inf0NOI8dpfBGURlcekc2jJjiPgBxKe4UPxSix1yTXJE2SmA5eKqoH9mXxdtQg598MajVzg/0XKxqla83MQmyeVMakYL4XHdyC6gc8pJpRkgcBCLCAWZg7trLDTXBkIIMtUF8xhysPUxFoc0ZxXF+SmnjcnJdGnU33VhB8Lh0t2CwlF22dYi3f9OcRdS/td6C85UfhnSepsH9mquv+Yyx9rou0nVGk6/3VLVIo/gWty3KfTTVVc4uI+xQwmqBUJXVn3c8Z2t25fe3bMj2VG4FUgKVLvXYz6E638w4tOQ9opcpH5lLnZmqy0G9yHTztAH2ZQN6n9Myo+4qFcwe44eUbPv/CZxF/c6eMUgFgujiiFk4+LyEc84DYRgJ/OfyeiaPaBf8IkZSLdym6gSAsAVaJHCn1gbUpNSqlv51QBLV+vZvehEzPlKavonTByt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 16:46:18.2869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7294d2-dc5d-4ebf-207a-08deebfe94c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804

Commit d9407ff11809 ("pds_core: Prevent health thread from running
during reset/remove") stops the health thread with cancel_work_sync()
before a reset, but a devcmd timeout during pdsc_fw_down() re-queues
health_work, so pdsc_health_thread() runs again mid-reset and double
allocates the core DMA queues via pdsc_fw_up().

Only the reset path is affected: on remove PDSC_S_STOPPING_DRIVER gates
the health thread and the workqueue is destroyed.

Use disable_work_sync() to cancel health_work and block further
queue_work() on it, and enable_work() in pdsc_restart_health_thread() to
re-allow it after the reset.

disable_work_sync() keeps a disable depth, so every disable must be
matched by one enable. pdsc_reset_prepare() stops the health thread and
pdsc_reset_done() restarts it. On the AER path pdsc_pci_error_detected()
calls pdsc_reset_prepare(), then pdsc_pci_error_resume() re-inits via
pci_reset_function_locked() (pds_core has no .slot_reset handler), which
runs the pair again - stopping the thread twice but restarting it once.
Gate the disable and enable on a health_stopped flag so each fires at
most once per stopped/running transition.

Fixes: d9407ff11809 ("pds_core: Prevent health thread from running during reset/remove")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260629200358.2626129-1-nikhil.rao%40amd.com?part=2
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.h |  1 +
 drivers/net/ethernet/amd/pds_core/main.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index b7fe9ad73349..a1d41329209f 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -171,6 +171,7 @@ struct pdsc {
 	struct timer_list wdtimer;
 	unsigned int wdtimer_period;
 	struct work_struct health_work;
+	bool health_stopped;
 	struct devlink_health_reporter *fw_reporter;
 	u32 fw_recoveries;
 
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 8d94a4d70395..71a1d4b001c2 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -470,8 +470,10 @@ static void pdsc_stop_health_thread(struct pdsc *pdsc)
 		return;
 
 	timer_shutdown_sync(&pdsc->wdtimer);
-	if (pdsc->health_work.func)
-		cancel_work_sync(&pdsc->health_work);
+	if (pdsc->health_work.func && !pdsc->health_stopped) {
+		disable_work_sync(&pdsc->health_work);
+		pdsc->health_stopped = true;
+	}
 }
 
 static void pdsc_restart_health_thread(struct pdsc *pdsc)
@@ -479,6 +481,10 @@ static void pdsc_restart_health_thread(struct pdsc *pdsc)
 	if (pdsc->pdev->is_virtfn)
 		return;
 
+	if (pdsc->health_stopped) {
+		enable_work(&pdsc->health_work);
+		pdsc->health_stopped = false;
+	}
 	timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);
 	mod_timer(&pdsc->wdtimer, jiffies + 1);
 }
-- 
2.43.0

