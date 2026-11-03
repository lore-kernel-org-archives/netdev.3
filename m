Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716790;
	b=L2LxO8grgcJfyHHYbCY6XW6hz8dIb/MZYM5ozsowv7eeI5uix4zN4s/ycQCQRdfvThyU
	 fsj77FOaYCT1vG6DvbHlW+8galtKGYZUESlpocKil7H/Ol+izu6CKT4FcJhLhdHTjxeNY
	 CrfxIAdpbN3ZKdP4ErQAeKNGfGGX889CpsNIDPaNfWzJHdUOerjqxkYgqroLGhpsTo+Re
	 jVt5C1urHLHyAZSGhh+zor7qJ9oWjXo3jqY+NQOiTtc4zyXtM2+tRTSzVVBHrQRbiqpp9
	 fPVyUzdv0WqIhnoRp7k9dCbB/khQajjk+nbR9ad48XyRb75cS3sa/fyC3SdokYruTgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716790;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mbiicu9wLOzaXOjyJuzoheYHvBlLyJoB5VWqTIheeoM=;
	b=KlLKpaeyzTuK9DvyvSbM9Yh8hbbibRtXm3eBzpY3tBjgBgLNrssV49j8iVqS5HZYDH+9
	 Eoyht7/7LlZ1E0Rf2RMiAsug9JnJjhSDWmEuOu9f5La8ikItR9ubGDKyYxMR3SDdlVWee
	 G030wmOwN5WjwdDxYerGYR/C8mdlL/iIzn0J3nL6GZXC/ckaO/wq2S5xlMJQycocGGyoi
	 vUyPhXaoh9qqxe4PwPYC9dI7rnuGdJZGjg1Lb7GlQ+47ofnhtMOaHfj4yxqm1nXStgEOw
	 G3xh98oPNx1Cct32ASE49O4K90zQorr/VyaDnBQIKDcc9GO4gRH122Yezc7Ka09XEFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LGxSFXTu;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3E606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70E3E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LGxSFXTu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793716789; x=1825252789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jp4Kfvt5JUngmuAAx6/ST9Y80lNlOVL+8kw0C8xpOhM=;
  b=LGxSFXTu8UUR0pXdfqyh73zerbYY+TfZpJuOVzygGx3fPcRIfz/n478o
   OXfyfNfl1rerU2zAqfnv9d9nCVX6TJDqBdvyj6dWpR5zNj633Do2EGaZB
   sMgd/dY4LR+v+uCDAyWOVcWUYq7PvQkpqV5iOUGyeL4CYfdHPiYbrmrhC
   eQP4HamfFu8hKcJ524oHwQDKHDXyNuSZUyASf1kiuRJYT/t3Rnvm/Oo5z
   icxq3kUrzJsSCYsnIFDpevT/fxUR0BNP1PxyGqoMuYlOs3n5TI/Kl48UT
   hsaoEywJJRSmQiZJnQSAyboUDKOf59+uFW7xGWMtG5JUc7mR+LS8pMauJ
   A==;
X-CSE-ConnectionGUID: nVv0ZQJfReS5A7SVZCHj5Q==
X-CSE-MsgGUID: 1dqKSmpURPCLp96g8Begcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2323988"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2323988"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:39:49 -0800
X-CSE-ConnectionGUID: 4tGYh+X+SWSO3am4H4uT4A==
X-CSE-MsgGUID: G1jw815zTNicLfe7gLhnrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8289852"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:39:44 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1036A312EE;
	Tue,  3 Nov 2026 14:39:41 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org,
	Simon Horman <horms@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	bruce.richardson@intel.com,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
	padraig.j.connolly@intel.com,
	ananth.s@intel.com,
	timothy.miskell@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v4 03/15] ice: add VF queue ena/dis helper functions
Date: Tue,  3 Nov 2026 15:14:44 +0100
Message-ID: <20261103141646.303620-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
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
2.54.0

