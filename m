Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.240.164.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580386;
	b=BICMN6zC/HKxIuWYjXyeJPummIvIg+zVJyjGSK7S85ZoOWvLy1GPXJKrZOg7kysI0wIH
	 ly7RHznlEJwru6jrkLey/fff+xZSkLJdiVo/ytQxhK3p2NaTUdU6EDsjhBnbOU5DQgEDA
	 8Pr2rT+xg06OT+e6T8DtSCQTCHUe5+4qQu0tUo/vJbCapjx8Tnr8/8d/YKLHlQkrDgmQD
	 9w6hueYIc5GNOND67lZl4cA0JNZIaWZoq29iNapKQsB0yy1C8b2j4M9Zpf3Sco2RXW7hI
	 pPRDtd4vaknyE8ySAsK8fO1ouWXuwtSB5LvvQZLCC6w5UV6e8KwS6I8f3vcfNjiXRiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580386;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=Hd+ojRNyVmS2Nc7uv+EkqKbfZ8AnXkMiivRUkETH+9c=;
	b=UgwQlqrd0B63hIaqMx6PjcE9oDQR+6bybmvF7fo0BxzUq5ywOapZCNurHzzifjQbX3g9
	 I/o9+LvBFGKYq47Gt3rTK7AHs6ZPkTH14d48BEUvWmOMr1BTJu9ffgRoXgpfpAESFk3BO
	 Vb4wXBxLm0K/5m/0D54ir5P4rpMpg+GBREvgufSdAKHq8NIcSVFZiKYXLgtxpMAkI71lk
	 qXbfmdgg+2sryZXPj0omp3Ks1u2eFfegRE9G6EWgkr4ooa4f7OHvvVkCXbYyEggx13BX7
	 DMzVccZGW+mzJd1Sa7BODJ+EmOZichPon7+dW9sFssuYWVsNdJ3Ro85ZbAf2V3IuxVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=couthit.com;
	spf=pass smtp.mailfrom=couthit.com;
	dkim=pass header.d=couthit.com header.i=@couthit.com header.a=rsa-sha256 header.s=default header.b=nYvTrilK;
	arc=none smtp.remote-ip=162.240.164.96
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B0606A33E;
	Fri, 13 Nov 2026 14:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B1B0606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.a=rsa-sha256 header.s=default header.b=nYvTrilK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Hd+ojRNyVmS2Nc7uv+EkqKbfZ8AnXkMiivRUkETH+9c=; b=nYvTrilKk6ct9fQPmHewL0JEdq
	TQaLfFZox6GQ29TlzPIg/8ND5O4hU8CVbO5oAkvOmx+xOZb9DbFVtD5Ipm4Iy+B3bf+yIs3xBwGGU
	T9SfdhKbEQtjR3iUQoyberYX8f1p7i+Kub40wZSWVl8BqgiXS0DO7OKKRxalPNKFOLiSANklLwI+M
	C4rMhoCpYMPUxRhd3f6LmkOM3NZxfcS8uL1NfkNvI0PzDWHZNNPFoMeMP1HP0tpWy+ngDHzUDgzmK
	f8bnSFI3azf4lwsi+/hOttQ4ywyL4n73KXrPtPljmnbfTE+jREF8m0E1+KMrU3wfnlGvJWD4LfPQ9
	6mk09qFA==;
Received: from [115.246.246.98] (port=25118 helo=bulbasuar.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <saivarun@couthit.com>)
	id 1xRsKs-000000060PR-1KSD;
	Fri, 13 Nov 2026 09:33:03 -0500
From: Sai Varun Mudepally <saivarun@couthit.com>
To: danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	vadim.fedorenko@linux.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	afd@ti.com,
	basharath@couthit.com,
	arnd@arndb.de,
	haokexin@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pratheesh@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	j-rameshbabu@ti.com,
	m-malladi@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com,
	saivarun@couthit.com
Subject: [PATCH net-next v6 1/3] net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for AM57xx, AM437x and AM335x
Date: Fri, 13 Nov 2026 19:58:22 +0530
Message-ID: <20261113143127.282466-2-saivarun@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113143127.282466-1-saivarun@couthit.com>
References: <20261113143127.282466-1-saivarun@couthit.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: saivarun@couthit.com
X-Authenticated-Sender: server.couthit.com: saivarun@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Roger Quadros <rogerq@ti.com>

The PRU-ICSS subsystem on AM335x, AM437x and AM57xx SoCs supports dedicated
firmware implementing the IEC 62439-3 redundancy protocols: HSR and PRP.
Extend the ICSSM PRUETH driver to enable these operating modes in addition
to the existing dual-EMAC and RSTP switch configurations.

In both HSR and PRP modes, the two PRU Ethernet ports operate as LRE (Link
Redundancy Entity) slave ports, while the host port acts as the master.
In case of HW offload mode, Frame duplicate detection/discard for both HSR
and PRP and L2 forwarding in case of HSR are handled entirely by firmware
within the PRU cores.

For HSR, frames received on one PRU port are forwarded to the host and to
the peer PRU port (store-and-forward or cut-through), providing a redundant
ring path. For PRP, any one of the PRU port forwards received frames to the
host after firmware discards the duplicates.

The PRU-ICSS subsystem loads the Dual EMAC firmware by default. To enable
HSR or PRP functionality, the firmware must be changed accordingly. The
required reconfiguration steps are detailed below.

To switch from dual-EMAC to HSR (example: eth2 and eth3 as slave raw
ports):

$ ip link set eth2 down && ip link set eth3 down
$ ip link set eth2 address <mac-addr>
$ ip link set eth3 address <mac-addr>
$ ethtool -K eth2 hsr-tag-rm-offload on
$ ethtool -K eth2 hsr-fwd-offload on
$ ethtool -K eth3 hsr-tag-rm-offload on
$ ethtool -K eth3 hsr-fwd-offload on
$ ip link add name hsr0 type hsr slave1 eth2 slave2 eth3 supervision 45
  version 1
$ ip link set eth2 up
$ ip link set eth3 up

To switch from dual-EMAC to PRP (example: eth2 and eth3 as slave raw
ports):

$ ip link set eth2 down && ip link set eth3 down
$ ip link set eth2 address <mac-addr>
$ ip link set eth3 address <mac-addr>
$ ethtool -K eth2 hsr-tag-rm-offload on
$ ethtool -K eth3 hsr-tag-rm-offload on
$ ip link add name prp0 type hsr slave1 eth2 slave2 eth3 supervision 45
  proto 1
$ ip link set eth2 up
$ ip link set eth3 up

To revert back to dual-EMAC:

$ ip link set eth2 down && ip link set eth3 down
$ ip link delete hsr0 or prp0
$ ethtool -K eth2 hsr-tag-rm-offload off
$ ethtool -K eth2 hsr-fwd-offload off
$ ethtool -K eth3 hsr-tag-rm-offload off
$ ethtool -K eth3 hsr-fwd-offload off

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
Signed-off-by: Sai Varun Mudepally <saivarun@couthit.com>
---
 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/Makefile              |   2 +-
 .../ethernet/ti/icssm/icssm_lre_firmware.h    | 141 ++++++
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 410 +++++++++++++++++-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |  32 +-
 .../net/ethernet/ti/icssm/icssm_prueth_lre.c  | 216 +++++++++
 .../net/ethernet/ti/icssm/icssm_prueth_lre.h  |  19 +
 7 files changed, 797 insertions(+), 24 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_lre_firmware.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_lre.h

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index c60b04921c62..afed42572fd1 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -237,6 +237,7 @@ config TI_PRUETH
 	depends on NET_SWITCHDEV
 	select TI_ICSS_IEP
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on HSR || !HSR
 	help
 	  Some TI SoCs has Programmable Realtime Unit (PRU) cores which can
 	  support Single or Dual Ethernet ports with the help of firmware code
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index f4276c9a7762..e4a10d60e1a6 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_TI_PRUETH) += icssm-prueth.o
-icssm-prueth-y := icssm/icssm_prueth.o icssm/icssm_prueth_switch.o icssm/icssm_switchdev.o
+icssm-prueth-y := icssm/icssm_prueth.o icssm/icssm_prueth_switch.o icssm/icssm_switchdev.o icssm/icssm_prueth_lre.o
 
 ti-cpsw-common-y += cpsw-common.o davinci_cpdma.o
 ti-cpsw-priv-y += cpsw_priv.o cpsw_ethtool.o
