Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251F3A75BD
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 04:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237763; cv=fail; b=hqFZbg7fUpQ5PfuXibwoqTTskQNzARk4uTqhbNkHVPKk16wqp/ihs1GJaeC5Ed3kFv9i697/MPi0jkJQPk6YA+AAE3cvbplfD31Ep1X3dNyjsIActxNxZ1HASoKlIS21mmTheZWlV4Ss9okutHpAMbXXWG892m1hSUfjJg54nps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237763; c=relaxed/simple;
	bh=HPCo0Fraa/ix1UieNT0F7xyjPSz/kCUtpk61S60TEvQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AMcN6enEdxePxuTQ47sNBQGUlbkR4OQNOHh+ANVMX4AIEIPKEZuppVU+WAUo7JPgorAZInUGM+8RHC+UVv02vVarnYl8s0lsxjU9AmWe844ds4eCR48IBn883VgNL7ABPYQlXJ2u3nqESkW8/pEFMryRH4CeRGNl/qzR8QDHa4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EN/IZ2qY; arc=fail smtp.client-ip=40.107.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EN/IZ2qY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xH0xpPjZshrvkKV6HTfRguTHH5FHOyVxi3keXQTjzwd9+iUKge/EKRDD7xJjK2x/h/UkTkKxZ/lubpklugKNJ4x4ayKxk7IkwebhRn4ChqH1OxB0Q77KzkALUaWUhu5C5yLnVH3GI96C86Egmy2JR40VCFCiR4C6O9532K7v7mso3OAs69ar2Rsu2CSy8wrc+e125IAIGLBzkSbnHTyhGeeNLN/xUeE8RYFHlRSmRJXNh5Y0DW8jmJpnCvGzH4A+RfJonXtn1nc2EEjdg1wc2zBCtSoNf9SI5uPCgrmB5oA8EAV7Xl8V2HRqorZrtJAUubW2un77hCJk19nzSlkLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqzXPv/ZJ4N7hjThtsY7Rj5FrkzyDfCfevW5kURlmEs=;
 b=axJLDOEKvL87PMR7WFMBOfGkIepkVw0KKDBYT6v+xpJolAadXUiqeMINcrqDJY42JPDRrMvET/TdtfdMFNEi7Bar4VYaFL+vE583ZJam+T7/PTHk9TySCB2IdOknmZvCnUzYR18FZtxWneNuZKg7phyuG31yFsJQoZR2npjXy3uxFa6lxCsoTIb2gIUuBSpURNlC26KfaNk2sUaTS5DBRAaWBREcaoAJZMmsMtHZ91zxzIzZz3hjIyplzlGNAU9zg8ZT2tscPk3wP+eMw9047OBOyia7E0ZUmOMNfxk15SYFylYtx+NB0gYcDnf5ZTHKne06CBrtJTMS1yxMYdjWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqzXPv/ZJ4N7hjThtsY7Rj5FrkzyDfCfevW5kURlmEs=;
 b=EN/IZ2qYXnPbGN1ToaUATRXVRC4mjpIeKKIYuHfYj6tUoMBJh0dW5KPkI8loF8/8f9/Rs+2K1yKSzb2Qzo0yt+hpE85WrDnutaAFqyiT42EDz0nY0tme7oBNpTlpyxovG0DMu3Y1cuX+1g+MfCGT9tdZdGuqn7FiZueUFyYpGSM=
