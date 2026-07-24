Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9243FD02
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927320; cv=fail; b=QbT18+EaPlPaCioc1js+FV3GaWy2y5OjnVDGrpcFfDXEjelpTeg9Lln6ISCjeNXxxNIKhRfNHJoCDxmIrlTP8c9dkxlOaQh7I9n1RVZSvCdyB1qVATvY0j1gvOr5hd60myOf+Ahc+3dOr2x4YHwK5pF6nX9Fb7ft1dFE9G+X6wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927320; c=relaxed/simple;
	bh=VMwngbJtVYQdZ+6gdez4X3t4tr0cW7M7Ij427jVtr1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZZ/xMGB/SmOZsOKkE/uYZqHqDl96dRKtQYyAI16j+vs4OEbjdbtUWi7ramm6c5ulCu8Ic2v8kgiBYTPHDkQMRb0dhv0jkizqQ/tgAw5T2d4Y5s6yuR/cy+BXz10f+BgqctzMBn0qSVz5uvH/qujfph94tGQQUvEeH3RJKaMTnqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k0HyKKUL; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k0HyKKUL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdWH8IqDUloMtd4cJkvBvbYm4z0qFU5BzCfKtwMX4MT5HdjyUlTdpe9Z3n4CT+VK6AAM9RiYQ9cnxhK7OWfVPkLOj3dLusylf/xJ1/HPgXfYEs8VTL1Ugno2poZIaxbuR995EH/No1f5hlQSvtPy0bgHQr4bFVJV6qyFJS7jPUuBVSs39aDIekaKc136Rwsfib/JBbsU5aFt3rq83dzOO/JNa+zIPd0aPp1lQrODcYMaVIEruv+uHjOkYutKk8YylBjkDMqH6EZg4bxdiJ0wEUWlFWz694kw4EcSwTXx+brMXMbv1kVMu258xf4+F/X5yWXZVOOpivxK/jDGRG8XFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eeAvMU/nboPz199VIOIqtseQwhgI5wme2E3j5g0KAY=;
 b=XosiZ5/+e4hcyuCHP8FeW4fse+bEQ66ysLWZospULc+wPC4TU/70lughiGu0e98iZA4SXn5A5kL2ZPwINZn+REMH2BgfME3BLpKYc+fn3aqLu3naCxY86DCFwKFxc42FEysKZRZ9+CMcNwMXHK5oe0rfAZ6fXJTryGQlaVKKsmCTguO0R0V3yuiiLSBuARbbTSF49Gshc115jyGh8AwkE00WPxoDT7TXlDxQB5ZSysFfqlwLKdhRU/hmSmsasZZBCbbyGI7Tw817BFpwwsLW2RG6pgmwVPFLC35fzH86hasPc5lJ2AuqEow4TuVCIiyTX+/iksdmn3pA67ySAFvejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eeAvMU/nboPz199VIOIqtseQwhgI5wme2E3j5g0KAY=;
 b=k0HyKKULrdb+iXIxbSpXAS4Xz3AQbox6cQE/iQlhiRKrzp8gBlnK1IOUzh3gT+kPlvSnII0RahUFskHparwZ+knN2Gl7yMV0xDotoTQRoc0rhZsrpTLd3n5fYzv8HU+ne0HgclzzoxGT2RvC6xk8Ee6xyWzqfZQxQXCk7Uj3MsY=
Received: from PH8PR20CA0020.namprd20.prod.outlook.com (2603:10b6:510:23c::21)
 by CH1PR12MB9670.namprd12.prod.outlook.com (2603:10b6:610:2af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 21:08:29 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:510:23c:cafe::3b) by PH8PR20CA0020.outlook.office365.com
 (2603:10b6:510:23c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 21:08:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 21:08:28 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 16:08:27 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Fri, 24 Jul 2026 21:07:25 +0000
Subject: [PATCH net-next v9 4/6] pds_core: add PLDM component info display
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260724-upstream_v8-v9-4-8425762b8b7f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CH1PR12MB9670:EE_
X-MS-Office365-Filtering-Correlation-Id: c2aedf52-300c-435e-8942-08dee9c7b5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|22082099003|18002099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	KB7RYESu7Xzg/R2bgR2noiKbG3OHz7K1kSaNnTc96IcYq0ff2OcUDpJOcm1tLm3adfzwnYUYAzsxsPsPTor9ftcYkuf1FmiE0Fe7HkWO9aqFp/Lye2u3j9kL4P5UAAyePAK4RHV37RnlRX8+kKwLJCzvwSb6I0c3Y8nY07PGZ2ngXsfk5Pq3jyl5nL++COsUP3gxRgytMVk+Ck+FYTJbeKKsAcKcDfw7zwRMRmcImxlivY56+7vGuF0yOXcyb/FilInp87AIwG8MUbYJVJ9wvYqCpPCsZOW5zt66DBgniwe6dEnJWxbO3rZMOLBRs6vTBYzSNv5I/y9OX5P66UaGlxqTvx13BO0qIw3VkjZyNN5+JU1U/oNB4vgSJKzztMy4oAGrNDfY3WQrKqBJ94/PmGxuwE3/Fo7k8acvKLw613E1mysWtrSCxuIr50SBLDiiMUEUoNFoLiNGlcEs8T97DD++DqPYjbn/fiTBn4062r08O9rvzAuJEvp7CeWi/ZV9Z2KqrHUnh0j6k5acuwjoCP+s/r6HpwcjicZmce1ffvruWvrN1ZOSVR7iveOaErMQB3Amcf5JnyHTmJPeJ3QR2Tda4TKO+0c3i7uYRgHHA3eEMVhstrmG3a8QQRO1Fpqdf/AWx9yp7DuODPwmddUpFwbkB3/AkOqtUpsh3mg5hM1SFm5Tx4QdUxZ9o+UFFFQIMuI/9brYU5Kt9KdHjxZIzg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TZIJumjm8ZYbeXXkKAt3EdM0+SMtxMGTe/Kc/o2+cKZ3LJg6/RioQ6A/quAFtrpW8sROd95ktvYzW50QvCxKKi5BknUm4aXTc3FZ0WbFw14KB0eR9F4QZIolSaE0rxqd1mZa942EFk6fRRjD09k/XhUCqNnjs35lnJM7EKw+rLACfVlSnOt+awIM0wdX+jxnFjKBOuHPoM4+3vbnSlkk0Zk6wS9p3bG4v/hEaKCKtpNcDrZvg+Gsf3sJd9NAc07tWP6fdeHpb2yn1TVg9IFwrqNsxdw8xzIfqsIQJzjeaq5pJrpCZu5ehX+smVzOQNl+Asth6XyUrlxoh2m/mjnIb450qq/IgT4RWcRxBbkewooV1sGCRC/JTu+wyC0kpZkZDRLsJV4RuFDnHl8CZ3P0sBPFydcZ0B6XR7grT1HyR8H58/RRmfMGTpb4ymj77JPK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:08:28.7650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2aedf52-300c-435e-8942-08dee9c7b5a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9670

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
index 616c7d7c0ffe..12f90b0ee0df 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -99,14 +99,120 @@ int pdsc_dl_flash_update(struct devlink *dl,
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
@@ -140,12 +246,41 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
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

