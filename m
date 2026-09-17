Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747E4E0B93
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670390; cv=none; b=LP6f4Ba42kBGMgPuenxzfvhvJOrNpkYNE0NR4EbXRrb/J/7WA71JlC3VJ3/Z1T9pp0OXoc3JNqeNDTp5l7XuIMtPBzRLVtnvdFWEhLbiMUUl91nxXTVLp9WiBMzh4Qzu18gOnmnUqj6m2i721EeRaaMejxObp2nIpRc9mxB0c/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670390; c=relaxed/simple;
	bh=bYw7mhJ7Mce5gH1HLEZzQa+SC5/s3yBwzV9wFqTxuXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dW77t/k6SQ9kq4DVCeP9JPsXGtkvIeJoqqpov+TcFPYd96hYKsRThzS12CL7TMvHA6rsvu2KK7VZzLCJQji6i4wMoYLdpKOd1bYrUrfpQKXDdSguDlv0miwi6ezXrgrblHjt/aE6N6SO+Pnv0GGezFkC858ZyHz1IAVUzxBUECM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGT1xwM3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGT1xwM3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789670387; x=1821206387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYw7mhJ7Mce5gH1HLEZzQa+SC5/s3yBwzV9wFqTxuXw=;
  b=jGT1xwM3/LCvHasXffRl7wONRU/0pqHXvdTFk3GsWQA3ctYejzz/ZcvI
   srrwlB1PmQ1reHSuqnNK5zNKJlTh89a2cCvbROLywakt2x2Qae7Hp4AF1
   U04s8yWp6Y9ArMPI92Xp632DkNyv5/cdx70qdS9jI/B0XDIqg0EPczinq
   uUq4vfFSS6c6oxwMg7Z+RTQknQkSsAX+SfcX8HyPpzDwo39G/VODizRxz
   9Su7QTgnRmFJh1TSmlL6lB/4DiDWv3AURINiIikOPjS1i9SRKc3XwMdbS
   KdJuBIzBXvea2ATkRhFaLPMDlntdaNMfI3v2Rv0sydNEVWJxqKT0f0Hla
   g==;
X-CSE-ConnectionGUID: BYXUvgGuS/KT19ztrZka1Q==
X-CSE-MsgGUID: ru9uy6e1SMqZsOa90e7YXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100722123"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100722123"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:39:39 -0700
X-CSE-ConnectionGUID: uUpXE2y6R4ii9EejcX0FTQ==
X-CSE-MsgGUID: hqFNF8GZTvq8R13iIockQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267728773"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 17 Sep 2026 11:39:39 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next v2 10/12] ice: add ACL reset recovery and NTUPLE feature toggle
Date: Thu, 17 Sep 2026 11:39:22 -0700
Message-ID: <20260917183927.2692068-11-anthony.l.nguyen@intel.com>
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

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Extend ACL support to survive PF resets. Add ice_acl_replay_flows() to
rebuild HW flow profiles from preserved SW state, and
ice_acl_replay_fltrs() to reprogram TCAM entries from the SW filter
list. Wire both into ice_rebuild(). On failure, don't fail reset, rather
delete all ACL filters from the SW list.

Reset per-profile HW extraction sequences and range checkers for all
profiles inside ice_acl_create_hw(). This state is separate from the
TCAM entries and survives a PF reset. Explicitly clearing it ensures
that the old configuration is erased.

