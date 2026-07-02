Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CBC48B372
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984920; cv=none; b=uX2Dz5TuoynN8tZdGt4NSAWSR/1XmfKA8/048AJedPyOPwD7aR6q+XwXwU7KdpGI7wXHWPUhfX7LmuWTGC3AhK1WnXHUjShni++SxGUN0uT5MD6BbO5mVAi04mgIUo82cJ0+YLUTv3ACfSPyUd4b9tFC9GsTXrlgQcKee4wxy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984920; c=relaxed/simple;
	bh=MabDCRBsN+CDhhi4lheUcomDoZdUFzurbe9YKVaXyjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gmUfMMDU8y52xPhSXnF0Gj3Qodgry5oNOu51BARV+WqVANefve7x/CKfHJ3LreSgwpCPcizBCCuEIhrF3LqsFybHRh2khn/eXQ5UJ6Un75CpKHc7Nl4p+tPzbZsm4XvxJHy8SH7gXtm9yiOH9907V5Ot+fGhqJfeilSeplAitnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mB44+dRz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mB44+dRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782984919; x=1814520919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MabDCRBsN+CDhhi4lheUcomDoZdUFzurbe9YKVaXyjk=;
  b=mB44+dRz1P2ppRAM3oPmqlCIrMarw43QKbfNcNwjFe1SIXRNrj2N4zpX
   +BfIeEQcxREaqteCejxjrIKx394BGTgk0GA8Uw3x8ABEDUFIoisr7svGN
   lFmft6aV0YytpH6UOWgjU2UI2NXMKy8BCDgH+GJRAFslcz07Zr1hDOwIR
   2hduFN5gBkUwa2HhKDpmLGqwHKy9C7jKVbIgD9Ja19YWrU218BXcsrDcS
   UhKo6HI2RfAX/SW2QZLphRzrKwaZJUJpHzoAk8EGBIqdhUteK8BB6c9q2
   Wzpix3GZM6/HGf6rLvEfweZNZAg1ukY98d3BRb//L/1QzwYeqz8MVOQx9
   Q==;
X-CSE-ConnectionGUID: QQ+R7mdCQPyk6y80pHjXZA==
X-CSE-MsgGUID: YL582xrVTw+iTOZD12Sksg==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="87649819"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="87649819"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:35:19 -0700
X-CSE-ConnectionGUID: eesZN8QhSUemYR8pXgNGcA==
X-CSE-MsgGUID: ErbuBx6qRWy92hRoxgxbtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253476429"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa009.jf.intel.com with ESMTP; 02 Jul 2026 02:35:18 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v1 5/6] ixgbe: E610: add MAC address runtime refresh
Date: Thu,  2 Jul 2026 11:15:52 +0200
Message-Id: <20260702091553.57112-6-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
References: <20260702091553.57112-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever MGMT requests MAC addr change and FW does it, driver does not
get aligned to that change. Current - legacy approach doesn't handle
such scenario.

Poll RAR0 (Receive Address Register) each service task cycle and update
driver and netdev structs once new MAC addr is detected. It may happen
that FW updates MAC address stored in RAR0 during runtime so SW shall fetch
the new address.

Refresh addr also during reset path to ensure the address survives RAR0
clearing during init_hw().

Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d1cfe913081f..ce2b1e208c0f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6499,6 +6499,36 @@ void ixgbe_disable_tx(struct ixgbe_adapter *adapter)
 	}
 }
 
+static void ixgbe_mac_addr_refresh(struct ixgbe_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int err;
+
+	if (hw->mac.type != ixgbe_mac_e610)
+		return;
+
+	/* fetch address stored currently in RAR0 in case the addr has been
+	 * altered by FW; if so, use it as the default one
+	 */
+	err = hw->mac.ops.get_mac_addr(hw, hw->mac.addr);
+	if (err) {
+		e_dev_warn("Cannot get MAC address\n");
+		return;
+	}
+
+	if (ether_addr_equal(netdev->dev_addr, hw->mac.addr) ||
+	    !is_valid_ether_addr(hw->mac.addr))
+		return;
+
+	ASSERT_RTNL();
+
+	eth_hw_addr_set(netdev, hw->mac.addr);
+	ether_addr_copy(adapter->mac_table[0].addr, hw->mac.addr);
+
+	call_netdevice_notifiers(NETDEV_CHANGEADDR, netdev);
+}
+
 void ixgbe_reset(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
@@ -6516,6 +6546,8 @@ void ixgbe_reset(struct ixgbe_adapter *adapter)
 			     IXGBE_FLAG2_SFP_NEEDS_RESET);
 	adapter->flags &= ~IXGBE_FLAG_NEED_LINK_CONFIG;
 
+	ixgbe_mac_addr_refresh(adapter);
+
 	err = hw->mac.ops.init_hw(hw);
 	switch (err) {
 	case 0:
@@ -8701,6 +8733,11 @@ static void ixgbe_service_task(struct work_struct *work)
 			ixgbe_handle_fw_event(adapter);
 		ixgbe_check_media_subtask(adapter);
 	}
+
+	rtnl_lock();
+	ixgbe_mac_addr_refresh(adapter);
+	rtnl_unlock();
+
 	ixgbe_reset_subtask(adapter);
 	ixgbe_phy_interrupt_subtask(adapter);
 	ixgbe_sfp_detection_subtask(adapter);
-- 
2.31.1

