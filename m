Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5540D588;
	Wed, 29 Jul 2026 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357918; cv=none; b=M52C7CMmM+ximUCwO/zIKYM9lAOBdJTPef4yv94Prn+JuSpPZcK2HygSxl03uMaHW/brepMvhcwg13zsDBNf13p1ZbRKSKz7lY9aLndQnRi7iFmfDkYDDqQ6S8npyOp18XuC6cnjes+sUncqve6rFVJ+N/S6V1+xIWbXMB2l6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357918; c=relaxed/simple;
	bh=bVlHHEUPXpsyA/dmc+CqN2KFur/xel1DV2f1KMwh3Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+ZmrSIumVUAj/6+Wxmt6CpkRKl27gYv3DuLmmcVY83Yj0zwBaSlR60AgIF/lEoqGbC3fkXeYUffdpIY8XPRG8IZrbbVcVlxuNfwi4grZfZhmxUgg4sUNIBczhdRsJdiIXHaG3Emy+E6eNacBlpxpqdM1i1qBux12793Cw5+X8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dkb/hrb1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dkb/hrb1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785357913; x=1816893913;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bVlHHEUPXpsyA/dmc+CqN2KFur/xel1DV2f1KMwh3Rw=;
  b=Dkb/hrb1pvk4+kP/con5R83foJ2nA2iF9oQrbI/D3+Zbg7+KSx92YSsV
   V9T5H48LdzqnV1ubf1HFnK39rW4/oBdqtcZvet+yHtKenIKc/eVNv1ge2
   QvIP8DiXQbVQyUeq0N2NWf3lkCBbWyUq4jli48rMhoTuHHOnX2I6Zl2CR
   sb9t4ViDcOqXfiVilYwmFJUYNw5+YCXBn8oWqGGosAtwl47Qiqw0nP2gO
   uEMRzlf3Xn89/u6+Twifhw4i9iz4GHV0owQOYFnb0xcrRB3ALCQsD1B4O
   NcS29GLhQFpyVhpCuZxML99RhsDmg7ZNR/5ibM+vfS8lP0mGfC93HqRIr
   A==;
X-CSE-ConnectionGUID: brEu6qFHTfyW1TYJFKdQgQ==
X-CSE-MsgGUID: 710FyQ5fSAKL+Qo4quqHfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="84952348"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="84952348"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 13:45:08 -0700
X-CSE-ConnectionGUID: 54xBxjBSQPWBArfqoPbtrA==
X-CSE-MsgGUID: Rq/YfcAkTOSqIAs2Zh21jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="264381323"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 29 Jul 2026 13:45:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v6 00/15][pull request] Introduce iXD driver
Date: Wed, 29 Jul 2026 13:44:47 -0700
Message-ID: <20260729204505.3373950-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Larysa Zaremba says:

This patch series adds the iXD driver, which supports the Intel(R)
Control Plane PCI Function on Intel E2100 and later IPUs and FNICs.
It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
exposed by the same card. The reason for the separation is to be able
to offload the control plane to the host different from where the data
plane is running.

This is the first phase in the release of this driver where we implement the
initialization of the core PCI driver. Subsequent phases will implement
advanced features like usage of idpf ethernet aux device, link management,
NVM update via devlink, switchdev port representors, data and exception path,
flow rule programming, etc.

The first phase entails the following aspects:

1. Additional libie functionalities:
Patches 1-5 introduce additional common library API for drivers to
communicate with the control plane through mailbox communication.
A control queue is a hardware interface which is used by the driver
to interact with other subsystems (like firmware). The library APIs
allow the driver to setup and configure the control queues to send and
receive virtchnl messages. The library has an internal bookkeeping
(XN API) mechanism to keep track of the send messages. It supports both
synchronous as well as asynchronous way of handling the messages. The
library also handles the timeout internally for synchronous messages
using events. This reduces the driver's overhead in handling the timeout
error cases.

The current patch series supports only APIs that are needed for device
initialization. These include APIs in the libie_pci module:
* Allocating/freeing the DMA memory and mapping the MMIO regions for
  BAR0, read/write APIs for drivers to access the MMIO memory

and libie_cp module:
* Control queue initialization and configuration
* Transport initialization for bookkeeping
* Blocking and asynchronous mailbox transactions

Once the mailbox is initialized, the drivers can send and receive virtchnl
messages to/from the control plane.

The modules above are not supposed to be linked with the main libie library,
but do share the folder with it.

2. idpf:
Patches 6-11 refactor the idpf driver to use the libie APIs for control
queue configuration, virtchnl transaction, device initialization
and reset and adjust related code accordingly.

