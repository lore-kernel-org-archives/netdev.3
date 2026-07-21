Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE9417D67
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661224; cv=fail; b=YodLuBqWKEq9c13pcuqQaB/NGCeCm+qT2tprc45jAtOrvagjMC90k/8iSWuEHGeLb6kH4+J14iMSbYynu9Vl2x/k/AOJkkx28hXLRQ6TxJdCAU4bLndUU3DrVi0+oFXv8vBiJLjBl7CypDZEwaWhNBz+wYUgpqVAqZW4zjpUIOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661224; c=relaxed/simple;
	bh=/CIpvVCz77UIn1zU8T1yDsBqwTzxcAyeDso8+whY23s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=GGjeIEkI9tPlnvjgyob1l/eV4fmtZ3u24c1zJ+UXHO+3T/giKBuZm0DgZgaIXzATjJAmJCdrcjqod66xjd7wxYt+Hd6hvxBbehsm2VimxMSnYqs7rIsPccAOk22jrc7ofeeUwVu3LiHUCUZgz6D+PlythtJ5aaFmkW7oInJzMLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nPXIpSDz; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nPXIpSDz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNn4whPgc0GVy9Hwan94mPWQY7e3+ScbqR0Bop/JM6U2HYNXVXFfmBysAQPgPy0AZj6na/drGSdwyGvW2TbBfiTEwIPg4ZqYpUUV6qdKGh5ihcNBMJJaVY5xXYuanuDt720vD3KxjKlrUbAJYipxEOyWDWuBRrycWzXhaJ6ULgAk1beAojuK+DnxJbrbw74fXsogcqnNAsBLMpvla2jYagWEskSEi865GH/cMedODpKF9eAaAv7E1G3FoJ2v8orABwCONHRFBTLUlE3R66JrjTYXWux1oM4hm/CfqtYz2b1ii8j5xkOMr+U6PdZC8g5ep6pWwaPOGHOzKmHHVcCkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Y62WEkhSiYHNr3otOl6X3z/xWYcMwpa5sXya2V1skc=;
 b=KVZ6D2Hn3ro/wGzRJp00GptWxXa/MFz671Yfs76MWjbB45gBPeTeZTodhv5ObxC1RzFwe9cbO/mrD0rZY4LYSb9o1eMcDUDaiLt0tLxNJIUWy4d9EnSoMaXQ36Sd3y76Tn9VVrBH/bIlAyrmAo5sNxReW/rWSr+obqcGxDiMqRvhn5UTThExVWQO3Pbpz3/HS9sFPcGgsdPTYuncEC0tevt65Nv3Q8+7r59j3pswTjENFCJbqp0Tanp3xL+RIQtqsDhsV2CsfEcE4SjBMtgIrvD8Y3WXGGJKSgJF5NZnIbAOT7V53GSKGZDnHEwFg06HoLx7u9myYICUpUCEZs1l2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y62WEkhSiYHNr3otOl6X3z/xWYcMwpa5sXya2V1skc=;
 b=nPXIpSDzq8Q/GvUjBq0sQrnt5vHRhMZsdeb7+6wkj+0eaZjPK2sQNiSJkFJuRMA5xALn0pwZ9lwVzvQqfVT2k1sejaZcr8niTMiyd9nn5lgS3rGtfSrLVnXKzCnukJVSllmd0ww+a+Ti4juZSPnviL1jCKpNdOdaTgZpQEIK/r0=
