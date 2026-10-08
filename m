Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4DB3B1EC0;
	Thu,  8 Oct 2026 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480089; cv=fail; b=aE+P9s6bsVaD+2HmoZ6Kt4MHCDpd1rCUffNStCbKGFNcW8Lvx7MdcjhRNm8zpYNivqHWbwloFUiTc7bbrzQN0ys9+ho/9vVUPyKmb5PxI2m0HrqKqEqY4cmeqWBafCm6q7Txxnfy1j/JmOY+BlR1sZ8tEK2qlbM5yNYWYB85Zxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480089; c=relaxed/simple;
	bh=mKBpiUlzu+06xui2M7M5TFj3CxmEUJGqecWqzojbQ3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hWO7tfVEmaPO8jpLp0CKpDFxmbJAGCT03JkMBYFcXfYRdP8QacBnGk8BroXIuY7+OO2t6Ma//sFBJ2+g8cjYjueYNDj+tdBH0Wc6oH9pJlYuv6JmnzTN/WVsJBlQ6mOrX/Aml2W4zDZ909idXbqWaf4DVAPGNxahdM3iXT+I96I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FB5zj6R/; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FB5zj6R/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVuIsW1rmN9y+BHlMs8Fcb3lSiD86lpDInCdLRCz+S5S5WuyzHETIevWM7vA/nTFNvLYWhzESq/st/z7d/s99MWDZq+T3+YxRuwzAaJfWBlRoAn6q0dBbA1/6nPzosB6u7BHhPs3mCtyAv/0gJJoB7WAD2196jaPUu9gVa122cD/9bDnlaBjEptvSIcYHTJ+G5wQ2fxyQXHmzR7ZHKf1Sdp4ZjcUWl2/CvGKvo4TxaVGhxrXx18MruKyrKhHfz+GoOjpiGO9PlOsl0w0OcjPR0I6gzNj4nzz7D9BBjsMBPXrsOIoZMIyXCxtax3ou8Oeq+0N2AcSWROwdCsJxFWn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=movjVmX+BLgqTq/bKnU88oxquynLkbd7ALz9g7ntxyQ=;
 b=BHdHS4vBQczhQnxUvesBE3QP9w2WB8dD8xMfMs0VA1uHgK0GAd3EjvqRHL5Xa1qKyBIiiviU8+n1TiG14e6mJE3vmOsOiIGhgIFpXcB7o/g2JTBs9VorhXIJYoA8l4oEsepHqa+z5DVNTHd17tNXUjLXJYPlvj2YaWhkuWt4K9xmpG3q6PksvzDql5JpaRkg2BqrJe6TfEAmp2Js4sjU6rFlubP8DlEddj2g5Z5QaydC8lmvpVkgfkB6m24EvWFTL6P932L/GhIgfwNTLb6R7DnLR5e5DQlWqlFuLCVVmsTFly7PNs0epZxn3PqQu26wJxIPKUSb9/+LM1x0utKH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=movjVmX+BLgqTq/bKnU88oxquynLkbd7ALz9g7ntxyQ=;
 b=FB5zj6R/RB85MmYzUbxdF8zriEY/JdcMiomRuPKL+PF75W+uycQ/3yUo+7emt2jHgghtYm5Efs0bOTeNUl/NMfkxbpfNIKv3o2GurUa8/3o7528rgudSduLgWpXJRwv4pZL7QZSHZTLX/bnJjYM/cvyo3/QqwU2waVLtkQHYp63cXkRbABkw95ZhevHj7XenN0C2eiCO3BP5JWSEd3F1RWrFzGrP+CZej0qArDleSovsIiDI2eoGpYHx3GIC7GJBXU1J+CpzmK14PNBDmDhqjBNVdZCdLQwlt7G4H4u6AqO5r1Wn2eEy9yvbcs2sXhcThiv8bzkTVTHAlF6zsQGZDA==
