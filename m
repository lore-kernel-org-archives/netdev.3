Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320172;
	b=GNI8EapO14nk1Ek9sxjKOiDVU5QWsKDWWqayTZsWygNYO8Z3MrOTSEq0sXOusTJhU2/i
	 ZLEXVVuHTCftHA7RkR6QOASZ64p8FAQ5lwddT/0FqamHP1v15bIENSQh8gEdm5LYyrsAH
	 KdhJelLfIYXS2KP3vMOg/LjtECBIlDD0utURrASbaYgpTn8AR+dxVUaJ+6IzYFkxzFLiF
	 05FYb/DGwt90ILKjZuJNgLyPy5JbhjMz3Gf0dbL8kCmZ0PkjG+hIxkOGA5zjFiCPnFcWz
	 EF0WjyPTKTm6S+6GcAHe821NjvjRVzkNPLqGBvLkuKob+bgkTxRys5f+Dym+FPjxSeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320172;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9kfDvWY4aeTd2c3KM0Aa3AbbGF79Z/co4T2Q980ljCY=;
	b=sGpfLcQXLVe2lzXQXZtvmWmgCQQ8OUHAo+r/MEE2U9qyi+5fas6Ncz5Cq1lXaHGINw7x
	 rWTOah6HLBniE3aYXByhWTpZveniDZDOCXGIclQok0CyPw3iSXPg+Zr5p0QIffVsmjFEl
	 ofJTzv2Ye3rKkRukV9cbJfZ0humsP1dwRrx9L4R5YszURHEc6xHrJrEL6gAue0+cThKt9
	 ijbvdO6XICKEehXv8O9nclI+bcnbtioJs+WdkMxrPu/C0kMS8Jcir8vaJKqjtQOSM+GkE
	 3aHvfSjjrXHRozmgvGWj21/tFeRDaRP2DTTuUxpe1GdkueGbpYL2oZiqOrScdssHlCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fccBOnGj;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC060A261A
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ADC060A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fccBOnGj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794320170; x=1825856170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sNELdpMG+f1f3x1YOKuAmnU1XlC1Z5jwxLG14II2E0M=;
  b=fccBOnGjq7jse9Pw/pIhebvt0S4CtU+pcObpLNPETg7w7ARitDeSHR/S
   7XUC4rU5wnAVUxQtUbzxrppDEeXaL0ovF02jGZQn8uk/muV7arqrhsFqW
   paCrrC3WnZpL8dtNxToWnJCvX/RR9cwZIzEKjfIkBiOIVB0hgeRw/n4/g
   wqffNHP0FRpynPDEwDButrnXNNCCtg0ABzreuCRGDSWlKiLCYLV59+4bx
   r+7fzfHWkD/bMWtl7BlXsqNCCGub78vbdzyEZCwxNS5MVoIXHfnWnQXgL
   r7vLkYaU0HHo3o7sb3uvkRF3P6eOFFvia1ZCWCV0fgeZ+yMzdrKveDX2F
   Q==;
X-CSE-ConnectionGUID: jClZs3IDT9GFiap6xSAzpA==
X-CSE-MsgGUID: 4lZkcgAJSMCTwgadWBMtBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3091194"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3091194"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:16:09 -0800
X-CSE-ConnectionGUID: 8xERcpGFTcCOSCh4D0I8FQ==
X-CSE-MsgGUID: mYWdRFVpR4KH56VHREyOOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8327667"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 06:16:04 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.251])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 485022FC5A;
	Tue, 10 Nov 2026 14:16:02 +0000 (GMT)
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
Subject: [PATCH net-next v5 11/15] ice: introduce handling of virtchnl LARGE VF opcodes
Date: Tue, 10 Nov 2026 15:07:20 +0100
Message-ID: <20261110141534.95614-12-przemyslaw.kitszel@intel.com>
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

From: Brett Creeley <brett.creeley@intel.com>

With new virtchnl offload/capability VFs are able to make use of more than
16 queues. But the old opcodes were designed with a max of 16 queues,
so new ones were added (by iavf/virtchnl commit of this series).
Handle VIRTCHNL_OP_ENABLE_QUEUES_V2, VIRTCHNL_OP_DISABLE_QUEUES_V2 and
VIRTCHNL_OP_MAP_QUEUE_VECTOR here. VIRTCHNL_OP_GET_MAX_RSS_QREGION is
only allowlisted, its handler comes with bigger RSS LUT support later
in the series.

