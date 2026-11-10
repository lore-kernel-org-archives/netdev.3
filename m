Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320160;
	b=g5jn+5CCgUqehSH67wuVb6Pm9ApnfOWMQ2RUVGcBnr3bcnjlqjW0ZqbTU5rhlF3SDAy4
	 cInlhOIMrAMa/P1XIw03Fye34PtM18S1yyaV34TMAtSikTGbqTbiibaYXciIHT8HA6wig
	 YzA4o1Dg8TOrclRsnnHFekrWPmWyHwe354pcaHuOvoW8edTEaQmCsQDzmJ7c2V1GK+tB+
	 saaQdF4Gm7Uc8C+SqU48GuyVBBMCwJiu1fTCpUgV96o8G4Z/LEC7pshuH6YBhZqYYWpXK
	 s41iEh+n5PCMFaftPg+bnttwZVnV/qWL1vzArN96IyhVZX3eU0U97wF3P8hQfrncdhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320160;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FNs+/WU9/BJX/SAO8iXWBQKAK/1CMw7CEjt7RvoYBQc=;
	b=YNbT/dAc6poZk+AqcQ31gpu77oldmMiZfHXA4ZTk4rR0pKWnkOG97ubsEHBDNq8CioCg
	 +YgIcmurtGpyHXhjUVP/k4sSBSzyWh+TuHLtUA+HbbNWKGE4F3/v5f23xHpfRj5RHqVsj
	 ACZo4n/GWm6cglMtl1I85MrYZ4xKouwVeggodohWcz4QkLBbxabY0+yU37m7BSVGT8k2K
	 0c7BAai3yGYpOpkSYlanWi9XZpAZHaxEsJ44y/K67S0H3Aqt3kTf2HqQLf89E3rEnC+wN
	 TA4/6OG4t+vIjTmsobH05IxjJzF6aFCZwHEhU3AejmdaKs73kjQsfKYf2k7psOYJEkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RxKCMn9L;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D883C606A338
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D883C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RxKCMn9L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794320160; x=1825856160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dRAWW8Xo3K/rRaFLGwZmyyegisfhoV4qSncl662WcCU=;
  b=RxKCMn9L5zuyyLQz6Ku1mj7Y3NMZswGS2rWMAME2vEDuXfE78Z8O+8HQ
   8+bBiD/FylTn0iVIjOvBKJNXae/fW76sM6DTYmhiXUMeR8ZQB1vP8d5+O
   jCrz7L8+QwXOv7/0q8kH6s+v0kqFSOMq59AvxQEulDe0/FFZvWFc0C/8w
   WresOwX9qQgBb8EgoQzfFKOV73mmORqaYMoX9vxfYM3IkNT6bLj5btRoA
   dT+G9/wsJKlkwrFAtnKaB1B6kX4GO1R972qBdMEsYnGkc658FFDrJetgH
   qTNY0g6ss9D+Ww3jJXubo9NYh1MkFUHE2acefBeT+ODixBFNoNj2wHKZ3
   A==;
X-CSE-ConnectionGUID: PQuwvrbpQtCZNyG/HvZu6Q==
X-CSE-MsgGUID: Fwd9C7OOQKi145zPW+h7hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3091119"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3091119"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:15:59 -0800
X-CSE-ConnectionGUID: PdSwi3UPQ2mprlV4uHWBug==
X-CSE-MsgGUID: CNV8JJ4mTjK4vqB2Fcz+3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8327597"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 06:15:54 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.251])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2E8152FC5F;
	Tue, 10 Nov 2026 14:15:52 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	anzaki@gmail.com,
	brett.creeley@amd.com,
	ohartoov@nvidia.com,
	Petr Oros <poros@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v5 06/15] ice: bump to 256qs for VF
Date: Tue, 10 Nov 2026 15:07:15 +0100
Message-ID: <20261110141534.95614-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
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

