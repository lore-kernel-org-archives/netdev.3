Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D0551C35F
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903916; cv=none; b=Clq+De+8jq0GJHsi2AysW8YNLJ8/hBM6x46gauZZCcetFLdtj3W5j2K/mEZJCLLcgvvOFTFbjA39AkxMt3SFM1+Y4+h+9trW0u8RTcTtwH72yo8rUEWl7xaVGjNh/TVhjAGIQ9AhAm+r0MsVy+WOuzPEKt/IIYTB6odCJ+hJKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903916; c=relaxed/simple;
	bh=aDK19axj1CxE6bZdzpaBR096pcWBCPHXRqVDQ63wpHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nB4adTBep/CUrIzXiJLskOMClF2U8y7odA2QlAbdpFxisPqqKhrb77RPZzOuM/fnUN/JxQXt943mndfJmgc+5YeyKaX7+vYS6EK04r/jvDYjle91sdCsbkcOjuDYTd5d7vZdOQkELkSFh1KGp/nWRhfWDpxvyvyIWpTs04vBerA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GllwdqLq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GllwdqLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788903915; x=1820439915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aDK19axj1CxE6bZdzpaBR096pcWBCPHXRqVDQ63wpHE=;
  b=GllwdqLq9RafzaWouLNcy+QUBtteWtbxAR4atQewiObupyuQeUOKWuxp
   ioUSjnPPPiRUzDryaCKc9HtDLM7zcsSZrBIdthTsr3uWqZ8bJaMauav8w
   ywaYrmtux6Abp4Tj/PXeoZ7jD+N7a0rzYtXFz6SU9XvTwtVFLnHnjzVAd
   DuMJv2agzsA4OmO5tAE1UeXlDDKXQTAv+D+5d1bSwcfSlOqbZ8ChXyLwE
   jllNTdZQYXCEIOJhZBKUQe6wl8CKzGpQE+Nuo/+Ghqe8BSuYjPsQ8MuaW
   pFzT79uLSedWGJww8s1I/MyuhmTnKuBgvgWG3SOZf4GmNpzkg82JSVJy/
   Q==;
X-CSE-ConnectionGUID: B+x620IeTpODxdh2W3Kvzg==
X-CSE-MsgGUID: zwef7MwVSiGvb1VXrUVWig==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106836243"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="106836243"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 14:45:09 -0700
X-CSE-ConnectionGUID: 3TveequHS6CEFl3+Xr2NRQ==
X-CSE-MsgGUID: SueAX08IR+m8+a9YtUQpOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="269782520"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 08 Sep 2026 14:45:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	ae878000@gmail.com,
	mhun512@gmail.com,
	joshua.a.hay@intel.com,
	sridhar.samudrala@intel.com,
	milena.olech@intel.com,
	vadim.fedorenko@linux.dev,
	willemb@google.com,
	przemyslaw.kitszel@intel.com,
	jbrandeb@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 4/5] ice: add missing xa_destroy for sched_node_ids
Date: Tue,  8 Sep 2026 14:44:59 -0700
Message-ID: <20260908214502.528440-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
References: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Commit 16dfa49406bc ("ice: Introduce new parameters in ice_sched_node")
added a sched_node_ids xarray to the port info structure, but never called
xa_destroy on it.

Since xarrays can allocate internal memory, this can result in a memory
leak even if every element in the xarray has been removed.

The xarray is currently embedded in the port_info structure. This appears
to have been done because its use is within functions that take the
port_info as a primary argument.

However, this complicates managing the lifecycle of the field. The
port_info structure is allocated in ice_init_hw() using devm, and it is
not released until the devm cleanup when the driver is unloaded.

The ice_init_hw() function is called in many places, including devlink
reload, and possibly during DDP load after updating the Tx scheduler
layout.

Adding a call of xa_destroy to the ice_deinit_hw() causes Sashiko to raise
multiple concerns due to potential ordering issues and possible ways that
port_info could be a dangling reference.

To handle this, move the sched_node_ids out of port_info and into the hw
structure. All users of the array already have a pointer to hw anyways, and
there is only one sched_node_ids per adapter. While here, remove the overly
verbose comment explaining the nature of the sched_node_ids xarray.

