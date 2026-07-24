Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AC4399EF
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927317; cv=fail; b=TkzRMIkP4H05WNmMog3xK9JASj1k3B6k1en2sXw7TdbLMz9fE9kTjeC+l0jwbSv/j9ZfphVErbLxkekSJVdX/wJBQZgWtZXVLyeiwSqaUybQ6f9bhi97WjiJOuHle/raf2txag7bARWv3psjjnJCW+jNJwUIU3kvH0PwAKQ2lIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927317; c=relaxed/simple;
	bh=+rXI5DlPYxZBkQUrBikYXUgROlB225E1GwxVW1lfMpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BgC9amAmV9Nr10S13kZyGh9CSqnS1sokmi3z96xYhVuJqh7qerSqtSuZ8tJ1/jxnjNKp+WNz7nviU3ADFYFeoGVxG8NCYXqaBUExXWuvOGTU9it0/YPq4f6S66R2ya/vPVumoCNE2uFOho5n86jdNIabtg8tDDcJ3xATXKUnubM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qFKCqD5j; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qFKCqD5j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBUlmC6SnL322jqDW+5vebYMZh0ZHnqH4vVVvWFRtGtc6K24iUujjV94JPbEV9DGZFoPtP+scOk5BDoYExAIMRX3LjFxjda/T9Dmr7WGOP5ffrZ9iZ7kIZ7SE5p9zcvvrRdHnn7D5sPRCSTdmltJnVdFLu05QteMAXBtoIMLhdzoFAOCXwRUtcQcLgcnjrakrZvwGBD3zMycskvY3DdSUgopWIPBmLNP/700Boo/Mw31bUyW9uBqsqERDbzPWMkgNmXwbkBWp7g6STkm1sMMi+4GSEYAh/RctptKQ7rKijyPQqnfuYg+MZdhxUFZo/YJ6gGOSbUpTV7RBp/9+biRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fRmGLYoN7GAueNEMpvrJ1M5dp4ZhFA0fyxIGN+UaMY=;
 b=m2zcbSXPe6C5DKRfdLcMAUzrfsFzPFzYPTM+I7Hsd6L8d56ZnlehVh5KJyVbVls/ovvFVE9conpFvebA6+apP9CodHm5S+YY5Mo7gwOYBZANCYOG+ea+YS3NNIZFC+EdG6qVKHfdW25j3Xv0ZxAYk4YVOWLo0Fo/VO0CKJoxU1NxLsoYDHm886PpfWP5yt70Vso9HsQ5PQmirCXsovF8AuSgqg6ZuY1BL8zEeQfhXbZXI1+uioMtWFSKAsNkUZPs2hFT1EMAZ35y3Ad+HFwO4j4t1HPJCeiDa1FIj06B2KfHDpK4pSgntBKpoETn1d4x61UpH3tlyXnyWL498LxZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fRmGLYoN7GAueNEMpvrJ1M5dp4ZhFA0fyxIGN+UaMY=;
 b=qFKCqD5jUXAd4hquNalwoFZvtGqFH1Vkzw8C1CbDClWVammnj0/fwN9EzDgv1Vgnfwyw+u9gQ3JjtW3w31O5t+EUvggkQrJsaS3ji3v07icyTfppab8HOjdHl8yphNe81HDOLmdhO1J73v6I3/J7pwVUkeVtz0Ez2wK3xr6kRkQ=
Received: from PH7P221CA0064.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::18)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 21:08:28 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:510:328:cafe::5c) by PH7P221CA0064.outlook.office365.com
 (2603:10b6:510:328::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 21:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 21:08:26 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 16:08:25 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Fri, 24 Jul 2026 21:07:23 +0000
Subject: [PATCH net-next v9 2/6] pds_core: add support for identity version
 2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260724-upstream_v8-v9-2-8425762b8b7f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d11473-333b-42c3-0242-08dee9c7b48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	AMsBjr200YNJE4fJoNBmal8CBgASqWPMVT2q2bjPRSOKvrgMDXnq/p1MplTSPsKUmY9f5yF2lFj3x6xPizVIRQf6v1f7kPvahYtDI4F4zWx8TfgRqPGL7c9X6KmsJKIWAGf/fwpyR73HnpdQQy45DtQAWjRTNF4h5uV5523K3ij2QgC7PCFAHZyyE3ByslKV2dcVFJRru4iTY+I1V04DBbSLdbs2czzW9quy3Bp9dc9rT+O/ppPf/7dnDFGOY3h8hO9GMbinhfQ2S9qFIoS9jzZpn4Y2EIVYFh8lB3R9BrKfHuvAtJEaggmcwBGvEWwf+yKQDfrKkvG10I9hFGoCXlL89w5vBOBUcIiWU5L5Zi4g3mqiOxdRmsBQ4SHg7SiFZyBn8EccPxAU7LS1pMid2AxVma4tl+6r4xc64ylV0CHO3a/KU/N7cR2Et90Ro2RZ3MCN3ApsIzU+ffM9nzmwiMr1ZtkGGA6uced80fxpZbwmUkrmxYDlPyJoxKbMBO9LFo2McCd0QNJee7ligw2FNJt6L8mNnGrkpwlwqDIT8DTuWBEHgCw3LGcv4PrEF58PEswgi9ajbOJ8mYJFE496AFnuGJnH4/sLX+RfGMm2sPZypk9Dc6c8sdJQMsGSXfTs2e0OQSbJZzZdg39MrWEE92HNWxQx58wiY+6hY+WEcOE7rvaWNnxVQr0JClsN1SUnId4udeqKG42pQc7cLSOJ2g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l7XVt0zBE1mPUkCW8InpXt/mKHFGbWYYP1R9sxzBeVY/riEN346rajPHQIY0tbYf6sBZa5c/viaqmTtHPOtTGto2O2TTmclFDx4tX4+yjJPc+W7arBOyi0ja4lCKl7SVfKf/jVG2VQZfA7scjvryH9ZSayWto7tF78oPqlbh9TqWxUp+hWtGJs8/wxRfwzm+BY2u6QSoM0Oxbh8N/snh6oHshpryWGXPFL6jFTdYhAohT0RZ8gZViKk5OxjL+R5NaT+tOHVFKU4ajzhbDHEkCoEwNl+2NfskF5nEAL4311qSHIMhBkhbGmrHirOOTmPC+OzkYaSSpQP63GnfhdrRAEVEe/DryYWp6znYyYYIWluHH9RXmV3TUCoetCPS3mfhpu8CxpnCETLCDZBVUf/QAmkUGN0Qc0Oxo7eKqcTR4buWHX/oIX9j5HgiSjFeREEw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:08:26.9084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d11473-333b-42c3-0242-08dee9c7b48a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259

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

