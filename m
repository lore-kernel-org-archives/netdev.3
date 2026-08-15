Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEAD2DC357
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786752053; cv=fail; b=us3ix0KQlxBmHCUBvuLWcDF590EllGCoQ2U6Sta62TZA9qwqht4EVyIhJT1YtFUPsGqJLs8MS6gSkhGzQdYicDZb64MB4cuuAgD6FWMMqVCAAVwXQA7viuD8U5yXVDRJhFbwxcAaFabFEfggYF3NR0KdSJ4NOeJhzM9khABVQzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786752053; c=relaxed/simple;
	bh=rON7cOwg9VtpGOt/A3hjbb1fu1Pmt3oL+8QEbq3jCtE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=pYNJUKbaZqKWoMizKSUifdC1PZC5RoZ332uopEvotdO9dKsgk3x1xjE12JhOQLG9r5da5KKCJxgZqHRnn/2T9mz+t3hl1tSydUr8fLw2VVOhs8cE5YuH1Fh4kkZ1oRjCw9XWDhVaMChqcRyyDedajJr+BdG2fyKKuf7pi6j0AGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dy9dxx0U; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dy9dxx0U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE+IzjDTFF/Cp+2zSpXwKUR4zBjgAHjZQwJF5IC/d7Fa17rA0YsxVLOJlR9ZmSXQpT81wIVl5TfK142RnUW634rnaexHKiJantHQ2/tDbgCmQZnPO2A4FHDS9RvQ+p/hqde1aUVa/NPbLK79HiKWxIAVDGqLexVU4AfHJebo6A0J43zsqY3bau+tUNjvnpJhQuqBE+mv94j4f/3hiLmG2NpUKLvQIFQMq0R1i9RzRXw82PVqETowM66quNFair0JC18uG5fUtigWkElAL3yLt2aLgeGgTCyPNDxawbKYYTZysgmnfv5A8B/QAf2YxaoLFOt9ufXjjj4d5j0xW9UGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwngriPRdL0DIfZsSeZ2Tgeu7Cb5YthWzNNeDneyeb4=;
 b=peYZikMxit6gLQw06du6NqhTyO2xzV1VXt2usVKj8SraPE7uSXns8eeBH9ezadWiQWuYco+kWoHaTDAEyAA+/3+QtPlUDU0rHkJyYWYGkk6PW45/QUhVYRQ1Gc2OSTAM/DNYQGZzOe2fsGKCpkDY4LJtAU+mQj4Y4d1G3YNNcXHNYJNEqr1J6+LjbHCGxJaHmVd+v0LrLBl5MzZ5Lydrtn7iLsyr6b7JFd1Ua7NkuPlhJJkJTTxWL475rl2fIkRBbp5El2d/74xVSWFcrN+axB6ONuXwg21VA/wiiOueG5SmhcgCO4B2XJWKwNmdx44plQfMVlrboZPBXQ7qzJ9WgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwngriPRdL0DIfZsSeZ2Tgeu7Cb5YthWzNNeDneyeb4=;
 b=Dy9dxx0Urf8HM7vad01PQ04v4QDRboSFq9NtFehH26fQEVLFJnN6+u0xNrHVObudJIr4XoixcrMtj/IdcoJhc1kLOFEoLvSi8ts0oUwp7m+5WZDx0Jib3BAGGCCY+u+9zgFfxylnywV6CuIPNZI6pGgHabHYQ+8p+/yzacRJuO8=
Received: from BL1PR13CA0114.namprd13.prod.outlook.com (2603:10b6:208:2b9::29)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sat, 15 Aug
 2026 00:00:44 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:2b9:cafe::54) by BL1PR13CA0114.outlook.office365.com
 (2603:10b6:208:2b9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Sat, 15
 Aug 2026 00:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Sat, 15 Aug 2026 00:00:43 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 19:00:42 -0500
From: Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net 0/3] ionic: fix port_info lifetime problems around
 device reset
