Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277F35372C9
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076980; cv=none; b=mnsmCc4/Wzc2dJV1rV/JuOUVo9lj2lrFiL3anza7JzoJ2eZvDhNrESkHHsRN6OCR3Vgugs1yceSjbVXSgxiZnvi8FwQ4OrBtCS4pmlzVOUBC2osO6rMOZfceypRaZ0vFdwATGwO5WHotd6/JJNKN75o7Gcg3Kj/IOExntzgaPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076980; c=relaxed/simple;
	bh=4QH1S2syL6mlFcY4Z5eC/lt5lGMSXXdYEQtpCVVQWfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncsvqvv6aFha+3tyn3kKVa9rx7hx5q14OhgnWCYnC3HkQP3ZZyYLss+H1As/VX8V19we4xvry2o81h8+hAYbyzjvuR2pNAdUoZRg8O6KJWYixl0P8IM6Rb+nsYYFa/BVCNg/16Dzv5x1NB6RBno/G804Cm7t66KqkG5Iab7lQC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2SULOIv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2SULOIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790076974; x=1821612974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4QH1S2syL6mlFcY4Z5eC/lt5lGMSXXdYEQtpCVVQWfo=;
  b=L2SULOIvwBHSW7RfkhfqtY9UUl4TLpLr1oTovp/N/mccrX8qsK77tk+k
   HvgCsO2PHa8rk9QDQXW03D+g1c154dE31Fk7uuTLLN21CwuSDDr11Rg3C
   bO7SXuFlyeWe2ZuJIKRGtGKbc2mVKjscJrHAUYC/4Tj6mt7qG10J+DNnn
   /JftXZ+NAirbMTE75gwRly8VXl4POS7kdtLkje+NIuwu2Q6oms8FWYx9Y
   uYGgr0FgUteSLXj74NpPhShLbM7ncY72JGVqb1r7C7pFIvHZ1xK98m0VI
   e4WyBpDg6Teo1Tbmwtiv/QunzJ+XjxEh9rGflNf4aONUom8cwwocRCIXE
   w==;
X-CSE-ConnectionGUID: ZI+1/R/aQniGwrO+muypig==
X-CSE-MsgGUID: 5ts4waIITTeLBRZabRFEOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90787338"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90787338"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:36:03 -0700
X-CSE-ConnectionGUID: 16ei8HstTaG/F8VFLERuwA==
X-CSE-MsgGUID: 7sCUDdjdRAWIgR05RVZHEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="272592003"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa007.fm.intel.com with ESMTP; 22 Sep 2026 04:36:03 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v2 4/4] ixgbe: Implement PCI reset handler
Date: Tue, 22 Sep 2026 11:35:58 +0000
Message-ID: <20260922113558.2288111-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
References: <20260922113558.2288111-1-sergey.temerkhanov@intel.com>
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
occurring after the PCI reset is performed via sysfs during
its operation.

The reset codepath may trigger a number of dependencies in the
reset of the driver, so that it is necessary to check if
the netdev is present and running there.