3. ixd:
Patches 12-15 add the ixd driver and implement multiple pieces of the
initialization flow as follows:
* Add the ability to load
* A reset is issued to ensure a clean device state, followed by
  initialization of the mailbox
* Device capabilities:
  As part of initialization, the driver has to determine what the device is
  capable of (ex. max queues, vports, etc). This information is obtained from
  the firmware and stored by the driver.
* Enable initial support for the devlink interface
---
v6:
* use idpf_mmio_region_non_static() in idpf_idc_init_aux_core_dev() to avoid
  code duplication
* change LIBIE_CTLQ_TYPE_TX/RX from macros to enum libie_ctlq_type
* pull libie_ctlq_xn_shutdown() out of libie_ctlq_xn_deinit() for consistency
  and to avoid unlikely races with send queue force-cleaning
* remove unused send_ctx field from struct libie_ctlq_xn_clean_params
* add missing dma_wmb() before tail register update in libie_ctlq_post_rx_buffs()
* initialize mem->direction in libie_cp_alloc_dma_mem (purely cosmetic)
* remove unnecessary dma_mb() for coherent DMA in libie_ctlq_xn_send_clean()
* removed redundant list-init check
* fixed whitespaces not flagged by checkpatch
* improved documentation

v5: https://lore.kernel.org/netdev/20260715180042.1972010-1-anthony.l.nguyen@intel.com/
* Add length validation to libie_ctlq_add()
* Add memory barrier before writing tail in libie_ctlq_send()
* Reduce larger then needed size allocation in libie_ctlq_xn_init_dma()
* Clarify error message on dev init failure in idpf_probe()
* Nullify adapter->asq and adapter->arq on failure in idpf_init_dflt_mbx()
* Correct virtchnl version compatibility checks in ixd_handle_vc_ver()
* Misc documentation fixes

v4: https://lore.kernel.org/netdev/0a3ceda1-a29b-4784-975b-d8c89f145d10@intel.com/
* use check_add_overflow() for MMIO offset+size bounds check in libie_pci
* replace iounmap() with pci_iounmap() for MMIO regions in libie_pci
* fix missing rx_buf->offset when constructing ctlq Rx message address
* always zero Rx descriptor before reallocation
* do not call complete() inside spinlock, theoretical use-after-free
* reset async xn state to IDLE before freeing in libie_ctlq_xn_shutdown()
* zero control queue Tx descriptor before freeing memory
* remove unused ctx field from struct libie_ctlq_xn_clean_params
* roll back merging of idpf_deinit_dflt_mbx() and xnm shutdown,
  those calls are separate again (so idpf refactoring becomes more trivial)
* introduce idpf_send_vf_reset_msg() for one-way VF reset message bypassing
  XN manager, which is shut down by now
* guard libie_ctlq_xn_shutdown() against NULL xnm in idpf_vc_event_task(),
  this is needed if reset fails and reschedules
