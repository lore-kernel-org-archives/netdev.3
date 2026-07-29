Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23F2147E5
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297174; cv=fail; b=Wea3i/IrPVbasJX5Wa8p3qTi3ffBdA1IYNwX409n6WEsCJsoUJ0qNxf9/+PeYSryFhe/0TBFY9U3e/613/jfEQhgBGqyWsmc0AisMc5xwcjxRWZ8PC+mCSsbvBH27l2M2Jc/Xc0Ji9jluKBhN8Hwh3AoyZhSLwnBsbyVPSpF6w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297174; c=relaxed/simple;
	bh=9kvkwWAgWl8m3IwazyeDsR7HOY/PkZXhvnKhg81Qxr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hA2wdX+erFp1LrPTebeJCTplKEiReOK3z9UN0k6JUe/Ag9BuCscaGD/Ly4iIxCKO3f2i4fsA0dhB7kcnHGrTHx/5RACzmcQkyhb55letbqVMiBiDxLlFuiOk/9PnwlzHjdM3y65+S0YdV3JjCTTbr374AjNM7UMLGOhMJGkZ+bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5mDG+CFZ; arc=fail smtp.client-ip=40.93.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5mDG+CFZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvhBlJo8QdF7v8zBLlEmM6FH1gS6uQP8W/UyokcV55xrcOkeovRszAlt7okKetb2AgEkyEFZL2qpTVl/SfMn4vayl096SvCFtu0U4yWA8aPPijXNUQWjV44wOyguDq+ZS/3C7r+bqaSEwOXLQJV6BAO7j0LhK1wwChXwEC/Qcvgd/GPX6Z/GBZzhA4G5Pm0F0vuLqb2LfKMM0+823OEUNcMV1XzoAJMXbnK93vyYcssLW0ZSWE1t6juOfS31P1fKV0dMCnkq4aVGmzBPlivIx6Pg9jYc5CFXlBF+PojU5sZ6TuNJ0LXagBzlvv5x9b+oygvRPPOkcqXl1hvZz3EByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65P14G8MrJ6FxNl2IrmSBJvlbbeTKasggJPClwg7HIg=;
 b=Jj6ZMz1KJ3HIThfWHcxeuLBVkIC9Qw+uP4Kxqt9FDN8boPnujdBENIrN2HLSrDj0QbIk4PhIWC64k+9zTvyv6kpCm9SF1WErDlJ6kMJP8bugYVIaC8i51ZJBKLBHyym7FlFIHKDfHFjXwU6pCn5Yjix5q5KZgCTdtZz3Pt08z49P3iojZ1Eju5Ld1zVWrULDZHJyN8wjOt9v6XJj2oAnibfu89tYv7WYZWGDL+zA2T/xyDaF8IacjO7+7yGJDYeiPxL6K1qhk3L+jsb/6gdO8G5kfpBA8ArOtY3B0Y6Z9Et8L3gFYEKoqdBdH5xPYn7tTSqrpPTteVc21IOrm8z0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65P14G8MrJ6FxNl2IrmSBJvlbbeTKasggJPClwg7HIg=;
 b=5mDG+CFZp3W93k6RWYSzCkHQcJEAKD+2LkJzy0cqIA03EY+rDSHEW9lJPLmISnAw7aUcZTHnpq2doYalGDaXoRRtduuwG/3Ebczn9V/HxLvEUXUfKdINZOFpNytR7r4YMJ223tPPTg6R1GnYip7umsjW5bnmSicClY9owvEh4PM=
