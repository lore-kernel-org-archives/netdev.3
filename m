Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954A563FC2;
	Wed,  9 Sep 2026 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963683; cv=fail; b=AK5GtSqKlYk3McKnkTa1vqAUp7fWFYl7nEAbLKXDW9GEMVwxfWxVFOYj4BO415AJuLll2AYKN3RwiR0Kdu9Seg8S6nJd4+/thswHhxkuftY3eFZDjGtzAsLhg8+s6I07otyJBW5nRxze/q+5YXojTbT++UuOsC7hQY4kE5aoITQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963683; c=relaxed/simple;
	bh=q4vzJseAg5F3reggtCmQSa/YikPIPHSKwF0d1SsQu4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YoTiyiynyglqUIbchwLncmV2GPno4xOjkKt8SL1IAuk+8ZMYsOF93AfLDYpbC7A3IfeF/NDSyV9Astuq3fI1YkgRSChxnIuMpC64XnOQ/PnH6iqRCi29JQAhK1xCQlAR6g3CCDh9YqXwr+ZOcr77uMpfrJaslGQpNBSqRFmXGdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DodJCW45; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DodJCW45"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyqpzopZCZSxWjPG4kYji3FB6Qlnfak2OmjuERatM7qQnm7qIku1uTLIPxEo/vHF0IUu400qHc1TkxaZpTIpz7ykdfv/+WgExifHTKWWSQ7gJhKd2KED1MSYCnHJmP4VOwLfO712euZTp+l5XRckJ1sKoumvWhDekmTgg8xxSPB0S47kNzr5ekCboOdxF+Iia/nXu020wmDO5ak8/gyuYKLqUmE18thzym5r66SeIFaeKnZzjudGTMnf9+/hBOny2kdcn4vK2cNevkwN5uInL6vFDlvf6AgsblnGvZQwJvNyArt0oeacMe8qJuX4ghO/Fzkbk88KfAGwADVZxKrsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLPwJ8C3AInFbZJo2LhqllKVNro4BQtpfATiZq0pdjs=;
 b=Xit9Vj9q1FaOZhuuOnYc9v3L/Vxu0M44Omvfp4TXsgQYuJHvUeGgDvcU/LAXnGG+hMitvwY5tPLcSsqNvx6pjBUW3QdT/WgzdcAUu7VOUEj8y/mkscyvDvUPuZtwtjWMISc+df/50P3XTYnOYNOVnwh3sDUGTgFcs0Y6Lcg2P4i5TR/azo8WGUptKONgomDFCR8BXIwA3Lf8VEzw5ItNntMB8t8AO/CW6MCJMXkYPCbWPGZXuKmh8LSROQNZiOzTKJ5EqTyEmabG1z7vSg3Zj9e1CobtZJPqQDLETN7GgGz41sWhXLSnSnz5ye82XDqu8FTIoXreKwFsmMdUnjiWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLPwJ8C3AInFbZJo2LhqllKVNro4BQtpfATiZq0pdjs=;
 b=DodJCW45AdL0wUGXP/H/aM5qsf0e+FoExv+OaskHVXFr1UYHI4P/XE7xFGJTBNcnPvd+Fv0/CvMkBMVqm3qcvs1Ur3mnpEW8XKYZNyLKcXjDdr37E+AwgT1pX/fHYP49qe7IkA4E0uEY7loaCYYmClHosB8r9Q5mkuqC+cHj+fM=
Received: from PH7P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::26)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 14:21:14 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::a6) by PH7P220CA0039.outlook.office365.com
 (2603:10b6:510:32b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 14:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 14:21:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 09:21:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 09:20:59 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 09:20:57 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 0/4] net: macb: Add TSN MQPRIO and CBS traffic-class offload
