Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACFC417D90;
	Wed, 15 Jul 2026 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138508; cv=none; b=MjCVjDQww1PdHp6jgmC6TAc7dG+vJm0/QMhzNGwnv/sHcP5CQk9XcuwgNTH3gcbv5LKQbJ58irOrsVaN7u6xvkQoDLfYnAsPsG0sopdw1mpV0UIXtK28nPigZZqhw4tuW6IDIPnUoLGQGbw2VPLhQ9petVtVNw9X2dauphbSg0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138508; c=relaxed/simple;
	bh=Xt9j1L1f3FStLjqZgRyzoRwjOLq5ffHjwk7TzNbNCws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruh/HMr8zVfHuI+tZUCdKxFUHC9O1J8EZs2MinamW/rrEC+ewIgOjkG+1SBVU4Cp9me780v2fVnJMfsHsvXZ/yikui/DOiYmU6hsATf+N3jkp+l0SH2Rp6k35e6BZM7pfLRl2gHQO0uR0pge8pO3YFgy5fYGpC9qDOUxTmLgymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QauDarVy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QauDarVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784138500; x=1815674500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xt9j1L1f3FStLjqZgRyzoRwjOLq5ffHjwk7TzNbNCws=;
  b=QauDarVyGH2KV3wkHoupsBXwVtnIr+s6j+RzaD/Zm6TwtK9aC8nZrDvl
   ZL9WzWovp7+hVN86xnHWMlqs80jGLVmz4xZKU8NwLsRVSVRwk5KF+Fcl8
   HVQXpNXWPQaGT+lHctDS7sIcjje2RzMbQ/EBkIl4Y5TjPbib2boq9a00h
   2W406yonpBJ1Hh/WSL+HN1tsaB7zYF4jyHgaoALlOQBTbe8TNxizdiKMJ
   rjVeGPSWDSknndvh30N7h2BGhxdc1ZiHakKBQRB0Ap8cM7IE2sjnDfnbo
   +o0JMqb0xKECi37woSzK3lViPDzuszOPXazI0grb90o/ApolBaEp6c2iM
   g==;
X-CSE-ConnectionGUID: RK3k7mDcRAug7oRTU5jVFA==
X-CSE-MsgGUID: ND1yjtGtQFuKKUAxxd+FJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110336869"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="110336869"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 11:01:04 -0700
X-CSE-ConnectionGUID: zF3t0bNpQVmbjTD9eICYGQ==
X-CSE-MsgGUID: E1dBtShBQFKpFeOFPz9BaQ==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jul 2026 11:01:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Amritha Nambiar <anthony.l.nguyen@intel.com>,
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
	linux-doc@vger.kernel.org,
	Bharath R <Bharath.r@intel.com>
Subject: [PATCH net-next v5 15/15] ixd: add devlink support
Date: Wed, 15 Jul 2026 11:00:40 -0700
Message-ID: <20260715180042.1972010-16-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
References: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amritha Nambiar <amritha.nambiar@intel.com>

Enable initial support for the devlink interface with the ixd driver. The
ixd hardware is a single function PCIe device. So, the PCIe adapter gets
its own devlink instance to manage device-wide resources or configuration.

$ devlink dev show
pci/0000:83:00.6

$ devlink dev info pci/0000:83:00.6
pci/0000:83:00.6:
  driver ixd
  serial_number 00-a0-c9-ff-ff-23-45-67
  versions:
      fixed:
        device.type MEV
      running:
        virtchnl 2.0

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Bharath R <Bharath.r@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 Documentation/networking/devlink/index.rst   |  1 +
 Documentation/networking/devlink/ixd.rst     | 30 ++++++
 drivers/net/ethernet/intel/ixd/Kconfig       |  1 +
 drivers/net/ethernet/intel/ixd/Makefile      |  1 +
 drivers/net/ethernet/intel/ixd/ixd.h         |  1 +
 drivers/net/ethernet/intel/ixd/ixd_devlink.c | 97 ++++++++++++++++++++
 drivers/net/ethernet/intel/ixd/ixd_devlink.h | 50 ++++++++++
 drivers/net/ethernet/intel/ixd/ixd_lib.c     |  3 +
 drivers/net/ethernet/intel/ixd/ixd_main.c    | 14 ++-
 9 files changed, 195 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/networking/devlink/ixd.rst
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.h

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 4745148fecf4..e371be30b99e 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -88,6 +88,7 @@ parameters, info versions, and other features it supports.
    ionic
    iosm
    ixgbe
+   ixd
    kvaser_pciefd
    kvaser_usb
    mlx4