If a VF wishes to request >16 queues it should first make sure that the
PF supports the VIRTCHNL_VF_LARGE_NUM_QPAIRS capability.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Co-developed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com> # msglen val
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v5:
 * widen num_ring_{rx,tx} of struct ice_q_vector to u16, mapping all
   256 queues of a VF to one vector wrapped them around (Sashiko)

v4:
 * limit queue chunks to ICE_MAX_QS_PER_VF, the size of
   vf->{rx,tx}q_ena, as num_vf_qs could be set higher via
   sriov_vf_msix_count (Sashiko)
 * VIRTCHNL_OP_MAP_QUEUE_VECTOR: set ring->q_vector, num_ring_{rx,tx}
   and {rx,tx}.itr_idx, as VIRTCHNL_OP_CONFIG_IRQ_MAP does (Sashiko)
 * look up the VF VSI once per message, make ice_vc_ena_txq_chunk()
   void (Sashiko)

v3:
 * reject VIRTCHNL_OP_MAP_QUEUE_VECTOR entries with an out of range
   itr_idx (me)

v2:
 * fix error response in one case of ice_vc_map_q_vector_msg() (Alex)
 * use ice_get_vf_vsi() instead of plain array access (Sashiko)
 * return VIRTCHNL_STATUS_ERR_PARAM on error (Sashiko)
 * commit message: GET_MAX_RSS_QREGION is handled only later
---
 drivers/net/ethernet/intel/ice/ice.h          |   4 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   1 +
 drivers/net/ethernet/intel/ice/virt/queues.h  |   3 +
 .../net/ethernet/intel/ice/virt/allowlist.c   |   8 +
 drivers/net/ethernet/intel/ice/virt/queues.c  | 339 ++++++++++++++++++
 5 files changed, 353 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 89a2bdbecf60..fc2e84136e24 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -474,8 +474,8 @@ struct ice_q_vector {
 
 	u16 v_idx;			/* index in the vsi->q_vector array. */
 	u16 reg_idx;			/* PF relative register index */
-	u8 num_ring_rx;			/* total number of Rx rings in vector */
-	u8 num_ring_tx;			/* total number of Tx rings in vector */
+	u16 num_ring_rx;		/* total number of Rx rings in vector */
+	u16 num_ring_tx;		/* total number of Tx rings in vector */
 	u8 wb_on_itr:1;			/* if true, WB on ITR is enabled */
 	/* in usecs, need to use ice_intrl_to_usecs_reg() before writing this
 	 * value to the device
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index a9e95c85bc98..396dfb2b2d97 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -125,6 +125,7 @@ struct ice_vf_ops {
 	void (*clear_reset_trigger)(struct ice_vf *vf);
 	void (*irq_close)(struct ice_vf *vf);
 	void (*post_vsi_rebuild)(struct ice_vf *vf);
+	struct ice_q_vector *(*get_q_vector)(struct ice_vsi *vsi, u16 vec_id);
 };
 
 /* Virtchnl/SR-IOV config info */
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.h b/drivers/net/ethernet/intel/ice/virt/queues.h
index c4a792cecea1..223f609dd4f3 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.h
+++ b/drivers/net/ethernet/intel/ice/virt/queues.h
@@ -16,5 +16,8 @@ int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg);
 int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg);
 int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg);
 int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg);
+int ice_vc_ena_qs_v2_msg(struct ice_vf *vf, u8 *msg, u16 msglen);
+int ice_vc_dis_qs_v2_msg(struct ice_vf *vf, u8 *msg, u16 msglen);
+int ice_vc_map_q_vector_msg(struct ice_vf *vf, u8 *msg, u16 msglen);
 
 #endif /* _ICE_VIRT_QUEUES_H_ */
diff --git a/drivers/net/ethernet/intel/ice/virt/allowlist.c b/drivers/net/ethernet/intel/ice/virt/allowlist.c
index a07efec19c45..ef769b843c6f 100644
--- a/drivers/net/ethernet/intel/ice/virt/allowlist.c
+++ b/drivers/net/ethernet/intel/ice/virt/allowlist.c
@@ -95,6 +95,13 @@ static const u32 tc_allowlist_opcodes[] = {
 	VIRTCHNL_OP_CONFIG_QUANTA,
 };
 
