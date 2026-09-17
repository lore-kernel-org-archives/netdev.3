Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54183498920
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638216; cv=none; b=m5b02bQohDCJzZlh0N61oJ8ALC2/tbDg+KPgQJMrzMnLmfdAR8qrR8BiYWC/p3KYAQm3nl2PZyRFzH5rsLBLnsF//zX6CDTL3ObpQ5nPO6OzxgzaEC5uevZXmH/q0o9t8nWjj8rqDqz32syHiHvnPYG5TM0bjAC2NV4arpZc/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638216; c=relaxed/simple;
	bh=5PiRaKoQmAY7dp5ExsOS/8a+QnYZ6ge28TIZ18TnBgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbAxgYwrbrFhyMi9vxsjZFgdz4yjprnK8F+iX80uZ/WrAPwa7cM26BVsCjwl3BwkQapX5V4dV0jJhJalAliRqz5Vusc/BZX/ZlwVBQ4rDzUR2rXoC+AIx2tQa4weC3punWtwKRT7cxaDBZ9w82hiIPCzfjXMmSyuoEpgLHPHglw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksvYNQVU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksvYNQVU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789638201; x=1821174201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5PiRaKoQmAY7dp5ExsOS/8a+QnYZ6ge28TIZ18TnBgs=;
  b=ksvYNQVUXTeCwi0B5XUHxkwK5APg+4uo/eRfd5RhEzRcP9EHyQ8bg1Au
   6s+msG25X8vVLkJ3/3tMb2O6Cbj60g12CRptTzhTd/mpTI4qOx2cFi5x8
   Zfmc9QBItczjhjV9EZ1TRnlS07mQ4S1ETQYq//uU0Q4584Yoorw3zd4/G
   GdjuO1UhDrVnlW5V/qNz38KuLoQtZfRY5H+fE40gd2zWsuBHSeXxdnCfR
   NLUqoYxvDdEOT68ArK0KzjHtNMw4vtSI6l77Griis6w9vvwlIbUv09Jou
   H7mHDuHXPxaJ6LrZYUMzcBVDDB1l+KT9Hubt7iJS7ZGzxsV+WDDV5S5pv
   Q==;
X-CSE-ConnectionGUID: WByW0chRRgicATdVbdT/dQ==
X-CSE-MsgGUID: NugiHDq4Qcyj1LoFUjRLWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100706503"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100706503"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:43:18 -0700
X-CSE-ConnectionGUID: beFfsIBbQVWSTeHv7MbuUw==
X-CSE-MsgGUID: periOg7ZRxmooXQS1xOZgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269400577"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2026 02:43:15 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	6b0e0deb9a688f5d6289c31b0eba49801deb832e,
	Mon,
	Sep,
	17,
	00:00:00,
	2001,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Thu, 17 Sep 2026 11:43:11 +0200
Message-ID: <20260917094312.1567881-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917094312.1567881-1-aleksandr.loktionov@intel.com>
References: <20260917094312.1567881-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CNSA 2.0 PQC adapters carry an external Root of Trust (eRoT) controller
that enforces full-image authentication during NVM updates.  Detect its
presence at init time so later patches can gate firmware update flows.

Primary detection uses the LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT device
capability (0x004E) reported by firmware.  When running on older firmware
that does not advertise the capability at all, fall back to reading the
eRoT presence fuse (SR 0x1016 bits[1:0]).

The capability ID is reserved in the shared libie adminq.h rather than
defined locally in ice, alongside the other LIBIE_AQC_CAPS_* values that
ice_parse_common_caps() already switches on.  AQ capability IDs are a
single firmware-defined numbering space; reserving 0x004E centrally
prevents libie from later assigning it to an unrelated capability out
from under ice.

The result is stored in hw->erot_present and exposed through the
ICE_F_EROT feature bit.  ice_parse_erot_presence() is called from
ice_init_hw() after ice_get_caps() so the device capability field is
already populated at detection time.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h        |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c |  7 ++++
 drivers/net/ethernet/intel/ice/ice_lib.c    |  3 ++
 drivers/net/ethernet/intel/ice/ice_nvm.c    | 39 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_nvm.h    |  5 +++
 drivers/net/ethernet/intel/ice/ice_type.h   |  5 +++
 include/linux/net/intel/libie/adminq.h      |  1 +
 7 files changed, 61 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c701..a78fa17 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -210,6 +210,7 @@ enum ice_feature {
 	ICE_F_SRIOV_LAG,
 	ICE_F_SRIOV_AA_LAG,
 	ICE_F_MBX_LIMIT,
+	ICE_F_EROT,
 	ICE_F_MAX
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ef1ce10..1e0936d 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1031,6 +1031,7 @@ int ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_cqinit;
 
+	ice_parse_erot_presence(hw);
 	if (!hw->port_info)
 		hw->port_info = devm_kzalloc(ice_hw_to_dev(hw),
 					     sizeof(*hw->port_info),
@@ -2479,6 +2480,12 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
 	case LIBIE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE:
 		caps->tx_sched_topo_comp_mode_en = (number == 1);
 		break;
+	case LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT:
+		caps->external_pqc_rot_present = (number == 1);
+		caps->external_pqc_rot_present_cap_advertised = true;
+		ice_debug(hw, ICE_DBG_INIT, "%s: external_pqc_rot_present = %d\n",
+			  prefix, caps->external_pqc_rot_present);
+		break;
 	default:
 		/* Not one of the recognized common capabilities */
 		found = false;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9e08db3..ad2b6fb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -4003,6 +4003,9 @@ void ice_init_feature_support(struct ice_pf *pf)
 		ice_set_feature_support(pf, ICE_F_GCS);
 		ice_set_feature_support(pf, ICE_F_TXTIME);
 	}
+
+	if (pf->hw.erot_present)
+		ice_set_feature_support(pf, ICE_F_EROT);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 21f3b61..9ae7de2 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -1105,6 +1105,45 @@ static int ice_determine_css_hdr_len(struct ice_hw *hw)
 	return 0;
 }
 
