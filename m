Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A748663E
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333980; cv=none; b=ktohiT6zB5JnKn2FLC5pVqG+pv3xANj3y/iplbGyHu7VWQRzPJo/prNMZEkPl+zDqpCstJdO9anEc5XErr7Efwx588mSkziB5JIrYMxN+x/xSLo6b+TQWYKXTrAMEqJY3++Ds0JJe8bQUff9plwNifQF3o3trI5AFJ9ajx09wEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333980; c=relaxed/simple;
	bh=1TeedpNf4se513fr5NdVyRJ/Tisrwdz3DUQxuoWnRKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJOKFkZ+aEMzeioRQhiw6X/rEtqt+SKMJ3qcEMzH5wiySd/C7oJZyyZmdQXNC4cw5VffkWNKlYvvObpMLl3OAKpSUgqjP52K/tdTUm1zzCCMwLW8CZn9W8f/XpUcQ2nkzFeG6pFg3MnPq3XeuEPESptmJ/dEhhNdNTyEltMoQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOJ6fti4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOJ6fti4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785333978; x=1816869978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1TeedpNf4se513fr5NdVyRJ/Tisrwdz3DUQxuoWnRKc=;
  b=HOJ6fti4wCNjTkNJhC2f6cE7sq6Vqa0Puan1lN2EN+6pyYaM9tKE38wz
   ARoWMqJZH8yNUOdecCK0bBd7AmsFAowI3+8rRkCHn1ZgzELCFWy50/7Q1
   Pq6rVpFu3qPG7Nv3gnCqpCYV/gSDx1E1UTZib6bv1vZRrONslFpX/ibBS
   WLHCL9jTYUbBKccQrZnCN3+VVI1GBtckqdsfx2gFhMDA2rkPIRDU57dsw
   KgBSj0HjuAvoasXNvJ2ki1gYb/xQ2kwrGcog0k+5eTmkDOoud1gNGCywD
   dvMBIn4j1xVZe4jTFUF2sRovjG/0+AtkV/4P9S9hOlBHcmnk0dfpvrcxb
   Q==;
X-CSE-ConnectionGUID: MTiFHMVMRQCNi+awiJ1rvA==
X-CSE-MsgGUID: PFwjkYnbTkGMKOWFZ1DTuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89617555"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="89617555"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:06:17 -0700
X-CSE-ConnectionGUID: 7G1aELTOTzOMXyEwHqnIdQ==
X-CSE-MsgGUID: t8LS+BrKRO2Z+ZmwEMgATg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="260072634"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 29 Jul 2026 07:06:16 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B115D2FC47;
	Wed, 29 Jul 2026 15:06:14 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH iwl-next v2] ice: detect duplicates in ACL
Date: Wed, 29 Jul 2026 15:05:10 +0200
Message-ID: <20260729130510.220222-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntuple filters without masks (fdir) disallow duplicate entries. Extend
this behaviour to rules with masks (ACL).
Also skip checking ACL rules in ice_fdir_is_dup_fltr(), as it's only
used for fdir.

Keep the naming convention consistent with ice_fdir_is_dup_fltr() and
ice_fdir_comp_rules(). ice_fdir_is_dup_fltr() cannot be reused directly,
as it ignores masks.

Before fix: duplicate rules with masks are allowed to be created and the
duplicate rule cannot be removed:
  sudo ethtool -N eth0 flow-type udp4 src-port 9000 m 0xff00 action 18
    Added rule with ID 31231
  sudo ethtool -N eth0 flow-type udp4 src-port 9000 m 0xff00 action 18
    Added rule with ID 31230
  sudo ethtool -N eth0 delete 31230
  sudo ethtool -N eth0 delete 31231
    rmgr: Cannot delete RX class rule: Invalid argument
    Cannot delete classification rule

After fix: duplicate rule is correctly detected:
  sudo ethtool -N eth0 flow-type udp4 src-port 9000 m 0xff00 action 18
    Added rule with ID 31231
  sudo ethtool -N eth0 flow-type udp4 src-port 9000 m 0xff00 action 18
    rmgr: Cannot insert RX class rule: Invalid argument
    Cannot insert classification rule

Fixes: 3272c00a1247 ("ice: create ACL entry")
Reported-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v2:
* Tweak ice_acl_is_dup_fltr() function doc and comments to accurately
  reflect what is actually happening in the function
* Add repro steps and expected behaviour to commit msg
* ice_acl_comp_rules(): rename ipv4_equal -> base_equal in expectation
  of future changes that might introduce more fields
---
Not sending to net because the fixed code is on dev-queue.
Tony, please squash this with the offending commit.
---
 drivers/net/ethernet/intel/ice/ice_acl_main.c | 87 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_fdir.c     |  3 +
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c b/drivers/net/ethernet/intel/ice/ice_acl_main.c
index 7c566077d55a..d13e8bc1b701 100644
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
+	bool base_equal;
+
+	if (a->flow_type != b->flow_type)
+		return false;
+
+	base_equal = a->ip.v4.dst_ip == b->ip.v4.dst_ip &&
+		     a->ip.v4.src_ip == b->ip.v4.src_ip &&
+		     a->mask.v4.dst_ip == b->mask.v4.dst_ip &&
+		     a->mask.v4.src_ip == b->mask.v4.src_ip;
+
+	switch (a->flow_type) {
+	case ICE_FLTR_PTYPE_NONF_IPV4_TCP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_SCTP:
+		return base_equal &&
+		       a->ip.v4.dst_port == b->ip.v4.dst_port &&
+		       a->ip.v4.src_port == b->ip.v4.src_port &&
+		       a->mask.v4.dst_port == b->mask.v4.dst_port &&
+		       a->mask.v4.src_port == b->mask.v4.src_port;
+	case ICE_FLTR_PTYPE_NONF_IPV4_OTHER:
+		return base_equal &&
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
+ * Return: true if a filter with identical match criteria (same flow type,
+ * values, and masks) already exists, unless it is at the same location with a
+ * different queue (an update)
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
+		 * Same location with a different queue is an update, not a
+		 * duplicate - skip it. Everything else is a duplicate.
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

