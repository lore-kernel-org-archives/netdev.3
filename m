Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289B466AF7
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888009; cv=fail; b=Dvx5CqSUtGKN+p6hR+ELfVv4WxznRy9zvFBbyJW7T0ejuHbGM167D2p1T61SjRAylLzGkK9iGxtYaMjDNGqUP+mBwg//avoKZAROuhtJc0bPgcAi5IrivA2Ex7YMtgie2SHnHsP1zJHIibXrFXbUp8JAbGqVzEiG1EIZe5pBuD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888009; c=relaxed/simple;
	bh=DySasxCKnPK3ARvrq4xGNSKWzKKpJjrh69LioBXBiW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gfZM1upEgCg6SirI+63HMB5W/LpUGihV3yroQpEyDYorxN9v6CHymCh1YfOAaBOVVmQM4tWz2Uf2aNt42pvTVV8orhEi/R73nxPV9ZLyqTJjHqUi9x7KjxqjJdlv8I9l8TWDbK5VZ3D0eeWnXCyCpfmC2E5yhWCxC5XfbMfDE2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ss0FA5Ff; arc=fail smtp.client-ip=52.101.46.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ss0FA5Ff"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9FGF65l34pJVVw9GomgDE7RqDuIYvrjh8jp/OFR7VWhrXk5ELPE9cTa4b8B5Nuiofdpl5Lp90+abOMakEieMcvkQ8JmN20EPaQ2jNA5WCiFIGqP2f8eodpHWzrmaTeN/k1CJniLoC3IaIXiWjgj+qkO1AuPvLOx68OJp9gQ/+lKYO+s22iJifDm9PhPqVSP0WdKLFD06mq7IHEQGOh2myRBiLItl0SzVNze4r3TtaYfEvEA0t3xOc4GOMLceJVrIbGVCfQ+zgPlpfUPKuPRLnbFxASGaaQHjrPs6eicJPHYMLaJLi2PvjZHktAq8DOZhZPAD5cnHR1+nbJqvBZNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c0BRGQijEe1f5cOVsOWJAyFAE3jXZC+0NIaikNh2qE=;
 b=m4AyOZ+MPGaJjV45EJOVpqdD/6Vq/1rZ8J4/sIgQQkspAQrosM1jGY/xJZ2bLfqlRThHPYX/tzVdo4dFdYKLggxfdCrKvv/o+iqjd15YADQoGEyVAbIsP8sHoRlLltZ/n0Zctp7IQDllw4k8drvtn32rpK1xMLegCZ1Haeh2nxPHxYdl0fgYQC/OEHUNCtxYFnc/gslzjTHRkTgAyd6wpEAEUpKgduOEHO5p+lnDUzhlarpHlUMjR5kCVvOPTKNmfcsOEfznSmqT6kEUCP0ECtKaz9fNIQ86Rc0W6Cd5bUAAaoEX7UKy0jAUaLr3Omy1DEigyDuWsilXbpN4k8rxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c0BRGQijEe1f5cOVsOWJAyFAE3jXZC+0NIaikNh2qE=;
 b=Ss0FA5FfpndYyhyvSdZ7hFarochB/UW+qRdE0XrHLPFZtBhTVlMc5ogdqmLsirQwqtVi6OpF7Bpi/B+hFt1ClH/4u1XHODMT4m8ugxVrurAp0ogWY5oEajeD5/42h0XWEM6dtvyfPNcoNMcY2seVxRaV5OwThsP88RZlFxjjtmY=
Received: from MW4PR04CA0155.namprd04.prod.outlook.com (2603:10b6:303:85::10)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 00:00:00 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::7a) by MW4PR04CA0155.outlook.office365.com
 (2603:10b6:303:85::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.19 via Frontend Transport; Wed, 5
 Aug 2026 00:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 23:59:59 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 18:59:58 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v2] pds_core: fix cmd_regs access racing BAR unmap on reset
