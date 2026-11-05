Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=12.32.117.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850255;
	b=Q3VzImhINabecJlfE4ZNZbGcxHx5KThw28lq/RoZvijJK+LM9Le9+fOcmkWpzQeOEUUO
	 YOStaHin4I7PrzHuBMnyRduSe7KdEgX7lrmfdOe30bbhhbJUYeJaIg1armWMx5Qv2YKN/
	 kB+UERbfz4BlKNgjujnfOCFC4PG4MRWHPq8GQ47YAkzvpaTgqAiD0+Ci2bcNV83+o/8Tt
	 iLjrG+v9NDU8sx4BKZmRgpRGcR4s/2uEIoeyEuraI+W4vg4JG8kH7ciAmWRhfdnGelVC/
	 q2Md7fgBb8LXHu1GifHn29HtIEpiTsehtEjm7/41TrONxganhZYmhRNsJBBytSKynew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850255;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/4ZDS7kBrSzd6pt0ETyWRju/FCd0D8nG1pYJX7OfriA=;
	b=O7Kw1ryK4oigg7v5iWN4tKZ5G6J0Vp2/TNDxK9njxGjwZynwYrMzA6hCV99csyfBFgLb
	 5DBx9PsEbeIrb2B427PvjhGklADpndL6HCSwvi7IN0mgPCR59lmlUdu/1u0V/QSstKJ5S
	 PIKRSVNva+eOZB+H9hfRuk2kaBKteH96Dowr2BAXJxvN2TuiM0pfMbOvan78PV8ytGd+8
	 vte4PcdpRfeKxc+WikibpzRYMu44vQVDmrEprN3RfEv38ungnPi9sAm+7PbiamdnURIFE
	 Y1a5MZMQB1SIbYZudqqKTuxLE0LgaBcqmZ8eTaCGZzeJra43TF4xmPJ3FaydUhByUFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chelsio.com;
	spf=pass smtp.mailfrom=chelsio.com;
	arc=none smtp.remote-ip=12.32.117.8
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417B606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 03:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0417B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 6A53hj3m002480;
	Wed, 4 Nov 2026 19:43:46 -0800
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com,
        harshitha.vr@chelsio.com
Subject: [PATCH net-next v5 REPOST 00/12] cxgb4: Add T7 adapter support
Date: Thu,  5 Nov 2026 08:15:37 -0500
Message-Id: <20261105131549.547554-1-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
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

This series adds support for Chelsio T7 adapters to the cxgb4 driver.

The series extends the driver core to recognize and initialize T7
devices, adds support for T7-specific hardware resources and firmware
interfaces, updates PCI initialization and resource management, and
enables adapter operation through the existing networking stack.

In addition, the series updates several auxiliary components to support
the T7 architecture, including PTP, ethtool, filter management, CUDBG,
and debugfs. Support is also added for T7 multicore debugging and
diagnostic infrastructure.

Testing:
  1. Each patch compiled individually
  2. Driver probe and initialization on T7 adapters
  3. Link bring-up
  4. ping
  5. NIC tx and rx traffic (using neperf and iperf)
  6. Reload the driver multiple times

checkpatch.pl:
- Patch 4: "missing sentinel in ID array" and "Macros with complex
  values should be enclosed in parentheses" warnings are reported for
  the macro-generated PCI device ID table. The generated table includes
  the required terminating entry. This error is a false-positive.
- Patch 7: Several "Avoid CamelCase" warnings are reported for standard
  ethtool link mode identifiers (e.g. 1000baseKX_Full,
  100000baseCR4_Full), which are kernel-defined names and cannot be
  renamed.
 


Potnuri Bharat Teja (12):
  cxgb4: add T7 hardware definitions and firmware interfaces
  cxgb4: rework the interrupt handling framework
  cxgb4: add T7 hardware management support
  cxgb4: move PCI device management into cxgb4_pci.c and rework driver
    helpers
  cxgb4: add T7 support to the main driver
  cxgb4: update PTP register access for T7
  cxgb4: extend ethtool support for T7 adapters
  cxgb4: Add T7 support to the filter infrastructure.
  cxgb4: Add indirect register definitions for T7
  cxgb4: extend CUDBG support for T7 adapters
  cxgb4: extend debugfs support for T7 adapters
  cxgb4: select ULD Tx and control queues by TID on T7

---
v4 -> v5
- fixed the build error reported by the Kernel Test Robot.
---
v3 -> v4
- fixed buildbot errors
---
v2 -> v3:
- rebase the patches to tot
- add ULD multicore support changes
v1 -> v2:
- split the v1 hardware management patch in two; the interrupt
  handling rework is not T7 specific and now lands first
- merged the PCI management patch into the one that wires it up, so
  each commit builds what it adds, then split off the T7 changes
- fixed per patch build failures reported by the kernel test robot
- fixed: shared static intr_info structures mutated per adapter;
  t4_handle_intr() clearing only enabled cause bits; IPv4 address
  byte order in mk_act_open_req(); cxgb4_read_tpte() sleeping under
  xa_lock_irq(); missing CAP_NET_ADMIN on the cudbg ioctl read
  commands; CXGB4_DEV_ENABLED set too late in probe
- dropped the SYN-only filter field and the unused cxgb4_pci helpers
---

 drivers/net/ethernet/chelsio/cxgb4/Makefile   |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c |   10 +-
 .../net/ethernet/chelsio/cxgb4/cudbg_entity.h |  114 +-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h |   56 +-
 .../ethernet/chelsio/cxgb4/cudbg_indir_reg.h  |   43 +
 .../chelsio/cxgb4/cudbg_indir_reg_t7.h        | 1113 +++
 .../net/ethernet/chelsio/cxgb4/cudbg_lib.c    | 1088 ++-
 .../net/ethernet/chelsio/cxgb4/cudbg_lib.h    |   60 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  148 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c  |   20 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_dcb.c    |   19 +-
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.c    | 1031 ++-
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.h    |   17 +-
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    |  381 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_filter.c |  214 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 1183 +--
 .../net/ethernet/chelsio/cxgb4/cxgb4_pci.c    |  332 +
 .../net/ethernet/chelsio/cxgb4/cxgb4_pci.h    |   23 +
 .../net/ethernet/chelsio/cxgb4/cxgb4_ptp.c    |   82 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_uld.c    |  140 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_uld.h    |    5 +
 drivers/net/ethernet/chelsio/cxgb4/sge.c      |  182 +-
 .../net/ethernet/chelsio/cxgb4/t4_chip_type.h |   10 +
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    | 6579 ++++++++++++---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.h    |  140 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h   |  109 +-
 .../ethernet/chelsio/cxgb4/t4_pci_id_tbl.h    |   21 +
 drivers/net/ethernet/chelsio/cxgb4/t4_regs.h  | 7285 ++++++++++++++---
 drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h   |   16 +
 .../net/ethernet/chelsio/cxgb4/t4_values.h    |   11 +
 drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h |   88 +-
 .../net/ethernet/chelsio/cxgb4/t4fw_version.h |    9 +
 32 files changed, 17042 insertions(+), 3489 deletions(-)
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg.h
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg_t7.h
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.h

-- 
2.39.1

