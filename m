Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42D46E003
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650937; cv=fail; b=ZXv9YuxRmZndisY0dI4EBq2eKfPLKRzBauBWeqLvyxHZHPpvxtfk9Qvu7Dux9sRZemqZihCP7+z9IfXjKXp4dznJ+MuMpY8jTwRPwy2n9cq+lmxyzI+okdJnsWXy+kWTt5TvihZ35fJ6uyYR6IBLe+8S+8vyO0yodv1wzYjq4hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650937; c=relaxed/simple;
	bh=OHASZ1TcZ3i3FtcIqzFc5uUL8SrhR89x4ow15+61kfM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CTOAjLcdLQM4BmSeVkDHK0Oe8CPN1CREfO6zyAZhd7FRvDaN2/MwpZQ+7W1LFr8r/7+iMdXIuPInhS9znXXn05q2jgFgqu1LwxmDWms4yjKDqZEXvSHAWrJB+PvgZ05H3SKUCOjzf7Bgbn7vjx59TveJWOAGwi3m2OnNJ6GbXxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5WAytN2j; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5WAytN2j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOTX8gJmAeVs3TC1gdQpE+d6GCs+IW4tVGOD/8cdjBhk+jmNa3UpjdSOEjRQaXlVSaMjlGU44E5kUSYshPruzKQFrdjzL3szwJKpZVPt/WgKfZIj3OkST6iIwx/nTUQ15pJoVqRMXvUqL3cf6yb7lD0oq3xFb2asISskv2ZCxPFkF8AXKEYVpmA2VF2DOd/3i3NNmxUavVxjTVkIOW9hqhLvrpGV1kGhRTG3kZmjB95BKdibqapY2KwEqzGzYjE/Vmq2LT4uNRqkC0nJ6IQ3PtdarVdTyR6u88iqpQ8QYly9X0l0if3FvGoklWRR+61avYyDHWgp79vN2jW+Q+BhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHMhGvUkSeYRAHQAOe5lTjeRdU51moRrTU8lLNBr0YY=;
 b=EZ5JayDZ7k8Xto9yCqO2BCyr4Ugw030oyaGuEMqFbtMRpA5XMTE0OsUZUikPPDd44qQ6Wkg8QvIAsE+WqspCsEfZ/OceFlx+31XfMwTGeaCoORnwpvJCepUdjxWUGpfr4QiEpzRbz7du8W5NppN4+Wf1137z+UNM9ErSlRA1CCK/do6QtoU8lU4Pw+Y7g6BQaXyptcFSQs/BuBBzskhoOgq4ZvyQJ7scLoxTcVpPBuQSGPOOSLgRuIAMAbixAWKgscPMnRHbr/cDbAsk4HQ4u6wzoq+WXkuMdWqirP0lF6LwcjXtGigoWyFCLWIiWhMilcaT+AY4tgZ1nYfFJCxYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHMhGvUkSeYRAHQAOe5lTjeRdU51moRrTU8lLNBr0YY=;
 b=5WAytN2jHeHhysuoCEh4RnBkRjqAc0ee/4BbQh6UqewejCmwz1f5FAebfZQX6QnELlwyJrYfGX1ErgTEWmbJQRRvTuoqDCBYT54rm5ckBsZHv/ZJA5F1ZMSjmz9m2o2GwH6bflkH7XZ8+RTC6d+cpbjehj+Cvp4litePvzYCWSk=
Received: from MW4PR04CA0258.namprd04.prod.outlook.com (2603:10b6:303:88::23)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 16:22:10 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::67) by MW4PR04CA0258.outlook.office365.com
 (2603:10b6:303:88::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 16:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 16:22:10 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 11:22:02 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net] pds_core: keep the health thread stopped during reset
