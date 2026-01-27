Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204AE257844
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553056; cv=none; b=b9jQ7dkNv9iiu6TuzbLTCBZLd9O8KRrG25+pEI1npHt4Pm2cH21IIb/aQwlXfn8YZGRR976VU62hHCYYejXrOQVDRlH3Ne+SoAQw2/R+6tViynJ0TLlJzeVYTUyq17MT7PO7NH5OtqDjVbGzW3BEwfU/df2IH9lpFVUE3iZfgPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553056; c=relaxed/simple;
	bh=IESa9dpzpxh7V882GFzjaKPDjWWoo0OVdGzGgHMX8/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXzxOB+wzupJhdYAFc0lwLpy3yKGvvQfcoJypShZwiJ5ZmpHwHXKaSWuWxCogBelpg2Guggz/ubW/L6FW1UKuPsoga9ZZ5DG4GjQBzLsZwUGvpwF/zcg0b8BFgC8TPrR3daqm+wF3nEDLD6/LzH2QPF3rSi3kWubItkKwJqalIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTnK8Vie; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTnK8Vie"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769553056; x=1801089056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IESa9dpzpxh7V882GFzjaKPDjWWoo0OVdGzGgHMX8/g=;
  b=OTnK8Viem7wfLXcTGt3GpSve5JxqFO6hASFzn0+iRsESwt5FZyNWHxJi
   jd4ZBa+qtSor+AaJTkIeHIBURCcW5kUDK21PP0kYD8wBOjwHyrD109OC5
   b5wdT0wd6uqPXYsYRSvEyjwRdTO0EYL8KCKVHEJ++7dPcxxtpAdS2/mrk
   vrdd5A6fY0ZcZUKVDon7PPzI+YPR66JUu8tzIPs++6qKzCdZ58m/5KRb6
   eqZVtPi8p2RgCgvQp6foJkRL0g3SjlJCel1xtG4nNWFVX4BAxQ6hRHwm2
   T6zTQaCECjs1ru7HRlc2LbdQlPUGO+MoUfDc99sMCMo2qeUPkSWaz2n4/
   Q==;
X-CSE-ConnectionGUID: gYkZmCv0TqqVbuMSm6dC6Q==
X-CSE-MsgGUID: svKt8TD9Q0q2wZt20VzJJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="93418589"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="93418589"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 14:30:54 -0800
X-CSE-ConnectionGUID: CH87//nATZuVJvReGC3qXg==
X-CSE-MsgGUID: EEqbhoCjRtGN3GzVzykVkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="245714637"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 27 Jan 2026 14:30:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <enjuk@amazon.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	horms@kernel.org,
	kohei@enjuk.org
Subject: [PATCH net 1/4] ixgbe: fix memory leaks in the ixgbe_recovery_probe() path
Date: Tue, 27 Jan 2026 14:30:42 -0800
Message-ID: <20260127223047.3979404-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260127223047.3979404-1-anthony.l.nguyen@intel.com>
References: <20260127223047.3979404-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <enjuk@amazon.com>

When ixgbe_recovery_probe() is invoked and this function fails,
allocated resources in advance are not completely freed, because
ixgbe_probe() returns ixgbe_recovery_probe() directly and
ixgbe_recovery_probe() only frees partial resources, resulting in memory
leaks including:
- adapter->io_addr
- adapter->jump_tables[0]
- adapter->mac_table
- adapter->rss_key
- adapter->af_xdp_zc_qps

The leaked MMIO region can be observed in /proc/vmallocinfo, and the
remaining leaks are reported by kmemleak.

Don't return ixgbe_recovery_probe() directly, and instead let
ixgbe_probe() to clean up resources on failures.

Fixes: 29cb3b8d95c7 ("ixgbe: add E610 implementation of FW recovery mode")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 034618e79169..a69b5a8a91cb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11468,14 +11468,12 @@ static void ixgbe_set_fw_version(struct ixgbe_adapter *adapter)
  */
 static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
 {
-	struct net_device *netdev = adapter->netdev;
 	struct pci_dev *pdev = adapter->pdev;
 	struct ixgbe_hw *hw = &adapter->hw;
-	bool disable_dev;
 	int err = -EIO;
 
 	if (hw->mac.type != ixgbe_mac_e610)
-		goto clean_up_probe;
+		return err;
 
 	ixgbe_get_hw_control(adapter);
 	mutex_init(&hw->aci.lock);
@@ -11507,13 +11505,6 @@ static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
 shutdown_aci:
 	mutex_destroy(&adapter->hw.aci.lock);
 	ixgbe_release_hw_control(adapter);
-clean_up_probe:
-	disable_dev = !test_and_set_bit(__IXGBE_DISABLED, &adapter->state);
-	free_netdev(netdev);
-	devlink_free(adapter->devlink);
-	pci_release_mem_regions(pdev);
-	if (disable_dev)
-		pci_disable_device(pdev);
 	return err;
 }
 
@@ -11655,8 +11646,13 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_sw_init;
 
-	if (ixgbe_check_fw_error(adapter))
-		return ixgbe_recovery_probe(adapter);
+	if (ixgbe_check_fw_error(adapter)) {
+		err = ixgbe_recovery_probe(adapter);
+		if (err)
+			goto err_sw_init;
+
+		return 0;
+	}
 
 	if (adapter->hw.mac.type == ixgbe_mac_e610) {
 		err = ixgbe_get_caps(&adapter->hw);
-- 
2.47.1

