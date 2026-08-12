Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D7F48F843;
	Wed, 12 Aug 2026 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570045; cv=none; b=e7Fu7llnglcrFiWVMVbb/aSo5/ofqSUYHPTg0c3aMXiV28MVZtno1fj9QzLbB+lUvMQObSZiZ3+Qc8o3XPPSvxx338sftcYp8idt9S/WkpwOllqx4BFvfEGRusngBN9pFiuEz8lblnRjwfURI1/UK7hozZkS9B3AhhXaXtFmp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570045; c=relaxed/simple;
	bh=xPWU6A15255rg3AWJCN1NE53VQ3gUaGDvBsTInTMid0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akCE505DyFG0n3oa2QMIp64KuSEJTehnVDb+WYIyKsl5y9aMCNr9SRlO3K+dQUJVVFixc9WXPj8KFGqZ2gtr/sVlH15nRqLA5BxFGtZKPcRXnzGgysy4/XQLF5/qkcljJCvUNQz9MHcfZgH170wYyN/lK/qfcKyjtTgnX4/GR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnoQ2dBz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnoQ2dBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786570012; x=1818106012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xPWU6A15255rg3AWJCN1NE53VQ3gUaGDvBsTInTMid0=;
  b=WnoQ2dBzDE7lH9VQZZYe29Hoau+U7Y7XoOtf8c03QEqCx+qvZ9DUv9cz
   SHuGOmMjWJVE/pG6ntJDAzHITvIVCwvtXIGofeBss1n4Go0i4u0EAcPmp
   8p7Y2Yl66y6HRgCzibI0Xz/C27aQnTwACgo2DZP0+f4LehGjigR/BZjcA
   hFzAyOFqpjH7OReGd4bvztHnIWlxbBIFF8mykGOkyNE4GjoPZqtAdD4aH
   BDqCaObiQgxTX2OAHr3BaffhfBoGGuBGpB94h14aZ3WrCd0LTGk+RhZwJ
   hLSJgWUAfMWBHOVln9aE9lFWh/EysJ4oVFQNwR/Fjxfn11gTi3mEjlbzQ
   A==;
X-CSE-ConnectionGUID: anTBCmRPTuKCnWqteQzK0Q==
X-CSE-MsgGUID: c7t9hL8dS7yXEjvqzv6dfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97485619"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="97485619"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 14:25:44 -0700
X-CSE-ConnectionGUID: u2S1OffsSEeBJfgsfj2LVQ==
X-CSE-MsgGUID: LM835Jy3TbCpv+djcBQMNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="257546263"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 12 Aug 2026 14:25:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
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
	linux-doc@vger.kernel.org,
	Bharath R <Bharath.r@intel.com>
Subject: [PATCH net-next v8 12/15] ixd: add basic driver framework for Intel(R) Control Plane Function
Date: Wed, 12 Aug 2026 14:25:26 -0700
Message-ID: <20260812212532.905873-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260812212532.905873-1-anthony.l.nguyen@intel.com>
References: <20260812212532.905873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

Add module register and probe functionality. Add the required support to
register IXD PCI driver, as well as probe, remove and shutdown callbacks.
Enable the PCI device and request to reserve the memory resources that will
be used by the driver. Finally map the BAR0 address space.

For now, use devm_kzalloc() to allocate adapter, as it requires the least
amount of code. In a later commit, it will be replaced with a devlink
alternative.

Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Bharath R <Bharath.r@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/intel/ixd.rst     |  39 ++++++
 drivers/net/ethernet/intel/Kconfig            |   2 +
 drivers/net/ethernet/intel/Makefile           |   1 +
 drivers/net/ethernet/intel/ixd/Kconfig        |  12 ++
 drivers/net/ethernet/intel/ixd/Makefile       |   8 ++
 drivers/net/ethernet/intel/ixd/ixd.h          |  28 +++++
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  28 +++++
 drivers/net/ethernet/intel/ixd/ixd_main.c     | 112 ++++++++++++++++++
 9 files changed, 231 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/ixd.rst
 create mode 100644 drivers/net/ethernet/intel/ixd/Kconfig
 create mode 100644 drivers/net/ethernet/intel/ixd/Makefile
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_main.c

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 786a23c84b90..d9980c84487a 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -35,6 +35,7 @@ Contents:
    intel/idpf
    intel/igb
    intel/igbvf
