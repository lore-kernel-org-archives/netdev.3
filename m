Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D221C16A;
	Sun,  2 Aug 2026 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785658877; cv=none; b=kVsGI997MFws7gyD8DwLE54cAMB8n2JakYPRsQGV4FXJ1pz1qcv9bMDtvZLnLOFvmvpTCHoBmJY1L2bDBEQtC3pqbEDN+qryZJrXrYGMnQQOahNp/S2JV33ZIOZxeQ/S1BWGKyIzgdysIfzADBDlP3lKzdqngT1W3XvO4cYVM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785658877; c=relaxed/simple;
	bh=HG9A6NY1tvh9TrmCGlsZylls0emvvxd/8Z9geZLiY0Y=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=g+P6GQybX0WdFdMKqTxiGlHBbW2eNQgjl4b5G4hJ5vqizBTOSE96+egdweq0wYEMsQRbX1zFl1UbiD7jFLyA4xi2uJ/pu1jCy7F2HLJDGy1mCsPbxqtxRqeMXUXoHRxdS6vf1ixEkiQHvGCtbmDClfN56IZezxjRYfx3DWr60c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4hCXnd3wHRz55y22;
	Sun, 02 Aug 2026 16:21:09 +0800 (CST)
Received: from njy2app02.zte.com.cn ([10.40.13.116])
	by mse-fl2.zte.com.cn with SMTP id 6728L2Sd036287;
	Sun, 2 Aug 2026 16:21:02 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njb2app07[null])
	by mapi (Zmail) with MAPI id mid204;
	Sun, 2 Aug 2026 16:21:04 +0800 (CST)
X-Zmail-TransId: 2aff6a6efdf0866-914ba
X-Mailer: Zmail v1.0
Message-ID: <202608021621043761zZMwCny1e6y0TRFLQHxx@zte.com.cn>
In-Reply-To: <20260802160048653KdUvSUgDsEs4zwYF9Ey0q@zte.com.cn>
References: 20260802160048653KdUvSUgDsEs4zwYF9Ey0q@zte.com.cn
Date: Sun, 2 Aug 2026 16:21:04 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYxMCAxLzJdIGRpbmdoYWk6IGFkZCBaVEUgbmV0d29yayBkcml2ZXIgc3VwcG9ydA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6728L2Sd036287
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 02 Aug 2026 16:21:09 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6EFDF5.000/4hCXnd3wHRz55y22

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
 drivers/net/ethernet/zte/dinghai/Kconfig  |  34 +++++
 drivers/net/ethernet/zte/dinghai/Makefile |   7 +
 drivers/net/ethernet/zte/dinghai/en_pf.c  | 174 ++++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h  |  29 ++++
 9 files changed, 278 insertions(+)
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
index 000000000000..e2f4da33df59
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for ZTE DingHai Ethernet driver
+#
+
+obj-$(CONFIG_DINGHAI_PF) += dinghai10e.o
+dinghai10e-y := en_pf.o
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
new file mode 100644
index 000000000000..e7ff6954e745
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
@@ -0,0 +1,174 @@
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
+	dma_set_mask_and_coherent(zxdh_dev->device, DMA_BIT_MASK(64));
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
+	struct zxdh_core_dev *zxdh_dev;
+	struct zxdh_pf_dev *pf_dev;
+	struct devlink *devlink;
+	int ret;
+
+	devlink = devlink_alloc(&zxdh_pf_devlink_ops, sizeof(struct zxdh_core_dev),
+				&pdev->dev);
+	if (!devlink)
+		return -ENOMEM;
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
+	ret = zxdh_pf_pci_init(zxdh_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "zxdh_pf_pci_init failed: %d\n", ret);
+		goto err_pci_init;
+	}
+
+	devlink_register(devlink);
+
+	return 0;
+
+err_pci_init:
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
+
+	devlink_unregister(devlink);
+	zxdh_pf_pci_close(zxdh_dev);
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
index 000000000000..f6b9dc94a57d
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ZTE DingHai Ethernet driver - PF header
+ * Copyright (c) 2022-2026, ZTE Corporation.
+ */
+
+#ifndef __ZXDH_EN_PF_H__
+#define __ZXDH_EN_PF_H__
+
+#define ZXDH_PF_VENDOR_ID	0x1cf2
+#define ZXDH_PF_DEVICE_ID	0x8040
+#define ZXDH_VF_DEVICE_ID	0x8041
+
+struct zxdh_core_dev {
+	struct device *device;
+	struct pci_dev *pdev;
+	struct devlink *devlink;
+	void *priv;
+};
+
+struct zxdh_pf_dev {
+	void __iomem *pci_ioremap_addr[6];
+};
+
+void *zxdh_core_alloc_priv(struct zxdh_core_dev *zxdh_dev, size_t size);
+void zxdh_core_free_priv(struct zxdh_core_dev *zxdh_dev);
+void zxdh_pf_pci_close(struct zxdh_core_dev *zxdh_dev);
+
+#endif /* __ZXDH_EN_PF_H__ */
-- 
2.27.0
