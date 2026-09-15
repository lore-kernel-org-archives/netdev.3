Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6E3BB69F
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476951; cv=none; b=prM25WjcphdvpRyaQqmrp2Dnc+DNFVsVzyKa0OZbouzalVZsnHLznZ4Tjx+jB8c4kXj7cf9pmBJkBShFVVScIRO4IslqBP4NK3YYdeGWe1rJFB8jmtP7orxow7bxjoDv0vvExcje1WUsidVWQx+c1OU6tuQY/T+qpQ3ClNUHivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476951; c=relaxed/simple;
	bh=rK6IW2BjueDdcIhIO7EvEeSjm2GmE/765EP6oWxFOAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgMaCiMwrzrLhQGH8WUQah0y4gs5R7cJao8OdUXcc85tGm74/ziDUdGM7bGX7+BGgq8NOR0Q95UNenNXkyIc2MG3czlKIMZlC7GGsNgoe4ughdXAY3fCKD01hdl7KhJxqOgaLWVmNWNsR8Uz75ONwm7Y7kqR6+6bOuX6ug5U+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDoGvZZh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDoGvZZh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476950; x=1821012950;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rK6IW2BjueDdcIhIO7EvEeSjm2GmE/765EP6oWxFOAU=;
  b=gDoGvZZhAErpXmNsfgSMoHPqFFbzITO0H8vtp5kBfJZDXm7aEDh6sJix
   t1fu7aRr1O9yIYURSxhFwgYso0ssEhOVGoNVsLXJKvnGqU38f8GB3GgEl
   tlU5ATvmM0t2UEt6mVUhIbQnP5rgCgFcmWiCB9rgEwuzhfRywBWJNAR75
   ouiAWPEJm7t7gFzYDY4BlEXJ0A/+L3hdF2a6iw8+PACOC2H/k/W6Eh6dn
   w/Cqo4jVRm9ppRFiAWvo+4t5MB+Xc173s8k1n78eA4dtN+ZhTWzL0n8EC
   FgcxmSJTPyBpdkx9F1ESGok7GVG/wiEKRqIkwKfC3xE/KzSY48tl6hJBu
   A==;
X-CSE-ConnectionGUID: +tblHEAVT1uJO0mR5YXlRA==
X-CSE-MsgGUID: 3ZzvixBVS9KdarpA6oDBkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607053"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112607053"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:50 -0700
X-CSE-ConnectionGUID: lzVVUaZjRu+Q88XlpnHlSQ==
X-CSE-MsgGUID: gItMP/fSQ3eQOgq1WniuZg==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:48 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ixgbe: remove ixgbe_ping_all_vfs() from link state change handlers
Date: Tue, 15 Sep 2026 14:55:47 +0200
Message-ID: <20260915125547.3975992-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When multiple VFs are brought up simultaneously, a VF can receive a CTS
(Clear To Send) mailbox message instead of the expected RESET | (N)ACK
response, because the watchdog fires a gratuitous ping right as the VF
mailbox transaction is in progress.

Remove the ixgbe_ping_all_vfs() call from both ixgbe_watchdog_link_is_up()
and ixgbe_watchdog_link_is_down().  Both paths contain an identical call
with the same race window during VF initialization: link-state changes
(up or down) can arrive while VFs are mid-initialization, and the
gratuitous ping from either direction collides with the VF mailbox state
machine for the same reason.

Link-state changes are already communicated to VFs through the normal
mailbox protocol; these extra pings are redundant on both paths.

This removes the last two callers of ixgbe_ping_all_vfs(), so remove
the now-unused function and its declaration as well.

Suggested-by: Sebastian Basierski <sebastianx.basierski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  6 ------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 14 --------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |  1 -
 3 files changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8d3627c..d816aa1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8195,9 +8195,6 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 
 	/* update the default user priority for VFs */
 	ixgbe_update_default_up(adapter);
-
-	/* ping all the active vfs to let them know link has changed */
-	ixgbe_ping_all_vfs(adapter);
 }
 
 /**
@@ -8228,9 +8225,6 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 
 	e_info(drv, "NIC Link is Down\n");
 	netif_carrier_off(netdev);
-
-	/* ping all the active vfs to let them know link has changed */
-	ixgbe_ping_all_vfs(adapter);
 }
 
 static bool ixgbe_ring_tx_pending(struct ixgbe_adapter *adapter)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 431d77d..da641e9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1515,20 +1515,6 @@ static inline void ixgbe_ping_vf(struct ixgbe_adapter *adapter, int vf)
 	ixgbe_write_mbx(hw, &ping, 1, vf);
 }
 
-void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter)
-{
-	struct ixgbe_hw *hw = &adapter->hw;
-	u32 ping;
-	int i;
-
-	for (i = 0 ; i < adapter->num_vfs; i++) {
-		ping = IXGBE_PF_CONTROL_MSG;
-		if (adapter->vfinfo[i].clear_to_send)
-			ping |= IXGBE_VT_MSGTYPE_CTS;
-		ixgbe_write_mbx(hw, &ping, 1, i);
-	}
-}
-
 /**
  * ixgbe_set_all_vfs - update vfs queues
  * @adapter: Pointer to adapter struct
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
index bc4cab9..f755bfd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h
@@ -18,7 +18,6 @@ void ixgbe_restore_vf_multicasts(struct ixgbe_adapter *adapter);
 bool ixgbe_check_mdd_event(struct ixgbe_adapter *adapter);
 void ixgbe_msg_task(struct ixgbe_adapter *adapter);
 int ixgbe_vf_configuration(struct pci_dev *pdev, unsigned int event_mask);
-void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter);
 void ixgbe_set_all_vfs(struct ixgbe_adapter *adapter);
 int ixgbe_ndo_set_vf_mac(struct net_device *netdev, int queue, u8 *mac);
 int ixgbe_ndo_set_vf_vlan(struct net_device *netdev, int queue, u16 vlan,
-- 
2.52.0

