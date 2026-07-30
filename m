Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CB0367294
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785385559; cv=fail; b=W+b0iOiDOrKmI4/qh6mkizEAwEI7Uzpwy7MXLaT6BklG0UYg75ayJyVwQw7w9ZwMzF6HCS8IHJG/1C2KUsuey5lQFtRIk8yPVAw569caC6KULG3AUoCCRAsnK6SmTjlGRpzCvv1snbROIAzn9zywLcMw2BZIGSgrupmbVt5aSEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785385559; c=relaxed/simple;
	bh=+rXI5DlPYxZBkQUrBikYXUgROlB225E1GwxVW1lfMpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qzrQzjMivwGw21BBzU7PQRThOuMU3X2B2x0BiYSgfYk2v7OlI1lbuGGQYqwxlwxBojpjN2mXUKzPTjBjBc8EQpf7UxUcb7zoKxCnW9jA0NHY72lAFnjZC4hXABbUav8QnMfMUgAZd7BIjdObiBT0EuTmFTRTOcgQaMSFp3hoATs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F3PgP2xp; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F3PgP2xp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpRzxZnHIg/YUNx52AYcNffsX4Y55QwY6musTxyKdGfZKu2fl2xBMsMp7VfnVHv8Uf5HRRpqQaaO/Q80a8ORwDVydoq+9+vNUbt1qq7Q2KNBskACwCVax4O2arkuUh0czuAFoCBK1jL8pcH/BT+jUy2MFHO4Z+CGzeFwx5PS97yMgMc1B4fPozl3XhpVivvr254ciIpgah6HjMjJFFdF+IBxmzLPIxSxpsVTbYRis7cVvptf1g+7GkE1ZKyCI/aT17wtw2mtw3U3iscKkPB8wUHTpAw/VrnbxnRc0v7r48+JQe/Cr2fcTOMaNzwq3QpiW1fxWcRDCG6HGOgNxqThkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fRmGLYoN7GAueNEMpvrJ1M5dp4ZhFA0fyxIGN+UaMY=;
 b=FrwrZtfjM56w61H4DPfd7z2KzLO0+1//SPtLbyxTJJNp9YK4OcodjAaz+KK+FK16+bgjrUboWzh2ZQJrLsqbOpBFtZAoMha9inu5A+/k9FQ2cW8YwYOC0ATICdX54mb+er124XSWXRk3lctim06Ny37jJaGVnwQWsKTbzMkeEFeVfmT8Ndmp3qLh1t6WzJUCcL76L6hBTXpzGxWMLtxFAjLntwBETnBwWYeiA3vRu3QWGqHvKFqqKF3Tpvj7iwsHIPhMyFbITwO8U2drELyuxjw2RrKzcnCeQ+HJF71AVhzuJIdhMbgmBB4bnsN2Aw3Nbmcb0267sFf0Qq0JiYT0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fRmGLYoN7GAueNEMpvrJ1M5dp4ZhFA0fyxIGN+UaMY=;
 b=F3PgP2xp3Zrn1w9DCWTeG7ShUuhHn0bGF1yl7w4QGXz7TGvEPDAO4aeT6P0UCvSvrMrsHXk3nkUVogUdDLrt6QypIjFeAoMAQnuLLdsFbld+cNRHGgnNlslb121ldQ45xFJLYI7g6TiR1bH3QRnQcaohWY34q8+qIcPDl1339yw=
