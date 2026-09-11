Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D0489877
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133407; cv=none; b=SBbWvtAgtTgp9pmMpzDcIpTVEl+p95GDH+syk+7JHGpXdY4BqdbBLq7pfWVf2qhCUbxhUeTJCkK8HiBuaqQHBmhmWqH/yPwEsBvysNaX3XJhxEusTEMPpfBXpinctEaNIj9FNxp/EYptC19P80gR95ymANDGiIbh2nXZ+ZMHt4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133407; c=relaxed/simple;
	bh=NdUyRRAq/orlglGiQ3Pqj8h/NIOiIbOnC2Y0Yq+IK6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHm9plRm2Qc9/Qvui5Q9Jeh7mbtEgwzS0zwbGZ60yLOwJOt2iM3BsouiDeD1KNapowaWGgyCkrqItPCtZvMAZoFwUXB826uBi/4G2rkItXjnOh13kfN/7B0pJ4i/en6DUKqmoR49M5Y1FdZOSYfUghemBOeyngaA44LTLuTiDoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOx9gn2c; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOx9gn2c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789133406; x=1820669406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NdUyRRAq/orlglGiQ3Pqj8h/NIOiIbOnC2Y0Yq+IK6Y=;
  b=MOx9gn2cI/jxJId69PU7j+ebVEl5pZyXDXqK76k+KpF2g+SHRjAXBFkp
   K3rNv3/+RXxT3EGt1jDPVdlyaB5TIMYQfh9i5s7RZmzezLePHfQB6L1YI
   k2omt0Zb4E7f5HitlShQGecyTY4lv2z0fbaTcVC/T9oHCgSqK7EKNJ7ap
   y6CnssfneFy5vllKNUX2m0JoPQvvP+Kwob6Ol+EDBol/bwVSv3jA1aeoq
   CLfIrZBF5Bqo5IuvUqJ9hCeacvxkHW3obIq/bHTic+LdgeUOudiN6EmuC
   0Kqmmwlh9H6vofBSIf5sC3h3n3UTNspxu3U33dq4u0vhlYqAa3CNt04VP
   Q==;
X-CSE-ConnectionGUID: g/A7S7U6SzGQfS5sgJHUqw==
X-CSE-MsgGUID: anD1WjZdQziUrKI4u50NTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107549"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107549"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 06:30:06 -0700
X-CSE-ConnectionGUID: aZG0P84JQ0K5aLnjTKeMyA==
X-CSE-MsgGUID: ZUlasN0KSICgTmNdTqQm6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270541303"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:30:05 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 10/10] ixd: use interrupt for mailbox communication
Date: Fri, 11 Sep 2026 14:49:21 +0200
Message-ID: <20260911124921.2881348-11-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from polling to interrupt for invoking mailbox operations when it
is available.

Add flag to store the information about the mailbox interrupt. If
interrupt is turned off mailbox will be handled by periodic workqueue.
If it is enabled interrupt will take care of it.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ixd/Kconfig        |   1 +
 drivers/net/ethernet/intel/ixd/ixd.h          |  28 ++++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |   8 +-
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  10 ++
 drivers/net/ethernet/intel/ixd/ixd_lib.c      | 126 ++++++++++++++++++
 drivers/net/ethernet/intel/ixd/ixd_main.c     |   2 +
 6 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixd/Kconfig b/drivers/net/ethernet/intel/ixd/Kconfig
index 0a48b3bb7bc2..69c37c2cdb67 100644
--- a/drivers/net/ethernet/intel/ixd/Kconfig
+++ b/drivers/net/ethernet/intel/ixd/Kconfig
@@ -6,6 +6,7 @@ config IXD
 	depends on PCI_MSI
 	select LIBIE_CP
 	select LIBIE_PCI
+	select LIBIE_IRQ
 	select NET_DEVLINK
 	help
 	  This driver supports Intel(R) Control Plane PCI Function
diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
index 4a1590f937b5..ed5ffe04f48d 100644
--- a/drivers/net/ethernet/intel/ixd/ixd.h
+++ b/drivers/net/ethernet/intel/ixd/ixd.h
@@ -5,9 +5,20 @@
 #define _IXD_H_
 
 #include <linux/net/intel/libie/controlq.h>
+#include <linux/net/intel/libie/irq.h>
 
 #define IXD_INIT_TASK_DELAY_JIFFIES	msecs_to_jiffies(500)
 
