Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530CA4F7CDD
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738494; cv=none; b=T2GpNyfA/B+alBXmsvP9AhAjdsji/aqz5933DUIKnbiLWZZtWqForGBNWSIjwAEnK8wsAEDOf/5ODrGO+X7Oiw7oozRvPAB9tWMHRwq+IUMNkYTyQ10WK3FHm+xiWHAo8sXNPqkoeQLg0vG0OmEy9+fcM3cz/97qjmAz/0pkqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738494; c=relaxed/simple;
	bh=alPd3jIpdS35on6zf2c81Y02DU9c1ZRoSXkBLUj8oEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=opJTLvT/Q28urfguwOZgf8hkvcwg/pHREYx+u4x3XLL83SFSjKwrIgcKDCliTAen/45Ax09nGaexw5/nQVNRNF3BNpByuxx5V+01cV5N+grrqBeH0NiFnyBOHOobrdGdrUVqbGYGfXLog9lN46iGZGz0Pc698/H0MbI9LnK6jQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyzswVPN; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyzswVPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738493; x=1821274493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=alPd3jIpdS35on6zf2c81Y02DU9c1ZRoSXkBLUj8oEs=;
  b=jyzswVPN7EldigBsfFqrAJUZoWHjLe2/Z+qaAcEpKij9ZPQ3Bw4PyF2x
   7LvigYoCo1707ieaBofCY2zjxwdhKL1mZUEAHM5H2+juNUcrjM6gu38wd
   gonOj9utSL7x5ac8FOdZuK1ZsaoGeAh5myLYTlZYpCEmof/rBf4WHw7+G
   ESEXAgmnhzhbbVtjkOMl9rnuciUeawVah7m10ev0lnrCyg0Wt8ZN2AzFi
   nTy4i+Ooa0g7F9esQRV7P5dshKWpoZCOiTMqnU9K4RGf0N0M+fUi4esLf
   FBJFqk2M5acX5CqTGYY10UgdUxcaCLoKKRXaWxDWn1DVpENYR1IdmRlcq
   Q==;
X-CSE-ConnectionGUID: Xg9dWTJIS9+XtYKYlxRK3w==
X-CSE-MsgGUID: KU1VOlv1Q3+SYAFypOzy7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="744158"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="744158"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:34:53 -0700
X-CSE-ConnectionGUID: ZnUoGYpdRJiMkT+yZZOcag==
X-CSE-MsgGUID: xEebdWUVSQKoVfaV1sak/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="299513973"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa001.fm.intel.com with ESMTP; 18 Sep 2026 06:33:33 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2] ixgbe: remove ixgbe_ping_all_vfs() from link state change handlers
Date: Fri, 18 Sep 2026 15:33:27 +0200
Message-ID: <20260918133327.4170034-1-aleksandr.loktionov@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2: no code changes, resending to pick up Reviewed-by
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  6 ------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 14 --------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |  1 -
 3 files changed, 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f918564..365acf8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8181,9 +8181,6 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 
 	/* update the default user priority for VFs */
 	ixgbe_update_default_up(adapter);
-
-	/* ping all the active vfs to let them know link has changed */
-	ixgbe_ping_all_vfs(adapter);
 }
 
 /**
@@ -8214,9 +8211,6 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 
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