Date: Wed, 9 Sep 2026 19:50:52 +0530
Message-ID: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d05eef-0f63-433e-99fa-08df0e7d9a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HSR3fOf3S2NPg4eS+iNJjCvLmaf7uTfD7laV11xx34dSPiULYrr1DGHWAyq8YB9x69BbBS/WstYmFc3V7VAFwXpMZySfBfcKpMnOzFt70YFeG7ZGNmReSMHiTl+2BbAwPJpqIofAL+1ioRrb1fnyOXGfKpyfxQGHMSS2C6JuTNFkbDM7LKGyp7nts3rME8/MQw0ox3Ui73jVIZcrxaaT06yD9wceDYQ1wN2vYg38aKbT2eH2/qvZb6Ik6ibNqXRuDDMEb85UdXUoLq3XhxdmG5RyIlVFlVVZIj5vlsWYmLtNbexyhV+E61VRwG3FtZGwwwoM01b9EJNSM4Hs2VSHzf+8giX6GzKvOoPN5eRk4VtAJI+9pO4JpDB++8inNPo79AMvcmR+1s++U+hN6nlFkz2GHcoIVPvpd+l6dUkhZ5J8uJ9iB3qDeGoP1TzqP45V5YBgpebBFbsfLPhksXiMI9sdvqz2SJg5p+v59HwpVJUJkYxcG+ISc1AnzGU3kkBMDzO3krSNwaxkmNS447rpB25EFl8CU2Tjm39YTTbUMv2VJzACqtzhGGso4hb6xm6tgKqmW+94hiUafBkAvcSvMsk967WGuw95ljEbb84AX0Z2N7EUiL0BJvb2OpPVmqOQe4YLUv9EMAFQPoRis/aKXZR8r/5JmK8n64J4kJVc2ZUYthyHdKUMnv35/KPO0VfgDYamjlYueJy77ujbxBo3XA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(10067099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mQFoAO75+A+1J7ymo3EJCXyFhFS3CVGWtoEd88d9te3+c17Vk1t5hMYHrkAFZkSEb0qmbrRh/uM1RUlFwOaOY7aUMEoNNkwPGV44r0PPDNSQQ8WfnSLeKNwSk3DUGAxw4cP3CslwS4piHZNTTapevHwaEv204OEHg/3dantFSfmP3q80dpAQ1pQTZ8aGCrhIt3g495a3h8jjyoOqMyVLpvboaY/6uYFt2wQZn++ChCiyOkhAXwZQABszq3++WpHKtdWyTpxcbNvGrcHhJssEsu0/SElzmxyVv/lualGHqshqj2zJp8k9ZqJw+0rwpR/BvNKSx3ShXwzEWjrnxGpnnhKlwuumgWgM4rE2wiv+62yIMnd6qPip56+JB4o/cCnS0Rv3vmwU3ERAvI2bdQppKydL2A5Wyjz38TyE1pvtWfF41WhdiQzvcK4uKL7XqOsq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:21:13.5584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d05eef-0f63-433e-99fa-08df0e7d9a88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112

This series adds TSN traffic-class hardware offload support to the
Cadence macb/GEM driver, building on the existing TAPRIO/Qbv
infrastructure.

GEM IP versions that implement Qbv (e.g. Versal GEM) also support
additional TSN clauses. The series first generalises the existing Qbv
capability flag into a traffic-class offload flag and centralises the
common ndo_setup_tc() preconditions, then adds two new offloads:

 - MQPRIO: traffic-class to hardware-queue mapping, delegating queue
   count and overlap validation to the mqprio core.

 - CBS (Credit-Based Shaper, IEEE 802.1Qav): per-queue idleslope
   programming on the two highest-priority queues, with the idleslope
   register value derived from the current link speed (full 32-bit
   range for high-speed GEM, port-rate factor for standard GEM).

Patches 1 and 2 are preparatory refactors with no functional change.
Patches 3 and 4 add the MQPRIO and CBS offloads respectively.

Changes in v2:
- CBS: macb_cbs_get_queue_params() now returns the idleslope register
  offset instead of a bool flag, and the idleslope is programmed via
  bp->macb_reg_writel(), dropping the per-queue if/else (patch 4).
- CBS: zero-initialize kset and expand the idleslope conversion
  comment (patch 4).
- Rebased on net-next, which renamed the struct net_device pointer to
  "netdev" (was "dev"/"ndev"); no functional change in patches 1-3.

v1: https://lore.kernel.org/netdev/20260807095012.640223-1-vineeth.karumanchi@amd.com/

Vineeth Karumanchi (4):
  net: macb: Rename MACB_CAPS_QBV to MACB_CAPS_TC
  net: macb: Move TC capability and PM checks to macb_setup_tc()
  net: macb: Add MQPRIO qdisc hardware offload support
  net: macb: Add TSN CBS TC offload support

 drivers/net/ethernet/cadence/macb.h      |  11 +-
 drivers/net/ethernet/cadence/macb_main.c | 204 +++++++++++++++++++++--
 2 files changed, 201 insertions(+), 14 deletions(-)


base-commit: 548b86839f7fb819a4d6c83b71c73ec378d24275
-- 
2.43.0

