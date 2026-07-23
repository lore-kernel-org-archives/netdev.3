Received: from out198-7.us.a.mail.aliyun.com (out198-7.us.a.mail.aliyun.com [47.90.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFAF36C0AB;
	Thu, 23 Jul 2026 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784779618; cv=none; b=m8p4vuB+8HbQxhs+v7lRHzlK4x5279mBKV2S0Lb/Uqs7qcUl0l8YmiKom1irOZ5T++jkwUCyeodqpcICjBNeka8jSV6MUsZMSRqTCKRb0q8wxdug8v0cQQnqCJYl0CwIjsgOGii/Ufpuo6aVUqXnYcVIH/z6EfeUP5wuK8o92us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784779618; c=relaxed/simple;
	bh=TB1aP02M/wksmffi/wwTPFR3ibh+yjoU0K/9EPGZ+UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRk3vcLTcFQUF9ZTRphXthw1nQNNpuQVHDp7pVTxRS1FDZR454EbUnSEautdJ/Hjh2CqzjwH0aZ616BZ4Qee1nbFtBKsI7SmWp6OBgDO6R9QCO81yu4rwFmTzCA1gP5aQbi0w7z33ks8JV08eY7qlCmdhPRsxNFILtd/yjfGWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00389911-0.00286044-0.99324;FP=17789052485869651638|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iSkYuNz_1784779275;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iSkYuNz_1784779275 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 23 Jul 2026 12:01:15 +0800
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
Subject: [PATCH v22 net-next 02/12] net/nebula-matrix: add core driver architecture and HW layer initialization
Date: Thu, 23 Jul 2026 12:00:54 +0800
Message-ID: <20260723040110.91410-3-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723040110.91410-1-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-1-illusion.wang@nebula-matrix.com>
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
- 64/32-bit DMA mask fallback and PCI master setup
- Leonis hardware BAR resource request and ioremap logic

This patch establishes the lowest HW layer and core infrastructure,
preparing for subsequent device implementations.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   3 +-
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  19 +++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 150 ++++++++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  14 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |  28 ++++
 .../nbl/nbl_include/nbl_def_common.h          |  32 ++++
 .../nbl/nbl_include/nbl_def_hw.h              |  21 +++
 .../nbl/nbl_include/nbl_include.h             |   9 ++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c | 106 ++++++++++++-
 9 files changed, 380 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index b90fba239401..caa863d3a582 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -3,4 +3,5 @@
 
 obj-$(CONFIG_NBL) := nbl.o
 
-nbl-objs +=      nbl_main.o
+nbl-objs +=       nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index ef083956c695..7ae331959ca1 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -6,9 +6,28 @@
 #ifndef _NBL_CORE_H_
 #define _NBL_CORE_H_
 
+#include <linux/pci.h>
+#include "nbl_include/nbl_include.h"
+#include "nbl_include/nbl_def_common.h"
+
+struct nbl_hw_mgt;
+
 enum {
 	NBL_CAP_HAS_CTRL_BIT,
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
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
new file mode 100644
index 000000000000..79a4b15c01a9
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
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
+		 * The fixed 16MiB MEMORY BAR of PF0 contains both control
+		 * register region and the 8KiB RDMA notify partition inside
+		 * this single 16MiB window. The RDMA notify area does not
+		 * occupy extra space outside the BAR range.
+		 * We only map the front part of BAR by cutting off the last
+		 * NBL_RDMA_NOTIFY_LEN bytes for hardware exclusive RDMA
+		 * notification use,
+		 * so the mapping length equals bar_len - NBL_RDMA_NOTIFY_LEN.
+		 * Since the RDMA notify region is internal to the 16MiB BAR,
+		 * the minimum BAR size check remains bar_len >=
+		 * NBL_HW_REG_SPACE_SIZE to ensure full register space is
+		 * available.
+		 */
+		if (bar_len < NBL_HW_REG_SPACE_SIZE) {
+			dev_err(&pdev->dev,
+				"MEMORY BAR len %pa too small for ctrl reg space\n",
+				&bar_len);
+			ret = -EINVAL;
+			goto setup_mgt_fail;
+		}
+
+		hw_mgt->hw_size = bar_len - NBL_RDMA_NOTIFY_LEN;
+		hw_mgt->hw_addr =
+			pcim_iomap(pdev, NBL_MEMORY_BAR,
+				   hw_mgt->hw_size);
+	} else {
+		if (bar_len < NBL_REG_NET_ONLY_LEN) {
+			dev_err(&pdev->dev,
+				"MEMORY BAR len %pa too small for net only reg space\n",
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
index 000000000000..77c67b67ba31
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
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
index 000000000000..af9706ebbc73
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
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
+#define NBL_HW_REG_SPACE_SIZE			(16ULL << 20)
+
+struct nbl_hw_mgt {
+	struct nbl_common_info *common;
+	u8 __iomem *hw_addr;
+	u8 __iomem *mailbox_bar_hw_addr;
+	resource_size_t hw_size;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
new file mode 100644
index 000000000000..5b7ec68d620b
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
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
index 000000000000..ab97956582b4
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
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
+struct nbl_hw_ops_tbl {
+	struct nbl_hw_mgt *priv;
+};
+
+int nbl_hw_init_leonis(struct nbl_adapter *adapter);
+void nbl_hw_remove_leonis(struct nbl_adapter *adapter);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index cd99f96e1568..70f4f4b4c49c 100644
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
index 7c969c854bdc..aa14b827abea 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -8,16 +8,120 @@
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
+	 * Only PF0 possesses ctrl capability; all PFs share identical PCI
+	 * device ID, so we handle this via special function ID judgement.
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
+	int dma_32_err;
+	int err;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to enable PCI dev, err=%d\n", err);
+		return err;
+	}
+	err = pci_save_state(pdev);
+	if (err) {
+		dev_err(dev, "Save pci state failed %d\n", err);
+		goto configure_dma_err;
+	}
+	nbl_get_func_param(pdev, id->driver_data, &param);
+
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_dbg(dev, "Configure DMA 64 bit mask failed, err = %d\n",
+			err);
+		dma_32_err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (dma_32_err) {
+			dev_err(dev,
+				"Configure DMA 32 bit mask failed, dma_32_err = %d\n",
+				dma_32_err);
+			err = dma_32_err;
+			goto configure_dma_err;
+		}
+	}
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
+configure_dma_err:
+	pci_disable_device(pdev);
+	return err;
 }
 
 static void nbl_remove(struct pci_dev *pdev)
 {
+	struct nbl_adapter *adapter = pci_get_drvdata(pdev);
+
+	if (adapter)
+		nbl_core_remove(adapter);
+
+	pci_restore_state(pdev);
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
 }
 
 /*
-- 
2.47.3