Date: Tue, 4 Aug 2026 23:59:46 +0000
Message-ID: <20260804235946.177762-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc8ef3e-c161-44d2-e365-08def2847e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|13003099007|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sQKw6y3wJ4B+Ev6kM3TnaIhE5vE3lTAFtZyibSc+4bvAkgqh1l6spRtCc1kFUvo4sqdaUSPryGKHkzaa7tatSSzs0olX6YNFD7BiAXCpVDGE5HT2psABj+q7wCHHfFd+hRG+AVtYE8wuEz0DZY3IKNhUECwoQ14WooTRN+U7lzyIeYokhHqTdi5I7EMl9Bjm3ao2hj3N9DhPVn6NU1LMNHnCMQe5vVW7elZ4jkkiRXZrtBuf6j62yXDybUGgCrNpHWgPhISgi9zCe7BNfDTlHGIjDE2zB18U1zNJUeQRGxED0POoQPK6dzrxa6ajfXk0njJJRaOmTQf2Ldy3E6nQPFeD5yQFVi6KutsBwukceG8ONsJmZS6pslC9k1321ruo8neW9UojlCY6TH4HhD316PyMYxEmTR8Insr9g8LONL4xAd/LJlgVVo6mKC3jFTi8aC36smKzgRP2S5NePJ8kzSUsORlQSVnGtad/+iokbvabHuoVYOt7d4T2Uq7DbRNxl/FWA/SsxuaxzAzYVK+2N4175XvVGlWH0UuelTcqwcaJobXwik3gUtMlY/YSs/Wqx+9oj9oiVfSF7DLwxvO+2moc/FTOnPbFZIidMry4QUa9eQJivfEf8ZTTrc42ufb5k56mDalKak1KnMFvORK7JQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(13003099007)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+YXcwhd/oeLBDsk1hJ7UvS1KNEvDsF1LiFJIb8AJ5yK7/yfc6CbqFkxHCQaDBJUAx3PtQZcI6rVTJZv+d7BXlEBrxBmii8TB9VBe6XHstm4gaI7DkBh4KaFu1TbBJDLr2XMpokXYQBMSA+sOAIX8dLVBKA8LCur+/aTJbGRJLNHyL5Bk+Nld1wIZMQHScDxD+9hcmvmFl15T3/9zT7Vkfti4HxqUlpE4574V7JAIESSob+xXGWhiFadOszEh7Q/5ZK6fX6PfQ7vtYSAGyVt4Nz3ZLVQvTOP+K5h+FhR+KxFlsRhn4+OSiRqoaz8dNOoEXlOOdHoa9leEm/QAKKyDx9h/MepeF0QYd0ceRVljg/U3YmNXS+LzfdafPxmUINFlzgD0AGnPz55p/a2NUH9q3QNvTqXUteqQDCh6hl0SU2+VnCgwbNiYfmUUMkW+bHnO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:59:59.9302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc8ef3e-c161-44d2-e365-08def2847e3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152

pdsc_reset_prepare() and pdsc_reset_done()'s pdsc_map_bars() error path
clear/iounmap cmd_regs without devcmd_lock, and some devcmd callers
access cmd_regs under the lock without checking it. An FLR concurrent
with a devlink flash can unmap cmd_regs under an in-flight devcmd,
causing a NULL deref or a write to unmapped MMIO.

Take devcmd_lock across the BAR unmap/remap, and check cmd_regs at those
callers. Only the PF maps cmd_regs and runs devcmd, so skip the unmap on
a VF, as pdsc_remove() and pdsc_reset_done() already do.

pdsc_unmap_bars() also clears info_regs, intr_status, intr_ctrl and
db_pages. The interrupt and start/stop readers of those are quiesced
before the unmap by pdsc_fw_down(), which frees the interrupts and tears
down the queues. The debugfs readers are not, since those files outlive
a reset; that is pre-existing and out of scope here.

Fixes: e96094c1d11c ("pds_core: Clear BARs on reset")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260708212222.296202-1-nikhil.rao%40amd.com?part=3
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
v2: address sashiko findings on v1
  - guard cmd_regs under devcmd_lock in pdsc_identify() and
    pdsc_core_init(), which stage into cmd_regs->data before
    pdsc_devcmd_locked()'s check
  - skip the unmap for VFs instead of running it unlocked; it is a
    no-op there
  - the download loop is left as-is: an interrupted flash is not
    committed, as the device validates on install and reports
    PDS_RC_BAD_FW
  - say why the other BAR0-backed pointers (intr_status, intr_ctrl,
    db_pages) are not affected, and what remains out of scope
  - rebased on net
v1: https://lore.kernel.org/all/20260729055258.1416225-1-nikhil.rao@amd.com/

 drivers/net/ethernet/amd/pds_core/core.c | 8 ++++++++
 drivers/net/ethernet/amd/pds_core/dev.c  | 5 +++++
 drivers/net/ethernet/amd/pds_core/fw.c   | 6 ++++++
 drivers/net/ethernet/amd/pds_core/main.c | 8 +++++++-
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 04ec2569c61c..c3c27a7c63d0 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -364,6 +364,14 @@ static int pdsc_core_init(struct pdsc *pdsc)
 
 	mutex_lock(&pdsc->devcmd_lock);
 
+	if (!pdsc->cmd_regs) {
+		mutex_unlock(&pdsc->devcmd_lock);
+		err = -ENXIO;
+		dev_err(pdsc->dev, "Device init command failed: %pe\n",
+			ERR_PTR(err));
+		goto err_out_uninit;
+	}
+
 	sz = min_t(size_t, sizeof(cidi), sizeof(pdsc->cmd_regs->data));
 	memcpy_toio(&pdsc->cmd_regs->data, &cidi, sz);
 
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index bded6b33289c..ec96f67dc67b 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -294,6 +294,11 @@ static int pdsc_identify(struct pdsc *pdsc)
 	 */
 	mutex_lock(&pdsc->devcmd_lock);
 
+	if (!pdsc->cmd_regs) {
+		mutex_unlock(&pdsc->devcmd_lock);
+		return -ENXIO;
+	}
+
 	sz = min_t(size_t, sizeof(drv), sizeof(pdsc->cmd_regs->data));
 	memcpy_toio(&pdsc->cmd_regs->data, &drv, sz);
 
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
index 9a2c64198d03..1b960139de4e 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -507,7 +507,11 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
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
@@ -536,7 +540,9 @@ static void pdsc_reset_done(struct pci_dev *pdev)
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