Received: from CY8PR12CA0047.namprd12.prod.outlook.com (2603:10b6:930:49::20)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 03:52:47 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::63) by CY8PR12CA0047.outlook.office365.com
 (2603:10b6:930:49::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 03:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 03:52:47 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 22:52:45 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Jul 2026 03:51:59 +0000
Subject: [PATCH net-next v11 4/6] pds_core: add PLDM component info display
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260729-upstream_v8-v11-4-e4b7d5bb2913@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4ed367-a2aa-47f5-bcbe-08deed24da8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|3023799007|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	tu/O0g0crWaAOUAHdSWFsU1PBPKVDSeznK8Vg9KFFzYypSbY86kvtSrOSgji681fuUfYXi/zRjXiAdmW3jKD7v+ryyPTyINYbHKpiTKXmb7cHvTewIzCV/PSvqTcBm4ove1oxoqKsybiprrQEL+3/9DwTN56y/epllZBKJwlpgMS0oGpOS5E1kor0tTFc9NxpwTctWYK2cbDRjGQ5T3Q0mXW3xt/6hg+yAVOiBKK7tQ06prbewXn4FrNTARLMDv2l1joHBHFcSnALYR0Up/UYswhMuipkEsY5zuo6qo2yexkDZi7ridUTjPPDtaf+S8PeUlO3O4jSnqdFDadIbE2S/OgBOjIa97FZBoP4rbhtb+mFILj2Bs3GztKnHq1CHrrAuezEm1vzKgWSs/wqQkf13FBqgqB1QiAVEMLu2bjnb00GVRou0/X1Xo3kxV9MmDmjmTr3oAuFdhgjOLZBoJ04fnv5yMTcWGArZe3B047PgLruoftontL86gpdPFMg/6PuIJbwM+K6b3ds5baduwsYgm9KSiIZ88g6JwxjtbfvaYKnkPZiSr8Up1jxDJykHD1zJ8hyeySe7NZwtXqL77BNmTQ/LcFj+lNW0FJb32Vof/kqXoUop+ey1D4UO4bYP2UbCzyS4XVnSMp1arqCM9PDpwjVsOmwpoDsYyGyqh0mEwQwEFsZbvXApnkxCk7ailI4SblPXdmd89zfFAqfvAgYw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(3023799007)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ack+qD+uA6AkigPVnbSaylZ1XsmutZUJfRWtyShk1hhjLEAv3PtlSZVlVYusx+6x0siGdQc3mv14iQA9hsvD0kGpoDqnMq5+fewq0Dw9F+KskLsTj5HLFDF+Xcprls3lHnggCll6MFNz00GpIMc6C0Q1mpUH0/DKIj6wVk4d1gln8z6qh0lELWqHNR7OsKeesA7oRYP+IFkmBorH+3Rxv6ZK+JZRUicEZXAYJco3b1F9w03eH0csn/bIfV1vLs6KdcjHEBXzSvHiWYo1jMuvYSBfT/HziTLbJLXlfS3Fnl9jAu4inJagk4upFDKHMK1qvZALxjwh8McLDsPxeJUoloyYIvFqouvAmGxXvHb/F4D9dTHeV0BLrnJwySDYM5DTB863zJB1OBvyqh9km5EEBciKjBeCdVSKLyQ8hDFvze+16J3RhArzmF9jdDvje0Lo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 03:52:47.3507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4ed367-a2aa-47f5-bcbe-08deed24da8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005

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
 drivers/net/ethernet/amd/pds_core/core.h    |   1 +
 drivers/net/ethernet/amd/pds_core/devlink.c | 145 +++++++++++++++++++++++++++-
 3 files changed, 143 insertions(+), 5 deletions(-)

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
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index c686f0bbbaeb..73356c74bb9f 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -340,6 +340,7 @@ int pdsc_firmware_update(struct pdsc *pdsc,
 			 struct netlink_ext_ack *extack);
 int pdsc_get_component_info(struct pdsc *pdsc);
 const char *pdsc_fw_type_to_name(u8 type);
+void pdsc_fw_components_invalidate(struct pdsc *pdsc);
 
 void pdsc_fw_down(struct pdsc *pdsc);
 void pdsc_fw_up(struct pdsc *pdsc);
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

