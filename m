Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED954D487C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670393; cv=none; b=A6+BnSYgY5zZ6I2sooGJwim12Qd0QNpiJXYoXcuPIU+mQqcB6NY2Tt2D0pG92kZR4criV5usZkD8YNHWLHR2Tbec0iURTUMlTQhGW0G/1n3RNr4ReSMTqGLaTTaaoTILb8gQgkf8CWPDAeDPuTwIedv2sMDpLJOa66ze1AbEnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670393; c=relaxed/simple;
	bh=7RVplSQjawVM9VOWuoJGni1lEB/PnBuc+YTn/GU6LIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZ7loxnDptWE01ji21FiO9WSMRCKpOeT3R7qrjSvD54qBBLeT06t+GpH13Dyt1witpmYHHkUf9metb2ZlBLwpOU8juqI9GoPx/SU/VG2NaTsve56x7ROqbNJH48H5JqpSXUtbvuTFtqWLFVYTYKhES37NWKF0OroBpI3HIfjMS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vfo3iayF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vfo3iayF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789670391; x=1821206391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7RVplSQjawVM9VOWuoJGni1lEB/PnBuc+YTn/GU6LIc=;
  b=Vfo3iayFF57HhVOrC+i1nIsphW/Qmk4/g7deMK4eGO+Y2nMt0rs4OHy+
   F+nElmxyRwxcjCbRbKssZ0qrJUDCfQW+NdKd6F3muRwyqeFMiaO6c4QDA
   9vIhxutsX3RuXEVF3lq1wNnA0+BKFZPmswONmKlKuUHqukkhVLjUCLjst
   CsO0PmaAANyX6T19oG/0Y5AcOl1c4s/PUW9dmRURn4WqB8kTDZmsQf0HV
   THybKlT75N4Kx+eZ8I40k1RSHlP/K7OqsHTet84kQ2XUp7E7uDnTUoAch
   1slZjg3dYJiwDzubs1kBjlj+UiTYq+FrXe2oDELpC8CWewYXr7FPFAvUN
   w==;
X-CSE-ConnectionGUID: U63zbZOfQ6CMbPdt8Xziuw==
X-CSE-MsgGUID: ALMc4eWtRb+pB6BZqhfBAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100722138"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100722138"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:39:40 -0700
X-CSE-ConnectionGUID: WYt1tyTbQIectMfL5BPeBA==
X-CSE-MsgGUID: cLs1s7a+S7urCTxn5Sj6fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267728781"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 17 Sep 2026 11:39:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	anthony.l.nguyen@intel.com,
	marcin.szycik@linux.intel.com,
	aleksandr.loktionov@intel.com,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next v2 12/12] ice: use ACL for ntuple rules that conflict with FDir
Date: Thu, 17 Sep 2026 11:39:24 -0700
Message-ID: <20260917183927.2692068-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Flow Director can keep only one input set per flow type. After ACL support
was added for ethtool ntuple rules, the driver still only selected ACL for
rules with partial masks.

That leaves a gap for rules with full masks that still require a different
input set than the one already programmed for Flow Director. Such rules go
through the FDir path, build a different extraction sequence and then fail
because the existing FDir profile cannot be reused.

Detect this case before programming the rule. Build the candidate IP flow
segment, compare it with the active non-tunneled FDir profile and, when the
input sets differ, offload the rule through ACL if ACL is available.

Refactor the IP flow segment setup into a helper so the same logic can be
used both by the extraction-sequence configuration path and by the conflict
check.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 189 +++++++++++++-----
 1 file changed, 140 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index fef8640d23fb..691b4500e6be 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -1484,6 +1484,120 @@ ice_set_fdir_vlan_seg(struct ice_flow_seg_info *seg,
 	return 0;
 }
 
