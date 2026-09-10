Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD30598BE3
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069114; cv=none; b=nxpklxW39f/Bw69H86rNfCPDSvsYnviwn6gWaRGfGPLrVmZXZNFvj8TYdx65ZqWXdWbdcQ4KtCQErp/BN/iVPRQvjGxIc0Ma6ULUiQtKWhx9yDPUS70zAEYsIWzrjTdwBZYxfYX+4rhEnJgkR7+89DVHuZyt6kVQh1YLRyRQvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069114; c=relaxed/simple;
	bh=URzbeGQg/NoPkNl6O/IEsc/Hyptre/noxPW2YTadU3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rwHp/Z/hl8SlrntTTrYwVf+tPig9XKnFVJdEoqZkcW1xU7NJdZG/drQ6VclGIs0a8yK+mA3mFlbxBGWHBhUIcOkw6yTGEvLNq5BMJbE6EvleHyAFHXiMIoevAAQQGljEHFQGaTO8MsbMHFhtBZMaEjDruwDSPh5JaRqWAcgkCNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSF6feBA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSF6feBA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789069111; x=1820605111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=URzbeGQg/NoPkNl6O/IEsc/Hyptre/noxPW2YTadU3Y=;
  b=dSF6feBACcD+MOD04T1mnvb8pLk8mJjsGWs+CicqjG1gvWotfb2hi5T1
   X6DLI412eFsNAggafqjLWvL7mr+lJamvJ2S4V3uGJnBiVn7eFZ/PfQQTD
   Rkmf/LWhIuPkNI1le0YpMdQddBQeL7+NST74oytWHmsUy2egmuUoAects
   29Vj/VWL4H5Tq6mGRuU4oNC9w9YYw5NjGaBn+cJErYYfcHOWxFXuyRunH
   veNJmn5Mgks3VDuLGUlOFrrfjzHVnJax+vzAhx3c05QW0WXHQbxE4r2bu
   eBin1fgxUUHnvLoj54BI+FaUk5oT1iFyTqunWWbWt1XS8S5yeDXKBa9lH
   A==;
X-CSE-ConnectionGUID: Vy/2ttZxRSibQiP+8kiyPg==
X-CSE-MsgGUID: Ey4jC5LCR+OVElKrdwTQxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="93356308"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="93356308"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 12:38:30 -0700
X-CSE-ConnectionGUID: BwsTX6s9S/SbdZX7N3vWYQ==
X-CSE-MsgGUID: 6f6qYrRdRHyD8tTPUNsnhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="271703423"
Received: from ccdlinuxdev11.iil.intel.com ([143.185.162.70])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 12:38:27 -0700
From: Dima Ruinskiy <dima.ruinskiy@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	dima.ruinskiy@intel.com,
	anthony.l.nguyen@intel.com,
	allen.lan@intel.com,
	acelan.kao@canonical.com,
	kuba@kernel.org
Subject: [PATCH iwl-next v4] igc: Support ACPI-based MAC passthrough
Date: Thu, 10 Sep 2026 22:38:24 +0300
Message-Id: <20260910193824.3257378-1-dima.ruinskiy@intel.com>
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
when enabled, is intended to override the permanent MAC address of the
any network controller attached via a docking station. The purpose is to
allow the host PC retain its network identity in a corporate environment,
regardless of the specific docking station it is connected to. The
expectation is that only one docking station is attached at a time, or
that only a single network controller is plugged in at a time.

Implement seamless passthrough of the system MAC address to the
I225/I226 network controller, by looking up the relevant ACPI object names
and using them to initialize the MAC address. Limit the lookup only to
controllers that are Thunderbolt-attached, as these are the only docking
stations that can pass through an I225/I226 controller to the host.

On systems where the feature is disabled or unsupported, the ACPI objects
do not exist or do not contain a valid Ethernet MAC, the default MAC
address of the device is used.

Assisted-by: GitHub-Copilot:claude-opus-4.7
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
---
Change log
v3->v4:
	use pci_is_thunderbolt_attached instead of device id check
	explicitly save permanent address when using passthrough mac
v2->v3:
	fix typo that introduced check reversal
v1->v2:
	limit scope to dock device ids
---
 drivers/net/ethernet/intel/igc/igc_main.c | 70 +++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index f6d1ee75627d..d51e9bcdfc3e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c)  2018 Intel Corporation */
 
+#include <linux/acpi.h>
+#include <linux/hex.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/if_vlan.h>
@@ -7134,6 +7136,58 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
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
+		    obj->string.length != sources[i].length ||
+		    !obj->string.pointer)
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
+		ACPI_FREE(obj);
+	}
+
+	return mac_found;
+}
+
 /**
  * igc_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -7300,6 +7354,22 @@ static int igc_probe(struct pci_dev *pdev,
 		/* copy the MAC address out of the NVM */
 		if (hw->mac.ops.read_mac_addr(hw))
 			dev_err(&pdev->dev, "NVM Read Error\n");
+
+		/* For devices behind a Thunderbolt/USB4 dock, look for a
+		 * system-provided MAC in the ACPI table
+		 */
+		if (pci_is_thunderbolt_attached(pdev) &&
+		    igc_get_acpi_mac_passthru(hw->mac.addr)) {
+			/* Set the permanent MAC address. Leave blank if invalid to
+			 * reflect there is something wrong with the NVM MAC.
+			 */
+			if (is_valid_ether_addr(hw->mac.perm_addr))
+				ether_addr_copy(netdev->perm_addr, hw->mac.perm_addr);
+			netdev->addr_assign_type = NET_ADDR_STOLEN;
+			dev_info(&pdev->dev,
+				 "Using ACPI pass-thru MAC addr %pM\n",
+				 hw->mac.addr);
+		}
 	}
 
 	eth_hw_addr_set(netdev, hw->mac.addr);
-- 
2.55.0

