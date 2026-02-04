Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE888423A78;
	Wed,  4 Feb 2026 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219873; cv=none; b=VdZiP5aVbowSmimb/Etev8YfMA/LGgyGqNLvES1sPDXrJkpbkNLdfp9z95gG8aeGDAuEwBdlpuuTGg98/2BGk3lH211z8PcmswtV95KJFxX8JjqoOXSZNMu03YPzhkNILSB7J3+xYxuQctI+etLuvEO+GMBf61jMQpdH7dfvYLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219873; c=relaxed/simple;
	bh=e/SbG2tv+Vp5aAA6qUNCeSUnTaIUvHurv8Z6KAFxvRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezQrqfAGPFJg8UYj1gH3xx1XM0BhrTKlIguWluJhRgA1U5sQWBgGFSbQmf+sNez1aQkKb5Dhblvt9mLaNPVme0iV6rewJMCgs6uZDNJjQvoywzyT7FLxqpJ20hrC987o4itjEKlv/sR96SRcK2qLyxVPkCSYqwE7hCjWTNeNrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mk7k41lM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mk7k41lM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770219873; x=1801755873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e/SbG2tv+Vp5aAA6qUNCeSUnTaIUvHurv8Z6KAFxvRs=;
  b=mk7k41lMtXL30OhLHUAq3KwkkoZxYYZTomwKDGZerIcg1EsFstx5RVSe
   t177+39i178bkh1iTQh6u70QjV7ifxesNV6n9CP50pkzh+7Bt2HuKlhJA
   ydJRwfA4CYNZ48Au1OsRpaACH9fgd2zvdFQGs69qbs/I7U+0htQYiUlyv
   xv8gFyxyKznzcDrJLTSVkp0Bn6wGjFbhOEKM8ag9xhyt4u7O6TqV5euxU
   XwAyPFcH+WFwNocIS4/FFCjcawLg6+4YGgA+4jekScC5A08JzTQ5GvGK2
   T8wL4Jm6tGRhmIA+3H1L+3qTbLkzzQBN1gc+XaVDl9UN2RweM8h4tKxp3
   w==;
X-CSE-ConnectionGUID: hMjEfbLRTq6NM51ioeWNpQ==
X-CSE-MsgGUID: QDJziTXNSfKfg6ZWMAHeZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88987109"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="88987109"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:44:32 -0800
X-CSE-ConnectionGUID: NQERNJTwRwGdCp99zs+DDQ==
X-CSE-MsgGUID: bt0nrMdZRry52fO+LEIbvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209494131"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa010.jf.intel.com with ESMTP; 04 Feb 2026 07:44:30 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v4 5/7] ice: add functions to query for vsi's pvids
Date: Wed,  4 Feb 2026 16:44:16 +0100
Message-ID: <20260204154418.1285309-6-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204154418.1285309-1-jakub.slepecki@intel.com>
References: <20260204154418.1285309-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

PVID information is set across two structs and several members depending
primarily on DVM support and VSI type.  Add function that guess whether
PVID is set and where and allow to access raw VLAN ID set.  This is
intended to be used later on to decide what MAC{,VLAN} filters to set
for a VSI.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
No changes iv v4.
No changes in v3.
No changes in v2.
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 56 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h |  2 +
 2 files changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 041278caf8e3..ff4763cea2e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -4136,3 +4136,59 @@ void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel)
 		wr32(hw, qrx_context_offset, regval);
 	}
 }
+
+/**
+ * ice_vsi_has_outer_pvid - check if VSI has outer Port VLAN ID assigned
+ * @info: props of VSI in question
+ *
+ * Return: true if VSI has outer PVID, false otherwise.
+ */
+static bool
+ice_vsi_has_outer_pvid(const struct ice_aqc_vsi_props *info)
+{
+	return info->outer_vlan_flags & ICE_AQ_VSI_OUTER_VLAN_PORT_BASED_INSERT;
+}
+
+/**
+ * ice_vsi_has_inner_pvid - check if VSI has inner Port VLAN ID assigned
+ * @info: props of VSI in question
+ *
+ * Return: true if VSI has inner PVID, false otherwise.
+ */
+static bool
+ice_vsi_has_inner_pvid(const struct ice_aqc_vsi_props *info)
+{
+	return info->inner_vlan_flags & ICE_AQ_VSI_INNER_VLAN_INSERT_PVID;
+}
+
+/**
+ * ice_vsi_has_pvid - check if VSI has Port VLAN ID assigned
+ * @vsi: VSI in question
+ *
+ * Return: true if VSI has either outer or inner PVID, false otherwise.
+ */
+bool
+ice_vsi_has_pvid(struct ice_vsi *vsi)
+{
+	return ice_vsi_has_outer_pvid(&vsi->info) ||
+	       ice_vsi_has_inner_pvid(&vsi->info);
+}
+
+/**
+ * ice_vsi_pvid - retrieve VSI's Port VLAN ID
+ * @vsi: VSI in question
+ *
+ * Return: VSI's PVID; it is valid only if ice_vsi_has_pvid is true.
+ */
+u16
+ice_vsi_pvid(struct ice_vsi *vsi)
+{
+	__le16 vlan_info = 0;
+
+	if (ice_vsi_has_outer_pvid(&vsi->info))
+		vlan_info = vsi->info.port_based_outer_vlan;
+	else if (ice_vsi_has_inner_pvid(&vsi->info))
+		vlan_info = vsi->info.port_based_inner_vlan;
+
+	return le16_to_cpu(vlan_info) & VLAN_VID_MASK;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 2d3168458891..46152e26a995 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -134,6 +134,8 @@ void ice_clear_feature_support(struct ice_pf *pf, enum ice_feature f);
 void ice_init_feature_support(struct ice_pf *pf);
 bool ice_vsi_is_rx_queue_active(struct ice_vsi *vsi);
 void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel);
+bool ice_vsi_has_pvid(struct ice_vsi *vsi);
+u16 ice_vsi_pvid(struct ice_vsi *vsi);
 
 extern const struct netdev_queue_mgmt_ops ice_queue_mgmt_ops;
 
-- 
2.43.0