* validate response sizes in idpf more
* fix MAINTAINERS glob pattern for include/linux/net/intel/
* roll back linux/{net/intel -> intel}/* change (1st patch)
* use pci_iomap_range() to map regions in libie_pci
* improve libie_pci commit message
* remove broken dead code for getting RSS from idpf (new patch!)
* use maximum alignment for control queue stack buffer in ixd
* fix ixd_ctlq_clean_sq() usage
* do not register ixd devlink prematurely
* improve receive buffer size validation in idpf

v3: https://lore.kernel.org/netdev/20260515224443.2772147-1-anthony.l.nguyen@intel.com/
- lock libie ctlq transaction earlier on Rx path
- improve ctlq Rx buffer size validation both in idpf and libie
- fix RSS LUT buf size (will also go to stable separately)
- improve xnm shutdown handling
- skip zero-sized BAR regions instread of returning error in idpf
- unify treatment of initialized and uninitialized ctlq messages

v2: https://lore.kernel.org/netdev/20260403194938.3577011-1-anthony.l.nguyen@intel.com/
- improved failure handling and input validation
- removed cp version from devlink in ixd

v1: https://lore.kernel.org/netdev/20260317230905.847744-1-anthony.l.nguyen@intel.com/

The following are changes since commit 2bb54b49e9d522f54dc9c0fe10ba40fbc56041c8:
  ppp: convert chan_sem to a mutex
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Amritha Nambiar (1):
  ixd: add devlink support

Larysa Zaremba (6):
  idpf: remove unused code for getting RSS info from device
  idpf: make mbx_task queueing and cancelling more consistent
  idpf: print a debug message and bail in case of non-event ctlq message
  ixd: add basic driver framework for Intel(R) Control Plane Function
  ixd: add reset checks and initialize the mailbox
  ixd: add the core initialization

Pavan Kumar Linga (4):
  libeth: allow to create fill queues without NAPI
  idpf: remove 'vport_params_reqd' field
  idpf: refactor idpf to use libie_pci APIs
  idpf: refactor idpf to use libie control queues

Phani R Burra (3):
  libie: add PCI device initialization helpers to libie
  libie: add control queue support
  libie: add bookkeeping support for control queue messages

Victor Raj (1):
  virtchnl: move virtchnl and virtchnl2 headers to
    'include/linux/net/intel'

 .../device_drivers/ethernet/index.rst         |    1 +
 .../device_drivers/ethernet/intel/ixd.rst     |   39 +
 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/ixd.rst      |   30 +
 MAINTAINERS                                   |    3 +-
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/intel/Makefile           |    1 +
 drivers/net/ethernet/intel/i40e/i40e.h        |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c |    2 +-
 .../net/ethernet/intel/i40e/i40e_prototype.h  |    2 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |    2 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c |    2 +-
 .../net/ethernet/intel/iavf/iavf_prototype.h  |    3 +-
 drivers/net/ethernet/intel/iavf/iavf_types.h  |    4 +-
 drivers/net/ethernet/intel/ice/ice.h          |    2 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |    2 +-
 .../net/ethernet/intel/ice/virt/virtchnl.h    |    2 +-
 drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
 drivers/net/ethernet/intel/idpf/Makefile      |    2 -
 drivers/net/ethernet/intel/idpf/idpf.h        |   99 +-
 .../net/ethernet/intel/idpf/idpf_controlq.c   |  621 ------
 .../net/ethernet/intel/idpf/idpf_controlq.h   |  144 --
 .../ethernet/intel/idpf/idpf_controlq_api.h   |  177 --
 .../ethernet/intel/idpf/idpf_controlq_setup.c |  169 --
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  101 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   28 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c    |   32 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   69 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  115 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |    4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    4 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   96 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1884 +++++++----------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  109 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  312 +--
 drivers/net/ethernet/intel/ixd/Kconfig        |   15 +
 drivers/net/ethernet/intel/ixd/Makefile       |   13 +
 drivers/net/ethernet/intel/ixd/ixd.h          |   59 +
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |  146 ++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.h     |   34 +
 drivers/net/ethernet/intel/ixd/ixd_dev.c      |   89 +
 drivers/net/ethernet/intel/ixd/ixd_devlink.c  |   97 +
 drivers/net/ethernet/intel/ixd/ixd_devlink.h  |   50 +
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |   68 +
 drivers/net/ethernet/intel/ixd/ixd_lib.c      |  177 ++
 drivers/net/ethernet/intel/ixd/ixd_main.c     |  147 ++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  190 ++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h |   12 +
 drivers/net/ethernet/intel/libeth/rx.c        |   12 +-
 drivers/net/ethernet/intel/libie/Kconfig      |   14 +
 drivers/net/ethernet/intel/libie/Makefile     |    8 +
 drivers/net/ethernet/intel/libie/controlq.c   | 1228 +++++++++++
 drivers/net/ethernet/intel/libie/pci.c        |  209 ++
 include/linux/net/intel/libie/controlq.h      |  428 ++++
 include/linux/net/intel/libie/pci.h           |   56 +
 include/linux/{avf => net/intel}/virtchnl.h   |    0
 .../linux/net/intel}/virtchnl2.h              |    0
 .../linux/net/intel}/virtchnl2_lan_desc.h     |    0
 include/net/libeth/rx.h                       |    4 +-
 62 files changed, 4250 insertions(+), 2897 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/ixd.rst
 create mode 100644 Documentation/networking/devlink/ixd.rst
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h
 create mode 100644 drivers/net/ethernet/intel/ixd/Kconfig
 create mode 100644 drivers/net/ethernet/intel/ixd/Makefile
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_dev.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lib.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_main.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
 create mode 100644 drivers/net/ethernet/intel/libie/controlq.c
 create mode 100644 drivers/net/ethernet/intel/libie/pci.c
 create mode 100644 include/linux/net/intel/libie/controlq.h
 create mode 100644 include/linux/net/intel/libie/pci.h
 rename include/linux/{avf => net/intel}/virtchnl.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/net/intel}/virtchnl2.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/net/intel}/virtchnl2_lan_desc.h (100%)

-- 
2.47.1