+static const u32 large_num_qpairs_allowlist_opcodes[] = {
+	VIRTCHNL_OP_GET_MAX_RSS_QREGION,
+	VIRTCHNL_OP_ENABLE_QUEUES_V2,
+	VIRTCHNL_OP_DISABLE_QUEUES_V2,
+	VIRTCHNL_OP_MAP_QUEUE_VECTOR,
+};
+
 struct allowlist_opcode_info {
 	const u32 *opcodes;
 	size_t size;
@@ -117,6 +124,7 @@ static const struct allowlist_opcode_info allowlist_opcodes[] = {
 	ALLOW_ITEM(VIRTCHNL_VF_OFFLOAD_VLAN_V2, vlan_v2_allowlist_opcodes),
 	ALLOW_ITEM(VIRTCHNL_VF_OFFLOAD_QOS, tc_allowlist_opcodes),
 	ALLOW_ITEM(VIRTCHNL_VF_CAP_PTP, ptp_allowlist_opcodes),
+	ALLOW_ITEM(VIRTCHNL_VF_LARGE_NUM_QPAIRS, large_num_qpairs_allowlist_opcodes),
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 7f2b459dbc83..f87ccf5d370b 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -1046,3 +1046,342 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
 				     v_ret, (u8 *)vfres, sizeof(*vfres));
 }
 