diff --git a/Documentation/networking/devlink/ixd.rst b/Documentation/networking/devlink/ixd.rst
new file mode 100644
index 000000000000..17b63c8425aa
--- /dev/null
+++ b/Documentation/networking/devlink/ixd.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+ixd devlink support
+===================
+
+This document describes the devlink features implemented by the ``ixd``
+device driver.
+
+Info versions
+=============
+
+The ``ixd`` driver reports the following versions
+
+.. list-table:: devlink info versions implemented
+    :widths: 5 5 5 90
+
+    * - Name
+      - Type
+      - Example
+      - Description
+    * - ``device.type``
+      - fixed
+      - MEV
+      - The hardware type for this device
+    * - ``virtchnl``
+      - running
+      - 2.0
+      - 2-digit version number (major.minor) of the communication channel
+        (virtchnl) used by the device.
diff --git a/drivers/net/ethernet/intel/ixd/Kconfig b/drivers/net/ethernet/intel/ixd/Kconfig
index 24510c50070e..34181c59dcdc 100644
--- a/drivers/net/ethernet/intel/ixd/Kconfig
+++ b/drivers/net/ethernet/intel/ixd/Kconfig
@@ -7,6 +7,7 @@ config IXD
 	select LIBETH
 	select LIBIE_CP
 	select LIBIE_PCI
+	select NET_DEVLINK
 	help
 	  This driver supports Intel(R) Control Plane PCI Function
 	  of Intel E2100 and later IPUs and FNICs.
diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
index 90abf231fb16..03760a2580b9 100644
--- a/drivers/net/ethernet/intel/ixd/Makefile
+++ b/drivers/net/ethernet/intel/ixd/Makefile
@@ -8,5 +8,6 @@ obj-$(CONFIG_IXD) += ixd.o
 ixd-y := ixd_main.o
 ixd-y += ixd_ctlq.o
 ixd-y += ixd_dev.o
+ixd-y += ixd_devlink.o
 ixd-y += ixd_lib.o
 ixd-y += ixd_virtchnl.o
diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
index 8e3cd5bc5a84..343c5053045f 100644
--- a/drivers/net/ethernet/intel/ixd/ixd.h
+++ b/drivers/net/ethernet/intel/ixd/ixd.h
@@ -23,6 +23,7 @@ struct ixd_adapter {
 		struct delayed_work init_work;
 		u8 reset_retries;
 		u8 vc_retries;
+		bool success;
 	} init_task;
 	struct delayed_work mbx_task;
 	struct libie_ctlq_xn_manager *xnm;
diff --git a/drivers/net/ethernet/intel/ixd/ixd_devlink.c b/drivers/net/ethernet/intel/ixd/ixd_devlink.c
new file mode 100644
index 000000000000..23ab11226978
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_devlink.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Intel Corporation. */
+
+#include "ixd.h"
+#include "ixd_devlink.h"
+
+#define IXD_DEVLINK_INFO_LEN	128
+
+/**
+ * ixd_fill_dsn - Get the serial number for the ixd device
+ * @adapter: adapter to query
+ * @buf: storage buffer for the info request
+ */
+static void ixd_fill_dsn(struct ixd_adapter *adapter, char *buf)
+{
+	u8 dsn[8];
+
+	/* Copy the DSN into an array in Big Endian format */
+	put_unaligned_be64(pci_get_dsn(adapter->cp_ctx.mmio_info.pdev), dsn);
+
+	snprintf(buf, IXD_DEVLINK_INFO_LEN, "%8phD", dsn);
+}
+
+/**
+ * ixd_fill_device_name - Get the name of the underlying hardware
+ * @adapter: adapter to query
+ * @buf: storage buffer for the info request
+ * @buf_size: size of the storage buffer
+ */
+static void ixd_fill_device_name(struct ixd_adapter *adapter, char *buf,
+				 size_t buf_size)
+{
+	if (adapter->caps.device_type == cpu_to_le32(VIRTCHNL2_MEV_DEVICE))
+		snprintf(buf, buf_size, "%s", "MEV");
+	else
+		snprintf(buf, buf_size, "%s", "UNKNOWN");
+}
+
+/**
+ * ixd_devlink_info_get - .info_get devlink handler
+ * @devlink: devlink instance structure
+ * @req: the devlink info request
+ * @extack: extended netdev ack structure
+ *
+ * Callback for the devlink .info_get operation. Reports information about the
+ * device.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+static int ixd_devlink_info_get(struct devlink *devlink,
+				struct devlink_info_req *req,
+				struct netlink_ext_ack *extack)
+{
+	struct ixd_adapter *adapter = devlink_priv(devlink);
+	char buf[IXD_DEVLINK_INFO_LEN];
+	int err;
+
+	ixd_fill_dsn(adapter, buf);
+	err = devlink_info_serial_number_put(req, buf);
+	if (err)
+		return err;
+
+	ixd_fill_device_name(adapter, buf, IXD_DEVLINK_INFO_LEN);
+	err = devlink_info_version_fixed_put(req, "device.type", buf);
+	if (err)
+		return err;
+
+	snprintf(buf, sizeof(buf), "%u.%u",
+		 adapter->vc_ver.major, adapter->vc_ver.minor);
+
+	return devlink_info_version_running_put(req, "virtchnl", buf);
+}
+
+static const struct devlink_ops ixd_devlink_ops = {
+	.info_get = ixd_devlink_info_get,
+};
+
+/**
+ * ixd_adapter_alloc - Allocate devlink and return adapter pointer
+ * @dev: the device to allocate for
+ *
+ * Allocate a devlink instance for this device and return the private area as
+ * the adapter structure.
+ *
+ * Return: adapter structure on success, NULL on failure
+ */
+struct ixd_adapter *ixd_adapter_alloc(struct device *dev)
+{
+	struct devlink *devlink;
+
+	devlink = devlink_alloc(&ixd_devlink_ops, sizeof(struct ixd_adapter),
+				dev);
+	if (!devlink)
+		return NULL;
+
+	return devlink_priv(devlink);
+}
diff --git a/drivers/net/ethernet/intel/ixd/ixd_devlink.h b/drivers/net/ethernet/intel/ixd/ixd_devlink.h
new file mode 100644
index 000000000000..b23a1b37aebc
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_devlink.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025, Intel Corporation. */
+
+#ifndef _IXD_DEVLINK_H_
+#define _IXD_DEVLINK_H_
+
+#include <net/devlink.h>
+
+#include "ixd.h"
+
+struct ixd_adapter *ixd_adapter_alloc(struct device *dev);
+
+/**
+ * ixd_devlink_free - teardown the devlink
+ * @adapter: the adapter structure to free
+ *
+ */
+static inline void ixd_devlink_free(struct ixd_adapter *adapter)
+{
+	struct devlink *devlink = priv_to_devlink(adapter);
+
+	devlink_free(devlink);
+}
+
+/**
+ * ixd_devlink_unregister - Unregister devlink for this adapter.
+ * @adapter: the adapter structure to cleanup
+ *
+ * Init task must be completed or cancelled beforehand.
+ */
+static inline void ixd_devlink_unregister(struct ixd_adapter *adapter)
+{
+	if (!adapter->init_task.success)
+		return;
+
+	devlink_unregister(priv_to_devlink(adapter));
+}
+
+/**
+ * ixd_devlink_register - Register devlink interface for this adapter
+ * @adapter: pointer to ixd adapter structure to be associated with devlink
+ *
+ * Register the devlink instance associated with this adapter
+ */
+static inline void ixd_devlink_register(struct ixd_adapter *adapter)
+{
+	devlink_register(priv_to_devlink(adapter));
+}
+
+#endif /* _IXD_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
index ce870aba143d..6f2b39cd985c 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
@@ -3,6 +3,7 @@
 
 #include "ixd.h"
 #include "ixd_ctlq.h"
