Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013010.outbound.protection.outlook.com [40.93.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199C938E121;
	Fri, 17 Jul 2026 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279336; cv=fail; b=Kd79K3UaggNfwyUqLk2nEkAA7PuvTzifuhJgdI5iMGYnc9H4GULjyqRRve4ZX+Gx6xGTkZcpfGAmqZ3SNkvslJ6oaQvYpHfPRwqZsxkWNugVyqJYcufrtZCVBGvlMe6OEonhOaYECEvI32qcuZp1UdePpkgCZAHwKmku9kLdeA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279336; c=relaxed/simple;
	bh=ZHas0OoY4dm/NYPVT3Y3gt6JuM62uyKI3FITvmghF4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jmP6vKViQ2eRKBP/JkBv+4S+QT+WBYn8G6Np/uvbvoS18VIXEQESdumb8hY0CKkcLKYdjMR+HRbxrif2Q+tP4VKX69V6Ug5zk/+OG2NY21M4zQhyHxSHYF0arzOkd1OBXav8dtVtgzhAARDtKXVyFKdFkpSLBnicOAD8lWYp6Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MFcu/Mi3; arc=fail smtp.client-ip=40.93.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MFcu/Mi3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bze8U1yt7iAGjQ+v5R6pyOZFinHOtJXjRRnBSjbxqdbXfE5VrKlpRi+71cUYVHByESwGqGiqgzULgzhBBoJ9rDv5/VfbtCy93ULljBvdd+7Rv8+nQbjnT/f2PsfG2baSwmcf0wcjg2L5rlAANETFfdeyTwN+leYh3N+Mq9o9eg4i3bdUC4KnqIIX0Dwwk1m9pGedxLHnxGreVjlGR+5ewQJqrwXo94RE1seC+rhZjO8IaJWqhe3fhxz0EWRHfFhNjKjWI2jJEdbOqTxQ6n/sRo52h6QlbAIy/2P0+YHS3jfqzSqLsanLrC5txWMmMdBseKePiOg5H0pKZptdvx0dTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vOnjmIpXY6g+q0xMlO0w0hbxC0mC/nI0/5caiIUw44=;
 b=SHwuHGQVQqZKJPeU1Kha3+0ci5KbZENHaWwdpJWm9VJrn/MKly0zMGGI7K9Ch9UZmVfOhU1vThgfJN75ZEATTn1Y6giqKexUyNQSIdQfg7flDazPpu9BHKPkum6NtoV9rsePHxv0jpEgwDcTmJg9F6KnJnNEUW30bKXv2v4D8n7PHHJCR8e2LMBa1DVcYQ7c31JSObESGeoCn3uRkwpzaJldd3bpzlLcH9iW3lzp8jucY7HLB9eXG2gJ8ACEJ25v7RaBCzcfoUbHDDnnTzzx4OxlmigXWnwXlqg5HHfvKPLBgPZLeAoLoSP/pemuHbdm+BNLEJMwItvw1WyMcY8rgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vOnjmIpXY6g+q0xMlO0w0hbxC0mC/nI0/5caiIUw44=;
 b=MFcu/Mi3CyIZDfwsOgS+EBk+tyAjJ0gKN37opRFg488q7ThKDx9gPRBNbG5tWZ0e3mLqsd6doLBtzs4k6jU4Z5imT8vSgMooX0zOoO9KZJ2QNvrMe7dqUXrddIhfgi5MVlV4D2j9agWADBAvLeQwk1kHrCFEBDyNxXAffNK74NU=
Received: from PH7P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::30)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 09:08:46 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::af) by PH7P220CA0013.outlook.office365.com
 (2603:10b6:510:326::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 09:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 09:08:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 04:08:29 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 17 Jul 2026 04:08:25 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
CC: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Suraj Gupta
	<suraj.gupta2@amd.com>, Marek Vasut <marex@nabladev.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Alex Bereza <alex@bereza.email>, "Folker
 Schwesinger" <dev@folker-schwesinger.de>, <dmaengine@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH v5 0/4] dmaengine: xilinx_dma: MCDMA descriptor and metadata handling improvements
Date: Fri, 17 Jul 2026 14:38:20 +0530
Message-ID: <20260717090824.2364230-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: ab76cbd6-6678-4ddf-9d0b-08dee3e30123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|56012099006|10067099003|11063799006|13003099007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	39QDQiv0sXQMKsMLa6jDdX8fYPmyYwGLSzpWkgaN1vPF9ErVT3dgUpGobJb3CRj+iOIiGLLc1SAI+br0xzDoI6uxcmgnRozT1RBQC3G+n1sl4lXViW+VKFNcX1uUiZOr6aUK9x4wONDF/Vvi9j4dXYN4anlIwaaObCqRzxUXlhJpREMblN6s7Mqsz4Y0DYWhbQfRMrozOfqPAk3p7JVgdeVidl1x0G+EkerOs7/xNPgCuQwGGVvhQ2abcWiyg5QtHxe0sowHkwupyEKB1COmTOLpoYqOpuLReMR5PvVP3lusXE9HvBEsw+Qh4yxNgCsoLFU2RwWNDaPFQCRDNKh6eAit2kcPfLR1Q0e6GC7iIUOW1Bg9oNjVz6jGCm8Kb7QHhVZk3VPSzWoOSkF3cS2I5c1AVdxO/FobrNCw/idLm8jWQdriJ5vNlk2b3lh8FioCipW7QdKph+mF/TD2R3Qiir8flcXM0dosqih03b3sFTKaMdcpNjKSxb+73tLpHdWFem0/yMp5FC6DkysGJ+qHAQDGJH5UM9y2B47nvp3n1ofXpezM+anqcwRqwOvn4/ZwwRjZtKmTYWS7SKs3vEtIv6YrOQ2htwJsDh3p3bkDZCtgFHl4f1sBLvDiA9L+CGNC/p7raLJikWnrv/HOtaO9DPivNPikWoHK+lUavjmdgI2c+fsvUAztrzz960H8sqGFAqH5RJiVud7xBjRiqR8gUQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(13003099007)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SOyzsCZT4swuv1XeL9BDH+AmkTzubD4JWKQOw9nlwB4w7gWV0M+8w2iIn6QsPdVTaisehLXYA05E7Hx+QxfQKoyFCTgU+MWHSTQWrxLHTLik/Oq77vIcJ7CWTEucdp0rF2mu1Duc86cnFMtRN3mV3kDryxun+3AkGJ2zED+OA5Gz2zdDDWKxr+Sk4cfEQ14mNm9IPSSNhnC2wxwlY9ppxGWIV0ePpfg6GM/uQcKbnja4dthKG3aw3VAwza4xKzno7pNDSIWH4c5U1T5K9PLHPQQMgs9dh7Hyk4b2h38qRF4rxxDOH8qs5e1EDPoPrbvJu4lavAxesDcVHutq075Pte5r58z6/0XBGyaRK7KBYwiBdOeBerSuCzbJZwSYKwhlswh9AhQIFp+WJ9XnIOs0+Vllvdtwff0pffcrTgN40YuWv6kKLv9qOLXUY0JeKpCp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:08:44.8748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab76cbd6-6678-4ddf-9d0b-08dee3e30123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294

This series improves the Xilinx AXI DMA and MCDMA driver's descriptor
handling and metadata reporting. It fixes direction-specific descriptor
field usage, ensures completion is based on the hardware completion bit
(important with interrupt coalescing), and extends metadata handling to
expose status and sideband fields alongside APP fields.

The axienet driver is updated to derive RX frame length from the standard
dmaengine residue mechanism rather than descriptor APP fields, making it
work on designs where the AXI4-Stream status/control interface is not
present.

Changes in V5:
 - Patch 4: Take the metadata pointer from the SOP descriptor for TX and
   the EOF descriptor for RX, matching where the hardware reads and writes
   the fields (TX previously used the EOF descriptor). AXI DMA now exposes
   only the APP words (20 bytes) in both directions. AXI MCDMA exposes the
   control sideband, status and APP fields (28 bytes), with the sideband
   position differing between MM2S and S2MM. Reworked the kernel-doc index
   table and commit message accordingly.
 - Patches 1-3: No functional change.

Changes in V4:
 - Patch 1: Added Reviewed-by: Radhey Shyam Pandey.
 - Patch 2: Reworded commit message to reference the AXIDMA fix it mirrors;
   added Reviewed-by: Radhey Shyam Pandey.
 - Patch 3: Renamed subject to "...from residue in dmaengine path";
   condensed commit message; dropped Fixes tag.
 - Patch 4: Restructured get_metadata_ptr() so AXIDMA is the fall-through
   path (no WARN_ON_ONCE); rewrote the kernel-doc as an index table
   covering AXI DMA, MCDMA S2MM and MCDMA MM2S; condensed commit message.

Changes in V3:
 - Patch 1: Renamed subject, added static_assert for descriptor size,
   refactored residue calculation for clarity.
 - Patch 2: Added Fixes tag, expanded commit message explaining interrupt
   coalescing scenario, simplified completion check logic.
 - Patch 3: New patch - axienet now uses result->residue for RX length
   instead of APP metadata, removing dependency on status/control stream.
 - Patch 4: Complete rewrite - metadata pointer now starts at status field
   (index 0) exposing status/sideband to clients; uses EOF descriptor;
   removed 'chan' field from descriptor struct.
 - Dropped V2 patches 4/5 (dt-bindings) and 5/5 (xferred_bytes) as the
   approach changed to use standard residue mechanism.

Changes in V2:
 - Rebased on the AXI DMA binding YAML conversion.
 - Added xlnx,include-stscntrl-strm in the YAML binding.
 - Clarified cover letter to reflect metadata behavior with and without
   APP fields.
https://lore.kernel.org/all/20260309033444.3472359-1-abin.joseph@amd.com/

Srinivas Neeli (3):
  dmaengine: xilinx_dma: Fix MCDMA descriptor fields based on DMA
    direction
  dmaengine: xilinx_dma: Move descriptors to done list based on
    completion bit
  net: xilinx: axienet: Derive RX frame length from residue in dmaengine
    path

Suraj Gupta (1):
  dmaengine: xilinx_dma: Extend metadata handling for AXI DMA and MCDMA

 drivers/dma/xilinx/xilinx_dma.c               | 85 ++++++++++++++++---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 14 ++-
 2 files changed, 78 insertions(+), 21 deletions(-)

-- 
2.43.0
