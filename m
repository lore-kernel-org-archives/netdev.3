Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE6470117
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661231; cv=fail; b=UixRzMcsjtFIcrIQRRk2I6fizy+Mr8n69GUNcHBFFjthE8nr8WqSCoqQmKfbrdg15f20yZsUglEr6yVlQwQDDb/FfhWmYYqd4MzaPm9lVB1r/E267r17XjlexkzMxFRii7y/yVoVzW06rE8pPIHkkWZW9ceTa6rysjb+D/6yOKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661231; c=relaxed/simple;
	bh=7C4XkUvQf4zxoUWNiAhBimdnPaOCeLYEDURWAXopqdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GXdqOlKAQDPN0t2mv3fwgoAVYQhmWsRwByjMnhdCBeeOFwCkBmW5qws3nKT7brrUPvcJWsnJVc/wPpKyYyfDvqja7+/mRBI/3bmaXXAStOJ9x7GVRyE8zhKNsoftMhcNGE0XCQFwqoU8H4SXyfFMJb2T4L+gauv0cuMoqS4YqDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MwW2aYe8; arc=fail smtp.client-ip=40.93.195.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MwW2aYe8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEhEkUvM6YcW8sgJZdIFj59OTkp3eMJDWs5IGrezpqOV77QuwPSYOsNQEHKKOhrDaPujz+ds5p2yD4EP7WPvAHoH93W9U5A4YC97w9BVAX4y4pyiq0V+vtVOVNTrFpae50vLCdTfT4dWFwhAHchdc9qXIO2VGEJl0JEJryx/e4h3MRAHeNpWSJ2bZEwP1sp+yHO6LNPgW0y+X+qlD0FwtopjYB8FgSH0wId1jXhQIj83ITchG97A+19+j1H3urjfYr0o9bCp9km0YFMIQpOCNC+y3yLH6GlTGB76vRYn5PTa9mfQXbdNy9bdowbXUbsKVZXbdU7RtWocIFRngSC8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mijV1+pLgBl2S+MnNpW/RwOeg1PRNCUA5ORaZz7YZU=;
 b=hQ4mjoHU7l5UnM11uXY3Pe9H30uAKM7NNAuIA7yR9YN/CO4GfZnLOQCPWC8mHbB3WZLBugVVrvxQm1pxdKCdK4IpQ3JxcBFkDmMypCWPuy15Drso5shdetYyrqHuxPejRVkO/cvewH8kmGthIIENteVYo0+pIYWaBwzt+ypPk4YVqvhLp8FV5QCEWOGjc7M7XQITUA2oLwELjv50R3SO9N5JhjGZHqyW54kD9MVMUiLoHRYbSETyPVEl0hCzo2DIyiQF59uIgv3Zuka3OoiGJ4T6CxAvahRLRF7wT0A5n7hp/hE2lD2jSYt7szYP7xAvok3WEwjqF/TzWdRVrLJqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mijV1+pLgBl2S+MnNpW/RwOeg1PRNCUA5ORaZz7YZU=;
 b=MwW2aYe8Gv0JTpTY1msRopaQ8Laak8lcQ+oZkAf/o6OaKIOZoaiaCcYpxvg5qF0fOLOGsusAnln/WhonWEilzEgKy68aIgJwt+6H0wqvIh/r6CHv4BwDOx5rFdg71gqC8T6VMITy+Ggv6BB04LY5G9rhcL0d75SYxPDRFYuWPLk=
