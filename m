Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50F55D886
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090535; cv=none; b=BywMa9JFopY/fiGkOjUTqjSg5gWKRp+UCuyW0s8DoGSbQopgAl/c3nQJExnXu09itrg3Vao3kwGmt4ZkUm+cVn/I9Qs7g1sLmF+VJEd28kNMnfAUZHm3s8hLhi7GZuwSa2sFPGshk+0OiKl0T2l80tQb9wLbI9g6CL1aPYOR8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090535; c=relaxed/simple;
	bh=rY0QkeYRoOMZmdDikz46iNQ7y9zutWnesKXcXX6WIeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtDM/zDpsqcQPvaD0XFQjbOBo0ngl4c/jpu3LZuA6QOdMFkHAR9Ax7zL2lxl07gtRjenTV7++2utGw3bNTN5qu2ya8wmrVxLxYqmpvbOFciKL7bn/VC3v8WFNX0klscDMhUeX5paMQij4+hwqxUvaWragNG6SrXse2xpnmvTQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1kn7ChP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1kn7ChP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792090524; x=1823626524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rY0QkeYRoOMZmdDikz46iNQ7y9zutWnesKXcXX6WIeA=;
  b=G1kn7ChPdCBB3ikiImBagQsUAVIgQFzvlxQksFaYD3XeCFUV0gMgOpzN
   mgH7SlhZ4bE03af3s9460KdOZW6qGy0S0+2sXgSnxDe9vm2p/mTmkldHd
   bCHXsARRRGNwUgS0uwoL0LpozUuru1ER4z1pY+Vyv44yXLIVdogVTwzx7
   H1798oo0M8kuBLAdjH9bzdg8Ix1qcn7W6nPPa6Z7GGWwWZX2pS8X/hX/N
   Ya+YU+a+gax/YkPb33yFGKd83upMzCVTCsQ2ANaDhSNwdeCj7GSB5oFAv
   3JdfD9yq/vtguPMi+yH20yaCAbVHBfFSJ/jiIRZT7EQsI6PoBx0e6ZCzn
   A==;
X-CSE-ConnectionGUID: MnbUETJoSBCNUwb9D6vq8g==
X-CSE-MsgGUID: S4PDS2ilR9u4luYQVvdXxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="757957"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="757957"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:55:19 -0700
X-CSE-ConnectionGUID: d3G5dzgZSTC7hJezsbAWKA==
X-CSE-MsgGUID: Fw47svLmRnSwnLWxgut5xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2003146"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2026 11:55:12 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.208])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1308032EC8;
	Thu, 15 Oct 2026 19:55:10 +0100 (IST)
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
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net-next v3 03/15] ice: add VF queue ena/dis helper functions
Date: Thu, 15 Oct 2026 20:51:14 +0200
Message-ID: <20261015185454.6332-4-przemyslaw.kitszel@intel.com>
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

From: Brett Creeley <brett.creeley@intel.com>

Add three new functions:
- ice_vf_vsi_dis_single_rxq()
- ice_vf_vsi_ena_single_rxq()
- ice_vf_vsi_ena_single_txq()
 (ice_vf_vsi_dis_single_txq() was introduced earlier).

Those functions wrap operations needed in the processes of enabling
and disabling single Tx/Rx VF queue, which are:
- check if the queue is not already in desired state
- perform the dis/ena operations
- bookkeeping of the queue's state.

Future commit will use them from another callsite.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2:
 * convert one comment to kdoc (Alex)
 * fix typos (Sashiko)
 * rebase: move ice_vf_dis_rxq_interrupt(), added to ice_vc_dis_qs_msg()
   by commit fb096882095e ("ice: fix VF interrupts cleanup"), into
   ice_vf_vsi_dis_single_rxq()
---
 drivers/net/ethernet/intel/ice/virt/queues.c | 117 ++++++++++++++-----
 1 file changed, 89 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index ac7f98479b13..a22780575086 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -242,6 +242,57 @@ static void ice_vf_dis_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
 	ice_flush(hw);
 }
 
