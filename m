Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE27563FBC
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090536; cv=none; b=EnBNK+Hti72QWvwpMbsStax2F46YM0Nn8ZIReN0r4JLjSFQyv/tVhWZ43djOd6L5Agh44o22Y1al9AhBAk0KGlx/UlgSU0JQu8c181N2nxJ68NSVwJ3fW4tMWXBZte1Q+QU3vT6zxKJWbdlsh0AKukCDicM9G4+HtGooeyRN5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090536; c=relaxed/simple;
	bh=fZXw7+CfPXKaR3U0midMYp1LQC5CzfBf4uXcfMKjHgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eK/inoJpaA+We3CDTYknqteTG9HwIuAA1rvkbfjhzUwv0FfqDrjlaxTW2xnpncTK6fQITgwkZlunFPbwbAQdoFkpgHfaTIpW0Q+I7XFmjfk0a2LIFAU6HW23lCy2EkA48uw8/5eiTB8a5ZAWKWE6n8l20gEG/kegP1yA61WrB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMQQzGQx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMQQzGQx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792090532; x=1823626532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZXw7+CfPXKaR3U0midMYp1LQC5CzfBf4uXcfMKjHgw=;
  b=hMQQzGQxjcmPD3x0Bl+lgIHzqVQuyBjmThT08ySNLIakSlqqb64FNjLe
   Psspp5Wq//wtkZauhaVf640AsLFrn6cD31bS/8JoKqT4ew+OSNEEcMWym
   Oe9+ixqmhusANF/Eayl0Zcy+/ZJmYKnDCsnKeG2ymQrx1jb1XemEQT3Oe
   oJQma/Fe4VtTlKcYs8uLec5wDo/R6paB3q2G9n9VEY/Xj/l0JsvSZxJMK
   g+WhFWcIy2RAO9w0VAPDm7RugPj1/ec9EAKxi7YaX00QDiQ9KRUhz8SlB
   PhKOS5HAkYtBOpJRqQJ/fm5PEyKIKzdNCdKwlo52S2k0lLcn7SPhu0XJn
   Q==;
X-CSE-ConnectionGUID: kBypXHSrQHaaQDRPXYb1FA==
X-CSE-MsgGUID: N/UZ9omQQRGjdMHUNjLvXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="757982"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="757982"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:55:21 -0700
X-CSE-ConnectionGUID: c/THwZGGQ7WKI9WLmy5RUQ==
X-CSE-MsgGUID: DwakVyRnTVa6w0/WVqFGrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2003151"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2026 11:55:16 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.208])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E860C32EC3;
	Thu, 15 Oct 2026 19:55:13 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
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
	jtornosm@redhat.com,
	ohartoov@nvidia.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v3 05/15] ice: rename ICE_MAX_RSS_QS_PER_VF to ICE_MAX_QS_PER_VF_VCV1
Date: Thu, 15 Oct 2026 20:51:16 +0200
Message-ID: <20261015185454.6332-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261015185454.6332-1-przemyslaw.kitszel@intel.com>
References: <20261015185454.6332-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename ICE_MAX_RSS_QS_PER_VF to ICE_MAX_QS_PER_VF_VCV1, in preparation for
the next patch that will extend the max to 256, using old value of 16 for
the "v1" variant of virtchnl opcodes.