diff --git a/drivers/net/ethernet/ti/icssm/icssm_lre_firmware.h b/drivers/net/ethernet/ti/icssm/icssm_lre_firmware.h
new file mode 100644
index 000000000000..b5ab0ec87c5f
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_lre_firmware.h
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2017-2020 Texas Instruments Incorporated - http://www.ti.com */
+#ifndef __ICSS_LRE_FIRMWARE_H
+#define __ICSS_LRE_FIRMWARE_H
+
+#define ICSS_LRE_HSR_MODE_OFFSET		0x1E76
+#define ICSS_LRE_MODEH				0x01
+
+/* PRU0 DMEM */
+#define ICSS_LRE_DBG_START			0x1E00
+
+#define ICSS_LRE_DUPLICATE_HOST_TABLE		0x0200
+
+/* PRU1 DMEM */
+#define ICSS_LRE_DUPLICATE_PORT_TABLE_PRU0	0x0200
+#define ICSS_LRE_DUPLICATE_PORT_TABLE_PRU1	0x0E00
+
+/* Size and setup (N and M) of duplicate host table */
+#define ICSS_LRE_DUPLICATE_HOST_TABLE_SIZE	0x1C08
+/* Size and setup (N and M) of duplicate port table (HSR Only) */
+#define ICSS_LRE_DUPLICATE_PORT_TABLE_SIZE	0x1C1C
+/* Time after which an entry is removed from the duplicate
+ * table (10 ms resolution)
+ */
+#define ICSS_LRE_DUPLI_FORGET_TIME		0x1C24
+/* Time interval to check the port duplicate table */
+#define ICSS_LRE_DUPLI_PORT_CHECK_RESO		0x1C2C
+/* Time interval to check the host duplicate table */
+#define ICSS_LRE_DUPLI_HOST_CHECK_RESO		0x1C30
+/* NodeTable | Host | Port */
+#define ICSS_LRE_HOST_TIMER_CHECK_FLAGS		0x1C38
+/* Arbitration flag for the host duplicate table */
+#define ICSS_LRE_HOST_DUPLICATE_ARBITRATION	0x1C3C
+/* Supervision address in LRE */
+#define ICSS_LRE_SUP_ADDR			0x1C4C
+#define ICSS_LRE_SUP_ADDR_LOW			0x1C50
+
+/* Time in TimeTicks (1/100s) */
+#define ICSS_LRE_DUPLICATE_FORGET_TIME_400_MS	40
+#define ICSS_LRE_NODE_FORGET_TIME_60000_MS	6000
+#define ICSS_LRE_MAX_FORGET_TIME		0xFFDF
+
+#define ICSS_LRE_DUPLICATE_PORT_TABLE_DMEM_SIZE	0x0C00
+#define ICSS_LRE_DUPLICATE_HOST_TABLE_DMEM_SIZE	0x1800
+#define ICSS_LRE_STATS_DMEM_SIZE		0x0080
+#define ICSS_LRE_DEBUG_COUNTER_DMEM_SIZE	0x0050
+
+#define ICSS_LRE_DUPLICATE_HOST_TABLE_SIZE_INIT	0x800004 /* N = 128, M = 4 */
+#define ICSS_LRE_DUPLICATE_PORT_TABLE_SIZE_INIT	0x400004 /* N = 64, M = 4 */
+#define ICSS_LRE_MASTER_SLAVE_BUSY_BITS_CLEAR	0x0
+#define ICSS_LRE_TABLE_CHECK_RESOLUTION_10_MS	0xA
+#define ICSS_LRE_SUP_ADDRESS_INIT_OCTETS_HIGH	0x4E1501
+#define ICSS_LRE_SUP_ADDRESS_INIT_OCTETS_LOW	0x1
+
+/* SHARED RAM */
+
+/* 8 bytes of VLAN PCP to RX QUEUE MAPPING */
+#define ICSS_LRE_QUEUE_2_PCP_MAP_OFFSET		0x124
+#define ICSS_LRE_START				0x140
+
+/* Count of HSR/PRP tagged frames successfully transmitted on port A/B */
+#define ICSS_LRE_CNT_TX_A			(ICSS_LRE_START + 4)
+#define ICSS_LRE_DUPLICATE_DISCARD		(ICSS_LRE_START + 104)
+#define ICSS_LRE_TRANSPARENT_RECEPTION		(ICSS_LRE_START + 108)
+#define ICSS_LRE_CNT_NODES			(ICSS_LRE_START + 52)
+
+/* SRAM */
+#define ICSS_LRE_IEC62439_CONST_DUPLICATE_ACCEPT		0x01
+#define ICSS_LRE_IEC62439_CONST_DUPLICATE_DISCARD		0x02
+#define ICSS_LRE_IEC62439_CONST_TRANSP_RECEPTION_REMOVE_RCT	0x01
+#define ICSS_LRE_IEC62439_CONST_TRANSP_RECEPTION_PASS_RCT	0x02
+
+/* Enable/disable interrupts for high/low priority instead of per port.
+ * 0 = disabled (default), 1 = enabled
+ */
+#define ICSS_LRE_PRIORITY_INTRS_STATUS_OFFSET	0x1FAA
+/* Enable/disable timestamping of packets. 0 = disabled (default) 1 = enabled */
+#define ICSS_LRE_TIMESTAMP_PKTS_STATUS_OFFSET	0x1FAB
+#define ICSS_LRE_TIMESTAMP_ARRAY_OFFSET		0xC200
+
+/* HOST_TIMER_CHECK_FLAGS bits */
+#define ICSS_LRE_HOST_TIMER_NODE_TABLE_CHECK_BIT	BIT(0)
+#define ICSS_LRE_HOST_TIMER_NODE_TABLE_CLEAR_BIT	BIT(4)
+#define ICSS_LRE_HOST_TIMER_HOST_TABLE_CHECK_BIT	BIT(8)
+#define ICSS_LRE_HOST_TIMER_P1_TABLE_CHECK_BIT		BIT(16)
+#define ICSS_LRE_HOST_TIMER_P2_TABLE_CHECK_BIT		BIT(24)
+#define ICSS_LRE_HOST_TIMER_PORT_TABLE_CHECK_BITS \
+			(ICSS_LRE_HOST_TIMER_P1_TABLE_CHECK_BIT | \
+			 ICSS_LRE_HOST_TIMER_P2_TABLE_CHECK_BIT)
+
+/* PRU1 DMEM */
+/* Node table offsets are different for AM3/4 vs AM57/K2G, set by firmware */
+#define ICSS_LRE_V1_0_HASH_MASK                 0x3F
+#define ICSS_LRE_V1_0_INDEX_ARRAY_NT            0x60
+#define ICSS_LRE_V1_0_BIN_ARRAY                 0x1A00
+#define ICSS_LRE_V1_0_NODE_TABLE_NEW            0x1FC0
+#define ICSS_LRE_V1_0_INDEX_ARRAY_LOC           PRUETH_MEM_DRAM0
+#define ICSS_LRE_V1_0_BIN_ARRAY_LOC             PRUETH_MEM_DRAM0
+#define ICSS_LRE_V1_0_NODE_TABLE_LOC            PRUETH_MEM_SHARED_RAM
+#define ICSS_LRE_V1_0_INDEX_TBL_MAX_ENTRIES     64
+#define ICSS_LRE_V1_0_BIN_TBL_MAX_ENTRIES       128
+#define ICSS_LRE_V1_0_NODE_TBL_MAX_ENTRIES      128
+
+#define ICSS_LRE_V2_1_HASH_MASK                 0xFF
+#define ICSS_LRE_V2_1_INDEX_ARRAY_NT            0x3000
+#define ICSS_LRE_V2_1_BIN_ARRAY \
+	(ICSS_LRE_V2_1_INDEX_ARRAY_NT + \
+	(ICSS_LRE_V2_1_INDEX_TBL_MAX_ENTRIES * 6))
+#define ICSS_LRE_V2_1_NODE_TABLE_NEW \
+	(ICSS_LRE_V2_1_BIN_ARRAY + \
+	(ICSS_LRE_V2_1_BIN_TBL_MAX_ENTRIES * 8))
+#define ICSS_LRE_V2_1_INDEX_ARRAY_LOC           PRUETH_MEM_SHARED_RAM
+#define ICSS_LRE_V2_1_BIN_ARRAY_LOC             PRUETH_MEM_SHARED_RAM
+#define ICSS_LRE_V2_1_NODE_TABLE_LOC            PRUETH_MEM_SHARED_RAM
+#define ICSS_LRE_V2_1_INDEX_TBL_MAX_ENTRIES     256
+#define ICSS_LRE_V2_1_BIN_TBL_MAX_ENTRIES       256
+#define ICSS_LRE_V2_1_NODE_TBL_MAX_ENTRIES      256
+
+#define ICSS_LRE_NODE_FREE			0x10
+#define ICSS_LRE_NODE_TAKEN			0x01
+#define ICSS_LRE_NT_REM_NODE_TYPE_MASK		0x1F
+#define ICSS_LRE_NT_REM_NODE_TYPE_SHIFT		0x00
+
+#define ICSS_LRE_NT_REM_NODE_TYPE_SANA		0x01
+#define ICSS_LRE_NT_REM_NODE_TYPE_SANB		0x02
+#define ICSS_LRE_NT_REM_NODE_TYPE_SANAB		0x03
+#define ICSS_LRE_NT_REM_NODE_TYPE_DAN		0x04
+#define ICSS_LRE_NT_REM_NODE_TYPE_REDBOX	0x08
+#define ICSS_LRE_NT_REM_NODE_TYPE_VDAN		0x10
+
+#define ICSS_LRE_NT_REM_NODE_HSR_BIT		0x20 /* if set node is HSR */
+
+#define ICSS_LRE_NT_REM_NODE_DUP_MASK		0xC0
+#define ICSS_LRE_NT_REM_NODE_DUP_SHIFT		0x06
+
+/* Node entry duplicate type: DupAccept */
+#define ICSS_LRE_NT_REM_NODE_DUP_ACCEPT		0x40
+/* Node entry duplicate type: DupDiscard */
+#define ICSS_LRE_NT_REM_NODE_DUP_DISCARD	0x80
+
+#endif /* __ICSS_LRE_FIRMWARE_H */
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 1aadef061e92..4f631dcc4d50 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -30,6 +30,7 @@
 
 #include "icssm_prueth.h"
 #include "icssm_prueth_switch.h"
