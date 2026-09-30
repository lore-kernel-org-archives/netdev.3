Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C53F12E1;
	Wed, 30 Sep 2026 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773107; cv=fail; b=XA0hmiteWWt/jbv4qOaa8wDoETF+q81UGWDi9NRXlVp6OAQxPBla7sRI5UPXBQvHefq+PGje0JP5Lui3084Cpu5ML5I9sEB6IobhpdmkvIi0sTbiUdCbtuHNp2i0RheHRK4vYueXAO/HOYyOaPHeR2vk+n1yNZN5WLPVp0d5P1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773107; c=relaxed/simple;
	bh=nmdvAW475QOFj41fXBS9WHD28ffywjbwqhGKNPX0BMY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DBe25SZR5nUhuC9aFgFHorFhSRwUW1Zsxpf1YsUDGkATwvQUdAUF2EqnlnHcy82DqRBVOgs8EN0IXVS6d/Au4Upg+7Fh5agjCI57gVA6ihD8UPCS0vJT1lS3YjPTwhl7TmmKL12QoPx0zi9EHyOq6IGEhdOYYxN1EPHulRBNkxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lKJAF/0D; arc=fail smtp.client-ip=40.93.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lKJAF/0D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCMu0dbCygLZd3fGJdX/ZvODSQf/35U0MPuRaNEdxDwzdHhpzFhIkgbCoclgkiHxCYdXkegkKwkT7d62Pxgm7ljWfc5Ha/ii0tEYeHpg5LrGm6njliyhXVBj5e0WxYPu2EaleA8hv4rGrTa1f8c7b91k4zTO+HomGXEAPflAusLI7u87W8zcWPIEdSEWLyfc37m41thidLcWhkzMc4Cc6hNwb3aTWcLfJG6yCYM+fRZqKcIX/pqKOdQIHyUCB5VDb2ASUkevITOuu4FmxShdHunDOhp0zBsb0yjjDBjai5WTy9miHalODYiXZuwB3FTiY/aTLgxH0JQJtzWpbmbUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM732EWyXjY1uo4zR8fT9qobuujQOwzWvrmdqYRngvk=;
 b=tozH92KTgUvSf+YHc6UJBKA8ngFimIo9uvJnoSAE2PIWiVWoxJdkqn/Z3vS3hrZTKH/UT4YLy1Vses/MnVSTuNGMY+Hkt+sON6sjxn1dnAXSjALrTiJbtjjn3DDVwzb6HDGG6IWbpGOs4g4yoxnCz0Md9nRgpjxlIhZgmhzwTXgvW2EPampk0F/T8u7ZFBL8xWlXxZr1/mHP5ghMofzI24+kQxHCDisGt76F+zDNnSSFPoFwOSPd4fLINB69d3SE23g8tawMCa96TaJ0C3G8rktMw81g761Fb1uCoxIijWoy+Fy8cLxMt3eMtLHJnB9izbNqfLRCGh+GyZErZphdUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM732EWyXjY1uo4zR8fT9qobuujQOwzWvrmdqYRngvk=;
 b=lKJAF/0DLwJAivE9S0NGS6pb6+a8uLSze5/qwXDtyIzaUAaHRfN+6cdV2Geqoe+wjY0WNO61Lr2caKfXrWT0ael5iwYNZXBkiJaplyEPgPvEulYWQFCLHh8y7T379vipxL527OoEe5AbLcMBnzjLDL1HJWA99szYfjWqyqFlUjzjmYFbNa6f5pAnCfCRPDG7pTguG785dcSQuHKutGkeAq893xkoSD8CTPHQRmwMFEd8Md0orpl/me5RRdJ0I/fyoh6YNY0770NvDNMOWcKm/gFF/a9wgOGoMGgl7e4JCnuth1EvpYSOFrJYymHXoUrFANPlqsr/QXKhvPBfZv/ryg==