Suggested-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.h     |  2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h  |  9 +++---
 drivers/net/ethernet/intel/ice/ice_lib.c     |  2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c   |  4 +--
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  | 12 ++++----
 drivers/net/ethernet/intel/ice/virt/queues.c | 30 ++++++++++----------
 6 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index f77ebcd61042..4bfffecbdc97 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -52,7 +52,7 @@ struct ice_lag {
 	u8 bond_lport_sec; /* lport values for secondary PF */
 
 	/* q_home keeps track of which interface the q is currently on */
-	u8 q_home[ICE_MAX_SRIOV_VFS][ICE_MAX_RSS_QS_PER_VF];
+	u8 q_home[ICE_MAX_SRIOV_VFS][ICE_MAX_QS_PER_VF_VCV1];
 
 	/* placeholder VSI for hanging VF queues from on secondary interface */
 	struct ice_vsi *sec_vf[ICE_MAX_SRIOV_VFS];
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index fa436b3b1eac..4959ecee0c21 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -19,7 +19,8 @@
 #define ICE_MAX_SRIOV_VFS		256
 
 /* VF resource constraints */
-#define ICE_MAX_RSS_QS_PER_VF	16
+/* for "old" virtchnl opcodes that accept up to 16 queues */
+#define ICE_MAX_QS_PER_VF_VCV1	16
 
 struct ice_pf;
 struct ice_vf;
@@ -161,8 +162,8 @@ struct ice_vf {
 	u8 dev_lan_addr[ETH_ALEN];
 	u8 hw_lan_addr[ETH_ALEN];
 	struct ice_time_mac legacy_last_added_umac;
-	DECLARE_BITMAP(txq_ena, ICE_MAX_RSS_QS_PER_VF);
-	DECLARE_BITMAP(rxq_ena, ICE_MAX_RSS_QS_PER_VF);
+	DECLARE_BITMAP(txq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	DECLARE_BITMAP(rxq_ena, ICE_MAX_QS_PER_VF_VCV1);
 	struct ice_vlan port_vlan_info;	/* Port VLAN ID, QoS, and TPID */
 	struct virtchnl_vlan_caps vlan_v2_caps;
 	struct ice_mbx_vf_info mbx_info;
@@ -205,7 +206,7 @@ struct ice_vf {
 	u16 lldp_recipe_id;
 	u16 lldp_rule_id;
 
-	struct ice_vf_qs_bw qs_bw[ICE_MAX_RSS_QS_PER_VF];
+	struct ice_vf_qs_bw qs_bw[ICE_MAX_QS_PER_VF_VCV1];
 };
 
 /* Flags for controlling behavior of ice_reset_vf */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8319956754b7..e18128bce959 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1026,7 +1026,7 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
 		 * For VSI_LUT, LUT size should be set to 64 bytes.
 		 */
 		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
-		vsi->rss_size = ICE_MAX_RSS_QS_PER_VF;
+		vsi->rss_size = ICE_MAX_QS_PER_VF_VCV1;
 		vsi->rss_lut_type = ICE_LUT_VSI;
 		break;
 	case ICE_VSI_LB:
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index c49f48b5ae38..dcd6d48ea38d 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -398,15 +398,15 @@ static int ice_set_per_vf_res(struct ice_pf *pf, u16 num_vfs)
 	}
 
 	num_txq = min_t(u16, num_msix_per_vf - ICE_NONQ_VECS_VF,
-			ICE_MAX_RSS_QS_PER_VF);
+			ICE_MAX_QS_PER_VF_VCV1);
 	avail_qs = ice_get_avail_txq_count(pf) / num_vfs;
 	if (!avail_qs)
 		num_txq = 0;
 	else if (num_txq > avail_qs)
 		num_txq = rounddown_pow_of_two(avail_qs);
 
 	num_rxq = min_t(u16, num_msix_per_vf - ICE_NONQ_VECS_VF,
-			ICE_MAX_RSS_QS_PER_VF);
+			ICE_MAX_QS_PER_VF_VCV1);
 	avail_qs = ice_get_avail_rxq_count(pf) / num_vfs;
 	if (!avail_qs)
 		num_rxq = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index a54cb2b8d3c7..be87a83d2599 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -528,8 +528,8 @@ static void ice_vf_rebuild_host_cfg(struct ice_vf *vf)
 static void ice_set_vf_state_qs_dis(struct ice_vf *vf)
 {
 	/* Clear Rx/Tx enabled queues flag */
-	bitmap_zero(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF);
-	bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
+	bitmap_zero(vf->txq_ena, ICE_MAX_QS_PER_VF_VCV1);
+	bitmap_zero(vf->rxq_ena, ICE_MAX_QS_PER_VF_VCV1);
 	clear_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
 }
 
@@ -1238,13 +1238,13 @@ bool ice_is_vf_trusted(struct ice_vf *vf)
  * ice_vf_has_no_qs_ena - check if the VF has any Rx or Tx queues enabled
  * @vf: the VF to check
  *
