Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320157;
	b=L4Pqn8orx6/B5SUPqQSyBorGcxFMaXwziWT7/PaTsKAZNaEbUrxpbbuwcRUPbRjAz/S2
	 TUt3ulVxaGPyMInlBL7ooN2v92Td46TFkbce9K3exI1u0bNuzVddVy2JXhev7R/dPRbqk
	 SDM2Ci+UJqGXyfkfshkOihL8ET34V+Lf13ktBVWVPlp1G+IU7CJR1/q0/zFocAPW3TJ7F
	 YPsUQ/y2kiAaCFr6ERTmCqZCnEhC1iJxJvVbuoXABeluVGL5X/+XbTGDLCR58oV2pO70H
	 iayXUfA3Sk6Grcq7nEhBbtTE9CLjKr47zFW5UITCYClAxKMm5zKz4oDS6W6h3Z3Jjnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320157;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N6z1JgNajNiEnTkDJP+OcnmuJqgSUqvScUVpsL5B4ww=;
	b=WIEDxQ3afb51lJFcexNydufaSsgVXXSoAMxcJAKKXP4tzG2oierQD36HnkGLgxhuP4Na
	 2qyXB3MQvC0XebEFTbfFabPU8/VF2KfcoX7W1J7UtjpIh9f8Dgx6xtmTYO9AGmAmCoHIP
	 /EC4PXF1gClr9ddMKyKANRxPKghrMf6ZOfyWXEwFa5DlizrrMleiBpqmWrl1Q63dHm1Qn
	 K5bT1gUWs/TGdBjdzrSKkB9IUQd3H6TT7ePdQSgQt1aNlTENGIpakxTrfg0Nll/hjs09x
	 Xqf+amPoTFX17agPQsDZlwbYwFPM0qQm+gfmpBur+kvG9/s5v3Z1IwVvb+EU1a2Icdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gwXum+vH;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43D60A2612
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE43D60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gwXum+vH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794320155; x=1825856155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EoZw3SqKXPj6on6zJs8Qp+OWr6VM6QEbjKLmyEw17M=;
  b=gwXum+vHtH+k+6K2Dl5yO93F0RroWSc9zrzsEhGKHz2XrSuPVTIUbK8S
   wiU67eIrx0ENw9UPFS86kTdBWvNCL5C0oLbpeo+yqrsYAmd6Y4iJV4BF5
   ZdjfmkIiysKV966ndhP6Z+kYhid9R3XkVy8jMTJDbAqpiw13P8+onw/OF
   h1xwnLk46O/FcTWoGDbHN77uXUyBxnK9ijt2dDt3UFZ6AgnpTEUHMuM4X
   To4OCo6QPXpriuM5nL5y1G40blHFciYFKz6fEYqVqbYS12BM6TwyICviO
   5lG0BM2lqnGSiv9HKnwUriYYowPqAiQruKUenXeFlDg8VsjD3Gr0Dpn+G
   g==;
X-CSE-ConnectionGUID: V48AfD8VSpK+oDjtuovMEw==
X-CSE-MsgGUID: nTpl+/kqQguNlztTqKtU/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3091081"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3091081"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:15:55 -0800
X-CSE-ConnectionGUID: wJtNj12NS5+6WjqfQ6SBCw==
X-CSE-MsgGUID: RmFEQisWQ2KduksMcp30+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8327585"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 06:15:50 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.244.251])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 417E52FC57;
	Tue, 10 Nov 2026 14:15:48 +0000 (GMT)
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
Subject: [PATCH net-next v5 04/15] ice: add helpers for Global RSS LUT alloc, free, vsi_update
Date: Tue, 10 Nov 2026 15:07:13 +0100
Message-ID: <20261110141534.95614-5-przemyslaw.kitszel@intel.com>
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

Add AQ commands for RSS Global LUT allocation and free operations.
The new functions are used by subsequent commits.

Add programming code for GLOBAL LUT ID of UPDATE VSI AQ,
do the same for RSS LUT "type", also for PF LUT in case of VF VSI.