+/**
+ * enum ixd_flags - Whole device flags
+ * @IXD_MB_INTR_MODE: Mailbox in interrupt mode
+ * @IXD_FLAGS_NBITS: Must be last
+ */
+enum ixd_flags {
+	IXD_MB_INTR_MODE,
+	IXD_FLAGS_NBITS,
+};
+
 /**
  * struct ixd_adapter - Data structure representing a CPF
  * @cp_ctx: Control plane communication context
@@ -24,6 +35,11 @@
  * @vc_ver.major: Negotiated major virtchnl version
  * @vc_ver.minor: Negotiated minor virtchnl version
  * @caps: Negotiated virtchnl capabilities
+ * @mb_irq: index and virq to track mailbox
+ * @irq: libie irq for interrupts management
+ * @mb_dyn_ctl: mailbox dynamic control register address
+ * @oicr_ena: direct OICR enable register address
+ * @flags: look at enum ixd_flags for more details
  */
 struct ixd_adapter {
 	struct libie_ctlq_ctx cp_ctx;
@@ -42,6 +58,11 @@ struct ixd_adapter {
 		u32 minor;
 	} vc_ver;
 	struct virtchnl2_get_capabilities caps;
+	struct msi_map mb_irq;
+	struct libie_irq irq;
+	void __iomem *mb_dyn_ctl;
+	void __iomem *oicr_ena;
+	DECLARE_BITMAP(flags, IXD_FLAGS_NBITS);
 };
 
 /**
@@ -55,6 +76,11 @@ static inline struct device *ixd_to_dev(struct ixd_adapter *adapter)
 	return &adapter->cp_ctx.mmio_info.pdev->dev;
 }
 
+static inline struct pci_dev *ixd_to_pdev(struct ixd_adapter *adapter)
+{
+	return adapter->cp_ctx.mmio_info.pdev;
+}
+
 void ixd_ctlq_reg_init(struct ixd_adapter *adapter,
 		       struct libie_ctlq_reg *ctlq_reg_tx,
 		       struct libie_ctlq_reg *ctlq_reg_rx);
@@ -66,5 +92,7 @@ void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter);
 int ixd_iomap_running_regions(struct ixd_adapter *adapter);
 bool ixd_iomap_is_not_start_region(struct libie_mmio_info *info,
 				   struct libie_pci_mmio_region *reg);
+void ixd_deinit_interrupts(struct ixd_adapter *adapter);
+void ixd_mailbox_irq_enable(struct ixd_adapter *adapter);
 
 #endif /* _IXD_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
index 8712e10c8c50..43daef30689a 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
@@ -134,8 +134,12 @@ void ixd_ctlq_rx_task(struct work_struct *work)
 
 	adapter = container_of(work, struct ixd_adapter, mbx_task.work);
 
-	queue_delayed_work(system_dfl_wq, &adapter->mbx_task,
-			   IXD_CTLQ_RX_TASK_DELAY_JIFFIES);
+	if (test_bit(IXD_MB_INTR_MODE, adapter->flags))
+		/* Just re-enable irq in HW. */
+		ixd_mailbox_irq_enable(adapter);
+	else
+		queue_delayed_work(system_dfl_wq, &adapter->mbx_task,
+				   IXD_CTLQ_RX_TASK_DELAY_JIFFIES);
 
 	ixd_ctlq_recv_mb_msg(adapter);
 }
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
index 58e58c75981b..b924ada5f831 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
+++ b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
@@ -31,6 +31,16 @@
 #define PF_FW_ATQH			(PF_FW_MBX + 0x20)
 #define PF_FW_ATQT			(PF_FW_MBX + 0x24)
 
+/* Interrupts */
+#define PF_GLINT_DYN_CTL_INTENA_S	0
+#define PF_GLINT_DYN_CTL_INTENA_M	BIT(PF_GLINT_DYN_CTL_INTENA_S)
+#define PF_GLINT_DYN_CTL_ITR_INDX_S	3
+#define PF_GLINT_DYN_CTL_ITR_INDX_M	GENMASK(4, 3)
+
+/* Generic registers */
+#define PF_INT_DIR_OICR_ENA		0x08406000
+#define PF_INT_DIR_OICR_ENA_M		GENMASK(31, 0)
+
 /* Reset registers */
 #define PFGEN_RTRIG_REG_LEN		2048
 #define PFGEN_RTRIG			0x08407000	/* Device resets */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
index 8311f7590666..e13614603a9e 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
@@ -4,6 +4,7 @@
 #include "ixd.h"
 #include "ixd_ctlq.h"
 #include "ixd_devlink.h"
+#include "ixd_lan_regs.h"
 #include "ixd_virtchnl.h"
 
 #define IXD_DFLT_MBX_Q_LEN 64
@@ -57,6 +58,125 @@ static void ixd_adapter_fill_dflt_ctlqs(struct ixd_adapter *adapter)
 				       LIBIE_CTLQ_MBX_ID);
 }
 
