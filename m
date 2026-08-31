Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E014353EE0;
	Mon, 31 Aug 2026 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788142468; cv=none; b=tUX6gGOb3Ih7f4zirlPf2N+3rR2jImK6o/ocVzhzszXwlzghZuj2CSP327LO97j5pEiDm68C6sKnzgO2rKeuF1726IMyaFGYx0Jfs7pG0ZaxiWAIAKNEAd3tvRbjOoh+jdaArdAg+keUIPV6x5b4eJPg7kGUcWl/608ejUVsuJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788142468; c=relaxed/simple;
	bh=sB0PKbquyoGpd30fiiwzMHQB7i1uAAELj7R3XbXi29M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rG05gCEZubqeAqZqHZMX1rLoIfA1L3Cx+meJqiU4PO63I/tAshsKJAdnJlsbAwZN3suu48s6RgUKADw/FqNvphEj6HPTgFyS7qducXnxd6p/ie/+EqNUJeZXaQjS9B/OMd7nXoTjeGSi4PKb2V4P2JNLK6ZkL9iAWpOu3hjQffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00369886-0.00174862-0.994552;FP=16600101634756461750|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.j0lvzVV_1788142452;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.j0lvzVV_1788142452 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 10:14:13 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v26 net-next 02/10] net/nebula-matrix: add core driver architecture and HW layer initialization
Date: Mon, 31 Aug 2026 10:13:53 +0800
Message-ID: <20260831021408.2325-3-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831021408.2325-1-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

Add the fundamental driver architecture framework and Leonis hardware
layer initialization for NBL NIC family.

- nbl_adapter/nbl_core/nbl_common_info core device context
- PCI probe/remove entry and basic device capability parsing
- Leonis hardware BAR resource request and ioremap logic

This patch establishes the lowest HW layer and core infrastructure,
preparing for subsequent device implementations.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   3 +-
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  18 +++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 152 ++++++++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  14 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |  32 ++++
 .../nbl/nbl_include/nbl_def_common.h          |  32 ++++
 .../nbl/nbl_include/nbl_def_hw.h              |  17 ++
 .../nbl/nbl_include/nbl_include.h             |   9 ++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  94 ++++++++++-
 9 files changed, 369 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 6c14d1071c0c..cc060cf8bf75 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -3,4 +3,5 @@
 
 obj-$(CONFIG_NBL) := nbl.o
 
-nbl-objs +=	nbl_main.o
+nbl-objs +=	nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+		nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index a3d63c698aea..1cd6587a8fcb 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -6,8 +6,26 @@
 #ifndef _NBL_CORE_H_
 #define _NBL_CORE_H_
 
+#include <linux/pci.h>
+#include "nbl_include/nbl_include.h"
+#include "nbl_include/nbl_def_common.h"
+
 enum {
 	NBL_CAP_HAS_NET_BIT,
 };
 