Date: Tue, 21 Jul 2026 16:21:41 +0000
Message-ID: <20260721162141.162153-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: ef24332b-b759-42ba-7a0c-08dee7443724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	vCSC778XasRAY0VR5oYpYpJ7WpJrfwm2QOyeATxcuFta+gaPAmveFZgkDuVlOSg64253635CXY+qfKodT5OQhpEo/LBYGiFFHEyKK6JW3WRF+zFc6j0NWT8b4VrEWAoBsTVO8a85kcJak30Pn1H/DjvfLNqlMhqps8mbx5BXA6lepAROF9OrE8QbXKyNmu347VtMZ7bIri8kiwCA0QvM8g/FcWPfjhsAO52YhjhHtXVs33HpVZICyvjUb1xAa3ZZ6BnPNcWjx8jiWfhYpuTJQGUD3aSDKL2LIIxp83MIwpzCAczGUOUNacYh/y+XJj9nlq3TPc2kSFqpnlN2ctKaGMdRg7LtNWFyI+DjiqNN3uPudAkEW4gS2HApBLgPbOLp42ALJCxAZpbzNOULKRsNmdixc71mKsG5F+o6RB5Mau2Phnm/kepq283RKPF0iNfGJdKCuXkL8xtPWyNeu5nzfIY2qrVpnIL3C14sbrcAWAYh+2UIi/qNfTQE9xj1E6Z/n6XuKU+5pzSf4H9TwoSk9LS0ofxUwPhktC+kPNjZTfb8UnqTIw6soqs8JJWcX9qcGZEQLig94lDAcgibqovikmAb+uhNzNlflDfVLi3qZVNzwyT8c3opvTe/sVIAhu0nTmCB3sP2XI7YoRPINk5/TQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hrdcGgi2HbiAKSg8dCgveBtGy6IQFDxSq+3hZO+744bpJ4jQfhNF7iVL2pUprqD6hAgnRBVNJV4LwuVR9AzLLH3IdmA7CLjZt9Ht5K40N44wfPPPo8aMC4PDe6xCbECbJvvGTuMuDG1sN9xT06IaFoH96bIAuwHkG0K4AertI/ZqNeJqoq/ymmo2aFqPeO5Sm+AZjgzGRux83tOHLwTnYFjA/9IZsk7198ondGoX6SNW9J7pmtK5M6VxGqojyjOI7LSmNZfvGypfS6SNN0KwqjV1wKpIpHUUqjtx9udpGnxZEH8AeSeVn0wI7YcaUKS/7n+eRV3XF1TBE+MKcAAmruHrHq4RbDselV7Hd6IEf+xAxPi45moPdnydt2ctCK9tWbEBFRCjLhmIoft0UKKzZyHW8FGnYFrC3tOaelwO/6Z9fyBrpRNGexpkltnOifVA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:22:10.0776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef24332b-b759-42ba-7a0c-08dee7443724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806

Commit d9407ff11809 ("pds_core: Prevent health thread from running
during reset/remove") stops the health thread with cancel_work_sync()
before a reset, but a devcmd timeout during pdsc_fw_down() re-queues
health_work, so pdsc_health_thread() runs again mid-reset and double
allocates the core DMA queues via pdsc_fw_up().

Only the reset path is affected. On remove, PDSC_S_STOPPING_DRIVER gates
the health thread.

Track the health thread's stopped state so a work item queued after the
cancel bails out.

Fixes: d9407ff11809 ("pds_core: Prevent health thread from running during reset/remove")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260629200358.2626129-1-nikhil.rao%40amd.com?part=2
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 3 +++
 drivers/net/ethernet/amd/pds_core/core.h | 1 +
 drivers/net/ethernet/amd/pds_core/main.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 38a2446571af..c4cba7194da0 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -635,6 +635,9 @@ void pdsc_health_thread(struct work_struct *work)
 	unsigned long mask;
 	bool healthy;
 
+	if (READ_ONCE(pdsc->health_stopped))
+		return;
+
 	mutex_lock(&pdsc->config_lock);
 
 	/* Don't do a check when in a transition state */
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
index 22db78343eb0..32e1d7069969 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -463,6 +463,7 @@ static void pdsc_stop_health_thread(struct pdsc *pdsc)
 	if (pdsc->pdev->is_virtfn)
 		return;
 
+	WRITE_ONCE(pdsc->health_stopped, true);
 	timer_shutdown_sync(&pdsc->wdtimer);
 	if (pdsc->health_work.func)
 		cancel_work_sync(&pdsc->health_work);
@@ -473,6 +474,7 @@ static void pdsc_restart_health_thread(struct pdsc *pdsc)
 	if (pdsc->pdev->is_virtfn)
 		return;
 
+	WRITE_ONCE(pdsc->health_stopped, false);
 	timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);
 	mod_timer(&pdsc->wdtimer, jiffies + 1);
 }
-- 
2.43.0