Received: from SJ0PR13CA0021.namprd13.prod.outlook.com (2603:10b6:a03:2c0::26)
 by DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 04:42:33 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::27) by SJ0PR13CA0021.outlook.office365.com
 (2603:10b6:a03:2c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 04:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 04:42:33 +0000
Received: from lab223.rund-run.pensando.io (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 23:42:31 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <brett.creeley@amd.com>,
	<eric.joyner@amd.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v3 0/3] pds_core: fixes for the PCI reset path
Date: Tue, 1 Sep 2026 04:42:16 +0000
Message-ID: <20260901044219.1361466-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|DS4PR12MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f30dae3-afcd-4483-7a4e-08df07e37066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|18002099003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	F+1zbgrnaS6kzkR5+6QCVwVV0ziABrouPWXpEe85ZChctrJN43in3kZbItlNjdRNgFGDeq5lYowOHOK0W9G/nY8HO70fBvK4uWPA4Ovjaq0E3XY3NcBDC0QrZBSRmGMZkLDJczx/BNWkEHXwVHtd6TFsUTpvW/pdQvYFPA7d/gX8pz/RHR3gutZYojoP03cl0FeoF3ThqyGM7XrrOimXWYSOQbFU6ZILofjXnINLMDJxf9r8gMPVpoKjnJkRdIv6jgjdp4wh5E12/pTWcZoLAJkaleCXPw2dYBRD3pCqrHNOD7blEwVx7sZLB12p0ktk1W5Dn9AlV4aOP3PC0NRgJtkmyk6V0DKEMoYsUimkMhHflYY1CI8PQr4tHFuCu1PmnHoihPsTz/IcFJhRONxeVCisxxZNdkoGOv1et7jPAggONlDZs1STK/7r23VDKs87qOA5N89rzmsxRS8Abx+/FgcAD/PMOeV8GN/IlZgeRh+npD8fzkMp2pbsFQehnbd+c4CnKJz5tbHvOP7M+HY78bsWRXrB9rvrEoUql9s+iKrbh17M8Havilwi422QuSOCWAa4hnzIr6N50zaX0MgFXhB6aQWWeooKPRLygc2t5YWs7RnhDjBpWzv5CmBEZPc0xb8UZa3xbcL5cTBxPLg9zeuKgF9uHg+8gn3lNBxUjG2pqrIq7yrTq75B1IA9Ze/wTsHEGMb0yoTVgW9MVsfcuQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(18002099003)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GeTmrbs3//Lt9v9hG4u/LVN7+cXF7GqyaPERkvTxoKUUUfs2Zgnm1zVCDsHW37iHYbuFAAG1gUF+NiZjcs33g7wvbr682HLFwM7X8XQM+drXrNoyMRIRzGgcu98VpRcJ+BPpQgmYklHtrGJ6BiSbt7RoYyi+7dr1o+tLvNB0btxjgnydO4rEnvv3yoK6gk4Il16AcoYJmp0SAY8A4puPH0SMVB/Jinn7qgATnRE7dZHkMjQvoKMbkQkTOJACIPwl2pNnptfCUwC/5RvLRaE3mNrJ02iOqBuQs1RSIZHbHeTSlu/Oz/bwOkzxjP7QbYXP2iQrIgtx+ss1RP2vWN+a43nrzaq+1HzutNZ6oy82sEeCBk/CjzX69qzXQHPN3HTQUxfShoXSvdVYaR+XCZpOJ4xgeCyqkAtGL/SAU2DQWs/Y9zClAKE6YvpiJvo1TKzP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 04:42:33.3543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f30dae3-afcd-4483-7a4e-08df07e37066
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636

The v2 review raised several issues beyond the cmd_regs race, so v3 is a
series rather than a single patch.

Patch 1 is the v2 patch with the pdsc_core_init() and
pdsc_identify_ver() checks removed. Those checks are dead code. commit
cd09971dcc1c ("pds_core: keep the health thread stopped during reset")
disables health_work across the reset, so the health thread can no
longer reach pdsc_setup() with the BARs unmapped. The only other callers
are probe and pdsc_reset_done(), and both map the BARs earlier in the
same call, so cmd_regs cannot be NULL by the time they get there.

The pdsc_core_init() check is also worse than what it replaces. Its
bail-out jumps to err_out_uninit, which ends up in pdsc_intr_free() and
writes to pdsc->intr_ctrl, also NULL at that point.

On v2 I said I would convert pdsc_identify() and pdsc_core_init() to
pdsc_devcmd_with_data() once the PLDM series landed. Dropping that: the
helper has no read-back path and both callers need one, and giving them
an -ENXIO return means hardening pdsc_intr_free() against a NULL
intr_ctrl on the err_out_uninit path. That is a lot of churn to
deduplicate two call sites.

Patch 2 is the VF pci_release_regions() fix, older than the cmd_regs
race, so it carries its own Fixes tag.

Patch 3 is the identity_show() NULL deref.

The v2 changelog claim that pdsc_unmap_bars() clears db_pages was wrong.
It clears info_regs, cmd_regs, intr_status and intr_ctrl; db_pages is
never mapped.

v2: https://lore.kernel.org/netdev/20260804235946.177762-1-nikhil.rao@amd.com/
v1: https://lore.kernel.org/netdev/20260729055258.1416225-1-nikhil.rao@amd.com/

Nikhil P. Rao (3):
  pds_core: fix cmd_regs access racing BAR unmap on reset
  pds_core: don't release PCI regions for VFs on reset
  pds_core: check info_regs in the identity debugfs reader

 drivers/net/ethernet/amd/pds_core/debugfs.c |  5 +++--
 drivers/net/ethernet/amd/pds_core/fw.c      | 10 +++++++++-
 drivers/net/ethernet/amd/pds_core/main.c    | 10 ++++++++--
 3 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.43.0

