Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616412;
	b=vEUuy9SCF9rx7hzVe+gjHKD7e7Fkzu5ztQ901jnPfPRwDe8Y9Vr8n3zJL3l4ZyxRfKXy
	 WOECg549Bv8mp5y02nnXaE3yu5MJ+SL9dUmgJHcEnjGxrndipaGEYdnSKjwc0mi8Kw0RG
	 Cly50Pk+3XYJkroq8rg+FtrD10w8lLrPYf3zXSSjLhHT+y99scpOuoED8ZNp7SJwa2VD4
	 HDgnvORoi29fCybfzD4SaWdEwH6EdqVNCEP6oOkKO8t8Q6Rsma6QVaSf0vXTl8ptOrMUb
	 9CCbAvxCDpYM1uIIgnVTX2nC1PQ+myeIlz7z8d4XxEk3wWr/W0WdX5QDcdPMK4LhRDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616412;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l+TZkyelYqDiKLngkZfqLvg/0jB/ZxDpVjN7nX2qCLw=;
	b=oR/KMzLQa12R1I0fMvI2UQ3tzXMP9ERzlFVRu5VyRrwT+MpfzscJ7E+Gh7zSfeFN9QRA
	 tYL1rrqDPoFsNyFdu8nq6GYG+XXcjwfAquwc66b4jLOO1HVV92GAoyKpl4sl08KNyHNaa
	 IRDLB4r5Ti3zf1a8kYrFkBYAnx+5kv/oOpPPHLQyZ+neHf6YdpvLPoO1gjRlSW/UnR7XS
	 WAY/EfvRzl8OcXFl+o/lyYqfBsk1nDpw2TnnKgzNp9G8rii+FEX8lRae1wms0Kq7OdR0h
	 wdEMGBIXP4g/s2nzaAiHU3MtdD1A/K0h9lF3IwJ4YfviNrDhm7TNd3+n3qW1ixwBb4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BDrqe7ZU;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045D606A333
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2045D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BDrqe7ZU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616411; x=1825152411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BSArHzWMJ0NSjxImgxT/Jbvl0fCoNAZt0L1fUjQa7xM=;
  b=BDrqe7ZUfAU2vJDBjO58CnE/VIASt4LUZJIkFDD5P58VSZwkaiFbbBvp
   ZLtlOrbDrEImZwRmdaYTDVLAWEhlr5ITlx6hx5vfJ7z5Qh0/9RfVm7Dzf
   ZyEBFkq1H9zudCHzJsSHzaVo5vOR/xNG/Jt+bN97faEzYDrFnFMV5fKuY
   WPynm3qRXbgrWC3Q0yMDEI6bL4GfsSguJo7UnXj+v9Bln2ZuF3aCaT9M8
   VBujiWTAa81efNOctWU/YMwQx1MLTV+UY44R5vj6wM0D9kSRodvdTCWGh
   NRJvjBsUZs0rQ7XSSPBxRCa2zmqgcWsBSuFUeiNdlB3nB9l/X+CIQ59SC
   A==;
X-CSE-ConnectionGUID: qFmwpNCZSUqU9aNSVmryBA==
X-CSE-MsgGUID: kF6LprPqSA6ZJKfXN3mWjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305047"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305047"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:46:34 -0800
X-CSE-ConnectionGUID: cn0WbREaQJuXx391DUdVsQ==
X-CSE-MsgGUID: wBlMzVeyQcSi8k1et+YpfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6012020"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:31 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com [10.217.184.18])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B8A862876D;
	Mon,  2 Nov 2026 10:46:29 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 4/6] ice: don't block on locks in ice_tear_down_devlink_rate_tree()
Date: Mon,  2 Nov 2026 11:50:19 +0100
Message-ID: <20261102105346.30739-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_tear_down_devlink_rate_tree() is called with RTNL held (dcbnl, mqprio),
and then blocks on the PF devlink lock and pf->vfs.table_lock, both of which
are taken the other way around elsewhere:
 - ice_start_vfs() and ice_free_vfs() hold table_lock and call
   ice_eswitch_{attach,detach}_vf(), which take the PF devlink lock and
   register/unregister representor netdevs (so RTNL).
 - ice_probe() holds the devlink lock across ice_load(), which registers
   the netdev (so RTNL).

Lockdep reports a possible ABBA deadlock:

        CPU0                    CPU1
        ----                    ----
   lock(&pf->vfs.table_lock);
                                lock(&devlink->lock_key);
                                lock(&pf->vfs.table_lock);
   lock(&devlink->lock_key);

Swapping the two locks would only fix this particular pair, as the RTNL
inversion would remain. Instead, only try both locks and fail with -EAGAIN
when either is contended, unlike the -EBUSY of an enabled custom Tx
scheduler.

