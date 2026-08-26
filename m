Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FBD442FCD
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755200; cv=none; b=CH6egsZ+YI1aR9TK973CCgD6Om+MlxLnFzBYp3u2pKAf2UW01cqWBMm5I5/+lsWoVt4hHlaUac3fCXshubEylcfIhyW/NAyFGoRAnKiCJ+akgDkmTZQ7EK0zTfCNHzmML6+1Pu9o2kQyDjG+vzxT3sWUShOEx60LWrf8z8icCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755200; c=relaxed/simple;
	bh=OH30fKT2PLxRbyaF4t4FBXNvX5ZHKgrVbj3y8brThXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUOrPgOZzebqiTGVIDev6i8gR107pzmc8c1YP5/CX3vGNVltLXLLqGAk4NaLF1bs/rDXi8/YX3fRr94r/awtQm2/s+z1mtess5s6SrCyGuVbGqKBV4YKbTBV/HwKsyuX6T15tW9ZJnbZzumce+BHdw6EicHaIuVjtHKie1mWQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nb2M3rGi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nb2M3rGi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787755196; x=1819291196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OH30fKT2PLxRbyaF4t4FBXNvX5ZHKgrVbj3y8brThXg=;
  b=nb2M3rGiwyH1F0LBSweb/2CKY2ATJdjIDb/Nasa1RMJjkOjAj+BfMOwK
   5XY9ZW+k4ksJvQJIlRj/7WFqGrFXVZfRvF8u1Mao6aViWZQ0vO3on9zF9
   rR5ZXCzR2dv1gdZtj+fEurCKGx2FvSbNzDOzs9vOsGsxDrTH5ljshfupN
   /sP3WwweGi0NCwm2UdC5oG189UVriAVvr1F1A2KRS+BbyzVRnYpJBKigY
   jcjHb1/O3CF7HlyqfguzHmDKsH+1YJE+9WslKU660GN9tkbmSq6YAEJcB
   KKvhbKHwQvmBHlm6u/rXqK3S6h3sA4JIM96gqVQPrXSxOtSSPdYXVtTY9
   A==;
X-CSE-ConnectionGUID: GVbNewXsSRuErsNCPTcNcA==
X-CSE-MsgGUID: eY1Hl8EbTSOh2cN5Qmu1yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99398914"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="99398914"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 07:39:53 -0700
X-CSE-ConnectionGUID: +c239XD+QluVEb4bw+eWrw==
X-CSE-MsgGUID: vUSkJwI1RyOOq+FHOxgCYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="292454827"
Received: from os-delivery.igk.intel.com ([10.123.220.8])
  by fmviesa001.fm.intel.com with ESMTP; 26 Aug 2026 07:39:51 -0700
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-net v5] ixgbevf: fix link speed reporting for Hyper-V E610 VFs
Date: Wed, 26 Aug 2026 16:39:50 +0200
Message-ID: <20260826143950.2385891-1-tomasz.lichwala@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an E610 VF is running under Hyper-V, the VFLINKS register does not
carry valid link speed. The existing code reads speed from VFLINKS, which
does not reflect the actual negotiated speed. This results in ethtool
reporting a stale or incorrect link speed.

The Hyper-V synthetic NIC exposes the actual link status through
emulated PCI config space at offset 0x209 in VFLINKS register format.
Read and decode link status from there when checking link on E610 VFs.

To avoid generating unnecessary VMBus transactions on every watchdog
cycle, read the PCI config register on demand when ethtool or sysfs
queries link speed, rather than polling it periodically. The cached
value is used by the watchdog and link state notifications as before.

Guard the PCI config space read with IS_ENABLED(CONFIG_PCI_MMCONFIG),
since accessing offsets above 256 requires MMCONFIG support.

Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
---
Note on IS_ENABLED(CONFIG_PCI_MMCONFIG): this guard is kept intentionally
for consistency with ixgbevf_hv_reset_hw_vf() which uses the same pattern
to access emulated PCI config space at offset 0x201. Both functions read
extended config space offsets (>256) that require MMCONFIG on x86. Hyper-V
E610 VFs are currently only deployed on x86 where CONFIG_PCI_MMCONFIG is
always enabled. If ARM64 Hyper-V support becomes relevant, both functions
should be updated together.

Note on watchdog race: the mbx_lock serializes concurrent check_link calls
so ethtool and watchdog cannot execute check_link simultaneously. The
ethtool response reads adapter->link_speed immediately after check_link
returns (same function, same thread) and always reports the fresh value.
The watchdog's pre-existing pattern of caching adapter fields into locals
before the lock applies to all HV VF types and is not introduced by this
patch.

v5:
 - Use subsystem device ID check instead of mac type to ensure the
   on-demand ethtool read only triggers for Hyper-V VFs, not bare-metal
v4:
 - Read link speed on demand from ethtool/sysfs query instead of polling
   every watchdog cycle to avoid unnecessary VMBus transactions (ethtool.c)
 - Restore get_link_status caching for E610 VFs in check_link
 - Add IS_ENABLED(CONFIG_PCI_MMCONFIG) guard for PCI config reads above
   offset 256
 - Add CC netdev@vger.kernel.org
v3:
 - Remove #if IS_ENABLED(CONFIG_PCI_MMCONFIG) preprocessor guard
 - Replace goto decode label with if/else control flow
 - Move get_link_status check into else branch (non-E610 path only)
 - Expand commit message with problem description