Received: from SJ0PR13CA0071.namprd13.prod.outlook.com (2603:10b6:a03:2c4::16)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 04:25:51 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::64) by SJ0PR13CA0071.outlook.office365.com
 (2603:10b6:a03:2c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8 via Frontend Transport; Thu, 30
 Jul 2026 04:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 04:25:51 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 23:25:49 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Thu, 30 Jul 2026 04:25:19 +0000
Subject: [PATCH net-next v12 2/6] pds_core: add support for identity
 version 2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260730-upstream_v8-v12-2-136cd174ee85@amd.com>
References: <20260730-upstream_v8-v12-0-136cd174ee85@amd.com>
In-Reply-To: <20260730-upstream_v8-v12-0-136cd174ee85@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 0637cf7e-1119-48a1-fdbd-08deedf2a365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1gGftKULQ7pcQbwJNLbr9nvNAtf6PkllmMtHay0vzj1x8qlMOLaH+eqQw6NUqOnFO5O/vZaGD0fGZtpy0lHyI7jT9CiMjDsa71gEjTM66FF78pIC3OZMtjE0mRT6uFSfyogwYQIA0YGJUGtRJlI+Bd6a0db719tlX7Y/EmBEfQxMlKTh+sV0GLvJ5h2xmTUmgFRFte8mbT3WM4VG34Ppe/xocRDPtoqh69bYGwUv34erUanYKQI3H17qntX5q1qwN5be6NAoaez0MYG4SRbA++fMilYLD4TKq0Qh80GrHr3FPAK/r/NFd/EIXXBSels98RczRA9KLHtQBfvtZ7vJOs4yaEDwhfh8wMZP6VTWNXDvHSWWuFsWHoGvkAEPXseOcd4+SQf2xVgZO4MmhmA3dMy9q2flDV0LcDmci4ZSD+DHK3eQg2Z9B41fSedcCeXV8/RVf8n7rNNKI12RNLyQK0sB2mIC+DhL5FBJ9nKSTFvZ5tV0d2DQqS9nV6+B6U3msh1wLzM5+qA2n/XtF7G+PmAGq2tgfzzdlNYve+aLmNZvG29XFIcTHy4ZHg53xkiztGVtRrhRqwczI8On4Py2XSOr/FdCPeMANlDa1RU/6vHACvMswN4aLv8BBBli4aZgy4MZQ3daoZlVK/xSIfGpeFb6FNo/j4qW+AX3urmie8n2uRDCEzTKRHIjwm0osvzn4Ep2zESIb0CwGNYqRtWvvA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uhWIUm6xEIc0xvLhamx6IU4ew2Q5MHSJuodLlkZva9LGQzbdUntFmgbQbu5thhx6eFYaPo7wpjlLKlhwWu3Xmz72V9aq1MYo0mTEGxNonIyskG/HYnEYShboEBJxW8spoeZuVbyzvUJJwxq0rfdWpfi56ro2qt8hehfnfxy/B4Q5DzkZEsZDbcCCwhI2DNoKXs2z60QUvEslUO+iqvfrtnRy37BGWdDx6PhcYc7M5dPEa9FRmCdjRCFdflS3xknA5k6Lhhj2CBF3LpLSHr9Y7vDYySQ53YM5cZmAM4XVOI1lc2Lj9ylAW8JcCtAsQ22sBrZHY5rUswkgXvgewZeZFfMku7SWNPfGnyNN0P2Dpp1YBAOGhUVqv8n6c4PdYpmsC9/Qqg1mGOtsfzNPrmJFeubTPKfQVgLmGbfN7mrU0Z3+y32O5CDSh0TQBncYHlsB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:25:51.1006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0637cf7e-1119-48a1-fdbd-08deedf2a365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805

From: Brett Creeley <brett.creeley@amd.com>

Add a new capabilities field in struct pds_core_dev_identity,
which requires bumping the identity version to 2, i.e.
PDS_CORE_IDENTITY_VERSION_2. If version 2 negotiation fails,
then quietly fall back to version 1. If version 1 negotiation
fails, then driver load will fail.

Another patch in the series will make use of the capabilities
field.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 44 ++++++++++++++++++++++++++-------
 include/linux/pds/pds_core_if.h         |  4 +++
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index dd9989cfe6b3..2ebb5360e0e9 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -250,15 +250,17 @@ int pdsc_devcmd_reset(struct pdsc *pdsc)
 	return pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
 }
 
-static int pdsc_devcmd_identify_locked(struct pdsc *pdsc)
+static int pdsc_devcmd_identify_locked(struct pdsc *pdsc, u8 drv_ident_ver,
+				       bool do_msg)
 {
 	union pds_core_dev_comp comp = {};
 	union pds_core_dev_cmd cmd = {
 		.identify.opcode = PDS_CORE_CMD_IDENTIFY,
-		.identify.ver = PDS_CORE_IDENTITY_VERSION_1,
+		.identify.ver = drv_ident_ver,
 	};
 
-	return pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
+	return __pdsc_devcmd_locked(pdsc, &cmd, &comp, pdsc->devcmd_timeout,
+				    do_msg);
 }
 
 static void pdsc_init_devinfo(struct pdsc *pdsc)