Received: from DM6PR21CA0009.namprd21.prod.outlook.com (2603:10b6:5:174::19)
 by SAWPR12MB999163.namprd12.prod.outlook.com (2603:10b6:806:4e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 19:13:34 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com (2603:10b6:5:174::4)
 by DM6PR21CA0009.outlook.office365.com (2603:10b6:5:174::19) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.4
 via Frontend Transport; Tue, 21 Jul 2026 19:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 19:13:34 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 14:13:33 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net-next v8 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
Date: Tue, 21 Jul 2026 19:13:08 +0000
Message-ID: <20260721-upstream_v8-v8-0-1ea9a8b7c4ff@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMTEX2oC/yWM0QqCQBQFf0XOcwu26ab9SkSsdqobtMneVQTx3
 93qcRhmFiijUHEqFkROovIJGZpdgf7pw4NGbplhS+vKo92bcdAU6d/XqTHtwbYd68rV3iEXQ+R
 d5t/tjMBkAueEy9/o2L3Yp+8M67oBNY1XqnkAAAA=
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SAWPR12MB999163:EE_
X-MS-Office365-Filtering-Correlation-Id: e99bf6b2-d169-4c4c-c92a-08dee75c290a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|11063799006|56012099006|10067099003|6133799003|3023799007|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	qzoylLjbU0ywTZY5xYQH4IeSjUjkR3zrCvszstHUch6y425MYtVgwCohNDGre4NCHpL11wDN2eiI3+/HP9lDEn4RqKuPAXyupKsA4pYLdpmHwjkmhTyi77F/N592RN0fsd23zlPngWHdnnia6X+jQv2N0U81KHPnow9/6Ggy2PGjip6L00pmMCtEEkuLdLqCyS2iWVTFSMsROoapdgS7c6n8/dUwB1978ESG95p0qxupFtjvPKyikdZGq/rj2jAgh+IEGp9IlO6JPxuJTyzpehJtQsJLe3tWVWueK3BMue9hJsaqMrwrZf2dOmSxryJHwfrjlM1XzK61HLPL2o5J39gdzvUfP8kA5etdv/H3jiXBN59Q8TBl8VOiK9D0r+OTAbXS525dtaZtkr5va5LuwbwYPhYNSUw+zOIm4ne8w8l8D5ID2hztgmR5bn0i5SC53w/CvNyGIlivZ/m45rfus6Z+nrHLg04uAAxCQWSD1g6otjh50zcXv5qfhPjYzx/HRnEThkV7SK0Z+st386DClQ+nkJXj/BiXT0gY+wl8gwxvIEnpKn6Dndecvk2dvrY+bAtIeEBTTYAPCHr4BHspQu2fY5CnYnXYWMcZNMfUN+fIG6KRxf0bN1ncS/Jqa9nBhLSWOVLwb8Qv+y9JYEuU0YTrOaz9AIHsaigxiH3ZSbBzmh3dpJKOnzULJ6GXeeRk+T06YjEW43OBMYg4tXHX7w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sYszRAlGa0MmedPAMhK+SmYiI+h/ruFMjWLSWHtzFsLPjTEydUgtCGkPS+fDOelkuixgc4YERzgXwK4lakpFP4Y1aztPWN0elpZBSXGmijEQzmfT0BRHVWOc8mbzKwXJ19Xsi2sefBKXDxMAqyhIoFHhJYYBuSMYa8RKzETUo1CFoVZyAWxrnUsMNlnQ0XVMyPkwpVE42Pto3xFBxdalQBqvfbgEYlqiFryiz4YbGzOP9uUqFwn3JJXgufR3iCFm8XRqvUcydlnBmJpSZ9uBKdG92lJsnanH17nfIBXfSpPe+mlKGGdub7qDruUz0CEIMPgfh9C6aU3oYyCqHX5zTwwMGrlv2bt/UvZPxAcvzlDuD0p/85isKXqH6Zxahk+bM4ZyGmSHLtNw3yEG8oPWKQxjwH/5GybtVFz1g98v+1v5ThVPF4ZXGC1Im1fdKkd1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:13:34.3959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e99bf6b2-d169-4c4c-c92a-08dee75c290a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999163

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

Link to v6: https://lore.kernel.org/netdev/20260623-upstream_v6-v6-0-3bb64e0dc4f3@amd.com/

Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
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
 drivers/net/ethernet/amd/pds_core/main.c           |   9 +-
 include/linux/pds/pds_core_if.h                    | 469 ++++++++++++
 10 files changed, 1895 insertions(+), 25 deletions(-)
---
base-commit: 805185b7c7a1069e407b6f7b3bc98e44d415f484
change-id: 20260721-upstream_v8-9329be5465a6

Best regards,
--  
Nikhil P. Rao <nikhil.rao@amd.com>