+#include "icssm_prueth_lre.h"
 #include "icssm_vlan_mcast_filter_mmap.h"
 #include "../icssg/icssg_mii_rt.h"
 #include "../icssg/icss_iep.h"
@@ -40,6 +41,29 @@
 #define TX_CLK_DELAY_100M	0x6
 #define HR_TIMER_TX_DELAY_US	100
 
+#define NETIF_PRUETH_LRE_OFFLOAD_FEATURES       (NETIF_F_HW_HSR_FWD | \
+						 NETIF_F_HW_HSR_TAG_RM)
+
+static void icssm_prueth_set_fw_offsets(struct prueth *prueth)
+{
+	/* Set Multicast filter control and table offsets */
+	if (PRUETH_IS_EMAC(prueth) || PRUETH_IS_SWITCH(prueth)) {
+		prueth->fw_offsets.mc_ctrl_offset  =
+			ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET;
+		prueth->fw_offsets.mc_filter_mask =
+			ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OFFSET;
+		prueth->fw_offsets.mc_filter_tbl =
+			ICSS_EMAC_FW_MULTICAST_FILTER_TABLE;
+	} else {
+		prueth->fw_offsets.mc_ctrl_offset  =
+			ICSS_LRE_FW_MULTICAST_TABLE_SEARCH_OP_CONTROL_BIT;
+		prueth->fw_offsets.mc_filter_mask =
+			ICSS_LRE_FW_MULTICAST_FILTER_MASK;
+		prueth->fw_offsets.mc_filter_tbl =
+			ICSS_LRE_FW_MULTICAST_FILTER_TABLE;
+	}
+}
+
 static void icssm_prueth_write_reg(struct prueth *prueth,
 				   enum prueth_mem region,
 				   unsigned int reg, u32 val)
@@ -309,12 +333,15 @@ static void icssm_prueth_hostinit(struct prueth *prueth)
 	icssm_prueth_mii_init(prueth);
 }
 
-/* This function initialize the driver in EMAC mode
+/* Initialize the driver in EMAC, HSR or PRP mode
  * based on eth_type
  */
 static void icssm_prueth_init_ethernet_mode(struct prueth *prueth)
 {
+	icssm_prueth_set_fw_offsets(prueth);
 	icssm_prueth_hostinit(prueth);
+	if (prueth_is_lre(prueth))
+		icssm_prueth_lre_config(prueth);
 }
 
 static void icssm_prueth_port_enable(struct prueth_emac *emac, bool enable)
@@ -609,6 +636,9 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
        /* update first buffer descriptor */
 	wr_buf_desc = (pktlen << PRUETH_BD_LENGTH_SHIFT) &
 		       PRUETH_BD_LENGTH_MASK;
+	if (PRUETH_IS_HSR(prueth))
+		wr_buf_desc |= BIT(PRUETH_BD_HSR_FRAME_SHIFT);
+
 	sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
 	if (!PRUETH_IS_EMAC(prueth))
 		writel(wr_buf_desc, sram + readw(&queue_desc->wr_ptr));