+#include "ixd_devlink.h"
 #include "ixd_virtchnl.h"
 
 #define IXD_DFLT_MBX_Q_LEN 64
@@ -154,6 +155,8 @@ void ixd_init_task(struct work_struct *work)
 
 	if (!ixd_vc_dev_init(adapter)) {
 		adapter->init_task.vc_retries = 0;
+		adapter->init_task.success = true;
+		ixd_devlink_register(adapter);
 		return;
 	}
 
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index eb8e410300c2..973bc480e25a 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -4,6 +4,7 @@
 #include "ixd.h"
 #include "ixd_ctlq.h"
 #include "ixd_lan_regs.h"
+#include "ixd_devlink.h"
 
 MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
 MODULE_IMPORT_NS("LIBIE_CP");
@@ -21,6 +22,8 @@ static void ixd_remove(struct pci_dev *pdev)
 	/* Do not mix removal with (re)initialization */
 	cancel_delayed_work_sync(&adapter->init_task.init_work);
 
+	ixd_devlink_unregister(adapter);
+
 	/* Leave the device clean on exit */
 	if (adapter->xnm)
 		libie_ctlq_xn_shutdown(adapter->xnm);
@@ -28,6 +31,7 @@ static void ixd_remove(struct pci_dev *pdev)
 	ixd_deinit_dflt_mbx(adapter);
 
 	libie_pci_unmap_all_mmio_regions(&adapter->cp_ctx.mmio_info);
+	ixd_devlink_free(adapter);
 }
 
 /**
@@ -95,7 +99,7 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (WARN_ON(ent->device != IXD_DEV_ID_CPF))
 		return -EINVAL;
 
-	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
+	adapter = ixd_adapter_alloc(&pdev->dev);
 	if (!adapter)
 		return -ENOMEM;
 
@@ -104,13 +108,13 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = libie_pci_init_dev(pdev);
 	if (err)
-		return err;
+		goto free_adapter;
 
 	pci_set_drvdata(pdev, adapter);
 
 	err = ixd_iomap_regions(adapter);
 	if (err)
-		return err;
+		goto free_adapter;
 
 	INIT_DELAYED_WORK(&adapter->init_task.init_work,
 			  ixd_init_task);
@@ -121,6 +125,10 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   msecs_to_jiffies(500));
 
 	return 0;
+
+free_adapter:
+	ixd_devlink_free(adapter);
+	return err;
 }
 
 static const struct pci_device_id ixd_pci_tbl[] = {
-- 
2.47.1