Add the missing xa_destroy to the cleanup path and to ice_deinit_hw(),
ensuring that we properly release the xarray memory.

This was caught by Sashiko during development of unrelated code.

Fixes: 16dfa49406bc ("ice: Introduce new parameters in ice_sched_node")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 9 ++++++---
 drivers/net/ethernet/intel/ice/ice_sched.c  | 4 ++--
 drivers/net/ethernet/intel/ice/ice_type.h   | 2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ef1ce106f81b..04633103e3e6 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1051,14 +1051,13 @@ int ice_init_hw(struct ice_hw *hw)
 
 	hw->evb_veb = true;
 
-	/* init xarray for identifying scheduling nodes uniquely */
-	xa_init_flags(&hw->port_info->sched_node_ids, XA_FLAGS_ALLOC);
+	xa_init_flags(&hw->sched_node_ids, XA_FLAGS_ALLOC);
 
 	/* Query the allocated resources for Tx scheduler */
 	status = ice_sched_query_res_alloc(hw);
 	if (status) {
 		ice_debug(hw, ICE_DBG_SCHED, "Failed to get scheduler allocated resources\n");
-		goto err_unroll_alloc;
+		goto err_unroll_xarray;
 	}
 	ice_sched_get_psm_clk_freq(hw);
 
@@ -1146,6 +1145,8 @@ int ice_init_hw(struct ice_hw *hw)
 	ice_cleanup_fltr_mgmt_struct(hw);
 err_unroll_sched:
 	ice_sched_cleanup_all(hw);
+err_unroll_xarray:
+	xa_destroy(&hw->sched_node_ids);
 err_unroll_alloc:
 	devm_kfree(ice_hw_to_dev(hw), hw->port_info);
 err_unroll_cqinit:
@@ -1186,6 +1187,8 @@ void ice_deinit_hw(struct ice_hw *hw)
 
 	/* Clear VSI contexts if not already cleared */
 	ice_clear_all_vsi_ctx(hw);
+
+	xa_destroy(&hw->sched_node_ids);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index fff0c1afdb41..ffa18d86729a 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -371,7 +371,7 @@ void ice_free_sched_node(struct ice_port_info *pi, struct ice_sched_node *node)
 
 	devm_kfree(ice_hw_to_dev(hw), node->children);
 	kfree(node->name);
-	xa_erase(&pi->sched_node_ids, node->id);
+	xa_erase(&hw->sched_node_ids, node->id);
 	devm_kfree(ice_hw_to_dev(hw), node);
 }
 
@@ -977,7 +977,7 @@ ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 		if (!new_node->name)
 			return -ENOMEM;
 
-		status = xa_alloc(&pi->sched_node_ids, &new_node->id, NULL, XA_LIMIT(0, UINT_MAX),
+		status = xa_alloc(&hw->sched_node_ids, &new_node->id, NULL, XA_LIMIT(0, UINT_MAX),
 				  GFP_KERNEL);
 		if (status) {
 			ice_debug(hw, ICE_DBG_SCHED, "xa_alloc failed for sched node status =%d\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index d9a5c1aae7c2..cf147a212707 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -765,7 +765,6 @@ struct ice_port_info {
 	/* List contain profile ID(s) and other params per layer */
 	struct list_head rl_prof_list[ICE_AQC_TOPO_MAX_LEVEL_NUM];
 	struct ice_qos_cfg qos_cfg;
-	struct xarray sched_node_ids;
 	u8 is_vf:1;
 	u8 is_custom_tx_enabled:1;
 };
@@ -930,6 +929,7 @@ struct ice_hw {
 	u8 sw_entry_point_layer;
 	u16 max_children[ICE_AQC_TOPO_MAX_LEVEL_NUM];
 	struct list_head agg_list;	/* lists all aggregator */
+	struct xarray sched_node_ids;
 
 	struct ice_vsi_ctx *vsi_ctx[ICE_MAX_VSI];
 	u8 evb_veb;		/* true for VEB, false for VEPA */
-- 
2.47.1