+/**
+ * ice_set_fdir_ip_flow_seg - set IP flow segment based on ethtool flow type
+ * @fsp: pointer to ethtool Rx flow specification
+ * @seg: flow segment for programming
+ * @perfect_fltr: valid on success; returns true if perfect fltr, false if not
+ *
+ * Return: 0 on success and errno in case of error.
+ */
+static int ice_set_fdir_ip_flow_seg(struct ethtool_rx_flow_spec *fsp,
+				    struct ice_flow_seg_info *seg,
+				    bool *perfect_fltr)
+{
+	switch (fsp->flow_type & ~FLOW_EXT) {
+	case TCP_V4_FLOW:
+		return ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
+					    ICE_FLOW_SEG_HDR_TCP, perfect_fltr);
+	case UDP_V4_FLOW:
+		return ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
+					    ICE_FLOW_SEG_HDR_UDP, perfect_fltr);
+	case SCTP_V4_FLOW:
+		return ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
+					    ICE_FLOW_SEG_HDR_SCTP,
+					    perfect_fltr);
+	case IPV4_USER_FLOW:
+		return ice_set_fdir_ip4_usr_seg(seg, &fsp->m_u.usr_ip4_spec,
+						perfect_fltr);
+	case TCP_V6_FLOW:
+		return ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
+					    ICE_FLOW_SEG_HDR_TCP, perfect_fltr);
+	case UDP_V6_FLOW:
+		return ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
+					    ICE_FLOW_SEG_HDR_UDP, perfect_fltr);
+	case SCTP_V6_FLOW:
+		return ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
+					    ICE_FLOW_SEG_HDR_SCTP,
+					    perfect_fltr);
+	case IPV6_USER_FLOW:
+		return ice_set_fdir_ip6_usr_seg(seg, &fsp->m_u.usr_ip6_spec,
+						perfect_fltr);
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * ice_fdir_has_input_set_conflict - Check conflict with existing FD filters
+ * @pf: PF structure
+ * @fsp: pointer to ethtool Rx flow specification
+ * @user: user-defined data parsed from flow specification
+ *
+ * Checks if adding this filter to Flow Director would cause an input set
+ * mismatch with existing filters for the same flow type by building
+ * the segment and comparing with existing profiles.
+ *
+ * Return: true if there's a conflict (use ACL), false otherwise (can use FD)
+ */
+static bool
+ice_fdir_has_input_set_conflict(struct ice_pf *pf,
+				struct ethtool_rx_flow_spec *fsp,
+				const struct ice_rx_flow_userdef *user)
+{
+	struct ice_flow_seg_info *test_seg, *old_seg;
+	bool perfect_fltr = false, conflict = false;
+	struct ice_fd_hw_prof *hw_prof;
+	struct ice_hw *hw = &pf->hw;
+	enum ice_fltr_ptype flow;
+	int err;
+
+	if ((fsp->flow_type & ~FLOW_EXT) == ETHER_FLOW)
+		return false;
+
+	flow = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
+	if (flow >= ICE_FLTR_PTYPE_MAX || !hw->fdir_prof ||
+	    !hw->fdir_prof[flow]) {
+		return false;
+	}
+
+	hw_prof = hw->fdir_prof[flow];
+	old_seg = hw_prof->fdir_seg[ICE_FD_HW_SEG_NON_TUN];
+
+	/* A profile with no ethtool FDir filters (fdir_fltr_cnt == 0) may
+	 * still be locked by aRFS perfect (4-tuple) filters, which keep their
+	 * own active counters separate from fdir_fltr_cnt.
+	 */
+	if (!old_seg || (hw->fdir_fltr_cnt[flow] == 0 &&
+			 !ice_is_arfs_using_perfect_flow(hw, flow)))
+		return false;
+
+	test_seg = kzalloc_obj(*test_seg);
+	if (!test_seg)
+		return false;
+
+	err = ice_set_fdir_ip_flow_seg(fsp, test_seg, &perfect_fltr);
+
+	if (err) {
+		kfree(test_seg);
+		return false;
+	}
+
+	if (user && user->flex_fltr)
+		ice_flow_add_fld_raw(test_seg, user->flex_offset,
+				     ICE_FLTR_PRGM_FLEX_WORD_SIZE,
+				     ICE_FLOW_FLD_OFF_INVAL,
+				     ICE_FLOW_FLD_OFF_INVAL);
+
+	/* Compare the test segment with the existing segment */
+	if (memcmp(old_seg, test_seg, sizeof(*test_seg)) != 0)
+		conflict = true;
+
+	kfree(test_seg);
+
+	return conflict;
+}
+
 /**
  * ice_cfg_fdir_xtrct_seq - Configure extraction sequence for the given filter
  * @pf: PF structure
@@ -1514,57 +1628,16 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 		return -ENOMEM;
 	}
 
-	switch (fsp->flow_type & ~FLOW_EXT) {
-	case TCP_V4_FLOW:
-		ret = ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
-					   ICE_FLOW_SEG_HDR_TCP,
-					   &perfect_filter);
-		break;
-	case UDP_V4_FLOW:
-		ret = ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
-					   ICE_FLOW_SEG_HDR_UDP,
-					   &perfect_filter);
-		break;
-	case SCTP_V4_FLOW:
-		ret = ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
-					   ICE_FLOW_SEG_HDR_SCTP,
-					   &perfect_filter);
-		break;
-	case IPV4_USER_FLOW:
-		ret = ice_set_fdir_ip4_usr_seg(seg, &fsp->m_u.usr_ip4_spec,
-					       &perfect_filter);
-		break;
-	case TCP_V6_FLOW:
-		ret = ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
-					   ICE_FLOW_SEG_HDR_TCP,
-					   &perfect_filter);
-		break;
-	case UDP_V6_FLOW:
-		ret = ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
-					   ICE_FLOW_SEG_HDR_UDP,
-					   &perfect_filter);
-		break;
-	case SCTP_V6_FLOW:
-		ret = ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
-					   ICE_FLOW_SEG_HDR_SCTP,
-					   &perfect_filter);
-		break;
-	case IPV6_USER_FLOW:
-		ret = ice_set_fdir_ip6_usr_seg(seg, &fsp->m_u.usr_ip6_spec,
-					       &perfect_filter);
-		break;
-	case ETHER_FLOW:
+	if ((fsp->flow_type & ~FLOW_EXT) == ETHER_FLOW) {
 		ret = ice_set_ether_flow_seg(dev, seg, &fsp->m_u.ether_spec);
 		if (!ret && (fsp->m_ext.vlan_etype || fsp->m_ext.vlan_tci)) {
-			if (!ice_fdir_vlan_valid(dev, fsp)) {
+			if (!ice_fdir_vlan_valid(dev, fsp))
 				ret = -EINVAL;
-				break;
-			}
-			ret = ice_set_fdir_vlan_seg(seg, &fsp->m_ext);
+			else
+				ret = ice_set_fdir_vlan_seg(seg, &fsp->m_ext);
 		}
-		break;
-	default:
-		ret = -EINVAL;
+	} else {
+		ret = ice_set_fdir_ip_flow_seg(fsp, seg, &perfect_filter);
 	}
 	if (ret)
 		goto err_exit;
@@ -2368,9 +2441,27 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -ENOSPC;
 	}
 
-	/* ACL filter */
-	if (pf->hw.acl_tbl && ice_is_acl_filter(fsp))
+	/* ACL filter, or this filter would cause an input set conflict with
+	 * existing FD filters
+	 */
+	if (pf->hw.acl_tbl &&
+	    (ice_is_acl_filter(fsp) ||
+	     ice_fdir_has_input_set_conflict(pf, fsp, &userdata))) {
+		/* The ACL programming path does not honor flex byte
+		 * (user-def) constraints. Routing a flex filter to ACL would
+		 * silently drop the flex match and offload a much broader
+		 * rule than requested, so reject it explicitly instead.
+		 */
+		if (userdata.flex_fltr) {
+			dev_info(dev, "Failed to add filter. Flex byte (user-def) filters cannot be offloaded to ACL.\n");
+			return -EOPNOTSUPP;
+		}
+
+		dev_dbg(dev, "ntuple filter at location %d offloaded to ACL instead of Flow Director\n",
+			fsp->location);
+
 		return ice_acl_add_rule_ethtool(vsi, cmd);
+	}
 
 	/* Only fdir filters below */
 	if (!test_bit(ICE_FLAG_FD_ENA, pf->flags))
-- 
2.47.1