+/**
+ * ice_parse_erot_presence - detect eRoT and populate hw->erot_present
+ * @hw: pointer to the HW struct
+ *
+ * Uses the device capability LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT when
+ * advertised by firmware, falling back to the eRoT Presence fuse only when
+ * the capability is not advertised at all (older firmware).
+ *
+ * Priority:
+ *  1. Device capability external_pqc_rot_present (advertised && == 1)
+ *     => eRoT present
+ *  2. Fuse BIT(0) set (only when capability not advertised)
+ *     => eRoT present
+ *  3. Otherwise => eRoT not present
+ */
+void ice_parse_erot_presence(struct ice_hw *hw)
+{
+	u16 fuse = 0;
+	int err;
+
+	hw->erot_present = false;
+
+	if (hw->dev_caps.common_cap.external_pqc_rot_present) {
+		hw->erot_present = true;
+	} else if (!hw->dev_caps.common_cap.external_pqc_rot_present_cap_advertised) {
+		err = ice_read_sr_word(hw, ICE_SR_EROT_PRESENCE_FUSE, &fuse);
+		if (err)
+			dev_warn(ice_hw_to_dev(hw),
+				 "Unable to read eRoT presence fuse (SR 0x%04x), err %d; assuming eRoT not present\n",
+				 ICE_SR_EROT_PRESENCE_FUSE, err);
+		else if (fuse & ICE_EROT_PRESENCE_FUSE_PRESENT)
+			hw->erot_present = true;
+	}
+
+	if (hw->erot_present)
+		dev_info(ice_hw_to_dev(hw),
+			 "eRoT (external Root of Trust) present\n");
+}
+
 /**
  * ice_init_nvm - initializes NVM setting
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
index e1d1a11..4b31dfc 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.h
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
@@ -28,7 +28,12 @@ int ice_get_inactive_nvm_ver(struct ice_hw *hw, struct ice_nvm_info *nvm);
 int
 ice_get_inactive_netlist_ver(struct ice_hw *hw, struct ice_netlist_info *netlist);
 int ice_read_pba_string(struct ice_hw *hw, u8 *pba_num, u32 pba_num_size);
+/* eRoT Presence fuse SR offset; BIT(0) set means eRoT present */
+#define ICE_SR_EROT_PRESENCE_FUSE	0x1016
+#define ICE_EROT_PRESENCE_FUSE_PRESENT	BIT(0)
+
 int ice_init_nvm(struct ice_hw *hw);
+void ice_parse_erot_presence(struct ice_hw *hw);
 int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data);
 int
 ice_aq_update_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index d9a5c1a..1375106 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -311,6 +311,9 @@ struct ice_hw_common_caps {
 	/* Post update reset restriction */
 	bool reset_restrict_support;
 	bool tx_sched_topo_comp_mode_en;
+	/* eRoT (external Root of Trust) controller present */
+	bool external_pqc_rot_present;
+	bool external_pqc_rot_present_cap_advertised;
 };
 
 /* IEEE 1588 TIME_SYNC specific info */
@@ -1040,6 +1043,8 @@ struct ice_hw {
 	u8 dvm_ena;
 	u16 io_expander_handle;
 	u8 cgu_part_number;
+	/* true when eRoT (external Root of Trust) controller is present */
+	bool erot_present;
 };
 
 /* Statistics collected by each port, VSI, VEB, and S-channel */
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index 839114d..df42f5b 100644
--- a/include/linux/net/intel/libie/adminq.h
+++ b/include/linux/net/intel/libie/adminq.h
@@ -175,6 +175,7 @@ LIBIE_CHECK_STRUCT_LEN(16, libie_aqc_list_caps);
 #define LIBIE_AQC_CAPS_PENDING_OROM_VER			0x004B
 #define LIBIE_AQC_CAPS_NET_VER				0x004C
 #define LIBIE_AQC_CAPS_PENDING_NET_VER			0x004D
+#define LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT		0x004E
 #define LIBIE_AQC_CAPS_RDMA				0x0051
 #define LIBIE_AQC_CAPS_LED				0x0061
 #define LIBIE_AQC_CAPS_SDP				0x0062
-- 
2.52.0