Received: from IA1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::9)
 by LV0PR12MB259608.namprd12.prod.outlook.com (2603:10b6:408:3ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 12:58:15 +0000
Received: from BN1PEPF0001806E.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::77) by IA1P220CA0018.outlook.office365.com
 (2603:10b6:208:464::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 12:58:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0001806E.mail.protection.outlook.com (10.167.245.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 12:58:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 05:57:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 05:57:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 05:57:53 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, "open
 list" <linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 0/5] net/mlx5: Introduce mlx5_nodnic, a driver for DRAM-less NVIDIA Mellanox NIC functions
Date: Wed, 30 Sep 2026 15:57:03 +0300
Message-ID: <20260930125708.144767-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806E:EE_|LV0PR12MB259608:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d2e7ad-eadf-492f-e8cd-08df1ef27db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|30052699003|1800799024|82310400026|376014|36860700016|18002099003|3023799007|6133799003|10067099003|260925022911599003|260925021911599003|5023799004|260925021311599003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	FF7sLsJ1v5J8x6ST4DR6Xpb5n1r8IQZ1OS4DlP/WbqTJwqFi1L4tM/rm7OKInov90vz2hhJhVsVD6AXFbmm6Kz08WU8apyJWUz4DJ2bzheSqnf5wtLviCPDkvVsV7qbaBBiYgLxFRZNHfwRgYRS2Myjx/WpLvTBc93BRg4hns7ZeYcBAcyiGjeicZNQqH0ZZj1tzMBsYu/35DS23WaZnIXL2S2mguBSrr5yPAjUaogbQBsQj3AyIFh4HaFQJcyaC/otqv4Q/m80PJLDbhlUQ6HdrCoECNYUHIiEmi50dii9PXf3ul8S6jeFcS1MYXTzXm+AdWfipzB1VmuZQn6BqQZ8V+K4QcCHQiVYxBeqDb7NRFljkqc8T521asB4OjUNndl7L71r6THD+SiWnEZ4WyxpWHFAC80G/zNwQLFVndnXkhk5rRd284l8oJiP8NNFjPJd4hDQx2qvJvtLl90CLXo/5R94YW880d2fKm6wrgpF9GDYy4MNgR92KZZoldSDwRDmb7kwQNyBTXfFO5Dn9yx+plepsL35/RYxtsQfE+gPn8m6PvV+WHJWgbGhmnX8yIRTZ9lj4X8y5mNINXWGY0XDO+UTmTCraB+BhmwM411ScKskoWlfnjooWvB8x6/cuhIQbJxWuLjajqBLOHNAHmxrJKyuT5sx4A+PiRPqFurcWBuHukVs68m0KgoUw7YjZj2x4a5cw6fJlKt3OgdMZQg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(30052699003)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(3023799007)(6133799003)(10067099003)(260925022911599003)(260925021911599003)(5023799004)(260925021311599003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	biJUGrfmVU6TdEr+cES0rHqjTosDTLkp2XGbAFKDLDmdkKFETAxBi2LFp7neIX+G2m7RvEeWSkPOSVHYwddlcvYsZWFDYpkNeh16oUhirYU29nOveuH51zKcpFTFRHiTqvHspurB6fUMG85FCGdmz/ZNQVNoN3k8jODz8OX9mDvMO8Nafn6FobEXnQfhXQQOGzsih7OtNSXIkAQVhvcPDEbXdfGlloi2HoHP1gleFjzKH+8gA3o9GXGUUyJ4Cg7LxlG9aZ8foPJ3eWWZgmm5dou75zzWfssTZoZADhNZtOR4WYTWUl7m/u7e9oe7tV1KKPp+f19UzeR3W8mhL2sLeFovFxTP5bKFYTx7+viDf+6ocj7cYfRwtulBPNpFZ7LwqKgB0SAIa9FMEVJ5m+3zogOt7GXz5ZHqJq1vUt+bZ1WMQ5eEkX1gyBcqcY2K9w/7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:58:14.8057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d2e7ad-eadf-492f-e8cd-08df1ef27db5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0001806E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB259608

Hi,

This series by Shahar introduces mlx5_nodnic, a Linux driver for the
NODNIC (No-DRAM NIC) hardware interface present in Mellanox/NVIDIA
ConnectX-family ASICs since 2015.

NODNIC is a first-class hardware capability.
It defines a lightweight NIC function intended for contexts where local
DRAM is unavailable or too costly: embedded controllers, management
planes, pre-boot environments, or any resource-constrained instantiation
of a ConnectX NIC. The hardware sends and receives ordinary Ethernet
frames via SQs, RQs and CQs. There is no encapsulation, no private
protocol, and no FW interposition: packets are forwarded as standard
Ethernet between whatever peers are connected to the function. The
interface is documented in the HW spec and has been in production in
non-Linux OS drivers for over a decade.

Where it is used today:
- Embedded management controllers on ConnectX-class ASICs that need a
  network path to the host without consuming a data-path PF.
- Resource-constrained SoC integrations (no local DRAM) where a
  minimal-footprint driver is required.
- Pre-boot / early-OS environments (PXE, iSCSI boot) that need a NIC
  without a full mlx5e stack.
- BF4 management PFs (one concrete deployment): on BlueField-4 the
  firmware exposes a NODNIC PF on the host side and a peer PF on the ARM
  side, using standard vport forwarding to connect them. This provides
  in-band Ethernet connectivity between the host and the DPU OS - SSH,
  PXE, and any standard networking application work over it without any
  special handling.

Design notes:
- The driver is separate from mlx5e rather than a mode within it.
  NODNIC uses PCI Vendor Specific Capability (VSC) for command
  operations - reads and writes over PCI config space - instead of the
  DMA-based command interface used by mlx5_core. This is what makes
  NODNIC usable in environments without reliable DMA access, and it
  makes the two command paths fundamentally incompatible. Folding this
  into mlx5e would mean carrying a second command transport and a second
  resource model through code that is already dense.
- A single SQ, RQ and shared CQ are exposed per function, with two MSI-X
  vectors: the data vector fires on CQEs and drives both TX and RX
  completions, and the event vector notifies on port state changes.
  This is the hardware's model, not a driver simplification.
- The driver exposes a plain netdev with no private uAPI, no ioctls and
  no vendor-specific configuration surface. Everything is driven through
  standard netdev, ethtool and devlink interfaces.
- The code lives under drivers/net/ethernet/mellanox/mlx5/nodnic/ and
  shares no paths with mlx5e, keeping the footprint small and the blast
  radius of changes contained.

Regards,
Tariq

Shahar Shitrit (5):
  net/mlx5: nodnic: Introduce the mlx5_nodnic driver
  net/mlx5: nodnic: Implement data path
  net/mlx5: nodnic: Add TX/RX statistics
  net/mlx5: nodnic: Add ethtool driver info
  net/mlx5: nodnic: Add health monitoring

 drivers/net/ethernet/mellanox/Kconfig         |    1 +
 drivers/net/ethernet/mellanox/Makefile        |    1 +
 .../net/ethernet/mellanox/mlx5/nodnic/Kconfig |   18 +
 .../ethernet/mellanox/mlx5/nodnic/Makefile    |    8 +
 .../net/ethernet/mellanox/mlx5/nodnic/en.c    |  263 ++++
 .../net/ethernet/mellanox/mlx5/nodnic/en.h    |  158 +++
 .../ethernet/mellanox/mlx5/nodnic/en_cfg.c    | 1107 +++++++++++++++++
 .../ethernet/mellanox/mlx5/nodnic/health.c    |  315 +++++
 .../net/ethernet/mellanox/mlx5/nodnic/main.c  |  876 +++++++++++++
 .../ethernet/mellanox/mlx5/nodnic/nodnic.h    |  105 ++
 .../mellanox/mlx5/nodnic/nodnic_ifc.h         |  318 +++++
 .../mellanox/mlx5/nodnic/nodnic_pci_vsc.c     |  418 +++++++
 .../mellanox/mlx5/nodnic/nodnic_pci_vsc.h     |   45 +
 .../net/ethernet/mellanox/mlx5/nodnic/rx.c    |  172 +++
 .../net/ethernet/mellanox/mlx5/nodnic/rx.h    |   25 +
 .../net/ethernet/mellanox/mlx5/nodnic/tx.c    |  230 ++++
 .../net/ethernet/mellanox/mlx5/nodnic/tx.h    |   61 +
 17 files changed, 4121 insertions(+)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/Kconfig
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/en.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/health.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/main.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_ifc.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/rx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/tx.h


base-commit: 47a1446725732cd3996edf607e8739334bbf4d78
-- 
2.44.0

