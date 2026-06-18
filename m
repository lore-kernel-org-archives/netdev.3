Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B52DE702
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792536; cv=none; b=bFeiGW+Xz5nVe9mksdWjwaDEAol2Fi7UGCcqjSI2/mLdrpD63gfEPBxkmiTsU5tH+472BQyBdKGuDtSc/tgU9iXIkb5CiMNUtjaZW7RcfoOYaciel2qEONiGxq/vbUhn8UTsc6QUh1UIHfsPr5Usx8m/yqakVYwhsVH7UvVlAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792536; c=relaxed/simple;
	bh=iq3Ezql0D49y86sPQaYvb4jHBq6U1dI1ce9k61tPxSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mx6rrpbduWSQPYq90TOF/mlO7bW1132CXeEZqQPddRCqNfXE0T6acHmVUgpjNn9FCyqvcfr33ZvKtqSZugYlsW9ikjIv1+Auwijj0WykWPdV916uY5/uXCHwOgtazzzysg7ISBIOah2bVpYMh748TznlKg9mM0Fjwizgh0VTdq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtQgvFgH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtQgvFgH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781792535; x=1813328535;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iq3Ezql0D49y86sPQaYvb4jHBq6U1dI1ce9k61tPxSI=;
  b=dtQgvFgHzpQia0GJ+MombG4X5dpkE6hbCNEhmvumOplaQbimtC+efDeu
   v00I1PyXlATNW5w2Cji+oDUmpbqyUyKgYsdGkyYhIUMGtzlxxKuHLUBnD
   K7/NxwY63tsWKEe+9N8D4m+ITnXK8LQLdlBGnrpsTPMAq7rHVGgLgs1Pc
   32pRsxxYKQXUfa+nB/q/WOLfxU+J0mEzpMe7T+TfvnLV4aLn4rrnZ2Pbx
   NOtSADVadAl5OndaedF7CdKJMGeCG7gjgzau1ddnz/Qg35TzsDvo1sSmK
   eixjVeTHsQZz3FPxrnxAIjbZTkCFX3M8QMRDfeJ7wTZVTeW9H4j8jnwqL
   w==;
X-CSE-ConnectionGUID: mB47Q4rYRfm90ZJ+5SZt5Q==
X-CSE-MsgGUID: LWZD4/4GSam0775bRe9vYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82629615"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82629615"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:22:14 -0700
X-CSE-ConnectionGUID: sLWbe4QjT8eXL7UIu4bBjQ==
X-CSE-MsgGUID: vBv+ppFORd+Xs4uDnzakJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="244214810"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa010.fm.intel.com with ESMTP; 18 Jun 2026 07:22:13 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de
Subject: [PATCH iwl-next v2] ixgbe: Implement PCI reset handler
Date: Thu, 18 Jun 2026 14:22:12 +0000
Message-ID: <20260618142212.310475-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement PCI device reset handler to allow the network device to
get re-initialized and function after a PCI-level reset.

This is necessary for the adapter to avoid TX queue timeouts
occurring when the PCI reset is initiated via sysfs during
the operation

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

Previous version: https://lore.kernel.org/netdev/MW4PR11MB6864BC9CA84F060AF7E0248480E42@MW4PR11MB6864.namprd11.prod.outlook.com/
v1->v2 changes: Rearranged the order of operations, switched to poll_timeout_us() macro

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 82 +++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 594ccb28da20..c4b0c5bb89c6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -912,6 +912,7 @@ enum ixgbe_state_t {
 	__IXGBE_PTP_TX_IN_PROGRESS,
 	__IXGBE_RESET_REQUESTED,
 	__IXGBE_PHY_INIT_COMPLETE,
+	__IXGBE_PCIE_RESET_IN_PROGRESS,
 };
 
 struct ixgbe_cb {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2ac274c73d61..0fb64aef223e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -12352,6 +12352,86 @@ static pci_ers_result_t ixgbe_io_slot_reset(struct pci_dev *pdev)
 	return result;
 }
 
+/* 1500 us poll interval */
+#define IXGBE_RESET_PREP_POLL_INTERVAL_US 1500
+/* 2 second timeout to acquire reset lock before proceeding */
+#define IXGBE_RESET_PREP_TIMEOUT_US 2000000
+
+/**
+ * ixgbe_reset_prep - called before the pci bus is reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Prepare the card for a reset, preventing the service task from running.
+ */
+static void ixgbe_reset_prep(struct pci_dev *pdev)
+{
+	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
+
+	if (!adapter)
+		return;
+
+	if (poll_timeout_us(test_and_set_bit(__IXGBE_RESETTING, &adapter->state),
+			    test_bit(__IXGBE_RESETTING, &adapter->state),
+			    IXGBE_RESET_PREP_POLL_INTERVAL_US,
+			    IXGBE_RESET_PREP_TIMEOUT_US, false)) {
+		/* ixgbe_reset_done() will exit early if this happens.
+		 * A retry will be needed
+		 */
+		e_err(drv, "Timed out waiting for __IXGBE_RESETTING to be released. Reset is needed\n");
+		return;
+	}
+
+	/* Sync __IXGBE_RESETTING */
+	smp_mb__after_atomic();
+
+	if (test_bit(__IXGBE_SERVICE_INITED, &adapter->state)) {
+		/* Prevent the service task from being requeued in the timer callback */
+		timer_delete_sync(&adapter->service_timer);
+		/* Cancel any possibly queued service task */
+		cancel_work_sync(&adapter->service_task);
+	}
+
+	pci_clear_master(pdev);
+
+	set_bit(__IXGBE_PCIE_RESET_IN_PROGRESS, &adapter->state);
+}
+
+/**
+ * ixgbe_reset_done - called after the pci bus has been reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Allow the service task to run and schedule re-initialization.
+ */
+static void ixgbe_reset_done(struct pci_dev *pdev)
+{
+	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
+
+	if (!adapter)
+		return;
+
+	if (!test_and_clear_bit(__IXGBE_PCIE_RESET_IN_PROGRESS, &adapter->state)) {
+		/* Should never get here */
+		e_err(drv, "Reset done called without PCIe reset in progress\n");
+		return;
+	}
+
+	pci_set_master(pdev);
+
+	/* Allow the service task to run */
+	if (!test_bit(__IXGBE_REMOVING, &adapter->state)) {
+		clear_bit(__IXGBE_RESETTING, &adapter->state);
+		/* Sync __IXGBE_RESETTING */
+		smp_mb__after_atomic();
+	}
+
+	/* Schedule re-initialization */
+	if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
+		set_bit(__IXGBE_RESET_REQUESTED, &adapter->state);
+		if (test_bit(__IXGBE_SERVICE_INITED, &adapter->state))
+			mod_timer(&adapter->service_timer, jiffies + 1);
+	}
+}
+
 /**
  * ixgbe_io_resume - called when traffic can start flowing again.
  * @pdev: Pointer to PCI device
@@ -12384,6 +12464,8 @@ static const struct pci_error_handlers ixgbe_err_handler = {
 	.error_detected = ixgbe_io_error_detected,
 	.slot_reset = ixgbe_io_slot_reset,
 	.resume = ixgbe_io_resume,
+	.reset_prepare = ixgbe_reset_prep,
+	.reset_done = ixgbe_reset_done,
 };
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ixgbe_pm_ops, ixgbe_suspend, ixgbe_resume);
-- 
2.53.0

