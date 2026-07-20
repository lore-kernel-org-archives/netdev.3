Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA71395AFC;
	Mon, 20 Jul 2026 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542277; cv=none; b=PY/Bgv34l5hCx28hhsx2V1Y2Yi3odMuNqv7vJY0LcrfUQ9D2oiS9RBI++2bDHL5Jqx37KzezH4ty07wV51tTnaNAcdikjq0Xsbygxevp9bZqWLwZAOjnBZp+syRW/FnIsZO7pF0bP8H6ECWcuC4tc/pMqFrblMmOBJKysyho1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542277; c=relaxed/simple;
	bh=0OxFYN5ylfO3R2r18ARrAbPOIBje9R2kiMtQe3JQlFQ=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=VRXBczMiJ+nosuXbKtiQTsR7gYyRQDvNBO3fmXO3l5MfDN1NpC2pfLGn5BdTHx0JyeN4QpLziQuiXvOHwYN4WOE+8XybGvI+wdnAM1XW01RoLd4wBDM98m45Ht0vOCc02t0fyn0T3ZgTU9Kz03Y5Wz4X6eTUrV9LGkwVuTHPREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h3brT3MzCz5BNS0;
	Mon, 20 Jul 2026 18:11:05 +0800 (CST)
Received: from njb2app06.zte.com.cn ([10.55.23.119])
	by mse-fl1.zte.com.cn with SMTP id 66KAAojP080382;
	Mon, 20 Jul 2026 18:10:50 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njy2app08[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 20 Jul 2026 18:10:53 +0800 (CST)
X-Zmail-TransId: 2b006a5df42d14b-4b790
X-Mailer: Zmail v1.0
Message-ID: <20260720181053485hNsVefbU8Lb_Ez3IvfHFG@zte.com.cn>
In-Reply-To: <20260720180651288d3b9DAp__Lfvo2x2PkMfC@zte.com.cn>
References: 20260720180651288d3b9DAp__Lfvo2x2PkMfC@zte.com.cn
Date: Mon, 20 Jul 2026 18:10:53 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY5IDEvMl0gZGluZ2hhaTogYWRkIFpURSBuZXR3b3JrIGRyaXZlciBzdXBwb3J0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 66KAAojP080382
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 20 Jul 2026 18:11:05 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A5DF439.001/4h3brT3MzCz5BNS0

From: Junyang Han <han.junyang@zte.com.cn>

Add basic framework for ZTE DingHai ethernet PF driver, including
Kconfig/Makefile build support and PCIe device probe/remove skeleton.

Signed-off-by: Junyang Han <han.junyang@zte.com.cn>
---
 MAINTAINERS                               |   6 +
 drivers/net/ethernet/Kconfig              |   1 +
 drivers/net/ethernet/Makefile             |   1 +
 drivers/net/ethernet/zte/Kconfig          |  20 +++
 drivers/net/ethernet/zte/Makefile         |   6 +
 drivers/net/ethernet/zte/dinghai/Kconfig  |  34 ++++
 drivers/net/ethernet/zte/dinghai/Makefile |   9 +
 drivers/net/ethernet/zte/dinghai/en_pf.c  | 195 ++++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h  |  52 ++++++
 9 files changed, 324 insertions(+)
 create mode 100644 drivers/net/ethernet/zte/Kconfig
 create mode 100644 drivers/net/ethernet/zte/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/Kconfig
 create mode 100644 drivers/net/ethernet/zte/dinghai/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..73692b09bf7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29440,6 +29440,12 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 F:	sound/hda/codecs/senarytech.c

+ZTE DINGHAI ETHERNET DRIVER
+M:	Junyang Han <han.junyang@zte.com.cn>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/zte/
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index b8f70e2a1763..c2b6996b0cfe 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -188,5 +188,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
 source "drivers/net/ethernet/wiznet/Kconfig"
 source "drivers/net/ethernet/xilinx/Kconfig"
 source "drivers/net/ethernet/xircom/Kconfig"
+source "drivers/net/ethernet/zte/Kconfig"

 endif # ETHERNET
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 57344fec6ce0..a34bcbd4df4e 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -104,3 +104,4 @@ obj-$(CONFIG_NET_VENDOR_XIRCOM) += xircom/
 obj-$(CONFIG_NET_VENDOR_SYNOPSYS) += synopsys/
 obj-$(CONFIG_NET_VENDOR_PENSANDO) += pensando/
 obj-$(CONFIG_OA_TC6) += oa_tc6.o
+obj-$(CONFIG_NET_VENDOR_ZTE) += zte/
diff --git a/drivers/net/ethernet/zte/Kconfig b/drivers/net/ethernet/zte/Kconfig
new file mode 100644
index 000000000000..b95c2fc7db77
--- /dev/null
+++ b/drivers/net/ethernet/zte/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ZTE driver configuration
+#
+
+config NET_VENDOR_ZTE
+    bool "ZTE devices"
+    default y
+    help
+      If you have a network (Ethernet) card belonging to this class, say Y.
+      Note that the answer to this question doesn't directly affect the
+      kernel: saying N will just cause the configurator to skip all
+      the questions about Zte cards. If you say Y, you will be asked
+      for your specific card in the following questions.
+
+if NET_VENDOR_ZTE
+
+source "drivers/net/ethernet/zte/dinghai/Kconfig"
+
+endif # NET_VENDOR_ZTE
diff --git a/drivers/net/ethernet/zte/Makefile b/drivers/net/ethernet/zte/Makefile
new file mode 100644
index 000000000000..cd9929b61559
--- /dev/null
+++ b/drivers/net/ethernet/zte/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the ZTE device drivers
+#
+
+obj-$(CONFIG_DINGHAI) += dinghai/
diff --git a/drivers/net/ethernet/zte/dinghai/Kconfig b/drivers/net/ethernet/zte/dinghai/Kconfig
new file mode 100644
index 000000000000..121be3bf7707
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ZTE DingHai Ethernet driver configuration
+#
+
+config DINGHAI
+    bool "ZTE DingHai Ethernet driver"
+    depends on PCI
+    select NET_DEVLINK
+    help
+      This driver supports ZTE DingHai Ethernet devices.
+
+      DingHai is a high-performance Ethernet controller that supports
+      multiple features including hardware offloading, SR-IOV, and
+      advanced virtualization capabilities.
+
+      If you say Y here, you can select specific driver variants below.
+
+      If unsure, say N.
+
+if DINGHAI
+
+config DINGHAI_PF
+    tristate "ZTE DingHai PF (Physical Function) driver"
+    help
+      This driver supports ZTE DingHai PCI Express Ethernet
+      adapters (PF).
+
+      To compile this driver as a module, choose M here. The module
+      will be named dinghai10e.
+
+      If unsure, say N.
+
+endif # DINGHAI
diff --git a/drivers/net/ethernet/zte/dinghai/Makefile b/drivers/net/ethernet/zte/dinghai/Makefile
new file mode 100644
index 000000000000..10df4eb79e80
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for ZTE DingHai Ethernet driver
+#
+
+ccflags-y += -I$(src)
+
+obj-$(CONFIG_DINGHAI_PF) += dinghai10e.o
+dinghai10e-y := en_pf.o
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
new file mode 100644
index 000000000000..27ab35d69920
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ZTE DingHai Ethernet driver
+ * Copyright (c) 2022-2026, ZTE Corporation.
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <net/devlink.h>
+#include <linux/dma-mapping.h>
+#include "en_pf.h"
+
+MODULE_AUTHOR("Junyang Han <han.junyang@zte.com.cn>");
+MODULE_DESCRIPTION("ZTE DingHai series Ethernet driver");
+MODULE_LICENSE("GPL");
+
+static const struct devlink_ops zxdh_pf_devlink_ops = {};
+
+static const struct pci_device_id zxdh_pf_pci_table[] = {
+	{ PCI_DEVICE(ZXDH_PF_VENDOR_ID, ZXDH_PF_DEVICE_ID) },
+	{ PCI_DEVICE(ZXDH_PF_VENDOR_ID, ZXDH_VF_DEVICE_ID) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, zxdh_pf_pci_table);
+
+void *zxdh_core_alloc_priv(struct zxdh_core_dev *zxdh_dev, size_t size)
+{
+	void *priv = kzalloc(size, GFP_KERNEL);
+
+	if (priv)
+		zxdh_dev->priv = priv;
+	return priv;
+}
+
+void zxdh_core_free_priv(struct zxdh_core_dev *zxdh_dev)
+{
+	kfree(zxdh_dev->priv);
+}
+
+static int zxdh_pf_pci_init(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+	int ret;
+
+	pci_set_drvdata(zxdh_dev->pdev, zxdh_dev);
+
+	ret = pci_enable_device(zxdh_dev->pdev);
+	if (ret) {
+		dev_err(zxdh_dev->device, "pci_enable_device failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = dma_set_mask_and_coherent(zxdh_dev->device, DMA_BIT_MASK(64));
+	if (ret) {
+		ret = dma_set_mask_and_coherent(zxdh_dev->device, DMA_BIT_MASK(32));
+		if (ret) {
+			dev_err(zxdh_dev->device, "dma_set_mask_and_coherent failed: %d\n", ret);
+			goto err_pci;
+		}
+	}
+
+	ret = pci_request_selected_regions(zxdh_dev->pdev,
+					   pci_select_bars(zxdh_dev->pdev, IORESOURCE_MEM),
+					   "dh-pf");
+	if (ret) {
+		dev_err(zxdh_dev->device, "pci_request_selected_regions failed: %d\n", ret);
+		goto err_pci;
+	}
+
+	pci_set_master(zxdh_dev->pdev);
+	ret = pci_save_state(zxdh_dev->pdev);
+	if (ret) {
+		dev_err(zxdh_dev->device, "pci_save_state failed: %d\n", ret);
+		goto err_pci_save_state;
+	}
+
+	if (!(pci_resource_flags(zxdh_dev->pdev, 0) & IORESOURCE_MEM)) {
+		ret = -ENODEV;
+		dev_err(zxdh_dev->device, "BAR 0 is not an MMIO resource\n");
+		goto err_pci_save_state;
+	}
+
+	pf_dev->pci_ioremap_addr[0] =
+		ioremap(pci_resource_start(zxdh_dev->pdev, 0),
+			pci_resource_len(zxdh_dev->pdev, 0));
+	if (!pf_dev->pci_ioremap_addr[0]) {
+		ret = -ENOMEM;
+		dev_err(zxdh_dev->device, "dh pf pci ioremap failed\n");
+		goto err_pci_save_state;
+	}
+
+	return 0;
+
+err_pci_save_state:
+	pci_release_selected_regions(zxdh_dev->pdev,
+				     pci_select_bars(zxdh_dev->pdev, IORESOURCE_MEM));
+err_pci:
+	pci_disable_device(zxdh_dev->pdev);
+	return ret;
+}
+
+void zxdh_pf_pci_close(struct zxdh_core_dev *zxdh_dev)
+{
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+
+	iounmap(pf_dev->pci_ioremap_addr[0]);
+	pci_release_selected_regions(zxdh_dev->pdev,
+				     pci_select_bars(zxdh_dev->pdev, IORESOURCE_MEM));
+	pci_disable_device(zxdh_dev->pdev);
+}
+
+static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct zxdh_pf_dev *pf_dev;
+	struct zxdh_core_dev *zxdh_dev;
+	struct devlink *devlink;
+	int ret;
+
+	devlink = devlink_alloc(&zxdh_pf_devlink_ops, sizeof(struct zxdh_core_dev),
+				&pdev->dev);
+	if (!devlink) {
+		dev_err(&pdev->dev, "zxdh_pf devlink alloc failed\n");
+		return -ENOMEM;
+	}
+
+	zxdh_dev = devlink_priv(devlink);
+	zxdh_dev->device = &pdev->dev;
+	zxdh_dev->pdev = pdev;
+	zxdh_dev->devlink = devlink;
+
+	pf_dev = zxdh_core_alloc_priv(zxdh_dev, sizeof(*pf_dev));
+	if (!pf_dev) {
+		dev_err(&pdev->dev, "zxdh_pf_dev alloc failed\n");
+		ret = -ENOMEM;
+		goto err_pf_dev;
+	}
+
+	pf_dev->bar_chan_valid = false;
+	pf_dev->vepa = false;
+	mutex_init(&zxdh_dev->lock);
+	mutex_init(&pf_dev->irq_lock);
+
+	zxdh_dev->coredev_type = GET_COREDEV_TYPE(pdev);
+
+	ret = zxdh_pf_pci_init(zxdh_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "zxdh_pf_pci_init failed: %d\n", ret);
+		goto err_cfg_init;
+	}
+
+	devlink_register(devlink);
+
+	return 0;
+
+err_cfg_init:
+	mutex_destroy(&pf_dev->irq_lock);
+	mutex_destroy(&zxdh_dev->lock);
+	zxdh_core_free_priv(zxdh_dev);
+err_pf_dev:
+	devlink_free(devlink);
+	return ret;
+}
+
+static void zxdh_pf_remove(struct pci_dev *pdev)
+{
+	struct zxdh_core_dev *zxdh_dev = pci_get_drvdata(pdev);
+	struct devlink *devlink = priv_to_devlink(zxdh_dev);
+	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
+
+	devlink_unregister(devlink);
+	zxdh_pf_pci_close(zxdh_dev);
+	mutex_destroy(&pf_dev->irq_lock);
+	mutex_destroy(&zxdh_dev->lock);
+	zxdh_core_free_priv(zxdh_dev);
+	devlink_free(devlink);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static void zxdh_pf_shutdown(struct pci_dev *pdev)
+{
+	if (system_state == SYSTEM_POWER_OFF)
+		pci_set_power_state(pdev, PCI_D3hot);
+	pci_disable_device(pdev);
+}
+
+static struct pci_driver zxdh_pf_driver = {
+	.name = "dinghai10e",
+	.id_table = zxdh_pf_pci_table,
+	.probe = zxdh_pf_probe,
+	.remove = zxdh_pf_remove,
+	.shutdown = zxdh_pf_shutdown,
+};
+
+module_pci_driver(zxdh_pf_driver);
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.h b/drivers/net/ethernet/zte/dinghai/en_pf.h
new file mode 100644
index 000000000000..65eac936505b
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ZTE DingHai Ethernet driver - PF header
+ * Copyright (c) 2022-2026, ZTE Corporation.
+ */
+
+#ifndef __ZXDH_EN_PF_H__
+#define __ZXDH_EN_PF_H__
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+
+#define ZXDH_PF_VENDOR_ID	0x1cf2
+#define ZXDH_PF_DEVICE_ID	0x8040
+#define ZXDH_VF_DEVICE_ID	0x8041
+
+enum zxdh_coredev_type {
+	DH_COREDEV_PF,
+	DH_COREDEV_VF,
+	DH_COREDEV_SF,
+	DH_COREDEV_MPF
+};
+
+struct devlink;
+
+struct zxdh_core_dev {
+	struct device *device;
+	enum zxdh_coredev_type coredev_type;
+	struct pci_dev *pdev;
+	struct devlink *devlink;
+	struct mutex lock; /* Protects device configuration */
+	void *priv;
+};
+
+struct zxdh_pf_dev {
+	void __iomem *pci_ioremap_addr[6];
+	bool bar_chan_valid;
+	bool vepa;
+	struct mutex irq_lock; /* Protects IRQ operations */
+};
+
+#define GET_COREDEV_TYPE(pdev) \
+	((pdev)->device == ZXDH_VF_DEVICE_ID ? DH_COREDEV_VF : DH_COREDEV_PF)
+
+void *zxdh_core_alloc_priv(struct zxdh_core_dev *zxdh_dev, size_t size);
+void zxdh_core_free_priv(struct zxdh_core_dev *zxdh_dev);
+void zxdh_pf_pci_close(struct zxdh_core_dev *zxdh_dev);
+
+#endif /* __ZXDH_EN_PF_H__ */
-- 
2.27.0
