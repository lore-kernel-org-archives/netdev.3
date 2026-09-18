Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151E5172CB
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738372; cv=none; b=BDStgdvWPzcILBTM5NkictP5mWTjC3fxTehywG75S+LZbZRhgaDD9ZhWI1U7ik1kZ8aq3UDU+XtBZECmwOG92dRry8tNtIh19tXPo4AeUHwdbPhaIuoQyBK02cEVlGHWtVQVOZZSMGkERUtUxw3ghwDEHlu5kCh9yIhbdXHakxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738372; c=relaxed/simple;
	bh=x4NN7MqcCe8oyBka/LerpVZGbLjWhhj/Cd4ZI48E7O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IssQc5mkK30Oi/4npAbmGoY+/XtzjPJtqkZSroG7jgjTI+sYMYpxdA4ssUkmub+tUNHQgXl5HVSU1Hz5E6M9uLupy95O/5WC49woEVNw+WgtKmWI/A+Wm0qSd/laJCq9wuu+GZae9rHbGTnOiNNK7gZsfhbgC3r5MXYRVSVCpfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esxlML+B; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esxlML+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738370; x=1821274370;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x4NN7MqcCe8oyBka/LerpVZGbLjWhhj/Cd4ZI48E7O0=;
  b=esxlML+BTTvaMrTe7MZL6g7H7ZybR5X7YBYCTN1Y7sTv8qQeG87+9Lsv
   mO3E40NerOXbtimM2/TqbbyXN3Lti8yMvnPOj+79MTQTki46y/zl4ZWem
   Rb0euEmPeCMriNBVF3h+DZ1TeIxT0u2WMXkGxruivV+FExIo4eWjgBysm
   heosPWgTpUz4dIjVs0wvVlufDGAHAhOzZ6VmKIFPfv7KQGUjAnETRepBh
   V9TIy2JEmk6s48eW7xl/JWDXKq0Ppmfo9toKptQOurhzDMBYNwVyUhwH7
   c3AstQzS0hN/hlXqwM7bOnQpZS8feLMWTVUP7x7pSoFcDc0VoohuB3cco
   g==;
X-CSE-ConnectionGUID: z0HEePNPTWWIdck+j9dGQw==
X-CSE-MsgGUID: e5+hzbupT/KSUsQDPuzmaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776437"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776437"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:32:50 -0700
X-CSE-ConnectionGUID: Pu9sPPbAQfCkDA012+GsgA==
X-CSE-MsgGUID: BOd6jJeZS7isXwJZFSknJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2835268"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 06:32:48 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3] ice: fix LLDP AQ filter fallback not working on E82x and E830 hardware
Date: Fri, 18 Sep 2026 15:32:43 +0200
Message-ID: <20260918133243.4169311-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
necessary") restructured ice_vsi_cfg_sw_lldp() to first attempt a
generic ethernet Rx filter and, on failure, fall back to the specialized
LLDP filter control AQ command (0x0A0A) via ice_lldp_fltr_add_remove().
This fallback is gated by ice_fw_supports_lldp_fltr_ctrl(), which only
accepted E810, causing two distinct omissions.

E82x (ICE_MAC_GENERIC, e.g. E822/E823) support the same LLDP filter
control AQ command with the same minimum firmware API version as E810
(>= 1.7.1). On E82x systems where the generic ethernet LLDP Rx filter
cannot be added, the AQ fallback silently returns -EOPNOTSUPP and the
port is left with no LLDP Rx filter.

E830 has been supported since kernel 6.9 and implements the same AQ
command but requires a higher minimum API version (>= 1.7.11). Starting
with NVM 1.2 / FW 7.9.1, the generic ethernet LLDP Rx filter path is
blocked on E830, making the AQ fallback the only viable option. With
ice_fw_supports_lldp_fltr_ctrl() returning false for E830, no LLDP Rx
filter is installed after a firmware-update-triggered reset (e.g. NVM
1.1->1.2 on an E830-CC in HPE DL380 Gen11), and the interface stays
link-down with complete loss of network connectivity.

Replace the single-type if-chain with a switch on hw->mac_type so each
family's version requirement is explicit. E810 and E82x share the 1.7.1
constants; E830 gets its own 1.7.11 constants. The default branch returns
false, covering any future MAC type that does not implement the command.

Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2: rewrite as a single combined patch using a switch on
hw->mac_type, instead of two separate patches (E82x fix, then a
follow-up E830 fix layered on top).
v2 -> v3: no code changes, resending to pick up Reviewed-by.
---
 drivers/net/ethernet/intel/ice/ice_common.c | 23 ++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_type.h   |  7 ++++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 0463310..b31be52 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6375,15 +6375,28 @@ ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
 /**
  * ice_fw_supports_lldp_fltr_ctrl - check NVM version supports lldp_fltr_ctrl
  * @hw: pointer to HW struct
+ *
+ * Check if firmware supports the LLDP filter control feature (AQ command
+ * 0x0A0A). Different hardware families require different minimum firmware
+ * API versions:
+ * - E810 and E82x: API version >= 1.7.1
+ * - E830: API version >= 1.7.11
  */
 bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw)
 {
-	if (hw->mac_type != ICE_MAC_E810)
+	switch (hw->mac_type) {
+	case ICE_MAC_E830:
+		return ice_is_fw_api_min_ver(hw, ICE_FW_API_LLDP_FLTR_MAJ_E830,
+					     ICE_FW_API_LLDP_FLTR_MIN_E830,
+					     ICE_FW_API_LLDP_FLTR_PATCH_E830);
+	case ICE_MAC_E810:
+	case ICE_MAC_GENERIC:
+		return ice_is_fw_api_min_ver(hw, ICE_FW_API_LLDP_FLTR_MAJ,
+					     ICE_FW_API_LLDP_FLTR_MIN,
+					     ICE_FW_API_LLDP_FLTR_PATCH);
+	default:
 		return false;
-
-	return ice_is_fw_api_min_ver(hw, ICE_FW_API_LLDP_FLTR_MAJ,
-				     ICE_FW_API_LLDP_FLTR_MIN,
-				     ICE_FW_API_LLDP_FLTR_PATCH);
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index cf147a2..710c519 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1217,11 +1217,16 @@ struct ice_aq_get_set_rss_lut_params {
 
 #define ICE_SR_WORDS_IN_1KB		512
 
-/* AQ API version for LLDP_FILTER_CONTROL */
+/* AQ API version for LLDP_FILTER_CONTROL - E810 and E82x */
 #define ICE_FW_API_LLDP_FLTR_MAJ	1
 #define ICE_FW_API_LLDP_FLTR_MIN	7
 #define ICE_FW_API_LLDP_FLTR_PATCH	1
 
+/* AQ API version for LLDP_FILTER_CONTROL - E830 */
+#define ICE_FW_API_LLDP_FLTR_MAJ_E830		1
+#define ICE_FW_API_LLDP_FLTR_MIN_E830		7
+#define ICE_FW_API_LLDP_FLTR_PATCH_E830	11
+
 /* AQ API version for report default configuration */
 #define ICE_FW_API_REPORT_DFLT_CFG_MAJ		1
 #define ICE_FW_API_REPORT_DFLT_CFG_MIN		7
-- 
2.52.0