+static bool ice_vc_supported_queue_type(s32 queue_type)
+{
+	return queue_type == VIRTCHNL_QUEUE_TYPE_RX ||
+	       queue_type == VIRTCHNL_QUEUE_TYPE_TX;
+}
+
+/**
+ * ice_vc_validate_qs_v2_msg - validate all qs_msg parameters
+ * @vf: VF the message was received from
+ * @qs_msg: contents of the message from the VF
+ * @msglen: length of @qs_msg
+ *
+ * Used to validate both the VIRTCHNL_OP_ENABLE_QUEUES_V2 and
+ * VIRTCHNL_OP_DISABLE_QUEUES_V2 messages. This should always be called before
+ * attempting to enable and/or disable queues on behalf of a VF in response to
+ * the previously mentioned opcodes.
+ *
+ * Return: If all checks succeed, then return true. Otherwise return
+ *         false, indicating to the caller that the qs_msg is invalid.
+ */
+static bool ice_vc_validate_qs_v2_msg(struct ice_vf *vf,
+				      struct virtchnl_del_ena_dis_queues *qs_msg,
+				      u16 msglen)
+{
+	u32 max_qs = min_t(u32, vf->num_vf_qs, ICE_MAX_QS_PER_VF);
+
+	if (msglen < virtchnl_struct_size(qs_msg, chunks, 0))
+		return false;
+
+	if (msglen < virtchnl_struct_size(qs_msg, chunks, qs_msg->num_chunks))
+		return false;
+
+	if (!qs_msg->num_chunks)
+		return false;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
+		return false;
+
+	if (!ice_vc_isvalid_vsi_id(vf, qs_msg->vport_id))
+		return false;
+
+	for (int i = 0; i < qs_msg->num_chunks; i++) {
+		struct virtchnl_queue_chunk *chunk = &qs_msg->chunks[i];
+		u32 end;
+
+		if (!ice_vc_supported_queue_type(chunk->type))
+			return false;
+
+		if (!chunk->num_queues)
+			return false;
+
+		end = chunk->start_queue_id + chunk->num_queues;
+		if (end > max_qs)
+			return false;
+	}
+
+	return true;
+}
+
+#define ice_for_each_q_in_chunk(chunk, q_id) \
+	for ((q_id) = (chunk)->start_queue_id; \
+	     (q_id) < (chunk)->start_queue_id + (chunk)->num_queues; \
+	     (q_id)++)
+
+static int
+ice_vc_ena_rxq_chunk(struct ice_vf *vf, struct ice_vsi *vsi,
+		     struct virtchnl_queue_chunk *chunk)
+{
+	u32 vf_qid;
+
+	ice_for_each_q_in_chunk(chunk, vf_qid) {
+		int err;
+
+		err = ice_vf_vsi_ena_single_rxq(vf, vsi, vf_qid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void
+ice_vc_ena_txq_chunk(struct ice_vf *vf, struct ice_vsi *vsi,
+		     struct virtchnl_queue_chunk *chunk)
+{
+	u32 vf_qid;
+
+	ice_for_each_q_in_chunk(chunk, vf_qid)
+		ice_vf_vsi_ena_single_txq(vf, vsi, vf_qid);
+}
+
+/**
+ * ice_vc_ena_qs_v2_msg - message handling for VIRTCHNL_OP_ENABLE_QUEUES_V2
+ * @vf: source of the request
+ * @msg: message to handle
+ * @msglen: length of the @msg
+ *
+ * Return: 0 on success or negative on error.
+ */
+int ice_vc_ena_qs_v2_msg(struct ice_vf *vf, u8 *msg, u16 msglen)
+{
+	struct virtchnl_del_ena_dis_queues *ena_qs_msg =
+			(struct virtchnl_del_ena_dis_queues *)msg;
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+	struct ice_vsi *vsi;
+
+	if (!ice_vc_validate_qs_v2_msg(vf, ena_qs_msg, msglen))
+		goto error_param;
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		goto error_param;
+
+	for (int i = 0; i < ena_qs_msg->num_chunks; i++) {
+		struct virtchnl_queue_chunk *chunk = &ena_qs_msg->chunks[i];
+
+		if (chunk->type == VIRTCHNL_QUEUE_TYPE_RX &&
+		    ice_vc_ena_rxq_chunk(vf, vsi, chunk))
+			goto error_param;
+		else if (chunk->type == VIRTCHNL_QUEUE_TYPE_TX)
+			ice_vc_ena_txq_chunk(vf, vsi, chunk);
+	}
+
+	v_ret = VIRTCHNL_STATUS_SUCCESS;
+	set_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
+
+error_param:
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_ENABLE_QUEUES_V2,
+				     v_ret, NULL, 0);
+}
+
+static int
+ice_vc_dis_rxq_chunk(struct ice_vf *vf, struct ice_vsi *vsi,
+		     struct virtchnl_queue_chunk *chunk)
+{
+	u32 vf_qid;
+
+	ice_for_each_q_in_chunk(chunk, vf_qid) {
+		int err;
+
+		err = ice_vf_vsi_dis_single_rxq(vf, vsi, vf_qid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+ice_vc_dis_txq_chunk(struct ice_vf *vf, struct ice_vsi *vsi,
+		     struct virtchnl_queue_chunk *chunk)
+{
+	u32 vf_qid;
+
+	ice_for_each_q_in_chunk(chunk, vf_qid) {
+		int err;
+
+		err = ice_vf_vsi_dis_single_txq(vf, vsi, vf_qid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/**
+ * ice_vc_dis_qs_v2_msg - message handling for VIRTCHNL_OP_DISABLE_QUEUES_V2
+ * @vf: source of the request
+ * @msg: message to handle
+ * @msglen: length of @msg
+ *
+ * Return: 0 on success or negative on error.
+ */
+int ice_vc_dis_qs_v2_msg(struct ice_vf *vf, u8 *msg, u16 msglen)
+{
+	struct virtchnl_del_ena_dis_queues *dis_qs_msg =
+			(struct virtchnl_del_ena_dis_queues *)msg;
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+	struct ice_vsi *vsi;
+
+	if (!ice_vc_validate_qs_v2_msg(vf, dis_qs_msg, msglen))
+		goto error_param;
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		goto error_param;
+
+	for (int i = 0; i < dis_qs_msg->num_chunks; i++) {
+		struct virtchnl_queue_chunk *chunk = &dis_qs_msg->chunks[i];
+
+		if (chunk->type == VIRTCHNL_QUEUE_TYPE_RX &&
+		    ice_vc_dis_rxq_chunk(vf, vsi, chunk))
+			goto error_param;
+		else if (chunk->type == VIRTCHNL_QUEUE_TYPE_TX &&
+			 ice_vc_dis_txq_chunk(vf, vsi, chunk))
+			goto error_param;
+	}
+
+	v_ret = VIRTCHNL_STATUS_SUCCESS;
+	if (ice_vf_has_no_qs_ena(vf))
+		clear_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
+
+error_param:
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_DISABLE_QUEUES_V2,
+				     v_ret, NULL, 0);
+}
+
+/**
+ * ice_vc_validate_qv_maps - validate parameters sent in the qs_msg structure
+ * @vf: VF the message was received from
+ * @qv_maps: contents of the message from the VF
+ * @msglen: length of the @qv_maps
+ *
+ * Used to validate VIRTCHNL_OP_MAP_QUEUE_VECTOR messages. This should always
+ * be called before attempting map interrupts to queues. If all checks succeed,
+ * then return success indicating to the caller that the qv_maps are valid.
+ * Otherwise return false, indicating to the caller that the qv_maps are
+ * invalid.
+ *
+ * Return: true if parameters are valid, false otherwise.
+ */
+static bool ice_vc_validate_qv_maps(struct ice_vf *vf,
+				    struct virtchnl_queue_vector_maps *qv_maps,
+				    u16 msglen)
+{
+	struct ice_vsi *vsi;
+	int total_vectors;
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		return false;
+
+	if (msglen < virtchnl_struct_size(qv_maps, qv_maps, 0))
+		return false;
+
+	if (msglen < virtchnl_struct_size(qv_maps, qv_maps, qv_maps->num_qv_maps))
+		return false;
+
+	if (!qv_maps->num_qv_maps)
+		return false;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
+		return false;
+
+	if (!ice_vc_isvalid_vsi_id(vf, qv_maps->vport_id))
+		return false;
+
+	total_vectors = vsi->num_q_vectors + ICE_NONQ_VECS_VF;
+
+	for (int i = 0; i < qv_maps->num_qv_maps; i++) {
+		if (!ice_vc_supported_queue_type(qv_maps->qv_maps[i].queue_type))
+			return false;
+
+		if (qv_maps->qv_maps[i].queue_id >= vf->num_vf_qs)
+			return false;
+
+		if (qv_maps->qv_maps[i].vector_id >= total_vectors ||
+		    qv_maps->qv_maps[i].vector_id < ICE_NONQ_VECS_VF)
+			return false;
+
+		if (qv_maps->qv_maps[i].itr_idx < ICE_IDX_ITR0 ||
+		    qv_maps->qv_maps[i].itr_idx > ICE_ITR_NONE)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * ice_vc_map_q_vector_msg - message handling for VIRTCHNL_OP_MAP_QUEUE_VECTOR
+ * @vf: source of the request
+ * @msg: message to handle
+ * @msglen: length of @msg
+ *
+ * Return: 0 on success or negative on error
+ */
+int ice_vc_map_q_vector_msg(struct ice_vf *vf, u8 *msg, u16 msglen)
+{
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+	struct virtchnl_queue_vector_maps *qv_maps;
+	struct ice_vsi *vsi;
+
+	qv_maps = (struct virtchnl_queue_vector_maps *)msg;
+
+	if (!ice_vc_validate_qv_maps(vf, qv_maps, msglen))
+		goto error_param;
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		goto error_param;
+
+	for (int i = 0; i < qv_maps->num_qv_maps; i++) {
+		struct virtchnl_queue_vector *qv_map = &qv_maps->qv_maps[i];
+		struct ice_q_vector *q_vector;
+		u16 vector_id;
+		int vsi_q_id;
+
+		vsi_q_id = qv_map->queue_id;
+		vector_id = qv_map->vector_id;
+
+		q_vector = vf->vf_ops->get_q_vector(vsi, vector_id);
+		if (!q_vector)
+			goto error_param;
+
+		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
+			goto error_param;
+
+		/* keep SW state in sync with HW, as ice_cfg_interrupt() does */
+		if (qv_map->queue_type == VIRTCHNL_QUEUE_TYPE_RX) {
+			struct ice_rx_ring *ring = vsi->rx_rings[vsi_q_id];
+
+			if (ring->q_vector && ring->q_vector->num_ring_rx)
+				ring->q_vector->num_ring_rx--;
+			ring->q_vector = q_vector;
+			q_vector->num_ring_rx++;
+			q_vector->rx.itr_idx = qv_map->itr_idx;
+			ice_cfg_rxq_interrupt(vsi, vsi_q_id,
+					      q_vector->vf_reg_idx,
+					      qv_map->itr_idx);
+		} else if (qv_map->queue_type == VIRTCHNL_QUEUE_TYPE_TX) {
+			struct ice_tx_ring *ring = vsi->tx_rings[vsi_q_id];
+
+			if (ring->q_vector && ring->q_vector->num_ring_tx)
+				ring->q_vector->num_ring_tx--;
+			ring->q_vector = q_vector;
+			q_vector->num_ring_tx++;
+			q_vector->tx.itr_idx = qv_map->itr_idx;
+			ice_cfg_txq_interrupt(vsi, vsi_q_id,
+					      q_vector->vf_reg_idx,
+					      qv_map->itr_idx);
+		}
+	}
+
+	v_ret = VIRTCHNL_STATUS_SUCCESS;
+
+error_param:
+	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_MAP_QUEUE_VECTOR,
+				     v_ret, NULL, 0);
+}
-- 
2.51.1

