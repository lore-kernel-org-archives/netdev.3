Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02522147E5
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297170; cv=fail; b=tqMCfXJoRqtC9gbZg+ZvyGX4l+coTzM6R6z9SwZPK9RcPRFjr+djOigEWxgcNoFq8EZqo1LqNQ1hbsHtABWepvoPDbKoZJm3fFKvwmipOGiyEgG55xTCpDRYaLww5KxpAwNtOVjgytJ1F7LHLSGX9QI+3R/KZOk1BtdzpjlsmZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297170; c=relaxed/simple;
	bh=3Q6WlL4c6PMjuI6PqMxfgA7sVeDCQa9sTFlybDxKWpg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=row09mEvMBkd4C9i18Q1uo08whUotrtios2npX5xy8fakaB+Fa/HBSD0Vs0gMZGpOBs0eVKrnzAHS8+He2j+vdFHfXitlSmnIiEPYTxeWpO1uRsE60y3NvsYw9XLU/WfQENVMhReGy+PIe7nyepsPiPJmf22MxjpfjgxdUkxQGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gh4HvaMK; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gh4HvaMK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ER4hCovin9jHhSe0VH09+jRdZvgCH+TeahjJuiQWk61DJG+7/sbSawVZxeDATXEbbSHi2EoXhMsyZbyoTEyLFBHAGX7uxQyOHbfC+0cTpAwAXKu7JiEXiwig11IdNrGJ21e/8WCuHHKBqTGOBRDrzySp2maLw+7KvWI7DbGL7X6hyUbCNqSxQFKuQ8Aa2G+kZHbkhIe3p1Jk5k6H5eFBroL/EAuzJUTKGoDSK2kzGXSMzXLAe0widI7dHm9Mrg5t6NFJR+mx/2XUlorL+G4j79xJYaV5KUvymo4FUoO9V8UdNN6N4gHzb6bwZJXCB3dLwRt8irb8EawXzbyC7boBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDlH6EbvIKewlrS7jw7wrWrHzuDbp58Kx0gEPxpGJOE=;
 b=DTAIJVSbpRruu3GvPUcd2VXJnokPMxsHSwW9WL1ZOPXWWHDFaal4hn+tCz+j7i5IqcLJH/X/RxH2MnkqbNu+gRsI1m0p+bp4j2BCuTGrmDTG/TBhucJz2vot6F8dZpM/nn6y51OrDt8dhwH1fEe0em58vFHPyfVrf9G4024vibp+qEdiP8lXEiAGjDsWbT1NQAn49mKhkp303kVsQHLGY1QMtRqqeJdJ00S/LjdWaPZSiOQYLFpPQ6Qw0luML8QLw5HqTA5PpF39WT4+nyPVohd/8/TA5FU+FPLwW6HIib+/q7vpJcl+YkuC9WXgfcK+aqcNpbA6GyLN3qL6aPcZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDlH6EbvIKewlrS7jw7wrWrHzuDbp58Kx0gEPxpGJOE=;
 b=gh4HvaMKfOsYBaMLgP6PXiQjM5AfxC2wLE46YBfAFvDlV4Pp+4wiiHzVJqX6EglmR1KhdcHsbx7F8ZMWmrsAalTDWgpUDU69Gyfhy/TKfi/9HbywsAEJ3HJtOeekLQ630xzY+xly6ESpMgvi+Aq4AhQHSFY6+oEZNg/EyOGg0bg=