Received: from DS1PR02CA0017.namprd02.prod.outlook.com (2603:10b6:8:44a::12)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 19:13:40 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:44a:cafe::43) by DS1PR02CA0017.outlook.office365.com
 (2603:10b6:8:44a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:13:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 19:13:39 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 14:13:36 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Tue, 21 Jul 2026 19:13:12 +0000
Subject: [PATCH net-next v8 4/6] pds_core: add PLDM component info display
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-upstream_v8-v8-4-1ea9a8b7c4ff@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e666815-6691-4fc1-191d-08dee75c2c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZrQvBLc/polVXunuZLc5hni+XmK6jhQnNuHtZL2/gjIk02nFEvGeCBx1TVmfb6KdNhcHddQQwlpdcFzluABkVX0r0g6P87dlbyoiC9Fi1g/Fd7LFuiQ5qJDiJAuB/bfR1Hy9/kvv1O58OIukWzT9kfWcTuNsq0RH1CuZkS6cHKKEhp0ZTBtvsfeiEGzH0Cj18v/1hA6PCchjsDCHBTIWneIMIH0O91HQLmhvcnqv7yJul5pknProcJ05stV4yir1Vw1ShMpaj1lJeOs8ppBSyTkw87mOkOLNxHVotICkgau1nOhe4W01g4u+2tP3XwTIUTzHmJ2WCVNkkWU5VzLTDWjU8K069JGKrgG1mN3zgiW9l6SzWfh8g32QocVFQpGecxnri+BEe0RLViRL7TtHRIBQeRzD3+WgQKd2qQmhF9lHbPUwFiPWvLxQzIbcLZJgN+HGNawptaKugHJ87Kb2ScFtRTTHHDDU5tqOcOTc4PPr346s450gxDp6zWObjBNIRr1ZfIzhz+/Jj51c8pPko36pdSKsyBaP1gUMHmKOlKaaWGrrcN4Zafzt2v5/Af7WBZYz9SWGnrWawWymsrnaqC5s1XPbH3X02LNTmC6/VwnMx/QIsi31P6JJJe2WnqoYTEDdoVMW7SFy+BvURCqdKMj0hUsM/k0G4WZAOT5avWeS1l4xO1c3bR0xK6mqHPXSRtnFYKYUs1bScknbyHnWrw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v0TUcX6qrETvi9eDDh9lRUHMm7zY8Ztkizn2BHo8MJmZeA3hrqne1XA2LALH3KWCIPvUd0kFiJYhHR29rQAC+bQkNbZVdj6lb13idRg41aTZPid9D0DjojQXVBP55W1ABw2Xfi+hnmEkZgzFKcGeJ7xjjAljkYn9Wr5/j85XyMvLgjosomhsmy3nxncd/pfd6mgUNdlGDYMk5vz3vuDE6jVO9VcqPDtoN3bUEUqfu55QhEXR0TG1PiDpKasUP9gINJ811euMS6j9hDeVYSe3q+1MvBUzzLRq6nny4c8AQI/8e7LBtz8vKH5Gv4mlS4G5FlvUffR8mAnH8os2EuU6jXtiXQR0OpTUp5Tcjis0ol8Eheujy52Ho6lsNKjpOCAaPNWfFxfaK4M97sTYOkqQfQTSdTDdivUz2Rj3fOdb3dEY9Ug6v6YmJk3hm1Q/YPkY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:13:39.8669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e666815-6691-4fc1-191d-08dee75c2c4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947

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
 drivers/net/ethernet/amd/pds_core/fw.c      |  12 ++-
 4 files changed, 153 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 6c62ff7a32f0..a7a0bcf98ed3 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -589,6 +589,8 @@ void pdsc_fw_up(struct pdsc *pdsc)
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
diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
index 62b053478bc8..7a29a1f85b2f 100644
--- a/drivers/net/ethernet/amd/pds_core/fw.c
+++ b/drivers/net/ethernet/amd/pds_core/fw.c
@@ -42,6 +42,12 @@ const char *pdsc_fw_type_to_name(u8 type)
 	return NULL;
 }
 
+void pdsc_fw_components_invalidate(struct pdsc *pdsc)
+{
+	/* Pairs with READ_ONCE in pdsc_dl_component_info_get() */
+	WRITE_ONCE(pdsc->fw_components.num_components, 0);
+}
+
 static u8 pdsc_name_to_fw_type(const char *name)
 {
 	size_t prefix_len;
@@ -759,7 +765,9 @@ static int pdsc_flash_component(struct pldmfw *context,
 	if (component_type) {
 		const char *type_name = pdsc_fw_type_to_name(component_type);
 
-		if (type_name) {
+		if (component_type == PDS_CORE_FW_TYPE_MAIN) {
+			component_name = "fw";
+		} else if (type_name) {
 			snprintf(component_name_buf, sizeof(component_name_buf),
 				 "%s%s", PDSC_FW_COMPONENT_PREFIX, type_name);
 			component_name = component_name_buf;
@@ -966,7 +974,7 @@ int pdsc_firmware_update(struct pdsc *pdsc,
 		err = pdsc_legacy_firmware_update(pdsc, params, extack);
 
 	/* Invalidate cached component info so next info_get refreshes */
-	pdsc->fw_components.num_components = 0;
+	pdsc_fw_components_invalidate(pdsc);
 
 	return err;
 }

-- 
2.43.0

