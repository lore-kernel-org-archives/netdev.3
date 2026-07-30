Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041D380FC6
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785385558; cv=fail; b=ovoYPzw7U3+zO3x0SGsei79Wfof80bvWfxgKrOXV/7+jAd5B5g1SmkpICi6UmeQFEW3Ja5fiz98Mtgog+v9dW4VroSB9f6z4yr3vtvvAXSDFPSS/gkshYlR3t7vQHFi2aSv+J4eThKUOyTSqZXM066ta6TAaC+R5K2gKXuDiztk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785385558; c=relaxed/simple;
	bh=DFAR6wQy6baK1UGlEeyx2S3c5h/x9TJ8ILgM+ws4UUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nqq+Yv3DkmZ4ayq5XtPlyRT0Xygt7yD8h1oKnr6vdF7jdK605ABREX/jnsyROtaz/owfWeCRhU9NVrGJcc640ZB9SLxztvvWct0Y1j0PXqmy0RgSMJyrFqlEYQS7S8N04UnB09pfrpheO3mU5gyYSQIfKU4TLV5e618tpJaUSu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pOxXe0Dh; arc=fail smtp.client-ip=52.101.46.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pOxXe0Dh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O04BUzMh7ooONirXQpvAfJERWpLn0xuLHCIkvxv/ZZQV6nsNbXZdXp/FEfsx4VFogeteeII8Y+WUb1LUtFYQrrOTth4tmWjPIyktAykBAJYf5QcvXjpQou8ACekKhxe7uIRQWZRzEsEK3z1yIc1/KkG8wHEuO0emtX8I22XyeSNqoo5W3C9fupJXPknPS1BzbmlPjLgwwf32eLN43d3aBE+/p37aDlwENZwqGnjJ3Woi5TWraOaZ0arM2/8Ds9IRHALhVdLx56NHLskkEBFMBekpUJLi31T40UEmfwKaxn+MzmAIYjkHepj8b8OYeTwb9holFj5uZ+WxAZDslil9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrvrmKGkvM/W30SRvKkXKTNVDxCi2s2bWxy+SF9MND0=;
 b=Tiy6IO7cwVtgEBJC5Aw48Tn5/Qk/90WXFcDWGop/aIEppogkqeEJP+4OTuBfxwsr5OsyNX9urReKoloD8NVRV3QgSzIdXBonyLCQjSPq8c4u112gvagp2AmlltxrVilYJHBRuHbSLxb9ILbveGhU+AGnSVch5igd6apZI7322WB7u5SXx/+BWfNLIScwDJnhCQlhWKccnOfPGomsLEDqjCky+LPwVjFG5s8GMh9Tb7/xvtRVfIdOo2r4a36c4LKWGPPpOUhTY6q9se0woyuoJWrV+UIP0+kqXdtAuqYnN4bDP7Ez6zCXQVjrVSDZVMHGiUDho6jv76dl4s2td0eAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrvrmKGkvM/W30SRvKkXKTNVDxCi2s2bWxy+SF9MND0=;
 b=pOxXe0DhJROqJW8vj0ZGjLMLLMKD3gqwMkzgxbhzOVJMJ50oOoPWNiw5Yhr74ebswaTkfjqSD+vF5jsQnZKWMLuI+32A5CaFSjnkCkaRVkluygSwD5Gou8HPDlYm4g3778eTJGW5SKZnFcfjllLjaSKf0+0rjE4fmVraorBKqq8=
