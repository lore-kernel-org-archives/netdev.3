Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D9830C632
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785385556; cv=fail; b=Xw/TrgfV7SmMC8oXFZT/W37y/G53321ZaMN6NC9WzajxSpBPViQCEJgIm5H4s9g2ANuQUFT8lKxJN5mDkh0ZefpPaUvAomHuJ/LjAm+8hUBRIEmYqYWrGpSJOq8zO7wRkToTgtaDrf7UxkQ3T4oP/W71Fja+ssdFOod5V6LgqEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785385556; c=relaxed/simple;
	bh=tqTShs9J4ZU2uk+UpJ6Ii9vfKjlypcmrmOQZxeN4IUI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=UphzPeVKh1QtBAAU9KRUVcJpBmtiPT8T6lSgvGzl1Y/dBGN00dK6xLUYPFmeVaBYFAyvfLgcuo4JIvc7EH81rJ4J9Klw9UNMUbo0Hipfjpl6en3tsR0ZDJ8N5z68lvZylJctcy7XGWfIQSIMW3bk03O5q7C3kJWlwjjFXs/5CkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Xf35iDe; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Xf35iDe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lliz2RcZMkyc/ctwn30/sx1PIJmBflXhAZ2KUAw2IgtFb1nYalf68qRID3iNLLdSZQhs2bOGls1gTTp5mvcBqxeFhNnot5lfswYEGCtPJZ/VfmFRZVDwgFrBvaDvH9fqqBj38l6nIrvQz2pm6iBEBjeuguqj+xlCioJoS55HenqqRduAd6M5Hv5gLu1AlPT0Dn9G+9TrJwY0+BQ8FAboaGsDOpZ71iO+MivBHdEPrjQw79IYMuQtcX3GPL0owMHlzhuAoZiec9wZle7Y7vM9xKk7KglG08rFPq2EiGcWtcuJJC+sOdq5MgxdE21rd27t5QNasryKxrvg9wbtOP8VMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC2IjGvZWVQy+ubVjpHawYrFYT4o5bqVVAjJYXKid4w=;
 b=Bu5OMByAvw6UVvZnLgyKKXw3Y6VKRdi8ARIT19tix3Cgj1eoOhhi1eUm+WKP1qsrSS+EUX3bO+JImT9DZu3apTmubfYIUd4GbYeg935QAjDso7fC8u8AlCoDT9YGn9Uq2cPGeFAI6TVX9teBdnSmXvU0zJ3JEDeaP7XXC5IIXnJdxgBpH8dDZnvcYouTYttN8xf05Pm+uBZ/W1ifot0g1L1JgQL7jSYlP7Kz4dxE+1KsCfVLsqSCkJ3tUrw/S8XjAJXm9HTrFK4hUmCkPPNQn+Y5tv/c2mE9qw8duiHaps2FOS6jJOU1DKyPApb+tkogP/6GkEwPyjI+5HK9vUrrJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC2IjGvZWVQy+ubVjpHawYrFYT4o5bqVVAjJYXKid4w=;
 b=5Xf35iDeQJ9FI8reyEdPepQ8CHX6OfGNNb3pZUGmUnyREVGQ40tODmg7VnuIyD0hMCpNaWAs45A0orbREiwCbRiIHd48M+I7Tpb9JFZoyV9BMjclhmf4JiZBq2+DGI2aAw9kiSu+bHZziOPYjWrABMSffkmiO58kKGk9mQLylME=