+   intel/ixd
    intel/ixgbe
    intel/ixgbevf
    intel/i40e
diff --git a/Documentation/networking/device_drivers/ethernet/intel/ixd.rst b/Documentation/networking/device_drivers/ethernet/intel/ixd.rst
new file mode 100644
index 000000000000..1387626e5d20
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/intel/ixd.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+==========================================================================
+iXD Linux* Base Driver for the Intel(R) Control Plane Function
+==========================================================================
+
+Intel iXD Linux driver.
+Copyright(C) 2025 Intel Corporation.
+
+.. contents::
+
+For questions related to hardware requirements, refer to the documentation
+supplied with your Intel adapter. All hardware requirements listed apply to use
+with Linux.
+
+
+Identifying Your Adapter
+========================
+For information on how to identify your adapter, and for the latest Intel
+network drivers, refer to the Intel Support website:
+http://www.intel.com/support
+
+
+Support
+=======
+For general information, go to the Intel support website at:
+http://www.intel.com/support/
+
+If an issue is identified with the released source code on a supported kernel
+with a supported adapter, email the specific information related to the issue
+to intel-wired-lan@lists.osuosl.org.
+
+
+Trademarks
+==========
+Intel is a trademark or registered trademark of Intel Corporation or its
+subsidiaries in the United States and/or other countries.
+
+* Other names and brands may be claimed as the property of others.
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 288fa8ce53af..780f113986ea 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -398,4 +398,6 @@ config IGC_LEDS
 
 source "drivers/net/ethernet/intel/idpf/Kconfig"
 
+source "drivers/net/ethernet/intel/ixd/Kconfig"
+
 endif # NET_VENDOR_INTEL
diff --git a/drivers/net/ethernet/intel/Makefile b/drivers/net/ethernet/intel/Makefile
index 9a37dc76aef0..08b29f3b6801 100644
--- a/drivers/net/ethernet/intel/Makefile
+++ b/drivers/net/ethernet/intel/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_IAVF) += iavf/
 obj-$(CONFIG_FM10K) += fm10k/
 obj-$(CONFIG_ICE) += ice/
 obj-$(CONFIG_IDPF) += idpf/