@@ -627,6 +657,12 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 void icssm_parse_packet_info(struct prueth *prueth, u32 buffer_descriptor,
 			     struct prueth_packet_info *pkt_info)
 {
+	if (prueth_is_lre(prueth))
+		pkt_info->start_offset = !!(buffer_descriptor &
+					    PRUETH_BD_START_FLAG_MASK);
+	else
+		pkt_info->start_offset = false;
+
 	pkt_info->port = (buffer_descriptor & PRUETH_BD_PORT_MASK) >>
 			 PRUETH_BD_PORT_SHIFT;
 	pkt_info->length = (buffer_descriptor & PRUETH_BD_LENGTH_MASK) >>
@@ -661,10 +697,14 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 	unsigned int actual_pkt_len;
 	bool buffer_wrapped = false;
 	void *src_addr, *dst_addr;
+	u16 start_offset = 0;
 	struct sk_buff *skb;
 	int pkt_block_size;
 	void *ocmc_ram;
 
+	if (PRUETH_IS_HSR(emac->prueth))
+		start_offset = (pkt_info->start_offset ?
+				ICSSM_LRE_TAG_SIZE : 0);
 	/* the PRU firmware deals mostly in pointers already
 	 * offset into ram, we would like to deal in indexes
 	 * within the queue we are working with for code
@@ -687,7 +727,8 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 	/* calculate new pointer in ram */
 	*bd_rd_ptr = rxqueue->buffer_desc_offset + (update_block * BD_SIZE);
 
-	actual_pkt_len = pkt_info->length;
+	/* Exclude the HSR tag bytes already stripped by firmware, if any. */
+	actual_pkt_len = pkt_info->length - start_offset;
 
 	/* Allocate a socket buffer for this packet */
 	skb = netdev_alloc_skb_ip_align(ndev, actual_pkt_len);
@@ -707,6 +748,7 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 	 */
 	src_addr = ocmc_ram + rxqueue->buffer_offset +
 		   (read_block * ICSS_BLOCK_SIZE);
+	src_addr += start_offset;
 
 	/* Copy the data from PRU buffers(OCMC) to socket buffer(DRAM) */
 	if (buffer_wrapped) { /* wrapped around buffer */
@@ -720,6 +762,9 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 		if (pkt_info->length < bytes)
 			bytes = pkt_info->length;
 
+		/* If applicable, account for the HSR tag removed */
+		bytes -= start_offset;
+
 		/* copy non-wrapped part */
 		memcpy(dst_addr, src_addr, bytes);
 
@@ -741,6 +786,12 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 			icssm_prueth_sw_learn_fdb(emac, skb->data + ETH_ALEN);
 	}
 
+	/* For PRP, the RCT trailer is at the frame tail, exclude it from
+	 * the length to avoid passing it up the stack.
+	 */
+	if (PRUETH_IS_PRP(emac->prueth) && pkt_info->start_offset)
+		actual_pkt_len -= ICSSM_LRE_TAG_SIZE;
+
 	skb_put(skb, actual_pkt_len);
 
 	/* send packet up the stack */
@@ -804,13 +855,12 @@ static int icssm_emac_rx_packets(struct prueth_emac *emac, int budget)
 			rd_buf_desc = readl(shared_ram + bd_rd_ptr);
 			icssm_parse_packet_info(prueth, rd_buf_desc, &pkt_info);
 
-			if (pkt_info.length <= 0) {
-				/* a packet length of zero will cause us to
-				 * never move the read pointer ahead, locking
-				 * the driver, so we manually have to move it
-				 * to the write pointer, discarding all
-				 * remaining packets in this queue. This should
-				 * never happen.
+			if (pkt_info.length < EMAC_MIN_PKTLEN) {
+				/* if the packet is too small we skip it but we
+				 * still need to move the read pointer ahead
+				 * and assume something is wrong with the read
+				 * pointer as the firmware should be filtering
+				 * these packets
 				 */
 				update_rd_ptr = bd_wr_ptr;
 				emac->stats.rx_length_errors++;
@@ -982,14 +1032,20 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 		icssm_prueth_init_ethernet_mode(prueth);
 
 	/* reset and start PRU firmware */
-	if (PRUETH_IS_SWITCH(prueth)) {
+	if (!PRUETH_IS_EMAC(prueth)) {
+		/* Switch, HSR and PRP protocols share same queue structure */
 		ret = icssm_prueth_sw_emac_config(emac);
 		if (ret)
-			return ret;
+			goto free_hrtimer;
 
-		ret = icssm_prueth_sw_init_fdb_table(prueth);
-		if (ret)
-			return ret;
+		if (PRUETH_IS_SWITCH(prueth)) {
+			ret = icssm_prueth_sw_init_fdb_table(prueth);
+			if (ret)
+				goto free_hrtimer;
+		} else {
+			/* LRE mode: set up duplicate-table check flags */
+			icssm_prueth_lre_config_check_flags(prueth);
+		}
 	} else {
 		icssm_prueth_emac_config(emac);
 	}
@@ -1046,6 +1102,9 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 		icss_iep_exit(prueth->iep);
 free_mem:
 	icssm_prueth_free_memory(emac->prueth);
+free_hrtimer:
+	if (prueth_is_lre(prueth) && !prueth->emac_configured)
+		icssm_prueth_lre_cleanup(prueth);
 	return ret;
 }
 
@@ -1079,6 +1138,9 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
 	else
 		rproc_shutdown(emac->pru);
 
+	if (prueth_is_lre(prueth) && !prueth->emac_configured)
+		icssm_prueth_lre_cleanup(prueth);
+
 	/* free rx interrupts */
 	free_irq(emac->rx_irq, ndev);
 
@@ -1122,7 +1184,8 @@ static int icssm_prueth_change_mode(struct prueth *prueth,
 		}
 	}
 
-	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH) {
+	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH ||
+	    mode == PRUSS_ETHTYPE_HSR || mode == PRUSS_ETHTYPE_PRP) {
 		prueth->eth_type = mode;
 	} else {
 		dev_err(prueth->dev, "unknown mode\n");
@@ -1266,11 +1329,16 @@ static void icssm_emac_mc_filter_ctrl(struct prueth_emac *emac, bool enable)
 {
 	struct prueth *prueth = emac->prueth;
 	void __iomem *mc_filter_ctrl;
+	u32 mc_ctrl_offset;
 	void __iomem *ram;
 	u32 reg;
 
 	ram = prueth->mem[emac->dram].va;
-	mc_filter_ctrl = ram + ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET;
+	if (prueth_is_lre(prueth))
+		ram = prueth->mem[PRUETH_MEM_DRAM1].va;
+
+	mc_ctrl_offset = prueth->fw_offsets.mc_ctrl_offset;
+	mc_filter_ctrl = ram + mc_ctrl_offset;
 
 	if (enable)
 		reg = ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_ENABLED;
@@ -1289,7 +1357,10 @@ static void icssm_emac_mc_filter_reset(struct prueth_emac *emac)
 	void __iomem *ram;
 
 	ram = prueth->mem[emac->dram].va;
-	mc_filter_tbl_base = ICSS_EMAC_FW_MULTICAST_FILTER_TABLE;
+	if (prueth_is_lre(prueth))
+		ram = prueth->mem[PRUETH_MEM_DRAM1].va;
+
+	mc_filter_tbl_base = prueth->fw_offsets.mc_filter_tbl;
 
 	mc_filter_tbl = ram + mc_filter_tbl_base;
 	memset_io(mc_filter_tbl, 0, ICSS_EMAC_FW_MULTICAST_TABLE_SIZE_BYTES);
@@ -1302,11 +1373,16 @@ static void icssm_emac_mc_filter_hashmask
 {
 	struct prueth *prueth = emac->prueth;
 	void __iomem *mc_filter_mask;
+	u32 mc_filter_mask_base;
 	void __iomem *ram;
 
 	ram = prueth->mem[emac->dram].va;
+	if (prueth_is_lre(prueth))
+		ram = prueth->mem[PRUETH_MEM_DRAM1].va;
+
+	mc_filter_mask_base = prueth->fw_offsets.mc_filter_mask;
 
-	mc_filter_mask = ram + ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OFFSET;
+	mc_filter_mask = ram + mc_filter_mask_base;
 	memcpy_toio(mc_filter_mask, mask,
 		    ICSS_EMAC_FW_MULTICAST_FILTER_MASK_SIZE_BYTES);
 }
@@ -1316,11 +1392,16 @@ static void icssm_emac_mc_filter_bin_update(struct prueth_emac *emac, u8 hash,
 {
 	struct prueth *prueth = emac->prueth;
 	void __iomem *mc_filter_tbl;
+	u32 mc_filter_tbl_base;
 	void __iomem *ram;
 
 	ram = prueth->mem[emac->dram].va;
+	if (prueth_is_lre(prueth))
+		ram = prueth->mem[PRUETH_MEM_DRAM1].va;
+
+	mc_filter_tbl_base = prueth->fw_offsets.mc_filter_tbl;
 
-	mc_filter_tbl = ram + ICSS_EMAC_FW_MULTICAST_FILTER_TABLE;
+	mc_filter_tbl = ram + mc_filter_tbl_base;
 	writeb(val, mc_filter_tbl + hash);
 }
 
@@ -1360,6 +1441,8 @@ static void icssm_emac_ndo_set_rx_mode(struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 	bool promisc = ndev->flags & IFF_PROMISC;
+	/* Spinlock for multicast filter table */
+	spinlock_t *mc_filter_tbl_lock;
 	struct netdev_hw_addr *ha;
 	struct prueth *prueth;
 	unsigned long flags;
@@ -1371,8 +1454,18 @@ static void icssm_emac_ndo_set_rx_mode(struct net_device *ndev)
 	sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
 	reg = readl(sram + EMAC_PROMISCUOUS_MODE_OFFSET);
 
+	/* In LRE mode, the HSR core syncs the master's multicast list and
+	 * IFF_ALLMULTI to both slaves. Settings applied to a single slave are
+	 * not merged into the shared filter, so configure them on the HSR
+	 * master instead.
+	 */
+	if (prueth_is_lre(prueth))
+		mc_filter_tbl_lock = &prueth->addr_lock;
+	else
+		mc_filter_tbl_lock = &emac->addr_lock;
+
 	/* It is a shared table. So lock the access */
-	spin_lock_irqsave(&emac->addr_lock, flags);
+	spin_lock_irqsave(mc_filter_tbl_lock, flags);
 
 	/* Disable and reset multicast filter, allows allmulti */
 	icssm_emac_mc_filter_ctrl(emac, false);
@@ -1429,15 +1522,126 @@ static void icssm_emac_ndo_set_rx_mode(struct net_device *ndev)
 	}
 
 unlock:
-	spin_unlock_irqrestore(&emac->addr_lock, flags);
+	spin_unlock_irqrestore(mc_filter_tbl_lock, flags);
+}
+
+static netdev_features_t icssm_emac_ndo_fix_features(struct net_device *ndev,
+						     netdev_features_t features)
+{
+	/* hsr tag removal offload and hsr fwd offload are tightly coupled in
+	 * firmware implementation. Both these features need to be enabled /
+	 * disabled together.
+	 */
+	if (!(ndev->features & NETIF_PRUETH_LRE_OFFLOAD_FEATURES)) {
+		if ((features & NETIF_F_HW_HSR_FWD) ||
+		    (features & NETIF_F_HW_HSR_TAG_RM)) {
+			features |= NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
+			ndev->wanted_features |=
+				NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
+		}
+	}
+
+	if ((ndev->features & NETIF_F_HW_HSR_FWD) ||
+	    (ndev->features & NETIF_F_HW_HSR_TAG_RM)) {
+		if (!(features & NETIF_F_HW_HSR_FWD) ||
+		    !(features & NETIF_F_HW_HSR_TAG_RM)) {
+			features &= ~NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
+			ndev->wanted_features &=
+				~NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
+		}
+	}
+
+	return features;
+}
+
+/**
+ * icssm_emac_ndo_set_features - Configure HSR/PRP offload features
+ * @ndev: network device
+ * @features: Requested feature set
+ *
+ * Called by ethtool -K to configure HSR/PRP offload features. The request
+ * is rejected if this interface or its paired interface is running.
+ *
+ * Return: 0 on success, -EINVAL or -EBUSY on error.
+ */
+static int icssm_emac_ndo_set_features(struct net_device *ndev,
+				       netdev_features_t features)
+{
+	struct prueth_emac *emac, *other_emac;
+	netdev_features_t have, wanted;
+	struct net_device *upper;
+	struct prueth *prueth;
+	bool change_request;
+	int ret = -EBUSY;
+
+	emac = netdev_priv(ndev);
+	prueth = emac->prueth;
+	/* MAC instance index starts from 0. So index by port_id - 1 */
+	other_emac = emac->prueth->emac[(emac->port_id == PRUETH_PORT_MII0) ?
+				PRUETH_PORT_MII1 - 1 : PRUETH_PORT_MII0 - 1];
+	wanted = features & NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
+	have = ndev->features & NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
+	change_request = ((wanted ^ have) != 0);
+
+	if (!prueth->fw_data->support_lre)
+		return 0;
+
+	if (PRUETH_IS_SWITCH(prueth) && change_request) {
+		/* LRE offload cannot be enabled in switch mode, remove the
+		 * bridge first to revert to EMAC mode.
+		 */
+		netdev_err(ndev,
+			   "Switch to HSR/PRP not allowed\n");
+		ret = -EINVAL;
+		goto err_set_features;
+	}
+
+	upper = netdev_master_upper_dev_get(ndev);
+	if (upper && is_hsr_master(upper) && change_request) {
+		/* Firmware mode is switched to HSR/PRP based on the offload
+		 * features set at the time this port joins the hsr device, so
+		 * changing the features afterwards would desync ndev->features
+		 * from the firmware mode without the hsr core noticing.
+		 * Require unlinking from the hsr device first.
+		 */
+		netdev_err(ndev,
+			   "Can't change offload features while port is an HSR/PRP slave\n");
+		ret = -EBUSY;
+		goto err_set_features;
+	}
+
+	if (netif_running(ndev) && change_request) {
+		netdev_err(ndev,
+			   "Can't change feature when device runs\n");
+		goto err_set_features;
+	}
+
+	if (other_emac && netif_running(other_emac->ndev) && change_request) {
+		netdev_err(ndev,
+			   "Can't change feature when other device runs\n");
+		goto err_set_features;
+	}
+
+	return 0;
+
+err_set_features:
+	/* Restore the LRE bits in wanted_features to the current state */
+	ndev->wanted_features &= ~NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
+	ndev->wanted_features |= have;
+
+	return ret;
 }
 
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = icssm_emac_ndo_open,
 	.ndo_stop = icssm_emac_ndo_stop,
 	.ndo_start_xmit = icssm_emac_ndo_start_xmit,
+	.ndo_set_mac_address = eth_mac_addr,
+	.ndo_validate_addr = eth_validate_addr,
 	.ndo_get_stats64 = icssm_emac_ndo_get_stats64,
 	.ndo_set_rx_mode = icssm_emac_ndo_set_rx_mode,
+	.ndo_set_features = icssm_emac_ndo_set_features,
+	.ndo_fix_features = icssm_emac_ndo_fix_features,
 };
 
 /* get emac_port corresponding to eth_node name */
@@ -1591,6 +1795,9 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 		ndev->hw_features |= NETIF_F_HW_L2FW_DOFFLOAD;
 	}
 