Date: Fri, 14 Aug 2026 17:00:19 -0700
Message-ID: <20260814-ionic-port-info-lifetime-v1-0-f73b1a06c5f6@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABOsf2oC/x2MSwqEMBAFryK9tsHEwd9VxIUTO/pAE0mCCOLdJ
 8yyKKoeihIgkYbioSAXIrzLoMqCzDa7VRhLZtKVbqpOfTh7GD59SAxnPe+wknAI16qp27Y3X91
 3lPMziMX9X4/kJNH0vj/59JKkbwAAAA==
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>, Eric Joyner
	<eric.joyner@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: f94c80be-8f87-4b82-6c48-08defa604058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	qhMZjlyRFLdScF7p9jFEQ2dvUM4ba9gaHVZFW2ctVLhsrhfBth1QqdIAVSLAcbYSvt6jGVKmsfQe74esYo4DKE2l0ImE9tQdP14XqwkNd5c9beMw2b8uG/9EIlTLCdwJ/cQnJ3T2NuTnjMTmkkJjNg7E2myXjWg+2pYFrjiqHtxz9MJl3A6tRX+pnxEGBpw3tDAyy/YUY1P9o27FzuXIFfiRhkfJulCO6Wwf0fWAcbiy7ecjLOjBSmA+TX5csJURaHx/SepCKscvN0PauoCJO38mqhI/AeHh0BAOI+MBnF475mOLYxs+FbGGJtH8ly5WQLf4jcqzOnDU+8bB+mMs1iu0s4TaKhielW6m56maDOPZHZH/cBWfdpkjGD20MXEz1wLFHV+7qNTVoESYB4qLERiMwJm8yVL2c0ZOIBLu1AUamUH5RRV6fEsIEZJWQkVKeemWoIMs9moXKM62IILBJwGqqDP60jRu+o65JV5q7AJfVynYaWJ/X6Zt9VmUQT/n1S1Oc22phyVrbQQJpAc5BkDL/l5kms/1e6GRxfzuaGRXw33ZdcGszYK6qWwxE5bhH8DipN1pFpTubqyr0NL9lIbWsmLairdYrUZNKqfxWWgUxTlvbI3ofsvym0iokUHp
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A6OOWKBWlmAJU4lsrODwa0SeMA2LJu4dKHxyB1JW31GMBDSLsThUhIxQi7/AUn8eAuxZWXygRqJqXg856j2NIMgLUnpbjkOTOx+kuDIPmKCRxHaCPVLw03NV4fzonM+w9PliZBHskE/aLgDVLTD/0CLyV7U6wAeILvX/3lE2mL12UIzCtHs7skd+wYAXLEzQiLyMk+zawRotgpoJmtkzQjpOCwRlICKeeEY2lDkNapbm6mM9pMpbXfllU2BkWqJ2WYG+zKZqXLQkrfKU3DuP2VHP2wJ4FbY0IBQswquyv9Lk0dN6Irc4ojIJgldprtj4QV21bR+/zFUw80wcad/TUMSxfGSazC6J7sfUzVZpqMq3wMkQA3uCkRqUAd3rk+eO8XphodFCNeacyFrjn60nUHEW/rMTXA56jHMmIF92Yd1fVlYuPTAQIm71kj4yhZ3Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2026 00:00:43.6111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f94c80be-8f87-4b82-6c48-08defa604058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307

The ionic port_info DMA buffer is read by most of the driver's ethtool
ops, and is freed and reallocated by the firmware recovery and PCI reset
paths. Those paths hold no lock that the ethtool ops honor - the
driver takes no rtnl anywhere - so ethtool can dereference a pointer
that has just been set to NULL, or read out of a buffer that has just
been freed.

Patch 1 adds the missing NULL checks to the six ethtool ops that lacked
them; ionic_get_link_ext_stats() and ionic_get_link_ksettings() already
had them. It fixes the oops reachable today and does not depend on the
other two, so it stands on its own if the approach in patch 2 needs
more discussion.

Patch 2 detaches the netdev in ionic_reset_prepare(). The ethtool core
only stays out of a driver when netif_device_present() is false, and the
firmware recovery path already relies on that; the PCI reset path never
did. This is what actually closes the window rather than papering over
it.

Patch 3 fixes an unrelated leak of the same buffer that turned up while
auditing the free paths: probe failures after the port has been set up
unwind through a label that never calls ionic_port_reset().

The port_info lifetime problems were pointed out by the netdev AI review
bot on an unrelated ionic ethtool patch:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731214021.15279-1-eric.joyner@amd.com

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
Eric Joyner (3):
      ionic: check for a NULL port_info in the remaining ethtool ops
      ionic: detach the netdev in the PCI reset handler
      ionic: free port_info when probe fails after the port is set up

 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |  2 ++
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    | 30 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)
---
base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
change-id: 20260814-ionic-port-info-lifetime-3163779cb298

Best regards,
-- 
Eric Joyner <eric.joyner@amd.com>

