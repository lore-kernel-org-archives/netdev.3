Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012009.outbound.protection.outlook.com [40.93.195.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0F42D748
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171660; cv=fail; b=bSIEN3towF76xgFyI906jS8VLlIz4pEpVZMPlgs9g4HhiY9TfW3IdGz/2C/RLnBeWN4r9P8ZNPMGEprbgyaJyRNUHgqy20W3eOf+LlCpEL2QLUdqJeg+Dx/oqI9FUGC3yT4UkAV4R8+seBqGRr/Z8xSpeHLhc/zAHy7TrQA2kRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171660; c=relaxed/simple;
	bh=hACplMkxrf/fVPr7D6xxxlqiUawbOuuewi5EFN2aoeE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hhRhrMr6ZPTlbD3/TFR+YSWVi5Hrd7KB2cv+eO0hem1ypDnE99IPhzDXvQ020shgQbvg/lWFloKg5dRQMtcealB24HtUSgkgu3HOhTWsbI3ByeICiPOFz8QLlNOQYK2WcidaeYlU12G9z3ZNjd5T7L7GmmhX1TuNdGWSVCTDzLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P1+F2mbf; arc=fail smtp.client-ip=40.93.195.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P1+F2mbf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNXr/jVpNNyHOVSeUGonFwS+FQMAf0vWUKAA4bkj0fF2IZEoR6oRrCgLZH1sdziV4FPPvOGAzhi5MKbo8NM+CiJGS1PJN6kZsE5jPxdlCpPmzoNS2qr1P4y1CjJfXviR6mar+iOrH3jWLmWfhxwsu0lLiohVi42tg7VGsSBRooRfXeF13EK9UFkUlTBpVMW8dbwI2lMocaZabIu8kmZLshM0eu5b2q7fFgoMiZy62QA9sr/OeAAdRL7o23xukxU26PPF3dzyt+b2voOM8EHWH6ROCAZTpizbapx+fe4sFEisVhrLPDZNhmUThLb2A3Z/RBsChRHNtdoBywrz/IGKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/FWWTdGOy8W6euyHA++TEgR8ndRbJrRAsYZvaotDzY=;
 b=dAg66jIGWyvnWVJPTDxQF0eoZSKSd8uxyzbAS6WItkCGUyVJ9OozhU1flJIxwlz0+3R5l1UHTAUV5nX0td2F8hJP/eHw+vfWcdGUA/QgRsDselEx5wcwC91HXFDtnXYGo/1Vsumffwl+fC9GmnC/tNLm6rU0732OuFlLzBtW3xHdme+0c8SSuegee/7VIKt0dMkUGCWXIytp5+xZ6/EvkJTfR4/gLzP+nAs2SvpVbO7LnfPO48GWB1m8h4faSoJrsFcl94jWdmX2s3/ZUKHeEcaBw79CZCfAqipfuEhlJmSEtZx16zIapRN4ViRw2AF1ttyaKpoe+hcVX/JBYhJwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/FWWTdGOy8W6euyHA++TEgR8ndRbJrRAsYZvaotDzY=;
 b=P1+F2mbfCj/WEvkf5BbuLmIsxyzfn0MEOHwr9WW/KgoEDP3BGqmhV19H8ldUXFnSwu0qwfgKBkW+fgt6vDtjIgPyV86+jL//Gt3tkHvE6hWo0AjW/shvf4ykGdGbZVsIXiHwQSRBkTxYkpIRe+HtO9NFlKXaUcyQITgOIE9EbzE=
Received: from BN9PR03CA0801.namprd03.prod.outlook.com (2603:10b6:408:13f::26)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 17:00:50 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::2a) by BN9PR03CA0801.outlook.office365.com
 (2603:10b6:408:13f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 17:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Mon, 27 Jul 2026 17:00:50 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 12:00:49 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net] pds_core: cancel pending PCI reset work on AER recovery
