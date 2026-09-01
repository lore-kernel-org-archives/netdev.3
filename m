Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082CF38D3F2
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 04:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237764; cv=fail; b=tII0oZ9e5PTNuJ8g5flakCTj9JS2iAqnN5prF9SXGOkyQe6KbEQBvS4Rg6yYmNQ/D/c3p7xg6ZjLdyePgdVikHY9ISEWDqvnvIndCdjQSQQuGac2puLQEblCBWdElup1qrRmVNRUviRQu+htVTJeBNRzjFhDgu7HKQ0cQLlslzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237764; c=relaxed/simple;
	bh=a5Rnw+I9xdBwBE+2F0/LiCwczPbXT083bnLboKULwfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIU/Eny/1DI/s5NzdPNQqQp/MJCCCT+t+Alwv/vX3YJ7iVMKXDMNs9FCbQneRVelDHzebgYZ+o9imVl4QYHT4lHHbjeIOQX6/xUlTYhDPRhoREHPxYPzbtNkluKtGOZmcDcWvgxj9RIBvbkyf230FTIXslvkdN3RAkm2P/uuz+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QtPQmFRU; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QtPQmFRU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=je0wSrhT45d3EivhjoO8x/swTJKlP76l3z03AioUBzQrTDrhwuZAQNvhv6biJrmq2rDtdZ4NuZmoj54dSDZrJbFzHrtuYnbTTOkqqd7CZ4zMbtBNVC0//1E3adNb0ROkfHNPeQX+XvCs2WE5MQt7WbkaWDR1R0ur69pw5NIrstsQ9YHDUOWPJ/hWOb9t9sjlbb1TWvfb9ApLq4+d/ZK2SJzYmrcSwXL76aaaZ/ktVJwmNS84xjXDW2cuNWKpswMbmW6x+kuAAVcubvR9+vWOjlAoOXv4ImxRMVitPRPa5X+MSTaoiTO/vLKLt/+EDTI5Q/8zoASJRXssb3kWHNTAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46nm7vXFX/+wk662GWei5a9imKvX0z+XVuxcg3n1J/U=;
 b=r/SWAqIW+o1KqtPAJ0HRXqW7NpQUatBtJYzsZd+jWOj/J+5MjCTfi/Bop6FeBiIpkDQ3E4uEHP0eRHQ2ONg6rIuqaq28oEeb94bmPAaEfIOx0QNH2Wj9Oqljo7OucJL7ruOTBIEFi5nCXCbwpOEnxYYA+1VTAaHDUojOXA2c7RxecVQ933K9uaSd66o+VGiJPyDy0XdsOQk0UY0wiSinN54O5CU6qOciqR4c4sW+GV7yUedFiCZwuMP9FReDR/ZGtkuyy8oArrDrCvIMi7GVrDdDYjBGapjFMFd59CyHIQn3ntE8xkqtXrqk5PcSxqKY3AtVi9ipe/eFAr58v5wBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46nm7vXFX/+wk662GWei5a9imKvX0z+XVuxcg3n1J/U=;
 b=QtPQmFRUluohD890GluV+HIRErpAjEqTqGVBARHu1RiWGAy1gEQAfn9EM++/I4pRKBuBCzRAgp0trgwV+/0sRBAljP7vnOTqhbikDbJv73FFu1Muf0Ov5YHyqKrikHEnrd6xWZKoPSdAqAKw5KxVzwc0AR7E1y9tiK9zi+MvOPQ=
