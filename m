Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F74156FB
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927306; cv=fail; b=JCe9D9fwkbEANyJQ01hlkq64v4Qm0zjv6CZS9z4HGgezkEjVUkfjR+Srgr4pTD/omquB03kP7+v/jGEVfaLslarhAmJ2jdb6+I2bOjxVH0sEfD2QaUGEwIb1S0OwUyEBQk3bl+r0h5QlDmQvRh41uCmBaZXAtulA8ToSou3Xsbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927306; c=relaxed/simple;
	bh=K2AKGlys8QcTCo+25xFXv1sWBiQu0sSrZZNDhUPb3KE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 In-Reply-To:References:To:CC; b=uoLbsdFv7+12AN6R0yZP7XjKV0oTEIm2V25Ul6S0UL5nw0+XtPlZkPLPxeKtX7OdKSvV/4naaVfb9CZZ+1UZvoORQ2KnaVl2Km79VspwXZbxGbYjbAKkk1RF9JOl4O2QNwTFaN6rwRukWvsC18kG5cVWlpsGNMbwAx7p0Wrhv5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=REkrUmxo; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="REkrUmxo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGLrUrH4GUW9cZVTjX8DZDfIieAdIxZ9v81vqhz6m3L7qgRCq7j+aVriaoRMLzuYdhZRGtWLw1u+KRg08PJwEQx+lDXJphiVY1J4eOSMpUtjx+3Z/tsOIV0+pvsv8ltZksSf+kknqJEdWYv1QeCa9ZqeBXdg9mhF+C/Bu7h+zgSC+7Cj9QZAnLutoXOeAYDrQwwTEo/JX+StKlTUbz0glhAKfdjUfAp1UgLxQNiG2mf7hynB0reUVPJYAxcV+lcPTTkTEHoz8MTxViEnA47hP+8Ak6MNk4lDJFVCVPf2s51FTmCKSR5sI6wiOvbYKZC5LAFXxLyXeLZ1a2CU3emNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPtPhpGg5N0lNwU9umxNk1oA/PvjcZN/Z6V0RC/2mAY=;
 b=nuxenyacSdxIaSoWlqj9B7zr/0Kxx9K1BYPYOcESt7F9wFzMOGR6phKHeRBNLaBZZBN9R2y7I7QXOf5MJMRQXZ+EOLlqV3W1SAs3+nDycqtA7h/I98PFrzsOlJX2mNEX2Es+gkXXXljz2qI6y0Idnl22qa7H4rGm6G4i3f2KOxUBtoOAUrkOWLVjFG4rZNRn2cHFydRpjX43aeFDpuigU2k1Wiqz8CPNH2tiknhsDaMDNuEXmixuCKbi73TJLLIuPHNIOgVvPqQLEa8W6VTIpviVu3cNxSXXkJCaWnK7DonSQK3L+wm46BYyCZ9PwBKQdMmGiQrCK+12UN26x38pQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPtPhpGg5N0lNwU9umxNk1oA/PvjcZN/Z6V0RC/2mAY=;
 b=REkrUmxo8jS0cxiV3i5HS8owvDY6dHXpKdh7LCy9iKv2K+Wb6R37WEMgRml5Jjl2rEXCL9HCgq0c9H+2aO79ewUFhov014CQwBh4oJQPAW/6p7cBsjjMYLpF71SVqfPBTF7CJsApTs4zQ6PO43mBCZpsZ7kLHfUnEbXTXn8ykPw=
