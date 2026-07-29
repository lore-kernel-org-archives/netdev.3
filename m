Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F934A77D
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785304404; cv=fail; b=N2luWz8nQTWL5I6qEp7SNbqoanqwJ9kQx30bpBowOP13n+6g3WH4lFtW0DLf7awjWZXTTfIv34cBabsyb015JeOtY2/1CQFr0kv3EmkChdNQo43FE1zmXB5+4zPE4Ie72u6EoS9hKmfNgkJJU88XjA9mgNjCEPn3kvh+dYZB5Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785304404; c=relaxed/simple;
	bh=V8kFjC9JIPAUVqsuE6LCMF+A+XFKKbAOnjKvcwUboOI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o0VGPYvCjD6ijNYTULh4lcc5HCJz91iCJnDjF0JXav+RTMXEA8DNB/H16a7zHhsnxfa9Ua40n2Go6xqzz47A+x9UQHwbZDT0fwYY2nKGHiRxMTNj5XNY5mApUPoiszZpzV5e0qaV1wry0UEPfA2fK05aHF40DruIwtX715ckl9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y6eG1d6P; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y6eG1d6P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ruw7rKSsK50ToFqCR7OoCLZ2JKSoBY/7BKWvRGWws4/F4YgQsmq63xqCcKErwLUBvgDh4WseS6aQ2+OxtHfp++kkU9J/MYKpMMMBs719wB//qRHK3RH1fwhZcdNyJDnW/wIvnFibTJKsmT9HPeoTieqtoHvBhO6mnO/jRW1HH4ni+AwzimbYw+Ce9qY85SEEwJHiw7KaAf1FKiBxQ4gzwwU8XZxeXkdleE4DYvHD8FCP5Aj8+lZlMCUDXlfvFvMAevK190k5zZku38ABOcmNTLUZR3gR8GcvCyDpm6RXovgq4dy6obwgrI4mIK6uk9J0YlAB6uAvn54DtNK1HcPyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkIGSr1jriVgw15WUomRunLwU4L3mWoICEBkJTJ73rc=;
 b=bESeh+hWHD9SDctEezuO0OAyvtRA4+2MvLBQjAYE+Mfgfi1ezsLYzV+nFEKKkOldsJN6Jsn7TVdzNXrppGbHOwGuTRTV97y0wOXi/tp2RPIRd1AT633LHJBzIVdvkGH1oIDOm9DyaCfey6JjUL7Uvrn2tZf//8d6ynMr92wwNiFanN7AbdKmdsAysbtAzJHG3iRE0bWnZmpZ2fi8NaeEERiSLHT/RUt8HZSY89GwXUTnCiI3zrCW9iYQlGdXnsQ2F+j8exxi3cBOquwlcoibOh8x1zA9GV6cPVZtDdS82YoMI5RY3BjJ2dkcdgkBPE53IU8cb7YQk3/MsMX0M/AJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkIGSr1jriVgw15WUomRunLwU4L3mWoICEBkJTJ73rc=;
 b=Y6eG1d6PyTlO06wDKTxcP5lvmnULn1TmA2EURU/cr+osu8A9UaUE/iPzegEeoDOx5UCAoOC4lnBA2ORYffmetl1NL5nXPvR8iD41ml3Op6LFtv3tVI6g2p04I57ar7WhF5deQ9BtLtYHMSWbQZV8w9vS7tFeWJd5cpWw/vBoDg4=
Received: from SA0PR11CA0199.namprd11.prod.outlook.com (2603:10b6:806:1bc::24)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 05:53:20 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::65) by SA0PR11CA0199.outlook.office365.com
 (2603:10b6:806:1bc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 05:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 05:53:19 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 00:53:18 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net] pds_core: fix cmd_regs access racing BAR unmap on reset