Received: from SJ0PR13CA0070.namprd13.prod.outlook.com (2603:10b6:a03:2c4::15)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 04:25:52 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::58) by SJ0PR13CA0070.outlook.office365.com
 (2603:10b6:a03:2c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8 via Frontend Transport; Thu, 30
 Jul 2026 04:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 04:25:52 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 23:25:50 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Thu, 30 Jul 2026 04:25:21 +0000
Subject: [PATCH net-next v12 4/6] pds_core: add PLDM component info display
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260730-upstream_v8-v12-4-136cd174ee85@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aae5c04-68fd-4e6b-a433-08deedf2a430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	cw0Y1O7IAUtm4oOm5Cd0+aBUYJwruxMM8X875whVuMboPhgy04X7B4jScUWoSfglNUofPT68f1gPPGVeULSom6m/ueoT7bnZNKPjWytIEnVfYSeExfaFFwC9rtZC+JSDGZ2VLr6Z+yM5HsrII6bBUMyq75+YcYiJPdLTamHFIceOwIPXYvOpguVCpUvxuVITZvs40DpLD4CgqQWs5EFMFEP+StcaVQ2zHIOd+QTNGrWBmG1RZx6EgLXC6IYNVp7aLPQ4JIuBnDeUsBP2ZguWO+AtulnwfJhMNbUWunxSmfsoNmRYXU5S8xkgZyJ+eWWquA3LnNF1e5g6BznRyKBgn8GURLeIdt79r+/kli5QGd4BL1qr2bLthG4wKSHCzo/9DvvCkkqnZVOWE/NgePWXWmWh9TWXDDKGbkChnzz3dKuipNmSRs81AKJ9v+mrViMXcBRS1C5oLbf6Px0eT0XwyJPv7KsfVYe/QrXX0MG2VUF7JObQ68KOxBcLLIpJVZdqw42iB/a5RKfcD+jNrAaHyuHpUQyn4M1/VdInfTXR20Rhf3J8Ez/v/oiP/EUu326fzdfQl+9v552GRQDCOart34///uHH5paANsSQ1mVwAPNvuQuhMMiK7PfWOL9NW4npV5lvrwq0TdIqn7AC9WcAKEqEEwbVcyOyY+t2R/scSI67vnYrohC7Rsa/y9+l67EoyWcJPvq78w3CzyZL7hxi4w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qd+NxclCwiOSE/toad+DJdVfjL9lcgcN2wiGuvpujx6bRv49svnjrfrBxu+5VvngzBlzOCGO+JZmhzvpGTrkbAoN47z0sewteqnMXcBFeA3YqHqahX8mETrYkxixPjaPIgXf6qfN3gPQ61AJP2OAKFwF4LL5KgWAoTSHJSmGwG164oeKVbMfzqqiXRTlgbiD7uAosCc82gcxGQh/XpG5bli9+0eGkuZpKOf7nP/ctDuu1DcqT1y6egeeZ3L58qQGHFrZkRALWr4VUtoQ+nL4Y5WtK93snvPt07kQXX+w1YIKTvfe28D/nI86MqZOFynKJ4rCDT5XCxvGleUSWKQmrXxNZ7yiI60c/6X4dKy9WLSmPprnkl3nlplSjBvNFqxmINaH5mFtwoxazUP15JRvD9j5UH08R9EVnq+i4LT+9LYrhSJJnWVTPqk4xtEXulBb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:25:52.4350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aae5c04-68fd-4e6b-a433-08deedf2a430
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568

From: Brett Creeley <brett.creeley@amd.com>

Add detailed component information display via devlink info. This
allows users to see individual firmware components and their versions.
Components are reported as fixed, running, or stored based on their
firmware-provided flags.

Example output:
  $ devlink dev info pci/0000:00:05.0
  versions:
    fixed:
      asic.id 0x0
      asic.rev 0x0
    running:
      fw.bootloader 1.2.3
      fw.uboot 1.60.0-73
      fw 1.60.0-73
      fw.cpld 3.18
    stored:
      fw.bootloader 1.2.3
      fw.uboot 1.60.0-73
      fw.uboot.gold 1.50.0-22
      fw.gold 1.50.0-22
      fw 1.60.0-73
      fw.cpld 3.18

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c    |   2 +
 drivers/net/ethernet/amd/pds_core/devlink.c | 145 +++++++++++++++++++++++++++-
 2 files changed, 142 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index d13b727dee42..51d21328c73d 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -596,6 +596,8 @@ void pdsc_fw_up(struct pdsc *pdsc)
 		return;
 	}
 
+	pdsc_fw_components_invalidate(pdsc);
+
 	err = pdsc_setup(pdsc, PDSC_SETUP_RECOVERY);
 	if (err)
 		goto err_out;
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 3b763ee1715e..63fe45e91f71 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -93,14 +93,120 @@ int pdsc_dl_flash_update(struct devlink *dl,
 	return pdsc_firmware_update(pdsc, params, extack);
 }
 