Received: from SJ0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:2c0::24)
 by CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 04:42:39 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::a3) by SJ0PR13CA0019.outlook.office365.com
 (2603:10b6:a03:2c0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 04:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 04:42:38 +0000
Received: from lab223.rund-run.pensando.io (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 23:42:32 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <brett.creeley@amd.com>,
	<eric.joyner@amd.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v3 1/3] pds_core: fix cmd_regs access racing BAR unmap on reset
Date: Tue, 1 Sep 2026 04:42:17 +0000
Message-ID: <20260901044219.1361466-2-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901044219.1361466-1-nikhil.rao@amd.com>
References: <20260901044219.1361466-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|CY1PR12MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 053d3e02-64c6-4e7d-cc20-08df07e373a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	ZAhL4MWw9YbnGacAzYI4AkBUE96S3j6k6wetJe1T0+HX5F16tCzqYJzYmbfUhkNKcgkDXQzzJVBYb4Oxjbqpk1oHth0tJwYVD/2JAdB2gJaWUiHu70jsbgjP/pO7DD7ZREjrjv9i5EkK/uDfFLImNYkTEgS3JYcglLijtOZaf7otGUDttdIR2IUyDNEcO1YedXoDszEjkzG381i8CkhptWYRZfrNjd7WkR6OYnejLq5FOZaSEvvZq7OXWypVXHpHY8U09x1xrDxaDBkYAuYC6DJA31+Qi3t6MUdVUZm3E5UPk7KWakUUs5Qjjk9wythEf/l97TvIn8QFunoUVhW3oWpqcWS943gxh8OK0S8tvo7xZbG5y2r5yz6rmihVSA4DFctcUUHdZgbsBMK63hed6TyTfRexhlPMKybphFHJyaAopGpkAPwlJ7GY4GPan7HS8u0r1JhvaKumC+rcO5pdDPwnfWZlVJCkHFrv6SScW4UQv9Q5srZMhPPLJqkMZcXs3nK7g40JM5t4AcyTc6c/LaCPFXzFnHg5JCrmn7J1+Yk/q5xd0wXWtKI+pFuJqbNy3vJsESfCPfA4FvzKXKIetFgVggG3GJ7yYsisgZm5b5QW6/o2AVjliy5BO4M74sxYHCaBZB5JwMsff8cm5LEwww==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1S28zjPQhJPiBS8z7bVZnH+68+pkv5boPFEuxzP9/gsum83qZw7k+mAOCOzDd+m1KfqiLa5mGez4BBvrVbUTxxfqubHv3ys7lP359Kc2Pt2T9csVxqro6Y1f0yMfCWMnmDWHJ/ummJ5G1ZmrR0DMx5QLKiYRt3Bt1OT7A0UwyS/1GaFA8uAt87/Zr3LbXgHetzDomuKadlD5KqxktwzO09886H9eJE1gTjkr/ZTv7KAwemJaiyThIT5Sto4PRTUmoW2UJRj5XBa2lFCxXeIDy0VUeaBq6xaosxicXEVdNAhUqR7CbDZNkeJEIR/aSgfFfPAQLmTy2UYXX8/fCxQjnDrC1Sd1+w8+R8FwibbQFWP0zlHfTP0h+n8GYkTT7AmzXJZFgbJauH5Ok+AcXnhhq/NXUNkPQxpHCqNctZFPVuOVv3+JDgd1w6KjWD9RhEYk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 04:42:38.8089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 053d3e02-64c6-4e7d-cc20-08df07e373a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9699

pdsc_reset_prepare() and pdsc_reset_done()'s pdsc_map_bars() error path
clear/iounmap cmd_regs without devcmd_lock, and
pdsc_legacy_firmware_update()'s download loop derefs cmd_regs after
dropping and retaking the lock without re-checking. An FLR concurrent
with a devlink flash can unmap cmd_regs under an in-flight devcmd,
causing a NULL deref or a write to unmapped MMIO.

Take devcmd_lock across the BAR unmap/remap, and re-check cmd_regs in
the download loop. Only the PF maps cmd_regs and runs devcmd, so skip
the unmap on a VF, as pdsc_remove() and pdsc_reset_done() already do.

A reset that completes entirely within the unlocked window is not a
correctness problem for the image: the device clears its update session,
so a resumed download is rejected, and it verifies the staged image
before writing a flash slot, reporting PDS_RC_BAD_FW rather than
activating it.

pdsc_unmap_bars() also clears info_regs, intr_status and intr_ctrl. The
interrupt and start/stop readers of those are quiesced before the unmap
by pdsc_fw_down(), which frees the interrupts and tears down the queues.
The debugfs readers are not, since those files outlive a reset; that is
pre-existing and out of scope here.

Fixes: e96094c1d11c ("pds_core: Clear BARs on reset")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260708212222.296202-1-nikhil.rao%40amd.com?part=3
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/fw.c   | 10 +++++++++-
 drivers/net/ethernet/amd/pds_core/main.c |  8 +++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
index 5ccf017f6af4..19899bf38d40 100644
--- a/drivers/net/ethernet/amd/pds_core/fw.c
+++ b/drivers/net/ethernet/amd/pds_core/fw.c
@@ -171,8 +171,10 @@ pdsc_legacy_firmware_update(struct pdsc *pdsc,
 
 	dev_info(pdsc->dev, "Installing firmware\n");
 
-	if (!pdsc->cmd_regs)
+	if (!pdsc->cmd_regs) {
+		NL_SET_ERR_MSG_MOD(extack, "BARs not mapped");
 		return -ENXIO;
+	}
 
 	dl = priv_to_devlink(pdsc);
 	devlink_flash_update_status_notify(dl, "Preparing to flash",
@@ -198,6 +200,12 @@ pdsc_legacy_firmware_update(struct pdsc *pdsc,
 
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
index bb79e7476370..6e1079f9ba0f 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -513,7 +513,11 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
 		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 	}
 
-	pdsc_unmap_bars(pdsc);
+	if (!pdev->is_virtfn) {
+		mutex_lock(&pdsc->devcmd_lock);
+		pdsc_unmap_bars(pdsc);
+		mutex_unlock(&pdsc->devcmd_lock);
+	}
 	pci_release_regions(pdev);
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
@@ -543,7 +547,9 @@ static void pdsc_reset_done(struct pci_dev *pdev)
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

