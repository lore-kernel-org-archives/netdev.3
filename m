Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346A4A3410
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001930; cv=none; b=lBHkjmbYzIzeTVKE1IB7mscM8/y5S3KaK0MqN5Kx+57bdZdFTOeyc26P/4hSlaFpXkx3vH3V039a7q1GA9v8IIrA4LBD6XMOtHKYIIPOKRmya5AE4nm87d8780JmWZQDrP012CmC2A3xbV7mwVvGD/XSwP2W6vbejONtNzaUYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001930; c=relaxed/simple;
	bh=U/XYhECdsIgpMgxLgSQHoUxRul4tWcS04II2mqE+fVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LQQYN+HmETZrlW/Pe5/QCnVUykaZs+xQpHkd4QbhTVp9UF88JZjuffWa6cXLUPynNBGLULuIZvpU4dWnM5vjXPTDpDQMUL+YBPy2Z+GrcWPkfVNo5pOYH6Et6YGYRkCevo2UrdFApMqac3lrEdOKQ6PLtqZgs6XudbzJ8hNcYIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 68LDwo0j030578;
	Mon, 21 Sep 2026 06:58:51 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v2 00/11] cxgb4: Add T7 adapter support
Date: Mon, 21 Sep 2026 19:30:30 -0400
Message-Id: <20260921233041.61093-1-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
- Patch 3: "missing sentinel in ID array" and "Macros with complex
  values should be enclosed in parentheses" warnings are reported for
  the macro-generated PCI device ID table. The generated table includes
  the required terminating entry.
- Patch 6: Several "Avoid CamelCase" warnings are reported for standard
  ethtool link mode identifiers (e.g. 1000baseKX_Full,
  100000baseCR4_Full), which are kernel-defined names and cannot be
  renamed.


Potnuri Bharat Teja (11):
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

---
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

 drivers/net/ethernet/chelsio/cxgb4/Makefile   |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c |   10 +-
 .../net/ethernet/chelsio/cxgb4/cudbg_entity.h |  114 +-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h |   56 +-
 .../ethernet/chelsio/cxgb4/cudbg_indir_reg.h  |   43 +
 .../chelsio/cxgb4/cudbg_indir_reg_t7.h        | 1113 +++
 .../net/ethernet/chelsio/cxgb4/cudbg_lib.c    | 1085 ++-
 .../net/ethernet/chelsio/cxgb4/cudbg_lib.h    |   60 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  120 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c  |   20 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_dcb.c    |   19 +-
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.c    | 1029 ++-
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.h    |   17 +-
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    |  171 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_filter.c |  214 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 1176 +--
 .../net/ethernet/chelsio/cxgb4/cxgb4_pci.c    |  332 +
 .../net/ethernet/chelsio/cxgb4/cxgb4_pci.h    |   23 +
 .../net/ethernet/chelsio/cxgb4/cxgb4_ptp.c    |   82 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c      |  167 +-
 .../net/ethernet/chelsio/cxgb4/t4_chip_type.h |   10 +
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    | 6579 ++++++++++++---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.h    |  140 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h   |  109 +-
 .../ethernet/chelsio/cxgb4/t4_pci_id_tbl.h    |   21 +
 drivers/net/ethernet/chelsio/cxgb4/t4_regs.h  | 7285 ++++++++++++++---
 drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h   |   16 +
 .../net/ethernet/chelsio/cxgb4/t4_values.h    |   11 +
 drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h |   83 +-
 .../net/ethernet/chelsio/cxgb4/t4fw_version.h |    9 +
 30 files changed, 16740 insertions(+), 3376 deletions(-)
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg.h
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cudbg_indir_reg_t7.h
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.c
 create mode 100644 drivers/net/ethernet/chelsio/cxgb4/cxgb4_pci.h

-- 
2.47.3