+static int pdsc_dl_report_component(struct devlink_info_req *req,
+				    struct pds_core_fw_component_info *info)
+{
+	enum devlink_info_version_type ver_type;
+	u16 flags = le16_to_cpu(info->flags);
+	char *ver = info->version;
+	const char *name;
+	char buf[32];
+
+	/* Main firmware is reported as generic "fw" */
+	if (info->component_type == PDS_CORE_FW_TYPE_MAIN) {
+		if (info->slot_id == PDS_CORE_FW_SLOT_GOLD)
+			snprintf(buf, sizeof(buf), "fw.gold");
+		else
+			snprintf(buf, sizeof(buf), "fw");
+	} else {
+		name = pdsc_fw_type_to_name(info->component_type);
+		if (!name)
+			return 0;
+
+		if (info->slot_id == PDS_CORE_FW_SLOT_GOLD)
+			snprintf(buf, sizeof(buf), "fw.%s.gold", name);
+		else
+			snprintf(buf, sizeof(buf), "fw.%s", name);
+	}
+
+	ver_type = DEVLINK_INFO_VERSION_TYPE_NONE;
+	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_UPDATE_BY_NAME)
+		ver_type = DEVLINK_INFO_VERSION_TYPE_COMPONENT;
+
+	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_FIXED) {
+		int err;
+
+		err = devlink_info_version_fixed_put(req, buf, ver);
+		if (err)
+			return err;
+	}
+
+	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_RUNNING) {
+		int err;
+
+		err = devlink_info_version_running_put_ext(req, buf,
+							   ver, ver_type);
+		if (err)
+			return err;
+	}
+
+	if (flags & PDS_CORE_FW_COMPONENT_INFO_F_STARTUP) {
+		int err;
+
+		err = devlink_info_version_stored_put_ext(req, buf,
+							  ver, ver_type);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int pdsc_dl_report_fw_ver(struct devlink_info_req *req, char *fw_ver)
+{
+	return devlink_info_version_running_put(req,
+						DEVLINK_INFO_VERSION_GENERIC_FW,
+						fw_ver);
+}
+
+static int pdsc_dl_component_info_get(struct devlink *dl,
+				      struct devlink_info_req *req,
+				      struct netlink_ext_ack *extack)
+{
+	struct pdsc *pdsc = devlink_priv(dl);
+	u8 num_components;
+	int err;
+	int i;
+
+	/* Pairs with WRITE_ONCE in pdsc_fw_components_invalidate().
+	 * Use READ_ONCE to get a consistent snapshot of num_components.
+	 * pdsc_fw_components_invalidate() can zero it concurrently during
+	 * firmware recovery; using the local copy avoids iterating zero
+	 * times when we already decided the cache was valid.
+	 */
+	num_components = READ_ONCE(pdsc->fw_components.num_components);
+	if (!num_components) {
+		err = pdsc_get_component_info(pdsc);
+		if (err)
+			return pdsc_dl_report_fw_ver(req,
+						    pdsc->dev_info.fw_version);
+		num_components = READ_ONCE(pdsc->fw_components.num_components);
+		if (!num_components)
+			return pdsc_dl_report_fw_ver(req,
+						    pdsc->dev_info.fw_version);
+	}
+
+	num_components = min_t(u16, num_components,
+			       le16_to_cpu(pdsc->dev_ident.max_fw_slots));
+	for (i = 0; i < num_components; i++) {
+		err = pdsc_dl_report_component(req,
+					       &pdsc->fw_components.info[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static char *fw_slotnames[] = {
 	"fw.goldfw",
 	"fw.mainfwa",
 	"fw.mainfwb",
 };
 
-int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
-		     struct netlink_ext_ack *extack)
+static int pdsc_dl_fw_list_info_get(struct devlink *dl,
+				    struct devlink_info_req *req,
+				    struct netlink_ext_ack *extack)
 {
 	union pds_core_dev_cmd cmd = {
 		.fw_control.opcode = PDS_CORE_CMD_FW_CONTROL,
@@ -134,12 +240,41 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 			return err;
 	}
 
-	err = devlink_info_version_running_put(req,
-					       DEVLINK_INFO_VERSION_GENERIC_FW,
-					       pdsc->dev_info.fw_version);
+	return 0;
+}
+
+static int pdsc_dl_info_get_v1(struct devlink *dl,
+			       struct devlink_info_req *req,
+			       struct netlink_ext_ack *extack)
+{
+	struct pdsc *pdsc = devlink_priv(dl);
+	int err;
+
+	err = pdsc_dl_fw_list_info_get(dl, req, extack);
 	if (err)
 		return err;
 
+	/* Version 1: report fw from dev_info (running only) */
+	return pdsc_dl_report_fw_ver(req, pdsc->dev_info.fw_version);
+}
+
+int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
+		     struct netlink_ext_ack *extack)
+{
+	struct pdsc *pdsc = devlink_priv(dl);
+	char buf[32];
+	int err;
+
+	if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2) {
+		err = pdsc_dl_component_info_get(dl, req, extack);
+		if (err)
+			return err;
+	} else {
+		err = pdsc_dl_info_get_v1(dl, req, extack);
+		if (err)
+			return err;
+	}
+
 	snprintf(buf, sizeof(buf), "0x%x", pdsc->dev_info.asic_type);
 	err = devlink_info_version_fixed_put(req,
 					     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,

-- 
2.43.0