v2:
 - Simplify error path: return 0 with link_up=false instead of
   propagating PCI read error code
 - Fix alignment in macro definitions
 - Update comment describing Hyper-V PCI config offsets
 drivers/net/ethernet/intel/ixgbevf/ethtool.c | 12 ++++
 drivers/net/ethernet/intel/ixgbevf/vf.c      | 68 +++++++++++++++++---
 2 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 537a60d5276f..5d0fb4f4d9a3 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -83,6 +83,18 @@ static int ixgbevf_get_link_ksettings(struct net_device *netdev,
 				      struct ethtool_link_ksettings *cmd)
 {
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	/* Hyper-V E610 VFs: read current link speed from PCI config space
+	 * on every link speed query.
+	 */
+	if (adapter->pdev->subsystem_device == IXGBE_SUBDEV_ID_E610_VF_HV) {
+		spin_lock_bh(&adapter->mbx_lock);
+		hw->mac.get_link_status = true;
+		hw->mac.ops.check_link(hw, &adapter->link_speed,
+				       &adapter->link_up, false);
+		spin_unlock_bh(&adapter->mbx_lock);
+	}
 
 	ethtool_link_ksettings_zero_link_mode(cmd, supported);
 	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index f6df86d124b9..a84b62641e9b 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -1,14 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 1999 - 2024 Intel Corporation. */
 
+#include <linux/unaligned.h>
+
 #include "vf.h"
 #include "ixgbevf.h"
 
-/* On Hyper-V, to reset, we need to read from this offset
- * from the PCI config space. This is the mechanism used on
- * Hyper-V to support PF/VF communication.
+/* On Hyper-V the PF/VF communication is through emulated PCI config
+ * space. The reset and link status are exposed at the offsets below.
  */
-#define IXGBE_HV_RESET_OFFSET           0x201
+#define IXGBE_HV_RESET_OFFSET		0x201
+#define IXGBE_HV_LINK_STATUS_OFFSET	0x209
+#define IXGBE_HV_LINK_STATUS_SIZE	4
 
 static inline s32 ixgbevf_write_msg_read_ack(struct ixgbe_hw *hw, u32 *msg,
 					     u32 *retmsg, u16 size)
@@ -901,6 +904,40 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 	return ret_val;
 }
 
+/**
+ * ixgbevf_hv_read_links_e610 - read link status from PCI config space
+ * @hw: pointer to hardware structure
+ * @links_reg: pointer to store read value
+ *
+ * On Hyper-V E610 VFs the VFLINKS register does not carry valid link speed.
+ * Instead, link status is exposed through emulated PCI config space at offset
+ * 0x209 in VFLINKS register format.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static s32 ixgbevf_hv_read_links_e610(struct ixgbe_hw *hw, u32 *links_reg)
+{
+	struct ixgbevf_adapter *adapter = hw->back;
+	u8 data[IXGBE_HV_LINK_STATUS_SIZE];
+
+	if (!IS_ENABLED(CONFIG_PCI_MMCONFIG)) {
+		dev_err_once(&adapter->pdev->dev,
+			     "cannot read link status, PCI_MMCONFIG is required for Hyper-V\n");
+		return -EOPNOTSUPP;
+	}
+
+	for (int i = 0; i < IXGBE_HV_LINK_STATUS_SIZE; i++) {
+		int ret = pci_read_config_byte(adapter->pdev,
+					       IXGBE_HV_LINK_STATUS_OFFSET + i,
+					       &data[i]);
+		if (ret)
+			return pcibios_err_to_errno(ret);
+	}
+
+	*links_reg = get_unaligned_le32(data);
+	return 0;
+}
+
 /**
  * ixgbevf_hv_check_mac_link_vf - check link
  * @hw: pointer to private hardware struct
@@ -909,6 +946,7 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
  * @autoneg_wait_to_complete: unused
  *
  * Hyper-V variant; there is no mailbox communication.
+ * For E610 VFs, link status is read from emulated PCI config space.
  */
 static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
 					ixgbe_link_speed *speed,
@@ -926,8 +964,16 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
 	if (!mac->get_link_status)
 		goto out;
 
-	/* if link status is down no point in checking to see if pf is up */
-	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+	if (mac->type == ixgbe_mac_e610_vf) {
+		if (ixgbevf_hv_read_links_e610(hw, &links_reg)) {
+			*link_up = false;
+			*speed = IXGBE_LINK_SPEED_UNKNOWN;
+			return 0;
+		}
+	} else {
+		links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
+	}
+
 	if (!(links_reg & IXGBE_LINKS_UP))
 		goto out;
 
@@ -941,8 +987,11 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
 			udelay(100);
 			links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
 
-			if (!(links_reg & IXGBE_LINKS_UP))
-				goto out;
+			if (!(links_reg & IXGBE_LINKS_UP)) {
+				*link_up = false;
+				*speed = IXGBE_LINK_SPEED_UNKNOWN;
+				return 0;
+			}
 		}
 	}
 
@@ -956,6 +1005,9 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
 	case IXGBE_LINKS_SPEED_100_82599:
 		*speed = IXGBE_LINK_SPEED_100_FULL;
 		break;
+	default:
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+		break;
 	}
 
 	/* if we passed all the tests above then the link is up and we no
-- 
2.54.0

