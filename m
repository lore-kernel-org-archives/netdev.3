Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819B346A0B
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787465413; cv=none; b=PLVbdSMB/8OUoQALt/5mlBCcY7errs/2Y3G4pU6AmtF5YveQQ6ls/YQPC6h1dkxIPyG3HGoeN3oAchkDOVpje1krlLBg92rmFtV7/o0iVg8e8sZQ/QKFpdW7cE+9PVQH51ohy43GyIGhvZ14O9PazLbrG3tzQuKxS6lAd90ltTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787465413; c=relaxed/simple;
	bh=fztk5UFQ8OlR37tKLnJ5Y2qtD+GioIu0/kh6dxRKlmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kSXGC7A31FPASDVBbPIrvwP3QC5RRQqkdPDtiIeHYMi0apRREObKDxTVnn+lL0KWjbITiAeyJWYTj+FNW18uZzhal6pj63GagMcptUbyaUxG+nILGo6/t8rtadu0nzaThEEMFaICFxpLk2MqRnrp2W/HVKr9WbIabdWPPZEAFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgK+s2L5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgK+s2L5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787465410; x=1819001410;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fztk5UFQ8OlR37tKLnJ5Y2qtD+GioIu0/kh6dxRKlmU=;
  b=GgK+s2L5dltzPZ1+6F5w85duuysTYLuhLvfVTUnXC0fARR9m3cwvSLrI
   vn+nlXfCKc2897v3ZgDDZGWlzA631EBvCD48hlmffbLDTB0FfB2KPyAD9
   0HPkXIQEbnefIe1TFlMADpaxCKe7kl42wG6bKsxnGz4Ihcr0tk8xCgzIp
   xQeiE8vnjPrWMZAQxe2EdZQvARgSalASM3nnYbn+6A+VWnLwed5hrn8tv
   W38W/oQTW0rRckVy3xIT+WCsXr42Mg3Zrgs8CG3p34c/rBamhIBkkPsy+
   IdrWOjJitmLWy7N/8WYMuDRzeqORzhDme1wH7t5xkENKSD+XzEp3Du5/i
   A==;
X-CSE-ConnectionGUID: 5lGccQ2rTGa9s+cA2M5y3Q==
X-CSE-MsgGUID: e5IVgeE8QReEW30z4bZrsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="99479979"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="99479979"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2026 23:10:10 -0700
X-CSE-ConnectionGUID: H/Dies6kTjq7C4R2IgfkTA==
X-CSE-MsgGUID: IoxhT17TRZOZ99W1pC+ueg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="270519070"
Received: from ccdlinuxdev11.iil.intel.com ([143.185.162.70])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2026 23:10:08 -0700
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	dima.ruinskiy@intel.com,
	anthony.l.nguyen@intel.com,
	allen.lan@intel.com,
	acelan.kao@canonical.com,
	kuba@kernel.org
Subject: [PATCH iwl-next v3] igc: Support ACPI-based MAC passthrough
Date: Sun, 23 Aug 2026 09:10:06 +0300
Message-Id: <20260823061006.344040-1-dima.ruinskiy@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some systems implement a system MAC address object in the ACPI table,
using either \\_SB.AMAC or \\MACA object names. This system MAC address,
when enabled, is intended to override the permanent MAC address of a
network controller in a docking station connected to the system.

Implement lookup of the relevant ACPI object names and use them to
initialize the MAC address. Limit the scope to I225/I226 device IDs used
in docking stations, to avoid interfering with onboard I225/I226 NICs.

On systems where the feature is disabled or unsupported, the ACPI objects
do not exist or do not contain a valid Ethernet MAC, causing a fallback
to the existing MAC address initialization path.