Date: Mon, 27 Jul 2026 17:00:30 +0000
Message-ID: <20260727170030.361116-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b080ec-cfa0-4d09-f751-08deec009cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|56012099006|10067099003|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	4qGxveC7ul2zbUDantEeJSYKR9aqunbRrYf/xX8LpLNZZYwTMOcRPm7USoNXmT+OFDVG+v14/6tutTG2tNDs/+0j64xLWeruuO8NE5zprzq/5KRQm55TsMZAvgiQZttjNNO5fuC7yzJdAgMqjsqeb2fWmbTLiYsClkKmy7svvxuZJ++Lva6JXlURmZ0v93RvU6NjLi8QPfts2UE0rSbxwG1Bw1DO1H25Ruqrn23GUCGwTCDqKv9WUvta99SIaazcZd5d5XOZpTYmkDV6sfjOF3KmzNg3XwyzNin7IGgmf1R5hlUJdhD85d73dlj6+EwvX1UPUrzDwKTmyGNkgG9Ur/ZxiVROjhSyUUjfFbx7q6yUTVWunyKJIow5fT8QkS4bQx6GH9++n4fsKhtQe0j+T3lE7fqdkBtTxlI8FMiDJ4DYlFIAy+/lQOjydH2sy0s5QGymaNE02KQr7FAxsUogFPUiH2YJhQvs+jvkf7l7ZvyRQmpOjOK5XyXPxDToiPbOnFEONUH8i3MQybgGJ+D1VHfcQZ7YzsgNIOCniDKaRbE/QnkPvLetDwYA9jTnMwaJCcXMkKmCszOyILm1Rk1D1bMtW3Zc32/xnUCkdFA83/5sBPdIERhUXwduHsXJLlwPbvVr/ePnd+hy0X63Wa9yJQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7M8q01elaPLYmrayfJnzqr1riGX7hTPdWUmjSQvF+OGoGxU2lWkueGUbZaPOsA3n0bfyQ0j//tsJbEyzFamuu4QW0ATWTEHdW9Qc3qN4mubePvZzJvN9jOMdGgoZgoxv+SU+mDS6FChmlEUR543wPVZxMWeuSIHJhIksvhefJy4Ysk4i7yVmZovH9JDrWnMIaiXgmvdite7Rn4+PQ+8T2Md6JsPMgWEn2Otc+LQKjZZyyWxSn1PCr6Vy7W35lPz8Wm72Qu6eeK0U/6MhDSebD6UGFldZlmDgmhbdc7M6uyfaLXvzi8o4r9wH/IH3EyIkCUeW+tnhFgk/r1egwGWkWdEQMXf/EBgJJyUmEYfgPNlA8V4l4uG1m6vfpJ1Zux7SeoNiriuwo0yX0gPUhYoqBqCfCAtdqCpAAFgi7TK4jprruYlfYQ9c9J1PAr04HzXG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 17:00:50.7005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b080ec-cfa0-4d09-f751-08deec009cc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208

pdsc_check_pci_health() queues pci_reset_work when it sees a broken PCI
connection, and nothing cancels it. When the PCI core starts AER
recovery, pdsc_pci_error_detected() runs pdsc_reset_prepare() and
recovers the device, but a pci_reset_work queued just before is left
pending. If it runs after recovery released the device lock, it resets a
device the driver now considers healthy, bouncing the link for no reason.

Cancel pci_reset_work in pdsc_pci_error_detected() after
pdsc_reset_prepare(), which has already stopped the health thread so it
cannot requeue the work. cancel_work_sync() is safe under the device
lock here because pdsc_pci_reset_thread() uses pci_try_reset_function(),
which returns instead of blocking on the lock. Only PFs initialize
pci_reset_work, so guard the cancel with !is_virtfn.

Fixes: 81665adf25d2 ("pds_core: Fix pdsc_check_pci_health function to use work thread")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260714180223.1642792-2-nikhil.rao%40amd.com?part=1
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 8d94a4d70395..1bdfa9893904 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -555,7 +555,11 @@ static pci_ers_result_t pdsc_pci_error_detected(struct pci_dev *pdev,
 						pci_channel_state_t error)
 {
 	if (error == pci_channel_io_frozen) {
+		struct pdsc *pdsc = pci_get_drvdata(pdev);
+
 		pdsc_reset_prepare(pdev);
+		if (!pdev->is_virtfn)
+			cancel_work_sync(&pdsc->pci_reset_work);
 		return PCI_ERS_RESULT_NEED_RESET;
 	}
 
-- 
2.43.0