+	if (prueth->support_lre)
+		ndev->hw_features |= NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
+
 	ndev->dev.of_node = eth_node;
 
 	netif_napi_add(ndev, &emac->napi, icssm_emac_napi_poll);
@@ -1742,6 +1949,111 @@ static int icssm_prueth_ndev_port_unlink(struct net_device *ndev)
 	return ret;
 }
 
+static int icssm_prueth_hsr_port_link(struct net_device *ndev,
+				      struct net_device *hsr_ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev), *other_emac;
+	struct prueth *prueth = emac->prueth;
+	enum pruss_ethtype mode;
+	enum hsr_version ver;
+	unsigned long flags;
+	u8 all_slaves;
+	int ret = 0;
+
+	if (PRUETH_IS_SWITCH(prueth))
+		return -EOPNOTSUPP;
+
+	hsr_get_version(hsr_ndev, &ver);
+
+	if (ver == HSR_V1)
+		mode = PRUSS_ETHTYPE_HSR;
+	else if (ver == PRP_V1)
+		mode = PRUSS_ETHTYPE_PRP;
+	else
+		return -EOPNOTSUPP;
+
+	all_slaves = BIT(PRUETH_PORT_MII0) | BIT(PRUETH_PORT_MII1);
+	other_emac = emac->prueth->emac[(emac->port_id == PRUETH_PORT_MII0) ?
+				PRUETH_PORT_MII1 - 1 : PRUETH_PORT_MII0 - 1];
+
+	/* Reject HSR/PRP offload if the peer port does not have the offload
+	 * features enabled.
+	 */
+	if (other_emac &&
+	    !(other_emac->ndev->features & NETIF_PRUETH_LRE_OFFLOAD_FEATURES))
+		return -EOPNOTSUPP;
+
+	spin_lock_irqsave(&prueth->addr_lock, flags);
+
+	if (!prueth->hsr_members) {
+		prueth->hsr_dev = hsr_ndev;
+	} else {
+		/* Adding the port to a second master is not supported */
+		if (prueth->hsr_dev != hsr_ndev) {
+			spin_unlock_irqrestore(&prueth->addr_lock, flags);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	prueth->hsr_members |= BIT(emac->port_id);
+
+	spin_unlock_irqrestore(&prueth->addr_lock, flags);
+
+	if (!prueth_is_lre(prueth) && prueth->hsr_members == all_slaves) {
+		ret = icssm_prueth_change_mode(prueth, mode);
+		if (ret < 0) {
+			dev_err(prueth->dev, "Failed to enable %s mode\n",
+				(mode == PRUSS_ETHTYPE_HSR) ?
+				"HSR" : "PRP");
+			goto free_hsr;
+		} else {
+			dev_info(prueth->dev,
+				 "TI PRU ethernet now in %s mode\n",
+				 (mode == PRUSS_ETHTYPE_HSR) ?
+				 "HSR" : "PRP");
+		}
+	}
+
+	return 0;
+
+free_hsr:
+	spin_lock_irqsave(&prueth->addr_lock, flags);
+
+	prueth->hsr_members &= ~BIT(emac->port_id);
+
+	spin_unlock_irqrestore(&prueth->addr_lock, flags);
+	return ret;
+}
+
+static int icssm_prueth_hsr_port_unlink(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&prueth->addr_lock, flags);
+
+	prueth->hsr_members &= ~BIT(emac->port_id);
+
+	spin_unlock_irqrestore(&prueth->addr_lock, flags);
+
+	if (prueth_is_lre(prueth) && !prueth->hsr_members) {
+		ret = icssm_prueth_change_mode(prueth, PRUSS_ETHTYPE_EMAC);
+		if (ret < 0)
+			dev_err(prueth->dev, "Failed to enable dual EMAC mode\n");
+	}
+
+	spin_lock_irqsave(&prueth->addr_lock, flags);
+
+	if (!prueth->hsr_members)
+		prueth->hsr_dev = NULL;
+
+	spin_unlock_irqrestore(&prueth->addr_lock, flags);
+
+	return ret;
+}
+
 static int icssm_prueth_ndev_event(struct notifier_block *unused,
 				   unsigned long event, void *ptr)
 {
@@ -1749,13 +2061,27 @@ static int icssm_prueth_ndev_event(struct notifier_block *unused,
 	struct netdev_notifier_changeupper_info *info;
 	int ret = NOTIFY_DONE;
 
-	if (!icssm_prueth_sw_port_dev_check(ndev))
+	if (ndev->netdev_ops != &emac_netdev_ops)
 		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_CHANGEUPPER:
 		info = ptr;
+		if (is_hsr_master(info->upper_dev)) {
+			if (info->linking) {
+				if (ndev->features &
+				    NETIF_PRUETH_LRE_OFFLOAD_FEATURES)
+					ret = icssm_prueth_hsr_port_link
+						(ndev, info->upper_dev);
+			} else {
+				ret = icssm_prueth_hsr_port_unlink(ndev);
+			}
+		}
+
 		if (netif_is_bridge_master(info->upper_dev)) {
+			if (!icssm_prueth_sw_port_dev_check(ndev))
+				return NOTIFY_DONE;
+
 			if (info->linking)
 				ret = icssm_prueth_ndev_port_link
 					(ndev, info->upper_dev);
@@ -1797,6 +2123,7 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np;
 	struct prueth *prueth;
+	bool has_lre = false;
 	struct pruss *pruss;
 	int i, ret;
 
@@ -1811,6 +2138,7 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, prueth);
 	prueth->dev = dev;
 	prueth->fw_data = device_get_match_data(dev);
+	icssm_prueth_set_fw_offsets(prueth);
 
 	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
 	if (!eth_ports_node)
@@ -1956,6 +2284,17 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 		prueth->mem[PRUETH_MEM_OCMC].va,
 		prueth->mem[PRUETH_MEM_OCMC].size);
 
+	if (IS_ENABLED(CONFIG_HSR) && prueth->fw_data->support_lre)
+		has_lre = true;
+
+	/* LRE requires both ethernet nodes to be present in
+	 * DT, otherwise clear the support flag
+	 */
+	if (has_lre && (!eth0_node || !eth1_node))
+		has_lre = false;
+
+	prueth->support_lre = has_lre;
+	spin_lock_init(&prueth->addr_lock);
 	/* setup netdev interfaces */
 	if (eth0_node) {
 		ret = icssm_prueth_netdev_init(prueth, eth0_node);
@@ -2177,15 +2516,24 @@ static struct prueth_private_data am335x_prueth_pdata = {
 	.fw_pru[PRUSS_PRU0] = {
 		.fw_name[PRUSS_ETHTYPE_EMAC] =
 			"ti-pruss/am335x-pru0-prueth-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_HSR] =
+			"ti-pruss/am335x-pru0-pruhsr-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_PRP] =
+			"ti-pruss/am335x-pru0-pruprp-fw.elf",
 		.fw_name[PRUSS_ETHTYPE_SWITCH] =
 			"ti-pruss/am335x-pru0-prusw-fw.elf",
 	},
 	.fw_pru[PRUSS_PRU1] = {
 		.fw_name[PRUSS_ETHTYPE_EMAC] =
 			"ti-pruss/am335x-pru1-prueth-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_HSR] =
+			"ti-pruss/am335x-pru1-pruhsr-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_PRP] =
+			"ti-pruss/am335x-pru1-pruprp-fw.elf",
 		.fw_name[PRUSS_ETHTYPE_SWITCH] =
 			"ti-pruss/am335x-pru1-prusw-fw.elf",
 	},
+	.support_lre = true,
 	.support_switch = true,
 };
 
@@ -2195,15 +2543,24 @@ static struct prueth_private_data am437x_prueth_pdata = {
 	.fw_pru[PRUSS_PRU0] = {
 		.fw_name[PRUSS_ETHTYPE_EMAC] =
 			"ti-pruss/am437x-pru0-prueth-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_HSR] =
+			"ti-pruss/am437x-pru0-pruhsr-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_PRP] =
+			"ti-pruss/am437x-pru0-pruprp-fw.elf",
 		.fw_name[PRUSS_ETHTYPE_SWITCH] =
 			"ti-pruss/am437x-pru0-prusw-fw.elf",
 	},
 	.fw_pru[PRUSS_PRU1] = {
 		.fw_name[PRUSS_ETHTYPE_EMAC] =
 			"ti-pruss/am437x-pru1-prueth-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_HSR] =
+			"ti-pruss/am437x-pru1-pruhsr-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_PRP] =
+			"ti-pruss/am437x-pru1-pruprp-fw.elf",
 		.fw_name[PRUSS_ETHTYPE_SWITCH] =
 			"ti-pruss/am437x-pru1-prusw-fw.elf",
 	},
+	.support_lre = true,
 	.support_switch = true,
 };
 
@@ -2213,16 +2570,25 @@ static struct prueth_private_data am57xx_prueth_pdata = {
 	.fw_pru[PRUSS_PRU0] = {
 		.fw_name[PRUSS_ETHTYPE_EMAC] =
 			"ti-pruss/am57xx-pru0-prueth-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_HSR] =
+			"ti-pruss/am57xx-pru0-pruhsr-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_PRP] =
+			"ti-pruss/am57xx-pru0-pruprp-fw.elf",
 	.fw_name[PRUSS_ETHTYPE_SWITCH] =
 			"ti-pruss/am57xx-pru0-prusw-fw.elf",
 	},
 	.fw_pru[PRUSS_PRU1] = {
 		.fw_name[PRUSS_ETHTYPE_EMAC] =
 			"ti-pruss/am57xx-pru1-prueth-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_HSR] =
+			"ti-pruss/am57xx-pru1-pruhsr-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_PRP] =
+			"ti-pruss/am57xx-pru1-pruprp-fw.elf",
 		.fw_name[PRUSS_ETHTYPE_SWITCH] =
 			"ti-pruss/am57xx-pru1-prusw-fw.elf",
 
 	},
+	.support_lre = true,
 	.support_switch = true,
 };
 
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
index d5b49b462c24..a5d5bcd08bcd 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
@@ -16,13 +16,17 @@
 #include "icssm_switch.h"
 #include "icssm_prueth_ptp.h"
 #include "icssm_prueth_fdb_tbl.h"
+#include "icssm_lre_firmware.h"
 
 /* ICSSM size of redundancy tag */
 #define ICSSM_LRE_TAG_SIZE	6
 
+#define PRUETH_TIMER_MS (10)
+
 /* PRUSS local memory map */
 #define ICSS_LOCAL_SHARED_RAM	0x00010000
 #define EMAC_MAX_PKTLEN		(ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
+#define EMAC_MIN_PKTLEN		ETH_ZLEN
 /* Below macro is for 1528 Byte Frame support, to Allow even with
  * Redundancy tag
  */
@@ -42,6 +46,8 @@ enum pruss_ethtype {
 
 #define PRUETH_IS_EMAC(p)	((p)->eth_type == PRUSS_ETHTYPE_EMAC)
 #define PRUETH_IS_SWITCH(p)	((p)->eth_type == PRUSS_ETHTYPE_SWITCH)
+#define PRUETH_IS_HSR(p)	((p)->eth_type == PRUSS_ETHTYPE_HSR)
+#define PRUETH_IS_PRP(p)	((p)->eth_type == PRUSS_ETHTYPE_PRP)
 
 /**
  * struct prueth_queue_desc - Queue descriptor
@@ -86,6 +92,7 @@ struct prueth_queue_info {
 
 /**
  * struct prueth_packet_info - Info about a packet in buffer
+ * @start_offset: true if frame carries an HSR/PRP start offset
  * @shadow: this packet is stored in the collision queue
  * @port: port packet is on
  * @length: length of packet
@@ -96,6 +103,7 @@ struct prueth_queue_info {
  * @timestamp: Specifies if timestamp is appended to the packet
  */
 struct prueth_packet_info {
+	bool start_offset;
 	bool shadow;
 	unsigned int port;
 	unsigned int length;
@@ -171,6 +179,13 @@ enum prueth_mem {
 	PRUETH_MEM_MAX,
 };
 
+/* Firmware offsets/size information */
+struct prueth_fw_offsets {
+	u32 mc_ctrl_offset;
+	u32 mc_filter_mask;
+	u32 mc_filter_tbl;
+};
+
 enum pruss_device {
 	PRUSS_AM57XX = 0,
 	PRUSS_AM43XX,
@@ -183,11 +198,13 @@ enum pruss_device {
  * @driver_data: PRU Ethernet device name
  * @fw_pru: firmware names to be used for PRUSS ethernet usecases
  * @support_switch: boolean to indicate if switch is enabled
+ * @support_lre: boolean to indicate if LRE is enabled
  */
 struct prueth_private_data {
 	enum pruss_device driver_data;
 	const struct prueth_firmware fw_pru[PRUSS_NUM_PRUS];
 	bool support_switch;
+	bool support_lre;
 };
 
 struct prueth_emac_stats {
@@ -248,13 +265,20 @@ struct prueth {
 	struct icss_iep *iep;
 
 	const struct prueth_private_data *fw_data;
-	struct prueth_fw_offsets *fw_offsets;
+	struct prueth_fw_offsets fw_offsets;
 
 	struct device_node *eth_node[PRUETH_NUM_MACS];
 	struct prueth_emac *emac[PRUETH_NUM_MACS];
 	struct net_device *registered_netdevs[PRUETH_NUM_MACS];
 
+	bool support_lre;
+	unsigned int tbl_check_mask;
+	struct hrtimer tbl_check_timer;
+	/* serialize access to LRE VLAN/MC filter table */
+	spinlock_t addr_lock;
+
 	struct net_device *hw_bridge_dev;
+	struct net_device *hsr_dev;
 	struct fdb_tbl *fdb_tbl;
 
 	struct notifier_block prueth_netdevice_nb;
@@ -264,6 +288,7 @@ struct prueth {
 	unsigned int eth_type;
 	size_t ocmc_ram_size;
 	u8 emac_configured;
+	u8 hsr_members;
 	u8 br_members;
 };
 
@@ -277,4 +302,9 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 void icssm_emac_mc_filter_bin_allow(struct prueth_emac *emac, u8 hash);
 void icssm_emac_mc_filter_bin_disallow(struct prueth_emac *emac, u8 hash);
 u8 icssm_emac_get_mc_hash(u8 *mac, u8 *mask);
+
+static inline bool prueth_is_lre(struct prueth *prueth)
+{
+	return PRUETH_IS_HSR(prueth) || PRUETH_IS_PRP(prueth);
+}
 #endif /* __NET_TI_PRUETH_H */
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
new file mode 100644
index 000000000000..9e84244e0649
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Texas Instruments PRUETH hsr/prp Link Redundancy Entity (LRE) Driver.
+ *
+ * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include "icssm_lre_firmware.h"
+#include "icssm_prueth_lre.h"
+#include "icssm_prueth.h"
+#include "icssm_prueth_switch.h"
+
+void icssm_prueth_lre_config_check_flags(struct prueth *prueth)
+{
+	void __iomem *dram1 = prueth->mem[PRUETH_MEM_DRAM1].va;
+
+	/* HSR/PRP: initialize check table when first port is up */
+	if (prueth->emac_configured)
+		return;
+
+	prueth->tbl_check_mask = ICSS_LRE_HOST_TIMER_HOST_TABLE_CHECK_BIT;
+	if (PRUETH_IS_HSR(prueth))
+		prueth->tbl_check_mask |=
+			ICSS_LRE_HOST_TIMER_PORT_TABLE_CHECK_BITS;
+	writel(prueth->tbl_check_mask, dram1 + ICSS_LRE_HOST_TIMER_CHECK_FLAGS);
+}
+
+/* A group of PCPs are mapped to a Queue. This is the size of firmware
+ * array in shared memory
+ */
+#define PCP_GROUP_TO_QUEUE_MAP_SIZE	4
+
+/* PRU firmware default PCP to priority Queue map for ingress & egress
+ *
+ * At ingress to Host
+ * ==================
+ * byte 0 => PRU 1, PCP 0-3 => Q3
+ * byte 1 => PRU 1, PCP 4-7 => Q2
+ * byte 2 => PRU 0, PCP 0-3 => Q1
+ * byte 3 => PRU 0, PCP 4-7 => Q0
+ *
+ * At egress to wire/network on PRU-0 and PRU-1
+ * ============================================
+ * byte 0 => Host, PCP 0-3 => Q3
+ * byte 1 => Host, PCP 4-7 => Q2
+ *
+ * PRU-0
+ * -----
+ * byte 2 => PRU-1, PCP 0-3 => Q1
+ * byte 3 => PRU-1, PCP 4-7 => Q0
+ *
+ * PRU-1
+ * -----
+ * byte 2 => PRU-0, PCP 0-3 => Q1
+ * byte 3 => PRU-0, PCP 4-7 => Q0
+ *
+ * queue names below are named 1 based. i.e PRUETH_QUEUE1 is Q0,
+ * PRUETH_QUEUE2 is Q1 and so forth. Firmware convention is that
+ * a lower queue number has higher priority than a higher queue
+ * number.
+ */
+static u8 fw_pcp_default_priority_queue_map[PCP_GROUP_TO_QUEUE_MAP_SIZE] = {
+	/* port 2 or PRU 1 */
+	PRUETH_QUEUE4, PRUETH_QUEUE3,
+	/* port 1 or PRU 0 */
+	PRUETH_QUEUE2, PRUETH_QUEUE1,
+};
+
+static void icssm_prueth_lre_pcp_queue_map_config(struct prueth *prueth)
+{
+	void __iomem *sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+
+	memcpy_toio(sram + ICSS_LRE_QUEUE_2_PCP_MAP_OFFSET,
+		    &fw_pcp_default_priority_queue_map[0],
+		    PCP_GROUP_TO_QUEUE_MAP_SIZE);
+}
+
+static void icssm_prueth_lre_host_table_init(struct prueth *prueth)
+{
+	void __iomem *dram0 = prueth->mem[PRUETH_MEM_DRAM0].va;
+	void __iomem *dram1 = prueth->mem[PRUETH_MEM_DRAM1].va;
+
+	memset_io(dram0 + ICSS_LRE_DUPLICATE_HOST_TABLE, 0,
+		  ICSS_LRE_DUPLICATE_HOST_TABLE_DMEM_SIZE);
+
+	writel(ICSS_LRE_DUPLICATE_HOST_TABLE_SIZE_INIT,
+	       dram1 + ICSS_LRE_DUPLICATE_HOST_TABLE_SIZE);
+
+	writel(ICSS_LRE_TABLE_CHECK_RESOLUTION_10_MS,
+	       dram1 + ICSS_LRE_DUPLI_HOST_CHECK_RESO);
+
+	writel(ICSS_LRE_MASTER_SLAVE_BUSY_BITS_CLEAR,
+	       dram1 + ICSS_LRE_HOST_DUPLICATE_ARBITRATION);
+}
+
+static void icssm_prueth_lre_port_table_init(struct prueth *prueth)
+{
+	void __iomem *dram1 = prueth->mem[PRUETH_MEM_DRAM1].va;
+
+	if (PRUETH_IS_HSR(prueth)) {
+		memset_io(dram1 + ICSS_LRE_DUPLICATE_PORT_TABLE_PRU0, 0,
+			  ICSS_LRE_DUPLICATE_PORT_TABLE_DMEM_SIZE);
+		memset_io(dram1 + ICSS_LRE_DUPLICATE_PORT_TABLE_PRU1, 0,
+			  ICSS_LRE_DUPLICATE_PORT_TABLE_DMEM_SIZE);
+
+		writel(ICSS_LRE_DUPLICATE_PORT_TABLE_SIZE_INIT,
+		       dram1 + ICSS_LRE_DUPLICATE_PORT_TABLE_SIZE);
+	} else {
+		writel(0, dram1 + ICSS_LRE_DUPLICATE_PORT_TABLE_SIZE);
+	}
+
+	writel(ICSS_LRE_TABLE_CHECK_RESOLUTION_10_MS,
+	       dram1 + ICSS_LRE_DUPLI_PORT_CHECK_RESO);
+}
+
+static void icssm_prueth_lre_init(struct prueth *prueth)
+{
+	void __iomem *sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+
+	memset_io(sram + ICSS_LRE_START, 0, ICSS_LRE_STATS_DMEM_SIZE);
+
+	writel(ICSS_LRE_IEC62439_CONST_DUPLICATE_DISCARD,
+	       sram + ICSS_LRE_DUPLICATE_DISCARD);
+	writel(ICSS_LRE_IEC62439_CONST_TRANSP_RECEPTION_REMOVE_RCT,
+	       sram + ICSS_LRE_TRANSPARENT_RECEPTION);
+}
+
+static void icssm_prueth_lre_dbg_init(struct prueth *prueth)
+{
+	void __iomem *dram0 = prueth->mem[PRUETH_MEM_DRAM0].va;
+
+	memset_io(dram0 + ICSS_LRE_DBG_START, 0,
+		  ICSS_LRE_DEBUG_COUNTER_DMEM_SIZE);
+}
+
+static void icssm_prueth_lre_protocol_init(struct prueth *prueth)
+{
+	void __iomem *dram0 = prueth->mem[PRUETH_MEM_DRAM0].va;
+	void __iomem *dram1 = prueth->mem[PRUETH_MEM_DRAM1].va;
+
+	if (PRUETH_IS_HSR(prueth))
+		writew(ICSS_LRE_MODEH, dram0 + ICSS_LRE_HSR_MODE_OFFSET);
+
+	writel(ICSS_LRE_DUPLICATE_FORGET_TIME_400_MS,
+	       dram1 + ICSS_LRE_DUPLI_FORGET_TIME);
+
+	/* PRU firmware matches supervision frames on 01:15:4E:00:01 only
+	 * and forwards them to the host, bypassing the multicast filter.
+	 */
+	writel(ICSS_LRE_SUP_ADDRESS_INIT_OCTETS_HIGH,
+	       dram1 + ICSS_LRE_SUP_ADDR);
+	writel(ICSS_LRE_SUP_ADDRESS_INIT_OCTETS_LOW,
+	       dram1 + ICSS_LRE_SUP_ADDR_LOW);
+}
+
+static enum hrtimer_restart icssm_prueth_lre_timer(struct hrtimer *timer)
+{
+	struct prueth *prueth;
+	unsigned int timeout;
+	void __iomem *dram;
+
+	prueth = container_of(timer, struct prueth, tbl_check_timer);
+	dram = prueth->mem[PRUETH_MEM_DRAM1].va;
+	timeout = PRUETH_TIMER_MS;
+
+	hrtimer_forward_now(timer, ms_to_ktime(timeout));
+	/* HSR/PRP requires both ports to be up, regardless of link state. */
+	if (prueth->emac_configured !=
+	    (BIT(PRUETH_PORT_MII0) | BIT(PRUETH_PORT_MII1)))
+		return HRTIMER_RESTART;
+
+	/* Set the flags for duplicate tables so the firmware checks and
+	 * updates them every 10 milliseconds.
+	 */
+	writel(prueth->tbl_check_mask, dram + ICSS_LRE_HOST_TIMER_CHECK_FLAGS);
+
+	return HRTIMER_RESTART;
+}
+
+static void icssm_prueth_lre_init_timer(struct prueth *prueth)
+{
+	hrtimer_setup(&prueth->tbl_check_timer, &icssm_prueth_lre_timer,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+}
+
+static void icssm_prueth_lre_start_timer(struct prueth *prueth)
+{
+	unsigned int timeout = PRUETH_TIMER_MS;
+
+	if (hrtimer_active(&prueth->tbl_check_timer))
+		return;
+
+	hrtimer_start(&prueth->tbl_check_timer, ms_to_ktime(timeout),
+		      HRTIMER_MODE_REL);
+}
+
+void icssm_prueth_lre_config(struct prueth *prueth)
+{
+	icssm_prueth_lre_init_timer(prueth);
+	icssm_prueth_lre_start_timer(prueth);
+	icssm_prueth_lre_pcp_queue_map_config(prueth);
+	icssm_prueth_lre_host_table_init(prueth);
+	icssm_prueth_lre_port_table_init(prueth);
+	icssm_prueth_lre_init(prueth);
+	icssm_prueth_lre_dbg_init(prueth);
+	icssm_prueth_lre_protocol_init(prueth);
+}
+
+void icssm_prueth_lre_cleanup(struct prueth *prueth)
+{
+	if (hrtimer_active(&prueth->tbl_check_timer))
+		hrtimer_cancel(&prueth->tbl_check_timer);
+}
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.h b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.h
new file mode 100644
index 000000000000..0fe4d1ae5823
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
+ */
+
+#ifndef __NET_TI_PRUETH_LRE_H
+#define __NET_TI_PRUETH_LRE_H
+
+#include <linux/etherdevice.h>
+#include <linux/interrupt.h>
+#include <linux/if_vlan.h>
+
+#include "icssm_prueth.h"
+#include "icssm_lre_firmware.h"
+
+void icssm_prueth_lre_config(struct prueth *prueth);
+void icssm_prueth_lre_cleanup(struct prueth *prueth);
+void icssm_prueth_lre_config_check_flags(struct prueth *prueth);
+
+#endif /* __NET_TI_PRUETH_LRE_H */
-- 
2.43.0