Received: from SJ0PR13CA0071.namprd13.prod.outlook.com (2603:10b6:a03:2c4::16)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 04:25:49 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::45) by SJ0PR13CA0071.outlook.office365.com
 (2603:10b6:a03:2c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8 via Frontend Transport; Thu, 30
 Jul 2026 04:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 04:25:48 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 23:25:47 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net-next v12 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
Date: Thu, 30 Jul 2026 04:25:17 +0000
Message-ID: <20260730-upstream_v8-v12-0-136cd174ee85@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3SamoC/23NyWrDMBAG4FcJOldFo2jNKe8RQpCscaOCFyTFJ
 AS/exX3UMcU5jLL98+TZEwRMznsniThFHMc+toA/9iR5ur6L6Qx1AHhjCumOdDbmEtC110mQ+2
 eW49SKOkUqWJM2Mb7EnciPRba472Q8+8m3/w3NuUV9rq9xlyG9Fg+T2YR//6oxSigs8543Yi2P
 boufDZDt+ROdi3Fu7RVGsGlVtxXvJHA1tS8U2DVChVc64MWUsPGwtrajYVqUXgdpPfcwv7PzvP
 8A2om5cpzAQAA
X-Change-ID: 20260721-upstream_v8-9329be5465a6
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4fc33a-3699-494d-d980-08deedf2a20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|11063799006|5023799004|56012099006|3023799007|13003099007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	FKRV98tzb0LKflxm7KCPaK19ukTIztdzza5Myx+GcrtATkKlgnEMEb3fETqSmS0qKiG06g5EMJ+moXd/4vhXb/73bRViuT38KoVucYwT0aUSWA+/pWZx1BWtDAM+MPGD+Ve7WFR520GJwKkkBC34jx5crpRACBF2e95srvHtCTMgOz6tYCwtl9HC/GOovJ9coGL1kk6x3NN7SvI+jhdEQYcb0hLSNjw9zIr38rPmIuB8EB2KJwYDSX/rM4q4BXm3W3fYUYp7g3EXRrS8QCns88R8XQhnDTAaDPW5txB9VvK1UYMFn/c57YHS+OlWxfwXPOH+aq6srp6AlqRkcoKZ/KiHYi/yWkdOxjChE5I3IQS+p1tUJHOWE58cxkp4UhMbg5DBCnOeHHpKO7UQaHSasNjGWW+MO4XEpgMJBu5vLtmfmylmPHA5yu2DaJ7InBjCCK/QQKsdcTp4ArmsdPzIbJmjf1/xvwkV468xFKTHQS8Ww4CjDHInUVpQqz/T2AyZ6Rqx26tv2zwB33nKEhnFxbW2b9NpBdKbEqQ3kCAq5Ev89oJrVSTQ3Ea7d8LgHHukXIWAdCBwalCGR92g0WIxbp6CQtkLBTOdaxI2QNY2sCh0Ex+JzLsnFa0q+Lrj7i7E551DiwkBEZ/wjCeipQ7vdxYsrygzauO6Tcd9M627taU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(5023799004)(56012099006)(3023799007)(13003099007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dio92EWgF9jZOFCz9vPqQ78GqbcD8hqEOhLeNTsV1+7uM69BuowroKF9U2UaheZPjGwDWVIwDjajRTY1SkE4XdCAWxGyIDNOzwTrKb35VQilEWmUnxsor6UxN0LBN7OCRAY/kNTFSq4yzqMjdKzBCHFTHCaiBdxeKz7tLP0UGZzbXd+WuA/j5lHbknL7lv2INWPFYbZOxJFDZKvQnU1Burr1Ev+MGlV6DBVparGRgQyx+0ZqlZ5EO6JYXFAgmygwiTXDUlYQ4HM87JD8BjHBfoD3oGvgbwCu26Cx4bps0I8NeRAvBMD0S7KqIKExXUvZahOUydbfUGwJ+QwmajQfgeaTw6gZy6JUswWMzKgBfIEgsxE85Rgr+649p4moVpd7of9nwAuUtnOTcqnt31l9+b3QGmIr2qKt66QqRWQco0qbikgFtamky1YkAshzeXlr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:25:48.8340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4fc33a-3699-494d-d980-08deedf2a20a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806

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

Changes since v11:
- Patch 3 (PLDM firmware update): move the pdsc_fw_components_invalidate()
  prototype from patch 4 (component info) into this patch, which is where
  the function is defined and first called. This fixes a per-commit
  -Wmissing-prototypes warning under clang W=1 flagged by the netdev CI.
  No functional change.
- Link to v11: https://patch.msgid.link/20260729-upstream_v8-v11-0-e4b7d5bb2913@amd.com

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
Changes in v12:
- Patch 3 (PLDM firmware update): move the pdsc_fw_components_invalidate()
  prototype from patch 4 into patch 3 where the function is defined and
  first called, fixing a per-commit -Wmissing-prototypes warning under
  clang W=1. No functional change.
- Link to v11: https://patch.msgid.link/20260729-upstream_v8-v11-0-e4b7d5bb2913@amd.com

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

