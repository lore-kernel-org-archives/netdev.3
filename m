Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6772F549F;
	Fri,  7 Aug 2026 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099491; cv=fail; b=QfVujxKR8s3i2tq5riSDYd5ee8cdxI1BhU+oaAmE+6SbaPt6v30CwNwei19nBCHoRBEeZanSwC69GVJL1Hx9g525p0UA+soZ3qa417Znaukx0VvvObujJT3UR87LL7CEAnKGptsU0nMwiBm87XL9zgoegr0Q0IOsHEisxLkXAn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099491; c=relaxed/simple;
	bh=xRFbQqxjGNk6N1x7yc2dUhZWgcnZzoatOJ673Xk6qmU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=akAQcNKwPfM7bOUi9tj3GknNb3dJMKoguAwBln47LEsOMTJeWqJ6xTt6Qy/x93pL/XQumLZqN4FFLhKbMo8QavJY/vERjEZn2FL8v0Dg+TG+R6wp/xD25EcxNceH6wQRlERlfDu1P6tRL0+4urdSWLO6n0enC0dVvkw/Uv8Nu2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SpouA8pA; arc=fail smtp.client-ip=52.101.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SpouA8pA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYRigOpz+SuZGaZ+BpTq8BcUgfdnjDtLiwTqX8anz/U1hloWb3SD/+Ar9C5DBvbLgsvhOWu28aBKen98gxxvl80maKiRy/AJ2rQbfftYFuC6st1vEMYHkMf+cBedcSl9aXiZfYvEB+8S5flYCPqu6Tmwvoje42MjhN8Ug7GRcbYjipHVu3qhb+DNO6G8yjNthgZ13yVuk1iCJZj9SfE8tl4J/1dtp44ikiu7kPRl7uPm1YL5Rw163RJDdT3N5iF7CEsH8/fXYqkYHz0l5aMiVrVtqIXFKeC2S3c4FOKcTFeea0x580llKFgGod6iDeUUndGJ+o2+MQCEJy9teexw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6h0v7rdo8opTpgDTkqDfuyYtRhCa8TmcPBk9YSbDTk=;
 b=pmQdc/rwCfi+WcAWOWFyaE0YipP0Q+pu+uhAhiYccav0yaDyq43V8DDqMFpkseIK9jW6imL1eiujk1R4N7ieUEkRNHZMxaxypRdHfvXeJR3mJgTgMeIBdDwFUppi4NDeZjaHfQYqSMClX+4CRSaAwOeK4U3jjigEhjrOHnYi0KnznTnojxH9yxIKjUG8bPOJAD+S+IC4QVFmOEuF4BGDi6EvTQBvi/p2+CE7Qc7FC6tH6cYXBSL7CAg+aPE42cTriAAEqBgh8Nh/qYgWSUAacHK9jMnyduJ9CLtej1/tly12Q2ofPp9lsSY5BeOCc9+NAgsrsipcJlgvrIZpszSNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6h0v7rdo8opTpgDTkqDfuyYtRhCa8TmcPBk9YSbDTk=;
 b=SpouA8pAOD4oRI+BR3H5J7KWZt9QM5vDAhbcRMkx/efhrYXDdywSe6R3EBucusrUKArULLeN6YA2IKdGO6RoGeidA22BzSRU9Gib7Y5UJy48vo9LBBhugD+Ip9QinxYs+YJASmpFdei27lettRDpqPxo3VecK2kDmZV8BMHpf4Y=