+/**
+ * ice_vf_vsi_ena_single_rxq - enable single Rx queue based on relative q_id
+ * @vf: VF to enable queue for
+ * @vsi: VSI for the VF
+ * @q_id: VSI relative (0-based) queue ID
+ *
+ * Enable the Rx queue passed in.
+ *
+ * Return: 0 on success or negative on error.
+ */
+static int ice_vf_vsi_ena_single_rxq(struct ice_vf *vf, struct ice_vsi *vsi,
+				     u16 q_id)
+{
+	int err;
+
+	if (test_bit(q_id, vf->rxq_ena))
+		return 0;
+
+	err = ice_vsi_ctrl_one_rx_ring(vsi, true, q_id, true);
+	if (err) {
+		dev_err(ice_pf_to_dev(vsi->back), "Failed to enable Rx ring %d on VSI %d\n",
+			q_id, vsi->vsi_num);
+		return err;
+	}
+
+	ice_vf_ena_rxq_interrupt(vsi, q_id);
+	set_bit(q_id, vf->rxq_ena);
+
+	return 0;
+}
+
+/**
+ * ice_vf_vsi_ena_single_txq - enable single Tx queue based on relative q_id
+ * @vf: VF to enable queue for
+ * @vsi: VSI for the VF
+ * @q_id: VSI relative (0-based) queue ID
+ *
+ * Enable the Tx queue's interrupt. Note that the Tx queue(s) should have
+ * already been configured/enabled in VIRTCHNL_OP_CONFIG_VSI_QUEUES so this
+ * function only enables the interrupt associated with the q_id.
+ */
+static void ice_vf_vsi_ena_single_txq(struct ice_vf *vf, struct ice_vsi *vsi,
+				      u16 q_id)
+{
+	if (test_bit(q_id, vf->txq_ena))
+		return;
+
+	ice_vf_ena_txq_interrupt(vsi, q_id);
+	set_bit(q_id, vf->txq_ena);
+}
+
 /**
  * ice_vc_ena_qs_msg
  * @vf: pointer to the VF info
@@ -290,34 +341,20 @@ int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 			goto error_param;
 		}
 
-		/* Skip queue if enabled */
-		if (test_bit(vf_q_id, vf->rxq_ena))
-			continue;
-
-		if (ice_vsi_ctrl_one_rx_ring(vsi, true, vf_q_id, true)) {
-			dev_err(ice_pf_to_dev(vsi->back), "Failed to enable Rx ring %d on VSI %d\n",
-				vf_q_id, vsi->vsi_num);
+		if (ice_vf_vsi_ena_single_rxq(vf, vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
 		}
-
-		ice_vf_ena_rxq_interrupt(vsi, vf_q_id);
-		set_bit(vf_q_id, vf->rxq_ena);
 	}
 
 	q_map = vqs->tx_queues;
 	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
 		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
 		}
 
-		/* Skip queue if enabled */
-		if (test_bit(vf_q_id, vf->txq_ena))
-			continue;
-
-		ice_vf_ena_txq_interrupt(vsi, vf_q_id);
-		set_bit(vf_q_id, vf->txq_ena);
+		ice_vf_vsi_ena_single_txq(vf, vsi, vf_q_id);
 	}
 
 	/* Set flag to indicate that queues are enabled */
@@ -369,6 +406,41 @@ int ice_vf_vsi_dis_single_txq(struct ice_vf *vf, struct ice_vsi *vsi, u16 q_id)
 	return 0;
 }
 
+/**
+ * ice_vf_vsi_dis_single_rxq - disable a Rx queue for VF on relative queue ID
+ * @vf: VF to disable queue for
+ * @vsi: VSI for the VF
+ * @q_id: VSI relative (0-based) queue ID
+ *
+ * Attempt to disable the Rx queue passed in. If the Rx queue was successfully
+ * disabled then clear q_id bit in the enabled queues bitmap.
+ *
+ * Return: 0 when queue was already disabled or disabling succeeded, otherwise
+ *         negative error code.
+ */
+static int ice_vf_vsi_dis_single_rxq(struct ice_vf *vf, struct ice_vsi *vsi,
+				     u16 q_id)
+{
+	int err;
+
+	if (!test_bit(q_id, vf->rxq_ena))
+		return 0;
+
+	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_id, true);
+	if (err) {
+		dev_err(ice_pf_to_dev(vsi->back), "Failed to stop Rx ring %d on VSI %d\n",
+			q_id, vsi->vsi_num);
+		return err;
+	}
+
+	ice_vf_dis_rxq_interrupt(vsi, q_id);
+
+	/* Clear enabled queues flag */
+	clear_bit(q_id, vf->rxq_ena);
+
+	return 0;
+}
+
 /**
  * ice_vc_dis_qs_msg
  * @vf: pointer to the VF info
@@ -433,21 +505,10 @@ int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 				goto error_param;
 			}
 
-			/* Skip queue if not enabled */
-			if (!test_bit(vf_q_id, vf->rxq_ena))
-				continue;
-
-			if (ice_vsi_ctrl_one_rx_ring(vsi, false, vf_q_id,
-						     true)) {
-				dev_err(ice_pf_to_dev(vsi->back), "Failed to stop Rx ring %d on VSI %d\n",
-					vf_q_id, vsi->vsi_num);
+			if (ice_vf_vsi_dis_single_rxq(vf, vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
 			}
-
-			ice_vf_dis_rxq_interrupt(vsi, vf_q_id);
-			/* Clear enabled queues flag */
-			clear_bit(vf_q_id, vf->rxq_ena);
 		}
 	}
 
-- 
2.51.1