Received: from CY5PR17CA0027.namprd17.prod.outlook.com (2603:10b6:930:17::26)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 17:21:18 +0000
Received: from CY5PEPF00000E7B.namprd02.prod.outlook.com
 (2603:10b6:930:17:cafe::96) by CY5PR17CA0027.outlook.office365.com
 (2603:10b6:930:17::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 17:21:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY5PEPF00000E7B.mail.protection.outlook.com (10.167.247.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 17:21:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 10:20:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:20:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 10:20:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, "open
 list" <linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 0/5] net/mlx5: Introduce mlx5_nodnic, a driver for DRAM-less NVIDIA Mellanox NIC functions
Date: Thu, 8 Oct 2026 20:18:15 +0300
Message-ID: <20261008171821.660739-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E7B:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e91dcbe-68c7-4105-3290-08df25608f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|30052699003|376014|23010399003|82310400026|56012099006|5023799004|11063799006|10067099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	fma45CkaDVTfUd3wLjkvE/Vm2kAwbztj8Nm68F/HaktDhRZBNK+XBY6VrepHPAoyMgkKiG7WHh3IBzuwhyikWj7Sa/sDxe0zUSgozayv2jLZLMRXKTJLa/Iomu6Diqv31CuZye+WBvv8P4xch4/OHFF8EZhw/YMaVvEfPmz160IoUhIxxiMh1N0k4VvqU2xmLUPCBOGZT89HHEvBOHhR287Moo7mqoa+yXgOjMG9oWbScoiPh3Ur/b/s2tjxb+b0wo+Glk2jFCucDP3/Qs76OW4ZTSOniYwqZTBaqRgewYJJ8cGUcr6FLcSynbUBhpGvPlgmR9/YJiS7uRk1t1ubrFvSjLJ1QvanB34XDhXCZHL2X6rs+YJWPrVuQhPimnYwyy8xRvp/kl0LBdnzbwoSXfWyItF2wj9lakhKZCWAMUDwHXiMxEkrJpsPbzDWcmP62wWwEcA7k32Gu/xMAbVtwhxj0H+3ur5rZrzYotAEr0gObmrDcKpw3TAfYxJg6U84j/kXJJcif2xhnaCUtkb3mKnsps9EgaUKn2T5j6mNAhMUEZBkH979nrsPUxfeWPjUq/O4714AasfGlxMvUM5T/tIzGcvNr+YiOQ7QBEVE4eirEPjTOw21fQ6QyfC/uh8mIMr6SLb3I9zTUHqvx+1ZmjVfNrflqkJzUwHnT6WG7uUrg1SvJZKVX4v2TkZ2Jschr4PVwhHZ0ZDXHKM0gDH2hg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(30052699003)(376014)(23010399003)(82310400026)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9n1ISevlNXvHE1G45NLzTWUFJeU8yUmpOfdOR+p4ZxBnXMqf5LhRS1CuH0obgwxHcZnblBrl3fFdNd2/vQpCghINFDwB04IxcSIoabHnNhnH9P8uiNGpOUSk0h/7n+it5T36OesfnFTUUAHEv7+qZ4Q8xKOB7/UN+DR9dV044GMKnM4atu7H+KryAZzIZaRFMmzVTBwbP/vEWks0yFea/yKT0FyIFPapHyfOnFgfvK17D42mTehPvo4Q6hRtY/xSkJJgrrCJ+Wq+mwWn9VxdwOfDIRs4dSFV84XVpZgVZjwaoIJskf1BW7J88/6Y1Eb/shTd6hdnSqha4zZ/I4OHjEbp8XxTAKo1MBEhh2iEcqeaaE2vPDfdIrpI0yPNg1s4io/LuZ5lq4UB/oPtyZE/E3vSnxVhg4/k6ufC7PrdB38jN30Mx1sNaNeGXzmnHQv2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:21:15.8389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e91dcbe-68c7-4105-3290-08df25608f35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E7B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371

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
  standard netdev and ethtool interfaces.
- The code lives under drivers/net/ethernet/mellanox/mlx5/nodnic/ and
  shares no paths with mlx5e, keeping the footprint small and the blast
  radius of changes contained.

Regards,
Tariq

V2:
- Fix sparse warnings in the VSC accessors: use __be32 for the
  big-endian accessors and drop the redundant le32 conversions, which
  were also wrong on big-endian hosts (Simon Horman).
- Cover letter: drop the devlink mention (Simon Horman).
- Replace the open-coded bitfield macros in the VSC code with
  GENMASK/BIT and FIELD_GET/u32_replace_bits, and turn the config space
  accessor macros into functions.
- Fix line wrapping reported by checkpatch --strict.
- Add a MAINTAINERS entry for the driver.
- Kconfig: select PAGE_POOL, fixing the build when it is not otherwise
  enabled.
- Drop inline from a function in a .c file.

V1:
https://lore.kernel.org/all/20260930125708.144767-1-tariqt@nvidia.com/

Shahar Shitrit (5):
  net/mlx5: nodnic: Introduce the mlx5_nodnic driver
  net/mlx5: nodnic: Implement data path
  net/mlx5: nodnic: Add TX/RX statistics
  net/mlx5: nodnic: Add ethtool driver info
  net/mlx5: nodnic: Add health monitoring

 MAINTAINERS                                   |    9 +
 drivers/net/ethernet/mellanox/Kconfig         |    1 +
 drivers/net/ethernet/mellanox/Makefile        |    1 +
 .../net/ethernet/mellanox/mlx5/nodnic/Kconfig |   19 +
 .../ethernet/mellanox/mlx5/nodnic/Makefile    |    8 +
 .../net/ethernet/mellanox/mlx5/nodnic/en.c    |  263 ++++
 .../net/ethernet/mellanox/mlx5/nodnic/en.h    |  158 +++
 .../ethernet/mellanox/mlx5/nodnic/en_cfg.c    | 1107 +++++++++++++++++
 .../ethernet/mellanox/mlx5/nodnic/health.c    |  315 +++++
 .../net/ethernet/mellanox/mlx5/nodnic/main.c  |  866 +++++++++++++
 .../ethernet/mellanox/mlx5/nodnic/nodnic.h    |  105 ++
 .../mellanox/mlx5/nodnic/nodnic_ifc.h         |  318 +++++
 .../mellanox/mlx5/nodnic/nodnic_pci_vsc.c     |  343 +++++
 .../mellanox/mlx5/nodnic/nodnic_pci_vsc.h     |   45 +
 .../net/ethernet/mellanox/mlx5/nodnic/rx.c    |  172 +++
 .../net/ethernet/mellanox/mlx5/nodnic/rx.h    |   25 +
 .../net/ethernet/mellanox/mlx5/nodnic/tx.c    |  230 ++++
 .../net/ethernet/mellanox/mlx5/nodnic/tx.h    |   61 +
 18 files changed, 4046 insertions(+)
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


base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
-- 
2.44.0