Received: from PH7P220CA0078.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::34)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 10:44:39 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::1c) by PH7P220CA0078.outlook.office365.com
 (2603:10b6:510:32c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 10:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Fri, 7 Aug 2026 10:44:38 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:44:36 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:44:31 -0500
From: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
To: Srinivas Neeli <srinivas.neeli@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Michal Simek <michal.simek@amd.com>, Andrew Lunn
	<andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, Simon Horman
	<horms@kernel.org>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git-dev@amd.com>, <nagadheeraj.rottela@amd.com>
Subject: [PATCH 00/20] xilinx: tsn: Add TSN Endpoint Ethernet MAC driver support
Date: Fri, 7 Aug 2026 16:14:11 +0530
Message-ID: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 183a1f16-581f-41ee-dfe5-08def470e159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|23010399003|82310400026|56012099006|18002099003|3023799007|6133799003|10067099003|11063799006|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	4dLmvxTc8or3z8IWGsI/wy6I9VHGXT/qHKw3kmnfOSFNaQIVHke9EhiXo4V64s1nxa9kugxMyY5loIqepV9LT2aXRGfVHbPhZA/LqGn5J2zNbYzmYhn5gKkXyD9/FeTml8jmdu1hynRBdCkeEFNrEgy3RUOmSw8bdPfqf9KOJDhX85VP3gKQdPq2b1qOa5/cobq//Bznhz3eUeRIcGR4gA5P2xAf32d1h50d0CBgDu9SuCZsiX7UiDK3KvhGkYpV1zif2iIFWkjxGuinUb2yR180WjQO9kXD9e+RsZegCt7wx8CBt7u2XaAYRy23BDAWvtOhzyWEixV4N3Tpch+O+XtReCyy5pxHr9NF0gUBa46b1XhnySWIgTAmNsRWFcbjB05qVNTeN8UfcrWMcVrX5+oyR7n7d62k9FmmjCGQnnTkaTL78Dl/ByK22HSpIcB9la+Ni7HBfxuewEygfzrahlyGi9YwLVMp0dpf4MCaVIcg6EOxhTt85hghhJZqu1gtxkPdil46H2EHRBMbzeNaWYbnjOCYsTDUTY3nFarv+Jl1ONAaNWCeo2q1t4AG9D9T+NfUPnmHUja5uUUq3hKj7o6U5NUf0zJYTgyjZWvbLFfbQg/mU2jW1rMCZWYXwv+zpjhtFSESuB0+oIKH7siZfFNGgcEbWSuEk+ljf87LyHRFLVOExVAMV3u63xfw+7vPR6a2QPRk0cefyll52/XPca1E1XOe9ef2Qiq9LA7b4s/n+jgJ8oAHcY+FB73deN/7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(23010399003)(82310400026)(56012099006)(18002099003)(3023799007)(6133799003)(10067099003)(11063799006)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aglTk21EIYGvRrmEpo/26S81uZ7mRDSjOr7INs66ZNHrzSoSpXXty0oAfgpHqaTiXr5p2oNhVHG1NLy+UrjNsDEpq9PLHoXAXoJ1Ds8n7FCOtqdMdkOp3GIsjaUzdy7yqSTUr6eJp3c9Q9XRDbchMLjxk/W/1uRcnyRyEftcdRGWKs8nWZHGH3yOh5a9IrwHSErtKS+vu6G5aiU8+0wy/+4JlMOTFjk3EQynunbaEi4EytNnFXeGoKfsKrDMALt7jsjPVBMZDuU0Vg/B7WBr02djTvywIfoMs4XZBF1jfv43NWaB6sb5h/6H5hJ818ADDA7MwjxMYK7dwx/GlUlAn2owFuBU8Xdo6b8mdiEzHXn3qYAQCEAuc6I0jIPxWP6wB4Bvh17xs7IvHGm0LPRIhaj69kjFJUJIJ2rbeC6Yc83+ktBUJF4OQIGeOfpToUvd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:44:38.6188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 183a1f16-581f-41ee-dfe5-08def470e159
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222

Introduce a new network driver for the AMD LogiCORE 100M/1G TSN
Subsystem IP, also known as the TSN Endpoint Ethernet MAC IP, which
implements IEEE 802.1 Time-Sensitive Networking (TSN) features for
deterministic and low-latency Ethernet communication in real-time and
industrial automation use cases.

IP Core Overview:
The AMD LogiCORE 100M/1G TSN Subsystem IP solution (named as TSN Endpoint
Ethernet MAC IP in the IP catalog) implements IEEE 802.1 Time Sensitive
Networking (TSN) Standards and provides a low latency Bridged Endpoint or
Endpoint only solutions. The bridged endpoint solution consists of a 3-port
switch that connects to an endpoint including Linux software drivers. For
Bridged Endpoint (Switch Endpoint), two ports connects to the network and
one port connects to an internal Endpoint. It supports the use of
GMII/RGMII interfaces connecting to a physical-side interface (PHY) chip
with full duplex 100 Mb/s and 1 Gb/s operations.

Features:
- IP Customizable to generate TSN Endpoint or Bridged Endpoint solution
- Supports interface to network software stack
- Designed to comply with the following IEEE standards
    - 802.1AS  : Precision Time Protocol (PTP) synchronization
    - 802.1Qav : Credit-Based Shaper for traffic shaping
    - 802.1Qbv : Time-Aware Shaper for scheduled traffic
    - 802.1Qbu : Frame Preemption for ultra-low latency
    - 802.1CB  : Frame Replication and Elimination for redundancy
    - 802.1Qcc : Stream Reservation Protocol (SRP)
- IP is customizable to enable various TSN feature-sets
- Supports 2 to 8 priority queues for scheduled, reserved (IEEE 802.1 Qav
  Credit Based Shaper) and best effort traffic classes
- Provides feature rich Ethernet Switch that caters to various network
  needs
	* 3-port Switch (2-external, 1-internal)
	* Programmable cut-through and store-forward operations
	* 4-port Switch (2-external, 2-internal) extension through
          'Endpoint Extension' and 'Endpoint Packet Switching' features
- Solution validated on ZCU102 & ZC702 AMD Evaluation boards.

Sample hardware architecture diagram for Bidge End Point like below:

             +------------------+
             |      MCDMA       |
             +---------+--------+
                    Q0---Q7
                       |
          +------------------------------------------------------------ +
          |            |	 TSN sub system(Bridge End Point)	|
          |            |                                                |
          |     +------+----+  Port 0   +-----------------------+       |
          |     |  EndPoint |<--------->|       TSN Switch      |       |
          |     |    (EP)   |           +----+-------------+----+       |
          |     +-----------+                |             |            |
          |                                  |             |            |
          |                              Port 1         Port 2          |
          |                                  |             |            |
          |                            +-----------+  +-----------+     |
          |                            |  MAC-1    |  |  MAC-2    |     |
          |                            |  (ETH1)   |  |  (ETH2)   |     |
          |                            +-----+-----+  +-----+-----+     |
	  |			             |		    |           |
          |				     |              |           |
          +-------------------------------------------------------------+
                                             |              |
                                          RGMII           RGMII
                                             |              |
                                      +-----------+  +-----------+
                                      |  PHY1     |  |  PHY2     |
                                      | (Port 0)  |  | (Port 2)  |
                                      +-----------+  +-----------+

Software Driver Overview:

The switch-facing part of the IP is exposed through the Distributed
Switch Architecture (DSA) framework, so MAC1 and MAC2 show up to Linux
as proper switch ports (swp1, swp2) that can be enslaved to a Linux
bridge, with the endpoint acting as the CPU/conduit port. The driver
is split into a thin wrapper, an endpoint driver, a DSA switch driver,
and a DSA tag protocol, mirroring the hardware blocks:

Wrapper driver:
- Binds the top-level IP node, acquires and enables the IP-block
  clocks.
- Spawns the endpoint and switch blocks as child platform devices via
  devm_of_platform_populate() and carries no netdev or register access
  of its own.

Endpoint driver:
- Implements the conduit net_device that Linux DMA traffic flows
  through on its way to and from the switch fabric.
- Manages multi-queue TX and RX descriptor rings using the dmaengine
  framework for high-performance packet transfer.
- Classifies each received frame by the source-port id carried in the
  RX descriptor and attaches DSA port metadata so the DSA core can
  demux it to the right user port netdev.

DSA switch driver:
- Registers a struct dsa_switch with three ports (CPU + MAC1 + MAC2)
  and owns the switch fabric registers, the per-MAC register windows,
  and all switch IRQs.
- Implements port_stp_state_set to drive the hardware's per-port
  Disabled/Blocking/Forwarding state machine from the bridge's STP
  state.
- Offloads the bridge's FDB and VLAN membership into the switch's CAM
  and per-port VLAN tables (port_fdb_add/del, port_vlan_add/del), and
  installs CAM trap entries so link-local STP/LLDP frames reach the
  CPU port.
- Enables the bridge's TX forwarding offload so data frames take the
  switch's own CAM/VLAN lookup, the same path a frame ingressing on
  MAC1/MAC2 takes, instead of being flooded by software.
- Registers a per-MAC MDIO bus and wires up phylink for each port,
  including PHY connection management on link state changes.
- Registers a PTP Hardware Clock (PHC) backed by the IP's shared RTC
  timer block and drives the per-MAC PTP TX/RX hardware paths so
  event-frame timestamping bypasses the switch fabric and DMA
  entirely.

DSA tag protocol:
- Adds DSA_TAG_PROTO_XLNX_TSN. The xmit hook intercepts PTP frames for
  the per-MAC PTP TX path, other frames pass through unchanged. The rcv
  hook is a defensive no-op since RX demux is handled by the endpoint
  driver's port metadata rather than by an in-band tag.

Changes in v1:
- Reworked the switch side of the driver onto the DSA framework
  instead of exposing MAC1/MAC2 as independent, framework-unaware
  netdevs.
- Added the DSA tag protocol and moved RX classification from an
  skb->dev based scheme into DSA port metadata attached by the
  endpoint driver.
- Added STP state offload (port_stp_state_set), bridge FDB/VLAN
  offload backed by the switch CAM and VLAN tables, bridge TX
  forwarding offload, and CAM trap entries for link-local control
  frames.
- Carried phylink, per-MAC MDIO, and PTP support over from the
  previous posting, now wired up through DSA port ops instead of
  the platform driver.
- Split the driver into a thin wrapper, endpoint driver, and DSA
  switch driver along the DSA compatible/binding boundaries instead
  of a single flat driver.

Test information:
- Validated these changes on the net-next branch with the MCDMA patches
  cherry-picked from linux-next, along with the series listed below
  https://lore.kernel.org/all/20260713072146.45269-1-srinivas.neeli@amd.com/
- Performed ping, iperf3, and 2-step PTP tests on the ZynqMP platform,
  including bridging swp1/swp2 through a Linux bridge with hardware
  FDB/VLAN offload enabled.

Nagadheeraj Rottela (13):
  net: xilinx: tsn: deliver endpoint RX frames to DSA user ports
  net: dsa: tag_xlnx_tsn: add skeleton tag protocol
  net: dsa: xilinx: add skeleton driver for TSN switch
  net: dsa: xilinx: implement port_stp_state_set
  net: dsa: xilinx: register per-MAC MDIO buses
  net: dsa: xilinx: wire up phylink for the switch ports
  net: dsa: xilinx: program MAC frame filter and per-port nibbles
  net: dsa: xilinx: register PHC backed by the RTC timer block
  net: dsa: xilinx: drive per-MAC PTP TX/RX hardware paths
  net: dsa: xilinx: opt into TX forwarding offload on bridge join
  net: dsa: xilinx: offload the bridge FDB to the switch CAM
  net: dsa: xilinx: offload bridge VLAN filtering to the switch
  net: dsa: xilinx: trap link-local control frames to the CPU port

Srinivas Neeli (7):
  dt-bindings: net: add Xilinx TSN Endpoint Ethernet MAC
  net: xilinx: tsn: add TSN endpoint wrapper driver
  net: xilinx: tsn: add endpoint MAC driver skeleton
  net: xilinx: tsn: parse endpoint DMA channel configuration
  net: xilinx: tsn: bring up the endpoint MCDMA channels
  net: xilinx: tsn: add the endpoint RX data path
  net: xilinx: tsn: add the endpoint TX data path

 .../net/xlnx,tsn-endpoint-ethernet-mac.yaml   |  343 ++++
 MAINTAINERS                                   |   11 +
 drivers/net/dsa/Kconfig                       |    2 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/xilinx/Kconfig                |   12 +
 drivers/net/dsa/xilinx/Makefile               |    3 +
 drivers/net/dsa/xilinx/xilinx_tsn.c           | 1621 +++++++++++++++++
 drivers/net/dsa/xilinx/xilinx_tsn.h           |  417 +++++
 drivers/net/dsa/xilinx/xilinx_tsn_ptp.c       |  590 ++++++
 drivers/net/ethernet/xilinx/Kconfig           |    1 +
 drivers/net/ethernet/xilinx/Makefile          |    1 +
 drivers/net/ethernet/xilinx/tsn/Kconfig       |   16 +
 drivers/net/ethernet/xilinx/tsn/Makefile      |    2 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h  |   15 +
 .../net/ethernet/xilinx/tsn/xilinx_tsn_ep.c   |  926 ++++++++++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_main.c |  108 ++
 include/linux/dsa/xlnx_tsn.h                  |   25 +
 include/net/dsa.h                             |    2 +
 net/dsa/Kconfig                               |    9 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_xlnx_tsn.c                        |   60 +
 21 files changed, 4166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
 create mode 100644 drivers/net/dsa/xilinx/Kconfig
 create mode 100644 drivers/net/dsa/xilinx/Makefile
 create mode 100644 drivers/net/dsa/xilinx/xilinx_tsn.c
 create mode 100644 drivers/net/dsa/xilinx/xilinx_tsn.h
 create mode 100644 drivers/net/dsa/xilinx/xilinx_tsn_ptp.c
 create mode 100644 drivers/net/ethernet/xilinx/tsn/Kconfig
 create mode 100644 drivers/net/ethernet/xilinx/tsn/Makefile
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
 create mode 100644 include/linux/dsa/xlnx_tsn.h
 create mode 100644 net/dsa/tag_xlnx_tsn.c

-- 
2.34.1