Adjust all bitmaps and arrays in ice to accept 256 VF queues.
Extend struct ice_vf::num_req_qs width to allow 256 queues.
Keep old/legacy size for virtchnl opcodes that were designed to accept
only up to 16 queues.

Raise also the limits for the default VF queue count and for
VIRTCHNL_OP_REQUEST_QUEUES to 256. New virtchnl opcodes, needed to
make use of more than 16 queues, are handled by subsequent commits
of this series, the work is split for easier review.

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v5:
 * LAG: call ice_aq_cfg_lan_txq() for up to U8_MAX queues at a time, as
   num_qs of the command is u8, 256 VF queues were sent as 0 (Sashiko)

v3:
 * fix rollback in ice_vc_cfg_qs_msg() to disable queues by their IDs,
   not by qpair index, as config could be now split into many messages;
   unwind only the entries that got past validation (Sashiko)

v2:
 * change ice_lag allocations to kvzalloc(), as they have grown to
   66KB (Sashiko)
 * commit message: mention that the default and requested VF queue
   limits are raised already here, while more than 16 queues are
   enabled by subsequent commits

Sashiko suggestions I don't want to apply:
 S: there is an existing error handling issue in ice_init_lag()
 me: pre-existing and unrelated, will be fixed separately
---
 drivers/net/ethernet/intel/ice/ice_lag.h     |  2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h  |  9 ++--
 drivers/net/ethernet/intel/ice/ice_lag.c     | 54 ++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_lib.c     |  2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c   |  4 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  8 +--
 drivers/net/ethernet/intel/ice/virt/queues.c | 28 +++++-----
 7 files changed, 71 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index 4bfffecbdc97..39f6a6cc844d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -52,7 +52,7 @@ struct ice_lag {
 	u8 bond_lport_sec; /* lport values for secondary PF */
 
 	/* q_home keeps track of which interface the q is currently on */
-	u8 q_home[ICE_MAX_SRIOV_VFS][ICE_MAX_QS_PER_VF_VCV1];
+	u8 q_home[ICE_MAX_SRIOV_VFS][ICE_MAX_QS_PER_VF];
 
 	/* placeholder VSI for hanging VF queues from on secondary interface */
 	struct ice_vsi *sec_vf[ICE_MAX_SRIOV_VFS];
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 4959ecee0c21..a9e95c85bc98 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -21,6 +21,7 @@
 /* VF resource constraints */
 /* for "old" virtchnl opcodes that accept up to 16 queues */
 #define ICE_MAX_QS_PER_VF_VCV1	16
+#define ICE_MAX_QS_PER_VF	256
 
 struct ice_pf;
 struct ice_vf;
@@ -162,8 +163,8 @@ struct ice_vf {
 	u8 dev_lan_addr[ETH_ALEN];
 	u8 hw_lan_addr[ETH_ALEN];
 	struct ice_time_mac legacy_last_added_umac;
-	DECLARE_BITMAP(txq_ena, ICE_MAX_QS_PER_VF_VCV1);
-	DECLARE_BITMAP(rxq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	DECLARE_BITMAP(txq_ena, ICE_MAX_QS_PER_VF);
+	DECLARE_BITMAP(rxq_ena, ICE_MAX_QS_PER_VF);
 	struct ice_vlan port_vlan_info;	/* Port VLAN ID, QoS, and TPID */
 	struct virtchnl_vlan_caps vlan_v2_caps;
 	struct ice_mbx_vf_info mbx_info;
@@ -185,7 +186,7 @@ struct ice_vf {
 	DECLARE_BITMAP(vf_states, ICE_VF_STATES_NBITS);	/* VF runtime states */
 
 	unsigned long vf_caps;		/* VF's adv. capabilities */
-	u8 num_req_qs;			/* num of queue pairs requested by VF */
+	u16 num_req_qs;			/* num of queue pairs requested by VF */
 	u16 num_mac;
 	u16 num_mac_lldp;
 	u16 num_vf_qs;			/* num of queue configured per VF */
@@ -206,7 +207,7 @@ struct ice_vf {
 	u16 lldp_recipe_id;
 	u16 lldp_rule_id;
 
-	struct ice_vf_qs_bw qs_bw[ICE_MAX_QS_PER_VF_VCV1];
+	struct ice_vf_qs_bw qs_bw[ICE_MAX_QS_PER_VF];
 };
 
 /* Flags for controlling behavior of ice_reset_vf */
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 08a17ded0ad5..4bb28564c0d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -549,6 +549,41 @@ ice_lag_qbuf_recfg(struct ice_hw *hw, struct ice_aqc_cfg_txqs_buf *qbuf,
 	return count;
 }
 
+/**
+ * ice_lag_cfg_lan_txq - reconfigure queues for a new port
+ * @hw: HW struct to send the command on
+ * @qbuf: buffer filled by ice_lag_qbuf_recfg(), gets modified
+ * @numq: number of queues in @qbuf
+ * @oldport: lport of the current queues location
+ * @newport: lport of the destination queues location
+ *
+ * One command takes up to U8_MAX queues, a VF could have more.
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int
+ice_lag_cfg_lan_txq(struct ice_hw *hw, struct ice_aqc_cfg_txqs_buf *qbuf,
+		    u16 numq, u8 oldport, u8 newport)
+{
+	while (numq) {
+		int num = min(numq, U8_MAX);
+		int err;
+
+		err = ice_aq_cfg_lan_txq(hw, qbuf,
+					 struct_size(qbuf, queue_info, num),
+					 num, oldport, newport,
+					 ICE_AQC_Q_CFG_TC_CHNG, NULL);
+		if (err)
+			return err;
+
+		numq -= num;
+		memmove(qbuf->queue_info, &qbuf->queue_info[num],
+			numq * sizeof(*qbuf->queue_info));
+	}
+
+	return 0;
+}
+
 /**
  * ice_lag_get_sched_parent - locate or create a sched node parent
  * @hw: HW struct for getting parent in
@@ -689,8 +724,7 @@ ice_lag_move_vf_node_tc(struct ice_lag *lag, u8 oldport, u8 newport,
 		goto qbuf_none;
 	}
 
-	if (ice_aq_cfg_lan_txq(&lag->pf->hw, qbuf, qbuf_size, valq, oldport,
-			       newport, ICE_AQC_Q_CFG_TC_CHNG, NULL)) {
+	if (ice_lag_cfg_lan_txq(&lag->pf->hw, qbuf, valq, oldport, newport)) {
 		dev_warn(dev, "Failure to configure queues for LAG failover\n");
 		goto qbuf_err;
 	}
@@ -1277,9 +1311,8 @@ ice_lag_reclaim_vf_tc(struct ice_lag *lag, struct ice_hw *src_hw, u16 vsi_num,
 		goto reclaim_none;
 	}
 
-	if (ice_aq_cfg_lan_txq(hw, qbuf, qbuf_size, numq,
-			       src_hw->port_info->lport, hw->port_info->lport,
-			       ICE_AQC_Q_CFG_TC_CHNG, NULL)) {
+	if (ice_lag_cfg_lan_txq(hw, qbuf, numq, src_hw->port_info->lport,
+				hw->port_info->lport)) {
 		dev_warn(dev, "Failure to configure queues for LAG failover\n");
 		goto reclaim_qerr;
 	}
@@ -2495,9 +2528,8 @@ ice_lag_move_vf_nodes_tc_sync(struct ice_lag *lag, struct ice_hw *dest_hw,
 		goto sync_none;
 	}
 
-	if (ice_aq_cfg_lan_txq(hw, qbuf, qbuf_size, numq, hw->port_info->lport,
-			       dest_hw->port_info->lport,
-			       ICE_AQC_Q_CFG_TC_CHNG, NULL)) {
+	if (ice_lag_cfg_lan_txq(hw, qbuf, numq, hw->port_info->lport,
+				dest_hw->port_info->lport)) {
 		dev_warn(dev, "Failure to configure queues for LAG reset rebuild\n");
 		goto sync_qerr;
 	}
@@ -2577,7 +2609,7 @@ int ice_init_lag(struct ice_pf *pf)
 	if (!ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
 		return 0;
 
-	pf->lag = kzalloc_obj(*lag);
+	pf->lag = kvzalloc_obj(*lag);
 	if (!pf->lag)
 		return -ENOMEM;
 	lag = pf->lag;
@@ -2651,7 +2683,7 @@ int ice_init_lag(struct ice_pf *pf)
 	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
 			&lag->pf_recipe);
 lag_error:
-	kfree(lag);
+	kvfree(lag);
 	pf->lag = NULL;
 	return err;
 }
@@ -2680,7 +2712,7 @@ void ice_deinit_lag(struct ice_pf *pf)
 	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
 			&pf->lag->lport_recipe);
 
-	kfree(lag);
+	kvfree(lag);
 
 	pf->lag = NULL;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index e18128bce959..f81b310a98c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1026,7 +1026,7 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
 		 * For VSI_LUT, LUT size should be set to 64 bytes.
 		 */
 		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
-		vsi->rss_size = ICE_MAX_QS_PER_VF_VCV1;
+		vsi->rss_size = ICE_MAX_QS_PER_VF;
 		vsi->rss_lut_type = ICE_LUT_VSI;
 		break;
 	case ICE_VSI_LB:
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index dcd6d48ea38d..d7c4a6540008 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -398,15 +398,15 @@ static int ice_set_per_vf_res(struct ice_pf *pf, u16 num_vfs)
 	}
 
 	num_txq = min_t(u16, num_msix_per_vf - ICE_NONQ_VECS_VF,
-			ICE_MAX_QS_PER_VF_VCV1);
+			ICE_MAX_QS_PER_VF);
 	avail_qs = ice_get_avail_txq_count(pf) / num_vfs;
 	if (!avail_qs)
 		num_txq = 0;
 	else if (num_txq > avail_qs)
 		num_txq = rounddown_pow_of_two(avail_qs);
 
 	num_rxq = min_t(u16, num_msix_per_vf - ICE_NONQ_VECS_VF,
-			ICE_MAX_QS_PER_VF_VCV1);
+			ICE_MAX_QS_PER_VF);
 	avail_qs = ice_get_avail_rxq_count(pf) / num_vfs;
 	if (!avail_qs)
 		num_rxq = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index be87a83d2599..320b393ddaaf 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -528,8 +528,8 @@ static void ice_vf_rebuild_host_cfg(struct ice_vf *vf)
 static void ice_set_vf_state_qs_dis(struct ice_vf *vf)
 {
 	/* Clear Rx/Tx enabled queues flag */
-	bitmap_zero(vf->txq_ena, ICE_MAX_QS_PER_VF_VCV1);
-	bitmap_zero(vf->rxq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	bitmap_zero(vf->txq_ena, ICE_MAX_QS_PER_VF);
+	bitmap_zero(vf->rxq_ena, ICE_MAX_QS_PER_VF);
 	clear_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
 }
 
@@ -1243,8 +1243,8 @@ bool ice_is_vf_trusted(struct ice_vf *vf)
  */
 bool ice_vf_has_no_qs_ena(struct ice_vf *vf)
 {
-	return bitmap_empty(vf->rxq_ena, ICE_MAX_QS_PER_VF_VCV1) &&
-	       bitmap_empty(vf->txq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	return bitmap_empty(vf->rxq_ena, ICE_MAX_QS_PER_VF) &&
+	       bitmap_empty(vf->txq_ena, ICE_MAX_QS_PER_VF);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 2667634e3c8c..7f2b459dbc83 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -681,7 +681,7 @@ int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	if (qbw->num_queues > ICE_MAX_QS_PER_VF_VCV1 ||
+	if (qbw->num_queues > ICE_MAX_QS_PER_VF ||
 	    qbw->num_queues > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -773,7 +773,7 @@ int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	if (end_qid > ICE_MAX_QS_PER_VF_VCV1 ||
+	if (end_qid > ICE_MAX_QS_PER_VF ||
 	    end_qid > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -822,9 +822,9 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	struct virtchnl_vsi_queue_config_info *qci =
 	    (struct virtchnl_vsi_queue_config_info *)msg;
 	struct virtchnl_queue_pair_info *qpi;
+	int i, q_idx, last_valid = -1;
 	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
-	int i = -1, q_idx;
 	bool ena_ts;
 	u8 act_prt;
 
@@ -841,7 +841,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	if (!vsi)
 		goto error_param;
 
-	if (qci->num_queue_pairs > ICE_MAX_QS_PER_VF_VCV1 ||
+	if (qci->num_queue_pairs > ICE_MAX_QS_PER_VF ||
 	    qci->num_queue_pairs > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(pf), "VF-%d requesting more than supported number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -877,6 +877,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		if (q_idx >= vsi->alloc_txq || q_idx >= vsi->alloc_rxq) {
 			goto error_param;
 		}
+		last_valid = i;
 
 		/* copy Tx queue info from VF into VSI */
 		if (qpi->txq.ring_len > 0) {
@@ -967,13 +968,14 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 				     VIRTCHNL_STATUS_SUCCESS, NULL, 0);
 error_param:
 	/* disable whatever we can */
-	for (; i >= 0; i--) {
-		if (ice_vsi_ctrl_one_rx_ring(vsi, false, i, true))
+	for (; last_valid >= 0; last_valid--) {
+		q_idx = qci->qpair[last_valid].rxq.queue_id;
+		if (ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true))
 			dev_err(ice_pf_to_dev(pf), "VF-%d could not disable RX queue %d\n",
-				vf->vf_id, i);
-		if (ice_vf_vsi_dis_single_txq(vf, vsi, i))
+				vf->vf_id, q_idx);
+		if (ice_vf_vsi_dis_single_txq(vf, vsi, q_idx))
 			dev_err(ice_pf_to_dev(pf), "VF-%d could not disable TX queue %d\n",
-				vf->vf_id, i);
+				vf->vf_id, q_idx);
 	}
 
 	ice_lag_complete_vf_reset(pf->lag, act_prt);
@@ -1019,16 +1021,16 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 	if (!req_queues) {
 		dev_err(dev, "VF %d tried to request 0 queues. Ignoring.\n",
 			vf->vf_id);
-	} else if (req_queues > ICE_MAX_QS_PER_VF_VCV1) {
+	} else if (req_queues > ICE_MAX_QS_PER_VF) {
 		dev_err(dev, "VF %d tried to request more than %d queues.\n",
-			vf->vf_id, ICE_MAX_QS_PER_VF_VCV1);
-		vfres->num_queue_pairs = ICE_MAX_QS_PER_VF_VCV1;
+			vf->vf_id, ICE_MAX_QS_PER_VF);
+		vfres->num_queue_pairs = ICE_MAX_QS_PER_VF;
 	} else if (req_queues > cur_queues &&
 		   req_queues - cur_queues > tx_rx_queue_left) {
 		dev_warn(dev, "VF %d requested %u more queues, but only %u left.\n",
 			 vf->vf_id, req_queues - cur_queues, tx_rx_queue_left);
 		vfres->num_queue_pairs = min_t(u16, max_allowed_vf_queues,
-					       ICE_MAX_QS_PER_VF_VCV1);
+					       ICE_MAX_QS_PER_VF);
 	} else {
 		/* request is successful, then reset VF */
 		vf->num_req_qs = req_queues;
-- 
2.51.1