+obj-$(CONFIG_IXD) += ixd/
diff --git a/drivers/net/ethernet/intel/ixd/Kconfig b/drivers/net/ethernet/intel/ixd/Kconfig
new file mode 100644
index 000000000000..5279cee2a050
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2025 Intel Corporation
+
+config IXD
+	tristate "Intel(R) Control Plane Function Support"
+	depends on PCI_MSI
+	select LIBIE_PCI
+	help
+	  This driver supports Intel(R) Control Plane PCI Function
+	  of Intel E2100 and later IPUs and FNICs.
+	  It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
+	  exposed by the same card.
diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
new file mode 100644
index 000000000000..3849bc240600
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2025 Intel Corporation
+
+# Intel(R) Control Plane Function Linux Driver
+
+obj-$(CONFIG_IXD) += ixd.o
+
+ixd-y := ixd_main.o
diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
new file mode 100644
index 000000000000..1b918c5d31cd
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef _IXD_H_
+#define _IXD_H_
+
+#include <linux/net/intel/libie/pci.h>
+
+/**
+ * struct ixd_adapter - Data structure representing a CPF
+ * @hw: Device access data
+ */
+struct ixd_adapter {
+	struct libie_mmio_info hw;
+};
+
+/**
+ * ixd_to_dev - Get the corresponding device struct from an adapter
+ * @adapter: PCI device driver-specific private data
+ *
+ * Return: struct device corresponding to the given adapter
+ */
+static inline struct device *ixd_to_dev(struct ixd_adapter *adapter)
+{
+	return &adapter->hw.pdev->dev;
+}
+
+#endif /* _IXD_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
new file mode 100644
index 000000000000..fbb88929d0de
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef _IXD_LAN_REGS_H_
+#define _IXD_LAN_REGS_H_
+
+/* Control Plane Function PCI ID */
+#define IXD_DEV_ID_CPF			0x1efe
+
+/* Control Queue (Mailbox) */
+#define PF_FW_MBX_REG_LEN		4096
+#define PF_FW_MBX			0x08400000
+
+/* Reset registers */
+#define PFGEN_RTRIG_REG_LEN		2048
+#define PFGEN_RTRIG			0x08407000	/* Device resets */
+
+/**
+ * struct ixd_bar_region - BAR region description
+ * @offset: BAR region offset
+ * @size: BAR region size
+ */
+struct ixd_bar_region {
+	resource_size_t offset;
+	resource_size_t size;
+};
+
+#endif /* _IXD_LAN_REGS_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
new file mode 100644
index 000000000000..75ee53152e61
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include "ixd.h"
+#include "ixd_lan_regs.h"
+
+MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
+MODULE_IMPORT_NS("LIBIE_PCI");
+MODULE_LICENSE("GPL");
+
+/**
+ * ixd_remove - remove a CPF PCI device
+ * @pdev: PCI device being removed
+ */
+static void ixd_remove(struct pci_dev *pdev)
+{
+	struct ixd_adapter *adapter = pci_get_drvdata(pdev);
+
+	libie_pci_unmap_all_mmio_regions(&adapter->hw);
+}
+
+/**
+ * ixd_shutdown - shut down a CPF PCI device
+ * @pdev: PCI device being shut down
+ */
+static void ixd_shutdown(struct pci_dev *pdev)
+{
+	ixd_remove(pdev);
+
+	if (system_state == SYSTEM_POWER_OFF)
+		pci_set_power_state(pdev, PCI_D3hot);
+}
+
+/**
+ * ixd_iomap_regions - iomap PCI BARs
+ * @adapter: adapter to map memory regions for
+ *
+ * Returns: %0 on success, negative on failure
+ */
+static int ixd_iomap_regions(struct ixd_adapter *adapter)
+{
+	const struct ixd_bar_region regions[] = {
+		{
+			.offset = PFGEN_RTRIG,
+			.size = PFGEN_RTRIG_REG_LEN,
+		},
+		{
+			.offset = PF_FW_MBX,
+			.size = PF_FW_MBX_REG_LEN,
+		},
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(regions); i++) {
+		struct libie_mmio_info *mmio_info = &adapter->hw;
+		bool map_ok;
+
+		map_ok = libie_pci_map_mmio_region(mmio_info,
+						   regions[i].offset,
+						   regions[i].size);
+		if (!map_ok) {
+			dev_err(ixd_to_dev(adapter),
+				"Failed to map PCI device MMIO region\n");
+
+			libie_pci_unmap_all_mmio_regions(mmio_info);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * ixd_probe - probe a CPF PCI device
+ * @pdev: corresponding PCI device
+ * @ent: entry in ixd_pci_tbl
+ *
+ * Returns: %0 on success, negative errno code on failure
+ */
+static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct ixd_adapter *adapter;
+	int err;
+
+	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
+	if (!adapter)
+		return -ENOMEM;
+	adapter->hw.pdev = pdev;
+	INIT_LIST_HEAD(&adapter->hw.mmio_list);
+
+	err = libie_pci_init_dev(pdev);
+	if (err)
+		return err;
+
+	pci_set_drvdata(pdev, adapter);
+
+	return ixd_iomap_regions(adapter);
+}
+
+static const struct pci_device_id ixd_pci_tbl[] = {
+	{ PCI_VDEVICE(INTEL, IXD_DEV_ID_CPF) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, ixd_pci_tbl);
+
+static struct pci_driver ixd_driver = {
+	.name			= KBUILD_MODNAME,
+	.id_table		= ixd_pci_tbl,
+	.probe			= ixd_probe,
+	.remove			= ixd_remove,
+	.shutdown		= ixd_shutdown,
+};
+module_pci_driver(ixd_driver);
-- 
2.47.1

