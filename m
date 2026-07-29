Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF314ABE
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297171; cv=fail; b=GPuITlix6/nn+JAxMVRndv7Y+Rm7p+URv7dXqyuulJy4r6sEnJCbsrLzJNstPE944c6NeNy5V7yqik2AGUMpPzpSvUs6E00C4JnJ9pNCtNAMxyaFFIvTUC+5EKM3jAG2+JpsEg5NRYpRWk6wY/gR8xQE+D4Ka0gfHw1fIkkuEjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297171; c=relaxed/simple;
	bh=+rXI5DlPYxZBkQUrBikYXUgROlB225E1GwxVW1lfMpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BgXq4sGTvrAN+c08nel6T8dt5ZUXNMrJqEP77o3TOZ9w57JQf7Wlk1YeqssfHiU2fRmzvRHZ7AKUxM3QNT6SNLQAD7W4pJqBqUsJ7Zf2eFC17AVRKDC/NNi2xUP8gkCHSnlZdFuvli3wQzAKCByMwNM5+A7bYmCS/DVrw9a9qFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T5vfuO7P; arc=fail smtp.client-ip=52.101.48.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T5vfuO7P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkR2DnfyjACRXyR/iMu9K7bNYLE0zb+lwAZNxGZJvRNvFM9wLQTSC8aDxqb5UcIUYSeiqR0/gRPt+r3VIXW6DtEiW05zCi2uGFshWioLl/4NjlEJ4i1jOxhOaq693oW2VeEECISxSgLFD5LS/4kWYrpq3cMGx32p/rLRUKT+Eixh6OBF7/6FON4jS3b+zmLOVwrHOFE+xeAIbp4KanRX5VofpU/EsF4D3N7Uw7ltFs0IVAz6/d0CHU04PQCK1xyw9mdJ7S2h20/K69sg95qT58OQPFOy+aKdngqDbzsiz8O/sSakLULGWLv9YP00YmbT5OuDgk82pStVPFOP4EHz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fRmGLYoN7GAueNEMpvrJ1M5dp4ZhFA0fyxIGN+UaMY=;
 b=bqXmXvLuyqFTCSzgBlq2o3lM5jGqLLJIryGOhAuzLbsQDBBR0cmEteWfe4HwpUbgwx43j1BPipbiAB+Kp9bQaMeW2ae7ERkzTVmGLKRxnYeBZxTbwvh7IcK246KyfjqIsdE6fzjSQUUMWKWfXbgkDJcz7fdQchZ1VtlgSZ7Or51vtLpBeoT4WZ2r2NcCYFPEOPRUPcGdMqckOmkCGFIoalEH1uQ7s0fo6ekAhfmFAJ352Cj/xCSeVKqO0U9sXFUia90++GPa0t0hGf6HHTTnG2fhMkQdLXoKNDl1SJX0UAV/MjGSfD4rE/W2pIxRCfkYVDrn9vXcXY39Jr8g3SxC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fRmGLYoN7GAueNEMpvrJ1M5dp4ZhFA0fyxIGN+UaMY=;
 b=T5vfuO7PIOwGlUcu3tkSFSvYrxC/d/XxkoBZFnMvlPOYcdNZqbBaL1lC1LOTajQ11IguspaHirWuifLbRrs4jowXbC8O7h+lb6n8JD6kpXajs/njbScg8+uUtYjDzJA/5LZO9DSIxd8ZSwE6SUwExCQVlBw06OGaD3Npgy4xwUA=
Received: from CY8PR12CA0027.namprd12.prod.outlook.com (2603:10b6:930:49::6)
 by DS2PR12MB9592.namprd12.prod.outlook.com (2603:10b6:8:27c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 03:52:45 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::3f) by CY8PR12CA0027.outlook.office365.com
 (2603:10b6:930:49::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 03:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 03:52:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 22:52:43 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Jul 2026 03:51:57 +0000
Subject: [PATCH net-next v11 2/6] pds_core: add support for identity
 version 2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260729-upstream_v8-v11-2-e4b7d5bb2913@amd.com>
References: <20260729-upstream_v8-v11-0-e4b7d5bb2913@amd.com>
In-Reply-To: <20260729-upstream_v8-v11-0-e4b7d5bb2913@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS2PR12MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 58dbf15e-8948-4eee-d999-08deed24d946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|11063799006|10067099003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e3cy8M4niUYaYwlh9AQQky3VfQtezdzeHEjFYd10Agxs+FxxUGtdDIu4WP0/LukPc4t1+SEnIErxDEYQODlZ2LnV38hcboS8Pojk0xb0ydxCklIw7+p6fEpSlamrNrNPWtWaxIsdOWAZ8NHBB+tsIVs1JO1fdOnkh6PrH1Waw/aQmc7M5nShgBjhOPZamRp5j42dlSVE3jegeXT/bCuXsubF5UDKoU8YlfnU/Y+76LIyU0rn1fOQzcZYdKhfVpqPlALGIWfsbYYpEItlr39FSVrawIBexUhEZBuDVGFSn73KNgVont+fqit7IIqlW5z9XZCNxHwpJdVWGLWjlySiQ3P2R+46MLWghLBg/yRMN3jp7QyZHlivisvqgMYu4V82QcKT+qdl4VJRoIKH55JgmQHrK6efLou5FBeQrhE/bjzQkdRSVtkQ231c62kzggzIdAykStLnvGcq14ldDoQD2bcMi4b/LglqZJ+FV/ltILRPiJ7GUGrIFzhwnRwvHjdf4IH5Tv3ZzYJPHlqmNBQ2OtwMQO8r+5gctKz4L0iawYkyZ3afqVr1Ojz+fButSVdg8dJB+OWI+fvIl3RVLO4uR67vUEn5GuGqkYsFDdoSqjnxrhW/PZANmGaECRvYPWG2z5fx6uwcC7WLW5+OT40yBOQCogX4K1stMBYMjo6RCWRp7/dLCwb0tVCKRKoMP61lgYjjzPYb56UwaR8ESpdg8g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(11063799006)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EfrKSOn8KYyVih3VUOTt6wxqX7Ytbc91gFaKU6NENZoYD6Ikk5vRQtFYfmBkuXUcpYJKHlHsJEgQBWtMSarJlk/8+zW5etqb8BV4Mi3mF9rtKBgx6vFgpofN7zLqDwjjk0gPt3Yie/mu508JoUN0tJcMsceRW77Y93fp1Ecpw/4rOQJhH30SHWJv5E1P5P9rwE4kOUw1hhRGb3/l4idbCkrVPm6ZUoBY5zyIlIlJsRVy91e94G/SmxbNSp0ylNgLzKmiS0bntn11NbnfOeUVpa804o8eiVS/c1szrUvMZoDP88DTXpckrmZgfV0D69Ik4V0Fu8b/ZQVo6Y4oQshp33THV4Wci3fi6aERAJ+V4CsLbaNnqjsBaXNSVrodGbMPgY5ehEd3lAFSP02Fzwwm9BbRcPiHO4lrqMpntEmd51izBy/366CJpC2dbkkU1b5Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 03:52:45.2188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dbf15e-8948-4eee-d999-08deed24d946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9592

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