Fixes: 711d57796f5c ("PCI: expose function reset capability in sysfs")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 111 ++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index bac3b85a1d63..88247e760bda 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -912,6 +912,7 @@ enum ixgbe_state_t {
 	__IXGBE_PTP_TX_IN_PROGRESS,
 	__IXGBE_RESET_REQUESTED,
 	__IXGBE_PHY_INIT_COMPLETE,
+	__IXGBE_PCI_RESET_PREPARED,
 };
 
 struct ixgbe_cb {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6ef51b822a50..da26d1013f3e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10537,6 +10537,9 @@ void ixgbe_do_reset(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 
+	if (!netif_device_present(netdev))
+		return;
+
 	if (netif_running(netdev))
 		ixgbe_reinit_locked(adapter);
 	else
@@ -12396,6 +12399,7 @@ static int ixgbe_rebuild_fcoe_queues(struct ixgbe_adapter *adapter)
 
 	ixgbe_clear_interrupt_scheme(adapter);
 	err = ixgbe_init_interrupt_scheme(adapter);
+	/* Keep reinit_pending set so ixgbe_open() retries before using queues. */
 	if (err)
 		return err;
 
@@ -12404,6 +12408,110 @@ static int ixgbe_rebuild_fcoe_queues(struct ixgbe_adapter *adapter)
 	return 0;
 }
 
+/**
+ * ixgbe_pci_reset_prepare - called before the pci bus is reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Quiesce the driver in preparation for a PCI function reset. Called from
+ * pci_dev_save_and_disable() before the core saves config state and writes
+ * PCI_COMMAND_INTX_DISABLE to clear bus mastering and MMIO decode, so MMIO
+ * access to the device is still valid here.
+ */
+static void ixgbe_pci_reset_prepare(struct pci_dev *pdev)
+{
+	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+
+	if (!adapter)
+		return;
+
+	netdev = adapter->netdev;
+
+	rtnl_lock();
+	if (!netif_device_present(netdev)) {
+		rtnl_unlock();
+		return;
+	}
+
+	set_bit(__IXGBE_PCI_RESET_PREPARED, &adapter->state);
+	netif_device_detach(netdev);
+	if (netif_running(netdev))
+		ixgbe_close_suspend(adapter);
+	rtnl_unlock();
+
+	/* __IXGBE_RESETTING is intentionally not set here: it is spun on
+	 * while holding rtnl by ixgbe_reinit_locked(), ixgbe_dcbnl_devreset()
+	 * and the ethtool reset paths, so holding it across the rtnl drop
+	 * would deadlock those callers against ixgbe_pci_reset_done(), which
+	 * needs to re-acquire rtnl.  During the reset window concurrent
+	 * rtnl-holding paths must treat the netdev as detached, while teardown
+	 * paths also observe __IXGBE_DOWN set by ixgbe_down() via
+	 * ixgbe_close_suspend(), matching the existing ixgbe_io_error_detected()
+	 * flow.
+	 */
+
+	if (test_bit(__IXGBE_SERVICE_INITED, &adapter->state)) {
+		/* The service timer was already stopped by ixgbe_down() via
+		 * ixgbe_close_suspend(); if the netdev was not running, the
+		 * timer is not armed.  Only the currently queued service task
+		 * (if any) still needs to be flushed here.
+		 */
+		cancel_work_sync(&adapter->service_task);
+		clear_bit(__IXGBE_SERVICE_SCHED, &adapter->state);
+	}
+}
+
+/**
+ * ixgbe_pci_reset_done - called after the pci bus has been reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Re-initialize the device after a PCI function reset. The PCI core has
+ * already called pci_restore_state() before invoking this callback, so the
+ * saved Command register (including bus mastering) is back in place.
+ */
+static void ixgbe_pci_reset_done(struct pci_dev *pdev)
+{
+	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+	bool running;
+	int err = 0;
+
+	if (!adapter)
+		return;
+
+	netdev = adapter->netdev;
+
+	rtnl_lock();
+	if (!test_and_clear_bit(__IXGBE_PCI_RESET_PREPARED, &adapter->state)) {
+		rtnl_unlock();
+		return;
+	}
+
+	adapter->hw.hw_addr = adapter->io_addr;
+	ixgbe_reset(adapter);
+	IXGBE_WRITE_REG(&adapter->hw, IXGBE_WUS, ~0);
+	running = netif_running(netdev);
+
+	err = ixgbe_rebuild_fcoe_queues(adapter);
+	if (err)
+		e_dev_err("Cannot rebuild queue layout after PCI reset: %d\n",
+			  err);
+	if (running && !err) {
+		err = ixgbe_open(netdev);
+		if (err)
+			e_dev_err("Cannot re-open netdev after PCI reset: %d. A new reset is needed.\n",
+				  err);
+	}
+	if (err && running)
+		dev_close(netdev);
+	/* Restore presence so userspace can retry later. If recovery failed,
+	 * dev_close() cleared IFF_UP first so netif_device_attach() will not wake
+	 * Tx queues without a successful open.
+	 */
+	netif_device_attach(netdev);
+	rtnl_unlock();
+}
+
 /**
  * ixgbe_io_resume - called when traffic can start flowing again.
  * @pdev: Pointer to PCI device
@@ -12441,6 +12549,7 @@ static void ixgbe_io_resume(struct pci_dev *pdev)
 	if (err && running)
 		dev_close(netdev);
 
+	/* A failed running device is down; attach permits a later open retry. */
 	netif_device_attach(netdev);
 	rtnl_unlock();
 }
@@ -12449,6 +12558,8 @@ static const struct pci_error_handlers ixgbe_err_handler = {
 	.error_detected = ixgbe_io_error_detected,
 	.slot_reset = ixgbe_io_slot_reset,
 	.resume = ixgbe_io_resume,
+	.reset_prepare = ixgbe_pci_reset_prepare,
+	.reset_done = ixgbe_pci_reset_done,
 };
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ixgbe_pm_ops, ixgbe_suspend, ixgbe_resume);
-- 
2.53.0

