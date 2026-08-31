Received: from out198-2.us.a.mail.aliyun.com (out198-2.us.a.mail.aliyun.com [47.90.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1E356754;
	Mon, 31 Aug 2026 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788142790; cv=none; b=q801/5mqVfOPXj8Tw1VeyTctYrvmVea2KjJA1guKDsHvRs6Muz7oQU/5NoteGs6/sWaenaq8Nh/YGJgeOb9kOHFdWq4kXe6BBxH6Q1TsyY+jcYsGvIy4xLJf1gbs5oPAx0/9KVmQb29UkyCCdp5b0MwjLVd48Oy7rZ+Wt8MSQ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788142790; c=relaxed/simple;
	bh=8X845z1Tq4pmWOJYXxFI50uAyB/ZneALwqYURPUF1pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luBNbqssvUjgpgwIGeXk4G7i7/jZKoFxEMHhgRSuMMvzSWOCk5btDx7qI1sfVohGN15UyIZXNmx0uEye3+xHaA0roCEybjsostsK5cUw7rdjIrOD7AbK1yt7emHIMcw3bLiZNv7nHxCTd2lPtkPB3ITEno8Dpruf1uIPqGGcJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0678256|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0331837-0.00316563-0.963651;FP=17173382588434751154|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.j0lvzRy_1788142451;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.j0lvzRy_1788142451 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 10:14:12 +0800
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
Subject: [PATCH v26 net-next 01/10] net/nebula-matrix: add minimum nbl build framework
Date: Mon, 31 Aug 2026 10:13:52 +0800
Message-ID: <20260831021408.2325-2-illusion.wang@nebula-matrix.com>
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

This patch adds the minimum build infrastructure:
1. Add Kconfig, Makefile and MAINTAINERS entries;
2. Add corresponding driver documentation;
3. Add PCI driver skeleton with empty stubs for nbl driver.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../ethernet/nebula-matrix/nbl.rst            |  28 +++++
 MAINTAINERS                                   |  10 ++
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/nebula-matrix/Kconfig    |  31 ++++++
 drivers/net/ethernet/nebula-matrix/Makefile   |   6 ++
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   6 ++
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  13 +++
 .../nbl/nbl_include/nbl_include.h             |  14 +++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c | 100 ++++++++++++++++++
 11 files changed, 211 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
 create mode 100644 drivers/net/ethernet/nebula-matrix/Kconfig
 create mode 100644 drivers/net/ethernet/nebula-matrix/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index d9980c84487a..403ae9c2b06a 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -48,6 +48,7 @@ Contents:
    meta/fbnic
    microsoft/netvsc
    mucse/rnpgbe
+   nebula-matrix/nbl
    netronome/nfp
    pensando/ionic
    pensando/ionic_rdma
diff --git a/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst b/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
new file mode 100644
index 000000000000..ff38302968c5
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
@@ -0,0 +1,28 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================================================
+Linux Base Driver for Nebula-matrix m18110-NIC/m18000-NIC family
+================================================================
+
+Overview:
+=========
+The m18110-NIC/m18000-NIC is a series of network interface cards for the Data
+Center Area.
+
+The driver supports link-speed 100GbE/25GE/10GE.
+
+m18110-NIC/m18000-NIC devices support MSI-X interrupt vector for each Tx/Rx
+queue and interrupt moderation.
+
+m18110-NIC/m18000-NIC devices support also various offload features such as
+checksum offload, Receive-Side Scaling(RSS).
+
+Support
+=======
+
+For more information about m18110-NIC/m18000-NIC, please visit the following URL:
+https://www.nebula-matrix.com/snic_s1000_en
+
+If an issue is identified with the released source code on the supported kernel
+with a supported adapter, email the specific information related to the issue to
+open@nebula-matrix.com.
diff --git a/MAINTAINERS b/MAINTAINERS
index 460cb7268845..ab55ba0da0a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18654,6 +18654,16 @@ F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
 F:	Documentation/hwmon/nct7363.rst
 F:	drivers/hwmon/nct7363.c
 
+NEBULA-MATRIX ETHERNET DRIVER (nebula-matrix)
+M:	Illusion Wang <illusion.wang@nebula-matrix.com>
+M:	Dimon Zhao <dimon.zhao@nebula-matrix.com>
+M:	Alvin Wang <alvin.wang@nebula-matrix.com>
+M:	Sam Chen <sam.chen@nebula-matrix.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/device_drivers/ethernet/nebula-matrix/
+F:	drivers/net/ethernet/nebula-matrix/
+
 NETCONSOLE
 M:	Breno Leitao <leitao@debian.org>
 S:	Maintained
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 8581ccba1505..c2b0161d0bec 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -130,6 +130,7 @@ config FEALNX
 
 source "drivers/net/ethernet/ni/Kconfig"
 source "drivers/net/ethernet/natsemi/Kconfig"
+source "drivers/net/ethernet/nebula-matrix/Kconfig"
 source "drivers/net/ethernet/netronome/Kconfig"
 source "drivers/net/ethernet/8390/Kconfig"
 source "drivers/net/ethernet/nvidia/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 2b1153d35b52..a306dae23bcb 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_NET_VENDOR_MUCSE) += mucse/
 obj-$(CONFIG_NET_VENDOR_MYRI) += myricom/
 obj-$(CONFIG_FEALNX) += fealnx.o
 obj-$(CONFIG_NET_VENDOR_NATSEMI) += natsemi/
+obj-$(CONFIG_NET_VENDOR_NEBULA_MATRIX) += nebula-matrix/
 obj-$(CONFIG_NET_VENDOR_NETRONOME) += netronome/
 obj-$(CONFIG_NET_VENDOR_NI) += ni/
 obj-$(CONFIG_NET_VENDOR_NVIDIA) += nvidia/
diff --git a/drivers/net/ethernet/nebula-matrix/Kconfig b/drivers/net/ethernet/nebula-matrix/Kconfig
new file mode 100644
index 000000000000..f16e9663eaed
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/Kconfig
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Nebula-matrix network device configuration
+#
+
+config NET_VENDOR_NEBULA_MATRIX
+	bool "Nebula-matrix devices"
+	default y
+	help
+	  If you have a network (Ethernet) card belonging to this class, say Y.
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Nebula-matrix cards. If you say Y, you will be asked
+	  for your specific card in the following questions.
+
+if NET_VENDOR_NEBULA_MATRIX
+
+config NBL
+	tristate "Nebula-matrix Ethernet Controller m18110/m18000 support"
+	depends on PCI && (64BIT || COMPILE_TEST) && !CPU_BIG_ENDIAN
+	help
+	  This driver supports Nebula-matrix Ethernet Controller m18110/m18000
+	  Family of devices.
+
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst>.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called nbl.
+
+endif # NET_VENDOR_NEBULA_MATRIX
diff --git a/drivers/net/ethernet/nebula-matrix/Makefile b/drivers/net/ethernet/nebula-matrix/Makefile
new file mode 100644
index 000000000000..42cdf2db8f0c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Nebula-matrix network device drivers.
+#
+
+obj-$(CONFIG_NBL) += nbl/
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
new file mode 100644
index 000000000000..6c14d1071c0c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Nebula Matrix Limited.
+
+obj-$(CONFIG_NBL) := nbl.o
+
+nbl-objs +=	nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
new file mode 100644
index 000000000000..a3d63c698aea
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_CORE_H_
+#define _NBL_CORE_H_
+
+enum {
+	NBL_CAP_HAS_NET_BIT,
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
new file mode 100644
index 000000000000..16b10bcf1d36
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_INCLUDE_H_
+#define _NBL_INCLUDE_H_
+
+#include <linux/types.h>
+
+/*  ------  Basic definitions  -------  */
+#define NBL_DRIVER_NAME					"nbl"
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
new file mode 100644
index 000000000000..199626159a4c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Nebula Matrix Limited.
+ */
+
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/bits.h>
+#include "nbl_include/nbl_include.h"
+#include "nbl_core.h"
+
+static int nbl_probe(struct pci_dev *pdev,
+		     const struct pci_device_id *id)
+{
+	return -ENODEV;
+}
+
+static void nbl_remove(struct pci_dev *pdev)
+{
+}
+
+/*
+ * PCI Device IDs for Leonis/NBL Network Controllers
+ *
+ * Vendor ID: 0x1F0F
+ * SNIC v3r1 product Device IDs range: 0x3403-0x3412
+ */
+#define NBL_VENDOR_ID				0x1F0F
+
+#define NBL_DEVICE_ID_M18110			0x3403
+#define NBL_DEVICE_ID_M18110_LX			0x3404
+#define NBL_DEVICE_ID_M18110_BASE_T		0x3405
+#define NBL_DEVICE_ID_M18110_LX_BASE_T		0x3406
+#define NBL_DEVICE_ID_M18110_OCP		0x3407
+#define NBL_DEVICE_ID_M18110_LX_OCP		0x3408
+#define NBL_DEVICE_ID_M18110_BASE_T_OCP		0x3409
+#define NBL_DEVICE_ID_M18110_LX_BASE_T_OCP	0x340a
+#define NBL_DEVICE_ID_M18000			0x340b
+#define NBL_DEVICE_ID_M18000_LX			0x340c
+#define NBL_DEVICE_ID_M18000_BASE_T		0x340d
+#define NBL_DEVICE_ID_M18000_LX_BASE_T		0x340e
+#define NBL_DEVICE_ID_M18000_OCP		0x340f
+#define NBL_DEVICE_ID_M18000_LX_OCP		0x3410
+#define NBL_DEVICE_ID_M18000_BASE_T_OCP		0x3411
+#define NBL_DEVICE_ID_M18000_LX_BASE_T_OCP	0x3412
+
+/* All below IDs belong to Leonis ASIC family, different form-factor variants,
+ * share the same hardware initialization flow without differentiated ops.
+ */
+static const struct pci_device_id nbl_id_table[] = {
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_BASE_T),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_BASE_T),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_BASE_T_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_BASE_T_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },
+	/* required as sentinel */
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, nbl_id_table);
+
+static struct pci_driver nbl_driver = {
+	.name = NBL_DRIVER_NAME,
+	.id_table = nbl_id_table,
+	.probe = nbl_probe,
+	.remove = nbl_remove,
+};
+
+module_pci_driver(nbl_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Nebula Matrix Network Driver");
+MODULE_AUTHOR("Illusion Wang <illusion.wang@nebula-matrix.com>");
-- 
2.47.3