Assisted-by: GitHub-Copilot:claude-opus-4.7
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
---
v3: fix typo that introduced check reversal
v2: limit scope to dock device ids
v1: initial version
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_base.c |  8 +++
 drivers/net/ethernet/intel/igc/igc_hw.h   |  2 +
 drivers/net/ethernet/intel/igc/igc_main.c | 69 +++++++++++++++++++++--
 4 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 88291f775c22..05affaa04aa4 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -567,6 +567,7 @@ enum igc_tx_flags {
 
 enum igc_boards {
 	board_base,
+	board_dock,
 };
 
 /* The largest size we can write to the descriptor is 65535.  In order to
diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index ab9120a3127f..c9067cc79b69 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -474,4 +474,12 @@ const struct igc_info igc_base_info = {
 	.get_invariants		= igc_get_invariants_base,
 	.mac_ops		= &igc_mac_ops_base,
 	.phy_ops		= &igc_phy_ops_base,
+	.is_dock		= false,
+};
+
+const struct igc_info igc_dock_info = {
+	.get_invariants		= igc_get_invariants_base,
+	.mac_ops		= &igc_mac_ops_base,
+	.phy_ops		= &igc_phy_ops_base,
+	.is_dock		= true,
 };
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 62aaee55668a..d14b7666b5d7 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -69,9 +69,11 @@ struct igc_info {
 	struct igc_mac_operations *mac_ops;
 	const struct igc_phy_operations *phy_ops;
 	struct igc_nvm_operations *nvm_ops;
+	bool is_dock;
 };
 
 extern const struct igc_info igc_base_info;
+extern const struct igc_info igc_dock_info;
 
 enum igc_forced_speed_duplex {
 	IGC_FORCED_10H,
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 82800a4a6d6c..15d0815a2110 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -11,6 +11,8 @@
 #include <net/pkt_sched.h>
 #include <linux/bpf_trace.h>
 #include <net/xdp_sock_drv.h>
+#include <linux/acpi.h>
+#include <linux/hex.h>
 #include <linux/pci.h>
 #include <linux/mdio.h>
 
@@ -44,6 +46,7 @@ static const char igc_copyright[] =
 
 static const struct igc_info *igc_info_tbl[] = {
 	[board_base] = &igc_base_info,
+	[board_dock] = &igc_dock_info,
 };
 
 static const struct pci_device_id igc_pci_tbl[] = {
@@ -54,8 +57,8 @@ static const struct pci_device_id igc_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K), .driver_data = board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K2), .driver_data = board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_K), .driver_data = board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LMVP), .driver_data = board_base },
-	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LMVP), .driver_data = board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LMVP), .driver_data = board_dock },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LMVP), .driver_data = board_dock },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_IT), .driver_data = board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LM), .driver_data = board_base },
 	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_V), .driver_data = board_base },
@@ -7116,6 +7119,57 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+static bool igc_get_acpi_mac_passthru(u8 *mac)
+{
+	static const struct {
+		const char *name;
+		acpi_object_type type;
+		u32 length;
+	} sources[] = {
+		{ "\\_SB.AMAC", ACPI_TYPE_BUFFER, 23 },
+		{ "\\MACA",     ACPI_TYPE_STRING, 22 },
+	};
+	struct acpi_buffer buffer;
+	union acpi_object *obj;
+	bool mac_found = false;
+	acpi_status status;
+	u8 buf[ETH_ALEN];
+	int i;
+
+	if (!IS_ENABLED(CONFIG_ACPI))
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(sources) && !mac_found; i++) {
+		buffer.length = ACPI_ALLOCATE_BUFFER;
+		buffer.pointer = NULL;
+
+		status = acpi_evaluate_object(NULL, (char *)sources[i].name,
+					      NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		obj = buffer.pointer;
+		if (!obj || obj->type != sources[i].type ||
+		    obj->string.length != sources[i].length)
+			goto free_obj;
+
+		if (strncmp(obj->string.pointer, "_AUXMAC_#", 9) ||
+		    obj->string.pointer[21] != '#')
+			goto free_obj;
+
+		if (hex2bin(buf, obj->string.pointer + 9, ETH_ALEN) ||
+		    !is_valid_ether_addr(buf))
+			goto free_obj;
+
+		ether_addr_copy(mac, buf);
+		mac_found = true;
+free_obj:
+		kfree(obj);
+	}
+
+	return mac_found;
+}
+
 /**
  * igc_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -7279,9 +7333,16 @@ static int igc_probe(struct pci_dev *pdev,
 	}
 
 	if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
-		/* copy the MAC address out of the NVM */
-		if (hw->mac.ops.read_mac_addr(hw))
+		/* Look for a system-provided MAC in the ACPI table before
+		 * falling back to reading the address from the NVM.
+		 */
+		if (ei->is_dock && igc_get_acpi_mac_passthru(hw->mac.addr)) {
+			netdev->addr_assign_type = NET_ADDR_STOLEN;
+			dev_info(&pdev->dev, "Using ACPI pass-thru MAC addr %pM\n",
+				 hw->mac.addr);
+		} else if (hw->mac.ops.read_mac_addr(hw)) {
 			dev_err(&pdev->dev, "NVM Read Error\n");
+		}
 	}
 
 	eth_hw_addr_set(netdev, hw->mac.addr);
-- 
2.43.7