- * Returns true if the VF has no Rx and no Tx queues enabled and returns false
- * otherwise
+ * Return: true if the VF has no Rx and no Tx queues enabled and returns false
+ * otherwise.
  */
 bool ice_vf_has_no_qs_ena(struct ice_vf *vf)
 {
-	return bitmap_empty(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF) &&
-		bitmap_empty(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF);
+	return bitmap_empty(vf->rxq_ena, ICE_MAX_QS_PER_VF_VCV1) &&
+	       bitmap_empty(vf->txq_ena, ICE_MAX_QS_PER_VF_VCV1);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index a22780575086..2667634e3c8c 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -171,8 +171,8 @@ static int ice_vf_cfg_q_quanta_profile(struct ice_vf *vf, u16 quanta_size,
 static bool ice_vc_validate_vqs_bitmaps(struct virtchnl_queue_select *vqs)
 {
 	if ((!vqs->rx_queues && !vqs->tx_queues) ||
-	    vqs->rx_queues >= BIT(ICE_MAX_RSS_QS_PER_VF) ||
-	    vqs->tx_queues >= BIT(ICE_MAX_RSS_QS_PER_VF))
+	    vqs->rx_queues >= BIT(ICE_MAX_QS_PER_VF_VCV1) ||
+	    vqs->tx_queues >= BIT(ICE_MAX_QS_PER_VF_VCV1))
 		return false;
 
 	return true;
@@ -335,7 +335,7 @@ int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 	 * programmed using ice_vsi_cfg_txqs
 	 */
 	q_map = vqs->rx_queues;
-	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
+	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_QS_PER_VF_VCV1) {
 		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
@@ -348,7 +348,7 @@ int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 	}
 
 	q_map = vqs->tx_queues;
-	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
+	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_QS_PER_VF_VCV1) {
 		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
@@ -484,7 +484,7 @@ int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 	if (vqs->tx_queues) {
 		q_map = vqs->tx_queues;
 
-		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
+		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_QS_PER_VF_VCV1) {
 			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
@@ -499,7 +499,7 @@ int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 
 	q_map = vqs->rx_queues;
 	if (q_map) {
-		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
+		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_QS_PER_VF_VCV1) {
 			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
@@ -542,7 +542,7 @@ ice_cfg_interrupt(struct ice_vf *vf, struct ice_vsi *vsi,
 	q_vector->num_ring_tx = 0;
 
 	qmap = map->rxq_map;
-	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_RSS_QS_PER_VF) {
+	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_QS_PER_VF_VCV1) {
 		vsi_q_id = vsi_q_id_idx;
 
 		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
@@ -557,7 +557,7 @@ ice_cfg_interrupt(struct ice_vf *vf, struct ice_vsi *vsi,
 	}
 
 	qmap = map->txq_map;
-	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_RSS_QS_PER_VF) {
+	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_QS_PER_VF_VCV1) {
 		vsi_q_id = vsi_q_id_idx;
 
 		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
@@ -681,7 +681,7 @@ int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	if (qbw->num_queues > ICE_MAX_RSS_QS_PER_VF ||
+	if (qbw->num_queues > ICE_MAX_QS_PER_VF_VCV1 ||
 	    qbw->num_queues > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -773,7 +773,7 @@ int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	if (end_qid > ICE_MAX_RSS_QS_PER_VF ||
+	if (end_qid > ICE_MAX_QS_PER_VF_VCV1 ||
 	    end_qid > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -841,7 +841,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	if (!vsi)
 		goto error_param;
 
-	if (qci->num_queue_pairs > ICE_MAX_RSS_QS_PER_VF ||
+	if (qci->num_queue_pairs > ICE_MAX_QS_PER_VF_VCV1 ||
 	    qci->num_queue_pairs > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(pf), "VF-%d requesting more than supported number of queues: %d\n",
 			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));
@@ -1019,16 +1019,16 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 	if (!req_queues) {
 		dev_err(dev, "VF %d tried to request 0 queues. Ignoring.\n",
 			vf->vf_id);
-	} else if (req_queues > ICE_MAX_RSS_QS_PER_VF) {
+	} else if (req_queues > ICE_MAX_QS_PER_VF_VCV1) {
 		dev_err(dev, "VF %d tried to request more than %d queues.\n",
-			vf->vf_id, ICE_MAX_RSS_QS_PER_VF);
-		vfres->num_queue_pairs = ICE_MAX_RSS_QS_PER_VF;
+			vf->vf_id, ICE_MAX_QS_PER_VF_VCV1);
+		vfres->num_queue_pairs = ICE_MAX_QS_PER_VF_VCV1;
 	} else if (req_queues > cur_queues &&
 		   req_queues - cur_queues > tx_rx_queue_left) {
 		dev_warn(dev, "VF %d requested %u more queues, but only %u left.\n",
 			 vf->vf_id, req_queues - cur_queues, tx_rx_queue_left);
 		vfres->num_queue_pairs = min_t(u16, max_allowed_vf_queues,
-					       ICE_MAX_RSS_QS_PER_VF);
+					       ICE_MAX_QS_PER_VF_VCV1);
 	} else {
 		/* request is successful, then reset VF */
 		vf->num_req_qs = req_queues;
-- 
2.51.1