Received: from CY8PR12CA0026.namprd12.prod.outlook.com (2603:10b6:930:49::27)
 by IA5PR12MB999301.namprd12.prod.outlook.com (2603:10b6:208:60a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 03:52:44 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::95) by CY8PR12CA0026.outlook.office365.com
 (2603:10b6:930:49::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 03:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 03:52:43 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 22:52:41 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net-next v11 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
Date: Wed, 29 Jul 2026 03:51:55 +0000
Message-ID: <20260729-upstream_v8-v11-0-e4b7d5bb2913@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANt4aWoC/23NyQ7CIBAG4FdpOIsBpCyefA9jDLRTi0lpA9hom
 r67tB5cYjKXWb5/JhQhOIhoX0wowOii631uKN0UqGqNvwB2dR4gRpggklF8G2IKYLrzqLDeMW2
 h5KI0AmUxBGjcfY07Ig8Je7gndHpt4s1eoUpL2HLbupj68Fg/j2oVf3/kIpiC0UZZWfGmOZiu3
 lZ9t+aO+lPyb6mzVJyVUjCb8Y+k5JOqb0pJtlzUprG15KWkbzvP8xOsbdKANwEAAA==
X-Change-ID: 20260721-upstream_v8-9329be5465a6
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Brett Creeley <brett.creeley@amd.com>,
	Eric Joyner <eric.joyner@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>, "Vamsi
 Atluri" <Vamsi.Atluri@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA5PR12MB999301:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2e4fe4-52cb-4297-b6d1-08deed24d801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|13003099007|6133799003|56012099006|10067099003|11063799006|5023799004|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gW+Y4slnyiXctMRPfEDL9fy2FpINl/69oUv98Lb1rFK8NUfVikpb2492gwIZJISirsA8OnkkVx4zdHFf7e0jXlkBfQFqonN95MH0sbtxM6sUo3D0EKdsftn3XdKqYx2KDv/oaBQRd5qxnICpdVRNsGLSsS3bZSut/ulGYITr633ezcPSy+xBXmXTmnaaTjNP1liX7tg176/YRA9lwMjx/jAOU6FiIvG2+nu2TOMKAXf/hp6HBMRsY/7hwgZw5NSCcPZ6gZHY+58ObZCOnXs4Ucudi2u2+GtQraGwMC1meUKK/B/kBTu4cTb44IKO0uvbUsWWGJ6u4ut6On+Ic3hIMbnv5pe7f44H62gk58pYO9PTygoX4LIXdeu2Y82E/rlpcyMhiMAvwn2KcEbVLjtx4Cne/yC5YGuolGyIVRulicwhFsUfboYTqdA7Ljg4ZR1XVE9/0k1N9n46Q+e+Ps8nQCT7PlBfwsCxjfg2tjuh44k0CwQOEyDXvcCtnIPEAn5f1xArROcPYxEc86I5Bo4ZCVRoLqxc1v8dGgbYt0HC+c/hAPb7/pZbyNerMykIUOzLIOFwJAAfhu/kO+J8iX4OJgHBYxM02A+DM5TFwh0p0Qi1C1rLTVxl2+MkYoYvkDMSA0JFBIM/6e5ebXiiVolvPqtL+tj2YAzpxlSozFjMu58=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(13003099007)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wqone3JTR0PMdXi8wJKBNmBRZFZsPSIkJvcMnRYyMQl/um654Y4MFzB1ULagN4mZeaNlU6ymYZhHp6bKFpFnQ9z0UfoIvbYTWzHj8WGlQO/KdKB1qGWmOuaKolBFOQ177CuJ5HIeggjHb1xhdwBqvQjIFJz+BFLfOqielt+8BIOjPG5QLavy1Sx23tjlQazPE4IoB/zLi+8NCTnulz7K4pTbIwbHFuJ6F03FPHouNl3L1iOjRfDyLTVlKx3yHq/zTKOr/w9yWzf7lY9dzAc3oQn48/kuvu7MW3WddWHIAkP8gRPNgOxTpfY7kYFx5I65Uh9P5fLxY+Xh5qHLK/Rdae6YBuWrtTikpAGJwIsKhsZq1G3epJhbtedGlfvHHC8m75h18s8xHI/gJ1qAdVMsZkSPgbMx6jbgLTqWMaMEjDghZ1C2gxjZjh3pV86OqKdT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 03:52:43.0909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2e4fe4-52cb-4297-b6d1-08deed24d801
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999301

This series adds PLDM-based firmware update support to the pds_core
driver. PLDM (Platform Level Data Model) is a DMTF standard for firmware
management that provides a vendor-neutral interface for firmware updates.

The implementation uses the kernel's pldmfw library for package parsing
and component matching. Users can update entire firmware packages or
individual components via devlink flash. Component information is
displayed via devlink info, showing firmware versions and update status
for each component.

The series also adds host backed memory support, allowing firmware to
request memory pages from the host for its operations.

Changes since v10:
- v10 did not reach the list.
- Patch 3 (PLDM firmware update): revert to matching the requested
  component by type against the components in the package (as in v8 and
  earlier). v10 filtered the package by a single device-side identifier
  via PLDMFW_UPDATE_MODE_SINGLE_COMPONENT, but the same component type can
  have different identifiers in the standard vs gold firmware packages, so
  per-component update could fail with -ENOENT. Also reject a per-component
  update when the requested component is not present in the package.

Changes since v9:
- Patch 3 (PLDM firmware update):
  - Fix a v9 rebase error that reintroduced an -EOPNOTSUPP guard in
    pdsc_dl_flash_update(), which rejected all per-component flash
    requests and made per-component update unreachable.
  - Implement per-component update using the pldmfw
    PLDMFW_UPDATE_MODE_SINGLE_COMPONENT mode and component_identifier
    instead of a driver-side component-name filter. The name filter
    silently reported success when the requested component was absent
    from the package (nothing was flashed); the framework mode rejects
    that case instead.
- Link to v9: https://patch.msgid.link/20260724-upstream_v8-v9-0-8425762b8b7f@amd.com

Changes since v8:
- Rebase onto net-next after latest net -> net-next merge
- Link to v8: https://patch.msgid.link/20260721-upstream_v8-v8-0-1ea9a8b7c4ff@amd.com

Changes since v7:
- Patch 2 (identity version 2): log "Cannot identify device" from
  pdsc_identify() (the final outcome) instead of pdsc_identify_ver(), so
  the benign v2->v1 identity fallback stays quiet.
- Patch 3 (PLDM firmware update):
  - Skip a component whenever send_component_tbl reports response 1, not
    only PREREQS_NOT_MET, so components the device reports at an identical
    or lower version are skipped at the component-table stage and reported
    as "Skipped" via devlink.
  - Initialize the deferred DMA list/lock in pdsc_probe() instead of
    pdsc_init_pf(); pdsc_deferred_dma_free() runs on the common PF/VF
    remove path, so on a VF it spliced an uninitialized list head.

Changes since v6:
- Patch 3 (PLDM firmware update):
  - Add config space read after pci_clear_master() in teardown to ensure
    in-flight DMA has completed before freeing deferred buffers
  - Use list_splice_init() to detach deferred DMA list under lock, then
    iterate and free without holding the lock
  - Add NL_SET_ERR_MSG_MOD calls to PLDM error paths for better error
    reporting via netlink extack
  - Use PDSC_FW_COMPONENT_FULL_NAME_BUFLEN macro instead of ad-hoc buffer
    size in pdsc_flash_component()
  - Simplify finalize_update loop condition to `if (err != -EAGAIN)`
  - Reject devlink flash with component parameter when firmware doesn't
    support PLDM (returns -EOPNOTSUPP). This depends on a fix submitted
    via net: https://lore.kernel.org/netdev/20260708163649.128620-1-nikhil.rao@amd.com
  - Update documentation clarifying fw.gold is not a flash target
- Patch 4 (component info):
  - Use READ_ONCE/WRITE_ONCE pairing for num_components to get a consistent
    snapshot; avoids iterating zero times with no fallback when recovery
    path invalidates the cache concurrently

Changes since v5:
- Patch 3: Changed "fw.suc.mainfw" to "fw.suc" for System Unit Controller
  firmware to be consistent with the "fw.mainfw" to "fw" change in v4
- Fixed bugs identified by sashiko:
  Patch 3 (PLDM firmware update):
  - Remove stray kdoc fragment in pds_core_send_component_op enum

  Patch 4 (component info):
  - Fix fallback to dev_info.fw_version when pdsc_get_component_info()
    succeeds but returns zero components

  Patch 5 (host backed memory):
  - Expand PDSC_HOST_MEM_MAX_CONTIG comment to clarify why PAGE_SIZE <<
    MAX_PAGE_ORDER is not used

Changes since v4 (sashiko review, Simon Horman):
- Invalidate cached component info in recovery path to ensure stale
  versions are not reported after firmware changes
- Fix v1 error handling: propagate errors from pdsc_dl_fw_list_info_get()
  instead of masking them
- Fix v2 error handling: fall back to dev_info.fw_version only when
  pdsc_get_component_info() fails; propagate devlink errors so partial
  replies are discarded
- Clean up max_fw_slots comment to clarify it contains component count

Changes since v3:
- Changed "fw.mainfw" to just "fw" for main firmware (Jakub Kicinski).
  Gold slot main firmware is reported as "fw.gold".
- Removed redundant memset before alloc_pages (Paolo Abeni)
- Changed dev_err to dev_warn for alloc_pages failure (Paolo Abeni)
- Only report dev_info.fw_version for identity version 1 (version 2+
  reports firmware via PLDM component info)
- Fixed checkpatch alignment issue by extracting pdsc_dl_info_get_v1()
  helper function

Changes since v2:
- Use driver-defined component names instead of passing through firmware
  names (Jakub Kicinski). Added component_type enum that firmware populates,
  driver maps to stable names like fw, fw.gold, fw.bootloader.
  Added documentation of firmware version names to pds_core.rst.
- Fixed bugs identified by sashiko:
  Patch 2 (identity version 2):
  - Fix comment using wrong macro names (IDENTIFY vs IDENTITY)

  Patch 3 (PLDM firmware update):
  - DMA-after-free on EAGAIN/ETIMEDOUT: when a command times out or
    returns busy, firmware may still be accessing the DMA buffer; defer
    freeing until a subsequent command succeeds
  - Use dev_warn_once for incompatible firmware version (ver==0)
  - Clear component cache after flash to show updated versions

  Patch 4 (component info):
  - Fix min_t(u8) truncation of max_fw_slots (u16) to min_t(u16)
  - Fix F_FIXED early return skipping F_RUNNING flag check
  - Don't fail devlink info if component query fails; use dev_warn_once
    and continue to report generic fields (fw, asic.id, serial_number)

  Patch 5 (host backed memory):
  - Switch from adminq to devcmd; fixes both workqueue self-deadlock
    during recovery (adminq completion runs on same wq as health_thread)
    and health_work re-queued after cancel (adminq timeout re-queues work)
  - Remove MEM_DEL from teardown path; fixes both MEM_DEL sent twice
    for same tag and num_host_mem_reqs ambiguous semantics (now only
    tracks pages to free). pci_clear_master guarantees DMA quiescence.
  - Fix PDSC_HOST_MEM_MAX_CONTIG to 4MB constant (was arch-dependent)
  - Not fixed: pdsc_host_mem_add() failure ignored; partial host memory
    is acceptable and firmware handles fewer regions than requested

  Patch 6 (debugfs):
  - Move pdsc_debugfs_del_host_mem() before pdsc_host_mem_free() to
    fix use-after-free race with debugfs readers
  - Use %u for unsigned types and %pad for dma_addr_t
  - Remove "file exists" check (now dead code since teardown removes file)

Note: The following fix was submitted separately via net:
- DMA in flight during teardown (call pci_clear_master before freeing
  host memory):
  https://lore.kernel.org/all/20260604213637.3844317-1-nikhil.rao@amd.com/

Changes since v1:
- Removed redefinition of __counted_by kernel primitive (Jakub Kicinski)
- Fixed kdoc warnings in pds_core_if.h
- Fixed checkpatch warnings
- Fixed bugs identified by sashiko:
  Patch 2 (identity version 2):
  - Zero data region before firmware commands
  - Suppress expected error message during identify probe

  Patch 3 (PLDM firmware update):
  - Memory leak in pdsc_send_component_image() error path
  - Memory leak in pdsc_flash_component() error path
  - Missing devcmd_lock in pdsc_devcmd_finalize_update()
  - Fixed dma_mapping_error() return value handling (returns boolean, not error code)
  - Skip logic for components with index > 255

  Patch 4 (component info):
  - Added generic fw version display for all identity versions
  - Handle components with both RUNNING and STARTUP flags

  Patch 5 (host backed memory):
  - Race between pdsc_remove and health thread (use-after-free)
  - Set missing index field in MEM_QUERY command
  - Host memory allocation size and zeroing
  - Don't free host memory on MEM_ADD timeout (firmware may still be using it)

  Patch 6 (debugfs):
  - Fix dentry reference leak in debugfs_lookup (missing dput)

- Improvements:
  - Cache component info to avoid repeated firmware queries (patch 4)

Note: The following fix for an existing bug was submitted separately
via net:
- Timeout error overwritten with stale status:
  https://lore.kernel.org/netdev/20260515212907.998028-1-nikhil.rao@amd.com/

Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
---

---
Brett Creeley (4):
      pds_core: add support for quiet devcmd failures
      pds_core: add support for identity version 2
      pds_core: add PLDM firmware update support via devlink flash
      pds_core: add PLDM component info display

Nikhil P. Rao (2):
      pds_core: add host backed memory support for firmware
      pds_core: add debugfs support for host backed memory

 .../device_drivers/ethernet/amd/pds_core.rst       |  89 +++
 drivers/net/ethernet/amd/Kconfig                   |   1 +
 drivers/net/ethernet/amd/pds_core/core.c           | 173 +++++
 drivers/net/ethernet/amd/pds_core/core.h           |  54 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c        |  45 ++
 drivers/net/ethernet/amd/pds_core/dev.c            | 144 +++-
 drivers/net/ethernet/amd/pds_core/devlink.c        | 149 +++-
 drivers/net/ethernet/amd/pds_core/fw.c             | 796 ++++++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c           |   7 +
 include/linux/pds/pds_core_if.h                    | 469 ++++++++++++
 10 files changed, 1899 insertions(+), 28 deletions(-)
---
base-commit: 89d8006259b81dd25c962f6cc8d7ab268d6ea426
change-id: 20260721-upstream_v8-9329be5465a6

Best regards,
--  
Nikhil P. Rao <nikhil.rao@amd.com>