+static irqreturn_t ixd_mailbox_irq_handler(int __always_unused irq, void *data)
+{
+	struct ixd_adapter *adapter = (struct ixd_adapter *)data;
+
+	queue_delayed_work(system_dfl_wq, &adapter->mbx_task, 0);
+
+	return IRQ_HANDLED;
+}
+
+void ixd_mailbox_irq_enable(struct ixd_adapter *adapter)
+{
+	writel(PF_GLINT_DYN_CTL_INTENA_M | PF_GLINT_DYN_CTL_ITR_INDX_M,
+	       adapter->mb_dyn_ctl);
+	writel(PF_INT_DIR_OICR_ENA_M, adapter->oicr_ena);
+}
+
+static void ixd_mailbox_irq_disable(struct ixd_adapter *adapter)
+{
+	/* Clear INTENA, keep the ITR index pointing to the no update one. */
+	writel(PF_GLINT_DYN_CTL_ITR_INDX_M, adapter->mb_dyn_ctl);
+	writel(0, adapter->oicr_ena);
+}
+
+static int ixd_mailbox_irq_regs_init(struct ixd_adapter *adapter)
+{
+	struct libie_mmio_info *mmio = &adapter->cp_ctx.mmio_info;
+	u32 dyn_ctl = le32_to_cpu(adapter->caps.mailbox_dyn_ctl);
+
+	adapter->mb_dyn_ctl = libie_pci_get_mmio_addr(mmio, dyn_ctl);
+	adapter->oicr_ena = libie_pci_get_mmio_addr(mmio, PF_INT_DIR_OICR_ENA);
+
+	if (!adapter->mb_dyn_ctl || !adapter->oicr_ena)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void ixd_mailbox_irq_deinit(struct ixd_adapter *adapter)
+{
+	if (!test_and_clear_bit(IXD_MB_INTR_MODE, adapter->flags))
+		return;
+
+	ixd_mailbox_irq_disable(adapter);
+
+	/* The mailbox task re-arms the interrupt, make sure it isn't running
+	 * anymore before the irq line is freed.
+	 */
+	cancel_delayed_work_sync(&adapter->mbx_task);
+
+	kfree(free_irq(adapter->mb_irq.virq, adapter));
+	libie_irq_free(&adapter->irq, adapter->mb_irq);
+}
+
+static int ixd_mailbox_irq_init(struct ixd_adapter *adapter)
+{
+	struct msi_map *irq = &adapter->mb_irq;
+	char *name;
+	int err;
+
+	*irq = libie_irq_alloc(&adapter->irq, LIBIE_IRQ_STATIC);
+	if (irq->index < 0)
+		return irq->index;
+
+	name = kasprintf(GFP_KERNEL, "%s-%s-%d",
+			 dev_driver_string(ixd_to_dev(adapter)), "Mailbox", 0);
+	if (!name) {
+		libie_irq_free(&adapter->irq, adapter->mb_irq);
+
+		return -ENOMEM;
+	}
+
+	err = request_irq(irq->virq, ixd_mailbox_irq_handler, 0, name, adapter);
+	if (err) {
+		kfree(name);
+		libie_irq_free(&adapter->irq, adapter->mb_irq);
+		dev_err(ixd_to_dev(adapter), "IRQ request for mailbox failed, error: %d\n",
+			err);
+
+		return err;
+	}
+
+	set_bit(IXD_MB_INTR_MODE, adapter->flags);
+
+	return 0;
+}
+
+void ixd_deinit_interrupts(struct ixd_adapter *adapter)
+{
+	ixd_mailbox_irq_deinit(adapter);
+	libie_irq_deinit(&adapter->irq);
+}
+
+static int ixd_init_interrupts(struct ixd_adapter *adapter)
+{
+	struct libie_irq *irq = &adapter->irq;
+	int err;
+
+	err = libie_irq_init(irq, ixd_to_pdev(adapter), 1, 1);
+	if (err)
+		return err;
+
+	err = ixd_mailbox_irq_regs_init(adapter);
+	if (err)
+		goto free_irq;
+
+	err = ixd_mailbox_irq_init(adapter);
+	if (err)
+		goto free_irq;
+
+	ixd_mailbox_irq_enable(adapter);
+
+	return 0;
+
+free_irq:
+	libie_irq_deinit(irq);
+
+	return err;
+}
+
 /**
  * ixd_deinit_dflt_mbx - Deinitialize default mailbox
  * @adapter: adapter info struct
@@ -154,6 +274,12 @@ void ixd_init_task(struct work_struct *work)
 		adapter->init_task.vc_retries = 0;
 		adapter->init_task.success = true;
 		ixd_devlink_register(adapter);
+
+		err = ixd_init_interrupts(adapter);
+		if (err)
+			dev_err(ixd_to_dev(adapter),
+				"Failed to initialize interrupts: %d\n",
+				err);
 		return;
 	}
 
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index 488a919f3b1b..e83550da3e9a 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -9,6 +9,7 @@
 MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
 MODULE_IMPORT_NS("LIBIE_CP");
 MODULE_IMPORT_NS("LIBIE_PCI");
+MODULE_IMPORT_NS("LIBIE_IRQ");
 MODULE_LICENSE("GPL");
 
 /**
@@ -25,6 +26,7 @@ static void ixd_remove(struct pci_dev *pdev)
 	ixd_devlink_unregister(adapter);
 
 	/* Leave the device clean on exit */
+	ixd_deinit_interrupts(adapter);
 	if (adapter->xnm)
 		libie_ctlq_xn_shutdown(adapter->xnm);
 	ixd_trigger_reset(adapter);
-- 
2.49.0