Co-developed-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2: fix whitespace (Sashiko)
---
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.c      | 28 +++++++++++--
 drivers/net/ethernet/intel/ice/ice_switch.c   | 41 +++++++++++++++++++
 5 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 432da05c48c0..89a2bdbecf60 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -367,6 +367,7 @@ struct ice_vsi {
 	u8 *rss_hkey_user;	/* User configured hash keys */
 	u8 *rss_lut_user;	/* User configured lookup table entries */
 	u8 rss_lut_type;	/* used to configure Get/Set RSS LUT AQ call */
+	u8 global_lut_id;       /* valid when lut_type == GLOBAL_LUT */
 
 	/* aRFS members only allocated for the PF VSI */
 #define ICE_MAX_ARFS_LIST	1024
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 42878abac9eb..90c5587642d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -169,6 +169,7 @@ struct ice_aqc_set_port_params {
 #define ICE_AQC_RES_TYPE_VSI_LIST_PRUNE			0x04
 #define ICE_AQC_RES_TYPE_RECIPE				0x05
 #define ICE_AQC_RES_TYPE_SWID				0x07
+#define ICE_AQC_RES_TYPE_GLOBAL_RSS_HASH		0x20
 #define ICE_AQC_RES_TYPE_FDIR_COUNTER_BLOCK		0x21
 #define ICE_AQC_RES_TYPE_FDIR_GUARANTEED_ENTRIES	0x22
 #define ICE_AQC_RES_TYPE_FDIR_SHARED_ENTRIES		0x23
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 671d7a5f359f..99b593b68bd0 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -387,6 +387,8 @@ ice_rem_adv_rule_by_id(struct ice_hw *hw,
 		       struct ice_rule_query_data *remove_entry);
 
 int ice_init_def_sw_recp(struct ice_hw *hw);
+int ice_alloc_rss_global_lut(struct ice_hw *hw, u16 *global_lut_id);
+int ice_free_rss_global_lut(struct ice_hw *hw, u16 global_lut_id);
 u16 ice_get_hw_vsi_num(struct ice_hw *hw, u16 vsi_handle);
 
 int ice_replay_vsi_all_fltr(struct ice_hw *hw, u16 vsi_handle);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7cd2dd066ef5..8319956754b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1247,30 +1247,46 @@ static void ice_set_fd_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 	ctxt->info.fd_report_opt = cpu_to_le16(val);
 }
 
+/* Translate @lut_type used in most of the places to the Admin Queue
+ * Q_OPT value for RSS.
+ * Used with VSI ADD and VSI UPDATE AQs (opcodes 0x0210, 0x0211).
+ */
+static u8 ice_lut_type_to_aq_qopt_rss_val(enum ice_lut_type lut_type)
+{
+	switch (lut_type) {
+	case ICE_LUT_PF:
+		return ICE_AQ_VSI_Q_OPT_RSS_LUT_PF;
+	case ICE_LUT_GLOBAL:
+		return ICE_AQ_VSI_Q_OPT_RSS_LUT_GBL;
+	case ICE_LUT_VSI:
+	default:
+		return ICE_AQ_VSI_Q_OPT_RSS_LUT_VSI;
+	}
+}
+
 /**
  * ice_set_rss_vsi_ctx - Set RSS VSI context before adding a VSI
  * @ctxt: the VSI context being set
  * @vsi: the VSI being configured
  */
 static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 {
 	u8 lut_type, hash_type;
+	u8 global_lut_id = 0;
 	struct device *dev;
 	struct ice_pf *pf;
 
 	pf = vsi->back;
 	dev = ice_pf_to_dev(pf);
 
 	switch (vsi->type) {
 	case ICE_VSI_CHNL:
-	case ICE_VSI_PF:
-		/* PF VSI will inherit RSS instance of PF */
 		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_PF;
 		break;
+	case ICE_VSI_PF:
 	case ICE_VSI_VF:
 	case ICE_VSI_SF:
-		/* VF VSI will gets a small RSS table which is a VSI LUT type */
-		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_VSI;
+		lut_type = ice_lut_type_to_aq_qopt_rss_val(vsi->rss_lut_type);
 		break;
 	default:
 		dev_dbg(dev, "Unsupported VSI type %s\n",
@@ -1281,8 +1297,12 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 	hash_type = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 	vsi->rss_hfunc = hash_type;
 
+	if (vsi->rss_lut_type == ICE_LUT_GLOBAL)
+		global_lut_id = vsi->global_lut_id;
+
 	ctxt->info.q_opt_rss =
 		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_LUT_M, lut_type) |
+		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_M, global_lut_id) |
 		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hash_type);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 4daee252e2a6..e6f08fe9b5c2 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1527,6 +1527,47 @@ ice_aq_get_sw_cfg(struct ice_hw *hw, struct ice_aqc_get_sw_cfg_resp_elem *buf,
 	return status;
 }
 
+/* Allocate a new Global LUT for the caller.
+ * LUT ID is returned via @global_lut_id.
+ */
+int ice_alloc_rss_global_lut(struct ice_hw *hw, u16 *global_lut_id)
+{
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	u16 buf_len = __struct_size(buf);
+	int err;
+
+	buf->num_elems = cpu_to_le16(1);
+	buf->res_type = cpu_to_le16(ICE_AQC_RES_TYPE_GLOBAL_RSS_HASH);
+
+	err = ice_aq_alloc_free_res(hw, buf, buf_len, ice_aqc_opc_alloc_res);
+	if (err)
+		ice_debug(hw, ICE_DBG_RES, "Failed to allocate RSS global LUT, err %d\n",
+			  err);
+	else
+		*global_lut_id = le16_to_cpu(buf->elem[0].e.sw_resp);
+
+	return err;
+}
+
+/* Free Global LUT at @global_lut_id. */
+int ice_free_rss_global_lut(struct ice_hw *hw, u16 global_lut_id)
+{
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	u16 buf_len = __struct_size(buf);
+	int err;
+
+	buf->num_elems = cpu_to_le16(1);
+	buf->res_type = cpu_to_le16(ICE_AQC_RES_TYPE_GLOBAL_RSS_HASH);
+	buf->elem[0].e.sw_resp = cpu_to_le16(global_lut_id);
+
+	err = ice_aq_alloc_free_res(hw, buf, buf_len, ice_aqc_opc_free_res);
+	if (err)
+		ice_debug(hw, ICE_DBG_RES, "Failed to free RSS global LUT %d, err %d\n",
+			  global_lut_id, err);
+
+	return err;
+}
+
 /**
  * ice_aq_add_vsi
  * @hw: pointer to the HW struct
-- 
2.51.1

