Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4141CB5C
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889940; cv=none; b=HkPtboR6AaYOzvnhiAihxVACk33E9k/OCe8Zc4NrRQJ2Vr9d5Ru+YvXD+R96GWn0zd37n+5ZJC0pfCFK24OyxOTDBTzgMPToBlNXiudm9TVilAjlEm8lpSa1ou5r59k7m1tvNQFoe3a80xeLhT/k8yfcjUpgdYV48+PWPA+doYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889940; c=relaxed/simple;
	bh=42qq2mzSR5oQOgXgBny4rWUjHkADJbz8UNxSJimHz8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcMWeqR0kGSnMhC8IVRT+mUqTmelnpZvTwJq/zezY5JYM85y5sOK6d5OCe2seWHXWt5+eRNfev7DRX3mTs/scaqJXT1Dcub+KgwH/+/hglMSgkGpUfmw5MfXXiH0YWmu/gMeig02ZQJmcq9IUUoQfTCH7hPXQepLmVCCg+qUgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7bvCL7Z; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7bvCL7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784889937; x=1816425937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=42qq2mzSR5oQOgXgBny4rWUjHkADJbz8UNxSJimHz8o=;
  b=i7bvCL7ZjdRZX1rZV0dN2UPGWnFb+j0N1Ad7OZcL3RMYoWwYzgVmCXNJ
   52y+I4SoMSRmxMS1wmdCDaOkbqm8oNiNFEYmfcY0Ew5zP2GgbfENeY6M3
   sIJmWARRqbzGbxxztWTvVUc+miB9tKbBsT9fwDgdlbrVERTHJFqu2kjpv
   Fy/Rx9YPoynIHOnWoVQycE1xa8kXzzoY/fhLk17VrO1pPuIafy//jfwa0
   J3mr8qJ1oBkhAfW/uOexuP7k8VlGWH039Zcahr8l0K/ec3CGinMKPknkP
   Q0ApyYkMHr5gZGCZwE9zYvMMwKSpzFoq5muNCUTftaZ4P2O3aFw5TTlLA
   w==;
X-CSE-ConnectionGUID: 2U8lL5prTEm4YUH8eE+jIg==
X-CSE-MsgGUID: t0NpnoCFSiCwYIneAB5ohQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96147909"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="96147909"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 03:45:36 -0700
X-CSE-ConnectionGUID: boER7GEIQJ6dKdjn68JlBQ==
X-CSE-MsgGUID: dE37CkzqSjuUpuZZZUvUFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="254737982"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 24 Jul 2026 03:45:34 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 659C828763;
	Fri, 24 Jul 2026 11:45:33 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next] ice: detect duplicates in ACL
Date: Fri, 24 Jul 2026 11:44:54 +0200
Message-ID: <20260724094454.16079-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent duplicate rules from being added to ACL.
Also skip checking ACL rules in ice_fdir_is_dup_fltr(), as it's only
used for fdir.

Fixes: fe9b91ade50e ("ice: create ACL entry")
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
Not sending to net because the fixed code is on dev-queue.
Tony, please squash this with the offending commit.
---
 drivers/net/ethernet/intel/ice/ice_acl_main.c | 87 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_fdir.c     |  3 +
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c b/drivers/net/ethernet/intel/ice/ice_acl_main.c
index 7c566077d55a..473b329b37bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_acl_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c
@@ -283,6 +283,85 @@ void ice_acl_replay_fltrs(struct ice_pf *pf)
 	}
 }
 
+/**
+ * ice_acl_comp_rules - compare two ACL filters
+ * @a: first ACL filter
+ * @b: second ACL filter
+ *
+ * Return: true if a and b values and masks are identical, false otherwise
+ */
+static bool
+ice_acl_comp_rules(struct ice_ntuple_fltr *a, struct ice_ntuple_fltr *b)
+{
+	bool ipv4_equal;
+
+	if (a->flow_type != b->flow_type)
+		return false;
+
+	ipv4_equal = a->ip.v4.dst_ip == b->ip.v4.dst_ip &&
+		     a->ip.v4.src_ip == b->ip.v4.src_ip &&
+		     a->mask.v4.dst_ip == b->mask.v4.dst_ip &&
+		     a->mask.v4.src_ip == b->mask.v4.src_ip;
+
+	switch (a->flow_type) {
+	case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_SCTP:
+		return ipv4_equal &&
+		       a->ip.v4.dst_port == b->ip.v4.dst_port &&
+		       a->ip.v4.src_port == b->ip.v4.src_port &&
+		       a->mask.v4.dst_port == b->mask.v4.dst_port &&
+		       a->mask.v4.src_port == b->mask.v4.src_port;
+	case ICE_FLTR_PTYPE_NONF_IPV4_OTHER:
+		return ipv4_equal &&
+		       a->ip.v4.l4_header == b->ip.v4.l4_header &&
+		       a->ip.v4.proto == b->ip.v4.proto &&
+		       a->ip.v4.ip_ver == b->ip.v4.ip_ver &&
+		       a->ip.v4.tos == b->ip.v4.tos &&
+		       a->mask.v4.l4_header == b->mask.v4.l4_header &&
+		       a->mask.v4.proto == b->mask.v4.proto &&
+		       a->mask.v4.ip_ver == b->mask.v4.ip_ver &&
+		       a->mask.v4.tos == b->mask.v4.tos;
+	default:
+		return false;
+	}
+}
+
+/**
+ * ice_acl_is_dup_fltr - test if an ACL filter is already in the list
+ * @hw: hardware data structure
+ * @input: ACL filter to check
+ *
+ * Return: true if an identical filter (same flow type, values, and masks)
+ * already exists at a different location
+ */
+static bool
+ice_acl_is_dup_fltr(struct ice_hw *hw, struct ice_ntuple_fltr *input)
+{
+	struct ice_ntuple_fltr *rule;
+
+	list_for_each_entry(rule, &hw->fdir_list_head, fltr_node) {
+		if (!rule->acl_fltr)
+			continue;
+
+		if (!ice_acl_comp_rules(rule, input))
+			continue;
+
+		/* At this point rule and input have same match criteria.
+		 * Different location is a duplicate.
+		 * Same location with a different queue is an update (not a
+		 * duplicate).
+		 */
+		if (rule->fltr_id == input->fltr_id &&
+		    rule->q_index != input->q_index)
+			continue;
+
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * ice_acl_add_rule_ethtool - add an ACL rule
  * @vsi: pointer to target VSI
@@ -322,6 +401,14 @@ int ice_acl_add_rule_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	if (err)
 		goto free_input;
 
+	mutex_lock(&hw->fdir_fltr_lock);
+	if (ice_acl_is_dup_fltr(hw, input)) {
+		mutex_unlock(&hw->fdir_fltr_lock);
+		err = -EINVAL;
+		goto free_input;
+	}
+	mutex_unlock(&hw->fdir_fltr_lock);
+
 	memset(&acts, 0, sizeof(acts));
 	if (fsp->ring_cookie == RX_CLS_FLOW_DISC)
 		ice_acl_set_act_drop(&acts[0]);
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index 1bc91cb41769..1d79138683b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
@@ -1261,6 +1261,9 @@ bool ice_fdir_is_dup_fltr(struct ice_hw *hw, struct ice_ntuple_fltr *input)
 	bool ret = false;
 
 	list_for_each_entry(rule, &hw->fdir_list_head, fltr_node) {
+		if (rule->acl_fltr)
+			continue;
+
 		if (rule->flow_type != input->flow_type)
 			continue;
 
-- 
2.49.0