@@ -281,8 +283,9 @@ static void pdsc_init_devinfo(struct pdsc *pdsc)
 	dev_dbg(pdsc->dev, "fw_version %s\n", pdsc->dev_info.fw_version);
 }
 
-static int pdsc_identify(struct pdsc *pdsc)
+static int pdsc_identify_ver(struct pdsc *pdsc, u8 drv_ident_ver)
 {
+	bool do_msg = drv_ident_ver == PDS_CORE_IDENTITY_VERSION_1;
 	struct pds_core_drv_identity drv = {};
 	size_t sz;
 	int err;
@@ -305,19 +308,22 @@ static int pdsc_identify(struct pdsc *pdsc)
 	sz = min_t(size_t, sizeof(drv), sizeof(pdsc->cmd_regs->data));
 	memcpy_toio(&pdsc->cmd_regs->data, &drv, sz);
 
-	err = pdsc_devcmd_identify_locked(pdsc);
+	err = pdsc_devcmd_identify_locked(pdsc, drv_ident_ver, do_msg);
 	if (!err) {
 		sz = min_t(size_t, sizeof(pdsc->dev_ident),
 			   sizeof(pdsc->cmd_regs->data));
 		memcpy_fromio(&pdsc->dev_ident, &pdsc->cmd_regs->data, sz);
+
+		/* V1 firmware doesn't set capabilities, so the field may
+		 * contain garbage from the outgoing driver identity.
+		 */
+		if (pdsc->dev_ident.version < PDS_CORE_IDENTITY_VERSION_2)
+			pdsc->dev_ident.capabilities = 0;
 	}
 	mutex_unlock(&pdsc->devcmd_lock);
 
-	if (err) {
-		dev_err(pdsc->dev, "Cannot identify device: %pe\n",
-			ERR_PTR(err));
+	if (err)
 		return err;
-	}
 
 	if (isprint(pdsc->dev_info.fw_version[0]) &&
 	    isascii(pdsc->dev_info.fw_version[0]))
@@ -334,6 +340,26 @@ static int pdsc_identify(struct pdsc *pdsc)
 	return 0;
 }
 
+static int pdsc_identify(struct pdsc *pdsc)
+{
+	int err;
+
+	/* Older firmware rejects anything but PDS_CORE_IDENTITY_VERSION_1
+	 * with PDS_RC_EVERSION (-EINVAL), so retry with V1 on version
+	 * rejection. Don't retry on other errors like -ENXIO/-ETIMEDOUT
+	 * which indicate firmware is not running or hung.
+	 */
+	err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_2);
+	if (err == -EINVAL)
+		err = pdsc_identify_ver(pdsc, PDS_CORE_IDENTITY_VERSION_1);
+
+	if (err)
+		dev_err(pdsc->dev, "Cannot identify device: %pe\n",
+			ERR_PTR(err));
+
+	return err;
+}
+
 void pdsc_dev_uninit(struct pdsc *pdsc)
 {
 	if (pdsc->intr_info) {
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index 17a87c1a55d7..619186f26b5b 100644
--- a/include/linux/pds/pds_core_if.h
+++ b/include/linux/pds/pds_core_if.h
@@ -119,6 +119,8 @@ struct pds_core_drv_identity {
  *		      value in usecs to device units using:
  *		      device units = usecs * mult / div
  * @vif_types:        How many of each VIF device type is supported
+ * @capabilities:     Device capabilities
+ *		      only supported on version >= PDS_CORE_IDENTITY_VERSION_2
  */
 struct pds_core_dev_identity {
 	u8     version;
@@ -131,9 +133,11 @@ struct pds_core_dev_identity {
 	__le32 intr_coal_mult;
 	__le32 intr_coal_div;
 	__le16 vif_types[PDS_DEV_TYPE_MAX];
+	__le64 capabilities;
 };
 
 #define PDS_CORE_IDENTITY_VERSION_1	1
+#define PDS_CORE_IDENTITY_VERSION_2	2
 
 /**
  * struct pds_core_dev_identify_cmd - Driver/device identify command

-- 
2.43.0

