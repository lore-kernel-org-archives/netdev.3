Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42711A3160
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133391; cv=none; b=tAHCFxwHQjJX6RSnc8pevuqE4pXR7638OLb0KYEyBI5GB1VCZPBMQDJMKro+H4P6FmNTr9jergUGy2t3wFrIF8BKoYIfouksG5nebWLETOr5JxvGJrRpe4w3qqP2001eVywzZxqCOqpteqHDZM5Isf+YbmPCPgskKNSVHblql1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133391; c=relaxed/simple;
	bh=LrZ2ncNwR8m2BBw2Loy6xydWlmptaQWowFJKwOnP7Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XyhJtnTb5ShEzX+MtzEfCKod9nZ6hbxqKhPfhMVG2kbxjEaUd5Z33BHXNaaO/1VeFzhsezrgBb0HKINdSv8hqA9I/2sl9POf4H4pGiOnb2s8b12xxOom3nVtz9AyDZOw4O4+hp6H5oSswKfjHlpDnxoO6p3ttmoK+vptKI6jP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+P7fA3d; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+P7fA3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789133390; x=1820669390;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LrZ2ncNwR8m2BBw2Loy6xydWlmptaQWowFJKwOnP7Wo=;
  b=K+P7fA3d35GBqJluwJYgy9FQF9R2u3Ruub1nL5iSjyR4UA18353WT7Wd
   pEjRjKeud2I/zAGNLwql/MC1sKq7uiQY/fN9JmiKi7vjC7GzbTIxirmMO
   kCF34HVa5rDJtlDT37ouwkKxnBNhKewc9jGurMAo8jbxJrd2KQ2v3w3W4
   ul3AUdANV2JmoEz7WoHBUrP4AdXNkfBIPb0mXtd1hBDnuEeJScrESPUoi
   pP9DDlO0Qx9r2lSdNtUGovn+C0UJkV3PoTggdpYbjDmGEM5BMFFxPe8JI
   7Sky3wmLPN576U8/dNx0wzT6whfqloFqsw5sOMEqzpokL0hic9H5TI9N7
   g==;
X-CSE-ConnectionGUID: UQDX3YjfQuSsRyg0juj9Kg==
X-CSE-MsgGUID: QEszi4iJTVu9OQ+sfMJgxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107520"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107520"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 06:29:50 -0700
X-CSE-ConnectionGUID: a20Sxac6Q8aiYkvWGy0IfA==
X-CSE-MsgGUID: WJO6pqH3TPSzCJ7rnXWpVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270541252"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:29:49 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 00/10] Interrupts helper in libie
Date: Fri, 11 Sep 2026 14:49:11 +0200
Message-ID: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

To not copy the same code to handle interrupts in ixd driver move it to
libie_irq module and use in both idpf and ixd.

First part is changing current idpf code to make it more friendly to be
moved to the lib. Basically there is no need to store MSI-X entries in
separate table. Instead of that store it in xarray which also replace
custom lifo implementation.

Patch with libie is about moving the code to the new module. No
functional changes here, just moving the code or adding some more
descriptions.

The irq code is similar in ice. One patch also coverd the changes in ice
driver.

Last patches is the implementation in ixd driver. To manage MSI-X it
needs to first map correct regions. Do this using virtchnl command,
similiary as in idpf.

v1 --> v2: [1]
* patch 05
- New struct idpf_rdma_irq { entries, map, num } replaces
  adapter->rdma_msix_entries and adapter->num_rdma_msix_entries.
  idpf_idc.c is now touched by this patch to follow the rename.
- Removed the idpf_rdma_entry_to_index() helper. v1 reverse-looked-up the
  libie index from msix_entry.entry on every free; v2 stores the
  struct msi_map directly in rdma_irq->map[].
- idpf_rdma_intr_init() now allocates rdma_irq->map as well and unwinds
  both arrays on failure; idpf_rdma_intr_free() frees both.
- libie_irq_deinit() sets irq->pdev = NULL at the end.
- libie_get_irq() gains an "if (!irq->pdev) return NULL;" guard.
- libie_irq_free() guard changed from "if (!map.virq || map.index < 0)"
  to "if (map.virq <= 0 || map.index < 0)".
- idpf_vport_intr_alloc(): tmp_irqs changed from __free(kfree) to a plain
  pointer with an explicit kfree() on every error path and on success;
  loop variable i hoisted to function scope.
- idpf_mb_intr_init(): the libie_irq_alloc() call moved above the index
  check (cosmetic).