Return early, without taking any lock, when no tree is exported: always
when switchdev is not running, and also after DCB got enabled, as the tree
is not exported again then. The latter is checked by rate_node pointers of
the Tx scheduler nodes, under the scheduler lock, unless the scheduler is
not ready (during a reset). This way DCB and mqprio configuration fails on
contention only when there is a tree to tear down. It also covers
ice_pf_dcb_cfg() with locked == false, called from probe or devlink reload,
where the devlink lock is already held and RTNL is not.

Propagate the error to the callers that can report it: dcbnl ops and
mqprio. For that, stop ice_dcbnl_setapp() from folding all errors into
ICE_DCB_NO_HW_CHG. ice_dcbnl_setapp() updates the app list, and may switch
the FW to DSCP mode, before it calls ice_pf_dcb_cfg(). To fail before any
change in the usual case, move the custom Tx scheduler check and the
teardown into a helper, and call it from ice_dcbnl_setapp() first.
ice_dcbnl_delapp() does not add TCs, so it has no tree to tear down.

ice_dcbnl_cee_set_all() returns a u8 status, not an errno, so it can't
report -EAGAIN, but the desired config is kept and a retry applies it.
DCB init, called from ethtool priv flags, already ignores ice_pf_dcb_cfg()
failures.

Found during development, reproducer:
  PF=ens801f7np7
  BDF=$(basename $(readlink /sys/class/net/$PF/device))
  ethtool --set-priv-flags $PF fw-lldp-agent off
  devlink dev eswitch set pci/$BDF mode switchdev
  echo 2 > /sys/class/net/$PF/device/sriov_numvfs
  dcb ets set dev $PF tc-tsa all:ets tc-bw all:0 0:50 1:50 prio-tc all:0 4:1

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.h  |  2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |  1 +
 .../net/ethernet/intel/ice/devlink/devlink.c  | 47 +++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  | 27 +++++++++--
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c   | 15 +++++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  4 +-
 6 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
index 1af3b0763fbb..4139171ca57c 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
@@ -20,7 +20,7 @@ void ice_devlink_init_regions(struct ice_pf *pf);
 void ice_devlink_destroy_regions(struct ice_pf *pf);
 
 int ice_devlink_rate_init_tx_topology(struct devlink *devlink, struct ice_vsi *vsi);
-void ice_tear_down_devlink_rate_tree(struct ice_pf *pf);
+int ice_tear_down_devlink_rate_tree(struct ice_pf *pf);
 void ice_devlink_rate_clear_tx_topology(struct ice_vsi *vsi);
 
 #endif /* _ICE_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
index da9ba814b4e8..dd00cb459212 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
@@ -20,6 +20,7 @@ u8 ice_dcb_get_num_tc(struct ice_dcbx_cfg *dcbcfg);
 void ice_vsi_set_dcb_tc_cfg(struct ice_vsi *vsi);
 bool ice_is_pfc_causing_hung_q(struct ice_pf *pf, unsigned int txqueue);
 u8 ice_dcb_get_tc(struct ice_vsi *vsi, int queue_index);
+int ice_dcb_prep_multi_tc(struct ice_pf *pf);
 int
 ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked);
 int ice_dcb_bwchk(struct ice_pf *pf, struct ice_dcbx_cfg *dcbcfg);
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 044aa62be473..c94bc75e448e 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -683,31 +683,68 @@ static int ice_devlink_tx_sched_layers_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static bool ice_devlink_rate_tree_is_exported(struct ice_port_info *pi)
+{
+	struct ice_sched_node *tc_node;
+	bool exported = false;
+
+	if (pi->port_state != ICE_SCHED_PORT_STATE_READY)
+		return false;
+
+	mutex_lock(&pi->sched_lock);
+	tc_node = pi->root->children[0];
+	for (int i = 0; i < tc_node->num_children; i++) {
+		if (tc_node->children[i]->rate_node) {
+			exported = true;
+			break;
+		}
+	}
+	mutex_unlock(&pi->sched_lock);
+
+	return exported;
+}
+
 /**
  * ice_tear_down_devlink_rate_tree - removes devlink-rate exported tree
  * @pf: pf struct
  *
  * This function tears down tree exported during VF's creation.
+ *
+ * Return: 0 on success or when no tree is exported, -EAGAIN if a lock could
+ * not be taken.
  */