Date: Wed, 29 Jul 2026 05:52:58 +0000
Message-ID: <20260729055258.1416225-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 01771723-9c38-46b8-15ed-08deed35b17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|13003099007|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	vV38/X8iKPNR5clxEostr3CH3rieGFcMWoTWCYEyeNHcVf76ZHVPVKeUn8SsCBJMnXLLiK0ZpA/JDZxnsefUJY9Yiacavd00dVKe2z8fTrFbxUHmWyw8+2eAaxCpy+4rRQAc+LIRXIVFNIFl3eorbYIu9ySPFBE5NZPBArROe8noQiDNpjwLHwlTojc1+oWz/DpKD/DvynoCPKgInGzPeyK+0XpHqavRuSoB98JpO9tTuaj8cVHLpbhjMXEIk0hp3HVo24aU1b6NTHUzTwu4fiSvjluPzhmED14Pre1VsBk/aeEAAF8qi34eKx0BF6ZWZosaQ2yBrKfRgtPhgNQ93x1Fk+ZbFfg0ze6zZlOIlc/MI7d2LJ0ad5VMjxuuF2fj8jiFWHwPF4mKd2DcKX1Xv77xLQQOcKX3WGmOVJcLelo3hMrxWfgoozL4dBzTdnu+N1L4N/vk2UJlozDs55LD9lgDAMyGw67h/cHgUFXfztlPQm9aVcZTd5jT1USdsIJG8V/aXH7qhq7dzVHuLjgSah7KJFMsX0crPwWfMDeI5kLmfuHEY9wOmIRACyRjjRfG1eKtCt0RbM+k2mptFxFMA6g5neFuyS97BcSIV3iGvaZTZ6xNrbnWW/vBn5uFd16G2nIrpdkUbqQuHMu8C+Biog==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(13003099007)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p+zFbR5EJm24ndKD20qN9p63iFa71m16nh57/CyV+54N2D1hTQA5/JBZm3whQc0Mnvn8dAogw42VqiZddUHpe1V6YBAxBkY0R/UCi1ga3AMhO6scUFJVG5KlaZVPGvdqJU2QvlnzwKQxTvoC0CXAmcl8IEuBMDZrMX7SFHFUCnMnvo6M9SonIEWjqZeoVGFFRFY+/xw29V3fANpfggrl7f7H8HvhExTCoPZBEfiTNAorMzlEAD4zB1jt7IWbCMi3ZSG8hwSY0ljA+xcBafT9Z5WQQU4NJ4GT7+0F6+YcR7HWOyxgkYx+45DxZ+O0vti1PLv9NAgXStMkz2iS3NDhN4GMjtXvFUed2gwGcxd7W+/wppgIbVbZZoi70AgZo6/LBQOUTRG5VXPnV04/fcBz5F17iGDLYdKh91HrAw1Q2lecFor86oIMvXKIiv6c3uMt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 05:53:19.9349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01771723-9c38-46b8-15ed-08deed35b17d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554

pdsc_reset_prepare() and pdsc_reset_done()'s pdsc_map_bars() error path
clear/iounmap cmd_regs without devcmd_lock, and pdsc_firmware_update()'s
download loop derefs cmd_regs after dropping and retaking the lock
without re-checking. An FLR concurrent with a devlink flash can unmap
cmd_regs under an in-flight devcmd, causing a NULL deref or a write to
unmapped MMIO.

Take devcmd_lock across the BAR unmap/remap. Only the PF maps cmd_regs
and runs devcmd, so guard the locking to the PF.

pdsc_unmap_bars() also clears info_regs, which has its own readers under
config_lock (and a lockless debugfs reader); that teardown race is
pre-existing and handled separately.

Fixes: e96094c1d11c ("pds_core: Clear BARs on reset")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260708212222.296202-1-nikhil.rao%40amd.com?part=3
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/fw.c   |  6 ++++++
 drivers/net/ethernet/amd/pds_core/main.c | 10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
index fa626719e68d..cd7616ed9ef3 100644
--- a/drivers/net/ethernet/amd/pds_core/fw.c
+++ b/drivers/net/ethernet/amd/pds_core/fw.c
@@ -134,6 +134,12 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
 
 		copy_sz = min_t(unsigned int, buf_sz, fw->size - offset);
 		mutex_lock(&pdsc->devcmd_lock);
+		if (!pdsc->cmd_regs) {
+			mutex_unlock(&pdsc->devcmd_lock);
+			err = -ENXIO;
+			NL_SET_ERR_MSG_MOD(extack, "Device reset during flash");
+			goto err_out;
+		}
 		memcpy_toio(&pdsc->cmd_regs->data, fw->data + offset, copy_sz);
 		err = pdsc_devcmd_fw_download_locked(pdsc, data_addr,
 						     offset, copy_sz);
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 8d94a4d70395..08af92b47d7d 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -501,7 +501,13 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
 		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 	}
 
-	pdsc_unmap_bars(pdsc);
+	if (!pdev->is_virtfn) {
+		mutex_lock(&pdsc->devcmd_lock);
+		pdsc_unmap_bars(pdsc);
+		mutex_unlock(&pdsc->devcmd_lock);
+	} else {
+		pdsc_unmap_bars(pdsc);
+	}
 	pci_release_regions(pdev);
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
@@ -530,7 +536,9 @@ static void pdsc_reset_done(struct pci_dev *pdev)
 			return;
 		}
 
+		mutex_lock(&pdsc->devcmd_lock);
 		err = pdsc_map_bars(pdsc);
+		mutex_unlock(&pdsc->devcmd_lock);
 		if (err)
 			return;
 	}
-- 
2.43.0