Add the ICE_FLAG_ACL_ENA PF flag to track ACL status. ACL is always
available, so set it unconditionally in driver initialization. Use the
new flag to track the NTUPLE ethtool feature flag, alongside Flow
Director, as both blocks are used to implement ethtool NTUPLE filters.
Like with Flow Director, disabling the flag deletes all filters, but
enabling it does not reprogram filters.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  4 +
 drivers/net/ethernet/intel/ice/ice_acl.h      |  5 +-
 drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 43 +++++-----
 drivers/net/ethernet/intel/ice/ice_acl_main.c | 47 +++++++++++
 drivers/net/ethernet/intel/ice/ice_acl_main.h |  1 +
 .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 79 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c     | 47 +++++++++++
 7 files changed, 201 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 61a320eaf3c5..fcf1130f511f 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -503,6 +503,7 @@ enum ice_pf_flags {
 	ICE_FLAG_DCB_CAPABLE,
 	ICE_FLAG_DCB_ENA,
 	ICE_FLAG_FD_ENA,
+	ICE_FLAG_ACL_ENA,
 	ICE_FLAG_PTP_SUPPORTED,		/* PTP is supported by NVM */
 	ICE_FLAG_ADV_FEATURES,
 	ICE_FLAG_TC_MQPRIO,		/* support for Multi queue TC */
@@ -1019,10 +1020,12 @@ int ice_init_rdma(struct ice_pf *pf);
 void ice_deinit_rdma(struct ice_pf *pf);
 bool ice_is_wol_supported(struct ice_hw *hw);
 void ice_fdir_del_all_fltrs(struct ice_vsi *vsi);
+void ice_acl_del_all_fltrs(struct ice_vsi *vsi);
 int
 ice_fdir_write_fltr(struct ice_pf *pf, struct ice_ntuple_fltr *input, bool add,
 		    bool is_tun);
 void ice_vsi_manage_fdir(struct ice_vsi *vsi, bool ena);
+void ice_vsi_manage_acl(struct ice_vsi *vsi, bool ena);
 int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
 int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
 int ice_get_ethtool_fdir_entry(struct ice_hw *hw, struct ethtool_rxnfc *cmd);
@@ -1040,6 +1043,7 @@ ice_get_fdir_fltr_ids(struct ice_hw *hw, struct ethtool_rxnfc *cmd,
 		      u32 *rule_locs);
 void ice_fdir_rem_adq_chnl(struct ice_hw *hw, u16 vsi_idx);
 void ice_acl_rem_flows(struct ice_hw *hw);
+void ice_acl_replay_flows(struct ice_hw *hw);
 void ice_fdir_release_flows(struct ice_hw *hw);
 void ice_fdir_replay_flows(struct ice_hw *hw);
 void ice_fdir_replay_fltrs(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_acl.h b/drivers/net/ethernet/intel/ice/ice_acl.h
index 0c8163e585d9..65e16ad1c783 100644
--- a/drivers/net/ethernet/intel/ice/ice_acl.h
+++ b/drivers/net/ethernet/intel/ice/ice_acl.h
@@ -6,6 +6,9 @@
 
 #include "ice_common.h"
 
+/* Maximum number of ACL HW profiles */
+#define ICE_ACL_MAX_PROF		128
+
 /* Marks a PF scenario slot as unused in the ACL profile extraction table */
 #define ICE_ACL_INVALID_SCEN		0x3f
 
@@ -124,7 +127,7 @@ struct ice_acl_cntrs {
 };
 
 int ice_acl_create_tbl(struct ice_hw *hw, struct ice_acl_tbl_params *params);
-int ice_acl_destroy_tbl(struct ice_hw *hw);
+void ice_acl_destroy_tbl(struct ice_hw *hw);
 int ice_acl_create_scen(struct ice_hw *hw, u16 match_width, u16 num_entries,
 			u16 *scen_id);
 int ice_aq_alloc_acl_tbl(struct ice_hw *hw, struct ice_acl_alloc_tbl *tbl,
diff --git a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
index 0ee86236bc37..4ea08bd9784c 100644
--- a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
+++ b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
@@ -877,9 +877,10 @@ static int ice_acl_destroy_scen(struct ice_hw *hw, u16 scen_id)
  * ice_acl_destroy_tbl - Destroy a previously created LEM table for ACL
  * @hw: pointer to the HW struct
  *
- * Return: 0 on success, negative on error
+ * Continue on AQ errors so SW state is always cleaned up - e.g. after a reset,
+ * where the HW tables might be already gone.
  */
-int ice_acl_destroy_tbl(struct ice_hw *hw)
+void ice_acl_destroy_tbl(struct ice_hw *hw)
 {
 	struct ice_acl_scen *pos_scen, *tmp_scen;
 	struct ice_aqc_acl_generic resp_buf;
@@ -887,7 +888,7 @@ int ice_acl_destroy_tbl(struct ice_hw *hw)
 	int err;
 
 	if (!hw->acl_tbl)
-		return -ENOENT;
+		return;
 
 	/* Mark all the created scenario's TCAM to stop the packet lookup and
 	 * delete them afterward
@@ -898,44 +899,38 @@ int ice_acl_destroy_tbl(struct ice_hw *hw)
 		if (err) {
 			ice_debug(hw, ICE_DBG_ACL, "ice_aq_query_acl_scen() failed. status: %d\n",
 				  err);
-			return err;
-		}
-
-		for (int i = 0; i < ICE_AQC_ACL_SLICES; i++) {
-			buf.tcam_cfg[i].chnk_msk = 0;
-			buf.tcam_cfg[i].start_cmp_set =
-					ICE_AQC_ACL_ALLOC_SCE_START_CMP;
-		}
+		} else {
+			for (int i = 0; i < ICE_AQC_ACL_SLICES; i++) {
+				buf.tcam_cfg[i].chnk_msk = 0;
+				buf.tcam_cfg[i].start_cmp_set =
+						ICE_AQC_ACL_ALLOC_SCE_START_CMP;
+			}
 
-		for (int i = 0; i < ICE_AQC_MAX_ACTION_MEMORIES; i++)
-			buf.act_mem_cfg[i] = 0;
+			for (int i = 0; i < ICE_AQC_MAX_ACTION_MEMORIES; i++)
+				buf.act_mem_cfg[i] = 0;
 
-		err = ice_aq_update_acl_scen(hw, pos_scen->id, &buf, NULL);
-		if (err) {
-			ice_debug(hw, ICE_DBG_ACL, "ice_aq_update_acl_scen() failed. status: %d\n",
-				  err);
-			return err;
+			err = ice_aq_update_acl_scen(hw, pos_scen->id, &buf,
+						     NULL);
+			if (err)
+				ice_debug(hw, ICE_DBG_ACL, "scenario update failed, status: %d\n",
+					  err);
 		}
 
 		err = ice_acl_destroy_scen(hw, pos_scen->id);
 		if (err) {
-			ice_debug(hw, ICE_DBG_ACL, "deletion of scenario failed. status: %d\n",
+			ice_debug(hw, ICE_DBG_ACL, "deletion of scenario failed, status: %d\n",
 				  err);
-			return err;
 		}
 	}
 
 	err = ice_aq_dealloc_acl_tbl(hw, hw->acl_tbl->id, &resp_buf, NULL);
 	if (err) {
-		ice_debug(hw, ICE_DBG_ACL, "AQ de-allocation of ACL failed. status: %d\n",
+		ice_debug(hw, ICE_DBG_ACL, "AQ de-allocation of ACL failed, status: %d\n",
 			  err);
-		return err;
 	}
 
 	kfree(hw->acl_tbl);
 	hw->acl_tbl = NULL;
-
-	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c b/drivers/net/ethernet/intel/ice/ice_acl_main.c
index 171b7bf8519c..d13e8bc1b701 100644
--- a/drivers/net/ethernet/intel/ice/ice_acl_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c
@@ -236,6 +236,53 @@ static void ice_acl_set_act_fwd_queue(struct ice_flow_action *action,
 	action->data.acl_act.value = cpu_to_le16(queue_index);
 }
 
+/*
+ * ice_acl_replay_fltrs - replay ACL filters from the SW filter list
+ * @pf: board private structure
+ *
+ * Reprograms ACL TCAM entries after a reset using data preserved in the
+ * SW filter list. Relies on ice_acl_replay_flows() having been called first
+ * to restore the flow profiles.
+ */
+void ice_acl_replay_fltrs(struct ice_pf *pf)
+{
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	struct ice_hw *hw = &pf->hw;
+	struct ice_ntuple_fltr *f_rule;
+
+	if (!vsi)
+		return;
+
+	list_for_each_entry(f_rule, &hw->fdir_list_head, fltr_node) {
+		struct ice_flow_action acts[ICE_ACL_NUM_ACT];
+		struct ice_acl_hw_prof *hw_prof;
+		u64 entry_h = 0;
+		int err;
+
+		if (!f_rule->acl_fltr)
+			continue;
+
+		if (!hw->acl_prof || !hw->acl_prof[f_rule->flow_type])
+			continue;
+
+		hw_prof = hw->acl_prof[f_rule->flow_type];
+
+		memset(&acts, 0, sizeof(acts));
+		if (f_rule->dest_ctl == ICE_FLTR_PRGM_DESC_DEST_DROP_PKT)
+			ice_acl_set_act_drop(&acts[0]);
+		else
+			ice_acl_set_act_fwd_queue(&acts[0], f_rule->q_index);
+
+		err = ice_flow_add_entry(hw, ICE_BLK_ACL, hw_prof->prof_id,
+					 f_rule->fltr_id, vsi->idx,
+					 ICE_FLOW_PRIO_NORMAL, f_rule, acts,
+					 ICE_ACL_NUM_ACT, &entry_h);
+		if (err)
+			dev_warn(ice_pf_to_dev(pf), "Could not reprogram filter %d, status %d\n",
+				 f_rule->fltr_id, err);
+	}
+}
+
 /**
  * ice_acl_comp_rules - compare two ACL filters
  * @a: first ACL filter
diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.h b/drivers/net/ethernet/intel/ice/ice_acl_main.h
index 6665af2e7053..54053954b244 100644
--- a/drivers/net/ethernet/intel/ice/ice_acl_main.h
+++ b/drivers/net/ethernet/intel/ice/ice_acl_main.h
@@ -6,4 +6,5 @@
 #include "ice.h"
 #include <linux/ethtool.h>
 int ice_acl_add_rule_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
+void ice_acl_replay_fltrs(struct ice_pf *pf);
 #endif /* _ICE_ACL_MAIN_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index 0ac44d38fdbd..fef8640d23fb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -527,6 +527,37 @@ void ice_fdir_replay_flows(struct ice_hw *hw)
 	}
 }
 
+/**
+ * ice_acl_replay_flows - replay HW ACL flow profiles
+ * @hw: pointer to HW instance
+ */
+void ice_acl_replay_flows(struct ice_hw *hw)
+{
+	if (!hw->acl_prof)
+		return;
+
+	for (enum ice_fltr_ptype flow = ICE_FLTR_PTYPE_NONF_NONE;
+	     flow < ICE_FLTR_PTYPE_MAX; flow++) {
+		struct ice_flow_prof *hw_prof;
+		struct ice_acl_hw_prof *prof;
+		int err;
+
+		flow &= ~FLOW_EXT;
+		prof = hw->acl_prof[flow];
+		if (!prof || !prof->seg)
+			continue;
+
+		err = ice_flow_add_prof(hw, ICE_BLK_ACL, ICE_FLOW_RX,
+					prof->seg, 1, false, &hw_prof);
+		if (err) {
+			dev_err(ice_hw_to_dev(hw), "Could not replay ACL, flow type %d\n",
+				flow);
+			continue;
+		}
+		prof->prof_id = hw_prof->id;
+	}
+}
+
 /**
  * ice_parse_rx_flow_user_data - deconstruct user-defined data
  * @fsp: pointer to ethtool Rx flow specification
@@ -1825,6 +1856,28 @@ static int ice_del_acl_ethtool(struct ice_hw *hw, struct ice_ntuple_fltr *fltr)
 	return ice_flow_rem_entry(hw, ICE_BLK_ACL, entry);
 }
 
+/**
+ * ice_acl_del_all_fltrs - Delete all ACL filters from the filter list
+ * @vsi: the VSI being changed
+ *
+ * This function needs to be called while holding hw->fdir_fltr_lock
+ */
+void ice_acl_del_all_fltrs(struct ice_vsi *vsi)
+{
+	struct ice_ntuple_fltr *f_rule, *tmp;
+	struct ice_hw *hw = &vsi->back->hw;
+
+	list_for_each_entry_safe(f_rule, tmp, &hw->fdir_list_head, fltr_node) {
+		if (!f_rule->acl_fltr)
+			continue;
+
+		ice_del_acl_ethtool(hw, f_rule);
+		ice_ntuple_update_cntrs(hw, f_rule, false);
+		list_del(&f_rule->fltr_node);
+		kfree(f_rule);
+	}
+}
+
 /**
  * ice_vsi_manage_fdir - turn on/off flow director
  * @vsi: the VSI being changed
@@ -1858,6 +1911,32 @@ void ice_vsi_manage_fdir(struct ice_vsi *vsi, bool ena)
 	mutex_unlock(&hw->fdir_fltr_lock);
 }
 
+/**
+ * ice_vsi_manage_acl - turn on/off ACL
+ * @vsi: the VSI being changed
+ * @ena: boolean value indicating if this is an enable or disable request
+ */
+void ice_vsi_manage_acl(struct ice_vsi *vsi, bool ena)
+{
+	struct ice_pf *pf = vsi->back;
+	struct ice_hw *hw = &pf->hw;
+
+	if (ena) {
+		set_bit(ICE_FLAG_ACL_ENA, pf->flags);
+		return;
+	}
+
+	mutex_lock(&hw->fdir_fltr_lock);
+	if (!test_and_clear_bit(ICE_FLAG_ACL_ENA, pf->flags))
+		goto release_lock;
+
+	ice_acl_del_all_fltrs(vsi);
+	ice_acl_rem_flows(hw);
+
+release_lock:
+	mutex_unlock(&hw->fdir_fltr_lock);
+}
+
 /**
  * ice_fdir_do_rem_flow - delete flow and possibly add perfect flow
  * @pf: PF structure
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3a10b2c2a44a..8a81d3e475a7 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -18,6 +18,7 @@
 #include "ice_sf_eth.h"
 #include "ice_hwmon.h"
 #include "ice_acl.h"
+#include "ice_acl_main.h"
 /* Including ice_trace.h with CREATE_TRACE_POINTS defined will generate the
  * ice tracepoint functions. This must be done exactly once across the
  * ice driver.
@@ -3947,6 +3948,9 @@ static void ice_set_pf_caps(struct ice_pf *pf)
 				       func_caps->fd_fltr_best_effort);
 	}
 
+	/* ACL is always initially available */
+	set_bit(ICE_FLAG_ACL_ENA, pf->flags);
+
 	clear_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags);
 	if (func_caps->common_cap.ieee_1588)
 		set_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags);
@@ -4369,6 +4373,30 @@ static int ice_acl_create_hw(struct ice_pf *pf)
 	if (err)
 		goto destroy_table;
 
+	/* Reset profile extraction sequences and range checkers for all
+	 * possible HW profile IDs. The TCAM entries are already zeroed by
+	 * ice_acl_init_tbl() inside ice_acl_create_tbl(), but profile
+	 * extraction and range checker state is separate per-profile HW state
+	 * that survives PF reset, therefore must be brought back to default
+	 * state.
+	 */
+	for (u8 prof_id = 0; prof_id < ICE_ACL_MAX_PROF; prof_id++) {
+		struct ice_aqc_acl_prof_generic_frmt xtrct_buf = {};
+		struct ice_aqc_acl_profile_ranges range_buf = {};
+
+		memset(xtrct_buf.pf_scenario_num, ICE_ACL_INVALID_SCEN,
+		       sizeof(xtrct_buf.pf_scenario_num));
+		err = ice_prgm_acl_prof_xtrct(hw, prof_id, &xtrct_buf, NULL);
+		if (err)
+			dev_warn(ice_pf_to_dev(pf), "Failed to reset profile extraction for profile %u\n",
+				 prof_id);
+
+		ice_prog_acl_prof_ranges(hw, prof_id, &range_buf, NULL);
+		if (err)
+			dev_warn(ice_pf_to_dev(pf), "Failed to reset range checkers for profile %u\n",
+				 prof_id);
+	}
+
 	return 0;
 
 destroy_table:
@@ -6614,6 +6642,7 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
 		bool ena = !!(features & NETIF_F_NTUPLE);
 
 		ice_vsi_manage_fdir(vsi, ena);
+		ice_vsi_manage_acl(vsi, ena);
 		ena ? ice_init_arfs(vsi) : ice_clear_arfs(vsi);
 	}
 
@@ -7911,6 +7940,24 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		ice_rebuild_arfs(pf);
 	}
 
+	if (test_bit(ICE_FLAG_ACL_ENA, pf->flags)) {
+		/* Clean up the stale HW table SW state left by the reset,
+		 * recreate the HW table and scenario, then replay flow profiles
+		 * from preserved SW state.
+		 */
+		ice_acl_destroy_tbl(hw);
+		if (!ice_acl_create_hw(pf)) {
+			ice_acl_replay_flows(hw);
+			ice_acl_replay_fltrs(pf);
+		} else {
+			dev_err(dev, "Failed to rebuild ACL\n");
+			mutex_lock(&hw->fdir_fltr_lock);
+			if (vsi)
+				ice_acl_del_all_fltrs(vsi);
+			mutex_unlock(&hw->fdir_fltr_lock);
+		}
+	}
+
 	if (vsi && vsi->netdev)
 		netif_device_attach(vsi->netdev);
 
-- 
2.47.1