-void ice_tear_down_devlink_rate_tree(struct ice_pf *pf)
+int ice_tear_down_devlink_rate_tree(struct ice_pf *pf)
 {
 	struct devlink *devlink;
 	struct ice_vf *vf;
 	unsigned int bkt;
 
+	/* The tree is exported only when switchdev is running */
+	if (!ice_is_switchdev_running(pf) ||
+	    !ice_devlink_rate_tree_is_exported(pf->hw.port_info))
+		return 0;
+
+	ASSERT_RTNL();
+
 	devlink = priv_to_devlink(pf);
 
-	devl_lock(devlink);
-	mutex_lock(&pf->vfs.table_lock);
+	/* Both locks are taken before RTNL elsewhere, so only try them here */
+	if (!mutex_trylock(&pf->vfs.table_lock))
+		return -EAGAIN;
+	if (!devl_trylock(devlink)) {
+		mutex_unlock(&pf->vfs.table_lock);
+		return -EAGAIN;
+	}
 	ice_for_each_vf(pf, bkt, vf) {
 		if (vf->devlink_port.devlink_rate)
 			devl_rate_leaf_destroy(&vf->devlink_port);
 	}
-	mutex_unlock(&pf->vfs.table_lock);
-
 	ice_devlink_rate_clear_tx_topology(ice_get_main_vsi(pf));
 	devl_rate_nodes_destroy(devlink);
 	devl_unlock(devlink);
+	mutex_unlock(&pf->vfs.table_lock);
+
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 3034f461f513..59fafd296f1c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -341,6 +341,23 @@ int ice_dcb_bwchk(struct ice_pf *pf, struct ice_dcbx_cfg *dcbcfg)
 	return 0;
 }
 
+/**
+ * ice_dcb_prep_multi_tc - prepare the Tx scheduler for more than one TC
+ * @pf: pointer to the PF struct
+ *
+ * Return: 0 on success, -EBUSY if the Tx scheduler is customized via
+ * devlink-rate, -EAGAIN if its devlink-rate export could not be torn down.
+ */
+int ice_dcb_prep_multi_tc(struct ice_pf *pf)
+{
+	if (pf->hw.port_info->is_custom_tx_enabled) {
+		dev_err(ice_pf_to_dev(pf), "Custom Tx scheduler feature enabled, can't configure DCB\n");
+		return -EBUSY;
+	}
+
+	return ice_tear_down_devlink_rate_tree(pf);
+}
+
 /**
  * ice_pf_dcb_cfg - Apply new DCB configuration
  * @pf: pointer to the PF struct
@@ -364,12 +381,12 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 
 	/* Enable DCB tagging only when more than one TC */
 	if (ice_dcb_get_num_tc(new_cfg) > 1) {
+		int err;
+
 		dev_dbg(dev, "DCB tagging enabled (num TC > 1)\n");
-		if (pf->hw.port_info->is_custom_tx_enabled) {
-			dev_err(dev, "Custom Tx scheduler feature enabled, can't configure DCB\n");
-			return -EBUSY;
-		}
-		ice_tear_down_devlink_rate_tree(pf);
+		err = ice_dcb_prep_multi_tc(pf);
+		if (err)
+			return err;
 
 		set_bit(ICE_FLAG_DCB_ENA, pf->flags);
 	} else {
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index 9cdb9581fdc3..2b9f5e6c1bbe 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -736,6 +736,7 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_dcb_app_priority_table new_app;
 	struct ice_dcbx_cfg *old_cfg, *new_cfg;
+	int tc_to_prep;
 	u8 max_tc;
 	int ret;
 
@@ -779,6 +780,18 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 	new_cfg = &pf->hw.port_info->qos_cfg.desired_dcbx_cfg;
 	old_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
 
+	/* fail before any change; switching to DSCP mode enables max_tc TCs */
+	if (old_cfg->pfc_mode == ICE_QOS_MODE_VLAN)
+		tc_to_prep = max_tc;
+	else
+		tc_to_prep = ice_dcb_get_num_tc(new_cfg);
+
+	if (tc_to_prep > 1) {
+		ret = ice_dcb_prep_multi_tc(pf);
+		if (ret)
+			goto setapp_out;
+	}
+
 	ret = dcb_ieee_setapp(netdev, app);
 	if (ret)
 		goto setapp_out;
@@ -850,7 +863,7 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 	/* return of zero indicates new cfg applied */
 	if (ret == ICE_DCB_HW_CHG_RST)
 		ice_dcbnl_devreset(netdev);
-	else
+	else if (ret > 0)
 		ret = ICE_DCB_NO_HW_CHG;
 
 setapp_out:
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 454fba07d4ec..30de690ecf7c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9180,7 +9180,9 @@ static int ice_setup_tc_mqprio_qdisc(struct net_device *netdev, void *type_data)
 			dev_err(dev, "Custom Tx scheduler feature enabled, can't configure ADQ\n");
 			return -EBUSY;
 		}
-		ice_tear_down_devlink_rate_tree(pf);
+		ret = ice_tear_down_devlink_rate_tree(pf);
+		if (ret)
+			return ret;
 
 		ret = ice_validate_mqprio_qopt(vsi, mqprio_qopt);
 		if (ret) {
-- 
2.54.0