+struct nbl_core {
+	struct nbl_hw_mgt *hw_mgt;
+};
+
+struct nbl_adapter {
+	struct pci_dev *pdev;
+	struct nbl_core core;
+	struct nbl_common_info common;
+};
+
+struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
+				  struct nbl_init_param *param);
+void nbl_core_remove(struct nbl_adapter *adapter);
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
new file mode 100644
index 000000000000..a67d1a674466
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/bitfield.h>
+#include "nbl_hw_leonis.h"
+
+/* Structure starts here, adding an op should not modify anything below */
+static struct nbl_hw_mgt *nbl_hw_setup_hw_mgt(struct nbl_common_info *common)
+{
+	struct device *dev = common->dev;
+	struct nbl_hw_mgt *hw_mgt;
+
+	hw_mgt = devm_kzalloc(dev, sizeof(*hw_mgt), GFP_KERNEL);
+	if (!hw_mgt)
+		return ERR_PTR(-ENOMEM);
+
+	hw_mgt->common = common;
+
+	return hw_mgt;
+}
+
+static int nbl_pcim_request_selected_bars(struct pci_dev *pdev, u32 mask,
+					  const char *name)
+{
+	int bar;
+	int ret;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!(mask & BIT(bar)))
+			continue;
+		ret = pcim_request_region(pdev, bar, name);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+int nbl_hw_init_leonis(struct nbl_adapter *adapter)
+{
+	resource_size_t expect_sz = NBL_MEM_BAR_TOTAL_SIZE;
+	struct nbl_common_info *common = &adapter->common;
+	struct pci_dev *pdev = common->pdev;
+	struct nbl_hw_mgt *hw_mgt = NULL;
+	resource_size_t bar_len;
+	u32 bar_mask;
+	int ret;
+
+	hw_mgt = nbl_hw_setup_hw_mgt(common);
+	if (IS_ERR(hw_mgt)) {
+		ret = PTR_ERR(hw_mgt);
+		goto setup_mgt_fail;
+	}
+	bar_mask = BIT(NBL_MEMORY_BAR) | BIT(NBL_MAILBOX_BAR);
+	ret = nbl_pcim_request_selected_bars(pdev, bar_mask, NBL_DRIVER_NAME);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Request memory bar failed, err = %d\n",
+			ret);
+		goto setup_mgt_fail;
+	}
+
+	bar_len = pci_resource_len(pdev, NBL_MEMORY_BAR);
+	if (!(pci_resource_flags(pdev, NBL_MEMORY_BAR) & IORESOURCE_MEM)) {
+		dev_err(&pdev->dev, "MEMORY BAR is not memory resource\n");
+		ret = -EINVAL;
+		goto setup_mgt_fail;
+	}
+	if (common->has_ctrl) {
+		/*
+		 * Hardware layout: MEMORY BAR total size is 64M.
+		 * The tail NBL_RDMA_NOTIFY_LEN bytes of the 64M BAR are
+		 * reserved exclusively for RDMA notify hardware.
+		 * Ethernet driver must avoid mapping this reserved tail
+		 * to prevent x86 PAT aliasing conflict between eth net
+		 * mapping and RDMA driver WC mapping. Mapping starts
+		 * at BAR offset 0.
+		 *
+		 * Skip trailing NBL_RDMA_NOTIFY_LEN bytes at BAR tail.
+		 * Round size down to page boundary to avoid ioremap
+		 * rounding up and accidentally including RDMA reserved
+		 * region when PAGE_SIZE > 8KiB.
+		 */
+		if (bar_len < NBL_MEM_BAR_TOTAL_SIZE) {
+			dev_err(&pdev->dev,
+				"MEMORY BAR len %pr smaller than expected %pr\n",
+				&bar_len, &expect_sz);
+			ret = -EINVAL;
+			goto setup_mgt_fail;
+		}
+		hw_mgt->hw_size = PAGE_ALIGN_DOWN(NBL_MEM_BAR_TOTAL_SIZE -
+						 NBL_RDMA_NOTIFY_LEN);
+		hw_mgt->hw_addr =
+			pcim_iomap(pdev, NBL_MEMORY_BAR,
+				   hw_mgt->hw_size);
+	} else {
+		if (bar_len < NBL_REG_NET_ONLY_LEN) {
+			dev_err(&pdev->dev,
+				"MEMORY BAR len %pr too small for net only reg space\n",
+				&bar_len);
+			ret = -EINVAL;
+			goto setup_mgt_fail;
+		}
+		hw_mgt->hw_size = NBL_REG_NET_ONLY_LEN;
+		hw_mgt->hw_addr = pcim_iomap(pdev, NBL_MEMORY_BAR,
+					     hw_mgt->hw_size);
+	}
+	if (!hw_mgt->hw_addr) {
+		dev_err(&pdev->dev, "MEMORY BAR pcim_iomap failed\n");
+		ret = -EIO;
+		goto setup_mgt_fail;
+	}
+
+	bar_len = pci_resource_len(pdev, NBL_MAILBOX_BAR);
+	if (!(pci_resource_flags(pdev, NBL_MAILBOX_BAR) & IORESOURCE_MEM)) {
+		dev_err(&pdev->dev, "MAILBOX BAR is not memory resource\n");
+		ret = -EINVAL;
+		goto setup_mgt_fail;
+	}
+	if (bar_len == 0) {
+		dev_err(&pdev->dev, "MAILBOX BAR length is zero\n");
+		ret = -EINVAL;
+		goto setup_mgt_fail;
+	}
+	hw_mgt->mailbox_bar_hw_addr = pcim_iomap(pdev, NBL_MAILBOX_BAR,
+						 bar_len);
+	if (!hw_mgt->mailbox_bar_hw_addr) {
+		dev_err(&pdev->dev, "MAILBOX BAR pcim_iomap failed\n");
+		ret = -EIO;
+		goto setup_mgt_fail;
+	}
+	hw_mgt->mailbox_bar_size = bar_len;
+
+	adapter->core.hw_mgt = hw_mgt;
+
+	return 0;
+
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_hw_remove_leonis(struct nbl_adapter *adapter)
+{
+	/* All BAR mappings & PCI regions are managed by pcim/devres,
+	 * no manual iounmap / release required
+	 */
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
new file mode 100644
index 000000000000..a3397f5be353
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_HW_LEONIS_H_
+#define _NBL_HW_LEONIS_H_
+
+#include <linux/types.h>
+
+#include "../../nbl_include/nbl_include.h"
+#include "../nbl_hw_reg.h"
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
new file mode 100644
index 000000000000..5e9823e01d39
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_HW_REG_H_
+#define _NBL_HW_REG_H_
+
+#include <linux/types.h>
+
+#include "../nbl_include/nbl_def_hw.h"
+#include "../nbl_include/nbl_def_common.h"
+#include "../nbl_core.h"
+
+#define NBL_MEMORY_BAR				0
+#define NBL_MAILBOX_BAR				2
+#define NBL_RDMA_NOTIFY_LEN			(8ULL << 10)
+#define NBL_REG_NET_ONLY_LEN			(8ULL << 10)
+/*
+ * PCI MEMORY BAR total size: 64MiB.
+ */
+#define NBL_MEM_BAR_TOTAL_SIZE			(64ULL << 20)
+
+struct nbl_hw_mgt {
+	struct nbl_common_info *common;
+	u8 __iomem *hw_addr;
+	u8 __iomem *mailbox_bar_hw_addr;
+	resource_size_t hw_size;
+	resource_size_t mailbox_bar_size;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
new file mode 100644
index 000000000000..da30244fe75d
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_COMMON_H_
+#define _NBL_DEF_COMMON_H_
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include "nbl_include.h"
+
+struct nbl_common_info {
+	struct pci_dev *pdev;
+	struct device *dev;
+	u32 msg_enable;
+	u16 vsi_id;
+	u8 eth_id;
+	u8 logic_eth_id;
+	u8 eth_num;
+
+	u8 function;
+	u8 devid;
+	u8 bus;
+	u8 hw_bus;
+
+	u8 has_ctrl;
+	u8 has_net;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
new file mode 100644
index 000000000000..ecbf440e4366
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_DEF_HW_H_
+#define _NBL_DEF_HW_H_
+
+#include <linux/types.h>
+
+struct nbl_hw_mgt;
+struct nbl_adapter;
+
+int nbl_hw_init_leonis(struct nbl_adapter *adapter);
+void nbl_hw_remove_leonis(struct nbl_adapter *adapter);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 16b10bcf1d36..14e7b19f9a4c 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -10,5 +10,14 @@
 
 /*  ------  Basic definitions  -------  */
 #define NBL_DRIVER_NAME					"nbl"
+struct nbl_func_caps {
+	u32 has_ctrl:1;
+	u32 has_net:1;
+	u32 rsv:30;
+};
+
+struct nbl_init_param {
+	struct nbl_func_caps caps;
+};
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 199626159a4c..f2552bc73293 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -8,16 +8,108 @@
 #include <linux/module.h>
 #include <linux/bits.h>
 #include "nbl_include/nbl_include.h"
+#include "nbl_include/nbl_def_hw.h"
+#include "nbl_include/nbl_def_common.h"
 #include "nbl_core.h"
 
+struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
+				  struct nbl_init_param *param)
+{
+	struct nbl_common_info *common;
+	struct nbl_adapter *adapter;
+	int ret;
+
+	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
+	if (!adapter)
+		return ERR_PTR(-ENOMEM);
+
+	adapter->pdev = pdev;
+	common = &adapter->common;
+
+	common->pdev = pdev;
+	common->dev = &pdev->dev;
+	common->has_ctrl = param->caps.has_ctrl;
+	common->has_net = param->caps.has_net;
+	common->function = PCI_FUNC(pdev->devfn);
+	common->devid = PCI_SLOT(pdev->devfn);
+	common->bus = pdev->bus->number;
+
+	ret = nbl_hw_init_leonis(adapter);
+	if (ret)
+		goto hw_init_fail;
+
+	return adapter;
+hw_init_fail:
+	return ERR_PTR(ret);
+}
+
+void nbl_core_remove(struct nbl_adapter *adapter)
+{
+	nbl_hw_remove_leonis(adapter);
+}
+
+static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
+			       struct nbl_init_param *param)
+{
+	param->caps.has_net = !!(driver_data & BIT(NBL_CAP_HAS_NET_BIT));
+
+	/*
+	 * Hardware fixed rule: physical PF0 is the only management PF with
+	 * global ctrl capability. All PFs share identical PCI device ID, so
+	 * distinguish control PF via physical function ID.
+	 *
+	 * Hardware & firmware design FORBID passing any PF through to virtual
+	 * machines, there is no scenario where a non-management PF appears
+	 * as Func 0 inside guest. Thus using PCI_FUNC(pdev->devfn) to identify
+	 *  control PF is safe on our platform.
+	 */
+	if ((PCI_FUNC(pdev->devfn) == 0) && !pdev->is_virtfn)
+		param->caps.has_ctrl = 1;
+}
+
 static int nbl_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *id)
 {
-	return -ENODEV;
+	struct nbl_init_param param = { { 0 } };
+	struct device *dev = &pdev->dev;
+	struct nbl_adapter *adapter;
+	int err;
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to enable PCI dev, err=%d\n", err);
+		return err;
+	}
+
+	nbl_get_func_param(pdev, id->driver_data, &param);
+	/* never return fail when DMA_BIT_MASK(64) */
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
+	pci_set_master(pdev);
+
+	adapter = nbl_core_init(pdev, &param);
+	if (IS_ERR(adapter)) {
+		dev_err(dev, "Nbl adapter init fail: %pe\n", adapter);
+		err = PTR_ERR(adapter);
+		goto adapter_init_err;
+	}
+	pci_set_drvdata(pdev, adapter);
+	return 0;
+adapter_init_err:
+	pci_clear_master(pdev);
+	return err;
 }
 
 static void nbl_remove(struct pci_dev *pdev)
 {
+	struct nbl_adapter *adapter = pci_get_drvdata(pdev);
+
+	if (!adapter)
+		return;
+	pci_set_drvdata(pdev, NULL);
+	nbl_core_remove(adapter);
+
+	pci_clear_master(pdev);
 }
 
 /*
-- 
2.47.3