Received: from PH8PR20CA0014.namprd20.prod.outlook.com (2603:10b6:510:23c::24)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 21:08:11 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:510:23c:cafe::3e) by PH8PR20CA0014.outlook.office365.com
 (2603:10b6:510:23c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 21:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 21:08:10 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 16:07:58 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net-next v9 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
Date: Fri, 24 Jul 2026 21:07:21 +0000
Message-ID: <20260724-upstream_v8-v9-0-8425762b8b7f@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAnUY2oC/22NSw6DIBRFt2LeuDRI/eGo+2hMg/ioNAENoLEx7
 L1op03u5OT+dvDoNHposx0crtrrySbglwzkKOwLiR4SA6OsojXLyTL74FCY59oQfmO8x7KoSlF
 BaswOld7OtQdYDMTiFqD7OX7p3yjDMXZkR+3D5D7n8dqcjb8fSZTkKLho+loWSt2FGa5yMtDFG
 L/9HP3VwAAAAA==
X-Change-ID: 20260721-upstream_v8-9329be5465a6
In-Reply-To: <20260721-upstream_v8-v8-0-1ea9a8b7c4ff@amd.com>
References: <20260721-upstream_v8-v8-0-1ea9a8b7c4ff@amd.com>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Brett Creeley <brett.creeley@amd.com>,
	Eric Joyner <eric.joyner@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>, "Vamsi
 Atluri" <Vamsi.Atluri@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 265658bd-81e4-4685-4311-08dee9c7ab04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|13003099007|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	GZ5oA5eM7YqS06kTLNWiNxpmyQvKqCLGIpvB5XuNyqySKMtlfOGZ8umrTwQcxD/DfmN3rUIWwt4lbHX5IYyB795kU/WfYyGuYwgjFB2cAzNQrhyMkPgWJdEn8BoLSMsMoEXgaSoJg3L0x5XxmeTbTbgtUi5ZxzgQv9f++Yo34joenM2W9XVUclj3f1BsY4uvaLeUsfAYED3dQjCRUB+DqaoXGK7h8Dp/AV5u5DJ5v1VhThBQflakJRlOo1aDJJhsdLjdkFIosl7TBGZlNwcDNrw+Lj+k3Mo3VJ05AcNhzmb8KTzOQBo9nQw7xQPrpRG1roO3YVqqCN6Oag4PA0GTVV94EzJYfrfG/wRvTpFyHIzcKFrx1m1LPIRkuKLWI+qZoni65JpxrFwQugQkBunq/BOcD7hV61xoJrpN2H687TEoLzsidJTMY5Xoe07/YX0smVsRb8DBXAkST7y5qYk+bokk3QcTXPEjqaF4Balx+pfo81lMJ4pbFbW2OXKiWogmQQqRHqEk9cKKoJIIzVdkNSipSEYFSAl+2UPMBTYB7fz+s+oZEFw6Y3w6gvsy1vjdRq7b/uSytOxqARSXjUvzSRy1qQGLFIqHCsxjUI4ABOG0XcpdKSkQ1dCsPr7Uvz6GAgpO1cM3szNMkzof4fTwaA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mc+MAEBfmSqYSghhBXYYO6c7WlOh8YTz6vx2nx4fRe7WaB9b2DuRbcxxPjiqAuQdaEnj0l46bNcaiGhyXysmA4VKHyXjLFERGWSbk0uXR2BweUvB7aQUCemSZlTHaYrydSW8KGib7Ry6c4/I+2MN4JnbVQaZK8bcJnpCJeVtozeqj+4PXRFynvb7PxM4iTBRL9mXlHYuGptA6xrQG5S8WZ1rL4H7CtYVlz3/MaQK25eg2a/uLm/m/fzs1Op8Sd/irUrnVaRvhmkBP7JzVvwBiocA4UbtPfVanNnh+qceP2KZ1HxRegQuXHZGiMIqTI8RbzxmwKo9smwHiVJZsmKSGQ7qMNDEduCrhz2wYDyTHkTputWLCRm1X/mXikOaeKcHbmOMh7ZyCwGvTUy/Rpwb22tRwtimR2NcZJ4v/uw5an5MOmpoZrzIyXJcqEQRhyYy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:08:10.9421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 265658bd-81e4-4685-4311-08dee9c7ab04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

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
 drivers/net/ethernet/amd/pds_core/devlink.c        | 147 +++-
 drivers/net/ethernet/amd/pds_core/fw.c             | 789 ++++++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c           |   7 +
 include/linux/pds/pds_core_if.h                    | 469 ++++++++++++
 10 files changed, 1894 insertions(+), 24 deletions(-)
---
base-commit: 89d8006259b81dd25c962f6cc8d7ab268d6ea426
change-id: 20260721-upstream_v8-9329be5465a6

Best regards,
--  
Nikhil P. Rao <nikhil.rao@amd.com>

