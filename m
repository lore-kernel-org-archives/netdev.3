Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF5B46EF66
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661227; cv=fail; b=VaybciAm0TdvVmwt6YJyHsvjcsKuLSWt5D4d2s8ZNN3it7T3SnqxcA6jODAhTWnBps53/hi8o54rK978lJO8gsbn1lUJK8X+CR99E9d8mGuwoHTN1gd+rMjqVXa9KJcOuiu1zWz1kbUHtxJc9+YEbisrfASh+L3wMJsfDnEPexs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661227; c=relaxed/simple;
	bh=+rXI5DlPYxZBkQUrBikYXUgROlB225E1GwxVW1lfMpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MGWqAxwyFdgf3/Xt3pbq27me32gkkzGuiEggrSiDjbi1t5jmnTL+wUd4oZ5exyw1XZUIjBmWnDkd3jJA3MZIdqjQ5N+90eLj+Lbm1WZMvybvpZb/cuQKB7w7BDQYzAL0YjSsZOYDhWggvY0HpR0xLhU6SbCWV2T1aeArLm7ZO5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CGh34VGP; arc=fail smtp.client-ip=40.93.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CGh34VGP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9EdqWiWraxUrS5INYSQIyOwSG2GNyIAEAb96wx5t4xs4fWAYKX0AO8KjmCosFRio34ePWNzpYRjx8VJEeqpLlWYKEfidlQZm4lXKOMrLGPMG0tY0sAP8mJT71GQ61KubQrng5/OUACI2K+9iX7ACHzO4aX86dUudrPf4tzVmOUzi3I2vFXLYv9VqcT4nrf1z+32rcljeffab07zYzSdn8g8nnwdSknVlIuxs+3zMn/ffbKucU89JMzRePaL/wW4zcGk10W5Ed2JHhy0eEwmYsBJa+OGo6enp+QOhzfwWNiDYo0oN5jPExfZMw7UgitfB3tKQw1shU0WLyXjoZy/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fRmGLYoN7GAueNEMpvrJ1M5dp4ZhFA0fyxIGN+UaMY=;
 b=BV39OV/OSZ5m5h/0Ihfh1Q4jvPSy0RHUKDYSsHIzP2Lj/Ctq4aF7fd0nSH4ltZLx80LKCOdzVI5D8p1POXIxjQNMwwqs0ZxXnXoAwI9THKHTfd7CsewX3Fx2/koLtWQc8Weu4m54H42BS1JhyOAodsQdQeHnJqFrKNKq6+MDOTc/+IhFfg4c2u0mQdPLxhaou7Bx11Hz+q7shTTtBDvOkL/xUAcXuFHR6mWytmuarWChATtZ8Rgiua/DoeBa5s/YcEqUko49Rz3fM8wmSKi72d4WwvmCnhks8AWM1fcenMfkAPR7xmj4RdMlMIBkKDOPAvoWz9PCB5EnRWEuraMl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fRmGLYoN7GAueNEMpvrJ1M5dp4ZhFA0fyxIGN+UaMY=;
 b=CGh34VGPcPyBHvEubqFKTqcOpWjKYZiQMZFuZDlT3AoTDG8j582jsy2m3ED351Kr/7Zu8CpNQj+G0L4sXUcnc/yCS4QOXwOPKpLtJ1Sqt00tIirQyRErrKtVfxg8CTsqY5WdxGg4/t8KcJkIpwQRNiveVTuIEm+jhsjT1TWzV8E=
Received: from DS1PR02CA0018.namprd02.prod.outlook.com (2603:10b6:8:44a::16)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 19:13:36 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:44a:cafe::85) by DS1PR02CA0018.outlook.office365.com
 (2603:10b6:8:44a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 19:13:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 14:13:35 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Tue, 21 Jul 2026 19:13:10 +0000
Subject: [PATCH net-next v8 2/6] pds_core: add support for identity version
 2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-upstream_v8-v8-2-1ea9a8b7c4ff@amd.com>
References: <20260721-upstream_v8-v8-0-1ea9a8b7c4ff@amd.com>
In-Reply-To: <20260721-upstream_v8-v8-0-1ea9a8b7c4ff@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 2801d3e9-4fa5-4da7-d8fb-08dee75c2a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zEgQ8CRo2XY7xNJWSy5TBpamU/f/85FvcdrlCDSoEpnvtCHgCWP9BaesviOHx8Bcgsxg6tmLf5rirAB8S13JwomTves+psK6QRita1D1VNH4Yrs3fMG2RmQjV2DkLxx2paAUZt3ApdHTOzWe45gsCGJTsl3/MUcpLpsZFWmcPnTPoAjXcUc0PcCR53yRX3D32QPwKpzClP9wfAOQgaNtHNnTE7TfUcDmFf1mfE1TdoSFLKZlcH8MmLcsY0HJ57TbqpAly1CVh02F3NKhG57HtrIn41zo4epayP0WYMFMDQTbvyKFbfVbKaeWgklJnPOqso9HSqdpJwCaAxCXV4olijdGvaQ3dTlMe+DSECcEyhG9Nn+YpR+kNnLDuxtj3waXrK7NEs86ogkEjhO+pxBFK0RzKbYqZsTv0oW/obFz3aDCOnszCsy0OiTssraGO+tCzS0763sdkujE6OX6YLVlOY6pSKfZWZAtMI3PUG+MI9l/Y28ZNn/qty9A0rhzFEBlRQPv1goLyXri5FpiNz8Sk98CsPEZ2fTAiXl4ImcP+VW0bu54xa7cm28KgBGzseH4d8fAHtA3voA+8czmesnT/4yMfBFSp6iizQumtyzYaLabqTGUorBVdVpM/MGbOubJX8gnj72DC543vS9ERv3On6UeYiv3wA1LHtsoCON4VsGF6qn7zpucFc8EAQBfMhWXBiVOFxmCjUv7uUrqrZgqMA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ztGlMjIQfXv3JVNiiPFHS+FRbOxHptaZg5A4GsGCj5LznBSopImPKPfPatz+0GRSOmid5RuskmU5OmV1+gDIKdyVU27DabEmOTgkadnJ2ZpuSiUBIgGaXg1YLLNfGJ1vj6QqZGKjdoAwIwzC6EHpQ56eE1Stj9XqrX0gzb3HHZdMDswNVM/nphGesLbIuAv3Ns4R7sOVdBC98qOKkehIEPOTNqbhA+KnRbz0ZcHxhCtlibP8AcE1/mgihFZufP5VD6VEYqpFhQzFqXVULp9CQG67L+agr8SHO3kqI1ZuyzdC9m+srZl6B7lGJ6lPECGzV3skmhu4uhySMrQHOnJl7CrBRCrWDZNBZupnMcThGuJ9rZiHpKX6j8+bsFnEH4DrzR2YE4F2q6oJMSJZMUkGTkqvs8RZgKFy49mDWMUnpTGKfoT3pfEdQcVV59w98kwq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:13:36.3700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2801d3e9-4fa5-4da7-d8fb-08dee75c2a34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708

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