* patch 06
- Dropped Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>.
- Otherwise only context churn from the idpf_rdma_irq change in patch 05.

* patch 07
- Dropped Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>.
- include/linux/net/intel/libie/irq.h no longer includes
  <linux/net/intel/virtchnl2.h>; it forward declares
  struct virtchnl2_get_capabilities and struct virtchnl2_alloc_vectors
  instead.

* patch 08
- Commit message corrected. v1 claimed the allocation order was
  preserved

- LIBIE_IRQ_ANY is now introduced here rather than in patch 05: the enum
  value, the kernel-doc entries, and the struct xa_limit local plus the
  dynamic-then-static fallback in libie_get_irq() all moved into this
  patch.

* patch 09
- Removed the hardcoded PF_PCI_0/1/2 offset and size defines from
  ixd_lan_regs.h and the static ixd_running_regions[] table.
  ixd_iomap_running_regions() now computes the three ranges around the
  mailbox and reset registers from PF_FW_MBX, PFGEN_RTRIG and
  pci_resource_len().
- ixd_start_regions[] made static, with a comment explaining it stays
  mapped for the whole driver life.
- uint i -> unsigned int i in ixd_iomap_is_not_start_region().
- New ixd_fill_caps() requests VIRTCHNL2_CAP_LAN_MEMORY_REGIONS in
  GET_CAPS, and new ixd_is_cap_ena() helper. ixd_vc_dev_init() now
  selects the path based on the negotiated capability instead of sending
  the command and falling back on error.
- ixd_handle_lan_mmio_regions(): bounds check uses
  struct_size(recv_mmio, mem_reg, num_regions) instead of the open-coded
  sizeof() + sizeof() * n; zero-size padding regions are skipped; the
  unused err variable is gone.

* patch 10
- Register addresses are resolved once and cached in the new
  adapter->mb_dyn_ctl and adapter->oicr_ena via the new
  ixd_mailbox_irq_regs_init(), with a NULL check returning -EINVAL. v1
  called libie_pci_get_mmio_addr() on every enable with no NULL check.
- New ixd_mailbox_irq_disable().
- ixd_mailbox_irq_deinit() rewritten: early return on the flag, disable
  the interrupt in HW, then cancel_delayed_work_sync(&adapter->mbx_task)
  before free_irq(). v1 instead re-queued mbx_task after freeing the irq.
- ixd_mailbox_irq_init() now handles kasprintf() returning NULL (frees
  the libie irq, returns -ENOMEM). v1 passed a possibly NULL name to
  request_irq().
- ixd_remove(): ixd_deinit_interrupts() moved earlier, before
  libie_ctlq_xn_shutdown() and ixd_trigger_reset(), instead of after
  them.

[1] https://lore.kernel.org/netdev/20260907102418.2697317-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (10):
  idpf: store HW vectors information
  idpf: fill q_vector interrupt registers one by one
  idpf: get rid of msix_entries array
  idpf: drop v_idx from q_vector structure
  libie, idpf: move irq code to libie
  libie, idpf: move hardware irq info struct to libie
  libie, idpf: move parsing alloc vectors command to libie
  ice: use libie_irq for interrupts managing
  ixd: support for getting lan memory regions
  ixd: use interrupt for mailbox communication

 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/ice/ice.h          |   5 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   4 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_irq.c      | 181 +-------
 drivers/net/ethernet/intel/ice/ice_irq.h      |  14 -
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  15 +-
 drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  88 ++--
 drivers/net/ethernet/intel/idpf/idpf_dev.c    | 108 ++---
 drivers/net/ethernet/intel/idpf/idpf_idc.c    |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 425 +++++-------------
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   3 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 142 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  23 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 109 ++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 159 +------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   9 +-
 drivers/net/ethernet/intel/ixd/Kconfig        |   1 +
 drivers/net/ethernet/intel/ixd/ixd.h          |  31 ++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |   8 +-
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  10 +
 drivers/net/ethernet/intel/ixd/ixd_lib.c      | 126 ++++++
 drivers/net/ethernet/intel/ixd/ixd_main.c     | 133 +++++-
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  90 +++-
 drivers/net/ethernet/intel/libie/Kconfig      |   6 +
 drivers/net/ethernet/intel/libie/Makefile     |   4 +
 drivers/net/ethernet/intel/libie/irq.c        | 368 +++++++++++++++
 include/linux/net/intel/libie/irq.h           | 120 +++++
 30 files changed, 1250 insertions(+), 947 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libie/irq.c
 create mode 100644 include/linux/net/intel/libie/irq.h

-- 
2.49.0

